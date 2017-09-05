#!/usr/local/bin/bash
#
# Bash script to parse wttr.in for a sunny weekend with
# less than 50% chance of rain for the whole day.
# (MORNING - AFTERNOON - NIGHT)
#
# Run on crontab every FRIDAY morning for accurate alerts!
# wttr.in only displays a 3-day forecast, so we plan ahead.
# Example: 0 7 * * 5 /path/to/weekend-wttr.sh > /dev/null 2>&1
# Don't forget to 'chmod +x weekend-wttr.sh' when you're done.

# Fetch as HTML.
# Replace 'atlanta' with your city/location.
# Check the URL for proper syntax before using.
curl -s -A "Mozilla" -m 4 http://wttr.in/atlanta --output wttrsrc.txt

# Strip the full dump for rain percentages (Fri/Sat/Sun).
cat wttrsrc.txt | grep "%" > wttrstrip.txt
sleep 1
rm wttrsrc.txt

# Keep only the weekend weather for our final results.
tail -n 2 wttrstrip.txt > weekend-wttr.txt
rm wttrstrip.txt
sleep 1

# 50% or higher chance of rain means it's unlikely to be sunny.
# Replace the sample email address and zipcode with your own.
# Add '-s Subject' or other mail commands if needed. In this
# example, we're sending to SMS Email and don't need subjects.

if egrep -q '50%|51%|52%|53%|54%|55%|56%|57%|58%|59%|60%|61%|62%|63%|64%|65%|66%|67%|68%|69%|70%|71%|72%|73%|74%|75%|76%|77%|78%|79%|80%|81%|82%|83%|84%|85%|86%|87%|88%|89%|90%|91%|92%|93%|94%|95%|96%|97%|98%|99%' weekend-wttr.txt; then
  echo 'The weekend forecast calls for SUN http://weather.gov/30313' | mail 1234567890@messaging.sprintpcs.com
  rm weekend-wttr.txt
else
  echo 'The weekend forecast calls for RAIN http://weather.gov/30313' | mail 1234567890@messaging.sprintpcs.com
  rm weekend-wttr.txt
fi

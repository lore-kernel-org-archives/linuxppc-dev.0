Message-ID: <3CBF14C1.6080802@cymes.de>
Date: Thu, 18 Apr 2002 20:47:29 +0200
From: Matthias Grimm <joker@cymes.de>
MIME-Version: 1.0
To: LinuxPPC-Dev <linuxppc-dev@lists.linuxppc.org>
Subject: Design weakness in /proc/pmu ?!
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi,

Recently I played a lot with /proc/pmu to get reliable battery states.

In the current design each battery has a value time rem. calculated out
of that battery's parameters. This calculations will fail if more than
one battery is attached to the computer as the following snapshot of a
wallstreet powerbook shows:

$ cat /proc/pmu/info
PMU driver version     : 2
PMU firmware version   : 0a
AC Power               : 0
Battery count          : 2

$ cat /proc/pmu/battery_0

flags      : 00000001
charge     : 2619
max_charge : 2639
current    : 0
voltage    : 16489
time rem.  : 0

$ cat /proc/pmu/battery_1

flags      : 00000001
charge     : 261
max_charge : 2529
current    : -1318
voltage    : 14318
time rem.  : 712

As you could see battery 0 is fully charged but the time remaining value
is calculated as zero. If you now calculate the overall time remaining
simply as sum of the time rem. of each battery you will get a wrong time
and possibly bother the user with unnessecary warnings.

I suggest to move the time rem. value out of the /proc/battery_* files
into the /proc/info file and store an overall time-remaining value
there. Because the time until power off is a quality of the whole system
mainly defined through the overall power consumption. It isn't a feature
of a single battery.

What do you think?

    Regards
     Matthias


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/

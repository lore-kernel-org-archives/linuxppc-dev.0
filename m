Message-ID: <3974CA79.C5F0AB2B@execpc.com>
Date: Tue, 18 Jul 2000 16:22:01 -0500
From: Joseph Garcia <jpgarcia@execpc.com>
MIME-Version: 1.0
To: Derek Homeier <supas100@astrophysik.uni-kiel.de>
CC: linuxppc-dev@lists.linuxppc.org
Subject: Re: switching consoles
References: <Pine.SOL.3.95.1000718225607.3933D-100000@juliet>
Content-Type: text/plain; charset=iso-2022-jp
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Derek Homeier wrote:
> However, this might also be a side effect of writing evil things to the PMU,
> because the crashes were all related to not being able to power on the
> backlight and wake up from sleep mode. Does the PMU handle the ADB stuff as
> well (think I heard so, but not positive)?

i'd think that it would be more likely the nvram resetting.  But PMU is actually
on ADB.  as far as i know, all direct pmu ioctls (battery query, etc) are sent
to /dev/adb, while interpreted ioctls (like sleep) are sent to /dev/pmu, which
is why /dev/pmu features need kernel support and vary from system to system.

The noodle-scratcher in this is the fact that the keyboard's F-key setting is
maintained post-sleep, while trackpad tapping is always reset.  both being ADB
devs reset upon wake, id think it would get reset.  there could be something we
are missing.

--
Joseph P. Garcia      jpgarcia@execpc.com      jpgarcia@lidar.ssec.wisc.edu
CS Undergraduate                      Student Employee - Systems Programmer
University of Wisconsin - Madison                            UW Lidar Group

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/

Mime-Version: 1.0
Message-Id: <p05200f0bba801e39a47c@[10.8.16.89]>
Date: Mon, 24 Feb 2003 13:45:13 -0600
To: linuxppc-dev@lists.linuxppc.org
From: Greg Allen <gallen@arlut.utexas.edu>
Subject: Wake-on-LAN on PowerBook G4
Content-Type: text/plain; charset="us-ascii" ; format="flowed"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


I have a PowerBook G4, 1GHz. Wake-on-LAN works fine under MacOS X,
but seems to be ignored on Linux.

My guess is that this belongs in
    drivers/macintosh/via-pmu.c, at about line 2070:

   /* Tell PMU what events will wake us up */
....
   pmu_request(&req, NULL, 4, PMU_POWER_EVENTS, PMU_PWR_SET_WAKEUP_EVENTS,
     0, PMU_PWR_WAKEUP_KEY |
     (option_lid_wakeup ? PMU_PWR_WAKEUP_LID_OPEN : 0));

Several other options for wakeup are listed in include/linux/pmu.h,
but Wake-on-LAN is not one of them.

I'd like to make this work and am willing to try, but need more info.
Questions:

Is this the right place, and there's just a PMU_PWR_WAKEUP_LAN bit missing?
Does anyone know what that bit is? Perhaps Apple doesn't tell us.
Is there a MacOSX program that dumps this PMU register, so I can
twiddle the setting and see if a PMU bit changes?

Any advice greatly appreciated. If there's a more appropriate list,
please let me know.

Thanks,
-Greg
--
  Gregory E. Allen, MSEE Engineering Scientist
  Applied Research Laboratories: The University of Texas at Austin
  Please help find my missing daughter: http://FindSabrina.org/

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/

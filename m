Message-Id: <4.1.19991126173632.00950400@mail>
Date: Fri, 26 Nov 1999 17:47:55 -0800
To: linuxppc-dev@lists.linuxppc.org
From: Jan Brittenson <bson@rockgarden.net>
Subject: 2.2.14pre9: restoring 1999 PBG3 backlight level after sleep
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


It appears that just reenabling the backlighting after a sleep doesn't
restore brightness on the 1999 Powerbook G3.  Adding a pmu_set_brightness()
immediately after waking up, to explicitly reset it, seems to do the trick.

*** via-pmu.c.orig 	Fri Nov 26 17:32:28 1999 
--- via-pmu.c 	Fri Nov 26 17:05:17 1999 
*************** 
*** 1471,1476 **** 
--- 1471,1477 ---- 
		case PMU_HEATHROW_BASED: 
		case PMU_PADDINGTON_BASED: 
			error = powerbook_sleep_G3(); 
+			pmu_set_brightness(backlight_level); 
			break; 
		default: 
			error = ENOSYS;

I wasn't sure whether this is necessary on any other platforms, in
which case it should probably be moved out of the switch statement,
or if it only applies to G3's, in which case it should probably be
moved to powerbook_sleep_G3().  Especially if it only applies to
the 1999 PBG3's.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/

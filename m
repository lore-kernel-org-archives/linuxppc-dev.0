Message-ID: <3EDD9B7C.3080101@esd-electronics.com>
Date: Wed, 04 Jun 2003 09:10:52 +0200
From: Matthias Fuchs <matthias.fuchs@esd-electronics.com>
MIME-Version: 1.0
To: linuxppc-embedded@lists.linuxppc.org
Subject: patch against linuxppc_2_4_devel: ppc405_wdt.c needs to be fixed
Content-Type: multipart/mixed;
 boundary="------------060006080202020201050105"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


This is a multi-part message in MIME format.
--------------060006080202020201050105
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

I noticed that the 405 watchdog driver's ioctl() for GETPERIOD and SETPERIOD
are not working correctly. The ioctls pass the watchdog timer period in microseconds.
The variable wdt_period stores the current period in seconds.

The attached patch fixes this behavior.

Matthias

--------------060006080202020201050105
Content-Type: text/plain;
 name="ppc405_wdt.p"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="ppc405_wdt.p"

--- drivers/char/ppc405_wdt.c	Wed Jun  4 08:58:42 2003
+++ /usr/src/linuxppc_2_4_devel/drivers/char/ppc405_wdt.c	Tue Dec 24 06:00:15 2002
@@ -190,8 +190,7 @@
 			}
 		case WDIOC_GETPERIOD:
 			/* return watchdog period (units = microseconds) */
-			period = wdt_period * MICROSECBASE;
-
+			period = (wdt_period / HZ) * MICROSECBASE;
 			if (copy_to_user((unsigned long *)arg, &period,
 			    sizeof(period))) {
 				return -EFAULT;
@@ -234,7 +233,8 @@
 			if (period == 0)
 				period = MAXONEHOUR * MICROSECBASE;

-			wdt_period = period / MICROSECBASE;
+			heartbeat_count(0) = (period / TENMSBASE) +
+				(period % TENMSBASE ? 1 : 0);
 			ppc405wd_update_timer();

 			break;

--------------060006080202020201050105--


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/

Return-Path: <mikpe@user.it.uu.se>
Received: from aun.it.uu.se (aun.it.uu.se [130.238.12.36])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "aun.it.uu.se",
	Issuer "Uppsala University CA" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 2C21267A95
	for <linuxppc-dev@ozlabs.org>; Thu, 10 Feb 2005 02:47:06 +1100 (EST)
From: Mikael Pettersson <mikpe@user.it.uu.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <16906.12395.517982.168072@alkaid.it.uu.se>
Date: Wed, 9 Feb 2005 16:46:51 +0100
To: paulus@samba.org, benh@kernel.crashing.org
Cc: linuxppc-dev@ozlabs.org, linux-kerne@vger.kernel.org
Subject: [PATCH][2.6.11-rc3] gcc-4.0 fixes for ppc32
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

These patches are needed to allow me to build a working
2.6.11-rc3 kernel for ppc32 with gcc-4.0 (20050130 snapshot):

- The static time_offset in arch/ppc/kernel/time.c triggers a
  declaration conflict with the non-static one in include/linux/timex.h.
  Solution: s/time_offset/ppc_time_offset/g in ppc's time.c.
- OpenPIC is declared extern in open_pic_defs.h but static in
  open_pic.c. Solution: remove the extern decl.
- prom_display_paths[] and prom_num_displays are declared extern in
  include/asm-ppc/prom.h but static in arch/ppc/syslib/prom_init.c.
  Solution: remove the extern decls.
- The 'const' on __USE_RTC() in include/asm-ppc/time.h triggers
  compiler warnings. Change it to use compiler.h's __attribute_const__.
  (This mirrors changes that have already been made in e.g. byteorder.h.)

Tested on an eMac. No breakage observed.

Signed-off-by: Mikael Pettersson <mikpe@csd.uu.se>

--- linux-2.6.11-rc3/arch/ppc/kernel/time.c.~1~	2005-02-08 20:43:01.000000000 +0100
+++ linux-2.6.11-rc3/arch/ppc/kernel/time.c	2005-02-08 21:57:24.000000000 +0100
@@ -89,7 +89,7 @@ unsigned long tb_to_ns_scale;
 
 extern unsigned long wall_jiffies;
 
-static long time_offset;
+static long ppc_time_offset;
 
 DEFINE_SPINLOCK(rtc_lock);
 
@@ -172,7 +172,7 @@ void timer_interrupt(struct pt_regs * re
 		     xtime.tv_sec - last_rtc_update >= 659 &&
 		     abs((xtime.tv_nsec / 1000) - (1000000-1000000/HZ)) < 500000/HZ &&
 		     jiffies - wall_jiffies == 1) {
-		  	if (ppc_md.set_rtc_time(xtime.tv_sec+1 + time_offset) == 0)
+		  	if (ppc_md.set_rtc_time(xtime.tv_sec+1 + ppc_time_offset) == 0)
 				last_rtc_update = xtime.tv_sec+1;
 			else
 				/* Try again one minute later */
@@ -289,7 +289,7 @@ void __init time_init(void)
 	unsigned old_stamp, stamp, elapsed;
 
         if (ppc_md.time_init != NULL)
-                time_offset = ppc_md.time_init();
+                ppc_time_offset = ppc_md.time_init();
 
 	if (__USE_RTC()) {
 		/* 601 processor: dec counts down by 128 every 128ns */
@@ -334,10 +334,10 @@ void __init time_init(void)
 	set_dec(tb_ticks_per_jiffy);
 
 	/* If platform provided a timezone (pmac), we correct the time */
-        if (time_offset) {
-		sys_tz.tz_minuteswest = -time_offset / 60;
+        if (ppc_time_offset) {
+		sys_tz.tz_minuteswest = -ppc_time_offset / 60;
 		sys_tz.tz_dsttime = 0;
-		xtime.tv_sec -= time_offset;
+		xtime.tv_sec -= ppc_time_offset;
         }
         set_normalized_timespec(&wall_to_monotonic,
                                 -xtime.tv_sec, -xtime.tv_nsec);
--- linux-2.6.11-rc3/arch/ppc/syslib/open_pic_defs.h.~1~	2005-02-08 20:43:01.000000000 +0100
+++ linux-2.6.11-rc3/arch/ppc/syslib/open_pic_defs.h	2005-02-08 22:06:36.000000000 +0100
@@ -172,9 +172,6 @@ struct OpenPIC {
     OpenPIC_Processor Processor[OPENPIC_MAX_PROCESSORS];
 };
 
-extern volatile struct OpenPIC __iomem *OpenPIC;
-
-
     /*
      *  Current Task Priority Register
      */
--- linux-2.6.11-rc3/include/asm-ppc/prom.h.~1~	2003-09-28 12:19:57.000000000 +0200
+++ linux-2.6.11-rc3/include/asm-ppc/prom.h	2005-02-08 22:02:49.000000000 +0100
@@ -13,9 +13,6 @@
 typedef void *phandle;
 typedef void *ihandle;
 
-extern char *prom_display_paths[];
-extern unsigned int prom_num_displays;
-
 struct address_range {
 	unsigned int space;
 	unsigned int address;
--- linux-2.6.11-rc3/include/asm-ppc/time.h.~1~	2004-12-25 12:16:24.000000000 +0100
+++ linux-2.6.11-rc3/include/asm-ppc/time.h	2005-02-08 22:14:22.000000000 +0100
@@ -13,6 +13,7 @@
 #include <linux/types.h>
 #include <linux/rtc.h>
 #include <linux/threads.h>
+#include <linux/compiler.h>
 
 #include <asm/reg.h>
 
@@ -58,7 +59,7 @@ static __inline__ void set_dec(unsigned 
 /* Accessor functions for the timebase (RTC on 601) registers. */
 /* If one day CONFIG_POWER is added just define __USE_RTC as 1 */
 #ifdef CONFIG_6xx
-extern __inline__ int const __USE_RTC(void) {
+extern __inline__ int __attribute_const__ __USE_RTC(void) {
 	return (mfspr(SPRN_PVR)>>16) == 1;
 }
 #else

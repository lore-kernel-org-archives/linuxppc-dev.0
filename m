Return-Path: <SRS0+fa9254f6a0dc08e19aee+555+infradead.org+dwmw2@pentafluge.srs.infradead.org>
Received: from pentafluge.infradead.org (pentafluge.infradead.org
	[213.146.154.40])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 7A06F67A71
	for <linuxppc-dev@ozlabs.org>; Tue,  1 Mar 2005 21:07:21 +1100 (EST)
From: David Woodhouse <dwmw2@infradead.org>
To: benh@kernel.crashing.org
Content-Type: text/plain
Date: Tue, 01 Mar 2005 10:06:48 +0000
Message-Id: <1109671608.22578.88.camel@hades.cambridge.redhat.com>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
Subject: GCC4 fun.
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

include/asm-ppc64/paca.h:
	Fix use of 'struct paca_struct' before it's defined.

arch/ppc/open_pic_defs.h;
	Remove extern declaration of OpenPIC. It's static in openpic.c

include/asm-ppc/prom.h:
	Remove extern declaration of prom_display_paths[] and 
	prom_num_displays. Those are static too in prom_init.c

arch/ppc/kernel/time.c:
	Rename time_offset to rtc_time_offset to avoid conflict
	with the global time_offset.

--- linux-2.6.10/include/asm-ppc64/paca.h~	2005-03-01 08:48:20.000000000 +0000
+++ linux-2.6.10/include/asm-ppc64/paca.h	2005-03-01 08:54:47.662044104 +0000
@@ -22,7 +22,6 @@
 #include	<asm/iSeries/ItLpRegSave.h>
 #include	<asm/mmu.h>
 
-extern struct paca_struct paca[];
 register struct paca_struct *local_paca asm("r13");
 #define get_paca()	local_paca
 
@@ -115,4 +114,6 @@
 #endif
 };
 
+extern struct paca_struct paca[];
+
 #endif /* _PPC64_PACA_H */
--- linux-2.6.10-ppc/arch/ppc/syslib/open_pic_defs.h~	2005-03-01 09:20:34.000000000 +0000
+++ linux-2.6.10-ppc/arch/ppc/syslib/open_pic_defs.h	2005-03-01 09:39:22.776010608 +0000
@@ -172,8 +172,6 @@ struct OpenPIC {
     OpenPIC_Processor Processor[OPENPIC_MAX_PROCESSORS];
 };
 
-extern volatile struct OpenPIC __iomem *OpenPIC;
-
 
     /*
      *  Current Task Priority Register
--- linux-2.6.10-ppc/include/asm-ppc/prom.h~	2004-12-24 21:35:23.000000000 +0000
+++ linux-2.6.10-ppc/include/asm-ppc/prom.h	2005-03-01 09:36:01.350016664 +0000
@@ -13,9 +13,6 @@
 typedef void *phandle;
 typedef void *ihandle;
 
-extern char *prom_display_paths[];
-extern unsigned int prom_num_displays;
-
 struct address_range {
 	unsigned int space;
 	unsigned int address;
--- linux-2.6.10-ppc/arch/ppc/kernel/time.c~	2005-03-01 09:20:34.000000000 +0000
+++ linux-2.6.10-ppc/arch/ppc/kernel/time.c	2005-03-01 09:53:47.293085192 +0000
@@ -89,7 +89,7 @@ unsigned long tb_to_ns_scale;
 
 extern unsigned long wall_jiffies;
 
-static long time_offset;
+static long rtc_time_offset;
 
 DEFINE_SPINLOCK(rtc_lock);
 
@@ -172,7 +172,7 @@ void timer_interrupt(struct pt_regs * re
 		     xtime.tv_sec - last_rtc_update >= 659 &&
 		     abs((xtime.tv_nsec / 1000) - (1000000-1000000/HZ)) < 500000/HZ &&
 		     jiffies - wall_jiffies == 1) {
-		  	if (ppc_md.set_rtc_time(xtime.tv_sec+1 + time_offset) == 0)
+		  	if (ppc_md.set_rtc_time(xtime.tv_sec+1 + rtc_time_offset) == 0)
 				last_rtc_update = xtime.tv_sec+1;
 			else
 				/* Try again one minute later */
@@ -289,7 +289,7 @@ void __init time_init(void)
 	unsigned old_stamp, stamp, elapsed;
 
         if (ppc_md.time_init != NULL)
-                time_offset = ppc_md.time_init();
+                rtc_time_offset = ppc_md.time_init();
 
 	if (__USE_RTC()) {
 		/* 601 processor: dec counts down by 128 every 128ns */
@@ -334,10 +334,10 @@ void __init time_init(void)
 	set_dec(tb_ticks_per_jiffy);
 
 	/* If platform provided a timezone (pmac), we correct the time */
-        if (time_offset) {
-		sys_tz.tz_minuteswest = -time_offset / 60;
+        if (rtc_time_offset) {
+		sys_tz.tz_minuteswest = -rtc_time_offset / 60;
 		sys_tz.tz_dsttime = 0;
-		xtime.tv_sec -= time_offset;
+		xtime.tv_sec -= rtc_time_offset;
         }
         set_normalized_timespec(&wall_to_monotonic,
                                 -xtime.tv_sec, -xtime.tv_nsec);


-- 
dwmw2

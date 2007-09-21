Return-Path: <tony@bakeyournoodle.com>
Received: from pythia.bakeyournoodle.com (pythia.bakeyournoodle.com
	[203.82.209.197]) by ozlabs.org (Postfix) with ESMTP id 6BCE7DDE99
	for <linuxppc-dev@ozlabs.org>; Fri, 21 Sep 2007 13:28:10 +1000 (EST)
To: <linuxppc-dev@ozlabs.org>,
	Paul Mackerras <paulus@samba.org>
From: Tony Breeds <tony@bakeyournoodle.com>
Date: Fri, 21 Sep 2007 13:26:02 +1000
Subject: [PATCH v2 1/4] Implement {read,update}_persistent_clock.
Message-Id: <1190345162.620000.305760830507.qpush@thor>
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Realtime Kernel <linux-rt-users@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

With these functions implemented we cooperate better with the generic
timekeeping code.  This obsoletes the need for the timer sysdev as a bonus.

Signed-off-by: Tony Breeds <tony@bakeyournoodle.com>

---

Patch set updated to powerpc/for-2.6.24

* Compile tested for arch/powerpc/configs/*_defconfig
* Booted on pSeries, iSeries, Cell and PS3

 arch/powerpc/Kconfig         |    3 +
 arch/powerpc/kernel/time.c   |   85 ++++++++++-------------------------
 arch/powerpc/sysdev/Makefile |    5 --
 arch/powerpc/sysdev/timer.c  |   81 ---------------------------------
 4 files changed, 29 insertions(+), 145 deletions(-)

Index: working/arch/powerpc/Kconfig
===================================================================
--- working.orig/arch/powerpc/Kconfig
+++ working/arch/powerpc/Kconfig
@@ -21,6 +21,9 @@ config MMU
 	bool
 	default y
 
+config GENERIC_CMOS_UPDATE
+	def_bool y
+
 config GENERIC_HARDIRQS
 	bool
 	default y
Index: working/arch/powerpc/kernel/time.c
===================================================================
--- working.orig/arch/powerpc/kernel/time.c
+++ working/arch/powerpc/kernel/time.c
@@ -73,16 +73,11 @@
 #include <asm/iseries/hv_call_xm.h>
 #endif
 
-/* keep track of when we need to update the rtc */
-time_t last_rtc_update;
 #ifdef CONFIG_PPC_ISERIES
 static unsigned long __initdata iSeries_recal_titan;
 static signed long __initdata iSeries_recal_tb;
 #endif
 
-/* The decrementer counts down by 128 every 128ns on a 601. */
-#define DECREMENTER_COUNT_601	(1000000000 / HZ)
-
 #define XSEC_PER_SEC (1024*1024)
 
 #ifdef CONFIG_PPC64
@@ -348,39 +343,6 @@ void udelay(unsigned long usecs)
 }
 EXPORT_SYMBOL(udelay);
 
-static __inline__ void timer_check_rtc(void)
-{
-        /*
-         * update the rtc when needed, this should be performed on the
-         * right fraction of a second. Half or full second ?
-         * Full second works on mk48t59 clocks, others need testing.
-         * Note that this update is basically only used through 
-         * the adjtimex system calls. Setting the HW clock in
-         * any other way is a /dev/rtc and userland business.
-         * This is still wrong by -0.5/+1.5 jiffies because of the
-         * timer interrupt resolution and possible delay, but here we 
-         * hit a quantization limit which can only be solved by higher
-         * resolution timers and decoupling time management from timer
-         * interrupts. This is also wrong on the clocks
-         * which require being written at the half second boundary.
-         * We should have an rtc call that only sets the minutes and
-         * seconds like on Intel to avoid problems with non UTC clocks.
-         */
-        if (ppc_md.set_rtc_time && ntp_synced() &&
-	    xtime.tv_sec - last_rtc_update >= 659 &&
-	    abs((xtime.tv_nsec/1000) - (1000000-1000000/HZ)) < 500000/HZ) {
-		struct rtc_time tm;
-		to_tm(xtime.tv_sec + 1 + timezone_offset, &tm);
-		tm.tm_year -= 1900;
-		tm.tm_mon -= 1;
-		if (ppc_md.set_rtc_time(&tm) == 0)
-			last_rtc_update = xtime.tv_sec + 1;
-		else
-			/* Try again one minute later */
-			last_rtc_update += 60;
-        }
-}
-
 /*
  * This version of gettimeofday has microsecond resolution.
  */
@@ -689,7 +651,6 @@ void timer_interrupt(struct pt_regs * re
 			tb_last_jiffy = tb_next_jiffy;
 			do_timer(1);
 			timer_recalc_offset(tb_last_jiffy);
-			timer_check_rtc();
 		}
 		write_sequnlock(&xtime_lock);
 	}
@@ -801,11 +762,6 @@ int do_settimeofday(struct timespec *tv)
  	set_normalized_timespec(&xtime, new_sec, new_nsec);
 	set_normalized_timespec(&wall_to_monotonic, wtm_sec, wtm_nsec);
 
-	/* In case of a large backwards jump in time with NTP, we want the 
-	 * clock to be updated as soon as the PLL is again in lock.
-	 */
-	last_rtc_update = new_sec - 658;
-
 	ntp_clear();
 
 	new_xsec = xtime.tv_nsec;
@@ -881,12 +837,35 @@ void __init generic_calibrate_decr(void)
 #endif
 }
 
-unsigned long get_boot_time(void)
+int update_persistent_clock(struct timespec now)
 {
 	struct rtc_time tm;
 
-	if (ppc_md.get_boot_time)
-		return ppc_md.get_boot_time();
+	if (!ppc_md.set_rtc_time)
+		return 0;
+
+	to_tm(now.tv_sec + 1 + timezone_offset, &tm);
+	tm.tm_year -= 1900;
+	tm.tm_mon -= 1;
+
+	return ppc_md.set_rtc_time(&tm);
+}
+
+unsigned long read_persistent_clock(void)
+{
+	struct rtc_time tm;
+	static int first = 1;
+
+	/* XXX this is a litle fragile but will work okay in the short term */
+	if (first) {
+		first = 0;
+		if (ppc_md.time_init)
+			timezone_offset = ppc_md.time_init();
+
+		/* get_boot_time() isn't guaranteed to be safe to call late */
+		if (ppc_md.get_boot_time)
+			return ppc_md.get_boot_time() -timezone_offset;
+	}
 	if (!ppc_md.get_rtc_time)
 		return 0;
 	ppc_md.get_rtc_time(&tm);
@@ -898,14 +877,10 @@ unsigned long get_boot_time(void)
 void __init time_init(void)
 {
 	unsigned long flags;
-	unsigned long tm = 0;
 	struct div_result res;
 	u64 scale, x;
 	unsigned shift;
 
-        if (ppc_md.time_init != NULL)
-                timezone_offset = ppc_md.time_init();
-
 	if (__USE_RTC()) {
 		/* 601 processor: dec counts down by 128 every 128ns */
 		ppc_tb_freq = 1000000000;
@@ -980,19 +955,14 @@ void __init time_init(void)
 	/* Save the current timebase to pretty up CONFIG_PRINTK_TIME */
 	boot_tb = get_tb_or_rtc();
 
-	tm = get_boot_time();
-
 	write_seqlock_irqsave(&xtime_lock, flags);
 
 	/* If platform provided a timezone (pmac), we correct the time */
         if (timezone_offset) {
 		sys_tz.tz_minuteswest = -timezone_offset / 60;
 		sys_tz.tz_dsttime = 0;
-		tm -= timezone_offset;
         }
 
-	xtime.tv_sec = tm;
-	xtime.tv_nsec = 0;
 	do_gtod.varp = &do_gtod.vars[0];
 	do_gtod.var_idx = 0;
 	do_gtod.varp->tb_orig_stamp = tb_last_jiffy;
@@ -1010,9 +980,6 @@ void __init time_init(void)
 
 	time_freq = 0;
 
-	last_rtc_update = xtime.tv_sec;
-	set_normalized_timespec(&wall_to_monotonic,
-	                        -xtime.tv_sec, -xtime.tv_nsec);
 	write_sequnlock_irqrestore(&xtime_lock, flags);
 
 	/* Not exact, but the timer interrupt takes care of this */
Index: working/arch/powerpc/sysdev/Makefile
===================================================================
--- working.orig/arch/powerpc/sysdev/Makefile
+++ working/arch/powerpc/sysdev/Makefile
@@ -20,11 +20,6 @@ obj-$(CONFIG_MV64X60)		+= $(mv64x60-y) m
 obj-$(CONFIG_RTC_DRV_CMOS)	+= rtc_cmos_setup.o
 obj-$(CONFIG_AXON_RAM)		+= axonram.o
 
-# contains only the suspend handler for time
-ifeq ($(CONFIG_RTC_CLASS),)
-obj-$(CONFIG_PM)		+= timer.o
-endif
-
 ifeq ($(CONFIG_PPC_MERGE),y)
 obj-$(CONFIG_PPC_INDIRECT_PCI)	+= indirect_pci.o
 obj-$(CONFIG_PPC_I8259)		+= i8259.o
Index: working/arch/powerpc/sysdev/timer.c
===================================================================
--- working.orig/arch/powerpc/sysdev/timer.c
+++ /dev/null
@@ -1,81 +0,0 @@
-/*
- * Common code to keep time when machine suspends.
- *
- * Copyright 2007	Johannes Berg <johannes@sipsolutions.net>
- *
- * GPLv2
- */
-
-#include <linux/time.h>
-#include <linux/sysdev.h>
-#include <asm/rtc.h>
-
-static unsigned long suspend_rtc_time;
-
-/*
- * Reset the time after a sleep.
- */
-static int timer_resume(struct sys_device *dev)
-{
-	struct timeval tv;
-	struct timespec ts;
-	struct rtc_time cur_rtc_tm;
-	unsigned long cur_rtc_time, diff;
-
-	/* get current RTC time and convert to seconds */
-	get_rtc_time(&cur_rtc_tm);
-	cur_rtc_time = mktime(cur_rtc_tm.tm_year + 1900,
-			      cur_rtc_tm.tm_mon + 1,
-			      cur_rtc_tm.tm_mday,
-			      cur_rtc_tm.tm_hour,
-			      cur_rtc_tm.tm_min,
-			      cur_rtc_tm.tm_sec);
-
-	diff = cur_rtc_time - suspend_rtc_time;
-
-	/* adjust time of day by seconds that elapsed while
-	 * we were suspended */
-	do_gettimeofday(&tv);
-	ts.tv_sec = tv.tv_sec + diff;
-	ts.tv_nsec = tv.tv_usec * NSEC_PER_USEC;
-	do_settimeofday(&ts);
-
-	return 0;
-}
-
-static int timer_suspend(struct sys_device *dev, pm_message_t state)
-{
-	struct rtc_time suspend_rtc_tm;
-	WARN_ON(!ppc_md.get_rtc_time);
-
-	get_rtc_time(&suspend_rtc_tm);
-	suspend_rtc_time = mktime(suspend_rtc_tm.tm_year + 1900,
-				  suspend_rtc_tm.tm_mon + 1,
-				  suspend_rtc_tm.tm_mday,
-				  suspend_rtc_tm.tm_hour,
-				  suspend_rtc_tm.tm_min,
-				  suspend_rtc_tm.tm_sec);
-
-	return 0;
-}
-
-static struct sysdev_class timer_sysclass = {
-	.resume = timer_resume,
-	.suspend = timer_suspend,
-	set_kset_name("timer"),
-};
-
-static struct sys_device device_timer = {
-	.id = 0,
-	.cls = &timer_sysclass,
-};
-
-static int time_init_device(void)
-{
-	int error = sysdev_class_register(&timer_sysclass);
-	if (!error)
-		error = sysdev_register(&device_timer);
-	return error;
-}
-
-device_initcall(time_init_device);

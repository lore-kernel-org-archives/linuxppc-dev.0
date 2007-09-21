Return-Path: <tony@bakeyournoodle.com>
Received: from pythia.bakeyournoodle.com (pythia.bakeyournoodle.com
	[203.82.209.197]) by ozlabs.org (Postfix) with ESMTP id 9C25ADDEB8
	for <linuxppc-dev@ozlabs.org>; Fri, 21 Sep 2007 13:28:10 +1000 (EST)
To: <linuxppc-dev@ozlabs.org>,
	Paul Mackerras <paulus@samba.org>
From: Tony Breeds <tony@bakeyournoodle.com>
Date: Fri, 21 Sep 2007 13:26:02 +1000
Subject: [PATCH v2 2/4] Implement generic time of day clocksource for powerpc
	machines.
In-Reply-To: <1190345162.620000.305760830507.qpush@thor>
Message-Id: <20070921032603.07AF232C889@thor>
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

Signed-off-by: Tony Breeds <tony@bakeyournoodle.com>

---

Updated to create a clocksource driver specific to the 601

 arch/powerpc/Kconfig       |    6 
 arch/powerpc/kernel/time.c |  255 ++++++++++++-------------------------
 2 files changed, 91 insertions(+), 170 deletions(-)

Index: working/arch/powerpc/Kconfig
===================================================================
--- working.orig/arch/powerpc/Kconfig
+++ working/arch/powerpc/Kconfig
@@ -24,6 +24,12 @@ config MMU
 config GENERIC_CMOS_UPDATE
 	def_bool y
 
+config GENERIC_TIME
+	def_bool y
+
+config GENERIC_TIME_VSYSCALL
+	def_bool y
+
 config GENERIC_HARDIRQS
 	bool
 	default y
Index: working/arch/powerpc/kernel/time.c
===================================================================
--- working.orig/arch/powerpc/kernel/time.c
+++ working/arch/powerpc/kernel/time.c
@@ -73,9 +73,38 @@
 #include <asm/iseries/hv_call_xm.h>
 #endif
 
+/* powerpc clocksource/clockevent code */
+
+#include <linux/clocksource.h>
+
+static cycle_t rtc_read(void);
+static struct clocksource clocksource_rtc = {
+	.name         = "rtc",
+	.rating       = 400,
+	.flags        = CLOCK_SOURCE_IS_CONTINUOUS,
+	.mask         = CLOCKSOURCE_MASK(64),
+	.shift        = 22,
+	.mult         = 0,	/* To be filled in */
+	.read         = rtc_read,
+};
+
+static cycle_t timebase_read(void);
+static struct clocksource clocksource_timebase = {
+	.name         = "timebase",
+	.rating       = 400,
+	.flags        = CLOCK_SOURCE_IS_CONTINUOUS,
+	.mask         = CLOCKSOURCE_MASK(64),
+	.shift        = 22,
+	.mult         = 0,	/* To be filled in */
+	.read         = timebase_read,
+};
+
 #ifdef CONFIG_PPC_ISERIES
 static unsigned long __initdata iSeries_recal_titan;
 static signed long __initdata iSeries_recal_tb;
+
+/* Forward declaration is only needed for iSereis compiles */
+void __init clocksource_init(void);
 #endif
 
 #define XSEC_PER_SEC (1024*1024)
@@ -343,65 +372,6 @@ void udelay(unsigned long usecs)
 }
 EXPORT_SYMBOL(udelay);
 
-/*
- * This version of gettimeofday has microsecond resolution.
- */
-static inline void __do_gettimeofday(struct timeval *tv)
-{
-	unsigned long sec, usec;
-	u64 tb_ticks, xsec;
-	struct gettimeofday_vars *temp_varp;
-	u64 temp_tb_to_xs, temp_stamp_xsec;
-
-	/*
-	 * These calculations are faster (gets rid of divides)
-	 * if done in units of 1/2^20 rather than microseconds.
-	 * The conversion to microseconds at the end is done
-	 * without a divide (and in fact, without a multiply)
-	 */
-	temp_varp = do_gtod.varp;
-
-	/* Sampling the time base must be done after loading
-	 * do_gtod.varp in order to avoid racing with update_gtod.
-	 */
-	data_barrier(temp_varp);
-	tb_ticks = get_tb() - temp_varp->tb_orig_stamp;
-	temp_tb_to_xs = temp_varp->tb_to_xs;
-	temp_stamp_xsec = temp_varp->stamp_xsec;
-	xsec = temp_stamp_xsec + mulhdu(tb_ticks, temp_tb_to_xs);
-	sec = xsec / XSEC_PER_SEC;
-	usec = (unsigned long)xsec & (XSEC_PER_SEC - 1);
-	usec = SCALE_XSEC(usec, 1000000);
-
-	tv->tv_sec = sec;
-	tv->tv_usec = usec;
-}
-
-void do_gettimeofday(struct timeval *tv)
-{
-	if (__USE_RTC()) {
-		/* do this the old way */
-		unsigned long flags, seq;
-		unsigned int sec, nsec, usec;
-
-		do {
-			seq = read_seqbegin_irqsave(&xtime_lock, flags);
-			sec = xtime.tv_sec;
-			nsec = xtime.tv_nsec + tb_ticks_since(tb_last_jiffy);
-		} while (read_seqretry_irqrestore(&xtime_lock, seq, flags));
-		usec = nsec / 1000;
-		while (usec >= 1000000) {
-			usec -= 1000000;
-			++sec;
-		}
-		tv->tv_sec = sec;
-		tv->tv_usec = usec;
-		return;
-	}
-	__do_gettimeofday(tv);
-}
-
-EXPORT_SYMBOL(do_gettimeofday);
 
 /*
  * There are two copies of tb_to_xs and stamp_xsec so that no
@@ -447,56 +417,6 @@ static inline void update_gtod(u64 new_t
 	++(vdso_data->tb_update_count);
 }
 
-/*
- * When the timebase - tb_orig_stamp gets too big, we do a manipulation
- * between tb_orig_stamp and stamp_xsec. The goal here is to keep the
- * difference tb - tb_orig_stamp small enough to always fit inside a
- * 32 bits number. This is a requirement of our fast 32 bits userland
- * implementation in the vdso. If we "miss" a call to this function
- * (interrupt latency, CPU locked in a spinlock, ...) and we end up
- * with a too big difference, then the vdso will fallback to calling
- * the syscall
- */
-static __inline__ void timer_recalc_offset(u64 cur_tb)
-{
-	unsigned long offset;
-	u64 new_stamp_xsec;
-	u64 tlen, t2x;
-	u64 tb, xsec_old, xsec_new;
-	struct gettimeofday_vars *varp;
-
-	if (__USE_RTC())
-		return;
-	tlen = current_tick_length();
-	offset = cur_tb - do_gtod.varp->tb_orig_stamp;
-	if (tlen == last_tick_len && offset < 0x80000000u)
-		return;
-	if (tlen != last_tick_len) {
-		t2x = mulhdu(tlen << TICKLEN_SHIFT, ticklen_to_xs);
-		last_tick_len = tlen;
-	} else
-		t2x = do_gtod.varp->tb_to_xs;
-	new_stamp_xsec = (u64) xtime.tv_nsec * XSEC_PER_SEC;
-	do_div(new_stamp_xsec, 1000000000);
-	new_stamp_xsec += (u64) xtime.tv_sec * XSEC_PER_SEC;
-
-	++vdso_data->tb_update_count;
-	smp_mb();
-
-	/*
-	 * Make sure time doesn't go backwards for userspace gettimeofday.
-	 */
-	tb = get_tb();
-	varp = do_gtod.varp;
-	xsec_old = mulhdu(tb - varp->tb_orig_stamp, varp->tb_to_xs)
-		+ varp->stamp_xsec;
-	xsec_new = mulhdu(tb - cur_tb, t2x) + new_stamp_xsec;
-	if (xsec_new < xsec_old)
-		new_stamp_xsec += xsec_old - xsec_new;
-
-	update_gtod(cur_tb, new_stamp_xsec, t2x);
-}
-
 #ifdef CONFIG_SMP
 unsigned long profile_pc(struct pt_regs *regs)
 {
@@ -568,6 +488,8 @@ static int __init iSeries_tb_recal(void)
 	iSeries_recal_titan = titan;
 	iSeries_recal_tb = tb;
 
+	/* Called here as now we know accurate values for the timebase */
+	clocksource_init();
 	return 0;
 }
 late_initcall(iSeries_tb_recal);
@@ -650,7 +572,6 @@ void timer_interrupt(struct pt_regs * re
 		if (per_cpu(last_jiffy, cpu) >= tb_next_jiffy) {
 			tb_last_jiffy = tb_next_jiffy;
 			do_timer(1);
-			timer_recalc_offset(tb_last_jiffy);
 		}
 		write_sequnlock(&xtime_lock);
 	}
@@ -722,66 +643,6 @@ unsigned long long sched_clock(void)
 	return mulhdu(get_tb() - boot_tb, tb_to_ns_scale) << tb_to_ns_shift;
 }
 
-int do_settimeofday(struct timespec *tv)
-{
-	time_t wtm_sec, new_sec = tv->tv_sec;
-	long wtm_nsec, new_nsec = tv->tv_nsec;
-	unsigned long flags;
-	u64 new_xsec;
-	unsigned long tb_delta;
-
-	if ((unsigned long)tv->tv_nsec >= NSEC_PER_SEC)
-		return -EINVAL;
-
-	write_seqlock_irqsave(&xtime_lock, flags);
-
-	/*
-	 * Updating the RTC is not the job of this code. If the time is
-	 * stepped under NTP, the RTC will be updated after STA_UNSYNC
-	 * is cleared.  Tools like clock/hwclock either copy the RTC
-	 * to the system time, in which case there is no point in writing
-	 * to the RTC again, or write to the RTC but then they don't call
-	 * settimeofday to perform this operation.
-	 */
-
-	/* Make userspace gettimeofday spin until we're done. */
-	++vdso_data->tb_update_count;
-	smp_mb();
-
-	/*
-	 * Subtract off the number of nanoseconds since the
-	 * beginning of the last tick.
-	 */
-	tb_delta = tb_ticks_since(tb_last_jiffy);
-	tb_delta = mulhdu(tb_delta, do_gtod.varp->tb_to_xs); /* in xsec */
-	new_nsec -= SCALE_XSEC(tb_delta, 1000000000);
-
-	wtm_sec  = wall_to_monotonic.tv_sec + (xtime.tv_sec - new_sec);
-	wtm_nsec = wall_to_monotonic.tv_nsec + (xtime.tv_nsec - new_nsec);
-
- 	set_normalized_timespec(&xtime, new_sec, new_nsec);
-	set_normalized_timespec(&wall_to_monotonic, wtm_sec, wtm_nsec);
-
-	ntp_clear();
-
-	new_xsec = xtime.tv_nsec;
-	if (new_xsec != 0) {
-		new_xsec *= XSEC_PER_SEC;
-		do_div(new_xsec, NSEC_PER_SEC);
-	}
-	new_xsec += (u64)xtime.tv_sec * XSEC_PER_SEC;
-	update_gtod(tb_last_jiffy, new_xsec, do_gtod.varp->tb_to_xs);
-
-	vdso_data->tz_minuteswest = sys_tz.tz_minuteswest;
-	vdso_data->tz_dsttime = sys_tz.tz_dsttime;
-
-	write_sequnlock_irqrestore(&xtime_lock, flags);
-	clock_was_set();
-	return 0;
-}
-
-EXPORT_SYMBOL(do_settimeofday);
-
 static int __init get_freq(char *name, int cells, unsigned long *val)
 {
 	struct device_node *cpu;
@@ -873,6 +734,69 @@ unsigned long read_persistent_clock(void
 		      tm.tm_hour, tm.tm_min, tm.tm_sec);
 }
 
+/* clocksource code */
+static cycle_t rtc_read(void)
+{
+	return (cycle_t)get_rtc();
+}
+
+static cycle_t timebase_read(void)
+{
+	return (cycle_t)get_tb();
+}
+
+void update_vsyscall(struct timespec *wall_time, struct clocksource *clock)
+{
+	u64 t2x, stamp_xsec;
+
+	if (__USE_RTC() || clock != &clocksource_timebase)
+		return;
+
+	/* Make userspace gettimeofday spin until we're done. */
+	++vdso_data->tb_update_count;
+	smp_mb();
+
+	/* XXX this assumes clock->shift == 22 */
+	/* 4611686018 ~= 2^(20+64-22) / 1e9 */
+	t2x = (u64) clock->mult * 4611686018ULL;
+	stamp_xsec = (u64) xtime.tv_nsec * XSEC_PER_SEC;
+	do_div(stamp_xsec, 1000000000);
+	stamp_xsec += (u64) xtime.tv_sec * XSEC_PER_SEC;
+	update_gtod(clock->cycle_last, stamp_xsec, t2x);
+}
+
+void update_vsyscall_tz(void)
+{
+	/* Make userspace gettimeofday spin until we're done. */
+	++vdso_data->tb_update_count;
+	smp_mb();
+	vdso_data->tz_minuteswest = sys_tz.tz_minuteswest;
+	vdso_data->tz_dsttime = sys_tz.tz_dsttime;
+	smp_mb();
+	++vdso_data->tb_update_count;
+}
+
+void __init clocksource_init(void)
+{
+	struct clocksource *clock;
+
+	if (__USE_RTC())
+		clock = &clocksource_rtc;
+	else
+		clock = &clocksource_timebase;
+
+	clock->mult = clocksource_hz2mult(tb_ticks_per_sec, clock->shift);
+
+	if (clocksource_register(clock)) {
+		printk(KERN_ERR "clocksource: %s is already registered\n",
+		       clock->name);
+		return;
+	}
+
+	printk(KERN_INFO "clocksource: %s mult[%x] shift[%d] registered\n",
+	       clock->name, clock->mult, clock->shift);
+}
+
 /* This function is only called on the boot processor */
 void __init time_init(void)
 {
@@ -982,6 +906,12 @@ void __init time_init(void)
 
 	write_sequnlock_irqrestore(&xtime_lock, flags);
 
+	/* Register the clocksource, if we're not running on iSeries */
+#ifdef CONFIG_ISERIES
+	if (!firmware_has_feature(FW_FEATURE_ISERIES))
+#endif
+		clocksource_init();
+
 	/* Not exact, but the timer interrupt takes care of this */
 	set_dec(tb_ticks_per_jiffy);
 }

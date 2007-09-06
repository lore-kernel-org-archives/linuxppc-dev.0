Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <18144.4514.601900.881855@cargo.ozlabs.ibm.com>
Date: Fri, 7 Sep 2007 00:41:38 +1000
From: Paul Mackerras <paulus@samba.org>
To: linuxppc-dev@ozlabs.org
Subject: [RFC/PATCH 1/2] Basic generic time/clocksource code for PowerPC
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This changes PowerPC to use the generic time infrastructure for
gettimeofday et al.  We register a clocksource which uses the timebase
register, or the RTC on the 601.

It also gets rid of the RTC update stuff.  IIRC we discussed removing
this some time ago but never actually did it.

This is based largely on an earlier patch by Tony Breeds.  It could
still use a little more cleanup.

Signed-off-by: Paul Mackerras <paulus@samba.org>
---

diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index 00099ef..ebecc85 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -21,6 +21,12 @@ config MMU
 	bool
 	default y
 
+config GENERIC_TIME
+	def_bool y
+
+config GENERIC_TIME_VSYSCALL
+	def_bool y
+
 config GENERIC_HARDIRQS
 	bool
 	default y
diff --git a/arch/powerpc/kernel/time.c b/arch/powerpc/kernel/time.c
index b5944d8..7e960a2 100644
--- a/arch/powerpc/kernel/time.c
+++ b/arch/powerpc/kernel/time.c
@@ -73,16 +73,34 @@
 #include <asm/iseries/hv_call_xm.h>
 #endif
 
-/* keep track of when we need to update the rtc */
-time_t last_rtc_update;
+/* powerpc clocksource/clockevent code */
+
+/* TODO:
+ *  o Code style
+ *    * Variable names ... be consistent.
+ *
+ * TODO: Clocksource
+ *  o iSeries registation and matching it with the titan-recalibrate
+ *  o xtime:  Either time.c manages it, or clocksource does, not both
+ */
+
+#include <linux/clocksource.h>
+
+static struct clocksource clocksource_timebase = {
+	.name         = "timebase",
+	.rating       = 400,
+	.flags        = CLOCK_SOURCE_IS_CONTINUOUS,
+	.mask         = CLOCKSOURCE_MASK(64),
+	.shift        = 22,
+	.mult         = 0,	/* To be filled in */
+	.read         = NULL,   /* To be filled in */
+};
+
 #ifdef CONFIG_PPC_ISERIES
 static unsigned long __initdata iSeries_recal_titan;
 static signed long __initdata iSeries_recal_tb;
 #endif
 
-/* The decrementer counts down by 128 every 128ns on a 601. */
-#define DECREMENTER_COUNT_601	(1000000000 / HZ)
-
 #define XSEC_PER_SEC (1024*1024)
 
 #ifdef CONFIG_PPC64
@@ -348,98 +366,6 @@ void udelay(unsigned long usecs)
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
@@ -485,56 +411,6 @@ static inline void update_gtod(u64 new_tb_stamp, u64 new_stamp_xsec,
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
@@ -560,6 +436,7 @@ static int __init iSeries_tb_recal(void)
 {
 	struct div_result divres;
 	unsigned long titan, tb;
+	u64 tb_to_xs;
 
 	/* Make sure we only run on iSeries */
 	if (!firmware_has_feature(FW_FEATURE_ISERIES))
@@ -686,8 +563,6 @@ void timer_interrupt(struct pt_regs * regs)
 		if (per_cpu(last_jiffy, cpu) >= tb_next_jiffy) {
 			tb_last_jiffy = tb_next_jiffy;
 			do_timer(1);
-			timer_recalc_offset(tb_last_jiffy);
-			timer_check_rtc();
 		}
 		write_sequnlock(&xtime_lock);
 	}
@@ -759,71 +634,6 @@ unsigned long long sched_clock(void)
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
-	/* In case of a large backwards jump in time with NTP, we want the 
-	 * clock to be updated as soon as the PLL is again in lock.
-	 */
-	last_rtc_update = new_sec - 658;
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
@@ -892,6 +702,55 @@ unsigned long get_boot_time(void)
 		      tm.tm_hour, tm.tm_min, tm.tm_sec);
 }
 
+/* clocksource code */
+static cycle_t timebase_read(void)
+{
+	if (__USE_RTC())
+		return (cycle_t)get_rtc();
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
+void __init clocksource_init(void)
+{
+	int mult;
+
+	mult = clocksource_hz2mult(tb_ticks_per_sec,
+	                           clocksource_timebase.shift);
+	clocksource_timebase.mult = mult;
+
+	clocksource_timebase.read = timebase_read;
+
+	if (clocksource_register(&clocksource_timebase)) {
+		printk(KERN_ERR "clocksource: %s is already registered\n",
+		       clocksource_timebase.name);
+		return;
+	}
+
+	printk(KERN_INFO "clocksource: %s mult[%x] shift[%d] registered\n",
+	       clocksource_timebase.name,
+	       clocksource_timebase.mult, clocksource_timebase.shift);
+}
+
 /* This function is only called on the boot processor */
 void __init time_init(void)
 {
@@ -1008,11 +867,13 @@ void __init time_init(void)
 
 	time_freq = 0;
 
-	last_rtc_update = xtime.tv_sec;
 	set_normalized_timespec(&wall_to_monotonic,
 	                        -xtime.tv_sec, -xtime.tv_nsec);
 	write_sequnlock_irqrestore(&xtime_lock, flags);
 
+	/* Register the clocksource */
+	clocksource_init();
+
 	/* Not exact, but the timer interrupt takes care of this */
 	set_dec(tb_ticks_per_jiffy);
 }

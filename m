Return-Path: <domen.puncer@telargo.com>
Received: from out001.atlarge.net (out001.atlarge.net [129.41.63.69])
	by ozlabs.org (Postfix) with ESMTP id 66BCFDDDFD
	for <linuxppc-dev@ozlabs.org>; Thu, 12 Jul 2007 16:51:08 +1000 (EST)
Date: Thu, 12 Jul 2007 08:51:04 +0200
From: Domen Puncer <domen.puncer@telargo.com>
To: Matt Sealey <matt@genesi-usa.com>
Subject: Re: Tickless Hz/hrtimers/etc. on PowerPC
Message-ID: <20070712065104.GI4375@moe.telargo.com>
References: <46951C1A.4080001@genesi-usa.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="FCuugMFkClbJLl1L"
In-Reply-To: <46951C1A.4080001@genesi-usa.com>
Cc: ppc-dev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--FCuugMFkClbJLl1L
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On 11/07/07 19:06 +0100, Matt Sealey wrote:
> Does anyone have the definitive patchset to enable the tickless hz,
> some kind of hrtimer and the other related improvements in the
> PowerPC tree?

I use attached patches for tickless.
Order in which they're applied:

PowerPC_GENERIC_CLOCKEVENTS.patch
PowerPC_GENERIC_TIME.linux-2.6.18-rc6_timeofday-arch-ppc_C6.patch
PowerPC_enable_HRT_and_dynticks_support.patch
PowerPC_no_hz_fix.patch
tickless-enable.patch

HTH


	Domen

--FCuugMFkClbJLl1L
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="PowerPC_GENERIC_CLOCKEVENTS.patch"

===================================================================
---
 arch/powerpc/Kconfig       |   12 +++-
 arch/powerpc/kernel/time.c |  124 ++++++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 134 insertions(+), 2 deletions(-)

Index: work-powerpc.git/arch/powerpc/Kconfig
===================================================================
--- work-powerpc.git.orig/arch/powerpc/Kconfig
+++ work-powerpc.git/arch/powerpc/Kconfig
@@ -347,7 +347,7 @@ config PPC_MM_SLICES
 
 config VIRT_CPU_ACCOUNTING
 	bool "Deterministic task and CPU time accounting"
-	depends on PPC64
+	depends on PPC64 && !GENERIC_CLOCKEVENTS
 	default y
 	help
 	  Select this option to enable more accurate task and CPU time
@@ -406,6 +406,16 @@ config HIGHMEM
 	depends on PPC32
 
 source kernel/Kconfig.hz
+
+config GENERIC_CLOCKEVENTS
+	bool "Clock event devices support"
+	default n
+	help
+	  Enable support for the clock event devices necessary for the
+	  high-resolution timers and the tickless system support.
+	  NOTE: This is not compatible with the deterministic time accounting
+	  option on PPC64.
+
 source kernel/Kconfig.preempt
 source "fs/Kconfig.binfmt"
 
Index: work-powerpc.git/arch/powerpc/kernel/time.c
===================================================================
--- work-powerpc.git.orig/arch/powerpc/kernel/time.c
+++ work-powerpc.git/arch/powerpc/kernel/time.c
@@ -52,6 +52,7 @@
 #include <linux/jiffies.h>
 #include <linux/posix-timers.h>
 #include <linux/irq.h>
+#include <linux/clockchips.h>
 
 #include <asm/io.h>
 #include <asm/processor.h>
@@ -127,6 +128,83 @@ unsigned long ppc_tb_freq;
 static u64 tb_last_jiffy __cacheline_aligned_in_smp;
 static DEFINE_PER_CPU(u64, last_jiffy);
 
+#ifdef CONFIG_GENERIC_CLOCKEVENTS
+
+#if defined(CONFIG_40x) || defined(CONFIG_BOOKE)
+#define DECREMENTER_MAX 0xffffffff
+#else
+#define DECREMENTER_MAX 0x7fffffff /* setting MSB triggers an interrupt */
+#endif
+
+static int decrementer_set_next_event(unsigned long evt,
+				      struct clock_event_device *dev)
+{
+#if defined(CONFIG_40x)
+	mtspr(SPRN_PIT, evt);	/* 40x has a hidden PIT auto-reload register */
+#elif defined(CONFIG_BOOKE)
+	mtspr(SPRN_DECAR, evt); /* Book E has  separate auto-reload register */
+	set_dec(evt);
+#else
+	set_dec(evt - 1);	/* Classic decrementer interrupts at -1 */
+#endif
+	return 0;
+}
+
+static void decrementer_set_mode(enum	clock_event_mode   mode,
+				 struct clock_event_device *dev)
+{
+#if defined(CONFIG_40x) || defined(CONFIG_BOOKE)
+	u32 tcr = mfspr(SPRN_TCR);
+
+	tcr |= TCR_DIE;
+	switch (mode) {
+	case CLOCK_EVT_MODE_PERIODIC:
+		tcr |=  TCR_ARE;
+		break;
+	case CLOCK_EVT_MODE_ONESHOT:
+		tcr &= ~TCR_ARE;
+		break;
+	case CLOCK_EVT_MODE_UNUSED:
+	case CLOCK_EVT_MODE_SHUTDOWN:
+		tcr &= ~TCR_DIE;
+		break;
+	}
+	mtspr(SPRN_TCR, tcr);
+#endif
+	if (mode == CLOCK_EVT_MODE_PERIODIC)
+		decrementer_set_next_event(tb_ticks_per_jiffy, dev);
+}
+
+static struct clock_event_device decrementer_clockevent = {
+	.name		= "decrementer",
+#if defined(CONFIG_40x) || defined(CONFIG_BOOKE)
+	.features	= CLOCK_EVT_FEAT_ONESHOT | CLOCK_EVT_FEAT_PERIODIC,
+#else
+	.features	= CLOCK_EVT_FEAT_ONESHOT,
+#endif
+	.shift		= 32,
+	.rating		= 200,
+	.irq		= -1,
+	.set_next_event	= decrementer_set_next_event,
+	.set_mode	= decrementer_set_mode,
+};
+
+static DEFINE_PER_CPU(struct clock_event_device, decrementers);
+
+static void register_decrementer(void)
+{
+	int cpu = smp_processor_id();
+	struct clock_event_device *decrementer = &per_cpu(decrementers, cpu);
+
+	memcpy(decrementer, &decrementer_clockevent, sizeof(*decrementer));
+
+	decrementer->cpumask = cpumask_of_cpu(cpu);
+
+	clockevents_register_device(decrementer);
+}
+
+#endif /* CONFIG_GENERIC_CLOCKEVENTS */
+
 #ifdef CONFIG_VIRT_CPU_ACCOUNTING
 /*
  * Factors for converting from cputime_t (timebase ticks) to
@@ -312,6 +390,9 @@ void snapshot_timebase(void)
 {
 	__get_cpu_var(last_jiffy) = get_tb();
 	snapshot_purr();
+#ifdef CONFIG_GENERIC_CLOCKEVENTS
+	register_decrementer();
+#endif
 }
 
 void __delay(unsigned long loops)
@@ -627,7 +708,31 @@ void timer_interrupt(struct pt_regs * re
 	old_regs = set_irq_regs(regs);
 	irq_enter();
 
+#ifdef CONFIG_GENERIC_CLOCKEVENTS
+#ifdef CONFIG_PPC_MULTIPLATFORM
+	/*
+	 * We must write a positive value to the decrementer to clear
+	 * the interrupt on the IBM 970 CPU series.  In periodic mode,
+	 * this happens when the decrementer gets reloaded later, but
+	 * in one-shot mode, we have to do it here since an event handler
+	 * may skip loading the new value...
+	 */
+	if (per_cpu(decrementers, cpu).mode != CLOCK_EVT_MODE_PERIODIC)
+		set_dec(DECREMENTER_MAX);
+#endif
+	/*
+	 * We can't disable the decrementer, so in the period between
+	 * CPU being marked offline and calling stop-self, it's taking
+	 * timer interrupts...
+	 */
+	if (!cpu_is_offline(cpu)) {
+		struct clock_event_device *dev = &per_cpu(decrementers, cpu);
+
+		dev->event_handler(dev);
+	}
+#else
 	profile_tick(CPU_PROFILING);
+#endif
 	calculate_steal_time();
 
 #ifdef CONFIG_PPC_ISERIES
@@ -643,6 +748,7 @@ void timer_interrupt(struct pt_regs * re
 		if (__USE_RTC() && per_cpu(last_jiffy, cpu) >= 1000000000)
 			per_cpu(last_jiffy, cpu) -= 1000000000;
 
+#ifndef CONFIG_GENERIC_CLOCKEVENTS
 		/*
 		 * We cannot disable the decrementer, so in the period
 		 * between this cpu's being marked offline in cpu_online_map
@@ -652,6 +758,7 @@ void timer_interrupt(struct pt_regs * re
 		 */
 		if (!cpu_is_offline(cpu))
 			account_process_time(regs);
+#endif
 
 		/*
 		 * No need to check whether cpu is offline here; boot_cpuid
@@ -664,15 +771,19 @@ void timer_interrupt(struct pt_regs * re
 		tb_next_jiffy = tb_last_jiffy + tb_ticks_per_jiffy;
 		if (per_cpu(last_jiffy, cpu) >= tb_next_jiffy) {
 			tb_last_jiffy = tb_next_jiffy;
+#ifndef CONFIG_GENERIC_CLOCKEVENTS
 			do_timer(1);
+#endif
 			timer_recalc_offset(tb_last_jiffy);
 			timer_check_rtc();
 		}
 		write_sequnlock(&xtime_lock);
 	}
-	
+
+#ifndef CONFIG_GENERIC_CLOCKEVENTS
 	next_dec = tb_ticks_per_jiffy - ticks;
 	set_dec(next_dec);
+#endif
 
 #ifdef CONFIG_PPC_ISERIES
 	if (firmware_has_feature(FW_FEATURE_ISERIES) && hvlpevent_is_pending())
@@ -996,8 +1107,19 @@ void __init time_init(void)
 	                        -xtime.tv_sec, -xtime.tv_nsec);
 	write_sequnlock_irqrestore(&xtime_lock, flags);
 
+#ifdef CONFIG_GENERIC_CLOCKEVENTS
+	decrementer_clockevent.mult = div_sc(ppc_tb_freq, NSEC_PER_SEC,
+					     decrementer_clockevent.shift);
+	decrementer_clockevent.max_delta_ns =
+		clockevent_delta2ns(DECREMENTER_MAX, &decrementer_clockevent);
+	decrementer_clockevent.min_delta_ns =
+		clockevent_delta2ns(0xf, &decrementer_clockevent);
+
+	register_decrementer();
+#else
 	/* Not exact, but the timer interrupt takes care of this */
 	set_dec(tb_ticks_per_jiffy);
+#endif
 }
 
 

--FCuugMFkClbJLl1L
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="PowerPC_GENERIC_TIME.linux-2.6.18-rc6_timeofday-arch-ppc_C6.patch"

Early pass on powerpc conversion to generic timekeeping.

Signed-off-by: John Stultz <johnstul@us.ibm.com>

 arch/powerpc/Kconfig       |    4 
 arch/powerpc/kernel/time.c |  278 +++++----------------------------------------
 2 files changed, 37 insertions(+), 245 deletions(-)

linux-2.6.18-rc6_timeofday-arch-ppc_C6.patch
============================================
Index: work-powerpc.git/arch/powerpc/Kconfig
===================================================================
--- work-powerpc.git.orig/arch/powerpc/Kconfig
+++ work-powerpc.git/arch/powerpc/Kconfig
@@ -31,6 +31,10 @@ config MMU
 	bool
 	default y
 
+config GENERIC_TIME
+	bool
+	default y
+
 config GENERIC_HARDIRQS
 	bool
 	default y
Index: work-powerpc.git/arch/powerpc/kernel/time.c
===================================================================
--- work-powerpc.git.orig/arch/powerpc/kernel/time.c
+++ work-powerpc.git/arch/powerpc/kernel/time.c
@@ -117,8 +117,6 @@ EXPORT_SYMBOL_GPL(rtc_lock);
 u64 tb_to_ns_scale;
 unsigned tb_to_ns_shift;
 
-struct gettimeofday_struct do_gtod;
-
 extern struct timezone sys_tz;
 static long timezone_offset;
 
@@ -456,160 +454,6 @@ static __inline__ void timer_check_rtc(v
         }
 }
 
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
-
-/*
- * There are two copies of tb_to_xs and stamp_xsec so that no
- * lock is needed to access and use these values in
- * do_gettimeofday.  We alternate the copies and as long as a
- * reasonable time elapses between changes, there will never
- * be inconsistent values.  ntpd has a minimum of one minute
- * between updates.
- */
-static inline void update_gtod(u64 new_tb_stamp, u64 new_stamp_xsec,
-			       u64 new_tb_to_xs)
-{
-	unsigned temp_idx;
-	struct gettimeofday_vars *temp_varp;
-
-	temp_idx = (do_gtod.var_idx == 0);
-	temp_varp = &do_gtod.vars[temp_idx];
-
-	temp_varp->tb_to_xs = new_tb_to_xs;
-	temp_varp->tb_orig_stamp = new_tb_stamp;
-	temp_varp->stamp_xsec = new_stamp_xsec;
-	smp_mb();
-	do_gtod.varp = temp_varp;
-	do_gtod.var_idx = temp_idx;
-
-	/*
-	 * tb_update_count is used to allow the userspace gettimeofday code
-	 * to assure itself that it sees a consistent view of the tb_to_xs and
-	 * stamp_xsec variables.  It reads the tb_update_count, then reads
-	 * tb_to_xs and stamp_xsec and then reads tb_update_count again.  If
-	 * the two values of tb_update_count match and are even then the
-	 * tb_to_xs and stamp_xsec values are consistent.  If not, then it
-	 * loops back and reads them again until this criteria is met.
-	 * We expect the caller to have done the first increment of
-	 * vdso_data->tb_update_count already.
-	 */
-	vdso_data->tb_orig_stamp = new_tb_stamp;
-	vdso_data->stamp_xsec = new_stamp_xsec;
-	vdso_data->tb_to_xs = new_tb_to_xs;
-	vdso_data->wtom_clock_sec = wall_to_monotonic.tv_sec;
-	vdso_data->wtom_clock_nsec = wall_to_monotonic.tv_nsec;
-	smp_wmb();
-	++(vdso_data->tb_update_count);
-}
-
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
@@ -659,11 +503,7 @@ static void iSeries_tb_recal(void)
 				tb_ticks_per_sec   = new_tb_ticks_per_sec;
 				calc_cputime_factors();
 				div128_by_32( XSEC_PER_SEC, 0, tb_ticks_per_sec, &divres );
-				do_gtod.tb_ticks_per_sec = tb_ticks_per_sec;
 				tb_to_xs = divres.result_low;
-				do_gtod.varp->tb_to_xs = tb_to_xs;
-				vdso_data->tb_ticks_per_sec = tb_ticks_per_sec;
-				vdso_data->tb_to_xs = tb_to_xs;
 			}
 			else {
 				printk( "Titan recalibrate: FAILED (difference > 4 percent)\n"
@@ -849,76 +689,6 @@ unsigned long long sched_clock(void)
 	return mulhdu(get_tb(), tb_to_ns_scale) << tb_to_ns_shift;
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
-#ifdef CONFIG_PPC_ISERIES
-	if (firmware_has_feature(FW_FEATURE_ISERIES) && first_settimeofday) {
-		iSeries_tb_recal();
-		first_settimeofday = 0;
-	}
-#endif
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
 
 static int __init get_freq(char *name, int cells, unsigned long *val)
 {
@@ -1085,20 +855,6 @@ void __init time_init(void)
 
 	xtime.tv_sec = tm;
 	xtime.tv_nsec = 0;
-	do_gtod.varp = &do_gtod.vars[0];
-	do_gtod.var_idx = 0;
-	do_gtod.varp->tb_orig_stamp = tb_last_jiffy;
-	__get_cpu_var(last_jiffy) = tb_last_jiffy;
-	do_gtod.varp->stamp_xsec = (u64) xtime.tv_sec * XSEC_PER_SEC;
-	do_gtod.tb_ticks_per_sec = tb_ticks_per_sec;
-	do_gtod.varp->tb_to_xs = tb_to_xs;
-	do_gtod.tb_to_us = tb_to_us;
-
-	vdso_data->tb_orig_stamp = tb_last_jiffy;
-	vdso_data->tb_update_count = 0;
-	vdso_data->tb_ticks_per_sec = tb_ticks_per_sec;
-	vdso_data->stamp_xsec = (u64) xtime.tv_sec * XSEC_PER_SEC;
-	vdso_data->tb_to_xs = tb_to_xs;
 
 	time_freq = 0;
 
@@ -1122,7 +878,6 @@ void __init time_init(void)
 #endif
 }
 
-
 #define FEBRUARY	2
 #define	STARTOFTIME	1970
 #define SECDAY		86400L
@@ -1267,3 +1022,36 @@ void div128_by_32(u64 dividend_high, u64
 	dr->result_low  = ((u64)y << 32) + z;
 
 }
+
+
+/* powerpc clocksource code */
+
+#include <linux/clocksource.h>
+static cycle_t timebase_read(void)
+{
+	return (cycle_t)get_tb();
+}
+
+struct clocksource clocksource_timebase = {
+	.name = "timebase",
+	.rating = 200,
+	.read = timebase_read,
+	.mask = (cycle_t)-1,
+	.mult = 0,
+	.shift = 22,
+};
+
+
+/* XXX - this should be calculated or properly externed! */
+static int __init init_timebase_clocksource(void)
+{
+	if (__USE_RTC())
+		return -ENODEV;
+
+	clocksource_timebase.mult = clocksource_hz2mult(tb_ticks_per_sec,
+					clocksource_timebase.shift);
+	return clocksource_register(&clocksource_timebase);
+}
+
+module_init(init_timebase_clocksource);
+

--FCuugMFkClbJLl1L
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="PowerPC_enable_HRT_and_dynticks_support.patch"

---
 arch/powerpc/Kconfig       |    1 +
 arch/powerpc/kernel/idle.c |    3 +++
 2 files changed, 4 insertions(+)

Index: work-powerpc.git/arch/powerpc/Kconfig
===================================================================
--- work-powerpc.git.orig/arch/powerpc/Kconfig
+++ work-powerpc.git/arch/powerpc/Kconfig
@@ -416,6 +416,7 @@ config GENERIC_CLOCKEVENTS
 	  NOTE: This is not compatible with the deterministic time accounting
 	  option on PPC64.
 
+source kernel/time/Kconfig
 source kernel/Kconfig.preempt
 source "fs/Kconfig.binfmt"
 
Index: work-powerpc.git/arch/powerpc/kernel/idle.c
===================================================================
--- work-powerpc.git.orig/arch/powerpc/kernel/idle.c
+++ work-powerpc.git/arch/powerpc/kernel/idle.c
@@ -24,6 +24,7 @@
 #include <linux/smp.h>
 #include <linux/cpu.h>
 #include <linux/sysctl.h>
+#include <linux/tick.h>
 
 #include <asm/system.h>
 #include <asm/processor.h>
@@ -59,6 +60,7 @@ void cpu_idle(void)
 
 	set_thread_flag(TIF_POLLING_NRFLAG);
 	while (1) {
+		tick_nohz_stop_sched_tick();
 		while (!need_resched() && !cpu_should_die()) {
 			ppc64_runlatch_off();
 
@@ -92,6 +94,7 @@ void cpu_idle(void)
 		ppc64_runlatch_on();
 		if (cpu_should_die())
 			cpu_die();
+		tick_nohz_restart_sched_tick();
 		preempt_enable_no_resched();
 		schedule();
 		preempt_disable();

--FCuugMFkClbJLl1L
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="PowerPC_no_hz_fix.patch"

---
 arch/powerpc/kernel/time.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Index: work-powerpc.git/arch/powerpc/kernel/time.c
===================================================================
--- work-powerpc.git.orig/arch/powerpc/kernel/time.c
+++ work-powerpc.git/arch/powerpc/kernel/time.c
@@ -614,7 +614,7 @@ void timer_interrupt(struct pt_regs * re
 #ifndef CONFIG_GENERIC_CLOCKEVENTS
 			do_timer(1);
 #endif
-			timer_recalc_offset(tb_last_jiffy);
+			/*timer_recalc_offset(tb_last_jiffy);*/
 			timer_check_rtc();
 		}
 		write_sequnlock(&xtime_lock);

--FCuugMFkClbJLl1L
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="tickless-enable.patch"

This is needed for hrtimer_switch_to_hres() to get called.
hrtimer_run_queues()
|-tick_check_oneshot_change()
| \-timekeeping_is_continuous()
|   \- flags check
\-hrtimer_switch_to_hres()

Signed-off-by: Domen Puncer <domen.puncer@telargo.com>

---
 arch/powerpc/kernel/time.c |    1 +
 1 file changed, 1 insertion(+)

Index: work-powerpc.git/arch/powerpc/kernel/time.c
===================================================================
--- work-powerpc.git.orig/arch/powerpc/kernel/time.c
+++ work-powerpc.git/arch/powerpc/kernel/time.c
@@ -1039,6 +1039,7 @@ struct clocksource clocksource_timebase 
 	.mask = (cycle_t)-1,
 	.mult = 0,
 	.shift = 22,
+	.flags = CLOCK_SOURCE_VALID_FOR_HRES,
 };
 
 

--FCuugMFkClbJLl1L--

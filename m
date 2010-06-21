Return-Path: <paulus@ozlabs.org>
Date: Mon, 21 Jun 2010 15:04:14 +1000
From: Paul Mackerras <paulus@samba.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 2/2] powerpc: Clean up obsolete code relating to decrementer
	and timebase
Message-ID: <20100621050414.GB12055@drongo>
References: <20100621050308.GA12055@drongo>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20100621050308.GA12055@drongo>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Since the decrementer and timekeeping code was moved over to using
the generic clockevents and timekeeping infrastructure, several
variables and functions have been obsolete and effectively unused.
This deletes them.

In particular, wakeup_decrementer() is no longer needed since the
generic code reprograms the decrementer as part of the process of
resuming the timekeeping code, which happens during sysdev resume.
Thus the wakeup_decrementer calls in the suspend_enter methods for
52xx platforms have been removed.  The call in the powermac cpu
frequency change code has been replaced by set_dec(1), which will
cause a timer interrupt as soon as interrupts are enabled, and the
generic code will then reprogram the decrementer with the correct
value.

This also simplifies the generic_suspend_en/disable_irqs functions
and makes them static since they are not referenced outside time.c.
The preempt_enable/disable calls are removed because the generic
code has disabled all but the boot cpu at the point where these
functions are called, so we can't be moved to another cpu.

Signed-off-by: Paul Mackerras <paulus@samba.org>
---
 arch/powerpc/include/asm/machdep.h           |    3 -
 arch/powerpc/include/asm/time.h              |    7 --
 arch/powerpc/kernel/smp.c                    |    2 -
 arch/powerpc/kernel/time.c                   |  136 +-------------------------
 arch/powerpc/platforms/52xx/lite5200_pm.c    |    3 -
 arch/powerpc/platforms/52xx/mpc52xx_pm.c     |    3 -
 arch/powerpc/platforms/powermac/cpufreq_32.c |    8 +-
 7 files changed, 9 insertions(+), 153 deletions(-)

diff --git a/arch/powerpc/include/asm/machdep.h b/arch/powerpc/include/asm/machdep.h
index 9f0fc9e..7716e68 100644
--- a/arch/powerpc/include/asm/machdep.h
+++ b/arch/powerpc/include/asm/machdep.h
@@ -366,8 +366,5 @@ static inline void log_error(char *buf, unsigned int err_type, int fatal)
 #define machine_late_initcall(mach,fn)		__define_machine_initcall(mach,"7",fn,7)
 #define machine_late_initcall_sync(mach,fn)	__define_machine_initcall(mach,"7s",fn,7s)
 
-void generic_suspend_disable_irqs(void);
-void generic_suspend_enable_irqs(void);
-
 #endif /* __KERNEL__ */
 #endif /* _ASM_POWERPC_MACHDEP_H */
diff --git a/arch/powerpc/include/asm/time.h b/arch/powerpc/include/asm/time.h
index 27ccb76..dc779df 100644
--- a/arch/powerpc/include/asm/time.h
+++ b/arch/powerpc/include/asm/time.h
@@ -28,16 +28,12 @@
 extern unsigned long tb_ticks_per_jiffy;
 extern unsigned long tb_ticks_per_usec;
 extern unsigned long tb_ticks_per_sec;
-extern u64 tb_to_xs;
-extern unsigned      tb_to_us;
 
 struct rtc_time;
 extern void to_tm(int tim, struct rtc_time * tm);
 extern void GregorianDay(struct rtc_time *tm);
-extern time_t last_rtc_update;
 
 extern void generic_calibrate_decr(void);
-extern void wakeup_decrementer(void);
 extern void snapshot_timebase(void);
 
 extern void set_dec_cpu6(unsigned int val);
@@ -204,9 +200,6 @@ static inline unsigned long tb_ticks_since(unsigned long tstamp)
 extern u64 mulhdu(u64, u64);
 #endif
 
-extern void smp_space_timers(unsigned int);
-
-extern unsigned mulhwu_scale_factor(unsigned, unsigned);
 extern void div128_by_32(u64 dividend_high, u64 dividend_low,
 			 unsigned divisor, struct div_result *dr);
 
diff --git a/arch/powerpc/kernel/smp.c b/arch/powerpc/kernel/smp.c
index 5c196d1..8764daa 100644
--- a/arch/powerpc/kernel/smp.c
+++ b/arch/powerpc/kernel/smp.c
@@ -288,8 +288,6 @@ void __init smp_prepare_cpus(unsigned int max_cpus)
 			max_cpus = NR_CPUS;
 	else
 		max_cpus = 1;
- 
-	smp_space_timers(max_cpus);
 
 	for_each_possible_cpu(cpu)
 		if (cpu != boot_cpuid)
diff --git a/arch/powerpc/kernel/time.c b/arch/powerpc/kernel/time.c
index 5adebaf..ccb8759 100644
--- a/arch/powerpc/kernel/time.c
+++ b/arch/powerpc/kernel/time.c
@@ -149,16 +149,6 @@ unsigned long tb_ticks_per_usec = 100; /* sane default */
 EXPORT_SYMBOL(tb_ticks_per_usec);
 unsigned long tb_ticks_per_sec;
 EXPORT_SYMBOL(tb_ticks_per_sec);	/* for cputime_t conversions */
-u64 tb_to_xs;
-unsigned tb_to_us;
-
-#define TICKLEN_SCALE	NTP_SCALE_SHIFT
-static u64 last_tick_len;	/* units are ns / 2^TICKLEN_SCALE */
-static u64 ticklen_to_xs;	/* 0.64 fraction */
-
-/* If last_tick_len corresponds to about 1/HZ seconds, then
-   last_tick_len << TICKLEN_SHIFT will be about 2^63. */
-#define TICKLEN_SHIFT	(63 - 30 - TICKLEN_SCALE + SHIFT_HZ)
 
 DEFINE_SPINLOCK(rtc_lock);
 EXPORT_SYMBOL_GPL(rtc_lock);
@@ -174,7 +164,6 @@ unsigned long ppc_proc_freq;
 EXPORT_SYMBOL(ppc_proc_freq);
 unsigned long ppc_tb_freq;
 
-static u64 tb_last_jiffy __cacheline_aligned_in_smp;
 static DEFINE_PER_CPU(u64, last_jiffy);
 
 #ifdef CONFIG_VIRT_CPU_ACCOUNTING
@@ -446,7 +435,6 @@ EXPORT_SYMBOL(profile_pc);
 
 static int __init iSeries_tb_recal(void)
 {
-	struct div_result divres;
 	unsigned long titan, tb;
 
 	/* Make sure we only run on iSeries */
@@ -477,10 +465,7 @@ static int __init iSeries_tb_recal(void)
 				tb_ticks_per_jiffy = new_tb_ticks_per_jiffy;
 				tb_ticks_per_sec   = new_tb_ticks_per_sec;
 				calc_cputime_factors();
-				div128_by_32( XSEC_PER_SEC, 0, tb_ticks_per_sec, &divres );
-				tb_to_xs = divres.result_low;
 				vdso_data->tb_ticks_per_sec = tb_ticks_per_sec;
-				vdso_data->tb_to_xs = tb_to_xs;
 				setup_cputime_one_jiffy();
 			}
 			else {
@@ -643,27 +628,9 @@ void timer_interrupt(struct pt_regs * regs)
 	trace_timer_interrupt_exit(regs);
 }
 
-void wakeup_decrementer(void)
-{
-	unsigned long ticks;
-
-	/*
-	 * The timebase gets saved on sleep and restored on wakeup,
-	 * so all we need to do is to reset the decrementer.
-	 */
-	ticks = tb_ticks_since(__get_cpu_var(last_jiffy));
-	if (ticks < tb_ticks_per_jiffy)
-		ticks = tb_ticks_per_jiffy - ticks;
-	else
-		ticks = 1;
-	set_dec(ticks);
-}
-
 #ifdef CONFIG_SUSPEND
-void generic_suspend_disable_irqs(void)
+static void generic_suspend_disable_irqs(void)
 {
-	preempt_disable();
-
 	/* Disable the decrementer, so that it doesn't interfere
 	 * with suspending.
 	 */
@@ -673,12 +640,9 @@ void generic_suspend_disable_irqs(void)
 	set_dec(0x7fffffff);
 }
 
-void generic_suspend_enable_irqs(void)
+static void generic_suspend_enable_irqs(void)
 {
-	wakeup_decrementer();
-
 	local_irq_enable();
-	preempt_enable();
 }
 
 /* Overrides the weak version in kernel/power/main.c */
@@ -698,23 +662,6 @@ void arch_suspend_enable_irqs(void)
 }
 #endif
 
-#ifdef CONFIG_SMP
-void __init smp_space_timers(unsigned int max_cpus)
-{
-	int i;
-	u64 previous_tb = per_cpu(last_jiffy, boot_cpuid);
-
-	/* make sure tb > per_cpu(last_jiffy, cpu) for all cpus always */
-	previous_tb -= tb_ticks_per_jiffy;
-
-	for_each_possible_cpu(i) {
-		if (i == boot_cpuid)
-			continue;
-		per_cpu(last_jiffy, i) = previous_tb;
-	}
-}
-#endif
-
 /*
  * Scheduler clock - returns current time in nanosec units.
  *
@@ -1014,15 +961,13 @@ void secondary_cpu_time_init(void)
 /* This function is only called on the boot processor */
 void __init time_init(void)
 {
-	unsigned long flags;
 	struct div_result res;
-	u64 scale, x;
+	u64 scale;
 	unsigned shift;
 
 	if (__USE_RTC()) {
 		/* 601 processor: dec counts down by 128 every 128ns */
 		ppc_tb_freq = 1000000000;
-		tb_last_jiffy = get_rtcl();
 	} else {
 		/* Normal PowerPC with timebase register */
 		ppc_md.calibrate_decr();
@@ -1030,50 +975,15 @@ void __init time_init(void)
 		       ppc_tb_freq / 1000000, ppc_tb_freq % 1000000);
 		printk(KERN_DEBUG "time_init: processor frequency   = %lu.%.6lu MHz\n",
 		       ppc_proc_freq / 1000000, ppc_proc_freq % 1000000);
-		tb_last_jiffy = get_tb();
 	}
 
 	tb_ticks_per_jiffy = ppc_tb_freq / HZ;
 	tb_ticks_per_sec = ppc_tb_freq;
 	tb_ticks_per_usec = ppc_tb_freq / 1000000;
-	tb_to_us = mulhwu_scale_factor(ppc_tb_freq, 1000000);
 	calc_cputime_factors();
 	setup_cputime_one_jiffy();
 
 	/*
-	 * Calculate the length of each tick in ns.  It will not be
-	 * exactly 1e9/HZ unless ppc_tb_freq is divisible by HZ.
-	 * We compute 1e9 * tb_ticks_per_jiffy / ppc_tb_freq,
-	 * rounded up.
-	 */
-	x = (u64) NSEC_PER_SEC * tb_ticks_per_jiffy + ppc_tb_freq - 1;
-	do_div(x, ppc_tb_freq);
-	tick_nsec = x;
-	last_tick_len = x << TICKLEN_SCALE;
-
-	/*
-	 * Compute ticklen_to_xs, which is a factor which gets multiplied
-	 * by (last_tick_len << TICKLEN_SHIFT) to get a tb_to_xs value.
-	 * It is computed as:
-	 * ticklen_to_xs = 2^N / (tb_ticks_per_jiffy * 1e9)
-	 * where N = 64 + 20 - TICKLEN_SCALE - TICKLEN_SHIFT
-	 * which turns out to be N = 51 - SHIFT_HZ.
-	 * This gives the result as a 0.64 fixed-point fraction.
-	 * That value is reduced by an offset amounting to 1 xsec per
-	 * 2^31 timebase ticks to avoid problems with time going backwards
-	 * by 1 xsec when we do timer_recalc_offset due to losing the
-	 * fractional xsec.  That offset is equal to ppc_tb_freq/2^51
-	 * since there are 2^20 xsec in a second.
-	 */
-	div128_by_32((1ULL << 51) - ppc_tb_freq, 0,
-		     tb_ticks_per_jiffy << SHIFT_HZ, &res);
-	div128_by_32(res.result_high, res.result_low, NSEC_PER_SEC, &res);
-	ticklen_to_xs = res.result_low;
-
-	/* Compute tb_to_xs from tick_nsec */
-	tb_to_xs = mulhdu(last_tick_len << TICKLEN_SHIFT, ticklen_to_xs);
-
-	/*
 	 * Compute scale factor for sched_clock.
 	 * The calibrate_decr() function has set tb_ticks_per_sec,
 	 * which is the timebase frequency.
@@ -1094,21 +1004,14 @@ void __init time_init(void)
 	/* Save the current timebase to pretty up CONFIG_PRINTK_TIME */
 	boot_tb = get_tb_or_rtc();
 
-	write_seqlock_irqsave(&xtime_lock, flags);
-
 	/* If platform provided a timezone (pmac), we correct the time */
         if (timezone_offset) {
 		sys_tz.tz_minuteswest = -timezone_offset / 60;
 		sys_tz.tz_dsttime = 0;
         }
 
-	vdso_data->tb_orig_stamp = tb_last_jiffy;
 	vdso_data->tb_update_count = 0;
 	vdso_data->tb_ticks_per_sec = tb_ticks_per_sec;
-	vdso_data->stamp_xsec = (u64) xtime.tv_sec * XSEC_PER_SEC;
-	vdso_data->tb_to_xs = tb_to_xs;
-
-	write_sequnlock_irqrestore(&xtime_lock, flags);
 
 	/* Start the decrementer on CPUs that have manual control
 	 * such as BookE
@@ -1202,39 +1105,6 @@ void to_tm(int tim, struct rtc_time * tm)
 	GregorianDay(tm);
 }
 
-/* Auxiliary function to compute scaling factors */
-/* Actually the choice of a timebase running at 1/4 the of the bus
- * frequency giving resolution of a few tens of nanoseconds is quite nice.
- * It makes this computation very precise (27-28 bits typically) which
- * is optimistic considering the stability of most processor clock
- * oscillators and the precision with which the timebase frequency
- * is measured but does not harm.
- */
-unsigned mulhwu_scale_factor(unsigned inscale, unsigned outscale)
-{
-        unsigned mlt=0, tmp, err;
-        /* No concern for performance, it's done once: use a stupid
-         * but safe and compact method to find the multiplier.
-         */
-  
-        for (tmp = 1U<<31; tmp != 0; tmp >>= 1) {
-                if (mulhwu(inscale, mlt|tmp) < outscale)
-			mlt |= tmp;
-        }
-  
-        /* We might still be off by 1 for the best approximation.
-         * A side effect of this is that if outscale is too large
-         * the returned value will be zero.
-         * Many corner cases have been checked and seem to work,
-         * some might have been forgotten in the test however.
-         */
-  
-        err = inscale * (mlt+1);
-        if (err <= inscale/2)
-		mlt++;
-        return mlt;
-}
-
 /*
  * Divide a 128-bit dividend by a 32-bit divisor, leaving a 128 bit
  * result.
diff --git a/arch/powerpc/platforms/52xx/lite5200_pm.c b/arch/powerpc/platforms/52xx/lite5200_pm.c
index b5c753d..80234e5 100644
--- a/arch/powerpc/platforms/52xx/lite5200_pm.c
+++ b/arch/powerpc/platforms/52xx/lite5200_pm.c
@@ -216,9 +216,6 @@ static int lite5200_pm_enter(suspend_state_t state)
 
 	lite5200_restore_regs();
 
-	/* restart jiffies */
-	wakeup_decrementer();
-
 	iounmap(mbar);
 	return 0;
 }
diff --git a/arch/powerpc/platforms/52xx/mpc52xx_pm.c b/arch/powerpc/platforms/52xx/mpc52xx_pm.c
index a55b0b6..30cc48d 100644
--- a/arch/powerpc/platforms/52xx/mpc52xx_pm.c
+++ b/arch/powerpc/platforms/52xx/mpc52xx_pm.c
@@ -162,9 +162,6 @@ int mpc52xx_pm_enter(suspend_state_t state)
 	/* restore SRAM */
 	memcpy(sram, saved_sram, sram_size);
 
-	/* restart jiffies */
-	wakeup_decrementer();
-
 	/* reenable interrupts in PIC */
 	out_be32(&intr->main_mask, intr_main_mask);
 
diff --git a/arch/powerpc/platforms/powermac/cpufreq_32.c b/arch/powerpc/platforms/powermac/cpufreq_32.c
index 1e9eba1..415ca6d 100644
--- a/arch/powerpc/platforms/powermac/cpufreq_32.c
+++ b/arch/powerpc/platforms/powermac/cpufreq_32.c
@@ -310,8 +310,12 @@ static int pmu_set_cpu_speed(int low_speed)
 	/* Restore low level PMU operations */
 	pmu_unlock();
 
-	/* Restore decrementer */
-	wakeup_decrementer();
+	/*
+	 * Restore decrementer; we'll take a decrementer interrupt
+	 * as soon as interrupts are re-enabled and the generic
+	 * clockevents code will reprogram it with the right value.
+	 */
+	set_dec(1);
 
 	/* Restore interrupts */
  	mpic_cpu_set_priority(pic_prio);
-- 
1.7.1

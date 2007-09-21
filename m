Return-Path: <tony@bakeyournoodle.com>
Received: from pythia.bakeyournoodle.com (pythia.bakeyournoodle.com
	[203.82.209.197]) by ozlabs.org (Postfix) with ESMTP id AFAF8DDEB9
	for <linuxppc-dev@ozlabs.org>; Fri, 21 Sep 2007 13:28:10 +1000 (EST)
To: <linuxppc-dev@ozlabs.org>,
	Paul Mackerras <paulus@samba.org>
From: Tony Breeds <tony@bakeyournoodle.com>
Date: Fri, 21 Sep 2007 13:26:03 +1000
Subject: [PATCH v2 3/4] Implement clockevents driver for powerpc
In-Reply-To: <1190345162.620000.305760830507.qpush@thor>
Message-Id: <20070921032603.0D3EA32C887@thor>
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
Updated to remove a trivial FIXME left behind

 arch/powerpc/Kconfig       |    3 
 arch/powerpc/kernel/smp.c  |    3 
 arch/powerpc/kernel/time.c |  134 +++++++++++++++++++++++++------------
 include/asm-powerpc/time.h |    1 
 4 files changed, 98 insertions(+), 43 deletions(-)

Index: working/arch/powerpc/Kconfig
===================================================================
--- working.orig/arch/powerpc/Kconfig
+++ working/arch/powerpc/Kconfig
@@ -30,6 +30,9 @@ config GENERIC_TIME
 config GENERIC_TIME_VSYSCALL
 	def_bool y
 
+config GENERIC_CLOCKEVENTS
+	def_bool y
+
 config GENERIC_HARDIRQS
 	bool
 	default y
Index: working/arch/powerpc/kernel/smp.c
===================================================================
--- working.orig/arch/powerpc/kernel/smp.c
+++ working/arch/powerpc/kernel/smp.c
@@ -560,6 +560,8 @@ int __devinit start_secondary(void *unus
 	if (system_state > SYSTEM_BOOTING)
 		snapshot_timebase();
 
+	secondary_cpu_time_init();
+
 	spin_lock(&call_lock);
 	cpu_set(cpu, cpu_online_map);
 	spin_unlock(&call_lock);
Index: working/arch/powerpc/kernel/time.c
===================================================================
--- working.orig/arch/powerpc/kernel/time.c
+++ working/arch/powerpc/kernel/time.c
@@ -75,6 +75,7 @@
 
 /* powerpc clocksource/clockevent code */
 
+#include <linux/clockchips.h>
 #include <linux/clocksource.h>
 
 static cycle_t rtc_read(void);
@@ -99,6 +100,27 @@ static struct clocksource clocksource_ti
 	.read         = timebase_read,
 };
 
+#define DECREMENTER_MAX	0x7fffffff
+
+static int decrementer_set_next_event(unsigned long evt,
+				      struct clock_event_device *dev);
+static void decrementer_set_mode(enum clock_event_mode mode,
+				 struct clock_event_device *dev);
+
+static struct clock_event_device decrementer_clockevent = {
+       .name           = "decrementer",
+       .rating         = 200,
+       .shift          = 32,
+       .mult           = 0,	/* To be filled in */
+       .irq            = -1,
+       .set_next_event = decrementer_set_next_event,
+       .set_mode       = decrementer_set_mode,
+       .features       = CLOCK_EVT_FEAT_ONESHOT,
+};
+
+static DEFINE_PER_CPU(struct clock_event_device, decrementers);
+void init_decrementer_clockevent(void);
+
 #ifdef CONFIG_PPC_ISERIES
 static unsigned long __initdata iSeries_recal_titan;
 static signed long __initdata iSeries_recal_tb;
@@ -519,10 +541,12 @@ void __init iSeries_time_init_early(void
 void timer_interrupt(struct pt_regs * regs)
 {
 	struct pt_regs *old_regs;
-	int next_dec;
 	int cpu = smp_processor_id();
-	unsigned long ticks;
-	u64 tb_next_jiffy;
+	struct clock_event_device *evt = &per_cpu(decrementers, cpu);
+
+	/* Ensure a positive value is written to the decrementer, or else
+	 * some CPUs will continuue to take decrementer exceptions */
+	set_dec(DECREMENTER_MAX);
 
 #ifdef CONFIG_PPC32
 	if (atomic_read(&ppc_n_lost_interrupts) != 0)
@@ -532,7 +556,6 @@ void timer_interrupt(struct pt_regs * re
 	old_regs = set_irq_regs(regs);
 	irq_enter();
 
-	profile_tick(CPU_PROFILING);
 	calculate_steal_time();
 
 #ifdef CONFIG_PPC_ISERIES
@@ -540,44 +563,20 @@ void timer_interrupt(struct pt_regs * re
 		get_lppaca()->int_dword.fields.decr_int = 0;
 #endif
 
-	while ((ticks = tb_ticks_since(per_cpu(last_jiffy, cpu)))
-	       >= tb_ticks_per_jiffy) {
-		/* Update last_jiffy */
-		per_cpu(last_jiffy, cpu) += tb_ticks_per_jiffy;
-		/* Handle RTCL overflow on 601 */
-		if (__USE_RTC() && per_cpu(last_jiffy, cpu) >= 1000000000)
-			per_cpu(last_jiffy, cpu) -= 1000000000;
-
-		/*
-		 * We cannot disable the decrementer, so in the period
-		 * between this cpu's being marked offline in cpu_online_map
-		 * and calling stop-self, it is taking timer interrupts.
-		 * Avoid calling into the scheduler rebalancing code if this
-		 * is the case.
-		 */
-		if (!cpu_is_offline(cpu))
-			account_process_time(regs);
-
-		/*
-		 * No need to check whether cpu is offline here; boot_cpuid
-		 * should have been fixed up by now.
-		 */
-		if (cpu != boot_cpuid)
-			continue;
+	/*
+	 * We cannot disable the decrementer, so in the period
+	 * between this cpu's being marked offline in cpu_online_map
+	 * and calling stop-self, it is taking timer interrupts.
+	 * Avoid calling into the scheduler rebalancing code if this
+	 * is the case.
+	 */
+	if (!cpu_is_offline(cpu))
+		account_process_time(regs);
 
-		write_seqlock(&xtime_lock);
-		tb_next_jiffy = tb_last_jiffy + tb_ticks_per_jiffy;
-		if (__USE_RTC() && tb_next_jiffy >= 1000000000)
-			tb_next_jiffy -= 1000000000;
-		if (per_cpu(last_jiffy, cpu) >= tb_next_jiffy) {
-			tb_last_jiffy = tb_next_jiffy;
-			do_timer(1);
-		}
-		write_sequnlock(&xtime_lock);
-	}
-	
-	next_dec = tb_ticks_per_jiffy - ticks;
-	set_dec(next_dec);
+	if (evt->event_handler)
+		evt->event_handler(evt);
+	else
+		evt->set_next_event(DECREMENTER_MAX, evt);
 
 #ifdef CONFIG_PPC_ISERIES
 	if (firmware_has_feature(FW_FEATURE_ISERIES) && hvlpevent_is_pending())
@@ -797,6 +796,53 @@ void __init clocksource_init(void)
 	       clock->name, clock->mult, clock->shift);
 }
 
+static int decrementer_set_next_event(unsigned long evt,
+				      struct clock_event_device *dev)
+{
+	set_dec(evt);
+	return 0;
+}
+
+static void decrementer_set_mode(enum clock_event_mode mode,
+				 struct clock_event_device *dev)
+{
+	if (mode != CLOCK_EVT_MODE_ONESHOT)
+		decrementer_set_next_event(DECREMENTER_MAX, dev);
+}
+
+static void register_decrementer_clockevent(int cpu)
+{
+	struct clock_event_device *dec = &per_cpu(decrementers, cpu);
+
+	*dec = decrementer_clockevent;
+	dec->cpumask = cpumask_of_cpu(cpu);
+
+	printk(KERN_ERR "clockevent: %s mult[%lx] shift[%d] cpu[%d]\n",
+	       dec->name, dec->mult, dec->shift, cpu);
+
+	clockevents_register_device(dec);
+}
+
+void init_decrementer_clockevent(void)
+{
+	int cpu = smp_processor_id();
+
+	decrementer_clockevent.mult = div_sc(ppc_tb_freq, NSEC_PER_SEC,
+					     decrementer_clockevent.shift);
+	decrementer_clockevent.max_delta_ns =
+		clockevent_delta2ns(DECREMENTER_MAX, &decrementer_clockevent);
+	decrementer_clockevent.min_delta_ns = 1000;
+
+	register_decrementer_clockevent(cpu);
+}
+
+void secondary_cpu_time_init(void)
+{
+	/* FIME: Should make unrelatred change to move snapshot_timebase
+	 * call here ! */
+	register_decrementer_clockevent(smp_processor_id());
+}
+
 /* This function is only called on the boot processor */
 void __init time_init(void)
 {
@@ -912,8 +958,7 @@ void __init time_init(void)
 #endif
 		clocksource_init();
 
-	/* Not exact, but the timer interrupt takes care of this */
-	set_dec(tb_ticks_per_jiffy);
+	init_decrementer_clockevent();
 }
 
 
Index: working/include/asm-powerpc/time.h
===================================================================
--- working.orig/include/asm-powerpc/time.h
+++ working/include/asm-powerpc/time.h
@@ -245,6 +245,7 @@ extern void snapshot_timebases(void);
 #define snapshot_timebases()			do { } while (0)
 #endif
 
+extern void secondary_cpu_time_init(void);
 extern void iSeries_time_init_early(void);
 
 #endif /* __KERNEL__ */

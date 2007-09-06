Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <18144.4702.673658.336384@cargo.ozlabs.ibm.com>
Date: Fri, 7 Sep 2007 00:44:46 +1000
From: Paul Mackerras <paulus@samba.org>
To: linuxppc-dev@ozlabs.org
Subject: [RFC/PATCH 2/2] Generic clockevents and no-idle-HZ for PowerPC
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This creates a clockevent for the PowerPC decrementer and registers it
with the generic clock/timer system, and implements the dynamic ticks
(no idle HZ) option for PowerPC.

This is based largely on an earlier patch by Tony Breeds.  It could
still use more cleanup.  This and the previous patch seem to be
working fine on my G4 powerbook (ppc32).

Signed-off-by: Paul Mackerras <paulus@samba.org>
---
diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index ebecc85..9a4fac2 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -27,6 +27,9 @@ config GENERIC_TIME
 config GENERIC_TIME_VSYSCALL
 	def_bool y
 
+config GENERIC_CLOCKEVENTS
+	def_bool y
+
 config GENERIC_HARDIRQS
 	bool
 	default y
@@ -162,6 +165,7 @@ config HIGHMEM
 	bool "High memory support"
 	depends on PPC32
 
+source kernel/time/Kconfig
 source kernel/Kconfig.hz
 source kernel/Kconfig.preempt
 source "fs/Kconfig.binfmt"
diff --git a/arch/powerpc/kernel/asm-offsets.c b/arch/powerpc/kernel/asm-offsets.c
index a408053..b2bb50b 100644
--- a/arch/powerpc/kernel/asm-offsets.c
+++ b/arch/powerpc/kernel/asm-offsets.c
@@ -307,7 +307,6 @@ int main(void)
 	DEFINE(CLOCK_REALTIME, CLOCK_REALTIME);
 	DEFINE(CLOCK_MONOTONIC, CLOCK_MONOTONIC);
 	DEFINE(NSEC_PER_SEC, NSEC_PER_SEC);
-	DEFINE(CLOCK_REALTIME_RES, TICK_NSEC);
 
 #ifdef CONFIG_BUG
 	DEFINE(BUG_ENTRY_SIZE, sizeof(struct bug_entry));
diff --git a/arch/powerpc/kernel/idle.c b/arch/powerpc/kernel/idle.c
index a9e9cbd..abd2957 100644
--- a/arch/powerpc/kernel/idle.c
+++ b/arch/powerpc/kernel/idle.c
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
 
@@ -90,6 +92,7 @@ void cpu_idle(void)
 
 		HMT_medium();
 		ppc64_runlatch_on();
+		tick_nohz_restart_sched_tick();
 		if (cpu_should_die())
 			cpu_die();
 		preempt_enable_no_resched();
diff --git a/arch/powerpc/kernel/smp.c b/arch/powerpc/kernel/smp.c
index 1ea4316..1118c2d 100644
--- a/arch/powerpc/kernel/smp.c
+++ b/arch/powerpc/kernel/smp.c
@@ -560,6 +560,9 @@ int __devinit start_secondary(void *unused)
 	if (system_state > SYSTEM_BOOTING)
 		snapshot_timebase();
 
+	/* FIXME: should be in if() above */
+	secondary_cpu_time_init();
+
 	spin_lock(&call_lock);
 	cpu_set(cpu, cpu_online_map);
 	spin_unlock(&call_lock);
diff --git a/arch/powerpc/kernel/time.c b/arch/powerpc/kernel/time.c
index 7e960a2..1353d73 100644
--- a/arch/powerpc/kernel/time.c
+++ b/arch/powerpc/kernel/time.c
@@ -78,12 +78,31 @@
 /* TODO:
  *  o Code style
  *    * Variable names ... be consistent.
+ *      - decrementers => events
+ *      - evt == an event source
+ *      - clc == a tb_tick to fire at
+ *      - jiffies  is related to HZ
+ *      - tb_jiffies/tick are releted to the timebase
+ *  o test on PPC32 and other platforms
+ *  o determine compatability with VIRT_CPU_ACCOUNTING
+ *  o Seperate out into other files.
+ *  o Startup, it's ugly, make sure a return value is appropriate
+ *  o HOTPLUG_CPU safe!
+ *    * revmoval / addition.
  *
  * TODO: Clocksource
  *  o iSeries registation and matching it with the titan-recalibrate
- *  o xtime:  Either time.c manages it, or clocksource does, not both
+ *  o Create clocksources for each of the platforms, and store in
+ *    appropriate place
+ *
+ * TODO: Clockevents
+ *  o Create clockevents for each of the platforms, and store in
+ *    appropriate place
+ *  o CPU Hotplug
+ *  o "fair" machanisim for distributing do_timer() updates.
  */
 
+#include <linux/clockchips.h>
 #include <linux/clocksource.h>
 
 static struct clocksource clocksource_timebase = {
@@ -96,6 +115,25 @@ static struct clocksource clocksource_timebase = {
 	.read         = NULL,   /* To be filled in */
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
+static DEFINE_PER_CPU(struct clock_event_device, decrementers);
+
 #ifdef CONFIG_PPC_ISERIES
 static unsigned long __initdata iSeries_recal_titan;
 static signed long __initdata iSeries_recal_tb;
@@ -436,7 +474,6 @@ static int __init iSeries_tb_recal(void)
 {
 	struct div_result divres;
 	unsigned long titan, tb;
-	u64 tb_to_xs;
 
 	/* Make sure we only run on iSeries */
 	if (!firmware_has_feature(FW_FEATURE_ISERIES))
@@ -512,10 +549,10 @@ void __init iSeries_time_init_early(void)
 void timer_interrupt(struct pt_regs * regs)
 {
 	struct pt_regs *old_regs;
-	int next_dec;
 	int cpu = smp_processor_id();
 	unsigned long ticks;
 	u64 tb_next_jiffy;
+	struct clock_event_device *evt = &per_cpu(decrementers, cpu);
 
 #ifdef CONFIG_PPC32
 	if (atomic_read(&ppc_n_lost_interrupts) != 0)
@@ -525,7 +562,6 @@ void timer_interrupt(struct pt_regs * regs)
 	old_regs = set_irq_regs(regs);
 	irq_enter();
 
-	profile_tick(CPU_PROFILING);
 	calculate_steal_time();
 
 #ifdef CONFIG_PPC_ISERIES
@@ -533,42 +569,10 @@ void timer_interrupt(struct pt_regs * regs)
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
-
-		write_seqlock(&xtime_lock);
-		tb_next_jiffy = tb_last_jiffy + tb_ticks_per_jiffy;
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
@@ -702,6 +706,11 @@ unsigned long get_boot_time(void)
 		      tm.tm_hour, tm.tm_min, tm.tm_sec);
 }
 
+unsigned long read_persistent_clock(void)
+{
+	return get_boot_time();
+}
+
 /* clocksource code */
 static cycle_t timebase_read(void)
 {
@@ -710,6 +719,53 @@ static cycle_t timebase_read(void)
 	return (cycle_t)get_tb();
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
 void update_vsyscall(struct timespec *wall_time, struct clocksource *clock)
 {
 	u64 t2x, stamp_xsec;
@@ -749,6 +805,8 @@ void __init clocksource_init(void)
 	printk(KERN_INFO "clocksource: %s mult[%x] shift[%d] registered\n",
 	       clocksource_timebase.name,
 	       clocksource_timebase.mult, clocksource_timebase.shift);
+
+	init_decrementer_clockevent();
 }
 
 /* This function is only called on the boot processor */
@@ -874,8 +932,7 @@ void __init time_init(void)
 	/* Register the clocksource */
 	clocksource_init();
 
-	/* Not exact, but the timer interrupt takes care of this */
-	set_dec(tb_ticks_per_jiffy);
+	set_dec(DECREMENTER_MAX);
 }
 
 
diff --git a/arch/powerpc/kernel/vdso32/gettimeofday.S b/arch/powerpc/kernel/vdso32/gettimeofday.S
index 72ca26d..c007658 100644
--- a/arch/powerpc/kernel/vdso32/gettimeofday.S
+++ b/arch/powerpc/kernel/vdso32/gettimeofday.S
@@ -225,8 +225,7 @@ V_FUNCTION_BEGIN(__kernel_clock_getres)
 	cmpli	cr0,r4,0
 	crclr	cr0*4+so
 	beqlr
-	lis	r5,CLOCK_REALTIME_RES@h
-	ori	r5,r5,CLOCK_REALTIME_RES@l
+	li	r5,1
 	stw	r3,TSPC32_TV_SEC(r4)
 	stw	r5,TSPC32_TV_NSEC(r4)
 	blr
diff --git a/arch/powerpc/kernel/vdso64/gettimeofday.S b/arch/powerpc/kernel/vdso64/gettimeofday.S
index c6401f9..7d16ddb 100644
--- a/arch/powerpc/kernel/vdso64/gettimeofday.S
+++ b/arch/powerpc/kernel/vdso64/gettimeofday.S
@@ -198,8 +198,7 @@ V_FUNCTION_BEGIN(__kernel_clock_getres)
 	cmpli	cr0,r4,0
 	crclr	cr0*4+so
 	beqlr
-	lis	r5,CLOCK_REALTIME_RES@h
-	ori	r5,r5,CLOCK_REALTIME_RES@l
+	li	r5,1
 	std	r3,TSPC64_TV_SEC(r4)
 	std	r5,TSPC64_TV_NSEC(r4)
 	blr
diff --git a/arch/powerpc/platforms/iseries/setup.c b/arch/powerpc/platforms/iseries/setup.c
index fad493e..6f27db4 100644
--- a/arch/powerpc/platforms/iseries/setup.c
+++ b/arch/powerpc/platforms/iseries/setup.c
@@ -26,6 +26,7 @@
 #include <linux/major.h>
 #include <linux/root_dev.h>
 #include <linux/kernel.h>
+#include <linux/tick.h>
 
 #include <asm/processor.h>
 #include <asm/machdep.h>
@@ -561,6 +562,7 @@ static void yield_shared_processor(void)
 static void iseries_shared_idle(void)
 {
 	while (1) {
+		tick_nohz_stop_sched_tick();
 		while (!need_resched() && !hvlpevent_is_pending()) {
 			local_irq_disable();
 			ppc64_runlatch_off();
@@ -574,6 +576,7 @@ static void iseries_shared_idle(void)
 		}
 
 		ppc64_runlatch_on();
+		tick_nohz_restart_sched_tick();
 
 		if (hvlpevent_is_pending())
 			process_iSeries_events();
@@ -589,6 +592,7 @@ static void iseries_dedicated_idle(void)
 	set_thread_flag(TIF_POLLING_NRFLAG);
 
 	while (1) {
+		tick_nohz_stop_sched_tick();
 		if (!need_resched()) {
 			while (!need_resched()) {
 				ppc64_runlatch_off();
@@ -605,6 +609,7 @@ static void iseries_dedicated_idle(void)
 		}
 
 		ppc64_runlatch_on();
+		tick_nohz_restart_sched_tick();
 		preempt_enable_no_resched();
 		schedule();
 		preempt_disable();
diff --git a/arch/powerpc/sysdev/Makefile b/arch/powerpc/sysdev/Makefile
index 08ce31e..3b289cf 100644
--- a/arch/powerpc/sysdev/Makefile
+++ b/arch/powerpc/sysdev/Makefile
@@ -20,11 +20,6 @@ obj-$(CONFIG_MV64X60)		+= $(mv64x60-y) mv64x60_pic.o mv64x60_dev.o
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
diff --git a/include/asm-powerpc/time.h b/include/asm-powerpc/time.h
index fdc271e..f9d9abb 100644
--- a/include/asm-powerpc/time.h
+++ b/include/asm-powerpc/time.h
@@ -240,6 +240,7 @@ extern void snapshot_timebases(void);
 #define snapshot_timebases()			do { } while (0)
 #endif
 
+extern void secondary_cpu_time_init(void);
 extern void iSeries_time_init_early(void);
 
 #endif /* __KERNEL__ */

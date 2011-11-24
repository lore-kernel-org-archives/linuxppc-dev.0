Return-Path: <anton@samba.org>
Message-Id: <20111124060847.560807579@samba.org>
Date: Thu, 24 Nov 2011 17:07:22 +1100
From: Anton Blanchard <anton@samba.org>
To: benh@kernel.crashing.org, paulus@samba.org, johnstul@us.ibm.com,
 miltonm@bga.com
Subject: [PATCH 6/6] powerpc/time: Optimise decrementer_check_overflow
References: <20111124060716.362614789@samba.org>
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

decrementer_check_overflow is called from arch_local_irq_restore so
we want to make it as light weight as possible. As such, turn
decrementer_check_overflow into an inline function.

To avoid a circular mess of includes, separate out the two components
of struct decrementer_clock and keep the struct clock_event_device
part local to time.c.

The fast path improves from:

arch_local_irq_restore
     0:       mflr    r0
     4:       std     r0,16(r1)
     8:       stdu    r1,-112(r1)
     c:       stb     r3,578(r13)
    10:       cmpdi   cr7,r3,0
    14:       beq-    cr7,24 <.arch_local_irq_restore+0x24>
...
    24:       addi    r1,r1,112
    28:       ld      r0,16(r1)
    2c:       mtlr    r0
    30:       blr

to:

arch_local_irq_restore
    0:       std     r30,-16(r1)
    4:       ld      r30,0(r2)
    8:       stb     r3,578(r13)
    c:       cmpdi   cr7,r3,0
   10:       beq-    cr7,6c <.arch_local_irq_restore+0x6c>
...
   6c:       ld      r30,-16(r1)
   70:       blr

Unfortunately we still setup a local TOC (due to -mminimal-toc). Yet
another sign we should be moving to -mcmodel=medium.

Signed-off-by: Anton Blanchard <anton@samba.org>
---

Index: linux-build/arch/powerpc/kernel/time.c
===================================================================
--- linux-build.orig/arch/powerpc/kernel/time.c	2011-11-17 13:07:26.638774436 +1100
+++ linux-build/arch/powerpc/kernel/time.c	2011-11-17 13:13:22.409001783 +1100
@@ -114,12 +114,8 @@ static struct clock_event_device decreme
 	.features	= CLOCK_EVT_FEAT_ONESHOT,
 };
 
-struct decrementer_clock {
-	struct clock_event_device event;
-	u64 next_tb;
-};
-
-static DEFINE_PER_CPU(struct decrementer_clock, decrementers);
+DEFINE_PER_CPU(u64, decrementers_next_tb);
+static DEFINE_PER_CPU(struct clock_event_device, decrementers);
 
 #ifdef CONFIG_PPC_ISERIES
 static unsigned long __initdata iSeries_recal_titan;
@@ -570,8 +566,8 @@ void arch_irq_work_raise(void)
 void timer_interrupt(struct pt_regs * regs)
 {
 	struct pt_regs *old_regs;
-	struct decrementer_clock *decrementer =  &__get_cpu_var(decrementers);
-	struct clock_event_device *evt = &decrementer->event;
+	u64 *next_tb = &__get_cpu_var(decrementers_next_tb);
+	struct clock_event_device *evt = &__get_cpu_var(decrementers);
 
 	/* Ensure a positive value is written to the decrementer, or else
 	 * some CPUs will continue to take decrementer exceptions.
@@ -606,7 +602,7 @@ void timer_interrupt(struct pt_regs * re
 		get_lppaca()->int_dword.fields.decr_int = 0;
 #endif
 
-	decrementer->next_tb = ~(u64)0;
+	*next_tb = ~(u64)0;
 	if (evt->event_handler)
 		evt->event_handler(evt);
 
@@ -872,19 +868,10 @@ static void __init clocksource_init(void
 	       clock->name, clock->mult, clock->shift);
 }
 
-void decrementer_check_overflow(void)
-{
-	u64 now = get_tb_or_rtc();
-	struct decrementer_clock *decrementer = &__get_cpu_var(decrementers);
-
-	if (now >= decrementer->next_tb)
-		set_dec(1);
-}
-
 static int decrementer_set_next_event(unsigned long evt,
 				      struct clock_event_device *dev)
 {
-	__get_cpu_var(decrementers).next_tb = get_tb_or_rtc() + evt;
+	__get_cpu_var(decrementers_next_tb) = get_tb_or_rtc() + evt;
 	set_dec(evt);
 	return 0;
 }
@@ -898,7 +885,7 @@ static void decrementer_set_mode(enum cl
 
 static void register_decrementer_clockevent(int cpu)
 {
-	struct clock_event_device *dec = &per_cpu(decrementers, cpu).event;
+	struct clock_event_device *dec = &per_cpu(decrementers, cpu);
 
 	*dec = decrementer_clockevent;
 	dec->cpumask = cpumask_of(cpu);
Index: linux-build/arch/powerpc/include/asm/time.h
===================================================================
--- linux-build.orig/arch/powerpc/include/asm/time.h	2011-11-17 13:07:30.438840750 +1100
+++ linux-build/arch/powerpc/include/asm/time.h	2011-11-17 13:13:05.492705459 +1100
@@ -219,7 +219,7 @@ DECLARE_PER_CPU(struct cpu_usage, cpu_us
 extern void secondary_cpu_time_init(void);
 extern void iSeries_time_init_early(void);
 
-extern void decrementer_check_overflow(void);
+DECLARE_PER_CPU(u64, decrementers_next_tb);
 
 #endif /* __KERNEL__ */
 #endif /* __POWERPC_TIME_H */
Index: linux-build/arch/powerpc/kernel/irq.c
===================================================================
--- linux-build.orig/arch/powerpc/kernel/irq.c	2011-11-17 13:07:26.662774855 +1100
+++ linux-build/arch/powerpc/kernel/irq.c	2011-11-17 13:15:02.038747391 +1100
@@ -115,6 +115,15 @@ static inline notrace void set_soft_enab
 	: : "r" (enable), "i" (offsetof(struct paca_struct, soft_enabled)));
 }
 
+static inline notrace void decrementer_check_overflow(void)
+{
+	u64 now = get_tb_or_rtc();
+	u64 *next_tb = &__get_cpu_var(decrementers_next_tb);
+
+	if (now >= *next_tb)
+		set_dec(1);
+}
+
 notrace void arch_local_irq_restore(unsigned long en)
 {
 	/*

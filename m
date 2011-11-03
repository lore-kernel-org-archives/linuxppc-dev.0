Return-Path: <anton@samba.org>
Message-Id: <20111103010112.033075296@samba.org>
Date: Thu, 03 Nov 2011 11:59:25 +1100
From: Anton Blanchard <anton@samba.org>
To: benh@kernel.crashing.org,
 paulus@samba.org,
 johnstul@us.ibm.com
Subject: [PATCH 3/4] powerpc/time: Remove unnecessary sanity check of
 decrementer expiration
References: <20111103005922.854058953@samba.org>
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The clockevents code uses max_delta_ns to avoid calling a clockevent
with too large a value.

Remove the redundant version of this in the timer_interrupt code.

Signed-off-by: Anton Blanchard <anton@samba.org>
---

Index: linux-build/arch/powerpc/kernel/time.c
===================================================================
--- linux-build.orig/arch/powerpc/kernel/time.c	2011-11-03 10:20:00.965704053 +1100
+++ linux-build/arch/powerpc/kernel/time.c	2011-11-03 10:20:02.117723634 +1100
@@ -114,12 +114,7 @@ static struct clock_event_device decreme
        .features       = CLOCK_EVT_FEAT_ONESHOT,
 };
 
-struct decrementer_clock {
-	struct clock_event_device event;
-	u64 next_tb;
-};
-
-static DEFINE_PER_CPU(struct decrementer_clock, decrementers);
+static DEFINE_PER_CPU(struct clock_event_device, decrementers);
 
 #ifdef CONFIG_PPC_ISERIES
 static unsigned long __initdata iSeries_recal_titan;
@@ -570,9 +565,7 @@ void arch_irq_work_raise(void)
 void timer_interrupt(struct pt_regs * regs)
 {
 	struct pt_regs *old_regs;
-	struct decrementer_clock *decrementer =  &__get_cpu_var(decrementers);
-	struct clock_event_device *evt = &decrementer->event;
-	u64 now;
+	struct clock_event_device *evt = &__get_cpu_var(decrementers);
 
 	/* Ensure a positive value is written to the decrementer, or else
 	 * some CPUs will continue to take decrementer exceptions.
@@ -607,16 +600,7 @@ void timer_interrupt(struct pt_regs * re
 		get_lppaca()->int_dword.fields.decr_int = 0;
 #endif
 
-	now = get_tb_or_rtc();
-	if (now >= decrementer->next_tb) {
-		decrementer->next_tb = ~(u64)0;
-		if (evt->event_handler)
-			evt->event_handler(evt);
-	} else {
-		now = decrementer->next_tb - now;
-		if (now <= DECREMENTER_MAX)
-			set_dec((int)now);
-	}
+	evt->event_handler(evt);
 
 #ifdef CONFIG_PPC_ISERIES
 	if (firmware_has_feature(FW_FEATURE_ISERIES) && hvlpevent_is_pending())
@@ -884,7 +868,6 @@ static void __init clocksource_init(void
 static int decrementer_set_next_event(unsigned long evt,
 				      struct clock_event_device *dev)
 {
-	__get_cpu_var(decrementers).next_tb = get_tb_or_rtc() + evt;
 	set_dec(evt);
 	return 0;
 }
@@ -898,7 +881,7 @@ static void decrementer_set_mode(enum cl
 
 static void register_decrementer_clockevent(int cpu)
 {
-	struct clock_event_device *dec = &per_cpu(decrementers, cpu).event;
+	struct clock_event_device *dec = &per_cpu(decrementers, cpu);
 
 	*dec = decrementer_clockevent;
 	dec->cpumask = cpumask_of(cpu);

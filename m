Return-Path: <miltonm@sullivan.realtime.net>
Received: from sullivan.realtime.net (sullivan.realtime.net [205.238.132.226])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 548F1DE039
	for <linuxppc-dev@ozlabs.org>; Fri, 14 Dec 2007 15:52:22 +1100 (EST)
Date: Thu, 13 Dec 2007 22:52:15 -0600 (CST)
From: Milton Miller <miltonm@bga.com>
Sender: Milton Miller <miltonm@realtime.net>
To: Paul Mackerras <paulus@samba.org>
Subject: [PATCH 4/6] timer interrupt: use a struct for two per_cpu varables
In-Reply-To: <mm-cpu-0@bga.com>
Message-Id: <mm-cpu-4@bga.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

timer_interrupt was calculating per_cpu_offset several times, having to
start from the toc because of potential aliasing issues.

Placing both decrementer per_cpu varables in a struct and calculating
the address once with __get_cpu_var results in better code on both 32
and 64 bit.

Signed-off-by: Milton Miller <miltonm@bga.com>
---
Index: kernel/arch/powerpc/kernel/time.c
===================================================================
--- kernel.orig/arch/powerpc/kernel/time.c	2007-12-13 17:56:37.000000000 -0600
+++ kernel/arch/powerpc/kernel/time.c	2007-12-13 18:07:13.000000000 -0600
@@ -116,8 +116,12 @@ static struct clock_event_device decreme
        .features       = CLOCK_EVT_FEAT_ONESHOT,
 };
 
-static DEFINE_PER_CPU(struct clock_event_device, decrementers);
-static DEFINE_PER_CPU(u64, decrementer_next_tb);
+struct decrementer_clock {
+	struct clock_event_device event;
+	u64 next_tb;
+};
+
+static DEFINE_PER_CPU(struct decrementer_clock, decrementers);
 
 #ifdef CONFIG_PPC_ISERIES
 static unsigned long __initdata iSeries_recal_titan;
@@ -555,8 +559,8 @@ void __init iSeries_time_init_early(void
 void timer_interrupt(struct pt_regs * regs)
 {
 	struct pt_regs *old_regs;
-	int cpu = smp_processor_id();
-	struct clock_event_device *evt = &per_cpu(decrementers, cpu);
+	struct decrementer_clock *decrementer =  &__get_cpu_var(decrementers);
+	struct clock_event_device *evt = &decrementer->event;
 	u64 now;
 
 	/* Ensure a positive value is written to the decrementer, or else
@@ -569,9 +573,9 @@ void timer_interrupt(struct pt_regs * re
 #endif
 
 	now = get_tb_or_rtc();
-	if (now < per_cpu(decrementer_next_tb, cpu)) {
+	if (now < decrementer->next_tb) {
 		/* not time for this event yet */
-		now = per_cpu(decrementer_next_tb, cpu) - now;
+		now = decrementer->next_tb - now;
 		if (now <= DECREMENTER_MAX)
 			set_dec((int)now);
 		return;
@@ -810,7 +814,7 @@ void __init clocksource_init(void)
 static int decrementer_set_next_event(unsigned long evt,
 				      struct clock_event_device *dev)
 {
-	__get_cpu_var(decrementer_next_tb) = get_tb_or_rtc() + evt;
+	__get_cpu_var(decrementers).next_tb = get_tb_or_rtc() + evt;
 	set_dec(evt);
 	return 0;
 }
@@ -824,7 +828,7 @@ static void decrementer_set_mode(enum cl
 
 static void register_decrementer_clockevent(int cpu)
 {
-	struct clock_event_device *dec = &per_cpu(decrementers, cpu);
+	struct clock_event_device *dec = &per_cpu(decrementers, cpu).event;
 
 	*dec = decrementer_clockevent;
 	dec->cpumask = cpumask_of_cpu(cpu);

Return-Path: <npiggin@gmail.com>
Received: from mail-pf0-x242.google.com (mail-pf0-x242.google.com
 [IPv6:2607:f8b0:400e:c00::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40B2cl0TFSzF2KV
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 28 Mar 2018 20:28:38 +1100 (AEDT)
Received: by mail-pf0-x242.google.com with SMTP id q9so759475pff.1
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 28 Mar 2018 02:28:38 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 "Srivatsa S . Bhat" <srivatsa.bhat@linux.vnet.ibm.com>,
 Preeti U Murthy <preeti@linux.vnet.ibm.com>
Subject: [PATCH 3/5] powerpc: clockevents broadcast receiver use
 tick_receive_broadcast
Date: Wed, 28 Mar 2018 19:28:17 +1000
Message-Id: <20180328092819.27015-4-npiggin@gmail.com>
In-Reply-To: <20180328092819.27015-1-npiggin@gmail.com>
References: <20180328092819.27015-1-npiggin@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The broadcast tick recipient can call tick_receive_broadcast rather
than re-running the full timer interrupt.

It does not not have to check for the next event time, because the
sender already determined the timer has expired. It does not have to
test irq_work_pending, because that's a direct decrementer interrupt
and does not go through the clock events subsystem.

This results in no code size change, but both the decrementer and
broadcast path lengths are reduced.

Cc: Srivatsa S. Bhat <srivatsa.bhat@linux.vnet.ibm.com>
Cc: Preeti U Murthy <preeti@linux.vnet.ibm.com>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 arch/powerpc/include/asm/hw_irq.h |  1 +
 arch/powerpc/include/asm/time.h   |  1 -
 arch/powerpc/kernel/smp.c         |  4 +-
 arch/powerpc/kernel/time.c        | 84 ++++++++++++++++++---------------------
 4 files changed, 42 insertions(+), 48 deletions(-)

diff --git a/arch/powerpc/include/asm/hw_irq.h b/arch/powerpc/include/asm/hw_irq.h
index 855e17d158b1..dcdb95a13c47 100644
--- a/arch/powerpc/include/asm/hw_irq.h
+++ b/arch/powerpc/include/asm/hw_irq.h
@@ -55,6 +55,7 @@ extern void replay_system_reset(void);
 extern void __replay_interrupt(unsigned int vector);
 
 extern void timer_interrupt(struct pt_regs *);
+extern void timer_broadcast_interrupt(void);
 extern void performance_monitor_exception(struct pt_regs *regs);
 extern void WatchdogException(struct pt_regs *regs);
 extern void unknown_exception(struct pt_regs *regs);
diff --git a/arch/powerpc/include/asm/time.h b/arch/powerpc/include/asm/time.h
index c965c79765c4..69b89f941252 100644
--- a/arch/powerpc/include/asm/time.h
+++ b/arch/powerpc/include/asm/time.h
@@ -28,7 +28,6 @@ extern struct clock_event_device decrementer_clockevent;
 
 struct rtc_time;
 extern void to_tm(int tim, struct rtc_time * tm);
-extern void tick_broadcast_ipi_handler(void);
 
 extern void generic_calibrate_decr(void);
 extern void hdec_interrupt(struct pt_regs *regs);
diff --git a/arch/powerpc/kernel/smp.c b/arch/powerpc/kernel/smp.c
index bbe7634b3a43..de5ac63b4ad6 100644
--- a/arch/powerpc/kernel/smp.c
+++ b/arch/powerpc/kernel/smp.c
@@ -157,7 +157,7 @@ static irqreturn_t reschedule_action(int irq, void *data)
 
 static irqreturn_t tick_broadcast_ipi_action(int irq, void *data)
 {
-	tick_broadcast_ipi_handler();
+	timer_broadcast_interrupt();
 	return IRQ_HANDLED;
 }
 
@@ -278,7 +278,7 @@ irqreturn_t smp_ipi_demux_relaxed(void)
 		if (all & IPI_MESSAGE(PPC_MSG_RESCHEDULE))
 			scheduler_ipi();
 		if (all & IPI_MESSAGE(PPC_MSG_TICK_BROADCAST))
-			tick_broadcast_ipi_handler();
+			timer_broadcast_interrupt();
 #ifdef CONFIG_NMI_IPI
 		if (all & IPI_MESSAGE(PPC_MSG_NMI_IPI))
 			nmi_ipi_action(0, NULL);
diff --git a/arch/powerpc/kernel/time.c b/arch/powerpc/kernel/time.c
index 3e531ab4e836..199f330e8f01 100644
--- a/arch/powerpc/kernel/time.c
+++ b/arch/powerpc/kernel/time.c
@@ -535,47 +535,16 @@ void arch_irq_work_raise(void)
 
 #endif /* CONFIG_IRQ_WORK */
 
-static void __timer_interrupt(void)
-{
-	struct pt_regs *regs = get_irq_regs();
-	u64 *next_tb = this_cpu_ptr(&decrementers_next_tb);
-	struct clock_event_device *evt = this_cpu_ptr(&decrementers);
-	u64 now;
-
-	trace_timer_interrupt_entry(regs);
-
-	if (test_irq_work_pending()) {
-		clear_irq_work_pending();
-		irq_work_run();
-	}
-
-	now = get_tb_or_rtc();
-	if (now >= *next_tb) {
-		*next_tb = ~(u64)0;
-		if (evt->event_handler)
-			evt->event_handler(evt);
-		__this_cpu_inc(irq_stat.timer_irqs_event);
-	} else {
-		now = *next_tb - now;
-		if (now <= decrementer_max)
-			set_dec(now);
-		/* We may have raced with new irq work */
-		if (test_irq_work_pending())
-			set_dec(1);
-		__this_cpu_inc(irq_stat.timer_irqs_others);
-	}
-
-	trace_timer_interrupt_exit(regs);
-}
-
 /*
  * timer_interrupt - gets called when the decrementer overflows,
  * with interrupts disabled.
  */
-void timer_interrupt(struct pt_regs * regs)
+void timer_interrupt(struct pt_regs *regs)
 {
-	struct pt_regs *old_regs;
+	struct clock_event_device *evt = this_cpu_ptr(&decrementers);
 	u64 *next_tb = this_cpu_ptr(&decrementers_next_tb);
+	struct pt_regs *old_regs;
+	u64 now;
 
 	/* Ensure a positive value is written to the decrementer, or else
 	 * some CPUs will continue to take decrementer exceptions.
@@ -606,13 +575,47 @@ void timer_interrupt(struct pt_regs * regs)
 
 	old_regs = set_irq_regs(regs);
 	irq_enter();
+	trace_timer_interrupt_entry(regs);
+
+	if (test_irq_work_pending()) {
+		clear_irq_work_pending();
+		irq_work_run();
+	}
+
+	now = get_tb_or_rtc();
+	if (now >= *next_tb) {
+		*next_tb = ~(u64)0;
+		if (evt->event_handler)
+			evt->event_handler(evt);
+		__this_cpu_inc(irq_stat.timer_irqs_event);
+	} else {
+		now = *next_tb - now;
+		if (now <= decrementer_max)
+			set_dec(now);
+		/* We may have raced with new irq work */
+		if (test_irq_work_pending())
+			set_dec(1);
+		__this_cpu_inc(irq_stat.timer_irqs_others);
+	}
 
-	__timer_interrupt();
+	trace_timer_interrupt_exit(regs);
 	irq_exit();
 	set_irq_regs(old_regs);
 }
 EXPORT_SYMBOL(timer_interrupt);
 
+void timer_broadcast_interrupt(void)
+{
+	u64 *next_tb = this_cpu_ptr(&decrementers_next_tb);
+	struct pt_regs *regs = get_irq_regs();
+
+	trace_timer_interrupt_entry(regs);
+	*next_tb = ~(u64)0;
+	tick_receive_broadcast();
+	__this_cpu_inc(irq_stat.timer_irqs_event);
+	trace_timer_interrupt_exit(regs);
+}
+
 /*
  * Hypervisor decrementer interrupts shouldn't occur but are sometimes
  * left pending on exit from a KVM guest.  We don't need to do anything
@@ -960,15 +963,6 @@ static int decrementer_shutdown(struct clock_event_device *dev)
 	return 0;
 }
 
-/* Interrupt handler for the timer broadcast IPI */
-void tick_broadcast_ipi_handler(void)
-{
-	u64 *next_tb = this_cpu_ptr(&decrementers_next_tb);
-
-	*next_tb = get_tb_or_rtc();
-	__timer_interrupt();
-}
-
 static void register_decrementer_clockevent(int cpu)
 {
 	struct clock_event_device *dec = &per_cpu(decrementers, cpu);
-- 
2.16.1

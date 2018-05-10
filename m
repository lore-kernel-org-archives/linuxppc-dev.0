Return-Path: <npiggin@gmail.com>
Received: from mail-pf0-x241.google.com (mail-pf0-x241.google.com
 [IPv6:2607:f8b0:400e:c00::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40hg360MjdzF29N
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 11 May 2018 03:20:17 +1000 (AEST)
Received: by mail-pf0-x241.google.com with SMTP id v63-v6so1383655pfk.8
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 10 May 2018 10:20:17 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 Alistair Popple <alistair@popple.id.au>
Subject: [PATCH] powerpc/powernv: process all OPAL event interrupts with kopald
Date: Fri, 11 May 2018 03:20:05 +1000
Message-Id: <20180510172005.27160-1-npiggin@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Using irq_work for processing OPAL event interrupts is not necessary.
irq_work is typically used to schedule work from NMI context, a
softirq may be more appropriate. However OPAL events are not
particularly performance or latency critical, so they can all be
invoked by kopald.

This patch removes the irq_work queueing, and instead wakes up
kopald when there is an event to be processed. kopald processes
interrupts individually, enabling irqs and calling cond_resched
between each one to minimise latencies.

Event handlers themselves should still use threaded handlers,
workqueues, etc. as necessary to avoid high interrupts-off latencies
within any single interrupt.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 arch/powerpc/platforms/powernv/opal-irqchip.c | 87 +++++++++----------
 arch/powerpc/platforms/powernv/opal.c         | 23 +++--
 arch/powerpc/platforms/powernv/powernv.h      |  3 +-
 3 files changed, 52 insertions(+), 61 deletions(-)

diff --git a/arch/powerpc/platforms/powernv/opal-irqchip.c b/arch/powerpc/platforms/powernv/opal-irqchip.c
index 9d1b8c0aaf93..354fa53947be 100644
--- a/arch/powerpc/platforms/powernv/opal-irqchip.c
+++ b/arch/powerpc/platforms/powernv/opal-irqchip.c
@@ -22,7 +22,6 @@
 #include <linux/kthread.h>
 #include <linux/delay.h>
 #include <linux/slab.h>
-#include <linux/irq_work.h>
 
 #include <asm/machdep.h>
 #include <asm/opal.h>
@@ -38,37 +37,47 @@ struct opal_event_irqchip {
 	unsigned long mask;
 };
 static struct opal_event_irqchip opal_event_irqchip;
-
+static u64 last_outstanding_events;
 static unsigned int opal_irq_count;
 static unsigned int *opal_irqs;
 
-static void opal_handle_irq_work(struct irq_work *work);
-static u64 last_outstanding_events;
-static struct irq_work opal_event_irq_work = {
-	.func = opal_handle_irq_work,
-};
-
-void opal_handle_events(uint64_t events)
+void opal_handle_events(void)
 {
-	int virq, hwirq = 0;
-	u64 mask = opal_event_irqchip.mask;
+	__be64 events = 0;
+	u64 e;
+
+	e = READ_ONCE(last_outstanding_events) & opal_event_irqchip.mask;
+again:
+	while (e) {
+		int virq, hwirq;
+
+		hwirq = fls64(e) - 1;
+		e &= ~BIT_ULL(hwirq);
+
+		local_irq_disable();
+		virq = irq_find_mapping(opal_event_irqchip.domain, hwirq);
+		if (virq) {
+			irq_enter();
+			generic_handle_irq(virq);
+			irq_exit();
+		}
+		local_irq_enable();
 
-	if (!in_irq() && (events & mask)) {
-		last_outstanding_events = events;
-		irq_work_queue(&opal_event_irq_work);
-		return;
+		cond_resched();
 	}
+	last_outstanding_events = 0;
+	if (opal_poll_events(&events) != OPAL_SUCCESS)
+		return;
+	e = be64_to_cpu(events) & opal_event_irqchip.mask;
+	if (e)
+		goto again;
+}
 
-	while (events & mask) {
-		hwirq = fls64(events) - 1;
-		if (BIT_ULL(hwirq) & mask) {
-			virq = irq_find_mapping(opal_event_irqchip.domain,
-						hwirq);
-			if (virq)
-				generic_handle_irq(virq);
-		}
-		events &= ~BIT_ULL(hwirq);
-	}
+bool opal_have_pending_events(void)
+{
+	if (last_outstanding_events & opal_event_irqchip.mask)
+		return true;
+	return false;
 }
 
 static void opal_event_mask(struct irq_data *d)
@@ -78,24 +87,9 @@ static void opal_event_mask(struct irq_data *d)
 
 static void opal_event_unmask(struct irq_data *d)
 {
-	__be64 events;
-
 	set_bit(d->hwirq, &opal_event_irqchip.mask);
-
-	opal_poll_events(&events);
-	last_outstanding_events = be64_to_cpu(events);
-
-	/*
-	 * We can't just handle the events now with opal_handle_events().
-	 * If we did we would deadlock when opal_event_unmask() is called from
-	 * handle_level_irq() with the irq descriptor lock held, because
-	 * calling opal_handle_events() would call generic_handle_irq() and
-	 * then handle_level_irq() which would try to take the descriptor lock
-	 * again. Instead queue the events for later.
-	 */
-	if (last_outstanding_events & opal_event_irqchip.mask)
-		/* Need to retrigger the interrupt */
-		irq_work_queue(&opal_event_irq_work);
+	if (opal_have_pending_events())
+		opal_wake_poller();
 }
 
 static int opal_event_set_type(struct irq_data *d, unsigned int flow_type)
@@ -136,16 +130,13 @@ static irqreturn_t opal_interrupt(int irq, void *data)
 	__be64 events;
 
 	opal_handle_interrupt(virq_to_hw(irq), &events);
-	opal_handle_events(be64_to_cpu(events));
+	last_outstanding_events = be64_to_cpu(events);
+	if (opal_have_pending_events())
+		opal_wake_poller();
 
 	return IRQ_HANDLED;
 }
 
-static void opal_handle_irq_work(struct irq_work *work)
-{
-	opal_handle_events(last_outstanding_events);
-}
-
 static int opal_event_match(struct irq_domain *h, struct device_node *node,
 			    enum irq_domain_bus_token bus_token)
 {
diff --git a/arch/powerpc/platforms/powernv/opal.c b/arch/powerpc/platforms/powernv/opal.c
index 48fbb41af5d1..0d539c661748 100644
--- a/arch/powerpc/platforms/powernv/opal.c
+++ b/arch/powerpc/platforms/powernv/opal.c
@@ -540,21 +540,15 @@ int opal_hmi_exception_early(struct pt_regs *regs)
 /* HMI exception handler called in virtual mode during check_irq_replay. */
 int opal_handle_hmi_exception(struct pt_regs *regs)
 {
-	s64 rc;
-	__be64 evt = 0;
-
 	/*
 	 * Check if HMI event is available.
-	 * if Yes, then call opal_poll_events to pull opal messages and
-	 * process them.
+	 * if Yes, then wake kopald to process them.
 	 */
 	if (!local_paca->hmi_event_available)
 		return 0;
 
 	local_paca->hmi_event_available = 0;
-	rc = opal_poll_events(&evt);
-	if (rc == OPAL_SUCCESS && evt)
-		opal_handle_events(be64_to_cpu(evt));
+	opal_wake_poller();
 
 	return 1;
 }
@@ -757,14 +751,19 @@ static void __init opal_imc_init_dev(void)
 static int kopald(void *unused)
 {
 	unsigned long timeout = msecs_to_jiffies(opal_heartbeat) + 1;
-	__be64 events;
 
 	set_freezable();
 	do {
 		try_to_freeze();
-		opal_poll_events(&events);
-		opal_handle_events(be64_to_cpu(events));
-		schedule_timeout_interruptible(timeout);
+
+		opal_handle_events();
+
+		set_current_state(TASK_INTERRUPTIBLE);
+		if (opal_have_pending_events())
+			__set_current_state(TASK_RUNNING);
+		else
+			schedule_timeout(timeout);
+
 	} while (!kthread_should_stop());
 
 	return 0;
diff --git a/arch/powerpc/platforms/powernv/powernv.h b/arch/powerpc/platforms/powernv/powernv.h
index 94f17ab1374b..fd4a1c5a6369 100644
--- a/arch/powerpc/platforms/powernv/powernv.h
+++ b/arch/powerpc/platforms/powernv/powernv.h
@@ -24,7 +24,8 @@ extern u32 pnv_get_supported_cpuidle_states(void);
 
 extern void pnv_lpc_init(void);
 
-extern void opal_handle_events(uint64_t events);
+extern void opal_handle_events(void);
+extern bool opal_have_pending_events(void);
 extern void opal_event_shutdown(void);
 
 bool cpu_core_split_required(void);
-- 
2.17.0

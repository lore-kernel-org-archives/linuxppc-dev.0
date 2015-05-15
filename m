Return-Path: <apopple@au1.ibm.com>
Received: from e23smtp06.au.ibm.com (e23smtp06.au.ibm.com [202.81.31.148])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id BF10A1A0780
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 15 May 2015 14:08:13 +1000 (AEST)
Received: from /spool/local
 by e23smtp06.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <apopple@au1.ibm.com>;
 Fri, 15 May 2015 14:08:13 +1000
Received: from d23relay07.au.ibm.com (d23relay07.au.ibm.com [9.190.26.37])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id 435342BB0040
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 15 May 2015 14:08:10 +1000 (EST)
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay07.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t4F482MK29229150
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 15 May 2015 14:08:10 +1000
Received: from d23av04.au.ibm.com (localhost [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t4F47bkw025347
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 15 May 2015 14:07:37 +1000
From: Alistair Popple <alistair@popple.id.au>
To: linuxppc-dev@lists.ozlabs.org, mpe@ellerman.id.au
Subject: [PATCH v4 9/9] opal: Remove events notifier
Date: Fri, 15 May 2015 14:06:44 +1000
Message-Id: <1431662804-16851-10-git-send-email-alistair@popple.id.au>
In-Reply-To: <1431662804-16851-1-git-send-email-alistair@popple.id.au>
References: <1431662804-16851-1-git-send-email-alistair@popple.id.au>
Cc: Alistair Popple <alistair@popple.id.au>, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

All users of the old opal events notifier have been converted over to
the irq domain so remove the event notifier functions.

Signed-off-by: Alistair Popple <alistair@popple.id.au>
---
 arch/powerpc/platforms/powernv/opal-irqchip.c | 16 ++---
 arch/powerpc/platforms/powernv/opal.c         | 84 +--------------------------
 arch/powerpc/platforms/powernv/powernv.h      |  1 -
 arch/powerpc/platforms/powernv/setup.c        |  2 +-
 4 files changed, 8 insertions(+), 95 deletions(-)

diff --git a/arch/powerpc/platforms/powernv/opal-irqchip.c b/arch/powerpc/platforms/powernv/opal-irqchip.c
index bd5125d..841135f 100644
--- a/arch/powerpc/platforms/powernv/opal-irqchip.c
+++ b/arch/powerpc/platforms/powernv/opal-irqchip.c
@@ -100,7 +100,6 @@ void opal_handle_events(uint64_t events)
 {
 	int virq, hwirq = 0;
 	u64 mask = opal_event_irqchip.mask;
-	u64 notifier_mask = 0;
 
 	if (!in_irq() && (events & mask)) {
 		last_outstanding_events = events;
@@ -108,19 +107,16 @@ void opal_handle_events(uint64_t events)
 		return;
 	}
 
-	while (events) {
+	while (events & mask) {
 		hwirq = fls64(events) - 1;
-		virq = irq_find_mapping(opal_event_irqchip.domain,
-					hwirq);
-		if (virq) {
-			if (BIT_ULL(hwirq) & mask)
+		if (BIT_ULL(hwirq) & mask) {
+			virq = irq_find_mapping(opal_event_irqchip.domain,
+						hwirq);
+			if (virq)
 				generic_handle_irq(virq);
-		} else
-			notifier_mask |= BIT_ULL(hwirq);
+		}
 		events &= ~BIT_ULL(hwirq);
 	}
-
-	opal_do_notifier(notifier_mask);
 }
 
 static irqreturn_t opal_interrupt(int irq, void *data)
diff --git a/arch/powerpc/platforms/powernv/opal.c b/arch/powerpc/platforms/powernv/opal.c
index cd5718b..8403307 100644
--- a/arch/powerpc/platforms/powernv/opal.c
+++ b/arch/powerpc/platforms/powernv/opal.c
@@ -53,11 +53,7 @@ static int mc_recoverable_range_len;
 
 struct device_node *opal_node;
 static DEFINE_SPINLOCK(opal_write_lock);
-static ATOMIC_NOTIFIER_HEAD(opal_notifier_head);
 static struct atomic_notifier_head opal_msg_notifier_head[OPAL_MSG_TYPE_MAX];
-static DEFINE_SPINLOCK(opal_notifier_lock);
-static uint64_t last_notified_mask = 0x0ul;
-static atomic_t opal_notifier_hold = ATOMIC_INIT(0);
 static uint32_t opal_heartbeat;
 
 static void opal_reinit_cores(void)
@@ -223,82 +219,6 @@ static int __init opal_register_exception_handlers(void)
 }
 machine_early_initcall(powernv, opal_register_exception_handlers);
 
-int opal_notifier_register(struct notifier_block *nb)
-{
-	if (!nb) {
-		pr_warning("%s: Invalid argument (%p)\n",
-			   __func__, nb);
-		return -EINVAL;
-	}
-
-	atomic_notifier_chain_register(&opal_notifier_head, nb);
-	return 0;
-}
-EXPORT_SYMBOL_GPL(opal_notifier_register);
-
-int opal_notifier_unregister(struct notifier_block *nb)
-{
-	if (!nb) {
-		pr_warning("%s: Invalid argument (%p)\n",
-			   __func__, nb);
-		return -EINVAL;
-	}
-
-	atomic_notifier_chain_unregister(&opal_notifier_head, nb);
-	return 0;
-}
-EXPORT_SYMBOL_GPL(opal_notifier_unregister);
-
-void opal_do_notifier(uint64_t events)
-{
-	unsigned long flags;
-	uint64_t changed_mask;
-
-	if (atomic_read(&opal_notifier_hold))
-		return;
-
-	spin_lock_irqsave(&opal_notifier_lock, flags);
-	changed_mask = last_notified_mask ^ events;
-	last_notified_mask = events;
-	spin_unlock_irqrestore(&opal_notifier_lock, flags);
-
-	/*
-	 * We feed with the event bits and changed bits for
-	 * enough information to the callback.
-	 */
-	atomic_notifier_call_chain(&opal_notifier_head,
-				   events, (void *)changed_mask);
-}
-
-void opal_notifier_update_evt(uint64_t evt_mask,
-			      uint64_t evt_val)
-{
-	unsigned long flags;
-
-	spin_lock_irqsave(&opal_notifier_lock, flags);
-	last_notified_mask &= ~evt_mask;
-	last_notified_mask |= evt_val;
-	spin_unlock_irqrestore(&opal_notifier_lock, flags);
-}
-
-void opal_notifier_enable(void)
-{
-	int64_t rc;
-	__be64 evt = 0;
-
-	atomic_set(&opal_notifier_hold, 0);
-
-	/* Process pending events */
-	rc = opal_poll_events(&evt);
-	if (rc == OPAL_SUCCESS && evt)
-		opal_do_notifier(be64_to_cpu(evt));
-}
-
-void opal_notifier_disable(void)
-{
-	atomic_set(&opal_notifier_hold, 1);
-}
-
 /*
  * Opal message notifier based on message type. Allow subscribers to get
  * notified for specific messgae type.
@@ -570,10 +490,8 @@ int opal_handle_hmi_exception(struct pt_regs *regs)
 
 	local_paca->hmi_event_available = 0;
 	rc = opal_poll_events(&evt);
-	if (rc == OPAL_SUCCESS && evt) {
-		opal_do_notifier(be64_to_cpu(evt));
+	if (rc == OPAL_SUCCESS && evt)
 		opal_handle_events(be64_to_cpu(evt));
-	}
 
 	return 1;
 }
diff --git a/arch/powerpc/platforms/powernv/powernv.h b/arch/powerpc/platforms/powernv/powernv.h
index 221d4c8..f907f0a 100644
--- a/arch/powerpc/platforms/powernv/powernv.h
+++ b/arch/powerpc/platforms/powernv/powernv.h
@@ -35,7 +35,6 @@ extern u32 pnv_get_supported_cpuidle_states(void);
 
 extern void pnv_lpc_init(void);
 
-extern void opal_do_notifier(uint64_t events);
 extern void opal_handle_events(uint64_t events);
 extern void opal_event_shutdown(void);
 
diff --git a/arch/powerpc/platforms/powernv/setup.c b/arch/powerpc/platforms/powernv/setup.c
index 16fdcb2..399f1d7 100644
--- a/arch/powerpc/platforms/powernv/setup.c
+++ b/arch/powerpc/platforms/powernv/setup.c
@@ -111,7 +111,7 @@ static void pnv_prepare_going_down(void)
 	 * Disable all notifiers from OPAL, we can't
 	 * service interrupts anymore anyway
 	 */
-	opal_notifier_disable();
+	opal_event_shutdown();
 
 	/* Soft disable interrupts */
 	local_irq_disable();
-- 
1.8.3.2

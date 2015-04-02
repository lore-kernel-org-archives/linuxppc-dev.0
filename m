Return-Path: <alistair.popple@au1.ibm.com>
Received: from e23smtp01.au.ibm.com (e23smtp01.au.ibm.com [202.81.31.143])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 19D821A077F
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  2 Apr 2015 14:24:23 +1100 (AEDT)
Received: from /spool/local
 by e23smtp01.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <alistair.popple@au1.ibm.com>;
 Thu, 2 Apr 2015 13:24:22 +1000
Received: from d23relay07.au.ibm.com (d23relay07.au.ibm.com [9.190.26.37])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id 2F1343578056
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  2 Apr 2015 14:24:19 +1100 (EST)
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay07.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t323OADt15925298
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 2 Apr 2015 14:24:19 +1100
Received: from d23av04.au.ibm.com (localhost [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t323Njp8017902
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 2 Apr 2015 14:23:45 +1100
From: Alistair Popple <alistair@popple.id.au>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 8/8] opal: Remove events notifier
Date: Thu,  2 Apr 2015 14:22:32 +1100
Message-Id: <1427944952-17452-8-git-send-email-alistair@popple.id.au>
In-Reply-To: <1427944952-17452-1-git-send-email-alistair@popple.id.au>
References: <1427944952-17452-1-git-send-email-alistair@popple.id.au>
Cc: Alistair Popple <alistair@popple.id.au>,
 Gavin Shan <gwshan@linux.vnet.ibm.com>, Jeremy Kerr <jk@ozlabs.org>
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
 arch/powerpc/platforms/powernv/opal-irqchip.c |  4 --
 arch/powerpc/platforms/powernv/opal.c         | 84 +--------------------------
 arch/powerpc/platforms/powernv/powernv.h      |  1 -
 arch/powerpc/platforms/powernv/setup.c        |  2 +-
 4 files changed, 2 insertions(+), 89 deletions(-)

diff --git a/arch/powerpc/platforms/powernv/opal-irqchip.c b/arch/powerpc/platforms/powernv/opal-irqchip.c
index acc12e3..a6f7dfd 100644
--- a/arch/powerpc/platforms/powernv/opal-irqchip.c
+++ b/arch/powerpc/platforms/powernv/opal-irqchip.c
@@ -132,10 +132,6 @@ static irqreturn_t opal_interrupt(int irq, void *data)
 
 	opal_handle_interrupt(virq_to_hw(irq), &events);
 
-	/* Continue to call the notifiers until we have converted
-	 * existing users over. */
-	opal_do_notifier(be64_to_cpu(events));
-
 	/* Clear the ack bit once an event is set to zero */
 	opal_event_irqchip.ack &= events;
 
diff --git a/arch/powerpc/platforms/powernv/opal.c b/arch/powerpc/platforms/powernv/opal.c
index b37f0fc..11794d7 100644
--- a/arch/powerpc/platforms/powernv/opal.c
+++ b/arch/powerpc/platforms/powernv/opal.c
@@ -51,11 +51,7 @@ static int mc_recoverable_range_len;
 
 struct device_node *opal_node;
 static DEFINE_SPINLOCK(opal_write_lock);
-static ATOMIC_NOTIFIER_HEAD(opal_notifier_head);
 static struct atomic_notifier_head opal_msg_notifier_head[OPAL_MSG_TYPE_MAX];
-static DEFINE_SPINLOCK(opal_notifier_lock);
-static uint64_t last_notified_mask = 0x0ul;
-static atomic_t opal_notifier_hold = ATOMIC_INIT(0);
 
 static void opal_reinit_cores(void)
 {
@@ -220,82 +216,6 @@ static int __init opal_register_exception_handlers(void)
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
@@ -565,10 +485,8 @@ int opal_handle_hmi_exception(struct pt_regs *regs)
 
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
index 41edf6c..addd15c 100644
--- a/arch/powerpc/platforms/powernv/powernv.h
+++ b/arch/powerpc/platforms/powernv/powernv.h
@@ -33,7 +33,6 @@ extern u32 pnv_get_supported_cpuidle_states(void);
 
 extern void pnv_lpc_init(void);
 
-extern void opal_do_notifier(uint64_t events);
 extern void opal_handle_events(uint64_t events);
 extern void opal_event_shutdown(void);
 
diff --git a/arch/powerpc/platforms/powernv/setup.c b/arch/powerpc/platforms/powernv/setup.c
index d2de7d5..1fb529d 100644
--- a/arch/powerpc/platforms/powernv/setup.c
+++ b/arch/powerpc/platforms/powernv/setup.c
@@ -112,7 +112,7 @@ static void pnv_prepare_going_down(void)
 	 * Disable all notifiers from OPAL, we can't
 	 * service interrupts anymore anyway
 	 */
-	opal_notifier_disable();
+	opal_event_shutdown();
 
 	/* Soft disable interrupts */
 	local_irq_disable();
-- 
1.8.3.2

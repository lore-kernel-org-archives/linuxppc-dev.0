Return-Path: <vbarshak@ru.mvista.com>
Received: from vaxon.spb.rtsoft.ru (unknown [212.176.242.38])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id C4473DDE1A
	for <linuxppc-dev@ozlabs.org>; Thu, 15 Nov 2007 01:02:15 +1100 (EST)
Received: from vaxon.spb.rtsoft.ru (localhost.localdomain [127.0.0.1])
	by vaxon.spb.rtsoft.ru (8.13.1/8.13.1) with ESMTP id lAEE0rQd012154
	for <linuxppc-dev@ozlabs.org>; Wed, 14 Nov 2007 17:00:53 +0300
Received: (from vaxon@localhost)
	by vaxon.spb.rtsoft.ru (8.13.1/8.13.1/Submit) id lAEE0rYC012151
	for linuxppc-dev@ozlabs.org; Wed, 14 Nov 2007 17:00:53 +0300
Date: Wed, 14 Nov 2007 17:00:52 +0300
From: Valentine Barshak <vbarshak@ru.mvista.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 2/2] PowerPC: make 4xx uic use generic level irq handler
Message-ID: <20071114140052.GA12129@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <473AEA91.8090109@ru.mvista.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This patch makes PowerPC 4xx UIC use generic level irq handler instead
of a custom handle_uic_irq() function. We ack only edge irqs in mask_ack
callback, since acking a level irq on UIC has no effect if the interrupt
is still asserted by the device, even if the interrupt is already masked.
So, to really de-assert the interrupt we need to de-assert the external
source first *and* ack it on UIC then. The handle_level_irq() function
masks and ack's the interrupt with mask_ack callback prior to calling
the actual ISR and unmasks it at the end. So, to use it with UIC interrupts
we need to ack level irqs in the unmask callback instead, after the ISR
has de-asserted the external interrupt source. Even if we ack the interrupt
that we didn't handle (unmask/ack it at the end of the handler, while
next irq is already pending) it will not de-assert the irq, untill we
de-assert its exteral source.

Signed-off-by: Valentine Barshak <vbarshak@ru.mvista.com>
---
 arch/powerpc/sysdev/uic.c |   81 ++++++++++------------------------------------
 1 files changed, 19 insertions(+), 62 deletions(-)

--- linux-2.6.orig/arch/powerpc/sysdev/uic.c	2007-11-14 15:57:37.000000000 +0300
+++ linux-2.6/arch/powerpc/sysdev/uic.c	2007-11-14 15:59:18.000000000 +0300
@@ -60,14 +60,19 @@ struct uic {
 
 static void uic_unmask_irq(unsigned int virq)
 {
+	struct irq_desc *desc = get_irq_desc(virq);
 	struct uic *uic = get_irq_chip_data(virq);
 	unsigned int src = uic_irq_to_hw(virq);
 	unsigned long flags;
-	u32 er;
+	u32 er, sr;
 
+	sr = 1 << (31-src);
 	spin_lock_irqsave(&uic->lock, flags);
+	/* ack level-triggered interrupts here */
+	if (desc->status & IRQ_LEVEL)
+		mtdcr(uic->dcrbase + UIC_SR, sr);
 	er = mfdcr(uic->dcrbase + UIC_ER);
-	er |= 1 << (31 - src);
+	er |= sr;
 	mtdcr(uic->dcrbase + UIC_ER, er);
 	spin_unlock_irqrestore(&uic->lock, flags);
 }
@@ -99,6 +104,7 @@ static void uic_ack_irq(unsigned int vir
 
 static void uic_mask_ack_irq(unsigned int virq)
 {
+	struct irq_desc *desc = get_irq_desc(virq);
 	struct uic *uic = get_irq_chip_data(virq);
 	unsigned int src = uic_irq_to_hw(virq);
 	unsigned long flags;
@@ -109,7 +115,16 @@ static void uic_mask_ack_irq(unsigned in
 	er = mfdcr(uic->dcrbase + UIC_ER);
 	er &= ~sr;
 	mtdcr(uic->dcrbase + UIC_ER, er);
-	mtdcr(uic->dcrbase + UIC_SR, sr);
+ 	/* On the UIC, acking (i.e. clearing the SR bit)
+	 * a level irq will have no effect if the interrupt
+	 * is still asserted by the device, even if
+	 * the interrupt is already masked. Therefore
+	 * we only ack the egde interrupts here, while
+	 * level interrupts are ack'ed after the actual
+	 * isr call in the uic_unmask_irq()
+	 */
+	if (!(desc->status & IRQ_LEVEL))
+		mtdcr(uic->dcrbase + UIC_SR, sr);
 	spin_unlock_irqrestore(&uic->lock, flags);
 }
 
@@ -173,64 +188,6 @@ static struct irq_chip uic_irq_chip = {
 	.set_type	= uic_set_irq_type,
 };
 
-/**
- *	handle_uic_irq - irq flow handler for UIC
- *	@irq:	the interrupt number
- *	@desc:	the interrupt description structure for this irq
- *
- * This is modified version of the generic handle_level_irq() suitable
- * for the UIC.  On the UIC, acking (i.e. clearing the SR bit) a level
- * irq will have no effect if the interrupt is still asserted by the
- * device, even if the interrupt is already masked.  Therefore, unlike
- * the standard handle_level_irq(), we must ack the interrupt *after*
- * invoking the ISR (which should have de-asserted the interrupt in
- * the external source).  For edge interrupts we ack at the beginning
- * instead of the end, to keep the window in which we can miss an
- * interrupt as small as possible.
- */
-void fastcall handle_uic_irq(unsigned int irq, struct irq_desc *desc)
-{
-	unsigned int cpu = smp_processor_id();
-	struct irqaction *action;
-	irqreturn_t action_ret;
-
-	spin_lock(&desc->lock);
-	if (desc->status & IRQ_LEVEL)
-		desc->chip->mask(irq);
-	else
-		desc->chip->mask_ack(irq);
-
-	if (unlikely(desc->status & IRQ_INPROGRESS))
-		goto out_unlock;
-	desc->status &= ~(IRQ_REPLAY | IRQ_WAITING);
-	kstat_cpu(cpu).irqs[irq]++;
-
-	/*
-	 * If its disabled or no action available
-	 * keep it masked and get out of here
-	 */
-	action = desc->action;
-	if (unlikely(!action || (desc->status & IRQ_DISABLED))) {
-		desc->status |= IRQ_PENDING;
-		goto out_unlock;
-	}
-
-	desc->status |= IRQ_INPROGRESS;
-	desc->status &= ~IRQ_PENDING;
-	spin_unlock(&desc->lock);
-
-	action_ret = handle_IRQ_event(irq, action);
-
-	spin_lock(&desc->lock);
-	desc->status &= ~IRQ_INPROGRESS;
-	if (desc->status & IRQ_LEVEL)
-		desc->chip->ack(irq);
-	if (!(desc->status & IRQ_DISABLED) && desc->chip->unmask)
-		desc->chip->unmask(irq);
-out_unlock:
-	spin_unlock(&desc->lock);
-}
-
 static int uic_host_map(struct irq_host *h, unsigned int virq,
 			irq_hw_number_t hw)
 {
@@ -239,7 +196,7 @@ static int uic_host_map(struct irq_host 
 	set_irq_chip_data(virq, uic);
 	/* Despite the name, handle_level_irq() works for both level
 	 * and edge irqs on UIC.  FIXME: check this is correct */
-	set_irq_chip_and_handler(virq, &uic_irq_chip, handle_uic_irq);
+	set_irq_chip_and_handler(virq, &uic_irq_chip, handle_level_irq);
 
 	/* Set default irq type */
 	set_irq_type(virq, IRQ_TYPE_NONE);

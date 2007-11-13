Return-Path: <vbarshak@ru.mvista.com>
Received: from vaxon.spb.rtsoft.ru (unknown [212.176.242.38])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 94770DDE1A
	for <linuxppc-dev@ozlabs.org>; Wed, 14 Nov 2007 23:10:43 +1100 (EST)
Date: Tue, 13 Nov 2007 23:27:31 +0300
From: Valentine Barshak <vbarshak@ru.mvista.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 2/2] PowerPC: make 4xx uic use generic edge and level irq
	handlers
Message-ID: <20071113202731.GA26319@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20071113201559.GA26172@ru.mvista.com>
Cc: dwg@au1.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This patch makes PowerPC 4xx UIC use generic edge and level irq handlers
instead of a custom handle_uic_irq() function. Acking a level irq on UIC
has no effect if the interrupt is still asserted by the device, even if
the interrupt is already masked. So, to really de-assert the interrupt
we need to de-assert the external source first *and* ack it on UIC then.
The handle_level_irq() function masks and ack's the interrupt with mask_ack
callback prior to calling the actual ISR and unmasks it at the end.
So, to use it with UIC level interrupts we need to ack in the unmask
callback instead, after the ISR has de-asserted the external interrupt source.
Even if we ack the interrupt that we didn't handle (unmask/ack it at
the end of the handler, while next irq is already pending) it will not
de-assert the irq, untill we de-assert its exteral source.

Signed-off-by: Valentine Barshak <vbarshak@ru.mvista.com>
---
 arch/powerpc/sysdev/uic.c |   89 ++++++++++++----------------------------------
 1 files changed, 24 insertions(+), 65 deletions(-)

--- linux-2.6/arch/powerpc/sysdev/uic.c	2007-11-13 22:28:01.000000000 +0300
+++ linux-2.6.o/arch/powerpc/sysdev/uic.c	2007-11-13 22:27:20.000000000 +0300
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
+	/* ack level interrupts here */
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
+ 	/* on the uic, acking (i.e. clearing the sr bit)
+	 * a level irq will have no effect if the interrupt
+	 * is still asserted by the device, even if
+	 * the interrupt is already masked. therefore
+	 * we only ack the egde interrupts here, while
+	 * level interrupts are ack'ed after the actual
+	 * isr call in the uic_unmask_irq()
+	 */
+	if (!(desc->status & IRQ_LEVEL))
+		mtdcr(uic->dcrbase + UIC_SR, sr);
 	spin_unlock_irqrestore(&uic->lock, flags);
 }
 
@@ -156,8 +171,11 @@ static int uic_set_irq_type(unsigned int
 
 	desc->status &= ~(IRQ_TYPE_SENSE_MASK | IRQ_LEVEL);
 	desc->status |= flow_type & IRQ_TYPE_SENSE_MASK;
-	if (!trigger)
+	if (!trigger) {
 		desc->status |= IRQ_LEVEL;
+		set_irq_handler(virq, handle_level_irq);
+	} else
+		set_irq_handler(virq, handle_edge_irq);
 
 	spin_unlock_irqrestore(&uic->lock, flags);
 
@@ -173,73 +191,14 @@ static struct irq_chip uic_irq_chip = {
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
 	struct uic *uic = h->host_data;
 
 	set_irq_chip_data(virq, uic);
-	/* Despite the name, handle_level_irq() works for both level
-	 * and edge irqs on UIC.  FIXME: check this is correct */
-	set_irq_chip_and_handler(virq, &uic_irq_chip, handle_uic_irq);
+	/* appropriate irq handler is set by set_irq_type() */
+	set_irq_chip(virq, &uic_irq_chip);
 
 	/* Set default irq type */
 	set_irq_type(virq, IRQ_TYPE_NONE);

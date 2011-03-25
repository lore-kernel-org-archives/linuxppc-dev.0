Return-Path: <tglx@linutronix.de>
Received: from linutronix.de (www.linutronix.de [62.245.132.108])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id C30C1100BAC
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat, 26 Mar 2011 09:08:57 +1100 (EST)
Message-Id: <20110325164141.619502119@linutronix.de>
Date: Fri, 25 Mar 2011 21:36:20 -0000
From: Thomas Gleixner <tglx@linutronix.de>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [patch 10/14] powerpc: uic: Cleanup flow type handling
References: <20110325164049.138289403@linutronix.de>
Cc: Lennert Buytenhek <buytenh@secretlab.ca>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The core irq_set_type() function updates the flow type when the chip
callback returns 0. So setting the type is bogus. The core also
updates IRQ_LEVEL.

Use irq_data to get the level type information in the chip functions.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 arch/powerpc/sysdev/uic.c |   25 +++++++++----------------
 1 file changed, 9 insertions(+), 16 deletions(-)

Index: linux-2.6-tip/arch/powerpc/sysdev/uic.c
===================================================================
--- linux-2.6-tip.orig/arch/powerpc/sysdev/uic.c
+++ linux-2.6-tip/arch/powerpc/sysdev/uic.c
@@ -57,7 +57,6 @@ struct uic {
 
 static void uic_unmask_irq(struct irq_data *d)
 {
-	struct irq_desc *desc = irq_to_desc(d->irq);
 	struct uic *uic = irq_data_get_irq_chip_data(d);
 	unsigned int src = uic_irq_to_hw(d->irq);
 	unsigned long flags;
@@ -66,7 +65,7 @@ static void uic_unmask_irq(struct irq_da
 	sr = 1 << (31-src);
 	spin_lock_irqsave(&uic->lock, flags);
 	/* ack level-triggered interrupts here */
-	if (desc->status & IRQ_LEVEL)
+	if (irqd_is_level_type(d))
 		mtdcr(uic->dcrbase + UIC_SR, sr);
 	er = mfdcr(uic->dcrbase + UIC_ER);
 	er |= sr;
@@ -101,7 +100,6 @@ static void uic_ack_irq(struct irq_data 
 
 static void uic_mask_ack_irq(struct irq_data *d)
 {
-	struct irq_desc *desc = irq_to_desc(d->irq);
 	struct uic *uic = irq_data_get_irq_chip_data(d);
 	unsigned int src = uic_irq_to_hw(d->irq);
 	unsigned long flags;
@@ -120,7 +118,7 @@ static void uic_mask_ack_irq(struct irq_
 	 * level interrupts are ack'ed after the actual
 	 * isr call in the uic_unmask_irq()
 	 */
-	if (!(desc->status & IRQ_LEVEL))
+	if (!irqd_is_level_type(d))
 		mtdcr(uic->dcrbase + UIC_SR, sr);
 	spin_unlock_irqrestore(&uic->lock, flags);
 }
@@ -129,7 +127,6 @@ static int uic_set_irq_type(struct irq_d
 {
 	struct uic *uic = irq_data_get_irq_chip_data(d);
 	unsigned int src = uic_irq_to_hw(d->irq);
-	struct irq_desc *desc = irq_to_desc(d->irq);
 	unsigned long flags;
 	int trigger, polarity;
 	u32 tr, pr, mask;
@@ -166,11 +163,6 @@ static int uic_set_irq_type(struct irq_d
 	mtdcr(uic->dcrbase + UIC_PR, pr);
 	mtdcr(uic->dcrbase + UIC_TR, tr);
 
-	desc->status &= ~(IRQ_TYPE_SENSE_MASK | IRQ_LEVEL);
-	desc->status |= flow_type & IRQ_TYPE_SENSE_MASK;
-	if (!trigger)
-		desc->status |= IRQ_LEVEL;
-
 	spin_unlock_irqrestore(&uic->lock, flags);
 
 	return 0;
@@ -221,16 +213,17 @@ static struct irq_host_ops uic_host_ops 
 void uic_irq_cascade(unsigned int virq, struct irq_desc *desc)
 {
 	struct irq_chip *chip = get_irq_desc_chip(desc);
+	struct irq_data *idata = irq_desc_get_irq_data(desc);
 	struct uic *uic = get_irq_data(virq);
 	u32 msr;
 	int src;
 	int subvirq;
 
 	raw_spin_lock(&desc->lock);
-	if (desc->status & IRQ_LEVEL)
-		chip->irq_mask(&desc->irq_data);
+	if (irqd_is_level_type(idata))
+		chip->irq_mask(idata);
 	else
-		chip->irq_mask_ack(&desc->irq_data);
+		chip->irq_mask_ack(idata);
 	raw_spin_unlock(&desc->lock);
 
 	msr = mfdcr(uic->dcrbase + UIC_MSR);
@@ -244,10 +237,10 @@ void uic_irq_cascade(unsigned int virq, 
 
 uic_irq_ret:
 	raw_spin_lock(&desc->lock);
-	if (desc->status & IRQ_LEVEL)
-		chip->irq_ack(&desc->irq_data);
+	if (irqd_is_level_type(data))
+		chip->irq_ack(idata);
 	if (!(desc->status & IRQ_DISABLED) && chip->irq_unmask)
-		chip->irq_unmask(&desc->irq_data);
+		chip->irq_unmask(idata);
 	raw_spin_unlock(&desc->lock);
 }
 

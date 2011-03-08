Return-Path: <buytenh@wantstofly.org>
Received: from mail.wantstofly.org (fw.wantstofly.org [80.101.37.227])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id B520E100EB4
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue,  8 Mar 2011 11:00:19 +1100 (EST)
Date: Tue, 8 Mar 2011 01:00:16 +0100
From: Lennert Buytenhek <buytenh@wantstofly.org>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 25/28] powerpc: sysdev/uic irq_data conversion.
Message-ID: <20110308000015.GD16649@mail.wantstofly.org>
References: <cover.1299541392.git.buytenh@wantstofly.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <cover.1299541392.git.buytenh@wantstofly.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Signed-off-by: Lennert Buytenhek <buytenh@secretlab.ca>
---
 arch/powerpc/sysdev/uic.c |   59 +++++++++++++++++++++++----------------------
 1 files changed, 30 insertions(+), 29 deletions(-)

diff --git a/arch/powerpc/sysdev/uic.c b/arch/powerpc/sysdev/uic.c
index 0038fb7..861fb99 100644
--- a/arch/powerpc/sysdev/uic.c
+++ b/arch/powerpc/sysdev/uic.c
@@ -55,11 +55,11 @@ struct uic {
 	struct irq_host	*irqhost;
 };
 
-static void uic_unmask_irq(unsigned int virq)
+static void uic_unmask_irq(struct irq_data *d)
 {
-	struct irq_desc *desc = irq_to_desc(virq);
-	struct uic *uic = get_irq_chip_data(virq);
-	unsigned int src = uic_irq_to_hw(virq);
+	struct irq_desc *desc = irq_to_desc(d->irq);
+	struct uic *uic = get_irq_chip_data(d->irq);
+	unsigned int src = uic_irq_to_hw(d->irq);
 	unsigned long flags;
 	u32 er, sr;
 
@@ -74,10 +74,10 @@ static void uic_unmask_irq(unsigned int virq)
 	spin_unlock_irqrestore(&uic->lock, flags);
 }
 
-static void uic_mask_irq(unsigned int virq)
+static void uic_mask_irq(struct irq_data *d)
 {
-	struct uic *uic = get_irq_chip_data(virq);
-	unsigned int src = uic_irq_to_hw(virq);
+	struct uic *uic = get_irq_chip_data(d->irq);
+	unsigned int src = uic_irq_to_hw(d->irq);
 	unsigned long flags;
 	u32 er;
 
@@ -88,10 +88,10 @@ static void uic_mask_irq(unsigned int virq)
 	spin_unlock_irqrestore(&uic->lock, flags);
 }
 
-static void uic_ack_irq(unsigned int virq)
+static void uic_ack_irq(struct irq_data *d)
 {
-	struct uic *uic = get_irq_chip_data(virq);
-	unsigned int src = uic_irq_to_hw(virq);
+	struct uic *uic = get_irq_chip_data(d->irq);
+	unsigned int src = uic_irq_to_hw(d->irq);
 	unsigned long flags;
 
 	spin_lock_irqsave(&uic->lock, flags);
@@ -99,11 +99,11 @@ static void uic_ack_irq(unsigned int virq)
 	spin_unlock_irqrestore(&uic->lock, flags);
 }
 
-static void uic_mask_ack_irq(unsigned int virq)
+static void uic_mask_ack_irq(struct irq_data *d)
 {
-	struct irq_desc *desc = irq_to_desc(virq);
-	struct uic *uic = get_irq_chip_data(virq);
-	unsigned int src = uic_irq_to_hw(virq);
+	struct irq_desc *desc = irq_to_desc(d->irq);
+	struct uic *uic = get_irq_chip_data(d->irq);
+	unsigned int src = uic_irq_to_hw(d->irq);
 	unsigned long flags;
 	u32 er, sr;
 
@@ -125,18 +125,18 @@ static void uic_mask_ack_irq(unsigned int virq)
 	spin_unlock_irqrestore(&uic->lock, flags);
 }
 
-static int uic_set_irq_type(unsigned int virq, unsigned int flow_type)
+static int uic_set_irq_type(struct irq_data *d, unsigned int flow_type)
 {
-	struct uic *uic = get_irq_chip_data(virq);
-	unsigned int src = uic_irq_to_hw(virq);
-	struct irq_desc *desc = irq_to_desc(virq);
+	struct uic *uic = get_irq_chip_data(d->irq);
+	unsigned int src = uic_irq_to_hw(d->irq);
+	struct irq_desc *desc = irq_to_desc(d->irq);
 	unsigned long flags;
 	int trigger, polarity;
 	u32 tr, pr, mask;
 
 	switch (flow_type & IRQ_TYPE_SENSE_MASK) {
 	case IRQ_TYPE_NONE:
-		uic_mask_irq(virq);
+		uic_mask_irq(d);
 		return 0;
 
 	case IRQ_TYPE_EDGE_RISING:
@@ -178,11 +178,11 @@ static int uic_set_irq_type(unsigned int virq, unsigned int flow_type)
 
 static struct irq_chip uic_irq_chip = {
 	.name		= "UIC",
-	.unmask		= uic_unmask_irq,
-	.mask		= uic_mask_irq,
- 	.mask_ack	= uic_mask_ack_irq,
-	.ack		= uic_ack_irq,
-	.set_type	= uic_set_irq_type,
+	.irq_unmask	= uic_unmask_irq,
+	.irq_mask	= uic_mask_irq,
+	.irq_mask_ack	= uic_mask_ack_irq,
+	.irq_ack	= uic_ack_irq,
+	.irq_set_type	= uic_set_irq_type,
 };
 
 static int uic_host_map(struct irq_host *h, unsigned int virq,
@@ -220,6 +220,7 @@ static struct irq_host_ops uic_host_ops = {
 
 void uic_irq_cascade(unsigned int virq, struct irq_desc *desc)
 {
+	struct irq_chip *chip = get_irq_desc_chip(desc);
 	struct uic *uic = get_irq_data(virq);
 	u32 msr;
 	int src;
@@ -227,9 +228,9 @@ void uic_irq_cascade(unsigned int virq, struct irq_desc *desc)
 
 	raw_spin_lock(&desc->lock);
 	if (desc->status & IRQ_LEVEL)
-		desc->chip->mask(virq);
+		chip->irq_mask(&desc->irq_data);
 	else
-		desc->chip->mask_ack(virq);
+		chip->irq_mask_ack(&desc->irq_data);
 	raw_spin_unlock(&desc->lock);
 
 	msr = mfdcr(uic->dcrbase + UIC_MSR);
@@ -244,9 +245,9 @@ void uic_irq_cascade(unsigned int virq, struct irq_desc *desc)
 uic_irq_ret:
 	raw_spin_lock(&desc->lock);
 	if (desc->status & IRQ_LEVEL)
-		desc->chip->ack(virq);
-	if (!(desc->status & IRQ_DISABLED) && desc->chip->unmask)
-		desc->chip->unmask(virq);
+		chip->irq_ack(&desc->irq_data);
+	if (!(desc->status & IRQ_DISABLED) && chip->irq_unmask)
+		chip->irq_unmask(&desc->irq_data);
 	raw_spin_unlock(&desc->lock);
 }
 
-- 
1.7.4

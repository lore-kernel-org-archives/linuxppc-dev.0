Return-Path: <buytenh@wantstofly.org>
Received: from mail.wantstofly.org (fw.wantstofly.org [80.101.37.227])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 50896B7708
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue,  8 Mar 2011 10:59:27 +1100 (EST)
Date: Tue, 8 Mar 2011 00:59:23 +0100
From: Lennert Buytenhek <buytenh@wantstofly.org>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 06/28] powerpc: platforms/86xx irq_data conversion.
Message-ID: <20110307235923.GK16649@mail.wantstofly.org>
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
 arch/powerpc/platforms/86xx/gef_pic.c |   22 +++++++++++-----------
 arch/powerpc/platforms/86xx/pic.c     |    5 ++++-
 2 files changed, 15 insertions(+), 12 deletions(-)

diff --git a/arch/powerpc/platforms/86xx/gef_pic.c b/arch/powerpc/platforms/86xx/gef_pic.c
index 6df9e25..0adfe3b 100644
--- a/arch/powerpc/platforms/86xx/gef_pic.c
+++ b/arch/powerpc/platforms/86xx/gef_pic.c
@@ -95,6 +95,7 @@ static int gef_pic_cascade_irq;
 
 void gef_pic_cascade(unsigned int irq, struct irq_desc *desc)
 {
+	struct irq_chip *chip = get_irq_desc_chip(desc);
 	unsigned int cascade_irq;
 
 	/*
@@ -106,17 +107,16 @@ void gef_pic_cascade(unsigned int irq, struct irq_desc *desc)
 	if (cascade_irq != NO_IRQ)
 		generic_handle_irq(cascade_irq);
 
-	desc->chip->eoi(irq);
-
+	chip->irq_eoi(&desc->irq_data);
 }
 
-static void gef_pic_mask(unsigned int virq)
+static void gef_pic_mask(struct irq_data *d)
 {
 	unsigned long flags;
 	unsigned int hwirq;
 	u32 mask;
 
-	hwirq = gef_irq_to_hw(virq);
+	hwirq = gef_irq_to_hw(d->irq);
 
 	raw_spin_lock_irqsave(&gef_pic_lock, flags);
 	mask = in_be32(gef_pic_irq_reg_base + GEF_PIC_INTR_MASK(0));
@@ -125,21 +125,21 @@ static void gef_pic_mask(unsigned int virq)
 	raw_spin_unlock_irqrestore(&gef_pic_lock, flags);
 }
 
-static void gef_pic_mask_ack(unsigned int virq)
+static void gef_pic_mask_ack(struct irq_data *d)
 {
 	/* Don't think we actually have to do anything to ack an interrupt,
 	 * we just need to clear down the devices interrupt and it will go away
 	 */
-	gef_pic_mask(virq);
+	gef_pic_mask(d);
 }
 
-static void gef_pic_unmask(unsigned int virq)
+static void gef_pic_unmask(struct irq_data *d)
 {
 	unsigned long flags;
 	unsigned int hwirq;
 	u32 mask;
 
-	hwirq = gef_irq_to_hw(virq);
+	hwirq = gef_irq_to_hw(d->irq);
 
 	raw_spin_lock_irqsave(&gef_pic_lock, flags);
 	mask = in_be32(gef_pic_irq_reg_base + GEF_PIC_INTR_MASK(0));
@@ -150,9 +150,9 @@ static void gef_pic_unmask(unsigned int virq)
 
 static struct irq_chip gef_pic_chip = {
 	.name		= "gefp",
-	.mask		= gef_pic_mask,
-	.mask_ack	= gef_pic_mask_ack,
-	.unmask		= gef_pic_unmask,
+	.irq_mask	= gef_pic_mask,
+	.irq_mask_ack	= gef_pic_mask_ack,
+	.irq_unmask	= gef_pic_unmask,
 };
 
 
diff --git a/arch/powerpc/platforms/86xx/pic.c b/arch/powerpc/platforms/86xx/pic.c
index 668275d..cbe3363 100644
--- a/arch/powerpc/platforms/86xx/pic.c
+++ b/arch/powerpc/platforms/86xx/pic.c
@@ -19,10 +19,13 @@
 #ifdef CONFIG_PPC_I8259
 static void mpc86xx_8259_cascade(unsigned int irq, struct irq_desc *desc)
 {
+	struct irq_chip *chip = get_irq_desc_chip(desc);
 	unsigned int cascade_irq = i8259_irq();
+
 	if (cascade_irq != NO_IRQ)
 		generic_handle_irq(cascade_irq);
-	desc->chip->eoi(irq);
+
+	chip->irq_eoi(&desc->irq_data);
 }
 #endif	/* CONFIG_PPC_I8259 */
 
-- 
1.7.4

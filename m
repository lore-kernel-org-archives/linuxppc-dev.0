Return-Path: <buytenh@wantstofly.org>
Received: from mail.wantstofly.org (fw.wantstofly.org [80.101.37.227])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 91085B727B
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue,  8 Mar 2011 10:59:18 +1100 (EST)
Date: Tue, 8 Mar 2011 00:59:14 +0100
From: Lennert Buytenhek <buytenh@wantstofly.org>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 03/28] powerpc: platforms/52xx irq_data conversion.
Message-ID: <20110307235914.GH16649@mail.wantstofly.org>
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
 arch/powerpc/platforms/52xx/media5200.c   |   21 ++++----
 arch/powerpc/platforms/52xx/mpc52xx_gpt.c |   26 +++++-----
 arch/powerpc/platforms/52xx/mpc52xx_pic.c |   80 ++++++++++++++--------------
 3 files changed, 64 insertions(+), 63 deletions(-)

diff --git a/arch/powerpc/platforms/52xx/media5200.c b/arch/powerpc/platforms/52xx/media5200.c
index 2c7780c..2bd1e6c 100644
--- a/arch/powerpc/platforms/52xx/media5200.c
+++ b/arch/powerpc/platforms/52xx/media5200.c
@@ -49,45 +49,46 @@ struct media5200_irq {
 };
 struct media5200_irq media5200_irq;
 
-static void media5200_irq_unmask(unsigned int virq)
+static void media5200_irq_unmask(struct irq_data *d)
 {
 	unsigned long flags;
 	u32 val;
 
 	spin_lock_irqsave(&media5200_irq.lock, flags);
 	val = in_be32(media5200_irq.regs + MEDIA5200_IRQ_ENABLE);
-	val |= 1 << (MEDIA5200_IRQ_SHIFT + irq_map[virq].hwirq);
+	val |= 1 << (MEDIA5200_IRQ_SHIFT + irq_map[d->irq].hwirq);
 	out_be32(media5200_irq.regs + MEDIA5200_IRQ_ENABLE, val);
 	spin_unlock_irqrestore(&media5200_irq.lock, flags);
 }
 
-static void media5200_irq_mask(unsigned int virq)
+static void media5200_irq_mask(struct irq_data *d)
 {
 	unsigned long flags;
 	u32 val;
 
 	spin_lock_irqsave(&media5200_irq.lock, flags);
 	val = in_be32(media5200_irq.regs + MEDIA5200_IRQ_ENABLE);
-	val &= ~(1 << (MEDIA5200_IRQ_SHIFT + irq_map[virq].hwirq));
+	val &= ~(1 << (MEDIA5200_IRQ_SHIFT + irq_map[d->irq].hwirq));
 	out_be32(media5200_irq.regs + MEDIA5200_IRQ_ENABLE, val);
 	spin_unlock_irqrestore(&media5200_irq.lock, flags);
 }
 
 static struct irq_chip media5200_irq_chip = {
 	.name = "Media5200 FPGA",
-	.unmask = media5200_irq_unmask,
-	.mask = media5200_irq_mask,
-	.mask_ack = media5200_irq_mask,
+	.irq_unmask = media5200_irq_unmask,
+	.irq_mask = media5200_irq_mask,
+	.irq_mask_ack = media5200_irq_mask,
 };
 
 void media5200_irq_cascade(unsigned int virq, struct irq_desc *desc)
 {
+	struct irq_chip *chip = get_irq_desc_chip(desc);
 	int sub_virq, val;
 	u32 status, enable;
 
 	/* Mask off the cascaded IRQ */
 	raw_spin_lock(&desc->lock);
-	desc->chip->mask(virq);
+	chip->irq_mask(&desc->irq_data);
 	raw_spin_unlock(&desc->lock);
 
 	/* Ask the FPGA for IRQ status.  If 'val' is 0, then no irqs
@@ -105,9 +106,9 @@ void media5200_irq_cascade(unsigned int virq, struct irq_desc *desc)
 
 	/* Processing done; can reenable the cascade now */
 	raw_spin_lock(&desc->lock);
-	desc->chip->ack(virq);
+	chip->irq_ack(&desc->irq_data);
 	if (!(desc->status & IRQ_DISABLED))
-		desc->chip->unmask(virq);
+		chip->irq_unmask(&desc->irq_data);
 	raw_spin_unlock(&desc->lock);
 }
 
diff --git a/arch/powerpc/platforms/52xx/mpc52xx_gpt.c b/arch/powerpc/platforms/52xx/mpc52xx_gpt.c
index e0d703c..fe6cc5d 100644
--- a/arch/powerpc/platforms/52xx/mpc52xx_gpt.c
+++ b/arch/powerpc/platforms/52xx/mpc52xx_gpt.c
@@ -135,9 +135,9 @@ DEFINE_MUTEX(mpc52xx_gpt_list_mutex);
  * Cascaded interrupt controller hooks
  */
 
-static void mpc52xx_gpt_irq_unmask(unsigned int virq)
+static void mpc52xx_gpt_irq_unmask(struct irq_data *d)
 {
-	struct mpc52xx_gpt_priv *gpt = get_irq_chip_data(virq);
+	struct mpc52xx_gpt_priv *gpt = get_irq_chip_data(d->irq);
 	unsigned long flags;
 
 	spin_lock_irqsave(&gpt->lock, flags);
@@ -145,9 +145,9 @@ static void mpc52xx_gpt_irq_unmask(unsigned int virq)
 	spin_unlock_irqrestore(&gpt->lock, flags);
 }
 
-static void mpc52xx_gpt_irq_mask(unsigned int virq)
+static void mpc52xx_gpt_irq_mask(struct irq_data *d)
 {
-	struct mpc52xx_gpt_priv *gpt = get_irq_chip_data(virq);
+	struct mpc52xx_gpt_priv *gpt = get_irq_chip_data(d->irq);
 	unsigned long flags;
 
 	spin_lock_irqsave(&gpt->lock, flags);
@@ -155,20 +155,20 @@ static void mpc52xx_gpt_irq_mask(unsigned int virq)
 	spin_unlock_irqrestore(&gpt->lock, flags);
 }
 
-static void mpc52xx_gpt_irq_ack(unsigned int virq)
+static void mpc52xx_gpt_irq_ack(struct irq_data *d)
 {
-	struct mpc52xx_gpt_priv *gpt = get_irq_chip_data(virq);
+	struct mpc52xx_gpt_priv *gpt = get_irq_chip_data(d->irq);
 
 	out_be32(&gpt->regs->status, MPC52xx_GPT_STATUS_IRQMASK);
 }
 
-static int mpc52xx_gpt_irq_set_type(unsigned int virq, unsigned int flow_type)
+static int mpc52xx_gpt_irq_set_type(struct irq_data *d, unsigned int flow_type)
 {
-	struct mpc52xx_gpt_priv *gpt = get_irq_chip_data(virq);
+	struct mpc52xx_gpt_priv *gpt = get_irq_chip_data(d->irq);
 	unsigned long flags;
 	u32 reg;
 
-	dev_dbg(gpt->dev, "%s: virq=%i type=%x\n", __func__, virq, flow_type);
+	dev_dbg(gpt->dev, "%s: virq=%i type=%x\n", __func__, d->irq, flow_type);
 
 	spin_lock_irqsave(&gpt->lock, flags);
 	reg = in_be32(&gpt->regs->mode) & ~MPC52xx_GPT_MODE_ICT_MASK;
@@ -184,10 +184,10 @@ static int mpc52xx_gpt_irq_set_type(unsigned int virq, unsigned int flow_type)
 
 static struct irq_chip mpc52xx_gpt_irq_chip = {
 	.name = "MPC52xx GPT",
-	.unmask = mpc52xx_gpt_irq_unmask,
-	.mask = mpc52xx_gpt_irq_mask,
-	.ack = mpc52xx_gpt_irq_ack,
-	.set_type = mpc52xx_gpt_irq_set_type,
+	.irq_unmask = mpc52xx_gpt_irq_unmask,
+	.irq_mask = mpc52xx_gpt_irq_mask,
+	.irq_ack = mpc52xx_gpt_irq_ack,
+	.irq_set_type = mpc52xx_gpt_irq_set_type,
 };
 
 void mpc52xx_gpt_irq_cascade(unsigned int virq, struct irq_desc *desc)
diff --git a/arch/powerpc/platforms/52xx/mpc52xx_pic.c b/arch/powerpc/platforms/52xx/mpc52xx_pic.c
index 4bf4bf7..9f3ed58 100644
--- a/arch/powerpc/platforms/52xx/mpc52xx_pic.c
+++ b/arch/powerpc/platforms/52xx/mpc52xx_pic.c
@@ -155,47 +155,47 @@ static inline void io_be_clrbit(u32 __iomem *addr, int bitno)
 /*
  * IRQ[0-3] interrupt irq_chip
  */
-static void mpc52xx_extirq_mask(unsigned int virq)
+static void mpc52xx_extirq_mask(struct irq_data *d)
 {
 	int irq;
 	int l2irq;
 
-	irq = irq_map[virq].hwirq;
+	irq = irq_map[d->irq].hwirq;
 	l2irq = irq & MPC52xx_IRQ_L2_MASK;
 
 	io_be_clrbit(&intr->ctrl, 11 - l2irq);
 }
 
-static void mpc52xx_extirq_unmask(unsigned int virq)
+static void mpc52xx_extirq_unmask(struct irq_data *d)
 {
 	int irq;
 	int l2irq;
 
-	irq = irq_map[virq].hwirq;
+	irq = irq_map[d->irq].hwirq;
 	l2irq = irq & MPC52xx_IRQ_L2_MASK;
 
 	io_be_setbit(&intr->ctrl, 11 - l2irq);
 }
 
-static void mpc52xx_extirq_ack(unsigned int virq)
+static void mpc52xx_extirq_ack(struct irq_data *d)
 {
 	int irq;
 	int l2irq;
 
-	irq = irq_map[virq].hwirq;
+	irq = irq_map[d->irq].hwirq;
 	l2irq = irq & MPC52xx_IRQ_L2_MASK;
 
 	io_be_setbit(&intr->ctrl, 27-l2irq);
 }
 
-static int mpc52xx_extirq_set_type(unsigned int virq, unsigned int flow_type)
+static int mpc52xx_extirq_set_type(struct irq_data *d, unsigned int flow_type)
 {
 	u32 ctrl_reg, type;
 	int irq;
 	int l2irq;
 	void *handler = handle_level_irq;
 
-	irq = irq_map[virq].hwirq;
+	irq = irq_map[d->irq].hwirq;
 	l2irq = irq & MPC52xx_IRQ_L2_MASK;
 
 	pr_debug("%s: irq=%x. l2=%d flow_type=%d\n", __func__, irq, l2irq, flow_type);
@@ -214,44 +214,44 @@ static int mpc52xx_extirq_set_type(unsigned int virq, unsigned int flow_type)
 	ctrl_reg |= (type << (22 - (l2irq * 2)));
 	out_be32(&intr->ctrl, ctrl_reg);
 
-	__set_irq_handler_unlocked(virq, handler);
+	__set_irq_handler_unlocked(d->irq, handler);
 
 	return 0;
 }
 
 static struct irq_chip mpc52xx_extirq_irqchip = {
 	.name = "MPC52xx External",
-	.mask = mpc52xx_extirq_mask,
-	.unmask = mpc52xx_extirq_unmask,
-	.ack = mpc52xx_extirq_ack,
-	.set_type = mpc52xx_extirq_set_type,
+	.irq_mask = mpc52xx_extirq_mask,
+	.irq_unmask = mpc52xx_extirq_unmask,
+	.irq_ack = mpc52xx_extirq_ack,
+	.irq_set_type = mpc52xx_extirq_set_type,
 };
 
 /*
  * Main interrupt irq_chip
  */
-static int mpc52xx_null_set_type(unsigned int virq, unsigned int flow_type)
+static int mpc52xx_null_set_type(struct irq_data *d, unsigned int flow_type)
 {
 	return 0; /* Do nothing so that the sense mask will get updated */
 }
 
-static void mpc52xx_main_mask(unsigned int virq)
+static void mpc52xx_main_mask(struct irq_data *d)
 {
 	int irq;
 	int l2irq;
 
-	irq = irq_map[virq].hwirq;
+	irq = irq_map[d->irq].hwirq;
 	l2irq = irq & MPC52xx_IRQ_L2_MASK;
 
 	io_be_setbit(&intr->main_mask, 16 - l2irq);
 }
 
-static void mpc52xx_main_unmask(unsigned int virq)
+static void mpc52xx_main_unmask(struct irq_data *d)
 {
 	int irq;
 	int l2irq;
 
-	irq = irq_map[virq].hwirq;
+	irq = irq_map[d->irq].hwirq;
 	l2irq = irq & MPC52xx_IRQ_L2_MASK;
 
 	io_be_clrbit(&intr->main_mask, 16 - l2irq);
@@ -259,32 +259,32 @@ static void mpc52xx_main_unmask(unsigned int virq)
 
 static struct irq_chip mpc52xx_main_irqchip = {
 	.name = "MPC52xx Main",
-	.mask = mpc52xx_main_mask,
-	.mask_ack = mpc52xx_main_mask,
-	.unmask = mpc52xx_main_unmask,
-	.set_type = mpc52xx_null_set_type,
+	.irq_mask = mpc52xx_main_mask,
+	.irq_mask_ack = mpc52xx_main_mask,
+	.irq_unmask = mpc52xx_main_unmask,
+	.irq_set_type = mpc52xx_null_set_type,
 };
 
 /*
  * Peripherals interrupt irq_chip
  */
-static void mpc52xx_periph_mask(unsigned int virq)
+static void mpc52xx_periph_mask(struct irq_data *d)
 {
 	int irq;
 	int l2irq;
 
-	irq = irq_map[virq].hwirq;
+	irq = irq_map[d->irq].hwirq;
 	l2irq = irq & MPC52xx_IRQ_L2_MASK;
 
 	io_be_setbit(&intr->per_mask, 31 - l2irq);
 }
 
-static void mpc52xx_periph_unmask(unsigned int virq)
+static void mpc52xx_periph_unmask(struct irq_data *d)
 {
 	int irq;
 	int l2irq;
 
-	irq = irq_map[virq].hwirq;
+	irq = irq_map[d->irq].hwirq;
 	l2irq = irq & MPC52xx_IRQ_L2_MASK;
 
 	io_be_clrbit(&intr->per_mask, 31 - l2irq);
@@ -292,43 +292,43 @@ static void mpc52xx_periph_unmask(unsigned int virq)
 
 static struct irq_chip mpc52xx_periph_irqchip = {
 	.name = "MPC52xx Peripherals",
-	.mask = mpc52xx_periph_mask,
-	.mask_ack = mpc52xx_periph_mask,
-	.unmask = mpc52xx_periph_unmask,
-	.set_type = mpc52xx_null_set_type,
+	.irq_mask = mpc52xx_periph_mask,
+	.irq_mask_ack = mpc52xx_periph_mask,
+	.irq_unmask = mpc52xx_periph_unmask,
+	.irq_set_type = mpc52xx_null_set_type,
 };
 
 /*
  * SDMA interrupt irq_chip
  */
-static void mpc52xx_sdma_mask(unsigned int virq)
+static void mpc52xx_sdma_mask(struct irq_data *d)
 {
 	int irq;
 	int l2irq;
 
-	irq = irq_map[virq].hwirq;
+	irq = irq_map[d->irq].hwirq;
 	l2irq = irq & MPC52xx_IRQ_L2_MASK;
 
 	io_be_setbit(&sdma->IntMask, l2irq);
 }
 
-static void mpc52xx_sdma_unmask(unsigned int virq)
+static void mpc52xx_sdma_unmask(struct irq_data *d)
 {
 	int irq;
 	int l2irq;
 
-	irq = irq_map[virq].hwirq;
+	irq = irq_map[d->irq].hwirq;
 	l2irq = irq & MPC52xx_IRQ_L2_MASK;
 
 	io_be_clrbit(&sdma->IntMask, l2irq);
 }
 
-static void mpc52xx_sdma_ack(unsigned int virq)
+static void mpc52xx_sdma_ack(struct irq_data *d)
 {
 	int irq;
 	int l2irq;
 
-	irq = irq_map[virq].hwirq;
+	irq = irq_map[d->irq].hwirq;
 	l2irq = irq & MPC52xx_IRQ_L2_MASK;
 
 	out_be32(&sdma->IntPend, 1 << l2irq);
@@ -336,10 +336,10 @@ static void mpc52xx_sdma_ack(unsigned int virq)
 
 static struct irq_chip mpc52xx_sdma_irqchip = {
 	.name = "MPC52xx SDMA",
-	.mask = mpc52xx_sdma_mask,
-	.unmask = mpc52xx_sdma_unmask,
-	.ack = mpc52xx_sdma_ack,
-	.set_type = mpc52xx_null_set_type,
+	.irq_mask = mpc52xx_sdma_mask,
+	.irq_unmask = mpc52xx_sdma_unmask,
+	.irq_ack = mpc52xx_sdma_ack,
+	.irq_set_type = mpc52xx_null_set_type,
 };
 
 /**
-- 
1.7.4

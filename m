Return-Path: <buytenh@wantstofly.org>
Received: from mail.wantstofly.org (fw.wantstofly.org [80.101.37.227])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id C3B6FB77AF
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue,  8 Mar 2011 10:59:32 +1100 (EST)
Date: Tue, 8 Mar 2011 00:59:28 +0100
From: Lennert Buytenhek <buytenh@wantstofly.org>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 08/28] powerpc: platforms/cell irq_data conversion.
Message-ID: <20110307235928.GM16649@mail.wantstofly.org>
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
 arch/powerpc/platforms/cell/axon_msi.c       |    3 +-
 arch/powerpc/platforms/cell/beat_interrupt.c |   36 +++++++++++-----------
 arch/powerpc/platforms/cell/interrupt.c      |   30 ++++++++++--------
 arch/powerpc/platforms/cell/setup.c          |    6 ++-
 arch/powerpc/platforms/cell/spider-pic.c     |   43 ++++++++++++++------------
 5 files changed, 64 insertions(+), 54 deletions(-)

diff --git a/arch/powerpc/platforms/cell/axon_msi.c b/arch/powerpc/platforms/cell/axon_msi.c
index e3e379c..c07930f 100644
--- a/arch/powerpc/platforms/cell/axon_msi.c
+++ b/arch/powerpc/platforms/cell/axon_msi.c
@@ -93,6 +93,7 @@ static void msic_dcr_write(struct axon_msic *msic, unsigned int dcr_n, u32 val)
 
 static void axon_msi_cascade(unsigned int irq, struct irq_desc *desc)
 {
+	struct irq_chip *chip = get_irq_desc_chip(desc);
 	struct axon_msic *msic = get_irq_data(irq);
 	u32 write_offset, msi;
 	int idx;
@@ -145,7 +146,7 @@ static void axon_msi_cascade(unsigned int irq, struct irq_desc *desc)
 		msic->read_offset &= MSIC_FIFO_SIZE_MASK;
 	}
 
-	desc->chip->eoi(irq);
+	chip->irq_eoi(&desc->irq_data);
 }
 
 static struct axon_msic *find_msi_translator(struct pci_dev *dev)
diff --git a/arch/powerpc/platforms/cell/beat_interrupt.c b/arch/powerpc/platforms/cell/beat_interrupt.c
index 682af97..0b8f7d7 100644
--- a/arch/powerpc/platforms/cell/beat_interrupt.c
+++ b/arch/powerpc/platforms/cell/beat_interrupt.c
@@ -61,59 +61,59 @@ static inline void beatic_update_irq_mask(unsigned int irq_plug)
 		panic("Failed to set mask IRQ!");
 }
 
-static void beatic_mask_irq(unsigned int irq_plug)
+static void beatic_mask_irq(struct irq_data *d)
 {
 	unsigned long flags;
 
 	raw_spin_lock_irqsave(&beatic_irq_mask_lock, flags);
-	beatic_irq_mask_enable[irq_plug/64] &= ~(1UL << (63 - (irq_plug%64)));
-	beatic_update_irq_mask(irq_plug);
+	beatic_irq_mask_enable[d->irq/64] &= ~(1UL << (63 - (d->irq%64)));
+	beatic_update_irq_mask(d->irq);
 	raw_spin_unlock_irqrestore(&beatic_irq_mask_lock, flags);
 }
 
-static void beatic_unmask_irq(unsigned int irq_plug)
+static void beatic_unmask_irq(struct irq_data *d)
 {
 	unsigned long flags;
 
 	raw_spin_lock_irqsave(&beatic_irq_mask_lock, flags);
-	beatic_irq_mask_enable[irq_plug/64] |= 1UL << (63 - (irq_plug%64));
-	beatic_update_irq_mask(irq_plug);
+	beatic_irq_mask_enable[d->irq/64] |= 1UL << (63 - (d->irq%64));
+	beatic_update_irq_mask(d->irq);
 	raw_spin_unlock_irqrestore(&beatic_irq_mask_lock, flags);
 }
 
-static void beatic_ack_irq(unsigned int irq_plug)
+static void beatic_ack_irq(struct irq_data *d)
 {
 	unsigned long flags;
 
 	raw_spin_lock_irqsave(&beatic_irq_mask_lock, flags);
-	beatic_irq_mask_ack[irq_plug/64] &= ~(1UL << (63 - (irq_plug%64)));
-	beatic_update_irq_mask(irq_plug);
+	beatic_irq_mask_ack[d->irq/64] &= ~(1UL << (63 - (d->irq%64)));
+	beatic_update_irq_mask(d->irq);
 	raw_spin_unlock_irqrestore(&beatic_irq_mask_lock, flags);
 }
 
-static void beatic_end_irq(unsigned int irq_plug)
+static void beatic_end_irq(struct irq_data *d)
 {
 	s64 err;
 	unsigned long flags;
 
-	err = beat_downcount_of_interrupt(irq_plug);
+	err = beat_downcount_of_interrupt(d->irq);
 	if (err != 0) {
 		if ((err & 0xFFFFFFFF) != 0xFFFFFFF5) /* -11: wrong state */
 			panic("Failed to downcount IRQ! Error = %16llx", err);
 
-		printk(KERN_ERR "IRQ over-downcounted, plug %d\n", irq_plug);
+		printk(KERN_ERR "IRQ over-downcounted, plug %d\n", d->irq);
 	}
 	raw_spin_lock_irqsave(&beatic_irq_mask_lock, flags);
-	beatic_irq_mask_ack[irq_plug/64] |= 1UL << (63 - (irq_plug%64));
-	beatic_update_irq_mask(irq_plug);
+	beatic_irq_mask_ack[d->irq/64] |= 1UL << (63 - (d->irq%64));
+	beatic_update_irq_mask(d->irq);
 	raw_spin_unlock_irqrestore(&beatic_irq_mask_lock, flags);
 }
 
 static struct irq_chip beatic_pic = {
 	.name = "CELL-BEAT",
-	.unmask = beatic_unmask_irq,
-	.mask = beatic_mask_irq,
-	.eoi = beatic_end_irq,
+	.irq_unmask = beatic_unmask_irq,
+	.irq_mask = beatic_mask_irq,
+	.irq_eoi = beatic_end_irq,
 };
 
 /*
@@ -232,7 +232,7 @@ unsigned int beatic_get_irq(void)
 
 	ret = beatic_get_irq_plug();
 	if (ret != NO_IRQ)
-		beatic_ack_irq(ret);
+		beatic_ack_irq(irq_get_irq_data(ret));
 	return ret;
 }
 
diff --git a/arch/powerpc/platforms/cell/interrupt.c b/arch/powerpc/platforms/cell/interrupt.c
index 10eb1a4..624d26e 100644
--- a/arch/powerpc/platforms/cell/interrupt.c
+++ b/arch/powerpc/platforms/cell/interrupt.c
@@ -72,15 +72,15 @@ static irq_hw_number_t iic_pending_to_hwnum(struct cbe_iic_pending_bits bits)
 		return (node << IIC_IRQ_NODE_SHIFT) | (class << 4) | unit;
 }
 
-static void iic_mask(unsigned int irq)
+static void iic_mask(struct irq_data *d)
 {
 }
 
-static void iic_unmask(unsigned int irq)
+static void iic_unmask(struct irq_data *d)
 {
 }
 
-static void iic_eoi(unsigned int irq)
+static void iic_eoi(struct irq_data *d)
 {
 	struct iic *iic = &__get_cpu_var(cpu_iic);
 	out_be64(&iic->regs->prio, iic->eoi_stack[--iic->eoi_ptr]);
@@ -89,19 +89,21 @@ static void iic_eoi(unsigned int irq)
 
 static struct irq_chip iic_chip = {
 	.name = "CELL-IIC",
-	.mask = iic_mask,
-	.unmask = iic_unmask,
-	.eoi = iic_eoi,
+	.irq_mask = iic_mask,
+	.irq_unmask = iic_unmask,
+	.irq_eoi = iic_eoi,
 };
 
 
-static void iic_ioexc_eoi(unsigned int irq)
+static void iic_ioexc_eoi(struct irq_data *d)
 {
 }
 
 static void iic_ioexc_cascade(unsigned int irq, struct irq_desc *desc)
 {
-	struct cbe_iic_regs __iomem *node_iic = (void __iomem *)desc->handler_data;
+	struct irq_chip *chip = get_irq_desc_chip(desc);
+	struct cbe_iic_regs __iomem *node_iic =
+		(void __iomem *)get_irq_desc_data(desc);
 	unsigned int base = (irq & 0xffffff00) | IIC_IRQ_TYPE_IOEXC;
 	unsigned long bits, ack;
 	int cascade;
@@ -128,15 +130,15 @@ static void iic_ioexc_cascade(unsigned int irq, struct irq_desc *desc)
 		if (ack)
 			out_be64(&node_iic->iic_is, ack);
 	}
-	desc->chip->eoi(irq);
+	chip->irq_eoi(&desc->irq_data);
 }
 
 
 static struct irq_chip iic_ioexc_chip = {
 	.name = "CELL-IOEX",
-	.mask = iic_mask,
-	.unmask = iic_unmask,
-	.eoi = iic_ioexc_eoi,
+	.irq_mask = iic_mask,
+	.irq_unmask = iic_unmask,
+	.irq_eoi = iic_ioexc_eoi,
 };
 
 /* Get an IRQ number from the pending state register of the IIC */
@@ -237,6 +239,8 @@ extern int noirqdebug;
 
 static void handle_iic_irq(unsigned int irq, struct irq_desc *desc)
 {
+	struct irq_chip *chip = get_irq_desc_chip(desc);
+
 	raw_spin_lock(&desc->lock);
 
 	desc->status &= ~(IRQ_REPLAY | IRQ_WAITING);
@@ -275,7 +279,7 @@ static void handle_iic_irq(unsigned int irq, struct irq_desc *desc)
 
 	desc->status &= ~IRQ_INPROGRESS;
 out_eoi:
-	desc->chip->eoi(irq);
+	chip->irq_eoi(&desc->irq_data);
 	raw_spin_unlock(&desc->lock);
 }
 
diff --git a/arch/powerpc/platforms/cell/setup.c b/arch/powerpc/platforms/cell/setup.c
index 6919957..6a28d02 100644
--- a/arch/powerpc/platforms/cell/setup.c
+++ b/arch/powerpc/platforms/cell/setup.c
@@ -187,13 +187,15 @@ machine_subsys_initcall(cell, cell_publish_devices);
 
 static void cell_mpic_cascade(unsigned int irq, struct irq_desc *desc)
 {
-	struct mpic *mpic = desc->handler_data;
+	struct irq_chip *chip = get_irq_desc_chip(desc);
+	struct mpic *mpic = get_irq_desc_data(desc);
 	unsigned int virq;
 
 	virq = mpic_get_one_irq(mpic);
 	if (virq != NO_IRQ)
 		generic_handle_irq(virq);
-	desc->chip->eoi(irq);
+
+	chip->irq_eoi(&desc->irq_data);
 }
 
 static void __init mpic_init_IRQ(void)
diff --git a/arch/powerpc/platforms/cell/spider-pic.c b/arch/powerpc/platforms/cell/spider-pic.c
index 3f2e557..b38cdfc 100644
--- a/arch/powerpc/platforms/cell/spider-pic.c
+++ b/arch/powerpc/platforms/cell/spider-pic.c
@@ -79,30 +79,30 @@ static void __iomem *spider_get_irq_config(struct spider_pic *pic,
 	return pic->regs + TIR_CFGA + 8 * src;
 }
 
-static void spider_unmask_irq(unsigned int virq)
+static void spider_unmask_irq(struct irq_data *d)
 {
-	struct spider_pic *pic = spider_virq_to_pic(virq);
-	void __iomem *cfg = spider_get_irq_config(pic, irq_map[virq].hwirq);
+	struct spider_pic *pic = spider_virq_to_pic(d->irq);
+	void __iomem *cfg = spider_get_irq_config(pic, irq_map[d->irq].hwirq);
 
 	out_be32(cfg, in_be32(cfg) | 0x30000000u);
 }
 
-static void spider_mask_irq(unsigned int virq)
+static void spider_mask_irq(struct irq_data *d)
 {
-	struct spider_pic *pic = spider_virq_to_pic(virq);
-	void __iomem *cfg = spider_get_irq_config(pic, irq_map[virq].hwirq);
+	struct spider_pic *pic = spider_virq_to_pic(d->irq);
+	void __iomem *cfg = spider_get_irq_config(pic, irq_map[d->irq].hwirq);
 
 	out_be32(cfg, in_be32(cfg) & ~0x30000000u);
 }
 
-static void spider_ack_irq(unsigned int virq)
+static void spider_ack_irq(struct irq_data *d)
 {
-	struct spider_pic *pic = spider_virq_to_pic(virq);
-	unsigned int src = irq_map[virq].hwirq;
+	struct spider_pic *pic = spider_virq_to_pic(d->irq);
+	unsigned int src = irq_map[d->irq].hwirq;
 
 	/* Reset edge detection logic if necessary
 	 */
-	if (irq_to_desc(virq)->status & IRQ_LEVEL)
+	if (irq_to_desc(d->irq)->status & IRQ_LEVEL)
 		return;
 
 	/* Only interrupts 47 to 50 can be set to edge */
@@ -113,13 +113,13 @@ static void spider_ack_irq(unsigned int virq)
 	out_be32(pic->regs + TIR_EDC, 0x100 | (src & 0xf));
 }
 
-static int spider_set_irq_type(unsigned int virq, unsigned int type)
+static int spider_set_irq_type(struct irq_data *d, unsigned int type)
 {
 	unsigned int sense = type & IRQ_TYPE_SENSE_MASK;
-	struct spider_pic *pic = spider_virq_to_pic(virq);
-	unsigned int hw = irq_map[virq].hwirq;
+	struct spider_pic *pic = spider_virq_to_pic(d->irq);
+	unsigned int hw = irq_map[d->irq].hwirq;
 	void __iomem *cfg = spider_get_irq_config(pic, hw);
-	struct irq_desc *desc = irq_to_desc(virq);
+	struct irq_desc *desc = irq_to_desc(d->irq);
 	u32 old_mask;
 	u32 ic;
 
@@ -169,10 +169,10 @@ static int spider_set_irq_type(unsigned int virq, unsigned int type)
 
 static struct irq_chip spider_pic = {
 	.name = "SPIDER",
-	.unmask = spider_unmask_irq,
-	.mask = spider_mask_irq,
-	.ack = spider_ack_irq,
-	.set_type = spider_set_irq_type,
+	.irq_unmask = spider_unmask_irq,
+	.irq_mask = spider_mask_irq,
+	.irq_ack = spider_ack_irq,
+	.irq_set_type = spider_set_irq_type,
 };
 
 static int spider_host_map(struct irq_host *h, unsigned int virq,
@@ -207,7 +207,8 @@ static struct irq_host_ops spider_host_ops = {
 
 static void spider_irq_cascade(unsigned int irq, struct irq_desc *desc)
 {
-	struct spider_pic *pic = desc->handler_data;
+	struct irq_chip *chip = get_irq_desc_chip(desc);
+	struct spider_pic *pic = get_irq_desc_data(desc);
 	unsigned int cs, virq;
 
 	cs = in_be32(pic->regs + TIR_CS) >> 24;
@@ -215,9 +216,11 @@ static void spider_irq_cascade(unsigned int irq, struct irq_desc *desc)
 		virq = NO_IRQ;
 	else
 		virq = irq_linear_revmap(pic->host, cs);
+
 	if (virq != NO_IRQ)
 		generic_handle_irq(virq);
-	desc->chip->eoi(irq);
+
+	chip->irq_eoi(&desc->irq_data);
 }
 
 /* For hooking up the cascace we have a problem. Our device-tree is
-- 
1.7.4

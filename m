Return-Path: <glikely@secretlab.ca>
Received: from rn-out-0910.google.com (rn-out-0910.google.com [64.233.170.187])
	by ozlabs.org (Postfix) with ESMTP id 3AAEFDE007
	for <linuxppc-dev@ozlabs.org>; Thu, 22 Jan 2009 07:55:44 +1100 (EST)
Received: by rn-out-0910.google.com with SMTP id j67so462393rne.16
	for <linuxppc-dev@ozlabs.org>; Wed, 21 Jan 2009 12:55:44 -0800 (PST)
Sender: Grant Likely <glikely@secretlab.ca>
From: Grant Likely <grant.likely@secretlab.ca>
Subject: [PATCH 7/8] powerpc/5200: Refactor mpc5200 interrupt controller driver
To: linuxppc-dev@ozlabs.org
Date: Wed, 21 Jan 2009 13:55:41 -0700
Message-ID: <20090121205540.31232.77034.stgit@localhost.localdomain>
In-Reply-To: <20090121205506.31232.27908.stgit@localhost.localdomain>
References: <20090121205506.31232.27908.stgit@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Grant Likely <grant.likely@secretlab.ca>

Rework the mpc5200-pic driver to simplify it and fix up the setting
of desc->status when set_type is called for internal IRQs (so they
are reported as level, not edge).  The simplification is due to
splitting off the handling of external IRQs into a separate block
so they don't need to be handled as exceptions in the normal
CRIT, MAIN and PERP paths.

Signed-off-by: Grant Likely <grant.likely@secretlab.ca>
CC: Wolfram Sang <w.sang@pengutronix.de>
---

 arch/powerpc/platforms/52xx/mpc52xx_pic.c |  145 ++++++++++++-----------------
 1 files changed, 58 insertions(+), 87 deletions(-)


diff --git a/arch/powerpc/platforms/52xx/mpc52xx_pic.c b/arch/powerpc/platforms/52xx/mpc52xx_pic.c
index c0a9559..277c9c5 100644
--- a/arch/powerpc/platforms/52xx/mpc52xx_pic.c
+++ b/arch/powerpc/platforms/52xx/mpc52xx_pic.c
@@ -190,10 +190,10 @@ static void mpc52xx_extirq_ack(unsigned int virq)
 
 static int mpc52xx_extirq_set_type(unsigned int virq, unsigned int flow_type)
 {
-	struct irq_desc *desc = get_irq_desc(virq);
 	u32 ctrl_reg, type;
 	int irq;
 	int l2irq;
+	void *handler = handle_level_irq;
 
 	irq = irq_map[virq].hwirq;
 	l2irq = irq & MPC52xx_IRQ_L2_MASK;
@@ -201,32 +201,21 @@ static int mpc52xx_extirq_set_type(unsigned int virq, unsigned int flow_type)
 	pr_debug("%s: irq=%x. l2=%d flow_type=%d\n", __func__, irq, l2irq, flow_type);
 
 	switch (flow_type) {
-	case IRQF_TRIGGER_HIGH:
-		type = 0;
-		break;
-	case IRQF_TRIGGER_RISING:
-		type = 1;
-		break;
-	case IRQF_TRIGGER_FALLING:
-		type = 2;
-		break;
-	case IRQF_TRIGGER_LOW:
-		type = 3;
-		break;
+	case IRQF_TRIGGER_HIGH: type = 0; break;
+	case IRQF_TRIGGER_RISING: type = 1; handler = handle_edge_irq; break;
+	case IRQF_TRIGGER_FALLING: type = 2; handler = handle_edge_irq; break;
+	case IRQF_TRIGGER_LOW: type = 3; break;
 	default:
 		type = 0;
 	}
 
-	desc->status &= ~(IRQ_TYPE_SENSE_MASK | IRQ_LEVEL);
-	desc->status |= flow_type & IRQ_TYPE_SENSE_MASK;
-	if (flow_type & (IRQ_TYPE_LEVEL_HIGH | IRQ_TYPE_LEVEL_LOW))
-		desc->status |= IRQ_LEVEL;
-
 	ctrl_reg = in_be32(&intr->ctrl);
 	ctrl_reg &= ~(0x3 << (22 - (l2irq * 2)));
 	ctrl_reg |= (type << (22 - (l2irq * 2)));
 	out_be32(&intr->ctrl, ctrl_reg);
 
+	__set_irq_handler_unlocked(virq, handler);
+
 	return 0;
 }
 
@@ -241,6 +230,11 @@ static struct irq_chip mpc52xx_extirq_irqchip = {
 /*
  * Main interrupt irq_chip
  */
+static int mpc52xx_null_set_type(unsigned int virq, unsigned int flow_type)
+{
+	return 0; /* Do nothing so that the sense mask will get updated */
+}
+
 static void mpc52xx_main_mask(unsigned int virq)
 {
 	int irq;
@@ -268,6 +262,7 @@ static struct irq_chip mpc52xx_main_irqchip = {
 	.mask = mpc52xx_main_mask,
 	.mask_ack = mpc52xx_main_mask,
 	.unmask = mpc52xx_main_unmask,
+	.set_type = mpc52xx_null_set_type,
 };
 
 /*
@@ -300,6 +295,7 @@ static struct irq_chip mpc52xx_periph_irqchip = {
 	.mask = mpc52xx_periph_mask,
 	.mask_ack = mpc52xx_periph_mask,
 	.unmask = mpc52xx_periph_unmask,
+	.set_type = mpc52xx_null_set_type,
 };
 
 /*
@@ -343,9 +339,19 @@ static struct irq_chip mpc52xx_sdma_irqchip = {
 	.mask = mpc52xx_sdma_mask,
 	.unmask = mpc52xx_sdma_unmask,
 	.ack = mpc52xx_sdma_ack,
+	.set_type = mpc52xx_null_set_type,
 };
 
 /**
+ * mpc52xx_is_extirq - Returns true if hwirq number is for an external IRQ
+ */
+static int mpc52xx_is_extirq(int l1, int l2)
+{
+	return ((l1 == 0) && (l2 == 0)) ||
+	       ((l1 == 1) && (l2 >= 1) && (l2 <= 3));
+}
+
+/**
  * mpc52xx_irqhost_xlate - translate virq# from device tree interrupts property
  */
 static int mpc52xx_irqhost_xlate(struct irq_host *h, struct device_node *ct,
@@ -363,38 +369,23 @@ static int mpc52xx_irqhost_xlate(struct irq_host *h, struct device_node *ct,
 
 	intrvect_l1 = (int)intspec[0];
 	intrvect_l2 = (int)intspec[1];
-	intrvect_type = (int)intspec[2];
+	intrvect_type = (int)intspec[2] & 0x3;
 
 	intrvect_linux = (intrvect_l1 << MPC52xx_IRQ_L1_OFFSET) &
 			 MPC52xx_IRQ_L1_MASK;
 	intrvect_linux |= intrvect_l2 & MPC52xx_IRQ_L2_MASK;
 
-	pr_debug("return %x, l1=%d, l2=%d\n", intrvect_linux, intrvect_l1,
-		 intrvect_l2);
-
 	*out_hwirq = intrvect_linux;
-	*out_flags = mpc52xx_map_senses[intrvect_type];
+	*out_flags = IRQ_TYPE_LEVEL_LOW;
+	if (mpc52xx_is_extirq(intrvect_l1, intrvect_l2))
+		*out_flags = mpc52xx_map_senses[intrvect_type];
 
+	pr_debug("return %x, l1=%d, l2=%d\n", intrvect_linux, intrvect_l1,
+		 intrvect_l2);
 	return 0;
 }
 
 /**
- * mpc52xx_irqx_gettype - determine the IRQ sense type (level/edge)
- *
- * Only external IRQs need this.
- */
-static int mpc52xx_irqx_gettype(int irq)
-{
-	int type;
-	u32 ctrl_reg;
-
-	ctrl_reg = in_be32(&intr->ctrl);
-	type = (ctrl_reg >> (22 - irq * 2)) & 0x3;
-
-	return mpc52xx_map_senses[type];
-}
-
-/**
  * mpc52xx_irqhost_map - Hook to map from virq to an irq_chip structure
  */
 static int mpc52xx_irqhost_map(struct irq_host *h, unsigned int virq,
@@ -402,68 +393,46 @@ static int mpc52xx_irqhost_map(struct irq_host *h, unsigned int virq,
 {
 	int l1irq;
 	int l2irq;
-	struct irq_chip *good_irqchip;
+	struct irq_chip *irqchip;
 	void *good_handle;
 	int type;
+	u32 reg;
 
 	l1irq = (irq & MPC52xx_IRQ_L1_MASK) >> MPC52xx_IRQ_L1_OFFSET;
 	l2irq = irq & MPC52xx_IRQ_L2_MASK;
 
 	/*
-	 * Most of ours IRQs will be level low
-	 * Only external IRQs on some platform may be others
+	 * External IRQs are handled differently by the hardware so they are
+	 * handled by a dedicated irq_chip structure.
 	 */
-	type = IRQ_TYPE_LEVEL_LOW;
+	if (mpc52xx_is_extirq(l1irq, l2irq)) {
+		reg = in_be32(&intr->ctrl);
+		type = mpc52xx_map_senses[(reg >> (22 - l2irq * 2)) & 0x3];
+		if ((type == IRQ_TYPE_EDGE_FALLING) ||
+		    (type == IRQ_TYPE_EDGE_RISING))
+			good_handle = handle_edge_irq;
+		else
+			good_handle = handle_level_irq;
+
+		set_irq_chip_and_handler(virq, &mpc52xx_extirq_irqchip, good_handle);
+		pr_debug("%s: External IRQ%i virq=%x, hw=%x. type=%x\n",
+			 __func__, l2irq, virq, (int)irq, type);
+		return 0;
+	}
 
+	/* It is an internal SOC irq.  Choose the correct irq_chip */
 	switch (l1irq) {
-	case MPC52xx_IRQ_L1_CRIT:
-		pr_debug("%s: Critical. l2=%x\n", __func__, l2irq);
-
-		BUG_ON(l2irq != 0);
-
-		type = mpc52xx_irqx_gettype(l2irq);
-		good_irqchip = &mpc52xx_extirq_irqchip;
-		break;
-
-	case MPC52xx_IRQ_L1_MAIN:
-		pr_debug("%s: Main IRQ[1-3] l2=%x\n", __func__, l2irq);
-
-		if ((l2irq >= 1) && (l2irq <= 3)) {
-			type = mpc52xx_irqx_gettype(l2irq);
-			good_irqchip = &mpc52xx_extirq_irqchip;
-		} else {
-			good_irqchip = &mpc52xx_main_irqchip;
-		}
-		break;
-
-	case MPC52xx_IRQ_L1_PERP:
-		pr_debug("%s: Peripherals. l2=%x\n", __func__, l2irq);
-		good_irqchip = &mpc52xx_periph_irqchip;
-		break;
-
-	case MPC52xx_IRQ_L1_SDMA:
-		pr_debug("%s: SDMA. l2=%x\n", __func__, l2irq);
-		good_irqchip = &mpc52xx_sdma_irqchip;
-		break;
-
+	case MPC52xx_IRQ_L1_MAIN: irqchip = &mpc52xx_main_irqchip; break;
+	case MPC52xx_IRQ_L1_PERP: irqchip = &mpc52xx_periph_irqchip; break;
+	case MPC52xx_IRQ_L1_SDMA: irqchip = &mpc52xx_sdma_irqchip; break;
 	default:
-		pr_err("%s: invalid virq requested (0x%x)\n", __func__, virq);
+		pr_err("%s: invalid irq: virq=%i, l1=%i, l2=%i\n",
+		       __func__, virq, l1irq, l2irq);
 		return -EINVAL;
 	}
 
-	switch (type) {
-	case IRQ_TYPE_EDGE_FALLING:
-	case IRQ_TYPE_EDGE_RISING:
-		good_handle = handle_edge_irq;
-		break;
-	default:
-		good_handle = handle_level_irq;
-	}
-
-	set_irq_chip_and_handler(virq, good_irqchip, good_handle);
-
-	pr_debug("%s: virq=%x, hw=%x. type=%x\n", __func__, virq,
-		 (int)irq, type);
+	set_irq_chip_and_handler(virq, irqchip, handle_level_irq);
+	pr_debug("%s: virq=%x, l1=%i, l2=%i\n", __func__, virq, l1irq, l2irq);
 
 	return 0;
 }
@@ -502,6 +471,8 @@ void __init mpc52xx_init_irq(void)
 		panic(__FILE__	": find_and_map failed on 'mpc5200-bestcomm'. "
 				"Check node !");
 
+	pr_debug("MPC5200 IRQ controller mapped to 0x%p\n", intr);
+
 	/* Disable all interrupt sources. */
 	out_be32(&sdma->IntPend, 0xffffffff);	/* 1 means clear pending */
 	out_be32(&sdma->IntMask, 0xffffffff);	/* 1 means disabled */

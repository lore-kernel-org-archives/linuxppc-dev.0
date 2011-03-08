Return-Path: <buytenh@wantstofly.org>
Received: from mail.wantstofly.org (fw.wantstofly.org [80.101.37.227])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 64842B7E3C
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue,  8 Mar 2011 11:00:22 +1100 (EST)
Date: Tue, 8 Mar 2011 01:00:18 +0100
From: Lennert Buytenhek <buytenh@wantstofly.org>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 26/28] powerpc: sysdev/xilinx_intc irq_data conversion.
Message-ID: <20110308000018.GE16649@mail.wantstofly.org>
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
 arch/powerpc/sysdev/xilinx_intc.c |   48 +++++++++++++++++++-----------------
 1 files changed, 25 insertions(+), 23 deletions(-)

diff --git a/arch/powerpc/sysdev/xilinx_intc.c b/arch/powerpc/sysdev/xilinx_intc.c
index 1e0ccfa..0512f58 100644
--- a/arch/powerpc/sysdev/xilinx_intc.c
+++ b/arch/powerpc/sysdev/xilinx_intc.c
@@ -69,17 +69,17 @@ static unsigned char xilinx_intc_map_senses[] = {
  *
  * IRQ Chip common (across level and edge) operations
  */
-static void xilinx_intc_mask(unsigned int virq)
+static void xilinx_intc_mask(struct irq_data *d)
 {
-	int irq = virq_to_hw(virq);
-	void * regs = get_irq_chip_data(virq);
+	int irq = virq_to_hw(d->irq);
+	void * regs = get_irq_chip_data(d->irq);
 	pr_debug("mask: %d\n", irq);
 	out_be32(regs + XINTC_CIE, 1 << irq);
 }
 
-static int xilinx_intc_set_type(unsigned int virq, unsigned int flow_type)
+static int xilinx_intc_set_type(struct irq_data *d, unsigned int flow_type)
 {
-	struct irq_desc *desc = irq_to_desc(virq);
+	struct irq_desc *desc = irq_to_desc(d->irq);
 
 	desc->status &= ~(IRQ_TYPE_SENSE_MASK | IRQ_LEVEL);
 	desc->status |= flow_type & IRQ_TYPE_SENSE_MASK;
@@ -91,10 +91,10 @@ static int xilinx_intc_set_type(unsigned int virq, unsigned int flow_type)
 /*
  * IRQ Chip level operations
  */
-static void xilinx_intc_level_unmask(unsigned int virq)
+static void xilinx_intc_level_unmask(struct irq_data *d)
 {
-	int irq = virq_to_hw(virq);
-	void * regs = get_irq_chip_data(virq);
+	int irq = virq_to_hw(d->irq);
+	void * regs = get_irq_chip_data(d->irq);
 	pr_debug("unmask: %d\n", irq);
 	out_be32(regs + XINTC_SIE, 1 << irq);
 
@@ -107,37 +107,37 @@ static void xilinx_intc_level_unmask(unsigned int virq)
 
 static struct irq_chip xilinx_intc_level_irqchip = {
 	.name = "Xilinx Level INTC",
-	.mask = xilinx_intc_mask,
-	.mask_ack = xilinx_intc_mask,
-	.unmask = xilinx_intc_level_unmask,
-	.set_type = xilinx_intc_set_type,
+	.irq_mask = xilinx_intc_mask,
+	.irq_mask_ack = xilinx_intc_mask,
+	.irq_unmask = xilinx_intc_level_unmask,
+	.irq_set_type = xilinx_intc_set_type,
 };
 
 /*
  * IRQ Chip edge operations
  */
-static void xilinx_intc_edge_unmask(unsigned int virq)
+static void xilinx_intc_edge_unmask(struct irq_data *d)
 {
-	int irq = virq_to_hw(virq);
-	void *regs = get_irq_chip_data(virq);
+	int irq = virq_to_hw(d->irq);
+	void *regs = get_irq_chip_data(d->irq);
 	pr_debug("unmask: %d\n", irq);
 	out_be32(regs + XINTC_SIE, 1 << irq);
 }
 
-static void xilinx_intc_edge_ack(unsigned int virq)
+static void xilinx_intc_edge_ack(struct irq_data *d)
 {
-	int irq = virq_to_hw(virq);
-	void * regs = get_irq_chip_data(virq);
+	int irq = virq_to_hw(d->irq);
+	void * regs = get_irq_chip_data(d->irq);
 	pr_debug("ack: %d\n", irq);
 	out_be32(regs + XINTC_IAR, 1 << irq);
 }
 
 static struct irq_chip xilinx_intc_edge_irqchip = {
 	.name = "Xilinx Edge  INTC",
-	.mask = xilinx_intc_mask,
-	.unmask = xilinx_intc_edge_unmask,
-	.ack = xilinx_intc_edge_ack,
-	.set_type = xilinx_intc_set_type,
+	.irq_mask = xilinx_intc_mask,
+	.irq_unmask = xilinx_intc_edge_unmask,
+	.irq_ack = xilinx_intc_edge_ack,
+	.irq_set_type = xilinx_intc_set_type,
 };
 
 /*
@@ -229,12 +229,14 @@ int xilinx_intc_get_irq(void)
  */
 static void xilinx_i8259_cascade(unsigned int irq, struct irq_desc *desc)
 {
+	struct irq_chip *chip = get_irq_desc_chip(desc);
 	unsigned int cascade_irq = i8259_irq();
+
 	if (cascade_irq)
 		generic_handle_irq(cascade_irq);
 
 	/* Let xilinx_intc end the interrupt */
-	desc->chip->unmask(irq);
+	chip->irq_unmask(&desc->irq_data);
 }
 
 static void __init xilinx_i8259_setup_cascade(void)
-- 
1.7.4

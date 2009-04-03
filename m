Return-Path: <John.Linn@xilinx.com>
Received: from SG2EHSOBE005.bigfish.com (outbound-sin.frontbridge.com
	[207.46.51.80]) by ozlabs.org (Postfix) with ESMTP id EDA76DDDF6
	for <linuxppc-dev@ozlabs.org>; Sat,  4 Apr 2009 09:55:24 +1100 (EST)
From: John Linn <john.linn@xilinx.com>
To: grant.likely@secretlab.ca, linuxppc-dev@ozlabs.org,
	jwboyer@linux.vnet.ibm.com
Subject: [PATCH] Powerpc: Xilinx: Intc: Fix level irqs which have duplicates
Date: Fri, 3 Apr 2009 16:55:08 -0600
Message-ID: <20090403225517.26D941870050@mail94-sin.bigfish.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: John Linn <john.linn@xilinx.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

The interrupt controller was not handling level interrupts correctly
such that duplicate interrupts were happening. This fixes the problem
and adds edge type interrupts which are needed in Xilinx hardware.

Signed-off-by: John Linn <john.linn@xilinx.com>
---
 arch/powerpc/sysdev/xilinx_intc.c |  112 ++++++++++++++++++++++++++++++++++---
 1 files changed, 103 insertions(+), 9 deletions(-)

diff --git a/arch/powerpc/sysdev/xilinx_intc.c b/arch/powerpc/sysdev/xilinx_intc.c
index a22e1a2..7c99a1e 100644
--- a/arch/powerpc/sysdev/xilinx_intc.c
+++ b/arch/powerpc/sysdev/xilinx_intc.c
@@ -41,8 +41,30 @@
 
 static struct irq_host *master_irqhost;
 
+/* The following table allows the interrupt type, edge or level,
+ * to be cached after being read from the device tree until the interrupt
+ * is mapped
+ */
+static int xilinx_intc_typetable[32];
+
+/* Map the interrupt type from the device tree to the interrupt types
+ * used by the interrupt subsystem
+ */
+static unsigned char xilinx_intc_map_senses[] = {
+	IRQ_TYPE_EDGE_RISING,
+	IRQ_TYPE_EDGE_FALLING,
+	IRQ_TYPE_LEVEL_HIGH,
+	IRQ_TYPE_LEVEL_LOW,
+};
+
 /*
- * IRQ Chip operations
+ * The interrupt controller is setup such that it doesn't work well with
+ * the level interrupt handler in the kernel because the handler acks the
+ * interrupt before calling the application interrupt handler. To deal with
+ * that, we use 2 different irq chips so that different functions can be
+ * used for level and edge type interrupts.
+ *
+ * IRQ Chip common (across level and edge) operations
  */
 static void xilinx_intc_mask(unsigned int virq)
 {
@@ -52,15 +74,54 @@ static void xilinx_intc_mask(unsigned int virq)
 	out_be32(regs + XINTC_CIE, 1 << irq);
 }
 
-static void xilinx_intc_unmask(unsigned int virq)
+static int xilinx_intc_set_type(unsigned int virq, unsigned int flow_type)
+{
+	struct irq_desc *desc = get_irq_desc(virq);
+
+	desc->status &= ~(IRQ_TYPE_SENSE_MASK | IRQ_LEVEL);
+	desc->status |= flow_type & IRQ_TYPE_SENSE_MASK;
+	if (flow_type & (IRQ_TYPE_LEVEL_HIGH | IRQ_TYPE_LEVEL_LOW))
+		desc->status |= IRQ_LEVEL;
+	return 0;
+}
+
+/*
+ * IRQ Chip level operations
+ */
+static void xilinx_intc_level_unmask(unsigned int virq)
 {
 	int irq = virq_to_hw(virq);
 	void * regs = get_irq_chip_data(virq);
 	pr_debug("unmask: %d\n", irq);
 	out_be32(regs + XINTC_SIE, 1 << irq);
+
+	/* ack level irqs because they can't be acked during
+	 * ack function since the handle_level_irq function
+	 * acks the irq before calling the inerrupt handler
+	 */
+	out_be32(regs + XINTC_IAR, 1 << irq);
+}
+
+static struct irq_chip xilinx_intc_level_irqchip = {
+	.typename = "Xilinx Level INTC",
+	.mask = xilinx_intc_mask,
+	.mask_ack = xilinx_intc_mask,
+	.unmask = xilinx_intc_level_unmask,
+	.set_type = xilinx_intc_set_type,
+};
+
+/*
+ * IRQ Chip edge operations
+ */
+static void xilinx_intc_edge_unmask(unsigned int virq)
+{
+	int irq = virq_to_hw(virq);
+	void *regs = get_irq_chip_data(virq);
+	pr_debug("unmask: %d\n", irq);
+	out_be32(regs + XINTC_SIE, 1 << irq);
 }
 
-static void xilinx_intc_ack(unsigned int virq)
+static void xilinx_intc_edge_ack(unsigned int virq)
 {
 	int irq = virq_to_hw(virq);
 	void * regs = get_irq_chip_data(virq);
@@ -68,27 +129,60 @@ static void xilinx_intc_ack(unsigned int virq)
 	out_be32(regs + XINTC_IAR, 1 << irq);
 }
 
-static struct irq_chip xilinx_intc_irqchip = {
-	.typename = "Xilinx INTC",
+static struct irq_chip xilinx_intc_edge_irqchip = {
+	.typename = "Xilinx Edge  INTC",
 	.mask = xilinx_intc_mask,
-	.unmask = xilinx_intc_unmask,
-	.ack = xilinx_intc_ack,
+	.unmask = xilinx_intc_edge_unmask,
+	.ack = xilinx_intc_edge_ack,
+	.set_type = xilinx_intc_set_type,
 };
 
 /*
  * IRQ Host operations
  */
+
+/**
+ * xilinx_intc_xlate - translate virq# from device tree interrupts property
+ */
+static int xilinx_intc_xlate(struct irq_host *h, struct device_node *ct,
+				u32 *intspec, unsigned int intsize,
+				irq_hw_number_t *out_hwirq,
+				unsigned int *out_flags)
+{
+	if (intsize != 2)
+		return -1;
+
+	/* keep a copy of the interrupt type til the interrupt is mapped
+	 */
+	xilinx_intc_typetable[intspec[0]] = xilinx_intc_map_senses[intspec[1]];
+
+	/* Xilinx uses 2 interrupt entries, the 1st being the h/w
+	 * interrupt number, the 2nd being the interrupt type, edge or level
+	 */
+	*out_hwirq = intspec[0];
+	*out_flags = xilinx_intc_map_senses[intspec[1]];
+
+	return 0;
+}
 static int xilinx_intc_map(struct irq_host *h, unsigned int virq,
 				  irq_hw_number_t irq)
 {
 	set_irq_chip_data(virq, h->host_data);
-	set_irq_chip_and_handler(virq, &xilinx_intc_irqchip, handle_level_irq);
-	set_irq_type(virq, IRQ_TYPE_NONE);
+
+	if (xilinx_intc_typetable[irq] == IRQ_TYPE_LEVEL_HIGH ||
+	    xilinx_intc_typetable[irq] == IRQ_TYPE_LEVEL_LOW) {
+		set_irq_chip_and_handler(virq, &xilinx_intc_level_irqchip,
+			handle_level_irq);
+	} else {
+		set_irq_chip_and_handler(virq, &xilinx_intc_edge_irqchip,
+			handle_edge_irq);
+	}
 	return 0;
 }
 
 static struct irq_host_ops xilinx_intc_ops = {
 	.map = xilinx_intc_map,
+	.xlate = xilinx_intc_xlate,
 };
 
 struct irq_host * __init
-- 
1.6.2.1



This email and any attachments are intended for the sole use of the named recipient(s) and contain(s) confidential information that may be proprietary, privileged or copyrighted under applicable law. If you are not the intended recipient, do not read, copy, or forward this email message or any attachments. Delete this email message and any attachments immediately.

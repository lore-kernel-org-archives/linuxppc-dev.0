Return-Path: <Zubair.Kakakhel@imgtec.com>
Received: from mailapp01.imgtec.com (mailapp01.imgtec.com [195.59.15.196])
 by lists.ozlabs.org (Postfix) with ESMTP id 3tHTvv1V5szDvLZ
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 14 Nov 2016 23:14:03 +1100 (AEDT)
From: Zubair Lutfullah Kakakhel <Zubair.Kakakhel@imgtec.com>
To: <monstr@monstr.eu>, <tglx@linutronix.de>, <jason@lakedaemon.net>,
 <marc.zyngier@arm.com>
CC: <linux-kernel@vger.kernel.org>, <michal.simek@xilinx.com>,
 <linuxppc-dev@lists.ozlabs.org>, <mpe@ellerman.id.au>,
 <Zubair.Kakakhel@imgtec.com>
Subject: [Patch v7 3/7] irqchip: xilinx: restructure and use jump label api
Date: Mon, 14 Nov 2016 12:13:47 +0000
Message-ID: <20161114121351.10924-4-Zubair.Kakakhel@imgtec.com>
In-Reply-To: <20161114121351.10924-1-Zubair.Kakakhel@imgtec.com>
References: <20161114121351.10924-1-Zubair.Kakakhel@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Add a global structure to house various variables.
And cleanup read/write handling by using jump label api.

Signed-off-by: Zubair Lutfullah Kakakhel <Zubair.Kakakhel@imgtec.com>

---
V6 -> V7
Restructure and use jump label api
Better commit log

V5 -> V6
Removed __func__ from printk
Rebase to v4.9-rc3

V4 -> V5
Rebased to v4.9-rc1
Better error handling

V3 -> V4
Better error handling for kzalloc
Erroring out if the axi intc is probed twice as that isn't
supported

V2 -> V3
New patch. Cleans up driver structure
---
 drivers/irqchip/irq-xilinx-intc.c | 118 +++++++++++++++++++++-----------------
 1 file changed, 66 insertions(+), 52 deletions(-)

diff --git a/drivers/irqchip/irq-xilinx-intc.c b/drivers/irqchip/irq-xilinx-intc.c
index 096c1ed..7331d8c 100644
--- a/drivers/irqchip/irq-xilinx-intc.c
+++ b/drivers/irqchip/irq-xilinx-intc.c
@@ -14,10 +14,9 @@
 #include <linux/irqchip.h>
 #include <linux/of_address.h>
 #include <linux/io.h>
+#include <linux/jump_label.h>
 #include <linux/bug.h>
 
-static void __iomem *intc_baseaddr;
-
 /* No one else should require these constants, so define them locally here. */
 #define ISR 0x00			/* Interrupt Status Register */
 #define IPR 0x04			/* Interrupt Pending Register */
@@ -31,27 +30,30 @@ static void __iomem *intc_baseaddr;
 #define MER_ME (1<<0)
 #define MER_HIE (1<<1)
 
-static unsigned int (*read_fn)(void __iomem *);
-static void (*write_fn)(u32, void __iomem *);
+static DEFINE_STATIC_KEY_FALSE(xintc_is_be);
 
-static void intc_write32(u32 val, void __iomem *addr)
-{
-	iowrite32(val, addr);
-}
+struct xintc_irq_chip {
+	void		__iomem *base;
+	struct		irq_domain *root_domain;
+	u32		intr_mask;
+};
 
-static unsigned int intc_read32(void __iomem *addr)
-{
-	return ioread32(addr);
-}
+static struct xintc_irq_chip *xintc_irqc;
 
-static void intc_write32_be(u32 val, void __iomem *addr)
+static void xintc_write(int reg, u32 data)
 {
-	iowrite32be(val, addr);
+	if (static_branch_unlikely(&xintc_is_be))
+		iowrite32be(data, xintc_irqc->base + reg);
+	else
+		iowrite32(data, xintc_irqc->base + reg);
 }
 
-static unsigned int intc_read32_be(void __iomem *addr)
+static unsigned int xintc_read(int reg)
 {
-	return ioread32be(addr);
+	if (static_branch_unlikely(&xintc_is_be))
+		return ioread32be(xintc_irqc->base + reg);
+	else
+		return ioread32(xintc_irqc->base + reg);
 }
 
 static void intc_enable_or_unmask(struct irq_data *d)
@@ -65,21 +67,21 @@ static void intc_enable_or_unmask(struct irq_data *d)
 	 * acks the irq before calling the interrupt handler
 	 */
 	if (irqd_is_level_type(d))
-		write_fn(mask, intc_baseaddr + IAR);
+		xintc_write(IAR, mask);
 
-	write_fn(mask, intc_baseaddr + SIE);
+	xintc_write(SIE, mask);
 }
 
 static void intc_disable_or_mask(struct irq_data *d)
 {
 	pr_debug("irq-xilinx: disable: %ld\n", d->hwirq);
-	write_fn(1 << d->hwirq, intc_baseaddr + CIE);
+	xintc_write(CIE, 1 << d->hwirq);
 }
 
 static void intc_ack(struct irq_data *d)
 {
 	pr_debug("irq-xilinx: ack: %ld\n", d->hwirq);
-	write_fn(1 << d->hwirq, intc_baseaddr + IAR);
+	xintc_write(IAR, 1 << d->hwirq);
 }
 
 static void intc_mask_ack(struct irq_data *d)
@@ -87,8 +89,8 @@ static void intc_mask_ack(struct irq_data *d)
 	unsigned long mask = 1 << d->hwirq;
 
 	pr_debug("irq-xilinx: disable_and_ack: %ld\n", d->hwirq);
-	write_fn(mask, intc_baseaddr + CIE);
-	write_fn(mask, intc_baseaddr + IAR);
+	xintc_write(CIE, mask);
+	xintc_write(IAR, mask);
 }
 
 static struct irq_chip intc_dev = {
@@ -99,15 +101,13 @@ static struct irq_chip intc_dev = {
 	.irq_mask_ack = intc_mask_ack,
 };
 
-static struct irq_domain *root_domain;
-
 unsigned int get_irq(void)
 {
 	unsigned int hwirq, irq = -1;
 
-	hwirq = read_fn(intc_baseaddr + IVR);
+	hwirq = xintc_read(IVR);
 	if (hwirq != -1U)
-		irq = irq_find_mapping(root_domain, hwirq);
+		irq = irq_find_mapping(xintc_irqc->root_domain, hwirq);
 
 	pr_debug("irq-xilinx: hwirq=%d, irq=%d\n", hwirq, irq);
 
@@ -116,9 +116,7 @@ unsigned int get_irq(void)
 
 static int xintc_map(struct irq_domain *d, unsigned int irq, irq_hw_number_t hw)
 {
-	u32 intr_mask = (u32)d->host_data;
-
-	if (intr_mask & (1 << hw)) {
+	if (xintc_irqc->intr_mask & (1 << hw)) {
 		irq_set_chip_and_handler_name(irq, &intc_dev,
 						handle_edge_irq, "edge");
 		irq_clear_status_flags(irq, IRQ_LEVEL);
@@ -138,59 +136,75 @@ static const struct irq_domain_ops xintc_irq_domain_ops = {
 static int __init xilinx_intc_of_init(struct device_node *intc,
 					     struct device_node *parent)
 {
-	u32 nr_irq, intr_mask;
+	u32 nr_irq;
 	int ret;
+	struct xintc_irq_chip *irqc;
 
-	intc_baseaddr = of_iomap(intc, 0);
-	BUG_ON(!intc_baseaddr);
+	if (xintc_irqc) {
+		pr_err("irq-xilinx: Multiple instances aren't supported\n");
+		return -EINVAL;
+	}
+
+	irqc = kzalloc(sizeof(*irqc), GFP_KERNEL);
+	if (!irqc)
+		return -ENOMEM;
+
+	xintc_irqc = irqc;
+
+	irqc->base = of_iomap(intc, 0);
+	BUG_ON(!irqc->base);
 
 	ret = of_property_read_u32(intc, "xlnx,num-intr-inputs", &nr_irq);
 	if (ret < 0) {
 		pr_err("irq-xilinx: unable to read xlnx,num-intr-inputs\n");
-		return ret;
+		goto err_alloc;
 	}
 
-	ret = of_property_read_u32(intc, "xlnx,kind-of-intr", &intr_mask);
+	ret = of_property_read_u32(intc, "xlnx,kind-of-intr", &irqc->intr_mask);
 	if (ret < 0) {
 		pr_err("irq-xilinx: unable to read xlnx,kind-of-intr\n");
-		return ret;
+		goto err_alloc;
 	}
 
-	if (intr_mask >> nr_irq)
+	if (irqc->intr_mask >> nr_irq)
 		pr_warn("irq-xilinx: mismatch in kind-of-intr param\n");
 
 	pr_info("irq-xilinx: %s: num_irq=%d, edge=0x%x\n",
-		intc->full_name, nr_irq, intr_mask);
+		intc->full_name, nr_irq, irqc->intr_mask);
 
-	write_fn = intc_write32;
-	read_fn = intc_read32;
 
 	/*
 	 * Disable all external interrupts until they are
 	 * explicity requested.
 	 */
-	write_fn(0, intc_baseaddr + IER);
+	xintc_write(IER, 0);
 
 	/* Acknowledge any pending interrupts just in case. */
-	write_fn(0xffffffff, intc_baseaddr + IAR);
+	xintc_write(IAR, 0xffffffff);
 
 	/* Turn on the Master Enable. */
-	write_fn(MER_HIE | MER_ME, intc_baseaddr + MER);
-	if (!(read_fn(intc_baseaddr + MER) & (MER_HIE | MER_ME))) {
-		write_fn = intc_write32_be;
-		read_fn = intc_read32_be;
-		write_fn(MER_HIE | MER_ME, intc_baseaddr + MER);
+	xintc_write(MER, MER_HIE | MER_ME);
+	if (!(xintc_read(MER) & (MER_HIE | MER_ME))) {
+		static_branch_enable(&xintc_is_be);
+		xintc_write(MER, MER_HIE | MER_ME);
 	}
 
-	/* Yeah, okay, casting the intr_mask to a void* is butt-ugly, but I'm
-	 * lazy and Michal can clean it up to something nicer when he tests
-	 * and commits this patch.  ~~gcl */
-	root_domain = irq_domain_add_linear(intc, nr_irq, &xintc_irq_domain_ops,
-							(void *)intr_mask);
+	irqc->root_domain = irq_domain_add_linear(intc, nr_irq,
+						  &xintc_irq_domain_ops, irqc);
+	if (!irqc->root_domain) {
+		pr_err("irq-xilinx: Unable to create IRQ domain\n");
+		goto err_alloc;
+	}
 
-	irq_set_default_host(root_domain);
+	irq_set_default_host(irqc->root_domain);
 
 	return 0;
+
+err_alloc:
+	xintc_irqc = NULL;
+	kfree(irqc);
+	return ret;
+
 }
 
 IRQCHIP_DECLARE(xilinx_intc, "xlnx,xps-intc-1.00.a", xilinx_intc_of_init);
-- 
2.10.2

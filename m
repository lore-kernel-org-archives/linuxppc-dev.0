Return-Path: <grant.likely@secretlab.ca>
Received: from pd2mo2so.prod.shaw.ca (idcmail-mo1so.shaw.ca [24.71.223.10])
	by ozlabs.org (Postfix) with ESMTP id 061D0DDF42
	for <linuxppc-dev@ozlabs.org>; Sat, 29 Sep 2007 04:17:04 +1000 (EST)
Received: from pd2mr5so.prod.shaw.ca (pd2mr5so-qfe3.prod.shaw.ca [10.0.141.8])
	by l-daemon (Sun ONE Messaging Server 6.0 HotFix 1.01 (built Mar 15
	2004))
	with ESMTP id <0JP300AKTC2QWM60@l-daemon> for linuxppc-dev@ozlabs.org;
	Fri, 28 Sep 2007 12:16:02 -0600 (MDT)
Received: from pn2ml1so.prod.shaw.ca ([10.0.121.145])
	by pd2mr5so.prod.shaw.ca (Sun Java System Messaging Server 6.2-7.05
	(built Sep
	5 2006)) with ESMTP id <0JP3003A9C2NP070@pd2mr5so.prod.shaw.ca> for
	linuxppc-dev@ozlabs.org; Fri, 28 Sep 2007 12:16:01 -0600 (MDT)
Received: from trillian.cg.shawcable.net ([68.147.67.118])
	by l-daemon (Sun ONE Messaging Server 6.0 HotFix 1.01 (built Mar 15
	2004))
	with ESMTP id <0JP300GLQC2NK980@l-daemon> for linuxppc-dev@ozlabs.org;
	Fri, 28 Sep 2007 12:15:59 -0600 (MDT)
Date: Fri, 28 Sep 2007 12:16:07 -0600
From: Grant Likely <grant.likely@secretlab.ca>
Subject: [PATCH 03/18] Virtex: add xilinx interrupt controller driver
In-reply-to: <20070928181421.18608.74224.stgit@trillian.cg.shawcable.net>
To: linuxppc-dev@ozlabs.org, jwboyer@linux.vnet.ibm.com, jacmet@sunsite.dk
Message-id: <20070928181606.18608.30412.stgit@trillian.cg.shawcable.net>
MIME-version: 1.0
Content-type: text/plain; charset=utf-8
References: <20070928181421.18608.74224.stgit@trillian.cg.shawcable.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Grant Likely <grant.likely@secretlab.ca>

Signed-off-by: Grant Likely <grant.likely@secretlab.ca>
---

 arch/powerpc/sysdev/Makefile      |    1 
 arch/powerpc/sysdev/xilinx_intc.c |  151 +++++++++++++++++++++++++++++++++++++
 include/asm-powerpc/xilinx_intc.h |   20 +++++
 3 files changed, 172 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/sysdev/Makefile b/arch/powerpc/sysdev/Makefile
index 08ce31e..0457117 100644
--- a/arch/powerpc/sysdev/Makefile
+++ b/arch/powerpc/sysdev/Makefile
@@ -30,6 +30,7 @@ obj-$(CONFIG_PPC_INDIRECT_PCI)	+= indirect_pci.o
 obj-$(CONFIG_PPC_I8259)		+= i8259.o
 obj-$(CONFIG_PPC_83xx)		+= ipic.o
 obj-$(CONFIG_4xx)		+= uic.o
+obj-$(CONFIG_XILINX_VIRTEX)	+= xilinx_intc.o
 endif
 
 # Temporary hack until we have migrated to asm-powerpc
diff --git a/arch/powerpc/sysdev/xilinx_intc.c b/arch/powerpc/sysdev/xilinx_intc.c
new file mode 100644
index 0000000..fe24f0f
--- /dev/null
+++ b/arch/powerpc/sysdev/xilinx_intc.c
@@ -0,0 +1,151 @@
+/*
+ * Interrupt controller driver for Xilinx Virtex FPGAs
+ *
+ * Copyright (C) 2007 Secret Lab Technologies Ltd.
+ *
+ * This file is licensed under the terms of the GNU General Public License
+ * version 2. This program is licensed "as is" without any warranty of any
+ * kind, whether express or implied.
+ *
+ */
+
+/*
+ * This is a driver for the interrupt controller typically found in
+ * Xilinx Virtex FPGA designs.
+ *
+ * The interrupt sense levels are hard coded into the FPGA design with
+ * typically a 1:1 relationship between irq lines and devices (no shared
+ * irq lines).  Therefore, this driver does not attempt to handle edge
+ * and level interrupts differently.
+ */
+#undef DEBUG
+
+#include <linux/kernel.h>
+#include <linux/irq.h>
+#include <asm/io.h>
+#include <asm/processor.h>
+#include <asm/prom.h>
+#include <asm/irq.h>
+
+/*
+ * INTC Registers
+ */
+#define ISR	0	/* Interrupt Status */
+#define IPR	4	/* Interrupt Pending */
+#define IER	8	/* Interrupt Enable */
+#define IAR	12	/* Interrupt Acknowledge */
+#define SIE	16	/* Set Interrupt Enable bits */
+#define CIE	20	/* Clear Interrupt Enable bits */
+#define IVR	24	/* Interrupt Vector */
+#define MER	28	/* Master Enable */
+
+static struct irq_host *master_irqhost;
+
+/*
+ * IRQ Chip operations
+ */
+static void xilinx_intc_mask(unsigned int virq)
+{
+	int irq = irq_map[virq].hwirq;
+	void * regs = get_irq_chip_data(virq);
+	pr_debug("mask: %d\n", irq);
+	out_be32(regs + CIE, 1 << irq);
+}
+
+static void xilinx_intc_unmask(unsigned int virq)
+{
+	int irq = irq_map[virq].hwirq;
+	void * regs = get_irq_chip_data(virq);
+	pr_debug("unmask: %d\n", irq);
+	out_be32(regs + SIE, 1 << irq);
+}
+
+static void xilinx_intc_ack(unsigned int virq)
+{
+	int irq = irq_map[virq].hwirq;
+	void * regs = get_irq_chip_data(virq);
+	pr_debug("ack: %d\n", irq);
+	out_be32(regs + IAR, 1 << irq);
+}
+
+static struct irq_chip xilinx_intc_irqchip = {
+	.typename = "Xilinx INTC",
+	.mask = xilinx_intc_mask,
+	.unmask = xilinx_intc_unmask,
+	.ack = xilinx_intc_ack,
+};
+
+/*
+ * IRQ Host operations
+ */
+static int xilinx_intc_map(struct irq_host *h, unsigned int virq,
+				  irq_hw_number_t irq)
+{
+	set_irq_chip_data(virq, h->host_data);
+	set_irq_chip_and_handler(virq, &xilinx_intc_irqchip, handle_level_irq);
+	set_irq_type(virq, IRQ_TYPE_NONE);
+	return 0;
+}
+
+static struct irq_host_ops xilinx_intc_ops = {
+	.map = xilinx_intc_map,
+};
+
+struct irq_host * __init
+xilinx_intc_init(struct device_node *np)
+{
+	struct irq_host * irq;
+	struct resource res;
+	void * regs;
+	int rc;
+
+	/* Find and map the intc registers */
+	rc = of_address_to_resource(np, 0, &res);
+	if (rc) {
+		printk(KERN_ERR __FILE__ ": of_address_to_resource() failed\n");
+		return NULL;
+	}
+	regs = ioremap(res.start, 32);
+
+	printk(KERN_INFO "Xilinx intc at 0x%08X mapped to 0x%p\n",
+		res.start, regs);
+
+	/* Setup interrupt controller */
+	out_be32(regs + IER, 0); /* disable all irqs */
+	out_be32(regs + IAR, ~(u32) 0); /* Acknowledge pending irqs */
+	out_be32(regs + MER, 0x3UL); /* Turn on the Master Enable. */
+
+	/* Allocate and initialize an irq_host structure. */
+	irq = irq_alloc_host(np, IRQ_HOST_MAP_LINEAR, 32, &xilinx_intc_ops, -1);
+	if (!irq)
+		panic(__FILE__ ": Cannot allocate IRQ host\n");
+	irq->host_data = regs;
+	return irq;
+}
+
+int xilinx_intc_get_irq(void)
+{
+	void * regs = master_irqhost->host_data;
+	pr_debug("get_irq:\n");
+	return irq_linear_revmap(master_irqhost, in_be32(regs + IVR));
+}
+
+void __init xilinx_intc_init_tree(void)
+{
+	struct device_node *np;
+
+	/* find top level interrupt controller */
+	for_each_compatible_node(np, NULL, "xilinx,intc") {
+		if (!of_get_property(np, "interrupts", NULL))
+			break;
+	}
+
+	/* xilinx interrupt controller needs to be top level */
+	BUG_ON(!np);
+
+	master_irqhost = xilinx_intc_init(np);
+	BUG_ON(!master_irqhost);
+
+	irq_set_default_host(master_irqhost);
+	of_node_put(np);
+}
diff --git a/include/asm-powerpc/xilinx_intc.h b/include/asm-powerpc/xilinx_intc.h
new file mode 100644
index 0000000..343612f
--- /dev/null
+++ b/include/asm-powerpc/xilinx_intc.h
@@ -0,0 +1,20 @@
+/*
+ * Xilinx intc external definitions
+ *
+ * Copyright 2007 Secret Lab Technologies Ltd.
+ *
+ * This program is free software; you can redistribute  it and/or modify it
+ * under  the terms of  the GNU General  Public License as published by the
+ * Free Software Foundation;  either version 2 of the  License, or (at your
+ * option) any later version.
+ */
+#ifndef _ASM_POWERPC_XILINX_INTC_H
+#define _ASM_POWERPC_XILINX_INTC_H
+
+#ifdef __KERNEL__
+
+extern void __init xilinx_intc_init_tree(void);
+extern unsigned int xilinx_intc_get_irq(void);
+
+#endif /* __KERNEL__ */
+#endif /* _ASM_POWERPC_XILINX_INTC_H */

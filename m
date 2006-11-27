Return-Path: <grant.likely@secretlab.ca>
Received: from sandbox.secretlab.ca (S01060016b61d1226.cg.shawcable.net
	[68.147.191.145]) by ozlabs.org (Postfix) with ESMTP id 6BB0467D67
	for <linuxppc-dev@ozlabs.org>; Tue, 28 Nov 2006 08:17:08 +1100 (EST)
From: Grant Likely <grant.likely@secretlab.ca>
To: linuxppc-dev@ozlabs.org,
	Paul Mackerras <paulus@samba.org>
Subject: [PATCH 2/9] [POWERPC] Move MPC52xx PIC driver into
	arch/powerpc/platforms/52xx
Date: Mon, 27 Nov 2006 14:16:23 -0700
Message-Id: <11646622063980-git-send-email-grant.likely@secretlab.ca>
In-Reply-To: <11646622052490-git-send-email-grant.likely@secretlab.ca>
References: <1164662190802-git-send-email-grant.likely@secretlab.ca>
	<11646622052490-git-send-email-grant.likely@secretlab.ca>
Cc: Sylvain Munaut <tnt@246tNt.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

No other chips use this device, it belongs in a 52xx-specific path.

Signed-off-by: Grant Likely <grant.likely@secretlab.ca>
Signed-off-by: Sylvain Munaut <tnt@246tNt.com>
---
 arch/powerpc/platforms/52xx/Makefile      |    6 +
 arch/powerpc/platforms/52xx/mpc52xx_pic.c |  538 +++++++++++++++++++++++++++++
 arch/powerpc/platforms/Makefile           |    5 +-
 arch/powerpc/sysdev/Makefile              |    1 -
 arch/powerpc/sysdev/mpc52xx_pic.c         |  538 -----------------------------
 5 files changed, 547 insertions(+), 541 deletions(-)

diff --git a/arch/powerpc/platforms/52xx/Makefile b/arch/powerpc/platforms/52xx/Makefile
new file mode 100644
index 0000000..e1b02f1
--- /dev/null
+++ b/arch/powerpc/platforms/52xx/Makefile
@@ -0,0 +1,6 @@
+#
+# Makefile for 52xx based boards
+#
+ifeq ($(CONFIG_PPC_MERGE),y)
+obj-y				+= mpc52xx_pic.o
+endif
diff --git a/arch/powerpc/platforms/52xx/mpc52xx_pic.c b/arch/powerpc/platforms/52xx/mpc52xx_pic.c
new file mode 100644
index 0000000..6df51f0
--- /dev/null
+++ b/arch/powerpc/platforms/52xx/mpc52xx_pic.c
@@ -0,0 +1,538 @@
+/*
+ *
+ * Programmable Interrupt Controller functions for the Freescale MPC52xx.
+ *
+ * Copyright (C) 2006 bplan GmbH
+ *
+ * Based on the code from the 2.4 kernel by
+ * Dale Farnsworth <dfarnsworth@mvista.com> and Kent Borg.
+ *
+ * Copyright (C) 2004 Sylvain Munaut <tnt@246tNt.com>
+ * Copyright (C) 2003 Montavista Software, Inc
+ *
+ * This file is licensed under the terms of the GNU General Public License
+ * version 2. This program is licensed "as is" without any warranty of any
+ * kind, whether express or implied.
+ *
+ */
+
+#undef DEBUG
+
+#include <linux/stddef.h>
+#include <linux/init.h>
+#include <linux/sched.h>
+#include <linux/signal.h>
+#include <linux/stddef.h>
+#include <linux/delay.h>
+#include <linux/irq.h>
+#include <linux/hardirq.h>
+
+#include <asm/io.h>
+#include <asm/processor.h>
+#include <asm/system.h>
+#include <asm/irq.h>
+#include <asm/prom.h>
+#include <asm/mpc52xx.h>
+
+/*
+ *
+*/
+
+static struct mpc52xx_intr __iomem *intr;
+static struct mpc52xx_sdma __iomem *sdma;
+static struct irq_host *mpc52xx_irqhost = NULL;
+
+static unsigned char mpc52xx_map_senses[4] = {
+	IRQ_TYPE_LEVEL_HIGH,
+	IRQ_TYPE_EDGE_RISING,
+	IRQ_TYPE_EDGE_FALLING,
+	IRQ_TYPE_LEVEL_LOW,
+};
+
+/*
+ *
+*/
+
+static inline void io_be_setbit(u32 __iomem * addr, int bitno)
+{
+	out_be32(addr, in_be32(addr) | (1 << bitno));
+}
+
+static inline void io_be_clrbit(u32 __iomem * addr, int bitno)
+{
+	out_be32(addr, in_be32(addr) & ~(1 << bitno));
+}
+
+/*
+ * IRQ[0-3] interrupt irq_chip
+*/
+
+static void mpc52xx_extirq_mask(unsigned int virq)
+{
+	int irq;
+	int l2irq;
+
+	irq = irq_map[virq].hwirq;
+	l2irq = (irq & MPC52xx_IRQ_L2_MASK) >> MPC52xx_IRQ_L2_OFFSET;
+
+	pr_debug("%s: irq=%x. l2=%d\n", __func__, irq, l2irq);
+
+	io_be_clrbit(&intr->ctrl, 11 - l2irq);
+}
+
+static void mpc52xx_extirq_unmask(unsigned int virq)
+{
+	int irq;
+	int l2irq;
+
+	irq = irq_map[virq].hwirq;
+	l2irq = (irq & MPC52xx_IRQ_L2_MASK) >> MPC52xx_IRQ_L2_OFFSET;
+
+	pr_debug("%s: irq=%x. l2=%d\n", __func__, irq, l2irq);
+
+	io_be_setbit(&intr->ctrl, 11 - l2irq);
+}
+
+static void mpc52xx_extirq_ack(unsigned int virq)
+{
+	int irq;
+	int l2irq;
+
+	irq = irq_map[virq].hwirq;
+	l2irq = (irq & MPC52xx_IRQ_L2_MASK) >> MPC52xx_IRQ_L2_OFFSET;
+
+	pr_debug("%s: irq=%x. l2=%d\n", __func__, irq, l2irq);
+
+	io_be_setbit(&intr->ctrl, 27 - l2irq);
+}
+
+static struct irq_chip mpc52xx_extirq_irqchip = {
+	.typename = " MPC52xx IRQ[0-3] ",
+	.mask = mpc52xx_extirq_mask,
+	.unmask = mpc52xx_extirq_unmask,
+	.ack = mpc52xx_extirq_ack,
+};
+
+/*
+ * Main interrupt irq_chip
+*/
+
+static void mpc52xx_main_mask(unsigned int virq)
+{
+	int irq;
+	int l2irq;
+
+	irq = irq_map[virq].hwirq;
+	l2irq = (irq & MPC52xx_IRQ_L2_MASK) >> MPC52xx_IRQ_L2_OFFSET;
+
+	pr_debug("%s: irq=%x. l2=%d\n", __func__, irq, l2irq);
+
+	io_be_setbit(&intr->main_mask, 15 - l2irq);
+}
+
+static void mpc52xx_main_unmask(unsigned int virq)
+{
+	int irq;
+	int l2irq;
+
+	irq = irq_map[virq].hwirq;
+	l2irq = (irq & MPC52xx_IRQ_L2_MASK) >> MPC52xx_IRQ_L2_OFFSET;
+
+	pr_debug("%s: irq=%x. l2=%d\n", __func__, irq, l2irq);
+
+	io_be_clrbit(&intr->main_mask, 15 - l2irq);
+}
+
+static struct irq_chip mpc52xx_main_irqchip = {
+	.typename = "MPC52xx Main",
+	.mask = mpc52xx_main_mask,
+	.mask_ack = mpc52xx_main_mask,
+	.unmask = mpc52xx_main_unmask,
+};
+
+/*
+ * Peripherals interrupt irq_chip
+*/
+
+static void mpc52xx_periph_mask(unsigned int virq)
+{
+	int irq;
+	int l2irq;
+
+	irq = irq_map[virq].hwirq;
+	l2irq = (irq & MPC52xx_IRQ_L2_MASK) >> MPC52xx_IRQ_L2_OFFSET;
+
+	pr_debug("%s: irq=%x. l2=%d\n", __func__, irq, l2irq);
+
+	io_be_setbit(&intr->per_mask, 31 - l2irq);
+}
+
+static void mpc52xx_periph_unmask(unsigned int virq)
+{
+	int irq;
+	int l2irq;
+
+	irq = irq_map[virq].hwirq;
+	l2irq = (irq & MPC52xx_IRQ_L2_MASK) >> MPC52xx_IRQ_L2_OFFSET;
+
+	pr_debug("%s: irq=%x. l2=%d\n", __func__, irq, l2irq);
+
+	io_be_clrbit(&intr->per_mask, 31 - l2irq);
+}
+
+static struct irq_chip mpc52xx_periph_irqchip = {
+	.typename = "MPC52xx Peripherals",
+	.mask = mpc52xx_periph_mask,
+	.mask_ack = mpc52xx_periph_mask,
+	.unmask = mpc52xx_periph_unmask,
+};
+
+/*
+ * SDMA interrupt irq_chip
+*/
+
+static void mpc52xx_sdma_mask(unsigned int virq)
+{
+	int irq;
+	int l2irq;
+
+	irq = irq_map[virq].hwirq;
+	l2irq = (irq & MPC52xx_IRQ_L2_MASK) >> MPC52xx_IRQ_L2_OFFSET;
+
+	pr_debug("%s: irq=%x. l2=%d\n", __func__, irq, l2irq);
+
+	io_be_setbit(&sdma->IntMask, l2irq);
+}
+
+static void mpc52xx_sdma_unmask(unsigned int virq)
+{
+	int irq;
+	int l2irq;
+
+	irq = irq_map[virq].hwirq;
+	l2irq = (irq & MPC52xx_IRQ_L2_MASK) >> MPC52xx_IRQ_L2_OFFSET;
+
+	pr_debug("%s: irq=%x. l2=%d\n", __func__, irq, l2irq);
+
+	io_be_clrbit(&sdma->IntMask, l2irq);
+}
+
+static void mpc52xx_sdma_ack(unsigned int virq)
+{
+	int irq;
+	int l2irq;
+
+	irq = irq_map[virq].hwirq;
+	l2irq = (irq & MPC52xx_IRQ_L2_MASK) >> MPC52xx_IRQ_L2_OFFSET;
+
+	pr_debug("%s: irq=%x. l2=%d\n", __func__, irq, l2irq);
+
+	out_be32(&sdma->IntPend, 1 << l2irq);
+}
+
+static struct irq_chip mpc52xx_sdma_irqchip = {
+	.typename = "MPC52xx SDMA",
+	.mask = mpc52xx_sdma_mask,
+	.unmask = mpc52xx_sdma_unmask,
+	.ack = mpc52xx_sdma_ack,
+};
+
+/*
+ * irq_host
+*/
+
+static int mpc52xx_irqhost_match(struct irq_host *h, struct device_node *node)
+{
+	pr_debug("%s: node=%p\n", __func__, node);
+	return mpc52xx_irqhost->host_data == node;
+}
+
+static int mpc52xx_irqhost_xlate(struct irq_host *h, struct device_node *ct,
+				 u32 * intspec, unsigned int intsize,
+				 irq_hw_number_t * out_hwirq,
+				 unsigned int *out_flags)
+{
+	int intrvect_l1;
+	int intrvect_l2;
+	int intrvect_type;
+	int intrvect_linux;
+
+	if (intsize != 3)
+		return -1;
+
+	intrvect_l1 = (int)intspec[0];
+	intrvect_l2 = (int)intspec[1];
+	intrvect_type = (int)intspec[2];
+
+	intrvect_linux =
+	    (intrvect_l1 << MPC52xx_IRQ_L1_OFFSET) & MPC52xx_IRQ_L1_MASK;
+	intrvect_linux |=
+	    (intrvect_l2 << MPC52xx_IRQ_L2_OFFSET) & MPC52xx_IRQ_L2_MASK;
+
+	pr_debug("return %x, l1=%d, l2=%d\n", intrvect_linux, intrvect_l1,
+		 intrvect_l2);
+
+	*out_hwirq = intrvect_linux;
+	*out_flags = mpc52xx_map_senses[intrvect_type];
+
+	return 0;
+}
+
+/*
+ * this function retrieves the correct IRQ type out
+ * of the MPC regs
+ * Only externals IRQs needs this
+*/
+static int mpc52xx_irqx_gettype(int irq)
+{
+	int type;
+	u32 ctrl_reg;
+
+	ctrl_reg = in_be32(&intr->ctrl);
+	type = (ctrl_reg >> (22 - irq * 2)) & 0x3;
+
+	return mpc52xx_map_senses[type];
+}
+
+static int mpc52xx_irqhost_map(struct irq_host *h, unsigned int virq,
+			       irq_hw_number_t irq)
+{
+	int l1irq;
+	int l2irq;
+	struct irq_chip *good_irqchip;
+	void *good_handle;
+	int type;
+
+	l1irq = (irq & MPC52xx_IRQ_L1_MASK) >> MPC52xx_IRQ_L1_OFFSET;
+	l2irq = (irq & MPC52xx_IRQ_L2_MASK) >> MPC52xx_IRQ_L2_OFFSET;
+
+	/*
+	 * Most of ours IRQs will be level low
+	 * Only external IRQs on some platform may be others
+	 */
+	type = IRQ_TYPE_LEVEL_LOW;
+
+	switch (l1irq) {
+	case MPC52xx_IRQ_L1_CRIT:
+		pr_debug("%s: Critical. l2=%x\n", __func__, l2irq);
+
+		BUG_ON(l2irq != 0);
+
+		type = mpc52xx_irqx_gettype(l2irq);
+		good_irqchip = &mpc52xx_extirq_irqchip;
+		break;
+
+	case MPC52xx_IRQ_L1_MAIN:
+		pr_debug("%s: Main IRQ[1-3] l2=%x\n", __func__, l2irq);
+
+		if ((l2irq >= 1) && (l2irq <= 3)) {
+			type = mpc52xx_irqx_gettype(l2irq);
+			good_irqchip = &mpc52xx_extirq_irqchip;
+		} else {
+			good_irqchip = &mpc52xx_main_irqchip;
+		}
+		break;
+
+	case MPC52xx_IRQ_L1_PERP:
+		pr_debug("%s: Peripherals. l2=%x\n", __func__, l2irq);
+		good_irqchip = &mpc52xx_periph_irqchip;
+		break;
+
+	case MPC52xx_IRQ_L1_SDMA:
+		pr_debug("%s: SDMA. l2=%x\n", __func__, l2irq);
+		good_irqchip = &mpc52xx_sdma_irqchip;
+		break;
+
+	default:
+		pr_debug("%s: Error, unknown L1 IRQ (0x%x)\n", __func__, l1irq);
+		printk(KERN_ERR "Unknow IRQ!\n");
+		return -EINVAL;
+	}
+
+	switch (type) {
+	case IRQ_TYPE_EDGE_FALLING:
+	case IRQ_TYPE_EDGE_RISING:
+		good_handle = handle_edge_irq;
+		break;
+	default:
+		good_handle = handle_level_irq;
+	}
+
+	set_irq_chip_and_handler(virq, good_irqchip, good_handle);
+
+	pr_debug("%s: virq=%x, hw=%x. type=%x\n", __func__, virq,
+		 (int)irq, type);
+
+	return 0;
+}
+
+static struct irq_host_ops mpc52xx_irqhost_ops = {
+	.match = mpc52xx_irqhost_match,
+	.xlate = mpc52xx_irqhost_xlate,
+	.map = mpc52xx_irqhost_map,
+};
+
+/*
+ * init (public)
+*/
+
+void __init mpc52xx_init_irq(void)
+{
+	struct device_node *picnode = NULL;
+	int picnode_regsize;
+	u32 picnode_regoffset;
+
+	struct device_node *sdmanode = NULL;
+	int sdmanode_regsize;
+	u32 sdmanode_regoffset;
+
+	u64 size64;
+	int flags;
+
+	u32 intr_ctrl;
+
+	picnode = of_find_compatible_node(NULL, "interrupt-controller",
+						"mpc5200-pic");
+	if (picnode == NULL) {
+		printk(KERN_ERR "MPC52xx PIC: "
+			"Unable to find the interrupt controller "
+			"in the OpenFirmware device tree\n");
+		goto end;
+	}
+
+	sdmanode = of_find_compatible_node(NULL, "dma-controller",
+						 "mpc5200-bestcomm");
+	if (sdmanode == NULL) {
+		printk(KERN_ERR "MPC52xx PIC"
+			"Unable to find the Bestcomm DMA controller device "
+			"in the OpenFirmware device tree\n");
+		goto end;
+	}
+
+	/* Retrieve PIC ressources */
+	picnode_regoffset = (u32) of_get_address(picnode, 0, &size64, &flags);
+	if (picnode_regoffset == 0) {
+		printk(KERN_ERR "MPC52xx PIC"
+			"Unable to get the interrupt controller address\n");
+		goto end;
+	}
+
+	picnode_regoffset =
+		of_translate_address(picnode, (u32 *) picnode_regoffset);
+	picnode_regsize = (int)size64;
+
+	/* Retrieve SDMA ressources */
+	sdmanode_regoffset = (u32) of_get_address(sdmanode, 0, &size64, &flags);
+	if (sdmanode_regoffset == 0) {
+		printk(KERN_ERR "MPC52xx PIC: "
+			"Unable to get the Bestcomm DMA controller address\n");
+		goto end;
+	}
+
+	sdmanode_regoffset =
+	    of_translate_address(sdmanode, (u32 *) sdmanode_regoffset);
+	sdmanode_regsize = (int)size64;
+
+	/* Remap the necessary zones */
+	intr = ioremap(picnode_regoffset, picnode_regsize);
+	if (intr == NULL) {
+		printk(KERN_ERR "MPC52xx PIC: "
+			"Unable to ioremap interrupt controller registers!\n");
+		goto end;
+	}
+
+	sdma = ioremap(sdmanode_regoffset, sdmanode_regsize);
+	if (sdma == NULL) {
+		iounmap(intr);
+		printk(KERN_ERR "MPC52xx PIC: "
+			"Unable to ioremap Bestcomm DMA registers!\n");
+		goto end;
+	}
+
+	printk(KERN_INFO "MPC52xx PIC: MPC52xx PIC Remapped at 0x%8.8x\n",
+		picnode_regoffset);
+	printk(KERN_INFO "MPC52xx PIC: MPC52xx SDMA Remapped at 0x%8.8x\n",
+		sdmanode_regoffset);
+
+	/* Disable all interrupt sources. */
+	out_be32(&sdma->IntPend, 0xffffffff);	/* 1 means clear pending */
+	out_be32(&sdma->IntMask, 0xffffffff);	/* 1 means disabled */
+	out_be32(&intr->per_mask, 0x7ffffc00);	/* 1 means disabled */
+	out_be32(&intr->main_mask, 0x00010fff);	/* 1 means disabled */
+	intr_ctrl = in_be32(&intr->ctrl);
+	intr_ctrl &= 0x00ff0000;	/* Keeps IRQ[0-3] config */
+	intr_ctrl |=	0x0f000000 |	/* clear IRQ 0-3 */
+			0x00001000 |	/* MEE master external enable */
+			0x00000000 |	/* 0 means disable IRQ 0-3 */
+			0x00000001;	/* CEb route critical normally */
+	out_be32(&intr->ctrl, intr_ctrl);
+
+	/* Zero a bunch of the priority settings. */
+	out_be32(&intr->per_pri1, 0);
+	out_be32(&intr->per_pri2, 0);
+	out_be32(&intr->per_pri3, 0);
+	out_be32(&intr->main_pri1, 0);
+	out_be32(&intr->main_pri2, 0);
+
+	/*
+	 * As last step, add an irq host to translate the real
+	 * hw irq information provided by the ofw to linux virq
+	 */
+
+	mpc52xx_irqhost =
+	    irq_alloc_host(IRQ_HOST_MAP_LINEAR, MPC52xx_IRQ_HIGHTESTHWIRQ,
+			   &mpc52xx_irqhost_ops, -1);
+
+	if (mpc52xx_irqhost) {
+		mpc52xx_irqhost->host_data = picnode;
+		printk(KERN_INFO "MPC52xx PIC is up and running!\n");
+	} else {
+		printk(KERN_ERR
+			"MPC52xx PIC: Unable to allocate the IRQ host\n");
+	}
+
+end:
+	of_node_put(picnode);
+	of_node_put(sdmanode);
+}
+
+/*
+ * get_irq (public)
+*/
+unsigned int mpc52xx_get_irq(void)
+{
+	u32 status;
+	int irq = NO_IRQ_IGNORE;
+
+	status = in_be32(&intr->enc_status);
+	if (status & 0x00000400) {	/* critical */
+		irq = (status >> 8) & 0x3;
+		if (irq == 2)	/* high priority peripheral */
+			goto peripheral;
+		irq |=	(MPC52xx_IRQ_L1_CRIT << MPC52xx_IRQ_L1_OFFSET) &
+			MPC52xx_IRQ_L1_MASK;
+	} else if (status & 0x00200000) {	/* main */
+		irq = (status >> 16) & 0x1f;
+		if (irq == 4)	/* low priority peripheral */
+			goto peripheral;
+		irq |=	(MPC52xx_IRQ_L1_MAIN << MPC52xx_IRQ_L1_OFFSET) &
+			MPC52xx_IRQ_L1_MASK;
+	} else if (status & 0x20000000) {	/* peripheral */
+	      peripheral:
+		irq = (status >> 24) & 0x1f;
+		if (irq == 0) {	/* bestcomm */
+			status = in_be32(&sdma->IntPend);
+			irq = ffs(status) - 1;
+			irq |=	(MPC52xx_IRQ_L1_SDMA << MPC52xx_IRQ_L1_OFFSET) &
+				MPC52xx_IRQ_L1_MASK;
+		} else
+			irq |=	(MPC52xx_IRQ_L1_PERP << MPC52xx_IRQ_L1_OFFSET) &
+				MPC52xx_IRQ_L1_MASK;
+	}
+
+	pr_debug("%s: irq=%x. virq=%d\n", __func__, irq,
+		 irq_linear_revmap(mpc52xx_irqhost, irq));
+
+	return irq_linear_revmap(mpc52xx_irqhost, irq);
+}
+
diff --git a/arch/powerpc/platforms/Makefile b/arch/powerpc/platforms/Makefile
index 56caf4f..562f9da 100644
--- a/arch/powerpc/platforms/Makefile
+++ b/arch/powerpc/platforms/Makefile
@@ -5,16 +5,17 @@ ifeq ($(CONFIG_PPC64),y)
 obj-$(CONFIG_PPC_PMAC)		+= powermac/
 endif
 endif
-obj-$(CONFIG_PPC_EFIKA)          += efika/
+obj-$(CONFIG_PPC_EFIKA)		+= efika/
 obj-$(CONFIG_PPC_CHRP)		+= chrp/
 obj-$(CONFIG_4xx)		+= 4xx/
+obj-$(CONFIG_PPC_MPC52xx)	+= 52xx/
 obj-$(CONFIG_PPC_83xx)		+= 83xx/
 obj-$(CONFIG_PPC_85xx)		+= 85xx/
 obj-$(CONFIG_PPC_86xx)		+= 86xx/
 obj-$(CONFIG_PPC_PSERIES)	+= pseries/
 obj-$(CONFIG_PPC_ISERIES)	+= iseries/
 obj-$(CONFIG_PPC_MAPLE)		+= maple/
-obj-$(CONFIG_PPC_PASEMI)		+= pasemi/
+obj-$(CONFIG_PPC_PASEMI)	+= pasemi/
 obj-$(CONFIG_PPC_CELL)		+= cell/
 obj-$(CONFIG_PS3)		+= ps3/
 obj-$(CONFIG_EMBEDDED6xx)	+= embedded6xx/
diff --git a/arch/powerpc/sysdev/Makefile b/arch/powerpc/sysdev/Makefile
index bae8746..623fe71 100644
--- a/arch/powerpc/sysdev/Makefile
+++ b/arch/powerpc/sysdev/Makefile
@@ -15,7 +15,6 @@ obj-$(CONFIG_QUICC_ENGINE)	+= qe_lib/
 ifeq ($(CONFIG_PPC_MERGE),y)
 obj-$(CONFIG_PPC_I8259)		+= i8259.o
 obj-$(CONFIG_PPC_83xx)		+= ipic.o
-obj-$(CONFIG_PPC_MPC52xx)	+= mpc52xx_pic.o
 endif
 
 # Temporary hack until we have migrated to asm-powerpc
diff --git a/arch/powerpc/sysdev/mpc52xx_pic.c b/arch/powerpc/sysdev/mpc52xx_pic.c
deleted file mode 100644
index 6df51f0..0000000
--- a/arch/powerpc/sysdev/mpc52xx_pic.c
+++ /dev/null
@@ -1,538 +0,0 @@
-/*
- *
- * Programmable Interrupt Controller functions for the Freescale MPC52xx.
- *
- * Copyright (C) 2006 bplan GmbH
- *
- * Based on the code from the 2.4 kernel by
- * Dale Farnsworth <dfarnsworth@mvista.com> and Kent Borg.
- *
- * Copyright (C) 2004 Sylvain Munaut <tnt@246tNt.com>
- * Copyright (C) 2003 Montavista Software, Inc
- *
- * This file is licensed under the terms of the GNU General Public License
- * version 2. This program is licensed "as is" without any warranty of any
- * kind, whether express or implied.
- *
- */
-
-#undef DEBUG
-
-#include <linux/stddef.h>
-#include <linux/init.h>
-#include <linux/sched.h>
-#include <linux/signal.h>
-#include <linux/stddef.h>
-#include <linux/delay.h>
-#include <linux/irq.h>
-#include <linux/hardirq.h>
-
-#include <asm/io.h>
-#include <asm/processor.h>
-#include <asm/system.h>
-#include <asm/irq.h>
-#include <asm/prom.h>
-#include <asm/mpc52xx.h>
-
-/*
- *
-*/
-
-static struct mpc52xx_intr __iomem *intr;
-static struct mpc52xx_sdma __iomem *sdma;
-static struct irq_host *mpc52xx_irqhost = NULL;
-
-static unsigned char mpc52xx_map_senses[4] = {
-	IRQ_TYPE_LEVEL_HIGH,
-	IRQ_TYPE_EDGE_RISING,
-	IRQ_TYPE_EDGE_FALLING,
-	IRQ_TYPE_LEVEL_LOW,
-};
-
-/*
- *
-*/
-
-static inline void io_be_setbit(u32 __iomem * addr, int bitno)
-{
-	out_be32(addr, in_be32(addr) | (1 << bitno));
-}
-
-static inline void io_be_clrbit(u32 __iomem * addr, int bitno)
-{
-	out_be32(addr, in_be32(addr) & ~(1 << bitno));
-}
-
-/*
- * IRQ[0-3] interrupt irq_chip
-*/
-
-static void mpc52xx_extirq_mask(unsigned int virq)
-{
-	int irq;
-	int l2irq;
-
-	irq = irq_map[virq].hwirq;
-	l2irq = (irq & MPC52xx_IRQ_L2_MASK) >> MPC52xx_IRQ_L2_OFFSET;
-
-	pr_debug("%s: irq=%x. l2=%d\n", __func__, irq, l2irq);
-
-	io_be_clrbit(&intr->ctrl, 11 - l2irq);
-}
-
-static void mpc52xx_extirq_unmask(unsigned int virq)
-{
-	int irq;
-	int l2irq;
-
-	irq = irq_map[virq].hwirq;
-	l2irq = (irq & MPC52xx_IRQ_L2_MASK) >> MPC52xx_IRQ_L2_OFFSET;
-
-	pr_debug("%s: irq=%x. l2=%d\n", __func__, irq, l2irq);
-
-	io_be_setbit(&intr->ctrl, 11 - l2irq);
-}
-
-static void mpc52xx_extirq_ack(unsigned int virq)
-{
-	int irq;
-	int l2irq;
-
-	irq = irq_map[virq].hwirq;
-	l2irq = (irq & MPC52xx_IRQ_L2_MASK) >> MPC52xx_IRQ_L2_OFFSET;
-
-	pr_debug("%s: irq=%x. l2=%d\n", __func__, irq, l2irq);
-
-	io_be_setbit(&intr->ctrl, 27 - l2irq);
-}
-
-static struct irq_chip mpc52xx_extirq_irqchip = {
-	.typename = " MPC52xx IRQ[0-3] ",
-	.mask = mpc52xx_extirq_mask,
-	.unmask = mpc52xx_extirq_unmask,
-	.ack = mpc52xx_extirq_ack,
-};
-
-/*
- * Main interrupt irq_chip
-*/
-
-static void mpc52xx_main_mask(unsigned int virq)
-{
-	int irq;
-	int l2irq;
-
-	irq = irq_map[virq].hwirq;
-	l2irq = (irq & MPC52xx_IRQ_L2_MASK) >> MPC52xx_IRQ_L2_OFFSET;
-
-	pr_debug("%s: irq=%x. l2=%d\n", __func__, irq, l2irq);
-
-	io_be_setbit(&intr->main_mask, 15 - l2irq);
-}
-
-static void mpc52xx_main_unmask(unsigned int virq)
-{
-	int irq;
-	int l2irq;
-
-	irq = irq_map[virq].hwirq;
-	l2irq = (irq & MPC52xx_IRQ_L2_MASK) >> MPC52xx_IRQ_L2_OFFSET;
-
-	pr_debug("%s: irq=%x. l2=%d\n", __func__, irq, l2irq);
-
-	io_be_clrbit(&intr->main_mask, 15 - l2irq);
-}
-
-static struct irq_chip mpc52xx_main_irqchip = {
-	.typename = "MPC52xx Main",
-	.mask = mpc52xx_main_mask,
-	.mask_ack = mpc52xx_main_mask,
-	.unmask = mpc52xx_main_unmask,
-};
-
-/*
- * Peripherals interrupt irq_chip
-*/
-
-static void mpc52xx_periph_mask(unsigned int virq)
-{
-	int irq;
-	int l2irq;
-
-	irq = irq_map[virq].hwirq;
-	l2irq = (irq & MPC52xx_IRQ_L2_MASK) >> MPC52xx_IRQ_L2_OFFSET;
-
-	pr_debug("%s: irq=%x. l2=%d\n", __func__, irq, l2irq);
-
-	io_be_setbit(&intr->per_mask, 31 - l2irq);
-}
-
-static void mpc52xx_periph_unmask(unsigned int virq)
-{
-	int irq;
-	int l2irq;
-
-	irq = irq_map[virq].hwirq;
-	l2irq = (irq & MPC52xx_IRQ_L2_MASK) >> MPC52xx_IRQ_L2_OFFSET;
-
-	pr_debug("%s: irq=%x. l2=%d\n", __func__, irq, l2irq);
-
-	io_be_clrbit(&intr->per_mask, 31 - l2irq);
-}
-
-static struct irq_chip mpc52xx_periph_irqchip = {
-	.typename = "MPC52xx Peripherals",
-	.mask = mpc52xx_periph_mask,
-	.mask_ack = mpc52xx_periph_mask,
-	.unmask = mpc52xx_periph_unmask,
-};
-
-/*
- * SDMA interrupt irq_chip
-*/
-
-static void mpc52xx_sdma_mask(unsigned int virq)
-{
-	int irq;
-	int l2irq;
-
-	irq = irq_map[virq].hwirq;
-	l2irq = (irq & MPC52xx_IRQ_L2_MASK) >> MPC52xx_IRQ_L2_OFFSET;
-
-	pr_debug("%s: irq=%x. l2=%d\n", __func__, irq, l2irq);
-
-	io_be_setbit(&sdma->IntMask, l2irq);
-}
-
-static void mpc52xx_sdma_unmask(unsigned int virq)
-{
-	int irq;
-	int l2irq;
-
-	irq = irq_map[virq].hwirq;
-	l2irq = (irq & MPC52xx_IRQ_L2_MASK) >> MPC52xx_IRQ_L2_OFFSET;
-
-	pr_debug("%s: irq=%x. l2=%d\n", __func__, irq, l2irq);
-
-	io_be_clrbit(&sdma->IntMask, l2irq);
-}
-
-static void mpc52xx_sdma_ack(unsigned int virq)
-{
-	int irq;
-	int l2irq;
-
-	irq = irq_map[virq].hwirq;
-	l2irq = (irq & MPC52xx_IRQ_L2_MASK) >> MPC52xx_IRQ_L2_OFFSET;
-
-	pr_debug("%s: irq=%x. l2=%d\n", __func__, irq, l2irq);
-
-	out_be32(&sdma->IntPend, 1 << l2irq);
-}
-
-static struct irq_chip mpc52xx_sdma_irqchip = {
-	.typename = "MPC52xx SDMA",
-	.mask = mpc52xx_sdma_mask,
-	.unmask = mpc52xx_sdma_unmask,
-	.ack = mpc52xx_sdma_ack,
-};
-
-/*
- * irq_host
-*/
-
-static int mpc52xx_irqhost_match(struct irq_host *h, struct device_node *node)
-{
-	pr_debug("%s: node=%p\n", __func__, node);
-	return mpc52xx_irqhost->host_data == node;
-}
-
-static int mpc52xx_irqhost_xlate(struct irq_host *h, struct device_node *ct,
-				 u32 * intspec, unsigned int intsize,
-				 irq_hw_number_t * out_hwirq,
-				 unsigned int *out_flags)
-{
-	int intrvect_l1;
-	int intrvect_l2;
-	int intrvect_type;
-	int intrvect_linux;
-
-	if (intsize != 3)
-		return -1;
-
-	intrvect_l1 = (int)intspec[0];
-	intrvect_l2 = (int)intspec[1];
-	intrvect_type = (int)intspec[2];
-
-	intrvect_linux =
-	    (intrvect_l1 << MPC52xx_IRQ_L1_OFFSET) & MPC52xx_IRQ_L1_MASK;
-	intrvect_linux |=
-	    (intrvect_l2 << MPC52xx_IRQ_L2_OFFSET) & MPC52xx_IRQ_L2_MASK;
-
-	pr_debug("return %x, l1=%d, l2=%d\n", intrvect_linux, intrvect_l1,
-		 intrvect_l2);
-
-	*out_hwirq = intrvect_linux;
-	*out_flags = mpc52xx_map_senses[intrvect_type];
-
-	return 0;
-}
-
-/*
- * this function retrieves the correct IRQ type out
- * of the MPC regs
- * Only externals IRQs needs this
-*/
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
-static int mpc52xx_irqhost_map(struct irq_host *h, unsigned int virq,
-			       irq_hw_number_t irq)
-{
-	int l1irq;
-	int l2irq;
-	struct irq_chip *good_irqchip;
-	void *good_handle;
-	int type;
-
-	l1irq = (irq & MPC52xx_IRQ_L1_MASK) >> MPC52xx_IRQ_L1_OFFSET;
-	l2irq = (irq & MPC52xx_IRQ_L2_MASK) >> MPC52xx_IRQ_L2_OFFSET;
-
-	/*
-	 * Most of ours IRQs will be level low
-	 * Only external IRQs on some platform may be others
-	 */
-	type = IRQ_TYPE_LEVEL_LOW;
-
-	switch (l1irq) {
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
-	default:
-		pr_debug("%s: Error, unknown L1 IRQ (0x%x)\n", __func__, l1irq);
-		printk(KERN_ERR "Unknow IRQ!\n");
-		return -EINVAL;
-	}
-
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
-
-	return 0;
-}
-
-static struct irq_host_ops mpc52xx_irqhost_ops = {
-	.match = mpc52xx_irqhost_match,
-	.xlate = mpc52xx_irqhost_xlate,
-	.map = mpc52xx_irqhost_map,
-};
-
-/*
- * init (public)
-*/
-
-void __init mpc52xx_init_irq(void)
-{
-	struct device_node *picnode = NULL;
-	int picnode_regsize;
-	u32 picnode_regoffset;
-
-	struct device_node *sdmanode = NULL;
-	int sdmanode_regsize;
-	u32 sdmanode_regoffset;
-
-	u64 size64;
-	int flags;
-
-	u32 intr_ctrl;
-
-	picnode = of_find_compatible_node(NULL, "interrupt-controller",
-						"mpc5200-pic");
-	if (picnode == NULL) {
-		printk(KERN_ERR "MPC52xx PIC: "
-			"Unable to find the interrupt controller "
-			"in the OpenFirmware device tree\n");
-		goto end;
-	}
-
-	sdmanode = of_find_compatible_node(NULL, "dma-controller",
-						 "mpc5200-bestcomm");
-	if (sdmanode == NULL) {
-		printk(KERN_ERR "MPC52xx PIC"
-			"Unable to find the Bestcomm DMA controller device "
-			"in the OpenFirmware device tree\n");
-		goto end;
-	}
-
-	/* Retrieve PIC ressources */
-	picnode_regoffset = (u32) of_get_address(picnode, 0, &size64, &flags);
-	if (picnode_regoffset == 0) {
-		printk(KERN_ERR "MPC52xx PIC"
-			"Unable to get the interrupt controller address\n");
-		goto end;
-	}
-
-	picnode_regoffset =
-		of_translate_address(picnode, (u32 *) picnode_regoffset);
-	picnode_regsize = (int)size64;
-
-	/* Retrieve SDMA ressources */
-	sdmanode_regoffset = (u32) of_get_address(sdmanode, 0, &size64, &flags);
-	if (sdmanode_regoffset == 0) {
-		printk(KERN_ERR "MPC52xx PIC: "
-			"Unable to get the Bestcomm DMA controller address\n");
-		goto end;
-	}
-
-	sdmanode_regoffset =
-	    of_translate_address(sdmanode, (u32 *) sdmanode_regoffset);
-	sdmanode_regsize = (int)size64;
-
-	/* Remap the necessary zones */
-	intr = ioremap(picnode_regoffset, picnode_regsize);
-	if (intr == NULL) {
-		printk(KERN_ERR "MPC52xx PIC: "
-			"Unable to ioremap interrupt controller registers!\n");
-		goto end;
-	}
-
-	sdma = ioremap(sdmanode_regoffset, sdmanode_regsize);
-	if (sdma == NULL) {
-		iounmap(intr);
-		printk(KERN_ERR "MPC52xx PIC: "
-			"Unable to ioremap Bestcomm DMA registers!\n");
-		goto end;
-	}
-
-	printk(KERN_INFO "MPC52xx PIC: MPC52xx PIC Remapped at 0x%8.8x\n",
-		picnode_regoffset);
-	printk(KERN_INFO "MPC52xx PIC: MPC52xx SDMA Remapped at 0x%8.8x\n",
-		sdmanode_regoffset);
-
-	/* Disable all interrupt sources. */
-	out_be32(&sdma->IntPend, 0xffffffff);	/* 1 means clear pending */
-	out_be32(&sdma->IntMask, 0xffffffff);	/* 1 means disabled */
-	out_be32(&intr->per_mask, 0x7ffffc00);	/* 1 means disabled */
-	out_be32(&intr->main_mask, 0x00010fff);	/* 1 means disabled */
-	intr_ctrl = in_be32(&intr->ctrl);
-	intr_ctrl &= 0x00ff0000;	/* Keeps IRQ[0-3] config */
-	intr_ctrl |=	0x0f000000 |	/* clear IRQ 0-3 */
-			0x00001000 |	/* MEE master external enable */
-			0x00000000 |	/* 0 means disable IRQ 0-3 */
-			0x00000001;	/* CEb route critical normally */
-	out_be32(&intr->ctrl, intr_ctrl);
-
-	/* Zero a bunch of the priority settings. */
-	out_be32(&intr->per_pri1, 0);
-	out_be32(&intr->per_pri2, 0);
-	out_be32(&intr->per_pri3, 0);
-	out_be32(&intr->main_pri1, 0);
-	out_be32(&intr->main_pri2, 0);
-
-	/*
-	 * As last step, add an irq host to translate the real
-	 * hw irq information provided by the ofw to linux virq
-	 */
-
-	mpc52xx_irqhost =
-	    irq_alloc_host(IRQ_HOST_MAP_LINEAR, MPC52xx_IRQ_HIGHTESTHWIRQ,
-			   &mpc52xx_irqhost_ops, -1);
-
-	if (mpc52xx_irqhost) {
-		mpc52xx_irqhost->host_data = picnode;
-		printk(KERN_INFO "MPC52xx PIC is up and running!\n");
-	} else {
-		printk(KERN_ERR
-			"MPC52xx PIC: Unable to allocate the IRQ host\n");
-	}
-
-end:
-	of_node_put(picnode);
-	of_node_put(sdmanode);
-}
-
-/*
- * get_irq (public)
-*/
-unsigned int mpc52xx_get_irq(void)
-{
-	u32 status;
-	int irq = NO_IRQ_IGNORE;
-
-	status = in_be32(&intr->enc_status);
-	if (status & 0x00000400) {	/* critical */
-		irq = (status >> 8) & 0x3;
-		if (irq == 2)	/* high priority peripheral */
-			goto peripheral;
-		irq |=	(MPC52xx_IRQ_L1_CRIT << MPC52xx_IRQ_L1_OFFSET) &
-			MPC52xx_IRQ_L1_MASK;
-	} else if (status & 0x00200000) {	/* main */
-		irq = (status >> 16) & 0x1f;
-		if (irq == 4)	/* low priority peripheral */
-			goto peripheral;
-		irq |=	(MPC52xx_IRQ_L1_MAIN << MPC52xx_IRQ_L1_OFFSET) &
-			MPC52xx_IRQ_L1_MASK;
-	} else if (status & 0x20000000) {	/* peripheral */
-	      peripheral:
-		irq = (status >> 24) & 0x1f;
-		if (irq == 0) {	/* bestcomm */
-			status = in_be32(&sdma->IntPend);
-			irq = ffs(status) - 1;
-			irq |=	(MPC52xx_IRQ_L1_SDMA << MPC52xx_IRQ_L1_OFFSET) &
-				MPC52xx_IRQ_L1_MASK;
-		} else
-			irq |=	(MPC52xx_IRQ_L1_PERP << MPC52xx_IRQ_L1_OFFSET) &
-				MPC52xx_IRQ_L1_MASK;
-	}
-
-	pr_debug("%s: irq=%x. virq=%d\n", __func__, irq,
-		 irq_linear_revmap(mpc52xx_irqhost, irq));
-
-	return irq_linear_revmap(mpc52xx_irqhost, irq);
-}
-
-- 
1.4.3.rc2.g0503

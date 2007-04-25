Return-Path: <mgreer@mvista.com>
Date: Wed, 25 Apr 2007 16:58:58 -0700
From: "Mark A. Greer" <mgreer@mvista.com>
To: Paul Mackerras <paulus@samba.org>
Subject: [PATCH 6/13] powerpc: Add arch/powerpc support for Marvell/mv64x60
	hostbridge
Message-ID: <20070425235858.GH4046@mag.az.mvista.com>
References: <20070425234630.GA4046@mag.az.mvista.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070425234630.GA4046@mag.az.mvista.com>
Cc: linuxppc-dev <Linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


From: Dale Farnsworth <dale@farnsworth.org>

Signed-off-by: Dale Farnsworth <dale@farnsworth.org>
---

 platforms/embedded6xx/Kconfig |    4 
 sysdev/Makefile               |    1 
 sysdev/mv64x60.c              |  343 ++++++++++++++++++++++++++++++++++++++++++
 sysdev/mv64x60.h              |    9 +
 4 files changed, 357 insertions(+)

Index: linux-2.6-powerpc-df/arch/powerpc/sysdev/mv64x60.c
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-2.6-powerpc-df/arch/powerpc/sysdev/mv64x60.c	2007-04-17 12:48:22.000000000 -0700
@@ -0,0 +1,343 @@
+/*
+ * Common routines for the Marvell mv64360/mv64460 host bridges (Discovery)
+ *
+ * Author: Dale Farnsworth <dale@farnsworth.org>
+ *
+ * 2007 (c) MontaVista, Software, Inc.  This file is licensed under
+ * the terms of the GNU General Public License version 2.  This program
+ * is licensed "as is" without any warranty of any kind, whether express
+ * or implied.
+ */
+
+#include <linux/stddef.h>
+#include <linux/kernel.h>
+#include <linux/init.h>
+#include <linux/irq.h>
+#include <linux/interrupt.h>
+#include <linux/spinlock.h>
+
+#include <asm/byteorder.h>
+#include <asm/io.h>
+#include <asm/prom.h>
+#include <asm/irq.h>
+#include <asm/machdep.h>
+
+#include "mv64x60.h"
+
+/* Interrupt Controller Interface Registers */
+#define MV64X60_IC_MAIN_CAUSE_LO	0x0004
+#define MV64X60_IC_MAIN_CAUSE_HI	0x000c
+#define MV64X60_IC_CPU0_INTR_MASK_LO	0x0014
+#define MV64X60_IC_CPU0_INTR_MASK_HI	0x001c
+#define MV64X60_IC_CPU0_SELECT_CAUSE	0x0024
+
+#define MV64X60_HIGH_GPP_GROUPS		0x0f000000
+#define MV64X60_SELECT_CAUSE_HIGH	0x40000000
+
+/* General Purpose Pins Controller Interface Registers */
+#define MV64x60_GPP_INTR_CAUSE		0x0008
+#define MV64x60_GPP_INTR_MASK		0x000c
+
+#define MV64x60_LEVEL1_LOW		0
+#define MV64x60_LEVEL1_HIGH		1
+#define MV64x60_LEVEL1_GPP		2
+
+#define MV64x60_LEVEL1_MASK		0x00000060
+#define MV64x60_LEVEL1_OFFSET		5
+
+#define MV64x60_LEVEL2_MASK		0x0000001f
+
+#define MV64x60_NUM_IRQS		96
+
+DEFINE_SPINLOCK(mv64x60_lock);
+
+static void __iomem *mv64x60_irq_reg_base;
+static void __iomem *mv64x60_gpp_reg_base;
+
+/*
+ * Interrupt Controller Handling
+ *
+ * The interrupt controller handles three groups of interrupts:
+ *   main low:	IRQ0-IRQ31
+ *   main high:	IRQ32-IRQ63
+ *   gpp:	IRQ64-IRQ95
+ *
+ * This code handles interrupts in two levels.  Level 1 selects the
+ * interrupt group, and level 2 selects an IRQ within that group.
+ * Each group has its own irq_chip structure.
+ */
+
+static u32 mv64x60_cached_low_mask  = 0;
+static u32 mv64x60_cached_high_mask = MV64X60_HIGH_GPP_GROUPS;
+static u32 mv64x60_cached_gpp_mask  = 0;
+
+static struct irq_host *mv64x60_irq_host;
+
+/*
+ * mv64x60_chip_low functions
+ */
+
+static void mv64x60_mask_low(unsigned int virq)
+{
+	int level2 = irq_map[virq].hwirq & MV64x60_LEVEL2_MASK;
+	unsigned long flags;
+
+	spin_lock_irqsave(&mv64x60_lock, flags);
+	mv64x60_cached_low_mask &= ~(1 << level2);
+	out_le32(mv64x60_irq_reg_base + MV64X60_IC_CPU0_INTR_MASK_LO,
+		 mv64x60_cached_low_mask);
+	spin_unlock_irqrestore(&mv64x60_lock, flags);
+	(void)in_le32(mv64x60_irq_reg_base + MV64X60_IC_CPU0_INTR_MASK_LO);
+}
+
+static void mv64x60_unmask_low(unsigned int virq)
+{
+	int level2 = irq_map[virq].hwirq & MV64x60_LEVEL2_MASK;
+	unsigned long flags;
+
+	spin_lock_irqsave(&mv64x60_lock, flags);
+	mv64x60_cached_low_mask |= 1 << level2;
+	out_le32(mv64x60_irq_reg_base + MV64X60_IC_CPU0_INTR_MASK_LO,
+		 mv64x60_cached_low_mask);
+	spin_unlock_irqrestore(&mv64x60_lock, flags);
+	(void)in_le32(mv64x60_irq_reg_base + MV64X60_IC_CPU0_INTR_MASK_LO);
+}
+
+static struct irq_chip mv64x60_chip_low = {
+	.name		= "mv64x60_low",
+	.mask		= mv64x60_mask_low,
+	.mask_ack	= mv64x60_mask_low,
+	.unmask		= mv64x60_unmask_low,
+};
+
+/*
+ * mv64x60_chip_high functions
+ */
+
+static void mv64x60_mask_high(unsigned int virq)
+{
+	int level2 = irq_map[virq].hwirq & MV64x60_LEVEL2_MASK;
+	unsigned long flags;
+
+	spin_lock_irqsave(&mv64x60_lock, flags);
+	mv64x60_cached_high_mask &= ~(1 << level2);
+	out_le32(mv64x60_irq_reg_base + MV64X60_IC_CPU0_INTR_MASK_HI,
+		 mv64x60_cached_high_mask);
+	spin_unlock_irqrestore(&mv64x60_lock, flags);
+	(void)in_le32(mv64x60_irq_reg_base + MV64X60_IC_CPU0_INTR_MASK_HI);
+}
+
+static void mv64x60_unmask_high(unsigned int virq)
+{
+	int level2 = irq_map[virq].hwirq & MV64x60_LEVEL2_MASK;
+	unsigned long flags;
+
+	spin_lock_irqsave(&mv64x60_lock, flags);
+	mv64x60_cached_high_mask |= 1 << level2;
+	out_le32(mv64x60_irq_reg_base + MV64X60_IC_CPU0_INTR_MASK_HI,
+		 mv64x60_cached_high_mask);
+	spin_unlock_irqrestore(&mv64x60_lock, flags);
+	(void)in_le32(mv64x60_irq_reg_base + MV64X60_IC_CPU0_INTR_MASK_HI);
+}
+
+static struct irq_chip mv64x60_chip_high = {
+	.name		= "mv64x60_high",
+	.mask		= mv64x60_mask_high,
+	.mask_ack	= mv64x60_mask_high,
+	.unmask		= mv64x60_unmask_high,
+};
+
+/*
+ * mv64x60_chip_gpp functions
+ */
+
+static void mv64x60_mask_gpp(unsigned int virq)
+{
+	int level2 = irq_map[virq].hwirq & MV64x60_LEVEL2_MASK;
+	unsigned long flags;
+
+	spin_lock_irqsave(&mv64x60_lock, flags);
+	mv64x60_cached_gpp_mask &= ~(1 << level2);
+	out_le32(mv64x60_gpp_reg_base + MV64x60_GPP_INTR_MASK,
+		 mv64x60_cached_gpp_mask);
+	spin_unlock_irqrestore(&mv64x60_lock, flags);
+	(void)in_le32(mv64x60_gpp_reg_base + MV64x60_GPP_INTR_MASK);
+}
+
+static void mv64x60_mask_ack_gpp(unsigned int virq)
+{
+	int level2 = irq_map[virq].hwirq & MV64x60_LEVEL2_MASK;
+	unsigned long flags;
+
+	spin_lock_irqsave(&mv64x60_lock, flags);
+	mv64x60_cached_gpp_mask &= ~(1 << level2);
+	out_le32(mv64x60_gpp_reg_base + MV64x60_GPP_INTR_MASK,
+		 mv64x60_cached_gpp_mask);
+	out_le32(mv64x60_gpp_reg_base + MV64x60_GPP_INTR_CAUSE,
+		 ~(1 << level2));
+	spin_unlock_irqrestore(&mv64x60_lock, flags);
+	(void)in_le32(mv64x60_gpp_reg_base + MV64x60_GPP_INTR_CAUSE);
+}
+
+static void mv64x60_unmask_gpp(unsigned int virq)
+{
+	int level2 = irq_map[virq].hwirq & MV64x60_LEVEL2_MASK;
+	unsigned long flags;
+
+	spin_lock_irqsave(&mv64x60_lock, flags);
+	mv64x60_cached_gpp_mask |= 1 << level2;
+	out_le32(mv64x60_gpp_reg_base + MV64x60_GPP_INTR_MASK,
+		 mv64x60_cached_gpp_mask);
+	spin_unlock_irqrestore(&mv64x60_lock, flags);
+	(void)in_le32(mv64x60_gpp_reg_base + MV64x60_GPP_INTR_MASK);
+}
+
+static struct irq_chip mv64x60_chip_gpp = {
+	.name		= "mv64x60_gpp",
+	.mask		= mv64x60_mask_gpp,
+	.mask_ack	= mv64x60_mask_ack_gpp,
+	.unmask		= mv64x60_unmask_gpp,
+};
+
+/*
+ * mv64x60_host_ops functions
+ */
+
+static int mv64x60_host_match(struct irq_host *h, struct device_node *np)
+{
+	return mv64x60_irq_host->host_data == np;
+}
+
+static struct irq_chip *mv64x60_chips[] = {
+	[MV64x60_LEVEL1_LOW]  = &mv64x60_chip_low,
+	[MV64x60_LEVEL1_HIGH] = &mv64x60_chip_high,
+	[MV64x60_LEVEL1_GPP]  = &mv64x60_chip_gpp,
+};
+
+static int mv64x60_host_map(struct irq_host *h, unsigned int virq,
+			  irq_hw_number_t hwirq)
+{
+	int level1;
+
+	get_irq_desc(virq)->status |= IRQ_LEVEL;
+
+	level1 = (hwirq & MV64x60_LEVEL1_MASK) >> MV64x60_LEVEL1_OFFSET;
+	BUG_ON(level1 > MV64x60_LEVEL1_GPP);
+	set_irq_chip_and_handler(virq, mv64x60_chips[level1], handle_level_irq);
+
+	return 0;
+}
+
+static struct irq_host_ops mv64x60_host_ops = {
+	.match = mv64x60_host_match,
+	.map   = mv64x60_host_map,
+};
+
+/*
+ * Global functions
+ */
+
+void __init mv64x60_init_irq(void)
+{
+	struct device_node *np;
+	phys_addr_t paddr;
+	unsigned int size;
+	const unsigned int *reg;
+	unsigned long flags;
+
+	np = of_find_compatible_node(NULL, "mv64x60-gpp", "mv64x60-gpp");
+	reg = of_get_property(np, "reg", &size);
+	paddr = of_translate_address(np, reg);
+	mv64x60_gpp_reg_base = ioremap(paddr, reg[1]);
+	of_node_put(np);
+
+	np = of_find_compatible_node(NULL, "mv64x60-pic", "mv64x60-pic");
+	reg = of_get_property(np, "reg", &size);
+	paddr = of_translate_address(np, reg);
+	of_node_put(np);
+	mv64x60_irq_reg_base = ioremap(paddr, reg[1]);
+
+	mv64x60_irq_host = irq_alloc_host(IRQ_HOST_MAP_LINEAR, MV64x60_NUM_IRQS,
+					  &mv64x60_host_ops, MV64x60_NUM_IRQS);
+
+	mv64x60_irq_host->host_data = np;
+
+	spin_lock_irqsave(&mv64x60_lock, flags);
+	out_le32(mv64x60_gpp_reg_base + MV64x60_GPP_INTR_MASK,
+		 mv64x60_cached_gpp_mask);
+	out_le32(mv64x60_irq_reg_base + MV64X60_IC_CPU0_INTR_MASK_LO,
+		 mv64x60_cached_low_mask);
+	out_le32(mv64x60_irq_reg_base + MV64X60_IC_CPU0_INTR_MASK_HI,
+		 mv64x60_cached_high_mask);
+
+	out_le32(mv64x60_gpp_reg_base + MV64x60_GPP_INTR_CAUSE, 0);
+	out_le32(mv64x60_irq_reg_base + MV64X60_IC_MAIN_CAUSE_LO, 0);
+	out_le32(mv64x60_irq_reg_base + MV64X60_IC_MAIN_CAUSE_HI, 0);
+	spin_unlock_irqrestore(&mv64x60_lock, flags);
+}
+
+unsigned int mv64x60_get_irq(void)
+{
+	u32 cause;
+	int level1;
+	irq_hw_number_t hwirq;
+	int virq = NO_IRQ;
+
+	cause = in_le32(mv64x60_irq_reg_base + MV64X60_IC_CPU0_SELECT_CAUSE);
+	if (cause & MV64X60_SELECT_CAUSE_HIGH) {
+		cause &= mv64x60_cached_high_mask;
+		level1 = MV64x60_LEVEL1_HIGH;
+		if (cause & MV64X60_HIGH_GPP_GROUPS) {
+			cause = in_le32(mv64x60_gpp_reg_base +
+					MV64x60_GPP_INTR_CAUSE);
+			cause &= mv64x60_cached_gpp_mask;
+			level1 = MV64x60_LEVEL1_GPP;
+		}
+	} else {
+		cause &= mv64x60_cached_low_mask;
+		level1 = MV64x60_LEVEL1_LOW;
+	}
+	if (cause) {
+		hwirq = (level1 << MV64x60_LEVEL1_OFFSET) | __ilog2(cause);
+		virq = irq_linear_revmap(mv64x60_irq_host, hwirq);
+	}
+
+	return virq;
+}
+
+/*
+ * The bootwrapper sets the coherency of the DMA windows according to
+ * the setting in the device tree.  For the kernel, coherency is a
+ * compile-time configuration option.  Fail if there is a mismatch.
+ */
+
+#ifdef CONFIG_NOT_COHERENT_CACHE
+#define KERNEL_COHERENCY	0
+#else
+#define KERNEL_COHERENCY	1
+#endif
+
+int __init mv64x60_verify_cache_coherency(void)
+{
+	struct device_node *np;
+	const void *prop;
+	int devtree_coherency;
+
+	np = of_find_node_by_path("/");
+	prop = of_get_property(np, "coherency-off", NULL);
+	of_node_put(np);
+
+	devtree_coherency = prop ? 0 : 1;
+
+	if (devtree_coherency != KERNEL_COHERENCY) {
+		printk(KERN_ERR
+			"kernel coherency:%s != device tree_coherency:%s\n",
+			KERNEL_COHERENCY ? "on" : "off",
+			devtree_coherency ? "on" : "off");
+		BUG();
+	}
+
+	return 0;
+}
+
+late_initcall(mv64x60_verify_cache_coherency);
Index: linux-2.6-powerpc-df/arch/powerpc/sysdev/mv64x60.h
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-2.6-powerpc-df/arch/powerpc/sysdev/mv64x60.h	2007-04-17 12:47:28.000000000 -0700
@@ -0,0 +1,9 @@
+#ifndef __MV64X60_H__
+#define __MV64X60_H__
+
+#include <linux/init.h>
+
+extern void __init mv64x60_init_irq(void);
+extern unsigned int mv64x60_get_irq(void);
+
+#endif /* __MV64X60_H__ */
Index: linux-2.6-powerpc-df/arch/powerpc/platforms/embedded6xx/Kconfig
===================================================================
--- linux-2.6-powerpc-df.orig/arch/powerpc/platforms/embedded6xx/Kconfig	2007-04-17 11:35:26.000000000 -0700
+++ linux-2.6-powerpc-df/arch/powerpc/platforms/embedded6xx/Kconfig	2007-04-17 12:47:27.000000000 -0700
@@ -38,6 +38,10 @@
 	select PPC_INDIRECT_PCI
 	default y
 
+config MV64X60
+	bool
+	select PPC_INDIRECT_PCI
+
 config MPC10X_OPENPIC
 	bool
 	depends on LINKSTATION
Index: linux-2.6-powerpc-df/arch/powerpc/sysdev/Makefile
===================================================================
--- linux-2.6-powerpc-df.orig/arch/powerpc/sysdev/Makefile	2007-04-17 11:35:26.000000000 -0700
+++ linux-2.6-powerpc-df/arch/powerpc/sysdev/Makefile	2007-04-17 12:46:39.000000000 -0700
@@ -14,6 +14,7 @@
 obj-$(CONFIG_FSL_PCIE)		+= fsl_pcie.o
 obj-$(CONFIG_TSI108_BRIDGE)	+= tsi108_pci.o tsi108_dev.o
 obj-$(CONFIG_QUICC_ENGINE)	+= qe_lib/
+obj-$(CONFIG_MV64X60)		+= mv64x60.o
 
 # contains only the suspend handler for time
 obj-$(CONFIG_PM)		+= timer.o

Return-Path: <jrigby@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 0BAADDE395
	for <linuxppc-dev@ozlabs.org>; Sat, 21 Jun 2008 02:58:51 +1000 (EST)
Received: from de01smr01.freescale.net (de01smr01.freescale.net [10.208.0.31])
	by de01egw02.freescale.net (8.12.11/de01egw02) with ESMTP id
	m5KGwj6d024100
	for <linuxppc-dev@ozlabs.org>; Fri, 20 Jun 2008 09:58:45 -0700 (MST)
From: John Rigby <jrigby@freescale.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 4/6] MPC5121 Add MPC5121ADS cpld support
Date: Fri, 20 Jun 2008 10:58:37 -0600
Message-Id: <1213981119-1979-5-git-send-email-jrigby@freescale.com>
In-Reply-To: <1213981119-1979-4-git-send-email-jrigby@freescale.com>
References: <1213981119-1979-1-git-send-email-jrigby@freescale.com>
	<1213981119-1979-2-git-send-email-jrigby@freescale.com>
	<1213981119-1979-3-git-send-email-jrigby@freescale.com>
	<1213981119-1979-4-git-send-email-jrigby@freescale.com>
Cc: John Rigby <jrigby@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Add a interrupt host for the interrupt
controller in the mpc5121ads cpld.
PCI interrupts are 0-7 the rest are 8-15
Touchscreen pendown irq is hardwired to irq1
All other irqs are chainged to irq0

Signed-off-by: John Rigby <jrigby@freescale.com>
---
 arch/powerpc/platforms/512x/Kconfig            |    1 +
 arch/powerpc/platforms/512x/Makefile           |    2 +-
 arch/powerpc/platforms/512x/mpc5121_ads.c      |   14 ++-
 arch/powerpc/platforms/512x/mpc5121_ads.h      |   14 ++
 arch/powerpc/platforms/512x/mpc5121_ads_cpld.c |  204 ++++++++++++++++++++++++
 5 files changed, 233 insertions(+), 2 deletions(-)
 create mode 100644 arch/powerpc/platforms/512x/mpc5121_ads.h
 create mode 100644 arch/powerpc/platforms/512x/mpc5121_ads_cpld.c

diff --git a/arch/powerpc/platforms/512x/Kconfig b/arch/powerpc/platforms/512x/Kconfig
index f9a04da..0fd3b00 100644
--- a/arch/powerpc/platforms/512x/Kconfig
+++ b/arch/powerpc/platforms/512x/Kconfig
@@ -12,6 +12,7 @@ config MPC5121_ADS
 	depends on PPC_MULTIPLATFORM && PPC32
 	select DEFAULT_UIMAGE
 	select PPC_MPC5121
+	select MPC5121_ADS_CPLD
 	help
 	  This option enables support for the MPC5121E ADS board.
 
diff --git a/arch/powerpc/platforms/512x/Makefile b/arch/powerpc/platforms/512x/Makefile
index e6674c8..aaa934b 100644
--- a/arch/powerpc/platforms/512x/Makefile
+++ b/arch/powerpc/platforms/512x/Makefile
@@ -2,5 +2,5 @@
 # Makefile for the Freescale PowerPC 512x linux kernel.
 #
 obj-y				:= clock.o mpc512x_shared.o
-obj-$(CONFIG_MPC5121_ADS)	+= mpc5121_ads.o
+obj-$(CONFIG_MPC5121_ADS)	+= mpc5121_ads.o mpc5121_ads_cpld.o
 obj-$(CONFIG_MPC5121_GENERIC)	+= mpc5121_generic.o
diff --git a/arch/powerpc/platforms/512x/mpc5121_ads.c b/arch/powerpc/platforms/512x/mpc5121_ads.c
index 45bb2ef..36805fd 100644
--- a/arch/powerpc/platforms/512x/mpc5121_ads.c
+++ b/arch/powerpc/platforms/512x/mpc5121_ads.c
@@ -1,5 +1,5 @@
 /*
- * Copyright (C) 2007 Freescale Semiconductor, Inc. All rights reserved.
+ * Copyright (C) 2007, 2008 Freescale Semiconductor, Inc. All rights reserved.
  *
  * Author: John Rigby, <jrigby@freescale.com>, Thur Mar 29 2007
  *
@@ -23,6 +23,16 @@
 #include <asm/time.h>
 
 #include "mpc512x.h"
+#include "mpc5121_ads.h"
+
+static void __init mpc5121_ads_setup_arch(void)
+{
+	printk(KERN_INFO "MPC5121 ADS board from Freescale Semiconductor\n");
+	/*
+	 * cpld regs are needed early
+	 */
+	mpc5121_ads_cpld_map();
+}
 
 static struct of_device_id __initdata of_bus_ids[] = {
 	{ .name = "soc", },
@@ -41,6 +51,7 @@ static void __init mpc5121_ads_declare_of_platform_devices(void)
 static void __init mpc5121_ads_init_IRQ(void)
 {
 	mpc512x_init_IRQ();
+	mpc5121_ads_cpld_pic_init();
 }
 
 /*
@@ -56,6 +67,7 @@ static int __init mpc5121_ads_probe(void)
 define_machine(mpc5121_ads) {
 	.name			= "MPC5121 ADS",
 	.probe			= mpc5121_ads_probe,
+	.setup_arch		= mpc5121_ads_setup_arch,
 	.init			= mpc5121_ads_declare_of_platform_devices,
 	.init_IRQ		= mpc5121_ads_init_IRQ,
 	.get_irq		= ipic_get_irq,
diff --git a/arch/powerpc/platforms/512x/mpc5121_ads.h b/arch/powerpc/platforms/512x/mpc5121_ads.h
new file mode 100644
index 0000000..885992e
--- /dev/null
+++ b/arch/powerpc/platforms/512x/mpc5121_ads.h
@@ -0,0 +1,14 @@
+/*
+ * Copyright (C) 2008 Freescale Semiconductor, Inc. All rights reserved.
+ *
+ * This program is free software; you can redistribute  it and/or modify it
+ * under  the terms of  the GNU General  Public License as published by the
+ * Free Software Foundation;  either version 2 of the  License, or (at your
+ * option) any later version.
+ */
+
+#ifndef __MPC512ADS_H__
+#define __MPC512ADS_H__
+extern void __init mpc5121_ads_cpld_map(void);
+extern void __init mpc5121_ads_cpld_pic_init(void);
+#endif				/* __MPC512ADS_H__ */
diff --git a/arch/powerpc/platforms/512x/mpc5121_ads_cpld.c b/arch/powerpc/platforms/512x/mpc5121_ads_cpld.c
new file mode 100644
index 0000000..a6ce805
--- /dev/null
+++ b/arch/powerpc/platforms/512x/mpc5121_ads_cpld.c
@@ -0,0 +1,204 @@
+/*
+ * Copyright (C) 2008 Freescale Semiconductor, Inc. All rights reserved.
+ *
+ * Author: John Rigby, <jrigby@freescale.com>
+ *
+ * Description:
+ * MPC5121ADS CPLD irq handling
+ *
+ * This is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ */
+
+#undef DEBUG
+
+#include <linux/kernel.h>
+#include <linux/interrupt.h>
+#include <linux/irq.h>
+#include <linux/io.h>
+#include <asm/prom.h>
+
+static struct device_node *cpld_pic_node;
+static struct irq_host *cpld_pic_host;
+
+/*
+ * Bits to ignore in the misc_status register
+ * 0x10 touch screen pendown is hard routed to irq1
+ * 0x02 pci status is read from pci status register
+ */
+#define MISC_IGNORE 0x12
+
+/*
+ * Nothing to ignore in pci status register
+ */
+#define PCI_IGNORE 0x00
+
+struct cpld_pic {
+	u8 pci_mask;
+	u8 pci_status;
+	u8 route;
+	u8 misc_mask;
+	u8 misc_status;
+	u8 misc_control;
+};
+
+static struct cpld_pic __iomem *cpld_regs;
+
+static void __iomem *
+irq_to_pic_mask(unsigned int irq)
+{
+	return irq <= 7 ? &cpld_regs->pci_mask : &cpld_regs->misc_mask;
+}
+
+static unsigned int
+irq_to_pic_bit(unsigned int irq)
+{
+	return 1 << (irq & 0x7);
+}
+
+static void
+cpld_mask_irq(unsigned int irq)
+{
+	unsigned int cpld_irq = (unsigned int)irq_map[irq].hwirq;
+	void __iomem *pic_mask = irq_to_pic_mask(cpld_irq);
+
+	out_8(pic_mask,
+	      in_8(pic_mask) | irq_to_pic_bit(cpld_irq));
+}
+
+static void
+cpld_unmask_irq(unsigned int irq)
+{
+	unsigned int cpld_irq = (unsigned int)irq_map[irq].hwirq;
+	void __iomem *pic_mask = irq_to_pic_mask(cpld_irq);
+
+	out_8(pic_mask,
+	      in_8(pic_mask) & ~irq_to_pic_bit(cpld_irq));
+}
+
+static struct irq_chip cpld_pic = {
+	.typename = " CPLD PIC ",
+	.mask = cpld_mask_irq,
+	.ack = cpld_mask_irq,
+	.unmask = cpld_unmask_irq,
+};
+
+static int
+cpld_pic_get_irq(int offset, u8 ignore, u8 __iomem *statusp,
+			    u8 __iomem *maskp)
+{
+	int cpld_irq;
+	u8 status = in_8(statusp);
+	u8 mask = in_8(maskp);
+
+	/* ignore don't cares and masked irqs */
+	status |= (ignore | mask);
+
+	if (status == 0xff)
+		return NO_IRQ_IGNORE;
+
+	cpld_irq = ffz(status) + offset;
+
+	return irq_linear_revmap(cpld_pic_host, cpld_irq);
+}
+
+static void
+cpld_pic_cascade(unsigned int irq, struct irq_desc *desc)
+{
+	irq = cpld_pic_get_irq(0, PCI_IGNORE, &cpld_regs->pci_status,
+		&cpld_regs->pci_mask);
+	if (irq != NO_IRQ && irq != NO_IRQ_IGNORE) {
+		generic_handle_irq(irq);
+		return;
+	}
+
+	irq = cpld_pic_get_irq(8, MISC_IGNORE, &cpld_regs->misc_status,
+		&cpld_regs->misc_mask);
+	if (irq != NO_IRQ && irq != NO_IRQ_IGNORE) {
+		generic_handle_irq(irq);
+		return;
+	}
+}
+
+static int
+cpld_pic_host_match(struct irq_host *h, struct device_node *node)
+{
+	return cpld_pic_node == node;
+}
+
+static int
+cpld_pic_host_map(struct irq_host *h, unsigned int virq,
+			     irq_hw_number_t hw)
+{
+	get_irq_desc(virq)->status |= IRQ_LEVEL;
+	set_irq_chip_and_handler(virq, &cpld_pic, handle_level_irq);
+	return 0;
+}
+
+static struct
+irq_host_ops cpld_pic_host_ops = {
+	.match = cpld_pic_host_match,
+	.map = cpld_pic_host_map,
+};
+
+void __init
+mpc5121_ads_cpld_map(void)
+{
+	struct device_node *np = NULL;
+
+	np = of_find_compatible_node(NULL, NULL, "fsl,mpc5121ads-cpld-pic");
+	if (!np) {
+		printk(KERN_ERR "CPLD PIC init: can not find cpld-pic node\n");
+		return;
+	}
+
+	cpld_regs = of_iomap(np, 0);
+	of_node_put(np);
+}
+
+void __init
+mpc5121_ads_cpld_pic_init(void)
+{
+	unsigned int cascade_irq;
+	struct device_node *np = NULL;
+
+	pr_debug("cpld_ic_init\n");
+
+	np = of_find_compatible_node(NULL, NULL, "fsl,mpc5121ads-cpld-pic");
+	if (!np) {
+		printk(KERN_ERR "CPLD PIC init: can not find cpld-pic node\n");
+		return;
+	}
+
+	if (!cpld_regs)
+		goto end;
+
+	cascade_irq = irq_of_parse_and_map(np, 0);
+	if (cascade_irq == NO_IRQ)
+		goto end;
+
+	/*
+	 * statically route touch screen pendown through 1
+	 * and ignore it here
+	 * route all others through our cascade irq
+	 */
+	out_8(&cpld_regs->route, 0xfd);
+	out_8(&cpld_regs->pci_mask, 0xff);
+	/* unmask pci ints in misc mask */
+	out_8(&cpld_regs->misc_mask, ~(MISC_IGNORE));
+
+	cpld_pic_node = of_node_get(np);
+
+	cpld_pic_host =
+	    irq_alloc_host(np, IRQ_HOST_MAP_LINEAR, 16, &cpld_pic_host_ops, 16);
+	if (!cpld_pic_host) {
+		printk(KERN_ERR "CPLD PIC: failed to allocate irq host!\n");
+		goto end;
+	}
+
+	set_irq_chained_handler(cascade_irq, cpld_pic_cascade);
+end:
+	of_node_put(np);
+}
-- 
1.5.6.rc0.46.gd2b3

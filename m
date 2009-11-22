Return-Path: <albert_herranz@yahoo.es>
Received: from smtp106.mail.ukl.yahoo.com (smtp106.mail.ukl.yahoo.com
	[77.238.184.38]) by ozlabs.org (Postfix) with SMTP id B35C41007FD
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon, 23 Nov 2009 09:02:11 +1100 (EST)
From: Albert Herranz <albert_herranz@yahoo.es>
To: linuxppc-dev@lists.ozlabs.org
Subject: [RFC PATCH 11/19] powerpc: gamecube/wii: flipper interrupt controller
	support
Date: Sun, 22 Nov 2009 23:01:42 +0100
Message-Id: <1258927311-4340-12-git-send-email-albert_herranz@yahoo.es>
In-Reply-To: <1258927311-4340-11-git-send-email-albert_herranz@yahoo.es>
References: <1258927311-4340-1-git-send-email-albert_herranz@yahoo.es>
	<1258927311-4340-2-git-send-email-albert_herranz@yahoo.es>
	<1258927311-4340-3-git-send-email-albert_herranz@yahoo.es>
	<1258927311-4340-4-git-send-email-albert_herranz@yahoo.es>
	<1258927311-4340-5-git-send-email-albert_herranz@yahoo.es>
	<1258927311-4340-6-git-send-email-albert_herranz@yahoo.es>
	<1258927311-4340-7-git-send-email-albert_herranz@yahoo.es>
	<1258927311-4340-8-git-send-email-albert_herranz@yahoo.es>
	<1258927311-4340-9-git-send-email-albert_herranz@yahoo.es>
	<1258927311-4340-10-git-send-email-albert_herranz@yahoo.es>
	<1258927311-4340-11-git-send-email-albert_herranz@yahoo.es>
Cc: Albert Herranz <albert_herranz@yahoo.es>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Add support for the interrupt controller included in the "Flipper"
chipset of the Nintendo GameCube video game console.
The same interrupt controller is also present in the "Hollywood" chipset
of the Nintendo Wii.

Signed-off-by: Albert Herranz <albert_herranz@yahoo.es>
---
 arch/powerpc/platforms/embedded6xx/Kconfig       |    6 +
 arch/powerpc/platforms/embedded6xx/Makefile      |    1 +
 arch/powerpc/platforms/embedded6xx/flipper-pic.c |  247 ++++++++++++++++++++++
 arch/powerpc/platforms/embedded6xx/flipper-pic.h |   25 +++
 4 files changed, 279 insertions(+), 0 deletions(-)
 create mode 100644 arch/powerpc/platforms/embedded6xx/flipper-pic.c
 create mode 100644 arch/powerpc/platforms/embedded6xx/flipper-pic.h

diff --git a/arch/powerpc/platforms/embedded6xx/Kconfig b/arch/powerpc/platforms/embedded6xx/Kconfig
index bfd88be..29a98c6 100644
--- a/arch/powerpc/platforms/embedded6xx/Kconfig
+++ b/arch/powerpc/platforms/embedded6xx/Kconfig
@@ -94,6 +94,7 @@ config MPC10X_STORE_GATHERING
 config GAMECUBE_COMMON
 	bool
 	select NOT_COHERENT_CACHE
+	select FLIPPER_PIC
 
 config USBGECKO_UDBG
 	bool "USB Gecko udbg console for the Nintendo GameCube/Wii"
@@ -108,3 +109,8 @@ config USBGECKO_UDBG
 
 	  If in doubt, say N here.
 
+config FLIPPER_PIC
+	bool
+	depends on GAMECUBE_COMMON
+	default y
+
diff --git a/arch/powerpc/platforms/embedded6xx/Makefile b/arch/powerpc/platforms/embedded6xx/Makefile
index 0ab7492..35258fd 100644
--- a/arch/powerpc/platforms/embedded6xx/Makefile
+++ b/arch/powerpc/platforms/embedded6xx/Makefile
@@ -8,3 +8,4 @@ obj-$(CONFIG_PPC_HOLLY)		+= holly.o
 obj-$(CONFIG_PPC_PRPMC2800)	+= prpmc2800.o
 obj-$(CONFIG_PPC_C2K)		+= c2k.o
 obj-$(CONFIG_USBGECKO_UDBG)	+= usbgecko_udbg.o
+obj-$(CONFIG_FLIPPER_PIC)	+= flipper-pic.o
diff --git a/arch/powerpc/platforms/embedded6xx/flipper-pic.c b/arch/powerpc/platforms/embedded6xx/flipper-pic.c
new file mode 100644
index 0000000..98c2e9f
--- /dev/null
+++ b/arch/powerpc/platforms/embedded6xx/flipper-pic.c
@@ -0,0 +1,247 @@
+/*
+ * arch/powerpc/platforms/embedded6xx/flipper-pic.c
+ *
+ * Nintendo GameCube/Wii "Flipper" interrupt controller support.
+ * Copyright (C) 2004-2009 The GameCube Linux Team
+ * Copyright (C) 2007,2008,2009 Albert Herranz
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version 2
+ * of the License, or (at your option) any later version.
+ *
+ */
+#define DRV_MODULE_NAME "flipper-pic"
+#define pr_fmt(fmt) DRV_MODULE_NAME ": " fmt
+
+#include <linux/kernel.h>
+#include <linux/init.h>
+#include <linux/irq.h>
+#include <linux/of.h>
+#include <asm/io.h>
+
+#include "flipper-pic.h"
+
+#define FLIPPER_NR_IRQS		32
+
+/*
+ * Each interrupt has a corresponding bit in both
+ * the Interrupt Cause (ICR) and Interrupt Mask (IMR) registers.
+ *
+ * Enabling/disabling an interrupt line involves asserting/clearing
+ * the corresponding bit in IMR. ACK'ing a request simply involves
+ * asserting the corresponding bit in ICR.
+ */
+#define FLIPPER_ICR		0x00
+#define FLIPPER_ICR_RSS		(1<<16) /* reset switch state */
+
+#define FLIPPER_IMR		0x04
+
+#define FLIPPER_RESET		0x24
+
+
+/*
+ * IRQ chip hooks.
+ *
+ */
+
+static void flipper_pic_mask_and_ack(unsigned int virq)
+{
+	int irq = virq_to_hw(virq);
+	void __iomem *io_base = get_irq_chip_data(virq);
+
+	clear_bit(irq, io_base + FLIPPER_IMR);
+	set_bit(irq, io_base + FLIPPER_ICR);
+}
+
+static void flipper_pic_ack(unsigned int virq)
+{
+	int irq = virq_to_hw(virq);
+	void __iomem *io_base = get_irq_chip_data(virq);
+
+	set_bit(irq, io_base + FLIPPER_ICR);
+}
+
+static void flipper_pic_mask(unsigned int virq)
+{
+	int irq = virq_to_hw(virq);
+	void __iomem *io_base = get_irq_chip_data(virq);
+
+	clear_bit(irq, io_base + FLIPPER_IMR);
+}
+
+static void flipper_pic_unmask(unsigned int virq)
+{
+	int irq = virq_to_hw(virq);
+	void __iomem *io_base = get_irq_chip_data(virq);
+
+	set_bit(irq, io_base + FLIPPER_IMR);
+}
+
+
+static struct irq_chip flipper_pic = {
+	.typename	= "flipper-pic",
+	.ack		= flipper_pic_ack,
+	.mask_ack	= flipper_pic_mask_and_ack,
+	.mask		= flipper_pic_mask,
+	.unmask		= flipper_pic_unmask,
+};
+
+/*
+ * IRQ host hooks.
+ *
+ */
+
+static struct irq_host *flipper_irq_host;
+
+static int flipper_pic_map(struct irq_host *h, unsigned int virq,
+			   irq_hw_number_t hwirq)
+{
+	set_irq_chip_data(virq, h->host_data);
+	get_irq_desc(virq)->status |= IRQ_LEVEL;
+	set_irq_chip_and_handler(virq, &flipper_pic, handle_level_irq);
+	return 0;
+}
+
+static void flipper_pic_unmap(struct irq_host *h, unsigned int irq)
+{
+	set_irq_chip_data(irq, NULL);
+	set_irq_chip(irq, NULL);
+}
+
+static int flipper_pic_match(struct irq_host *h, struct device_node *np)
+{
+	return 1;
+}
+
+
+static struct irq_host_ops flipper_irq_host_ops = {
+	.map = flipper_pic_map,
+	.unmap = flipper_pic_unmap,
+	.match = flipper_pic_match,
+};
+
+/*
+ * Platform hooks.
+ *
+ */
+
+static void __flipper_quiesce(void __iomem *io_base)
+{
+	/* mask and ack all IRQs */
+	out_be32(io_base + FLIPPER_IMR, 0x00000000);
+	out_be32(io_base + FLIPPER_ICR, 0xffffffff);
+}
+
+struct irq_host * __init flipper_pic_init(struct device_node *np)
+{
+	struct irq_host *irq_host;
+	struct resource res;
+	void __iomem *io_base;
+	int retval;
+
+	retval = of_address_to_resource(np, 0, &res);
+	if (retval) {
+		pr_err("no io memory range found\n");
+		return NULL;
+	}
+	io_base = ioremap(res.start, res.end - res.start + 1);
+
+	pr_info("controller at 0x%08x mapped to 0x%p\n", res.start, io_base);
+
+	__flipper_quiesce(io_base);
+
+	irq_host = irq_alloc_host(np, IRQ_HOST_MAP_LINEAR, FLIPPER_NR_IRQS,
+				  &flipper_irq_host_ops, -1);
+	if (!irq_host) {
+		pr_err("failed to allocate irq_host\n");
+		return NULL;
+	}
+
+	irq_host->host_data = io_base;
+
+	return irq_host;
+}
+
+unsigned int flipper_pic_get_irq(void)
+{
+	void __iomem *io_base = flipper_irq_host->host_data;
+	int irq;
+	u32 irq_status;
+
+	irq_status = in_be32(io_base + FLIPPER_ICR) &
+		     in_be32(io_base + FLIPPER_IMR);
+	if (irq_status == 0)
+		return -1;	/* no more IRQs pending */
+
+	__asm__ __volatile__("cntlzw %0,%1" : "=r"(irq) : "r"(irq_status));
+	return irq_linear_revmap(flipper_irq_host, 31 - irq);
+}
+
+/*
+ * Probe function.
+ *
+ */
+
+void __init flipper_pic_probe(void)
+{
+	struct device_node *np;
+
+	np = of_find_compatible_node(NULL, NULL, "nintendo,flipper-pic");
+	BUG_ON(!np);
+
+	flipper_irq_host = flipper_pic_init(np);
+	BUG_ON(!flipper_irq_host);
+
+	irq_set_default_host(flipper_irq_host);
+
+	of_node_put(np);
+}
+
+/*
+ * Misc functions related to the flipper chipset.
+ *
+ */
+
+/**
+ * flipper_quiesce() - quiesce flipper irq controller
+ *
+ * Mask and ack all interrupt sources.
+ *
+ */
+void flipper_quiesce(void)
+{
+	void __iomem *io_base = flipper_irq_host->host_data;
+
+	__flipper_quiesce(io_base);
+}
+
+/*
+ * Resets the platform.
+ */
+void flipper_platform_reset(void)
+{
+	void __iomem *io_base;
+
+	if (flipper_irq_host && flipper_irq_host->host_data) {
+		io_base = flipper_irq_host->host_data;
+		out_8(io_base + FLIPPER_RESET, 0x00);
+	}
+}
+
+/*
+ * Returns non-zero if the reset button is pressed.
+ */
+int flipper_is_reset_button_pressed(void)
+{
+	void __iomem *io_base;
+	u32 icr;
+
+	if (flipper_irq_host && flipper_irq_host->host_data) {
+		io_base = flipper_irq_host->host_data;
+		icr = in_be32(io_base + FLIPPER_ICR);
+		return !(icr & FLIPPER_ICR_RSS);
+	}
+	return 0;
+}
+
diff --git a/arch/powerpc/platforms/embedded6xx/flipper-pic.h b/arch/powerpc/platforms/embedded6xx/flipper-pic.h
new file mode 100644
index 0000000..e339186
--- /dev/null
+++ b/arch/powerpc/platforms/embedded6xx/flipper-pic.h
@@ -0,0 +1,25 @@
+/*
+ * arch/powerpc/platforms/embedded6xx/flipper-pic.h
+ *
+ * Nintendo GameCube/Wii "Flipper" interrupt controller support.
+ * Copyright (C) 2004-2009 The GameCube Linux Team
+ * Copyright (C) 2007,2008,2009 Albert Herranz
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version 2
+ * of the License, or (at your option) any later version.
+ *
+ */
+
+#ifndef __FLIPPER_PIC_H
+#define __FLIPPER_PIC_H
+
+unsigned int flipper_pic_get_irq(void);
+void __init flipper_pic_probe(void);
+
+void flipper_quiesce(void);
+void flipper_platform_reset(void);
+int flipper_is_reset_button_pressed(void);
+
+#endif
-- 
1.6.3.3

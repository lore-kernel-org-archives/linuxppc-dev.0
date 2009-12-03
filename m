Return-Path: <albert_herranz@yahoo.es>
Received: from smtp136.mail.ukl.yahoo.com (smtp136.mail.ukl.yahoo.com
	[77.238.184.67]) by ozlabs.org (Postfix) with SMTP id A06D6B7C46
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri,  4 Dec 2009 09:47:41 +1100 (EST)
From: Albert Herranz <albert_herranz@yahoo.es>
To: linuxppc-dev@lists.ozlabs.org
Subject: [RFC PATCH v2 4/6] powerpc: wii: hollywood interrupt controller
	support
Date: Thu,  3 Dec 2009 23:47:25 +0100
Message-Id: <1259880447-5008-5-git-send-email-albert_herranz@yahoo.es>
In-Reply-To: <1259880447-5008-1-git-send-email-albert_herranz@yahoo.es>
References: <1259880447-5008-1-git-send-email-albert_herranz@yahoo.es>
Cc: Albert Herranz <albert_herranz@yahoo.es>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Add support for the dual interrupt controller included in the "Hollywood"
chipset of the Nintendo Wii video game console.
This interrupt controller serves both the Broadway processor (as a cascade)
and the Starlet processor, and is used to manage interrupts for the
non-classic hardware.

Signed-off-by: Albert Herranz <albert_herranz@yahoo.es>
---
v1 -> v2
- Use name instead of typename for struct irq_chip.
- Write 0xffffffff instead of ~0 to clear interrupts.
  Suggestion by Segher Boessenkool.
- Use __fls instead of open coded asm. Suggestion by Segher Boessenkool.
- Stop looking for interrupt controllers after finding the first one,
  as the code only handles one (as the hardware does).
  Suggestion by Segher Boessenkool.
- Use a write instead of a read/modify/write to ack interrupts.
  Suggestion by Segher Boessenkool.

 arch/powerpc/platforms/embedded6xx/Makefile   |    1 +
 arch/powerpc/platforms/embedded6xx/hlwd-pic.c |  241 +++++++++++++++++++++++++
 arch/powerpc/platforms/embedded6xx/hlwd-pic.h |   22 +++
 3 files changed, 264 insertions(+), 0 deletions(-)
 create mode 100644 arch/powerpc/platforms/embedded6xx/hlwd-pic.c
 create mode 100644 arch/powerpc/platforms/embedded6xx/hlwd-pic.h

diff --git a/arch/powerpc/platforms/embedded6xx/Makefile b/arch/powerpc/platforms/embedded6xx/Makefile
index 9365edd..f75b9e4 100644
--- a/arch/powerpc/platforms/embedded6xx/Makefile
+++ b/arch/powerpc/platforms/embedded6xx/Makefile
@@ -10,3 +10,4 @@ obj-$(CONFIG_PPC_C2K)		+= c2k.o
 obj-$(CONFIG_USBGECKO_UDBG)	+= usbgecko_udbg.o
 obj-$(CONFIG_GAMECUBE_COMMON)	+= flipper-pic.o
 obj-$(CONFIG_GAMECUBE)		+= gamecube.o
+obj-$(CONFIG_WII)		+= hlwd-pic.o
diff --git a/arch/powerpc/platforms/embedded6xx/hlwd-pic.c b/arch/powerpc/platforms/embedded6xx/hlwd-pic.c
new file mode 100644
index 0000000..752d997
--- /dev/null
+++ b/arch/powerpc/platforms/embedded6xx/hlwd-pic.c
@@ -0,0 +1,241 @@
+/*
+ * arch/powerpc/platforms/embedded6xx/hlwd-pic.c
+ *
+ * Nintendo Wii "Hollywood" interrupt controller support.
+ * Copyright (C) 2009 The GameCube Linux Team
+ * Copyright (C) 2009 Albert Herranz
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version 2
+ * of the License, or (at your option) any later version.
+ *
+ */
+#define DRV_MODULE_NAME "hlwd-pic"
+#define pr_fmt(fmt) DRV_MODULE_NAME ": " fmt
+
+#include <linux/kernel.h>
+#include <linux/init.h>
+#include <linux/irq.h>
+#include <linux/of.h>
+#include <asm/io.h>
+
+#include "hlwd-pic.h"
+
+#define HLWD_NR_IRQS	32
+
+/*
+ * Each interrupt has a corresponding bit in both
+ * the Interrupt Cause (ICR) and Interrupt Mask (IMR) registers.
+ *
+ * Enabling/disabling an interrupt line involves asserting/clearing
+ * the corresponding bit in IMR. ACK'ing a request simply involves
+ * asserting the corresponding bit in ICR.
+ */
+#define HW_BROADWAY_ICR		0x00
+#define HW_BROADWAY_IMR		0x04
+
+
+/*
+ * IRQ chip hooks.
+ *
+ */
+
+static void hlwd_pic_mask_and_ack(unsigned int virq)
+{
+	int irq = virq_to_hw(virq);
+	void __iomem *io_base = get_irq_chip_data(virq);
+	u32 mask = 1 << irq;
+
+	clrbits32(io_base + HW_BROADWAY_IMR, mask);
+	out_be32(io_base + HW_BROADWAY_ICR, mask);
+}
+
+static void hlwd_pic_ack(unsigned int virq)
+{
+	int irq = virq_to_hw(virq);
+	void __iomem *io_base = get_irq_chip_data(virq);
+
+	out_be32(io_base + HW_BROADWAY_ICR, 1 << irq);
+}
+
+static void hlwd_pic_mask(unsigned int virq)
+{
+	int irq = virq_to_hw(virq);
+	void __iomem *io_base = get_irq_chip_data(virq);
+
+	clrbits32(io_base + HW_BROADWAY_IMR, 1 << irq);
+}
+
+static void hlwd_pic_unmask(unsigned int virq)
+{
+	int irq = virq_to_hw(virq);
+	void __iomem *io_base = get_irq_chip_data(virq);
+
+	setbits32(io_base + HW_BROADWAY_IMR, 1 << irq);
+}
+
+
+static struct irq_chip hlwd_pic = {
+	.name		= "hlwd-pic",
+	.ack		= hlwd_pic_ack,
+	.mask_ack	= hlwd_pic_mask_and_ack,
+	.mask		= hlwd_pic_mask,
+	.unmask		= hlwd_pic_unmask,
+};
+
+/*
+ * IRQ host hooks.
+ *
+ */
+
+static struct irq_host *hlwd_irq_host;
+
+static int hlwd_pic_map(struct irq_host *h, unsigned int virq,
+			   irq_hw_number_t hwirq)
+{
+	set_irq_chip_data(virq, h->host_data);
+	get_irq_desc(virq)->status |= IRQ_LEVEL;
+	set_irq_chip_and_handler(virq, &hlwd_pic, handle_level_irq);
+	return 0;
+}
+
+static void hlwd_pic_unmap(struct irq_host *h, unsigned int irq)
+{
+	set_irq_chip_data(irq, NULL);
+	set_irq_chip(irq, NULL);
+}
+
+static struct irq_host_ops hlwd_irq_host_ops = {
+	.map = hlwd_pic_map,
+	.unmap = hlwd_pic_unmap,
+};
+
+static unsigned int __hlwd_pic_get_irq(struct irq_host *h)
+{
+	void __iomem *io_base = h->host_data;
+	int irq;
+	u32 irq_status;
+
+	irq_status = in_be32(io_base + HW_BROADWAY_ICR) &
+		     in_be32(io_base + HW_BROADWAY_IMR);
+	if (irq_status == 0)
+		return NO_IRQ;	/* no more IRQs pending */
+
+	irq = __ffs(irq_status);
+	return irq_linear_revmap(h, irq);
+}
+
+static void hlwd_pic_irq_cascade(unsigned int cascade_virq,
+				      struct irq_desc *desc)
+{
+	struct irq_host *irq_host = get_irq_data(cascade_virq);
+	unsigned int virq;
+
+	spin_lock(&desc->lock);
+	desc->chip->mask(cascade_virq); /* IRQ_LEVEL */
+	spin_unlock(&desc->lock);
+
+	virq = __hlwd_pic_get_irq(irq_host);
+	if (virq != NO_IRQ)
+		generic_handle_irq(virq);
+	else
+		pr_err("spurious interrupt!\n");
+
+	spin_lock(&desc->lock);
+	desc->chip->ack(cascade_virq); /* IRQ_LEVEL */
+	if (!(desc->status & IRQ_DISABLED) && desc->chip->unmask)
+		desc->chip->unmask(cascade_virq);
+	spin_unlock(&desc->lock);
+}
+
+/*
+ * Platform hooks.
+ *
+ */
+
+static void __hlwd_quiesce(void __iomem *io_base)
+{
+	/* mask and ack all IRQs */
+	out_be32(io_base + HW_BROADWAY_IMR, 0);
+	out_be32(io_base + HW_BROADWAY_ICR, 0xffffffff);
+}
+
+struct irq_host *hlwd_pic_init(struct device_node *np)
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
+	io_base = ioremap(res.start, resource_size(&res));
+	if (!io_base) {
+		pr_err("ioremap failed\n");
+		return NULL;
+	}
+
+	pr_info("controller at 0x%08x mapped to 0x%p\n", res.start, io_base);
+
+	__hlwd_quiesce(io_base);
+
+	irq_host = irq_alloc_host(np, IRQ_HOST_MAP_LINEAR, HLWD_NR_IRQS,
+				  &hlwd_irq_host_ops, -1);
+	if (!irq_host) {
+		pr_err("failed to allocate irq_host\n");
+		return NULL;
+	}
+	irq_host->host_data = io_base;
+
+	return irq_host;
+}
+
+unsigned int hlwd_pic_get_irq(void)
+{
+	return __hlwd_pic_get_irq(hlwd_irq_host);
+}
+
+/*
+ * Probe function.
+ *
+ */
+
+void hlwd_pic_probe(void)
+{
+	struct irq_host *host;
+	struct device_node *np;
+	const u32 *interrupts;
+	int cascade_virq;
+
+	for_each_compatible_node(np, NULL, "nintendo,hollywood-pic") {
+		interrupts = of_get_property(np, "interrupts", NULL);
+		if (interrupts) {
+			host = hlwd_pic_init(np);
+			BUG_ON(!host);
+			cascade_virq = irq_of_parse_and_map(np, 0);
+			set_irq_data(cascade_virq, host);
+			set_irq_chained_handler(cascade_virq,
+						hlwd_pic_irq_cascade);
+			hlwd_irq_host = host;
+			break;
+		}
+	}
+}
+
+/**
+ * hlwd_quiesce() - quiesce hollywood irq controller
+ *
+ * Mask and ack all interrupt sources.
+ *
+ */
+void hlwd_quiesce(void)
+{
+	void __iomem *io_base = hlwd_irq_host->host_data;
+
+	__hlwd_quiesce(io_base);
+}
+
diff --git a/arch/powerpc/platforms/embedded6xx/hlwd-pic.h b/arch/powerpc/platforms/embedded6xx/hlwd-pic.h
new file mode 100644
index 0000000..d2e5a09
--- /dev/null
+++ b/arch/powerpc/platforms/embedded6xx/hlwd-pic.h
@@ -0,0 +1,22 @@
+/*
+ * arch/powerpc/platforms/embedded6xx/hlwd-pic.h
+ *
+ * Nintendo Wii "Hollywood" interrupt controller support.
+ * Copyright (C) 2009 The GameCube Linux Team
+ * Copyright (C) 2009 Albert Herranz
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version 2
+ * of the License, or (at your option) any later version.
+ *
+ */
+
+#ifndef __HLWD_PIC_H
+#define __HLWD_PIC_H
+
+extern unsigned int hlwd_pic_get_irq(void);
+extern void hlwd_pic_probe(void);
+extern void hlwd_quiesce(void);
+
+#endif
-- 
1.6.3.3

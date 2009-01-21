Return-Path: <glikely@secretlab.ca>
Received: from rn-out-0910.google.com (rn-out-0910.google.com [64.233.170.187])
	by ozlabs.org (Postfix) with ESMTP id 6316DDDF2F
	for <linuxppc-dev@ozlabs.org>; Thu, 22 Jan 2009 07:55:50 +1100 (EST)
Received: by rn-out-0910.google.com with SMTP id j67so462393rne.16
	for <linuxppc-dev@ozlabs.org>; Wed, 21 Jan 2009 12:55:49 -0800 (PST)
Sender: Grant Likely <glikely@secretlab.ca>
From: Grant Likely <grant.likely@secretlab.ca>
Subject: [PATCH 8/8] powerpc/5200: Rework GPT driver to also be an IRQ
	controller
To: linuxppc-dev@ozlabs.org
Date: Wed, 21 Jan 2009 13:55:46 -0700
Message-ID: <20090121205546.31232.74885.stgit@localhost.localdomain>
In-Reply-To: <20090121205506.31232.27908.stgit@localhost.localdomain>
References: <20090121205506.31232.27908.stgit@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Grant Likely <grant.likely@secretlab.ca>

This patch adds IRQ controller support to the MPC5200 General
Purpose Timer (GPT) device driver.  With this patch the mpc5200-gpt
driver supports both GPIO and IRQ functions.

The GPT driver was contained within the mpc52xx_gpio.c file, but this
patch moves it out into a new file (mpc52xx_gpt.c) since it has more
than just GPIO functionality now and it was only grouped with the
mpc52xx-gpio drivers as a matter of convenience before.  Also, this
driver will most likely get extended again to also provide support
for the timer function.

Implementation node: Alternately, I could have tried to implement
the IRQ support as a separate driver and left the GPIO portion alone.
However, multiple functions of this device (ie. GPIO input+interrupt
controller, or timer+GPIO) can be active at the same time and the
registers are shared so it is safer to contain all functionality
within a single driver.

Signed-off-by: Grant Likely <grant.likely@secretlab.ca>
CC: Sascha Hauer <s.hauer@pengutronix.de>
CC: Wolfram Sang <w.sang@pengutronix.de>
CC: linuxppc-dev@ozlabs.org
---

 arch/powerpc/platforms/52xx/Makefile       |    2 
 arch/powerpc/platforms/52xx/mpc52xx_gpio.c |   85 ------
 arch/powerpc/platforms/52xx/mpc52xx_gpt.c  |  429 ++++++++++++++++++++++++++++
 3 files changed, 430 insertions(+), 86 deletions(-)
 create mode 100644 arch/powerpc/platforms/52xx/mpc52xx_gpt.c


diff --git a/arch/powerpc/platforms/52xx/Makefile b/arch/powerpc/platforms/52xx/Makefile
index 9dfbde2..bfd4f52 100644
--- a/arch/powerpc/platforms/52xx/Makefile
+++ b/arch/powerpc/platforms/52xx/Makefile
@@ -1,7 +1,7 @@
 #
 # Makefile for 52xx based boards
 #
-obj-y				+= mpc52xx_pic.o mpc52xx_common.o
+obj-y				+= mpc52xx_pic.o mpc52xx_common.o mpc52xx_gpt.o
 obj-$(CONFIG_PCI)		+= mpc52xx_pci.o
 
 obj-$(CONFIG_PPC_MPC5200_SIMPLE) += mpc5200_simple.o
diff --git a/arch/powerpc/platforms/52xx/mpc52xx_gpio.c b/arch/powerpc/platforms/52xx/mpc52xx_gpio.c
index 07f89ae..2b8d8ef 100644
--- a/arch/powerpc/platforms/52xx/mpc52xx_gpio.c
+++ b/arch/powerpc/platforms/52xx/mpc52xx_gpio.c
@@ -354,88 +354,6 @@ static struct of_platform_driver mpc52xx_simple_gpiochip_driver = {
 	.remove = mpc52xx_gpiochip_remove,
 };
 
-/*
- * GPIO LIB API implementation for gpt GPIOs.
- *
- * Each gpt only has a single GPIO.
- */
-static int mpc52xx_gpt_gpio_get(struct gpio_chip *gc, unsigned int gpio)
-{
-	struct of_mm_gpio_chip *mm_gc = to_of_mm_gpio_chip(gc);
-	struct mpc52xx_gpt __iomem *regs = mm_gc->regs;
-
-	return (in_be32(&regs->status) & (1 << (31 - 23))) ? 1 : 0;
-}
-
-static void
-mpc52xx_gpt_gpio_set(struct gpio_chip *gc, unsigned int gpio, int val)
-{
-	struct of_mm_gpio_chip *mm_gc = to_of_mm_gpio_chip(gc);
-	struct mpc52xx_gpt __iomem *regs = mm_gc->regs;
-
-	if (val)
-		out_be32(&regs->mode, 0x34);
-	else
-		out_be32(&regs->mode, 0x24);
-
-	pr_debug("%s: gpio: %d val: %d\n", __func__, gpio, val);
-}
-
-static int mpc52xx_gpt_gpio_dir_in(struct gpio_chip *gc, unsigned int gpio)
-{
-	struct of_mm_gpio_chip *mm_gc = to_of_mm_gpio_chip(gc);
-	struct mpc52xx_gpt __iomem *regs = mm_gc->regs;
-
-	out_be32(&regs->mode, 0x04);
-
-	return 0;
-}
-
-static int
-mpc52xx_gpt_gpio_dir_out(struct gpio_chip *gc, unsigned int gpio, int val)
-{
-	mpc52xx_gpt_gpio_set(gc, gpio, val);
-	pr_debug("%s: gpio: %d val: %d\n", __func__, gpio, val);
-
-	return 0;
-}
-
-static int __devinit mpc52xx_gpt_gpiochip_probe(struct of_device *ofdev,
-					const struct of_device_id *match)
-{
-	struct of_mm_gpio_chip *mmchip;
-	struct of_gpio_chip *chip;
-
-	mmchip = kzalloc(sizeof(*mmchip), GFP_KERNEL);
-	if (!mmchip)
-		return -ENOMEM;
-
-	chip = &mmchip->of_gc;
-
-	chip->gpio_cells          = 2;
-	chip->gc.ngpio            = 1;
-	chip->gc.direction_input  = mpc52xx_gpt_gpio_dir_in;
-	chip->gc.direction_output = mpc52xx_gpt_gpio_dir_out;
-	chip->gc.get              = mpc52xx_gpt_gpio_get;
-	chip->gc.set              = mpc52xx_gpt_gpio_set;
-
-	return of_mm_gpiochip_add(ofdev->node, mmchip);
-}
-
-static const struct of_device_id mpc52xx_gpt_gpiochip_match[] = {
-	{
-		.compatible = "fsl,mpc5200-gpt-gpio",
-	},
-	{}
-};
-
-static struct of_platform_driver mpc52xx_gpt_gpiochip_driver = {
-	.name = "gpio_gpt",
-	.match_table = mpc52xx_gpt_gpiochip_match,
-	.probe = mpc52xx_gpt_gpiochip_probe,
-	.remove = mpc52xx_gpiochip_remove,
-};
-
 static int __init mpc52xx_gpio_init(void)
 {
 	if (of_register_platform_driver(&mpc52xx_wkup_gpiochip_driver))
@@ -444,9 +362,6 @@ static int __init mpc52xx_gpio_init(void)
 	if (of_register_platform_driver(&mpc52xx_simple_gpiochip_driver))
 		printk(KERN_ERR "Unable to register simple GPIO driver\n");
 
-	if (of_register_platform_driver(&mpc52xx_gpt_gpiochip_driver))
-		printk(KERN_ERR "Unable to register gpt GPIO driver\n");
-
 	return 0;
 }
 
diff --git a/arch/powerpc/platforms/52xx/mpc52xx_gpt.c b/arch/powerpc/platforms/52xx/mpc52xx_gpt.c
new file mode 100644
index 0000000..612a8a3
--- /dev/null
+++ b/arch/powerpc/platforms/52xx/mpc52xx_gpt.c
@@ -0,0 +1,429 @@
+/*
+ * MPC5200 General Purpose Timer device driver
+ *
+ * Copyright (c) 2009 Secret Lab Technologies Ltd.
+ * Copyright (c) 2008 Sascha Hauer <s.hauer@pengutronix.de>, Pengutronix
+ *
+ * This program is free software; you can redistribute  it and/or modify it
+ * under  the terms of  the GNU General  Public License as published by the
+ * Free Software Foundation;  either version 2 of the  License, or (at your
+ * option) any later version.
+ *
+ * This file is a driver for the the General Purpose Timer (gpt) devices
+ * found on the MPC5200 SoC.  Each timer has an IO pin which can be used
+ * for GPIO or can be used to raise interrupts.  The timer function can
+ * be used independently from the IO pin, or it can be used to control
+ * output signals or measure input signals.
+ *
+ * This driver supports the GPIO and IRQ controller functions of the GPT
+ * device.  Timer functions are not yet supported, nor is the watchdog
+ * timer.
+ *
+ * To use the GPIO function, the following two properties must be added
+ * to the device tree node for the gpt device (typically in the .dts file
+ * for the board):
+ * 	gpio-controller;
+ * 	#gpio-cells = < 2 >;
+ * This driver will register the GPIO pin if it finds the gpio-controller
+ * property in the device tree.
+ *
+ * To use the IRQ controller function, the following two properties must
+ * be added to the device tree node for the gpt device:
+ * 	interrupt-controller;
+ * 	#interrupt-cells = < 1 >;
+ * The IRQ controller binding only uses one cell to specify the interrupt,
+ * and the IRQ flags are encoded in the cell.  A cell is not used to encode
+ * the IRQ number because the GPT only has a single IRQ source.  For flags,
+ * a value of '1' means rising edge sensitive and '2' means falling edge.
+ *
+ * The GPIO and the IRQ controller functions can be used at the same time,
+ * but in this use case the IO line will only work as an input.  Trying to
+ * use it as a GPIO output will not work.
+ *
+ * When using the GPIO line as an output, it can either be driven as normal
+ * IO, or it can be an OC output.  At the moment it is the responsibility
+ * of the bootloader or the platform setup code to set the output mode.
+ * This driver does not change the output mode setting.
+ */
+
+#include <linux/irq.h>
+#include <linux/interrupt.h>
+#include <linux/io.h>
+#include <linux/of.h>
+#include <linux/of_platform.h>
+#include <linux/of_gpio.h>
+#include <linux/kernel.h>
+
+#include <asm/time.h>
+#include <asm/prom.h>
+#include <asm/machdep.h>
+#include <asm/mpc52xx.h>
+
+MODULE_DESCRIPTION("Freescale MPC52xx gpt driver");
+MODULE_AUTHOR("Sascha Hauer, Grant Likely");
+MODULE_LICENSE("GPL");
+
+/**
+ * struct mpc52xx_gpt - Private data structure for MPC52xx GPT driver
+ * @dev: pointer to device structure
+ * @regs: virtual address of GPT registers
+ * @of_gc: of_gpio_chip instance structure; used when GPIO is enabled
+ * @irqhost: Pointer to irq_host instance; used when IRQ mode is supported
+ */
+struct mpc52xx_gpt_priv {
+	struct device *dev;
+	struct mpc52xx_gpt __iomem *regs;
+	spinlock_t lock;
+	struct of_gpio_chip of_gc;
+	struct irq_host *irqhost;
+};
+
+#define MPC52xx_GPT_GPIO_MODE_MASK	0x00000030
+#define MPC52xx_GPT_GPIO_MODE_OUTPUT	0x00000020
+#define MPC52xx_GPT_GPIO_OUTPUT_HIGH	0x00000010
+
+/* ---------------------------------------------------------------------
+ * Cascaded interrupt controller hooks
+ */
+
+static void mpc52xx_gpt_irq_unmask(unsigned int virq)
+{
+	struct mpc52xx_gpt_priv *gpt = get_irq_chip_data(virq);
+	unsigned long flags;
+
+	spin_lock_irqsave(&gpt->lock, flags);
+	out_be32(&gpt->regs->mode, in_be32(&gpt->regs->mode) | 0x100);
+	spin_unlock_irqrestore(&gpt->lock, flags);
+}
+
+static void mpc52xx_gpt_irq_mask(unsigned int virq)
+{
+	struct mpc52xx_gpt_priv *gpt = get_irq_chip_data(virq);
+	unsigned long flags;
+
+	spin_lock_irqsave(&gpt->lock, flags);
+	out_be32(&gpt->regs->mode, in_be32(&gpt->regs->mode) & ~0x100);
+	spin_unlock_irqrestore(&gpt->lock, flags);
+}
+
+static void mpc52xx_gpt_irq_ack(unsigned int virq)
+{
+	struct mpc52xx_gpt_priv *gpt = get_irq_chip_data(virq);
+
+	out_be32(&gpt->regs->status, 0xf);
+}
+
+static int mpc52xx_gpt_irq_set_type(unsigned int virq, unsigned int flow_type)
+{
+	struct mpc52xx_gpt_priv *gpt = get_irq_chip_data(virq);
+	unsigned long flags;
+	u32 reg;
+
+	dev_dbg(gpt->dev, "%s: virq=%i type=%x\n", __func__, virq, flow_type);
+
+	spin_lock_irqsave(&gpt->lock, flags);
+	reg = in_be32(&gpt->regs->mode) & ~0x30000;
+	if (flow_type & IRQF_TRIGGER_RISING)
+		reg |= 0x10000;
+	if (flow_type & IRQF_TRIGGER_FALLING)
+		reg |= 0x20000;
+	out_be32(&gpt->regs->mode, reg);
+	spin_unlock_irqrestore(&gpt->lock, flags);
+
+	return 0;
+}
+
+static struct irq_chip mpc52xx_gpt_irq_chip = {
+	.typename = "MPC52xx GPT",
+	.unmask = mpc52xx_gpt_irq_unmask,
+	.mask = mpc52xx_gpt_irq_mask,
+	.ack = mpc52xx_gpt_irq_ack,
+	.set_type = mpc52xx_gpt_irq_set_type,
+};
+
+void mpc52xx_gpt_irq_cascade(unsigned int virq, struct irq_desc *desc)
+{
+	struct mpc52xx_gpt_priv *gpt = get_irq_data(virq);
+	int sub_virq;
+	u32 status;
+
+	/* Ask the FPGA for IRQ status.  If 'val' is 0, then no irqs
+	 * are pending.  'ffs()' is 1 based */
+	status = in_be32(&gpt->regs->status) | 0xF;
+	if (status) {
+		sub_virq = irq_linear_revmap(gpt->irqhost, 0);
+		generic_handle_irq(sub_virq);
+	}
+}
+
+static int mpc52xx_gpt_irq_map(struct irq_host *h, unsigned int virq,
+			       irq_hw_number_t hw)
+{
+	struct mpc52xx_gpt_priv *gpt = h->host_data;
+
+	dev_dbg(gpt->dev, "%s: h=%p, virq=%i\n", __func__, h, virq);
+	set_irq_chip_data(virq, gpt);
+	set_irq_chip_and_handler(virq, &mpc52xx_gpt_irq_chip, handle_edge_irq);
+
+	return 0;
+}
+
+static int mpc52xx_gpt_irq_xlate(struct irq_host *h, struct device_node *ct,
+				 u32 *intspec, unsigned int intsize,
+				 irq_hw_number_t *out_hwirq,
+				 unsigned int *out_flags)
+{
+	struct mpc52xx_gpt_priv *gpt = h->host_data;
+
+	dev_dbg(gpt->dev, "%s: flags=%i\n", __func__, intspec[0]);
+
+	if ((intsize < 1) || (intspec[0] < 1) || (intspec[0] > 3)) {
+		dev_err(gpt->dev, "bad irq specifier in %s\n", ct->full_name);
+		return -ENODEV;
+	}
+
+	*out_hwirq = 0; /* The GPT only has 1 IRQ line */
+	*out_flags = intspec[0];
+
+	WARN_ON(*out_flags == 0);
+
+	return 0;
+}
+
+static struct irq_host_ops mpc52xx_gpt_irq_ops = {
+	.map = mpc52xx_gpt_irq_map,
+	.xlate = mpc52xx_gpt_irq_xlate,
+};
+
+static void
+mpc52xx_gpt_irq_setup(struct mpc52xx_gpt_priv *gpt, struct device_node *node)
+{
+	int cascade_virq;
+	unsigned long flags;
+	u32 val;
+
+	/* Only setup cascaded IRQ if device tree claims the GPT is
+	 * an interrupt controller */
+	if (!of_find_property(node, "interrupt-controller", NULL))
+		return;
+
+	cascade_virq = irq_of_parse_and_map(node, 0);
+
+	gpt->irqhost = irq_alloc_host(node, IRQ_HOST_MAP_LINEAR, 1,
+				      &mpc52xx_gpt_irq_ops, -1);
+	if (!gpt->irqhost) {
+		dev_err(gpt->dev, "irq_alloc_host() failed\n");
+		return;
+	}
+
+	gpt->irqhost->host_data = gpt;
+
+	set_irq_data(cascade_virq, gpt);
+	set_irq_chained_handler(cascade_virq, mpc52xx_gpt_irq_cascade);
+
+	/* Set to Input Capture mode */
+	spin_lock_irqsave(&gpt->lock, flags);
+	val = in_be32(&gpt->regs->mode) & ~0x7;
+	out_be32(&gpt->regs->mode, val | 0x1); /* IC mode */
+	spin_unlock_irqrestore(&gpt->lock, flags);
+
+	dev_dbg(gpt->dev, "%s() complete. virq=%i\n", __func__, cascade_virq);
+
+	return;
+}
+
+
+/* ---------------------------------------------------------------------
+ * GPIOLIB hooks
+ */
+#if defined(CONFIG_GPIOLIB)
+static inline struct mpc52xx_gpt_priv *gc_to_mpc52xx_gpt(struct gpio_chip *gc)
+{
+	return container_of(to_of_gpio_chip(gc), struct mpc52xx_gpt_priv,of_gc);
+}
+
+static int mpc52xx_gpt_gpio_get(struct gpio_chip *gc, unsigned int gpio)
+{
+	struct mpc52xx_gpt_priv *gpt = gc_to_mpc52xx_gpt(gc);
+
+	return (in_be32(&gpt->regs->status) >> 8) & 1;
+}
+
+static void
+mpc52xx_gpt_gpio_set(struct gpio_chip *gc, unsigned int gpio, int val)
+{
+	struct mpc52xx_gpt_priv *gpt = gc_to_mpc52xx_gpt(gc);
+	unsigned long flags;
+	u32 tmp;
+
+	dev_dbg(gpt->dev, "%s: gpio:%d val:%d\n", __func__, gpio, val);
+
+	spin_lock_irqsave(&gpt->lock, flags);
+	tmp = in_be32(&gpt->regs->mode) & ~MPC52xx_GPT_GPIO_MODE_MASK;
+	out_be32(&gpt->regs->mode, tmp | (val ? 0x30 : 0x20));
+	spin_unlock_irqrestore(&gpt->lock, flags);
+}
+
+static int mpc52xx_gpt_gpio_dir_in(struct gpio_chip *gc, unsigned int gpio)
+{
+	struct mpc52xx_gpt_priv *gpt = gc_to_mpc52xx_gpt(gc);
+	unsigned long flags;
+	u32 tmp;
+
+	dev_dbg(gpt->dev, "%s: gpio:%d\n", __func__, gpio);
+
+	spin_lock_irqsave(&gpt->lock, flags);
+	tmp = in_be32(&gpt->regs->mode) & ~MPC52xx_GPT_GPIO_MODE_MASK;
+	out_be32(&gpt->regs->mode, tmp);
+	spin_unlock_irqrestore(&gpt->lock, flags);
+
+	return 0;
+}
+
+static int
+mpc52xx_gpt_gpio_dir_out(struct gpio_chip *gc, unsigned int gpio, int val)
+{
+	mpc52xx_gpt_gpio_set(gc, gpio, val);
+	return 0;
+}
+
+static void
+mpc52xx_gpt_gpio_setup(struct mpc52xx_gpt_priv *gpt, struct device_node *node)
+{
+	int rc;
+
+	/* Only setup GPIO if the device tree claims the GPT is
+	 * a GPIO controller */
+	if (!of_find_property(node, "gpio-controller", NULL))
+		return;
+
+	gpt->of_gc.gc.label = kstrdup(node->full_name, GFP_KERNEL);
+	if (!gpt->of_gc.gc.label) {
+		dev_err(gpt->dev, "out of memory\n");
+		return;
+	}
+
+	gpt->of_gc.gpio_cells = 2;
+	gpt->of_gc.gc.ngpio = 1;
+	gpt->of_gc.gc.direction_input  = mpc52xx_gpt_gpio_dir_in;
+	gpt->of_gc.gc.direction_output = mpc52xx_gpt_gpio_dir_out;
+	gpt->of_gc.gc.get = mpc52xx_gpt_gpio_get;
+	gpt->of_gc.gc.set = mpc52xx_gpt_gpio_set;
+	gpt->of_gc.gc.base = -1;
+	gpt->of_gc.xlate = of_gpio_simple_xlate;
+	node->data = &gpt->of_gc;
+	of_node_get(node);
+
+	rc = gpiochip_add(&gpt->of_gc.gc);
+	if (rc)
+		dev_err(gpt->dev, "gpiochip_add() failed; rc=%i\n", rc);
+
+	dev_dbg(gpt->dev, "%s() complete.\n", __func__);
+}
+#else /* defined(CONFIG_GPIOLIB) */
+static void
+mpc52xx_gpt_gpio_setup(struct mpc52xx_gpt_priv *, struct device_node *) { }
+#endif /* defined(CONFIG_GPIOLIB) */
+
+/***********************************************************************
+ * SYSFS attributes
+ */
+#if defined(CONFIG_SYSFS)
+static ssize_t mpc52xx_gpt_show_regs(struct device *dev,
+				     struct device_attribute *attr, char *buf)
+{
+	struct mpc52xx_gpt_priv *gpt = dev_get_drvdata(dev);
+	int i, len = 0;
+	u32 __iomem *regs = (void __iomem *) gpt->regs;
+
+	for (i = 0; i < 4; i++)
+		len += sprintf(buf + len, "%.8x ", in_be32(regs + i));
+	len += sprintf(buf + len, "\n");
+
+	return len;
+}
+
+static struct device_attribute mpc52xx_gpt_attrib[] = {
+	__ATTR(regs, S_IRUGO | S_IWUSR, mpc52xx_gpt_show_regs, NULL),
+};
+
+static void mpc52xx_gpt_create_attribs(struct mpc52xx_gpt_priv *gpt)
+{
+	int i, err = 0;
+
+	for (i = 0; i < ARRAY_SIZE(mpc52xx_gpt_attrib); i++)
+		err |= device_create_file(gpt->dev, &mpc52xx_gpt_attrib[i]);
+
+	if (err)
+		dev_err(gpt->dev, "device_create_file() failed\n");
+}
+
+#else /* defined(CONFIG_SYSFS) */
+static void mpc52xx_gpt_create_attribs(struct mpc52xx_gpt_priv *) { return 0; }
+#endif /* defined(CONFIG_SYSFS) */
+
+/* ---------------------------------------------------------------------
+ * of_platform bus binding code
+ */
+static int __devinit mpc52xx_gpt_probe(struct of_device *ofdev,
+				       const struct of_device_id *match)
+{
+	struct mpc52xx_gpt_priv *gpt;
+	u32 val;
+
+	gpt = kzalloc(sizeof *gpt, GFP_KERNEL);
+	if (!gpt)
+		return -ENOMEM;
+
+	spin_lock_init(&gpt->lock);
+	gpt->dev = &ofdev->dev;
+	gpt->regs = of_iomap(ofdev->node, 0);
+	if (!gpt->regs) {
+		kfree(gpt);
+		return -ENOMEM;
+	}
+
+	/* Setup external pin in GPIO mode */
+	val = in_be32(&gpt->regs->mode) & ~0x7;
+	out_be32(&gpt->regs->mode, val | 0x4);
+
+	dev_set_drvdata(&ofdev->dev, gpt);
+
+	mpc52xx_gpt_create_attribs(gpt);
+	mpc52xx_gpt_gpio_setup(gpt, ofdev->node);
+	mpc52xx_gpt_irq_setup(gpt, ofdev->node);
+
+	return 0;
+}
+
+static int mpc52xx_gpt_remove(struct of_device *ofdev)
+{
+	return -EBUSY;
+}
+
+static const struct of_device_id mpc52xx_gpt_match[] = {
+	{ .compatible = "fsl,mpc5200-gpt", },
+
+	/* Depreciated compatible values; don't use for new dts files */
+	{ .compatible = "fsl,mpc5200-gpt-gpio", },
+	{ .compatible = "mpc5200-gpt", },
+	{}
+};
+
+static struct of_platform_driver mpc52xx_gpt_driver = {
+	.name = "mpc52xx-gpt",
+	.match_table = mpc52xx_gpt_match,
+	.probe = mpc52xx_gpt_probe,
+	.remove = mpc52xx_gpt_remove,
+};
+
+static int __init mpc52xx_gpt_init(void)
+{
+	if (of_register_platform_driver(&mpc52xx_gpt_driver))
+		pr_err("error registering MPC52xx GPT driver\n");
+
+	return 0;
+}
+
+/* Make sure GPIOs and IRQs get set up before anyone tries to use them */
+subsys_initcall(mpc52xx_gpt_init);

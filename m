Return-Path: <bgat@billgatliff.com>
Received: from mail-iw0-f181.google.com (mail-iw0-f181.google.com
	[209.85.223.181]) by ozlabs.org (Postfix) with ESMTP id 803E11007D1
	for <linuxppc-dev@ozlabs.org>; Thu, 31 Dec 2009 15:16:23 +1100 (EST)
Received: by iwn11 with SMTP id 11so9447026iwn.17
	for <linuxppc-dev@ozlabs.org>; Wed, 30 Dec 2009 20:16:21 -0800 (PST)
From: Bill Gatliff <bgat@billgatliff.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 1/1] Adds gpio_to_irq() and related support to the
	mpc52xx_gpio WKUP peripheral driver
Date: Wed, 30 Dec 2009 22:16:25 -0600
Message-Id: <1262232985-30822-1-git-send-email-bgat@billgatliff.com>
In-Reply-To: <y>
References: <y>
Cc: Bill Gatliff <bgat@billgatliff.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This patch cascades the GPIO_WKUP peripheral's eight pins into separate,
virtual interrupt descriptors.  This demultiplexing relieves driver authors
of having to demultiplex and manage the pins on their own.

Several important changes were necessary to implement this support, beyond
just the addition of the cascading and irq_host functions.  First, the
gpiochip devices are now registered during arch_initcall.  Without this
modification, the virtual interrupt mapping changes during startup in ways
that cause drivers to "lose" their interrupt-to-handler mappings.  The
mpc52xx FEC driver, for example, will fail to receive interrupts if the
gpiochip and irq_host registrations happen at subsys_initcall as was done
in the previous version of the driver.

Second, the previously-unimplemented gpio_to_irq() function was added,
using __gpio_to_irq().  The author does not know why this code was previously
left out of arch/powerpc/include/asm/gpio.h.  It seems to work.  The generic
irq_to_gpio() function was not tested.

Finally, the interrupt-controller property was added to the mpc52xx_gpio device
tree entry for the WKUP peripheral.  The interrupt demultiplexing code is
installed only when this property is present.  The author's device tree node
for the GPIO_WKUP peripheral looks like this:

	gpio_wkup: gpio@c00 {
			compatible = "fsl,mpc5200b-gpio-wkup","fsl,mpc5200-gpio-wkup";
			#gpio-cells = <2>;
			#address-cells = <0>;
			reg = <0xc00 0x40>;

			interrupt-parent = <&mpc5200_pic>;
			interrupts = <1 8 0  0 3 0>;

			gpio-controller;
			interrupt-controller;
			#interrupt-cells = <3>;
		};

The author generally refrains from modifying working code.  However, there were a large
number of redundant statements in the existing gpiolib implementation code to compute
bit masks for pins, and these masks needed to be consistent throughout the gpio and interrupt
cascading implementation.  The redundant statements were replaced with a new
mpc52xx_wkup_gpio_to_mask() helper function.

The gpio-to-irq mapping follows the convention established by the gpiolib driver.
Specifically, gpio pin 0 is GPIO_WKUP_7, pin 1 is GPIO_WKUP_6, and so on.  An example of
a device tree node that attaches to GPIO_WKUP_7 looks like this (the associated driver is
a modified version of the existing drivers/misc/input/rotary_encoder.c):

	rotary-encoder {
			compatible = "linux,rotary-encoder","rotary-encoder";
			interrupts = <&mpc5200_pic 1 2 3>;
			gpios = <&gpio_wkup 0 0>;

			type = <1>;
			val-ccw = <0x4a>;
			val-cw = <78>;
		};

The three values in the "gpios =" statement are the phandle for the gpio controller,
the peripheral pin number, and a flag that is currently ignored.  The rotary-encoder
driver uses of_get_gpio_flags() to get the gpiolib value for the pin:

		cfg->gpio[wchan] = of_get_gpio_flags(ofdev->node, ngpio++, NULL);

The value returned by of_get_gpio_flags() can be passed to gpio_to_irq(), and then
on to request_irq().

The GPIO_WKUP peripheral supports limited options for interrupt types, including:

	IRQ_TYPE_EDGE_FALLING, IRQ_TYPE_EDGE_RISING, IRQ_TYPE_EDGE_BOTH

The driver emulates IRQ_TYPE_LEVEL_LOW and IRQ_TYPE_LEVEL_HIGH types using falling
and rising edges, respectively, but this code has not been extensively tested.  The
GPIO_WKUP peripheral's "pulse" interrupt type is not supported.

This driver does not currently support Deep Sleep wakeups, only non-Deep Sleep ones.
The Deep Sleep wakeups appear to be most suited for support under power management
functionality, and not gpio-related operations.

Signed-off-by: Bill Gatliff <bgat@billgatliff.com>
---
 arch/powerpc/platforms/52xx/mpc52xx_gpio.c |  328 ++++++++++++++++++++++-----
 1 files changed, 267 insertions(+), 61 deletions(-)

diff --git a/arch/powerpc/platforms/52xx/mpc52xx_gpio.c b/arch/powerpc/platforms/52xx/mpc52xx_gpio.c
index 2b8d8ef..67d91d2 100644
--- a/arch/powerpc/platforms/52xx/mpc52xx_gpio.c
+++ b/arch/powerpc/platforms/52xx/mpc52xx_gpio.c
@@ -1,6 +1,7 @@
 /*
  * MPC52xx gpio driver
  *
+ * Copyright (c) 2010 Bill Gatliff <bgat@billgatliff.com>
  * Copyright (c) 2008 Sascha Hauer <s.hauer@pengutronix.de>, Pengutronix
  *
  * This program is free software; you can redistribute it and/or modify
@@ -22,6 +23,7 @@
 #include <linux/of_gpio.h>
 #include <linux/io.h>
 #include <linux/of_platform.h>
+#include <linux/irq.h>
 
 #include <asm/gpio.h>
 #include <asm/mpc52xx.h>
@@ -34,8 +36,18 @@ struct mpc52xx_gpiochip {
 	unsigned int shadow_dvo;
 	unsigned int shadow_gpioe;
 	unsigned int shadow_ddr;
+	unsigned int shadow_iinten;
+	unsigned int shadow_itype;
+	struct irq_host *irqhost;
+	unsigned int irq;
 };
 
+static inline struct mpc52xx_gpiochip *
+to_mpc52xx_gpiochip(struct of_mm_gpio_chip *mm)
+{
+	return container_of(mm, struct mpc52xx_gpiochip, mmchip);
+}
+
 /*
  * GPIO LIB API implementation for wakeup GPIOs.
  *
@@ -52,6 +64,14 @@ struct mpc52xx_gpiochip {
  * 7 -> PSC1_4
  *
  */
+
+#define MPC52XX_WKUP_GPIO_PINS 8
+
+static inline u32 mpc52xx_wkup_gpio_to_mask(unsigned int gpio)
+{
+	return 1u << ((MPC52XX_WKUP_GPIO_PINS - 1) - gpio);
+}
+
 static int mpc52xx_wkup_gpio_get(struct gpio_chip *gc, unsigned int gpio)
 {
 	struct of_mm_gpio_chip *mm_gc = to_of_mm_gpio_chip(gc);
@@ -74,9 +94,9 @@ __mpc52xx_wkup_gpio_set(struct gpio_chip *gc, unsigned int gpio, int val)
 	struct mpc52xx_gpio_wkup __iomem *regs = mm_gc->regs;
 
 	if (val)
-		chip->shadow_dvo |= 1 << (7 - gpio);
+		chip->shadow_dvo |= mpc52xx_wkup_gpio_to_mask(gpio);
 	else
-		chip->shadow_dvo &= ~(1 << (7 - gpio));
+		chip->shadow_dvo &= ~mpc52xx_wkup_gpio_to_mask(gpio);
 
 	out_8(&regs->wkup_dvo, chip->shadow_dvo);
 }
@@ -103,14 +123,16 @@ static int mpc52xx_wkup_gpio_dir_in(struct gpio_chip *gc, unsigned int gpio)
 	struct mpc52xx_gpio_wkup __iomem *regs = mm_gc->regs;
 	unsigned long flags;
 
+	pr_debug("%s: gpio %d\n", __func__, gpio);
+
 	spin_lock_irqsave(&gpio_lock, flags);
 
 	/* set the direction */
-	chip->shadow_ddr &= ~(1 << (7 - gpio));
+	chip->shadow_ddr &= ~mpc52xx_wkup_gpio_to_mask(gpio);
 	out_8(&regs->wkup_ddr, chip->shadow_ddr);
 
 	/* and enable the pin */
-	chip->shadow_gpioe |= 1 << (7 - gpio);
+	chip->shadow_gpioe |= mpc52xx_wkup_gpio_to_mask(gpio);
 	out_8(&regs->wkup_gpioe, chip->shadow_gpioe);
 
 	spin_unlock_irqrestore(&gpio_lock, flags);
@@ -132,11 +154,11 @@ mpc52xx_wkup_gpio_dir_out(struct gpio_chip *gc, unsigned int gpio, int val)
 	__mpc52xx_wkup_gpio_set(gc, gpio, val);
 
 	/* Then set direction */
-	chip->shadow_ddr |= 1 << (7 - gpio);
+	chip->shadow_ddr |= mpc52xx_wkup_gpio_to_mask(gpio);
 	out_8(&regs->wkup_ddr, chip->shadow_ddr);
 
 	/* Finally enable the pin */
-	chip->shadow_gpioe |= 1 << (7 - gpio);
+	chip->shadow_gpioe |= mpc52xx_wkup_gpio_to_mask(gpio);
 	out_8(&regs->wkup_gpioe, chip->shadow_gpioe);
 
 	spin_unlock_irqrestore(&gpio_lock, flags);
@@ -146,17 +168,198 @@ mpc52xx_wkup_gpio_dir_out(struct gpio_chip *gc, unsigned int gpio, int val)
 	return 0;
 }
 
-static int __devinit mpc52xx_wkup_gpiochip_probe(struct of_device *ofdev,
-					const struct of_device_id *match)
+static int mpc52xx_wkup_gpio_to_irq(struct gpio_chip *gc, unsigned offset)
+{
+	struct of_mm_gpio_chip *mm = to_of_mm_gpio_chip(gc);
+	struct mpc52xx_gpiochip *c = to_mpc52xx_gpiochip(mm);
+
+	if (c->irqhost && offset < MPC52XX_WKUP_GPIO_PINS)
+		return irq_create_mapping(c->irqhost, offset);
+	return -ENXIO;
+}
+
+static void mpc52xx_wkup_gpio_irq_cascade(unsigned int irq, struct irq_desc *desc)
+{
+	struct mpc52xx_gpiochip *chip = get_irq_data(irq);
+	struct of_mm_gpio_chip *mm_gc = &chip->mmchip;
+	struct mpc52xx_gpio_wkup __iomem *regs = mm_gc->regs;
+	u32 istat;
+	int gpio, sub_virq;
+
+	while((istat = in_8(&regs->wkup_istat) != 0)) {
+		gpio = ffs(istat) - 1;
+		sub_virq = irq_linear_revmap(chip->irqhost, gpio);
+		generic_handle_irq(sub_virq);
+
+		pr_debug("%s: istat %x gpio %d irq %u sub_virq %d\n",
+			 __func__, istat, gpio, irq, sub_virq);
+	}
+}
+
+static void mpc52xx_wkup_gpio_irq_unmask(unsigned int virq)
+{
+	struct mpc52xx_gpiochip *c = get_irq_chip_data(virq);
+	struct of_mm_gpio_chip *mm = &c->mmchip;
+	struct mpc52xx_gpio_wkup __iomem *regs = mm->regs;
+	unsigned long flags;
+
+	pr_debug("%s virq %d hwirq %ld\n",
+		 __func__, virq, virq_to_hw(virq));
+
+	spin_lock_irqsave(&gpio_lock, flags);
+	c->shadow_iinten |= mpc52xx_wkup_gpio_to_mask(virq_to_hw(virq));
+	out_8(&regs->wkup_iinten, c->shadow_iinten);
+	spin_unlock_irqrestore(&gpio_lock, flags);
+
+	pr_debug( "%s: iinten %x\n", __func__, c->shadow_iinten);
+}
+
+static void mpc52xx_wkup_gpio_irq_mask(unsigned int virq)
+{
+	struct mpc52xx_gpiochip *c = get_irq_chip_data(virq);
+	struct of_mm_gpio_chip *mm = &c->mmchip;
+	struct mpc52xx_gpio_wkup __iomem *regs = mm->regs;
+	unsigned long flags;
+
+	pr_debug("%s virq %d hwirq %ld\n",
+		 __func__, virq, virq_to_hw(virq));
+
+	spin_lock_irqsave(&gpio_lock, flags);
+	c->shadow_iinten &= ~mpc52xx_wkup_gpio_to_mask(virq_to_hw(virq));
+	out_8(&regs->wkup_iinten, c->shadow_iinten);
+	spin_unlock_irqrestore(&gpio_lock, flags);
+
+	pr_debug( "%s: iinten %x\n",
+		  __func__, c->shadow_iinten);
+}
+
+static void mpc52xx_wkup_gpio_irq_ack(unsigned int virq)
+{
+	struct mpc52xx_gpiochip *c = get_irq_chip_data(virq);
+	struct of_mm_gpio_chip *mm = &c->mmchip;
+	struct mpc52xx_gpio_wkup __iomem *regs = mm->regs;
+	unsigned long flags;
+
+	pr_debug("%s\n", __func__);
+
+	spin_lock_irqsave(&gpio_lock, flags);
+	out_8(&regs->wkup_istat, mpc52xx_wkup_gpio_to_mask(virq_to_hw(virq)));
+	spin_unlock_irqrestore(&gpio_lock, flags);
+}
+
+
+static inline u32 mpc52xx_wkup_gpio_to_itype(unsigned int gpio,
+					     unsigned int type)
+{
+	return type << (((MPC52XX_WKUP_GPIO_PINS - 1) - gpio) * 2);
+}
+
+enum wkup_gpio_itype {
+	ITYPE_BOTH = 0,
+	ITYPE_FALLING = 1,
+	ITYPE_RISING = 2,
+	ITYPE_PULSE = 3,
+	ITYPE_MASK = (ITYPE_BOTH | ITYPE_RISING
+		      | ITYPE_FALLING | ITYPE_PULSE),
+};
+
+static int mpc52xx_wkup_gpio_irq_set_type(unsigned int virq,
+					  unsigned int flow_type)
+{
+	struct mpc52xx_gpiochip *c = get_irq_chip_data(virq);
+	struct of_mm_gpio_chip *mm = &c->mmchip;
+	struct mpc52xx_gpio_wkup __iomem *regs = mm->regs;
+	unsigned int hw = virq_to_hw(virq);
+	unsigned long flags;
+	unsigned int type;
+
+	pr_debug("%s virq %d hw %d type %d\n",
+	       __func__, virq, hw, flow_type);
+
+	switch (flow_type) {
+	case IRQ_TYPE_LEVEL_LOW:
+		/* emulate with IRQ_TYPE_EDGE_FALLING */
+	case IRQ_TYPE_EDGE_FALLING:
+		type = mpc52xx_wkup_gpio_to_itype(hw, ITYPE_FALLING);
+		break;
+	case IRQ_TYPE_LEVEL_HIGH:
+		/* emulate with IRQ_TYPE_EDGE_RISING */
+	case IRQ_TYPE_EDGE_RISING:
+		type = mpc52xx_wkup_gpio_to_itype(hw, ITYPE_RISING);
+		break;
+	case IRQ_TYPE_EDGE_BOTH:
+		type = mpc52xx_wkup_gpio_to_itype(hw, ITYPE_BOTH);
+		break;
+	case IRQ_TYPE_NONE: /* TODO: what do we do with this? */
+		return -EINVAL;
+	default:
+		/* TODO: how do we map the "pulse" type? */
+		return -EINVAL;
+	}
+
+	spin_lock_irqsave(&gpio_lock, flags);
+	c->shadow_itype &= ~mpc52xx_wkup_gpio_to_itype(hw, ITYPE_MASK);
+	c->shadow_itype |= type;
+	out_be16(&regs->wkup_itype, c->shadow_itype);
+	spin_unlock_irqrestore(&gpio_lock, flags);
+
+	pr_debug("%s: itype %x\n", __func__, c->shadow_itype);
+	return 0;
+}
+
+
+static struct irq_chip mpc52xx_wkup_gpio_irq_chip = {
+	.name		= "mpc5200-gpio-wkup-irq",
+	.unmask		= mpc52xx_wkup_gpio_irq_unmask,
+	.mask		= mpc52xx_wkup_gpio_irq_mask,
+	.ack		= mpc52xx_wkup_gpio_irq_ack,
+	.set_type	= mpc52xx_wkup_gpio_irq_set_type,
+};
+
+static int mpc52xx_wkup_gpio_irqhost_map(struct irq_host *h,
+					 unsigned int virq,
+					 irq_hw_number_t hw)
+{
+	pr_debug("%s virq %d hw %ld host_data %p\n",
+	       __func__, virq, hw, h->host_data);
+	set_irq_chip_data(virq, h->host_data);
+	set_irq_chip_and_handler(virq,
+				 &mpc52xx_wkup_gpio_irq_chip,
+				 handle_level_irq);
+	return 0;
+}
+
+static int mpc52xx_wkup_gpio_irqhost_xlate(struct irq_host *h,
+					   struct device_node *ctrler,
+					   const u32 *intspec,
+					   unsigned int intsize,
+					   irq_hw_number_t *out_hwirq,
+					   unsigned int *out_flags)
+{
+	*out_hwirq = intspec[0];
+	*out_flags = intspec[1];
+
+	pr_debug("*** %s intspec %d %d %d out_hwirq %d out_flags %d\n",
+	       __func__, intspec[0], intspec[1], intspec[2],
+	       (int)*out_hwirq, *out_flags);
+	return 0;
+}
+
+static struct irq_host_ops mpc52xx_wkup_gpio_irq_ops = {
+	.map		= mpc52xx_wkup_gpio_irqhost_map,
+	.xlate		= mpc52xx_wkup_gpio_irqhost_xlate,
+};
+
+static void __init mpc52xx_add_wkup_gpiochip(struct device_node *np)
 {
 	struct mpc52xx_gpiochip *chip;
 	struct mpc52xx_gpio_wkup __iomem *regs;
 	struct of_gpio_chip *ofchip;
-	int ret;
+	unsigned int irq;
 
 	chip = kzalloc(sizeof(*chip), GFP_KERNEL);
 	if (!chip)
-		return -ENOMEM;
+		goto done;
 
 	ofchip = &chip->mmchip.of_gc;
 
@@ -167,36 +370,56 @@ static int __devinit mpc52xx_wkup_gpiochip_probe(struct of_device *ofdev,
 	ofchip->gc.get              = mpc52xx_wkup_gpio_get;
 	ofchip->gc.set              = mpc52xx_wkup_gpio_set;
 
-	ret = of_mm_gpiochip_add(ofdev->node, &chip->mmchip);
-	if (ret)
-		return ret;
+	if (of_mm_gpiochip_add(np, &chip->mmchip))
+	    goto err_free_chip;
 
 	regs = chip->mmchip.regs;
 	chip->shadow_gpioe = in_8(&regs->wkup_gpioe);
 	chip->shadow_ddr = in_8(&regs->wkup_ddr);
 	chip->shadow_dvo = in_8(&regs->wkup_dvo);
 
-	return 0;
-}
+	if (!of_find_property(np, "interrupt-controller", NULL))
+		goto done;
 
-static int mpc52xx_gpiochip_remove(struct of_device *ofdev)
-{
-	return -EBUSY;
-}
+	irq = irq_of_parse_and_map(np, 0);
+	if (irq == NO_IRQ)
+		goto done;
 
-static const struct of_device_id mpc52xx_wkup_gpiochip_match[] = {
-	{
-		.compatible = "fsl,mpc5200-gpio-wkup",
-	},
-	{}
-};
+	pr_debug("%s: irq %d\n", __func__, irq);
 
-static struct of_platform_driver mpc52xx_wkup_gpiochip_driver = {
-	.name = "gpio_wkup",
-	.match_table = mpc52xx_wkup_gpiochip_match,
-	.probe = mpc52xx_wkup_gpiochip_probe,
-	.remove = mpc52xx_gpiochip_remove,
-};
+	chip->irq = irq;
+	chip->irqhost = irq_alloc_host(np, IRQ_HOST_MAP_LINEAR,
+				       MPC52XX_WKUP_GPIO_PINS,
+				       &mpc52xx_wkup_gpio_irq_ops,
+				       MPC52XX_WKUP_GPIO_PINS);
+	if (!chip->irqhost) {
+		pr_err( "%s: irq_alloc_host() failed\n", __func__);
+		goto done;
+	}
+
+	chip->irqhost->host_data = chip;
+	pr_debug("%s: chip %p\n", __func__, chip);
+
+	out_8(&regs->wkup_iinten, 0);
+	out_be16(&regs->wkup_itype, 0);
+	out_8(&regs->wkup_istat, 0xff);
+
+	ofchip->gc.to_irq = mpc52xx_wkup_gpio_to_irq;
+
+	set_irq_data(irq, chip);
+	set_irq_chained_handler(irq, mpc52xx_wkup_gpio_irq_cascade);
+
+	out_8(&regs->wkup_maste, 1);
+
+	chip->shadow_iinten = in_8(&regs->wkup_iinten);
+	chip->shadow_itype = in_be16(&regs->wkup_itype);
+
+done:
+	return;
+
+err_free_chip:
+	kfree(chip);
+}
 
 /*
  * GPIO LIB API implementation for simple GPIOs
@@ -307,17 +530,16 @@ mpc52xx_simple_gpio_dir_out(struct gpio_chip *gc, unsigned int gpio, int val)
 	return 0;
 }
 
-static int __devinit mpc52xx_simple_gpiochip_probe(struct of_device *ofdev,
-					const struct of_device_id *match)
+
+static void __init mpc52xx_add_simple_gpiochip(struct device_node *np)
 {
 	struct mpc52xx_gpiochip *chip;
 	struct of_gpio_chip *ofchip;
 	struct mpc52xx_gpio __iomem *regs;
-	int ret;
 
 	chip = kzalloc(sizeof(*chip), GFP_KERNEL);
 	if (!chip)
-		return -ENOMEM;
+		return;
 
 	ofchip = &chip->mmchip.of_gc;
 
@@ -328,50 +550,34 @@ static int __devinit mpc52xx_simple_gpiochip_probe(struct of_device *ofdev,
 	ofchip->gc.get              = mpc52xx_simple_gpio_get;
 	ofchip->gc.set              = mpc52xx_simple_gpio_set;
 
-	ret = of_mm_gpiochip_add(ofdev->node, &chip->mmchip);
-	if (ret)
-		return ret;
+	of_mm_gpiochip_add(np, &chip->mmchip);
 
 	regs = chip->mmchip.regs;
 	chip->shadow_gpioe = in_be32(&regs->simple_gpioe);
 	chip->shadow_ddr = in_be32(&regs->simple_ddr);
 	chip->shadow_dvo = in_be32(&regs->simple_dvo);
-
-	return 0;
 }
 
-static const struct of_device_id mpc52xx_simple_gpiochip_match[] = {
-	{
-		.compatible = "fsl,mpc5200-gpio",
-	},
-	{}
-};
-
-static struct of_platform_driver mpc52xx_simple_gpiochip_driver = {
-	.name = "gpio",
-	.match_table = mpc52xx_simple_gpiochip_match,
-	.probe = mpc52xx_simple_gpiochip_probe,
-	.remove = mpc52xx_gpiochip_remove,
-};
-
 static int __init mpc52xx_gpio_init(void)
 {
-	if (of_register_platform_driver(&mpc52xx_wkup_gpiochip_driver))
-		printk(KERN_ERR "Unable to register wakeup GPIO driver\n");
+	struct device_node *np;
+
+	for_each_compatible_node(np, NULL, "fsl,mpc5200-gpio")
+		mpc52xx_add_simple_gpiochip(np);
 
-	if (of_register_platform_driver(&mpc52xx_simple_gpiochip_driver))
-		printk(KERN_ERR "Unable to register simple GPIO driver\n");
+	for_each_compatible_node(np, NULL, "fsl,mpc5200-gpio-wkup")
+		mpc52xx_add_wkup_gpiochip(np);
 
 	return 0;
 }
 
-
 /* Make sure we get initialised before anyone else tries to use us */
-subsys_initcall(mpc52xx_gpio_init);
+arch_initcall(mpc52xx_gpio_init);
 
 /* No exit call at the moment as we cannot unregister of gpio chips */
 
 MODULE_DESCRIPTION("Freescale MPC52xx gpio driver");
-MODULE_AUTHOR("Sascha Hauer <s.hauer@pengutronix.de");
+MODULE_AUTHOR("Sascha Hauer <s.hauer@pengutronix.de, "
+	      "Bill Gatliff <bgat@billgatliff.com>");
 MODULE_LICENSE("GPL v2");
 
-- 
1.6.5

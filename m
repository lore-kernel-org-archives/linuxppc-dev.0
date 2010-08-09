Return-Path: <agust@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.10])
	by ozlabs.org (Postfix) with ESMTP id C44EFB6EFE
	for <linuxppc-dev@ozlabs.org>; Mon,  9 Aug 2010 15:20:24 +1000 (EST)
From: Anatolij Gustschin <agust@denx.de>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH v3] powerpc/mpc8xxx_gpio.c: extend the driver to support
	mpc512x gpios
Date: Mon,  9 Aug 2010 07:20:11 +0200
Message-Id: <1281331211-17878-1-git-send-email-agust@denx.de>
In-Reply-To: <1281207816-31807-1-git-send-email-agust@denx.de>
References: <1281207816-31807-1-git-send-email-agust@denx.de>
Cc: Anatolij Gustschin <agust@denx.de>, Wolfgang Denk <wd@denx.de>,
	Detlev Zundel <dzu@denx.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The GPIO controller of MPC512x is slightly different from
8xxx GPIO controllers. The register interface is the same
except the external interrupt control register. The MPC512x
GPIO controller differentiates between four interrupt event
types and therefore provides two interrupt control registers,
GPICR1 and GPICR2. GPIO[0:15] interrupt event types are
configured in GPICR1 register, GPIO[16:31] - in GPICR2 register.

This patch adds MPC512x speciffic set_type() callback and
updates config file and comments. Additionally the gpio chip
registration function is changed to use for_each_matching_node()
preventing multiple registration if a node claimes compatibility
with another gpio controller type. Also merge two chip
registration functions into one.

Signed-off-by: Anatolij Gustschin <agust@denx.de>
---
v3:
  - merge mpc8xxx_add_controller() into mpc8xxx_add_gpiochips()
  - do not use of_node's data field for set type hook,
    use added void data pointer in the gpio chip struct
    instead.

v2:
 - add patch description
 - use match table data to set irq set_type hook as
   recommended
 - refactor to use for_each_matching_node() in
   mpc8xxx_add_gpiochips() as suggested by Grant

 arch/powerpc/platforms/Kconfig     |    7 +-
 arch/powerpc/sysdev/mpc8xxx_gpio.c |  196 +++++++++++++++++++++++-------------
 2 files changed, 129 insertions(+), 74 deletions(-)

diff --git a/arch/powerpc/platforms/Kconfig b/arch/powerpc/platforms/Kconfig
index d1663db..471115a 100644
--- a/arch/powerpc/platforms/Kconfig
+++ b/arch/powerpc/platforms/Kconfig
@@ -304,13 +304,14 @@ config OF_RTC
 source "arch/powerpc/sysdev/bestcomm/Kconfig"
 
 config MPC8xxx_GPIO
-	bool "MPC8xxx GPIO support"
-	depends on PPC_MPC831x || PPC_MPC834x || PPC_MPC837x || FSL_SOC_BOOKE || PPC_86xx
+	bool "MPC512x/MPC8xxx GPIO support"
+	depends on PPC_MPC512x || PPC_MPC831x || PPC_MPC834x || PPC_MPC837x || \
+		   FSL_SOC_BOOKE || PPC_86xx
 	select GENERIC_GPIO
 	select ARCH_REQUIRE_GPIOLIB
 	help
 	  Say Y here if you're going to use hardware that connects to the
-	  MPC831x/834x/837x/8572/8610 GPIOs.
+	  MPC512x/831x/834x/837x/8572/8610 GPIOs.
 
 config SIMPLE_GPIO
 	bool "Support for simple, memory-mapped GPIO controllers"
diff --git a/arch/powerpc/sysdev/mpc8xxx_gpio.c b/arch/powerpc/sysdev/mpc8xxx_gpio.c
index 2b69084..072f490 100644
--- a/arch/powerpc/sysdev/mpc8xxx_gpio.c
+++ b/arch/powerpc/sysdev/mpc8xxx_gpio.c
@@ -1,5 +1,5 @@
 /*
- * GPIOs on MPC8349/8572/8610 and compatible
+ * GPIOs on MPC512x/8349/8572/8610 and compatible
  *
  * Copyright (C) 2008 Peter Korsgaard <jacmet@sunsite.dk>
  *
@@ -26,6 +26,7 @@
 #define GPIO_IER		0x0c
 #define GPIO_IMR		0x10
 #define GPIO_ICR		0x14
+#define GPIO_ICR2		0x18
 
 struct mpc8xxx_gpio_chip {
 	struct of_mm_gpio_chip mm_gc;
@@ -37,6 +38,7 @@ struct mpc8xxx_gpio_chip {
 	 */
 	u32 data;
 	struct irq_host *irq;
+	void *of_dev_id_data;
 };
 
 static inline u32 mpc8xxx_gpio2mask(unsigned int gpio)
@@ -215,6 +217,51 @@ static int mpc8xxx_irq_set_type(unsigned int virq, unsigned int flow_type)
 	return 0;
 }
 
+static int mpc512x_irq_set_type(unsigned int virq, unsigned int flow_type)
+{
+	struct mpc8xxx_gpio_chip *mpc8xxx_gc = get_irq_chip_data(virq);
+	struct of_mm_gpio_chip *mm = &mpc8xxx_gc->mm_gc;
+	unsigned long gpio = virq_to_hw(virq);
+	void __iomem *reg;
+	unsigned int shift;
+	unsigned long flags;
+
+	if (gpio < 16) {
+		reg = mm->regs + GPIO_ICR;
+		shift = (15 - gpio) * 2;
+	} else {
+		reg = mm->regs + GPIO_ICR2;
+		shift = (15 - (gpio % 16)) * 2;
+	}
+
+	switch (flow_type) {
+	case IRQ_TYPE_EDGE_FALLING:
+	case IRQ_TYPE_LEVEL_LOW:
+		spin_lock_irqsave(&mpc8xxx_gc->lock, flags);
+		clrsetbits_be32(reg, 3 << shift, 2 << shift);
+		spin_unlock_irqrestore(&mpc8xxx_gc->lock, flags);
+		break;
+
+	case IRQ_TYPE_EDGE_RISING:
+	case IRQ_TYPE_LEVEL_HIGH:
+		spin_lock_irqsave(&mpc8xxx_gc->lock, flags);
+		clrsetbits_be32(reg, 3 << shift, 1 << shift);
+		spin_unlock_irqrestore(&mpc8xxx_gc->lock, flags);
+		break;
+
+	case IRQ_TYPE_EDGE_BOTH:
+		spin_lock_irqsave(&mpc8xxx_gc->lock, flags);
+		clrbits32(reg, 3 << shift);
+		spin_unlock_irqrestore(&mpc8xxx_gc->lock, flags);
+		break;
+
+	default:
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
 static struct irq_chip mpc8xxx_irq_chip = {
 	.name		= "mpc8xxx-gpio",
 	.unmask		= mpc8xxx_irq_unmask,
@@ -226,6 +273,11 @@ static struct irq_chip mpc8xxx_irq_chip = {
 static int mpc8xxx_gpio_irq_map(struct irq_host *h, unsigned int virq,
 				irq_hw_number_t hw)
 {
+	struct mpc8xxx_gpio_chip *mpc8xxx_gc = h->host_data;
+
+	if (mpc8xxx_gc->of_dev_id_data)
+		mpc8xxx_irq_chip.set_type = mpc8xxx_gc->of_dev_id_data;
+
 	set_irq_chip_data(virq, h->host_data);
 	set_irq_chip_and_handler(virq, &mpc8xxx_irq_chip, handle_level_irq);
 	set_irq_type(virq, IRQ_TYPE_NONE);
@@ -253,83 +305,85 @@ static struct irq_host_ops mpc8xxx_gpio_irq_ops = {
 	.xlate	= mpc8xxx_gpio_irq_xlate,
 };
 
-static void __init mpc8xxx_add_controller(struct device_node *np)
+static struct of_device_id mpc8xxx_gpio_ids[] __initdata = {
+	{ .compatible = "fsl,mpc8349-gpio", },
+	{ .compatible = "fsl,mpc8572-gpio", },
+	{ .compatible = "fsl,mpc8610-gpio", },
+	{ .compatible = "fsl,mpc5121-gpio", .data = mpc512x_irq_set_type, },
+	{}
+};
+
+static int __init mpc8xxx_add_gpiochips(void)
 {
 	struct mpc8xxx_gpio_chip *mpc8xxx_gc;
 	struct of_mm_gpio_chip *mm_gc;
 	struct gpio_chip *gc;
+	struct device_node *np;
+	const struct of_device_id *id;
 	unsigned hwirq;
-	int ret;
-
-	mpc8xxx_gc = kzalloc(sizeof(*mpc8xxx_gc), GFP_KERNEL);
-	if (!mpc8xxx_gc) {
-		ret = -ENOMEM;
-		goto err;
-	}
-
-	spin_lock_init(&mpc8xxx_gc->lock);
-
-	mm_gc = &mpc8xxx_gc->mm_gc;
-	gc = &mm_gc->gc;
-
-	mm_gc->save_regs = mpc8xxx_gpio_save_regs;
-	gc->ngpio = MPC8XXX_GPIO_PINS;
-	gc->direction_input = mpc8xxx_gpio_dir_in;
-	gc->direction_output = mpc8xxx_gpio_dir_out;
-	if (of_device_is_compatible(np, "fsl,mpc8572-gpio"))
-		gc->get = mpc8572_gpio_get;
-	else
-		gc->get = mpc8xxx_gpio_get;
-	gc->set = mpc8xxx_gpio_set;
-	gc->to_irq = mpc8xxx_gpio_to_irq;
-
-	ret = of_mm_gpiochip_add(np, mm_gc);
-	if (ret)
-		goto err;
-
-	hwirq = irq_of_parse_and_map(np, 0);
-	if (hwirq == NO_IRQ)
-		goto skip_irq;
-
-	mpc8xxx_gc->irq =
-		irq_alloc_host(np, IRQ_HOST_MAP_LINEAR, MPC8XXX_GPIO_PINS,
-			       &mpc8xxx_gpio_irq_ops, MPC8XXX_GPIO_PINS);
-	if (!mpc8xxx_gc->irq)
-		goto skip_irq;
-
-	mpc8xxx_gc->irq->host_data = mpc8xxx_gc;
-
-	/* ack and mask all irqs */
-	out_be32(mm_gc->regs + GPIO_IER, 0xffffffff);
-	out_be32(mm_gc->regs + GPIO_IMR, 0);
-
-	set_irq_data(hwirq, mpc8xxx_gc);
-	set_irq_chained_handler(hwirq, mpc8xxx_gpio_irq_cascade);
-
-skip_irq:
-	return;
-
+	int ret = 0;
+
+	for_each_matching_node(np, mpc8xxx_gpio_ids) {
+		mpc8xxx_gc = kzalloc(sizeof(*mpc8xxx_gc), GFP_KERNEL);
+		if (!mpc8xxx_gc) {
+			ret = -ENOMEM;
+			goto err;
+		}
+
+		spin_lock_init(&mpc8xxx_gc->lock);
+
+		mm_gc = &mpc8xxx_gc->mm_gc;
+		gc = &mm_gc->gc;
+
+		mm_gc->save_regs = mpc8xxx_gpio_save_regs;
+		gc->ngpio = MPC8XXX_GPIO_PINS;
+		gc->direction_input = mpc8xxx_gpio_dir_in;
+		gc->direction_output = mpc8xxx_gpio_dir_out;
+		if (of_device_is_compatible(np, "fsl,mpc8572-gpio"))
+			gc->get = mpc8572_gpio_get;
+		else
+			gc->get = mpc8xxx_gpio_get;
+		gc->set = mpc8xxx_gpio_set;
+		gc->to_irq = mpc8xxx_gpio_to_irq;
+
+		ret = of_mm_gpiochip_add(np, mm_gc);
+		if (ret)
+			goto err;
+
+		hwirq = irq_of_parse_and_map(np, 0);
+		if (hwirq == NO_IRQ)
+			continue;
+
+		mpc8xxx_gc->irq =
+			irq_alloc_host(np, IRQ_HOST_MAP_LINEAR,
+				       MPC8XXX_GPIO_PINS,
+				       &mpc8xxx_gpio_irq_ops,
+				       MPC8XXX_GPIO_PINS);
+		if (!mpc8xxx_gc->irq)
+			continue;
+
+		id = of_match_node(mpc8xxx_gpio_ids, np);
+		if (id)
+			mpc8xxx_gc->of_dev_id_data = id->data;
+
+		mpc8xxx_gc->irq->host_data = mpc8xxx_gc;
+
+		/* ack and mask all irqs */
+		out_be32(mm_gc->regs + GPIO_IER, 0xffffffff);
+		out_be32(mm_gc->regs + GPIO_IMR, 0);
+
+		set_irq_data(hwirq, mpc8xxx_gc);
+		set_irq_chained_handler(hwirq, mpc8xxx_gpio_irq_cascade);
+
+		continue;
 err:
-	pr_err("%s: registration failed with status %d\n",
-	       np->full_name, ret);
-	kfree(mpc8xxx_gc);
-
-	return;
-}
-
-static int __init mpc8xxx_add_gpiochips(void)
-{
-	struct device_node *np;
-
-	for_each_compatible_node(np, NULL, "fsl,mpc8349-gpio")
-		mpc8xxx_add_controller(np);
+		pr_err("%s: registration failed with status %d\n",
+		       np->full_name, ret);
+		kfree(mpc8xxx_gc);
 
-	for_each_compatible_node(np, NULL, "fsl,mpc8572-gpio")
-		mpc8xxx_add_controller(np);
-
-	for_each_compatible_node(np, NULL, "fsl,mpc8610-gpio")
-		mpc8xxx_add_controller(np);
+		continue;
+	}
 
-	return 0;
+	return ret;
 }
 arch_initcall(mpc8xxx_add_gpiochips);
-- 
1.7.0.4

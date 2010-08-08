Return-Path: <glikely@secretlab.ca>
Received: from mail-yw0-f42.google.com (mail-yw0-f42.google.com
	[209.85.213.42]) by ozlabs.org (Postfix) with ESMTP id 06335B6EED
	for <linuxppc-dev@ozlabs.org>; Sun,  8 Aug 2010 10:40:43 +1000 (EST)
Received: by ywi6 with SMTP id 6so5491344ywi.15
	for <linuxppc-dev@ozlabs.org>; Sat, 07 Aug 2010 17:40:42 -0700 (PDT)
MIME-Version: 1.0
Sender: glikely@secretlab.ca
In-Reply-To: <1281207816-31807-1-git-send-email-agust@denx.de>
References: <1281187711-10215-1-git-send-email-agust@denx.de>
	<1281207816-31807-1-git-send-email-agust@denx.de>
From: Grant Likely <grant.likely@secretlab.ca>
Date: Sat, 7 Aug 2010 18:40:22 -0600
Message-ID: <AANLkTim7uCTYLTwj0Gqen3dAi9iNO7te8NCs6wWj7nSi@mail.gmail.com>
Subject: Re: [PATCH v2] powerpc/mpc8xxx_gpio.c: extend the driver to support
	mpc512x gpios
To: Anatolij Gustschin <agust@denx.de>, linuxppc-dev@ozlabs.org
Content-Type: text/plain; charset=ISO-8859-1
Cc: Wolfgang Denk <wd@denx.de>, Detlev Zundel <dzu@denx.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

"Anatolij Gustschin" <agust@denx.de> wrote:

>The GPIO controller of MPC512x is slightly different from
>8xxx GPIO controllers. The register interface is the same
>except the external interrupt control register. The MPC512x
>GPIO controller differentiates between four interrupt event
>types and therefore provides two interrupt control registers,
>GPICR1 and GPICR2. GPIO[0:15] interrupt event types are
>configured in GPICR1 register, GPIO[16:31] - in GPICR2 register.
>
>This patch adds MPC512x speciffic set_type() callback and
>updates config file and comments. Additionally the gpio chip
>registration function is changed to use for_each_matching_node()
>preventing multiple registration if a node claimes compatibility
>with another gpio controller type.
>
>Signed-off-by: Anatolij Gustschin <agust@denx.de>
>---
>v2:
> - add patch description
> - use match table data to set irq set_type hook as
>   recommended
> - refactor to use for_each_matching_node() in
>   mpc8xxx_add_gpiochips() as suggested by Grant
>
> arch/powerpc/platforms/Kconfig     |    7 ++-
> arch/powerpc/sysdev/mpc8xxx_gpio.c |   72 ++++++++++++++++++++++++++++++++----
> 2 files changed, 68 insertions(+), 11 deletions(-)
>
>diff --git a/arch/powerpc/platforms/Kconfig b/arch/powerpc/platforms/Kconfig
>index d1663db..471115a 100644
>--- a/arch/powerpc/platforms/Kconfig
>+++ b/arch/powerpc/platforms/Kconfig
>@@ -304,13 +304,14 @@ config OF_RTC
> source "arch/powerpc/sysdev/bestcomm/Kconfig"
>
> config MPC8xxx_GPIO
>-	bool "MPC8xxx GPIO support"
>-	depends on PPC_MPC831x || PPC_MPC834x || PPC_MPC837x || FSL_SOC_BOOKE || PPC_86xx
>+	bool "MPC512x/MPC8xxx GPIO support"
>+	depends on PPC_MPC512x || PPC_MPC831x || PPC_MPC834x || PPC_MPC837x || \
>+		   FSL_SOC_BOOKE || PPC_86xx
> 	select GENERIC_GPIO
> 	select ARCH_REQUIRE_GPIOLIB
> 	help
> 	  Say Y here if you're going to use hardware that connects to the
>-	  MPC831x/834x/837x/8572/8610 GPIOs.
>+	  MPC512x/831x/834x/837x/8572/8610 GPIOs.
>
> config SIMPLE_GPIO
> 	bool "Support for simple, memory-mapped GPIO controllers"
>diff --git a/arch/powerpc/sysdev/mpc8xxx_gpio.c b/arch/powerpc/sysdev/mpc8xxx_gpio.c
>index 2b69084..87ad655 100644
>--- a/arch/powerpc/sysdev/mpc8xxx_gpio.c
>+++ b/arch/powerpc/sysdev/mpc8xxx_gpio.c
>@@ -1,5 +1,5 @@
> /*
>- * GPIOs on MPC8349/8572/8610 and compatible
>+ * GPIOs on MPC512x/8349/8572/8610 and compatible
>  *
>  * Copyright (C) 2008 Peter Korsgaard <jacmet@sunsite.dk>
>  *
>@@ -26,6 +26,7 @@
> #define GPIO_IER		0x0c
> #define GPIO_IMR		0x10
> #define GPIO_ICR		0x14
>+#define GPIO_ICR2		0x18
>
> struct mpc8xxx_gpio_chip {
> 	struct of_mm_gpio_chip mm_gc;
>@@ -215,6 +216,51 @@ static int mpc8xxx_irq_set_type(unsigned int virq, unsigned int flow_type)
> 	return 0;
> }
>
>+static int mpc512x_irq_set_type(unsigned int virq, unsigned int flow_type)
>+{
>+	struct mpc8xxx_gpio_chip *mpc8xxx_gc = get_irq_chip_data(virq);
>+	struct of_mm_gpio_chip *mm = &mpc8xxx_gc->mm_gc;
>+	unsigned long gpio = virq_to_hw(virq);
>+	void __iomem *reg;
>+	unsigned int shift;
>+	unsigned long flags;
>+
>+	if (gpio < 16) {
>+		reg = mm->regs + GPIO_ICR;
>+		shift = (15 - gpio) * 2;
>+	} else {
>+		reg = mm->regs + GPIO_ICR2;
>+		shift = (15 - (gpio % 16)) * 2;
>+	}
>+
>+	switch (flow_type) {
>+	case IRQ_TYPE_EDGE_FALLING:
>+	case IRQ_TYPE_LEVEL_LOW:
>+		spin_lock_irqsave(&mpc8xxx_gc->lock, flags);
>+		clrsetbits_be32(reg, 3 << shift, 2 << shift);
>+		spin_unlock_irqrestore(&mpc8xxx_gc->lock, flags);
>+		break;
>+
>+	case IRQ_TYPE_EDGE_RISING:
>+	case IRQ_TYPE_LEVEL_HIGH:
>+		spin_lock_irqsave(&mpc8xxx_gc->lock, flags);
>+		clrsetbits_be32(reg, 3 << shift, 1 << shift);
>+		spin_unlock_irqrestore(&mpc8xxx_gc->lock, flags);
>+		break;
>+
>+	case IRQ_TYPE_EDGE_BOTH:
>+		spin_lock_irqsave(&mpc8xxx_gc->lock, flags);
>+		clrbits32(reg, 3 << shift);
>+		spin_unlock_irqrestore(&mpc8xxx_gc->lock, flags);
>+		break;
>+
>+	default:
>+		return -EINVAL;
>+	}
>+
>+	return 0;
>+}
>+
> static struct irq_chip mpc8xxx_irq_chip = {
> 	.name		= "mpc8xxx-gpio",
> 	.unmask		= mpc8xxx_irq_unmask,
>@@ -226,6 +272,9 @@ static struct irq_chip mpc8xxx_irq_chip = {
> static int mpc8xxx_gpio_irq_map(struct irq_host *h, unsigned int virq,
> 				irq_hw_number_t hw)
> {
>+	if (h->of_node && h->of_node->data)
>+		mpc8xxx_irq_chip.set_type = h->of_node->data;
>+
> 	set_irq_chip_data(virq, h->host_data);
> 	set_irq_chip_and_handler(virq, &mpc8xxx_irq_chip, handle_level_irq);
> 	set_irq_type(virq, IRQ_TYPE_NONE);
>@@ -317,18 +366,25 @@ err:
> 	return;
> }
>
>+static struct of_device_id mpc8xxx_gpio_ids[] __initdata = {
>+	{ .compatible = "fsl,mpc8349-gpio", },
>+	{ .compatible = "fsl,mpc8572-gpio", },
>+	{ .compatible = "fsl,mpc8610-gpio", },
>+	{ .compatible = "fsl,mpc5121-gpio", .data = mpc512x_irq_set_type, },
>+	{}
>+};
>+
> static int __init mpc8xxx_add_gpiochips(void)
> {
>+	const struct of_device_id *id;
> 	struct device_node *np;
>
>-	for_each_compatible_node(np, NULL, "fsl,mpc8349-gpio")
>-		mpc8xxx_add_controller(np);
>-
>-	for_each_compatible_node(np, NULL, "fsl,mpc8572-gpio")
>-		mpc8xxx_add_controller(np);
>-
>-	for_each_compatible_node(np, NULL, "fsl,mpc8610-gpio")
>+	for_each_matching_node(np, mpc8xxx_gpio_ids) {
>+		id = of_match_node(mpc8xxx_gpio_ids, np);
>+		if (id)
>+			np->data = id->data;
> 		mpc8xxx_add_controller(np);
>+	}

Sorry, I miss led you.  id->data is fine, but don't use np->data.
Call of_match_node() inside mpc8xxx_add_controller() instead, or
change the function signature to pass it in explicitly...

Actually, there is absolutely no reason to keep mpc8xxx_add_gpiochip()
as a separate function with the simplification of
mpc8xxx_add_gpiochips().  I'd simplify the whole thing by merging the
two functions together.

g.

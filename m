Return-Path: <agust@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
	by ozlabs.org (Postfix) with ESMTP id EEBEFB6EE8
	for <linuxppc-dev@ozlabs.org>; Sat,  7 Aug 2010 23:28:45 +1000 (EST)
From: Anatolij Gustschin <agust@denx.de>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] powerpc/mpc8xxx_gpio.c: extend the driver to support mpc512x
	gpios
Date: Sat,  7 Aug 2010 15:28:31 +0200
Message-Id: <1281187711-10215-1-git-send-email-agust@denx.de>
In-Reply-To: <87iq4r5y4q.fsf@macbook.be.48ers.dk>
References: <87iq4r5y4q.fsf@macbook.be.48ers.dk>
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

Signed-off-by: Anatolij Gustschin <agust@denx.de>
---
 arch/powerpc/platforms/Kconfig     |    7 ++--
 arch/powerpc/sysdev/mpc8xxx_gpio.c |   54 +++++++++++++++++++++++++++++++++++-
 2 files changed, 57 insertions(+), 4 deletions(-)

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
index 2b69084..f5b4959 100644
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
@@ -215,6 +216,51 @@ static int mpc8xxx_irq_set_type(unsigned int virq, unsigned int flow_type)
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
@@ -226,6 +272,9 @@ static struct irq_chip mpc8xxx_irq_chip = {
 static int mpc8xxx_gpio_irq_map(struct irq_host *h, unsigned int virq,
 				irq_hw_number_t hw)
 {
+	if (of_device_is_compatible(h->of_node, "fsl,mpc5121-gpio"))
+		mpc8xxx_irq_chip.set_type = mpc512x_irq_set_type;
+
 	set_irq_chip_data(virq, h->host_data);
 	set_irq_chip_and_handler(virq, &mpc8xxx_irq_chip, handle_level_irq);
 	set_irq_type(virq, IRQ_TYPE_NONE);
@@ -330,6 +379,9 @@ static int __init mpc8xxx_add_gpiochips(void)
 	for_each_compatible_node(np, NULL, "fsl,mpc8610-gpio")
 		mpc8xxx_add_controller(np);
 
+	for_each_compatible_node(np, NULL, "fsl,mpc5121-gpio")
+		mpc8xxx_add_controller(np);
+
 	return 0;
 }
 arch_initcall(mpc8xxx_add_gpiochips);
-- 
1.7.0.4

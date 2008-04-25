Return-Path: <sha@pengutronix.de>
Received: from metis.extern.pengutronix.de (metis.extern.pengutronix.de
	[83.236.181.26]) (using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 5AD2EDDFB8
	for <linuxppc-dev@ozlabs.org>; Fri, 25 Apr 2008 20:53:40 +1000 (EST)
Received: from kiwi.ptxnet.pengutronix.de ([10.1.0.84])
	by metis.extern.pengutronix.de with esmtp (Exim 4.63)
	(envelope-from <sha@pengutronix.de>) id 1JpLYc-0002qf-Ne
	for linuxppc-dev@ozlabs.org; Fri, 25 Apr 2008 12:53:34 +0200
Received: from sha by kiwi.ptxnet.pengutronix.de with local (Exim 4.69)
	(envelope-from <sha@pengutronix.de>) id 1JpLb2-0002oL-Jm
	for linuxppc-dev@ozlabs.org; Fri, 25 Apr 2008 12:56:04 +0200
Date: Fri, 25 Apr 2008 12:56:04 +0200
From: Sascha Hauer <s.hauer@pengutronix.de>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] add gpiolib support for mpc5200
Message-ID: <20080425105604.GN6692@pengutronix.de>
References: <20080424153659.GJ6692@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20080424153659.GJ6692@pengutronix.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


This patch adds gpiolib support for mpc5200 SOCs.
Changes since last submit:

- fixed checkpatch warnings
- use shadow variables for register accesses
- make match tables const
- Add documentation

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>

---
 Documentation/powerpc/mpc52xx-device-tree-bindings.txt |   12 
 arch/powerpc/platforms/52xx/Kconfig                    |    6 
 arch/powerpc/platforms/52xx/Makefile                   |    2 
 arch/powerpc/platforms/52xx/mpc52xx_gpio.c             |  465 +++++++++++++++++
 4 files changed, 485 insertions(+)

Index: linux-2.6-powerpc/arch/powerpc/platforms/52xx/mpc52xx_gpio.c
===================================================================
--- /dev/null
+++ linux-2.6-powerpc/arch/powerpc/platforms/52xx/mpc52xx_gpio.c
@@ -0,0 +1,465 @@
+/*
+ * MPC52xx gpio driver
+ *
+ * Copyright (c) 2008 Sascha Hauer <s.hauer@pengutronix.de>, Pengutronix
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2
+ * as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+ */
+
+#include <linux/of.h>
+#include <linux/kernel.h>
+#include <linux/of_gpio.h>
+#include <linux/io.h>
+#include <linux/of_platform.h>
+
+#include <asm/gpio.h>
+#include <asm/mpc52xx.h>
+#include <sysdev/fsl_soc.h>
+
+static DEFINE_SPINLOCK(gpio_lock);
+
+struct mpc52xx_gpiochip {
+	struct of_mm_gpio_chip mmchip;
+	unsigned int shadow_dvo;
+	unsigned int shadow_gpioe;
+	unsigned int shadow_ddr;
+};
+
+/*
+ * GPIO LIB API implementation for wakeup GPIOs.
+ *
+ * There's a maximum of 8 wakeup GPIOs. Which of these are available
+ * for use depends on your board setup.
+ *
+ * 0 -> GPIO_WKUP_7
+ * 1 -> GPIO_WKUP_6
+ * 2 -> PSC6_1
+ * 3 -> PSC6_0
+ * 4 -> ETH_17
+ * 5 -> PSC3_9
+ * 6 -> PSC2_4
+ * 7 -> PSC1_4
+ *
+ */
+static int mpc52xx_wkup_gpio_get(struct gpio_chip *gc, unsigned int gpio)
+{
+	struct of_mm_gpio_chip *mm_gc = to_of_mm_gpio_chip(gc);
+	struct mpc52xx_gpio_wkup __iomem *regs = mm_gc->regs;
+	unsigned int ret;
+
+	ret = (in_8(&regs->wkup_ival) >> (7 - gpio)) & 1;
+
+	pr_debug("%s: gpio: %d ret: %d\n", __func__, gpio, ret);
+
+	return ret;
+}
+
+static inline void
+__mpc52xx_wkup_gpio_set(struct gpio_chip *gc, unsigned int gpio, int val)
+{
+	struct of_mm_gpio_chip *mm_gc = to_of_mm_gpio_chip(gc);
+	struct mpc52xx_gpiochip *chip = container_of(mm_gc,
+			struct mpc52xx_gpiochip, mmchip);
+	struct mpc52xx_gpio_wkup __iomem *regs = mm_gc->regs;
+
+	if (val)
+		chip->shadow_dvo |= 1 << (7 - gpio);
+	else
+		chip->shadow_dvo &= ~(1 << (7 - gpio));
+
+	out_8(&regs->wkup_dvo, chip->shadow_dvo);
+}
+
+static void
+mpc52xx_wkup_gpio_set(struct gpio_chip *gc, unsigned int gpio, int val)
+{
+	unsigned long flags;
+
+	spin_lock_irqsave(&gpio_lock, flags);
+
+	__mpc52xx_wkup_gpio_set(gc, gpio, val);
+
+	spin_unlock_irqrestore(&gpio_lock, flags);
+
+	pr_debug("%s: gpio: %d val: %d\n", __func__, gpio, val);
+}
+
+static int mpc52xx_wkup_gpio_dir_in(struct gpio_chip *gc, unsigned int gpio)
+{
+	struct of_mm_gpio_chip *mm_gc = to_of_mm_gpio_chip(gc);
+	struct mpc52xx_gpiochip *chip = container_of(mm_gc,
+			struct mpc52xx_gpiochip, mmchip);
+	struct mpc52xx_gpio_wkup *regs = mm_gc->regs;
+	unsigned long flags;
+
+	spin_lock_irqsave(&gpio_lock, flags);
+
+	/* set the direction */
+	chip->shadow_ddr &= ~(1 << (7 - gpio));
+	out_8(&regs->wkup_ddr, chip->shadow_ddr);
+
+	/* and enable the pin */
+	chip->shadow_gpioe |= 1 << (7 - gpio);
+	out_8(&regs->wkup_gpioe, chip->shadow_gpioe);
+
+	spin_unlock_irqrestore(&gpio_lock, flags);
+
+	return 0;
+}
+
+static int
+mpc52xx_wkup_gpio_dir_out(struct gpio_chip *gc, unsigned int gpio, int val)
+{
+	struct of_mm_gpio_chip *mm_gc = to_of_mm_gpio_chip(gc);
+	struct mpc52xx_gpio_wkup *regs = mm_gc->regs;
+	struct mpc52xx_gpiochip *chip = container_of(mm_gc,
+			struct mpc52xx_gpiochip, mmchip);
+	unsigned long flags;
+
+	spin_lock_irqsave(&gpio_lock, flags);
+
+	__mpc52xx_wkup_gpio_set(gc, gpio, val);
+
+	/* Then set direction */
+	chip->shadow_ddr |= 1 << (7 - gpio);
+	out_8(&regs->wkup_ddr, chip->shadow_ddr);
+
+	/* Finally enable the pin */
+	chip->shadow_gpioe |= 1 << (7 - gpio);
+	out_8(&regs->wkup_gpioe, chip->shadow_gpioe);
+
+	spin_unlock_irqrestore(&gpio_lock, flags);
+
+	pr_debug("%s: gpio: %d val: %d\n", __func__, gpio, val);
+
+	return 0;
+}
+
+static int __devinit mpc52xx_wkup_gpiochip_probe(struct of_device *ofdev,
+					const struct of_device_id *match)
+{
+	struct mpc52xx_gpiochip *chip;
+	struct mpc52xx_gpio_wkup *regs;
+	struct of_gpio_chip *ofchip;
+	int ret;
+
+	chip = kzalloc(sizeof(*chip), GFP_KERNEL);
+	if (!chip)
+		return -ENOMEM;
+
+	ofchip = &chip->mmchip.of_gc;
+
+	ofchip->gpio_cells          = 2;
+	ofchip->gc.ngpio            = 8;
+	ofchip->gc.direction_input  = mpc52xx_wkup_gpio_dir_in;
+	ofchip->gc.direction_output = mpc52xx_wkup_gpio_dir_out;
+	ofchip->gc.get              = mpc52xx_wkup_gpio_get;
+	ofchip->gc.set              = mpc52xx_wkup_gpio_set;
+
+	ret = of_mm_gpiochip_add(ofdev->node, &chip->mmchip);
+	if (ret)
+		return ret;
+
+	regs = chip->mmchip.regs;
+	chip->shadow_gpioe = in_8(&regs->wkup_gpioe);
+	chip->shadow_ddr = in_8(&regs->wkup_ddr);
+	chip->shadow_dvo = in_8(&regs->wkup_dvo);
+
+	return 0;
+}
+
+static int mpc52xx_gpiochip_remove(struct of_device *ofdev)
+{
+	return -EBUSY;
+}
+
+static const struct of_device_id mpc52xx_wkup_gpiochip_match[] = {
+	{
+		.compatible = "fsl,mpc5200-gpio-wkup",
+	},
+	{}
+};
+
+static struct of_platform_driver mpc52xx_wkup_gpiochip_driver = {
+	.name = "gpio_wkup",
+	.match_table = mpc52xx_wkup_gpiochip_match,
+	.probe = mpc52xx_wkup_gpiochip_probe,
+	.remove = mpc52xx_gpiochip_remove,
+};
+
+/*
+ * GPIO LIB API implementation for simple GPIOs
+ *
+ * There's a maximum of 32 simple GPIOs. Which of these are available
+ * for use depends on your board setup.
+ * The numbering reflects the bit numbering in the port registers:
+ *
+ *  0..1  > reserved
+ *  2..3  > IRDA
+ *  4..7  > ETHR
+ *  8..11 > reserved
+ * 12..15 > USB
+ * 16..17 > reserved
+ * 18..23 > PSC3
+ * 24..27 > PSC2
+ * 28..31 > PSC1
+ */
+static int mpc52xx_simple_gpio_get(struct gpio_chip *gc, unsigned int gpio)
+{
+	struct of_mm_gpio_chip *mm_gc = to_of_mm_gpio_chip(gc);
+	struct mpc52xx_gpio __iomem *regs = mm_gc->regs;
+	unsigned int ret;
+
+	ret = (in_be32(&regs->simple_ival) >> (31 - gpio)) & 1;
+
+	return ret;
+}
+
+static inline void
+__mpc52xx_simple_gpio_set(struct gpio_chip *gc, unsigned int gpio, int val)
+{
+	struct of_mm_gpio_chip *mm_gc = to_of_mm_gpio_chip(gc);
+	struct mpc52xx_gpiochip *chip = container_of(mm_gc,
+			struct mpc52xx_gpiochip, mmchip);
+	struct mpc52xx_gpio __iomem *regs = mm_gc->regs;
+
+	if (val)
+		chip->shadow_dvo |= 1 << (31 - gpio);
+	else
+		chip->shadow_dvo &= ~(1 << (31 - gpio));
+	out_be32(&regs->simple_dvo, chip->shadow_dvo);
+}
+
+static void
+mpc52xx_simple_gpio_set(struct gpio_chip *gc, unsigned int gpio, int val)
+{
+	unsigned long flags;
+
+	spin_lock_irqsave(&gpio_lock, flags);
+
+	__mpc52xx_simple_gpio_set(gc, gpio, val);
+
+	spin_unlock_irqrestore(&gpio_lock, flags);
+
+	pr_debug("%s: gpio: %d val: %d\n", __func__, gpio, val);
+}
+
+static int mpc52xx_simple_gpio_dir_in(struct gpio_chip *gc, unsigned int gpio)
+{
+	struct of_mm_gpio_chip *mm_gc = to_of_mm_gpio_chip(gc);
+	struct mpc52xx_gpiochip *chip = container_of(mm_gc,
+			struct mpc52xx_gpiochip, mmchip);
+	struct mpc52xx_gpio *regs = mm_gc->regs;
+	unsigned long flags;
+
+	spin_lock_irqsave(&gpio_lock, flags);
+
+	/* set the direction */
+	chip->shadow_ddr &= ~(1 << (31 - gpio));
+	out_be32(&regs->simple_ddr, chip->shadow_ddr);
+
+	/* and enable the pin */
+	chip->shadow_gpioe |= 1 << (31 - gpio);
+	out_be32(&regs->simple_gpioe, chip->shadow_gpioe);
+
+	spin_unlock_irqrestore(&gpio_lock, flags);
+
+	return 0;
+}
+
+static int
+mpc52xx_simple_gpio_dir_out(struct gpio_chip *gc, unsigned int gpio, int val)
+{
+	struct of_mm_gpio_chip *mm_gc = to_of_mm_gpio_chip(gc);
+	struct mpc52xx_gpiochip *chip = container_of(mm_gc,
+			struct mpc52xx_gpiochip, mmchip);
+	struct mpc52xx_gpio *regs = mm_gc->regs;
+	unsigned long flags;
+
+	spin_lock_irqsave(&gpio_lock, flags);
+
+	/* First set initial value */
+	__mpc52xx_simple_gpio_set(gc, gpio, val);
+
+	/* Then set direction */
+	chip->shadow_ddr |= 1 << (31 - gpio);
+	out_be32(&regs->simple_ddr, chip->shadow_ddr);
+
+	/* Finally enable the pin */
+	chip->shadow_gpioe |= 1 << (31 - gpio);
+	out_be32(&regs->simple_gpioe, chip->shadow_gpioe);
+
+	spin_unlock_irqrestore(&gpio_lock, flags);
+
+	pr_debug("%s: gpio: %d val: %d\n", __func__, gpio, val);
+
+	return 0;
+}
+
+static int __devinit mpc52xx_simple_gpiochip_probe(struct of_device *ofdev,
+					const struct of_device_id *match)
+{
+	struct mpc52xx_gpiochip *chip;
+	struct of_gpio_chip *ofchip;
+	struct mpc52xx_gpio *regs;
+	int ret;
+
+	chip = kzalloc(sizeof(*chip), GFP_KERNEL);
+	if (!chip)
+		return -ENOMEM;
+
+	ofchip = &chip->mmchip.of_gc;
+
+	ofchip->gpio_cells          = 2;
+	ofchip->gc.ngpio            = 32;
+	ofchip->gc.direction_input  = mpc52xx_simple_gpio_dir_in;
+	ofchip->gc.direction_output = mpc52xx_simple_gpio_dir_out;
+	ofchip->gc.get              = mpc52xx_simple_gpio_get;
+	ofchip->gc.set              = mpc52xx_simple_gpio_set;
+
+	ret = of_mm_gpiochip_add(ofdev->node, &chip->mmchip);
+	if (ret)
+		return ret;
+
+	regs = chip->mmchip.regs;
+	chip->shadow_gpioe = in_be32(&regs->simple_gpioe);
+	chip->shadow_ddr = in_be32(&regs->simple_ddr);
+	chip->shadow_dvo = in_be32(&regs->simple_dvo);
+
+	return 0;
+}
+
+static const struct of_device_id mpc52xx_simple_gpiochip_match[] = {
+	{
+		.compatible = "fsl,mpc5200-gpio",
+	},
+	{}
+};
+
+static struct of_platform_driver mpc52xx_simple_gpiochip_driver = {
+	.name = "gpio",
+	.match_table = mpc52xx_simple_gpiochip_match,
+	.probe = mpc52xx_simple_gpiochip_probe,
+	.remove = mpc52xx_gpiochip_remove,
+};
+
+/*
+ * GPIO LIB API implementation for gpt GPIOs.
+ *
+ * Each gpt only has a single GPIO.
+ */
+static int mpc52xx_gpt_gpio_get(struct gpio_chip *gc, unsigned int gpio)
+{
+	struct of_mm_gpio_chip *mm_gc = to_of_mm_gpio_chip(gc);
+	struct mpc52xx_gpt __iomem *regs = mm_gc->regs;
+	unsigned int ret;
+
+	return (in_be32(&regs->status) & (1 << (31 - 23))) ? 1 : 0;
+
+	return ret;
+}
+
+static void
+mpc52xx_gpt_gpio_set(struct gpio_chip *gc, unsigned int gpio, int val)
+{
+	struct of_mm_gpio_chip *mm_gc = to_of_mm_gpio_chip(gc);
+	struct mpc52xx_gpt __iomem *regs = mm_gc->regs;
+
+	if (val)
+		out_be32(&regs->mode, 0x34);
+	else
+		out_be32(&regs->mode, 0x24);
+
+	pr_debug("%s: gpio: %d val: %d\n", __func__, gpio, val);
+}
+
+static int mpc52xx_gpt_gpio_dir_in(struct gpio_chip *gc, unsigned int gpio)
+{
+	struct of_mm_gpio_chip *mm_gc = to_of_mm_gpio_chip(gc);
+	struct mpc52xx_gpt *regs = mm_gc->regs;
+
+	out_be32(&regs->mode, 0x04);
+
+	return 0;
+}
+
+static int
+mpc52xx_gpt_gpio_dir_out(struct gpio_chip *gc, unsigned int gpio, int val)
+{
+	mpc52xx_gpt_gpio_set(gc, gpio, val);
+	pr_debug("%s: gpio: %d val: %d\n", __func__, gpio, val);
+
+	return 0;
+}
+
+static int __devinit mpc52xx_gpt_gpiochip_probe(struct of_device *ofdev,
+					const struct of_device_id *match)
+{
+	struct of_mm_gpio_chip *mmchip;
+	struct of_gpio_chip *chip;
+
+	mmchip = kzalloc(sizeof(*mmchip), GFP_KERNEL);
+	if (!mmchip)
+		return -ENOMEM;
+
+	chip = &mmchip->of_gc;
+
+	chip->gpio_cells          = 2;
+	chip->gc.ngpio            = 1;
+	chip->gc.direction_input  = mpc52xx_gpt_gpio_dir_in;
+	chip->gc.direction_output = mpc52xx_gpt_gpio_dir_out;
+	chip->gc.get              = mpc52xx_gpt_gpio_get;
+	chip->gc.set              = mpc52xx_gpt_gpio_set;
+
+	return of_mm_gpiochip_add(ofdev->node, mmchip);
+}
+
+static const struct of_device_id mpc52xx_gpt_gpiochip_match[] = {
+	{
+		.compatible = "fsl,mpc5200-gpt-gpio",
+	},
+	{}
+};
+
+static struct of_platform_driver mpc52xx_gpt_gpiochip_driver = {
+	.name = "gpio_gpt",
+	.match_table = mpc52xx_gpt_gpiochip_match,
+	.probe = mpc52xx_gpt_gpiochip_probe,
+	.remove = mpc52xx_gpiochip_remove,
+};
+
+static int __init mpc52xx_gpio_init(void)
+{
+	if (of_register_platform_driver(&mpc52xx_wkup_gpiochip_driver))
+		printk(KERN_ERR "Unable to register wakeup GPIO driver\n");
+
+	if (of_register_platform_driver(&mpc52xx_simple_gpiochip_driver))
+		printk(KERN_ERR "Unable to register simple GPIO driver\n");
+
+	if (of_register_platform_driver(&mpc52xx_gpt_gpiochip_driver))
+		printk(KERN_ERR "Unable to register gpt GPIO driver\n");
+
+	return 0;
+}
+
+
+/* Make sure we get initialised before anyone else tries to use us */
+subsys_initcall(mpc52xx_gpio_init);
+
+/* No exit call at the moment as we cannot unregister of gpio chips */
+
+MODULE_DESCRIPTION("Freescale MPC52xx gpio driver");
+MODULE_AUTHOR("Sascha Hauer <s.hauer@pengutronix.de");
+MODULE_LICENSE("GPL v2");
+
Index: linux-2.6-powerpc/arch/powerpc/platforms/52xx/Kconfig
===================================================================
--- linux-2.6-powerpc.orig/arch/powerpc/platforms/52xx/Kconfig
+++ linux-2.6-powerpc/arch/powerpc/platforms/52xx/Kconfig
@@ -44,3 +44,9 @@ config PPC_MPC5200_BUGFIX
 
 	  It is safe to say 'Y' here
 
+config PPC_MPC5200_GPIO
+	bool "MPC5200 GPIO support"
+	depends on PPC_MPC52xx
+	select HAVE_GPIO_LIB
+	help
+	  Enable gpiolib support for mpc5200 based boards
Index: linux-2.6-powerpc/arch/powerpc/platforms/52xx/Makefile
===================================================================
--- linux-2.6-powerpc.orig/arch/powerpc/platforms/52xx/Makefile
+++ linux-2.6-powerpc/arch/powerpc/platforms/52xx/Makefile
@@ -14,3 +14,5 @@ obj-$(CONFIG_PM)		+= mpc52xx_sleep.o mpc
 ifeq ($(CONFIG_PPC_LITE5200),y)
 	obj-$(CONFIG_PM)	+= lite5200_sleep.o lite5200_pm.o
 endif
+
+obj-$(CONFIG_PPC_MPC5200_GPIO)	+= mpc52xx_gpio.o
\ No newline at end of file
Index: linux-2.6-powerpc/Documentation/powerpc/mpc52xx-device-tree-bindings.txt
===================================================================
--- linux-2.6-powerpc.orig/Documentation/powerpc/mpc52xx-device-tree-bindings.txt
+++ linux-2.6-powerpc/Documentation/powerpc/mpc52xx-device-tree-bindings.txt
@@ -186,6 +186,12 @@ Recommended soc5200 child nodes; populat
 name		device_type	compatible	  Description
 ----		-----------	----------	  -----------
 gpt@<addr>	gpt		fsl,mpc5200-gpt	  General purpose timers
+gpt@<addr>	gpt		fsl,mpc5200-gpt-gpio	General purpose
+							timers in GPIO mode
+gpio@<addr>			fsl,mpc5200-gpio	MPC5200 simple gpio
+							controller
+gpio@<addr>			fsl,mpc5200-gpio-wkup	MPC5200 wakeup gpio
+							controller
 rtc@<addr>	rtc		mpc5200-rtc	  Real time clock
 mscan@<addr>	mscan		mpc5200-mscan	  CAN bus controller
 pci@<addr>	pci		mpc5200-pci	  PCI bridge
@@ -225,6 +231,12 @@ PSC in i2s mode:  The mpc5200 and mpc520
 i2s mode.  An 'mpc5200b-psc-i2s' node cannot include 'mpc5200-psc-i2s' in the
 compatible field.
 
+7) GPIO controller nodes
+Each GPIO controller node should have the empty property gpio-controller and
+#gpio-cells set to 2. First cell is the GPIO number which is interpreted
+according to the bit numbers in the GPIO control registers. The second cell
+is for flags which is currently unsused.
+
 IV - Extra Notes
 ================
 
 

-- 
Pengutronix e.K. - Linux Solutions for Science and Industry
-----------------------------------------------------------
Kontakt-Informationen finden Sie im Header dieser Mail oder
auf der Webseite -> http://www.pengutronix.de/impressum/ <-

Return-Path: <agust@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
	by ozlabs.org (Postfix) with ESMTP id DA0A1B7D66
	for <linuxppc-dev@ozlabs.org>; Fri, 11 Jun 2010 02:06:15 +1000 (EST)
From: Anatolij Gustschin <agust@denx.de>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH V3] powerpc/mpc512x: Add gpio driver
Date: Thu, 10 Jun 2010 18:05:50 +0200
Message-Id: <1276185950-28451-1-git-send-email-agust@denx.de>
Cc: Anatolij Gustschin <agust@denx.de>, Wolfgang Denk <wd@denx.de>,
	Detlev Zundel <dzu@denx.de>, Matthias Fuchs <matthias.fuchs@esd.eu>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Matthias Fuchs <matthias.fuchs@esd.eu>

This patch adds a gpio driver for MPC512X PowerPCs.

It has been tested on our CAN-CBX-CPU5201 module that
uses a MPC5121 CPU. This platform comes with a couple of
LEDs and configuration switches that have been used for testing.

Signed-off-by: Matthias Fuchs <matthias.fuchs@esd.eu>
Signed-off-by: Anatolij Gustschin <agust@denx.de>
---
Please consider this patch for inclusion in 2.6.36. Thanks!

v3: - rebase to apply on current mainline tree
    - v2 switched to shadow registers but these are
      not pre-initialized (zero). As a result, setting
      pin direction or ODR register will clear other bits
      in direction and ODR registers. Fix this bug by adding
      shadow registers initialization code.

v2: - move driver to arch/powerpc/platforms/512x directory
    - Kconfig changes are now in arch/powerpc/platform/512x/Kconfig
    - put struct mpc512x_gpio_regs in driver's .c file
    - rename GPIO_MASK into MPC512x_GPIO_MASK
    - use shadow registers instead of r/m/w-operations
    - don't use arch_initcall but call mpc512x_add_gpiochips()
      from mpc512x platform setup code.

 arch/powerpc/platforms/512x/Kconfig          |    9 ++
 arch/powerpc/platforms/512x/Makefile         |    1 +
 arch/powerpc/platforms/512x/mpc512x.h        |    3 +
 arch/powerpc/platforms/512x/mpc512x_gpio.c   |  198 ++++++++++++++++++++++++++
 arch/powerpc/platforms/512x/mpc512x_shared.c |    3 +
 5 files changed, 214 insertions(+), 0 deletions(-)
 create mode 100644 arch/powerpc/platforms/512x/mpc512x_gpio.c

diff --git a/arch/powerpc/platforms/512x/Kconfig b/arch/powerpc/platforms/512x/Kconfig
index 4dac9b0..bd763ee 100644
--- a/arch/powerpc/platforms/512x/Kconfig
+++ b/arch/powerpc/platforms/512x/Kconfig
@@ -30,3 +30,12 @@ config MPC5121_GENERIC
 
 	  Compatible boards include:  Protonic LVT base boards (ZANMCU
 	  and VICVT2).
+
+config MPC512x_GPIO
+	bool "MPC512x GPIO support"
+	depends on PPC_MPC512x
+	select GENERIC_GPIO
+	select ARCH_REQUIRE_GPIOLIB
+	help
+	  Say Y here if you're going to use hardware that connects to the
+	  MPC512x GPIOs.
diff --git a/arch/powerpc/platforms/512x/Makefile b/arch/powerpc/platforms/512x/Makefile
index 90be2f5..12518e3 100644
--- a/arch/powerpc/platforms/512x/Makefile
+++ b/arch/powerpc/platforms/512x/Makefile
@@ -4,3 +4,4 @@
 obj-y				+= clock.o mpc512x_shared.o
 obj-$(CONFIG_MPC5121_ADS)	+= mpc5121_ads.o mpc5121_ads_cpld.o
 obj-$(CONFIG_MPC5121_GENERIC)	+= mpc5121_generic.o
+obj-$(CONFIG_MPC512x_GPIO)	+= mpc512x_gpio.o
diff --git a/arch/powerpc/platforms/512x/mpc512x.h b/arch/powerpc/platforms/512x/mpc512x.h
index b2daca0..4a1b094 100644
--- a/arch/powerpc/platforms/512x/mpc512x.h
+++ b/arch/powerpc/platforms/512x/mpc512x.h
@@ -16,4 +16,7 @@ extern void __init mpc512x_init(void);
 extern int __init mpc5121_clk_init(void);
 void __init mpc512x_declare_of_platform_devices(void);
 extern void mpc512x_restart(char *cmd);
+#ifdef CONFIG_MPC512x_GPIO
+extern int mpc512x_add_gpiochips(void);
+#endif
 #endif				/* __MPC512X_H__ */
diff --git a/arch/powerpc/platforms/512x/mpc512x_gpio.c b/arch/powerpc/platforms/512x/mpc512x_gpio.c
new file mode 100644
index 0000000..fc6ad82
--- /dev/null
+++ b/arch/powerpc/platforms/512x/mpc512x_gpio.c
@@ -0,0 +1,198 @@
+/*
+ * MPC512x gpio driver
+ *
+ * Copyright (c) 2010 Matthias Fuchs <matthias.fuchs@esd.eu>, esd gmbh
+ *
+ * derived from ppc4xx gpio driver
+ *
+ * Copyright (c) 2008 Harris Corporation
+ * Copyright (c) 2008 Sascha Hauer <s.hauer@pengutronix.de>, Pengutronix
+ * Copyright (c) MontaVista Software, Inc. 2008.
+ *
+ * Author: Steve Falco <sfalco@harris.com>
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
+#include <linux/kernel.h>
+#include <linux/init.h>
+#include <linux/spinlock.h>
+#include <linux/io.h>
+#include <linux/of.h>
+#include <linux/of_gpio.h>
+#include <linux/gpio.h>
+#include <linux/types.h>
+
+#define MPC512x_GPIO_MASK(gpio) (0x80000000 >> (gpio))
+
+struct mpc512x_gpio_regs {
+	u32 gpdir;
+	u32 gpodr;
+	u32 gpdat;
+	u32 gpier;
+	u32 gpimr;
+	u32 gpicr1;
+	u32 gpicr2;
+};
+
+struct mpc512x_chip {
+	struct of_mm_gpio_chip mm_gc;
+	spinlock_t lock;
+
+	/* shadow registers */
+	u32 dat;
+	u32 odr;
+	u32 dir;
+};
+
+/*
+ * GPIO LIB API implementation for GPIOs
+ *
+ * There are a maximum of 32 gpios in each gpio controller.
+ */
+static inline struct mpc512x_chip *
+to_mpc512x_gpiochip(struct of_mm_gpio_chip *mm_gc)
+{
+	return container_of(mm_gc, struct mpc512x_chip, mm_gc);
+}
+
+static int mpc512x_gpio_get(struct gpio_chip *gc, unsigned int gpio)
+{
+	struct of_mm_gpio_chip *mm_gc = to_of_mm_gpio_chip(gc);
+	struct mpc512x_gpio_regs __iomem *regs = mm_gc->regs;
+
+	return in_be32(&regs->gpdat) & MPC512x_GPIO_MASK(gpio);
+}
+
+static inline void
+__mpc512x_gpio_set(struct of_mm_gpio_chip *mm_gc, unsigned int gpio, int val)
+{
+	struct mpc512x_chip *chip = to_mpc512x_gpiochip(mm_gc);
+	struct mpc512x_gpio_regs __iomem *regs = mm_gc->regs;
+
+
+	if (val)
+		chip->dat |= MPC512x_GPIO_MASK(gpio);
+	else
+		chip->dat &= ~MPC512x_GPIO_MASK(gpio);
+
+	out_be32(&regs->gpdat, chip->dat);
+}
+
+static void
+mpc512x_gpio_set(struct gpio_chip *gc, unsigned int gpio, int val)
+{
+	struct of_mm_gpio_chip *mm_gc = to_of_mm_gpio_chip(gc);
+	struct mpc512x_chip *chip = to_mpc512x_gpiochip(mm_gc);
+	unsigned long flags;
+
+	spin_lock_irqsave(&chip->lock, flags);
+
+	__mpc512x_gpio_set(mm_gc, gpio, val);
+
+	spin_unlock_irqrestore(&chip->lock, flags);
+
+	pr_debug("%s: gpio: %d val: %d\n", __func__, gpio, val);
+}
+
+static int mpc512x_gpio_dir_in(struct gpio_chip *gc, unsigned int gpio)
+{
+	struct of_mm_gpio_chip *mm_gc = to_of_mm_gpio_chip(gc);
+	struct mpc512x_chip *chip = to_mpc512x_gpiochip(mm_gc);
+	struct mpc512x_gpio_regs __iomem *regs = mm_gc->regs;
+	unsigned long flags;
+
+	spin_lock_irqsave(&chip->lock, flags);
+
+	/* Disable open-drain function */
+	chip->odr &= ~MPC512x_GPIO_MASK(gpio);
+	out_be32(&regs->gpodr, chip->odr);
+
+	/* Float the pin */
+	chip->dir &= ~MPC512x_GPIO_MASK(gpio);
+	out_be32(&regs->gpdir, chip->dir);
+
+	spin_unlock_irqrestore(&chip->lock, flags);
+
+	return 0;
+}
+
+static int
+mpc512x_gpio_dir_out(struct gpio_chip *gc, unsigned int gpio, int val)
+{
+	struct of_mm_gpio_chip *mm_gc = to_of_mm_gpio_chip(gc);
+	struct mpc512x_chip *chip = to_mpc512x_gpiochip(mm_gc);
+	struct mpc512x_gpio_regs __iomem *regs = mm_gc->regs;
+	unsigned long flags;
+
+	spin_lock_irqsave(&chip->lock, flags);
+
+	/* First set initial value */
+	__mpc512x_gpio_set(mm_gc, gpio, val);
+
+	/* Disable open-drain function */
+	chip->odr &= ~MPC512x_GPIO_MASK(gpio);
+	out_be32(&regs->gpodr, chip->odr);
+
+	/* Drive the pin */
+	chip->dir |= MPC512x_GPIO_MASK(gpio);
+	out_be32(&regs->gpdir, chip->dir);
+
+	spin_unlock_irqrestore(&chip->lock, flags);
+
+	pr_debug("%s: gpio: %d val: %d\n", __func__, gpio, val);
+
+	return 0;
+}
+
+void __init mpc512x_add_gpiochips(void)
+{
+	struct device_node *np;
+
+	for_each_compatible_node(np, NULL, "fsl,mpc5121-gpio") {
+		int ret;
+		struct mpc512x_chip *chip;
+		struct of_mm_gpio_chip *mm_gc;
+		struct of_gpio_chip *of_gc;
+		struct gpio_chip *gc;
+
+		chip = kzalloc(sizeof(*chip), GFP_KERNEL);
+		if (!chip) {
+			ret = -ENOMEM;
+			goto err;
+		}
+
+		spin_lock_init(&chip->lock);
+
+		mm_gc = &chip->mm_gc;
+		of_gc = &mm_gc->of_gc;
+		gc = &of_gc->gc;
+
+		gc->ngpio = 32;
+		gc->direction_input = mpc512x_gpio_dir_in;
+		gc->direction_output = mpc512x_gpio_dir_out;
+		gc->get = mpc512x_gpio_get;
+		gc->set = mpc512x_gpio_set;
+
+		ret = of_mm_gpiochip_add(np, mm_gc);
+		if (ret)
+			goto err;
+		continue;
+err:
+		pr_err("%s: registration failed with status %d\n",
+		       np->full_name, ret);
+		kfree(chip);
+		/* try others anyway */
+	}
+}
diff --git a/arch/powerpc/platforms/512x/mpc512x_shared.c b/arch/powerpc/platforms/512x/mpc512x_shared.c
index 707e572..15da1bc 100644
--- a/arch/powerpc/platforms/512x/mpc512x_shared.c
+++ b/arch/powerpc/platforms/512x/mpc512x_shared.c
@@ -178,4 +178,7 @@ void __init mpc512x_init(void)
 	mpc5121_clk_init();
 	mpc512x_restart_init();
 	mpc512x_psc_fifo_init();
+#ifdef CONFIG_MPC512x_GPIO
+	mpc512x_add_gpiochips();
+#endif
 }
-- 
1.7.0.4

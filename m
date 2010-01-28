Return-Path: <matthias.fuchs@esd-electronics.com>
Received: from mo-p05-ob.rzone.de (mo-p05-ob.rzone.de [81.169.146.180])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 33C1DB7CFE
	for <linuxppc-dev@ozlabs.org>; Fri, 29 Jan 2010 01:00:30 +1100 (EST)
Received: from bunny.home (p5B03DC7C.dip.t-dialin.net [91.3.220.124])
	by post.strato.de (klopstock mo38) (RZmta 22.6)
	with (EDH-RSA-DES-CBC3-SHA encrypted) ESMTP id j01c0bm0SDdCAl
	for <linuxppc-dev@ozlabs.org>; Thu, 28 Jan 2010 14:48:46 +0100 (MET)
Received: from fox.localnet (fox.home [192.168.2.13])
	by bunny.home (Postfix) with ESMTPS id 0BEFE2510116
	for <linuxppc-dev@ozlabs.org>; Thu, 28 Jan 2010 14:48:45 +0100 (CET)
From: Matthias Fuchs <matthias.fuchs@esd-electronics.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] powerpc/mpc512x: Add gpio driver
Date: Thu, 28 Jan 2010 14:48:42 +0100
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <201001281448.42965.matthias.fuchs@esd-electronics.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Signed-off-by: Matthias Fuchs <matthias.fuchs@esd.eu>
---
 arch/powerpc/include/asm/mpc512x_gpio.h |   30 +++++
 arch/powerpc/platforms/Kconfig          |    9 ++
 arch/powerpc/sysdev/Makefile            |    1 +
 arch/powerpc/sysdev/mpc512x_gpio.c      |  179 +++++++++++++++++++++++++++++++
 4 files changed, 219 insertions(+), 0 deletions(-)
 create mode 100644 arch/powerpc/include/asm/mpc512x_gpio.h
 create mode 100644 arch/powerpc/sysdev/mpc512x_gpio.c

diff --git a/arch/powerpc/include/asm/mpc512x_gpio.h b/arch/powerpc/include/asm/mpc512x_gpio.h
new file mode 100644
index 0000000..8b6922d
--- /dev/null
+++ b/arch/powerpc/include/asm/mpc512x_gpio.h
@@ -0,0 +1,30 @@
+/*
+ * Copyright (C) 2010 Matthias Fuchs <matthias.fuchs@esd.eu>, esd gmbh
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
+#ifndef MPC512X_GPIO_H
+#define MPC512X_GPIO_H
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
+#endif /* MPC512X_GPIO_H */
diff --git a/arch/powerpc/platforms/Kconfig b/arch/powerpc/platforms/Kconfig
index d1663db..76234cd 100644
--- a/arch/powerpc/platforms/Kconfig
+++ b/arch/powerpc/platforms/Kconfig
@@ -312,6 +312,15 @@ config MPC8xxx_GPIO
 	  Say Y here if you're going to use hardware that connects to the
 	  MPC831x/834x/837x/8572/8610 GPIOs.
 
+config MPC512x_GPIO
+	bool "MPC512x GPIO support"
+	depends on PPC_MPC512x
+	select GENERIC_GPIO
+	select ARCH_REQUIRE_GPIOLIB
+	help
+	  Say Y here if you're going to use hardware that connects to the
+	  MPC512x GPIOs.
+
 config SIMPLE_GPIO
 	bool "Support for simple, memory-mapped GPIO controllers"
 	depends on PPC
diff --git a/arch/powerpc/sysdev/Makefile b/arch/powerpc/sysdev/Makefile
index 5642924..cb61f2a 100644
--- a/arch/powerpc/sysdev/Makefile
+++ b/arch/powerpc/sysdev/Makefile
@@ -20,6 +20,7 @@ obj-$(CONFIG_FSL_PMC)		+= fsl_pmc.o
 obj-$(CONFIG_FSL_LBC)		+= fsl_lbc.o
 obj-$(CONFIG_FSL_GTM)		+= fsl_gtm.o
 obj-$(CONFIG_MPC8xxx_GPIO)	+= mpc8xxx_gpio.o
+obj-$(CONFIG_MPC512x_GPIO)	+= mpc512x_gpio.o
 obj-$(CONFIG_SIMPLE_GPIO)	+= simple_gpio.o
 obj-$(CONFIG_RAPIDIO)		+= fsl_rio.o
 obj-$(CONFIG_TSI108_BRIDGE)	+= tsi108_pci.o tsi108_dev.o
diff --git a/arch/powerpc/sysdev/mpc512x_gpio.c b/arch/powerpc/sysdev/mpc512x_gpio.c
new file mode 100644
index 0000000..09f075b
--- /dev/null
+++ b/arch/powerpc/sysdev/mpc512x_gpio.c
@@ -0,0 +1,179 @@
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
+#include <asm/mpc512x_gpio.h>
+
+#define GPIO_MASK(gpio)		(0x80000000 >> (gpio))
+
+struct mpc512x_chip {
+	struct of_mm_gpio_chip mm_gc;
+	spinlock_t lock;
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
+	return in_be32(&regs->gpdat) & GPIO_MASK(gpio);
+}
+
+static inline void
+__mpc512x_gpio_set(struct gpio_chip *gc, unsigned int gpio, int val)
+{
+	struct of_mm_gpio_chip *mm_gc = to_of_mm_gpio_chip(gc);
+	struct mpc512x_gpio_regs __iomem *regs = mm_gc->regs;
+
+	if (val)
+		setbits32(&regs->gpdat, GPIO_MASK(gpio));
+	else
+		clrbits32(&regs->gpdat, GPIO_MASK(gpio));
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
+	__mpc512x_gpio_set(gc, gpio, val);
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
+	clrbits32(&regs->gpodr, GPIO_MASK(gpio));
+
+	/* Float the pin */
+	clrbits32(&regs->gpdir, GPIO_MASK(gpio));
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
+	__mpc512x_gpio_set(gc, gpio, val);
+
+	/* Disable open-drain function */
+	clrbits32(&regs->gpodr, GPIO_MASK(gpio));
+
+	/* Drive the pin */
+	setbits32(&regs->gpdir, GPIO_MASK(gpio));
+
+	spin_unlock_irqrestore(&chip->lock, flags);
+
+	pr_debug("%s: gpio: %d val: %d\n", __func__, gpio, val);
+
+	return 0;
+}
+
+static int __init mpc512x_add_gpiochips(void)
+{
+	struct device_node *np;
+
+	for_each_compatible_node(np, NULL, "fsl,mpc5121-gpio") {
+		int ret;
+		struct mpc512x_chip *mpc512x_gc;
+		struct of_mm_gpio_chip *mm_gc;
+		struct of_gpio_chip *of_gc;
+		struct gpio_chip *gc;
+
+		mpc512x_gc = kzalloc(sizeof(*mpc512x_gc), GFP_KERNEL);
+		if (!mpc512x_gc) {
+			ret = -ENOMEM;
+			goto err;
+		}
+
+		spin_lock_init(&mpc512x_gc->lock);
+
+		mm_gc = &mpc512x_gc->mm_gc;
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
+		kfree(mpc512x_gc);
+		/* try others anyway */
+	}
+	return 0;
+}
+arch_initcall(mpc512x_add_gpiochips);
-- 
1.5.6.3

Return-Path: <avorontsov@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id 39970DDEF1
	for <linuxppc-dev@ozlabs.org>; Thu, 18 Sep 2008 03:58:25 +1000 (EST)
Date: Wed, 17 Sep 2008 21:58:20 +0400
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: [PATCH v2] powerpc: implement support for MPC8349-compatible SOC GPIOs
Message-ID: <20080917175820.GA22539@oksana.dev.rtsoft.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=windows-1251
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This patch implements GPIOLIB support for MPC8349-compatible SOC GPIOs.
MPC8610 adopted this GPIO unit, so let's place it into sysdev.

We'll need these gpios to support IrDA transceiver on MPC8610HPCD.

Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
---

v2:
- Incorporated Peter Korsgaard's suggestion regarding order
  of setting data/direction registers.

The patch applies on top of "powerpc: add driver for simple GPIO banks".

 arch/powerpc/sysdev/Kconfig            |   10 ++
 arch/powerpc/sysdev/Makefile           |    1 +
 arch/powerpc/sysdev/fsl_mpc8349_gpio.c |  161 ++++++++++++++++++++++++++++++++
 3 files changed, 172 insertions(+), 0 deletions(-)
 create mode 100644 arch/powerpc/sysdev/fsl_mpc8349_gpio.c

diff --git a/arch/powerpc/sysdev/Kconfig b/arch/powerpc/sysdev/Kconfig
index 30d6e4d..4cbfda0 100644
--- a/arch/powerpc/sysdev/Kconfig
+++ b/arch/powerpc/sysdev/Kconfig
@@ -17,3 +17,13 @@ config OF_SIMPLE_GPIO
 	  These are usually BCSRs used to control board's switches, LEDs,
 	  chip-selects, Ethernet/USB PHY's power and various other small
 	  on-board peripherals.
+
+config FSL_MPC8349_GPIO
+	bool "Support for MPC8349-compatible GPIO controllers"
+	depends on PPC32
+	select GENERIC_GPIO
+	select ARCH_REQUIRE_GPIOLIB
+	help
+	  Say Y here to support Freescale MPC8349-compatible GPIO controllers.
+	  The controllers can be found in MPC831x, MPC834x, MPC837x and
+	  MPC8610 processors.
diff --git a/arch/powerpc/sysdev/Makefile b/arch/powerpc/sysdev/Makefile
index 239d7e8..afbc3a4 100644
--- a/arch/powerpc/sysdev/Makefile
+++ b/arch/powerpc/sysdev/Makefile
@@ -37,6 +37,7 @@ obj-$(CONFIG_4xx)		+= ppc4xx_pci.o
 endif
 
 obj-$(CONFIG_OF_SIMPLE_GPIO)	+= of_simple_gpio.o
+obj-$(CONFIG_FSL_MPC8349_GPIO)	+= fsl_mpc8349_gpio.o
 
 # Temporary hack until we have migrated to asm-powerpc
 ifeq ($(ARCH),powerpc)
diff --git a/arch/powerpc/sysdev/fsl_mpc8349_gpio.c b/arch/powerpc/sysdev/fsl_mpc8349_gpio.c
new file mode 100644
index 0000000..c8c77f4
--- /dev/null
+++ b/arch/powerpc/sysdev/fsl_mpc8349_gpio.c
@@ -0,0 +1,161 @@
+/*
+ * MPC8349-compatible SOC GPIOs
+ *
+ * Copyright (c) MontaVista Software, Inc. 2008.
+ *
+ * Author: Anton Vorontsov <avorontsov@ru.mvista.com>
+ *
+ * This program is free software; you can redistribute  it and/or modify it
+ * under  the terms of  the GNU General  Public License as published by the
+ * Free Software Foundation;  either version 2 of the  License, or (at your
+ * option) any later version.
+ */
+
+#include <linux/init.h>
+#include <linux/types.h>
+#include <linux/kernel.h>
+#include <linux/compiler.h>
+#include <linux/spinlock.h>
+#include <linux/io.h>
+#include <linux/of.h>
+#include <linux/of_gpio.h>
+#include <linux/gpio.h>
+
+#define FSL_GPIO_PINS 32
+
+struct fsl_gpio_regs {
+	__be32 gpdir;
+	__be32 gpodr;
+	__be32 gpdat;
+	__be32 gpier;
+	__be32 gpimr;
+	__be32 gpicr;
+};
+
+struct fsl_gpio_chip {
+	struct of_mm_gpio_chip mm_gc;
+	spinlock_t lock;
+
+	/* shadowed data register to clear/set bits safely */
+	u32 gpdat;
+};
+
+static inline u32 pin2mask(unsigned int pin)
+{
+	return 1 << (FSL_GPIO_PINS - 1 - pin);
+}
+
+static inline struct fsl_gpio_chip *
+to_fsl_gpio_chip(struct of_mm_gpio_chip *mm_gc)
+{
+	return container_of(mm_gc, struct fsl_gpio_chip, mm_gc);
+}
+
+static void fsl_gpio_save_regs(struct of_mm_gpio_chip *mm_gc)
+{
+	struct fsl_gpio_chip *fsl_gc = to_fsl_gpio_chip(mm_gc);
+	struct fsl_gpio_regs __iomem *regs = mm_gc->regs;
+
+	fsl_gc->gpdat = in_be32(&regs->gpdat);
+}
+
+static int fsl_gpio_get(struct gpio_chip *gc, unsigned int gpio)
+{
+	struct of_mm_gpio_chip *mm_gc = to_of_mm_gpio_chip(gc);
+	struct fsl_gpio_regs __iomem *regs = mm_gc->regs;
+
+	return in_be32(&regs->gpdat) & pin2mask(gpio);
+}
+
+static void fsl_gpio_set(struct gpio_chip *gc, unsigned int gpio, int val)
+{
+	struct of_mm_gpio_chip *mm_gc = to_of_mm_gpio_chip(gc);
+	struct fsl_gpio_chip *fsl_gc = to_fsl_gpio_chip(mm_gc);
+	struct fsl_gpio_regs __iomem *regs = mm_gc->regs;
+	unsigned long flags;
+
+	spin_lock_irqsave(&fsl_gc->lock, flags);
+
+	if (val)
+		fsl_gc->gpdat |= pin2mask(gpio);
+	else
+		fsl_gc->gpdat &= ~pin2mask(gpio);
+
+	out_be32(&regs->gpdat, fsl_gc->gpdat);
+
+	spin_unlock_irqrestore(&fsl_gc->lock, flags);
+}
+
+static int fsl_gpio_dir_in(struct gpio_chip *gc, unsigned int gpio)
+{
+	struct of_mm_gpio_chip *mm_gc = to_of_mm_gpio_chip(gc);
+	struct fsl_gpio_chip *fsl_gc = to_fsl_gpio_chip(mm_gc);
+	struct fsl_gpio_regs __iomem *regs = mm_gc->regs;
+	unsigned long flags;
+
+	spin_lock_irqsave(&fsl_gc->lock, flags);
+	clrbits32(&regs->gpdir, pin2mask(gpio));
+	spin_unlock_irqrestore(&fsl_gc->lock, flags);
+	return 0;
+}
+
+static int fsl_gpio_dir_out(struct gpio_chip *gc, unsigned int gpio,
+				int val)
+{
+	struct of_mm_gpio_chip *mm_gc = to_of_mm_gpio_chip(gc);
+	struct fsl_gpio_chip *fsl_gc = to_fsl_gpio_chip(mm_gc);
+	struct fsl_gpio_regs __iomem *regs = mm_gc->regs;
+	unsigned long flags;
+
+	fsl_gpio_set(gc, gpio, val);
+
+	spin_lock_irqsave(&fsl_gc->lock, flags);
+	setbits32(&regs->gpdir, pin2mask(gpio));
+	spin_unlock_irqrestore(&fsl_gc->lock, flags);
+	return 0;
+}
+
+static int __init fsl_gpio_init(void)
+{
+	struct device_node *np;
+
+	for_each_compatible_node(np, NULL, "fsl,mpc8349-gpio-bank") {
+		int ret;
+		struct fsl_gpio_chip *fsl_gc;
+		struct of_mm_gpio_chip *mm_gc;
+		struct of_gpio_chip *of_gc;
+		struct gpio_chip *gc;
+
+		fsl_gc = kzalloc(sizeof(*fsl_gc), GFP_KERNEL);
+		if (!fsl_gc) {
+			ret = -ENOMEM;
+			goto err;
+		}
+
+		spin_lock_init(&fsl_gc->lock);
+
+		mm_gc = &fsl_gc->mm_gc;
+		of_gc = &mm_gc->of_gc;
+		gc = &of_gc->gc;
+
+		mm_gc->save_regs = fsl_gpio_save_regs;
+		of_gc->gpio_cells = 2;
+		gc->ngpio = FSL_GPIO_PINS;
+		gc->direction_input = fsl_gpio_dir_in;
+		gc->direction_output = fsl_gpio_dir_out;
+		gc->get = fsl_gpio_get;
+		gc->set = fsl_gpio_set;
+
+		ret = of_mm_gpiochip_add(np, mm_gc);
+		if (ret)
+			goto err;
+		continue;
+err:
+		pr_err("%s: registration failed with status %d\n",
+		       np->full_name, ret);
+		kfree(fsl_gc);
+		/* try others anyway */
+	}
+	return 0;
+}
+arch_initcall(fsl_gpio_init);
-- 
1.5.6.3

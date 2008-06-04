Return-Path: <avorontsov@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id 58BEADE38D
	for <linuxppc-dev@ozlabs.org>; Thu,  5 Jun 2008 01:45:25 +1000 (EST)
Date: Wed, 4 Jun 2008 19:45:24 +0400
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 1/2] [POWERPC] sysdev: implement support for
	MPC8349-compatible SOC GPIOs
Message-ID: <20080604154524.GB31162@polina.dev.rtsoft.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf8
Cc: Timur Tabi <timur@freescale.com>, Zhang Wei <Wei.Zhang@freescale.com>
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
 arch/powerpc/sysdev/Kconfig            |    7 ++
 arch/powerpc/sysdev/Makefile           |    2 +
 arch/powerpc/sysdev/fsl_mpc8349_gpio.c |  161 ++++++++++++++++++++++++++++++++
 3 files changed, 170 insertions(+), 0 deletions(-)
 create mode 100644 arch/powerpc/sysdev/fsl_mpc8349_gpio.c

diff --git a/arch/powerpc/sysdev/Kconfig b/arch/powerpc/sysdev/Kconfig
index 72fb35b..37d0143 100644
--- a/arch/powerpc/sysdev/Kconfig
+++ b/arch/powerpc/sysdev/Kconfig
@@ -6,3 +6,10 @@ config PPC4xx_PCI_EXPRESS
 	bool
 	depends on PCI && 4xx
 	default n
+
+config FSL_MPC8349_GPIO
+	bool
+	select GENERIC_GPIO
+	select HAVE_GPIO_LIB
+	help
+	  Support for Freescale MPC8349 compatible GPIOs.
diff --git a/arch/powerpc/sysdev/Makefile b/arch/powerpc/sysdev/Makefile
index 16a0ed2..3f93f5e 100644
--- a/arch/powerpc/sysdev/Makefile
+++ b/arch/powerpc/sysdev/Makefile
@@ -25,6 +25,8 @@ obj-$(CONFIG_MV64X60)		+= $(mv64x60-y) mv64x60_pic.o mv64x60_dev.o \
 obj-$(CONFIG_RTC_DRV_CMOS)	+= rtc_cmos_setup.o
 obj-$(CONFIG_AXON_RAM)		+= axonram.o
 
+obj-$(CONFIG_FSL_MPC8349_GPIO)	+= fsl_mpc8349_gpio.o
+
 ifeq ($(CONFIG_PPC_MERGE),y)
 obj-$(CONFIG_PPC_INDIRECT_PCI)	+= indirect_pci.o
 obj-$(CONFIG_PPC_I8259)		+= i8259.o
diff --git a/arch/powerpc/sysdev/fsl_mpc8349_gpio.c b/arch/powerpc/sysdev/fsl_mpc8349_gpio.c
new file mode 100644
index 0000000..fd29cb2
--- /dev/null
+++ b/arch/powerpc/sysdev/fsl_mpc8349_gpio.c
@@ -0,0 +1,161 @@
+/*
+ * MPC8349-compatible SOC GPIOs
+ *
+ * MPC8349 seem to be the first SOC with this GPIO unit. Later it was adopted
+ * by the MPC8610 SOC.
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
+#include <linux/kernel.h>
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
+	spin_lock_irqsave(&fsl_gc->lock, flags);
+	setbits32(&regs->gpdir, pin2mask(gpio));
+	spin_unlock_irqrestore(&fsl_gc->lock, flags);
+
+	fsl_gpio_set(gc, gpio, val);
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
1.5.5.1

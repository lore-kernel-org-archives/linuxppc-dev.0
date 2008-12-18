Return-Path: <avorontsov@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id 93438DDF31
	for <linuxppc-dev@ozlabs.org>; Fri, 19 Dec 2008 03:37:27 +1100 (EST)
Date: Thu, 18 Dec 2008 19:37:26 +0300
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: [PATCH 2/4] powerpc: Implement GPIO driver for simple
	memory-mapped banks
Message-ID: <20081218163726.GB2064@oksana.dev.rtsoft.ru>
References: <20081218163640.GA21049@oksana.dev.rtsoft.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=windows-1251
In-Reply-To: <20081218163640.GA21049@oksana.dev.rtsoft.ru>
Cc: linuxppc-dev@ozlabs.org, Timur Tabi <timur@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

The driver supports very simple GPIO controllers, that is, when a
controller provides just a 'data' register. Such controllers may be
found in various BCSRs (Board's FPGAs used to control board's
switches, LEDs, chip-selects, Ethernet/USB PHY power, etc).

So far we support only 1-byte GPIO banks. Support for other widths may
be implemented when/if needed.

p.s.
To avoid "made up" compatible entries (like compatible = "simple-gpio"),
boards must call simple_gpiochip_init() to pass the compatible string.

Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
---
 arch/powerpc/platforms/Kconfig    |   11 +++
 arch/powerpc/sysdev/Makefile      |    1 +
 arch/powerpc/sysdev/simple_gpio.c |  155 +++++++++++++++++++++++++++++++++++++
 arch/powerpc/sysdev/simple_gpio.h |   12 +++
 4 files changed, 179 insertions(+), 0 deletions(-)
 create mode 100644 arch/powerpc/sysdev/simple_gpio.c
 create mode 100644 arch/powerpc/sysdev/simple_gpio.h

diff --git a/arch/powerpc/platforms/Kconfig b/arch/powerpc/platforms/Kconfig
index 47e956c..47fe2be 100644
--- a/arch/powerpc/platforms/Kconfig
+++ b/arch/powerpc/platforms/Kconfig
@@ -312,4 +312,15 @@ config MPC8xxx_GPIO
 	  Say Y here if you're going to use hardware that connects to the
 	  MPC831x/834x/837x/8572/8610 GPIOs.
 
+config SIMPLE_GPIO
+	bool "Support for simple, memory-mapped GPIO controllers"
+	depends on PPC
+	select GENERIC_GPIO
+	select ARCH_REQUIRE_GPIOLIB
+	help
+	  Say Y here to support simple, memory-mapped GPIO controllers.
+	  These are usually BCSRs used to control board's switches, LEDs,
+	  chip-selects, Ethernet/USB PHY's power and various other small
+	  on-board peripherals.
+
 endmenu
diff --git a/arch/powerpc/sysdev/Makefile b/arch/powerpc/sysdev/Makefile
index 5afce11..b33b28a 100644
--- a/arch/powerpc/sysdev/Makefile
+++ b/arch/powerpc/sysdev/Makefile
@@ -17,6 +17,7 @@ obj-$(CONFIG_FSL_PCI)		+= fsl_pci.o $(fsl-msi-obj-y)
 obj-$(CONFIG_FSL_LBC)		+= fsl_lbc.o
 obj-$(CONFIG_FSL_GTM)		+= fsl_gtm.o
 obj-$(CONFIG_MPC8xxx_GPIO)	+= mpc8xxx_gpio.o
+obj-$(CONFIG_SIMPLE_GPIO)	+= simple_gpio.o
 obj-$(CONFIG_RAPIDIO)		+= fsl_rio.o
 obj-$(CONFIG_TSI108_BRIDGE)	+= tsi108_pci.o tsi108_dev.o
 obj-$(CONFIG_QUICC_ENGINE)	+= qe_lib/
diff --git a/arch/powerpc/sysdev/simple_gpio.c b/arch/powerpc/sysdev/simple_gpio.c
new file mode 100644
index 0000000..43c4569
--- /dev/null
+++ b/arch/powerpc/sysdev/simple_gpio.c
@@ -0,0 +1,155 @@
+/*
+ * Simple Memory-Mapped GPIOs
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
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/spinlock.h>
+#include <linux/types.h>
+#include <linux/ioport.h>
+#include <linux/io.h>
+#include <linux/of.h>
+#include <linux/of_gpio.h>
+#include <linux/gpio.h>
+#include <asm/prom.h>
+#include "simple_gpio.h"
+
+struct u8_gpio_chip {
+	struct of_mm_gpio_chip mm_gc;
+	spinlock_t lock;
+
+	/* shadowed data register to clear/set bits safely */
+	u8 data;
+};
+
+static struct u8_gpio_chip *to_u8_gpio_chip(struct of_mm_gpio_chip *mm_gc)
+{
+	return container_of(mm_gc, struct u8_gpio_chip, mm_gc);
+}
+
+static u8 u8_pin2mask(unsigned int pin)
+{
+	return 1 << (8 - 1 - pin);
+}
+
+static int u8_gpio_get(struct gpio_chip *gc, unsigned int gpio)
+{
+	struct of_mm_gpio_chip *mm_gc = to_of_mm_gpio_chip(gc);
+
+	return in_8(mm_gc->regs) & u8_pin2mask(gpio);
+}
+
+static void u8_gpio_set(struct gpio_chip *gc, unsigned int gpio, int val)
+{
+	struct of_mm_gpio_chip *mm_gc = to_of_mm_gpio_chip(gc);
+	struct u8_gpio_chip *u8_gc = to_u8_gpio_chip(mm_gc);
+	unsigned long flags;
+
+	spin_lock_irqsave(&u8_gc->lock, flags);
+
+	if (val)
+		u8_gc->data |= u8_pin2mask(gpio);
+	else
+		u8_gc->data &= ~u8_pin2mask(gpio);
+
+	out_8(mm_gc->regs, u8_gc->data);
+
+	spin_unlock_irqrestore(&u8_gc->lock, flags);
+}
+
+static int u8_gpio_dir_in(struct gpio_chip *gc, unsigned int gpio)
+{
+	return 0;
+}
+
+static int u8_gpio_dir_out(struct gpio_chip *gc, unsigned int gpio, int val)
+{
+	u8_gpio_set(gc, gpio, val);
+	return 0;
+}
+
+static void u8_gpio_save_regs(struct of_mm_gpio_chip *mm_gc)
+{
+	struct u8_gpio_chip *u8_gc = to_u8_gpio_chip(mm_gc);
+
+	u8_gc->data = in_8(mm_gc->regs);
+}
+
+static int __init u8_simple_gpiochip_add(struct device_node *np)
+{
+	int ret;
+	struct u8_gpio_chip *u8_gc;
+	struct of_mm_gpio_chip *mm_gc;
+	struct of_gpio_chip *of_gc;
+	struct gpio_chip *gc;
+
+	u8_gc = kzalloc(sizeof(*u8_gc), GFP_KERNEL);
+	if (!u8_gc)
+		return -ENOMEM;
+
+	spin_lock_init(&u8_gc->lock);
+
+	mm_gc = &u8_gc->mm_gc;
+	of_gc = &mm_gc->of_gc;
+	gc = &of_gc->gc;
+
+	mm_gc->save_regs = u8_gpio_save_regs;
+	of_gc->gpio_cells = 2;
+	gc->ngpio = 8;
+	gc->direction_input = u8_gpio_dir_in;
+	gc->direction_output = u8_gpio_dir_out;
+	gc->get = u8_gpio_get;
+	gc->set = u8_gpio_set;
+
+	ret = of_mm_gpiochip_add(np, mm_gc);
+	if (ret)
+		goto err;
+	return 0;
+err:
+	kfree(u8_gc);
+	return ret;
+}
+
+void __init simple_gpiochip_init(const char *compatible)
+{
+	struct device_node *np;
+
+	for_each_compatible_node(np, NULL, compatible) {
+		int ret;
+		struct resource r;
+
+		ret = of_address_to_resource(np, 0, &r);
+		if (ret)
+			goto err;
+
+		switch (resource_size(&r)) {
+		case 1:
+			ret = u8_simple_gpiochip_add(np);
+			if (ret)
+				goto err;
+			break;
+		default:
+			/*
+			 * Whenever you need support for GPIO bank width > 1,
+			 * please just turn u8_ code into huge macros, and
+			 * construct needed uX_ code with it.
+			 */
+			ret = -ENOSYS;
+			goto err;
+		}
+		continue;
+err:
+		pr_err("%s: registration failed, status %d\n",
+		       np->full_name, ret);
+	}
+}
diff --git a/arch/powerpc/sysdev/simple_gpio.h b/arch/powerpc/sysdev/simple_gpio.h
new file mode 100644
index 0000000..3a7b0c5
--- /dev/null
+++ b/arch/powerpc/sysdev/simple_gpio.h
@@ -0,0 +1,12 @@
+#ifndef __SYSDEV_SIMPLE_GPIO_H
+#define __SYSDEV_SIMPLE_GPIO_H
+
+#include <linux/errno.h>
+
+#ifdef CONFIG_SIMPLE_GPIO
+extern void simple_gpiochip_init(const char *compatible);
+#else
+static inline void simple_gpiochip_init(const char *compatible) {}
+#endif /* CONFIG_SIMPLE_GPIO */
+
+#endif /* __SYSDEV_SIMPLE_GPIO_H */
-- 
1.5.6.5

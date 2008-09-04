Return-Path: <avorontsov@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id 62EB1DDF2C
	for <linuxppc-dev@ozlabs.org>; Thu,  4 Sep 2008 23:36:44 +1000 (EST)
Date: Thu, 4 Sep 2008 17:36:40 +0400
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: [PATCH 1/2] powerpc: add driver for simple GPIO banks
Message-ID: <20080904133640.GA10256@oksana.dev.rtsoft.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=windows-1251
Cc: linuxppc-dev@ozlabs.org, Li Yang <leoli@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

The driver supports very simple GPIO controllers, that is, when a
controller provides just a 'data' register. Such controllers may
be found in various BCSRs (Board's FPGAs used to control board's
switches, LEDs, chip-selects, Ethernet/USB PHY power, etc).

So far we support only 1-byte GPIO banks. Support for other widths
may be implemented when/if needed.

Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
---

The driver is user-selectable now.

 arch/powerpc/sysdev/Kconfig          |   11 +++
 arch/powerpc/sysdev/Makefile         |    2 +
 arch/powerpc/sysdev/of_simple_gpio.c |  154 ++++++++++++++++++++++++++++++++++
 3 files changed, 167 insertions(+), 0 deletions(-)
 create mode 100644 arch/powerpc/sysdev/of_simple_gpio.c

diff --git a/arch/powerpc/sysdev/Kconfig b/arch/powerpc/sysdev/Kconfig
index 72fb35b..30d6e4d 100644
--- a/arch/powerpc/sysdev/Kconfig
+++ b/arch/powerpc/sysdev/Kconfig
@@ -6,3 +6,14 @@ config PPC4xx_PCI_EXPRESS
 	bool
 	depends on PCI && 4xx
 	default n
+
+config OF_SIMPLE_GPIO
+	bool "Support for simple, memory-mapped GPIO controllers"
+	depends on PPC
+	select GENERIC_GPIO
+	select ARCH_REQUIRE_GPIOLIB
+	help
+	  Say Y here to support simple, memory-mapped GPIO controllers.
+	  These are usually BCSRs used to control board's switches, LEDs,
+	  chip-selects, Ethernet/USB PHY's power and various other small
+	  on-board peripherals.
diff --git a/arch/powerpc/sysdev/Makefile b/arch/powerpc/sysdev/Makefile
index a90054b..239d7e8 100644
--- a/arch/powerpc/sysdev/Makefile
+++ b/arch/powerpc/sysdev/Makefile
@@ -36,6 +36,8 @@ ifeq ($(CONFIG_PCI),y)
 obj-$(CONFIG_4xx)		+= ppc4xx_pci.o
 endif
 
+obj-$(CONFIG_OF_SIMPLE_GPIO)	+= of_simple_gpio.o
+
 # Temporary hack until we have migrated to asm-powerpc
 ifeq ($(ARCH),powerpc)
 obj-$(CONFIG_CPM)		+= cpm_common.o
diff --git a/arch/powerpc/sysdev/of_simple_gpio.c b/arch/powerpc/sysdev/of_simple_gpio.c
new file mode 100644
index 0000000..536c0c2
--- /dev/null
+++ b/arch/powerpc/sysdev/of_simple_gpio.c
@@ -0,0 +1,154 @@
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
+#include <linux/spinlock.h>
+#include <linux/types.h>
+#include <linux/ioport.h>
+#include <linux/io.h>
+#include <linux/of.h>
+#include <linux/of_gpio.h>
+#include <linux/gpio.h>
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
+static int __init simple_gpiochip_init(void)
+{
+	struct device_node *np;
+
+	for_each_compatible_node(np, NULL, "simple-gpio-bank") {
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
+	return 0;
+}
+arch_initcall(simple_gpiochip_init);
-- 
1.5.6.3

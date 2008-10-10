Return-Path: <avorontsov@dev.rtsoft.ru>
Received: from mail.dev.rtsoft.ru (unknown [85.21.88.2])
	by ozlabs.org (Postfix) with SMTP id 26507DDF9D
	for <linuxppc-dev@ozlabs.org>; Sat, 11 Oct 2008 03:55:04 +1100 (EST)
Date: Fri, 10 Oct 2008 20:55:01 +0400
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: [PATCH 1/3] powerpc: add driver for simple GPIO banks
Message-ID: <20081010165501.GB4291@oksana.dev.rtsoft.ru>
References: <20081010165410.GA4291@oksana.dev.rtsoft.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=windows-1251
In-Reply-To: <20081010165410.GA4291@oksana.dev.rtsoft.ru>
Cc: linuxppc-dev@ozlabs.org
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
boards must call the simple_gpiochip_init() to pass the compatible
string.

Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
---
 Documentation/powerpc/dts-bindings/fsl/board.txt |   30 ++++
 arch/powerpc/platforms/Kconfig                   |   11 ++
 arch/powerpc/sysdev/Makefile                     |    1 +
 arch/powerpc/sysdev/simple_gpio.c                |  157 ++++++++++++++++++++++
 arch/powerpc/sysdev/simple_gpio.h                |   13 ++
 5 files changed, 212 insertions(+), 0 deletions(-)
 create mode 100644 arch/powerpc/sysdev/simple_gpio.c
 create mode 100644 arch/powerpc/sysdev/simple_gpio.h

diff --git a/Documentation/powerpc/dts-bindings/fsl/board.txt b/Documentation/powerpc/dts-bindings/fsl/board.txt
index 74ae6f1..e97877f 100644
--- a/Documentation/powerpc/dts-bindings/fsl/board.txt
+++ b/Documentation/powerpc/dts-bindings/fsl/board.txt
@@ -27,3 +27,33 @@ Example (MPC8610HPCD):
 		compatible = "fsl,fpga-pixis";
 		reg = <0xe8000000 32>;
 	};
+
+* Freescale BCSR GPIO banks
+
+Some BCSR registers act as simple GPIO controllers, each such
+register can be represented by the gpio-controller node.
+
+Required properities:
+- compatible : Should be "fsl,<board>-bcsr-gpio";
+- reg : Should contain the address and the lenght of the GPIO bank
+  register;
+- #gpio-cells : Should be two. The first cell is the pin number and the
+  second cell is used to specify optional paramters (currently unused);
+- gpio-controller : Marks the port as GPIO controller.
+
+Example:
+
+	bcsr@1,0 {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		device_type = "board-control";
+		reg = <1 0 0x8000>;
+		ranges = <0 1 0 0x8000>;
+
+		bcsr13: gpio-controller@d {
+			#gpio-cells = <2>;
+			compatible = "fsl,mpc8360mds-bcsr-gpio";
+			reg = <0xd 1>;
+			gpio-controller;
+		};
+	};
diff --git a/arch/powerpc/platforms/Kconfig b/arch/powerpc/platforms/Kconfig
index 71845d7..e4482b5 100644
--- a/arch/powerpc/platforms/Kconfig
+++ b/arch/powerpc/platforms/Kconfig
@@ -303,4 +303,15 @@ config OF_RTC
 
 source "arch/powerpc/sysdev/bestcomm/Kconfig"
 
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
index a90054b..cd06d7e 100644
--- a/arch/powerpc/sysdev/Makefile
+++ b/arch/powerpc/sysdev/Makefile
@@ -32,6 +32,7 @@ obj-$(CONFIG_4xx)		+= uic.o
 obj-$(CONFIG_4xx_SOC)		+= ppc4xx_soc.o
 obj-$(CONFIG_XILINX_VIRTEX)	+= xilinx_intc.o
 obj-$(CONFIG_OF_RTC)		+= of_rtc.o
+obj-$(CONFIG_SIMPLE_GPIO)	+= simple_gpio.o
 ifeq ($(CONFIG_PCI),y)
 obj-$(CONFIG_4xx)		+= ppc4xx_pci.o
 endif
diff --git a/arch/powerpc/sysdev/simple_gpio.c b/arch/powerpc/sysdev/simple_gpio.c
new file mode 100644
index 0000000..ef0a452
--- /dev/null
+++ b/arch/powerpc/sysdev/simple_gpio.c
@@ -0,0 +1,157 @@
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
+int __init simple_gpiochip_init(const char *compatible)
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
+	return 0;
+}
+EXPORT_SYMBOL(simple_gpiochip_init);
diff --git a/arch/powerpc/sysdev/simple_gpio.h b/arch/powerpc/sysdev/simple_gpio.h
new file mode 100644
index 0000000..389f712
--- /dev/null
+++ b/arch/powerpc/sysdev/simple_gpio.h
@@ -0,0 +1,13 @@
+#ifndef __SYSDEV_SIMPLE_GPIO_H
+#define __SYSDEV_SIMPLE_GPIO_H
+
+#ifdef CONFIG_SIMPLE_GPIO
+extern int __init simple_gpiochip_init(const char *compatible);
+#else
+static inline int __init simple_gpiochip_init(const char *compatible)
+{
+	return -ENODEV;
+}
+#endif /* CONFIG_SIMPLE_GPIO */
+
+#endif /* __SYSDEV_SIMPLE_GPIO_H */
-- 
1.5.6.3

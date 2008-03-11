Return-Path: <avorontsov@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id 4764CDE18A
	for <linuxppc-dev@ozlabs.org>; Wed, 12 Mar 2008 05:42:12 +1100 (EST)
Date: Tue, 11 Mar 2008 21:42:10 +0300
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 1/4] OF helpers for the GPIO API
Message-ID: <20080311184210.GA32164@localhost.localdomain>
References: <20080311184012.GA28466@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf8
In-Reply-To: <20080311184012.GA28466@localhost.localdomain>
Cc: David Miller <davem@davemloft.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This patch implements various helpers to support OF bindings for
the GPIO LIB API.

Previously this was PowerPC specific, but it seems this code
isn't arch-dependent anyhow, so let's place it into of/.

SPARC will not see this addition yet, real hardware seem to not use
GPIOs at all. But this might change:

   http://www.leox.org/docs/faq_MLleon.html

"16-bit I/O port" sounds promising. :-)

Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
---
 drivers/of/Kconfig      |    6 ++
 drivers/of/Makefile     |    1 +
 drivers/of/gpio.c       |  202 +++++++++++++++++++++++++++++++++++++++++++++++
 include/linux/of_gpio.h |   96 ++++++++++++++++++++++
 4 files changed, 305 insertions(+), 0 deletions(-)
 create mode 100644 drivers/of/gpio.c
 create mode 100644 include/linux/of_gpio.h

diff --git a/drivers/of/Kconfig b/drivers/of/Kconfig
index c03072b..3354ad7 100644
--- a/drivers/of/Kconfig
+++ b/drivers/of/Kconfig
@@ -1,3 +1,9 @@
 config OF_DEVICE
 	def_bool y
 	depends on OF && (SPARC || PPC_OF)
+
+config OF_GPIO
+	def_bool y
+	depends on OF && PPC_OF && HAVE_GPIO_LIB
+	help
+	  OpenFirmware GPIO accessors
diff --git a/drivers/of/Makefile b/drivers/of/Makefile
index ab9be5d..5a61f70 100644
--- a/drivers/of/Makefile
+++ b/drivers/of/Makefile
@@ -1,2 +1,3 @@
 obj-y = base.o
 obj-$(CONFIG_OF_DEVICE) += device.o platform.o
+obj-$(CONFIG_OF_GPIO)   += gpio.o
diff --git a/drivers/of/gpio.c b/drivers/of/gpio.c
new file mode 100644
index 0000000..ed1c161
--- /dev/null
+++ b/drivers/of/gpio.c
@@ -0,0 +1,202 @@
+/*
+ * OF helpers for the GPIO API
+ *
+ * Copyright (c) 2007-2008  MontaVista Software, Inc.
+ *
+ * Author: Anton Vorontsov <avorontsov@ru.mvista.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ */
+
+#include <linux/kernel.h>
+#include <linux/io.h>
+#include <linux/of.h>
+#include <linux/of_gpio.h>
+#include <asm/prom.h>
+
+int of_get_gpio(struct device_node *np, int index)
+{
+	int ret = -EINVAL;
+	struct device_node *gc;
+	struct of_gpio_chip *of_gc = NULL;
+	int size;
+	const u32 *gpios;
+	u32 nr_cells;
+	int i;
+	const void *gpio_spec;
+	const u32 *gpio_cells;
+	int gpio_index = 0;
+
+	gpios = of_get_property(np, "gpios", &size);
+	if (!gpios) {
+		ret = -ENOENT;
+		goto err0;
+	}
+	nr_cells = size / sizeof(u32);
+
+	for (i = 0; i < nr_cells; gpio_index++) {
+		const phandle *gpio_phandle;
+
+		gpio_phandle = gpios + i;
+		gpio_spec = gpio_phandle + 1;
+
+		/* one cell hole in the gpios = <>; */
+		if (!*gpio_phandle) {
+			if (gpio_index == index)
+				return -ENOENT;
+			i++;
+			continue;
+		}
+
+		gc = of_find_node_by_phandle(*gpio_phandle);
+		if (!gc) {
+			pr_debug("%s: could not find phandle for gpios\n",
+				 np->full_name);
+			goto err0;
+		}
+
+		of_gc = gc->data;
+		if (!of_gc) {
+			pr_debug("%s: gpio controller %s isn't registered\n",
+				 np->full_name, gc->full_name);
+			goto err1;
+		}
+
+		gpio_cells = of_get_property(gc, "#gpio-cells", &size);
+		if (!gpio_cells || size != sizeof(*gpio_cells) ||
+				*gpio_cells != of_gc->gpio_cells) {
+			pr_debug("%s: wrong #gpio-cells for %s\n",
+				 np->full_name, gc->full_name);
+			goto err1;
+		}
+
+		/* Next phandle is at phandle cells + #gpio-cells */
+		i += sizeof(*gpio_phandle) / sizeof(u32) + *gpio_cells;
+		if (i >= nr_cells + 1) {
+			pr_debug("%s: insufficient gpio-spec length\n",
+				 np->full_name);
+			goto err1;
+		}
+
+		if (gpio_index == index)
+			break;
+
+		of_gc = NULL;
+		of_node_put(gc);
+	}
+
+	if (!of_gc) {
+		ret = -ENOENT;
+		goto err0;
+	}
+
+	ret = of_gc->xlate(of_gc, np, gpio_spec);
+	if (ret < 0)
+		goto err1;
+
+	ret += of_gc->gc.base;
+err1:
+	of_node_put(gc);
+err0:
+	pr_debug("%s exited with status %d\n", __func__, ret);
+	return ret;
+}
+EXPORT_SYMBOL(of_get_gpio);
+
+static int of_gpio_simple_xlate(struct of_gpio_chip *of_gc,
+				struct device_node *np,
+				const void *gpio_spec)
+{
+	const u32 *gpio = gpio_spec;
+
+	if (*gpio > of_gc->gc.ngpio)
+		return -EINVAL;
+
+	return *gpio;
+}
+
+/* Should be sufficient for now, later we'll use dynamic bases. */
+#if defined(CONFIG_PPC32) || defined(CONFIG_SPARC32)
+#define GPIOS_PER_CHIP 32
+#else
+#define GPIOS_PER_CHIP 64
+#endif
+
+static int of_get_gpiochip_base(struct device_node *np)
+{
+	struct device_node *gc = NULL;
+	int gpiochip_base = 0;
+
+	while ((gc = of_find_all_nodes(gc))) {
+		if (!of_get_property(gc, "gpio-controller", NULL))
+			continue;
+
+		if (gc != np) {
+			gpiochip_base += GPIOS_PER_CHIP;
+			continue;
+		}
+
+		of_node_put(gc);
+
+		if (gpiochip_base >= ARCH_NR_GPIOS)
+			return -ENOSPC;
+
+		return gpiochip_base;
+	}
+
+	return -ENOENT;
+}
+
+int of_mm_gpiochip_add(struct device_node *np,
+		       struct of_mm_gpio_chip *mm_gc)
+{
+	int ret = -ENOMEM;
+	struct of_gpio_chip *of_gc = &mm_gc->of_gc;
+	struct gpio_chip *gc = &of_gc->gc;
+
+	gc->label = kstrdup(np->full_name, GFP_KERNEL);
+	if (!gc->label)
+		goto err0;
+
+	mm_gc->regs = of_iomap(np, 0);
+	if (!mm_gc->regs)
+		goto err1;
+
+	gc->base = of_get_gpiochip_base(np);
+	if (gc->base < 0) {
+		ret = gc->base;
+		goto err1;
+	}
+
+	if (!of_gc->xlate)
+		of_gc->xlate = of_gpio_simple_xlate;
+
+	if (mm_gc->save_regs)
+		mm_gc->save_regs(mm_gc);
+
+	np->data = of_gc;
+
+	ret = gpiochip_add(gc);
+	if (ret)
+		goto err2;
+
+	/* We don't want to lose the node and its ->data */
+	of_node_get(np);
+
+	pr_debug("%s: registered as generic GPIO chip, base is %d\n",
+		 np->full_name, gc->base);
+	return 0;
+err2:
+	np->data = NULL;
+	iounmap(mm_gc->regs);
+err1:
+	kfree(gc->label);
+err0:
+	pr_err("%s: GPIO chip registration failed with status %d\n",
+	       np->full_name, ret);
+	return ret;
+}
+EXPORT_SYMBOL(of_mm_gpiochip_add);
diff --git a/include/linux/of_gpio.h b/include/linux/of_gpio.h
new file mode 100644
index 0000000..ca313f0
--- /dev/null
+++ b/include/linux/of_gpio.h
@@ -0,0 +1,96 @@
+/*
+ * Generic GPIO API implementation for PowerPC.
+ *
+ * Copyright (c) 2007-2008  MontaVista Software, Inc.
+ *
+ * Author: Anton Vorontsov <avorontsov@ru.mvista.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ */
+
+#ifndef __LINUX_OF_GPIO_H
+#define __LINUX_OF_GPIO_H
+
+#include <asm/gpio.h>
+
+#ifdef CONFIG_OF_GPIO
+
+/*
+ * Generic OF GPIO chip
+ */
+struct of_gpio_chip {
+	struct gpio_chip gc;
+	int gpio_cells;
+	int (*xlate)(struct of_gpio_chip *of_gc, struct device_node *np,
+		     const void *gpio_spec);
+};
+
+static inline struct of_gpio_chip *to_of_gpio_chip(struct gpio_chip *gc)
+{
+	return container_of(gc, struct of_gpio_chip, gc);
+}
+
+/*
+ * OF GPIO chip for memory mapped banks
+ */
+struct of_mm_gpio_chip {
+	struct of_gpio_chip of_gc;
+	void (*save_regs)(struct of_mm_gpio_chip *mm_gc);
+	void __iomem *regs;
+};
+
+static inline struct of_mm_gpio_chip *to_of_mm_gpio_chip(struct gpio_chip *gc)
+{
+	struct of_gpio_chip *of_gc = to_of_gpio_chip(gc);
+
+	return container_of(of_gc, struct of_mm_gpio_chip, of_gc);
+}
+
+/**
+ * of_get_gpio - Get a GPIO number from the device tree to use with GPIO API
+ * @np:		device node to get GPIO from
+ * @index:	index of the GPIO
+ *
+ * Returns GPIO number to use with Linux generic GPIO API, or one of the errno
+ * value on the error condition.
+ */
+extern int of_get_gpio(struct device_node *np, int index);
+
+/**
+ * of_mm_gpiochip_add - Add memory mapped GPIO chip (bank)
+ * @np:		device node of the GPIO chip
+ * @mm_gc:	pointer to the of_mm_gpio_chip allocated structure
+ *
+ * To use this function you should allocate and fill mm_gc with:
+ *
+ * 1) In the gpio_chip structure:
+ *    - all the callbacks
+ *
+ * 2) In the of_gpio_chip structure:
+ *    - gpio_cells
+ *    - xlate callback (optional)
+ *
+ * 3) In the of_mm_gpio_chip structure:
+ *    - save_regs callback (optional)
+ *
+ * If succeeded, this function will map bank's memory and will
+ * do all necessary work for you. Then you'll able to use .regs
+ * to manage GPIOs from the callbacks.
+ */
+extern int of_mm_gpiochip_add(struct device_node *np,
+			      struct of_mm_gpio_chip *mm_gc);
+
+#else
+
+/* Drivers may not strictly depend on the GPIO support, so let them link. */
+static inline int of_get_gpio(struct device_node *np, int index)
+{
+	return -ENOSYS;
+}
+
+#endif /* CONFIG_OF_GPIO */
+
+#endif /* __LINUX_OF_GPIO_H */
-- 
1.5.2.2

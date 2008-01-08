Return-Path: <avorontsov@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id E5A49DE1DE
	for <linuxppc-dev@ozlabs.org>; Wed,  9 Jan 2008 05:36:06 +1100 (EST)
Date: Tue, 8 Jan 2008 21:45:18 +0300
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 1/3] [POWERPC] Implement support for the GPIO LIB API
Message-ID: <20080108184518.GA18445@localhost.localdomain>
References: <20080108184341.GA29753@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf8
In-Reply-To: <20080108184341.GA29753@localhost.localdomain>
Cc: Arnd Bergmann <arnd@arndb.de>, David Gibson <david@gibson.dropbear.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This patch implements support for the GPIO LIB API. Two calls
unimplemented though: irq_to_gpio and gpio_to_irq.

Various OF helpers provided to ease life and reduce code duplication.

Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
---
 Documentation/powerpc/booting-without-of.txt |   58 ++++++++
 arch/powerpc/Kconfig                         |    5 +
 arch/powerpc/kernel/Makefile                 |    1 +
 arch/powerpc/kernel/gpio.c                   |  186 ++++++++++++++++++++++++++
 include/asm-powerpc/gpio.h                   |  126 +++++++++++++++++
 5 files changed, 376 insertions(+), 0 deletions(-)
 create mode 100644 arch/powerpc/kernel/gpio.c
 create mode 100644 include/asm-powerpc/gpio.h

diff --git a/Documentation/powerpc/booting-without-of.txt b/Documentation/powerpc/booting-without-of.txt
index ee0209a..dd2613c 100644
--- a/Documentation/powerpc/booting-without-of.txt
+++ b/Documentation/powerpc/booting-without-of.txt
@@ -60,6 +60,10 @@ Table of Contents
     3) OpenPIC Interrupt Controllers
     4) ISA Interrupt Controllers
 
+  VIII - Specifying GPIO information for devices
+    1) gpios property
+    2) gpio-controller nodes
+
   Appendix A - Sample SOC node for MPC8540
 
 
@@ -2618,6 +2622,60 @@ encodings listed below:
 	2 =  high to low edge sensitive type enabled
 	3 =  low to high edge sensitive type enabled
 
+VIII - Specifying GPIO information for devices
+==============================================
+
+1) gpios property
+-----------------
+
+Nodes that makes use of GPIOs should define them using `gpios' property,
+format of which is: <&gpio-controller1-phandle gpio1-specifier
+		     &gpio-controller2-phandle gpio2-specifier
+		     ...>;
+
+Note that gpio-specifier length is controller dependent.
+
+gpio-specifier may encode: bank, pin position inside the bank,
+whether pin is open-drain and whether pin is active-low.
+
+Example of the node using GPIOs:
+
+	nand-flash@1,0 {
+		compatible = "stmicro,NAND512W3A2BN6E", "fsl,upm-nand";
+		reg = <1 0 1>;
+		width = <1>;
+		upm = "A";
+		upm-addr-offset = <16>;
+		upm-cmd-offset = <8>;
+		gpios = <&qe_pio_e 18>;
+		wait-pattern;
+		wait-write;
+	};
+
+In that example gpio-specifier is "18" and encodes GPIO pin number only,
+as accepted by the "qe_pio_e" gpio-controller.
+
+2) gpio-controller nodes
+------------------------
+
+Every GPIO controller node must have #gpio-cells property defined,
+this information will be used to translate gpio-specifiers.
+
+Example of two SOC GPIO banks defined as gpio-controller nodes:
+
+	qe_pio_a: gpio-controller@1400 {
+		#gpio-cells = <1>;
+		compatible = "fsl,qe-pario-bank";
+		reg = <0x1400 0x18>;
+		gpio-controller;
+	};
+
+	qe_pio_e: gpio-controller@1460 {
+		#gpio-cells = <1>;
+		compatible = "fsl,qe-pario-bank";
+		reg = <0x1460 0x18>;
+		gpio-controller;
+	};
 
 Appendix A - Sample SOC node for MPC8540
 ========================================
diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index 66a3d8c..b38c84a 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -73,6 +73,11 @@ config GENERIC_FIND_NEXT_BIT
 	bool
 	default y
 
+config GENERIC_GPIO
+	bool
+	help
+	  Generic GPIO API support
+
 config ARCH_NO_VIRT_TO_BUS
 	def_bool PPC64
 
diff --git a/arch/powerpc/kernel/Makefile b/arch/powerpc/kernel/Makefile
index 9374bc9..943045c 100644
--- a/arch/powerpc/kernel/Makefile
+++ b/arch/powerpc/kernel/Makefile
@@ -65,6 +65,7 @@ obj-$(CONFIG_BOOTX_TEXT)	+= btext.o
 obj-$(CONFIG_SMP)		+= smp.o
 obj-$(CONFIG_KPROBES)		+= kprobes.o
 obj-$(CONFIG_PPC_UDBG_16550)	+= legacy_serial.o udbg_16550.o
+obj-$(CONFIG_GPIO_LIB)		+= gpio.o
 
 pci64-$(CONFIG_PPC64)		+= pci_dn.o isa-bridge.o
 obj-$(CONFIG_PCI)		+= pci_$(CONFIG_WORD_SIZE).o $(pci64-y) \
diff --git a/arch/powerpc/kernel/gpio.c b/arch/powerpc/kernel/gpio.c
new file mode 100644
index 0000000..f41d1e0
--- /dev/null
+++ b/arch/powerpc/kernel/gpio.c
@@ -0,0 +1,186 @@
+/*
+ * OF helpers for the GPIO API
+ *
+ * Copyright (c) 2007  MontaVista Software, Inc.
+ * Copyright (c) 2007  Anton Vorontsov <avorontsov@ru.mvista.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ */
+
+#include <linux/kernel.h>
+#include <linux/of.h>
+#include <asm/prom.h>
+#include <asm/gpio.h>
+
+int of_gpio_simple_xlate(struct of_gpio_chip *of_gc, struct device_node *np,
+			 const void *gpio_spec)
+{
+	const u32 *gpio = gpio_spec;
+
+	if (*gpio > of_gc->gc.ngpio)
+		return -EINVAL;
+
+	return *gpio;
+}
+EXPORT_SYMBOL(of_gpio_simple_xlate);
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
+	for (i = 0; i < nr_cells;) {
+		const phandle *gpio_phandle;
+
+		gpio_phandle = gpios + i;
+		gpio_spec = gpio_phandle + 1;
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
+		gpio_index++;
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
+			gpiochip_base += ARCH_GPIOS_PER_CHIP;
+			continue;
+		}
+
+		of_node_put(gc);
+
+		if (gpiochip_base >= ARCH_OF_GPIOS_END)
+			return -ENOSPC;
+
+		return gpiochip_base;
+	}
+
+	return -ENOENT;
+}
+
+int of_mm_gpiochip_add(struct device_node *np,
+		       const struct of_gpio_chip *of_gc)
+{
+	int ret = -ENOMEM;
+	struct of_mm_gpio_chip *mm_gc;
+
+	mm_gc = kzalloc(sizeof(*mm_gc), GFP_KERNEL);
+	if (!mm_gc)
+		goto err0;
+
+	mm_gc->of_gc = *of_gc;
+
+	mm_gc->of_gc.gc.label = kstrdup(np->full_name, GFP_KERNEL);
+	if (!mm_gc->of_gc.gc.label)
+		goto err1;
+
+	ret = of_get_gpiochip_base(np);
+	if (ret < 0)
+		goto err2;
+
+	mm_gc->regs = of_iomap(np, 0);
+	if (!mm_gc->regs) {
+		ret = -ENOMEM;
+		goto err1;
+	}
+
+	mm_gc->of_gc.gc.base = ret;
+
+	np->data = &mm_gc->of_gc;
+
+	ret = gpiochip_add(&mm_gc->of_gc.gc);
+	if (ret)
+		goto err2;
+
+	of_node_get(np);
+
+	pr_debug("%s: registered as generic GPIO chip, base is %d\n",
+		 np->full_name, mm_gc->of_gc.gc.base);
+	return 0;
+err2:
+	np->data = NULL;
+	kfree(mm_gc->of_gc.gc.label);
+err1:
+	kfree(mm_gc);
+err0:
+	pr_err("%s: GPIO chip registration failed with status %d\n",
+	       np->full_name, ret);
+	return ret;
+}
+EXPORT_SYMBOL(of_mm_gpiochip_add);
diff --git a/include/asm-powerpc/gpio.h b/include/asm-powerpc/gpio.h
new file mode 100644
index 0000000..1cc2e90
--- /dev/null
+++ b/include/asm-powerpc/gpio.h
@@ -0,0 +1,126 @@
+/*
+ * Generic GPIO API implementation for PowerPC.
+ *
+ * Copyright (c) 2007  MontaVista Software, Inc.
+ * Copyright (c) 2007  Anton Vorontsov <avorontsov@ru.mvista.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ */
+
+#ifndef __ASM_POWERPC_GPIO_H
+#define __ASM_POWERPC_GPIO_H
+
+#include <asm-generic/gpio.h>
+
+#ifdef CONFIG_GPIO_LIB
+
+#define ARCH_OF_GPIOS_BASE	0
+#define ARCH_OF_GPIOS_END	(ARCH_GPIOS_PER_CHIP * 7)
+#define ARCH_NON_OF_GPIOS_BASE	ARCH_OF_GPIOS_END
+#define ARCH_NON_OF_GPIOS_END	ARCH_NR_GPIOS
+
+#if ARCH_NON_OF_GPIOS_BASE >= ARCH_NON_OF_GPIOS_END
+#error "Default ARCH_NR_GPIOS isn't sufficient, define yours."
+#endif
+
+/*
+ * We don't (yet) implement inlined/rapid versions for on-chip gpios.
+ * Just call gpiolib.
+ */
+static inline int gpio_get_value(unsigned int gpio)
+{
+	return __gpio_get_value(gpio);
+}
+
+static inline void gpio_set_value(unsigned int gpio, int value)
+{
+	__gpio_set_value(gpio, value);
+}
+
+/*
+ * Not implemented, yet.
+ */
+static inline int gpio_to_irq(unsigned int gpio)
+{
+	return -ENOSYS;
+}
+
+static inline int irq_to_gpio(unsigned int irq)
+{
+	return -ENOSYS;
+}
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
+#define to_of_gpio_chip(x) container_of(x, struct of_gpio_chip, gc)
+
+/*
+ * OF GPIO chip for memory mapped banks
+ */
+struct of_mm_gpio_chip {
+	struct of_gpio_chip of_gc;
+	void __iomem *regs;
+};
+
+#define to_of_mm_gpio_chip(x) container_of(to_of_gpio_chip(x), \
+					   struct of_mm_gpio_chip, of_gc)
+
+/**
+ * of_gpio_simple_xlate - Translate GPIO number given in the device tree
+ * @of_gc:	pointer to the OF GPIO chip
+ * @np:		device node to get GPIO from
+ * @gpio_spec:	pointer to the gpio-spec field in the `gpios' property
+ *
+ * This is gpio-controller specific function, returns translated GPIO
+ * number.
+ */
+extern int of_gpio_simple_xlate(struct of_gpio_chip *of_gc,
+				struct device_node *np,
+				const void *gpio_spec);
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
+ * @of_gc:	pointer to the of_gpio_chip template
+ *
+ * To use this function you should fill of_gc template with:
+ *
+ * 1) In the gpio_chip structure:
+ *    a) all callbacks
+ *    b) ngpios (GPIOs per bank)
+ *
+ * 2) In the of_gpio_chip structure:
+ *    a) xlate callback
+ *    b) gpio_cells
+ *
+ * If succeeded, this function will map bank's memory and will
+ * do all necessary work for you. Then you'll able to use .regs
+ * to manage GPIOs from the callbacks.
+ */
+extern int of_mm_gpiochip_add(struct device_node *np,
+			      const struct of_gpio_chip *of_gc);
+
+#endif /* CONFIG_GPIO_LIB */
+
+#endif /* __ASM_POWERPC_GPIO_H */
-- 
1.5.2.2

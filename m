Return-Path: <avorontsov@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id 4555DDDEBD
	for <linuxppc-dev@ozlabs.org>; Sat, 22 Dec 2007 07:29:17 +1100 (EST)
Date: Fri, 21 Dec 2007 23:31:15 +0300
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: [PATCH 1/4] [POWERPC] Implement GPIO API embryo
Message-ID: <20071221203115.GA4633@localhost.localdomain>
References: <20071221202824.GA4607@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf8
In-Reply-To: <20071221202824.GA4607@localhost.localdomain>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This patch implements GPIO API as described in Documentation/gpio.txt.
Two calls unimplemented though: irq_to_gpio and gpio_to_irq.

This patch also provides OF helpers.

Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
---
 arch/powerpc/Kconfig             |    3 ++
 arch/powerpc/kernel/prom_parse.c |   64 ++++++++++++++++++++++++++++++++++++++
 include/asm-powerpc/gpio.h       |   47 ++++++++++++++++++++++++++++
 include/asm-powerpc/prom.h       |   23 +++++++++++++
 4 files changed, 137 insertions(+), 0 deletions(-)
 create mode 100644 include/asm-powerpc/gpio.h

diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index 232c298..a4fa173 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -73,6 +73,9 @@ config GENERIC_FIND_NEXT_BIT
 	bool
 	default y
 
+config GENERIC_GPIO
+	bool
+
 config ARCH_NO_VIRT_TO_BUS
 	def_bool PPC64
 
diff --git a/arch/powerpc/kernel/prom_parse.c b/arch/powerpc/kernel/prom_parse.c
index 90eb3a3..9875598 100644
--- a/arch/powerpc/kernel/prom_parse.c
+++ b/arch/powerpc/kernel/prom_parse.c
@@ -7,6 +7,7 @@
 #include <linux/ioport.h>
 #include <linux/etherdevice.h>
 #include <asm/prom.h>
+#include <asm/gpio.h>
 #include <asm/pci-bridge.h>
 
 #ifdef DEBUG
@@ -1079,3 +1080,66 @@ void __iomem *of_iomap(struct device_node *np, int index)
 	return ioremap(res.start, 1 + res.end - res.start);
 }
 EXPORT_SYMBOL(of_iomap);
+
+int __of_parse_gpio_bank_pin(struct device_node *np, int index,
+			     int bank_width, int max_bank)
+{
+	int bank;
+	int pin;
+	const u32 *gpios;
+
+	/*
+	 * We can get there only if of_get_gpio() succeeded, thus
+	 * no need checking for "gpios" existence.
+	 */
+	gpios = of_get_property(np, "gpios", NULL);
+	bank = gpios[index * 2];
+	pin = gpios[index * 2 + 1];
+
+	if (bank >= max_bank || pin >= bank_width)
+		return -EINVAL;
+
+	return bank * bank_width + pin;
+}
+EXPORT_SYMBOL_GPL(__of_parse_gpio_bank_pin);
+
+int of_get_gpio(struct device_node *np, int index)
+{
+	int ret = -EINVAL;
+	const phandle *gc_ph;
+	struct device_node *gc;
+	struct of_gpio_chip *of_gpio_chip;
+	int size;
+	const u32 *gpio_cells;
+	const u32 *gpios;
+	u32 nr_cells;
+
+	gc_ph = of_get_property(np, "gpio-parent", NULL);
+	if (!gc_ph)
+		return ret;
+
+	gc = of_find_node_by_phandle(*gc_ph);
+	if (!gc || !gc->data)
+		return ret;
+
+	gpio_cells = of_get_property(gc, "#gpio-cells", &size);
+	if (!gpio_cells || size != sizeof(*gpio_cells) || *gpio_cells == 0)
+		goto err;
+
+	gpios = of_get_property(np, "gpios", &size);
+	if (!gpios)
+		goto err;
+	nr_cells = size / sizeof(u32);
+
+	if (nr_cells < *gpio_cells || nr_cells % *gpio_cells ||
+			index > nr_cells / *gpio_cells - 1)
+		goto err;
+
+	of_gpio_chip = gc->data;
+
+	ret = of_gpio_chip->xlate(np, index);
+err:
+	of_node_put(gc);
+	return ret;
+}
+EXPORT_SYMBOL(of_get_gpio);
diff --git a/include/asm-powerpc/gpio.h b/include/asm-powerpc/gpio.h
new file mode 100644
index 0000000..e0a4f85
--- /dev/null
+++ b/include/asm-powerpc/gpio.h
@@ -0,0 +1,47 @@
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
+extern int gpio_request(unsigned int gpio, const char *label);
+static inline void gpio_free(unsigned int gpio) {}
+
+extern int gpio_direction_input(unsigned int gpio);
+extern int gpio_direction_output(unsigned int gpio, int value);
+
+extern int gpio_get_value(unsigned int gpio);
+extern int gpio_set_value(unsigned int gpio, int value);
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
+ * OF specific gpio_chip handler.
+ */
+struct of_gpio_chip {
+	int (*xlate)(struct device_node *np, int index);
+};
+
+#include <asm-generic/gpio.h>
+
+#endif /* __ASM_POWERPC_GPIO_H */
diff --git a/include/asm-powerpc/prom.h b/include/asm-powerpc/prom.h
index 78b7b0d..f882efc 100644
--- a/include/asm-powerpc/prom.h
+++ b/include/asm-powerpc/prom.h
@@ -330,6 +330,29 @@ extern int of_irq_to_resource(struct device_node *dev, int index,
  */
 extern void __iomem *of_iomap(struct device_node *device, int index);
 
+/**
+ * __of_parse_gpio_bank_pin - Helper function to translate "bank pin" GPIOs
+ * @np:		device node to get GPIO from
+ * @index:	index of the GPIO
+ * @bank_width:	pins per bank
+ * @max_bank:	maximum value to represent a bank
+ *
+ * Returns GPIO number to use with Linux generic GPIO api, or
+ * one of the errno value on the error condition.
+ */
+extern int __of_parse_gpio_bank_pin(struct device_node *np, int index,
+				    int bank_width, int max_bank);
+
+/**
+ * of_get_gpio - Translate GPIO number given in the device tree
+ * @np:		device node to get GPIO from
+ * @index:	index of the GPIO
+ *
+ * Returns GPIO number to use with Linux generic GPIO API, or
+ * one of the errno value on the error condition.
+ */
+extern int of_get_gpio(struct device_node *np, int index);
+
 /*
  * NB:  This is here while we transition from using asm/prom.h
  * to linux/of.h
-- 
1.5.2.2

Return-Path: <sfalco@harris.com>
Received: from mlbe2k2.cs.myharris.net (mlbe2k2.cs.myharris.net
	[137.237.90.89]) by ozlabs.org (Postfix) with ESMTP id C415DDE1FF
	for <linuxppc-dev@ozlabs.org>; Tue, 14 Oct 2008 03:04:14 +1100 (EST)
Message-ID: <48F37179.2090903@harris.com>
Date: Mon, 13 Oct 2008 12:04:09 -0400
From: "Steven A. Falco" <sfalco@harris.com>
MIME-Version: 1.0
To: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
Subject: [PATCH v7] ppc4xx gpio driver
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This patch adds support for the GPIO functions of PPC40x and PPC44x
SOCs.

Signed-off-by: Steve Falco <sfalco@harris.com>
Acked-by: Stefan Roese <sr@denx.de>
Acked-by: Sean MacLennan <smaclennan@pikatech.com>
---
I believe I've satisfied all the comments that have been made for this
driver.

Josh - is there anything else you'd like to see before pulling this into
your tree?


Changes from the previous version:

1) Removed !! from the input routine.  A separate patch for sysfs gpio
export to sanitize its input has been posted.

2) Used the clr/set macros to improve readability.

3) Changed the device from amcc to ibm.

diff --git a/arch/powerpc/platforms/40x/Kconfig b/arch/powerpc/platforms/40x/Kconfig
index a9260e2..aaada72 100644
--- a/arch/powerpc/platforms/40x/Kconfig
+++ b/arch/powerpc/platforms/40x/Kconfig
@@ -139,6 +139,14 @@ config STB03xxx
 	select IBM405_ERR77
 	select IBM405_ERR51
 
+config PPC4xx_GPIO
+	bool "PPC4xx GPIO support"
+	depends on 40x
+	select ARCH_REQUIRE_GPIOLIB
+	select GENERIC_GPIO
+	help
+	  Enable gpiolib support for ppc40x based boards
+
 # 40x errata/workaround config symbols, selected by the CPU models above
 
 # All 405-based cores up until the 405GPR and 405EP have this errata.
diff --git a/arch/powerpc/platforms/44x/Kconfig b/arch/powerpc/platforms/44x/Kconfig
index 249ba01..eec5cb4 100644
--- a/arch/powerpc/platforms/44x/Kconfig
+++ b/arch/powerpc/platforms/44x/Kconfig
@@ -127,6 +143,14 @@ config XILINX_VIRTEX440_GENERIC_BOARD
 	  Most Virtex 5 designs should use this unless it needs to do some
 	  special configuration at board probe time.
 
+config PPC4xx_GPIO
+	bool "PPC4xx GPIO support"
+	depends on 44x
+	select ARCH_REQUIRE_GPIOLIB
+	select GENERIC_GPIO
+	help
+	  Enable gpiolib support for ppc440 based boards
+
 # 44x specific CPU modules, selected based on the board above.
 config 440EP
 	bool
diff --git a/arch/powerpc/sysdev/Makefile b/arch/powerpc/sysdev/Makefile
index a90054b..35d5765 100644
--- a/arch/powerpc/sysdev/Makefile
+++ b/arch/powerpc/sysdev/Makefile
@@ -35,6 +35,7 @@ obj-$(CONFIG_OF_RTC)		+= of_rtc.o
 ifeq ($(CONFIG_PCI),y)
 obj-$(CONFIG_4xx)		+= ppc4xx_pci.o
 endif
+obj-$(CONFIG_PPC4xx_GPIO)	+= ppc4xx_gpio.o
 
 # Temporary hack until we have migrated to asm-powerpc
 ifeq ($(ARCH),powerpc)
diff --git a/arch/powerpc/sysdev/ppc4xx_gpio.c b/arch/powerpc/sysdev/ppc4xx_gpio.c
new file mode 100644
index 0000000..110efe2
--- /dev/null
+++ b/arch/powerpc/sysdev/ppc4xx_gpio.c
@@ -0,0 +1,217 @@
+/*
+ * PPC4xx gpio driver
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
+#define GPIO_MASK(gpio)		(0x80000000 >> (gpio))
+#define GPIO_MASK2(gpio)	(0xc0000000 >> ((gpio) * 2))
+
+/* Physical GPIO register layout */
+struct ppc4xx_gpio {
+	__be32 or;
+	__be32 tcr;
+	__be32 osrl;
+	__be32 osrh;
+	__be32 tsrl;
+	__be32 tsrh;
+	__be32 odr;
+	__be32 ir;
+	__be32 rr1;
+	__be32 rr2;
+	__be32 rr3;
+	__be32 reserved1;
+	__be32 isr1l;
+	__be32 isr1h;
+	__be32 isr2l;
+	__be32 isr2h;
+	__be32 isr3l;
+	__be32 isr3h;
+};
+
+struct ppc4xx_gpio_chip {
+	struct of_mm_gpio_chip mm_gc;
+	spinlock_t lock;
+};
+
+/*
+ * GPIO LIB API implementation for GPIOs
+ *
+ * There are a maximum of 32 gpios in each gpio controller.
+ */
+
+static inline struct ppc4xx_gpio_chip *
+to_ppc4xx_gpiochip(struct of_mm_gpio_chip *mm_gc)
+{
+	return container_of(mm_gc, struct ppc4xx_gpio_chip, mm_gc);
+}
+
+static int ppc4xx_gpio_get(struct gpio_chip *gc, unsigned int gpio)
+{
+	struct of_mm_gpio_chip *mm_gc = to_of_mm_gpio_chip(gc);
+	struct ppc4xx_gpio __iomem *regs = mm_gc->regs;
+
+	return in_be32(&regs->ir) & GPIO_MASK(gpio);
+}
+
+static inline void
+__ppc4xx_gpio_set(struct gpio_chip *gc, unsigned int gpio, int val)
+{
+	struct of_mm_gpio_chip *mm_gc = to_of_mm_gpio_chip(gc);
+	struct ppc4xx_gpio __iomem *regs = mm_gc->regs;
+
+	if (val)
+		setbits32(&regs->or, GPIO_MASK(gpio));
+	else
+		clrbits32(&regs->or, GPIO_MASK(gpio));
+}
+
+static void
+ppc4xx_gpio_set(struct gpio_chip *gc, unsigned int gpio, int val)
+{
+	struct of_mm_gpio_chip *mm_gc = to_of_mm_gpio_chip(gc);
+	struct ppc4xx_gpio_chip *chip = to_ppc4xx_gpiochip(mm_gc);
+	unsigned long flags;
+
+	spin_lock_irqsave(&chip->lock, flags);
+
+	__ppc4xx_gpio_set(gc, gpio, val);
+
+	spin_unlock_irqrestore(&chip->lock, flags);
+
+	pr_debug("%s: gpio: %d val: %d\n", __func__, gpio, val);
+}
+
+static int ppc4xx_gpio_dir_in(struct gpio_chip *gc, unsigned int gpio)
+{
+	struct of_mm_gpio_chip *mm_gc = to_of_mm_gpio_chip(gc);
+	struct ppc4xx_gpio_chip *chip = to_ppc4xx_gpiochip(mm_gc);
+	struct ppc4xx_gpio __iomem *regs = mm_gc->regs;
+	unsigned long flags;
+
+	spin_lock_irqsave(&chip->lock, flags);
+
+	/* Disable open-drain function */
+	clrbits32(&regs->odr, GPIO_MASK(gpio));
+
+	/* Float the pin */
+	clrbits32(&regs->tcr, GPIO_MASK(gpio));
+
+	/* Bits 0-15 use TSRL/OSRL, bits 16-31 use TSRH/OSRH */
+	if (gpio < 16) {
+		clrbits32(&regs->osrl, GPIO_MASK2(gpio));
+		clrbits32(&regs->tsrl, GPIO_MASK2(gpio));
+	} else {
+		clrbits32(&regs->osrh, GPIO_MASK2(gpio));
+		clrbits32(&regs->tsrh, GPIO_MASK2(gpio));
+	}
+
+	spin_unlock_irqrestore(&chip->lock, flags);
+
+	return 0;
+}
+
+static int
+ppc4xx_gpio_dir_out(struct gpio_chip *gc, unsigned int gpio, int val)
+{
+	struct of_mm_gpio_chip *mm_gc = to_of_mm_gpio_chip(gc);
+	struct ppc4xx_gpio_chip *chip = to_ppc4xx_gpiochip(mm_gc);
+	struct ppc4xx_gpio __iomem *regs = mm_gc->regs;
+	unsigned long flags;
+
+	spin_lock_irqsave(&chip->lock, flags);
+
+	/* First set initial value */
+	__ppc4xx_gpio_set(gc, gpio, val);
+
+	/* Disable open-drain function */
+	clrbits32(&regs->odr, GPIO_MASK(gpio));
+
+	/* Drive the pin */
+	setbits32(&regs->tcr, GPIO_MASK(gpio));
+
+	/* Bits 0-15 use TSRL, bits 16-31 use TSRH */
+	if (gpio < 16) {
+		clrbits32(&regs->osrl, GPIO_MASK2(gpio));
+		clrbits32(&regs->tsrl, GPIO_MASK2(gpio));
+	} else {
+		clrbits32(&regs->osrh, GPIO_MASK2(gpio));
+		clrbits32(&regs->tsrh, GPIO_MASK2(gpio));
+	}
+
+	spin_unlock_irqrestore(&chip->lock, flags);
+
+	pr_debug("%s: gpio: %d val: %d\n", __func__, gpio, val);
+
+	return 0;
+}
+
+static int __init ppc4xx_add_gpiochips(void)
+{
+	struct device_node *np;
+
+	for_each_compatible_node(np, NULL, "ibm,ppc4xx-gpio") {
+		int ret;
+		struct ppc4xx_gpio_chip *ppc4xx_gc;
+		struct of_mm_gpio_chip *mm_gc;
+		struct of_gpio_chip *of_gc;
+		struct gpio_chip *gc;
+
+		ppc4xx_gc = kzalloc(sizeof(*ppc4xx_gc), GFP_KERNEL);
+		if (!ppc4xx_gc) {
+			ret = -ENOMEM;
+			goto err;
+		}
+
+		spin_lock_init(&ppc4xx_gc->lock);
+
+		mm_gc = &ppc4xx_gc->mm_gc;
+		of_gc = &mm_gc->of_gc;
+		gc = &of_gc->gc;
+
+		of_gc->gpio_cells = 2;
+		gc->ngpio = 32;
+		gc->direction_input = ppc4xx_gpio_dir_in;
+		gc->direction_output = ppc4xx_gpio_dir_out;
+		gc->get = ppc4xx_gpio_get;
+		gc->set = ppc4xx_gpio_set;
+
+		ret = of_mm_gpiochip_add(np, mm_gc);
+		if (ret)
+			goto err;
+		continue;
+err:
+		pr_err("%s: registration failed with status %d\n",
+		       np->full_name, ret);
+		kfree(ppc4xx_gc);
+		/* try others anyway */
+	}
+	return 0;
+}
+arch_initcall(ppc4xx_add_gpiochips);

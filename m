Return-Path: <jacmet@gmail.com>
Received: from fg-out-1718.google.com (fg-out-1718.google.com [72.14.220.152])
	by ozlabs.org (Postfix) with ESMTP id 85FAFDDE08
	for <linuxppc-dev@ozlabs.org>; Mon, 22 Sep 2008 16:32:39 +1000 (EST)
Received: by fg-out-1718.google.com with SMTP id d23so1391502fga.39
	for <linuxppc-dev@ozlabs.org>; Sun, 21 Sep 2008 23:32:37 -0700 (PDT)
From: Peter Korsgaard <jacmet@sunsite.dk>
To: galak@kernel.crashing.org, avorontsov@ru.mvista.com,
	linuxppc-dev@ozlabs.org
Subject: [PATCH v3] powerpc: gpio driver for mpc8349/8572/8610 and compatible
	with OF bindings
Date: Mon, 22 Sep 2008 08:32:34 +0200
Message-Id: <1222065154-19310-1-git-send-email-jacmet@sunsite.dk>
Sender: Peter Korsgaard <jacmet@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Structured similar to the existing QE GPIO support.

Signed-off-by: Peter Korsgaard <jacmet@sunsite.dk>
---
 Changes since v2:
 - Clarified documentation as requested by Kumar.

 Changes since v1:
 Incorporated feedback from Anton and Kumar:
 - Core is also used on 8572/8610 so s/83xx/8xxx/
 - Use fsl,mpc8572-gpio / fsl,mpc8610-gpio for 85xx/86xx as compatible
 - Use shadowed data register to handle open drain outputs
 - Expandend dts binding doc, use 8347 as example instead of 8349
 - Misc small cleanups

 .../powerpc/dts-bindings/fsl/8xxx_gpio.txt         |   40 +++++
 arch/powerpc/sysdev/Kconfig                        |    9 +
 arch/powerpc/sysdev/Makefile                       |    1 +
 arch/powerpc/sysdev/mpc8xxx_gpio.c                 |  170 ++++++++++++++++++++
 4 files changed, 220 insertions(+), 0 deletions(-)
 create mode 100644 Documentation/powerpc/dts-bindings/fsl/8xxx_gpio.txt
 create mode 100644 arch/powerpc/sysdev/mpc8xxx_gpio.c

diff --git a/Documentation/powerpc/dts-bindings/fsl/8xxx_gpio.txt b/Documentation/powerpc/dts-bindings/fsl/8xxx_gpio.txt
new file mode 100644
index 0000000..26c29c4
--- /dev/null
+++ b/Documentation/powerpc/dts-bindings/fsl/8xxx_gpio.txt
@@ -0,0 +1,40 @@
+GPIO controllers on MPC8xxx SoCs
+
+This is for the non-QE/CPM/GUTs GPIO controllers as found on
+8349, 8572, 8610 and compatible.
+
+Every GPIO controller node must have #gpio-cells property defined,
+this information will be used to translate gpio-specifiers.
+
+Required properties:
+- compatible : "fsl,<CHIP>-gpio" followed by "fsl,mpc8349-gpio" for
+  83xx, "fsl,mpc8572-gpio" for 85xx and "fsl,mpc8610-gpio" for 86xx.
+- #gpio-cells : Should be two. The first cell is the pin number and the
+  second cell is used to specify optional parameters (currently unused).
+ - interrupts : Interrupt mapping for GPIO IRQ (currently unused).
+ - interrupt-parent : Phandle for the interrupt controller that
+   services interrupts for this device.
+- gpio-controller : Marks the port as GPIO controller.
+
+Example of gpio-controller nodes for a MPC8347 SoC:
+
+	gpio1: gpio-controller@c00 {
+		#gpio-cells = <2>;
+		compatible = "fsl,mpc8347-gpio, fsl,mpc8349-gpio";
+		reg = <0xc00 0x100>;
+		interrupts = <74 0x8>;
+		interrupt-parent = <&ipic>;
+		gpio-controller;
+	};
+
+	gpio2: gpio-controller@d00 {
+		#gpio-cells = <2>;
+		compatible = "fsl,mpc8347-gpio, fsl,mpc8349-gpio";
+		reg = <0xd00 0x100>;
+		interrupts = <75 0x8>;
+		interrupt-parent = <&ipic>;
+		gpio-controller;
+	};
+
+See booting-without-of.txt for details of how to specify GPIO
+information for devices.
diff --git a/arch/powerpc/sysdev/Kconfig b/arch/powerpc/sysdev/Kconfig
index 72fb35b..a11cc8f 100644
--- a/arch/powerpc/sysdev/Kconfig
+++ b/arch/powerpc/sysdev/Kconfig
@@ -6,3 +6,12 @@ config PPC4xx_PCI_EXPRESS
 	bool
 	depends on PCI && 4xx
 	default n
+
+config MPC8xxx_GPIO
+	bool "MPC8xxx GPIO support"
+	depends on PPC_MPC831x || PPC_MPC834x || PPC_MPC837x || PPC_85xx || PPC_86xx
+	select GENERIC_GPIO
+	select ARCH_REQUIRE_GPIOLIB
+	help
+	  Say Y here if you're going to use hardware that connects to the
+	  MPC831x/834x/837x/8572/8610 GPIOs.
diff --git a/arch/powerpc/sysdev/Makefile b/arch/powerpc/sysdev/Makefile
index a90054b..e410764 100644
--- a/arch/powerpc/sysdev/Makefile
+++ b/arch/powerpc/sysdev/Makefile
@@ -15,6 +15,7 @@ obj-$(CONFIG_FSL_SOC)		+= fsl_soc.o
 obj-$(CONFIG_FSL_PCI)		+= fsl_pci.o $(fsl-msi-obj-y)
 obj-$(CONFIG_FSL_LBC)		+= fsl_lbc.o
 obj-$(CONFIG_FSL_GTM)		+= fsl_gtm.o
+obj-$(CONFIG_MPC8xxx_GPIO)	+= mpc8xxx_gpio.o
 obj-$(CONFIG_RAPIDIO)		+= fsl_rio.o
 obj-$(CONFIG_TSI108_BRIDGE)	+= tsi108_pci.o tsi108_dev.o
 obj-$(CONFIG_QUICC_ENGINE)	+= qe_lib/
diff --git a/arch/powerpc/sysdev/mpc8xxx_gpio.c b/arch/powerpc/sysdev/mpc8xxx_gpio.c
new file mode 100644
index 0000000..3c1f608
--- /dev/null
+++ b/arch/powerpc/sysdev/mpc8xxx_gpio.c
@@ -0,0 +1,170 @@
+/*
+ * GPIOs on MPC8349/8572/8610 and compatible
+ *
+ * Copyright (C) 2008 Peter Korsgaard <jacmet@sunsite.dk>
+ *
+ * This file is licensed under the terms of the GNU General Public License
+ * version 2.  This program is licensed "as is" without any warranty of any
+ * kind, whether express or implied.
+ */
+
+#include <linux/kernel.h>
+#include <linux/init.h>
+#include <linux/spinlock.h>
+#include <linux/io.h>
+#include <linux/of.h>
+#include <linux/of_gpio.h>
+#include <linux/gpio.h>
+
+#define MPC8XXX_GPIO_PINS	32
+
+#define GPIO_DIR		0x00
+#define GPIO_ODR		0x04
+#define GPIO_DAT		0x08
+#define GPIO_IER		0x0c
+#define GPIO_IMR		0x10
+#define GPIO_ICR		0x14
+
+struct mpc8xxx_gpio_chip {
+	struct of_mm_gpio_chip mm_gc;
+	spinlock_t lock;
+
+	/* shadowed data register to be able to clear/set output pins in
+	   open drain mode safely */
+	u32 data;
+};
+
+static inline u32 mpc8xxx_gpio2mask(unsigned int gpio)
+{
+	return 1u << (MPC8XXX_GPIO_PINS - 1 - gpio);
+}
+
+static inline struct mpc8xxx_gpio_chip *
+to_mpc8xxx_gpio_chip(struct of_mm_gpio_chip *mm)
+{
+	return container_of(mm, struct mpc8xxx_gpio_chip, mm_gc);
+}
+
+static void mpc8xxx_gpio_save_regs(struct of_mm_gpio_chip *mm)
+{
+	struct mpc8xxx_gpio_chip *mpc8xxx_gc = to_mpc8xxx_gpio_chip(mm);
+
+	mpc8xxx_gc->data = in_be32(mm->regs + GPIO_DAT);
+}
+
+static int mpc8xxx_gpio_get(struct gpio_chip *gc, unsigned int gpio)
+{
+	struct of_mm_gpio_chip *mm = to_of_mm_gpio_chip(gc);
+
+	return !!(in_be32(mm->regs + GPIO_DAT) & mpc8xxx_gpio2mask(gpio));
+}
+
+static void mpc8xxx_gpio_set(struct gpio_chip *gc, unsigned int gpio, int val)
+{
+	struct of_mm_gpio_chip *mm = to_of_mm_gpio_chip(gc);
+	struct mpc8xxx_gpio_chip *mpc8xxx_gc = to_mpc8xxx_gpio_chip(mm);
+	unsigned long flags;
+
+	spin_lock_irqsave(&mpc8xxx_gc->lock, flags);
+
+	if (val)
+		mpc8xxx_gc->data |= mpc8xxx_gpio2mask(gpio);
+	else
+		mpc8xxx_gc->data &= ~mpc8xxx_gpio2mask(gpio);
+
+	out_be32(mm->regs + GPIO_DAT, mpc8xxx_gc->data);
+
+	spin_unlock_irqrestore(&mpc8xxx_gc->lock, flags);
+}
+
+static int mpc8xxx_gpio_dir_in(struct gpio_chip *gc, unsigned int gpio)
+{
+	struct of_mm_gpio_chip *mm = to_of_mm_gpio_chip(gc);
+	struct mpc8xxx_gpio_chip *mpc8xxx_gc = to_mpc8xxx_gpio_chip(mm);
+	unsigned long flags;
+
+	spin_lock_irqsave(&mpc8xxx_gc->lock, flags);
+
+	out_be32(mm->regs + GPIO_DIR,
+		 in_be32(mm->regs + GPIO_DIR) & ~mpc8xxx_gpio2mask(gpio));
+
+	spin_unlock_irqrestore(&mpc8xxx_gc->lock, flags);
+
+	return 0;
+}
+
+static int mpc8xxx_gpio_dir_out(struct gpio_chip *gc, unsigned int gpio, int val)
+{
+	struct of_mm_gpio_chip *mm = to_of_mm_gpio_chip(gc);
+	struct mpc8xxx_gpio_chip *mpc8xxx_gc = to_mpc8xxx_gpio_chip(mm);
+	unsigned long flags;
+
+	mpc8xxx_gpio_set(gc, gpio, val);
+
+	spin_lock_irqsave(&mpc8xxx_gc->lock, flags);
+	out_be32(mm->regs + GPIO_DIR,
+		 in_be32(mm->regs + GPIO_DIR) | mpc8xxx_gpio2mask(gpio));
+
+	spin_unlock_irqrestore(&mpc8xxx_gc->lock, flags);
+
+	return 0;
+}
+
+static int __init mpc8xxx_add_controller(struct device_node *np)
+{
+	struct mpc8xxx_gpio_chip *mpc8xxx_gc;
+	struct of_mm_gpio_chip *mm_gc;
+	struct of_gpio_chip *of_gc;
+	struct gpio_chip *gc;
+	int ret;
+
+	mpc8xxx_gc = kzalloc(sizeof(*mpc8xxx_gc), GFP_KERNEL);
+	if (!mpc8xxx_gc) {
+		ret = -ENOMEM;
+		goto err;
+	}
+
+	spin_lock_init(&mpc8xxx_gc->lock);
+
+	mm_gc = &mpc8xxx_gc->mm_gc;
+	of_gc = &mm_gc->of_gc;
+	gc = &of_gc->gc;
+
+	mm_gc->save_regs = mpc8xxx_gpio_save_regs;
+	of_gc->gpio_cells = 2;
+	gc->ngpio = MPC8XXX_GPIO_PINS;
+	gc->direction_input = mpc8xxx_gpio_dir_in;
+	gc->direction_output = mpc8xxx_gpio_dir_out;
+	gc->get = mpc8xxx_gpio_get;
+	gc->set = mpc8xxx_gpio_set;
+
+	ret = of_mm_gpiochip_add(np, mm_gc);
+	if (ret)
+		goto err;
+
+	return 0;
+
+err:
+	pr_err("%s: registration failed with status %d\n",
+	       np->full_name, ret);
+	kfree(mpc8xxx_gc);
+
+	return ret;
+}
+
+static int __init mpc8xxx_add_gpiochips(void)
+{
+	struct device_node *np;
+
+	for_each_compatible_node(np, NULL, "fsl,mpc8349-gpio")
+		mpc8xxx_add_controller(np);
+
+	for_each_compatible_node(np, NULL, "fsl,mpc8572-gpio")
+		mpc8xxx_add_controller(np);
+
+	for_each_compatible_node(np, NULL, "fsl,mpc8610-gpio")
+		mpc8xxx_add_controller(np);
+
+	return 0;
+}
+arch_initcall(mpc8xxx_add_gpiochips);
-- 
1.5.6.3

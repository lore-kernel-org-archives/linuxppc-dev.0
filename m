Return-Path: <avorontsov@dev.rtsoft.ru>
Received: from mail.dev.rtsoft.ru (unknown [85.21.88.2])
	by ozlabs.org (Postfix) with SMTP id C761EDE3FA
	for <linuxppc-dev@ozlabs.org>; Sat, 26 Apr 2008 03:01:20 +1000 (EST)
Date: Fri, 25 Apr 2008 21:01:19 +0400
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: [PATCH 4/6] [POWERPC] QE: implement support for the GPIO LIB API
Message-ID: <20080425170119.GD12154@polina.dev.rtsoft.ru>
References: <20080425170014.GA11669@polina.dev.rtsoft.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf8
In-Reply-To: <20080425170014.GA11669@polina.dev.rtsoft.ru>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This is needed to access QE GPIOs via Linux GPIO API.

Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
---
 Documentation/powerpc/booting-without-of.txt |   37 ++++---
 arch/powerpc/sysdev/qe_lib/Kconfig           |    8 ++
 arch/powerpc/sysdev/qe_lib/Makefile          |    1 +
 arch/powerpc/sysdev/qe_lib/gpio.c            |  145 ++++++++++++++++++++++++++
 include/asm-powerpc/qe.h                     |    1 +
 5 files changed, 179 insertions(+), 13 deletions(-)
 create mode 100644 arch/powerpc/sysdev/qe_lib/gpio.c

diff --git a/Documentation/powerpc/booting-without-of.txt b/Documentation/powerpc/booting-without-of.txt
index 0f3738e..098f456 100644
--- a/Documentation/powerpc/booting-without-of.txt
+++ b/Documentation/powerpc/booting-without-of.txt
@@ -1721,24 +1721,35 @@ platforms are moved over to use the flattened-device-tree model.
    information.
 
    Required properties:
-   - device_type : should be "par_io".
+   - #gpio-cells : should be "2".
+   - compatible : should be "fsl,<chip>-qe-pario-bank",
+     "fsl,mpc8323-qe-pario-bank".
    - reg : offset to the register set and its length.
-   - num-ports : number of Parallel I/O ports
+   - gpio-controller : node to identify gpio controllers.
 
-   Example:
-	par_io@1400 {
-		reg = <1400 100>;
-		#address-cells = <1>;
-		#size-cells = <0>;
-		device_type = "par_io";
-		num-ports = <7>;
-		ucc_pin@01 {
-			......
-		};
+   For example, two QE Par I/O banks:
+	qe_pio_a: gpio-controller@1400 {
+		#gpio-cells = <2>;
+		compatible = "fsl,mpc8360-qe-pario-bank",
+			     "fsl,mpc8323-qe-pario-bank";
+		reg = <0x1400 0x18>;
+		gpio-controller;
+	};
 
+	qe_pio_e: gpio-controller@1460 {
+		#gpio-cells = <2>;
+		compatible = "fsl,mpc8360-qe-pario-bank",
+			     "fsl,mpc8323-qe-pario-bank";
+		reg = <0x1460 0x18>;
+		gpio-controller;
+	};
 
    vi) Pin configuration nodes
 
+   NOTE: pin configuration nodes are obsolete. Usually, their existance
+         is an evidence of the firmware shortcomings. Such fixups are
+         better handled by the Linux board file, not the device tree.
+
    Required properties:
    - linux,phandle : phandle of this node; likely referenced by a QE
      device.
diff --git a/arch/powerpc/sysdev/qe_lib/Kconfig b/arch/powerpc/sysdev/qe_lib/Kconfig
index 76ffbc4..4872fbb 100644
--- a/arch/powerpc/sysdev/qe_lib/Kconfig
+++ b/arch/powerpc/sysdev/qe_lib/Kconfig
@@ -24,3 +24,11 @@ config QE_USB
 	bool
 	help
 	  QE USB Host Controller support
+
+config QE_GPIO
+	bool "QE GPIO support"
+	select GENERIC_GPIO
+	select HAVE_GPIO_LIB
+	help
+	  Say Y here if you're going to use hardware that connects to the
+	  QE GPIOs.
diff --git a/arch/powerpc/sysdev/qe_lib/Makefile b/arch/powerpc/sysdev/qe_lib/Makefile
index e9ff888..f1855c1 100644
--- a/arch/powerpc/sysdev/qe_lib/Makefile
+++ b/arch/powerpc/sysdev/qe_lib/Makefile
@@ -7,3 +7,4 @@ obj-$(CONFIG_UCC)	+= ucc.o
 obj-$(CONFIG_UCC_SLOW)	+= ucc_slow.o
 obj-$(CONFIG_UCC_FAST)	+= ucc_fast.o
 obj-$(CONFIG_QE_USB)	+= usb.o
+obj-$(CONFIG_QE_GPIO)	+= gpio.o
diff --git a/arch/powerpc/sysdev/qe_lib/gpio.c b/arch/powerpc/sysdev/qe_lib/gpio.c
new file mode 100644
index 0000000..ae9edea
--- /dev/null
+++ b/arch/powerpc/sysdev/qe_lib/gpio.c
@@ -0,0 +1,145 @@
+/*
+ * QUICC Engine GPIOs
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
+#include <asm/qe.h>
+
+struct qe_gpio_chip {
+	struct of_mm_gpio_chip mm_gc;
+	spinlock_t lock;
+
+	/* shadowed data register to clear/set bits safely */
+	u32 cpdata;
+};
+
+static inline struct qe_gpio_chip *
+to_qe_gpio_chip(struct of_mm_gpio_chip *mm_gc)
+{
+	return container_of(mm_gc, struct qe_gpio_chip, mm_gc);
+}
+
+static void qe_gpio_save_regs(struct of_mm_gpio_chip *mm_gc)
+{
+	struct qe_gpio_chip *qe_gc = to_qe_gpio_chip(mm_gc);
+	struct qe_pio_regs __iomem *regs = mm_gc->regs;
+
+	qe_gc->cpdata = in_be32(&regs->cpdata);
+}
+
+static int qe_gpio_get(struct gpio_chip *gc, unsigned int gpio)
+{
+	struct of_mm_gpio_chip *mm_gc = to_of_mm_gpio_chip(gc);
+	struct qe_pio_regs __iomem *regs = mm_gc->regs;
+	u32 pin_mask = 1 << (QE_PIO_PINS - 1 - gpio);
+
+	return !!(in_be32(&regs->cpdata) & pin_mask);
+}
+
+static void qe_gpio_set(struct gpio_chip *gc, unsigned int gpio, int val)
+{
+	struct of_mm_gpio_chip *mm_gc = to_of_mm_gpio_chip(gc);
+	struct qe_gpio_chip *qe_gc = to_qe_gpio_chip(mm_gc);
+	struct qe_pio_regs __iomem *regs = mm_gc->regs;
+	unsigned long flags;
+	u32 pin_mask = 1 << (QE_PIO_PINS - 1 - gpio);
+
+	spin_lock_irqsave(&qe_gc->lock, flags);
+
+	if (val)
+		qe_gc->cpdata |= pin_mask;
+	else
+		qe_gc->cpdata &= ~pin_mask;
+
+	out_be32(&regs->cpdata, qe_gc->cpdata);
+
+	spin_unlock_irqrestore(&qe_gc->lock, flags);
+}
+
+static int qe_gpio_dir_in(struct gpio_chip *gc, unsigned int gpio)
+{
+	struct of_mm_gpio_chip *mm_gc = to_of_mm_gpio_chip(gc);
+	struct qe_gpio_chip *qe_gc = to_qe_gpio_chip(mm_gc);
+	unsigned long flags;
+
+	spin_lock_irqsave(&qe_gc->lock, flags);
+
+	__par_io_config_pin(mm_gc->regs, gpio, 2, 0, 0, 0);
+
+	spin_unlock_irqrestore(&qe_gc->lock, flags);
+
+	return 0;
+}
+
+static int qe_gpio_dir_out(struct gpio_chip *gc, unsigned int gpio, int val)
+{
+	struct of_mm_gpio_chip *mm_gc = to_of_mm_gpio_chip(gc);
+	struct qe_gpio_chip *qe_gc = to_qe_gpio_chip(mm_gc);
+	unsigned long flags;
+
+	spin_lock_irqsave(&qe_gc->lock, flags);
+
+	__par_io_config_pin(mm_gc->regs, gpio, 1, 0, 0, 0);
+
+	spin_unlock_irqrestore(&qe_gc->lock, flags);
+
+	qe_gpio_set(gc, gpio, val);
+
+	return 0;
+}
+
+void __init qe_add_gpiochips(void)
+{
+	int ret;
+	struct device_node *np;
+
+	for_each_compatible_node(np, NULL, "fsl,mpc8323-qe-pario-bank") {
+		struct qe_gpio_chip *qe_gc;
+		struct of_mm_gpio_chip *mm_gc;
+		struct of_gpio_chip *of_gc;
+		struct gpio_chip *gc;
+
+		qe_gc = kzalloc(sizeof(*qe_gc), GFP_KERNEL);
+		if (!qe_gc) {
+			ret = -ENOMEM;
+			goto err;
+		}
+
+		spin_lock_init(&qe_gc->lock);
+
+		mm_gc = &qe_gc->mm_gc;
+		of_gc = &mm_gc->of_gc;
+		gc = &of_gc->gc;
+
+		mm_gc->save_regs = qe_gpio_save_regs;
+		of_gc->gpio_cells = 2;
+		gc->ngpio = QE_PIO_PINS;
+		gc->direction_input = qe_gpio_dir_in;
+		gc->direction_output = qe_gpio_dir_out;
+		gc->get = qe_gpio_get;
+		gc->set = qe_gpio_set;
+
+		ret = of_mm_gpiochip_add(np, mm_gc);
+		if (ret)
+			goto err;
+	}
+
+	return;
+err:
+	pr_err("%s: registration failed with status %d\n", np->full_name, ret);
+	of_node_put(np);
+}
diff --git a/include/asm-powerpc/qe.h b/include/asm-powerpc/qe.h
index c4523ac..42ff6dd 100644
--- a/include/asm-powerpc/qe.h
+++ b/include/asm-powerpc/qe.h
@@ -100,6 +100,7 @@ struct qe_pio_regs {
 #endif
 };
 
+extern void __init qe_add_gpiochips(void);
 extern int par_io_init(struct device_node *np);
 extern int par_io_of_config(struct device_node *np);
 extern void __par_io_config_pin(struct qe_pio_regs __iomem *par_io, u8 pin,
-- 
1.5.5.1

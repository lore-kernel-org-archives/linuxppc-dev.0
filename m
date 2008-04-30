Return-Path: <avorontsov@dev.rtsoft.ru>
Received: from mail.dev.rtsoft.ru (unknown [85.21.88.2])
	by ozlabs.org (Postfix) with SMTP id C9358DDF21
	for <linuxppc-dev@ozlabs.org>; Thu,  1 May 2008 05:30:43 +1000 (EST)
Date: Wed, 30 Apr 2008 23:30:40 +0400
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: [PATCH v2 4/6] [POWERPC] QE: implement support for the GPIO LIB API
Message-ID: <20080430193040.GA9239@polina.dev.rtsoft.ru>
References: <20080429185920.GA19735@polina.dev.rtsoft.ru>
	<20080429190045.GD21203@polina.dev.rtsoft.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf8
In-Reply-To: <20080429190045.GD21203@polina.dev.rtsoft.ru>
Cc: linuxppc-dev@ozlabs.org, Timur Tabi <timur@freescale.com>
Reply-To: avorontsov@ru.mvista.com
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

Updated per Timur Tabi's comments.

 Documentation/powerpc/booting-without-of.txt |   27 +++++
 arch/powerpc/sysdev/qe_lib/Kconfig           |    9 ++
 arch/powerpc/sysdev/qe_lib/Makefile          |    1 +
 arch/powerpc/sysdev/qe_lib/gpio.c            |  146 ++++++++++++++++++++++++++
 include/asm-powerpc/qe.h                     |    3 +
 5 files changed, 186 insertions(+), 0 deletions(-)
 create mode 100644 arch/powerpc/sysdev/qe_lib/gpio.c

diff --git a/Documentation/powerpc/booting-without-of.txt b/Documentation/powerpc/booting-without-of.txt
index fc7a235..c1044ee 100644
--- a/Documentation/powerpc/booting-without-of.txt
+++ b/Documentation/powerpc/booting-without-of.txt
@@ -1738,6 +1738,33 @@ platforms are moved over to use the flattened-device-tree model.
 			......
 		};
 
+   Note that "par_io" nodes are obsolete, and should not be used for
+   the new device trees. Instead, each Par I/O bank should be represented
+   via its own gpio-controller node:
+
+   Required properties:
+   - #gpio-cells : should be "2".
+   - compatible : should be "fsl,<chip>-qe-pario-bank",
+     "fsl,mpc8323-qe-pario-bank".
+   - reg : offset to the register set and its length.
+   - gpio-controller : node to identify gpio controllers.
+
+   Example:
+	qe_pio_a: gpio-controller@1400 {
+		#gpio-cells = <2>;
+		compatible = "fsl,mpc8360-qe-pario-bank",
+			     "fsl,mpc8323-qe-pario-bank";
+		reg = <0x1400 0x18>;
+		gpio-controller;
+	};
+
+	qe_pio_e: gpio-controller@1460 {
+		#gpio-cells = <2>;
+		compatible = "fsl,mpc8360-qe-pario-bank",
+			     "fsl,mpc8323-qe-pario-bank";
+		reg = <0x1460 0x18>;
+		gpio-controller;
+	};
 
    vi) Pin configuration nodes
 
diff --git a/arch/powerpc/sysdev/qe_lib/Kconfig b/arch/powerpc/sysdev/qe_lib/Kconfig
index 76ffbc4..4bb18f5 100644
--- a/arch/powerpc/sysdev/qe_lib/Kconfig
+++ b/arch/powerpc/sysdev/qe_lib/Kconfig
@@ -24,3 +24,12 @@ config QE_USB
 	bool
 	help
 	  QE USB Host Controller support
+
+config QE_GPIO
+	bool "QE GPIO support"
+	depends on QUICC_ENGINE
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
index 0000000..c712e24
--- /dev/null
+++ b/arch/powerpc/sysdev/qe_lib/gpio.c
@@ -0,0 +1,146 @@
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
+	return in_be32(&regs->cpdata) & pin_mask;
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
+	__par_io_config_pin(mm_gc->regs, gpio, QE_PIO_DIR_IN, 0, 0, 0);
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
+	__par_io_config_pin(mm_gc->regs, gpio, QE_PIO_DIR_OUT, 0, 0, 0);
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
+	struct device_node *np;
+
+	for_each_compatible_node(np, NULL, "fsl,mpc8323-qe-pario-bank") {
+		int ret;
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
+		continue;
+err:
+		pr_err("%s: registration failed with status %d\n",
+		       np->full_name, ret);
+		kfree(qe_gc);
+		/* try others anyway */
+	}
+}
diff --git a/include/asm-powerpc/qe.h b/include/asm-powerpc/qe.h
index c4523ac..01e3c70 100644
--- a/include/asm-powerpc/qe.h
+++ b/include/asm-powerpc/qe.h
@@ -100,8 +100,11 @@ struct qe_pio_regs {
 #endif
 };
 
+extern void __init qe_add_gpiochips(void);
 extern int par_io_init(struct device_node *np);
 extern int par_io_of_config(struct device_node *np);
+#define QE_PIO_DIR_IN	2
+#define QE_PIO_DIR_OUT	1
 extern void __par_io_config_pin(struct qe_pio_regs __iomem *par_io, u8 pin,
 				int dir, int open_drain, int assignment,
 				int has_irq);
-- 
1.5.5.1

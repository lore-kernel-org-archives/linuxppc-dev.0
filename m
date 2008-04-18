Return-Path: <avorontsov@dev.rtsoft.ru>
Received: from mail.dev.rtsoft.ru (unknown [85.21.88.2])
	by ozlabs.org (Postfix) with SMTP id A21F3DEDF0
	for <linuxppc-dev@ozlabs.org>; Sat, 19 Apr 2008 05:10:00 +1000 (EST)
Date: Fri, 18 Apr 2008 23:09:59 +0400
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: [PATCH 4/5] [POWERPC] QE: implement support for the GPIO LIB API
Message-ID: <20080418190959.GD4407@polina.dev.rtsoft.ru>
References: <20080418190632.GA32204@polina.dev.rtsoft.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=windows-1251
In-Reply-To: <20080418190632.GA32204@polina.dev.rtsoft.ru>
Cc: David Brownell <david-b@pacbell.net>, linuxppc-dev@ozlabs.org
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

On Thu, Apr 17, 2008 at 09:21:40PM -0500, Kumar Gala wrote:
>
> On Apr 17, 2008, at 5:41 PM, Anton Vorontsov wrote:
>> On Thu, Apr 17, 2008 at 05:35:53PM -0500, Kumar Gala wrote:
>>>> index a3f9c3f..a4a195a 100644
>>>> --- a/arch/powerpc/sysdev/qe_lib/qe_io.c
>>>> +++ b/arch/powerpc/sysdev/qe_lib/qe_io.c
>>>> @@ -20,7 +20,8 @@
>>>> #include <linux/errno.h>
>>>> #include <linux/module.h>
>>>> #include <linux/ioport.h>
>>>> -
>>>> +#include <linux/spinlock.h>
>>>> +#include <linux/of_gpio.h>
>>>> #include <asm/io.h>
>>>> #include <asm/qe.h>
>>>> #include <asm/prom.h>
>>>> @@ -214,6 +215,140 @@ int par_io_of_config(struct device_node *np)
>>>> }
>>>> EXPORT_SYMBOL(par_io_of_config);
>>>
>>> can we split this out into a new file since its pretty much a driver.
>>
>> No problem. Would you prefer this to go under drivers/gpio/ ?
>
>
> Yes that would be better.  We actively worked on pull drivers out of  
> arch/ppc back in the day.

Hi David,

Do we need your Ack to go this through powerpc tree, and if so, could
you provide one?

Thanks.

 Documentation/powerpc/booting-without-of.txt |   34 ++++---
 arch/powerpc/platforms/Kconfig               |    2 +
 drivers/gpio/Kconfig                         |    9 ++
 drivers/gpio/Makefile                        |    1 +
 drivers/gpio/qe.c                            |  147 ++++++++++++++++++++++++++
 5 files changed, 180 insertions(+), 13 deletions(-)
 create mode 100644 drivers/gpio/qe.c

diff --git a/Documentation/powerpc/booting-without-of.txt b/Documentation/powerpc/booting-without-of.txt
index 827b630..5c9cfab 100644
--- a/Documentation/powerpc/booting-without-of.txt
+++ b/Documentation/powerpc/booting-without-of.txt
@@ -1721,24 +1721,32 @@ platforms are moved over to use the flattened-device-tree model.
    information.
 
    Required properties:
-   - device_type : should be "par_io".
+   - #gpio-cells : should be "2".
+   - compatible : should be "fsl,qe-pario-bank-<bank>", "fsl,qe-pario-bank"
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
+		compatible = "fsl,qe-pario-bank-a", "fsl,qe-pario-bank";
+		reg = <0x1400 0x18>;
+		gpio-controller;
+	};
 
+	qe_pio_e: gpio-controller@1460 {
+		#gpio-cells = <2>;
+		compatible = "fsl,qe-pario-bank-e", "fsl,qe-pario-bank";
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
diff --git a/arch/powerpc/platforms/Kconfig b/arch/powerpc/platforms/Kconfig
index f38c50b..f6eecd1 100644
--- a/arch/powerpc/platforms/Kconfig
+++ b/arch/powerpc/platforms/Kconfig
@@ -270,6 +270,8 @@ config QUICC_ENGINE
 	bool
 	select PPC_LIB_RHEAP
 	select CRC32
+	select GENERIC_GPIO
+	select HAVE_GPIO_LIB
 	help
 	  The QUICC Engine (QE) is a new generation of communications
 	  coprocessors on Freescale embedded CPUs (akin to CPM in older chips).
diff --git a/drivers/gpio/Kconfig b/drivers/gpio/Kconfig
index bbd2834..cee56f9 100644
--- a/drivers/gpio/Kconfig
+++ b/drivers/gpio/Kconfig
@@ -25,6 +25,15 @@ config DEBUG_GPIO
 
 # put expanders in the right section, in alphabetical order
 
+comment "On-chip GPIOs:"
+
+config GPIO_QE
+	bool "QUICC Engine GPIOs"
+	depends on QUICC_ENGINE
+	help
+	  Say Y here to use GPIOs on the Freescale PowerPC CPUs with
+	  QUICC Engine block.
+
 comment "I2C GPIO expanders:"
 
 config GPIO_PCA953X
diff --git a/drivers/gpio/Makefile b/drivers/gpio/Makefile
index fdde992..fd0a41f 100644
--- a/drivers/gpio/Makefile
+++ b/drivers/gpio/Makefile
@@ -7,3 +7,4 @@ obj-$(CONFIG_HAVE_GPIO_LIB)	+= gpiolib.o
 obj-$(CONFIG_GPIO_MCP23S08)	+= mcp23s08.o
 obj-$(CONFIG_GPIO_PCA953X)	+= pca953x.o
 obj-$(CONFIG_GPIO_PCF857X)	+= pcf857x.o
+obj-$(CONFIG_GPIO_QE)		+= qe.o
diff --git a/drivers/gpio/qe.c b/drivers/gpio/qe.c
new file mode 100644
index 0000000..474bc44
--- /dev/null
+++ b/drivers/gpio/qe.c
@@ -0,0 +1,147 @@
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
+static int __init qe_add_gpiochips(void)
+{
+	int ret;
+	struct device_node *np;
+
+	for_each_compatible_node(np, NULL, "fsl,qe-pario-bank") {
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
+	return 0;
+err:
+	pr_err("%s: registration failed with status %d\n", np->full_name, ret);
+	of_node_put(np);
+	return ret;
+}
+arch_initcall(qe_add_gpiochips);
-- 
1.5.5

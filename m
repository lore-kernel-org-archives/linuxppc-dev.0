Return-Path: <avorontsov@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id 89E94DEA4E
	for <linuxppc-dev@ozlabs.org>; Wed, 12 Mar 2008 05:42:32 +1100 (EST)
Received: from localhost (unknown [10.150.0.9])
	by buildserver.ru.mvista.com (Postfix) with ESMTP id 616868810
	for <linuxppc-dev@ozlabs.org>; Tue, 11 Mar 2008 23:42:44 +0400 (SAMT)
Date: Tue, 11 Mar 2008 21:42:30 +0300
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 4/4] [POWERPC] QE: implement support for the GPIO LIB API
Message-ID: <20080311184230.GD32164@localhost.localdomain>
References: <20080311184012.GA28466@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf8
In-Reply-To: <20080311184012.GA28466@localhost.localdomain>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
---
 Documentation/powerpc/booting-without-of.txt |   32 ++++---
 arch/powerpc/platforms/Kconfig               |    2 +
 arch/powerpc/sysdev/qe_lib/qe_io.c           |  137 +++++++++++++++++++++++++-
 3 files changed, 158 insertions(+), 13 deletions(-)

diff --git a/Documentation/powerpc/booting-without-of.txt b/Documentation/powerpc/booting-without-of.txt
index e9e0c2f..113884b 100644
--- a/Documentation/powerpc/booting-without-of.txt
+++ b/Documentation/powerpc/booting-without-of.txt
@@ -1703,24 +1703,32 @@ platforms are moved over to use the flattened-device-tree model.
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
index 0afd225..2d91ed9 100644
--- a/arch/powerpc/platforms/Kconfig
+++ b/arch/powerpc/platforms/Kconfig
@@ -271,6 +271,8 @@ config QUICC_ENGINE
 	bool
 	select PPC_LIB_RHEAP
 	select CRC32
+	select GENERIC_GPIO
+	select HAVE_GPIO_LIB
 	help
 	  The QUICC Engine (QE) is a new generation of communications
 	  coprocessors on Freescale embedded CPUs (akin to CPM in older chips).
diff --git a/arch/powerpc/sysdev/qe_lib/qe_io.c b/arch/powerpc/sysdev/qe_lib/qe_io.c
index a3f9c3f..a4a195a 100644
--- a/arch/powerpc/sysdev/qe_lib/qe_io.c
+++ b/arch/powerpc/sysdev/qe_lib/qe_io.c
@@ -20,7 +20,8 @@
 #include <linux/errno.h>
 #include <linux/module.h>
 #include <linux/ioport.h>
-
+#include <linux/spinlock.h>
+#include <linux/of_gpio.h>
 #include <asm/io.h>
 #include <asm/qe.h>
 #include <asm/prom.h>
@@ -214,6 +215,140 @@ int par_io_of_config(struct device_node *np)
 }
 EXPORT_SYMBOL(par_io_of_config);
 
+/*
+ * GPIO LIB API implementation
+ */
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
+	struct port_regs __iomem *regs = mm_gc->regs;
+
+	qe_gc->cpdata = in_be32(&regs->cpdata);
+}
+
+static int qe_gpio_get(struct gpio_chip *gc, unsigned int gpio)
+{
+	struct of_mm_gpio_chip *mm_gc = to_of_mm_gpio_chip(gc);
+	struct port_regs __iomem *regs = mm_gc->regs;
+	u32 pin_mask;
+
+	/* calculate pin location */
+	pin_mask = (u32) (1 << (NUM_OF_PINS - 1 - gpio));
+
+	return !!(in_be32(&regs->cpdata) & pin_mask);
+}
+
+static void qe_gpio_set(struct gpio_chip *gc, unsigned int gpio, int val)
+{
+	struct of_mm_gpio_chip *mm_gc = to_of_mm_gpio_chip(gc);
+	struct qe_gpio_chip *qe_gc = to_qe_gpio_chip(mm_gc);
+	struct port_regs __iomem *regs = mm_gc->regs;
+	unsigned long flags;
+	u32 pin_mask = 1 << (NUM_OF_PINS - 1 - gpio);
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
+		gc->ngpio = NUM_OF_PINS;
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
+
 #ifdef DEBUG
 static void dump_par_io(void)
 {
-- 
1.5.2.2

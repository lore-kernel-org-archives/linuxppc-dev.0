Return-Path: <avorontsov@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id 2D0C3DE6A4
	for <linuxppc-dev@ozlabs.org>; Wed,  9 Jan 2008 05:36:13 +1100 (EST)
Date: Tue, 8 Jan 2008 21:45:25 +0300
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 3/3] [POWERPC] QE: implement GPIO LIB API
Message-ID: <20080108184525.GC18445@localhost.localdomain>
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

Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
---
 Documentation/powerpc/booting-without-of.txt |   32 +++++++----
 arch/powerpc/platforms/Kconfig               |    2 +
 arch/powerpc/sysdev/qe_lib/qe_io.c           |   73 ++++++++++++++++++++++++++
 include/asm-powerpc/qe.h                     |    1 +
 4 files changed, 96 insertions(+), 12 deletions(-)

diff --git a/Documentation/powerpc/booting-without-of.txt b/Documentation/powerpc/booting-without-of.txt
index dd2613c..e279152 100644
--- a/Documentation/powerpc/booting-without-of.txt
+++ b/Documentation/powerpc/booting-without-of.txt
@@ -1696,24 +1696,32 @@ platforms are moved over to use the flattened-device-tree model.
    information.
 
    Required properties:
-   - device_type : should be "par_io".
+   - #gpio-cells : should be "1".
+   - compatible : should be "fsl,qe-pario-bank"
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
+		#gpio-cells = <1>;
+		compatible = "fsl,qe-pario-bank";
+		reg = <0x1400 0x18>;
+		gpio-controller;
+	};
 
+	qe_pio_e: gpio-controller@1460 {
+		#gpio-cells = <1>;
+		compatible = "fsl,qe-pario-bank";
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
index ea22cad..8dff946 100644
--- a/arch/powerpc/platforms/Kconfig
+++ b/arch/powerpc/platforms/Kconfig
@@ -265,6 +265,8 @@ config TAU_AVERAGE
 config QUICC_ENGINE
 	bool
 	select PPC_LIB_RHEAP
+	select GENERIC_GPIO
+	select GPIO_LIB
 	help
 	  The QUICC Engine (QE) is a new generation of communications
 	  coprocessors on Freescale embedded CPUs (akin to CPM in older chips).
diff --git a/arch/powerpc/sysdev/qe_lib/qe_io.c b/arch/powerpc/sysdev/qe_lib/qe_io.c
index aef893b..2a1ff45 100644
--- a/arch/powerpc/sysdev/qe_lib/qe_io.c
+++ b/arch/powerpc/sysdev/qe_lib/qe_io.c
@@ -23,6 +23,7 @@
 
 #include <asm/io.h>
 #include <asm/prom.h>
+#include <asm/gpio.h>
 #include <sysdev/fsl_soc.h>
 
 #undef DEBUG
@@ -213,6 +214,78 @@ int par_io_of_config(struct device_node *np)
 }
 EXPORT_SYMBOL(par_io_of_config);
 
+/*
+ * GPIO LIB API implementation
+ */
+
+static int qe_gpio_get(struct gpio_chip *gc, unsigned int gpio)
+{
+	struct of_mm_gpio_chip *mm_gc = to_of_mm_gpio_chip(gc);
+	struct port_regs *regs = mm_gc->regs;
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
+	struct port_regs *regs = mm_gc->regs;
+	u32 pin_mask;
+	u32 tmp_val;
+
+	/* calculate pin location */
+	pin_mask = (u32) (1 << (NUM_OF_PINS - 1 - gpio));
+
+	tmp_val = in_be32(&regs->cpdata);
+
+	if (val == 0)
+		out_be32(&regs->cpdata, ~pin_mask & tmp_val);
+	else
+		out_be32(&regs->cpdata, pin_mask | tmp_val);
+}
+
+static int qe_gpio_dir_in(struct gpio_chip *gc, unsigned int gpio)
+{
+	struct of_mm_gpio_chip *mm_gc = to_of_mm_gpio_chip(gc);
+
+	__par_io_config_pin(mm_gc->regs, gpio, 2, 0, 0, 0);
+
+	return 0;
+}
+
+static int qe_gpio_dir_out(struct gpio_chip *gc, unsigned int gpio, int val)
+{
+	struct of_mm_gpio_chip *mm_gc = to_of_mm_gpio_chip(gc);
+
+	__par_io_config_pin(mm_gc->regs, gpio, 1, 0, 0, 0);
+	qe_gpio_set(gc, gpio, val);
+
+	return 0;
+}
+
+static struct of_gpio_chip qe_gc = {
+	.gpio_cells = 1,
+	.xlate = of_gpio_simple_xlate,
+
+	.gc = {
+		.ngpio = NUM_OF_PINS,
+		.direction_input = qe_gpio_dir_in,
+		.direction_output = qe_gpio_dir_out,
+		.get = qe_gpio_get,
+		.set = qe_gpio_set,
+	},
+};
+
+int qe_gpiochip_add(struct device_node *np)
+{
+	return of_mm_gpiochip_add(np, &qe_gc);
+}
+EXPORT_SYMBOL(qe_gpiochip_add);
+
 #ifdef DEBUG
 static void dump_par_io(void)
 {
diff --git a/include/asm-powerpc/qe.h b/include/asm-powerpc/qe.h
index a24b7b1..2efda82 100644
--- a/include/asm-powerpc/qe.h
+++ b/include/asm-powerpc/qe.h
@@ -77,6 +77,7 @@ enum qe_clock {
 /* Export QE common operations */
 extern void qe_reset(void);
 extern int par_io_init(struct device_node *np);
+extern int qe_gpiochip_add(struct device_node *np);
 extern int par_io_of_config(struct device_node *np);
 extern int par_io_config_pin(u8 port, u8 pin, int dir, int open_drain,
 			     int assignment, int has_irq);
-- 
1.5.2.2

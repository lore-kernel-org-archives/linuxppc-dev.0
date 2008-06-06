Return-Path: <avorontsov@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id 102ACDEB77
	for <linuxppc-dev@ozlabs.org>; Sat,  7 Jun 2008 05:24:56 +1000 (EST)
Date: Fri, 6 Jun 2008 23:24:54 +0400
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: [PATCH 2/2] [POWERPC] 86xx: mpc8610_hpcd: add wakeup-on-sw9 support
Message-ID: <20080606192454.GB20132@polina.dev.rtsoft.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf8
Cc: Scott Wood <scottwood@freescale.com>, linuxppc-dev@ozlabs.org,
	Timur Tabi <timur@freescale.com>, Jason Jin <Jason.jin@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On MPC8610HPCD there is a dedicated switch to wake up the board.

The SW9 button is routed to IRQ8, but could be re-routed (via PIXIS)
to sreset. Luckily, default is IRQ8.

With 'no_console_suspend' kernel command line argument specified, the
board is also able to wakeup upon the serial input.

Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
---
 Documentation/powerpc/booting-without-of.txt |    4 ++
 arch/powerpc/boot/dts/mpc8610_hpcd.dts       |    2 +
 arch/powerpc/platforms/86xx/mpc8610_hpcd.c   |   45 +++++++++++++++++++++++--
 3 files changed, 47 insertions(+), 4 deletions(-)

diff --git a/Documentation/powerpc/booting-without-of.txt b/Documentation/powerpc/booting-without-of.txt
index 6c55f3f..8fd0500 100644
--- a/Documentation/powerpc/booting-without-of.txt
+++ b/Documentation/powerpc/booting-without-of.txt
@@ -2896,11 +2896,15 @@ platforms are moved over to use the flattened-device-tree model.
     - compatible : should be "fsl,fpga-pixis".
     - reg : should contain the address and the lenght of the FPPGA register
       set.
+    - interrupt-parent: the phandle for the interrupt controller.
+    - interrupts : should specify event IRQ.
 
     Example (MPC8610HPCD)
 	board-control@e8000000 {
 		compatible = "fsl,fpga-pixis";
 		reg = <0xe8000000 32>;
+		interrupt-parent = <&mpic>;
+		interrupts = <8 8>;
 	};
 
     t) Freescale MSI interrupt controller
diff --git a/arch/powerpc/boot/dts/mpc8610_hpcd.dts b/arch/powerpc/boot/dts/mpc8610_hpcd.dts
index 8dd8350..5952aa0 100644
--- a/arch/powerpc/boot/dts/mpc8610_hpcd.dts
+++ b/arch/powerpc/boot/dts/mpc8610_hpcd.dts
@@ -105,6 +105,8 @@
 			compatible = "fsl,fpga-pixis";
 			ranges = <0 3 0 0x20>;
 			reg = <3 0 0x20>;
+			interrupt-parent = <&mpic>;
+			interrupts = <8 8>;
 
 			sdcsr_pio: gpio-controller@a {
 				#gpio-cells = <2>;
diff --git a/arch/powerpc/platforms/86xx/mpc8610_hpcd.c b/arch/powerpc/platforms/86xx/mpc8610_hpcd.c
index 83e8ffd..12612fa 100644
--- a/arch/powerpc/platforms/86xx/mpc8610_hpcd.c
+++ b/arch/powerpc/platforms/86xx/mpc8610_hpcd.c
@@ -24,6 +24,7 @@
 #include <linux/seq_file.h>
 #include <linux/fsl_ir.h>
 #include <linux/gpio.h>
+#include <linux/interrupt.h>
 #include <linux/of.h>
 #include <linux/of_gpio.h>
 
@@ -43,11 +44,14 @@
 #include <sysdev/fsl_pci.h>
 #include <sysdev/fsl_soc.h>
 
+#define PX_CSR_EVES		(1 << 2)
 #define PX_BRDCFG0_DVISEL	(1 << 3)
 #define PX_BRDCFG0_DLINK	(1 << 4)
 #define PX_BRDCFG0_DIU_MASK	(PX_BRDCFG0_DVISEL | PX_BRDCFG0_DLINK)
 #define PX_BRDCFG0_IRDAEN	(1 << 5)
 
+static struct device_node *pixis_node;
+static u8 __iomem *pixis_csr;
 static u8 __iomem *pixis_bdcfg0;
 static u8 __iomem *pixis_arch;
 static u32 __iomem *clkdvdr;
@@ -182,6 +186,37 @@ err:
 	of_node_put(irda);
 }
 
+#ifdef CONFIG_SUSPEND
+static irqreturn_t sw9_irq(int irq, void *data)
+{
+	pr_debug("%s: PIXIS' event (sw9/wakeup) IRQ handled\n", __func__);
+	return IRQ_HANDLED;
+}
+
+static void __init mpc8610_suspend_init(void)
+{
+	int irq;
+
+	if (!pixis_node)
+		return;
+
+	irq = irq_of_parse_and_map(pixis_node, 0);
+	if (irq < 0 || irq == NO_IRQ) {
+		pr_err("%s: can't map pixis event IRQ.\n", __func__);
+		return;
+	}
+
+	if (request_irq(irq, sw9_irq, 0, "sw9", NULL)) {
+		pr_err("%s: can't request pixis event IRQ.\n", __func__);
+		irq_dispose_mapping(irq);
+	}
+
+	enable_irq_wake(irq);
+}
+#else
+static inline void mpc8610_suspend_init(void) { }
+#endif /* CONFIG_SUSPEND */
+
 static struct of_device_id __initdata mpc8610_ids[] = {
 	{ .compatible = "fsl,mpc8610-immr", },
 	{ .compatible = "simple-bus", },
@@ -191,6 +226,7 @@ static struct of_device_id __initdata mpc8610_ids[] = {
 static int __init mpc8610_declare_of_platform_devices(void)
 {
 	mpc8610_ir_init();
+	mpc8610_suspend_init();
 
 	/* Without this call, the SSI device driver won't get probed. */
 	of_platform_bus_probe(NULL, mpc8610_ids, NULL);
@@ -418,16 +454,17 @@ static void __init mpc86xx_hpcd_setup_arch(void)
 		return;
 	}
 
-	np = of_find_compatible_node(NULL, NULL, "fsl,fpga-pixis");
-	if (np) {
-		of_address_to_resource(np, 0, &r);
-		of_node_put(np);
+	pixis_node = of_find_compatible_node(NULL, NULL, "fsl,fpga-pixis");
+	if (pixis_node) {
+		of_address_to_resource(pixis_node, 0, &r);
+		of_node_put(pixis_node);
 		pixis = ioremap(r.start, 32);
 		if (!pixis) {
 			printk(KERN_ERR "Err: can't map FPGA cfg register!\n");
 			return;
 		}
 		pixis_bdcfg0 = pixis + 8;
+		pixis_csr = pixis + 3;
 		pixis_arch = pixis + 1;
 	} else
 		printk(KERN_ERR "Err: "
-- 
1.5.5.1

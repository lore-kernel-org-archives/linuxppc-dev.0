Return-Path: <avorontsov@ru.mvista.com>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 08049B7C2B
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon, 31 Aug 2009 05:37:26 +1000 (EST)
Received: from buildserver.ru.mvista.com (unknown [213.79.90.228])
	by ozlabs.org (Postfix) with ESMTP id DE76BDDD04
	for <linuxppc-dev@ozlabs.org>; Mon, 31 Aug 2009 05:37:24 +1000 (EST)
Date: Sun, 30 Aug 2009 23:37:23 +0400
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: [PATCH 4/5] powerpc/86xx: Add power management support for
	MPC8610HPCD boards
Message-ID: <20090830193723.GD17519@oksana.dev.rtsoft.ru>
References: <20090830193625.GA14693@oksana.dev.rtsoft.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <20090830193625.GA14693@oksana.dev.rtsoft.ru>
Cc: Scott Wood <scottwood@freescale.com>, linuxppc-dev@ozlabs.org,
	Timur Tabi <timur@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This patch adds needed nodes and properties to support suspend/resume
on the MPC8610HPCD boards.

There is a dedicated switch (SW9) that is used to wake up the boards.
By default the SW9 button is routed to IRQ8, but could be re-routed
(via PIXIS) to sreset.

With 'no_console_suspend' kernel command line argument specified, the
board is also able to wakeup upon serial port input.

Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
---
 Documentation/powerpc/dts-bindings/fsl/board.txt |    4 ++
 arch/powerpc/boot/dts/mpc8610_hpcd.dts           |   26 ++++++++++++
 arch/powerpc/platforms/86xx/mpc8610_hpcd.c       |   48 ++++++++++++++++++++--
 3 files changed, 74 insertions(+), 4 deletions(-)

diff --git a/Documentation/powerpc/dts-bindings/fsl/board.txt b/Documentation/powerpc/dts-bindings/fsl/board.txt
index e8b5bc2..39e9415 100644
--- a/Documentation/powerpc/dts-bindings/fsl/board.txt
+++ b/Documentation/powerpc/dts-bindings/fsl/board.txt
@@ -20,12 +20,16 @@ Required properities:
 - compatible : should be "fsl,fpga-pixis".
 - reg : should contain the address and the length of the FPPGA register
   set.
+- interrupt-parent: should specify phandle for the interrupt controller.
+- interrupts : should specify event (wakeup) IRQ.
 
 Example (MPC8610HPCD):
 
 	board-control@e8000000 {
 		compatible = "fsl,fpga-pixis";
 		reg = <0xe8000000 32>;
+		interrupt-parent = <&mpic>;
+		interrupts = <8 8>;
 	};
 
 * Freescale BCSR GPIO banks
diff --git a/arch/powerpc/boot/dts/mpc8610_hpcd.dts b/arch/powerpc/boot/dts/mpc8610_hpcd.dts
index f468d21..9535ce6 100644
--- a/arch/powerpc/boot/dts/mpc8610_hpcd.dts
+++ b/arch/powerpc/boot/dts/mpc8610_hpcd.dts
@@ -35,6 +35,8 @@
 			i-cache-line-size = <32>;
 			d-cache-size = <32768>;		// L1
 			i-cache-size = <32768>;		// L1
+			sleep = <&pmc 0x00008000 0	// core
+				 &pmc 0x00004000 0>;	// timebase
 			timebase-frequency = <0>;	// From uboot
 			bus-frequency = <0>;		// From uboot
 			clock-frequency = <0>;		// From uboot
@@ -60,6 +62,7 @@
 			  5 0 0xe8480000 0x00008000
 			  6 0 0xe84c0000 0x00008000
 			  3 0 0xe8000000 0x00000020>;
+		sleep = <&pmc 0x08000000 0>;
 
 		flash@0,0 {
 			compatible = "cfi-flash";
@@ -105,6 +108,8 @@
 			compatible = "fsl,fpga-pixis";
 			reg = <3 0 0x20>;
 			ranges = <0 3 0 0x20>;
+			interrupt-parent = <&mpic>;
+			interrupts = <8 8>;
 
 			sdcsr_pio: gpio-controller@a {
 				#gpio-cells = <2>;
@@ -163,6 +168,7 @@
 			reg = <0x3100 0x100>;
 			interrupts = <43 2>;
 			interrupt-parent = <&mpic>;
+			sleep = <&pmc 0x00000004 0>;
 			dfsrr;
 		};
 
@@ -174,6 +180,7 @@
 			clock-frequency = <0>;
 			interrupts = <42 2>;
 			interrupt-parent = <&mpic>;
+			sleep = <&pmc 0x00000002 0>;
 		};
 
 		serial1: serial@4600 {
@@ -184,6 +191,7 @@
 			clock-frequency = <0>;
 			interrupts = <42 2>;
 			interrupt-parent = <&mpic>;
+			sleep = <&pmc 0x00000008 0>;
 		};
 
 		spi@7000 {
@@ -196,6 +204,7 @@
 			interrupt-parent = <&mpic>;
 			mode = "cpu";
 			gpios = <&sdcsr_pio 7 0>;
+			sleep = <&pmc 0x00000800 0>;
 
 			mmc-slot@0 {
 				compatible = "fsl,mpc8610hpcd-mmc-slot",
@@ -213,6 +222,7 @@
 			reg = <0x2c000 100>;
 			interrupts = <72 2>;
 			interrupt-parent = <&mpic>;
+			sleep = <&pmc 0x04000000 0>;
 		};
 
 		mpic: interrupt-controller@40000 {
@@ -241,9 +251,18 @@
 		};
 
 		global-utilities@e0000 {
+			#address-cells = <1>;
+			#size-cells = <1>;
 			compatible = "fsl,mpc8610-guts";
 			reg = <0xe0000 0x1000>;
+			ranges = <0 0xe0000 0x1000>;
 			fsl,has-rstcr;
+
+			pmc: power@70 {
+				compatible = "fsl,mpc8610-pmc",
+					     "fsl,mpc8641d-pmc";
+				reg = <0x70 0x20>;
+			};
 		};
 
 		wdt@e4000 {
@@ -262,6 +281,7 @@
 			fsl,playback-dma = <&dma00>;
 			fsl,capture-dma = <&dma01>;
 			fsl,fifo-depth = <8>;
+			sleep = <&pmc 0 0x08000000>;
 		};
 
 		ssi@16100 {
@@ -271,6 +291,7 @@
 			interrupt-parent = <&mpic>;
 			interrupts = <63 2>;
 			fsl,fifo-depth = <8>;
+			sleep = <&pmc 0 0x04000000>;
 		};
 
 		dma@21300 {
@@ -280,6 +301,7 @@
 			cell-index = <0>;
 			reg = <0x21300 0x4>; /* DMA general status register */
 			ranges = <0x0 0x21100 0x200>;
+			sleep = <&pmc 0x00000400 0>;
 
 			dma00: dma-channel@0 {
 				compatible = "fsl,mpc8610-dma-channel",
@@ -322,6 +344,7 @@
 			cell-index = <1>;
 			reg = <0xc300 0x4>; /* DMA general status register */
 			ranges = <0x0 0xc100 0x200>;
+			sleep = <&pmc 0x00000200 0>;
 
 			dma-channel@0 {
 				compatible = "fsl,mpc8610-dma-channel",
@@ -369,6 +392,7 @@
 		bus-range = <0 0>;
 		ranges = <0x02000000 0x0 0x80000000 0x80000000 0x0 0x10000000
 			  0x01000000 0x0 0x00000000 0xe1000000 0x0 0x00100000>;
+		sleep = <&pmc 0x80000000 0>;
 		clock-frequency = <33333333>;
 		interrupt-parent = <&mpic>;
 		interrupts = <24 2>;
@@ -398,6 +422,7 @@
 		bus-range = <1 3>;
 		ranges = <0x02000000 0x0 0xa0000000 0xa0000000 0x0 0x10000000
 			  0x01000000 0x0 0x00000000 0xe3000000 0x0 0x00100000>;
+		sleep = <&pmc 0x40000000 0>;
 		clock-frequency = <33333333>;
 		interrupt-parent = <&mpic>;
 		interrupts = <26 2>;
@@ -474,6 +499,7 @@
 				 0x0000 0 0 4 &mpic 7 1>;
 		interrupt-parent = <&mpic>;
 		interrupts = <25 2>;
+		sleep = <&pmc 0x20000000 0>;
 		clock-frequency = <33333333>;
 	};
 };
diff --git a/arch/powerpc/platforms/86xx/mpc8610_hpcd.c b/arch/powerpc/platforms/86xx/mpc8610_hpcd.c
index 627908a..5abe137 100644
--- a/arch/powerpc/platforms/86xx/mpc8610_hpcd.c
+++ b/arch/powerpc/platforms/86xx/mpc8610_hpcd.c
@@ -19,6 +19,7 @@
 #include <linux/stddef.h>
 #include <linux/kernel.h>
 #include <linux/pci.h>
+#include <linux/interrupt.h>
 #include <linux/kdev_t.h>
 #include <linux/delay.h>
 #include <linux/seq_file.h>
@@ -41,10 +42,46 @@
 
 #include "mpc86xx.h"
 
+static struct device_node *pixis_node;
 static unsigned char *pixis_bdcfg0, *pixis_arch;
 
+#ifdef CONFIG_SUSPEND
+static irqreturn_t mpc8610_sw9_irq(int irq, void *data)
+{
+	pr_debug("%s: PIXIS' event (sw9/wakeup) IRQ handled\n", __func__);
+	return IRQ_HANDLED;
+}
+
+static void __init mpc8610_suspend_init(void)
+{
+	int irq;
+	int ret;
+
+	if (!pixis_node)
+		return;
+
+	irq = irq_of_parse_and_map(pixis_node, 0);
+	if (!irq) {
+		pr_err("%s: can't map pixis event IRQ.\n", __func__);
+		return;
+	}
+
+	ret = request_irq(irq, mpc8610_sw9_irq, 0, "sw9/wakeup", NULL);
+	if (ret) {
+		pr_err("%s: can't request pixis event IRQ: %d\n",
+		       __func__, ret);
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
+	{ .compatible = "fsl,mpc8610-guts", },
 	{ .compatible = "simple-bus", },
 	{ .compatible = "gianfar", },
 	{}
@@ -55,6 +92,9 @@ static int __init mpc8610_declare_of_platform_devices(void)
 	/* Firstly, register PIXIS GPIOs. */
 	simple_gpiochip_init("fsl,fpga-pixis-gpio-bank");
 
+	/* Enable wakeup on PIXIS' event IRQ. */
+	mpc8610_suspend_init();
+
 	/* Without this call, the SSI device driver won't get probed. */
 	of_platform_bus_probe(NULL, mpc8610_ids, NULL);
 
@@ -250,10 +290,10 @@ static void __init mpc86xx_hpcd_setup_arch(void)
 	diu_ops.set_sysfs_monitor_port	= mpc8610hpcd_set_sysfs_monitor_port;
 #endif
 
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
-- 
1.6.3.3

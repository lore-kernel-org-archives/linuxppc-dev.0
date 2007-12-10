Return-Path: <avorontsov@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id 88DF6DDE30
	for <linuxppc-dev@ozlabs.org>; Tue, 11 Dec 2007 07:26:19 +1100 (EST)
Received: from localhost (unknown [10.150.0.9])
	by buildserver.ru.mvista.com (Postfix) with ESMTP id 2B75C8816
	for <linuxppc-dev@ozlabs.org>; Tue, 11 Dec 2007 01:26:16 +0400 (SAMT)
Date: Mon, 10 Dec 2007 23:29:34 +0300
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] [POWERPC][RFC] MPC8360E-RDK: Device tree and board file
Message-ID: <20071210202934.GA32046@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This is new board made by Freescale Semiconductor Inc. and
Logic Product Development.

Currently supported:
1. UEC1,2 (UEC2 doesn't work, but I'm sure this is firmware issue)
2. I2C
3. SPI
4. NS16550 serial

Not supported so far:
1. StMICRO NAND512W3A2BN6E, 512 Mbit
2. UEC3,4
3. QE SCCs (slow UCCs)
4. PCI
5. ADC AD7843
6. FHCI USB
7. Graphics controller, Fujitsu MB86277

Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
---

Hi all,

That patch is early RFC:

I tend to submit patches just as they are mature enough, thus not bomb
the list with long queues or huge patches. After I'll fix all upcoming
issues with that basic support, it would be great if someone will
merge it, thus I can start do incremental patches supporting this or
that.

Below is MPC8360E-RDK basic support. I'm following latest fashion,
so dts is v1. ;-)

Thanks,

p.s. not sending defconfig yet.

 arch/powerpc/boot/dts/mpc836x_rdk.dts     |  232 +++++++++++++++++++++++++++++
 arch/powerpc/platforms/83xx/Kconfig       |   10 +-
 arch/powerpc/platforms/83xx/Makefile      |    1 +
 arch/powerpc/platforms/83xx/mpc836x_rdk.c |  109 ++++++++++++++
 4 files changed, 351 insertions(+), 1 deletions(-)
 create mode 100644 arch/powerpc/boot/dts/mpc836x_rdk.dts
 create mode 100644 arch/powerpc/platforms/83xx/mpc836x_rdk.c

diff --git a/arch/powerpc/boot/dts/mpc836x_rdk.dts b/arch/powerpc/boot/dts/mpc836x_rdk.dts
new file mode 100644
index 0000000..a3b37e8
--- /dev/null
+++ b/arch/powerpc/boot/dts/mpc836x_rdk.dts
@@ -0,0 +1,232 @@
+/*
+ * MPC8360E RDK Device Tree Source
+ *
+ * Copyright 2006 Freescale Semiconductor Inc.
+ * Copyright 2007 MontaVista Software, Inc.
+ * 		  Anton Vorontsov <avorontsov@ru.mvista.com>
+ *
+ * This program is free software; you can redistribute  it and/or modify it
+ * under  the terms of  the GNU General  Public License as published by the
+ * Free Software Foundation;  either version 2 of the  License, or (at your
+ * option) any later version.
+ */
+
+/dts-v1/;
+
+/ {
+	model = "MPC8360RDK";
+	compatible = "MPC8360ERDK", "MPC836xRDK", "MPC83xxRDK";
+	#address-cells = <1>;
+	#size-cells = <1>;
+
+	cpus {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		PowerPC,8360@0 {
+			device_type = "cpu";
+			reg = <0>;
+			d-cache-line-size = <32>;
+			i-cache-line-size = <32>;
+			d-cache-size = <32768>;
+			i-cache-size = <32768>;
+			timebase-frequency = <0>; /* filled by u-boot */
+			bus-frequency = <0>; /* filled by u-boot */
+			clock-frequency = <0>; /* filled by u-boot */
+		};
+	};
+
+	soc8360@e0000000 {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		device_type = "soc";
+		ranges = <0 0xe0000000 0x00100000>;
+		reg = <0xe0000000 0x00000200>;
+		bus-frequency = <0>; /* filled by u-boot */
+
+		wdt@200 {
+			device_type = "watchdog";
+			compatible = "mpc83xx_wdt";
+			reg = <0x200 0x100>;
+		};
+
+		i2c@3000 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			device_type = "i2c";
+			compatible = "fsl-i2c";
+			reg = <0x3000 0x100>;
+			interrupts = <14 8>;
+			interrupt-parent = <&ipic>;
+			dfsrr;
+		};
+
+		i2c@3100 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			device_type = "i2c";
+			compatible = "fsl-i2c";
+			reg = <0x3100 0x100>;
+			interrupts = <16 8>;
+			interrupt-parent = <&ipic>;
+			dfsrr;
+		};
+
+		serial@4500 {
+			device_type = "serial";
+			compatible = "ns16550";
+			reg = <0x4500 0x100>;
+			clock-frequency = <0>;
+			interrupts = <9 8>;
+			interrupt-parent = <&ipic>;
+		};
+
+		serial@4600 {
+			device_type = "serial";
+			compatible = "ns16550";
+			reg = <0x4600 0x100>;
+			clock-frequency = <0>;
+			interrupts = <10 8>;
+			interrupt-parent = <&ipic>;
+		};
+
+		crypto@30000 {
+			device_type = "crypto";
+			model = "SEC2";
+			compatible = "talitos";
+			reg = <0x30000 0x10000>;
+			interrupts = <11 8>;
+			interrupt-parent = <&ipic>;
+			num-channels = <4>;
+			channel-fifo-len = <24>;
+			exec-units-mask = <0x0000007e>;
+			/*
+			 * desc mask is for rev1.x, we need runtime fixup
+			 * for >=2.x
+			 */
+			descriptor-types-mask = <0x01010ebf>;
+		};
+
+		ipic: pic@700 {
+			interrupt-controller;
+			#address-cells = <0>;
+			#interrupt-cells = <2>;
+			reg = <0x700 0x100>;
+			device_type = "ipic";
+		};
+
+		par_io@1400 {
+			reg = <0x1400 0x100>;
+			num-ports = <7>;
+		};
+	};
+
+	qe@e0100000 {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		device_type = "qe";
+		model = "QE";
+		ranges = <0 0xe0100000 0x00100000>;
+		reg = <0xe0100000 0x480>;
+		brg-frequency = <0>; /* filled by u-boot */
+		bus-frequency = <0>; /* filled by u-boot */
+
+		muram@10000 {
+			device_type = "muram";
+			ranges = <0 0x00010000 0x0000c000>;
+
+			data-only@0 {
+				reg = <0 0xc000>;
+			};
+		};
+
+		spi@4c0 {
+			device_type = "spi";
+			compatible = "fsl_spi";
+			reg = <0x4c0 0x40>;
+			interrupts = <2>;
+			interrupt-parent = <&qeic>;
+			mode = "cpu";
+		};
+
+		spi@500 {
+			device_type = "spi";
+			compatible = "fsl_spi";
+			reg = <0x500 0x40>;
+			interrupts = <1>;
+			interrupt-parent = <&qeic>;
+			mode = "cpu";
+		};
+
+		usb@6c0 {
+			device_type = "usb";
+			compatible = "qe_udc";
+			reg = <0x6c0 0x40 0x8b00 0x100>;
+			interrupts = <11>;
+			interrupt-parent = <&qeic>;
+			mode = "slave";
+		};
+
+		ucc@2000 {
+			device_type = "network";
+			compatible = "ucc_geth";
+			model = "UCC";
+			device-id = <1>;
+			reg = <0x2000 0x200>;
+			interrupts = <32>;
+			interrupt-parent = <&qeic>;
+			local-mac-address = [ 00 00 00 00 00 00 ];
+			rx-clock = <0>;
+			tx-clock = <25>;
+			phy-handle = <&phy2>;
+			phy-connection-type = "rgmii-id";
+		};
+
+		ucc@3000 {
+			device_type = "network";
+			compatible = "ucc_geth";
+			model = "UCC";
+			device-id = <2>;
+			reg = <0x3000 0x200>;
+			interrupts = <33>;
+			interrupt-parent = <&qeic>;
+			local-mac-address = [ 00 00 00 00 00 00 ];
+			rx-clock = <0>;
+			tx-clock = <20>;
+			phy-handle = <&phy4>;
+			phy-connection-type = "rgmii-id";
+		};
+
+		mdio@2120 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <0x2120 0x18>;
+			device_type = "mdio";
+			compatible = "ucc_geth_phy";
+
+			phy2: ethernet-phy@02 {
+				interrupt-parent = <&ipic>;
+				/*interrupts = <17 8>;*/
+				reg = <2>;
+				device_type = "ethernet-phy";
+			};
+			phy4: ethernet-phy@04 {
+				interrupt-parent = <&ipic>;
+				/*interrupts = <18 8>;*/
+				reg = <4>;
+				device_type = "ethernet-phy";
+			};
+		};
+
+		qeic: qeic@80 {
+			interrupt-controller;
+			device_type = "qeic";
+			#address-cells = <0>;
+			#interrupt-cells = <1>;
+			reg = <0x80 0x80>;
+			big-endian;
+			interrupts = <32 8 33 8>;
+			interrupt-parent = <&ipic>;
+		};
+	};
+};
diff --git a/arch/powerpc/platforms/83xx/Kconfig b/arch/powerpc/platforms/83xx/Kconfig
index ec305f1..98f6358 100644
--- a/arch/powerpc/platforms/83xx/Kconfig
+++ b/arch/powerpc/platforms/83xx/Kconfig
@@ -50,6 +50,14 @@ config MPC836x_MDS
 	help
 	  This option enables support for the MPC836x MDS Processor Board.
 
+config MPC836x_RDK
+	bool "Freescale/Logic MPC836x RDK"
+	select DEFAULT_UIMAGE
+	select QUICC_ENGINE
+	help
+	  This option enables support for the MPC836x RDK Processor Board,
+	  also known as ZOOM PowerQUICC Kit.
+
 endchoice
 
 config PPC_MPC831x
@@ -74,4 +82,4 @@ config PPC_MPC836x
 	bool
 	select PPC_UDBG_16550
 	select PPC_INDIRECT_PCI
-	default y if MPC836x_MDS
+	default y if MPC836x_MDS || MPC836x_RDK
diff --git a/arch/powerpc/platforms/83xx/Makefile b/arch/powerpc/platforms/83xx/Makefile
index 5a98f88..24dcd75 100644
--- a/arch/powerpc/platforms/83xx/Makefile
+++ b/arch/powerpc/platforms/83xx/Makefile
@@ -9,3 +9,4 @@ obj-$(CONFIG_MPC834x_MDS)	+= mpc834x_mds.o
 obj-$(CONFIG_MPC834x_ITX)	+= mpc834x_itx.o
 obj-$(CONFIG_MPC836x_MDS)	+= mpc836x_mds.o
 obj-$(CONFIG_MPC832x_MDS)	+= mpc832x_mds.o
+obj-$(CONFIG_MPC836x_RDK)	+= mpc836x_rdk.o
diff --git a/arch/powerpc/platforms/83xx/mpc836x_rdk.c b/arch/powerpc/platforms/83xx/mpc836x_rdk.c
new file mode 100644
index 0000000..be9e2fd
--- /dev/null
+++ b/arch/powerpc/platforms/83xx/mpc836x_rdk.c
@@ -0,0 +1,109 @@
+/*
+ * MPC8360E-RDK board file.
+ *
+ * Copyright (c) 2006  Freescale Semicondutor, Inc.
+ * Copyright (c) 2007  MontaVista Software, Inc.
+ * 		       Anton Vorontsov <avorontsov@ru.mvista.com>
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under  the terms of  the GNU General  Public License as published by the
+ * Free Software Foundation;  either version 2 of the  License, or (at your
+ * option) any later version.
+ */
+
+#include <linux/kernel.h>
+#include <linux/of_platform.h>
+#include <asm/time.h>
+#include <asm/ipic.h>
+#include <asm/udbg.h>
+#include <asm/io.h>
+#include <asm/qe.h>
+#include <asm/qe_ic.h>
+#include <sysdev/fsl_soc.h>
+
+#include "mpc83xx.h"
+
+static struct of_device_id mpc836x_rdk_ids[] = {
+	{ .type = "soc", },
+	{ .compatible = "soc", },
+	{ .type = "qe", },
+	{},
+};
+
+static int __init mpc836x_rdk_declare_of_platform_devices(void)
+{
+	if (!machine_is(mpc836x_rdk))
+		return 0;
+
+	of_platform_bus_probe(NULL, mpc836x_rdk_ids, NULL);
+
+	return 0;
+}
+device_initcall(mpc836x_rdk_declare_of_platform_devices);
+
+static void __init mpc836x_rdk_setup_arch(void)
+{
+	struct device_node *np;
+
+	if (ppc_md.progress)
+		ppc_md.progress("mpc836x_rdk_setup_arch()", 0);
+
+#ifdef CONFIG_QUICC_ENGINE
+	qe_reset();
+
+	np = of_find_node_by_name(NULL, "par_io");
+	if (np)
+		par_io_init(np);
+	else
+		pr_warning("QE PIO not initialized!\n");
+#endif
+}
+
+static void __init mpc836x_rdk_init_IRQ(void)
+{
+	struct device_node *np;
+
+	np = of_find_node_by_type(NULL, "ipic");
+	if (!np)
+		return;
+
+	ipic_init(np, 0);
+
+	/*
+	 * Initialize the default interrupt mapping priorities,
+	 * in case the boot rom changed something on us.
+	 */
+	ipic_set_default_priority();
+	of_node_put(np);
+
+#ifdef CONFIG_QUICC_ENGINE
+	np = of_find_node_by_type(NULL, "qeic");
+	if (!np)
+		return;
+
+	qe_ic_init(np, 0, qe_ic_cascade_low_ipic, qe_ic_cascade_high_ipic);
+	of_node_put(np);
+#endif
+}
+
+/*
+ * Called very early, MMU is off, device-tree isn't unflattened
+ */
+static int __init mpc836x_rdk_probe(void)
+{
+	unsigned long root = of_get_flat_dt_root();
+
+	return of_flat_dt_is_compatible(root, "MPC836xRDK");
+}
+
+define_machine(mpc836x_rdk) {
+	.name		= "MPC836x RDK",
+	.probe		= mpc836x_rdk_probe,
+	.setup_arch	= mpc836x_rdk_setup_arch,
+	.init_IRQ	= mpc836x_rdk_init_IRQ,
+	.get_irq	= ipic_get_irq,
+	.restart	= mpc83xx_restart,
+	.time_init	= mpc83xx_time_init,
+	.calibrate_decr	= generic_calibrate_decr,
+	.progress	= udbg_progress,
+};
-- 
1.5.2.2

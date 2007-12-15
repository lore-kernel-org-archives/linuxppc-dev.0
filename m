Return-Path: <avorontsov@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id F1601DDDF0
	for <linuxppc-dev@ozlabs.org>; Sun, 16 Dec 2007 03:20:50 +1100 (EST)
Date: Sat, 15 Dec 2007 19:23:31 +0300
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH] [POWERPC][RFC] MPC8360E-RDK: Device tree and board file
Message-ID: <20071215162331.GA24999@localhost.localdomain>
References: <20071210202934.GA32046@localhost.localdomain>
	<10D5CABD-442B-44DF-83D7-7FED5CD150E3@kernel.crashing.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf8
In-Reply-To: <10D5CABD-442B-44DF-83D7-7FED5CD150E3@kernel.crashing.org>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, linuxppc-dev@ozlabs.org
Reply-To: avorontsov@ru.mvista.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Dec 11, 2007 at 12:42:18PM -0600, Kumar Gala wrote:
[...]
> let's go ahead w/an aliases node:
> 
> 	aliases {
> 		ethernet0 = &enet0;
> 		ethernet1 = &enet1;
> 		...
> 		serial0 = &serial0;
> 		serial1 = &serial1;
> 	};
> 
> >
> >+	cpus {
> >+		#address-cells = <1>;
> >+		#size-cells = <0>;
[...]
> >+
> 
> Add serial labels:
> 		serial0: serial@4500 {...
> >
> >+		serial@4500 {
[...]
> 		ethernet labels
> >
> >+		ucc@2000 {

Done, thanks. As time goes by, I also added support for UCC7,4
(10/100 ethernet).

Plus, added compatible = "fsl,qe-pario"; into the par_io node,
now I'm searching for it instead of "par_io" name.

This is still RFC, so nitpicking is highly appreciated.

- - - -
From: Anton Vorontsov <avorontsov@ru.mvista.com>

[POWERPC] MPC8360E-RDK: Device tree and board file

This is new board made by Freescale Semiconductor Inc. and
Logic Product Development.

Currently supported:
1. UEC1,2,7,4
2. I2C
3. SPI
4. NS16550 serial

Not supported so far:
1. StMICRO NAND512W3A2BN6E, 512 Mbit (supported with FSL UPM patches)
2. QE SCCs (slow UCCs, used as an UARTs)
3. PCI
4. ADC AD7843
5. FHCI USB
6. Graphics controller, Fujitsu MB86277

Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
---
 arch/powerpc/boot/dts/mpc836x_rdk.dts     |  288 +++++++++++++++++++++++++++++
 arch/powerpc/platforms/83xx/Kconfig       |   11 +-
 arch/powerpc/platforms/83xx/Makefile      |    1 +
 arch/powerpc/platforms/83xx/mpc836x_rdk.c |  112 +++++++++++
 4 files changed, 411 insertions(+), 1 deletions(-)
 create mode 100644 arch/powerpc/boot/dts/mpc836x_rdk.dts
 create mode 100644 arch/powerpc/platforms/83xx/mpc836x_rdk.c

diff --git a/arch/powerpc/boot/dts/mpc836x_rdk.dts b/arch/powerpc/boot/dts/mpc836x_rdk.dts
new file mode 100644
index 0000000..c873c39
--- /dev/null
+++ b/arch/powerpc/boot/dts/mpc836x_rdk.dts
@@ -0,0 +1,288 @@
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
+	#address-cells = <1>;
+	#size-cells = <1>;
+	compatible = "MPC8360ERDK", "MPC836xRDK", "MPC83xxRDK";
+	model = "MPC8360RDK";
+
+	aliases {
+		serial0 = &serial0;
+		serial1 = &serial1;
+		ethernet0 = &enet0;
+		ethernet1 = &enet1;
+		ethernet2 = &enet2;
+		ethernet3 = &enet3;
+	};
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
+			/* filled by u-boot */
+			timebase-frequency = <0>; 
+			bus-frequency = <0>;
+			clock-frequency = <0>;
+		};
+	};
+
+	soc8360@e0000000 {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		device_type = "soc";
+		ranges = <0 0xe0000000 0x00100000>;
+		reg = <0xe0000000 0x00000200>;
+		/* filled by u-boot */
+		bus-frequency = <0>;
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
+		serial0: serial@4500 {
+			device_type = "serial";
+			compatible = "ns16550";
+			reg = <0x4500 0x100>;
+			interrupts = <9 8>;
+			interrupt-parent = <&ipic>;
+			/* filled by u-boot */
+			clock-frequency = <0>;
+		};
+
+		serial1: serial@4600 {
+			device_type = "serial";
+			compatible = "ns16550";
+			reg = <0x4600 0x100>;
+			interrupts = <10 8>;
+			interrupt-parent = <&ipic>;
+			/* filled by u-boot */
+			clock-frequency = <0>;
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
+			#address-cells = <0>;
+			#interrupt-cells = <2>;
+			interrupt-controller;
+			reg = <0x700 0x100>;
+			device_type = "ipic";
+		};
+
+		par_io@1400 {
+			compatible = "fsl,qe-pario";
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
+		/* filled by u-boot */
+		brg-frequency = <0>;
+		bus-frequency = <0>;
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
+		enet0: ucc@2000 {
+			device_type = "network";
+			compatible = "ucc_geth";
+			model = "UCC";
+			device-id = <1>;
+			reg = <0x2000 0x200>;
+			interrupts = <32>;
+			interrupt-parent = <&qeic>;
+			rx-clock = <0>;
+			tx-clock = <25>;
+			phy-handle = <&phy2>;
+			phy-connection-type = "rgmii-id";
+			/* filled by u-boot */
+			local-mac-address = [ 00 00 00 00 00 00 ];
+		};
+
+		enet1: ucc@3000 {
+			device_type = "network";
+			compatible = "ucc_geth";
+			model = "UCC";
+			device-id = <2>;
+			reg = <0x3000 0x200>;
+			interrupts = <33>;
+			interrupt-parent = <&qeic>;
+			rx-clock = <0>;
+			tx-clock = <20>;
+			phy-handle = <&phy4>;
+			phy-connection-type = "rgmii-id";
+			/* filled by u-boot */
+			local-mac-address = [ 00 00 00 00 00 00 ];
+		};
+
+		enet2: ucc@2600 {
+			device_type = "network";
+			compatible = "ucc_geth";
+			model = "UCC";
+			device-id = <7>;
+			reg = <0x2600 0x200>;
+			interrupts = <34>;
+			interrupt-parent = <&qeic>;
+			rx-clock = <36>;
+			tx-clock = <35>;
+			phy-handle = <&phy1>;
+			phy-connection-type = "mii";
+			/* filled by u-boot */
+			local-mac-address = [ 00 00 00 00 00 00 ];
+		};
+
+		enet3: ucc@3200 {
+			device_type = "network";
+			compatible = "ucc_geth";
+			model = "UCC";
+			device-id = <4>;
+			reg = <0x3200 0x200>;
+			interrupts = <35>;
+			interrupt-parent = <&qeic>;
+			rx-clock = <24>;
+			tx-clock = <23>;
+			phy-handle = <&phy3>;
+			phy-connection-type = "mii";
+			/* filled by u-boot */
+			local-mac-address = [ 00 00 00 00 00 00 ];
+		};
+
+		mdio@2120 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <0x2120 0x18>;
+			device_type = "mdio";
+			compatible = "ucc_geth_phy";
+
+			phy1: ethernet-phy@1 {
+				reg = <1>;
+				device_type = "ethernet-phy";
+			};
+
+			phy2: ethernet-phy@2 {
+				reg = <2>;
+				device_type = "ethernet-phy";
+			};
+
+			phy3: ethernet-phy@3 {
+				reg = <3>;
+				device_type = "ethernet-phy";
+			};
+
+			phy4: ethernet-phy@4 {
+				reg = <4>;
+				device_type = "ethernet-phy";
+			};
+		};
+
+		qeic: qeic@80 {
+			#address-cells = <0>;
+			#interrupt-cells = <1>;
+			interrupt-controller;
+			device_type = "qeic";
+			reg = <0x80 0x80>;
+			big-endian;
+			interrupts = <32 8 33 8>;
+			interrupt-parent = <&ipic>;
+		};
+	};
+};
diff --git a/arch/powerpc/platforms/83xx/Kconfig b/arch/powerpc/platforms/83xx/Kconfig
index 2430ac8..0d5a87c 100644
--- a/arch/powerpc/platforms/83xx/Kconfig
+++ b/arch/powerpc/platforms/83xx/Kconfig
@@ -55,6 +55,15 @@ config MPC837x_MDS
 	select DEFAULT_UIMAGE
 	help
 	  This option enables support for the MPC837x MDS Processor Board.
+
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
@@ -79,7 +88,7 @@ config PPC_MPC836x
 	bool
 	select PPC_UDBG_16550
 	select PPC_INDIRECT_PCI
-	default y if MPC836x_MDS
+	default y if MPC836x_MDS || MPC836x_RDK
 
 config PPC_MPC837x
 	bool
diff --git a/arch/powerpc/platforms/83xx/Makefile b/arch/powerpc/platforms/83xx/Makefile
index df46629..bf1b799 100644
--- a/arch/powerpc/platforms/83xx/Makefile
+++ b/arch/powerpc/platforms/83xx/Makefile
@@ -10,3 +10,4 @@ obj-$(CONFIG_MPC834x_ITX)	+= mpc834x_itx.o
 obj-$(CONFIG_MPC836x_MDS)	+= mpc836x_mds.o
 obj-$(CONFIG_MPC832x_MDS)	+= mpc832x_mds.o
 obj-$(CONFIG_MPC837x_MDS)	+= mpc837x_mds.o
+obj-$(CONFIG_MPC836x_RDK)	+= mpc836x_rdk.o
diff --git a/arch/powerpc/platforms/83xx/mpc836x_rdk.c b/arch/powerpc/platforms/83xx/mpc836x_rdk.c
new file mode 100644
index 0000000..2d94b38
--- /dev/null
+++ b/arch/powerpc/platforms/83xx/mpc836x_rdk.c
@@ -0,0 +1,112 @@
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
+#include <asm/prom.h>
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
+	np = of_find_compatible_node(NULL, NULL, "fsl,qe-pario");
+	if (np) {
+		par_io_init(np);
+		of_node_put(np);
+	} else {
+		pr_warning("QE PIO not initialized!\n");
+	}
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
+ * Called very early, MMU is off, device-tree isn't unflattened.
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

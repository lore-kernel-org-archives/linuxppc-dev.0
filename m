Return-Path: <avorontsov@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id C066ADDEC7
	for <linuxppc-dev@ozlabs.org>; Thu, 20 Dec 2007 07:57:21 +1100 (EST)
Date: Wed, 19 Dec 2007 23:59:33 +0300
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH] [POWERPC][RFC] MPC8360E-RDK: Device tree and board file
Message-ID: <20071219205933.GA20912@localhost.localdomain>
References: <20071210202934.GA32046@localhost.localdomain>
	<10D5CABD-442B-44DF-83D7-7FED5CD150E3@kernel.crashing.org>
	<20071215162331.GA24999@localhost.localdomain>
	<20071217051403.GB3477@localhost.localdomain>
	<20071217170303.GA4303@loki.buserror.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf8
In-Reply-To: <20071217170303.GA4303@loki.buserror.net>
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

On Mon, Dec 17, 2007 at 11:03:04AM -0600, Scott Wood wrote:
> On Mon, Dec 17, 2007 at 04:14:03PM +1100, David Gibson wrote:
> > > +		crypto@30000 {
> > > +			device_type = "crypto";
> > > +			model = "SEC2";
> > > +			compatible = "talitos";
> > 
> > This device_type/compatible/model stuff is also crap, although I
> > suspect it needs to be fixed in the driver, as gianfar (finally) was.

Thanks everyone for the review! I did cleanups you suggested, and now
this patch depends on "[PATCH 0/4] device_type/compatible cleanups"
series.


Meanwhile added PCI and NOR flash support w/o partitions.

I still undecided on partitioning. 512KB u-boot, 128KB dtb, 2MB kernel,
4MB ramdisk, and less than 2MB for rootfs? Maybe get rid of rootfs on
the NOR flash and let kernel be 3MB? Personally, I tend to not inculcate
partition map into the dts at all.

How about that version?

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
5. PCI and miniPCI
6. Intel NOR StrataFlash X16 64Mbit PC28F640P30T85

Not supported so far:
1. StMICRO NAND512W3A2BN6E, 512 Mbit (supported with FSL UPM patches)
2. QE SCCs (slow UCCs, used as an UARTs)
3. ADC AD7843
4. FHCI USB
5. Graphics controller, Fujitsu MB86277

Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
---
 arch/powerpc/boot/dts/mpc836x_rdk.dts     |  328 +++++++++++++++++++++++++++++
 arch/powerpc/platforms/83xx/Kconfig       |   11 +-
 arch/powerpc/platforms/83xx/Makefile      |    1 +
 arch/powerpc/platforms/83xx/mpc836x_rdk.c |  118 +++++++++++
 4 files changed, 457 insertions(+), 1 deletions(-)
 create mode 100644 arch/powerpc/boot/dts/mpc836x_rdk.dts
 create mode 100644 arch/powerpc/platforms/83xx/mpc836x_rdk.c

diff --git a/arch/powerpc/boot/dts/mpc836x_rdk.dts b/arch/powerpc/boot/dts/mpc836x_rdk.dts
new file mode 100644
index 0000000..1d0c014
--- /dev/null
+++ b/arch/powerpc/boot/dts/mpc836x_rdk.dts
@@ -0,0 +1,328 @@
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
+		pci0 = &pci0;
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
+			compatible = "mpc83xx_wdt";
+			reg = <0x200 0x100>;
+		};
+
+		i2c@3000 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			cell-index = <0>;
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
+			cell-index = <1>;
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
+			compatible = "fsl,sec2-crypto";
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
+		ipic: interrupt-controller@700 {
+			#address-cells = <0>;
+			#interrupt-cells = <2>;
+			compatible = "fsl,pq2pro-pic", "fsl,ipic";
+			interrupt-controller;
+			reg = <0x700 0x100>;
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
+		compatible = "fsl,qe";
+		ranges = <0 0xe0100000 0x00100000>;
+		reg = <0xe0100000 0x480>;
+		/* filled by u-boot */
+		brg-frequency = <0>;
+
+		muram@10000 {
+			compatible = "fsl,qe-muram";
+			ranges = <0 0x00010000 0x0000c000>;
+
+			data-only@0 {
+				compatible = "fsl,qe-muram-data";
+				reg = <0 0xc000>;
+			};
+		};
+
+		spi@4c0 {
+			compatible = "fsl,spi";
+			reg = <0x4c0 0x40>;
+			interrupts = <2>;
+			interrupt-parent = <&qeic>;
+			mode = "cpu-qe";
+		};
+
+		spi@500 {
+			compatible = "fsl,spi";
+			reg = <0x500 0x40>;
+			interrupts = <1>;
+			interrupt-parent = <&qeic>;
+			mode = "cpu-qe";
+		};
+
+		usb@6c0 {
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
+			compatible = "fsl,ucc-mdio";
+
+			phy1: ethernet-phy@1 {
+				compatible = "national,DP83848VV";
+				reg = <1>;
+				device_type = "ethernet-phy";
+			};
+
+			phy2: ethernet-phy@2 {
+				compatible = "broadcom,BCM5481UA2KMLG";
+				reg = <2>;
+				device_type = "ethernet-phy";
+			};
+
+			phy3: ethernet-phy@3 {
+				compatible = "national,DP83848VV";
+				reg = <3>;
+				device_type = "ethernet-phy";
+			};
+
+			phy4: ethernet-phy@4 {
+				compatible = "broadcom,BCM5481UA2KMLG";
+				reg = <4>;
+				device_type = "ethernet-phy";
+			};
+		};
+
+		qeic: interrupt-controller@80 {
+			#address-cells = <0>;
+			#interrupt-cells = <1>;
+			compatible = "fsl,qe-pic";
+			interrupt-controller;
+			reg = <0x80 0x80>;
+			big-endian;
+			interrupts = <32 8 33 8>;
+			interrupt-parent = <&ipic>;
+		};
+	};
+
+	localbus@e0005000 {
+		#address-cells = <2>;
+		#size-cells = <1>;
+		compatible = "fsl,mpc8360-localbus",
+			     "fsl,pq2pro-localbus";
+		reg = <0xe0005000 0xd8>;
+		ranges = <0 0 0xff800000 0x800000>;
+
+		nor-flash@0,0 {
+			compatible = "intel,PC28F640P30T85", "cfi-flash";
+			reg = <0 0 0x800000>;
+			bank-width = <2>;
+			device-width = <1>;
+		};
+	};
+
+	pci0: pci@e0008500 {
+		#address-cells = <3>;
+		#size-cells = <2>;
+		#interrupt-cells = <1>;
+		device_type = "pci";
+		compatible = "fsl,mpc8360-pci", "fsl,mpc8349-pci";
+		reg = <0xe0008500 0x100>;
+		ranges = <0x02000000 0 0x90000000 0x90000000 0 0x10000000
+			  0x42000000 0 0x80000000 0x80000000 0 0x10000000
+			  0x01000000 0 0xe0300000 0xe0300000 0 0x00100000>;
+		interrupts = <66 8>;
+		interrupt-parent = <&ipic>;
+		interrupt-map-mask = <0xf800 0 0 7>;
+		interrupt-map = </* miniPCI0 IDSEL 0x14 AD20 */
+				 0xa000 0 0 1 &ipic 18 8
+				 0xa000 0 0 2 &ipic 19 8
+
+				 /* PCI1 IDSEL 0x15 AD21 */
+				 0xa800 0 0 1 &ipic 19 8
+				 0xa800 0 0 2 &ipic 20 8
+				 0xa800 0 0 3 &ipic 21 8
+				 0xa800 0 0 4 &ipic 18 8>;
+		/* filled by u-boot */
+		bus-range = <0 0>;
+		clock-frequency = <0>;
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
index 0000000..999cfa2
--- /dev/null
+++ b/arch/powerpc/platforms/83xx/mpc836x_rdk.c
@@ -0,0 +1,118 @@
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
+#include <linux/pci.h>
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
+	{ .compatible = "soc", },
+	{ .compatible = "fsl,qe", },
+	{ .compatible = "fsl,pq2pro-localbus", },
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
+#ifdef CONFIG_PCI
+	for_each_compatible_node(np, "pci", "fsl,mpc8349-pci")
+		mpc83xx_add_bridge(np);
+#endif
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
+	np = of_find_compatible_node(NULL, NULL, "fsl,ipic");
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
+	np = of_find_compatible_node(NULL, NULL, "fsl,qe-pic");
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

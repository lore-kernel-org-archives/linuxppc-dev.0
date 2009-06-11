Return-Path: <ncase@xes-inc.com>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 05327B7854
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 12 Jun 2009 05:43:50 +1000 (EST)
Received: from xes-mad.com (xes-mad.com [216.165.139.214])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 92F5BDDD01
	for <linuxppc-dev@ozlabs.org>; Fri, 12 Jun 2009 05:43:44 +1000 (EST)
From: Nate Case <ncase@xes-inc.com>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: [PATCH -next 2/4] powerpc/85xx: Add dts files for X-ES MPC85xx boards
Date: Thu, 11 Jun 2009 14:42:59 -0500
Message-Id: <1244749381-17429-3-git-send-email-ncase@xes-inc.com>
In-Reply-To: <1244749381-17429-2-git-send-email-ncase@xes-inc.com>
References: <1244749381-17429-1-git-send-email-ncase@xes-inc.com>
	<1244749381-17429-2-git-send-email-ncase@xes-inc.com>
Cc: linuxppc-dev@ozlabs.org, Nate Case <ncase@xes-inc.com>,
	David Gibson <david@gibson.dropbear.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Add device tree source files for various MPC85xx boards from Extreme
Engineering Solutions.  Supported boards include XPedite5370,
XPedite5200, XPedite5301, XPedite5330, and XCalibur1501.

Signed-off-by: Nate Case <ncase@xes-inc.com>
---
 arch/powerpc/boot/dts/xcalibur1501.dts     |  696 +++++++++++++++++++++++++++
 arch/powerpc/boot/dts/xpedite5200.dts      |  466 ++++++++++++++++++
 arch/powerpc/boot/dts/xpedite5200_xmon.dts |  506 ++++++++++++++++++++
 arch/powerpc/boot/dts/xpedite5301.dts      |  640 +++++++++++++++++++++++++
 arch/powerpc/boot/dts/xpedite5330.dts      |  707 ++++++++++++++++++++++++++++
 arch/powerpc/boot/dts/xpedite5370.dts      |  638 +++++++++++++++++++++++++
 6 files changed, 3653 insertions(+), 0 deletions(-)
 create mode 100644 arch/powerpc/boot/dts/xcalibur1501.dts
 create mode 100644 arch/powerpc/boot/dts/xpedite5200.dts
 create mode 100644 arch/powerpc/boot/dts/xpedite5200_xmon.dts
 create mode 100644 arch/powerpc/boot/dts/xpedite5301.dts
 create mode 100644 arch/powerpc/boot/dts/xpedite5330.dts
 create mode 100644 arch/powerpc/boot/dts/xpedite5370.dts

diff --git a/arch/powerpc/boot/dts/xcalibur1501.dts b/arch/powerpc/boot/dts/xcalibur1501.dts
new file mode 100644
index 0000000..ac0a617
--- /dev/null
+++ b/arch/powerpc/boot/dts/xcalibur1501.dts
@@ -0,0 +1,696 @@
+/*
+ * Copyright (C) 2008 Extreme Engineering Solutions, Inc.
+ * Based on MPC8572DS device tree from Freescale Semiconductor, Inc.
+ *
+ * XCalibur1501 6U CompactPCI single-board computer based on MPC8572E
+ *
+ * This is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+/dts-v1/;
+/ {
+	model = "xes,xcalibur1501";
+	compatible = "xes,xcalibur1501", "xes,MPC8572";
+	#address-cells = <2>;
+	#size-cells = <2>;
+
+	aliases {
+		ethernet0 = &enet0;
+		ethernet1 = &enet1;
+		ethernet2 = &enet2;
+		ethernet3 = &enet3;
+		serial0 = &serial0;
+		serial1 = &serial1;
+		pci2 = &pci2;
+	};
+
+	cpus {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		PowerPC,8572@0 {
+			device_type = "cpu";
+			reg = <0x0>;
+			d-cache-line-size = <32>;	// 32 bytes
+			i-cache-line-size = <32>;	// 32 bytes
+			d-cache-size = <0x8000>;		// L1, 32K
+			i-cache-size = <0x8000>;		// L1, 32K
+			timebase-frequency = <0>;
+			bus-frequency = <0>;
+			clock-frequency = <0>;
+			next-level-cache = <&L2>;
+		};
+
+		PowerPC,8572@1 {
+			device_type = "cpu";
+			reg = <0x1>;
+			d-cache-line-size = <32>;	// 32 bytes
+			i-cache-line-size = <32>;	// 32 bytes
+			d-cache-size = <0x8000>;		// L1, 32K
+			i-cache-size = <0x8000>;		// L1, 32K
+			timebase-frequency = <0>;
+			bus-frequency = <0>;
+			clock-frequency = <0>;
+			next-level-cache = <&L2>;
+		};
+	};
+
+	memory {
+		device_type = "memory";
+		reg = <0x0 0x0 0x0 0x0>;	// Filled in by U-Boot
+	};
+
+	localbus@ef005000 {
+		#address-cells = <2>;
+		#size-cells = <1>;
+		compatible = "fsl,mpc8572-elbc", "fsl,elbc", "simple-bus";
+		reg = <0 0xef005000 0 0x1000>;
+		interrupts = <19 2>;
+		interrupt-parent = <&mpic>;
+		/* Local bus region mappings */
+		ranges = <0 0 0 0xf8000000 0x8000000  /* CS0: Flash 1 */
+			  1 0 0 0xf0000000 0x8000000  /* CS1: Flash 2 */
+			  2 0 0 0xef800000 0x40000    /* CS2: NAND CE1 */
+			  3 0 0 0xef840000 0x40000    /* CS3: NAND CE2 */
+			  4 0 0 0xe9000000 0x100000>; /* CS4: USB */
+
+		nor-boot@0,0 {
+			compatible = "amd,s29gl01gp", "cfi-flash";
+			bank-width = <2>;
+			reg = <0 0 0x8000000>; /* 128MB */
+			#address-cells = <1>;
+			#size-cells = <1>;
+			partition@0 {
+				label = "Primary user space";
+				reg = <0x00000000 0x6f00000>; /* 111 MB */
+			};
+			partition@6f00000 {
+				label = "Primary kernel";
+				reg = <0x6f00000 0x1000000>; /* 16 MB */
+			};
+			partition@7f00000 {
+				label = "Primary DTB";
+				reg = <0x7f00000 0x40000>; /* 256 KB */
+			};
+			partition@7f40000 {
+				label = "Primary U-Boot environment";
+				reg = <0x7f40000 0x40000>; /* 256 KB */
+			};
+			partition@7f80000 {
+				label = "Primary U-Boot";
+				reg = <0x7f80000 0x80000>; /* 512 KB */
+				read-only;
+			};
+		};
+
+		nor-alternate@1,0 {
+			compatible = "amd,s29gl01gp", "cfi-flash";
+			bank-width = <2>;
+			//reg = <0xf0000000 0x08000000>; /* 128MB */
+			reg = <1 0 0x8000000>; /* 128MB */
+			#address-cells = <1>;
+			#size-cells = <1>;
+			partition@0 {
+				label = "Secondary user space";
+				reg = <0x00000000 0x6f00000>; /* 111 MB */
+			};
+			partition@6f00000 {
+				label = "Secondary kernel";
+				reg = <0x6f00000 0x1000000>; /* 16 MB */
+			};
+			partition@7f00000 {
+				label = "Secondary DTB";
+				reg = <0x7f00000 0x40000>; /* 256 KB */
+			};
+			partition@7f40000 {
+				label = "Secondary U-Boot environment";
+				reg = <0x7f40000 0x40000>; /* 256 KB */
+			};
+			partition@7f80000 {
+				label = "Secondary U-Boot";
+				reg = <0x7f80000 0x80000>; /* 512 KB */
+				read-only;
+			};
+		};
+
+		nand@2,0 {
+			#address-cells = <1>;
+			#size-cells = <1>;
+			/*
+			 * Actual part could be ST Micro NAND08GW3B2A (1 GB),
+			 * Micron MT29F8G08DAA (2x 512 MB), or Micron
+			 * MT29F16G08FAA (2x 1 GB), depending on the build
+			 * configuration
+			 */
+			compatible = "fsl,mpc8572-fcm-nand",
+				     "fsl,elbc-fcm-nand";
+			reg = <2 0 0x40000>;
+			/* U-Boot should fix this up if chip size > 1 GB */
+			partition@0 {
+				label = "NAND Filesystem";
+				reg = <0 0x40000000>;
+			};
+		};
+
+		usb@4,0 {
+			compatible = "nxp,usb-isp1761";
+			reg = <4 0 0x100000>;
+			bus-width = <32>;
+			interrupt-parent = <&mpic>;
+			interrupts = <10 1>;
+		};
+	};
+
+	soc8572@ef000000 {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		device_type = "soc";
+		compatible = "fsl,mpc8572-immr", "simple-bus";
+		ranges = <0x0 0 0xef000000 0x100000>;
+		bus-frequency = <0>;		// Filled out by uboot.
+
+		ecm-law@0 {
+			compatible = "fsl,ecm-law";
+			reg = <0x0 0x1000>;
+			fsl,num-laws = <12>;
+		};
+
+		ecm@1000 {
+			compatible = "fsl,mpc8572-ecm", "fsl,ecm";
+			reg = <0x1000 0x1000>;
+			interrupts = <17 2>;
+			interrupt-parent = <&mpic>;
+		};
+
+		memory-controller@2000 {
+			compatible = "fsl,mpc8572-memory-controller";
+			reg = <0x2000 0x1000>;
+			interrupt-parent = <&mpic>;
+			interrupts = <18 2>;
+		};
+
+		memory-controller@6000 {
+			compatible = "fsl,mpc8572-memory-controller";
+			reg = <0x6000 0x1000>;
+			interrupt-parent = <&mpic>;
+			interrupts = <18 2>;
+		};
+
+		L2: l2-cache-controller@20000 {
+			compatible = "fsl,mpc8572-l2-cache-controller";
+			reg = <0x20000 0x1000>;
+			cache-line-size = <32>;	// 32 bytes
+			cache-size = <0x100000>; // L2, 1M
+			interrupt-parent = <&mpic>;
+			interrupts = <16 2>;
+		};
+
+		i2c@3000 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			cell-index = <0>;
+			compatible = "fsl-i2c";
+			reg = <0x3000 0x100>;
+			interrupts = <43 2>;
+			interrupt-parent = <&mpic>;
+			dfsrr;
+
+			temp-sensor@48 {
+				compatible = "dallas,ds1631", "dallas,ds1621";
+				reg = <0x48>;
+			};
+
+			temp-sensor@4c {
+				compatible = "adi,adt7461";
+				reg = <0x4c>;
+			};
+
+			cpu-supervisor@51 {
+				compatible = "dallas,ds4510";
+				reg = <0x51>;
+			};
+
+			eeprom@54 {
+				compatible = "atmel,at24c128b";
+				reg = <0x54>;
+			};
+
+			rtc@68 {
+				compatible = "stm,m41t00",
+				             "dallas,ds1338";
+				reg = <0x68>;
+			};
+
+			pcie-switch@6a {
+				compatible = "plx,pex8648";
+				reg = <0x6a>;
+			};
+
+			/* On-board signals for VID, flash, serial */
+			gpio1: gpio@18 {
+				compatible = "nxp,pca9557";
+				reg = <0x18>;
+				#gpio-cells = <2>;
+				gpio-controller;
+				polarity = <0x00>;
+			};
+
+			/* PMC0/XMC0 signals */
+			gpio2: gpio@1c {
+				compatible = "nxp,pca9557";
+				reg = <0x1c>;
+				#gpio-cells = <2>;
+				gpio-controller;
+				polarity = <0x00>;
+			};
+
+			/* PMC1/XMC1 signals */
+			gpio3: gpio@1d {
+				compatible = "nxp,pca9557";
+				reg = <0x1d>;
+				#gpio-cells = <2>;
+				gpio-controller;
+				polarity = <0x00>;
+			};
+
+			/* CompactPCI signals (sysen, GA[4:0]) */
+			gpio4: gpio@1e {
+				compatible = "nxp,pca9557";
+				reg = <0x1e>;
+				#gpio-cells = <2>;
+				gpio-controller;
+				polarity = <0x00>;
+			};
+
+			/* CompactPCI J5 GPIO and FAL/DEG/PRST */
+			gpio5: gpio@1f {
+				compatible = "nxp,pca9557";
+				reg = <0x1f>;
+				#gpio-cells = <2>;
+				gpio-controller;
+				polarity = <0x00>;
+			};
+		};
+
+		i2c@3100 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			cell-index = <1>;
+			compatible = "fsl-i2c";
+			reg = <0x3100 0x100>;
+			interrupts = <43 2>;
+			interrupt-parent = <&mpic>;
+			dfsrr;
+		};
+
+		dma@c300 {
+			#address-cells = <1>;
+			#size-cells = <1>;
+			compatible = "fsl,mpc8572-dma", "fsl,eloplus-dma";
+			reg = <0xc300 0x4>;
+			ranges = <0x0 0xc100 0x200>;
+			cell-index = <1>;
+			dma-channel@0 {
+				compatible = "fsl,mpc8572-dma-channel",
+						"fsl,eloplus-dma-channel";
+				reg = <0x0 0x80>;
+				cell-index = <0>;
+				interrupt-parent = <&mpic>;
+				interrupts = <76 2>;
+			};
+			dma-channel@80 {
+				compatible = "fsl,mpc8572-dma-channel",
+						"fsl,eloplus-dma-channel";
+				reg = <0x80 0x80>;
+				cell-index = <1>;
+				interrupt-parent = <&mpic>;
+				interrupts = <77 2>;
+			};
+			dma-channel@100 {
+				compatible = "fsl,mpc8572-dma-channel",
+						"fsl,eloplus-dma-channel";
+				reg = <0x100 0x80>;
+				cell-index = <2>;
+				interrupt-parent = <&mpic>;
+				interrupts = <78 2>;
+			};
+			dma-channel@180 {
+				compatible = "fsl,mpc8572-dma-channel",
+						"fsl,eloplus-dma-channel";
+				reg = <0x180 0x80>;
+				cell-index = <3>;
+				interrupt-parent = <&mpic>;
+				interrupts = <79 2>;
+			};
+		};
+
+		dma@21300 {
+			#address-cells = <1>;
+			#size-cells = <1>;
+			compatible = "fsl,mpc8572-dma", "fsl,eloplus-dma";
+			reg = <0x21300 0x4>;
+			ranges = <0x0 0x21100 0x200>;
+			cell-index = <0>;
+			dma-channel@0 {
+				compatible = "fsl,mpc8572-dma-channel",
+						"fsl,eloplus-dma-channel";
+				reg = <0x0 0x80>;
+				cell-index = <0>;
+				interrupt-parent = <&mpic>;
+				interrupts = <20 2>;
+			};
+			dma-channel@80 {
+				compatible = "fsl,mpc8572-dma-channel",
+						"fsl,eloplus-dma-channel";
+				reg = <0x80 0x80>;
+				cell-index = <1>;
+				interrupt-parent = <&mpic>;
+				interrupts = <21 2>;
+			};
+			dma-channel@100 {
+				compatible = "fsl,mpc8572-dma-channel",
+						"fsl,eloplus-dma-channel";
+				reg = <0x100 0x80>;
+				cell-index = <2>;
+				interrupt-parent = <&mpic>;
+				interrupts = <22 2>;
+			};
+			dma-channel@180 {
+				compatible = "fsl,mpc8572-dma-channel",
+						"fsl,eloplus-dma-channel";
+				reg = <0x180 0x80>;
+				cell-index = <3>;
+				interrupt-parent = <&mpic>;
+				interrupts = <23 2>;
+			};
+		};
+
+		/* eTSEC 1 front panel 0 */
+		enet0: ethernet@24000 {
+			#address-cells = <1>;
+			#size-cells = <1>;
+			cell-index = <0>;
+			device_type = "network";
+			model = "eTSEC";
+			compatible = "gianfar";
+			reg = <0x24000 0x1000>;
+			ranges = <0x0 0x24000 0x1000>;
+			local-mac-address = [ 00 00 00 00 00 00 ];
+			interrupts = <29 2 30 2 34 2>;
+			interrupt-parent = <&mpic>;
+			tbi-handle = <&tbi0>;
+			phy-handle = <&phy0>;
+			phy-connection-type = "sgmii";
+
+			mdio@520 {
+				#address-cells = <1>;
+				#size-cells = <0>;
+				compatible = "fsl,gianfar-mdio";
+				reg = <0x520 0x20>;
+
+				phy0: ethernet-phy@1 {
+					interrupt-parent = <&mpic>;
+					interrupts = <4 1>;
+					reg = <0x1>;
+				};
+				phy1: ethernet-phy@2 {
+					interrupt-parent = <&mpic>;
+					interrupts = <4 1>;
+					reg = <0x2>;
+				};
+				phy2: ethernet-phy@3 {
+					interrupt-parent = <&mpic>;
+					interrupts = <5 1>;
+					reg = <0x3>;
+				};
+				phy3: ethernet-phy@4 {
+					interrupt-parent = <&mpic>;
+					interrupts = <5 1>;
+					reg = <0x4>;
+				};
+				tbi0: tbi-phy@11 {
+					reg = <0x11>;
+					device_type = "tbi-phy";
+				};
+			};
+		};
+
+		/* eTSEC 2 front panel 1 */
+		enet1: ethernet@25000 {
+			#address-cells = <1>;
+			#size-cells = <1>;
+			cell-index = <1>;
+			device_type = "network";
+			model = "eTSEC";
+			compatible = "gianfar";
+			reg = <0x25000 0x1000>;
+			ranges = <0x0 0x25000 0x1000>;
+			local-mac-address = [ 00 00 00 00 00 00 ];
+			interrupts = <35 2 36 2 40 2>;
+			interrupt-parent = <&mpic>;
+			tbi-handle = <&tbi1>;
+			phy-handle = <&phy1>;
+			phy-connection-type = "sgmii";
+
+			mdio@520 {
+				#address-cells = <1>;
+				#size-cells = <0>;
+				compatible = "fsl,gianfar-tbi";
+				reg = <0x520 0x20>;
+
+				tbi1: tbi-phy@11 {
+					reg = <0x11>;
+					device_type = "tbi-phy";
+				};
+			};
+		};
+
+		/* eTSEC 3 PICMG2.16 backplane port 0 */
+		enet2: ethernet@26000 {
+			#address-cells = <1>;
+			#size-cells = <1>;
+			cell-index = <2>;
+			device_type = "network";
+			model = "eTSEC";
+			compatible = "gianfar";
+			reg = <0x26000 0x1000>;
+			ranges = <0x0 0x26000 0x1000>;
+			local-mac-address = [ 00 00 00 00 00 00 ];
+			interrupts = <31 2 32 2 33 2>;
+			interrupt-parent = <&mpic>;
+			tbi-handle = <&tbi2>;
+			phy-handle = <&phy2>;
+			phy-connection-type = "sgmii";
+
+			mdio@520 {
+				#address-cells = <1>;
+				#size-cells = <0>;
+				compatible = "fsl,gianfar-tbi";
+				reg = <0x520 0x20>;
+
+				tbi2: tbi-phy@11 {
+					reg = <0x11>;
+					device_type = "tbi-phy";
+				};
+			};
+		};
+
+		/* eTSEC 4 PICMG2.16 backplane port 1 */
+		enet3: ethernet@27000 {
+			#address-cells = <1>;
+			#size-cells = <1>;
+			cell-index = <3>;
+			device_type = "network";
+			model = "eTSEC";
+			compatible = "gianfar";
+			reg = <0x27000 0x1000>;
+			ranges = <0x0 0x27000 0x1000>;
+			local-mac-address = [ 00 00 00 00 00 00 ];
+			interrupts = <37 2 38 2 39 2>;
+			interrupt-parent = <&mpic>;
+			tbi-handle = <&tbi3>;
+			phy-handle = <&phy3>;
+			phy-connection-type = "sgmii";
+
+			mdio@520 {
+				#address-cells = <1>;
+				#size-cells = <0>;
+				compatible = "fsl,gianfar-tbi";
+				reg = <0x520 0x20>;
+
+				tbi3: tbi-phy@11 {
+					reg = <0x11>;
+					device_type = "tbi-phy";
+				};
+			};
+		};
+
+		/* UART0 */
+		serial0: serial@4500 {
+			cell-index = <0>;
+			device_type = "serial";
+			compatible = "ns16550";
+			reg = <0x4500 0x100>;
+			clock-frequency = <0>;
+			interrupts = <42 2>;
+			interrupt-parent = <&mpic>;
+		};
+
+		/* UART1 */
+		serial1: serial@4600 {
+			cell-index = <1>;
+			device_type = "serial";
+			compatible = "ns16550";
+			reg = <0x4600 0x100>;
+			clock-frequency = <0>;
+			interrupts = <42 2>;
+			interrupt-parent = <&mpic>;
+		};
+
+		global-utilities@e0000 {	//global utilities block
+			compatible = "fsl,mpc8572-guts";
+			reg = <0xe0000 0x1000>;
+			fsl,has-rstcr;
+		};
+
+		msi@41600 {
+			compatible = "fsl,mpc8572-msi", "fsl,mpic-msi";
+			reg = <0x41600 0x80>;
+			msi-available-ranges = <0 0x100>;
+			interrupts = <
+				0xe0 0
+				0xe1 0
+				0xe2 0
+				0xe3 0
+				0xe4 0
+				0xe5 0
+				0xe6 0
+				0xe7 0>;
+			interrupt-parent = <&mpic>;
+		};
+
+		crypto@30000 {
+			compatible = "fsl,sec3.0", "fsl,sec2.4", "fsl,sec2.2",
+				     "fsl,sec2.1", "fsl,sec2.0";
+			reg = <0x30000 0x10000>;
+			interrupts = <45 2 58 2>;
+			interrupt-parent = <&mpic>;
+			fsl,num-channels = <4>;
+			fsl,channel-fifo-len = <24>;
+			fsl,exec-units-mask = <0x9fe>;
+			fsl,descriptor-types-mask = <0x3ab0ebf>;
+		};
+
+		mpic: pic@40000 {
+			interrupt-controller;
+			#address-cells = <0>;
+			#interrupt-cells = <2>;
+			reg = <0x40000 0x40000>;
+			compatible = "chrp,open-pic";
+			device_type = "open-pic";
+		};
+
+		gpio0: gpio@f000 {
+			compatible = "fsl,mpc8572-gpio";
+			reg = <0xf000 0x1000>;
+			interrupts = <47 2>;
+			interrupt-parent = <&mpic>;
+			#gpio-cells = <2>;
+			gpio-controller;
+		};
+
+		gpio-leds {
+			compatible = "gpio-leds";
+
+			heartbeat {
+				label = "Heartbeat";
+				gpios = <&gpio0 4 1>;
+				linux,default-trigger = "heartbeat";
+			};
+
+			yellow {
+				label = "Yellow";
+				gpios = <&gpio0 5 1>;
+			};
+
+			red {
+				label = "Red";
+				gpios = <&gpio0 6 1>;
+			};
+
+			green {
+				label = "Green";
+				gpios = <&gpio0 7 1>;
+			};
+		};
+
+		/* PME (pattern-matcher) */
+		pme@10000 {
+			compatible = "fsl,mpc8572-pme", "pme8572";
+			reg = <0x10000 0x5000>;
+			interrupts = <57 2 64 2 65 2 66 2 67 2>;
+			interrupt-parent = <&mpic>;
+		};
+
+		tlu@2f000 {
+			compatible = "fsl,mpc8572-tlu", "fsl_tlu";
+			reg = <0x2f000 0x1000>;
+			interupts = <61 2 >;
+			interrupt-parent = <&mpic>;
+		};
+
+		tlu@15000 {
+			compatible = "fsl,mpc8572-tlu", "fsl_tlu";
+			reg = <0x15000 0x1000>;
+			interupts = <75 2>;
+			interrupt-parent = <&mpic>;
+		};
+	};
+
+	/*
+	 * PCI Express controller 3 @ ef008000 is not used.
+	 * This would have been pci0 on other mpc85xx platforms.
+	 *
+	 * PCI Express controller 2 @ ef009000 is not used.
+	 * This would have been pci1 on other mpc85xx platforms.
+	 */
+
+	/* PCI Express controller 1, wired to PEX8648 PCIe switch */
+	pci2: pcie@ef00a000 {
+		compatible = "fsl,mpc8548-pcie";
+		device_type = "pci";
+		#interrupt-cells = <1>;
+		#size-cells = <2>;
+		#address-cells = <3>;
+		reg = <0 0xef00a000 0 0x1000>;
+		bus-range = <0 255>;
+		ranges = <0x2000000 0x0 0x80000000 0 0x80000000 0x0 0x40000000
+			  0x1000000 0x0 0x00000000 0 0xe8000000 0x0 0x10000>;
+		clock-frequency = <33333333>;
+		interrupt-parent = <&mpic>;
+		interrupts = <26 2>;
+		interrupt-map-mask = <0xf800 0x0 0x0 0x7>;
+		interrupt-map = <
+			/* IDSEL 0x0 */
+			0x0 0x0 0x0 0x1 &mpic 0x0 0x1
+			0x0 0x0 0x0 0x2 &mpic 0x1 0x1
+			0x0 0x0 0x0 0x3 &mpic 0x2 0x1
+			0x0 0x0 0x0 0x4 &mpic 0x3 0x1
+			>;
+		pcie@0 {
+			reg = <0x0 0x0 0x0 0x0 0x0>;
+			#size-cells = <2>;
+			#address-cells = <3>;
+			device_type = "pci";
+			ranges = <0x2000000 0x0 0x80000000
+				  0x2000000 0x0 0x80000000
+				  0x0 0x40000000
+
+				  0x1000000 0x0 0x0
+				  0x1000000 0x0 0x0
+				  0x0 0x100000>;
+		};
+	};
+};
diff --git a/arch/powerpc/boot/dts/xpedite5200.dts b/arch/powerpc/boot/dts/xpedite5200.dts
new file mode 100644
index 0000000..a0cf53f
--- /dev/null
+++ b/arch/powerpc/boot/dts/xpedite5200.dts
@@ -0,0 +1,466 @@
+/*
+ * Copyright (C) 2009 Extreme Engineering Solutions, Inc.
+ * Based on TQM8548 device tree
+ *
+ * XPedite5200 PrPMC/XMC module based on MPC8548E
+ *
+ * This is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+/dts-v1/;
+
+/ {
+	model = "xes,xpedite5200";
+	compatible = "xes,xpedite5200", "xes,MPC8548";
+	#address-cells = <1>;
+	#size-cells = <1>;
+
+	aliases {
+		ethernet0 = &enet0;
+		ethernet1 = &enet1;
+		ethernet2 = &enet2;
+		ethernet3 = &enet3;
+
+		serial0 = &serial0;
+		serial1 = &serial1;
+		pci0 = &pci0;
+	};
+
+	cpus {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		PowerPC,8548@0 {
+			device_type = "cpu";
+			reg = <0>;
+			d-cache-line-size = <32>;	// 32 bytes
+			i-cache-line-size = <32>;	// 32 bytes
+			d-cache-size = <0x8000>;	// L1, 32K
+			i-cache-size = <0x8000>;	// L1, 32K
+			next-level-cache = <&L2>;
+		};
+	};
+
+	memory {
+		device_type = "memory";
+		reg = <0x0 0x0>;	// Filled in by U-Boot
+	};
+
+	soc@ef000000 {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		device_type = "soc";
+		ranges = <0x0 0xef000000 0x100000>;
+		bus-frequency = <0>;
+		compatible = "fsl,mpc8548-immr", "simple-bus";
+
+		ecm-law@0 {
+			compatible = "fsl,ecm-law";
+			reg = <0x0 0x1000>;
+			fsl,num-laws = <12>;
+		};
+
+		ecm@1000 {
+			compatible = "fsl,mpc8548-ecm", "fsl,ecm";
+			reg = <0x1000 0x1000>;
+			interrupts = <17 2>;
+			interrupt-parent = <&mpic>;
+		};
+
+		memory-controller@2000 {
+			compatible = "fsl,mpc8548-memory-controller";
+			reg = <0x2000 0x1000>;
+			interrupt-parent = <&mpic>;
+			interrupts = <18 2>;
+		};
+
+		L2: l2-cache-controller@20000 {
+			compatible = "fsl,mpc8548-l2-cache-controller";
+			reg = <0x20000 0x1000>;
+			cache-line-size = <32>;	// 32 bytes
+			cache-size = <0x80000>;	// L2, 512K
+			interrupt-parent = <&mpic>;
+			interrupts = <16 2>;
+		};
+
+		/* On-card I2C */
+		i2c@3000 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			cell-index = <0>;
+			compatible = "fsl-i2c";
+			reg = <0x3000 0x100>;
+			interrupts = <43 2>;
+			interrupt-parent = <&mpic>;
+			dfsrr;
+
+			/*
+			 * Board GPIO:
+			 * 	0: BRD_CFG0 (1: P14 IO present)
+			 * 	1: BRD_CFG1 (1: FP ethernet present)
+			 * 	2: BRD_CFG2 (1: XMC IO present)
+			 * 	3: XMC root complex indicator
+			 * 	4: Flash boot device indicator
+			 * 	5: Flash write protect enable
+			 * 	6: PMC monarch indicator
+			 * 	7: PMC EREADY
+			 */
+			gpio1: gpio@18 {
+				compatible = "nxp,pca9556";
+				reg = <0x18>;
+				#gpio-cells = <2>;
+				gpio-controller;
+				polarity = <0x00>;
+			};
+
+			/* P14 GPIO */
+			gpio2: gpio@19 {
+				compatible = "nxp,pca9556";
+				reg = <0x19>;
+				#gpio-cells = <2>;
+				gpio-controller;
+				polarity = <0x00>;
+			};
+
+			eeprom@50 {
+				compatible = "atmel,at24c16";
+				reg = <0x50>;
+			};
+
+			rtc@68 {
+				compatible = "stm,m41t00",
+					     "dallas,ds1338";
+				reg = <0x68>;
+			};
+
+			dtt@48 {
+				compatible = "maxim,max1237";
+				reg = <0x34>;
+			};
+		};
+
+		/* Off-card I2C */
+		i2c@3100 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			cell-index = <1>;
+			compatible = "fsl-i2c";
+			reg = <0x3100 0x100>;
+			interrupts = <43 2>;
+			interrupt-parent = <&mpic>;
+			dfsrr;
+		};
+
+		dma@21300 {
+			#address-cells = <1>;
+			#size-cells = <1>;
+			compatible = "fsl,mpc8548-dma", "fsl,eloplus-dma";
+			reg = <0x21300 0x4>;
+			ranges = <0x0 0x21100 0x200>;
+			cell-index = <0>;
+			dma-channel@0 {
+				compatible = "fsl,mpc8548-dma-channel",
+						"fsl,eloplus-dma-channel";
+				reg = <0x0 0x80>;
+				cell-index = <0>;
+				interrupt-parent = <&mpic>;
+				interrupts = <20 2>;
+			};
+			dma-channel@80 {
+				compatible = "fsl,mpc8548-dma-channel",
+						"fsl,eloplus-dma-channel";
+				reg = <0x80 0x80>;
+				cell-index = <1>;
+				interrupt-parent = <&mpic>;
+				interrupts = <21 2>;
+			};
+			dma-channel@100 {
+				compatible = "fsl,mpc8548-dma-channel",
+						"fsl,eloplus-dma-channel";
+				reg = <0x100 0x80>;
+				cell-index = <2>;
+				interrupt-parent = <&mpic>;
+				interrupts = <22 2>;
+			};
+			dma-channel@180 {
+				compatible = "fsl,mpc8548-dma-channel",
+						"fsl,eloplus-dma-channel";
+				reg = <0x180 0x80>;
+				cell-index = <3>;
+				interrupt-parent = <&mpic>;
+				interrupts = <23 2>;
+			};
+		};
+
+		/* eTSEC1: Front panel port 0 */
+		enet0: ethernet@24000 {
+			#address-cells = <1>;
+			#size-cells = <1>;
+			cell-index = <0>;
+			device_type = "network";
+			model = "eTSEC";
+			compatible = "gianfar";
+			reg = <0x24000 0x1000>;
+			ranges = <0x0 0x24000 0x1000>;
+			local-mac-address = [ 00 00 00 00 00 00 ];
+			interrupts = <29 2 30 2 34 2>;
+			interrupt-parent = <&mpic>;
+			tbi-handle = <&tbi0>;
+			phy-handle = <&phy0>;
+
+			mdio@520 {
+				#address-cells = <1>;
+				#size-cells = <0>;
+				compatible = "fsl,gianfar-mdio";
+				reg = <0x520 0x20>;
+
+				phy0: ethernet-phy@1 {
+					interrupt-parent = <&mpic>;
+					interrupts = <8 1>;
+					reg = <0x1>;
+				};
+				phy1: ethernet-phy@2 {
+					interrupt-parent = <&mpic>;
+					interrupts = <8 1>;
+					reg = <0x2>;
+				};
+				phy2: ethernet-phy@3 {
+					interrupt-parent = <&mpic>;
+					interrupts = <8 1>;
+					reg = <0x3>;
+				};
+				phy3: ethernet-phy@4 {
+					interrupt-parent = <&mpic>;
+					interrupts = <8 1>;
+					reg = <0x4>;
+				};
+				tbi0: tbi-phy@11 {
+					reg = <0x11>;
+					device_type = "tbi-phy";
+				};
+			};
+		};
+
+		/* eTSEC2: Front panel port 1 */
+		enet1: ethernet@25000 {
+			#address-cells = <1>;
+			#size-cells = <1>;
+			cell-index = <1>;
+			device_type = "network";
+			model = "eTSEC";
+			compatible = "gianfar";
+			reg = <0x25000 0x1000>;
+			ranges = <0x0 0x25000 0x1000>;
+			local-mac-address = [ 00 00 00 00 00 00 ];
+			interrupts = <35 2 36 2 40 2>;
+			interrupt-parent = <&mpic>;
+			tbi-handle = <&tbi1>;
+			phy-handle = <&phy1>;
+
+			mdio@520 {
+				#address-cells = <1>;
+				#size-cells = <0>;
+				compatible = "fsl,gianfar-tbi";
+				reg = <0x520 0x20>;
+
+				tbi1: tbi-phy@11 {
+					reg = <0x11>;
+					device_type = "tbi-phy";
+				};
+			};
+		};
+
+		/* eTSEC3: Rear panel port 2 */
+		enet2: ethernet@26000 {
+			#address-cells = <1>;
+			#size-cells = <1>;
+			cell-index = <2>;
+			device_type = "network";
+			model = "eTSEC";
+			compatible = "gianfar";
+			reg = <0x26000 0x1000>;
+			ranges = <0x0 0x26000 0x1000>;
+			local-mac-address = [ 00 00 00 00 00 00 ];
+			interrupts = <31 2 32 2 33 2>;
+			interrupt-parent = <&mpic>;
+			tbi-handle = <&tbi2>;
+			phy-handle = <&phy2>;
+
+			mdio@520 {
+				#address-cells = <1>;
+				#size-cells = <0>;
+				compatible = "fsl,gianfar-tbi";
+				reg = <0x520 0x20>;
+
+				tbi2: tbi-phy@11 {
+					reg = <0x11>;
+					device_type = "tbi-phy";
+				};
+			};
+		};
+
+		/* eTSEC4: Rear panel port 3 */
+		enet3: ethernet@27000 {
+			#address-cells = <1>;
+			#size-cells = <1>;
+			cell-index = <3>;
+			device_type = "network";
+			model = "eTSEC";
+			compatible = "gianfar";
+			reg = <0x27000 0x1000>;
+			ranges = <0x0 0x27000 0x1000>;
+			local-mac-address = [ 00 00 00 00 00 00 ];
+			interrupts = <37 2 38 2 39 2>;
+			interrupt-parent = <&mpic>;
+			tbi-handle = <&tbi3>;
+			phy-handle = <&phy3>;
+
+			mdio@520 {
+				#address-cells = <1>;
+				#size-cells = <0>;
+				compatible = "fsl,gianfar-tbi";
+				reg = <0x520 0x20>;
+
+				tbi3: tbi-phy@11 {
+					reg = <0x11>;
+					device_type = "tbi-phy";
+				};
+			};
+		};
+
+		serial0: serial@4500 {
+			cell-index = <0>;
+			device_type = "serial";
+			compatible = "ns16550";
+			reg = <0x4500 0x100>;
+			clock-frequency = <0>;
+			current-speed = <115200>;
+			interrupts = <42 2>;
+			interrupt-parent = <&mpic>;
+		};
+
+		serial1: serial@4600 {
+			cell-index = <1>;
+			device_type = "serial";
+			compatible = "ns16550";
+			reg = <0x4600 0x100>;
+			clock-frequency = <0>;
+			current-speed = <115200>;
+			interrupts = <42 2>;
+			interrupt-parent = <&mpic>;
+		};
+
+		global-utilities@e0000 {	// global utilities reg
+			compatible = "fsl,mpc8548-guts";
+			reg = <0xe0000 0x1000>;
+			fsl,has-rstcr;
+		};
+
+		mpic: pic@40000 {
+			interrupt-controller;
+			#address-cells = <0>;
+			#interrupt-cells = <2>;
+			reg = <0x40000 0x40000>;
+			compatible = "chrp,open-pic";
+			device_type = "open-pic";
+		};
+	};
+
+	localbus@ef005000 {
+		compatible = "fsl,mpc8548-localbus", "fsl,pq3-localbus",
+			     "simple-bus";
+		#address-cells = <2>;
+		#size-cells = <1>;
+		reg = <0xef005000 0x100>;	// BRx, ORx, etc.
+
+		ranges = <
+			0 0x0 0xfc000000 0x04000000	// NOR boot flash
+			1 0x0 0xf8000000 0x04000000	// NOR expansion flash
+			2 0x0 0xef800000 0x00010000	// NAND CE1
+			3 0x0 0xef840000 0x00010000	// NAND CE2
+		>;
+
+		nor-boot@0,0 {
+			#address-cells = <1>;
+			#size-cells = <1>;
+			compatible = "cfi-flash";
+			reg = <0 0x0 0x4000000>;
+			bank-width = <2>;
+
+			partition@0 {
+				label = "Primary OS";
+				reg = <0x00000000 0x180000>;
+			};
+			partition@180000 {
+				label = "Secondary OS";
+				reg = <0x00180000 0x180000>;
+			};
+			partition@300000 {
+				label = "User";
+				reg = <0x00300000 0x3c80000>;
+			};
+			partition@3f80000 {
+				label = "Boot firmware";
+				reg = <0x03f80000 0x80000>;
+			};
+		};
+
+		nor-alternate@1,0 {
+			#address-cells = <1>;
+			#size-cells = <1>;
+			compatible = "cfi-flash";
+			reg = <1 0x0 0x4000000>;
+			bank-width = <2>;
+
+			partition@0 {
+				label = "Filesystem";
+				reg = <0x00000000 0x3f80000>;
+			};
+			partition@3f80000 {
+				label = "Alternate boot firmware";
+				reg = <0x03f80000 0x80000>;
+			};
+		};
+
+		nand@2,0 {
+			#address-cells = <1>;
+			#size-cells = <1>;
+			compatible = "xes,address-ctl-nand";
+			reg = <2 0x0 0x10000>;
+			cle-line = <0x8>;	/* CLE tied to A3 */
+			ale-line = <0x10>;	/* ALE tied to A4 */
+
+			/* U-Boot should fix this up */
+			partition@0 {
+				label = "NAND Filesystem";
+				reg = <0 0x40000000>;
+			};
+		};
+	};
+
+	/* PMC interface */
+	pci0: pci@ef008000 {
+		#interrupt-cells = <1>;
+		#size-cells = <2>;
+		#address-cells = <3>;
+		compatible = "fsl,mpc8540-pcix", "fsl,mpc8540-pci";
+		device_type = "pci";
+		reg = <0xef008000 0x1000>;
+		clock-frequency = <33333333>;
+		interrupt-map-mask = <0xf800 0x0 0x0 0x7>;
+		interrupt-map = <
+				/* IDSEL */
+				 0xe000 0 0 1 &mpic 2 1
+				 0xe000 0 0 2 &mpic 3 1>;
+
+		interrupt-parent = <&mpic>;
+		interrupts = <24 2>;
+		bus-range = <0 0>;
+		ranges = <0x02000000 0 0x80000000 0x80000000 0 0x40000000
+			  0x01000000 0 0x00000000 0xe8000000 0 0x00800000>;
+	};
+
+	/* XMC PCIe is not yet enabled in U-Boot on XPedite5200 */
+};
diff --git a/arch/powerpc/boot/dts/xpedite5200_xmon.dts b/arch/powerpc/boot/dts/xpedite5200_xmon.dts
new file mode 100644
index 0000000..c5b2975
--- /dev/null
+++ b/arch/powerpc/boot/dts/xpedite5200_xmon.dts
@@ -0,0 +1,506 @@
+/*
+ * Copyright (C) 2009 Extreme Engineering Solutions, Inc.
+ * Based on TQM8548 device tree
+ *
+ * XPedite5200 PrPMC/XMC module based on MPC8548E.  This dts is for the
+ * xMon boot loader memory map which differs from U-Boot's.
+ *
+ * This is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+/dts-v1/;
+
+/ {
+	model = "xes,xpedite5200";
+	compatible = "xes,xpedite5200", "xes,MPC8548";
+	#address-cells = <1>;
+	#size-cells = <1>;
+	form-factor = "PMC/XMC";
+	boot-bank = <0x0>;
+
+	aliases {
+		ethernet0 = &enet0;
+		ethernet1 = &enet1;
+		ethernet2 = &enet2;
+		ethernet3 = &enet3;
+
+		serial0 = &serial0;
+		serial1 = &serial1;
+		pci0 = &pci0;
+		pci1 = &pci1;
+	};
+
+	cpus {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		PowerPC,8548@0 {
+			device_type = "cpu";
+			reg = <0>;
+			d-cache-line-size = <32>;	// 32 bytes
+			i-cache-line-size = <32>;	// 32 bytes
+			d-cache-size = <0x8000>;	// L1, 32K
+			i-cache-size = <0x8000>;	// L1, 32K
+			next-level-cache = <&L2>;
+		};
+	};
+
+	memory {
+		device_type = "memory";
+		reg = <0x0 0x0>;	// Filled in by boot loader
+	};
+
+	soc@ef000000 {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		device_type = "soc";
+		ranges = <0x0 0xef000000 0x100000>;
+		bus-frequency = <0>;
+		compatible = "fsl,mpc8548-immr", "simple-bus";
+
+		ecm-law@0 {
+			compatible = "fsl,ecm-law";
+			reg = <0x0 0x1000>;
+			fsl,num-laws = <12>;
+		};
+
+		ecm@1000 {
+			compatible = "fsl,mpc8548-ecm", "fsl,ecm";
+			reg = <0x1000 0x1000>;
+			interrupts = <17 2>;
+			interrupt-parent = <&mpic>;
+		};
+
+		memory-controller@2000 {
+			compatible = "fsl,mpc8548-memory-controller";
+			reg = <0x2000 0x1000>;
+			interrupt-parent = <&mpic>;
+			interrupts = <18 2>;
+		};
+
+		L2: l2-cache-controller@20000 {
+			compatible = "fsl,mpc8548-l2-cache-controller";
+			reg = <0x20000 0x1000>;
+			cache-line-size = <32>;	// 32 bytes
+			cache-size = <0x80000>;	// L2, 512K
+			interrupt-parent = <&mpic>;
+			interrupts = <16 2>;
+		};
+
+		/* On-card I2C */
+		i2c@3000 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			cell-index = <0>;
+			compatible = "fsl-i2c";
+			reg = <0x3000 0x100>;
+			interrupts = <43 2>;
+			interrupt-parent = <&mpic>;
+			dfsrr;
+
+			/*
+			 * Board GPIO:
+			 * 	0: BRD_CFG0 (1: P14 IO present)
+			 * 	1: BRD_CFG1 (1: FP ethernet present)
+			 * 	2: BRD_CFG2 (1: XMC IO present)
+			 * 	3: XMC root complex indicator
+			 * 	4: Flash boot device indicator
+			 * 	5: Flash write protect enable
+			 * 	6: PMC monarch indicator
+			 * 	7: PMC EREADY
+			 */
+			gpio1: gpio@18 {
+				compatible = "nxp,pca9556";
+				reg = <0x18>;
+				#gpio-cells = <2>;
+				gpio-controller;
+				polarity = <0x00>;
+			};
+
+			/* P14 GPIO */
+			gpio2: gpio@19 {
+				compatible = "nxp,pca9556";
+				reg = <0x19>;
+				#gpio-cells = <2>;
+				gpio-controller;
+				polarity = <0x00>;
+			};
+
+			eeprom@50 {
+				compatible = "atmel,at24c16";
+				reg = <0x50>;
+			};
+
+			rtc@68 {
+				compatible = "stm,m41t00",
+					     "dallas,ds1338";
+				reg = <0x68>;
+			};
+
+			dtt@48 {
+				compatible = "maxim,max1237";
+				reg = <0x34>;
+			};
+		};
+
+		/* Off-card I2C */
+		i2c@3100 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			cell-index = <1>;
+			compatible = "fsl-i2c";
+			reg = <0x3100 0x100>;
+			interrupts = <43 2>;
+			interrupt-parent = <&mpic>;
+			dfsrr;
+		};
+
+		dma@21300 {
+			#address-cells = <1>;
+			#size-cells = <1>;
+			compatible = "fsl,mpc8548-dma", "fsl,eloplus-dma";
+			reg = <0x21300 0x4>;
+			ranges = <0x0 0x21100 0x200>;
+			cell-index = <0>;
+			dma-channel@0 {
+				compatible = "fsl,mpc8548-dma-channel",
+						"fsl,eloplus-dma-channel";
+				reg = <0x0 0x80>;
+				cell-index = <0>;
+				interrupt-parent = <&mpic>;
+				interrupts = <20 2>;
+			};
+			dma-channel@80 {
+				compatible = "fsl,mpc8548-dma-channel",
+						"fsl,eloplus-dma-channel";
+				reg = <0x80 0x80>;
+				cell-index = <1>;
+				interrupt-parent = <&mpic>;
+				interrupts = <21 2>;
+			};
+			dma-channel@100 {
+				compatible = "fsl,mpc8548-dma-channel",
+						"fsl,eloplus-dma-channel";
+				reg = <0x100 0x80>;
+				cell-index = <2>;
+				interrupt-parent = <&mpic>;
+				interrupts = <22 2>;
+			};
+			dma-channel@180 {
+				compatible = "fsl,mpc8548-dma-channel",
+						"fsl,eloplus-dma-channel";
+				reg = <0x180 0x80>;
+				cell-index = <3>;
+				interrupt-parent = <&mpic>;
+				interrupts = <23 2>;
+			};
+		};
+
+		/* eTSEC1: Front panel port 0 */
+		enet0: ethernet@24000 {
+			#address-cells = <1>;
+			#size-cells = <1>;
+			cell-index = <0>;
+			device_type = "network";
+			model = "eTSEC";
+			compatible = "gianfar";
+			reg = <0x24000 0x1000>;
+			ranges = <0x0 0x24000 0x1000>;
+			local-mac-address = [ 00 00 00 00 00 00 ];
+			interrupts = <29 2 30 2 34 2>;
+			interrupt-parent = <&mpic>;
+			tbi-handle = <&tbi0>;
+			phy-handle = <&phy0>;
+
+			mdio@520 {
+				#address-cells = <1>;
+				#size-cells = <0>;
+				compatible = "fsl,gianfar-mdio";
+				reg = <0x520 0x20>;
+
+				phy0: ethernet-phy@1 {
+					interrupt-parent = <&mpic>;
+					interrupts = <8 1>;
+					reg = <0x1>;
+				};
+				phy1: ethernet-phy@2 {
+					interrupt-parent = <&mpic>;
+					interrupts = <8 1>;
+					reg = <0x2>;
+				};
+				phy2: ethernet-phy@3 {
+					interrupt-parent = <&mpic>;
+					interrupts = <8 1>;
+					reg = <0x3>;
+				};
+				phy3: ethernet-phy@4 {
+					interrupt-parent = <&mpic>;
+					interrupts = <8 1>;
+					reg = <0x4>;
+				};
+				tbi0: tbi-phy@11 {
+					reg = <0x11>;
+					device_type = "tbi-phy";
+				};
+			};
+		};
+
+		/* eTSEC2: Front panel port 1 */
+		enet1: ethernet@25000 {
+			#address-cells = <1>;
+			#size-cells = <1>;
+			cell-index = <1>;
+			device_type = "network";
+			model = "eTSEC";
+			compatible = "gianfar";
+			reg = <0x25000 0x1000>;
+			ranges = <0x0 0x25000 0x1000>;
+			local-mac-address = [ 00 00 00 00 00 00 ];
+			interrupts = <35 2 36 2 40 2>;
+			interrupt-parent = <&mpic>;
+			tbi-handle = <&tbi1>;
+			phy-handle = <&phy1>;
+
+			mdio@520 {
+				#address-cells = <1>;
+				#size-cells = <0>;
+				compatible = "fsl,gianfar-tbi";
+				reg = <0x520 0x20>;
+
+				tbi1: tbi-phy@11 {
+					reg = <0x11>;
+					device_type = "tbi-phy";
+				};
+			};
+		};
+
+		/* eTSEC3: Rear panel port 2 */
+		enet2: ethernet@26000 {
+			#address-cells = <1>;
+			#size-cells = <1>;
+			cell-index = <2>;
+			device_type = "network";
+			model = "eTSEC";
+			compatible = "gianfar";
+			reg = <0x26000 0x1000>;
+			ranges = <0x0 0x26000 0x1000>;
+			local-mac-address = [ 00 00 00 00 00 00 ];
+			interrupts = <31 2 32 2 33 2>;
+			interrupt-parent = <&mpic>;
+			tbi-handle = <&tbi2>;
+			phy-handle = <&phy2>;
+
+			mdio@520 {
+				#address-cells = <1>;
+				#size-cells = <0>;
+				compatible = "fsl,gianfar-tbi";
+				reg = <0x520 0x20>;
+
+				tbi2: tbi-phy@11 {
+					reg = <0x11>;
+					device_type = "tbi-phy";
+				};
+			};
+		};
+
+		/* eTSEC4: Rear panel port 3 */
+		enet3: ethernet@27000 {
+			#address-cells = <1>;
+			#size-cells = <1>;
+			cell-index = <3>;
+			device_type = "network";
+			model = "eTSEC";
+			compatible = "gianfar";
+			reg = <0x27000 0x1000>;
+			ranges = <0x0 0x27000 0x1000>;
+			local-mac-address = [ 00 00 00 00 00 00 ];
+			interrupts = <37 2 38 2 39 2>;
+			interrupt-parent = <&mpic>;
+			tbi-handle = <&tbi3>;
+			phy-handle = <&phy3>;
+
+			mdio@520 {
+				#address-cells = <1>;
+				#size-cells = <0>;
+				compatible = "fsl,gianfar-tbi";
+				reg = <0x520 0x20>;
+
+				tbi3: tbi-phy@11 {
+					reg = <0x11>;
+					device_type = "tbi-phy";
+				};
+			};
+		};
+
+		serial0: serial@4500 {
+			cell-index = <0>;
+			device_type = "serial";
+			compatible = "ns16550";
+			reg = <0x4500 0x100>;
+			clock-frequency = <0>;
+			current-speed = <9600>;
+			interrupts = <42 2>;
+			interrupt-parent = <&mpic>;
+		};
+
+		serial1: serial@4600 {
+			cell-index = <1>;
+			device_type = "serial";
+			compatible = "ns16550";
+			reg = <0x4600 0x100>;
+			clock-frequency = <0>;
+			current-speed = <9600>;
+			interrupts = <42 2>;
+			interrupt-parent = <&mpic>;
+		};
+
+		global-utilities@e0000 {	// global utilities reg
+			compatible = "fsl,mpc8548-guts";
+			reg = <0xe0000 0x1000>;
+			fsl,has-rstcr;
+		};
+
+		mpic: pic@40000 {
+			interrupt-controller;
+			#address-cells = <0>;
+			#interrupt-cells = <2>;
+			reg = <0x40000 0x40000>;
+			compatible = "chrp,open-pic";
+			device_type = "open-pic";
+		};
+	};
+
+	localbus@ef005000 {
+		compatible = "fsl,mpc8548-localbus", "fsl,pq3-localbus",
+			     "simple-bus";
+		#address-cells = <2>;
+		#size-cells = <1>;
+		reg = <0xef005000 0x100>;	// BRx, ORx, etc.
+
+		ranges = <
+			0 0x0 0xf8000000 0x08000000	// NOR boot flash
+			1 0x0 0xf0000000 0x08000000	// NOR expansion flash
+			2 0x0 0xe8000000 0x00010000	// NAND CE1
+			3 0x0 0xe8010000 0x00010000	// NAND CE2
+		>;
+
+		nor-boot@0,0 {
+			#address-cells = <1>;
+			#size-cells = <1>;
+			compatible = "cfi-flash";
+			reg = <0 0x0 0x4000000>;
+			bank-width = <2>;
+
+			partition@0 {
+				label = "Primary OS";
+				reg = <0x00000000 0x180000>;
+			};
+			partition@180000 {
+				label = "Secondary OS";
+				reg = <0x00180000 0x180000>;
+			};
+			partition@300000 {
+				label = "User";
+				reg = <0x00300000 0x3c80000>;
+			};
+			partition@3f80000 {
+				label = "Boot firmware";
+				reg = <0x03f80000 0x80000>;
+			};
+		};
+
+		nor-alternate@1,0 {
+			#address-cells = <1>;
+			#size-cells = <1>;
+			compatible = "cfi-flash";
+			reg = <1 0x0 0x4000000>;
+			bank-width = <2>;
+
+			partition@0 {
+				label = "Filesystem";
+				reg = <0x00000000 0x3f80000>;
+			};
+			partition@3f80000 {
+				label = "Alternate boot firmware";
+				reg = <0x03f80000 0x80000>;
+			};
+		};
+
+		nand@2,0 {
+			#address-cells = <1>;
+			#size-cells = <1>;
+			compatible = "xes,address-ctl-nand";
+			reg = <2 0x0 0x10000>;
+			cle-line = <0x8>;	/* CLE tied to A3 */
+			ale-line = <0x10>;	/* ALE tied to A4 */
+
+			partition@0 {
+				label = "NAND Filesystem";
+				reg = <0 0x40000000>;
+			};
+		};
+	};
+
+	/* PMC interface */
+	pci0: pci@ef008000 {
+		#interrupt-cells = <1>;
+		#size-cells = <2>;
+		#address-cells = <3>;
+		compatible = "fsl,mpc8540-pcix", "fsl,mpc8540-pci";
+		device_type = "pci";
+		reg = <0xef008000 0x1000>;
+		clock-frequency = <33333333>;
+		interrupt-map-mask = <0xf800 0x0 0x0 0x7>;
+		interrupt-map = <
+				/* IDSEL */
+				 0xe000 0 0 1 &mpic 2 1
+				 0xe000 0 0 2 &mpic 3 1>;
+
+		interrupt-parent = <&mpic>;
+		interrupts = <24 2>;
+		bus-range = <0 0>;
+		ranges = <0x02000000 0 0x80000000 0x80000000 0 0x20000000
+			  0x01000000 0 0x00000000 0xd0000000 0 0x01000000>;
+	};
+
+	/* XMC PCIe */
+	pci1: pcie@ef00a000 {
+		interrupt-map-mask = <0xf800 0x0 0x0 0x7>;
+		interrupt-map = <
+			/* IDSEL 0x0 */
+			0x00000 0 0 1 &mpic 0 1
+			0x00000 0 0 2 &mpic 1 1
+			0x00000 0 0 3 &mpic 2 1
+			0x00000 0 0 4 &mpic 3 1>;
+
+		interrupt-parent = <&mpic>;
+		interrupts = <26 2>;
+		bus-range = <0 0xff>;
+		ranges = <0x02000000 0 0xa0000000 0xa0000000 0 0x20000000
+			  0x01000000 0 0x00000000 0xd1000000 0 0x01000000>;
+		clock-frequency = <33333333>;
+		#interrupt-cells = <1>;
+		#size-cells = <2>;
+		#address-cells = <3>;
+		reg = <0xef00a000 0x1000>;
+		compatible = "fsl,mpc8548-pcie";
+		device_type = "pci";
+		pcie@0 {
+			reg = <0 0 0 0 0>;
+			#size-cells = <2>;
+			#address-cells = <3>;
+			device_type = "pci";
+			ranges = <0x02000000 0 0xc0000000 0x02000000 0
+			          0xc0000000 0 0x20000000
+				  0x01000000 0 0x00000000 0x01000000 0
+				  0x00000000 0 0x08000000>;
+		};
+	};
+
+	/* Needed for dtbImage boot wrapper compatibility */
+	chosen {
+		linux,stdout-path = &serial0;
+	};
+};
diff --git a/arch/powerpc/boot/dts/xpedite5301.dts b/arch/powerpc/boot/dts/xpedite5301.dts
new file mode 100644
index 0000000..db7faf5
--- /dev/null
+++ b/arch/powerpc/boot/dts/xpedite5301.dts
@@ -0,0 +1,640 @@
+/*
+ * Copyright (C) 2008 Extreme Engineering Solutions, Inc.
+ * Based on MPC8572DS device tree from Freescale Semiconductor, Inc.
+ *
+ * XPedite5301 PMC/XMC module based on MPC8572E
+ *
+ * This is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+/dts-v1/;
+/ {
+	model = "xes,xpedite5301";
+	compatible = "xes,xpedite5301", "xes,MPC8572";
+	#address-cells = <2>;
+	#size-cells = <2>;
+	form-factor = "PMC/XMC";
+	boot-bank = <0x0>;	/* 0: Primary flash, 1: Secondary flash */
+
+	aliases {
+		ethernet0 = &enet0;
+		ethernet1 = &enet1;
+		serial0 = &serial0;
+		serial1 = &serial1;
+		pci1 = &pci1;
+		pci2 = &pci2;
+	};
+
+	cpus {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		PowerPC,8572@0 {
+			device_type = "cpu";
+			reg = <0x0>;
+			d-cache-line-size = <32>;	// 32 bytes
+			i-cache-line-size = <32>;	// 32 bytes
+			d-cache-size = <0x8000>;		// L1, 32K
+			i-cache-size = <0x8000>;		// L1, 32K
+			timebase-frequency = <0>;
+			bus-frequency = <0>;
+			clock-frequency = <0>;
+			next-level-cache = <&L2>;
+		};
+
+		PowerPC,8572@1 {
+			device_type = "cpu";
+			reg = <0x1>;
+			d-cache-line-size = <32>;	// 32 bytes
+			i-cache-line-size = <32>;	// 32 bytes
+			d-cache-size = <0x8000>;		// L1, 32K
+			i-cache-size = <0x8000>;		// L1, 32K
+			timebase-frequency = <0>;
+			bus-frequency = <0>;
+			clock-frequency = <0>;
+			next-level-cache = <&L2>;
+		};
+	};
+
+	memory {
+		device_type = "memory";
+		reg = <0x0 0x0 0x0 0x0>;	// Filled in by U-Boot
+	};
+
+	localbus@ef005000 {
+		#address-cells = <2>;
+		#size-cells = <1>;
+		compatible = "fsl,mpc8572-elbc", "fsl,elbc", "simple-bus";
+		reg = <0 0xef005000 0 0x1000>;
+		interrupts = <19 2>;
+		interrupt-parent = <&mpic>;
+		/* Local bus region mappings */
+		ranges = <0 0 0 0xf8000000 0x8000000 /* CS0: Boot flash */
+			  1 0 0 0xf0000000 0x8000000 /* CS1: Alternate flash */
+			  2 0 0 0xef800000 0x40000   /* CS2: NAND CE1 */
+			  3 0 0 0xef840000 0x40000>; /* CS3: NAND CE2 */
+
+		nor-boot@0,0 {
+			compatible = "amd,s29gl01gp", "cfi-flash";
+			bank-width = <2>;
+			reg = <0 0 0x8000000>; /* 128MB */
+			#address-cells = <1>;
+			#size-cells = <1>;
+			partition@0 {
+				label = "Primary user space";
+				reg = <0x00000000 0x6f00000>; /* 111 MB */
+			};
+			partition@6f00000 {
+				label = "Primary kernel";
+				reg = <0x6f00000 0x1000000>; /* 16 MB */
+			};
+			partition@7f00000 {
+				label = "Primary DTB";
+				reg = <0x7f00000 0x40000>; /* 256 KB */
+			};
+			partition@7f40000 {
+				label = "Primary U-Boot environment";
+				reg = <0x7f40000 0x40000>; /* 256 KB */
+			};
+			partition@7f80000 {
+				label = "Primary U-Boot";
+				reg = <0x7f80000 0x80000>; /* 512 KB */
+				read-only;
+			};
+		};
+
+		nor-alternate@1,0 {
+			compatible = "amd,s29gl01gp", "cfi-flash";
+			bank-width = <2>;
+			//reg = <0xf0000000 0x08000000>; /* 128MB */
+			reg = <1 0 0x8000000>; /* 128MB */
+			#address-cells = <1>;
+			#size-cells = <1>;
+			partition@0 {
+				label = "Secondary user space";
+				reg = <0x00000000 0x6f00000>; /* 111 MB */
+			};
+			partition@6f00000 {
+				label = "Secondary kernel";
+				reg = <0x6f00000 0x1000000>; /* 16 MB */
+			};
+			partition@7f00000 {
+				label = "Secondary DTB";
+				reg = <0x7f00000 0x40000>; /* 256 KB */
+			};
+			partition@7f40000 {
+				label = "Secondary U-Boot environment";
+				reg = <0x7f40000 0x40000>; /* 256 KB */
+			};
+			partition@7f80000 {
+				label = "Secondary U-Boot";
+				reg = <0x7f80000 0x80000>; /* 512 KB */
+				read-only;
+			};
+		};
+
+		nand@2,0 {
+			#address-cells = <1>;
+			#size-cells = <1>;
+			/*
+			 * Actual part could be ST Micro NAND08GW3B2A (1 GB),
+			 * Micron MT29F8G08DAA (2x 512 MB), or Micron
+			 * MT29F16G08FAA (2x 1 GB), depending on the build
+			 * configuration
+			 */
+			compatible = "fsl,mpc8572-fcm-nand",
+				     "fsl,elbc-fcm-nand";
+			reg = <2 0 0x40000>;
+			/* U-Boot should fix this up if chip size > 1 GB */
+			partition@0 {
+				label = "NAND Filesystem";
+				reg = <0 0x40000000>;
+			};
+		};
+
+	};
+
+	soc8572@ef000000 {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		device_type = "soc";
+		compatible = "fsl,mpc8572-immr", "simple-bus";
+		ranges = <0x0 0 0xef000000 0x100000>;
+		bus-frequency = <0>;		// Filled out by uboot.
+
+		ecm-law@0 {
+			compatible = "fsl,ecm-law";
+			reg = <0x0 0x1000>;
+			fsl,num-laws = <12>;
+		};
+
+		ecm@1000 {
+			compatible = "fsl,mpc8572-ecm", "fsl,ecm";
+			reg = <0x1000 0x1000>;
+			interrupts = <17 2>;
+			interrupt-parent = <&mpic>;
+		};
+
+		memory-controller@2000 {
+			compatible = "fsl,mpc8572-memory-controller";
+			reg = <0x2000 0x1000>;
+			interrupt-parent = <&mpic>;
+			interrupts = <18 2>;
+		};
+
+		memory-controller@6000 {
+			compatible = "fsl,mpc8572-memory-controller";
+			reg = <0x6000 0x1000>;
+			interrupt-parent = <&mpic>;
+			interrupts = <18 2>;
+		};
+
+		L2: l2-cache-controller@20000 {
+			compatible = "fsl,mpc8572-l2-cache-controller";
+			reg = <0x20000 0x1000>;
+			cache-line-size = <32>;	// 32 bytes
+			cache-size = <0x100000>; // L2, 1M
+			interrupt-parent = <&mpic>;
+			interrupts = <16 2>;
+		};
+
+		i2c@3000 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			cell-index = <0>;
+			compatible = "fsl-i2c";
+			reg = <0x3000 0x100>;
+			interrupts = <43 2>;
+			interrupt-parent = <&mpic>;
+			dfsrr;
+
+			temp-sensor@48 {
+				compatible = "dallas,ds1631", "dallas,ds1621";
+				reg = <0x48>;
+			};
+
+			temp-sensor@4c {
+				compatible = "adi,adt7461";
+				reg = <0x4c>;
+			};
+
+			cpu-supervisor@51 {
+				compatible = "dallas,ds4510";
+				reg = <0x51>;
+			};
+
+			eeprom@54 {
+				compatible = "atmel,at24c128b";
+				reg = <0x54>;
+			};
+
+			rtc@68 {
+				compatible = "stm,m41t00",
+				             "dallas,ds1338";
+				reg = <0x68>;
+			};
+
+			pcie-switch@70 {
+				compatible = "plx,pex8518";
+				reg = <0x70>;
+			};
+
+			gpio1: gpio@18 {
+				compatible = "nxp,pca9557";
+				reg = <0x18>;
+				#gpio-cells = <2>;
+				gpio-controller;
+				polarity = <0x00>;
+			};
+
+			gpio2: gpio@1c {
+				compatible = "nxp,pca9557";
+				reg = <0x1c>;
+				#gpio-cells = <2>;
+				gpio-controller;
+				polarity = <0x00>;
+			};
+
+			gpio3: gpio@1e {
+				compatible = "nxp,pca9557";
+				reg = <0x1e>;
+				#gpio-cells = <2>;
+				gpio-controller;
+				polarity = <0x00>;
+			};
+
+			gpio4: gpio@1f {
+				compatible = "nxp,pca9557";
+				reg = <0x1f>;
+				#gpio-cells = <2>;
+				gpio-controller;
+				polarity = <0x00>;
+			};
+		};
+
+		i2c@3100 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			cell-index = <1>;
+			compatible = "fsl-i2c";
+			reg = <0x3100 0x100>;
+			interrupts = <43 2>;
+			interrupt-parent = <&mpic>;
+			dfsrr;
+		};
+
+		dma@c300 {
+			#address-cells = <1>;
+			#size-cells = <1>;
+			compatible = "fsl,mpc8572-dma", "fsl,eloplus-dma";
+			reg = <0xc300 0x4>;
+			ranges = <0x0 0xc100 0x200>;
+			cell-index = <1>;
+			dma-channel@0 {
+				compatible = "fsl,mpc8572-dma-channel",
+						"fsl,eloplus-dma-channel";
+				reg = <0x0 0x80>;
+				cell-index = <0>;
+				interrupt-parent = <&mpic>;
+				interrupts = <76 2>;
+			};
+			dma-channel@80 {
+				compatible = "fsl,mpc8572-dma-channel",
+						"fsl,eloplus-dma-channel";
+				reg = <0x80 0x80>;
+				cell-index = <1>;
+				interrupt-parent = <&mpic>;
+				interrupts = <77 2>;
+			};
+			dma-channel@100 {
+				compatible = "fsl,mpc8572-dma-channel",
+						"fsl,eloplus-dma-channel";
+				reg = <0x100 0x80>;
+				cell-index = <2>;
+				interrupt-parent = <&mpic>;
+				interrupts = <78 2>;
+			};
+			dma-channel@180 {
+				compatible = "fsl,mpc8572-dma-channel",
+						"fsl,eloplus-dma-channel";
+				reg = <0x180 0x80>;
+				cell-index = <3>;
+				interrupt-parent = <&mpic>;
+				interrupts = <79 2>;
+			};
+		};
+
+		dma@21300 {
+			#address-cells = <1>;
+			#size-cells = <1>;
+			compatible = "fsl,mpc8572-dma", "fsl,eloplus-dma";
+			reg = <0x21300 0x4>;
+			ranges = <0x0 0x21100 0x200>;
+			cell-index = <0>;
+			dma-channel@0 {
+				compatible = "fsl,mpc8572-dma-channel",
+						"fsl,eloplus-dma-channel";
+				reg = <0x0 0x80>;
+				cell-index = <0>;
+				interrupt-parent = <&mpic>;
+				interrupts = <20 2>;
+			};
+			dma-channel@80 {
+				compatible = "fsl,mpc8572-dma-channel",
+						"fsl,eloplus-dma-channel";
+				reg = <0x80 0x80>;
+				cell-index = <1>;
+				interrupt-parent = <&mpic>;
+				interrupts = <21 2>;
+			};
+			dma-channel@100 {
+				compatible = "fsl,mpc8572-dma-channel",
+						"fsl,eloplus-dma-channel";
+				reg = <0x100 0x80>;
+				cell-index = <2>;
+				interrupt-parent = <&mpic>;
+				interrupts = <22 2>;
+			};
+			dma-channel@180 {
+				compatible = "fsl,mpc8572-dma-channel",
+						"fsl,eloplus-dma-channel";
+				reg = <0x180 0x80>;
+				cell-index = <3>;
+				interrupt-parent = <&mpic>;
+				interrupts = <23 2>;
+			};
+		};
+
+		/* eTSEC 1 */
+		enet0: ethernet@24000 {
+			#address-cells = <1>;
+			#size-cells = <1>;
+			cell-index = <0>;
+			device_type = "network";
+			model = "eTSEC";
+			compatible = "gianfar";
+			reg = <0x24000 0x1000>;
+			ranges = <0x0 0x24000 0x1000>;
+			local-mac-address = [ 00 00 00 00 00 00 ];
+			interrupts = <29 2 30 2 34 2>;
+			interrupt-parent = <&mpic>;
+			tbi-handle = <&tbi0>;
+			phy-handle = <&phy0>;
+			phy-connection-type = "sgmii";
+
+			mdio@520 {
+				#address-cells = <1>;
+				#size-cells = <0>;
+				compatible = "fsl,gianfar-mdio";
+				reg = <0x520 0x20>;
+
+				phy0: ethernet-phy@1 {
+					interrupt-parent = <&mpic>;
+					interrupts = <8 1>;
+					reg = <0x1>;
+				};
+				phy1: ethernet-phy@2 {
+					interrupt-parent = <&mpic>;
+					interrupts = <8 1>;
+					reg = <0x2>;
+				};
+				tbi0: tbi-phy@11 {
+					reg = <0x11>;
+					device_type = "tbi-phy";
+				};
+			};
+		};
+
+		/* eTSEC 2 */
+		enet1: ethernet@25000 {
+			#address-cells = <1>;
+			#size-cells = <1>;
+			cell-index = <1>;
+			device_type = "network";
+			model = "eTSEC";
+			compatible = "gianfar";
+			reg = <0x25000 0x1000>;
+			ranges = <0x0 0x25000 0x1000>;
+			local-mac-address = [ 00 00 00 00 00 00 ];
+			interrupts = <35 2 36 2 40 2>;
+			interrupt-parent = <&mpic>;
+			tbi-handle = <&tbi1>;
+			phy-handle = <&phy1>;
+			phy-connection-type = "sgmii";
+
+			mdio@520 {
+				#address-cells = <1>;
+				#size-cells = <0>;
+				compatible = "fsl,gianfar-tbi";
+				reg = <0x520 0x20>;
+
+				tbi1: tbi-phy@11 {
+					reg = <0x11>;
+					device_type = "tbi-phy";
+				};
+			};
+		};
+
+		/* UART0 */
+		serial0: serial@4500 {
+			cell-index = <0>;
+			device_type = "serial";
+			compatible = "ns16550";
+			reg = <0x4500 0x100>;
+			clock-frequency = <0>;
+			interrupts = <42 2>;
+			interrupt-parent = <&mpic>;
+		};
+
+		/* UART1 */
+		serial1: serial@4600 {
+			cell-index = <1>;
+			device_type = "serial";
+			compatible = "ns16550";
+			reg = <0x4600 0x100>;
+			clock-frequency = <0>;
+			interrupts = <42 2>;
+			interrupt-parent = <&mpic>;
+		};
+
+		global-utilities@e0000 {	//global utilities block
+			compatible = "fsl,mpc8572-guts";
+			reg = <0xe0000 0x1000>;
+			fsl,has-rstcr;
+		};
+
+		msi@41600 {
+			compatible = "fsl,mpc8572-msi", "fsl,mpic-msi";
+			reg = <0x41600 0x80>;
+			msi-available-ranges = <0 0x100>;
+			interrupts = <
+				0xe0 0
+				0xe1 0
+				0xe2 0
+				0xe3 0
+				0xe4 0
+				0xe5 0
+				0xe6 0
+				0xe7 0>;
+			interrupt-parent = <&mpic>;
+		};
+
+		crypto@30000 {
+			compatible = "fsl,sec3.0", "fsl,sec2.4", "fsl,sec2.2",
+				     "fsl,sec2.1", "fsl,sec2.0";
+			reg = <0x30000 0x10000>;
+			interrupts = <45 2 58 2>;
+			interrupt-parent = <&mpic>;
+			fsl,num-channels = <4>;
+			fsl,channel-fifo-len = <24>;
+			fsl,exec-units-mask = <0x9fe>;
+			fsl,descriptor-types-mask = <0x3ab0ebf>;
+		};
+
+		mpic: pic@40000 {
+			interrupt-controller;
+			#address-cells = <0>;
+			#interrupt-cells = <2>;
+			reg = <0x40000 0x40000>;
+			compatible = "chrp,open-pic";
+			device_type = "open-pic";
+		};
+
+		gpio0: gpio@f000 {
+			compatible = "fsl,mpc8572-gpio";
+			reg = <0xf000 0x1000>;
+			interrupts = <47 2>;
+			interrupt-parent = <&mpic>;
+			#gpio-cells = <2>;
+			gpio-controller;
+		};
+
+		gpio-leds {
+			compatible = "gpio-leds";
+
+			heartbeat {
+				label = "Heartbeat";
+				gpios = <&gpio0 4 1>;
+				linux,default-trigger = "heartbeat";
+			};
+
+			yellow {
+				label = "Yellow";
+				gpios = <&gpio0 5 1>;
+			};
+
+			red {
+				label = "Red";
+				gpios = <&gpio0 6 1>;
+			};
+
+			green {
+				label = "Green";
+				gpios = <&gpio0 7 1>;
+			};
+		};
+
+		/* PME (pattern-matcher) */
+		pme@10000 {
+			compatible = "fsl,mpc8572-pme", "pme8572";
+			reg = <0x10000 0x5000>;
+			interrupts = <57 2 64 2 65 2 66 2 67 2>;
+			interrupt-parent = <&mpic>;
+		};
+
+		tlu@2f000 {
+			compatible = "fsl,mpc8572-tlu", "fsl_tlu";
+			reg = <0x2f000 0x1000>;
+			interupts = <61 2 >;
+			interrupt-parent = <&mpic>;
+		};
+
+		tlu@15000 {
+			compatible = "fsl,mpc8572-tlu", "fsl_tlu";
+			reg = <0x15000 0x1000>;
+			interupts = <75 2>;
+			interrupt-parent = <&mpic>;
+		};
+	};
+
+	/*
+	 * PCI Express controller 3 @ ef008000 is not used.
+	 * This would have been pci0 on other mpc85xx platforms.
+	 */
+
+	/* PCI Express controller 2, wired to XMC P15 connector */
+	pci1: pcie@ef009000 {
+		compatible = "fsl,mpc8548-pcie";
+		device_type = "pci";
+		#interrupt-cells = <1>;
+		#size-cells = <2>;
+		#address-cells = <3>;
+		reg = <0 0xef009000 0 0x1000>;
+		bus-range = <0 255>;
+		ranges = <0x2000000 0x0 0xc0000000 0 0xc0000000 0x0 0x10000000
+			  0x1000000 0x0 0x00000000 0 0xe8800000 0x0 0x00010000>;
+		clock-frequency = <33333333>;
+		interrupt-parent = <&mpic>;
+		interrupts = <25 2>;
+		interrupt-map-mask = <0xf800 0x0 0x0 0x7>;
+		interrupt-map = <
+			/* IDSEL 0x0 */
+			0x0 0x0 0x0 0x1 &mpic 0x4 0x1
+			0x0 0x0 0x0 0x2 &mpic 0x5 0x1
+			0x0 0x0 0x0 0x3 &mpic 0x6 0x1
+			0x0 0x0 0x0 0x4 &mpic 0x7 0x1
+			>;
+		pcie@0 {
+			reg = <0x00000000 0x00000000 0x00000000 0x00000000 0x00000000>;
+			#size-cells = <2>;
+			#address-cells = <3>;
+			device_type = "pci";
+			ranges = <0x2000000 0x0 0xc0000000
+				  0x2000000 0x0 0xc0000000
+				  0x0 0x10000000
+
+				  0x1000000 0x0 0x0
+				  0x1000000 0x0 0x0
+				  0x0 0x100000>;
+		};
+	};
+
+	/* PCI Express controller 1, wired to PEX8112 for PMC interface */
+	pci2: pcie@ef00a000 {
+		compatible = "fsl,mpc8548-pcie";
+		device_type = "pci";
+		#interrupt-cells = <1>;
+		#size-cells = <2>;
+		#address-cells = <3>;
+		reg = <0 0xef00a000 0 0x1000>;
+		bus-range = <0 255>;
+		ranges = <0x2000000 0x0 0x80000000 0 0x80000000 0x0 0x40000000
+			  0x1000000 0x0 0x00000000 0 0xe8000000 0x0 0x10000>;
+		clock-frequency = <33333333>;
+		interrupt-parent = <&mpic>;
+		interrupts = <26 2>;
+		interrupt-map-mask = <0xf800 0x0 0x0 0x7>;
+		interrupt-map = <
+			/* IDSEL 0x0 */
+			0x0 0x0 0x0 0x1 &mpic 0x0 0x1
+			0x0 0x0 0x0 0x2 &mpic 0x1 0x1
+			0x0 0x0 0x0 0x3 &mpic 0x2 0x1
+			0x0 0x0 0x0 0x4 &mpic 0x3 0x1
+			>;
+		pcie@0 {
+			reg = <0x0 0x0 0x0 0x0 0x0>;
+			#size-cells = <2>;
+			#address-cells = <3>;
+			device_type = "pci";
+			ranges = <0x2000000 0x0 0x80000000
+				  0x2000000 0x0 0x80000000
+				  0x0 0x40000000
+
+				  0x1000000 0x0 0x0
+				  0x1000000 0x0 0x0
+				  0x0 0x100000>;
+		};
+	};
+};
diff --git a/arch/powerpc/boot/dts/xpedite5330.dts b/arch/powerpc/boot/dts/xpedite5330.dts
new file mode 100644
index 0000000..c364ca6
--- /dev/null
+++ b/arch/powerpc/boot/dts/xpedite5330.dts
@@ -0,0 +1,707 @@
+/*
+ * Copyright (C) 2008 Extreme Engineering Solutions, Inc.
+ * Based on MPC8572DS device tree from Freescale Semiconductor, Inc.
+ *
+ * XPedite5330 3U CompactPCI module based on MPC8572E
+ *
+ * This is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+/dts-v1/;
+/ {
+	model = "xes,xpedite5330";
+	compatible = "xes,xpedite5330", "xes,MPC8572";
+	#address-cells = <2>;
+	#size-cells = <2>;
+	form-factor = "3U CompactPCI";
+	boot-bank = <0x0>;	/* 0: Primary flash, 1: Secondary flash */
+
+	aliases {
+		ethernet0 = &enet0;
+		ethernet1 = &enet1;
+		serial0 = &serial0;
+		serial1 = &serial1;
+		pci0 = &pci0;
+		pci1 = &pci1;
+		pci2 = &pci2;
+	};
+
+	pmcslots {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		pmcslot@0 {
+			cell-index = <0>;
+			/*
+			 * boolean properties (true if defined):
+			 *     monarch;
+			 *     module-present;
+			 */
+		};
+	};
+
+	xmcslots {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		xmcslot@0 {
+			cell-index = <0>;
+			/*
+			 * boolean properties (true if defined):
+			 *     module-present;
+			 */
+		};
+	};
+
+	cpci {
+		/*
+		 * boolean properties (true if defined):
+		 *     system-controller;
+		 */
+		system-controller;
+	};
+
+	cpus {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		PowerPC,8572@0 {
+			device_type = "cpu";
+			reg = <0x0>;
+			d-cache-line-size = <32>;	// 32 bytes
+			i-cache-line-size = <32>;	// 32 bytes
+			d-cache-size = <0x8000>;		// L1, 32K
+			i-cache-size = <0x8000>;		// L1, 32K
+			timebase-frequency = <0>;
+			bus-frequency = <0>;
+			clock-frequency = <0>;
+			next-level-cache = <&L2>;
+		};
+
+		PowerPC,8572@1 {
+			device_type = "cpu";
+			reg = <0x1>;
+			d-cache-line-size = <32>;	// 32 bytes
+			i-cache-line-size = <32>;	// 32 bytes
+			d-cache-size = <0x8000>;		// L1, 32K
+			i-cache-size = <0x8000>;		// L1, 32K
+			timebase-frequency = <0>;
+			bus-frequency = <0>;
+			clock-frequency = <0>;
+			next-level-cache = <&L2>;
+		};
+	};
+
+	memory {
+		device_type = "memory";
+		reg = <0x0 0x0 0x0 0x0>;	// Filled in by U-Boot
+	};
+
+	localbus@ef005000 {
+		#address-cells = <2>;
+		#size-cells = <1>;
+		compatible = "fsl,mpc8572-elbc", "fsl,elbc", "simple-bus";
+		reg = <0 0xef005000 0 0x1000>;
+		interrupts = <19 2>;
+		interrupt-parent = <&mpic>;
+		/* Local bus region mappings */
+		ranges = <0 0 0 0xf8000000 0x8000000 /* CS0: Boot flash */
+			  1 0 0 0xf0000000 0x8000000 /* CS1: Alternate flash */
+			  2 0 0 0xef800000 0x40000   /* CS2: NAND CE1 */
+			  3 0 0 0xef840000 0x40000>; /* CS3: NAND CE2 */
+
+		nor-boot@0,0 {
+			compatible = "amd,s29gl01gp", "cfi-flash";
+			bank-width = <2>;
+			reg = <0 0 0x8000000>; /* 128MB */
+			#address-cells = <1>;
+			#size-cells = <1>;
+			partition@0 {
+				label = "Primary user space";
+				reg = <0x00000000 0x6f00000>; /* 111 MB */
+			};
+			partition@6f00000 {
+				label = "Primary kernel";
+				reg = <0x6f00000 0x1000000>; /* 16 MB */
+			};
+			partition@7f00000 {
+				label = "Primary DTB";
+				reg = <0x7f00000 0x40000>; /* 256 KB */
+			};
+			partition@7f40000 {
+				label = "Primary U-Boot environment";
+				reg = <0x7f40000 0x40000>; /* 256 KB */
+			};
+			partition@7f80000 {
+				label = "Primary U-Boot";
+				reg = <0x7f80000 0x80000>; /* 512 KB */
+				read-only;
+			};
+		};
+
+		nor-alternate@1,0 {
+			compatible = "amd,s29gl01gp", "cfi-flash";
+			bank-width = <2>;
+			//reg = <0xf0000000 0x08000000>; /* 128MB */
+			reg = <1 0 0x8000000>; /* 128MB */
+			#address-cells = <1>;
+			#size-cells = <1>;
+			partition@0 {
+				label = "Secondary user space";
+				reg = <0x00000000 0x6f00000>; /* 111 MB */
+			};
+			partition@6f00000 {
+				label = "Secondary kernel";
+				reg = <0x6f00000 0x1000000>; /* 16 MB */
+			};
+			partition@7f00000 {
+				label = "Secondary DTB";
+				reg = <0x7f00000 0x40000>; /* 256 KB */
+			};
+			partition@7f40000 {
+				label = "Secondary U-Boot environment";
+				reg = <0x7f40000 0x40000>; /* 256 KB */
+			};
+			partition@7f80000 {
+				label = "Secondary U-Boot";
+				reg = <0x7f80000 0x80000>; /* 512 KB */
+				read-only;
+			};
+		};
+
+		nand@2,0 {
+			#address-cells = <1>;
+			#size-cells = <1>;
+			/*
+			 * Actual part could be ST Micro NAND08GW3B2A (1 GB),
+			 * Micron MT29F8G08DAA (2x 512 MB), or Micron
+			 * MT29F16G08FAA (2x 1 GB), depending on the build
+			 * configuration
+			 */
+			compatible = "fsl,mpc8572-fcm-nand",
+				     "fsl,elbc-fcm-nand";
+			reg = <2 0 0x40000>;
+			/* U-Boot should fix this up if chip size > 1 GB */
+			partition@0 {
+				label = "NAND Filesystem";
+				reg = <0 0x40000000>;
+			};
+		};
+
+	};
+
+	soc8572@ef000000 {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		device_type = "soc";
+		compatible = "fsl,mpc8572-immr", "simple-bus";
+		ranges = <0x0 0 0xef000000 0x100000>;
+		bus-frequency = <0>;		// Filled out by uboot.
+
+		ecm-law@0 {
+			compatible = "fsl,ecm-law";
+			reg = <0x0 0x1000>;
+			fsl,num-laws = <12>;
+		};
+
+		ecm@1000 {
+			compatible = "fsl,mpc8572-ecm", "fsl,ecm";
+			reg = <0x1000 0x1000>;
+			interrupts = <17 2>;
+			interrupt-parent = <&mpic>;
+		};
+
+		memory-controller@2000 {
+			compatible = "fsl,mpc8572-memory-controller";
+			reg = <0x2000 0x1000>;
+			interrupt-parent = <&mpic>;
+			interrupts = <18 2>;
+		};
+
+		memory-controller@6000 {
+			compatible = "fsl,mpc8572-memory-controller";
+			reg = <0x6000 0x1000>;
+			interrupt-parent = <&mpic>;
+			interrupts = <18 2>;
+		};
+
+		L2: l2-cache-controller@20000 {
+			compatible = "fsl,mpc8572-l2-cache-controller";
+			reg = <0x20000 0x1000>;
+			cache-line-size = <32>;	// 32 bytes
+			cache-size = <0x100000>; // L2, 1M
+			interrupt-parent = <&mpic>;
+			interrupts = <16 2>;
+		};
+
+		i2c@3000 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			cell-index = <0>;
+			compatible = "fsl-i2c";
+			reg = <0x3000 0x100>;
+			interrupts = <43 2>;
+			interrupt-parent = <&mpic>;
+			dfsrr;
+
+			temp-sensor@48 {
+				compatible = "dallas,ds1631", "dallas,ds1621";
+				reg = <0x48>;
+			};
+
+			temp-sensor@4c {
+				compatible = "adi,adt7461";
+				reg = <0x4c>;
+			};
+
+			cpu-supervisor@51 {
+				compatible = "dallas,ds4510";
+				reg = <0x51>;
+			};
+
+			eeprom@54 {
+				compatible = "atmel,at24c128b";
+				reg = <0x54>;
+			};
+
+			rtc@68 {
+				compatible = "stm,m41t00",
+				             "dallas,ds1338";
+				reg = <0x68>;
+			};
+
+			pcie-switch@70 {
+				compatible = "plx,pex8518";
+				reg = <0x70>;
+			};
+
+			gpio1: gpio@18 {
+				compatible = "nxp,pca9557";
+				reg = <0x18>;
+				#gpio-cells = <2>;
+				gpio-controller;
+				polarity = <0x00>;
+			};
+
+			gpio2: gpio@1c {
+				compatible = "nxp,pca9557";
+				reg = <0x1c>;
+				#gpio-cells = <2>;
+				gpio-controller;
+				polarity = <0x00>;
+			};
+
+			gpio3: gpio@1e {
+				compatible = "nxp,pca9557";
+				reg = <0x1e>;
+				#gpio-cells = <2>;
+				gpio-controller;
+				polarity = <0x00>;
+			};
+
+			gpio4: gpio@1f {
+				compatible = "nxp,pca9557";
+				reg = <0x1f>;
+				#gpio-cells = <2>;
+				gpio-controller;
+				polarity = <0x00>;
+			};
+		};
+
+		i2c@3100 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			cell-index = <1>;
+			compatible = "fsl-i2c";
+			reg = <0x3100 0x100>;
+			interrupts = <43 2>;
+			interrupt-parent = <&mpic>;
+			dfsrr;
+		};
+
+		dma@c300 {
+			#address-cells = <1>;
+			#size-cells = <1>;
+			compatible = "fsl,mpc8572-dma", "fsl,eloplus-dma";
+			reg = <0xc300 0x4>;
+			ranges = <0x0 0xc100 0x200>;
+			cell-index = <1>;
+			dma-channel@0 {
+				compatible = "fsl,mpc8572-dma-channel",
+						"fsl,eloplus-dma-channel";
+				reg = <0x0 0x80>;
+				cell-index = <0>;
+				interrupt-parent = <&mpic>;
+				interrupts = <76 2>;
+			};
+			dma-channel@80 {
+				compatible = "fsl,mpc8572-dma-channel",
+						"fsl,eloplus-dma-channel";
+				reg = <0x80 0x80>;
+				cell-index = <1>;
+				interrupt-parent = <&mpic>;
+				interrupts = <77 2>;
+			};
+			dma-channel@100 {
+				compatible = "fsl,mpc8572-dma-channel",
+						"fsl,eloplus-dma-channel";
+				reg = <0x100 0x80>;
+				cell-index = <2>;
+				interrupt-parent = <&mpic>;
+				interrupts = <78 2>;
+			};
+			dma-channel@180 {
+				compatible = "fsl,mpc8572-dma-channel",
+						"fsl,eloplus-dma-channel";
+				reg = <0x180 0x80>;
+				cell-index = <3>;
+				interrupt-parent = <&mpic>;
+				interrupts = <79 2>;
+			};
+		};
+
+		dma@21300 {
+			#address-cells = <1>;
+			#size-cells = <1>;
+			compatible = "fsl,mpc8572-dma", "fsl,eloplus-dma";
+			reg = <0x21300 0x4>;
+			ranges = <0x0 0x21100 0x200>;
+			cell-index = <0>;
+			dma-channel@0 {
+				compatible = "fsl,mpc8572-dma-channel",
+						"fsl,eloplus-dma-channel";
+				reg = <0x0 0x80>;
+				cell-index = <0>;
+				interrupt-parent = <&mpic>;
+				interrupts = <20 2>;
+			};
+			dma-channel@80 {
+				compatible = "fsl,mpc8572-dma-channel",
+						"fsl,eloplus-dma-channel";
+				reg = <0x80 0x80>;
+				cell-index = <1>;
+				interrupt-parent = <&mpic>;
+				interrupts = <21 2>;
+			};
+			dma-channel@100 {
+				compatible = "fsl,mpc8572-dma-channel",
+						"fsl,eloplus-dma-channel";
+				reg = <0x100 0x80>;
+				cell-index = <2>;
+				interrupt-parent = <&mpic>;
+				interrupts = <22 2>;
+			};
+			dma-channel@180 {
+				compatible = "fsl,mpc8572-dma-channel",
+						"fsl,eloplus-dma-channel";
+				reg = <0x180 0x80>;
+				cell-index = <3>;
+				interrupt-parent = <&mpic>;
+				interrupts = <23 2>;
+			};
+		};
+
+		/* eTSEC 1 */
+		enet0: ethernet@24000 {
+			#address-cells = <1>;
+			#size-cells = <1>;
+			cell-index = <0>;
+			device_type = "network";
+			model = "eTSEC";
+			compatible = "gianfar";
+			reg = <0x24000 0x1000>;
+			ranges = <0x0 0x24000 0x1000>;
+			local-mac-address = [ 00 00 00 00 00 00 ];
+			interrupts = <29 2 30 2 34 2>;
+			interrupt-parent = <&mpic>;
+			tbi-handle = <&tbi0>;
+			phy-handle = <&phy0>;
+			phy-connection-type = "sgmii";
+
+			mdio@520 {
+				#address-cells = <1>;
+				#size-cells = <0>;
+				compatible = "fsl,gianfar-mdio";
+				reg = <0x520 0x20>;
+
+				phy0: ethernet-phy@1 {
+					interrupt-parent = <&mpic>;
+					interrupts = <8 1>;
+					reg = <0x1>;
+				};
+				phy1: ethernet-phy@2 {
+					interrupt-parent = <&mpic>;
+					interrupts = <8 1>;
+					reg = <0x2>;
+				};
+				tbi0: tbi-phy@11 {
+					reg = <0x11>;
+					device_type = "tbi-phy";
+				};
+			};
+		};
+
+		/* eTSEC 2 */
+		enet1: ethernet@25000 {
+			#address-cells = <1>;
+			#size-cells = <1>;
+			cell-index = <1>;
+			device_type = "network";
+			model = "eTSEC";
+			compatible = "gianfar";
+			reg = <0x25000 0x1000>;
+			ranges = <0x0 0x25000 0x1000>;
+			local-mac-address = [ 00 00 00 00 00 00 ];
+			interrupts = <35 2 36 2 40 2>;
+			interrupt-parent = <&mpic>;
+			tbi-handle = <&tbi1>;
+			phy-handle = <&phy1>;
+			phy-connection-type = "sgmii";
+
+			mdio@520 {
+				#address-cells = <1>;
+				#size-cells = <0>;
+				compatible = "fsl,gianfar-tbi";
+				reg = <0x520 0x20>;
+
+				tbi1: tbi-phy@11 {
+					reg = <0x11>;
+					device_type = "tbi-phy";
+				};
+			};
+		};
+
+		/* UART0 */
+		serial0: serial@4500 {
+			cell-index = <0>;
+			device_type = "serial";
+			compatible = "ns16550";
+			reg = <0x4500 0x100>;
+			clock-frequency = <0>;
+			interrupts = <42 2>;
+			interrupt-parent = <&mpic>;
+		};
+
+		/* UART1 */
+		serial1: serial@4600 {
+			cell-index = <1>;
+			device_type = "serial";
+			compatible = "ns16550";
+			reg = <0x4600 0x100>;
+			clock-frequency = <0>;
+			interrupts = <42 2>;
+			interrupt-parent = <&mpic>;
+		};
+
+		global-utilities@e0000 {	//global utilities block
+			compatible = "fsl,mpc8572-guts";
+			reg = <0xe0000 0x1000>;
+			fsl,has-rstcr;
+		};
+
+		msi@41600 {
+			compatible = "fsl,mpc8572-msi", "fsl,mpic-msi";
+			reg = <0x41600 0x80>;
+			msi-available-ranges = <0 0x100>;
+			interrupts = <
+				0xe0 0
+				0xe1 0
+				0xe2 0
+				0xe3 0
+				0xe4 0
+				0xe5 0
+				0xe6 0
+				0xe7 0>;
+			interrupt-parent = <&mpic>;
+		};
+
+		crypto@30000 {
+			compatible = "fsl,sec3.0", "fsl,sec2.4", "fsl,sec2.2",
+				     "fsl,sec2.1", "fsl,sec2.0";
+			reg = <0x30000 0x10000>;
+			interrupts = <45 2 58 2>;
+			interrupt-parent = <&mpic>;
+			fsl,num-channels = <4>;
+			fsl,channel-fifo-len = <24>;
+			fsl,exec-units-mask = <0x9fe>;
+			fsl,descriptor-types-mask = <0x3ab0ebf>;
+		};
+
+		mpic: pic@40000 {
+			interrupt-controller;
+			#address-cells = <0>;
+			#interrupt-cells = <2>;
+			reg = <0x40000 0x40000>;
+			compatible = "chrp,open-pic";
+			device_type = "open-pic";
+		};
+
+		gpio0: gpio@f000 {
+			compatible = "fsl,mpc8572-gpio";
+			reg = <0xf000 0x1000>;
+			interrupts = <47 2>;
+			interrupt-parent = <&mpic>;
+			#gpio-cells = <2>;
+			gpio-controller;
+		};
+
+		gpio-leds {
+			compatible = "gpio-leds";
+
+			heartbeat {
+				label = "Heartbeat";
+				gpios = <&gpio0 4 1>;
+				linux,default-trigger = "heartbeat";
+			};
+
+			yellow {
+				label = "Yellow";
+				gpios = <&gpio0 5 1>;
+			};
+
+			red {
+				label = "Red";
+				gpios = <&gpio0 6 1>;
+			};
+
+			green {
+				label = "Green";
+				gpios = <&gpio0 7 1>;
+			};
+		};
+
+		/* PME (pattern-matcher) */
+		pme@10000 {
+			compatible = "fsl,mpc8572-pme", "pme8572";
+			reg = <0x10000 0x5000>;
+			interrupts = <57 2 64 2 65 2 66 2 67 2>;
+			interrupt-parent = <&mpic>;
+		};
+
+		tlu@2f000 {
+			compatible = "fsl,mpc8572-tlu", "fsl_tlu";
+			reg = <0x2f000 0x1000>;
+			interupts = <61 2 >;
+			interrupt-parent = <&mpic>;
+		};
+
+		tlu@15000 {
+			compatible = "fsl,mpc8572-tlu", "fsl_tlu";
+			reg = <0x15000 0x1000>;
+			interupts = <75 2>;
+			interrupt-parent = <&mpic>;
+		};
+	};
+
+	/* PCI Express controller 3 - CompactPCI bus via PEX8112 bridge */
+	pci0: pcie@ef008000 {
+		compatible = "fsl,mpc8548-pcie";
+		device_type = "pci";
+		#interrupt-cells = <1>;
+		#size-cells = <2>;
+		#address-cells = <3>;
+		reg = <0 0xef008000 0 0x1000>;
+		bus-range = <0 255>;
+		ranges = <0x2000000 0x0 0xe0000000 0 0xe0000000 0x0 0x10000000
+			  0x1000000 0x0 0x00000000 0 0xe9000000 0x0 0x10000>;
+		clock-frequency = <33333333>;
+		interrupt-parent = <&mpic>;
+		interrupts = <24 2>;
+		interrupt-map-mask = <0xff00 0x0 0x0 0x7>;
+		interrupt-map = <
+			0x0 0x0 0x0 0x1 &mpic 0x0 0x1
+			0x0 0x0 0x0 0x2 &mpic 0x1 0x1
+			0x0 0x0 0x0 0x3 &mpic 0x2 0x1
+			0x0 0x0 0x0 0x4 &mpic 0x3 0x1
+			>;
+		pcie@0 {
+			reg = <0x0 0x0 0x0 0x0 0x0>;
+			#size-cells = <2>;
+			#address-cells = <3>;
+			device_type = "pci";
+			ranges = <0x02000000 0x0 0xe0000000
+				  0x02000000 0x0 0xe0000000
+				  0x0 0x10000000
+
+				  0x01000000 0x0 0x0
+				  0x01000000 0x0 0x0
+				  0x0 0x100000>;
+		};
+	};
+
+	/* PCI Express controller 2, PMC module via PEX8112 bridge */
+	pci1: pcie@ef009000 {
+		compatible = "fsl,mpc8548-pcie";
+		device_type = "pci";
+		#interrupt-cells = <1>;
+		#size-cells = <2>;
+		#address-cells = <3>;
+		reg = <0 0xef009000 0 0x1000>;
+		bus-range = <0 255>;
+		ranges = <0x2000000 0x0 0xc0000000 0 0xc0000000 0x0 0x10000000
+			  0x1000000 0x0 0x00000000 0 0xe8800000 0x0 0x10000>;
+		clock-frequency = <33333333>;
+		interrupt-parent = <&mpic>;
+		interrupts = <25 2>;
+		interrupt-map-mask = <0xf800 0x0 0x0 0x7>;
+		interrupt-map = <
+			/* IDSEL 0x0 */
+			0x0 0x0 0x0 0x1 &mpic 0x4 0x1
+			0x0 0x0 0x0 0x2 &mpic 0x5 0x1
+			0x0 0x0 0x0 0x3 &mpic 0x6 0x1
+			0x0 0x0 0x0 0x4 &mpic 0x7 0x1
+			>;
+		pcie@0 {
+			reg = <0x0 0x0 0x0 0x0 0x0>;
+			#size-cells = <2>;
+			#address-cells = <3>;
+			device_type = "pci";
+			ranges = <0x2000000 0x0 0xc0000000
+				  0x2000000 0x0 0xc0000000
+				  0x0 0x10000000
+
+				  0x1000000 0x0 0x0
+				  0x1000000 0x0 0x0
+				  0x0 0x100000>;
+		};
+	};
+
+	/* PCI Express controller 1, XMC P15 */
+	pci2: pcie@ef00a000 {
+		compatible = "fsl,mpc8548-pcie";
+		device_type = "pci";
+		#interrupt-cells = <1>;
+		#size-cells = <2>;
+		#address-cells = <3>;
+		reg = <0 0xef00a000 0 0x1000>;
+		bus-range = <0 255>;
+		ranges = <0x2000000 0x0 0x80000000 0 0x80000000 0x0 0x40000000
+			  0x1000000 0x0 0x00000000 0 0xe8000000 0x0 0x10000>;
+		clock-frequency = <33333333>;
+		interrupt-parent = <&mpic>;
+		interrupts = <26 2>;
+		interrupt-map-mask = <0xf800 0x0 0x0 0x7>;
+		interrupt-map = <
+			/* IDSEL 0x0 */
+			0x0 0x0 0x0 0x1 &mpic 0x0 0x1
+			0x0 0x0 0x0 0x2 &mpic 0x1 0x1
+			0x0 0x0 0x0 0x3 &mpic 0x2 0x1
+			0x0 0x0 0x0 0x4 &mpic 0x3 0x1
+			>;
+		pcie@0 {
+			reg = <0x0 0x0 0x0 0x0 0x0>;
+			#size-cells = <2>;
+			#address-cells = <3>;
+			device_type = "pci";
+			ranges = <0x2000000 0x0 0x80000000
+				  0x2000000 0x0 0x80000000
+				  0x0 0x40000000
+
+				  0x1000000 0x0 0x0
+				  0x1000000 0x0 0x0
+				  0x0 0x100000>;
+		};
+	};
+};
diff --git a/arch/powerpc/boot/dts/xpedite5370.dts b/arch/powerpc/boot/dts/xpedite5370.dts
new file mode 100644
index 0000000..7a8a4af
--- /dev/null
+++ b/arch/powerpc/boot/dts/xpedite5370.dts
@@ -0,0 +1,638 @@
+/*
+ * Copyright (C) 2008 Extreme Engineering Solutions, Inc.
+ * Based on MPC8572DS device tree from Freescale Semiconductor, Inc.
+ *
+ * XPedite5370 3U VPX single-board computer based on MPC8572E
+ *
+ * This is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+/dts-v1/;
+/ {
+	model = "xes,xpedite5370";
+	compatible = "xes,xpedite5370", "xes,MPC8572";
+	#address-cells = <2>;
+	#size-cells = <2>;
+
+	aliases {
+		ethernet0 = &enet0;
+		ethernet1 = &enet1;
+		serial0 = &serial0;
+		serial1 = &serial1;
+		pci1 = &pci1;
+		pci2 = &pci2;
+	};
+
+	cpus {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		PowerPC,8572@0 {
+			device_type = "cpu";
+			reg = <0x0>;
+			d-cache-line-size = <32>;	// 32 bytes
+			i-cache-line-size = <32>;	// 32 bytes
+			d-cache-size = <0x8000>;		// L1, 32K
+			i-cache-size = <0x8000>;		// L1, 32K
+			timebase-frequency = <0>;
+			bus-frequency = <0>;
+			clock-frequency = <0>;
+			next-level-cache = <&L2>;
+		};
+
+		PowerPC,8572@1 {
+			device_type = "cpu";
+			reg = <0x1>;
+			d-cache-line-size = <32>;	// 32 bytes
+			i-cache-line-size = <32>;	// 32 bytes
+			d-cache-size = <0x8000>;		// L1, 32K
+			i-cache-size = <0x8000>;		// L1, 32K
+			timebase-frequency = <0>;
+			bus-frequency = <0>;
+			clock-frequency = <0>;
+			next-level-cache = <&L2>;
+		};
+	};
+
+	memory {
+		device_type = "memory";
+		reg = <0x0 0x0 0x0 0x0>;	// Filled in by U-Boot
+	};
+
+	localbus@ef005000 {
+		#address-cells = <2>;
+		#size-cells = <1>;
+		compatible = "fsl,mpc8572-elbc", "fsl,elbc", "simple-bus";
+		reg = <0 0xef005000 0 0x1000>;
+		interrupts = <19 2>;
+		interrupt-parent = <&mpic>;
+		/* Local bus region mappings */
+		ranges = <0 0 0 0xf8000000 0x8000000 /* CS0: Boot flash */
+			  1 0 0 0xf0000000 0x8000000 /* CS1: Alternate flash */
+			  2 0 0 0xef800000 0x40000   /* CS2: NAND CE1 */
+			  3 0 0 0xef840000 0x40000>; /* CS3: NAND CE2 */
+
+		nor-boot@0,0 {
+			compatible = "amd,s29gl01gp", "cfi-flash";
+			bank-width = <2>;
+			reg = <0 0 0x8000000>; /* 128MB */
+			#address-cells = <1>;
+			#size-cells = <1>;
+			partition@0 {
+				label = "Primary user space";
+				reg = <0x00000000 0x6f00000>; /* 111 MB */
+			};
+			partition@6f00000 {
+				label = "Primary kernel";
+				reg = <0x6f00000 0x1000000>; /* 16 MB */
+			};
+			partition@7f00000 {
+				label = "Primary DTB";
+				reg = <0x7f00000 0x40000>; /* 256 KB */
+			};
+			partition@7f40000 {
+				label = "Primary U-Boot environment";
+				reg = <0x7f40000 0x40000>; /* 256 KB */
+			};
+			partition@7f80000 {
+				label = "Primary U-Boot";
+				reg = <0x7f80000 0x80000>; /* 512 KB */
+				read-only;
+			};
+		};
+
+		nor-alternate@1,0 {
+			compatible = "amd,s29gl01gp", "cfi-flash";
+			bank-width = <2>;
+			//reg = <0xf0000000 0x08000000>; /* 128MB */
+			reg = <1 0 0x8000000>; /* 128MB */
+			#address-cells = <1>;
+			#size-cells = <1>;
+			partition@0 {
+				label = "Secondary user space";
+				reg = <0x00000000 0x6f00000>; /* 111 MB */
+			};
+			partition@6f00000 {
+				label = "Secondary kernel";
+				reg = <0x6f00000 0x1000000>; /* 16 MB */
+			};
+			partition@7f00000 {
+				label = "Secondary DTB";
+				reg = <0x7f00000 0x40000>; /* 256 KB */
+			};
+			partition@7f40000 {
+				label = "Secondary U-Boot environment";
+				reg = <0x7f40000 0x40000>; /* 256 KB */
+			};
+			partition@7f80000 {
+				label = "Secondary U-Boot";
+				reg = <0x7f80000 0x80000>; /* 512 KB */
+				read-only;
+			};
+		};
+
+		nand@2,0 {
+			#address-cells = <1>;
+			#size-cells = <1>;
+			/*
+			 * Actual part could be ST Micro NAND08GW3B2A (1 GB),
+			 * Micron MT29F8G08DAA (2x 512 MB), or Micron
+			 * MT29F16G08FAA (2x 1 GB), depending on the build
+			 * configuration
+			 */
+			compatible = "fsl,mpc8572-fcm-nand",
+				     "fsl,elbc-fcm-nand";
+			reg = <2 0 0x40000>;
+			/* U-Boot should fix this up if chip size > 1 GB */
+			partition@0 {
+				label = "NAND Filesystem";
+				reg = <0 0x40000000>;
+			};
+		};
+
+	};
+
+	soc8572@ef000000 {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		device_type = "soc";
+		compatible = "fsl,mpc8572-immr", "simple-bus";
+		ranges = <0x0 0 0xef000000 0x100000>;
+		bus-frequency = <0>;		// Filled out by uboot.
+
+		ecm-law@0 {
+			compatible = "fsl,ecm-law";
+			reg = <0x0 0x1000>;
+			fsl,num-laws = <12>;
+		};
+
+		ecm@1000 {
+			compatible = "fsl,mpc8572-ecm", "fsl,ecm";
+			reg = <0x1000 0x1000>;
+			interrupts = <17 2>;
+			interrupt-parent = <&mpic>;
+		};
+
+		memory-controller@2000 {
+			compatible = "fsl,mpc8572-memory-controller";
+			reg = <0x2000 0x1000>;
+			interrupt-parent = <&mpic>;
+			interrupts = <18 2>;
+		};
+
+		memory-controller@6000 {
+			compatible = "fsl,mpc8572-memory-controller";
+			reg = <0x6000 0x1000>;
+			interrupt-parent = <&mpic>;
+			interrupts = <18 2>;
+		};
+
+		L2: l2-cache-controller@20000 {
+			compatible = "fsl,mpc8572-l2-cache-controller";
+			reg = <0x20000 0x1000>;
+			cache-line-size = <32>;	// 32 bytes
+			cache-size = <0x100000>; // L2, 1M
+			interrupt-parent = <&mpic>;
+			interrupts = <16 2>;
+		};
+
+		i2c@3000 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			cell-index = <0>;
+			compatible = "fsl-i2c";
+			reg = <0x3000 0x100>;
+			interrupts = <43 2>;
+			interrupt-parent = <&mpic>;
+			dfsrr;
+
+			temp-sensor@48 {
+				compatible = "dallas,ds1631", "dallas,ds1621";
+				reg = <0x48>;
+			};
+
+			temp-sensor@4c {
+				compatible = "adi,adt7461";
+				reg = <0x4c>;
+			};
+
+			cpu-supervisor@51 {
+				compatible = "dallas,ds4510";
+				reg = <0x51>;
+			};
+
+			eeprom@54 {
+				compatible = "atmel,at24c128b";
+				reg = <0x54>;
+			};
+
+			rtc@68 {
+				compatible = "stm,m41t00",
+				             "dallas,ds1338";
+				reg = <0x68>;
+			};
+
+			pcie-switch@70 {
+				compatible = "plx,pex8518";
+				reg = <0x70>;
+			};
+
+			gpio1: gpio@18 {
+				compatible = "nxp,pca9557";
+				reg = <0x18>;
+				#gpio-cells = <2>;
+				gpio-controller;
+				polarity = <0x00>;
+			};
+
+			gpio2: gpio@1c {
+				compatible = "nxp,pca9557";
+				reg = <0x1c>;
+				#gpio-cells = <2>;
+				gpio-controller;
+				polarity = <0x00>;
+			};
+
+			gpio3: gpio@1e {
+				compatible = "nxp,pca9557";
+				reg = <0x1e>;
+				#gpio-cells = <2>;
+				gpio-controller;
+				polarity = <0x00>;
+			};
+
+			gpio4: gpio@1f {
+				compatible = "nxp,pca9557";
+				reg = <0x1f>;
+				#gpio-cells = <2>;
+				gpio-controller;
+				polarity = <0x00>;
+			};
+		};
+
+		i2c@3100 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			cell-index = <1>;
+			compatible = "fsl-i2c";
+			reg = <0x3100 0x100>;
+			interrupts = <43 2>;
+			interrupt-parent = <&mpic>;
+			dfsrr;
+		};
+
+		dma@c300 {
+			#address-cells = <1>;
+			#size-cells = <1>;
+			compatible = "fsl,mpc8572-dma", "fsl,eloplus-dma";
+			reg = <0xc300 0x4>;
+			ranges = <0x0 0xc100 0x200>;
+			cell-index = <1>;
+			dma-channel@0 {
+				compatible = "fsl,mpc8572-dma-channel",
+						"fsl,eloplus-dma-channel";
+				reg = <0x0 0x80>;
+				cell-index = <0>;
+				interrupt-parent = <&mpic>;
+				interrupts = <76 2>;
+			};
+			dma-channel@80 {
+				compatible = "fsl,mpc8572-dma-channel",
+						"fsl,eloplus-dma-channel";
+				reg = <0x80 0x80>;
+				cell-index = <1>;
+				interrupt-parent = <&mpic>;
+				interrupts = <77 2>;
+			};
+			dma-channel@100 {
+				compatible = "fsl,mpc8572-dma-channel",
+						"fsl,eloplus-dma-channel";
+				reg = <0x100 0x80>;
+				cell-index = <2>;
+				interrupt-parent = <&mpic>;
+				interrupts = <78 2>;
+			};
+			dma-channel@180 {
+				compatible = "fsl,mpc8572-dma-channel",
+						"fsl,eloplus-dma-channel";
+				reg = <0x180 0x80>;
+				cell-index = <3>;
+				interrupt-parent = <&mpic>;
+				interrupts = <79 2>;
+			};
+		};
+
+		dma@21300 {
+			#address-cells = <1>;
+			#size-cells = <1>;
+			compatible = "fsl,mpc8572-dma", "fsl,eloplus-dma";
+			reg = <0x21300 0x4>;
+			ranges = <0x0 0x21100 0x200>;
+			cell-index = <0>;
+			dma-channel@0 {
+				compatible = "fsl,mpc8572-dma-channel",
+						"fsl,eloplus-dma-channel";
+				reg = <0x0 0x80>;
+				cell-index = <0>;
+				interrupt-parent = <&mpic>;
+				interrupts = <20 2>;
+			};
+			dma-channel@80 {
+				compatible = "fsl,mpc8572-dma-channel",
+						"fsl,eloplus-dma-channel";
+				reg = <0x80 0x80>;
+				cell-index = <1>;
+				interrupt-parent = <&mpic>;
+				interrupts = <21 2>;
+			};
+			dma-channel@100 {
+				compatible = "fsl,mpc8572-dma-channel",
+						"fsl,eloplus-dma-channel";
+				reg = <0x100 0x80>;
+				cell-index = <2>;
+				interrupt-parent = <&mpic>;
+				interrupts = <22 2>;
+			};
+			dma-channel@180 {
+				compatible = "fsl,mpc8572-dma-channel",
+						"fsl,eloplus-dma-channel";
+				reg = <0x180 0x80>;
+				cell-index = <3>;
+				interrupt-parent = <&mpic>;
+				interrupts = <23 2>;
+			};
+		};
+
+		/* eTSEC 1 */
+		enet0: ethernet@24000 {
+			#address-cells = <1>;
+			#size-cells = <1>;
+			cell-index = <0>;
+			device_type = "network";
+			model = "eTSEC";
+			compatible = "gianfar";
+			reg = <0x24000 0x1000>;
+			ranges = <0x0 0x24000 0x1000>;
+			local-mac-address = [ 00 00 00 00 00 00 ];
+			interrupts = <29 2 30 2 34 2>;
+			interrupt-parent = <&mpic>;
+			tbi-handle = <&tbi0>;
+			phy-handle = <&phy0>;
+			phy-connection-type = "sgmii";
+
+			mdio@520 {
+				#address-cells = <1>;
+				#size-cells = <0>;
+				compatible = "fsl,gianfar-mdio";
+				reg = <0x520 0x20>;
+
+				phy0: ethernet-phy@1 {
+					interrupt-parent = <&mpic>;
+					interrupts = <8 1>;
+					reg = <0x1>;
+				};
+				phy1: ethernet-phy@2 {
+					interrupt-parent = <&mpic>;
+					interrupts = <8 1>;
+					reg = <0x2>;
+				};
+				tbi0: tbi-phy@11 {
+					reg = <0x11>;
+					device_type = "tbi-phy";
+				};
+			};
+		};
+
+		/* eTSEC 2 */
+		enet1: ethernet@25000 {
+			#address-cells = <1>;
+			#size-cells = <1>;
+			cell-index = <1>;
+			device_type = "network";
+			model = "eTSEC";
+			compatible = "gianfar";
+			reg = <0x25000 0x1000>;
+			ranges = <0x0 0x25000 0x1000>;
+			local-mac-address = [ 00 00 00 00 00 00 ];
+			interrupts = <35 2 36 2 40 2>;
+			interrupt-parent = <&mpic>;
+			tbi-handle = <&tbi1>;
+			phy-handle = <&phy1>;
+			phy-connection-type = "sgmii";
+
+			mdio@520 {
+				#address-cells = <1>;
+				#size-cells = <0>;
+				compatible = "fsl,gianfar-tbi";
+				reg = <0x520 0x20>;
+
+				tbi1: tbi-phy@11 {
+					reg = <0x11>;
+					device_type = "tbi-phy";
+				};
+			};
+		};
+
+		/* UART0 */
+		serial0: serial@4500 {
+			cell-index = <0>;
+			device_type = "serial";
+			compatible = "ns16550";
+			reg = <0x4500 0x100>;
+			clock-frequency = <0>;
+			interrupts = <42 2>;
+			interrupt-parent = <&mpic>;
+		};
+
+		/* UART1 */
+		serial1: serial@4600 {
+			cell-index = <1>;
+			device_type = "serial";
+			compatible = "ns16550";
+			reg = <0x4600 0x100>;
+			clock-frequency = <0>;
+			interrupts = <42 2>;
+			interrupt-parent = <&mpic>;
+		};
+
+		global-utilities@e0000 {	//global utilities block
+			compatible = "fsl,mpc8572-guts";
+			reg = <0xe0000 0x1000>;
+			fsl,has-rstcr;
+		};
+
+		msi@41600 {
+			compatible = "fsl,mpc8572-msi", "fsl,mpic-msi";
+			reg = <0x41600 0x80>;
+			msi-available-ranges = <0 0x100>;
+			interrupts = <
+				0xe0 0
+				0xe1 0
+				0xe2 0
+				0xe3 0
+				0xe4 0
+				0xe5 0
+				0xe6 0
+				0xe7 0>;
+			interrupt-parent = <&mpic>;
+		};
+
+		crypto@30000 {
+			compatible = "fsl,sec3.0", "fsl,sec2.4", "fsl,sec2.2",
+				     "fsl,sec2.1", "fsl,sec2.0";
+			reg = <0x30000 0x10000>;
+			interrupts = <45 2 58 2>;
+			interrupt-parent = <&mpic>;
+			fsl,num-channels = <4>;
+			fsl,channel-fifo-len = <24>;
+			fsl,exec-units-mask = <0x9fe>;
+			fsl,descriptor-types-mask = <0x3ab0ebf>;
+		};
+
+		mpic: pic@40000 {
+			interrupt-controller;
+			#address-cells = <0>;
+			#interrupt-cells = <2>;
+			reg = <0x40000 0x40000>;
+			compatible = "chrp,open-pic";
+			device_type = "open-pic";
+		};
+
+		gpio0: gpio@f000 {
+			compatible = "fsl,mpc8572-gpio";
+			reg = <0xf000 0x1000>;
+			interrupts = <47 2>;
+			interrupt-parent = <&mpic>;
+			#gpio-cells = <2>;
+			gpio-controller;
+		};
+
+		gpio-leds {
+			compatible = "gpio-leds";
+
+			heartbeat {
+				label = "Heartbeat";
+				gpios = <&gpio0 4 1>;
+				linux,default-trigger = "heartbeat";
+			};
+
+			yellow {
+				label = "Yellow";
+				gpios = <&gpio0 5 1>;
+			};
+
+			red {
+				label = "Red";
+				gpios = <&gpio0 6 1>;
+			};
+
+			green {
+				label = "Green";
+				gpios = <&gpio0 7 1>;
+			};
+		};
+
+		/* PME (pattern-matcher) */
+		pme@10000 {
+			compatible = "fsl,mpc8572-pme", "pme8572";
+			reg = <0x10000 0x5000>;
+			interrupts = <57 2 64 2 65 2 66 2 67 2>;
+			interrupt-parent = <&mpic>;
+		};
+
+		tlu@2f000 {
+			compatible = "fsl,mpc8572-tlu", "fsl_tlu";
+			reg = <0x2f000 0x1000>;
+			interupts = <61 2 >;
+			interrupt-parent = <&mpic>;
+		};
+
+		tlu@15000 {
+			compatible = "fsl,mpc8572-tlu", "fsl_tlu";
+			reg = <0x15000 0x1000>;
+			interupts = <75 2>;
+			interrupt-parent = <&mpic>;
+		};
+	};
+
+	/*
+	 * PCI Express controller 3 @ ef008000 is not used.
+	 * This would have been pci0 on other mpc85xx platforms.
+	 */
+
+	/* PCI Express controller 2, wired to VPX P1,P2 backplane */
+	pci1: pcie@ef009000 {
+		compatible = "fsl,mpc8548-pcie";
+		device_type = "pci";
+		#interrupt-cells = <1>;
+		#size-cells = <2>;
+		#address-cells = <3>;
+		reg = <0 0xef009000 0 0x1000>;
+		bus-range = <0 255>;
+		ranges = <0x2000000 0x0 0xc0000000 0 0xc0000000 0x0 0x10000000
+			  0x1000000 0x0 0x00000000 0 0xe8800000 0x0 0x00010000>;
+		clock-frequency = <33333333>;
+		interrupt-parent = <&mpic>;
+		interrupts = <25 2>;
+		interrupt-map-mask = <0xf800 0x0 0x0 0x7>;
+		interrupt-map = <
+			/* IDSEL 0x0 */
+			0x0 0x0 0x0 0x1 &mpic 0x4 0x1
+			0x0 0x0 0x0 0x2 &mpic 0x5 0x1
+			0x0 0x0 0x0 0x3 &mpic 0x6 0x1
+			0x0 0x0 0x0 0x4 &mpic 0x7 0x1
+			>;
+		pcie@0 {
+			reg = <0x00000000 0x00000000 0x00000000 0x00000000 0x00000000>;
+			#size-cells = <2>;
+			#address-cells = <3>;
+			device_type = "pci";
+			ranges = <0x2000000 0x0 0xc0000000
+				  0x2000000 0x0 0xc0000000
+				  0x0 0x10000000
+
+				  0x1000000 0x0 0x0
+				  0x1000000 0x0 0x0
+				  0x0 0x100000>;
+		};
+	};
+
+	/* PCI Express controller 1, wired to PEX8518 PCIe switch */
+	pci2: pcie@ef00a000 {
+		compatible = "fsl,mpc8548-pcie";
+		device_type = "pci";
+		#interrupt-cells = <1>;
+		#size-cells = <2>;
+		#address-cells = <3>;
+		reg = <0 0xef00a000 0 0x1000>;
+		bus-range = <0 255>;
+		ranges = <0x2000000 0x0 0x80000000 0 0x80000000 0x0 0x40000000
+			  0x1000000 0x0 0x00000000 0 0xe8000000 0x0 0x10000>;
+		clock-frequency = <33333333>;
+		interrupt-parent = <&mpic>;
+		interrupts = <26 2>;
+		interrupt-map-mask = <0xf800 0x0 0x0 0x7>;
+		interrupt-map = <
+			/* IDSEL 0x0 */
+			0x0 0x0 0x0 0x1 &mpic 0x0 0x1
+			0x0 0x0 0x0 0x2 &mpic 0x1 0x1
+			0x0 0x0 0x0 0x3 &mpic 0x2 0x1
+			0x0 0x0 0x0 0x4 &mpic 0x3 0x1
+			>;
+		pcie@0 {
+			reg = <0x0 0x0 0x0 0x0 0x0>;
+			#size-cells = <2>;
+			#address-cells = <3>;
+			device_type = "pci";
+			ranges = <0x2000000 0x0 0x80000000
+				  0x2000000 0x0 0x80000000
+				  0x0 0x40000000
+
+				  0x1000000 0x0 0x0
+				  0x1000000 0x0 0x0
+				  0x0 0x100000>;
+		};
+	};
+};
-- 
1.6.0.4

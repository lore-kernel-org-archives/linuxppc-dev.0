Return-Path: <ncase@xes-inc.com>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id C53BBB70CA
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue,  9 Jun 2009 09:06:31 +1000 (EST)
Received: from xes-mad.com (xes-mad.com [216.165.139.214])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 1792EDDD0B
	for <linuxppc-dev@ozlabs.org>; Tue,  9 Jun 2009 09:06:27 +1000 (EST)
From: Nate Case <ncase@xes-inc.com>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: [PATCH -next] powerpc/85xx: Add support for X-ES MPC85xx boards
Date: Mon,  8 Jun 2009 17:13:48 -0500
Message-Id: <1244499228-18602-1-git-send-email-ncase@xes-inc.com>
Cc: linuxppc-dev@ozlabs.org, Nate Case <ncase@xes-inc.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Add support for X-ES single-board computers based on the Freescale
MPC85xx processors.  Changes include:

  * New machine support in platforms/85xx
  * dts files for supported boards
  * defconfig
  * A couple small additions to reg_booke.h for some needed bit
    definitions
  * Boot wrapper support for XPedite5200 to support legacy boot loader

Signed-off-by: Nate Case <ncase@xes-inc.com>
---
 arch/powerpc/boot/dts/xcalibur1501.dts          |  759 +++++++++++
 arch/powerpc/boot/dts/xpedite5200.dts           |  472 +++++++
 arch/powerpc/boot/dts/xpedite5200_xmon.dts      |  510 +++++++
 arch/powerpc/boot/dts/xpedite5301.dts           |  647 +++++++++
 arch/powerpc/boot/dts/xpedite5330.dts           |  714 ++++++++++
 arch/powerpc/boot/dts/xpedite5370.dts           |  683 ++++++++++
 arch/powerpc/boot/wrapper                       |    4 +
 arch/powerpc/configs/85xx/xes_mpc85xx_defconfig | 1668 +++++++++++++++++++++++
 arch/powerpc/include/asm/reg_booke.h            |    2 +
 arch/powerpc/platforms/85xx/Kconfig             |   10 +
 arch/powerpc/platforms/85xx/Makefile            |    1 +
 arch/powerpc/platforms/85xx/xes_mpc85xx.c       |  332 +++++
 12 files changed, 5802 insertions(+), 0 deletions(-)
 create mode 100644 arch/powerpc/boot/dts/xcalibur1501.dts
 create mode 100644 arch/powerpc/boot/dts/xpedite5200.dts
 create mode 100644 arch/powerpc/boot/dts/xpedite5200_xmon.dts
 create mode 100644 arch/powerpc/boot/dts/xpedite5301.dts
 create mode 100644 arch/powerpc/boot/dts/xpedite5330.dts
 create mode 100644 arch/powerpc/boot/dts/xpedite5370.dts
 create mode 100644 arch/powerpc/configs/85xx/xes_mpc85xx_defconfig
 create mode 100644 arch/powerpc/platforms/85xx/xes_mpc85xx.c

diff --git a/arch/powerpc/boot/dts/xcalibur1501.dts b/arch/powerpc/boot/dts/xcalibur1501.dts
new file mode 100644
index 0000000..497af7a
--- /dev/null
+++ b/arch/powerpc/boot/dts/xcalibur1501.dts
@@ -0,0 +1,759 @@
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
+	form-factor = "6U cPCI";
+	boot-bank = <0x0>;	/* 0: Primary flash, 1: Secondary flash */
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
+
+		pmcslot@1 {
+			cell-index = <1>;
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
+
+		xmcslot@1 {
+			cell-index = <1>;
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
+		compatible = "simple-bus";
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
+					device_type = "ethernet-phy";
+				};
+				phy1: ethernet-phy@2 {
+					interrupt-parent = <&mpic>;
+					interrupts = <4 1>;
+					reg = <0x2>;
+					device_type = "ethernet-phy";
+				};
+				phy2: ethernet-phy@3 {
+					interrupt-parent = <&mpic>;
+					interrupts = <5 1>;
+					reg = <0x3>;
+					device_type = "ethernet-phy";
+				};
+				phy3: ethernet-phy@4 {
+					interrupt-parent = <&mpic>;
+					interrupts = <5 1>;
+					reg = <0x4>;
+					device_type = "ethernet-phy";
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
+			/* U-Boot should populate as RS-232, RS-485, etc */
+			transceiver-mode = "Unknown";
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
+			/* U-Boot should populate as RS-232, RS-485, etc */
+			transceiver-mode = "Unknown";
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
+			device_type = "tlu";
+			compatible = "fsl,mpc8572-tlu", "fsl_tlu";
+			reg = <0x2f000 0x1000>;
+			interupts = <61 2 >;
+			interrupt-parent = <&mpic>;
+		};
+
+		tlu@15000 {
+			device_type = "tlu";
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
index 0000000..15a5883
--- /dev/null
+++ b/arch/powerpc/boot/dts/xpedite5200.dts
@@ -0,0 +1,472 @@
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
+		compatible = "simple-bus";
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
+					device_type = "ethernet-phy";
+				};
+				phy1: ethernet-phy@2 {
+					interrupt-parent = <&mpic>;
+					interrupts = <8 1>;
+					reg = <0x2>;
+					device_type = "ethernet-phy";
+				};
+				phy2: ethernet-phy@3 {
+					interrupt-parent = <&mpic>;
+					interrupts = <8 1>;
+					reg = <0x3>;
+					device_type = "ethernet-phy";
+				};
+				phy3: ethernet-phy@4 {
+					interrupt-parent = <&mpic>;
+					interrupts = <8 1>;
+					reg = <0x4>;
+					device_type = "ethernet-phy";
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
index 0000000..a29d147
--- /dev/null
+++ b/arch/powerpc/boot/dts/xpedite5200_xmon.dts
@@ -0,0 +1,510 @@
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
+		reg = <0x0 0x0>;
+	};
+
+	soc@ef000000 {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		device_type = "soc";
+		ranges = <0x0 0xef000000 0x100000>;
+		bus-frequency = <0>;
+		compatible = "simple-bus";
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
+					device_type = "ethernet-phy";
+				};
+				phy1: ethernet-phy@2 {
+					interrupt-parent = <&mpic>;
+					interrupts = <8 1>;
+					reg = <0x2>;
+					device_type = "ethernet-phy";
+				};
+				phy2: ethernet-phy@3 {
+					interrupt-parent = <&mpic>;
+					interrupts = <8 1>;
+					reg = <0x3>;
+					device_type = "ethernet-phy";
+				};
+				phy3: ethernet-phy@4 {
+					interrupt-parent = <&mpic>;
+					interrupts = <8 1>;
+					reg = <0x4>;
+					device_type = "ethernet-phy";
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
index 0000000..3e6f4f9
--- /dev/null
+++ b/arch/powerpc/boot/dts/xpedite5301.dts
@@ -0,0 +1,647 @@
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
+		compatible = "simple-bus";
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
+					device_type = "ethernet-phy";
+				};
+				phy1: ethernet-phy@2 {
+					interrupt-parent = <&mpic>;
+					interrupts = <8 1>;
+					reg = <0x2>;
+					device_type = "ethernet-phy";
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
+			/* U-Boot should populate as RS-232, RS-485, etc */
+			transceiver-mode = "Unknown";
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
+			/* U-Boot should populate as RS-232, RS-485, etc */
+			transceiver-mode = "Unknown";
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
+			device_type = "tlu";
+			compatible = "fsl,mpc8572-tlu", "fsl_tlu";
+			reg = <0x2f000 0x1000>;
+			interupts = <61 2 >;
+			interrupt-parent = <&mpic>;
+		};
+
+		tlu@15000 {
+			device_type = "tlu";
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
index 0000000..44cbe99
--- /dev/null
+++ b/arch/powerpc/boot/dts/xpedite5330.dts
@@ -0,0 +1,714 @@
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
+		compatible = "simple-bus";
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
+					device_type = "ethernet-phy";
+				};
+				phy1: ethernet-phy@2 {
+					interrupt-parent = <&mpic>;
+					interrupts = <8 1>;
+					reg = <0x2>;
+					device_type = "ethernet-phy";
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
+			/* U-Boot should populate as RS-232, RS-485, etc */
+			transceiver-mode = "Unknown";
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
+			/* U-Boot should populate as RS-232, RS-485, etc */
+			transceiver-mode = "Unknown";
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
+			device_type = "tlu";
+			compatible = "fsl,mpc8572-tlu", "fsl_tlu";
+			reg = <0x2f000 0x1000>;
+			interupts = <61 2 >;
+			interrupt-parent = <&mpic>;
+		};
+
+		tlu@15000 {
+			device_type = "tlu";
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
index 0000000..fc26c82
--- /dev/null
+++ b/arch/powerpc/boot/dts/xpedite5370.dts
@@ -0,0 +1,683 @@
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
+	form-factor = "3U VPX";
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
+	vpx {
+		geographical-address = <0x0>;
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
+		compatible = "simple-bus";
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
+					device_type = "ethernet-phy";
+				};
+				phy1: ethernet-phy@2 {
+					interrupt-parent = <&mpic>;
+					interrupts = <8 1>;
+					reg = <0x2>;
+					device_type = "ethernet-phy";
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
+			/* U-Boot should populate as RS-232, RS-485, etc */
+			transceiver-mode = "Unknown";
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
+			/* U-Boot should populate as RS-232, RS-485, etc */
+			transceiver-mode = "Unknown";
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
+			device_type = "tlu";
+			compatible = "fsl,mpc8572-tlu", "fsl_tlu";
+			reg = <0x2f000 0x1000>;
+			interupts = <61 2 >;
+			interrupt-parent = <&mpic>;
+		};
+
+		tlu@15000 {
+			device_type = "tlu";
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
diff --git a/arch/powerpc/boot/wrapper b/arch/powerpc/boot/wrapper
index 3ac75ae..4db487d 100755
--- a/arch/powerpc/boot/wrapper
+++ b/arch/powerpc/boot/wrapper
@@ -225,6 +225,10 @@ asp834x-redboot)
     platformo="$object/fixed-head.o $object/redboot-83xx.o"
     binary=y
     ;;
+xpedite52*)
+    link_address='0x1400000'
+    platformo=$object/cuboot-85xx.o
+    ;;
 esac
 
 vmz="$tmpdir/`basename \"$kernel\"`.$ext"
diff --git a/arch/powerpc/configs/85xx/xes_mpc85xx_defconfig b/arch/powerpc/configs/85xx/xes_mpc85xx_defconfig
new file mode 100644
index 0000000..86a3afe
--- /dev/null
+++ b/arch/powerpc/configs/85xx/xes_mpc85xx_defconfig
@@ -0,0 +1,1668 @@
+#
+# Automatically generated make config: don't edit
+# Linux kernel version: 2.6.30-rc4
+# Mon May 11 18:44:08 2009
+#
+# CONFIG_PPC64 is not set
+
+#
+# Processor support
+#
+# CONFIG_6xx is not set
+CONFIG_PPC_85xx=y
+# CONFIG_PPC_8xx is not set
+# CONFIG_40x is not set
+# CONFIG_44x is not set
+# CONFIG_E200 is not set
+CONFIG_E500=y
+# CONFIG_PPC_E500MC is not set
+CONFIG_BOOKE=y
+CONFIG_FSL_BOOKE=y
+CONFIG_FSL_EMB_PERFMON=y
+# CONFIG_PHYS_64BIT is not set
+CONFIG_SPE=y
+CONFIG_PPC_MMU_NOHASH=y
+CONFIG_PPC_BOOK3E_MMU=y
+# CONFIG_PPC_MM_SLICES is not set
+CONFIG_SMP=y
+CONFIG_NR_CPUS=2
+CONFIG_PPC32=y
+CONFIG_WORD_SIZE=32
+# CONFIG_ARCH_PHYS_ADDR_T_64BIT is not set
+CONFIG_MMU=y
+CONFIG_GENERIC_CMOS_UPDATE=y
+CONFIG_GENERIC_TIME=y
+CONFIG_GENERIC_TIME_VSYSCALL=y
+CONFIG_GENERIC_CLOCKEVENTS=y
+CONFIG_GENERIC_HARDIRQS=y
+# CONFIG_HAVE_SETUP_PER_CPU_AREA is not set
+CONFIG_IRQ_PER_CPU=y
+CONFIG_STACKTRACE_SUPPORT=y
+CONFIG_HAVE_LATENCYTOP_SUPPORT=y
+CONFIG_LOCKDEP_SUPPORT=y
+CONFIG_RWSEM_XCHGADD_ALGORITHM=y
+CONFIG_ARCH_HAS_ILOG2_U32=y
+CONFIG_GENERIC_HWEIGHT=y
+CONFIG_GENERIC_CALIBRATE_DELAY=y
+CONFIG_GENERIC_FIND_NEXT_BIT=y
+CONFIG_GENERIC_GPIO=y
+# CONFIG_ARCH_NO_VIRT_TO_BUS is not set
+CONFIG_PPC=y
+CONFIG_EARLY_PRINTK=y
+CONFIG_GENERIC_NVRAM=y
+CONFIG_SCHED_OMIT_FRAME_POINTER=y
+CONFIG_ARCH_MAY_HAVE_PC_FDC=y
+CONFIG_PPC_OF=y
+CONFIG_OF=y
+CONFIG_PPC_UDBG_16550=y
+CONFIG_GENERIC_TBSYNC=y
+CONFIG_AUDIT_ARCH=y
+CONFIG_GENERIC_BUG=y
+CONFIG_DTC=y
+CONFIG_DEFAULT_UIMAGE=y
+# CONFIG_PPC_DCR_NATIVE is not set
+# CONFIG_PPC_DCR_MMIO is not set
+CONFIG_ARCH_SUPPORTS_DEBUG_PAGEALLOC=y
+CONFIG_DEFCONFIG_LIST="/lib/modules/$UNAME_RELEASE/.config"
+
+#
+# General setup
+#
+CONFIG_EXPERIMENTAL=y
+CONFIG_LOCK_KERNEL=y
+CONFIG_INIT_ENV_ARG_LIMIT=32
+CONFIG_LOCALVERSION=""
+CONFIG_LOCALVERSION_AUTO=y
+CONFIG_SWAP=y
+CONFIG_SYSVIPC=y
+CONFIG_SYSVIPC_SYSCTL=y
+CONFIG_POSIX_MQUEUE=y
+CONFIG_POSIX_MQUEUE_SYSCTL=y
+CONFIG_BSD_PROCESS_ACCT=y
+# CONFIG_BSD_PROCESS_ACCT_V3 is not set
+# CONFIG_TASKSTATS is not set
+CONFIG_AUDIT=y
+# CONFIG_AUDITSYSCALL is not set
+
+#
+# RCU Subsystem
+#
+CONFIG_CLASSIC_RCU=y
+# CONFIG_TREE_RCU is not set
+# CONFIG_PREEMPT_RCU is not set
+# CONFIG_TREE_RCU_TRACE is not set
+# CONFIG_PREEMPT_RCU_TRACE is not set
+CONFIG_IKCONFIG=y
+CONFIG_IKCONFIG_PROC=y
+CONFIG_LOG_BUF_SHIFT=14
+# CONFIG_GROUP_SCHED is not set
+# CONFIG_CGROUPS is not set
+CONFIG_SYSFS_DEPRECATED=y
+CONFIG_SYSFS_DEPRECATED_V2=y
+# CONFIG_RELAY is not set
+# CONFIG_NAMESPACES is not set
+CONFIG_BLK_DEV_INITRD=y
+CONFIG_INITRAMFS_SOURCE=""
+CONFIG_RD_GZIP=y
+# CONFIG_RD_BZIP2 is not set
+# CONFIG_RD_LZMA is not set
+# CONFIG_CC_OPTIMIZE_FOR_SIZE is not set
+CONFIG_SYSCTL=y
+CONFIG_ANON_INODES=y
+CONFIG_EMBEDDED=y
+CONFIG_SYSCTL_SYSCALL=y
+CONFIG_KALLSYMS=y
+CONFIG_KALLSYMS_ALL=y
+CONFIG_KALLSYMS_EXTRA_PASS=y
+# CONFIG_STRIP_ASM_SYMS is not set
+CONFIG_HOTPLUG=y
+CONFIG_PRINTK=y
+CONFIG_BUG=y
+CONFIG_ELF_CORE=y
+CONFIG_BASE_FULL=y
+CONFIG_FUTEX=y
+CONFIG_EPOLL=y
+CONFIG_SIGNALFD=y
+CONFIG_TIMERFD=y
+CONFIG_EVENTFD=y
+CONFIG_SHMEM=y
+CONFIG_AIO=y
+CONFIG_VM_EVENT_COUNTERS=y
+CONFIG_PCI_QUIRKS=y
+CONFIG_SLUB_DEBUG=y
+CONFIG_COMPAT_BRK=y
+# CONFIG_SLAB is not set
+CONFIG_SLUB=y
+# CONFIG_SLOB is not set
+# CONFIG_PROFILING is not set
+# CONFIG_MARKERS is not set
+CONFIG_HAVE_OPROFILE=y
+# CONFIG_KPROBES is not set
+CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS=y
+CONFIG_HAVE_IOREMAP_PROT=y
+CONFIG_HAVE_KPROBES=y
+CONFIG_HAVE_KRETPROBES=y
+CONFIG_HAVE_ARCH_TRACEHOOK=y
+CONFIG_USE_GENERIC_SMP_HELPERS=y
+# CONFIG_SLOW_WORK is not set
+# CONFIG_HAVE_GENERIC_DMA_COHERENT is not set
+CONFIG_SLABINFO=y
+CONFIG_RT_MUTEXES=y
+CONFIG_BASE_SMALL=0
+CONFIG_MODULES=y
+# CONFIG_MODULE_FORCE_LOAD is not set
+CONFIG_MODULE_UNLOAD=y
+CONFIG_MODULE_FORCE_UNLOAD=y
+CONFIG_MODVERSIONS=y
+# CONFIG_MODULE_SRCVERSION_ALL is not set
+CONFIG_STOP_MACHINE=y
+CONFIG_BLOCK=y
+CONFIG_LBD=y
+# CONFIG_BLK_DEV_BSG is not set
+# CONFIG_BLK_DEV_INTEGRITY is not set
+
+#
+# IO Schedulers
+#
+CONFIG_IOSCHED_NOOP=y
+CONFIG_IOSCHED_AS=y
+CONFIG_IOSCHED_DEADLINE=y
+CONFIG_IOSCHED_CFQ=y
+# CONFIG_DEFAULT_AS is not set
+# CONFIG_DEFAULT_DEADLINE is not set
+CONFIG_DEFAULT_CFQ=y
+# CONFIG_DEFAULT_NOOP is not set
+CONFIG_DEFAULT_IOSCHED="cfq"
+# CONFIG_FREEZER is not set
+CONFIG_PPC_MSI_BITMAP=y
+
+#
+# Platform support
+#
+# CONFIG_PPC_CELL is not set
+# CONFIG_PPC_CELL_NATIVE is not set
+# CONFIG_PQ2ADS is not set
+CONFIG_MPC85xx=y
+# CONFIG_MPC8540_ADS is not set
+# CONFIG_MPC8560_ADS is not set
+# CONFIG_MPC85xx_CDS is not set
+# CONFIG_MPC85xx_MDS is not set
+# CONFIG_MPC8536_DS is not set
+# CONFIG_MPC85xx_DS is not set
+# CONFIG_SOCRATES is not set
+# CONFIG_KSI8560 is not set
+CONFIG_XES_MPC85xx=y
+# CONFIG_STX_GP3 is not set
+# CONFIG_TQM8540 is not set
+# CONFIG_TQM8541 is not set
+# CONFIG_TQM8548 is not set
+# CONFIG_TQM8555 is not set
+# CONFIG_TQM8560 is not set
+# CONFIG_SBC8548 is not set
+# CONFIG_SBC8560 is not set
+# CONFIG_IPIC is not set
+CONFIG_MPIC=y
+# CONFIG_MPIC_WEIRD is not set
+# CONFIG_PPC_I8259 is not set
+# CONFIG_PPC_RTAS is not set
+# CONFIG_MMIO_NVRAM is not set
+# CONFIG_PPC_MPC106 is not set
+# CONFIG_PPC_970_NAP is not set
+# CONFIG_PPC_INDIRECT_IO is not set
+# CONFIG_GENERIC_IOMAP is not set
+# CONFIG_CPU_FREQ is not set
+# CONFIG_QUICC_ENGINE is not set
+# CONFIG_CPM2 is not set
+# CONFIG_FSL_ULI1575 is not set
+CONFIG_MPC8xxx_GPIO=y
+# CONFIG_SIMPLE_GPIO is not set
+
+#
+# Kernel options
+#
+CONFIG_HIGHMEM=y
+# CONFIG_NO_HZ is not set
+# CONFIG_HIGH_RES_TIMERS is not set
+CONFIG_GENERIC_CLOCKEVENTS_BUILD=y
+# CONFIG_HZ_100 is not set
+CONFIG_HZ_250=y
+# CONFIG_HZ_300 is not set
+# CONFIG_HZ_1000 is not set
+CONFIG_HZ=250
+# CONFIG_SCHED_HRTICK is not set
+CONFIG_PREEMPT_NONE=y
+# CONFIG_PREEMPT_VOLUNTARY is not set
+# CONFIG_PREEMPT is not set
+CONFIG_BINFMT_ELF=y
+# CONFIG_CORE_DUMP_DEFAULT_ELF_HEADERS is not set
+# CONFIG_HAVE_AOUT is not set
+# CONFIG_BINFMT_MISC is not set
+CONFIG_MATH_EMULATION=y
+# CONFIG_IOMMU_HELPER is not set
+CONFIG_ARCH_ENABLE_MEMORY_HOTPLUG=y
+CONFIG_ARCH_HAS_WALK_MEMORY=y
+CONFIG_ARCH_ENABLE_MEMORY_HOTREMOVE=y
+# CONFIG_IRQ_ALL_CPUS is not set
+CONFIG_ARCH_FLATMEM_ENABLE=y
+CONFIG_ARCH_POPULATES_NODE_MAP=y
+CONFIG_SELECT_MEMORY_MODEL=y
+CONFIG_FLATMEM_MANUAL=y
+# CONFIG_DISCONTIGMEM_MANUAL is not set
+# CONFIG_SPARSEMEM_MANUAL is not set
+CONFIG_FLATMEM=y
+CONFIG_FLAT_NODE_MEM_MAP=y
+CONFIG_PAGEFLAGS_EXTENDED=y
+CONFIG_SPLIT_PTLOCK_CPUS=4
+CONFIG_MIGRATION=y
+# CONFIG_PHYS_ADDR_T_64BIT is not set
+CONFIG_ZONE_DMA_FLAG=1
+CONFIG_BOUNCE=y
+CONFIG_VIRT_TO_BUS=y
+CONFIG_UNEVICTABLE_LRU=y
+CONFIG_HAVE_MLOCK=y
+CONFIG_HAVE_MLOCKED_PAGE_BIT=y
+CONFIG_PPC_4K_PAGES=y
+# CONFIG_PPC_16K_PAGES is not set
+# CONFIG_PPC_64K_PAGES is not set
+# CONFIG_PPC_256K_PAGES is not set
+CONFIG_FORCE_MAX_ZONEORDER=11
+CONFIG_PROC_DEVICETREE=y
+# CONFIG_CMDLINE_BOOL is not set
+CONFIG_EXTRA_TARGETS=""
+# CONFIG_PM is not set
+CONFIG_SECCOMP=y
+CONFIG_ISA_DMA_API=y
+
+#
+# Bus options
+#
+CONFIG_ZONE_DMA=y
+CONFIG_PPC_INDIRECT_PCI=y
+CONFIG_FSL_SOC=y
+CONFIG_FSL_PCI=y
+CONFIG_FSL_LBC=y
+CONFIG_PPC_PCI_CHOICE=y
+CONFIG_PCI=y
+CONFIG_PCI_DOMAINS=y
+CONFIG_PCI_SYSCALL=y
+CONFIG_PCIEPORTBUS=y
+CONFIG_PCIEAER=y
+# CONFIG_PCIEASPM is not set
+CONFIG_ARCH_SUPPORTS_MSI=y
+CONFIG_PCI_MSI=y
+CONFIG_PCI_LEGACY=y
+# CONFIG_PCI_DEBUG is not set
+# CONFIG_PCI_STUB is not set
+# CONFIG_PCI_IOV is not set
+# CONFIG_PCCARD is not set
+# CONFIG_HOTPLUG_PCI is not set
+# CONFIG_HAS_RAPIDIO is not set
+
+#
+# Advanced setup
+#
+CONFIG_ADVANCED_OPTIONS=y
+CONFIG_LOWMEM_SIZE_BOOL=y
+CONFIG_LOWMEM_SIZE=0x40000000
+# CONFIG_LOWMEM_CAM_NUM_BOOL is not set
+CONFIG_LOWMEM_CAM_NUM=3
+# CONFIG_RELOCATABLE is not set
+CONFIG_PAGE_OFFSET_BOOL=y
+CONFIG_PAGE_OFFSET=0x80000000
+CONFIG_KERNEL_START_BOOL=y
+CONFIG_KERNEL_START=0x80000000
+# CONFIG_PHYSICAL_START_BOOL is not set
+CONFIG_PHYSICAL_START=0x00000000
+CONFIG_PHYSICAL_ALIGN=0x04000000
+CONFIG_TASK_SIZE_BOOL=y
+CONFIG_TASK_SIZE=0x80000000
+CONFIG_NET=y
+
+#
+# Networking options
+#
+CONFIG_PACKET=y
+# CONFIG_PACKET_MMAP is not set
+CONFIG_UNIX=y
+CONFIG_XFRM=y
+CONFIG_XFRM_USER=y
+# CONFIG_XFRM_SUB_POLICY is not set
+# CONFIG_XFRM_MIGRATE is not set
+# CONFIG_XFRM_STATISTICS is not set
+CONFIG_NET_KEY=y
+# CONFIG_NET_KEY_MIGRATE is not set
+CONFIG_INET=y
+CONFIG_IP_MULTICAST=y
+CONFIG_IP_ADVANCED_ROUTER=y
+CONFIG_ASK_IP_FIB_HASH=y
+# CONFIG_IP_FIB_TRIE is not set
+CONFIG_IP_FIB_HASH=y
+CONFIG_IP_MULTIPLE_TABLES=y
+CONFIG_IP_ROUTE_MULTIPATH=y
+CONFIG_IP_ROUTE_VERBOSE=y
+CONFIG_IP_PNP=y
+CONFIG_IP_PNP_DHCP=y
+CONFIG_IP_PNP_BOOTP=y
+CONFIG_IP_PNP_RARP=y
+CONFIG_NET_IPIP=y
+CONFIG_NET_IPGRE=y
+CONFIG_NET_IPGRE_BROADCAST=y
+CONFIG_IP_MROUTE=y
+CONFIG_IP_PIMSM_V1=y
+CONFIG_IP_PIMSM_V2=y
+CONFIG_ARPD=y
+# CONFIG_SYN_COOKIES is not set
+# CONFIG_INET_AH is not set
+# CONFIG_INET_ESP is not set
+# CONFIG_INET_IPCOMP is not set
+# CONFIG_INET_XFRM_TUNNEL is not set
+CONFIG_INET_TUNNEL=y
+# CONFIG_INET_XFRM_MODE_TRANSPORT is not set
+# CONFIG_INET_XFRM_MODE_TUNNEL is not set
+# CONFIG_INET_XFRM_MODE_BEET is not set
+# CONFIG_INET_LRO is not set
+CONFIG_INET_DIAG=y
+CONFIG_INET_TCP_DIAG=y
+# CONFIG_TCP_CONG_ADVANCED is not set
+CONFIG_TCP_CONG_CUBIC=y
+CONFIG_DEFAULT_TCP_CONG="cubic"
+# CONFIG_TCP_MD5SIG is not set
+CONFIG_IPV6=y
+# CONFIG_IPV6_PRIVACY is not set
+# CONFIG_IPV6_ROUTER_PREF is not set
+# CONFIG_IPV6_OPTIMISTIC_DAD is not set
+# CONFIG_INET6_AH is not set
+# CONFIG_INET6_ESP is not set
+# CONFIG_INET6_IPCOMP is not set
+# CONFIG_IPV6_MIP6 is not set
+# CONFIG_INET6_XFRM_TUNNEL is not set
+# CONFIG_INET6_TUNNEL is not set
+CONFIG_INET6_XFRM_MODE_TRANSPORT=y
+CONFIG_INET6_XFRM_MODE_TUNNEL=y
+CONFIG_INET6_XFRM_MODE_BEET=y
+# CONFIG_INET6_XFRM_MODE_ROUTEOPTIMIZATION is not set
+CONFIG_IPV6_SIT=y
+CONFIG_IPV6_NDISC_NODETYPE=y
+# CONFIG_IPV6_TUNNEL is not set
+# CONFIG_IPV6_MULTIPLE_TABLES is not set
+# CONFIG_IPV6_MROUTE is not set
+# CONFIG_NETWORK_SECMARK is not set
+# CONFIG_NETFILTER is not set
+# CONFIG_IP_DCCP is not set
+# CONFIG_IP_SCTP is not set
+# CONFIG_TIPC is not set
+# CONFIG_ATM is not set
+# CONFIG_BRIDGE is not set
+# CONFIG_NET_DSA is not set
+# CONFIG_VLAN_8021Q is not set
+# CONFIG_DECNET is not set
+# CONFIG_LLC2 is not set
+# CONFIG_IPX is not set
+# CONFIG_ATALK is not set
+# CONFIG_X25 is not set
+# CONFIG_LAPB is not set
+# CONFIG_ECONET is not set
+# CONFIG_WAN_ROUTER is not set
+# CONFIG_PHONET is not set
+# CONFIG_NET_SCHED is not set
+# CONFIG_DCB is not set
+
+#
+# Network testing
+#
+# CONFIG_NET_PKTGEN is not set
+# CONFIG_HAMRADIO is not set
+# CONFIG_CAN is not set
+# CONFIG_IRDA is not set
+# CONFIG_BT is not set
+# CONFIG_AF_RXRPC is not set
+CONFIG_FIB_RULES=y
+# CONFIG_WIRELESS is not set
+# CONFIG_WIMAX is not set
+# CONFIG_RFKILL is not set
+# CONFIG_NET_9P is not set
+
+#
+# Device Drivers
+#
+
+#
+# Generic Driver Options
+#
+CONFIG_UEVENT_HELPER_PATH="/sbin/hotplug"
+CONFIG_STANDALONE=y
+CONFIG_PREVENT_FIRMWARE_BUILD=y
+CONFIG_FW_LOADER=y
+CONFIG_FIRMWARE_IN_KERNEL=y
+CONFIG_EXTRA_FIRMWARE=""
+# CONFIG_DEBUG_DRIVER is not set
+# CONFIG_DEBUG_DEVRES is not set
+# CONFIG_SYS_HYPERVISOR is not set
+# CONFIG_CONNECTOR is not set
+CONFIG_MTD=y
+# CONFIG_MTD_DEBUG is not set
+# CONFIG_MTD_CONCAT is not set
+CONFIG_MTD_PARTITIONS=y
+# CONFIG_MTD_TESTS is not set
+CONFIG_MTD_REDBOOT_PARTS=y
+CONFIG_MTD_REDBOOT_DIRECTORY_BLOCK=-1
+# CONFIG_MTD_REDBOOT_PARTS_UNALLOCATED is not set
+# CONFIG_MTD_REDBOOT_PARTS_READONLY is not set
+CONFIG_MTD_CMDLINE_PARTS=y
+CONFIG_MTD_OF_PARTS=y
+# CONFIG_MTD_AR7_PARTS is not set
+
+#
+# User Modules And Translation Layers
+#
+CONFIG_MTD_CHAR=y
+CONFIG_MTD_BLKDEVS=y
+CONFIG_MTD_BLOCK=y
+# CONFIG_FTL is not set
+# CONFIG_NFTL is not set
+# CONFIG_INFTL is not set
+# CONFIG_RFD_FTL is not set
+# CONFIG_SSFDC is not set
+# CONFIG_MTD_OOPS is not set
+
+#
+# RAM/ROM/Flash chip drivers
+#
+CONFIG_MTD_CFI=y
+CONFIG_MTD_JEDECPROBE=y
+CONFIG_MTD_GEN_PROBE=y
+# CONFIG_MTD_CFI_ADV_OPTIONS is not set
+CONFIG_MTD_MAP_BANK_WIDTH_1=y
+CONFIG_MTD_MAP_BANK_WIDTH_2=y
+CONFIG_MTD_MAP_BANK_WIDTH_4=y
+# CONFIG_MTD_MAP_BANK_WIDTH_8 is not set
+# CONFIG_MTD_MAP_BANK_WIDTH_16 is not set
+# CONFIG_MTD_MAP_BANK_WIDTH_32 is not set
+CONFIG_MTD_CFI_I1=y
+CONFIG_MTD_CFI_I2=y
+# CONFIG_MTD_CFI_I4 is not set
+# CONFIG_MTD_CFI_I8 is not set
+CONFIG_MTD_CFI_INTELEXT=y
+CONFIG_MTD_CFI_AMDSTD=y
+CONFIG_MTD_CFI_STAA=y
+CONFIG_MTD_CFI_UTIL=y
+# CONFIG_MTD_RAM is not set
+# CONFIG_MTD_ROM is not set
+# CONFIG_MTD_ABSENT is not set
+
+#
+# Mapping drivers for chip access
+#
+# CONFIG_MTD_COMPLEX_MAPPINGS is not set
+# CONFIG_MTD_PHYSMAP is not set
+CONFIG_MTD_PHYSMAP_OF=y
+# CONFIG_MTD_INTEL_VR_NOR is not set
+# CONFIG_MTD_PLATRAM is not set
+
+#
+# Self-contained MTD device drivers
+#
+# CONFIG_MTD_PMC551 is not set
+# CONFIG_MTD_SLRAM is not set
+# CONFIG_MTD_PHRAM is not set
+# CONFIG_MTD_MTDRAM is not set
+# CONFIG_MTD_BLOCK2MTD is not set
+
+#
+# Disk-On-Chip Device Drivers
+#
+# CONFIG_MTD_DOC2000 is not set
+# CONFIG_MTD_DOC2001 is not set
+# CONFIG_MTD_DOC2001PLUS is not set
+CONFIG_MTD_NAND=y
+# CONFIG_MTD_NAND_VERIFY_WRITE is not set
+# CONFIG_MTD_NAND_ECC_SMC is not set
+# CONFIG_MTD_NAND_MUSEUM_IDS is not set
+CONFIG_MTD_NAND_IDS=y
+# CONFIG_MTD_NAND_DISKONCHIP is not set
+# CONFIG_MTD_NAND_CAFE is not set
+# CONFIG_MTD_NAND_NANDSIM is not set
+# CONFIG_MTD_NAND_PLATFORM is not set
+CONFIG_MTD_NAND_FSL_ELBC=y
+CONFIG_MTD_NAND_FSL_UPM=y
+# CONFIG_MTD_ONENAND is not set
+
+#
+# LPDDR flash memory drivers
+#
+# CONFIG_MTD_LPDDR is not set
+
+#
+# UBI - Unsorted block images
+#
+# CONFIG_MTD_UBI is not set
+CONFIG_OF_DEVICE=y
+CONFIG_OF_GPIO=y
+CONFIG_OF_I2C=y
+# CONFIG_PARPORT is not set
+CONFIG_BLK_DEV=y
+# CONFIG_BLK_DEV_FD is not set
+# CONFIG_BLK_CPQ_DA is not set
+# CONFIG_BLK_CPQ_CISS_DA is not set
+# CONFIG_BLK_DEV_DAC960 is not set
+# CONFIG_BLK_DEV_UMEM is not set
+# CONFIG_BLK_DEV_COW_COMMON is not set
+CONFIG_BLK_DEV_LOOP=y
+# CONFIG_BLK_DEV_CRYPTOLOOP is not set
+CONFIG_BLK_DEV_NBD=y
+# CONFIG_BLK_DEV_SX8 is not set
+CONFIG_BLK_DEV_RAM=y
+CONFIG_BLK_DEV_RAM_COUNT=16
+CONFIG_BLK_DEV_RAM_SIZE=131072
+# CONFIG_BLK_DEV_XIP is not set
+# CONFIG_CDROM_PKTCDVD is not set
+# CONFIG_ATA_OVER_ETH is not set
+# CONFIG_BLK_DEV_HD is not set
+CONFIG_MISC_DEVICES=y
+# CONFIG_PHANTOM is not set
+# CONFIG_SGI_IOC4 is not set
+# CONFIG_TIFM_CORE is not set
+# CONFIG_ICS932S401 is not set
+# CONFIG_ENCLOSURE_SERVICES is not set
+# CONFIG_HP_ILO is not set
+# CONFIG_ISL29003 is not set
+# CONFIG_C2PORT is not set
+
+#
+# EEPROM support
+#
+# CONFIG_EEPROM_AT24 is not set
+# CONFIG_EEPROM_LEGACY is not set
+# CONFIG_EEPROM_93CX6 is not set
+CONFIG_HAVE_IDE=y
+# CONFIG_IDE is not set
+
+#
+# SCSI device support
+#
+# CONFIG_RAID_ATTRS is not set
+CONFIG_SCSI=y
+CONFIG_SCSI_DMA=y
+# CONFIG_SCSI_TGT is not set
+# CONFIG_SCSI_NETLINK is not set
+CONFIG_SCSI_PROC_FS=y
+
+#
+# SCSI support type (disk, tape, CD-ROM)
+#
+CONFIG_BLK_DEV_SD=y
+CONFIG_CHR_DEV_ST=y
+# CONFIG_CHR_DEV_OSST is not set
+CONFIG_BLK_DEV_SR=y
+# CONFIG_BLK_DEV_SR_VENDOR is not set
+CONFIG_CHR_DEV_SG=y
+# CONFIG_CHR_DEV_SCH is not set
+
+#
+# Some SCSI devices (e.g. CD jukebox) support multiple LUNs
+#
+CONFIG_SCSI_MULTI_LUN=y
+# CONFIG_SCSI_CONSTANTS is not set
+CONFIG_SCSI_LOGGING=y
+# CONFIG_SCSI_SCAN_ASYNC is not set
+CONFIG_SCSI_WAIT_SCAN=m
+
+#
+# SCSI Transports
+#
+# CONFIG_SCSI_SPI_ATTRS is not set
+# CONFIG_SCSI_FC_ATTRS is not set
+# CONFIG_SCSI_ISCSI_ATTRS is not set
+# CONFIG_SCSI_SAS_LIBSAS is not set
+# CONFIG_SCSI_SRP_ATTRS is not set
+CONFIG_SCSI_LOWLEVEL=y
+# CONFIG_ISCSI_TCP is not set
+# CONFIG_BLK_DEV_3W_XXXX_RAID is not set
+# CONFIG_SCSI_3W_9XXX is not set
+# CONFIG_SCSI_ACARD is not set
+# CONFIG_SCSI_AACRAID is not set
+# CONFIG_SCSI_AIC7XXX is not set
+# CONFIG_SCSI_AIC7XXX_OLD is not set
+# CONFIG_SCSI_AIC79XX is not set
+# CONFIG_SCSI_AIC94XX is not set
+# CONFIG_SCSI_DPT_I2O is not set
+# CONFIG_SCSI_ADVANSYS is not set
+# CONFIG_SCSI_ARCMSR is not set
+# CONFIG_MEGARAID_NEWGEN is not set
+# CONFIG_MEGARAID_LEGACY is not set
+# CONFIG_MEGARAID_SAS is not set
+# CONFIG_SCSI_MPT2SAS is not set
+# CONFIG_SCSI_HPTIOP is not set
+# CONFIG_SCSI_BUSLOGIC is not set
+# CONFIG_LIBFC is not set
+# CONFIG_LIBFCOE is not set
+# CONFIG_FCOE is not set
+# CONFIG_SCSI_DMX3191D is not set
+# CONFIG_SCSI_EATA is not set
+# CONFIG_SCSI_FUTURE_DOMAIN is not set
+# CONFIG_SCSI_GDTH is not set
+# CONFIG_SCSI_IPS is not set
+# CONFIG_SCSI_INITIO is not set
+# CONFIG_SCSI_INIA100 is not set
+# CONFIG_SCSI_MVSAS is not set
+# CONFIG_SCSI_STEX is not set
+# CONFIG_SCSI_SYM53C8XX_2 is not set
+# CONFIG_SCSI_IPR is not set
+# CONFIG_SCSI_QLOGIC_1280 is not set
+# CONFIG_SCSI_QLA_FC is not set
+# CONFIG_SCSI_QLA_ISCSI is not set
+# CONFIG_SCSI_LPFC is not set
+# CONFIG_SCSI_DC395x is not set
+# CONFIG_SCSI_DC390T is not set
+# CONFIG_SCSI_NSP32 is not set
+# CONFIG_SCSI_DEBUG is not set
+# CONFIG_SCSI_SRP is not set
+# CONFIG_SCSI_DH is not set
+# CONFIG_SCSI_OSD_INITIATOR is not set
+CONFIG_ATA=y
+# CONFIG_ATA_NONSTANDARD is not set
+CONFIG_SATA_PMP=y
+CONFIG_SATA_AHCI=y
+# CONFIG_SATA_SIL24 is not set
+# CONFIG_SATA_FSL is not set
+CONFIG_ATA_SFF=y
+# CONFIG_SATA_SVW is not set
+# CONFIG_ATA_PIIX is not set
+# CONFIG_SATA_MV is not set
+# CONFIG_SATA_NV is not set
+# CONFIG_PDC_ADMA is not set
+# CONFIG_SATA_QSTOR is not set
+# CONFIG_SATA_PROMISE is not set
+# CONFIG_SATA_SX4 is not set
+# CONFIG_SATA_SIL is not set
+# CONFIG_SATA_SIS is not set
+# CONFIG_SATA_ULI is not set
+# CONFIG_SATA_VIA is not set
+# CONFIG_SATA_VITESSE is not set
+# CONFIG_SATA_INIC162X is not set
+CONFIG_PATA_ALI=y
+# CONFIG_PATA_AMD is not set
+# CONFIG_PATA_ARTOP is not set
+# CONFIG_PATA_ATIIXP is not set
+# CONFIG_PATA_CMD640_PCI is not set
+# CONFIG_PATA_CMD64X is not set
+# CONFIG_PATA_CS5520 is not set
+# CONFIG_PATA_CS5530 is not set
+# CONFIG_PATA_CYPRESS is not set
+# CONFIG_PATA_EFAR is not set
+# CONFIG_ATA_GENERIC is not set
+# CONFIG_PATA_HPT366 is not set
+# CONFIG_PATA_HPT37X is not set
+# CONFIG_PATA_HPT3X2N is not set
+# CONFIG_PATA_HPT3X3 is not set
+# CONFIG_PATA_IT821X is not set
+# CONFIG_PATA_IT8213 is not set
+# CONFIG_PATA_JMICRON is not set
+# CONFIG_PATA_TRIFLEX is not set
+# CONFIG_PATA_MARVELL is not set
+# CONFIG_PATA_MPIIX is not set
+# CONFIG_PATA_OLDPIIX is not set
+# CONFIG_PATA_NETCELL is not set
+# CONFIG_PATA_NINJA32 is not set
+# CONFIG_PATA_NS87410 is not set
+# CONFIG_PATA_NS87415 is not set
+# CONFIG_PATA_OPTI is not set
+# CONFIG_PATA_OPTIDMA is not set
+# CONFIG_PATA_PDC_OLD is not set
+# CONFIG_PATA_RADISYS is not set
+# CONFIG_PATA_RZ1000 is not set
+# CONFIG_PATA_SC1200 is not set
+# CONFIG_PATA_SERVERWORKS is not set
+# CONFIG_PATA_PDC2027X is not set
+# CONFIG_PATA_SIL680 is not set
+# CONFIG_PATA_SIS is not set
+# CONFIG_PATA_VIA is not set
+# CONFIG_PATA_WINBOND is not set
+# CONFIG_PATA_PLATFORM is not set
+# CONFIG_PATA_SCH is not set
+# CONFIG_MD is not set
+# CONFIG_FUSION is not set
+
+#
+# IEEE 1394 (FireWire) support
+#
+
+#
+# Enable only one of the two stacks, unless you know what you are doing
+#
+# CONFIG_FIREWIRE is not set
+# CONFIG_IEEE1394 is not set
+# CONFIG_I2O is not set
+# CONFIG_MACINTOSH_DRIVERS is not set
+CONFIG_NETDEVICES=y
+CONFIG_COMPAT_NET_DEV_OPS=y
+CONFIG_DUMMY=y
+# CONFIG_BONDING is not set
+# CONFIG_MACVLAN is not set
+# CONFIG_EQUALIZER is not set
+# CONFIG_TUN is not set
+# CONFIG_VETH is not set
+# CONFIG_ARCNET is not set
+CONFIG_PHYLIB=y
+
+#
+# MII PHY device drivers
+#
+# CONFIG_MARVELL_PHY is not set
+# CONFIG_DAVICOM_PHY is not set
+# CONFIG_QSEMI_PHY is not set
+# CONFIG_LXT_PHY is not set
+# CONFIG_CICADA_PHY is not set
+# CONFIG_VITESSE_PHY is not set
+# CONFIG_SMSC_PHY is not set
+CONFIG_BROADCOM_PHY=y
+# CONFIG_ICPLUS_PHY is not set
+# CONFIG_REALTEK_PHY is not set
+# CONFIG_NATIONAL_PHY is not set
+# CONFIG_STE10XP is not set
+# CONFIG_LSI_ET1011C_PHY is not set
+# CONFIG_FIXED_PHY is not set
+# CONFIG_MDIO_BITBANG is not set
+CONFIG_NET_ETHERNET=y
+CONFIG_MII=y
+# CONFIG_HAPPYMEAL is not set
+# CONFIG_SUNGEM is not set
+# CONFIG_CASSINI is not set
+# CONFIG_NET_VENDOR_3COM is not set
+# CONFIG_ETHOC is not set
+# CONFIG_DNET is not set
+# CONFIG_NET_TULIP is not set
+# CONFIG_HP100 is not set
+# CONFIG_IBM_NEW_EMAC_ZMII is not set
+# CONFIG_IBM_NEW_EMAC_RGMII is not set
+# CONFIG_IBM_NEW_EMAC_TAH is not set
+# CONFIG_IBM_NEW_EMAC_EMAC4 is not set
+# CONFIG_IBM_NEW_EMAC_NO_FLOW_CTRL is not set
+# CONFIG_IBM_NEW_EMAC_MAL_CLR_ICINTSTAT is not set
+# CONFIG_IBM_NEW_EMAC_MAL_COMMON_ERR is not set
+# CONFIG_NET_PCI is not set
+# CONFIG_B44 is not set
+# CONFIG_ATL2 is not set
+CONFIG_NETDEV_1000=y
+# CONFIG_ACENIC is not set
+# CONFIG_DL2K is not set
+CONFIG_E1000=y
+# CONFIG_E1000E is not set
+# CONFIG_IP1000 is not set
+# CONFIG_IGB is not set
+# CONFIG_IGBVF is not set
+# CONFIG_NS83820 is not set
+# CONFIG_HAMACHI is not set
+# CONFIG_YELLOWFIN is not set
+# CONFIG_R8169 is not set
+# CONFIG_SIS190 is not set
+# CONFIG_SKGE is not set
+# CONFIG_SKY2 is not set
+# CONFIG_VIA_VELOCITY is not set
+# CONFIG_TIGON3 is not set
+# CONFIG_BNX2 is not set
+CONFIG_FSL_PQ_MDIO=y
+CONFIG_GIANFAR=y
+# CONFIG_QLA3XXX is not set
+# CONFIG_ATL1 is not set
+# CONFIG_ATL1E is not set
+# CONFIG_ATL1C is not set
+# CONFIG_JME is not set
+# CONFIG_NETDEV_10000 is not set
+# CONFIG_TR is not set
+
+#
+# Wireless LAN
+#
+# CONFIG_WLAN_PRE80211 is not set
+# CONFIG_WLAN_80211 is not set
+
+#
+# Enable WiMAX (Networking options) to see the WiMAX drivers
+#
+# CONFIG_WAN is not set
+# CONFIG_FDDI is not set
+# CONFIG_HIPPI is not set
+# CONFIG_PPP is not set
+# CONFIG_SLIP is not set
+# CONFIG_NET_FC is not set
+# CONFIG_NETCONSOLE is not set
+# CONFIG_NETPOLL is not set
+# CONFIG_NET_POLL_CONTROLLER is not set
+# CONFIG_ISDN is not set
+# CONFIG_PHONE is not set
+
+#
+# Input device support
+#
+CONFIG_INPUT=y
+# CONFIG_INPUT_FF_MEMLESS is not set
+# CONFIG_INPUT_POLLDEV is not set
+
+#
+# Userland interfaces
+#
+# CONFIG_INPUT_MOUSEDEV is not set
+# CONFIG_INPUT_JOYDEV is not set
+# CONFIG_INPUT_EVDEV is not set
+# CONFIG_INPUT_EVBUG is not set
+
+#
+# Input Device Drivers
+#
+# CONFIG_INPUT_KEYBOARD is not set
+# CONFIG_INPUT_MOUSE is not set
+# CONFIG_INPUT_JOYSTICK is not set
+# CONFIG_INPUT_TABLET is not set
+# CONFIG_INPUT_TOUCHSCREEN is not set
+# CONFIG_INPUT_MISC is not set
+
+#
+# Hardware I/O ports
+#
+CONFIG_SERIO=y
+CONFIG_SERIO_I8042=y
+CONFIG_SERIO_SERPORT=y
+# CONFIG_SERIO_PCIPS2 is not set
+CONFIG_SERIO_LIBPS2=y
+# CONFIG_SERIO_RAW is not set
+# CONFIG_SERIO_XILINX_XPS_PS2 is not set
+# CONFIG_GAMEPORT is not set
+
+#
+# Character devices
+#
+CONFIG_VT=y
+CONFIG_CONSOLE_TRANSLATIONS=y
+CONFIG_VT_CONSOLE=y
+CONFIG_HW_CONSOLE=y
+# CONFIG_VT_HW_CONSOLE_BINDING is not set
+CONFIG_DEVKMEM=y
+# CONFIG_SERIAL_NONSTANDARD is not set
+# CONFIG_NOZOMI is not set
+
+#
+# Serial drivers
+#
+CONFIG_SERIAL_8250=y
+CONFIG_SERIAL_8250_CONSOLE=y
+CONFIG_SERIAL_8250_PCI=y
+CONFIG_SERIAL_8250_NR_UARTS=2
+CONFIG_SERIAL_8250_RUNTIME_UARTS=2
+CONFIG_SERIAL_8250_EXTENDED=y
+CONFIG_SERIAL_8250_MANY_PORTS=y
+CONFIG_SERIAL_8250_SHARE_IRQ=y
+CONFIG_SERIAL_8250_DETECT_IRQ=y
+CONFIG_SERIAL_8250_RSA=y
+
+#
+# Non-8250 serial port support
+#
+# CONFIG_SERIAL_UARTLITE is not set
+CONFIG_SERIAL_CORE=y
+CONFIG_SERIAL_CORE_CONSOLE=y
+# CONFIG_SERIAL_JSM is not set
+# CONFIG_SERIAL_OF_PLATFORM is not set
+CONFIG_UNIX98_PTYS=y
+# CONFIG_DEVPTS_MULTIPLE_INSTANCES is not set
+CONFIG_LEGACY_PTYS=y
+CONFIG_LEGACY_PTY_COUNT=256
+# CONFIG_HVC_UDBG is not set
+# CONFIG_IPMI_HANDLER is not set
+# CONFIG_HW_RANDOM is not set
+CONFIG_NVRAM=y
+# CONFIG_R3964 is not set
+# CONFIG_APPLICOM is not set
+# CONFIG_RAW_DRIVER is not set
+# CONFIG_TCG_TPM is not set
+CONFIG_DEVPORT=y
+CONFIG_I2C=y
+CONFIG_I2C_BOARDINFO=y
+CONFIG_I2C_CHARDEV=y
+CONFIG_I2C_HELPER_AUTO=y
+
+#
+# I2C Hardware Bus support
+#
+
+#
+# PC SMBus host controller drivers
+#
+# CONFIG_I2C_ALI1535 is not set
+# CONFIG_I2C_ALI1563 is not set
+# CONFIG_I2C_ALI15X3 is not set
+# CONFIG_I2C_AMD756 is not set
+# CONFIG_I2C_AMD8111 is not set
+# CONFIG_I2C_I801 is not set
+# CONFIG_I2C_ISCH is not set
+# CONFIG_I2C_PIIX4 is not set
+# CONFIG_I2C_NFORCE2 is not set
+# CONFIG_I2C_SIS5595 is not set
+# CONFIG_I2C_SIS630 is not set
+# CONFIG_I2C_SIS96X is not set
+# CONFIG_I2C_VIA is not set
+# CONFIG_I2C_VIAPRO is not set
+
+#
+# I2C system bus drivers (mostly embedded / system-on-chip)
+#
+# CONFIG_I2C_GPIO is not set
+CONFIG_I2C_MPC=y
+# CONFIG_I2C_OCORES is not set
+# CONFIG_I2C_SIMTEC is not set
+
+#
+# External I2C/SMBus adapter drivers
+#
+# CONFIG_I2C_PARPORT_LIGHT is not set
+# CONFIG_I2C_TAOS_EVM is not set
+
+#
+# Graphics adapter I2C/DDC channel drivers
+#
+# CONFIG_I2C_VOODOO3 is not set
+
+#
+# Other I2C/SMBus bus drivers
+#
+# CONFIG_I2C_PCA_PLATFORM is not set
+# CONFIG_I2C_STUB is not set
+
+#
+# Miscellaneous I2C Chip support
+#
+# CONFIG_DS1682 is not set
+# CONFIG_SENSORS_PCF8574 is not set
+# CONFIG_PCF8575 is not set
+# CONFIG_SENSORS_MAX6875 is not set
+# CONFIG_SENSORS_TSL2550 is not set
+# CONFIG_I2C_DEBUG_CORE is not set
+# CONFIG_I2C_DEBUG_ALGO is not set
+# CONFIG_I2C_DEBUG_BUS is not set
+# CONFIG_I2C_DEBUG_CHIP is not set
+# CONFIG_SPI is not set
+CONFIG_ARCH_WANT_OPTIONAL_GPIOLIB=y
+CONFIG_ARCH_REQUIRE_GPIOLIB=y
+CONFIG_GPIOLIB=y
+# CONFIG_DEBUG_GPIO is not set
+CONFIG_GPIO_SYSFS=y
+
+#
+# Memory mapped GPIO expanders:
+#
+# CONFIG_GPIO_XILINX is not set
+
+#
+# I2C GPIO expanders:
+#
+# CONFIG_GPIO_MAX732X is not set
+CONFIG_GPIO_PCA953X=y
+# CONFIG_GPIO_PCF857X is not set
+
+#
+# PCI GPIO expanders:
+#
+# CONFIG_GPIO_BT8XX is not set
+
+#
+# SPI GPIO expanders:
+#
+# CONFIG_W1 is not set
+# CONFIG_POWER_SUPPLY is not set
+CONFIG_HWMON=y
+# CONFIG_HWMON_VID is not set
+# CONFIG_SENSORS_AD7414 is not set
+# CONFIG_SENSORS_AD7418 is not set
+# CONFIG_SENSORS_ADM1021 is not set
+# CONFIG_SENSORS_ADM1025 is not set
+# CONFIG_SENSORS_ADM1026 is not set
+# CONFIG_SENSORS_ADM1029 is not set
+# CONFIG_SENSORS_ADM1031 is not set
+# CONFIG_SENSORS_ADM9240 is not set
+# CONFIG_SENSORS_ADT7462 is not set
+# CONFIG_SENSORS_ADT7470 is not set
+# CONFIG_SENSORS_ADT7473 is not set
+# CONFIG_SENSORS_ADT7475 is not set
+# CONFIG_SENSORS_ATXP1 is not set
+CONFIG_SENSORS_DS1621=y
+# CONFIG_SENSORS_I5K_AMB is not set
+# CONFIG_SENSORS_F71805F is not set
+# CONFIG_SENSORS_F71882FG is not set
+# CONFIG_SENSORS_F75375S is not set
+# CONFIG_SENSORS_G760A is not set
+# CONFIG_SENSORS_GL518SM is not set
+# CONFIG_SENSORS_GL520SM is not set
+# CONFIG_SENSORS_IT87 is not set
+# CONFIG_SENSORS_LM63 is not set
+# CONFIG_SENSORS_LM75 is not set
+# CONFIG_SENSORS_LM77 is not set
+# CONFIG_SENSORS_LM78 is not set
+# CONFIG_SENSORS_LM80 is not set
+# CONFIG_SENSORS_LM83 is not set
+# CONFIG_SENSORS_LM85 is not set
+# CONFIG_SENSORS_LM87 is not set
+CONFIG_SENSORS_LM90=y
+# CONFIG_SENSORS_LM92 is not set
+# CONFIG_SENSORS_LM93 is not set
+# CONFIG_SENSORS_LTC4215 is not set
+# CONFIG_SENSORS_LTC4245 is not set
+# CONFIG_SENSORS_LM95241 is not set
+# CONFIG_SENSORS_MAX1619 is not set
+# CONFIG_SENSORS_MAX6650 is not set
+# CONFIG_SENSORS_PC87360 is not set
+# CONFIG_SENSORS_PC87427 is not set
+# CONFIG_SENSORS_PCF8591 is not set
+# CONFIG_SENSORS_SHT15 is not set
+# CONFIG_SENSORS_SIS5595 is not set
+# CONFIG_SENSORS_DME1737 is not set
+# CONFIG_SENSORS_SMSC47M1 is not set
+# CONFIG_SENSORS_SMSC47M192 is not set
+# CONFIG_SENSORS_SMSC47B397 is not set
+# CONFIG_SENSORS_ADS7828 is not set
+# CONFIG_SENSORS_THMC50 is not set
+# CONFIG_SENSORS_VIA686A is not set
+# CONFIG_SENSORS_VT1211 is not set
+# CONFIG_SENSORS_VT8231 is not set
+# CONFIG_SENSORS_W83781D is not set
+# CONFIG_SENSORS_W83791D is not set
+# CONFIG_SENSORS_W83792D is not set
+# CONFIG_SENSORS_W83793 is not set
+# CONFIG_SENSORS_W83L785TS is not set
+# CONFIG_SENSORS_W83L786NG is not set
+# CONFIG_SENSORS_W83627HF is not set
+# CONFIG_SENSORS_W83627EHF is not set
+# CONFIG_HWMON_DEBUG_CHIP is not set
+# CONFIG_THERMAL is not set
+# CONFIG_THERMAL_HWMON is not set
+CONFIG_WATCHDOG=y
+# CONFIG_WATCHDOG_NOWAYOUT is not set
+
+#
+# Watchdog Device Drivers
+#
+# CONFIG_SOFT_WATCHDOG is not set
+# CONFIG_ALIM7101_WDT is not set
+# CONFIG_BOOKE_WDT is not set
+
+#
+# PCI-based Watchdog Cards
+#
+# CONFIG_PCIPCWATCHDOG is not set
+# CONFIG_WDTPCI is not set
+CONFIG_SSB_POSSIBLE=y
+
+#
+# Sonics Silicon Backplane
+#
+# CONFIG_SSB is not set
+
+#
+# Multifunction device drivers
+#
+# CONFIG_MFD_CORE is not set
+# CONFIG_MFD_SM501 is not set
+# CONFIG_HTC_PASIC3 is not set
+# CONFIG_TPS65010 is not set
+# CONFIG_TWL4030_CORE is not set
+# CONFIG_MFD_TMIO is not set
+# CONFIG_PMIC_DA903X is not set
+# CONFIG_MFD_WM8400 is not set
+# CONFIG_MFD_WM8350_I2C is not set
+# CONFIG_MFD_PCF50633 is not set
+# CONFIG_REGULATOR is not set
+
+#
+# Multimedia devices
+#
+
+#
+# Multimedia core support
+#
+# CONFIG_VIDEO_DEV is not set
+# CONFIG_DVB_CORE is not set
+# CONFIG_VIDEO_MEDIA is not set
+
+#
+# Multimedia drivers
+#
+# CONFIG_DAB is not set
+
+#
+# Graphics support
+#
+# CONFIG_AGP is not set
+# CONFIG_DRM is not set
+# CONFIG_VGASTATE is not set
+CONFIG_VIDEO_OUTPUT_CONTROL=y
+# CONFIG_FB is not set
+# CONFIG_BACKLIGHT_LCD_SUPPORT is not set
+
+#
+# Display device support
+#
+# CONFIG_DISPLAY_SUPPORT is not set
+
+#
+# Console display driver support
+#
+CONFIG_VGA_CONSOLE=y
+# CONFIG_VGACON_SOFT_SCROLLBACK is not set
+CONFIG_DUMMY_CONSOLE=y
+# CONFIG_SOUND is not set
+CONFIG_HID_SUPPORT=y
+CONFIG_HID=y
+# CONFIG_HID_DEBUG is not set
+# CONFIG_HIDRAW is not set
+# CONFIG_HID_PID is not set
+
+#
+# Special HID drivers
+#
+# CONFIG_USB_SUPPORT is not set
+# CONFIG_UWB is not set
+# CONFIG_MMC is not set
+# CONFIG_MEMSTICK is not set
+CONFIG_NEW_LEDS=y
+CONFIG_LEDS_CLASS=y
+
+#
+# LED drivers
+#
+# CONFIG_LEDS_PCA9532 is not set
+CONFIG_LEDS_GPIO=y
+CONFIG_LEDS_GPIO_PLATFORM=y
+CONFIG_LEDS_GPIO_OF=y
+# CONFIG_LEDS_LP5521 is not set
+CONFIG_LEDS_PCA955X=y
+# CONFIG_LEDS_BD2802 is not set
+
+#
+# LED Triggers
+#
+CONFIG_LEDS_TRIGGERS=y
+CONFIG_LEDS_TRIGGER_TIMER=y
+CONFIG_LEDS_TRIGGER_HEARTBEAT=y
+# CONFIG_LEDS_TRIGGER_BACKLIGHT is not set
+CONFIG_LEDS_TRIGGER_GPIO=y
+# CONFIG_LEDS_TRIGGER_DEFAULT_ON is not set
+
+#
+# iptables trigger is under Netfilter config (LED target)
+#
+# CONFIG_ACCESSIBILITY is not set
+# CONFIG_INFINIBAND is not set
+CONFIG_EDAC=y
+
+#
+# Reporting subsystems
+#
+# CONFIG_EDAC_DEBUG is not set
+CONFIG_EDAC_MM_EDAC=y
+CONFIG_EDAC_MPC85XX=y
+# CONFIG_EDAC_AMD8131 is not set
+# CONFIG_EDAC_AMD8111 is not set
+CONFIG_RTC_LIB=y
+CONFIG_RTC_CLASS=y
+CONFIG_RTC_HCTOSYS=y
+CONFIG_RTC_HCTOSYS_DEVICE="rtc0"
+# CONFIG_RTC_DEBUG is not set
+
+#
+# RTC interfaces
+#
+CONFIG_RTC_INTF_SYSFS=y
+CONFIG_RTC_INTF_PROC=y
+CONFIG_RTC_INTF_DEV=y
+# CONFIG_RTC_INTF_DEV_UIE_EMUL is not set
+# CONFIG_RTC_DRV_TEST is not set
+
+#
+# I2C RTC drivers
+#
+CONFIG_RTC_DRV_DS1307=y
+# CONFIG_RTC_DRV_DS1374 is not set
+# CONFIG_RTC_DRV_DS1672 is not set
+# CONFIG_RTC_DRV_MAX6900 is not set
+# CONFIG_RTC_DRV_RS5C372 is not set
+# CONFIG_RTC_DRV_ISL1208 is not set
+# CONFIG_RTC_DRV_X1205 is not set
+# CONFIG_RTC_DRV_PCF8563 is not set
+# CONFIG_RTC_DRV_PCF8583 is not set
+# CONFIG_RTC_DRV_M41T80 is not set
+# CONFIG_RTC_DRV_S35390A is not set
+# CONFIG_RTC_DRV_FM3130 is not set
+# CONFIG_RTC_DRV_RX8581 is not set
+
+#
+# SPI RTC drivers
+#
+
+#
+# Platform RTC drivers
+#
+CONFIG_RTC_DRV_CMOS=y
+# CONFIG_RTC_DRV_DS1286 is not set
+# CONFIG_RTC_DRV_DS1511 is not set
+# CONFIG_RTC_DRV_DS1553 is not set
+# CONFIG_RTC_DRV_DS1742 is not set
+# CONFIG_RTC_DRV_STK17TA8 is not set
+# CONFIG_RTC_DRV_M48T86 is not set
+# CONFIG_RTC_DRV_M48T35 is not set
+# CONFIG_RTC_DRV_M48T59 is not set
+# CONFIG_RTC_DRV_BQ4802 is not set
+# CONFIG_RTC_DRV_V3020 is not set
+
+#
+# on-CPU RTC drivers
+#
+# CONFIG_RTC_DRV_GENERIC is not set
+CONFIG_DMADEVICES=y
+
+#
+# DMA Devices
+#
+CONFIG_FSL_DMA=y
+CONFIG_DMA_ENGINE=y
+
+#
+# DMA Clients
+#
+CONFIG_NET_DMA=y
+# CONFIG_ASYNC_TX_DMA is not set
+# CONFIG_DMATEST is not set
+# CONFIG_AUXDISPLAY is not set
+# CONFIG_UIO is not set
+# CONFIG_STAGING is not set
+
+#
+# File systems
+#
+CONFIG_EXT2_FS=y
+# CONFIG_EXT2_FS_XATTR is not set
+# CONFIG_EXT2_FS_XIP is not set
+CONFIG_EXT3_FS=y
+# CONFIG_EXT3_DEFAULTS_TO_ORDERED is not set
+CONFIG_EXT3_FS_XATTR=y
+# CONFIG_EXT3_FS_POSIX_ACL is not set
+# CONFIG_EXT3_FS_SECURITY is not set
+# CONFIG_EXT4_FS is not set
+CONFIG_JBD=y
+CONFIG_FS_MBCACHE=y
+# CONFIG_REISERFS_FS is not set
+# CONFIG_JFS_FS is not set
+# CONFIG_FS_POSIX_ACL is not set
+CONFIG_FILE_LOCKING=y
+# CONFIG_XFS_FS is not set
+# CONFIG_GFS2_FS is not set
+# CONFIG_OCFS2_FS is not set
+# CONFIG_BTRFS_FS is not set
+CONFIG_DNOTIFY=y
+CONFIG_INOTIFY=y
+CONFIG_INOTIFY_USER=y
+# CONFIG_QUOTA is not set
+# CONFIG_AUTOFS_FS is not set
+# CONFIG_AUTOFS4_FS is not set
+# CONFIG_FUSE_FS is not set
+
+#
+# Caches
+#
+# CONFIG_FSCACHE is not set
+
+#
+# CD-ROM/DVD Filesystems
+#
+CONFIG_ISO9660_FS=y
+CONFIG_JOLIET=y
+CONFIG_ZISOFS=y
+CONFIG_UDF_FS=y
+CONFIG_UDF_NLS=y
+
+#
+# DOS/FAT/NT Filesystems
+#
+CONFIG_FAT_FS=y
+CONFIG_MSDOS_FS=y
+CONFIG_VFAT_FS=y
+CONFIG_FAT_DEFAULT_CODEPAGE=437
+CONFIG_FAT_DEFAULT_IOCHARSET="iso8859-1"
+# CONFIG_NTFS_FS is not set
+
+#
+# Pseudo filesystems
+#
+CONFIG_PROC_FS=y
+CONFIG_PROC_KCORE=y
+CONFIG_PROC_SYSCTL=y
+CONFIG_PROC_PAGE_MONITOR=y
+CONFIG_SYSFS=y
+CONFIG_TMPFS=y
+# CONFIG_TMPFS_POSIX_ACL is not set
+# CONFIG_HUGETLB_PAGE is not set
+# CONFIG_CONFIGFS_FS is not set
+CONFIG_MISC_FILESYSTEMS=y
+# CONFIG_ADFS_FS is not set
+# CONFIG_AFFS_FS is not set
+# CONFIG_HFS_FS is not set
+# CONFIG_HFSPLUS_FS is not set
+# CONFIG_BEFS_FS is not set
+# CONFIG_BFS_FS is not set
+# CONFIG_EFS_FS is not set
+CONFIG_JFFS2_FS=y
+CONFIG_JFFS2_FS_DEBUG=0
+CONFIG_JFFS2_FS_WRITEBUFFER=y
+# CONFIG_JFFS2_FS_WBUF_VERIFY is not set
+CONFIG_JFFS2_SUMMARY=y
+# CONFIG_JFFS2_FS_XATTR is not set
+# CONFIG_JFFS2_COMPRESSION_OPTIONS is not set
+CONFIG_JFFS2_ZLIB=y
+# CONFIG_JFFS2_LZO is not set
+CONFIG_JFFS2_RTIME=y
+# CONFIG_JFFS2_RUBIN is not set
+# CONFIG_CRAMFS is not set
+# CONFIG_SQUASHFS is not set
+# CONFIG_VXFS_FS is not set
+# CONFIG_MINIX_FS is not set
+# CONFIG_OMFS_FS is not set
+# CONFIG_HPFS_FS is not set
+# CONFIG_QNX4FS_FS is not set
+# CONFIG_ROMFS_FS is not set
+# CONFIG_SYSV_FS is not set
+# CONFIG_UFS_FS is not set
+# CONFIG_NILFS2_FS is not set
+CONFIG_NETWORK_FILESYSTEMS=y
+CONFIG_NFS_FS=y
+CONFIG_NFS_V3=y
+# CONFIG_NFS_V3_ACL is not set
+# CONFIG_NFS_V4 is not set
+CONFIG_ROOT_NFS=y
+CONFIG_NFSD=y
+# CONFIG_NFSD_V3 is not set
+# CONFIG_NFSD_V4 is not set
+CONFIG_LOCKD=y
+CONFIG_LOCKD_V4=y
+CONFIG_EXPORTFS=y
+CONFIG_NFS_COMMON=y
+CONFIG_SUNRPC=y
+# CONFIG_RPCSEC_GSS_KRB5 is not set
+# CONFIG_RPCSEC_GSS_SPKM3 is not set
+# CONFIG_SMB_FS is not set
+# CONFIG_CIFS is not set
+# CONFIG_NCP_FS is not set
+# CONFIG_CODA_FS is not set
+# CONFIG_AFS_FS is not set
+
+#
+# Partition Types
+#
+CONFIG_PARTITION_ADVANCED=y
+# CONFIG_ACORN_PARTITION is not set
+# CONFIG_OSF_PARTITION is not set
+# CONFIG_AMIGA_PARTITION is not set
+# CONFIG_ATARI_PARTITION is not set
+# CONFIG_MAC_PARTITION is not set
+CONFIG_MSDOS_PARTITION=y
+# CONFIG_BSD_DISKLABEL is not set
+# CONFIG_MINIX_SUBPARTITION is not set
+# CONFIG_SOLARIS_X86_PARTITION is not set
+# CONFIG_UNIXWARE_DISKLABEL is not set
+# CONFIG_LDM_PARTITION is not set
+# CONFIG_SGI_PARTITION is not set
+# CONFIG_ULTRIX_PARTITION is not set
+# CONFIG_SUN_PARTITION is not set
+# CONFIG_KARMA_PARTITION is not set
+# CONFIG_EFI_PARTITION is not set
+# CONFIG_SYSV68_PARTITION is not set
+CONFIG_NLS=y
+CONFIG_NLS_DEFAULT="iso8859-1"
+CONFIG_NLS_CODEPAGE_437=y
+# CONFIG_NLS_CODEPAGE_737 is not set
+# CONFIG_NLS_CODEPAGE_775 is not set
+# CONFIG_NLS_CODEPAGE_850 is not set
+# CONFIG_NLS_CODEPAGE_852 is not set
+# CONFIG_NLS_CODEPAGE_855 is not set
+# CONFIG_NLS_CODEPAGE_857 is not set
+# CONFIG_NLS_CODEPAGE_860 is not set
+# CONFIG_NLS_CODEPAGE_861 is not set
+# CONFIG_NLS_CODEPAGE_862 is not set
+# CONFIG_NLS_CODEPAGE_863 is not set
+# CONFIG_NLS_CODEPAGE_864 is not set
+# CONFIG_NLS_CODEPAGE_865 is not set
+# CONFIG_NLS_CODEPAGE_866 is not set
+# CONFIG_NLS_CODEPAGE_869 is not set
+# CONFIG_NLS_CODEPAGE_936 is not set
+# CONFIG_NLS_CODEPAGE_950 is not set
+# CONFIG_NLS_CODEPAGE_932 is not set
+# CONFIG_NLS_CODEPAGE_949 is not set
+# CONFIG_NLS_CODEPAGE_874 is not set
+# CONFIG_NLS_ISO8859_8 is not set
+# CONFIG_NLS_CODEPAGE_1250 is not set
+# CONFIG_NLS_CODEPAGE_1251 is not set
+# CONFIG_NLS_ASCII is not set
+CONFIG_NLS_ISO8859_1=y
+# CONFIG_NLS_ISO8859_2 is not set
+# CONFIG_NLS_ISO8859_3 is not set
+# CONFIG_NLS_ISO8859_4 is not set
+# CONFIG_NLS_ISO8859_5 is not set
+# CONFIG_NLS_ISO8859_6 is not set
+# CONFIG_NLS_ISO8859_7 is not set
+# CONFIG_NLS_ISO8859_9 is not set
+# CONFIG_NLS_ISO8859_13 is not set
+# CONFIG_NLS_ISO8859_14 is not set
+# CONFIG_NLS_ISO8859_15 is not set
+# CONFIG_NLS_KOI8_R is not set
+# CONFIG_NLS_KOI8_U is not set
+# CONFIG_NLS_UTF8 is not set
+# CONFIG_DLM is not set
+# CONFIG_BINARY_PRINTF is not set
+
+#
+# Library routines
+#
+CONFIG_BITREVERSE=y
+CONFIG_GENERIC_FIND_LAST_BIT=y
+# CONFIG_CRC_CCITT is not set
+# CONFIG_CRC16 is not set
+CONFIG_CRC_T10DIF=y
+CONFIG_CRC_ITU_T=y
+CONFIG_CRC32=y
+# CONFIG_CRC7 is not set
+# CONFIG_LIBCRC32C is not set
+CONFIG_ZLIB_INFLATE=y
+CONFIG_ZLIB_DEFLATE=y
+CONFIG_DECOMPRESS_GZIP=y
+CONFIG_HAS_IOMEM=y
+CONFIG_HAS_IOPORT=y
+CONFIG_HAS_DMA=y
+CONFIG_HAVE_LMB=y
+CONFIG_NLATTR=y
+
+#
+# Kernel hacking
+#
+# CONFIG_PRINTK_TIME is not set
+CONFIG_ENABLE_WARN_DEPRECATED=y
+CONFIG_ENABLE_MUST_CHECK=y
+CONFIG_FRAME_WARN=1024
+# CONFIG_MAGIC_SYSRQ is not set
+# CONFIG_UNUSED_SYMBOLS is not set
+# CONFIG_DEBUG_FS is not set
+# CONFIG_HEADERS_CHECK is not set
+CONFIG_DEBUG_KERNEL=y
+# CONFIG_DEBUG_SHIRQ is not set
+CONFIG_DETECT_SOFTLOCKUP=y
+# CONFIG_BOOTPARAM_SOFTLOCKUP_PANIC is not set
+CONFIG_BOOTPARAM_SOFTLOCKUP_PANIC_VALUE=0
+CONFIG_DETECT_HUNG_TASK=y
+# CONFIG_BOOTPARAM_HUNG_TASK_PANIC is not set
+CONFIG_BOOTPARAM_HUNG_TASK_PANIC_VALUE=0
+CONFIG_SCHED_DEBUG=y
+# CONFIG_SCHEDSTATS is not set
+# CONFIG_TIMER_STATS is not set
+# CONFIG_DEBUG_OBJECTS is not set
+# CONFIG_SLUB_DEBUG_ON is not set
+# CONFIG_SLUB_STATS is not set
+# CONFIG_DEBUG_RT_MUTEXES is not set
+# CONFIG_RT_MUTEX_TESTER is not set
+# CONFIG_DEBUG_SPINLOCK is not set
+# CONFIG_DEBUG_MUTEXES is not set
+# CONFIG_DEBUG_SPINLOCK_SLEEP is not set
+# CONFIG_DEBUG_LOCKING_API_SELFTESTS is not set
+# CONFIG_DEBUG_KOBJECT is not set
+# CONFIG_DEBUG_HIGHMEM is not set
+# CONFIG_DEBUG_BUGVERBOSE is not set
+# CONFIG_DEBUG_INFO is not set
+# CONFIG_DEBUG_VM is not set
+# CONFIG_DEBUG_WRITECOUNT is not set
+# CONFIG_DEBUG_MEMORY_INIT is not set
+# CONFIG_DEBUG_LIST is not set
+# CONFIG_DEBUG_SG is not set
+# CONFIG_DEBUG_NOTIFIERS is not set
+# CONFIG_BOOT_PRINTK_DELAY is not set
+# CONFIG_RCU_TORTURE_TEST is not set
+# CONFIG_RCU_CPU_STALL_DETECTOR is not set
+# CONFIG_BACKTRACE_SELF_TEST is not set
+# CONFIG_DEBUG_BLOCK_EXT_DEVT is not set
+# CONFIG_FAULT_INJECTION is not set
+# CONFIG_LATENCYTOP is not set
+# CONFIG_SYSCTL_SYSCALL_CHECK is not set
+# CONFIG_DEBUG_PAGEALLOC is not set
+CONFIG_HAVE_FUNCTION_TRACER=y
+CONFIG_HAVE_FUNCTION_GRAPH_TRACER=y
+CONFIG_HAVE_DYNAMIC_FTRACE=y
+CONFIG_HAVE_FTRACE_MCOUNT_RECORD=y
+CONFIG_TRACING_SUPPORT=y
+
+#
+# Tracers
+#
+# CONFIG_FUNCTION_TRACER is not set
+# CONFIG_SCHED_TRACER is not set
+# CONFIG_CONTEXT_SWITCH_TRACER is not set
+# CONFIG_EVENT_TRACER is not set
+# CONFIG_BOOT_TRACER is not set
+# CONFIG_TRACE_BRANCH_PROFILING is not set
+# CONFIG_STACK_TRACER is not set
+# CONFIG_KMEMTRACE is not set
+# CONFIG_WORKQUEUE_TRACER is not set
+# CONFIG_BLK_DEV_IO_TRACE is not set
+# CONFIG_SAMPLES is not set
+CONFIG_HAVE_ARCH_KGDB=y
+# CONFIG_KGDB is not set
+CONFIG_PRINT_STACK_DEPTH=64
+# CONFIG_DEBUG_STACKOVERFLOW is not set
+# CONFIG_DEBUG_STACK_USAGE is not set
+# CONFIG_CODE_PATCHING_SELFTEST is not set
+# CONFIG_FTR_FIXUP_SELFTEST is not set
+# CONFIG_MSI_BITMAP_SELFTEST is not set
+# CONFIG_XMON is not set
+# CONFIG_IRQSTACKS is not set
+# CONFIG_BDI_SWITCH is not set
+# CONFIG_PPC_EARLY_DEBUG is not set
+
+#
+# Security options
+#
+# CONFIG_KEYS is not set
+# CONFIG_SECURITY is not set
+# CONFIG_SECURITYFS is not set
+# CONFIG_SECURITY_FILE_CAPABILITIES is not set
+CONFIG_CRYPTO=y
+
+#
+# Crypto core or helper
+#
+# CONFIG_CRYPTO_FIPS is not set
+CONFIG_CRYPTO_ALGAPI=y
+CONFIG_CRYPTO_ALGAPI2=y
+CONFIG_CRYPTO_AEAD2=y
+CONFIG_CRYPTO_BLKCIPHER2=y
+CONFIG_CRYPTO_HASH=y
+CONFIG_CRYPTO_HASH2=y
+CONFIG_CRYPTO_RNG2=y
+CONFIG_CRYPTO_PCOMP=y
+CONFIG_CRYPTO_MANAGER=y
+CONFIG_CRYPTO_MANAGER2=y
+# CONFIG_CRYPTO_GF128MUL is not set
+# CONFIG_CRYPTO_NULL is not set
+CONFIG_CRYPTO_WORKQUEUE=y
+# CONFIG_CRYPTO_CRYPTD is not set
+# CONFIG_CRYPTO_AUTHENC is not set
+# CONFIG_CRYPTO_TEST is not set
+
+#
+# Authenticated Encryption with Associated Data
+#
+# CONFIG_CRYPTO_CCM is not set
+# CONFIG_CRYPTO_GCM is not set
+# CONFIG_CRYPTO_SEQIV is not set
+
+#
+# Block modes
+#
+# CONFIG_CRYPTO_CBC is not set
+# CONFIG_CRYPTO_CTR is not set
+# CONFIG_CRYPTO_CTS is not set
+# CONFIG_CRYPTO_ECB is not set
+# CONFIG_CRYPTO_LRW is not set
+# CONFIG_CRYPTO_PCBC is not set
+# CONFIG_CRYPTO_XTS is not set
+
+#
+# Hash modes
+#
+CONFIG_CRYPTO_HMAC=y
+# CONFIG_CRYPTO_XCBC is not set
+
+#
+# Digest
+#
+# CONFIG_CRYPTO_CRC32C is not set
+# CONFIG_CRYPTO_MD4 is not set
+CONFIG_CRYPTO_MD5=y
+# CONFIG_CRYPTO_MICHAEL_MIC is not set
+# CONFIG_CRYPTO_RMD128 is not set
+# CONFIG_CRYPTO_RMD160 is not set
+# CONFIG_CRYPTO_RMD256 is not set
+# CONFIG_CRYPTO_RMD320 is not set
+# CONFIG_CRYPTO_SHA1 is not set
+# CONFIG_CRYPTO_SHA256 is not set
+# CONFIG_CRYPTO_SHA512 is not set
+# CONFIG_CRYPTO_TGR192 is not set
+# CONFIG_CRYPTO_WP512 is not set
+
+#
+# Ciphers
+#
+# CONFIG_CRYPTO_AES is not set
+# CONFIG_CRYPTO_ANUBIS is not set
+# CONFIG_CRYPTO_ARC4 is not set
+# CONFIG_CRYPTO_BLOWFISH is not set
+# CONFIG_CRYPTO_CAMELLIA is not set
+# CONFIG_CRYPTO_CAST5 is not set
+# CONFIG_CRYPTO_CAST6 is not set
+# CONFIG_CRYPTO_DES is not set
+# CONFIG_CRYPTO_FCRYPT is not set
+# CONFIG_CRYPTO_KHAZAD is not set
+# CONFIG_CRYPTO_SALSA20 is not set
+# CONFIG_CRYPTO_SEED is not set
+# CONFIG_CRYPTO_SERPENT is not set
+# CONFIG_CRYPTO_TEA is not set
+# CONFIG_CRYPTO_TWOFISH is not set
+
+#
+# Compression
+#
+# CONFIG_CRYPTO_DEFLATE is not set
+# CONFIG_CRYPTO_ZLIB is not set
+# CONFIG_CRYPTO_LZO is not set
+
+#
+# Random Number Generation
+#
+# CONFIG_CRYPTO_ANSI_CPRNG is not set
+CONFIG_CRYPTO_HW=y
+# CONFIG_CRYPTO_DEV_HIFN_795X is not set
+# CONFIG_CRYPTO_DEV_TALITOS is not set
+# CONFIG_PPC_CLOCK is not set
+# CONFIG_VIRTUALIZATION is not set
diff --git a/arch/powerpc/include/asm/reg_booke.h b/arch/powerpc/include/asm/reg_booke.h
index 601ddbc..6bcf364 100644
--- a/arch/powerpc/include/asm/reg_booke.h
+++ b/arch/powerpc/include/asm/reg_booke.h
@@ -389,12 +389,14 @@
 #define ICCR_CACHE	1		/* Cacheable */
 
 /* Bit definitions for L1CSR0. */
+#define L1CSR0_CPE	0x00010000	/* Data Cache Parity Enable */
 #define L1CSR0_CLFC	0x00000100	/* Cache Lock Bits Flash Clear */
 #define L1CSR0_DCFI	0x00000002	/* Data Cache Flash Invalidate */
 #define L1CSR0_CFI	0x00000002	/* Cache Flash Invalidate */
 #define L1CSR0_DCE	0x00000001	/* Data Cache Enable */
 
 /* Bit definitions for L1CSR1. */
+#define L1CSR1_CPE	0x00010000	/* Instruction Cache Parity Enable */
 #define L1CSR1_ICLFR	0x00000100	/* Instr Cache Lock Bits Flash Reset */
 #define L1CSR1_ICFI	0x00000002	/* Instr Cache Flash Invalidate */
 #define L1CSR1_ICE	0x00000001	/* Instr Cache Enable */
diff --git a/arch/powerpc/platforms/85xx/Kconfig b/arch/powerpc/platforms/85xx/Kconfig
index 43d385c..e0d39bf 100644
--- a/arch/powerpc/platforms/85xx/Kconfig
+++ b/arch/powerpc/platforms/85xx/Kconfig
@@ -64,6 +64,16 @@ config KSI8560
         help
           This option enables support for the Emerson KSI8560 board
 
+config XES_MPC85xx
+	bool "X-ES single-board computer"
+	select DEFAULT_UIMAGE
+	help
+	  This option enables support for the various single-board
+	  computers from Extreme Engineering Solutions (X-ES) based on
+	  Freescale MPC85xx processors.
+	  Manufacturer: Extreme Engineering Solutions, Inc.
+	  URL: <http://www.xes-inc.com/>
+
 config STX_GP3
 	bool "Silicon Turnkey Express GP3"
 	help
diff --git a/arch/powerpc/platforms/85xx/Makefile b/arch/powerpc/platforms/85xx/Makefile
index a857b35..835733f 100644
--- a/arch/powerpc/platforms/85xx/Makefile
+++ b/arch/powerpc/platforms/85xx/Makefile
@@ -15,3 +15,4 @@ obj-$(CONFIG_SBC8560)     += sbc8560.o
 obj-$(CONFIG_SBC8548)     += sbc8548.o
 obj-$(CONFIG_SOCRATES)    += socrates.o socrates_fpga_pic.o
 obj-$(CONFIG_KSI8560)	  += ksi8560.o
+obj-$(CONFIG_XES_MPC85xx) += xes_mpc85xx.o
\ No newline at end of file
diff --git a/arch/powerpc/platforms/85xx/xes_mpc85xx.c b/arch/powerpc/platforms/85xx/xes_mpc85xx.c
new file mode 100644
index 0000000..c1b55b8
--- /dev/null
+++ b/arch/powerpc/platforms/85xx/xes_mpc85xx.c
@@ -0,0 +1,332 @@
+/*
+ * Copyright (C) 2009 Extreme Engineering Solutions, Inc.
+ *
+ * X-ES board-specific functionality
+ *
+ * Based on mpc85xx_ds code from Freescale Semiconductor, Inc.
+ *
+ * Author: Nate Case <ncase@xes-inc.com>
+ *
+ * This is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include <linux/stddef.h>
+#include <linux/kernel.h>
+#include <linux/pci.h>
+#include <linux/kdev_t.h>
+#include <linux/delay.h>
+#include <linux/seq_file.h>
+#include <linux/interrupt.h>
+#include <linux/of_platform.h>
+
+#include <asm/system.h>
+#include <asm/time.h>
+#include <asm/machdep.h>
+#include <asm/pci-bridge.h>
+#include <mm/mmu_decl.h>
+#include <asm/prom.h>
+#include <asm/udbg.h>
+#include <asm/mpic.h>
+
+#include <sysdev/fsl_soc.h>
+#include <sysdev/fsl_pci.h>
+#include <linux/of_platform.h>
+
+#undef DEBUG
+
+#ifdef DEBUG
+#define DBG(fmt, args...) printk(KERN_ERR "%s: " fmt, __func__, ## args)
+#else
+#define DBG(fmt, args...)
+#endif
+
+/* A few bit definitions needed for fixups on some boards */
+#define MPC85xx_L2CTL_L2E		0x80000000 /* L2 enable */
+#define MPC85xx_L2CTL_L2I		0x40000000 /* L2 flash invalidate */
+#define MPC85xx_L2CTL_L2SIZ_MASK	0x30000000 /* L2 SRAM size (R/O) */
+
+void __init xes_mpc85xx_pic_init(void)
+{
+	struct mpic *mpic;
+	struct resource r;
+	struct device_node *np;
+
+	np = of_find_node_by_type(NULL, "open-pic");
+	if (np == NULL) {
+		printk(KERN_ERR "Could not find open-pic node\n");
+		return;
+	}
+
+	if (of_address_to_resource(np, 0, &r)) {
+		printk(KERN_ERR "Failed to map mpic register space\n");
+		of_node_put(np);
+		return;
+	}
+
+	mpic = mpic_alloc(np, r.start,
+			  MPIC_PRIMARY | MPIC_WANTS_RESET |
+			  MPIC_BIG_ENDIAN | MPIC_BROKEN_FRR_NIRQS,
+			0, 256, " OpenPIC  ");
+	BUG_ON(mpic == NULL);
+	of_node_put(np);
+
+	mpic_init(mpic);
+}
+
+static void xes_mpc85xx_configure_l1(void)
+{
+	uint spr;
+	asm volatile("msync; isync");
+	spr = mfspr(SPRN_L1CSR1);
+	asm volatile("msync; isync");
+	/* Enable instruction cache */
+	mtspr(SPRN_L1CSR1, spr | L1CSR1_ICFI | L1CSR1_ICE | L1CSR1_CPE);
+
+	/* Enable L1 data cache if it isn't already enabled */
+	if (mfspr(SPRN_L1CSR0) == 0x0) {
+		printk(KERN_INFO "xes_mpc85xx: Enabling L1 caches\n");
+		asm volatile("msync; isync");
+		mtspr(SPRN_L1CSR0, 0x0);		/* Disable */
+		asm volatile("msync; isync");
+		mtspr(SPRN_L1CSR0, L1CSR0_DCFI);	/* Invalidate */
+		asm volatile("msync; isync");
+		spr = mfspr(SPRN_L1CSR0);
+		asm volatile("msync; isync");
+		mtspr(SPRN_L1CSR0, spr | L1CSR0_DCFI | L1CSR0_DCE |
+				   L1CSR0_CPE);		/* Enable */
+	}
+}
+
+static void xes_mpc85xx_configure_l2(void __iomem *l2_base)
+{
+	volatile uint32_t ctl, tmp;
+
+	asm volatile("msync; isync");
+	tmp = in_be32(l2_base);
+
+	/*
+	 * xMon may have enabled part of L2 as SRAM, so we need to set it
+	 * up for all cache mode just to be safe.
+	 */
+	printk(KERN_INFO "xes_mpc85xx: Enabling L2 as cache\n");
+
+	ctl = MPC85xx_L2CTL_L2E | MPC85xx_L2CTL_L2I;
+	if (machine_is_compatible("MPC8540") ||
+	    machine_is_compatible("MPC8560"))
+		/*
+		 * Assume L2 SRAM is used fully for cache, so set
+		 * L2BLKSZ (bits 4:5) to match L2SIZ (bits 2:3).
+		 */
+		ctl |= (tmp & MPC85xx_L2CTL_L2SIZ_MASK) >> 2;
+
+	asm volatile("msync; isync");
+	out_be32(l2_base, ctl);
+	asm volatile("msync; isync");
+}
+
+static void xes_mpc85xx_fixups(void)
+{
+	struct device_node *np;
+	int err;
+
+	/*
+	 * Legacy xMon firmware on some X-ES boards does not enable caches.
+	 * We must ensure that they get enabled here.
+	 */
+	if (machine_is(xes_mpc8548) || machine_is(xes_mpc8540))
+		xes_mpc85xx_configure_l1();
+
+	for_each_node_by_name(np, "l2-cache-controller") {
+		struct resource r[2];
+		void __iomem *l2_base;
+
+		/* Only MPC8548, MPC8540, and MPC8560 boards are affected */
+		if (!of_device_is_compatible(np,
+				    "fsl,mpc8548-l2-cache-controller") &&
+		    !of_device_is_compatible(np,
+				    "fsl,mpc8540-l2-cache-controller") &&
+		    !of_device_is_compatible(np,
+				    "fsl,mpc8560-l2-cache-controller"))
+			continue;
+
+		err = of_address_to_resource(np, 0, &r[0]);
+		if (err) {
+			printk(KERN_WARNING "xes_mpc85xx: Could not get "
+			       "resource for device tree node '%s'",
+			       np->full_name);
+			continue;
+		}
+
+		l2_base = ioremap(r[0].start, r[0].end - r[0].start + 1);
+
+		xes_mpc85xx_configure_l2(l2_base);
+	}
+}
+
+#ifdef CONFIG_PCI
+static int primary_phb_addr;
+
+static int xes_mpc85xx_exclude_device(struct pci_controller *hose,
+				   u_char bus, u_char devfn)
+{
+	struct device_node* node;
+	struct resource rsrc;
+
+	node = hose->dn;
+	of_address_to_resource(node, 0, &rsrc);
+
+	return PCIBIOS_SUCCESSFUL;
+}
+#endif	/* CONFIG_PCI */
+
+/*
+ * Setup the architecture
+ */
+#ifdef CONFIG_SMP
+extern void __init mpc85xx_smp_init(void);
+#endif
+static void __init xes_mpc85xx_setup_arch(void)
+{
+#ifdef CONFIG_PCI
+	struct device_node *np;
+#endif
+	struct device_node *root;
+	const char *model = "Unknown";
+
+	root = of_find_node_by_path("/");
+	if (root == NULL)
+		return;
+
+	model = of_get_property(root, "model", NULL);
+	if (strncasecmp(model, "xes,", strlen("xes,")) != 0)
+		return;
+
+	printk(KERN_INFO "X-ES MPC85xx-based single-board computer: %s\n",
+	       model + strlen("xes,"));
+
+	xes_mpc85xx_fixups();
+
+#ifdef CONFIG_PCI
+	for_each_node_by_type(np, "pci") {
+		if (of_device_is_compatible(np, "fsl,mpc8540-pci") ||
+		    of_device_is_compatible(np, "fsl,mpc8548-pcie")) {
+			struct resource rsrc;
+			of_address_to_resource(np, 0, &rsrc);
+			if ((rsrc.start & 0xfffff) == primary_phb_addr)
+				fsl_add_bridge(np, 1);
+			else
+				fsl_add_bridge(np, 0);
+		}
+	}
+
+	ppc_md.pci_exclude_device = xes_mpc85xx_exclude_device;
+#endif
+
+#ifdef CONFIG_SMP
+	mpc85xx_smp_init();
+#endif
+}
+
+static struct of_device_id __initdata xes_mpc85xx_ids[] = {
+	{ .type = "soc", },
+	{ .compatible = "soc", },
+	{ .compatible = "simple-bus", },
+	{ .compatible = "gianfar", },
+	{},
+};
+
+static int __init xes_mpc85xx_publish_devices(void)
+{
+	return of_platform_bus_probe(NULL, xes_mpc85xx_ids, NULL);
+}
+machine_device_initcall(xes_mpc8572, xes_mpc85xx_publish_devices);
+machine_device_initcall(xes_mpc8548, xes_mpc85xx_publish_devices);
+
+/*
+ * Called very early, device-tree isn't unflattened
+ */
+static int __init xes_mpc8572_probe(void)
+{
+	unsigned long root = of_get_flat_dt_root();
+
+	if (of_flat_dt_is_compatible(root, "xes,MPC8572")) {
+#ifdef CONFIG_PCI
+		primary_phb_addr = 0x8000;
+#endif
+		return 1;
+	} else {
+		return 0;
+	}
+}
+
+static int __init xes_mpc8548_probe(void)
+{
+	unsigned long root = of_get_flat_dt_root();
+
+	if (of_flat_dt_is_compatible(root, "xes,MPC8548")) {
+#ifdef CONFIG_PCI
+		primary_phb_addr = 0xb000;
+#endif
+		return 1;
+	} else {
+		return 0;
+	}
+}
+
+static int __init xes_mpc8540_probe(void)
+{
+	unsigned long root = of_get_flat_dt_root();
+
+	if (of_flat_dt_is_compatible(root, "xes,MPC8540")) {
+#ifdef CONFIG_PCI
+		primary_phb_addr = 0xb000;
+#endif
+		return 1;
+	} else {
+		return 0;
+	}
+}
+
+define_machine(xes_mpc8572) {
+	.name			= "X-ES MPC8572",
+	.probe			= xes_mpc8572_probe,
+	.setup_arch		= xes_mpc85xx_setup_arch,
+	.init_IRQ		= xes_mpc85xx_pic_init,
+#ifdef CONFIG_PCI
+	.pcibios_fixup_bus	= fsl_pcibios_fixup_bus,
+#endif
+	.get_irq		= mpic_get_irq,
+	.restart		= fsl_rstcr_restart,
+	.calibrate_decr		= generic_calibrate_decr,
+	.progress		= udbg_progress,
+};
+
+define_machine(xes_mpc8548) {
+	.name			= "X-ES MPC8548",
+	.probe			= xes_mpc8548_probe,
+	.setup_arch		= xes_mpc85xx_setup_arch,
+	.init_IRQ		= xes_mpc85xx_pic_init,
+#ifdef CONFIG_PCI
+	.pcibios_fixup_bus	= fsl_pcibios_fixup_bus,
+#endif
+	.get_irq		= mpic_get_irq,
+	.restart		= fsl_rstcr_restart,
+	.calibrate_decr		= generic_calibrate_decr,
+	.progress		= udbg_progress,
+};
+
+define_machine(xes_mpc8540) {
+	.name			= "X-ES MPC8540",
+	.probe			= xes_mpc8540_probe,
+	.setup_arch		= xes_mpc85xx_setup_arch,
+	.init_IRQ		= xes_mpc85xx_pic_init,
+#ifdef CONFIG_PCI
+	.pcibios_fixup_bus	= fsl_pcibios_fixup_bus,
+#endif
+	.get_irq		= mpic_get_irq,
+	.restart		= fsl_rstcr_restart,
+	.calibrate_decr		= generic_calibrate_decr,
+	.progress		= udbg_progress,
+};
-- 
1.6.0.2

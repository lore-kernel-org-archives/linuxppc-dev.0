Return-Path: <LeoLi@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 84AEEDDEC4
	for <linuxppc-dev@ozlabs.org>; Fri, 19 Oct 2007 00:59:27 +1000 (EST)
Received: from az33smr02.freescale.net (az33smr02.freescale.net [10.64.34.200])
	by az33egw02.freescale.net (8.12.11/az33egw02) with ESMTP id
	l9IExKFg008384
	for <linuxppc-dev@ozlabs.org>; Thu, 18 Oct 2007 07:59:21 -0700 (MST)
Received: from zch01exm26.fsl.freescale.net (zch01exm26.ap.freescale.net
	[10.192.129.221])
	by az33smr02.freescale.net (8.13.1/8.13.0) with ESMTP id l9IExJ0g011351
	for <linuxppc-dev@ozlabs.org>; Thu, 18 Oct 2007 09:59:19 -0500 (CDT)
From: Li Yang <leoli@freescale.com>
To: galak@kernel.crashing.org, paulus@samba.org, linuxppc-dev@ozlabs.org
Subject: [PATCH v6 resend 9/9] add MPC837x MDS board default device tree
Date: Thu, 18 Oct 2007 23:09:46 +0800
Message-Id: <1192720186-25228-1-git-send-email-leoli@freescale.com>
Cc: Li Yang <leoli@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Signed-off-by: Li Yang <leoli@freescale.com>
---
Fix a typo in previous one.

 arch/powerpc/boot/dts/mpc8377_mds.dts |  282 +++++++++++++++++++++++++++++++
 arch/powerpc/boot/dts/mpc8378_mds.dts |  264 +++++++++++++++++++++++++++++
 arch/powerpc/boot/dts/mpc8379_mds.dts |  300 +++++++++++++++++++++++++++++++++
 3 files changed, 846 insertions(+), 0 deletions(-)
 create mode 100644 arch/powerpc/boot/dts/mpc8377_mds.dts
 create mode 100644 arch/powerpc/boot/dts/mpc8378_mds.dts
 create mode 100644 arch/powerpc/boot/dts/mpc8379_mds.dts

diff --git a/arch/powerpc/boot/dts/mpc8377_mds.dts b/arch/powerpc/boot/dts/mpc8377_mds.dts
new file mode 100644
index 0000000..154d18b
--- /dev/null
+++ b/arch/powerpc/boot/dts/mpc8377_mds.dts
@@ -0,0 +1,282 @@
+/*
+ * MPC8377E MDS Device Tree Source
+ *
+ * Copyright 2007 Freescale Semiconductor Inc.
+ *
+ * This program is free software; you can redistribute  it and/or modify it
+ * under  the terms of  the GNU General  Public License as published by the
+ * Free Software Foundation;  either version 2 of the  License, or (at your
+ * option) any later version.
+ */
+
+/ {
+	model = "fsl,mpc8377emds";
+	compatible = "fsl,mpc8377emds","fsl,mpc837xmds";
+	#address-cells = <1>;
+	#size-cells = <1>;
+
+	cpus {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		PowerPC,837x@0 {
+			device_type = "cpu";
+			reg = <0>;
+			d-cache-line-size = <20>;
+			i-cache-line-size = <20>;
+			d-cache-size = <8000>;		// L1, 32K
+			i-cache-size = <8000>;		// L1, 32K
+			timebase-frequency = <0>;
+			bus-frequency = <0>;
+			clock-frequency = <0>;
+		};
+	};
+
+	memory {
+		device_type = "memory";
+		reg = <00000000 20000000>;	// 512MB at 0
+	};
+
+	soc@e0000000 {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		device_type = "soc";
+		ranges = <0 e0000000 00100000>;
+		reg = <e0000000 00000200>;
+		bus-frequency = <0>;
+
+		wdt@200 {
+			compatible = "mpc83xx_wdt";
+			reg = <200 100>;
+		};
+
+		i2c@3000 {
+			device_type = "i2c";
+			compatible = "fsl-i2c";
+			reg = <3000 100>;
+			interrupts = <e 8>;
+			interrupt-parent = < &ipic >;
+			dfsrr;
+		};
+
+		i2c@3100 {
+			device_type = "i2c";
+			compatible = "fsl-i2c";
+			reg = <3100 100>;
+			interrupts = <f 8>;
+			interrupt-parent = < &ipic >;
+			dfsrr;
+		};
+
+		spi@7000 {
+			compatible = "fsl_spi";
+			reg = <7000 1000>;
+			interrupts = <10 8>;
+			interrupt-parent = < &ipic >;
+			mode = "cpu";
+		};
+
+		/* phy type (ULPI, UTMI, UTMI_WIDE, SERIAL) */
+		usb@23000 {
+			device_type = "usb";
+			compatible = "fsl-usb2-dr";
+			reg = <23000 1000>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			interrupt-parent = < &ipic >;
+			interrupts = <26 8>;
+			phy_type = "utmi_wide";
+		};
+
+		mdio@24520 {
+			device_type = "mdio";
+			compatible = "gianfar";
+			reg = <24520 20>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			phy2: ethernet-phy@2 {
+				interrupt-parent = < &ipic >;
+				interrupts = <11 8>;
+				reg = <2>;
+				device_type = "ethernet-phy";
+			};
+			phy3: ethernet-phy@3 {
+				interrupt-parent = < &ipic >;
+				interrupts = <12 8>;
+				reg = <3>;
+				device_type = "ethernet-phy";
+			};
+		};
+
+		ethernet@24000 {
+			device_type = "network";
+			model = "eTSEC";
+			compatible = "gianfar";
+			reg = <24000 1000>;
+			local-mac-address = [ 00 00 00 00 00 00 ];
+			interrupts = <20 8 21 8 22 8>;
+			phy-connection-type = "mii";
+			interrupt-parent = < &ipic >;
+			phy-handle = < &phy2 >;
+		};
+
+		ethernet@25000 {
+			device_type = "network";
+			model = "eTSEC";
+			compatible = "gianfar";
+			reg = <25000 1000>;
+			local-mac-address = [ 00 00 00 00 00 00 ];
+			interrupts = <23 8 24 8 25 8>;
+			phy-connection-type = "mii";
+			interrupt-parent = < &ipic >;
+			phy-handle = < &phy3 >;
+		};
+
+		serial@4500 {
+			device_type = "serial";
+			compatible = "ns16550";
+			reg = <4500 100>;
+			clock-frequency = <0>;
+			interrupts = <9 8>;
+			interrupt-parent = < &ipic >;
+		};
+
+		serial@4600 {
+			device_type = "serial";
+			compatible = "ns16550";
+			reg = <4600 100>;
+			clock-frequency = <0>;
+			interrupts = <a 8>;
+			interrupt-parent = < &ipic >;
+		};
+
+		crypto@30000 {
+			model = "SEC3";
+			compatible = "talitos";
+			reg = <30000 10000>;
+			interrupts = <b 8>;
+			interrupt-parent = < &ipic >;
+			/* Rev. 3.0 geometry */
+			num-channels = <4>;
+			channel-fifo-len = <18>;
+			exec-units-mask = <000001fe>;
+			descriptor-types-mask = <03ab0ebf>;
+		};
+
+		sdhc@2e000 {
+			model = "eSDHC";
+			compatible = "fsl,esdhc";
+			reg = <2e000 1000>;
+			interrupts = <2a 8>;
+			interrupt-parent = < &ipic >;
+		};
+
+		sata@18000 {
+			model = "SATA-300";
+			compatible = "fsl,mpc8379-sata";
+			reg = <18000 1000>;
+			interrupts = <2c 8>;
+			interrupt-parent = < &ipic >;
+			phy-handle = < &serdes1 >;
+		};
+
+		sata@19000 {
+			model = "SATA-300";
+			compatible = "fsl,mpc8379-sata";
+			reg = <19000 1000>;
+			interrupts = <2d 8>;
+			interrupt-parent = < &ipic >;
+			phy-handle = < &serdes1 >;
+		};
+
+		serdes1:serdes@e3000 {
+			compatible = "fsl,serdes";
+			reg = <e3000 100>;
+			vdd-1v;
+			protocol = "sata";
+			clock = <d#100>;
+		};
+
+		serdes2:serdes@e3100 {
+			compatible = "fsl,serdes";
+			reg = <e3100 100>;
+			vdd-1v;
+			protocol = "pcie";
+			clock = <d#100>;
+		};
+
+		/* IPIC
+		 * interrupts cell = <intr #, sense>
+		 * sense values match linux IORESOURCE_IRQ_* defines:
+		 * sense == 8: Level, low assertion
+		 * sense == 2: Edge, high-to-low change
+		 */
+		ipic: pic@700 {
+			compatible = "fsl,ipic";
+			interrupt-controller;
+			#address-cells = <0>;
+			#interrupt-cells = <2>;
+			reg = <700 100>;
+		};
+	};
+
+	pci@e0008500 {
+		interrupt-map-mask = <f800 0 0 7>;
+		interrupt-map = <
+
+				/* IDSEL 0x11 */
+				 8800 0 0 1 &ipic 14 8
+				 8800 0 0 2 &ipic 15 8
+				 8800 0 0 3 &ipic 16 8
+				 8800 0 0 4 &ipic 17 8
+
+				/* IDSEL 0x12 */
+				 9000 0 0 1 &ipic 16 8
+				 9000 0 0 2 &ipic 17 8
+				 9000 0 0 3 &ipic 14 8
+				 9000 0 0 4 &ipic 15 8
+
+				/* IDSEL 0x13 */
+				 9800 0 0 1 &ipic 17 8
+				 9800 0 0 2 &ipic 14 8
+				 9800 0 0 3 &ipic 15 8
+				 9800 0 0 4 &ipic 16 8
+
+				/* IDSEL 0x15 */
+				 a800 0 0 1 &ipic 14 8
+				 a800 0 0 2 &ipic 15 8
+				 a800 0 0 3 &ipic 16 8
+				 a800 0 0 4 &ipic 17 8
+
+				/* IDSEL 0x16 */
+				 b000 0 0 1 &ipic 17 8
+				 b000 0 0 2 &ipic 14 8
+				 b000 0 0 3 &ipic 15 8
+				 b000 0 0 4 &ipic 16 8
+
+				/* IDSEL 0x17 */
+				 b800 0 0 1 &ipic 16 8
+				 b800 0 0 2 &ipic 17 8
+				 b800 0 0 3 &ipic 14 8
+				 b800 0 0 4 &ipic 15 8
+
+				/* IDSEL 0x18 */
+				 c000 0 0 1 &ipic 15 8
+				 c000 0 0 2 &ipic 16 8
+				 c000 0 0 3 &ipic 17 8
+				 c000 0 0 4 &ipic 14 8>;
+		interrupt-parent = < &ipic >;
+		interrupts = <42 8>;
+		bus-range = <0 0>;
+		ranges = <02000000 0 90000000 90000000 0 10000000
+		          42000000 0 80000000 80000000 0 10000000
+		          01000000 0 00000000 e2000000 0 00100000>;
+		clock-frequency = <0>;
+		#interrupt-cells = <1>;
+		#size-cells = <2>;
+		#address-cells = <3>;
+		reg = <e0008500 100>;
+		compatible = "fsl,mpc83xx-pci", "83xx";
+		device_type = "pci";
+	};
+};
diff --git a/arch/powerpc/boot/dts/mpc8378_mds.dts b/arch/powerpc/boot/dts/mpc8378_mds.dts
new file mode 100644
index 0000000..d15b2bd
--- /dev/null
+++ b/arch/powerpc/boot/dts/mpc8378_mds.dts
@@ -0,0 +1,264 @@
+/*
+ * MPC8378E MDS Device Tree Source
+ *
+ * Copyright 2007 Freescale Semiconductor Inc.
+ *
+ * This program is free software; you can redistribute  it and/or modify it
+ * under  the terms of  the GNU General  Public License as published by the
+ * Free Software Foundation;  either version 2 of the  License, or (at your
+ * option) any later version.
+ */
+
+/ {
+	model = "fsl,mpc8378emds";
+	compatible = "fsl,mpc8378emds","fsl,mpc837xmds";
+	#address-cells = <1>;
+	#size-cells = <1>;
+
+	cpus {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		PowerPC,837x@0 {
+			device_type = "cpu";
+			reg = <0>;
+			d-cache-line-size = <20>;
+			i-cache-line-size = <20>;
+			d-cache-size = <8000>;		// L1, 32K
+			i-cache-size = <8000>;		// L1, 32K
+			timebase-frequency = <0>;
+			bus-frequency = <0>;
+			clock-frequency = <0>;
+		};
+	};
+
+	memory {
+		device_type = "memory";
+		reg = <00000000 20000000>;	// 512MB at 0
+	};
+
+	soc@e0000000 {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		device_type = "soc";
+		ranges = <0 e0000000 00100000>;
+		reg = <e0000000 00000200>;
+		bus-frequency = <0>;
+
+		wdt@200 {
+			compatible = "mpc83xx_wdt";
+			reg = <200 100>;
+		};
+
+		i2c@3000 {
+			device_type = "i2c";
+			compatible = "fsl-i2c";
+			reg = <3000 100>;
+			interrupts = <e 8>;
+			interrupt-parent = < &ipic >;
+			dfsrr;
+		};
+
+		i2c@3100 {
+			device_type = "i2c";
+			compatible = "fsl-i2c";
+			reg = <3100 100>;
+			interrupts = <f 8>;
+			interrupt-parent = < &ipic >;
+			dfsrr;
+		};
+
+		spi@7000 {
+			compatible = "fsl_spi";
+			reg = <7000 1000>;
+			interrupts = <10 8>;
+			interrupt-parent = < &ipic >;
+			mode = "cpu";
+		};
+
+		/* phy type (ULPI, UTMI, UTMI_WIDE, SERIAL) */
+		usb@23000 {
+			device_type = "usb";
+			compatible = "fsl-usb2-dr";
+			reg = <23000 1000>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			interrupt-parent = < &ipic >;
+			interrupts = <26 8>;
+			phy_type = "utmi_wide";
+		};
+
+		mdio@24520 {
+			device_type = "mdio";
+			compatible = "gianfar";
+			reg = <24520 20>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			phy2: ethernet-phy@2 {
+				interrupt-parent = < &ipic >;
+				interrupts = <11 8>;
+				reg = <2>;
+				device_type = "ethernet-phy";
+			};
+			phy3: ethernet-phy@3 {
+				interrupt-parent = < &ipic >;
+				interrupts = <12 8>;
+				reg = <3>;
+				device_type = "ethernet-phy";
+			};
+		};
+
+		ethernet@24000 {
+			device_type = "network";
+			model = "eTSEC";
+			compatible = "gianfar";
+			reg = <24000 1000>;
+			local-mac-address = [ 00 00 00 00 00 00 ];
+			interrupts = <20 8 21 8 22 8>;
+			phy-connection-type = "mii";
+			interrupt-parent = < &ipic >;
+			phy-handle = < &phy2 >;
+		};
+
+		ethernet@25000 {
+			device_type = "network";
+			model = "eTSEC";
+			compatible = "gianfar";
+			reg = <25000 1000>;
+			local-mac-address = [ 00 00 00 00 00 00 ];
+			interrupts = <23 8 24 8 25 8>;
+			phy-connection-type = "mii";
+			interrupt-parent = < &ipic >;
+			phy-handle = < &phy3 >;
+		};
+
+		serial@4500 {
+			device_type = "serial";
+			compatible = "ns16550";
+			reg = <4500 100>;
+			clock-frequency = <0>;
+			interrupts = <9 8>;
+			interrupt-parent = < &ipic >;
+		};
+
+		serial@4600 {
+			device_type = "serial";
+			compatible = "ns16550";
+			reg = <4600 100>;
+			clock-frequency = <0>;
+			interrupts = <a 8>;
+			interrupt-parent = < &ipic >;
+		};
+
+		crypto@30000 {
+			model = "SEC3";
+			compatible = "talitos";
+			reg = <30000 10000>;
+			interrupts = <b 8>;
+			interrupt-parent = < &ipic >;
+			/* Rev. 3.0 geometry */
+			num-channels = <4>;
+			channel-fifo-len = <18>;
+			exec-units-mask = <000001fe>;
+			descriptor-types-mask = <03ab0ebf>;
+		};
+
+		sdhc@2e000 {
+			model = "eSDHC";
+			compatible = "fsl,esdhc";
+			reg = <2e000 1000>;
+			interrupts = <2a 8>;
+			interrupt-parent = < &ipic >;
+		};
+
+		serdes1:serdes@e3000 {
+			compatible = "fsl,serdes";
+			reg = <e3000 100>;
+			vdd-1v;
+			protocol = "sgmii";
+			clock = <d#100>;
+		};
+
+		serdes2:serdes@e3100 {
+			compatible = "fsl,serdes";
+			reg = <e3100 100>;
+			vdd-1v;
+			protocol = "pcie";
+			clock = <d#100>;
+		};
+
+		/* IPIC
+		 * interrupts cell = <intr #, sense>
+		 * sense values match linux IORESOURCE_IRQ_* defines:
+		 * sense == 8: Level, low assertion
+		 * sense == 2: Edge, high-to-low change
+		 */
+		ipic: pic@700 {
+			compatible = "fsl,ipic";
+			interrupt-controller;
+			#address-cells = <0>;
+			#interrupt-cells = <2>;
+			reg = <700 100>;
+		};
+	};
+
+	pci@e0008500 {
+		interrupt-map-mask = <f800 0 0 7>;
+		interrupt-map = <
+
+				/* IDSEL 0x11 */
+				 8800 0 0 1 &ipic 14 8
+				 8800 0 0 2 &ipic 15 8
+				 8800 0 0 3 &ipic 16 8
+				 8800 0 0 4 &ipic 17 8
+
+				/* IDSEL 0x12 */
+				 9000 0 0 1 &ipic 16 8
+				 9000 0 0 2 &ipic 17 8
+				 9000 0 0 3 &ipic 14 8
+				 9000 0 0 4 &ipic 15 8
+
+				/* IDSEL 0x13 */
+				 9800 0 0 1 &ipic 17 8
+				 9800 0 0 2 &ipic 14 8
+				 9800 0 0 3 &ipic 15 8
+				 9800 0 0 4 &ipic 16 8
+
+				/* IDSEL 0x15 */
+				 a800 0 0 1 &ipic 14 8
+				 a800 0 0 2 &ipic 15 8
+				 a800 0 0 3 &ipic 16 8
+				 a800 0 0 4 &ipic 17 8
+
+				/* IDSEL 0x16 */
+				 b000 0 0 1 &ipic 17 8
+				 b000 0 0 2 &ipic 14 8
+				 b000 0 0 3 &ipic 15 8
+				 b000 0 0 4 &ipic 16 8
+
+				/* IDSEL 0x17 */
+				 b800 0 0 1 &ipic 16 8
+				 b800 0 0 2 &ipic 17 8
+				 b800 0 0 3 &ipic 14 8
+				 b800 0 0 4 &ipic 15 8
+
+				/* IDSEL 0x18 */
+				 c000 0 0 1 &ipic 15 8
+				 c000 0 0 2 &ipic 16 8
+				 c000 0 0 3 &ipic 17 8
+				 c000 0 0 4 &ipic 14 8>;
+		interrupt-parent = < &ipic >;
+		interrupts = <42 8>;
+		bus-range = <0 0>;
+		ranges = <02000000 0 90000000 90000000 0 10000000
+		          42000000 0 80000000 80000000 0 10000000
+		          01000000 0 00000000 e2000000 0 00100000>;
+		clock-frequency = <0>;
+		#interrupt-cells = <1>;
+		#size-cells = <2>;
+		#address-cells = <3>;
+		reg = <e0008500 100>;
+		compatible = "fsl,mpc83xx-pci", "83xx";
+		device_type = "pci";
+	};
+};
diff --git a/arch/powerpc/boot/dts/mpc8379_mds.dts b/arch/powerpc/boot/dts/mpc8379_mds.dts
new file mode 100644
index 0000000..d6afec5
--- /dev/null
+++ b/arch/powerpc/boot/dts/mpc8379_mds.dts
@@ -0,0 +1,300 @@
+/*
+ * MPC8379E MDS Device Tree Source
+ *
+ * Copyright 2007 Freescale Semiconductor Inc.
+ *
+ * This program is free software; you can redistribute  it and/or modify it
+ * under  the terms of  the GNU General  Public License as published by the
+ * Free Software Foundation;  either version 2 of the  License, or (at your
+ * option) any later version.
+ */
+
+/ {
+	model = "fsl,mpc8379emds";
+	compatible = "fsl,mpc8379emds","fsl,mpc837xmds";
+	#address-cells = <1>;
+	#size-cells = <1>;
+
+	cpus {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		PowerPC,837x@0 {
+			device_type = "cpu";
+			reg = <0>;
+			d-cache-line-size = <20>;
+			i-cache-line-size = <20>;
+			d-cache-size = <8000>;		// L1, 32K
+			i-cache-size = <8000>;		// L1, 32K
+			timebase-frequency = <0>;
+			bus-frequency = <0>;
+			clock-frequency = <0>;
+		};
+	};
+
+	memory {
+		device_type = "memory";
+		reg = <00000000 20000000>;	// 512MB at 0
+	};
+
+	soc@e0000000 {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		device_type = "soc";
+		ranges = <0 e0000000 00100000>;
+		reg = <e0000000 00000200>;
+		bus-frequency = <0>;
+
+		wdt@200 {
+			compatible = "mpc83xx_wdt";
+			reg = <200 100>;
+		};
+
+		i2c@3000 {
+			device_type = "i2c";
+			compatible = "fsl-i2c";
+			reg = <3000 100>;
+			interrupts = <e 8>;
+			interrupt-parent = < &ipic >;
+			dfsrr;
+		};
+
+		i2c@3100 {
+			device_type = "i2c";
+			compatible = "fsl-i2c";
+			reg = <3100 100>;
+			interrupts = <f 8>;
+			interrupt-parent = < &ipic >;
+			dfsrr;
+		};
+
+		spi@7000 {
+			compatible = "fsl_spi";
+			reg = <7000 1000>;
+			interrupts = <10 8>;
+			interrupt-parent = < &ipic >;
+			mode = "cpu";
+		};
+
+		/* phy type (ULPI, UTMI, UTMI_WIDE, SERIAL) */
+		usb@23000 {
+			device_type = "usb";
+			compatible = "fsl-usb2-dr";
+			reg = <23000 1000>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			interrupt-parent = < &ipic >;
+			interrupts = <26 8>;
+			phy_type = "utmi_wide";
+		};
+
+		mdio@24520 {
+			device_type = "mdio";
+			compatible = "gianfar";
+			reg = <24520 20>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			phy2: ethernet-phy@2 {
+				interrupt-parent = < &ipic >;
+				interrupts = <11 8>;
+				reg = <2>;
+				device_type = "ethernet-phy";
+			};
+			phy3: ethernet-phy@3 {
+				interrupt-parent = < &ipic >;
+				interrupts = <12 8>;
+				reg = <3>;
+				device_type = "ethernet-phy";
+			};
+		};
+
+		ethernet@24000 {
+			device_type = "network";
+			model = "eTSEC";
+			compatible = "gianfar";
+			reg = <24000 1000>;
+			local-mac-address = [ 00 00 00 00 00 00 ];
+			interrupts = <20 8 21 8 22 8>;
+			phy-connection-type = "mii";
+			interrupt-parent = < &ipic >;
+			phy-handle = < &phy2 >;
+		};
+
+		ethernet@25000 {
+			device_type = "network";
+			model = "eTSEC";
+			compatible = "gianfar";
+			reg = <25000 1000>;
+			local-mac-address = [ 00 00 00 00 00 00 ];
+			interrupts = <23 8 24 8 25 8>;
+			phy-connection-type = "mii";
+			interrupt-parent = < &ipic >;
+			phy-handle = < &phy3 >;
+		};
+
+		serial@4500 {
+			device_type = "serial";
+			compatible = "ns16550";
+			reg = <4500 100>;
+			clock-frequency = <0>;
+			interrupts = <9 8>;
+			interrupt-parent = < &ipic >;
+		};
+
+		serial@4600 {
+			device_type = "serial";
+			compatible = "ns16550";
+			reg = <4600 100>;
+			clock-frequency = <0>;
+			interrupts = <a 8>;
+			interrupt-parent = < &ipic >;
+		};
+
+		crypto@30000 {
+			model = "SEC3";
+			compatible = "talitos";
+			reg = <30000 10000>;
+			interrupts = <b 8>;
+			interrupt-parent = < &ipic >;
+			/* Rev. 3.0 geometry */
+			num-channels = <4>;
+			channel-fifo-len = <18>;
+			exec-units-mask = <000001fe>;
+			descriptor-types-mask = <03ab0ebf>;
+		};
+
+		sdhc@2e000 {
+			model = "eSDHC";
+			compatible = "fsl,esdhc";
+			reg = <2e000 1000>;
+			interrupts = <2a 8>;
+			interrupt-parent = < &ipic >;
+		};
+
+		sata@18000 {
+			model = "SATA-300";
+			compatible = "fsl,mpc8379-sata";
+			reg = <18000 1000>;
+			interrupts = <2c 8>;
+			interrupt-parent = < &ipic >;
+			phy-handle = < &serdes1 >;
+		};
+
+		sata@19000 {
+			model = "SATA-300";
+			compatible = "fsl,mpc8379-sata";
+			reg = <19000 1000>;
+			interrupts = <2d 8>;
+			interrupt-parent = < &ipic >;
+			phy-handle = < &serdes1 >;
+		};
+
+		sata@1a000 {
+			model = "SATA-300";
+			compatible = "fsl,mpc8379-sata";
+			reg = <1a000 1000>;
+			interrupts = <2e 8>;
+			interrupt-parent = < &ipic >;
+			phy-handle = < &serdes2 >;
+		};
+
+		sata@1b000 {
+			model = "SATA-300";
+			compatible = "fsl,mpc8379-sata";
+			reg = <1b000 1000>;
+			interrupts = <2f 8>;
+			interrupt-parent = < &ipic >;
+			phy-handle = < &serdes2 >;
+		};
+
+		serdes1:serdes@e3000 {
+			compatible = "fsl,serdes";
+			reg = <e3000 100>;
+			vdd-1v;
+			protocol = "sata";
+			clock = <d#100>;
+		};
+
+		serdes2:serdes@e3100 {
+			compatible = "fsl,serdes";
+			reg = <e3100 100>;
+			vdd-1v;
+			protocol = "sata";
+			clock = <d#100>;
+		};
+
+		/* IPIC
+		 * interrupts cell = <intr #, sense>
+		 * sense values match linux IORESOURCE_IRQ_* defines:
+		 * sense == 8: Level, low assertion
+		 * sense == 2: Edge, high-to-low change
+		 */
+		ipic: pic@700 {
+			compatible = "fsl,ipic";
+			interrupt-controller;
+			#address-cells = <0>;
+			#interrupt-cells = <2>;
+			reg = <700 100>;
+		};
+	};
+
+	pci@e0008500 {
+		interrupt-map-mask = <f800 0 0 7>;
+		interrupt-map = <
+
+				/* IDSEL 0x11 */
+				 8800 0 0 1 &ipic 14 8
+				 8800 0 0 2 &ipic 15 8
+				 8800 0 0 3 &ipic 16 8
+				 8800 0 0 4 &ipic 17 8
+
+				/* IDSEL 0x12 */
+				 9000 0 0 1 &ipic 16 8
+				 9000 0 0 2 &ipic 17 8
+				 9000 0 0 3 &ipic 14 8
+				 9000 0 0 4 &ipic 15 8
+
+				/* IDSEL 0x13 */
+				 9800 0 0 1 &ipic 17 8
+				 9800 0 0 2 &ipic 14 8
+				 9800 0 0 3 &ipic 15 8
+				 9800 0 0 4 &ipic 16 8
+
+				/* IDSEL 0x15 */
+				 a800 0 0 1 &ipic 14 8
+				 a800 0 0 2 &ipic 15 8
+				 a800 0 0 3 &ipic 16 8
+				 a800 0 0 4 &ipic 17 8
+
+				/* IDSEL 0x16 */
+				 b000 0 0 1 &ipic 17 8
+				 b000 0 0 2 &ipic 14 8
+				 b000 0 0 3 &ipic 15 8
+				 b000 0 0 4 &ipic 16 8
+
+				/* IDSEL 0x17 */
+				 b800 0 0 1 &ipic 16 8
+				 b800 0 0 2 &ipic 17 8
+				 b800 0 0 3 &ipic 14 8
+				 b800 0 0 4 &ipic 15 8
+
+				/* IDSEL 0x18 */
+				 c000 0 0 1 &ipic 15 8
+				 c000 0 0 2 &ipic 16 8
+				 c000 0 0 3 &ipic 17 8
+				 c000 0 0 4 &ipic 14 8>;
+		interrupt-parent = < &ipic >;
+		interrupts = <42 8>;
+		bus-range = <0 0>;
+		ranges = <02000000 0 90000000 90000000 0 10000000
+		          42000000 0 80000000 80000000 0 10000000
+		          01000000 0 00000000 e2000000 0 00100000>;
+		clock-frequency = <0>;
+		#interrupt-cells = <1>;
+		#size-cells = <2>;
+		#address-cells = <3>;
+		reg = <e0008500 100>;
+		compatible = "fsl,mpc83xx-pci", "83xx";
+		device_type = "pci";
+	};
+};
-- 
1.5.3.2.104.g41ef

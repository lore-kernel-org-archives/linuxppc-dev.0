Return-Path: <paul.gortmaker@windriver.com>
Received: from mail.wrs.com (mail.windriver.com [147.11.1.11])
	by ozlabs.org (Postfix) with ESMTP id 461B7DDE09
	for <linuxppc-dev@ozlabs.org>; Fri, 25 Jan 2008 10:41:40 +1100 (EST)
From: Paul Gortmaker <paul.gortmaker@windriver.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 9/10] sbc834x: Add device tree source for Wind River SBC834x
	board.
Date: Thu, 24 Jan 2008 18:41:31 -0500
Message-Id: <12012180994172-git-send-email-paul.gortmaker@windriver.com>
In-Reply-To: <120121809863-git-send-email-paul.gortmaker@windriver.com>
References: <12012180922447-git-send-email-paul.gortmaker@windriver.com>
	<12012180943940-git-send-email-paul.gortmaker@windriver.com>
	<12012180944056-git-send-email-paul.gortmaker@windriver.com>
	<12012180951674-git-send-email-paul.gortmaker@windriver.com>
	<12012180961689-git-send-email-paul.gortmaker@windriver.com>
	<1201218096476-git-send-email-paul.gortmaker@windriver.com>
	<12012180971068-git-send-email-paul.gortmaker@windriver.com>
	<120121809839-git-send-email-paul.gortmaker@windriver.com>
	<120121809863-git-send-email-paul.gortmaker@windriver.com>
Message-Id: <331a875ebbfcf28f26707c86fa904953298e240b.1201217172.git.paul.gortmaker@windriver.com>
In-Reply-To: <e3ccba7097a77e66f07663fe9d1f174c06183528.1201217172.git.paul.gortmaker@windriver.com>
References: <e3ccba7097a77e66f07663fe9d1f174c06183528.1201217172.git.paul.gortmaker@windriver.com>
Cc: Paul Gortmaker <paul.gortmaker@windriver.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This adds the device tree source for the Wind River SBC834x board.
It is based on the MPC834x_MDS DTS, with the biggest difference being
the lack of BCSR and the PCI2 that the MDS gets via the PIB. That,
and this file is also dts-v1 format.

Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
---
 arch/powerpc/boot/dts/sbc8349.dts |  243 +++++++++++++++++++++++++++++++++++++
 1 files changed, 243 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/boot/dts/sbc8349.dts b/arch/powerpc/boot/dts/sbc8349.dts
new file mode 100644
index 0000000..9c13c1a
--- /dev/null
+++ b/arch/powerpc/boot/dts/sbc8349.dts
@@ -0,0 +1,243 @@
+/*
+ * SBC8349E Device Tree Source
+ *
+ * Copyright 2007 Wind River Inc.
+ *
+ * Paul Gortmaker (see MAINTAINERS for contact information)
+ *
+ *	-based largely on the Freescale MPC834x_MDS dts.
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
+	model = "SBC8349E";
+	compatible = "SBC834xE";
+	#address-cells = <1>;
+	#size-cells = <1>;
+
+	aliases {
+		ethernet0 = &enet0;
+		ethernet1 = &enet1;
+		serial0 = &serial0;
+		serial1 = &serial1;
+		pci0 = &pci0;
+	};
+
+	cpus {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		PowerPC,8349@0 {
+			device_type = "cpu";
+			reg = <0>;
+			d-cache-line-size = <0x20>;	// 32 bytes
+			i-cache-line-size = <0x20>;	// 32 bytes
+			d-cache-size = <0x8000>;		// L1, 32K
+			i-cache-size = <0x8000>;		// L1, 32K
+			timebase-frequency = <0>;	// from bootloader
+			bus-frequency = <0>;		// from bootloader
+			clock-frequency = <0>;		// from bootloader
+		};
+	};
+
+	memory {
+		device_type = "memory";
+		reg = <0x00000000 0x10000000>;	// 256MB at 0
+	};
+
+	soc8349@e0000000 {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		device_type = "soc";
+		ranges = <0x0 0xe0000000 0x00100000>;
+		reg = <0xe0000000 0x00000200>;
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
+			interrupts = <0xe 0x8>;
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
+			interrupts = <0xf 0x8>;
+			interrupt-parent = <&ipic>;
+			dfsrr;
+		};
+
+		spi@7000 {
+			compatible = "fsl_spi";
+			reg = <0x7000 0x1000>;
+			interrupts = <0x10 0x8>;
+			interrupt-parent = <&ipic>;
+			mode = "cpu";
+		};
+
+		/* phy type (ULPI or SERIAL) are only types supported for MPH */
+		/* port = 0 or 1 */
+		usb@22000 {
+			compatible = "fsl-usb2-mph";
+			reg = <0x22000 0x1000>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			interrupt-parent = <&ipic>;
+			interrupts = <0x27 0x8>;
+			phy_type = "ulpi";
+			port1;
+		};
+		/* phy type (ULPI, UTMI, UTMI_WIDE, SERIAL) */
+		usb@23000 {
+			device_type = "usb";
+			compatible = "fsl-usb2-dr";
+			reg = <0x23000 0x1000>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			interrupt-parent = <&ipic>;
+			interrupts = <0x26 0x8>;
+			dr_mode = "otg";
+			phy_type = "ulpi";
+		};
+
+		mdio@24520 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			compatible = "fsl,gianfar-mdio";
+			reg = <0x24520 0x20>;
+
+			phy0: ethernet-phy@19 {
+				interrupt-parent = <&ipic>;
+				interrupts = <0x14 0x8>;
+				reg = <0x19>;
+				device_type = "ethernet-phy";
+			};
+			phy1: ethernet-phy@1a {
+				interrupt-parent = <&ipic>;
+				interrupts = <0x15 0x8>;
+				reg = <0x1a>;
+				device_type = "ethernet-phy";
+			};
+		};
+
+		enet0: ethernet@24000 {
+			cell-index = <0>;
+			device_type = "network";
+			model = "TSEC";
+			compatible = "gianfar";
+			reg = <0x24000 0x1000>;
+			local-mac-address = [ 00 00 00 00 00 00 ];
+			interrupts = <0x20 0x8 0x21 0x8 0x22 0x8>;
+			interrupt-parent = <&ipic>;
+			phy-handle = <&phy0>;
+			linux,network-index = <0>;
+		};
+
+		enet1: ethernet@25000 {
+			cell-index = <1>;
+			device_type = "network";
+			model = "TSEC";
+			compatible = "gianfar";
+			reg = <0x25000 0x1000>;
+			local-mac-address = [ 00 00 00 00 00 00 ];
+			interrupts = <0x23 0x8 0x24 0x8 0x25 0x8>;
+			interrupt-parent = <&ipic>;
+			phy-handle = <&phy1>;
+			linux,network-index = <1>;
+		};
+
+		serial0: serial@4500 {
+			cell-index = <0>;
+			device_type = "serial";
+			compatible = "ns16550";
+			reg = <0x4500 0x100>;
+			clock-frequency = <0>;
+			interrupts = <0x9 0x8>;
+			interrupt-parent = <&ipic>;
+		};
+
+		serial1: serial@4600 {
+			cell-index = <1>;
+			device_type = "serial";
+			compatible = "ns16550";
+			reg = <0x4600 0x100>;
+			clock-frequency = <0>;
+			interrupts = <0xa 0x8>;
+			interrupt-parent = <&ipic>;
+		};
+
+		/* May need to remove if on a part without crypto engine */
+		crypto@30000 {
+			model = "SEC2";
+			compatible = "talitos";
+			reg = <0x30000 0x10000>;
+			interrupts = <0xb 0x8>;
+			interrupt-parent = <&ipic>;
+			num-channels = <4>;
+			channel-fifo-len = <0x18>;
+			exec-units-mask = <0x0000007e>;
+			/* desc mask is for rev2.0,
+			 * we need runtime fixup for >2.0 */
+			descriptor-types-mask = <0x01010ebf>;
+		};
+
+		/* IPIC
+		 * interrupts cell = <intr #, sense>
+		 * sense values match linux IORESOURCE_IRQ_* defines:
+		 * sense == 8: Level, low assertion
+		 * sense == 2: Edge, high-to-low change
+		 */
+		ipic: pic@700 {
+			interrupt-controller;
+			#address-cells = <0>;
+			#interrupt-cells = <2>;
+			reg = <0x700 0x100>;
+			device_type = "ipic";
+		};
+	};
+
+	pci0: pci@e0008500 {
+		cell-index = <1>;
+		interrupt-map-mask = <0xf800 0x0 0x0 0x7>;
+		interrupt-map = <
+
+				/* IDSEL 0x11 */
+				 0x8800 0x0 0x0 0x1 &ipic 0x14 0x8
+				 0x8800 0x0 0x0 0x2 &ipic 0x15 0x8
+				 0x8800 0x0 0x0 0x3 &ipic 0x16 0x8
+				 0x8800 0x0 0x0 0x4 &ipic 0x17 0x8>;
+
+		interrupt-parent = <&ipic>;
+		interrupts = <0x42 0x8>;
+		bus-range = <0 0>;
+		ranges = <0x02000000 0x0 0x90000000 0x90000000 0x0 0x10000000
+			  0x42000000 0x0 0x80000000 0x80000000 0x0 0x10000000
+			  0x01000000 0x0 0x00000000 0xe2000000 0x0 0x00100000>;
+		clock-frequency = <66666666>;
+		#interrupt-cells = <1>;
+		#size-cells = <2>;
+		#address-cells = <3>;
+		reg = <0xe0008500 0x100>;
+		compatible = "fsl,mpc8349-pci";
+		device_type = "pci";
+	};
+};
-- 
1.5.0.rc1.gf4b6c

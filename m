Return-Path: <afleming@freescale.com>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102]) by ozlabs.org (Postfix) with ESMTP id EFCA7679E1
	for <linuxppc-dev@ozlabs.org>; Fri, 18 Aug 2006 11:26:56 +1000 (EST)
Date: Thu, 17 Aug 2006 20:26:49 -0500 (CDT)
From: Andy Fleming <afleming@freescale.com>
To: Paul Mackerras <paulus@samba.org>, linuxppc-dev@ozlabs.org
Subject: [PATCH] Add 85xx DTS files
Message-ID: <Pine.LNX.4.61.0608172024570.420@ld0175-tx32.am.freescale.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Added the DTS files for the 8540 ADS, and the 8555/41/48 CDS

Signed-of-by: Andy Fleming <afleming@freescale.com>
---
 arch/powerpc/boot/dts/mpc8540ads.dts |  250 ++++++++++++++++++++++++++++++
 arch/powerpc/boot/dts/mpc8541cds.dts |  244 +++++++++++++++++++++++++++++
 arch/powerpc/boot/dts/mpc8548cds.dts |  287 ++++++++++++++++++++++++++++++++++
 arch/powerpc/boot/dts/mpc8555cds.dts |  244 +++++++++++++++++++++++++++++
 4 files changed, 1025 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/boot/dts/mpc8540ads.dts b/arch/powerpc/boot/dts/mpc8540ads.dts
new file mode 100644
index 0000000..88b0ea7
--- /dev/null
+++ b/arch/powerpc/boot/dts/mpc8540ads.dts
@@ -0,0 +1,250 @@
+/*
+ * MPC8540 ADS Device Tree Source
+ *
+ * Copyright 2006 Freescale Semiconductor Inc.
+ *
+ * This program is free software; you can redistribute  it and/or modify it
+ * under  the terms of  the GNU General  Public License as published by the
+ * Free Software Foundation;  either version 2 of the  License, or (at your
+ * option) any later version.
+ */
+
+
+/ {
+	model = "MPC8540ADS";
+	compatible = "MPC85xxADS";
+	#address-cells = <1>;
+	#size-cells = <1>;
+	linux,phandle = <100>;
+
+	cpus {
+		#cpus = <1>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+		linux,phandle = <200>;
+
+		PowerPC,8540@0 {
+			device_type = "cpu";
+			reg = <0>;
+			d-cache-line-size = <20>;	// 32 bytes
+			i-cache-line-size = <20>;	// 32 bytes
+			d-cache-size = <8000>;		// L1, 32K
+			i-cache-size = <8000>;		// L1, 32K
+			timebase-frequency = <0>;	//  33 MHz, from uboot
+			bus-frequency = <0>;	// 166 MHz
+			clock-frequency = <0>;	// 825 MHz, from uboot
+			32-bit;
+			linux,phandle = <201>;
+			linux,boot-cpu;
+		};
+	};
+
+	memory {
+		device_type = "memory";
+		linux,phandle = <300>;
+		reg = <00000000 08000000>;	// 128M at 0x0
+	};
+
+	soc8540@e0000000 {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		#interrupt-cells = <2>;
+		device_type = "soc";
+		ranges = <0 e0000000 00100000>;
+		reg = <e0000000 00100000>;	// CCSRBAR 1M
+		bus-frequency = <0>;
+
+		i2c@3000 {
+			device_type = "i2c";
+			compatible = "fsl-i2c";
+			reg = <3000 100>;
+			interrupts = <1b 2>;
+			interrupt-parent = <40000>;
+			dfsrr;
+		};
+
+		mdio@24520 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			device_type = "mdio";
+			compatible = "gianfar";
+			reg = <24520 20>;
+			linux,phandle = <24520>;
+			ethernet-phy@0 {
+				linux,phandle = <2452000>;
+				interrupt-parent = <40000>;
+				interrupts = <35 3>;
+				reg = <0>;
+				device_type = "ethernet-phy";
+			};
+			ethernet-phy@1 {
+				linux,phandle = <2452001>;
+				interrupt-parent = <40000>;
+				interrupts = <35 3>;
+				reg = <1>;
+				device_type = "ethernet-phy";
+			};
+		};
+
+		ethernet@24000 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			device_type = "network";
+			model = "TSEC";
+			compatible = "gianfar";
+			reg = <24000 1000>;
+			local-mac-address = [ 00 E0 0C 00 73 00 ];
+			interrupts = <d 2 e 2 12 2>;
+			interrupt-parent = <40000>;
+			phy-handle = <2452000>;
+		};
+
+		ethernet@25000 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			device_type = "network";
+			model = "TSEC";
+			compatible = "gianfar";
+			reg = <25000 1000>;
+			local-mac-address = [ 00 E0 0C 00 73 01 ];
+			interrupts = <13 2 14 2 18 2>;
+			interrupt-parent = <40000>;
+			phy-handle = <2452001>;
+		};
+
+		ethernet@26000 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			device_type = "network";
+			model = "FEC";
+			compatible = "gianfar";
+			reg = <26000 1000>;
+			local-mac-address = [ 00 E0 0C 00 73 02 ];
+			interrupts = <19 2>;
+			interrupt-parent = <40000>;
+			phy-handle = <2452001>;
+		};
+
+
+
+		serial@4500 {
+			device_type = "serial";
+			compatible = "ns16550";
+			reg = <4500 100>; 	// reg base, size
+			clock-frequency = <0>; 	// should we fill in in uboot?
+			interrupts = <1a 2>;
+			interrupt-parent = <40000>;
+		};
+
+		serial@4600 {
+			device_type = "serial";
+			compatible = "ns16550";
+			reg = <4600 100>;	// reg base, size
+			clock-frequency = <0>; 	// should we fill in in uboot?
+			interrupts = <1a 2>;
+			interrupt-parent = <40000>;
+		};
+		pci@8000 {
+			linux,phandle = <8000>;
+			interrupt-map-mask = <f800 0 0 7>;
+			interrupt-map = <
+
+				/* IDSEL 0x02 */
+				1000 0 0 1 40000 31 1
+				1000 0 0 2 40000 32 1
+				1000 0 0 3 40000 33 1
+				1000 0 0 4 40000 34 1
+
+				/* IDSEL 0x03 */
+				1800 0 0 1 40000 34 1
+				1800 0 0 2 40000 31 1
+				1800 0 0 3 40000 32 1
+				1800 0 0 4 40000 33 1
+
+				/* IDSEL 0x04 */
+				2000 0 0 1 40000 33 1
+				2000 0 0 2 40000 34 1
+				2000 0 0 3 40000 31 1
+				2000 0 0 4 40000 32 1
+
+				/* IDSEL 0x05 */
+				2800 0 0 1 40000 32 1
+				2800 0 0 2 40000 33 1
+				2800 0 0 3 40000 34 1
+				2800 0 0 4 40000 31 1
+
+				/* IDSEL 0x0c */
+				6000 0 0 1 40000 31 1
+				6000 0 0 2 40000 32 1
+				6000 0 0 3 40000 33 1
+				6000 0 0 4 40000 34 1
+
+				/* IDSEL 0x0d */
+				6800 0 0 1 40000 34 1
+				6800 0 0 2 40000 31 1
+				6800 0 0 3 40000 32 1
+				6800 0 0 4 40000 33 1
+
+				/* IDSEL 0x0e */
+				7000 0 0 1 40000 33 1
+				7000 0 0 2 40000 34 1
+				7000 0 0 3 40000 31 1
+				7000 0 0 4 40000 32 1
+
+				/* IDSEL 0x0f */
+				7800 0 0 1 40000 32 1
+				7800 0 0 2 40000 33 1
+				7800 0 0 3 40000 34 1
+				7800 0 0 4 40000 31 1
+
+				/* IDSEL 0x12 */
+				9000 0 0 1 40000 31 1
+				9000 0 0 2 40000 32 1
+				9000 0 0 3 40000 33 1
+				9000 0 0 4 40000 34 1
+
+				/* IDSEL 0x13 */
+				9800 0 0 1 40000 34 1
+				9800 0 0 2 40000 31 1
+				9800 0 0 3 40000 32 1
+				9800 0 0 4 40000 33 1
+
+				/* IDSEL 0x14 */
+				a000 0 0 1 40000 33 1
+				a000 0 0 2 40000 34 1
+				a000 0 0 3 40000 31 1
+				a000 0 0 4 40000 32 1
+
+				/* IDSEL 0x15 */
+				a800 0 0 1 40000 32 1
+				a800 0 0 2 40000 33 1
+				a800 0 0 3 40000 34 1
+				a800 0 0 4 40000 31 1>;
+			interrupt-parent = <40000>;
+			interrupts = <08 3>;
+			bus-range = <0 0>;
+			ranges = <02000000 0 80000000 80000000 0 20000000
+				  01000000 0 00000000 e2000000 0 00100000>;
+			clock-frequency = <3f940aa>;
+			#interrupt-cells = <1>;
+			#size-cells = <2>;
+			#address-cells = <3>;
+			reg = <8000 1000>;
+			compatible = "85xx";
+			device_type = "pci";
+		};
+
+		pic@40000 {
+			linux,phandle = <40000>;
+			clock-frequency = <0>;
+			interrupt-controller;
+			#address-cells = <0>;
+			#interrupt-cells = <2>;
+			reg = <40000 40000>;
+			built-in;
+			compatible = "chrp,open-pic";
+			device_type = "open-pic";
+                        big-endian;
+		};
+	};
+};
diff --git a/arch/powerpc/boot/dts/mpc8541cds.dts b/arch/powerpc/boot/dts/mpc8541cds.dts
new file mode 100644
index 0000000..d526397
--- /dev/null
+++ b/arch/powerpc/boot/dts/mpc8541cds.dts
@@ -0,0 +1,244 @@
+/*
+ * MPC8541 CDS Device Tree Source
+ *
+ * Copyright 2006 Freescale Semiconductor Inc.
+ *
+ * This program is free software; you can redistribute  it and/or modify it
+ * under  the terms of  the GNU General  Public License as published by the
+ * Free Software Foundation;  either version 2 of the  License, or (at your
+ * option) any later version.
+ */
+
+
+/ {
+	model = "MPC8541CDS";
+	compatible = "MPC85xxCDS";
+	#address-cells = <1>;
+	#size-cells = <1>;
+	linux,phandle = <100>;
+
+	cpus {
+		#cpus = <1>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+		linux,phandle = <200>;
+
+		PowerPC,8541@0 {
+			device_type = "cpu";
+			reg = <0>;
+			d-cache-line-size = <20>;	// 32 bytes
+			i-cache-line-size = <20>;	// 32 bytes
+			d-cache-size = <8000>;		// L1, 32K
+			i-cache-size = <8000>;		// L1, 32K
+			timebase-frequency = <0>;	//  33 MHz, from uboot
+			bus-frequency = <0>;	// 166 MHz
+			clock-frequency = <0>;	// 825 MHz, from uboot
+			32-bit;
+			linux,phandle = <201>;
+		};
+	};
+
+	memory {
+		device_type = "memory";
+		linux,phandle = <300>;
+		reg = <00000000 08000000>;	// 128M at 0x0
+	};
+
+	soc8541@e0000000 {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		#interrupt-cells = <2>;
+		device_type = "soc";
+		ranges = <0 e0000000 00100000>;
+		reg = <e0000000 00100000>;	// CCSRBAR 1M
+		bus-frequency = <0>;
+
+		i2c@3000 {
+			device_type = "i2c";
+			compatible = "fsl-i2c";
+			reg = <3000 100>;
+			interrupts = <1b 2>;
+			interrupt-parent = <40000>;
+			dfsrr;
+		};
+
+		mdio@24520 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			device_type = "mdio";
+			compatible = "gianfar";
+			reg = <24520 20>;
+			linux,phandle = <24520>;
+			ethernet-phy@0 {
+				linux,phandle = <2452000>;
+				interrupt-parent = <40000>;
+				interrupts = <35 0>;
+				reg = <0>;
+				device_type = "ethernet-phy";
+			};
+			ethernet-phy@1 {
+				linux,phandle = <2452001>;
+				interrupt-parent = <40000>;
+				interrupts = <35 0>;
+				reg = <1>;
+				device_type = "ethernet-phy";
+			};
+		};
+
+		ethernet@24000 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			device_type = "network";
+			model = "TSEC";
+			compatible = "gianfar";
+			reg = <24000 1000>;
+			local-mac-address = [ 00 E0 0C 00 73 00 ];
+			interrupts = <d 2 e 2 12 2>;
+			interrupt-parent = <40000>;
+			phy-handle = <2452000>;
+		};
+
+		ethernet@25000 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			device_type = "network";
+			model = "TSEC";
+			compatible = "gianfar";
+			reg = <25000 1000>;
+			local-mac-address = [ 00 E0 0C 00 73 01 ];
+			interrupts = <13 2 14 2 18 2>;
+			interrupt-parent = <40000>;
+			phy-handle = <2452001>;
+		};
+
+		serial@4500 {
+			device_type = "serial";
+			compatible = "ns16550";
+			reg = <4500 100>; 	// reg base, size
+			clock-frequency = <0>; 	// should we fill in in uboot?
+			interrupts = <1a 2>;
+			interrupt-parent = <40000>;
+		};
+
+		serial@4600 {
+			device_type = "serial";
+			compatible = "ns16550";
+			reg = <4600 100>;	// reg base, size
+			clock-frequency = <0>; 	// should we fill in in uboot?
+			interrupts = <1a 2>;
+			interrupt-parent = <40000>;
+		};
+
+		pci@8000 {
+			linux,phandle = <8000>;
+			interrupt-map-mask = <1f800 0 0 7>;
+			interrupt-map = <
+
+				/* IDSEL 0x10 */
+				08000 0 0 1 40000 30 1
+				08000 0 0 2 40000 31 1
+				08000 0 0 3 40000 32 1
+				08000 0 0 4 40000 33 1
+
+				/* IDSEL 0x11 */
+				08800 0 0 1 40000 30 1
+				08800 0 0 2 40000 31 1
+				08800 0 0 3 40000 32 1
+				08800 0 0 4 40000 33 1
+
+				/* IDSEL 0x12 (Slot 1) */
+				09000 0 0 1 40000 30 1
+				09000 0 0 2 40000 31 1
+				09000 0 0 3 40000 32 1
+				09000 0 0 4 40000 33 1
+
+				/* IDSEL 0x13 (Slot 2) */
+				09800 0 0 1 40000 31 1
+				09800 0 0 2 40000 32 1
+				09800 0 0 3 40000 33 1
+				09800 0 0 4 40000 30 1
+
+				/* IDSEL 0x14 (Slot 3) */
+				0a000 0 0 1 40000 32 1
+				0a000 0 0 2 40000 33 1
+				0a000 0 0 3 40000 30 1
+				0a000 0 0 4 40000 31 1
+
+				/* IDSEL 0x15 (Slot 4) */
+				0a800 0 0 1 40000 33 1
+				0a800 0 0 2 40000 30 1
+				0a800 0 0 3 40000 31 1
+				0a800 0 0 4 40000 32 1
+				
+				/* Bus 1 (Tundra Bridge) */
+				/* IDSEL 0x12 (ISA bridge) */
+				19000 0 0 1 40000 30 1
+				19000 0 0 2 40000 31 1
+				19000 0 0 3 40000 32 1
+				19000 0 0 4 40000 33 1>;
+			interrupt-parent = <40000>;
+			interrupts = <08 2>;
+			bus-range = <0 0>;
+			ranges = <02000000 0 80000000 80000000 0 20000000
+				  01000000 0 00000000 e2000000 0 00100000>;
+			clock-frequency = <3f940aa>;
+			#interrupt-cells = <1>;
+			#size-cells = <2>;
+			#address-cells = <3>;
+			reg = <8000 1000>;
+			compatible = "85xx";
+			device_type = "pci";
+
+			i8259@19000 {
+				clock-frequency = <0>;
+				interrupt-controller;
+				device_type = "interrupt-controller";
+				reg = <19000 0 0 0 1>;
+				#address-cells = <0>;
+				#interrupt-cells = <2>;
+				built-in;
+				compatible = "chrp,iic";
+				big-endian;
+				interrupts = <1>;
+				interrupt-parent = <8000>;
+			};
+		};
+
+		pci@9000 {
+			linux,phandle = <9000>;
+			interrupt-map-mask = <f800 0 0 7>;
+			interrupt-map = <
+
+				/* IDSEL 0x15 */
+				a800 0 0 1 40000 3b 1
+				a800 0 0 2 40000 3b 1
+				a800 0 0 3 40000 3b 1
+				a800 0 0 4 40000 3b 1>;
+			interrupt-parent = <40000>;
+			interrupts = <09 2>;
+			bus-range = <0 0>;
+			ranges = <02000000 0 a0000000 a0000000 0 20000000
+				  01000000 0 00000000 e3000000 0 00100000>;
+			clock-frequency = <3f940aa>;
+			#interrupt-cells = <1>;
+			#size-cells = <2>;
+			#address-cells = <3>;
+			reg = <9000 1000>;
+			compatible = "85xx";
+			device_type = "pci";
+		};
+
+		pic@40000 {
+			linux,phandle = <40000>;
+			clock-frequency = <0>;
+			interrupt-controller;
+			#address-cells = <0>;
+			#interrupt-cells = <2>;
+			reg = <40000 40000>;
+			built-in;
+			compatible = "chrp,open-pic";
+			device_type = "open-pic";
+                        big-endian;
+		};
+	};
+};
diff --git a/arch/powerpc/boot/dts/mpc8548cds.dts b/arch/powerpc/boot/dts/mpc8548cds.dts
new file mode 100644
index 0000000..ec1446a
--- /dev/null
+++ b/arch/powerpc/boot/dts/mpc8548cds.dts
@@ -0,0 +1,287 @@
+/*
+ * MPC8555 CDS Device Tree Source
+ *
+ * Copyright 2006 Freescale Semiconductor Inc.
+ *
+ * This program is free software; you can redistribute  it and/or modify it
+ * under  the terms of  the GNU General  Public License as published by the
+ * Free Software Foundation;  either version 2 of the  License, or (at your
+ * option) any later version.
+ */
+
+
+/ {
+	model = "MPC8548CDS";
+	compatible = "MPC85xxCDS";
+	#address-cells = <1>;
+	#size-cells = <1>;
+	linux,phandle = <100>;
+
+	cpus {
+		#cpus = <1>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+		linux,phandle = <200>;
+
+		PowerPC,8548@0 {
+			device_type = "cpu";
+			reg = <0>;
+			d-cache-line-size = <20>;	// 32 bytes
+			i-cache-line-size = <20>;	// 32 bytes
+			d-cache-size = <8000>;		// L1, 32K
+			i-cache-size = <8000>;		// L1, 32K
+			timebase-frequency = <0>;	//  33 MHz, from uboot
+			bus-frequency = <0>;	// 166 MHz
+			clock-frequency = <0>;	// 825 MHz, from uboot
+			32-bit;
+			linux,phandle = <201>;
+		};
+	};
+
+	memory {
+		device_type = "memory";
+		linux,phandle = <300>;
+		reg = <00000000 08000000>;	// 128M at 0x0
+	};
+
+	soc8548@e0000000 {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		#interrupt-cells = <2>;
+		device_type = "soc";
+		ranges = <0 e0000000 00100000>;
+		reg = <e0000000 00100000>;	// CCSRBAR 1M
+		bus-frequency = <0>;
+
+		i2c@3000 {
+			device_type = "i2c";
+			compatible = "fsl-i2c";
+			reg = <3000 100>;
+			interrupts = <1b 2>;
+			interrupt-parent = <40000>;
+			dfsrr;
+		};
+
+		mdio@24520 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			device_type = "mdio";
+			compatible = "gianfar";
+			reg = <24520 20>;
+			linux,phandle = <24520>;
+			ethernet-phy@0 {
+				linux,phandle = <2452000>;
+				interrupt-parent = <40000>;
+				interrupts = <35 0>;
+				reg = <0>;
+				device_type = "ethernet-phy";
+			};
+			ethernet-phy@1 {
+				linux,phandle = <2452001>;
+				interrupt-parent = <40000>;
+				interrupts = <35 0>;
+				reg = <1>;
+				device_type = "ethernet-phy";
+			};
+
+			ethernet-phy@2 {
+				linux,phandle = <2452002>;
+				interrupt-parent = <40000>;
+				interrupts = <35 0>;
+				reg = <2>;
+				device_type = "ethernet-phy";
+			};
+			ethernet-phy@3 {
+				linux,phandle = <2452003>;
+				interrupt-parent = <40000>;
+				interrupts = <35 0>;
+				reg = <3>;
+				device_type = "ethernet-phy";
+			};
+		};
+
+		ethernet@24000 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			device_type = "network";
+			model = "eTSEC";
+			compatible = "gianfar";
+			reg = <24000 1000>;
+			local-mac-address = [ 00 E0 0C 00 73 00 ];
+			interrupts = <d 2 e 2 12 2>;
+			interrupt-parent = <40000>;
+			phy-handle = <2452000>;
+		};
+
+		ethernet@25000 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			device_type = "network";
+			model = "eTSEC";
+			compatible = "gianfar";
+			reg = <25000 1000>;
+			local-mac-address = [ 00 E0 0C 00 73 01 ];
+			interrupts = <13 2 14 2 18 2>;
+			interrupt-parent = <40000>;
+			phy-handle = <2452001>;
+		};
+
+		ethernet@26000 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			device_type = "network";
+			model = "eTSEC";
+			compatible = "gianfar";
+			reg = <26000 1000>;
+			local-mac-address = [ 00 E0 0C 00 73 02 ];
+			interrupts = <f 2 10 2 11 2>;
+			interrupt-parent = <40000>;
+			phy-handle = <2452001>;
+		};
+
+/* eTSEC 4 is currently broken
+		ethernet@27000 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			device_type = "network";
+			model = "eTSEC";
+			compatible = "gianfar";
+			reg = <27000 1000>;
+			local-mac-address = [ 00 E0 0C 00 73 03 ];
+			interrupts = <15 2 16 2 17 2>;
+			interrupt-parent = <40000>;
+			phy-handle = <2452001>;
+		};
+ */
+
+		serial@4500 {
+			device_type = "serial";
+			compatible = "ns16550";
+			reg = <4500 100>; 	// reg base, size
+			clock-frequency = <0>; 	// should we fill in in uboot?
+			interrupts = <1a 2>;
+			interrupt-parent = <40000>;
+		};
+
+		serial@4600 {
+			device_type = "serial";
+			compatible = "ns16550";
+			reg = <4600 100>;	// reg base, size
+			clock-frequency = <0>; 	// should we fill in in uboot?
+			interrupts = <1a 2>;
+			interrupt-parent = <40000>;
+		};
+
+		pci@8000 {
+			linux,phandle = <8000>;
+			interrupt-map-mask = <1f800 0 0 7>;
+			interrupt-map = <
+
+				/* IDSEL 0x10 */
+				08000 0 0 1 40000 30 1
+				08000 0 0 2 40000 31 1
+				08000 0 0 3 40000 32 1
+				08000 0 0 4 40000 33 1
+
+				/* IDSEL 0x11 */
+				08800 0 0 1 40000 30 1
+				08800 0 0 2 40000 31 1
+				08800 0 0 3 40000 32 1
+				08800 0 0 4 40000 33 1
+
+				/* IDSEL 0x12 (Slot 1) */
+				09000 0 0 1 40000 30 1
+				09000 0 0 2 40000 31 1
+				09000 0 0 3 40000 32 1
+				09000 0 0 4 40000 33 1
+
+				/* IDSEL 0x13 (Slot 2) */
+				09800 0 0 1 40000 31 1
+				09800 0 0 2 40000 32 1
+				09800 0 0 3 40000 33 1
+				09800 0 0 4 40000 30 1
+
+				/* IDSEL 0x14 (Slot 3) */
+				0a000 0 0 1 40000 32 1
+				0a000 0 0 2 40000 33 1
+				0a000 0 0 3 40000 30 1
+				0a000 0 0 4 40000 31 1
+
+				/* IDSEL 0x15 (Slot 4) */
+				0a800 0 0 1 40000 33 1
+				0a800 0 0 2 40000 30 1
+				0a800 0 0 3 40000 31 1
+				0a800 0 0 4 40000 32 1
+				
+				/* Bus 1 (Tundra Bridge) */
+				/* IDSEL 0x12 (ISA bridge) */
+				19000 0 0 1 40000 30 1
+				19000 0 0 2 40000 31 1
+				19000 0 0 3 40000 32 1
+				19000 0 0 4 40000 33 1>;
+			interrupt-parent = <40000>;
+			interrupts = <08 2>;
+			bus-range = <0 0>;
+			ranges = <02000000 0 80000000 80000000 0 20000000
+				  01000000 0 00000000 e2000000 0 00100000>;
+			clock-frequency = <3f940aa>;
+			#interrupt-cells = <1>;
+			#size-cells = <2>;
+			#address-cells = <3>;
+			reg = <8000 1000>;
+			compatible = "85xx";
+			device_type = "pci";
+
+			i8259@19000 {
+				clock-frequency = <0>;
+				interrupt-controller;
+				device_type = "interrupt-controller";
+				reg = <19000 0 0 0 1>;
+				#address-cells = <0>;
+				#interrupt-cells = <2>;
+				built-in;
+				compatible = "chrp,iic";
+				big-endian;
+				interrupts = <1>;
+				interrupt-parent = <8000>;
+			};
+		};
+
+		pci@9000 {
+			linux,phandle = <9000>;
+			interrupt-map-mask = <f800 0 0 7>;
+			interrupt-map = <
+
+				/* IDSEL 0x15 */
+				a800 0 0 1 40000 3b 1
+				a800 0 0 2 40000 3b 1
+				a800 0 0 3 40000 3b 1
+				a800 0 0 4 40000 3b 1>;
+			interrupt-parent = <40000>;
+			interrupts = <09 2>;
+			bus-range = <0 0>;
+			ranges = <02000000 0 a0000000 a0000000 0 20000000
+				  01000000 0 00000000 e3000000 0 00100000>;
+			clock-frequency = <3f940aa>;
+			#interrupt-cells = <1>;
+			#size-cells = <2>;
+			#address-cells = <3>;
+			reg = <9000 1000>;
+			compatible = "85xx";
+			device_type = "pci";
+		};
+
+		pic@40000 {
+			linux,phandle = <40000>;
+			clock-frequency = <0>;
+			interrupt-controller;
+			#address-cells = <0>;
+			#interrupt-cells = <2>;
+			reg = <40000 40000>;
+			built-in;
+			compatible = "chrp,open-pic";
+			device_type = "open-pic";
+                        big-endian;
+		};
+	};
+};
diff --git a/arch/powerpc/boot/dts/mpc8555cds.dts b/arch/powerpc/boot/dts/mpc8555cds.dts
new file mode 100644
index 0000000..71fea14
--- /dev/null
+++ b/arch/powerpc/boot/dts/mpc8555cds.dts
@@ -0,0 +1,244 @@
+/*
+ * MPC8555 CDS Device Tree Source
+ *
+ * Copyright 2006 Freescale Semiconductor Inc.
+ *
+ * This program is free software; you can redistribute  it and/or modify it
+ * under  the terms of  the GNU General  Public License as published by the
+ * Free Software Foundation;  either version 2 of the  License, or (at your
+ * option) any later version.
+ */
+
+
+/ {
+	model = "MPC8555CDS";
+	compatible = "MPC85xxCDS";
+	#address-cells = <1>;
+	#size-cells = <1>;
+	linux,phandle = <100>;
+
+	cpus {
+		#cpus = <1>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+		linux,phandle = <200>;
+
+		PowerPC,8555@0 {
+			device_type = "cpu";
+			reg = <0>;
+			d-cache-line-size = <20>;	// 32 bytes
+			i-cache-line-size = <20>;	// 32 bytes
+			d-cache-size = <8000>;		// L1, 32K
+			i-cache-size = <8000>;		// L1, 32K
+			timebase-frequency = <0>;	//  33 MHz, from uboot
+			bus-frequency = <0>;	// 166 MHz
+			clock-frequency = <0>;	// 825 MHz, from uboot
+			32-bit;
+			linux,phandle = <201>;
+		};
+	};
+
+	memory {
+		device_type = "memory";
+		linux,phandle = <300>;
+		reg = <00000000 08000000>;	// 128M at 0x0
+	};
+
+	soc8555@e0000000 {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		#interrupt-cells = <2>;
+		device_type = "soc";
+		ranges = <0 e0000000 00100000>;
+		reg = <e0000000 00100000>;	// CCSRBAR 1M
+		bus-frequency = <0>;
+
+		i2c@3000 {
+			device_type = "i2c";
+			compatible = "fsl-i2c";
+			reg = <3000 100>;
+			interrupts = <1b 2>;
+			interrupt-parent = <40000>;
+			dfsrr;
+		};
+
+		mdio@24520 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			device_type = "mdio";
+			compatible = "gianfar";
+			reg = <24520 20>;
+			linux,phandle = <24520>;
+			ethernet-phy@0 {
+				linux,phandle = <2452000>;
+				interrupt-parent = <40000>;
+				interrupts = <35 0>;
+				reg = <0>;
+				device_type = "ethernet-phy";
+			};
+			ethernet-phy@1 {
+				linux,phandle = <2452001>;
+				interrupt-parent = <40000>;
+				interrupts = <35 0>;
+				reg = <1>;
+				device_type = "ethernet-phy";
+			};
+		};
+
+		ethernet@24000 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			device_type = "network";
+			model = "TSEC";
+			compatible = "gianfar";
+			reg = <24000 1000>;
+			local-mac-address = [ 00 E0 0C 00 73 00 ];
+			interrupts = <0d 2 0e 2 12 2>;
+			interrupt-parent = <40000>;
+			phy-handle = <2452000>;
+		};
+
+		ethernet@25000 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			device_type = "network";
+			model = "TSEC";
+			compatible = "gianfar";
+			reg = <25000 1000>;
+			local-mac-address = [ 00 E0 0C 00 73 01 ];
+			interrupts = <13 2 14 2 18 2>;
+			interrupt-parent = <40000>;
+			phy-handle = <2452001>;
+		};
+
+		serial@4500 {
+			device_type = "serial";
+			compatible = "ns16550";
+			reg = <4500 100>; 	// reg base, size
+			clock-frequency = <0>; 	// should we fill in in uboot?
+			interrupts = <1a 2>;
+			interrupt-parent = <40000>;
+		};
+
+		serial@4600 {
+			device_type = "serial";
+			compatible = "ns16550";
+			reg = <4600 100>;	// reg base, size
+			clock-frequency = <0>; 	// should we fill in in uboot?
+			interrupts = <1a 2>;
+			interrupt-parent = <40000>;
+		};
+
+		pci@8000 {
+			linux,phandle = <8000>;
+			interrupt-map-mask = <1f800 0 0 7>;
+			interrupt-map = <
+
+				/* IDSEL 0x10 */
+				08000 0 0 1 40000 30 1
+				08000 0 0 2 40000 31 1
+				08000 0 0 3 40000 32 1
+				08000 0 0 4 40000 33 1
+
+				/* IDSEL 0x11 */
+				08800 0 0 1 40000 30 1
+				08800 0 0 2 40000 31 1
+				08800 0 0 3 40000 32 1
+				08800 0 0 4 40000 33 1
+
+				/* IDSEL 0x12 (Slot 1) */
+				09000 0 0 1 40000 30 1
+				09000 0 0 2 40000 31 1
+				09000 0 0 3 40000 32 1
+				09000 0 0 4 40000 33 1
+
+				/* IDSEL 0x13 (Slot 2) */
+				09800 0 0 1 40000 31 1
+				09800 0 0 2 40000 32 1
+				09800 0 0 3 40000 33 1
+				09800 0 0 4 40000 30 1
+
+				/* IDSEL 0x14 (Slot 3) */
+				0a000 0 0 1 40000 32 1
+				0a000 0 0 2 40000 33 1
+				0a000 0 0 3 40000 30 1
+				0a000 0 0 4 40000 31 1
+
+				/* IDSEL 0x15 (Slot 4) */
+				0a800 0 0 1 40000 33 1
+				0a800 0 0 2 40000 30 1
+				0a800 0 0 3 40000 31 1
+				0a800 0 0 4 40000 32 1
+				
+				/* Bus 1 (Tundra Bridge) */
+				/* IDSEL 0x12 (ISA bridge) */
+				19000 0 0 1 40000 30 1
+				19000 0 0 2 40000 31 1
+				19000 0 0 3 40000 32 1
+				19000 0 0 4 40000 33 1>;
+			interrupt-parent = <40000>;
+			interrupts = <08 2>;
+			bus-range = <0 0>;
+			ranges = <02000000 0 80000000 80000000 0 20000000
+				  01000000 0 00000000 e2000000 0 00100000>;
+			clock-frequency = <3f940aa>;
+			#interrupt-cells = <1>;
+			#size-cells = <2>;
+			#address-cells = <3>;
+			reg = <8000 1000>;
+			compatible = "85xx";
+			device_type = "pci";
+
+			i8259@19000 {
+				clock-frequency = <0>;
+				interrupt-controller;
+				device_type = "interrupt-controller";
+				reg = <19000 0 0 0 1>;
+				#address-cells = <0>;
+				#interrupt-cells = <2>;
+				built-in;
+				compatible = "chrp,iic";
+				big-endian;
+				interrupts = <1>;
+				interrupt-parent = <8000>;
+			};
+		};
+
+		pci@9000 {
+			linux,phandle = <9000>;
+			interrupt-map-mask = <f800 0 0 7>;
+			interrupt-map = <
+
+				/* IDSEL 0x15 */
+				a800 0 0 1 40000 3b 1
+				a800 0 0 2 40000 3b 1
+				a800 0 0 3 40000 3b 1
+				a800 0 0 4 40000 3b 1>;
+			interrupt-parent = <40000>;
+			interrupts = <09 2>;
+			bus-range = <0 0>;
+			ranges = <02000000 0 a0000000 a0000000 0 20000000
+				  01000000 0 00000000 e3000000 0 00100000>;
+			clock-frequency = <3f940aa>;
+			#interrupt-cells = <1>;
+			#size-cells = <2>;
+			#address-cells = <3>;
+			reg = <9000 1000>;
+			compatible = "85xx";
+			device_type = "pci";
+		};
+
+		pic@40000 {
+			linux,phandle = <40000>;
+			clock-frequency = <0>;
+			interrupt-controller;
+			#address-cells = <0>;
+			#interrupt-cells = <2>;
+			reg = <40000 40000>;
+			built-in;
+			compatible = "chrp,open-pic";
+			device_type = "open-pic";
+                        big-endian;
+		};
+	};
+};
-- 
2006_06_07.01.gittree_pull-dirty

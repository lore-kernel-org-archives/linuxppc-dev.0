Return-Path: <tie-fei.zang@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102]) by ozlabs.org (Postfix) with ESMTP id 01CCD67C39
	for <linuxppc-dev@ozlabs.org>; Fri, 25 Aug 2006 18:43:45 +1000 (EST)
Received: from az33smr01.freescale.net (az33smr01.freescale.net [10.64.34.199])
	by az33egw01.freescale.net (8.12.11/az33egw01) with ESMTP id
	k7P8hi4Q001460
	for <linuxppc-dev@ozlabs.org>; Fri, 25 Aug 2006 01:43:44 -0700 (MST)
Received: from zch01exm23.fsl.freescale.net (zch01exm23.ap.freescale.net
	[10.192.129.207])
	by az33smr01.freescale.net (8.13.1/8.13.0) with ESMTP id k7P8hgI0026992
	for <linuxppc-dev@ozlabs.org>; Fri, 25 Aug 2006 03:43:43 -0500 (CDT)
Subject: [PATCH ] powerpc: mpc7448hpc2 device tree source file
From: Zang Roy-r61911 <tie-fei.zang@freescale.com>
To: Paul Mackerras <paulus@samba.org>
In-Reply-To: <7EA18FDD2DC2154AA3BD6D2F22A62A0E19E353@zch01exm23.fsl.freescale.net>
References: <7EA18FDD2DC2154AA3BD6D2F22A62A0E19E353@zch01exm23.fsl.freescale.net>
Content-Type: text/plain
Message-Id: <1156495404.7107.42.camel@localhost.localdomain>
Mime-Version: 1.0
Date: 25 Aug 2006 16:43:25 +0800
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	Yang Xin-Xin-r48390 <Xin-Xin.Yang@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This patch adds the mpc7448hpc2 device tree source file.

Signed-off-by: Roy Zang	<tie-fei.zang@freescale.com>


---
 arch/powerpc/boot/dts/mpc7448hpc2.dts |  190 +++++++++++++++++++++++++++++++++
 1 files changed, 190 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/boot/dts/mpc7448hpc2.dts b/arch/powerpc/boot/dts/mpc7448hpc2.dts
new file mode 100644
index 0000000..d7b985e
--- /dev/null
+++ b/arch/powerpc/boot/dts/mpc7448hpc2.dts
@@ -0,0 +1,190 @@
+/*
+ * MPC7448HPC2 (Taiga) board Device Tree Source
+ *
+ * Copyright 2006 Freescale Semiconductor Inc.
+ * 2006 Roy Zang <Roy Zang at freescale.com>.
+ *
+ * This program is free software; you can redistribute  it and/or modify it
+ * under  the terms of  the GNU General  Public License as published by the
+ * Free Software Foundation;  either version 2 of the  License, or (at your
+ * option) any later version.
+ */
+
+
+/ {
+	model = "mpc7448hpc2";
+	compatible = "mpc74xx";
+	#address-cells = <1>;
+	#size-cells = <1>;
+	linux,phandle = <100>;
+
+	cpus {
+		#cpus = <1>;
+		#address-cells = <1>;
+		#size-cells =<0>;
+		linux,phandle = <200>;
+				
+		PowerPC,7448@0 {
+			device_type = "cpu";
+			reg = <0>;
+			d-cache-line-size = <20>;	// 32 bytes
+			i-cache-line-size = <20>;	// 32 bytes
+			d-cache-size = <8000>;		// L1, 32K bytes
+			i-cache-size = <8000>;		// L1, 32K bytes
+			timebase-frequency = <0>;	// 33 MHz, from uboot
+			clock-frequency = <0>;		// From U-Boot
+			bus-frequency = <0>;		// From U-Boot
+			32-bit;
+			linux,phandle = <201>;
+			linux,boot-cpu;
+		};
+	};
+
+	memory {
+		device_type = "memory";
+		linux,phandle = <300>;
+		reg = <00000000 20000000	// DDR2   512M at 0
+		       >;
+	};
+
+  	tsi108@c0000000 {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		#interrupt-cells = <2>;
+		device_type = "tsi-bridge";
+		ranges = <00000000 c0000000 00010000>;
+		reg = <c0000000 00010000>;
+		bus-frequency = <0>;
+
+		i2c@7000 {
+			interrupt-parent = <7400>;
+			interrupts = <E 0>;
+			reg = <7000 400>;
+			device_type = "i2c";
+			compatible  = "tsi-i2c";
+		};
+
+		mdio@6000 {
+			device_type = "mdio";
+			compatible = "tsi-ethernet";
+
+			ethernet-phy@6000 {
+				linux,phandle = <6000>;
+				interrupt-parent = <7400>;
+				interrupts = <2 1>;
+				reg = <6000 50>;
+				phy-id = <8>;
+				device_type = "ethernet-phy";
+			};
+
+			ethernet-phy@6400 {
+				linux,phandle = <6400>;
+				interrupt-parent = <7400>;
+				interrupts = <2 1>;
+				reg = <6000 50>;
+				phy-id = <9>;
+				device_type = "ethernet-phy";
+			};
+
+		};
+
+		ethernet@6200 {
+			#size-cells = <0>;
+			device_type = "network";
+			model = "TSI-ETH";
+			compatible = "tsi-ethernet";
+			reg = <6000 200>;
+			address = [ 00 06 D2 00 00 01 ];
+			interrupts = <10 2>;
+			interrupt-parent = <7400>;
+			phy-handle = <6000>;
+		};
+
+		ethernet@6600 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			device_type = "network";
+			model = "TSI-ETH";
+			compatible = "tsi-ethernet";
+			reg = <6400 200>;
+			address = [ 00 06 D2 00 00 02 ];
+			interrupts = <11 2>;
+			interrupt-parent = <7400>;
+			phy-handle = <6400>;
+		};
+
+		serial@7808 {
+			device_type = "serial";
+			compatible = "ns16550";
+			reg = <7808 200>;
+			clock-frequency = <3f6b5a00>;
+			interrupts = <c 0>;
+			interrupt-parent = <7400>;
+		};
+
+		serial@7c08 {
+			device_type = "serial";
+			compatible = "ns16550";
+			reg = <7c08 200>;
+			clock-frequency = <3f6b5a00>;
+			interrupts = <d 0>;
+			interrupt-parent = <7400>;
+		};
+
+	  	pic@7400 {
+			linux,phandle = <7400>;
+			clock-frequency = <0>;
+			interrupt-controller;
+			#address-cells = <0>;
+			#interrupt-cells = <2>;
+			reg = <7400 400>;
+			built-in;
+			compatible = "chrp,open-pic";
+			device_type = "open-pic";
+                       	big-endian;
+		};
+		pci@1000 {
+			compatible = "tsi10x";
+			device_type = "pci";
+			linux,phandle = <1000>;
+			#interrupt-cells = <1>;
+			#size-cells = <2>;
+			#address-cells = <3>;
+			reg = <1000 1000>;
+			bus-range = <0 0>;
+			ranges = <02000000 0 e0000000 e0000000 0 1A000000	
+				  01000000 0 00000000 fa000000 0 00010000>;
+			clock-frequency = <7f28154>;
+			interrupt-parent = <7400>;
+			interrupts = <17 2>;
+			interrupt-map-mask = <f800 0 0 7>;
+			interrupt-map = <
+
+				/* IDSEL 0x11 */
+				0800 0 0 1 7400 24 0
+				0800 0 0 2 7400 25 0
+				0800 0 0 3 7400 26 0
+				0800 0 0 4 7400 27 0
+
+				/* IDSEL 0x12 */
+				1000 0 0 1 7400 25 0
+				1000 0 0 2 7400 26 0
+				1000 0 0 3 7400 27 0
+				1000 0 0 4 7400 24 0
+
+				/* IDSEL 0x13 */
+				1800 0 0 1 7400 26 0
+				1800 0 0 2 7400 27 0
+				1800 0 0 3 7400 24 0
+				1800 0 0 4 7400 25 0
+
+				/* IDSEL 0x14 */
+				2000 0 0 1 7400 27 0
+				2000 0 0 2 7400 24 0
+				2000 0 0 3 7400 25 0
+				2000 0 0 4 7400 26 0
+				>;
+		};
+	};
+
+};
-- 
1.4.0

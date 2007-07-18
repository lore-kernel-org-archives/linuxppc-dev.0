Return-Path: <tie-fei.zang@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 80364DDE1F
	for <linuxppc-dev@ozlabs.org>; Wed, 18 Jul 2007 19:22:36 +1000 (EST)
Received: from az33smr02.freescale.net (az33smr02.freescale.net [10.64.34.200])
	by az33egw02.freescale.net (8.12.11/az33egw02) with ESMTP id
	l6I9MUfO012008
	for <linuxppc-dev@ozlabs.org>; Wed, 18 Jul 2007 02:22:30 -0700 (MST)
Received: from zch01exm23.fsl.freescale.net (zch01exm23.ap.freescale.net
	[10.192.129.207])
	by az33smr02.freescale.net (8.13.1/8.13.0) with ESMTP id l6I9MSSD005314
	for <linuxppc-dev@ozlabs.org>; Wed, 18 Jul 2007 04:22:29 -0500 (CDT)
Subject: [PATCH] Add 8548CDS with Arcadia 3.0 support
From: Zang Roy-r61911 <tie-fei.zang@freescale.com>
To: Kumar Gala <galak@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>
Content-Type: text/plain
Message-Id: <1184750539.27603.7.camel@localhost.localdomain>
Mime-Version: 1.0
Date: 18 Jul 2007 17:22:20 +0800
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Roy Zang <tie-fei.zang@freescale.com>

Add 8548CDS with Arcadia 3.0 support. Arcadia 3.0 has different
pci irq routing comparing with Arcadia 3.1.

Signed-off-by: Roy Zang <tie-fei.zang@freescale.com>
---
 arch/powerpc/boot/dts/mpc8548cds_legacy.dts |  327 +++++++++++++++++++++++++++
 1 files changed, 327 insertions(+), 0 deletions(-)
 create mode 100644 arch/powerpc/boot/dts/mpc8548cds_legacy.dts

diff --git a/arch/powerpc/boot/dts/mpc8548cds_legacy.dts b/arch/powerpc/boot/dts/mpc8548cds_legacy.dts
new file mode 100644
index 0000000..7d26cb2
--- /dev/null
+++ b/arch/powerpc/boot/dts/mpc8548cds_legacy.dts
@@ -0,0 +1,327 @@
+/*
+ * Copyright 2007 Freescale Semiconductor Inc.
+ *
+ * Author: Roy Zang tie-fei.zang@freescale.com Jan, 2007
+ *
+ * Description:
+ * MPC8548 CDS with Arcadia 3.0 Device Tree Source
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
+	compatible = "MPC8548CDS", "MPC85xxCDS";
+	#address-cells = <1>;
+	#size-cells = <1>;
+
+	cpus {
+		#address-cells = <1>;
+		#size-cells = <0>;
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
+		};
+	};
+
+	memory {
+		device_type = "memory";
+		reg = <00000000 08000000>;	// 128M at 0x0
+	};
+
+	soc8548@e0000000 {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		device_type = "soc";
+		ranges = <0 e0000000 00100000>;
+		reg = <e0000000 00100000>;	// CCSRBAR 1M
+		bus-frequency = <0>;
+
+		memory-controller@2000 {
+			compatible = "fsl,8548-memory-controller";
+			reg = <2000 1000>;
+			interrupt-parent = <&mpic>;
+			interrupts = <12 2>;
+		};
+
+		l2-cache-controller@20000 {
+			compatible = "fsl,8548-l2-cache-controller";
+			reg = <20000 1000>;
+			cache-line-size = <20>;	// 32 bytes
+			cache-size = <80000>;	// L2, 512K
+			interrupt-parent = <&mpic>;
+			interrupts = <10 2>;
+		};
+
+		i2c@3000 {
+			device_type = "i2c";
+			compatible = "fsl-i2c";
+			reg = <3000 100>;
+			interrupts = <2b 2>;
+			interrupt-parent = <&mpic>;
+			dfsrr;
+		};
+
+		mdio@24520 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			device_type = "mdio";
+			compatible = "gianfar";
+			reg = <24520 20>;
+			phy0: ethernet-phy@0 {
+				interrupt-parent = <&mpic>;
+				interrupts = <5 1>;
+				reg = <0>;
+				device_type = "ethernet-phy";
+			};
+			phy1: ethernet-phy@1 {
+				interrupt-parent = <&mpic>;
+				interrupts = <5 1>;
+				reg = <1>;
+				device_type = "ethernet-phy";
+			};
+			phy2: ethernet-phy@2 {
+				interrupt-parent = <&mpic>;
+				interrupts = <5 1>;
+				reg = <2>;
+				device_type = "ethernet-phy";
+			};
+			phy3: ethernet-phy@3 {
+				interrupt-parent = <&mpic>;
+				interrupts = <5 1>;
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
+			local-mac-address = [ 00 00 00 00 00 00 ];
+			interrupts = <1d 2 1e 2 22 2>;
+			interrupt-parent = <&mpic>;
+			phy-handle = <&phy0>;
+		};
+
+		ethernet@25000 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			device_type = "network";
+			model = "eTSEC";
+			compatible = "gianfar";
+			reg = <25000 1000>;
+			local-mac-address = [ 00 00 00 00 00 00 ];
+			interrupts = <23 2 24 2 28 2>;
+			interrupt-parent = <&mpic>;
+			phy-handle = <&phy1>;
+		};
+
+/* eTSEC 3/4 are currently broken
+		ethernet@26000 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			device_type = "network";
+			model = "eTSEC";
+			compatible = "gianfar";
+			reg = <26000 1000>;
+			local-mac-address = [ 00 00 00 00 00 00 ];
+			interrupts = <1f 2 20 2 21 2>;
+			interrupt-parent = <&mpic>;
+			phy-handle = <&phy2>;
+		};
+
+		ethernet@27000 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			device_type = "network";
+			model = "eTSEC";
+			compatible = "gianfar";
+			reg = <27000 1000>;
+			local-mac-address = [ 00 00 00 00 00 00 ];
+			interrupts = <25 2 26 2 27 2>;
+			interrupt-parent = <&mpic>;
+			phy-handle = <&phy3>;
+		};
+ */
+
+		serial@4500 {
+			device_type = "serial";
+			compatible = "ns16550";
+			reg = <4500 100>; 	// reg base, size
+			clock-frequency = <0>; 	// should we fill in in uboot?
+			interrupts = <2a 2>;
+			interrupt-parent = <&mpic>;
+		};
+
+		serial@4600 {
+			device_type = "serial";
+			compatible = "ns16550";
+			reg = <4600 100>;	// reg base, size
+			clock-frequency = <0>; 	// should we fill in in uboot?
+			interrupts = <2a 2>;
+			interrupt-parent = <&mpic>;
+		};
+
+		global-utilities@e0000 {	//global utilities reg
+			compatible = "fsl,mpc8548-guts";
+			reg = <e0000 1000>;
+			fsl,has-rstcr;
+		};
+
+		pci1: pci@8000 {
+			interrupt-map-mask = <f800 0 0 7>;
+			interrupt-map = <
+
+				/* IDSEL 0x2 (PCIX Tsi310 bridge) */
+				1000 0 0 1 &mpic 0 1
+				1000 0 0 2 &mpic 1 1
+				1000 0 0 3 &mpic 2 1
+				1000 0 0 4 &mpic 3 1
+				
+				/* IDSEL 0x3 (PCIX Slot 2) */
+				1800 0 0 1 &mpic 0 1
+				1800 0 0 2 &mpic 1 1
+				1800 0 0 3 &mpic 2 1
+				1800 0 0 4 &mpic 3 1
+
+				/* IDSEL 0x4 (PCIX Slot 3) */
+				2000 0 0 1 &mpic 0 1
+				2000 0 0 2 &mpic 1 1
+				2000 0 0 3 &mpic 2 1
+				2000 0 0 4 &mpic 3 1
+
+				/* IDSEL 0x5 (PCIX Slot 4) */
+				2800 0 0 1 &mpic 0 1
+				2800 0 0 2 &mpic 1 1
+				2800 0 0 3 &mpic 2 1
+				2800 0 0 4 &mpic 3 1
+
+				/* IDSEL 0x6 (PCIX Slot 5) */
+				3000 0 0 1 &mpic 0 1
+				3000 0 0 2 &mpic 1 1
+				3000 0 0 3 &mpic 2 1
+				3000 0 0 4 &mpic 3 1
+
+				/* IDSEL 0x12 (Tsi310 bridge) */
+				9000 0 0 1 &mpic 0 1
+				9000 0 0 2 &mpic 1 1
+				9000 0 0 3 &mpic 2 1
+				9000 0 0 4 &mpic 3 1
+				
+				/* IDSEL 0x13 (Slot 2) */
+				9800 0 0 1 &mpic 0 1
+				9800 0 0 2 &mpic 1 1
+				9800 0 0 3 &mpic 2 1
+				9800 0 0 4 &mpic 3 1
+
+				/* IDSEL 0x14 (Slot 3) */
+				a000 0 0 1 &mpic 0 1
+				a000 0 0 2 &mpic 1 1
+				a000 0 0 3 &mpic 2 1
+				a000 0 0 4 &mpic 3 1
+
+				/* IDSEL 0x15 (Slot 4) */
+				a800 0 0 1 &mpic 0 1
+				a800 0 0 2 &mpic 1 1
+				a800 0 0 3 &mpic 2 1
+				a800 0 0 4 &mpic 3 1
+
+				/* IDSEL 0x16 (Slot 5) */
+				b000 0 0 1 &mpic 0 1
+				b000 0 0 2 &mpic 1 1
+				b000 0 0 3 &mpic 2 1
+				b000 0 0 4 &mpic 3 1>
+				
+			interrupt-parent = <&mpic>;
+			interrupts = <18 2>;
+			bus-range = <0 0>;
+			ranges = <02000000 0 80000000 80000000 0 10000000
+				  01000000 0 00000000 e2000000 0 00800000>;
+			clock-frequency = <3f940aa>;
+			#interrupt-cells = <1>;
+			#size-cells = <2>;
+			#address-cells = <3>;
+			reg = <8000 1000>;
+			compatible = "fsl,mpc8540-pcix", "fsl,mpc8540-pci";
+			device_type = "pci";
+		};
+
+		pci@9000 {
+			interrupt-map-mask = <f800 0 0 7>;
+			interrupt-map = <
+
+				/* IDSEL 0x15 */
+				a800 0 0 1 &mpic b 1
+				a800 0 0 2 &mpic b 1
+				a800 0 0 3 &mpic b 1
+				a800 0 0 4 &mpic b 1>;
+
+			interrupt-parent = <&mpic>;
+			interrupts = <19 2>;
+			bus-range = <0 0>;
+			ranges = <02000000 0 90000000 90000000 0 10000000
+				  01000000 0 00000000 e2800000 0 00800000>;
+			clock-frequency = <3f940aa>;
+			#interrupt-cells = <1>;
+			#size-cells = <2>;
+			#address-cells = <3>;
+			reg = <9000 1000>;
+			compatible = "fsl,mpc8540-pci";
+			device_type = "pci";
+		};
+
+		/* PCI Express */
+		pcie@a000 {
+			interrupt-map-mask = <f800 0 0 7>;
+			interrupt-map = <
+
+				/* IDSEL 0x0 (PEX) */
+				0000 0 0 1 &mpic 0 1
+				0000 0 0 2 &mpic 1 1
+				0000 0 0 3 &mpic 2 1
+				0000 0 0 4 &mpic 3 1>;
+
+			interrupt-parent = <&mpic>;
+			interrupts = <1a 2>;
+			bus-range = <0 ff>;
+			ranges = <02000000 0 a0000000 a0000000 0 20000000
+				  01000000 0 00000000 e3000000 0 08000000>;
+			clock-frequency = <1fca055>;
+			#interrupt-cells = <1>;
+			#size-cells = <2>;
+			#address-cells = <3>;
+			reg = <a000 1000>;
+			compatible = "fsl,mpc8548-pcie";
+			device_type = "pci";
+		};
+
+		mpic: pic@40000 {
+			clock-frequency = <0>;
+			interrupt-controller;
+			#address-cells = <0>;
+			#interrupt-cells = <2>;
+			reg = <40000 40000>;
+			built-in;
+			compatible = "chrp,open-pic";
+			device_type = "open-pic";
+			big-endian;
+		};
+	};
+};
-- 
1.5.1

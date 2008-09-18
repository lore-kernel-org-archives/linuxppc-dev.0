Return-Path: <vgallardo@amcc.com>
Received: from sdcmail02.amcc.com (sdcmail02.amcc.com [198.137.200.73])
	(using TLSv1 with cipher RC4-SHA (128/128 bits))
	(Client CN "Messaging Gateway Appliance Demo Cert",
	Issuer "Messaging Gateway Appliance Demo Cert" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id 2905CDE130
	for <linuxppc-dev@ozlabs.org>; Fri, 19 Sep 2008 08:48:28 +1000 (EST)
From: Victor Gallardo <vgallardo@amcc.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH v2] Add AMCC Arches DTS
Date: Thu, 18 Sep 2008 15:48:24 -0700
Message-Id: <1221778104-6360-1-git-send-email-vgallardo@amcc.com>
Cc: fkan@amcc.com, Victor Gallardo <vgallardo@amcc.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Basic functionality for the AMCC Arches eval Board.

Signed-off-by: Victor Gallardo <vgallardo@amcc.com>
---
 v2:
 - only include basic functionality

 arch/powerpc/boot/dts/arches.dts |  273 ++++++++++++++++++++++++++++++++++++++
 1 files changed, 273 insertions(+), 0 deletions(-)
 create mode 100644 arch/powerpc/boot/dts/arches.dts

diff --git a/arch/powerpc/boot/dts/arches.dts b/arch/powerpc/boot/dts/arches.dts
new file mode 100644
index 0000000..1f90d70
--- /dev/null
+++ b/arch/powerpc/boot/dts/arches.dts
@@ -0,0 +1,273 @@
+/*
+ * Device Tree Source for AMCC Glacier (460GT)
+ *
+ * Copyright 2008 DENX Software Engineering, Stefan Roese <sr@denx.de>
+ *
+ * This file is licensed under the terms of the GNU General Public
+ * License version 2.  This program is licensed "as is" without
+ * any warranty of any kind, whether express or implied.
+ */
+
+/dts-v1/;
+
+/ {
+	#address-cells = <2>;
+	#size-cells = <1>;
+	model = "amcc,arches";
+	compatible = "amcc,arches", "amcc,canyonlands";
+	dcr-parent = <&{/cpus/cpu@0}>;
+
+	aliases {
+		ethernet0 = &EMAC0;
+		ethernet1 = &EMAC1;
+		ethernet2 = &EMAC2;
+		serial0 = &UART0;
+	};
+
+	cpus {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		cpu@0 {
+			device_type = "cpu";
+			model = "PowerPC,460GT";
+			reg = <0x00000000>;
+			clock-frequency = <0>; /* Filled in by U-Boot */
+			timebase-frequency = <0>; /* Filled in by U-Boot */
+			i-cache-line-size = <32>;
+			d-cache-line-size = <32>;
+			i-cache-size = <32768>;
+			d-cache-size = <32768>;
+			dcr-controller;
+			dcr-access-method = "native";
+		};
+	};
+
+	memory {
+		device_type = "memory";
+		reg = <0x00000000 0x00000000 0x00000000>; /* Filled in by U-Boot */
+	};
+
+	UIC0: interrupt-controller0 {
+		compatible = "ibm,uic-460gt","ibm,uic";
+		interrupt-controller;
+		cell-index = <0>;
+		dcr-reg = <0x0c0 0x009>;
+		#address-cells = <0>;
+		#size-cells = <0>;
+		#interrupt-cells = <2>;
+	};
+
+	UIC1: interrupt-controller1 {
+		compatible = "ibm,uic-460gt","ibm,uic";
+		interrupt-controller;
+		cell-index = <1>;
+		dcr-reg = <0x0d0 0x009>;
+		#address-cells = <0>;
+		#size-cells = <0>;
+		#interrupt-cells = <2>;
+		interrupts = <0x1e 0x4 0x1f 0x4>; /* cascade */
+		interrupt-parent = <&UIC0>;
+	};
+
+	UIC2: interrupt-controller2 {
+		compatible = "ibm,uic-460gt","ibm,uic";
+		interrupt-controller;
+		cell-index = <2>;
+		dcr-reg = <0x0e0 0x009>;
+		#address-cells = <0>;
+		#size-cells = <0>;
+		#interrupt-cells = <2>;
+		interrupts = <0xa 0x4 0xb 0x4>; /* cascade */
+		interrupt-parent = <&UIC0>;
+	};
+
+	UIC3: interrupt-controller3 {
+		compatible = "ibm,uic-460gt","ibm,uic";
+		interrupt-controller;
+		cell-index = <3>;
+		dcr-reg = <0x0f0 0x009>;
+		#address-cells = <0>;
+		#size-cells = <0>;
+		#interrupt-cells = <2>;
+		interrupts = <0x10 0x4 0x11 0x4>; /* cascade */
+		interrupt-parent = <&UIC0>;
+	};
+
+	SDR0: sdr {
+		compatible = "ibm,sdr-460gt";
+		dcr-reg = <0x00e 0x002>;
+	};
+
+	CPR0: cpr {
+		compatible = "ibm,cpr-460gt";
+		dcr-reg = <0x00c 0x002>;
+	};
+
+	plb {
+		compatible = "ibm,plb-460gt", "ibm,plb4";
+		#address-cells = <2>;
+		#size-cells = <1>;
+		ranges;
+		clock-frequency = <0>; /* Filled in by U-Boot */
+
+		SDRAM0: sdram {
+			compatible = "ibm,sdram-460gt", "ibm,sdram-405gp";
+			dcr-reg = <0x010 0x002>;
+		};
+
+		MAL0: mcmal {
+			compatible = "ibm,mcmal-460gt", "ibm,mcmal2";
+			dcr-reg = <0x180 0x062>;
+			num-tx-chans = <3>;
+			num-rx-chans = <24>;
+			#address-cells = <0>;
+			#size-cells = <0>;
+			interrupt-parent = <&UIC2>;
+			interrupts = <	/*TXEOB*/ 0x6 0x4
+					/*RXEOB*/ 0x7 0x4
+					/*SERR*/  0x3 0x4
+					/*TXDE*/  0x4 0x4
+					/*RXDE*/  0x5 0x4>;
+			desc-base-addr-high = <0x8>;
+		};
+
+		POB0: opb {
+			compatible = "ibm,opb-460gt", "ibm,opb";
+			#address-cells = <1>;
+			#size-cells = <1>;
+			ranges = <0xb0000000 0x00000004 0xb0000000 0x50000000>;
+			clock-frequency = <0>; /* Filled in by U-Boot */
+
+			EBC0: ebc {
+				compatible = "ibm,ebc-460gt", "ibm,ebc";
+				dcr-reg = <0x012 0x002>;
+				#address-cells = <2>;
+				#size-cells = <1>;
+				clock-frequency = <0>; /* Filled in by U-Boot */
+				/* ranges property is supplied by U-Boot */
+				interrupts = <0x6 0x4>;
+				interrupt-parent = <&UIC1>;
+			};
+
+			UART0: serial@ef600300 {
+				device_type = "serial";
+				compatible = "ns16550";
+				reg = <0xef600300 0x00000008>;
+				virtual-reg = <0xef600300>;
+				clock-frequency = <0>; /* Filled in by U-Boot */
+				current-speed = <0>; /* Filled in by U-Boot */
+				interrupt-parent = <&UIC1>;
+				interrupts = <0x1 0x4>;
+			};
+
+			IIC0: i2c@ef600700 {
+				compatible = "ibm,iic-460gt", "ibm,iic";
+				reg = <0xef600700 0x00000014>;
+				interrupt-parent = <&UIC0>;
+				interrupts = <0x2 0x4>;
+			};
+
+			IIC1: i2c@ef600800 {
+				compatible = "ibm,iic-460gt", "ibm,iic";
+				reg = <0xef600800 0x00000014>;
+				interrupt-parent = <&UIC0>;
+				interrupts = <0x3 0x4>;
+			};
+
+			TAH0: emac-tah@ef601350 {
+				compatible = "ibm,tah-460gt", "ibm,tah";
+				reg = <0xef601350 0x00000030>;
+			};
+
+			TAH1: emac-tah@ef601450 {
+				compatible = "ibm,tah-460gt", "ibm,tah";
+				reg = <0xef601450 0x00000030>;
+			};
+
+			EMAC0: ethernet@ef600e00 {
+				device_type = "network";
+				compatible = "ibm,emac-460gt", "ibm,emac4sync";
+				interrupt-parent = <&EMAC0>;
+				interrupts = <0x0 0x1>;
+				#interrupt-cells = <1>;
+				#address-cells = <0>;
+				#size-cells = <0>;
+				interrupt-map = </*Status*/ 0x0 &UIC2 0x10 0x4
+						 /*Wake*/   0x1 &UIC2 0x14 0x4>;
+				reg = <0xef600e00 0x000000c4>;
+				local-mac-address = [000000000000]; /* Filled in by U-Boot */
+				mal-device = <&MAL0>;
+				mal-tx-channel = <0>;
+				mal-rx-channel = <0>;
+				cell-index = <0>;
+				max-frame-size = <9000>;
+				rx-fifo-size = <4096>;
+				tx-fifo-size = <2048>;
+				phy-mode = "sgmii";
+				phy-map = <0xffffffff>;
+				gpcs-address = <0x0000000a>;
+				tah-device = <&TAH0>;
+				tah-channel = <0>;
+				has-inverted-stacr-oc;
+				has-new-stacr-staopc;
+			};
+
+			EMAC1: ethernet@ef600f00 {
+				device_type = "network";
+				compatible = "ibm,emac-460gt", "ibm,emac4sync";
+				interrupt-parent = <&EMAC1>;
+				interrupts = <0x0 0x1>;
+				#interrupt-cells = <1>;
+				#address-cells = <0>;
+				#size-cells = <0>;
+				interrupt-map = </*Status*/ 0x0 &UIC2 0x11 0x4
+						 /*Wake*/   0x1 &UIC2 0x15 0x4>;
+				reg = <0xef600f00 0x000000c4>;
+				local-mac-address = [000000000000]; /* Filled in by U-Boot */
+				mal-device = <&MAL0>;
+				mal-tx-channel = <1>;
+				mal-rx-channel = <8>;
+				cell-index = <1>;
+				max-frame-size = <9000>;
+				rx-fifo-size = <4096>;
+				tx-fifo-size = <2048>;
+				phy-mode = "sgmii";
+				phy-map = <0x00000000>;
+				gpcs-address = <0x0000000b>;
+				tah-device = <&TAH1>;
+				tah-channel = <1>;
+				has-inverted-stacr-oc;
+				has-new-stacr-staopc;
+				mdio-device = <&EMAC0>;
+			};
+
+			EMAC2: ethernet@ef601100 {
+				device_type = "network";
+				compatible = "ibm,emac-460gt", "ibm,emac4sync";
+				interrupt-parent = <&EMAC2>;
+				interrupts = <0x0 0x1>;
+				#interrupt-cells = <1>;
+				#address-cells = <0>;
+				#size-cells = <0>;
+				interrupt-map = </*Status*/ 0x0 &UIC2 0x12 0x4
+						 /*Wake*/   0x1 &UIC2 0x16 0x4>;
+				reg = <0xef601100 0x000000c4>;
+				local-mac-address = [000000000000]; /* Filled in by U-Boot */
+				mal-device = <&MAL0>;
+				mal-tx-channel = <2>;
+				mal-rx-channel = <16>;
+				cell-index = <2>;
+				max-frame-size = <9000>;
+				rx-fifo-size = <4096>;
+				tx-fifo-size = <2048>;
+				phy-mode = "sgmii";
+				phy-map = <0x00000001>;
+				gpcs-address = <0x0000000C>;
+				has-inverted-stacr-oc;
+				has-new-stacr-staopc;
+				mdio-device = <&EMAC0>;
+			};
+		};
+	};
+};
-- 
1.5.5

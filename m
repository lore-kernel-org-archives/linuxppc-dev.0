Return-Path: <paul.gortmaker@windriver.com>
Received: from mail.wrs.com (mail.windriver.com [147.11.1.11])
	by ozlabs.org (Postfix) with ESMTP id 987AADDD0B
	for <linuxppc-dev@ozlabs.org>; Mon, 28 Jan 2008 18:28:08 +1100 (EST)
From: Paul Gortmaker <paul.gortmaker@windriver.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 7/9] 8349mitx: Convert mpc8349e-mitx to dts-v1 format.
Date: Mon, 28 Jan 2008 02:27:57 -0500
Message-Id: <fd274c4f37b24513b4bf8a69d79dbe1b6dea7082.1201503958.git.paul.gortmaker@windriver.com>
In-Reply-To: <53bbf9975296ba5dc57c68305079dc90d8d8a348.1201503958.git.paul.gortmaker@windriver.com>
References: <1201505279-25847-1-git-send-email-paul.gortmaker@windriver.com>
	<a050480a21aef92854805e9bee517c0d65d5bd59.1201503958.git.paul.gortmaker@windriver.com>
	<51b1015cd61540df832ee5d5ee125e7326c3f0ed.1201503958.git.paul.gortmaker@windriver.com>
	<d8e187e4d4aa981109450f333658730e3408f627.1201503958.git.paul.gortmaker@windriver.com>
	<1d2d2df57a47cff00d8539194b0c997175d18170.1201503958.git.paul.gortmaker@windriver.com>
	<fa3dbfb49842f4553d619b1cf209102ca2457d62.1201503958.git.paul.gortmaker@windriver.com>
	<53bbf9975296ba5dc57c68305079dc90d8d8a348.1201503958.git.paul.gortmaker@windriver.com>
In-Reply-To: <a050480a21aef92854805e9bee517c0d65d5bd59.1201503958.git.paul.gortmaker@windriver.com>
References: <a050480a21aef92854805e9bee517c0d65d5bd59.1201503958.git.paul.gortmaker@windriver.com>
Cc: Paul Gortmaker <paul.gortmaker@windriver.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Convert the MPC8349 MITX dts file to v1 format.  Entries for
values normally parsed by humans are left in decimal (i.e. IRQ,
cache size, clock rates, basic counts and index values).

Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
---
 arch/powerpc/boot/dts/mpc8349emitx.dts |  153 ++++++++++++++++----------------
 1 files changed, 78 insertions(+), 75 deletions(-)

diff --git a/arch/powerpc/boot/dts/mpc8349emitx.dts b/arch/powerpc/boot/dts/mpc8349emitx.dts
index 04b8da4..6467ae5 100644
--- a/arch/powerpc/boot/dts/mpc8349emitx.dts
+++ b/arch/powerpc/boot/dts/mpc8349emitx.dts
@@ -8,6 +8,9 @@
  * Free Software Foundation; either version 2 of the License, or (at your
  * option) any later version.
  */
+
+/dts-v1/;
+
 / {
 	model = "MPC8349EMITX";
 	compatible = "MPC8349EMITX", "MPC834xMITX", "MPC83xxMITX";
@@ -30,10 +33,10 @@
 		PowerPC,8349@0 {
 			device_type = "cpu";
 			reg = <0>;
-			d-cache-line-size = <20>;
-			i-cache-line-size = <20>;
-			d-cache-size = <8000>;
-			i-cache-size = <8000>;
+			d-cache-line-size = <32>;
+			i-cache-line-size = <32>;
+			d-cache-size = <32768>;
+			i-cache-size = <32768>;
 			timebase-frequency = <0>;	// from bootloader
 			bus-frequency = <0>;		// from bootloader
 			clock-frequency = <0>;		// from bootloader
@@ -42,21 +45,21 @@
 
 	memory {
 		device_type = "memory";
-		reg = <00000000 10000000>;
+		reg = <0x00000000 0x10000000>;
 	};
 
 	soc8349@e0000000 {
 		#address-cells = <1>;
 		#size-cells = <1>;
 		device_type = "soc";
-		ranges = <0 e0000000 00100000>;
-		reg = <e0000000 00000200>;
+		ranges = <0x0 0xe0000000 0x00100000>;
+		reg = <0xe0000000 0x00000200>;
 		bus-frequency = <0>;                    // from bootloader
 
 		wdt@200 {
 			device_type = "watchdog";
 			compatible = "mpc83xx_wdt";
-			reg = <200 100>;
+			reg = <0x200 0x100>;
 		};
 
 		i2c@3000 {
@@ -64,9 +67,9 @@
 			#size-cells = <0>;
 			cell-index = <0>;
 			compatible = "fsl-i2c";
-			reg = <3000 100>;
-			interrupts = <e 8>;
-			interrupt-parent = < &ipic >;
+			reg = <0x3000 0x100>;
+			interrupts = <14 0x8>;
+			interrupt-parent = <&ipic>;
 			dfsrr;
 		};
 
@@ -75,39 +78,39 @@
 			#size-cells = <0>;
 			cell-index = <1>;
 			compatible = "fsl-i2c";
-			reg = <3100 100>;
-			interrupts = <f 8>;
-			interrupt-parent = < &ipic >;
+			reg = <0x3100 0x100>;
+			interrupts = <15 0x8>;
+			interrupt-parent = <&ipic>;
 			dfsrr;
 		};
 
 		spi@7000 {
 			device_type = "spi";
 			compatible = "fsl_spi";
-			reg = <7000 1000>;
-			interrupts = <10 8>;
-			interrupt-parent = < &ipic >;
+			reg = <0x7000 0x1000>;
+			interrupts = <16 0x8>;
+			interrupt-parent = <&ipic>;
 			mode = "cpu";
 		};
 
 		usb@22000 {
 			compatible = "fsl-usb2-mph";
-			reg = <22000 1000>;
+			reg = <0x22000 0x1000>;
 			#address-cells = <1>;
 			#size-cells = <0>;
-			interrupt-parent = < &ipic >;
-			interrupts = <27 8>;
+			interrupt-parent = <&ipic>;
+			interrupts = <39 0x8>;
 			phy_type = "ulpi";
 			port1;
 		};
 
 		usb@23000 {
 			compatible = "fsl-usb2-dr";
-			reg = <23000 1000>;
+			reg = <0x23000 0x1000>;
 			#address-cells = <1>;
 			#size-cells = <0>;
-			interrupt-parent = < &ipic >;
-			interrupts = <26 8>;
+			interrupt-parent = <&ipic>;
+			interrupts = <38 0x8>;
 			dr_mode = "peripheral";
 			phy_type = "ulpi";
 		};
@@ -116,13 +119,13 @@
 			#address-cells = <1>;
 			#size-cells = <0>;
 			compatible = "fsl,gianfar-mdio";
-			reg = <24520 20>;
+			reg = <0x24520 0x20>;
 
 			/* Vitesse 8201 */
 			phy1c: ethernet-phy@1c {
-				interrupt-parent = < &ipic >;
-				interrupts = <12 8>;
-				reg = <1c>;
+				interrupt-parent = <&ipic>;
+				interrupts = <18 0x8>;
+				reg = <0x1c>;
 				device_type = "ethernet-phy";
 			};
 		};
@@ -132,11 +135,11 @@
 			device_type = "network";
 			model = "TSEC";
 			compatible = "gianfar";
-			reg = <24000 1000>;
+			reg = <0x24000 0x1000>;
 			local-mac-address = [ 00 00 00 00 00 00 ];
-			interrupts = <20 8 21 8 22 8>;
-			interrupt-parent = < &ipic >;
-			phy-handle = < &phy1c >;
+			interrupts = <32 0x8 33 0x8 34 0x8>;
+			interrupt-parent = <&ipic>;
+			phy-handle = <&phy1c>;
 			linux,network-index = <0>;
 		};
 
@@ -145,12 +148,12 @@
 			device_type = "network";
 			model = "TSEC";
 			compatible = "gianfar";
-			reg = <25000 1000>;
+			reg = <0x25000 0x1000>;
 			local-mac-address = [ 00 00 00 00 00 00 ];
-			interrupts = <23 8 24 8 25 8>;
-			interrupt-parent = < &ipic >;
+			interrupts = <35 0x8 36 0x8 37 0x8>;
+			interrupt-parent = <&ipic>;
 			/* Vitesse 7385 isn't on the MDIO bus */
-			fixed-link = <1 1 d#1000 0 0>;
+			fixed-link = <1 1 1000 0 0>;
 			linux,network-index = <1>;
 		};
 
@@ -158,88 +161,88 @@
 			cell-index = <0>;
 			device_type = "serial";
 			compatible = "ns16550";
-			reg = <4500 100>;
+			reg = <0x4500 0x100>;
 			clock-frequency = <0>;		// from bootloader
-			interrupts = <9 8>;
-			interrupt-parent = < &ipic >;
+			interrupts = <9 0x8>;
+			interrupt-parent = <&ipic>;
 		};
 
 		serial1: serial@4600 {
 			cell-index = <1>;
 			device_type = "serial";
 			compatible = "ns16550";
-			reg = <4600 100>;
+			reg = <0x4600 0x100>;
 			clock-frequency = <0>;		// from bootloader
-			interrupts = <a 8>;
-			interrupt-parent = < &ipic >;
+			interrupts = <10 0x8>;
+			interrupt-parent = <&ipic>;
 		};
 
 		crypto@30000 {
 			device_type = "crypto";
 			model = "SEC2";
 			compatible = "talitos";
-			reg = <30000 10000>;
-			interrupts = <b 8>;
-			interrupt-parent = < &ipic >;
+			reg = <0x30000 0x10000>;
+			interrupts = <11 0x8>;
+			interrupt-parent = <&ipic>;
 			num-channels = <4>;
-			channel-fifo-len = <18>;
-			exec-units-mask = <0000007e>;
-			descriptor-types-mask = <01010ebf>;
+			channel-fifo-len = <0x18>;
+			exec-units-mask = <0x0000007e>;
+			descriptor-types-mask = <0x01010ebf>;
 		};
 
 		ipic: pic@700 {
 			interrupt-controller;
 			#address-cells = <0>;
 			#interrupt-cells = <2>;
-			reg = <700 100>;
+			reg = <0x700 0x100>;
 			device_type = "ipic";
 		};
 	};
 
 	pci0: pci@e0008500 {
 		cell-index = <1>;
-		interrupt-map-mask = <f800 0 0 7>;
+		interrupt-map-mask = <0xf800 0x0 0x0 0x7>;
 		interrupt-map = <
 				/* IDSEL 0x10 - SATA */
-				8000 0 0 1 &ipic 16 8 /* SATA_INTA */
+				0x8000 0x0 0x0 0x1 &ipic 22 0x8 /* SATA_INTA */
 				>;
-		interrupt-parent = < &ipic >;
-		interrupts = <42 8>;
-		bus-range = <0 0>;
-		ranges = <42000000 0 80000000 80000000 0 10000000
-			  02000000 0 90000000 90000000 0 10000000
-			  01000000 0 00000000 e2000000 0 01000000>;
-		clock-frequency = <3f940aa>;
+		interrupt-parent = <&ipic>;
+		interrupts = <66 0x8>;
+		bus-range = <0x0 0x0>;
+		ranges = <0x42000000 0x0 0x80000000 0x80000000 0x0 0x10000000
+			  0x02000000 0x0 0x90000000 0x90000000 0x0 0x10000000
+			  0x01000000 0x0 0x00000000 0xe2000000 0x0 0x01000000>;
+		clock-frequency = <66666666>;
 		#interrupt-cells = <1>;
 		#size-cells = <2>;
 		#address-cells = <3>;
-		reg = <e0008500 100>;
+		reg = <0xe0008500 0x100>;
 		compatible = "fsl,mpc8349-pci";
 		device_type = "pci";
 	};
 
 	pci1: pci@e0008600 {
 		cell-index = <2>;
-		interrupt-map-mask = <f800 0 0 7>;
+		interrupt-map-mask = <0xf800 0x0 0x0 0x7>;
 		interrupt-map = <
 				/* IDSEL 0x0E - MiniPCI Slot */
-				7000 0 0 1 &ipic 15 8 /* PCI_INTA */
+				0x7000 0x0 0x0 0x1 &ipic 21 0x8 /* PCI_INTA */
 
 				/* IDSEL 0x0F - PCI Slot */
-				7800 0 0 1 &ipic 14 8 /* PCI_INTA */
-				7800 0 0 2 &ipic 15 8 /* PCI_INTB */
-				 >;
-		interrupt-parent = < &ipic >;
-		interrupts = <43 8>;
-		bus-range = <0 0>;
-		ranges = <42000000 0 a0000000 a0000000 0 10000000
-			  02000000 0 b0000000 b0000000 0 10000000
-			  01000000 0 00000000 e3000000 0 01000000>;
-		clock-frequency = <3f940aa>;
+				0x7800 0x0 0x0 0x1 &ipic 20 0x8 /* PCI_INTA */
+				0x7800 0x0 0x0 0x2 &ipic 21 0x8 /* PCI_INTB */
+				>;
+		interrupt-parent = <&ipic>;
+		interrupts = <67 0x8>;
+		bus-range = <0x0 0x0>;
+		ranges = <0x42000000 0x0 0xa0000000 0xa0000000 0x0 0x10000000
+			  0x02000000 0x0 0xb0000000 0xb0000000 0x0 0x10000000
+			  0x01000000 0x0 0x00000000 0xe3000000 0x0 0x01000000>;
+		clock-frequency = <66666666>;
 		#interrupt-cells = <1>;
 		#size-cells = <2>;
 		#address-cells = <3>;
-		reg = <e0008600 100>;
+		reg = <0xe0008600 0x100>;
 		compatible = "fsl,mpc8349-pci";
 		device_type = "pci";
 	};
@@ -249,15 +252,15 @@
 		#size-cells = <1>;
 		compatible = "fsl,mpc8349e-localbus",
 			     "fsl,pq2pro-localbus";
-		reg = <e0005000 d8>;
-		ranges = <3 0 f0000000 210>;
+		reg = <0xe0005000 0xd8>;
+		ranges = <0x3 0x0 0xf0000000 0x210>;
 
 		pata@3,0 {
 			compatible = "fsl,mpc8349emitx-pata", "ata-generic";
-			reg = <3 0 10 3 20c 4>;
+			reg = <0x3 0x0 0x10 0x3 0x20c 0x4>;
 			reg-shift = <1>;
 			pio-mode = <6>;
-			interrupts = <17 8>;
+			interrupts = <23 0x8>;
 			interrupt-parent = <&ipic>;
 		};
 	};
-- 
1.5.4.rc4.gcab31

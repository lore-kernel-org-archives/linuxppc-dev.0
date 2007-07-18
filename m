Return-Path: <b07421@freescale.com>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 50B7DDF002
	for <linuxppc-dev@ozlabs.org>; Wed, 18 Jul 2007 11:35:58 +1000 (EST)
Received: from de01smr01.freescale.net (de01smr01.freescale.net [10.208.0.31])
	by de01egw01.freescale.net (8.12.11/de01egw01) with ESMTP id
	l6I1ZpO7027664
	for <linuxppc-dev@ozlabs.org>; Tue, 17 Jul 2007 18:35:51 -0700 (MST)
Received: from mailserv2.am.freescale.net (mailserv2.am.freescale.net
	[10.83.16.18])
	by de01smr01.freescale.net (8.13.1/8.13.0) with ESMTP id l6I1ZoRq001539
	for <linuxppc-dev@ozlabs.org>; Tue, 17 Jul 2007 20:35:51 -0500 (CDT)
Received: from ld0162-tx32.am.freescale.net (ld0162-tx32 [10.82.19.112])
	by mailserv2.am.freescale.net (8.13.3/8.13.3) with ESMTP id
	l6I1BAh9007947
	for <linuxppc-dev@ozlabs.org>; Tue, 17 Jul 2007 20:11:10 -0500 (CDT)
Received: from ld0162-tx32.am.freescale.net (localhost [127.0.0.1])
	by ld0162-tx32.am.freescale.net (Postfix) with ESMTP id 273C7AEFC9
	for <linuxppc-dev@ozlabs.org>; Tue, 17 Jul 2007 20:35:50 -0500 (CDT)
Received: (from b07421@localhost)
	by ld0162-tx32.am.freescale.net (8.12.11/8.12.11/Submit) id
	l6I1Zonv015412
	for linuxppc-dev@ozlabs.org; Tue, 17 Jul 2007 20:35:50 -0500
Date: Tue, 17 Jul 2007 20:35:50 -0500
From: Scott Wood <scottwood@freescale.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 38/61] cpm2: Update device trees.
Message-ID: <20070718013549.GJ15238@ld0162-tx32.am.freescale.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070718013137.GA15217@ld0162-tx32.am.freescale.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

The mpc8272ads device tree is thoroughly reworked, including new CPM2 bindings.
The mpc8560ads tree has the CPM portions updated.

Signed-off-by: Scott Wood <scottwood@freescale.com>
---
 arch/powerpc/boot/dts/mpc8272ads.dts |  295 +++++++++++++++++++---------------
 arch/powerpc/boot/dts/mpc8560ads.dts |   70 +++++----
 2 files changed, 206 insertions(+), 159 deletions(-)

diff --git a/arch/powerpc/boot/dts/mpc8272ads.dts b/arch/powerpc/boot/dts/mpc8272ads.dts
index ae52ada..708736b 100644
--- a/arch/powerpc/boot/dts/mpc8272ads.dts
+++ b/arch/powerpc/boot/dts/mpc8272ads.dts
@@ -22,179 +22,213 @@
 		PowerPC,8272@0 {
 			device_type = "cpu";
 			reg = <0>;
-			d-cache-line-size = <20>;       // 32 bytes
-			i-cache-line-size = <20>;       // 32 bytes
-			d-cache-size = <4000>;          // L1, 16K
-			i-cache-size = <4000>;          // L1, 16K
+			d-cache-line-size = <d#32>;
+			i-cache-line-size = <d#32>;
+			d-cache-size = <d#16384>;
+			i-cache-size = <d#16384>;
 			timebase-frequency = <0>;
 			bus-frequency = <0>;
 			clock-frequency = <0>;
-			32-bit;
 		};
 	};
 
-	pci_pic: interrupt-controller@f8200000 {
-		#address-cells = <0>;
-		#interrupt-cells = <2>;
-		interrupt-controller;
-		reg = <f8200000 f8200004>;
-		built-in;
-		device_type = "pci-pic";
+	CS: chipselect {
+		compatible = "fsl,mpc8272ads-chipselect",
+		             "fsl,mpc8272-chipselect",
+		             "fsl,pq2-chipselect";
+		#address-cells = <2>;
+		#size-cells = <1>;
+		fsl,ctrl = <&CSCTRL>;
+
+		ranges = <0 0 fe000000 02000000
+		          1 0 f4500000 00008000
+		          3 0 f8200000 00008000>;
+
+		flash@0 {
+			device_type = "rom";
+			compatible = "direct-mapped";
+			reg = <0 0 2000000>;
+			probe-type = "CFI";
+			bank-width = "4";
+		};
+
+		bcsr@1 {
+			reg = <1 0 20>;
+			compatible = "fsl,mpc8272ads-bcsr";
+		};
+
+		PCI_PIC: interrupt-controller@f8200000 {
+			compatible = "fsl,mpc8272ads-pci-pic",
+			             "fsl,pq2ads-pci-pic";
+			#interrupt-cells = <1>;
+			interrupt-controller;
+			reg = <3 0 8>;
+			interrupt-parent = <&PIC>;
+			interrupts = <14 8>;
+		};
 	};
 
 	memory {
 		device_type = "memory";
-		reg = <00000000 4000000 f4500000 00000020>;
+		reg = <0 0>;
 	};
 
-	chosen {
-		name = "chosen";
-		linux,platform = <0>;
-		interrupt-controller = <&Cpm_pic>;
-	};
-
-	soc8272@f0000000 {
+	soc@f0000000 {
 		#address-cells = <1>;
 		#size-cells = <1>;
-		#interrupt-cells = <2>;
 		device_type = "soc";
+		compatible = "fsl,mpc8272", "fsl,pq2-soc";
 		ranges = <00000000 f0000000 00053000>;
 		reg = <f0000000 10000>;
 
-		mdio@0 {
-			device_type = "mdio";
-			compatible = "fs_enet";
-			reg = <0 0>;
-			#address-cells = <1>;
-			#size-cells = <0>;
-
-			phy0:ethernet-phy@0 {
-				interrupt-parent = <&Cpm_pic>;
-				interrupts = <17 4>;
-				reg = <0>;
-				bitbang = [ 12 12 13 02 02 01 ];
-				device_type = "ethernet-phy";
-			};
-
-			phy1:ethernet-phy@1 {
-				interrupt-parent = <&Cpm_pic>;
-				interrupts = <17 4>;
-				bitbang = [ 12 12 13 02 02 01 ];
-				reg = <3>;
-				device_type = "ethernet-phy";
-			};
+		CSCTRL: chipselect@10100 {
+			compatible = "fsl,mpc8272-chipset-ctrl",
+			             "fsl,pq2-chipselect-ctrl";
+			reg = <10100 40>;
+			fsl,bus = <&CS>;
 		};
 
-		ethernet@24000 {
-			#address-cells = <1>;
-			#size-cells = <0>;
-			device_type = "network";
-			device-id = <1>;
-			compatible = "fs_enet";
-			model = "FCC";
-			reg = <11300 20 8400 100 11380 30>;
-			mac-address = [ 00 11 2F 99 43 54 ];
-			interrupts = <20 2>;
-			interrupt-parent = <&Cpm_pic>;
-			phy-handle = <&Phy0>;
-			rx-clock = <13>;
-			tx-clock = <12>;
-		};
-
-		ethernet@25000 {
-			device_type = "network";
-			device-id = <2>;
-			compatible = "fs_enet";
-			model = "FCC";
-			reg = <11320 20 8500 100 113b0 30>;
-			mac-address = [ 00 11 2F 99 44 54 ];
-			interrupts = <21 2>;
-			interrupt-parent = <&Cpm_pic>;
-			phy-handle = <&Phy1>;
-			rx-clock = <17>;
-			tx-clock = <18>;
-		};
-
-		cpm@f0000000 {
+		cpm@119c0 {
 			#address-cells = <1>;
 			#size-cells = <1>;
-			#interrupt-cells = <2>;
 			compatible = "fsl,mpc8272-cpm", "fsl,cpm2", "fsl,cpm";
-			ranges = <00000000 00000000 20000>;
-			reg = <0 20000>;
-			command-proc = <119c0>;
-			fsl,brg-frequency = <d#25000000>;
-			cpm_clk = <BEBC200>;
+			fsl,brg-frequency = <0>;
+			reg = <119c0 30 0 2000>;
+			ranges;
+
+			brg@119f0 {
+				compatible = "fsl,mpc8272-brg",
+				             "fsl,cpm2-brg",
+				             "fsl,cpm-brg";
+				reg = <119f0 10 115f0 10>;
+			};
 
-			scc@11a00 {
+			serial@11a00 {
 				device_type = "serial";
-				compatible = "cpm_uart";
-				model = "SCC";
-				device-id = <1>;
+				compatible = "fsl,mpc8272-scc-uart",
+				             "fsl,cpm2-scc-uart",
+				             "fsl,cpm2-uart",
+				             "fsl,cpm-scc-uart",
+				             "fsl,cpm-uart";
 				reg = <11a00 20 8000 100>;
-				current-speed = <1c200>;
-				interrupts = <28 2>;
-				interrupt-parent = <&Cpm_pic>;
-				clock-setup = <0 00ffffff>;
-				rx-clock = <1>;
-				tx-clock = <1>;
+				interrupts = <28 8>;
+				interrupt-parent = <&PIC>;
+				fsl,cpm-brg = <1>;
+				fsl,cpm-command = <00800000>;
 			};
 
-			scc@11a60 {
+			serial@11a60 {
 				device_type = "serial";
-				compatible = "cpm_uart";
-				model = "SCC";
-				device-id = <4>;
+				compatible = "fsl,mpc8272-scc-uart",
+				             "fsl,cpm2-scc-uart",
+				             "fsl,cpm2-uart",
+				             "fsl,cpm-scc-uart",
+				             "fsl,cpm-uart";
 				reg = <11a60 20 8300 100>;
-				current-speed = <1c200>;
-				interrupts = <2b 2>;
-				interrupt-parent = <&Cpm_pic>;
-				clock-setup = <1b ffffff00>;
-				rx-clock = <4>;
-				tx-clock = <4>;
+				interrupts = <2b 8>;
+				interrupt-parent = <&PIC>;
+				fsl,cpm-brg = <4>;
+				fsl,cpm-command = <0ce00000>;
+			};
+
+			mdio@10d40 {
+				device_type = "mdio";
+				compatible = "fsl,mpc8272ads-mdio-bitbang",
+				             "fsl,mpc8272-mdio-bitbang",
+				             "fsl,cpm2-mdio-bitbang";
+				reg = <10d40 14>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+				fsl,mdio-pin = <12>;
+				fsl,mdc-pin = <13>;
+
+				PHY0: ethernet-phy@0 {
+					interrupt-parent = <&PIC>;
+					interrupts = <17 8>;
+					reg = <0>;
+					device_type = "ethernet-phy";
+				};
+
+				PHY1: ethernet-phy@1 {
+					interrupt-parent = <&PIC>;
+					interrupts = <17 8>;
+					reg = <3>;
+					device_type = "ethernet-phy";
+				};
+			};
+
+			ethernet@24000 {
+				device_type = "network";
+				compatible = "fsl,mpc8272-fcc-enet",
+				             "fsl,cpm2-fcc-enet",
+				             "fsl,cpm2-enet",
+				             "fsl,cpm-fcc-enet",
+				             "fsl,cpm-enet";
+				reg = <11300 20 8400 100 11380 30>;
+				local-mac-address = [ 00 00 00 00 00 00 ];
+				interrupts = <20 8>;
+				interrupt-parent = <&PIC>;
+				phy-handle = <&PHY0>;
+				linux,network-index = <0>;
+				fsl,cpm-command = <12000300>;
+			};
+
+			ethernet@25000 {
+				device_type = "network";
+				compatible = "fsl,mpc8272-fcc-enet",
+				             "fsl,cpm2-fcc-enet",
+				             "fsl,cpm2-enet",
+				             "fsl,cpm-fcc-enet",
+				             "fsl,cpm-enet";
+				reg = <11320 20 8500 100 113b0 30>;
+				local-mac-address = [ 00 00 00 00 00 00 ];
+				interrupts = <21 8>;
+				interrupt-parent = <&PIC>;
+				phy-handle = <&PHY1>;
+				linux,network-index = <1>;
+				fsl,cpm-command = <16200300>;
 			};
 		};
 
-		cpm_pic:interrupt-controller@10c00 {
-			#address-cells = <0>;
+		PIC: interrupt-controller@10c00 {
 			#interrupt-cells = <2>;
 			interrupt-controller;
 			reg = <10c00 80>;
-			built-in;
-			compatible = "fsl,pq2-pic";
+			compatible = "fsl,mpc8272-pic", "fsl,pq2-pic";
 		};
 
-		pci@0500 {
+		pci@10800 {
 			#interrupt-cells = <1>;
 			#size-cells = <2>;
 			#address-cells = <3>;
-			compatible = "8272";
+			compatible = "fsl,mpc8272-pci", "fsl,pq2-pci";
 			device_type = "pci";
-			reg = <10430 4dc>;
-			clock-frequency = <3f940aa>;
+			reg = <10800 10c 101ac 8 101c4 8>;
+			clock-frequency = <d#66666666>;
 			interrupt-map-mask = <f800 0 0 7>;
 			interrupt-map = <
 			                /* IDSEL 0x16 */
-			                 b000 0 0 1 f8200000 40 8
-			                 b000 0 0 2 f8200000 41 8
-			                 b000 0 0 3 f8200000 42 8
-			                 b000 0 0 4 f8200000 43 8
+			                 b000 0 0 1 &PCI_PIC 0
+			                 b000 0 0 2 &PCI_PIC 1
+			                 b000 0 0 3 &PCI_PIC 2
+			                 b000 0 0 4 &PCI_PIC 3
 
 			                /* IDSEL 0x17 */
-			                 b800 0 0 1 f8200000 43 8
-			                 b800 0 0 2 f8200000 40 8
-			                 b800 0 0 3 f8200000 41 8
-			                 b800 0 0 4 f8200000 42 8
+			                 b800 0 0 1 &PCI_PIC 4
+			                 b800 0 0 2 &PCI_PIC 5
+			                 b800 0 0 3 &PCI_PIC 6
+			                 b800 0 0 4 &PCI_PIC 7
 
 			                /* IDSEL 0x18 */
-			                 c000 0 0 1 f8200000 42 8
-			                 c000 0 0 2 f8200000 43 8
-			                 c000 0 0 3 f8200000 40 8
-			                 c000 0 0 4 f8200000 41 8>;
-			interrupt-parent = <&Cpm_pic>;
-			interrupts = <14 8>;
-			bus-range = <0 0>;
-			ranges = <02000000 0 80000000 80000000 0 40000000
+			                 c000 0 0 1 &PCI_PIC 8
+			                 c000 0 0 2 &PCI_PIC 9
+			                 c000 0 0 3 &PCI_PIC a
+			                 c000 0 0 4 &PCI_PIC b>;
+
+			interrupt-parent = <&PIC>;
+			interrupts = <12 8>;
+			ranges = <42000000 0 80000000 80000000 0 20000000
+			          02000000 0 a0000000 a0000000 0 20000000
 			          01000000 0 00000000 f6000000 0 02000000>;
 		};
 
@@ -202,10 +236,13 @@
 		crypto@30000 {
 			device_type = "crypto";
 			model = "SEC2";
-			compatible = "talitos";
+			compatible = "fsl,mpc8272-talitos-sec2",
+			             "fsl,talitos-sec2",
+			             "fsl,talitos",
+			             "talitos";
 			reg = <30000 10000>;
-			interrupts = <b 2>;
-			interrupt-parent = <&Cpm_pic>;
+			interrupts = <b 8>;
+			interrupt-parent = <&PIC>;
 			num-channels = <4>;
 			channel-fifo-len = <18>;
 			exec-units-mask = <0000007e>;
@@ -213,4 +250,8 @@
 			descriptor-types-mask = <01010ebf>;
 		};
 	};
+
+	chosen {
+		linux,stdout-path = "/soc/cpm/serial@11a00";
+	};
 };
diff --git a/arch/powerpc/boot/dts/mpc8560ads.dts b/arch/powerpc/boot/dts/mpc8560ads.dts
index 847a095..9a52257 100644
--- a/arch/powerpc/boot/dts/mpc8560ads.dts
+++ b/arch/powerpc/boot/dts/mpc8560ads.dts
@@ -237,10 +237,16 @@
 			#interrupt-cells = <2>;
 			compatible = "fsl,mpc8560-cpm", "fsl,cpm2", "fsl,cpm";
 			ranges = <0 0 c0000>;
-			reg = <80000 40000>;
-			command-proc = <919c0>;
+			reg = <919c0 30 80000 4000>;
 			fsl,brg-frequency = <d#165000000>;
 
+			brg@919f0 {
+				compatible = "fsl,mpc8560-brg",
+				             "fsl,cpm2-brg",
+				             "fsl,cpm-brg";
+				reg = <119f0 10 115f0 10>;
+			};
+
 			cpmpic: pic@90c00 {
 				interrupt-controller;
 				#address-cells = <0>;
@@ -252,39 +258,41 @@
 				compatible = "fsl,pq2-pic";
 			};
 
-			scc@91a00 {
+			serial@91a00 {
 				device_type = "serial";
-				compatible = "cpm_uart";
-				model = "SCC";
-				device-id = <1>;
+				compatible = "fsl,mpc8560-scc-uart",
+				             "fsl,cpm2-scc-uart",
+				             "fsl,cpm2-uart",
+				             "fsl,cpm-scc-uart",
+				             "fsl,cpm-uart";
 				reg = <91a00 20 88000 100>;
-				clock-setup = <00ffffff 0>;
-				rx-clock = <1>;
-				tx-clock = <1>;
-				current-speed = <1c200>;
 				interrupts = <28 8>;
 				interrupt-parent = <&cpmpic>;
+				fsl,cpm-brg = <1>;
+				fsl,cpm-command = <00800000>;
 			};
 
-			scc@91a20 {
+			serial@91a20 {
 				device_type = "serial";
-				compatible = "cpm_uart";
-				model = "SCC";
-				device-id = <2>;
+				compatible = "fsl,mpc8560-scc-uart",
+				             "fsl,cpm2-scc-uart",
+				             "fsl,cpm2-uart",
+				             "fsl,cpm-scc-uart",
+				             "fsl,cpm-uart";
 				reg = <91a20 20 88100 100>;
-				clock-setup = <ff00ffff 90000>;
-				rx-clock = <2>;
-				tx-clock = <2>;
-				current-speed = <1c200>;
 				interrupts = <29 8>;
 				interrupt-parent = <&cpmpic>;
+				fsl,cpm-brg = <2>;
+				fsl,cpm-command = <04a00000>;
 			};
 
-			fcc@91320 {
+			ethernet@91320 {
 				device_type = "network";
-				compatible = "fs_enet";
-				model = "FCC";
-				device-id = <2>;
+				compatible = "fsl,mpc8560-fcc-enet",
+				             "fsl,cpm2-fcc-enet",
+				             "fsl,cpm2-enet",
+				             "fsl,cpm-fcc-enet",
+				             "fsl,cpm-enet";
 				reg = <91320 20 88500 100 913a0 30>;
 				/*
 				 * mac-address is deprecated and will be removed
@@ -293,19 +301,19 @@
 				 */
 				mac-address = [ 00 00 00 00 00 00 ];
 				local-mac-address = [ 00 00 00 00 00 00 ];
-				clock-setup = <ff00ffff 250000>;
-				rx-clock = <15>;
-				tx-clock = <16>;
 				interrupts = <21 8>;
 				interrupt-parent = <&cpmpic>;
 				phy-handle = <&phy2>;
+				fsl,cpm-command = <16200300>;
 			};
 
-			fcc@91340 {
+			ethernet@91340 {
 				device_type = "network";
-				compatible = "fs_enet";
-				model = "FCC";
-				device-id = <3>;
+				compatible = "fsl,mpc8560-fcc-enet",
+				             "fsl,cpm2-fcc-enet",
+				             "fsl,cpm2-enet",
+				             "fsl,cpm-fcc-enet",
+				             "fsl,cpm-enet";
 				reg = <91340 20 88600 100 913d0 30>;
 				/*
 				 * mac-address is deprecated and will be removed
@@ -314,12 +322,10 @@
 				 */
 				mac-address = [ 00 00 00 00 00 00 ];
 				local-mac-address = [ 00 00 00 00 00 00 ];
-				clock-setup = <ffff00ff 3700>;
-				rx-clock = <17>;
-				tx-clock = <18>;
 				interrupts = <22 8>;
 				interrupt-parent = <&cpmpic>;
 				phy-handle = <&phy3>;
+				fsl,cpm-command = <1a400300>;
 			};
 		};
 	};
-- 
1.5.0.3

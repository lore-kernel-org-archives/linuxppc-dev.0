Return-Path: <tie-fei.zang@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 3C906DDE1A
	for <linuxppc-dev@ozlabs.org>; Fri, 13 Jul 2007 20:06:02 +1000 (EST)
Received: from az33smr01.freescale.net (az33smr01.freescale.net [10.64.34.199])
	by az33egw01.freescale.net (8.12.11/az33egw01) with ESMTP id
	l6DA5vrp004033
	for <linuxppc-dev@ozlabs.org>; Fri, 13 Jul 2007 03:05:57 -0700 (MST)
Received: from zch01exm23.fsl.freescale.net (zch01exm23.ap.freescale.net
	[10.192.129.207])
	by az33smr01.freescale.net (8.13.1/8.13.0) with ESMTP id l6DA5t2S016523
	for <linuxppc-dev@ozlabs.org>; Fri, 13 Jul 2007 05:05:56 -0500 (CDT)
Subject: [PATCH 2/2]  Add PCI/PCI Express node for 8544DS board]
From: Zang Roy-r61911 <tie-fei.zang@freescale.com>
To: Kumar Gala <galak@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>
Content-Type: text/plain
Message-Id: <1184321144.30789.45.camel@localhost.localdomain>
Mime-Version: 1.0
Date: 13 Jul 2007 18:05:44 +0800
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

Add PCI/PCI Express node for 8544DS board.

---
 arch/powerpc/boot/dts/mpc8544ds.dts |  211 +++++++++++++++++++++++++++++++++++
 1 files changed, 211 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/boot/dts/mpc8544ds.dts b/arch/powerpc/boot/dts/mpc8544ds.dts
index 43bf5c1..aab0bc6 100644
--- a/arch/powerpc/boot/dts/mpc8544ds.dts
+++ b/arch/powerpc/boot/dts/mpc8544ds.dts
@@ -143,6 +143,217 @@
 			fsl,has-rstcr;
 		};
 
+		pci@8000 {
+			compatible = "fsl,mpc8540-pci";
+			device_type = "pci";
+			interrupt-map-mask = <f800 0 0 7>;
+			interrupt-map = <
+
+				/* IDSEL 0x11 J17 Slot 1 */
+				8800 0 0 1 &mpic 2 1
+				8800 0 0 2 &mpic 3 1
+				8800 0 0 3 &mpic 4 1
+				8800 0 0 4 &mpic 1 1
+
+				/* IDSEL 0x12 J16 Slot 2 */
+
+				9000 0 0 1 &mpic 3 1
+				9000 0 0 2 &mpic 4 1
+				9000 0 0 3 &mpic 2 1
+				9000 0 0 4 &mpic 1 1>;
+
+			interrupt-parent = <&mpic>;
+			interrupts = <18 2>;
+			bus-range = <0 ff>;
+			ranges = <02000000 0 80000000 80000000 0 10000000
+				  01000000 0 00000000 e2000000 0 00800000>;
+			clock-frequency = <3f940aa>;
+			#interrupt-cells = <1>;
+			#size-cells = <2>;
+			#address-cells = <3>;
+			reg = <8000 1000>;
+		};
+
+		pci@a000 {
+			compatible = "fsl,mpc8548-pcie";
+			device_type = "pci";
+			#interrupt-cells = <1>;
+			#size-cells = <2>;
+			#address-cells = <3>;
+			reg = <a000 1000>;
+			bus-range = <0 ff>;
+			ranges = <02000000 0 90000000 90000000 0 10000000
+				  01000000 0 00000000 e2800000 0 00800000>;
+			clock-frequency = <1fca055>;
+			interrupt-parent = <&mpic>;
+			interrupts = <19 2>;
+			interrupt-map-mask = <f800 0 0 7>;
+			interrupt-map = <
+				/* IDSEL 0x0 */
+				0000 0 0 1 &mpic 0 1
+				0000 0 0 2 &mpic 1 1
+				0000 0 0 3 &mpic 2 1
+				0000 0 0 4 &mpic 3 1
+				>;
+		};
+
+		pci@9000 {
+			compatible = "fsl,mpc8548-pcie";
+			device_type = "pci";
+			#interrupt-cells = <1>;
+			#size-cells = <2>;
+			#address-cells = <3>;
+			reg = <9000 1000>;
+			bus-range = <0 ff>;
+			ranges = <02000000 0 a0000000 a0000000 0 10000000
+				  01000000 0 00000000 e3000000 0 00800000>;
+			clock-frequency = <1fca055>;
+			interrupt-parent = <&mpic>;
+			interrupts = <1a 2>;
+			interrupt-map-mask = <f800 0 0 7>;
+			interrupt-map = <
+				/* IDSEL 0x0 */
+				0000 0 0 1 &mpic 4 1
+				0000 0 0 2 &mpic 5 1
+				0000 0 0 3 &mpic 6 1
+				0000 0 0 4 &mpic 7 1
+				>;
+		};
+
+		pci@b000 {
+			compatible = "fsl,mpc8548-pcie";
+			device_type = "pci";
+			#interrupt-cells = <1>;
+			#size-cells = <2>;
+			#address-cells = <3>;
+			reg = <b000 1000>;
+			bus-range = <0 ff>;
+			ranges = <02000000 0 b0000000 b0000000 0 10000000
+				  01000000 0 00000000 e3800000 0 00800000>;
+			clock-frequency = <1fca055>;
+			interrupt-parent = <&mpic>;
+			interrupts = <1b 2>;
+			interrupt-map-mask = <f800 0 0 7>;
+			interrupt-map = <
+
+				// IDSEL 0x1a
+				d000 0 0 1 &i8259 6 2
+				d000 0 0 2 &i8259 3 2
+				d000 0 0 3 &i8259 4 2
+				d000 0 0 4 &i8259 5 2
+
+				// IDSEL 0x1b
+				d800 0 0 1 &i8259 5 2
+				d800 0 0 2 &i8259 0 0
+				d800 0 0 3 &i8259 0 0
+				d800 0 0 4 &i8259 0 0
+
+				// IDSEL 0x1c  USB
+				e000 0 0 1 &i8259 9 2
+				e000 0 0 2 &i8259 a 2
+				e000 0 0 3 &i8259 c 2
+				e000 0 0 4 &i8259 7 2
+
+				// IDSEL 0x1d  Audio
+				e800 0 0 1 &i8259 9 2
+				e800 0 0 2 &i8259 a 2
+				e800 0 0 3 &i8259 b 2
+				e800 0 0 4 &i8259 0 0
+
+				// IDSEL 0x1e Legacy
+				f000 0 0 1 &i8259 c 2
+				f000 0 0 2 &i8259 0 0
+				f000 0 0 3 &i8259 0 0
+				f000 0 0 4 &i8259 0 0
+
+				// IDSEL 0x1f IDE/SATA
+				f800 0 0 1 &i8259 6 2
+				f800 0 0 2 &i8259 0 0
+				f800 0 0 3 &i8259 0 0
+				f800 0 0 4 &i8259 0 0
+			>;
+			uli1575@0 {
+				reg = <0 0 0 0 0>;
+				#size-cells = <2>;
+				#address-cells = <3>;
+				ranges = <02000000 0 a0000000
+					  02000000 0 a0000000
+					  0 10000000
+					  01000000 0 00000000
+					  01000000 0 00000000
+					  0 00080000>;
+
+				pci_bridge@0 {
+					reg = <0 0 0 0 0>;
+					#size-cells = <2>;
+					#address-cells = <3>;
+					ranges = <02000000 0 80000000
+						  02000000 0 80000000
+						  0 20000000
+						  01000000 0 00000000
+						  01000000 0 00000000
+						  0 00100000>;
+
+					isa@1e {
+						device_type = "isa";
+						#interrupt-cells = <2>;
+						#size-cells = <1>;
+						#address-cells = <2>;
+						reg = <f000 0 0 0 0>;
+						ranges = <1 0 01000000 0 0
+							  00001000>;
+						interrupt-parent = <&i8259>;
+
+						i8259: interrupt-controller@20 {
+							reg = <1 20 2
+							       1 a0 2
+							       1 4d0 2>;
+							clock-frequency = <0>;
+							interrupt-controller;
+							device_type = "interrupt-controller";
+							#address-cells = <0>;
+							#interrupt-cells = <2>;
+							built-in;
+							compatible = "chrp,iic";
+							interrupts = <9 2>;
+							interrupt-parent =
+								<&mpic>;
+						};
+
+						i8042@60 {
+							#size-cells = <0>;
+							#address-cells = <1>;
+							reg = <1 60 1 1 64 1>;
+							interrupts = <1 3 c 3>;
+							interrupt-parent =
+								<&i8259>;
+
+							keyboard@0 {
+								reg = <0>;
+								compatible = "pnpPNP,303";
+							};
+
+							mouse@1 {
+								reg = <1>;
+								compatible = "pnpPNP,f03";
+							};
+						};
+
+						rtc@70 {
+							compatible =
+								"pnpPNP,b00";
+							reg = <1 70 2>;
+						};
+
+						gpio@400 {
+							reg = <1 400 80>;
+						};
+					};
+				};
+			};
+
+		};
+
 		mpic: pic@40000 {
 			clock-frequency = <0>;
 			interrupt-controller;
-- 
1.5.1

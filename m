Return-Path: <martyn.welch@ge.com>
Received: from exprod5og112.obsmtp.com (exprod5og112.obsmtp.com [64.18.0.24])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id DE528B6F8C
 for <linuxppc-dev@ozlabs.org>; Fri,  4 Nov 2011 04:44:02 +1100 (EST)
Subject: [PATCH] powerpc/86xx: Correct Gianfar support for GE boards
To: linuxppc-dev@ozlabs.org, galak@kernel.crashing.org
From: Martyn Welch <martyn.welch@ge.com>
Date: Thu, 03 Nov 2011 17:37:47 +0000
Message-ID: <20111103173726.23924.83647.stgit@ES-BJ21R4J>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The GE DTBs were not updated when the Gianfar driver was converted to an
of_platform_driver in commit b31a1d8b41513b96e9c7ec2f68c5734cef0b26a4. Update
the DTBs, adding the required TBI entries.

Signed-off-by: Martyn Welch <martyn.welch@ge.com>
---

 arch/powerpc/boot/dts/gef_ppc9a.dts  |   33 +++++++++++++++++++++++++++++----
 arch/powerpc/boot/dts/gef_sbc310.dts |   33 +++++++++++++++++++++++++++++----
 arch/powerpc/boot/dts/gef_sbc610.dts |   33 +++++++++++++++++++++++++++++----
 3 files changed, 87 insertions(+), 12 deletions(-)


diff --git a/arch/powerpc/boot/dts/gef_ppc9a.dts b/arch/powerpc/boot/dts/gef_ppc9a.dts
index 83f4b79..2266bbb 100644
--- a/arch/powerpc/boot/dts/gef_ppc9a.dts
+++ b/arch/powerpc/boot/dts/gef_ppc9a.dts
@@ -269,14 +269,16 @@
 		enet0: ethernet@24000 {
 			#address-cells = <1>;
 			#size-cells = <1>;
+			cell-index = <0>;
 			device_type = "network";
-			model = "eTSEC";
+			model = "TSEC";
 			compatible = "gianfar";
 			reg = <0x24000 0x1000>;
 			ranges = <0x0 0x24000 0x1000>;
 			local-mac-address = [ 00 00 00 00 00 00 ];
-			interrupts = <0x1d 0x2 0x1e 0x2 0x22 0x2>;
+			interrupts = <29 2 30  2 34 2>;
 			interrupt-parent = <&mpic>;
+			tbi-handle = <&tbi0>;
 			phy-handle = <&phy0>;
 			phy-connection-type = "gmii";
 
@@ -290,25 +292,48 @@
 					interrupt-parent = <&gef_pic>;
 					interrupts = <0x9 0x4>;
 					reg = <1>;
+					device_type = "ethernet-phy";
 				};
 				phy2: ethernet-phy@2 {
 					interrupt-parent = <&gef_pic>;
 					interrupts = <0x8 0x4>;
 					reg = <3>;
+					device_type = "ethernet-phy";
+				};
+				tbi0: tbi-phy@11 {
+					reg = <0x11>;
+					device_type = "tbi-phy";
 				};
 			};
 		};
 
 		enet1: ethernet@26000 {
+			#address-cells = <1>;
+			#size-cells = <1>;
+			cell-index = <2>;
 			device_type = "network";
-			model = "eTSEC";
+			model = "TSEC";
 			compatible = "gianfar";
 			reg = <0x26000 0x1000>;
+			ranges = <0x0 0x26000 0x1000>;
 			local-mac-address = [ 00 00 00 00 00 00 ];
-			interrupts = <0x1f 0x2 0x20 0x2 0x21 0x2>;
+			interrupts = <31 2 32 2 33 2>;
 			interrupt-parent = <&mpic>;
+			tbi-handle = <&tbi2>;
 			phy-handle = <&phy2>;
 			phy-connection-type = "gmii";
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
 		};
 
 		serial0: serial@4500 {
diff --git a/arch/powerpc/boot/dts/gef_sbc310.dts b/arch/powerpc/boot/dts/gef_sbc310.dts
index fc3a331..429e87d 100644
--- a/arch/powerpc/boot/dts/gef_sbc310.dts
+++ b/arch/powerpc/boot/dts/gef_sbc310.dts
@@ -267,14 +267,16 @@
 		enet0: ethernet@24000 {
 			#address-cells = <1>;
 			#size-cells = <1>;
+			cell-index = <0>;
 			device_type = "network";
-			model = "eTSEC";
+			model = "TSEC";
 			compatible = "gianfar";
 			reg = <0x24000 0x1000>;
 			ranges = <0x0 0x24000 0x1000>;
 			local-mac-address = [ 00 00 00 00 00 00 ];
-			interrupts = <0x1d 0x2 0x1e 0x2 0x22 0x2>;
+			interrupts = <29 2 30  2 34 2>;
 			interrupt-parent = <&mpic>;
+			tbi-handle = <&tbi0>;
 			phy-handle = <&phy0>;
 			phy-connection-type = "gmii";
 
@@ -288,25 +290,48 @@
 					interrupt-parent = <&gef_pic>;
 					interrupts = <0x9 0x4>;
 					reg = <1>;
+					device_type = "ethernet-phy";
 				};
 				phy2: ethernet-phy@2 {
 					interrupt-parent = <&gef_pic>;
 					interrupts = <0x8 0x4>;
 					reg = <3>;
+					device_type = "ethernet-phy";
+				};
+				tbi0: tbi-phy@11 {
+					reg = <0x11>;
+					device_type = "tbi-phy";
 				};
 			};
 		};
 
 		enet1: ethernet@26000 {
+			#address-cells = <1>;
+			#size-cells = <1>;
+			cell-index = <2>;
 			device_type = "network";
-			model = "eTSEC";
+			model = "TSEC";
 			compatible = "gianfar";
 			reg = <0x26000 0x1000>;
+			ranges = <0x0 0x26000 0x1000>;
 			local-mac-address = [ 00 00 00 00 00 00 ];
-			interrupts = <0x1f 0x2 0x20 0x2 0x21 0x2>;
+			interrupts = <31 2 32 2 33 2>;
 			interrupt-parent = <&mpic>;
+			tbi-handle = <&tbi2>;
 			phy-handle = <&phy2>;
 			phy-connection-type = "gmii";
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
 		};
 
 		serial0: serial@4500 {
diff --git a/arch/powerpc/boot/dts/gef_sbc610.dts b/arch/powerpc/boot/dts/gef_sbc610.dts
index c0671cc..d81201a 100644
--- a/arch/powerpc/boot/dts/gef_sbc610.dts
+++ b/arch/powerpc/boot/dts/gef_sbc610.dts
@@ -267,14 +267,16 @@
 		enet0: ethernet@24000 {
 			#address-cells = <1>;
 			#size-cells = <1>;
+			cell-index = <0>;
 			device_type = "network";
-			model = "eTSEC";
+			model = "TSEC";
 			compatible = "gianfar";
 			reg = <0x24000 0x1000>;
 			ranges = <0x0 0x24000 0x1000>;
 			local-mac-address = [ 00 00 00 00 00 00 ];
-			interrupts = <0x1d 0x2 0x1e 0x2 0x22 0x2>;
+			interrupts = <29 2 30  2 34 2>;
 			interrupt-parent = <&mpic>;
+			tbi-handle = <&tbi0>;
 			phy-handle = <&phy0>;
 			phy-connection-type = "gmii";
 
@@ -288,25 +290,48 @@
 					interrupt-parent = <&gef_pic>;
 					interrupts = <0x9 0x4>;
 					reg = <1>;
+					device_type = "ethernet-phy";
 				};
 				phy2: ethernet-phy@2 {
 					interrupt-parent = <&gef_pic>;
 					interrupts = <0x8 0x4>;
 					reg = <3>;
+					device_type = "ethernet-phy";
+				};
+				tbi0: tbi-phy@11 {
+					reg = <0x11>;
+					device_type = "tbi-phy";
 				};
 			};
 		};
 
 		enet1: ethernet@26000 {
+			#address-cells = <1>;
+			#size-cells = <1>;
+			cell-index = <2>;
 			device_type = "network";
-			model = "eTSEC";
+			model = "TSEC";
 			compatible = "gianfar";
 			reg = <0x26000 0x1000>;
+			ranges = <0x0 0x26000 0x1000>;
 			local-mac-address = [ 00 00 00 00 00 00 ];
-			interrupts = <0x1f 0x2 0x20 0x2 0x21 0x2>;
+			interrupts = <31 2 32 2 33 2>;
 			interrupt-parent = <&mpic>;
+			tbi-handle = <&tbi2>;
 			phy-handle = <&phy2>;
 			phy-connection-type = "gmii";
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
 		};
 
 		serial0: serial@4500 {


--
Martyn Welch (Principal Software Engineer)   |   Registered in England and
GE Intelligent Platforms                     |   Wales (3828642) at 100
T +44(0)127322748                            |   Barbirolli Square, Manchester,
E martyn.welch@ge.com                        |   M2 3AB  VAT:GB 927559189

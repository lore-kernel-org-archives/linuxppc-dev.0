Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id C236BB71DF
 for <linuxppc-dev@ozlabs.org>; Thu, 17 Nov 2011 18:16:25 +1100 (EST)
Received: from localhost (localhost.localdomain [127.0.0.1])
 by gate.crashing.org (8.14.1/8.13.8) with ESMTP id pAH7GM6I026484
 for <linuxppc-dev@ozlabs.org>; Thu, 17 Nov 2011 01:16:22 -0600
From: Kumar Gala <galak@kernel.crashing.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 02/29] powerpc/85xx: Rework PCI nodes on P1020RDB
Date: Thu, 17 Nov 2011 01:15:54 -0600
Message-Id: <1321514181-28897-2-git-send-email-galak@kernel.crashing.org>
In-Reply-To: <1321514181-28897-1-git-send-email-galak@kernel.crashing.org>
References: <1321514181-28897-1-git-send-email-galak@kernel.crashing.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

* Move SoC specific details like irq mapping to SoC dtsi
* Update interrupt property to cover both error interrupt and PCIe
  runtime interrupts

Signed-off-by: Kumar Gala <galak@kernel.crashing.org>
---
 arch/powerpc/boot/dts/p1020rdb.dts |   26 +---------------------
 arch/powerpc/boot/dts/p1020si.dtsi |   40 ++++++++++++++++++++++++++++++++---
 2 files changed, 38 insertions(+), 28 deletions(-)

diff --git a/arch/powerpc/boot/dts/p1020rdb.dts b/arch/powerpc/boot/dts/p1020rdb.dts
index d6a8ae4..8b1a7ee 100644
--- a/arch/powerpc/boot/dts/p1020rdb.dts
+++ b/arch/powerpc/boot/dts/p1020rdb.dts
@@ -257,19 +257,8 @@
 	pci0: pcie@ffe09000 {
 		ranges = <0x2000000 0x0 0xa0000000 0 0xa0000000 0x0 0x20000000
 			  0x1000000 0x0 0x00000000 0 0xffc10000 0x0 0x10000>;
-		interrupt-map-mask = <0xf800 0x0 0x0 0x7>;
-		interrupt-map = <
-			/* IDSEL 0x0 */
-			0000 0x0 0x0 0x1 &mpic 0x4 0x1
-			0000 0x0 0x0 0x2 &mpic 0x5 0x1
-			0000 0x0 0x0 0x3 &mpic 0x6 0x1
-			0000 0x0 0x0 0x4 &mpic 0x7 0x1
-			>;
+		reg = <0 0xffe09000 0 0x1000>;
 		pcie@0 {
-			reg = <0x0 0x0 0x0 0x0 0x0>;
-			#size-cells = <2>;
-			#address-cells = <3>;
-			device_type = "pci";
 			ranges = <0x2000000 0x0 0xa0000000
 				  0x2000000 0x0 0xa0000000
 				  0x0 0x20000000
@@ -281,21 +270,10 @@
 	};
 
 	pci1: pcie@ffe0a000 {
+		reg = <0 0xffe0a000 0 0x1000>;
 		ranges = <0x2000000 0x0 0x80000000 0 0x80000000 0x0 0x20000000
 			  0x1000000 0x0 0x00000000 0 0xffc00000 0x0 0x10000>;
-		interrupt-map-mask = <0xf800 0x0 0x0 0x7>;
-		interrupt-map = <
-			/* IDSEL 0x0 */
-			0000 0x0 0x0 0x1 &mpic 0x0 0x1
-			0000 0x0 0x0 0x2 &mpic 0x1 0x1
-			0000 0x0 0x0 0x3 &mpic 0x2 0x1
-			0000 0x0 0x0 0x4 &mpic 0x3 0x1
-			>;
 		pcie@0 {
-			reg = <0x0 0x0 0x0 0x0 0x0>;
-			#size-cells = <2>;
-			#address-cells = <3>;
-			device_type = "pci";
 			ranges = <0x2000000 0x0 0x80000000
 				  0x2000000 0x0 0x80000000
 				  0x0 0x20000000
diff --git a/arch/powerpc/boot/dts/p1020si.dtsi b/arch/powerpc/boot/dts/p1020si.dtsi
index 5c5acb6..58f6b30 100644
--- a/arch/powerpc/boot/dts/p1020si.dtsi
+++ b/arch/powerpc/boot/dts/p1020si.dtsi
@@ -352,26 +352,58 @@
 	pci0: pcie@ffe09000 {
 		compatible = "fsl,mpc8548-pcie";
 		device_type = "pci";
-		#interrupt-cells = <1>;
 		#size-cells = <2>;
 		#address-cells = <3>;
-		reg = <0 0xffe09000 0 0x1000>;
 		bus-range = <0 255>;
 		clock-frequency = <33333333>;
 		interrupt-parent = <&mpic>;
 		interrupts = <16 2>;
+
+		pcie@0 {
+			reg = <0 0 0 0 0>;
+			#interrupt-cells = <1>;
+			#size-cells = <2>;
+			#address-cells = <3>;
+			device_type = "pci";
+			interrupts = <16 2>;
+			interrupt-map-mask = <0xf800 0 0 7>;
+			interrupt-map = <
+				/* IDSEL 0x0 */
+				0000 0x0 0x0 0x1 &mpic 0x4 0x1
+				0000 0x0 0x0 0x2 &mpic 0x5 0x1
+				0000 0x0 0x0 0x3 &mpic 0x6 0x1
+				0000 0x0 0x0 0x4 &mpic 0x7 0x1
+				>;
+		};
+
 	};
 
 	pci1: pcie@ffe0a000 {
 		compatible = "fsl,mpc8548-pcie";
 		device_type = "pci";
-		#interrupt-cells = <1>;
 		#size-cells = <2>;
 		#address-cells = <3>;
-		reg = <0 0xffe0a000 0 0x1000>;
 		bus-range = <0 255>;
 		clock-frequency = <33333333>;
 		interrupt-parent = <&mpic>;
 		interrupts = <16 2>;
+
+		pcie@0 {
+			reg = <0 0 0 0 0>;
+			#interrupt-cells = <1>;
+			#size-cells = <2>;
+			#address-cells = <3>;
+			device_type = "pci";
+			interrupts = <16 2>;
+			interrupt-map-mask = <0xf800 0 0 7>;
+
+			interrupt-map = <
+				/* IDSEL 0x0 */
+				0000 0x0 0x0 0x1 &mpic 0x0 0x1
+				0000 0x0 0x0 0x2 &mpic 0x1 0x1
+				0000 0x0 0x0 0x3 &mpic 0x2 0x1
+				0000 0x0 0x0 0x4 &mpic 0x3 0x1
+				>;
+		};
 	};
 };
-- 
1.7.3.4

Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 3ED44B6F18
 for <linuxppc-dev@ozlabs.org>; Fri, 11 Nov 2011 03:07:16 +1100 (EST)
Received: from localhost (localhost.localdomain [127.0.0.1])
 by gate.crashing.org (8.14.1/8.13.8) with ESMTP id pAAG7DDM027667
 for <linuxppc-dev@ozlabs.org>; Thu, 10 Nov 2011 10:07:14 -0600
From: Kumar Gala <galak@kernel.crashing.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 04/11] powerpc/85xx: Update SPI binding to match binding spec
 for P1020RDB
Date: Thu, 10 Nov 2011 10:07:02 -0600
Message-Id: <1320941229-29557-4-git-send-email-galak@kernel.crashing.org>
In-Reply-To: <1320941229-29557-3-git-send-email-galak@kernel.crashing.org>
References: <1320941229-29557-1-git-send-email-galak@kernel.crashing.org>
 <1320941229-29557-2-git-send-email-galak@kernel.crashing.org>
 <1320941229-29557-3-git-send-email-galak@kernel.crashing.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The SPI node is out of date with regards to the binding for fsl-espi and
driver support.

Signed-off-by: Kumar Gala <galak@kernel.crashing.org>
---
 arch/powerpc/boot/dts/p1020rdb.dts |   30 +++++++++++++-----------------
 arch/powerpc/boot/dts/p1020si.dtsi |    5 ++---
 2 files changed, 15 insertions(+), 20 deletions(-)

diff --git a/arch/powerpc/boot/dts/p1020rdb.dts b/arch/powerpc/boot/dts/p1020rdb.dts
index 8b1a7ee..b31e7ec 100644
--- a/arch/powerpc/boot/dts/p1020rdb.dts
+++ b/arch/powerpc/boot/dts/p1020rdb.dts
@@ -149,49 +149,45 @@
 		};
 
 		spi@7000 {
-
-			fsl_m25p80@0 {
+			flash@0 {
 				#address-cells = <1>;
 				#size-cells = <1>;
-				compatible = "fsl,espi-flash";
+				compatible = "spansion,s25sl12801";
 				reg = <0>;
-				linux,modalias = "fsl_m25p80";
-				modal = "s25sl128b";
-				spi-max-frequency = <50000000>;
-				mode = <0>;
+				spi-max-frequency = <40000000>; /* input clock */
 
-				partition@0 {
+				partition@u-boot {
 					/* 512KB for u-boot Bootloader Image */
 					reg = <0x0 0x00080000>;
-					label = "SPI (RO) U-Boot Image";
+					label = "u-boot";
 					read-only;
 				};
 
-				partition@80000 {
+				partition@dtb {
 					/* 512KB for DTB Image */
 					reg = <0x00080000 0x00080000>;
-					label = "SPI (RO) DTB Image";
+					label = "dtb";
 					read-only;
 				};
 
-				partition@100000 {
+				partition@kernel {
 					/* 4MB for Linux Kernel Image */
 					reg = <0x00100000 0x00400000>;
-					label = "SPI (RO) Linux Kernel Image";
+					label = "kernel";
 					read-only;
 				};
 
-				partition@500000 {
+				partition@fs {
 					/* 4MB for Compressed RFS Image */
 					reg = <0x00500000 0x00400000>;
-					label = "SPI (RO) Compressed RFS Image";
+					label = "file system";
 					read-only;
 				};
 
-				partition@900000 {
+				partition@jffs-fs {
 					/* 7MB for JFFS2 based RFS */
 					reg = <0x00900000 0x00700000>;
-					label = "SPI (RW) JFFS2 RFS";
+					label = "file system jffs2";
 				};
 			};
 		};
diff --git a/arch/powerpc/boot/dts/p1020si.dtsi b/arch/powerpc/boot/dts/p1020si.dtsi
index 58f6b30..25e10cf 100644
--- a/arch/powerpc/boot/dts/p1020si.dtsi
+++ b/arch/powerpc/boot/dts/p1020si.dtsi
@@ -112,14 +112,13 @@
 		};
 
 		spi@7000 {
-			cell-index = <0>;
 			#address-cells = <1>;
 			#size-cells = <0>;
-			compatible = "fsl,espi";
+			compatible = "fsl,p1020-espi", "fsl,mpc8536-espi";
 			reg = <0x7000 0x1000>;
 			interrupts = <59 0x2>;
 			interrupt-parent = <&mpic>;
-			mode = "cpu";
+			fsl,espi-num-chipselects = <4>;
 		};
 
 		gpio: gpio-controller@f000 {
-- 
1.7.3.4

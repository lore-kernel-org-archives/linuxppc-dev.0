Return-Path: <B21284@freescale.com>
Received: from VA3EHSOBE004.bigfish.com (va3ehsobe004.messaging.microsoft.com
	[216.32.180.14]) by ozlabs.org (Postfix) with ESMTP id EA434B7147
	for <linuxppc-dev@ozlabs.org>; Tue, 20 Jul 2010 12:36:39 +1000 (EST)
Received: from mail69-va3 (localhost.localdomain [127.0.0.1])	by
	mail69-va3-R.bigfish.com (Postfix) with ESMTP id D6027101811D	for
	<linuxppc-dev@ozlabs.org>; Tue, 20 Jul 2010 02:21:30 +0000 (UTC)
Received: from VA3EHSMHS025.bigfish.com (unknown [10.7.14.238])	by
	mail69-va3.bigfish.com (Postfix) with ESMTP id 7457B7D804C	for
	<linuxppc-dev@ozlabs.org>; Tue, 20 Jul 2010 02:21:30 +0000 (UTC)
Received: from de01smr01.freescale.net (de01smr01.freescale.net [10.208.0.31])
	by az33egw02.freescale.net (8.14.3/8.14.3) with ESMTP id
	o6K2LRBG006769	for
	<linuxppc-dev@ozlabs.org>; Mon, 19 Jul 2010 19:21:27 -0700 (MST)
Received: from zch01exm21.fsl.freescale.net (zch01exm21.ap.freescale.net
	[10.192.129.205])	by de01smr01.freescale.net (8.13.1/8.13.0) with ESMTP
	id o6K2XWDl023963	for <linuxppc-dev@ozlabs.org>;
	Mon, 19 Jul 2010 21:33:43 -0500 (CDT)
From: Mingkai Hu <Mingkai.hu@freescale.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 6/6] DTS: add SPI flash(s25fl128p01) support on p4080ds and
	mpc8536ds board
Date: Tue, 20 Jul 2010 10:08:25 +0800
Message-ID: <1279591705-7574-7-git-send-email-Mingkai.hu@freescale.com>
In-Reply-To: <1279591705-7574-6-git-send-email-Mingkai.hu@freescale.com>
References: <1279591705-7574-1-git-send-email-Mingkai.hu@freescale.com>
	<1279591705-7574-2-git-send-email-Mingkai.hu@freescale.com>
	<1279591705-7574-3-git-send-email-Mingkai.hu@freescale.com>
	<1279591705-7574-4-git-send-email-Mingkai.hu@freescale.com>
	<1279591705-7574-5-git-send-email-Mingkai.hu@freescale.com>
	<1279591705-7574-6-git-send-email-Mingkai.hu@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: Mingkai Hu <Mingkai.hu@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Signed-off-by: Mingkai Hu <Mingkai.hu@freescale.com>
---
 arch/powerpc/boot/dts/mpc8536ds.dts |   52 +++++++++++++++++++++++++++++++++++
 arch/powerpc/boot/dts/p4080ds.dts   |    9 ++----
 2 files changed, 55 insertions(+), 6 deletions(-)

diff --git a/arch/powerpc/boot/dts/mpc8536ds.dts b/arch/powerpc/boot/dts/mpc8536ds.dts
index 815cebb..e5d07ec 100644
--- a/arch/powerpc/boot/dts/mpc8536ds.dts
+++ b/arch/powerpc/boot/dts/mpc8536ds.dts
@@ -108,6 +108,58 @@
 			};
 		};
 
+		spi@7000 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			compatible = "fsl,espi";
+			reg = <0x7000 0x1000>;
+			interrupts = <59 0x2>;
+			interrupt-parent = <&mpic>;
+ 			fsl,espi-num-chipselects = <4>;
+
+ 			flash@0 {
+				#address-cells = <1>;
+				#size-cells = <1>;
+ 				compatible = "spansion,s25sl12801";
+				reg = <0>;
+				spi-max-frequency = <40000000>;
+				partition@u-boot {
+					label = "u-boot";
+					reg = <0x00000000 0x00100000>;
+					read-only;
+				};
+				partition@kernel {
+					label = "kernel";
+					reg = <0x00100000 0x00500000>;
+					read-only;
+				};
+				partition@dtb {
+					label = "dtb";
+					reg = <0x00600000 0x00100000>;
+					read-only;
+				};
+				partition@fs {
+					label = "file system";
+					reg = <0x00700000 0x00900000>;
+				};
+			};
+ 			flash@1 {
+ 				compatible = "spansion,s25sl12801";
+				reg = <1>;
+				spi-max-frequency = <40000000>;
+			};
+ 			flash@2 {
+ 				compatible = "spansion,s25sl12801";
+				reg = <2>;
+				spi-max-frequency = <40000000>;
+			};
+ 			flash@3 {
+ 				compatible = "spansion,s25sl12801";
+				reg = <3>;
+				spi-max-frequency = <40000000>;
+			};
+		};
+
 		dma@21300 {
 			#address-cells = <1>;
 			#size-cells = <1>;
diff --git a/arch/powerpc/boot/dts/p4080ds.dts b/arch/powerpc/boot/dts/p4080ds.dts
index 6b29eab..ac7dd23 100644
--- a/arch/powerpc/boot/dts/p4080ds.dts
+++ b/arch/powerpc/boot/dts/p4080ds.dts
@@ -236,22 +236,19 @@
 		};
 
 		spi@110000 {
-			cell-index = <0>;
 			#address-cells = <1>;
 			#size-cells = <0>;
 			compatible = "fsl,espi";
 			reg = <0x110000 0x1000>;
 			interrupts = <53 0x2>;
 			interrupt-parent = <&mpic>;
-			espi,num-ss-bits = <4>;
-			mode = "cpu";
+ 			fsl,espi-num-chipselects = <4>;
 
-			fsl_m25p80@0 {
+ 			flash@0 {
 				#address-cells = <1>;
 				#size-cells = <1>;
-				compatible = "fsl,espi-flash";
+ 				compatible = "spansion,s25sl12801";
 				reg = <0>;
-				linux,modalias = "fsl_m25p80";
 				spi-max-frequency = <40000000>; /* input clock */
 				partition@u-boot {
 					label = "u-boot";
-- 
1.6.4

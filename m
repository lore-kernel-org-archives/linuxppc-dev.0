Return-Path: <B21284@freescale.com>
Received: from DB3EHSOBE002.bigfish.com (db3ehsobe002.messaging.microsoft.com
	[213.199.154.140]) by ozlabs.org (Postfix) with ESMTP id 244881007D2
	for <linuxppc-dev@ozlabs.org>; Mon,  2 Aug 2010 18:22:35 +1000 (EST)
Received: from mail21-db3 (localhost.localdomain [127.0.0.1])	by
	mail21-db3-R.bigfish.com (Postfix) with ESMTP id 78FEE9883D4	for
	<linuxppc-dev@ozlabs.org>; Mon,  2 Aug 2010 08:07:27 +0000 (UTC)
Received: from DB3EHSMHS009.bigfish.com (unknown [10.3.81.243])	by
	mail21-db3.bigfish.com (Postfix) with ESMTP id CE110A3004E	for
	<linuxppc-dev@ozlabs.org>; Mon,  2 Aug 2010 08:07:26 +0000 (UTC)
Received: from az33smr02.freescale.net (az33smr02.freescale.net
	[10.64.34.200])	by az33egw02.freescale.net (8.14.3/8.14.3) with ESMTP
	id o7287ERR012361	for <linuxppc-dev@ozlabs.org>;
	Mon, 2 Aug 2010 01:07:23 -0700 (MST)
Received: from zch01exm21.fsl.freescale.net (zch01exm21.ap.freescale.net
	[10.192.129.205])	by az33smr02.freescale.net (8.13.1/8.13.0) with ESMTP
	id o7287BM8014167	for <linuxppc-dev@ozlabs.org>;
	Mon, 2 Aug 2010 03:07:20 -0500 (CDT)
From: Mingkai Hu <Mingkai.hu@freescale.com>
To: linuxppc-dev@ozlabs.org, spi-devel-general@lists.sourceforge.net
Subject: [PATCH v2 6/6] DTS: add SPI flash(s25fl128p01) support on p4080ds and
	mpc8536ds board
Date: Mon, 2 Aug 2010 15:52:04 +0800
Message-ID: <1280735524-17547-7-git-send-email-Mingkai.hu@freescale.com>
In-Reply-To: <1280735524-17547-6-git-send-email-Mingkai.hu@freescale.com>
References: <1280735524-17547-1-git-send-email-Mingkai.hu@freescale.com>
	<1280735524-17547-2-git-send-email-Mingkai.hu@freescale.com>
	<1280735524-17547-3-git-send-email-Mingkai.hu@freescale.com>
	<1280735524-17547-4-git-send-email-Mingkai.hu@freescale.com>
	<1280735524-17547-5-git-send-email-Mingkai.hu@freescale.com>
	<1280735524-17547-6-git-send-email-Mingkai.hu@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: kumar.gala@freescale.com, Mingkai Hu <Mingkai.hu@freescale.com>
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

v2:
 - Remove the whitespace inconsitencies

 arch/powerpc/boot/dts/mpc8536ds.dts |   52 +++++++++++++++++++++++++++++++++++
 arch/powerpc/boot/dts/p4080ds.dts   |   11 +++-----
 2 files changed, 56 insertions(+), 7 deletions(-)

diff --git a/arch/powerpc/boot/dts/mpc8536ds.dts b/arch/powerpc/boot/dts/mpc8536ds.dts
index 815cebb..a75c10e 100644
--- a/arch/powerpc/boot/dts/mpc8536ds.dts
+++ b/arch/powerpc/boot/dts/mpc8536ds.dts
@@ -108,6 +108,58 @@
 			};
 		};
 
+		spi@7000 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			compatible = "fsl,mpc8536-espi";
+			reg = <0x7000 0x1000>;
+			interrupts = <59 0x2>;
+			interrupt-parent = <&mpic>;
+			fsl,espi-num-chipselects = <4>;
+
+			flash@0 {
+				#address-cells = <1>;
+				#size-cells = <1>;
+				compatible = "spansion,s25sl12801";
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
+			flash@1 {
+				compatible = "spansion,s25sl12801";
+				reg = <1>;
+				spi-max-frequency = <40000000>;
+			};
+			flash@2 {
+				compatible = "spansion,s25sl12801";
+				reg = <2>;
+				spi-max-frequency = <40000000>;
+			};
+			flash@3 {
+				compatible = "spansion,s25sl12801";
+				reg = <3>;
+				spi-max-frequency = <40000000>;
+			};
+		};
+
 		dma@21300 {
 			#address-cells = <1>;
 			#size-cells = <1>;
diff --git a/arch/powerpc/boot/dts/p4080ds.dts b/arch/powerpc/boot/dts/p4080ds.dts
index 6b29eab..48437ad 100644
--- a/arch/powerpc/boot/dts/p4080ds.dts
+++ b/arch/powerpc/boot/dts/p4080ds.dts
@@ -236,22 +236,19 @@
 		};
 
 		spi@110000 {
-			cell-index = <0>;
 			#address-cells = <1>;
 			#size-cells = <0>;
-			compatible = "fsl,espi";
+			compatible = "fsl,mpc8536-espi";
 			reg = <0x110000 0x1000>;
 			interrupts = <53 0x2>;
 			interrupt-parent = <&mpic>;
-			espi,num-ss-bits = <4>;
-			mode = "cpu";
+			fsl,espi-num-chipselects = <4>;
 
-			fsl_m25p80@0 {
+			flash@0 {
 				#address-cells = <1>;
 				#size-cells = <1>;
-				compatible = "fsl,espi-flash";
+				compatible = "spansion,s25sl12801";
 				reg = <0>;
-				linux,modalias = "fsl_m25p80";
 				spi-max-frequency = <40000000>; /* input clock */
 				partition@u-boot {
 					label = "u-boot";
-- 
1.6.4

Return-Path: <B21284@freescale.com>
Received: from DB3EHSOBE005.bigfish.com (db3ehsobe005.messaging.microsoft.com
	[213.199.154.143]) by ozlabs.org (Postfix) with ESMTP id 9E66E1007D3
	for <linuxppc-dev@ozlabs.org>; Mon,  2 Aug 2010 18:22:35 +1000 (EST)
Received: from mail27-db3 (localhost.localdomain [127.0.0.1])	by
	mail27-db3-R.bigfish.com (Postfix) with ESMTP id 076BA9D8313	for
	<linuxppc-dev@ozlabs.org>; Mon,  2 Aug 2010 08:07:27 +0000 (UTC)
Received: from DB3EHSMHS002.bigfish.com (unknown [10.3.81.252])	by
	mail27-db3.bigfish.com (Postfix) with ESMTP id B354F1750050	for
	<linuxppc-dev@ozlabs.org>; Mon,  2 Aug 2010 08:07:25 +0000 (UTC)
Received: from az33smr02.freescale.net (az33smr02.freescale.net
	[10.64.34.200])	by az33egw02.freescale.net (8.14.3/8.14.3) with ESMTP
	id o7287Dmd012352	for <linuxppc-dev@ozlabs.org>;
	Mon, 2 Aug 2010 01:07:23 -0700 (MST)
Received: from zch01exm21.fsl.freescale.net (zch01exm21.ap.freescale.net
	[10.192.129.205])	by az33smr02.freescale.net (8.13.1/8.13.0) with ESMTP
	id o7287BM6014167	for <linuxppc-dev@ozlabs.org>;
	Mon, 2 Aug 2010 03:07:18 -0500 (CDT)
From: Mingkai Hu <Mingkai.hu@freescale.com>
To: linuxppc-dev@ozlabs.org, spi-devel-general@lists.sourceforge.net
Subject: [PATCH v2 5/6] powerpc/of: add eSPI controller dts bindings
Date: Mon, 2 Aug 2010 15:52:03 +0800
Message-ID: <1280735524-17547-6-git-send-email-Mingkai.hu@freescale.com>
In-Reply-To: <1280735524-17547-5-git-send-email-Mingkai.hu@freescale.com>
References: <1280735524-17547-1-git-send-email-Mingkai.hu@freescale.com>
	<1280735524-17547-2-git-send-email-Mingkai.hu@freescale.com>
	<1280735524-17547-3-git-send-email-Mingkai.hu@freescale.com>
	<1280735524-17547-4-git-send-email-Mingkai.hu@freescale.com>
	<1280735524-17547-5-git-send-email-Mingkai.hu@freescale.com>
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

Also modifiy the document of cell-index in SPI controller.

Signed-off-by: Mingkai Hu <Mingkai.hu@freescale.com>
---

v2:
 - Add cell-index clarification
 - Add mpc8536 chip name to the compatible value

 Documentation/powerpc/dts-bindings/fsl/spi.txt |   24 +++++++++++++++++++++++-
 1 files changed, 23 insertions(+), 1 deletions(-)

diff --git a/Documentation/powerpc/dts-bindings/fsl/spi.txt b/Documentation/powerpc/dts-bindings/fsl/spi.txt
index 80510c0..01543ca 100644
--- a/Documentation/powerpc/dts-bindings/fsl/spi.txt
+++ b/Documentation/powerpc/dts-bindings/fsl/spi.txt
@@ -1,7 +1,9 @@
 * SPI (Serial Peripheral Interface)
 
 Required properties:
-- cell-index : SPI controller index.
+- cell-index : QE SPI subblock index.
+ 	       0: QE subblock SPI1
+ 	       1: QE subblock SPI2
 - compatible : should be "fsl,spi".
 - mode : the SPI operation mode, it can be "cpu" or "cpu-qe".
 - reg : Offset and length of the register set for the device
@@ -29,3 +31,23 @@ Example:
 		gpios = <&gpio 18 1	// device reg=<0>
 			 &gpio 19 1>;	// device reg=<1>
 	};
+
+
+* eSPI (Enhanced Serial Peripheral Interface)
+
+Required properties:
+- compatible : should be "fsl,mpc8536-espi".
+- reg : Offset and length of the register set for the device.
+- interrupts : should contain eSPI interrupt, the device has one interrupt.
+- fsl,espi-num-chipselects : the number of the chipselect signals.
+
+Example:
+	spi@110000 {
+		#address-cells = <1>;
+		#size-cells = <0>;
+		compatible = "fsl,espi";
+		reg = <0x110000 0x1000>;
+		interrupts = <53 0x2>;
+		interrupt-parent = <&mpic>;
+		fsl,espi-num-chipselects = <4>;
+	};
-- 
1.6.4

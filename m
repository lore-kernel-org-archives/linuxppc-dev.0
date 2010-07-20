Return-Path: <B21284@freescale.com>
Received: from VA3EHSOBE008.bigfish.com (va3ehsobe006.messaging.microsoft.com
	[216.32.180.16]) by ozlabs.org (Postfix) with ESMTP id 68884B6EF2
	for <linuxppc-dev@ozlabs.org>; Tue, 20 Jul 2010 12:22:31 +1000 (EST)
Received: from mail14-va3 (localhost.localdomain [127.0.0.1])	by
	mail14-va3-R.bigfish.com (Postfix) with ESMTP id 96C2E850062	for
	<linuxppc-dev@ozlabs.org>; Tue, 20 Jul 2010 02:22:28 +0000 (UTC)
Received: from VA3EHSMHS003.bigfish.com (unknown [10.7.14.245])	by
	mail14-va3.bigfish.com (Postfix) with ESMTP id B606B1450053	for
	<linuxppc-dev@ozlabs.org>; Tue, 20 Jul 2010 02:21:28 +0000 (UTC)
Received: from de01smr01.freescale.net (de01smr01.freescale.net [10.208.0.31])
	by az33egw02.freescale.net (8.14.3/8.14.3) with ESMTP id
	o6K2LPoY006765	for
	<linuxppc-dev@ozlabs.org>; Mon, 19 Jul 2010 19:21:26 -0700 (MST)
Received: from zch01exm21.fsl.freescale.net (zch01exm21.ap.freescale.net
	[10.192.129.205])	by de01smr01.freescale.net (8.13.1/8.13.0) with ESMTP
	id o6K2XWDj023963	for <linuxppc-dev@ozlabs.org>;
	Mon, 19 Jul 2010 21:33:41 -0500 (CDT)
From: Mingkai Hu <Mingkai.hu@freescale.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 5/6] powerpc/of: add eSPI controller dts bindings
Date: Tue, 20 Jul 2010 10:08:24 +0800
Message-ID: <1279591705-7574-6-git-send-email-Mingkai.hu@freescale.com>
In-Reply-To: <1279591705-7574-5-git-send-email-Mingkai.hu@freescale.com>
References: <1279591705-7574-1-git-send-email-Mingkai.hu@freescale.com>
	<1279591705-7574-2-git-send-email-Mingkai.hu@freescale.com>
	<1279591705-7574-3-git-send-email-Mingkai.hu@freescale.com>
	<1279591705-7574-4-git-send-email-Mingkai.hu@freescale.com>
	<1279591705-7574-5-git-send-email-Mingkai.hu@freescale.com>
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
 Documentation/powerpc/dts-bindings/fsl/spi.txt |   20 ++++++++++++++++++++
 1 files changed, 20 insertions(+), 0 deletions(-)

diff --git a/Documentation/powerpc/dts-bindings/fsl/spi.txt b/Documentation/powerpc/dts-bindings/fsl/spi.txt
index 80510c0..b360bf9 100644
--- a/Documentation/powerpc/dts-bindings/fsl/spi.txt
+++ b/Documentation/powerpc/dts-bindings/fsl/spi.txt
@@ -29,3 +29,23 @@ Example:
 		gpios = <&gpio 18 1	// device reg=<0>
 			 &gpio 19 1>;	// device reg=<1>
 	};
+
+
+* eSPI (Enhanced Serial Peripheral Interface)
+
+Required properties:
+- compatible : should be "fsl,espi".
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

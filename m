Return-Path: <B21284@freescale.com>
Received: from VA3EHSOBE008.bigfish.com (va3ehsobe006.messaging.microsoft.com
	[216.32.180.16]) by ozlabs.org (Postfix) with ESMTP id C2128B70B8
	for <linuxppc-dev@ozlabs.org>; Thu, 30 Sep 2010 18:26:15 +1000 (EST)
Received: from mail50-va3 (localhost.localdomain [127.0.0.1])	by
	mail50-va3-R.bigfish.com (Postfix) with ESMTP id 1E820193827C	for
	<linuxppc-dev@ozlabs.org>; Thu, 30 Sep 2010 08:26:13 +0000 (UTC)
Received: from VA3EHSMHS020.bigfish.com (unknown [10.7.14.243])	by
	mail50-va3.bigfish.com (Postfix) with ESMTP id D4FCC510050	for
	<linuxppc-dev@ozlabs.org>; Thu, 30 Sep 2010 08:26:12 +0000 (UTC)
Received: from de01smr02.am.mot.com (de01smr02.freescale.net [10.208.0.151])
	by de01egw01.freescale.net (8.14.3/8.14.3) with ESMTP id
	o8U8QAXW006864	for
	<linuxppc-dev@ozlabs.org>; Thu, 30 Sep 2010 01:26:10 -0700 (MST)
Received: from zch01exm21.fsl.freescale.net (zch01exm21.ap.freescale.net
	[10.192.129.205])	by de01smr02.am.mot.com (8.13.1/8.13.0) with ESMTP id
	o8U8fXHI017737	for <linuxppc-dev@ozlabs.org>;
	Thu, 30 Sep 2010 03:41:53 -0500 (CDT)
From: Mingkai Hu <Mingkai.hu@freescale.com>
To: linuxppc-dev@ozlabs.org, spi-devel-general@lists.sourceforge.net,
	linux-mtd@lists.infradead.org
Subject: [PATCH v3 7/7] DTS: add fsl,spi-quirk-trans-len-limit property
Date: Thu, 30 Sep 2010 16:00:46 +0800
Message-ID: <1285833646-12006-8-git-send-email-Mingkai.hu@freescale.com>
In-Reply-To: <1285833646-12006-7-git-send-email-Mingkai.hu@freescale.com>
References: <1285833646-12006-1-git-send-email-Mingkai.hu@freescale.com>
	<1285833646-12006-2-git-send-email-Mingkai.hu@freescale.com>
	<1285833646-12006-3-git-send-email-Mingkai.hu@freescale.com>
	<1285833646-12006-4-git-send-email-Mingkai.hu@freescale.com>
	<1285833646-12006-5-git-send-email-Mingkai.hu@freescale.com>
	<1285833646-12006-6-git-send-email-Mingkai.hu@freescale.com>
	<1285833646-12006-7-git-send-email-Mingkai.hu@freescale.com>
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
v3:
 - Add "spi-quirk-trans-len-limit" property to the board's dts.

 Documentation/powerpc/dts-bindings/fsl/spi.txt |    3 +++
 arch/powerpc/boot/dts/mpc8536ds.dts            |    1 +
 arch/powerpc/boot/dts/p4080ds.dts              |    1 +
 3 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/Documentation/powerpc/dts-bindings/fsl/spi.txt b/Documentation/powerpc/dts-bindings/fsl/spi.txt
index 777abd7..e1cb84e 100644
--- a/Documentation/powerpc/dts-bindings/fsl/spi.txt
+++ b/Documentation/powerpc/dts-bindings/fsl/spi.txt
@@ -41,6 +41,9 @@ Required properties:
 - interrupts : should contain eSPI interrupt, the device has one interrupt.
 - fsl,espi-num-chipselects : the number of the chipselect signals.
 
+Optional properties:
+- fsl,spi-quirk-trans-len-limit : the max trans length is limited to 0xFFFF.
+
 Example:
 	spi@110000 {
 		#address-cells = <1>;
diff --git a/arch/powerpc/boot/dts/mpc8536ds.dts b/arch/powerpc/boot/dts/mpc8536ds.dts
index a75c10e..6911c76 100644
--- a/arch/powerpc/boot/dts/mpc8536ds.dts
+++ b/arch/powerpc/boot/dts/mpc8536ds.dts
@@ -116,6 +116,7 @@
 			interrupts = <59 0x2>;
 			interrupt-parent = <&mpic>;
 			fsl,espi-num-chipselects = <4>;
+			fsl,spi-quirk-trans-len-limit;
 
 			flash@0 {
 				#address-cells = <1>;
diff --git a/arch/powerpc/boot/dts/p4080ds.dts b/arch/powerpc/boot/dts/p4080ds.dts
index 5b7fc29..060fc45 100644
--- a/arch/powerpc/boot/dts/p4080ds.dts
+++ b/arch/powerpc/boot/dts/p4080ds.dts
@@ -243,6 +243,7 @@
 			interrupts = <53 0x2>;
 			interrupt-parent = <&mpic>;
 			fsl,espi-num-chipselects = <4>;
+			fsl,spi-quirk-trans-len-limit;
 
 			flash@0 {
 				#address-cells = <1>;
-- 
1.6.4

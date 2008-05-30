Return-Path: <timur@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 0E827DDFF2
	for <linuxppc-dev@ozlabs.org>; Sat, 31 May 2008 08:12:12 +1000 (EST)
From: Timur Tabi <timur@freescale.com>
To: linuxppc-dev@ozlabs.org, galak@kernel.crashing.org
Subject: [PATCH] Fix DMA nodes in the MPC8610 HPCD device tree
Date: Fri, 30 May 2008 17:12:05 -0500
Message-Id: <1212185525-20944-1-git-send-email-timur@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

The node for DMA2 in the MPC8610 HPCD device tree has the wrong compatible
properties.  This breaks the DMA driver and the sound driver.

Signed-off-by: Timur Tabi <timur@freescale.com>
---

I have no idea how I let this bug slip in, but this is a must-fix for 2.6.26.

 arch/powerpc/boot/dts/mpc8610_hpcd.dts |   10 +++++-----
 1 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/powerpc/boot/dts/mpc8610_hpcd.dts b/arch/powerpc/boot/dts/mpc8610_hpcd.dts
index 08a780d..fa9b6bb 100644
--- a/arch/powerpc/boot/dts/mpc8610_hpcd.dts
+++ b/arch/powerpc/boot/dts/mpc8610_hpcd.dts
@@ -251,14 +251,14 @@
 		dma@c300 {
 			#address-cells = <1>;
 			#size-cells = <1>;
-			compatible = "fsl,mpc8610-dma", "fsl,mpc8540-dma";
+			compatible = "fsl,mpc8610-dma", "fsl,eloplus-dma";
 			cell-index = <1>;
 			reg = <0xc300 0x4>; /* DMA general status register */
 			ranges = <0x0 0xc100 0x200>;
 
 			dma-channel@0 {
 				compatible = "fsl,mpc8610-dma-channel",
-					"fsl,mpc8540-dma-channel";
+					"fsl,eloplus-dma-channel";
 				cell-index = <0>;
 				reg = <0x0 0x80>;
 				interrupt-parent = <&mpic>;
@@ -266,7 +266,7 @@
 			};
 			dma-channel@1 {
 				compatible = "fsl,mpc8610-dma-channel",
-					"fsl,mpc8540-dma-channel";
+					"fsl,eloplus-dma-channel";
 				cell-index = <1>;
 				reg = <0x80 0x80>;
 				interrupt-parent = <&mpic>;
@@ -274,7 +274,7 @@
 			};
 			dma-channel@2 {
 				compatible = "fsl,mpc8610-dma-channel",
-					"fsl,mpc8540-dma-channel";
+					"fsl,eloplus-dma-channel";
 				cell-index = <2>;
 				reg = <0x100 0x80>;
 				interrupt-parent = <&mpic>;
@@ -282,7 +282,7 @@
 			};
 			dma-channel@3 {
 				compatible = "fsl,mpc8610-dma-channel",
-					"fsl,mpc8540-dma-channel";
+					"fsl,eloplus-dma-channel";
 				cell-index = <3>;
 				reg = <0x180 0x80>;
 				interrupt-parent = <&mpic>;
-- 
1.5.5

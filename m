Return-Path: <Wei.Zhang@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id B9566DDEC0
	for <linuxppc-dev@ozlabs.org>; Fri,  7 Sep 2007 20:44:54 +1000 (EST)
Received: from az33smr01.freescale.net (az33smr01.freescale.net [10.64.34.199])
	by az33egw02.freescale.net (8.12.11/az33egw02) with ESMTP id
	l87Ain4s001563
	for <linuxppc-dev@ozlabs.org>; Fri, 7 Sep 2007 03:44:50 -0700 (MST)
Received: from zch01exm26.fsl.freescale.net (zch01exm26.ap.freescale.net
	[10.192.129.221])
	by az33smr01.freescale.net (8.13.1/8.13.0) with ESMTP id l87AilIJ017097
	for <linuxppc-dev@ozlabs.org>; Fri, 7 Sep 2007 05:44:49 -0500 (CDT)
From: Zhang Wei <wei.zhang@freescale.com>
To: paulus@samba.org
Subject: [PATCH 1/5] Add Freescale DMA and DMA channel to
	Documentation/powerpc/booting-without-of.txt file.
Date: Fri,  7 Sep 2007 18:53:52 +0800
Message-Id: <1189162437484-git-send-email-wei.zhang@freescale.com>
In-Reply-To: <11891624353752-git-send-email-wei.zhang@freescale.com>
References: <11891624353752-git-send-email-wei.zhang@freescale.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This patch adds Freescale DMA and DMA channel definition to
Documentation/powerpc/booting-without-of.txt file.

Signed-off-by: Zhang Wei <wei.zhang@freescale.com>
Signed-off-by: Ebony Zhu <ebony.zhu@freescale.com>
---
 Documentation/powerpc/booting-without-of.txt |   67 ++++++++++++++++++++++++++
 1 files changed, 67 insertions(+), 0 deletions(-)

diff --git a/Documentation/powerpc/booting-without-of.txt b/Documentation/powerpc/booting-without-of.txt
index 76733a3..d114edf 100644
--- a/Documentation/powerpc/booting-without-of.txt
+++ b/Documentation/powerpc/booting-without-of.txt
@@ -52,6 +52,8 @@ Table of Contents
       i) Freescale QUICC Engine module (QE)
       j) Flash chip nodes
       k) Global Utilities Block
+      l) Freescale DMA
+      m) Freescale DMA channel
 
   VII - Specifying interrupt information for devices
     1) interrupts property
@@ -1824,6 +1826,71 @@ platforms are moved over to use the flattened-device-tree model.
 		fsl,has-rstcr;
 	};
 
+   l) Freescale DMA
+
+   The DMA for dma-engine driver of Freescale MPC8540 silicon DMA
+   controller which also fit for MPC8560, MPC8555,
+   MPC8548, MPC8641 and MPC8349 silicon DMA controller,
+
+   For each DMA node, you should define channels included.
+   Please see below 'm) Freescale DMA channel' for DMA channel's definition.
+
+   Required properties:
+
+    - compatible : Should be "fsl,dma".
+    - reg : Offset and length of DMA general status register.
+    - ranges : Should be defined as specified in 1) to describe the
+               DMA controller channels.
+
+  Example:
+	dma@21000 {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		compatible = "fsl,dma";
+		reg = <21300 4>;
+		ranges = <0 21100 200>;
+		dma-channel@0 {
+			#address-cells = <1>;
+			#size-cells = <1>;
+			compatible = "fsl,mpc8540-dma-channel";
+			reg = <0 80>;
+			interrupt-parent = <&mpic>;
+			interrupts = <14 2>;
+		};
+		dma-channel@80 {
+			#address-cells = <1>;
+			#size-cells = <1>;
+			compatible = "fsl,mpc8540-dma-channel";
+			reg = <80 80>;
+			interrupt-parent = <&mpic>;
+			interrupts = <15 2>;
+		};
+		dma-channel@100 {
+			#address-cells = <1>;
+			#size-cells = <1>;
+			compatible = "fsl,mpc8540-dma-channel";
+			reg = <100 80>;
+			interrupt-parent = <&mpic>;
+			interrupts = <16 2>;
+		};
+		dma-channel@180 {
+			#address-cells = <1>;
+			#size-cells = <1>;
+			compatible = "fsl,mpc8540-dma-channel";
+			reg = <180 80>;
+			interrupt-parent = <&mpic>;
+			interrupts = <17 2>;
+		};
+	};
+
+   m) Freescale DMA channel
+
+   Required properties:
+
+    - compatible : Should be "fsl,mpc8540-dma-channel"
+                   or "fsl,mpc8349-dma-channel"
+    - reg : Offset and length of the register set for the DMA channel.
+
    More devices will be defined as this spec matures.
 
 VII - Specifying interrupt information for devices
-- 
1.5.2

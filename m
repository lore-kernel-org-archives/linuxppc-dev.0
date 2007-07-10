Return-Path: <wei.zhang@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 2E24FDDF70
	for <linuxppc-dev@ozlabs.org>; Tue, 10 Jul 2007 19:36:58 +1000 (EST)
From: Zhang Wei <wei.zhang@freescale.com>
To: paulus@samba.org, galak@kernel.crashing.org
Subject: [PATCH 1/4] Add DMA sector to
	Documentation/powerpc/booting-without-of.txt file.
Date: Tue, 10 Jul 2007 17:44:21 +0800
Message-Id: <11840606624025-git-send-email-wei.zhang@freescale.com>
In-Reply-To: <1184060662530-git-send-email-wei.zhang@freescale.com>
References: <1184060662530-git-send-email-wei.zhang@freescale.com>
Sender: Zhang Wei <wei.zhang@freescale.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This patch adds DMA sector to Documentation/powerpc/booting-without-of.txt file.

Signed-off-by: Zhang Wei <wei.zhang@freescale.com>
Signed-off-by: Ebony Zhu <ebony.zhu@freescale.com>
---
 Documentation/powerpc/booting-without-of.txt |   60 ++++++++++++++++++++++++++
 1 files changed, 60 insertions(+), 0 deletions(-)

diff --git a/Documentation/powerpc/booting-without-of.txt b/Documentation/powerpc/booting-without-of.txt
index c169299..08c619f 100644
--- a/Documentation/powerpc/booting-without-of.txt
+++ b/Documentation/powerpc/booting-without-of.txt
@@ -1790,6 +1790,66 @@ platforms are moved over to use the flattened-device-tree model.
  		partition-names = "fs\0firmware";
  	};
 
+   k) DMA
+
+   This sector define DMA for dma-engine driver of Freescale
+   MPC8xxx silicon. For each DMA setor, you should define
+   channels included.
+   Please see below 'l) DMA channel' for DMA channel's definition.
+
+   Required properties:
+
+    - compatible : Should be "fsl,mpc8xxx-dma"
+    - reg : Offset and length of the register set for the device
+    - ranges : Should be defined as specified in 1) to describe the
+               DMA controller's register.
+
+  Example:
+	dma@21000{
+		compatible = "fsl,mpc8xxx-dma";
+		reg = <21000 100>;
+		ranges = <0 21000 1000>;
+		ch0@100{
+			reg = <100 80>;
+			extended;
+			reserved;
+			interrupt-parent = <&mpic>;
+			interrupts = <14 2>;
+		};
+		ch1@180{
+			reg = <180 80>;
+			extended;
+			reserved;
+			interrupt-parent = <&mpic>;
+			interrupts = <15 2>;
+		};
+		ch2@200{
+			reg = <200 80>;
+			extended;
+			interrupt-parent = <&mpic>;
+			interrupts = <16 2>;
+		};
+		ch3@280{
+			reg = <280 80>;
+			extended;
+			interrupt-parent = <&mpic>;
+			interrupts = <17 2>;
+		};
+	};
+
+   l) DMA channel
+
+   Required properties:
+
+    - reg : Offset and length of the register set for the device
+
+   Recommended properties :
+
+    - extended : Set the DMA channel to work at extended chain mode.
+                 If not set, the DMA channel will work at basic
+                 chain mode.
+    - reserved : Reserve the DMA channel to device.
+
    More devices will be defined as this spec matures.
 
 VII - Specifying interrupt information for devices
-- 
1.5.1

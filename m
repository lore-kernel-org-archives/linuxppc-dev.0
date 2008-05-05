Return-Path: <Jason.Jin@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 4EB79DDEE8
	for <linuxppc-dev@ozlabs.org>; Mon,  5 May 2008 17:50:26 +1000 (EST)
Received: from az33smr01.freescale.net (az33smr01.freescale.net [10.64.34.199])
	by az33egw01.freescale.net (8.12.11/az33egw01) with ESMTP id
	m457oLTE022199
	for <linuxppc-dev@ozlabs.org>; Mon, 5 May 2008 00:50:22 -0700 (MST)
Received: from zch01exm21.fsl.freescale.net (zch01exm21.ap.freescale.net
	[10.192.129.205])
	by az33smr01.freescale.net (8.13.1/8.13.0) with ESMTP id m457oGRF012846
	for <linuxppc-dev@ozlabs.org>; Mon, 5 May 2008 02:50:21 -0500 (CDT)
From: Jason Jin <Jason.jin@freescale.com>
To: galak@kernel.crashing.org
Subject: [PATCH 4/4] booting-without-of for Freescale MSI
Date: Mon,  5 May 2008 15:47:14 +0800
Message-Id: <1209973634-1699-4-git-send-email-Jason.jin@freescale.com>
In-Reply-To: <1209973634-1699-3-git-send-email-Jason.jin@freescale.com>
References: <1209973634-1699-1-git-send-email-Jason.jin@freescale.com>
	<1209973634-1699-2-git-send-email-Jason.jin@freescale.com>
	<1209973634-1699-3-git-send-email-Jason.jin@freescale.com>
Cc: linuxppc-dev@ozlabs.org, Jason Jin <Jason.jin@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Binding document adding for Freescale MSI support.

Signed-off-by: Jason Jin <Jason.jin@freescale.com>
---
 Documentation/powerpc/booting-without-of.txt |   37 +++++++++++++++++++++++++-
 1 files changed, 36 insertions(+), 1 deletions(-)

diff --git a/Documentation/powerpc/booting-without-of.txt b/Documentation/powerpc/booting-without-of.txt
index 1d2a772..9c496f6 100644
--- a/Documentation/powerpc/booting-without-of.txt
+++ b/Documentation/powerpc/booting-without-of.txt
@@ -57,7 +57,10 @@ Table of Contents
       n) 4xx/Axon EMAC ethernet nodes
       o) Xilinx IP cores
       p) Freescale Synchronous Serial Interface
-	  q) USB EHCI controllers
+      q) USB EHCI controllers
+      r) Freescale Display Interface Unit
+      s) Freescale on board FPGA
+      t) Freescael MSI interrupt controller
 
   VII - Marvell Discovery mv64[345]6x System Controller chips
     1) The /system-controller node
@@ -2870,6 +2873,38 @@ platforms are moved over to use the flattened-device-tree model.
 		reg = <0xe8000000 32>;
 	};
 
+    t) Freescale MSI interrupt controller
+
+    Reguired properities:
+    - compatible : should be "fsl,MPIC-MSI" for 85xx/86xx cpu,
+      and "fsl,IPIC-MSI" for 83xx cpu.
+    - reg : should contain the address and the length of the shared message
+      interrupt register set.
+    - msi-available-ranges: use <start count> style section to define which
+      msi interrupt can be used in the 256 msi interrupts.
+    - interrupts : should contain the msi interrupts cascade to the host
+      interrupt controller.
+    - interrupt-parent: should be "&mpic" for 85xx/86xx cpu and "&ipic"
+      for 83xx cpu.
+
+    Example (85xx/86xx)
+	msi@41600 {
+		compatible = "fsl,MPIC-MSI";
+		reg = <0x41600 0x80>;
+		msi-available-ranges = <0 0x100>;
+		interrupts = <
+			0xb0 0
+			0xb1 0
+			0xb2 0
+			0xb3 0
+			0xb4 0
+			0xb5 0
+			0xb6 0
+			0xb7 0>;
+		interrupt-parent = <&mpic>;
+	};
+
+
 VII - Marvell Discovery mv64[345]6x System Controller chips
 ===========================================================
 
-- 
1.5.4

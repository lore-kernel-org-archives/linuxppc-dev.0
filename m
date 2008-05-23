Return-Path: <Jason.Jin@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 6D05BDE155
	for <linuxppc-dev@ozlabs.org>; Fri, 23 May 2008 18:34:42 +1000 (EST)
Received: from de01smr01.freescale.net (de01smr01.freescale.net [10.208.0.31])
	by de01egw02.freescale.net (8.12.11/de01egw02) with ESMTP id
	m4N8YWJc006721
	for <linuxppc-dev@ozlabs.org>; Fri, 23 May 2008 01:34:32 -0700 (MST)
Received: from zch01exm21.fsl.freescale.net (zch01exm21.ap.freescale.net
	[10.192.129.205])
	by de01smr01.freescale.net (8.13.1/8.13.0) with ESMTP id m4N8YUqW012505
	for <linuxppc-dev@ozlabs.org>; Fri, 23 May 2008 03:34:31 -0500 (CDT)
From: Jason Jin <Jason.jin@freescale.com>
To: galak@kernel.crashing.org
Subject: [PATCH 1/4 V5] booting-without-of for Freescale MSI
Date: Fri, 23 May 2008 16:32:45 +0800
Message-Id: <1211531568-31402-1-git-send-email-Jason.jin@freescale.com>
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
In this version:
The example node changed due to the hwirq num change of MSI.

 Documentation/powerpc/booting-without-of.txt |   43 +++++++++++++++++++++++++-
 1 files changed, 42 insertions(+), 1 deletions(-)

diff --git a/Documentation/powerpc/booting-without-of.txt b/Documentation/powerpc/booting-without-of.txt
index 1d2a772..c67d2f5 100644
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
@@ -2870,6 +2873,44 @@ platforms are moved over to use the flattened-device-tree model.
 		reg = <0xe8000000 32>;
 	};
 
+    t) Freescale MSI interrupt controller
+
+    Reguired properities:
+    - compatible : compatible list, contains 2 entries,
+      first is "fsl,CHIP-msi", where CHIP is the processor(mpc8610, mpc8572,
+      etc.) and the second is "fsl,mpic-msi" or "fsl,ipic-msi" depending on
+      the parent type.
+    - reg : should contain the address and the length of the shared message
+      interrupt register set.
+    - msi-available-ranges: use <start count> style section to define which
+      msi interrupt can be used in the 256 msi interrupts. This property is
+      optional, without this, all the 256 MSI interrupts can be used.
+    - interrupts : each one of the interrupts here is one entry per 32 MSIs,
+      and routed to the host interrupt controller. the interrupts should
+      be set as edge sensitive.
+    - interrupt-parent: the phandle for the interrupt controller
+      that services interrupts for this device. for 83xx cpu, the interrupts
+      are routed to IPIC, and for 85xx/86xx cpu the interrupts are routed
+      to MPIC.
+
+    Example
+	msi@41600 {
+		compatible = "fsl,mpc8610-msi", "fsl,mpic-msi";
+		reg = <0x41600 0x80>;
+		msi-available-ranges = <0 0x100>;
+		interrupts = <
+			0xe0 0
+			0xe1 0
+			0xe2 0
+			0xe3 0
+			0xe4 0
+			0xe5 0
+			0xe6 0
+			0xe7 0>;
+		interrupt-parent = <&mpic>;
+	};
+
+
 VII - Marvell Discovery mv64[345]6x System Controller chips
 ===========================================================
 
-- 
1.5.4

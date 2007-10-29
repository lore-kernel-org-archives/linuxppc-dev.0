Return-Path: <vbarshak@ru.mvista.com>
Received: from vaxon.spb.rtsoft.ru (unknown [212.176.242.38])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id CF328DE0FB
	for <linuxppc-dev@ozlabs.org>; Tue, 30 Oct 2007 06:25:37 +1100 (EST)
Date: Mon, 29 Oct 2007 23:22:20 +0300
From: Valentine Barshak <vbarshak@ru.mvista.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 2/3] PowerPC: 44x NanD Flash Controller (NDFC) bindings
Message-ID: <20071029202220.GA2154@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20071029201738.GA2022@ru.mvista.com>
Cc: tglx@linutronix.de, sr@denx.de, linux-mtd@lists.infradead.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

PowerPC 44x NanD Flash Controller (NDFC) bindings.

Signed-off-by: Valentine Barshak <vbarshak@ru.mvista.com>
---
 Documentation/powerpc/booting-without-of.txt |   64 +++++++++++++++++++++++++++
 1 files changed, 64 insertions(+)

--- linux-2.6.orig/Documentation/powerpc/booting-without-of.txt	2007-10-29 16:02:07.000000000 +0300
+++ linux-2.6/Documentation/powerpc/booting-without-of.txt	2007-10-29 21:34:14.000000000 +0300
@@ -52,6 +52,7 @@ Table of Contents
       i) Freescale QUICC Engine module (QE)
       j) CFI or JEDEC memory-mapped NOR flash
       k) Global Utilities Block
+      l) 44x NanD Flash Controller (NDFC)
 
   VII - Specifying interrupt information for devices
     1) interrupts property
@@ -2242,6 +2243,69 @@ platforms are moved over to use the flat
 			   available.
 			   For Axon: 0x0000012a
 
+  l) 44x NanD Flash Controller (NDFC)
+
+  Required properties:
+  - compatible : should be "ibm,ndfc".
+  - reg : should contain address and length of the NDFC registers.
+  
+  ndfc node should contain at least one ndfc-mtd sub-node describing
+  chip properties and bank settings for the chip(s) attached to particular
+  ndfc bank(s).
+
+  Required ndfc-mtd properties:
+  - bank-map : at least one value (less than number of NDFC banks available)
+    identifying bank number the chip is attached to. If we have several
+    identical chips and want to spread a single mtd device across all of them,
+    we need to specify here the bank numbers the chips are attached to.
+    E.g. "bank-map = <0 3>;" means a single mtd device will be created 
+    for 2 identical NAND chips attached to banks 0 and 3 of the NDFC.
+  Optional ndfc-mtd properties:
+  - chip-options : NAND chip options.
+  - chip-delay : NAND chip delay. Default is 50us.
+  - bank-settings : NDFC bank settings for the chip(s). This value is
+    written to the NDFC Bank Configuration Register.
+    If not specified, the default timings (RR=RWH=RWP=CRW=2) and 
+    bank width from the "bank-width" property will be used for the chip.
+  - bank-width : NAND chip bus width. Should be 1 for 8-bit NAND or 
+    2 for 16-bit NAND. By default an 8-bit width is set.
+  - #address-cells, #size-cells : Must be present if the flash has
+    sub-nodes representing partitions (see below).  In this case
+    both #address-cells and #size-cells must be equal to 1.
+  
+  ndfc_mtd can have partition sub-nodes, which are described the same way
+  as for the CFI or JEDEC memory-mapped NOR flash.
+
+   Example (Sequoia 440EPx):
+   NDFC is relocatable within EBC and should have EBC as a parent node.
+   Here we have NDFC on EBC CS3 bank and one NAND chip attached to bank 3
+   of the NanD Flash Controller:
+
+		ndfc@0,0 {
+			compatible = "ibm,ndfc-440epx", "ibm,ndfc";
+			reg = <3 000000 2000>;
+			ndfc-mtd0 {
+				bank-settings = <80002222>;
+				bank-map = <3>;
+				chip-delay = <32>;
+				#address-cells = <1>;
+				#size-cells = <1>;
+				partition@0 {
+					label = "u-boot-nand";
+					reg = <0 0080000>;
+				};
+				partition@80000 {
+					label = "kernel-nand";
+					reg = <0080000 0180000>;
+				};
+				partition@200000 {
+					label = "filesystem";
+					reg = <0200000 1e00000>;
+				};
+			};
+		};
+
+
    More devices will be defined as this spec matures.
 
 VII - Specifying interrupt information for devices

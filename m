Return-Path: <vbarshak@ru.mvista.com>
Received: from vaxon.spb.rtsoft.ru (unknown [212.176.242.38])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 29114DDECE
	for <linuxppc-dev@ozlabs.org>; Sat, 27 Oct 2007 03:50:05 +1000 (EST)
Date: Fri, 26 Oct 2007 21:47:38 +0400
From: Valentine Barshak <vbarshak@ru.mvista.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] PowerPC: 44x device-tree aware NDFC bindings
Message-ID: <20071026174738.GA13648@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20071026164130.GA11812@ru.mvista.com>
Cc: tglx@linutronix.de, sr@denx.de, linux-mtd@lists.infradead.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

PowerPC 44x NAND Flash Controller (NDFC) bindings

Signed-off-by: Valentine Barshak <vbarshak@ru.mvista.com>
---
 Documentation/powerpc/booting-without-of.txt |   43 +++++++++++++++++++++++++++
 1 files changed, 43 insertions(+)

--- linux-2.6.orig/Documentation/powerpc/booting-without-of.txt	2007-10-26 19:01:43.000000000 +0400
+++ linux-2.6/Documentation/powerpc/booting-without-of.txt	2007-10-26 21:43:33.000000000 +0400
@@ -52,6 +52,7 @@ Table of Contents
       i) Freescale QUICC Engine module (QE)
       j) CFI or JEDEC memory-mapped NOR flash
       k) Global Utilities Block
+      l) 44x NanD Flash Controller (NDFC)
 
   VII - Specifying interrupt information for devices
     1) interrupts property
@@ -2242,6 +2243,48 @@ platforms are moved over to use the flat
 			   available.
 			   For Axon: 0x0000012a
 
+  l) 44x NanD Flash Controller (NDFC)
+
+  Required properties:
+  - compatible : should be "ibm,ndfc".
+  - reg : should contain at address and length of the NDFC registers
+  - bank-width : NAND chip bus width. Should be 1 for 8-bit NAND or 
+		 2 for 16-bit NAND
+  - bank-map : The first 4 bits of this property indicate which of the
+	       4 NDFC banks have chips attached.
+  - #address-cells, #size-cells : Must be present if the flash has
+    sub-nodes representing partitions (see below).  In this case
+    both #address-cells and #size-cells must be equal to 1.
+  
+  NDFC can have partition nodes, which are described the same way
+  as for the CFI or JEDEC memory-mapped NOR flash.
+
+   Example (Sequoia 440EPx):
+   NDFC is relocatable within EBC and should have EBC as a parent node.
+   Here we have NDFC on EBC CS3 bank:
+
+		ndfc@0,0 {
+			compatible = "ibm,ndfc-440epx", "ibm,ndfc";
+			reg = <3 000000 2000>;
+			bank-width = <1>;
+			bank-mask = <8>;
+			#address-cells = <1>;
+			#size-cells = <1>;
+			partition@0 {
+				label = "u-boot-nand";
+				reg = <0 0080000>;
+			};
+			partition@80000 {
+				label = "kernel-nand";
+				reg = <0080000 0180000>;
+			};
+			partition@200000 {
+				label = "filesystem";
+				reg = <0200000 1e00000>;
+			};
+		};
+
+
    More devices will be defined as this spec matures.
 
 VII - Specifying interrupt information for devices

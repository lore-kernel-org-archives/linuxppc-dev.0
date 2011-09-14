Return-Path: <B04825@freescale.com>
Received: from ch1outboundpool.messaging.microsoft.com
	(ch1ehsobe004.messaging.microsoft.com [216.32.181.184])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(Client CN "mail.global.frontbridge.com",
	Issuer "Microsoft Secure Server Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 3C5B5B7105
	for <linuxppc-dev@ozlabs.org>; Thu, 15 Sep 2011 07:43:25 +1000 (EST)
From: Timur Tabi <timur@freescale.com>
To: <kumar.gala@freescale.com>, <linuxppc-dev@ozlabs.org>,
	<devicetree-discuss@lists.ozlabs.org>
Subject: [PATCH] [v2] powerpc/85xx: clean up FPGA device tree nodes for
	Freecsale QorIQ boards
Date: Wed, 14 Sep 2011 16:42:18 -0500
Message-ID: <1316036538-311-1-git-send-email-timur@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Standarize and document the FPGA nodes used on Freescale QorIQ reference
boards.  There are different kinds of FPGAs used on the boards, but
only two are currently standard: "pixis" and "qixis".  Although there are
minor differences among the boards that have one kind of FPGA, most of the
functionality is the same, so it makes sense to create common compatibility
strings.

Signed-off-by: Timur Tabi <timur@freescale.com>
---

v2: removed references to the CPLD

This patch applies on top of "[PATCH 3/4] powerpc/p3060qds: Add support for
P3060QDS board", but it also assumes that the 'ranges' property for the
localbus node on the P3060QDS device tree includes the missing line for
the NAND devices.

 .../devicetree/bindings/powerpc/fsl/board.txt      |   30 ++++++++++++--------
 arch/powerpc/boot/dts/p1022ds.dts                  |    2 +-
 arch/powerpc/boot/dts/p2020ds.dts                  |    5 +++
 arch/powerpc/boot/dts/p3041ds.dts                  |    4 +-
 arch/powerpc/boot/dts/p3060qds.dts                 |    8 ++++-
 arch/powerpc/boot/dts/p4080ds.dts                  |    8 ++++-
 arch/powerpc/boot/dts/p5020ds.dts                  |    4 +-
 7 files changed, 42 insertions(+), 19 deletions(-)

diff --git a/Documentation/devicetree/bindings/powerpc/fsl/board.txt b/Documentation/devicetree/bindings/powerpc/fsl/board.txt
index 39e9415..ba46a7a 100644
--- a/Documentation/devicetree/bindings/powerpc/fsl/board.txt
+++ b/Documentation/devicetree/bindings/powerpc/fsl/board.txt
@@ -1,3 +1,8 @@
+Freescale Reference Board Bindings
+
+This document describes device tree bindings for various devices that
+exist on some Freescale reference boards.
+
 * Board Control and Status (BCSR)
 
 Required properties:
@@ -12,25 +17,26 @@ Example:
 		reg = <f8000000 8000>;
 	};
 
-* Freescale on board FPGA
+* Freescale on-board FPGA
 
 This is the memory-mapped registers for on board FPGA.
 
 Required properities:
-- compatible : should be "fsl,fpga-pixis".
-- reg : should contain the address and the length of the FPPGA register
-  set.
+- compatible: should be a board-specific string followed by a string
+  indicating the type of FPGA.  Example:
+	"fsl,<board>-pixis", "fsl,fpga-pixis"
+- reg: should contain the address and the length of the FPGA register set.
 - interrupt-parent: should specify phandle for the interrupt controller.
-- interrupts : should specify event (wakeup) IRQ.
+- interrupts: should specify event (wakeup) IRQ.
 
-Example (MPC8610HPCD):
+Example (P1022DS):
 
-	board-control@e8000000 {
-		compatible = "fsl,fpga-pixis";
-		reg = <0xe8000000 32>;
-		interrupt-parent = <&mpic>;
-		interrupts = <8 8>;
-	};
+	 board-control@3,0 {
+		 compatible = "fsl,p1022ds-pixis", "fsl,fpga-pixis";
+		 reg = <3 0 0x30>;
+		 interrupt-parent = <&mpic>;
+		 interrupts = <8 8 0 0>;
+	 };
 
 * Freescale BCSR GPIO banks
 
diff --git a/arch/powerpc/boot/dts/p1022ds.dts b/arch/powerpc/boot/dts/p1022ds.dts
index 1be9743..97a0b87 100644
--- a/arch/powerpc/boot/dts/p1022ds.dts
+++ b/arch/powerpc/boot/dts/p1022ds.dts
@@ -150,7 +150,7 @@
 		};
 
 		board-control@3,0 {
-			compatible = "fsl,p1022ds-pixis";
+			compatible = "fsl,p1022ds-pixis", "fsl,fpga-pixis";
 			reg = <3 0 0x30>;
 			interrupt-parent = <&mpic>;
 			/*
diff --git a/arch/powerpc/boot/dts/p2020ds.dts b/arch/powerpc/boot/dts/p2020ds.dts
index dae4031..d1e52f3 100644
--- a/arch/powerpc/boot/dts/p2020ds.dts
+++ b/arch/powerpc/boot/dts/p2020ds.dts
@@ -118,6 +118,11 @@
 			};
 		};
 
+		board-control@3,0 {
+			compatible = "fsl,p2020ds-pixis", "fsl,fpga-pixis";
+			reg = <0x3 0x0 0x30>;
+		};
+
 		nand@4,0 {
 			compatible = "fsl,elbc-fcm-nand";
 			reg = <0x4 0x0 0x40000>;
diff --git a/arch/powerpc/boot/dts/p3041ds.dts b/arch/powerpc/boot/dts/p3041ds.dts
index 69cae67..92937ce 100644
--- a/arch/powerpc/boot/dts/p3041ds.dts
+++ b/arch/powerpc/boot/dts/p3041ds.dts
@@ -147,8 +147,8 @@
 		};
 
 		board-control@3,0 {
-			compatible = "fsl,p3041ds-pixis";
-			reg = <3 0 0x20>;
+			compatible = "fsl,p3041ds-pixis", "fsl,fpga-pixis";
+			reg = <3 0 0x30>;
 		};
 	};
 
diff --git a/arch/powerpc/boot/dts/p3060qds.dts b/arch/powerpc/boot/dts/p3060qds.dts
index 55edfd0..6758852 100644
--- a/arch/powerpc/boot/dts/p3060qds.dts
+++ b/arch/powerpc/boot/dts/p3060qds.dts
@@ -109,7 +109,8 @@
 	localbus@ffe124000 {
 		reg = <0xf 0xfe124000 0 0x1000>;
 		ranges = <0 0 0xf 0xe8000000 0x08000000
-			  2 0 0xf 0xffa00000 0x00040000>;
+			  2 0 0xf 0xffa00000 0x00040000
+			  3 0 0xf 0xffdf0000 0x00008000>;
 
 		flash@0,0 {
 			compatible = "cfi-flash";
@@ -155,6 +156,11 @@
 				reg = <0x1f000000 0x21000000>;
 			};
 		};
+
+		board-control@3,0 {
+			compatible = "fsl,p3060qds-qixis", "fsl,fpga-qixis";
+			reg = <3 0 0x100>;
+		};
 	};
 
 	pci0: pcie@ffe200000 {
diff --git a/arch/powerpc/boot/dts/p4080ds.dts b/arch/powerpc/boot/dts/p4080ds.dts
index eb11098..a26cf15 100644
--- a/arch/powerpc/boot/dts/p4080ds.dts
+++ b/arch/powerpc/boot/dts/p4080ds.dts
@@ -108,7 +108,8 @@
 
 	localbus@ffe124000 {
 		reg = <0xf 0xfe124000 0 0x1000>;
-		ranges = <0 0 0xf 0xe8000000 0x08000000>;
+		ranges = <0 0 0xf 0xe8000000 0x08000000
+			  3 0 0xf 0xffdf0000 0x00008000>;
 
 		flash@0,0 {
 			compatible = "cfi-flash";
@@ -116,6 +117,11 @@
 			bank-width = <2>;
 			device-width = <2>;
 		};
+
+		board-control@3,0 {
+			compatible = "fsl,p4080ds-pixis", "fsl,fpga-pixis";
+			reg = <3 0 0x30>;
+		};
 	};
 
 	pci0: pcie@ffe200000 {
diff --git a/arch/powerpc/boot/dts/p5020ds.dts b/arch/powerpc/boot/dts/p5020ds.dts
index 8366e2f..b959986 100644
--- a/arch/powerpc/boot/dts/p5020ds.dts
+++ b/arch/powerpc/boot/dts/p5020ds.dts
@@ -147,8 +147,8 @@
 		};
 
 		board-control@3,0 {
-			compatible = "fsl,p5020ds-pixis";
-			reg = <3 0 0x20>;
+			compatible = "fsl,p5020ds-pixis", "fsl,fpga-pixis";
+			reg = <3 0 0x30>;
 		};
 	};
 
-- 
1.7.3.4

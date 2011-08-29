Return-Path: <B04825@freescale.com>
Received: from AM1EHSOBE001.bigfish.com (am1ehsobe001.messaging.microsoft.com
	[213.199.154.204])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(Client CN "mail.global.frontbridge.com",
	Issuer "Microsoft Secure Server Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 4E956B6F8E
	for <linuxppc-dev@ozlabs.org>; Tue, 30 Aug 2011 05:10:09 +1000 (EST)
From: Timur Tabi <timur@freescale.com>
To: <kumar.gala@freescale.com>, <linuxppc-dev@ozlabs.org>,
	<devicetree-discuss@lists.ozlabs.org>
Subject: [PATCH] powerpc/85xx: clean up FPGA device tree nodes for Freecsale
	QorIQ boards
Date: Mon, 29 Aug 2011 14:09:59 -0500
Message-ID: <1314644999-16955-1-git-send-email-timur@freescale.com>
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
boards.  There are three kinds of FPGAs used on the boards: pixis, qixis, and
cpld.  Although their are minor differences among the boards that have one
kind of FPGA, most of the functionality is the same, so it makes sense
to create common compatibility strings.

Signed-off-by: Timur Tabi <timur@freescale.com>
---

Changes for other Freescale boards will be made in future patches.

 .../devicetree/bindings/powerpc/fsl/board.txt      |   30 ++++++++++++--------
 arch/powerpc/boot/dts/p1010rdb.dts                 |   10 ++----
 arch/powerpc/boot/dts/p1020rdb.dts                 |    7 ++++-
 arch/powerpc/boot/dts/p1022ds.dts                  |    2 +-
 arch/powerpc/boot/dts/p2020ds.dts                  |    5 +++
 arch/powerpc/boot/dts/p2020rdb.dts                 |    4 ++
 arch/powerpc/boot/dts/p2040rdb.dts                 |    8 ++++-
 arch/powerpc/boot/dts/p3041ds.dts                  |    4 +-
 arch/powerpc/boot/dts/p4080ds.dts                  |    8 ++++-
 arch/powerpc/boot/dts/p5020ds.dts                  |    4 +-
 10 files changed, 55 insertions(+), 27 deletions(-)

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
 
diff --git a/arch/powerpc/boot/dts/p1010rdb.dts b/arch/powerpc/boot/dts/p1010rdb.dts
index 6b33b73..7769e40 100644
--- a/arch/powerpc/boot/dts/p1010rdb.dts
+++ b/arch/powerpc/boot/dts/p1010rdb.dts
@@ -116,13 +116,9 @@
 			};
 		};
 
-		cpld@3,0 {
-			#address-cells = <1>;
-			#size-cells = <1>;
-			compatible = "fsl,p1010rdb-cpld";
-			reg = <0x3 0x0 0x0000020>;
-			bank-width = <1>;
-			device-width = <1>;
+		board-control@3,0 {
+			compatible = "fsl,p1010rdb-cpld", "fsl,fpga-cpld";
+			reg = <0x3 0x0 0x20>;
 		};
 	};
 
diff --git a/arch/powerpc/boot/dts/p1020rdb.dts b/arch/powerpc/boot/dts/p1020rdb.dts
index d6a8ae4..982d3ea 100644
--- a/arch/powerpc/boot/dts/p1020rdb.dts
+++ b/arch/powerpc/boot/dts/p1020rdb.dts
@@ -34,7 +34,8 @@
 		/* NOR, NAND Flashes and Vitesse 5 port L2 switch */
 		ranges = <0x0 0x0 0x0 0xef000000 0x01000000
 			  0x1 0x0 0x0 0xffa00000 0x00040000
-			  0x2 0x0 0x0 0xffb00000 0x00020000>;
+			  0x2 0x0 0x0 0xffb00000 0x00020000
+			  0x3 0x0 0x0 0xffdf0000 0x00008000>;
 
 		nor@0,0 {
 			#address-cells = <1>;
@@ -138,6 +139,10 @@
 			reg = <0x2 0x0 0x20000>;
 		};
 
+		board-control@3,0 {
+			compatible = "fsl,p1020rdb-cpld", "fsl,fpga-cpld";
+			reg = <0x3 0x0 0x20>;
+		};
 	};
 
 	soc@ffe00000 {
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
diff --git a/arch/powerpc/boot/dts/p2020rdb.dts b/arch/powerpc/boot/dts/p2020rdb.dts
index 1d7a05f..1bf9b8c 100644
--- a/arch/powerpc/boot/dts/p2020rdb.dts
+++ b/arch/powerpc/boot/dts/p2020rdb.dts
@@ -138,6 +138,10 @@
 			reg = <0x2 0x0 0x20000>;
 		};
 
+		board-control@3,0 {
+			compatible = "fsl,p2020rdb-cpld", "fsl,fpga-cpld";
+			reg = <0x3 0x0 0x20>;
+		};
 	};
 
 	soc@ffe00000 {
diff --git a/arch/powerpc/boot/dts/p2040rdb.dts b/arch/powerpc/boot/dts/p2040rdb.dts
index 7d84e39..1c72d65 100644
--- a/arch/powerpc/boot/dts/p2040rdb.dts
+++ b/arch/powerpc/boot/dts/p2040rdb.dts
@@ -109,7 +109,8 @@
 
 	localbus@ffe124000 {
 		reg = <0xf 0xfe124000 0 0x1000>;
-		ranges = <0 0 0xf 0xe8000000 0x08000000>;
+		ranges = <0 0 0xf 0xe8000000 0x08000000
+			  3 0 0xf 0xffdf0000 0x00008000>;
 
 		flash@0,0 {
 			compatible = "cfi-flash";
@@ -117,6 +118,11 @@
 			bank-width = <2>;
 			device-width = <2>;
 		};
+
+		board-control@3,0 {
+			compatible = "fsl,p2040rdb-cpld", "fsl,fpga-cpld";
+			reg = <3 0 0x20>;
+		};
 	};
 
 	pci0: pcie@ffe200000 {
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

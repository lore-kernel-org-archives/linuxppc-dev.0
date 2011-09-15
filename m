Return-Path: <B04825@freescale.com>
Received: from TX2EHSOBE007.bigfish.com (tx2ehsobe004.messaging.microsoft.com
	[65.55.88.14]) (using TLSv1 with cipher AES128-SHA (128/128 bits))
	(Client CN "mail.global.frontbridge.com",
	Issuer "Microsoft Secure Server Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 1DA7DB70BC
	for <linuxppc-dev@ozlabs.org>; Fri, 16 Sep 2011 04:04:20 +1000 (EST)
From: Timur Tabi <timur@freescale.com>
To: <kumar.gala@freescale.com>, <linuxppc-dev@ozlabs.org>,
	<devicetree-discuss@lists.ozlabs.org>
Subject: [PATCH] [v3] powerpc/85xx: clean up FPGA device tree nodes for
	Freecsale QorIQ boards
Date: Thu, 15 Sep 2011 13:04:13 -0500
Message-ID: <1316109853-6665-1-git-send-email-timur@freescale.com>
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
only two are currently standard: "pixis", "ngpixis", and "qixis".  Although
there are minor differences among the boards that have one kind of FPGA, most
of the functionality is the same, so it makes sense to create common
compatibility strings.

We also need to update the P1022DS platform file, because the compatible
string for its PIXIS node has changed.  This means that older kernels are
not compatible with newer device trees.  This is not a real problem, however,
since that particular function doesn't work anyway.  When the DIU is active,
the PIXIS is in "indirect mode", and so cannot be accessed as a memory-mapped
device.

Signed-off-by: Timur Tabi <timur@freescale.com>
---

v3: added "ngpixis" to list

v2: removed references to the CPLD

This patch only adds "ngpixis" nodes, because that's the easiest.  The
P3060QDS device tree already has a qixis node.  Support for older boards
with the old "pixis" will be added later.

 .../devicetree/bindings/powerpc/fsl/board.txt      |   30 ++++++++++++--------
 arch/powerpc/boot/dts/p1022ds.dts                  |    2 +-
 arch/powerpc/boot/dts/p2020ds.dts                  |    5 +++
 arch/powerpc/boot/dts/p3041ds.dts                  |    4 +-
 arch/powerpc/boot/dts/p4080ds.dts                  |    8 ++++-
 arch/powerpc/boot/dts/p5020ds.dts                  |    4 +-
 arch/powerpc/platforms/85xx/p1022_ds.c             |   11 ++++--
 7 files changed, 42 insertions(+), 22 deletions(-)

diff --git a/Documentation/devicetree/bindings/powerpc/fsl/board.txt b/Documentation/devicetree/bindings/powerpc/fsl/board.txt
index 39e9415..380914e 100644
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
+	"fsl,<board>-fpga", "fsl,fpga-pixis"
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
+		 compatible = "fsl,p1022ds-fpga", "fsl,fpga-ngpixis";
+		 reg = <3 0 0x30>;
+		 interrupt-parent = <&mpic>;
+		 interrupts = <8 8 0 0>;
+	 };
 
 * Freescale BCSR GPIO banks
 
diff --git a/arch/powerpc/boot/dts/p1022ds.dts b/arch/powerpc/boot/dts/p1022ds.dts
index 1be9743..b9b8719 100644
--- a/arch/powerpc/boot/dts/p1022ds.dts
+++ b/arch/powerpc/boot/dts/p1022ds.dts
@@ -150,7 +150,7 @@
 		};
 
 		board-control@3,0 {
-			compatible = "fsl,p1022ds-pixis";
+			compatible = "fsl,p1022ds-fpga", "fsl,fpga-ngpixis";
 			reg = <3 0 0x30>;
 			interrupt-parent = <&mpic>;
 			/*
diff --git a/arch/powerpc/boot/dts/p2020ds.dts b/arch/powerpc/boot/dts/p2020ds.dts
index dae4031..66f03d6 100644
--- a/arch/powerpc/boot/dts/p2020ds.dts
+++ b/arch/powerpc/boot/dts/p2020ds.dts
@@ -118,6 +118,11 @@
 			};
 		};
 
+		board-control@3,0 {
+			compatible = "fsl,p2020ds-fpga", "fsl,fpga-ngpixis";
+			reg = <0x3 0x0 0x30>;
+		};
+
 		nand@4,0 {
 			compatible = "fsl,elbc-fcm-nand";
 			reg = <0x4 0x0 0x40000>;
diff --git a/arch/powerpc/boot/dts/p3041ds.dts b/arch/powerpc/boot/dts/p3041ds.dts
index 69cae67..961a74c 100644
--- a/arch/powerpc/boot/dts/p3041ds.dts
+++ b/arch/powerpc/boot/dts/p3041ds.dts
@@ -147,8 +147,8 @@
 		};
 
 		board-control@3,0 {
-			compatible = "fsl,p3041ds-pixis";
-			reg = <3 0 0x20>;
+			compatible = "fsl,p3041ds-fpga", "fsl,fpga-ngpixis";
+			reg = <3 0 0x30>;
 		};
 	};
 
diff --git a/arch/powerpc/boot/dts/p4080ds.dts b/arch/powerpc/boot/dts/p4080ds.dts
index eb11098..ccd53af 100644
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
+			compatible = "fsl,p4080ds-fpga", "fsl,fpga-ngpixis";
+			reg = <3 0 0x30>;
+		};
 	};
 
 	pci0: pcie@ffe200000 {
diff --git a/arch/powerpc/boot/dts/p5020ds.dts b/arch/powerpc/boot/dts/p5020ds.dts
index 8366e2f..ca4d592 100644
--- a/arch/powerpc/boot/dts/p5020ds.dts
+++ b/arch/powerpc/boot/dts/p5020ds.dts
@@ -147,8 +147,8 @@
 		};
 
 		board-control@3,0 {
-			compatible = "fsl,p5020ds-pixis";
-			reg = <3 0 0x20>;
+			compatible = "fsl,p5020ds-fpga", "fsl,fpga-ngpixis";
+			reg = <3 0 0x30>;
 		};
 	};
 
diff --git a/arch/powerpc/platforms/85xx/p1022_ds.c b/arch/powerpc/platforms/85xx/p1022_ds.c
index 266b3aa..6a0b973 100644
--- a/arch/powerpc/platforms/85xx/p1022_ds.c
+++ b/arch/powerpc/platforms/85xx/p1022_ds.c
@@ -128,17 +128,20 @@ static void p1022ds_set_gamma_table(int monitor_port, char *gamma_table_base)
  */
 static void p1022ds_set_monitor_port(int monitor_port)
 {
-	struct device_node *pixis_node;
+	struct device_node *np;
 	void __iomem *pixis;
 	u8 __iomem *brdcfg1;
 
-	pixis_node = of_find_compatible_node(NULL, NULL, "fsl,p1022ds-pixis");
-	if (!pixis_node) {
+	np = of_find_compatible_node(NULL, NULL, "fsl,p1022ds-fpga");
+	if (!np)
+		/* older device trees used "fsl,p1022ds-pixis" */
+		np = of_find_compatible_node(NULL, NULL, "fsl,p1022ds-pixis");
+	if (!np) {
 		pr_err("p1022ds: missing ngPIXIS node\n");
 		return;
 	}
 
-	pixis = of_iomap(pixis_node, 0);
+	pixis = of_iomap(np, 0);
 	if (!pixis) {
 		pr_err("p1022ds: could not map ngPIXIS registers\n");
 		return;
-- 
1.7.3.4

Return-Path: <prvs=0161d7d14c=valentin.longchamp@keymile.com>
Received: from mail-de.keymile.com (mail-de.keymile.com [195.8.104.250])
 (using TLSv1.1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 5AA5B14008A
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 26 Mar 2014 00:42:09 +1100 (EST)
From: Valentin Longchamp <valentin.longchamp@keymile.com>
To: Scott Wood <scottwood@freescale.com>, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v3 2/3] devcietree: bindings: add some MFD Keymile FPGAs
Date: Tue, 25 Mar 2014 14:41:54 +0100
Message-Id: <1395754915-14534-3-git-send-email-valentin.longchamp@keymile.com>
In-Reply-To: <1395754915-14534-1-git-send-email-valentin.longchamp@keymile.com>
References: <1395754915-14534-1-git-send-email-valentin.longchamp@keymile.com>
Cc: devicetree@vger.kernel.org,
 Valentin Longchamp <valentin.longchamp@keymile.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

These are the bindings for 2 MFD devices used on some of the Keymile boards.
The first one is the chassis managmenet bfticu FPGA.
The second one is the board controller (reset, LEDs, GPIOs) QRIO CPDL.
These FPGAs are used in the kmcoge4 board.

This patch also add KEYMILE to the vendor-prefixes.

Signed-off-by: Valentin Longchamp <valentin.longchamp@keymile.com>

---
Changes in v3:
- add a patch with the bindings for the KEYMILE FPGAs

Changes in v2: None

 Documentation/devicetree/bindings/mfd/bfticu.txt   | 26 ++++++++++++++++++++++
 Documentation/devicetree/bindings/mfd/qriox.txt    | 17 ++++++++++++++
 .../devicetree/bindings/vendor-prefixes.txt        |  1 +
 3 files changed, 44 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mfd/bfticu.txt
 create mode 100644 Documentation/devicetree/bindings/mfd/qriox.txt

diff --git a/Documentation/devicetree/bindings/mfd/bfticu.txt b/Documentation/devicetree/bindings/mfd/bfticu.txt
new file mode 100644
index 0000000..92de32e
--- /dev/null
+++ b/Documentation/devicetree/bindings/mfd/bfticu.txt
@@ -0,0 +1,26 @@
+KEYMILE bfticu Chassis Management FPGA
+
+The bfticu is a multifunction device that manages the whole chassis.
+Its main functionality is to collect IRQs from the whole chassis and signals
+them to a single controller.
+
+Required properties:
+- compatible: "keymile,bfticu"
+- interrupt-controller: the bfticu FPGA is an interrupt controller
+- interrupts: the main IRQ line to signal the collected IRQs
+- #interrupt-cells : is 2
+	- The 1st cell is the local IRQ number on the bfticu
+	- The 2nd cell is the type of the IRQ (IRQ_TYPE_xxx)
+- interrupt-parent: the parent IRQ ctrl the main IRQ is connected to
+- reg: access on the parent local bus (chip select, offset in chip select, size)
+
+Example:
+
+	chassis-mgmt@3,0 {
+		compatible = "keymile,bfticu";
+		interrupt-controller;
+		#interrupt-cells = <2>;
+		reg = <3 0 0x100>;
+		interrupt-parent = <&mpic>;
+		interrupts = <6 1 0 0>;
+	};
diff --git a/Documentation/devicetree/bindings/mfd/qriox.txt b/Documentation/devicetree/bindings/mfd/qriox.txt
new file mode 100644
index 0000000..f301e2d
--- /dev/null
+++ b/Documentation/devicetree/bindings/mfd/qriox.txt
@@ -0,0 +1,17 @@
+KEYMILE qrio Board Control CPLD
+
+The qrio is a multifunction device that controls the KEYMILE boards based on
+the kmp204x design.
+It is consists of a reset controller, watchdog timer, LEDs, and 2 IRQ capable
+GPIO blocks.
+
+Required properties:
+- compatible: "keymile,qriox"
+- reg: access on the parent local bus (chip select, offset in chip select, size)
+
+Example:
+
+	board-control@1,0 {
+		compatible = "keymile,qriox";
+		reg = <1 0 0x80>;
+	};
diff --git a/Documentation/devicetree/bindings/vendor-prefixes.txt b/Documentation/devicetree/bindings/vendor-prefixes.txt
index 4a6eba0..913a007 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.txt
+++ b/Documentation/devicetree/bindings/vendor-prefixes.txt
@@ -49,6 +49,7 @@ img	Imagination Technologies Ltd.
 intercontrol	Inter Control Group
 isl	Intersil
 karo	Ka-Ro electronics GmbH
+keymile	KEYMILE GmbH
 lg	LG Corporation
 linux	Linux-specific binding
 lsi	LSI Corp. (LSI Logic)
-- 
1.8.0.1

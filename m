Return-Path: <B45475@freescale.com>
Received: from ch1outboundpool.messaging.microsoft.com
 (ch1ehsobe001.messaging.microsoft.com [216.32.181.181])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 388072C007B
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 22 Sep 2013 12:33:54 +1000 (EST)
Received: from mail95-ch1 (localhost [127.0.0.1])	by mail95-ch1-R.bigfish.com
 (Postfix) with ESMTP id 16695440288	for
 <linuxppc-dev@lists.ozlabs.org>; Sun,
 22 Sep 2013 02:33:49 +0000 (UTC)
Received: from CH1EHSMHS037.bigfish.com (snatpool2.int.messaging.microsoft.com
 [10.43.68.234])	by mail95-ch1.bigfish.com (Postfix) with ESMTP id
 F0401420056
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 22 Sep 2013 02:33:45 +0000 (UTC)
From: Zhao Qiang <B45475@freescale.com>
To: <linuxppc-dev@lists.ozlabs.org>
Subject: [PATCH] powerpc/p1010rdb:update dts to adapt to both old and new
 p1010rdb
Date: Sun, 22 Sep 2013 10:28:39 +0800
Message-ID: <1379816919-13851-1-git-send-email-B45475@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: Zhao Qiang <B45475@freescale.com>,
 Shengzhou Liu <Shengzhou.Liu@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

P1010rdb-pa and p1010rdb-pb have different phy interrupts.
So update dts to adapt to both p1010rdb-pa and p1010rdb-pb.

Signed-off-by: Shengzhou Liu <Shengzhou.Liu@freescale.com>
Signed-off-by: Zhao Qiang <B45475@freescale.com>
---
 arch/powerpc/boot/dts/p1010rdb-pa.dts | 33 ++++++++++++++++++
 arch/powerpc/boot/dts/p1010rdb-pb.dts | 33 ++++++++++++++++++
 arch/powerpc/boot/dts/p1010rdb.dts    | 66 -----------------------------------
 arch/powerpc/boot/dts/p1010rdb.dtsi   | 51 ++++++++++++++++++++++++---
 4 files changed, 112 insertions(+), 71 deletions(-)
 create mode 100644 arch/powerpc/boot/dts/p1010rdb-pa.dts
 create mode 100644 arch/powerpc/boot/dts/p1010rdb-pb.dts
 delete mode 100644 arch/powerpc/boot/dts/p1010rdb.dts

diff --git a/arch/powerpc/boot/dts/p1010rdb-pa.dts b/arch/powerpc/boot/dts/p1010rdb-pa.dts
new file mode 100644
index 0000000..e1688d4
--- /dev/null
+++ b/arch/powerpc/boot/dts/p1010rdb-pa.dts
@@ -0,0 +1,33 @@
+/*
+ * P1010 RDB-PA Device Tree Source
+ *
+ * Copyright 2011 Freescale Semiconductor Inc.
+ *
+ * This program is free software; you can redistribute  it and/or modify it
+ * under  the terms of  the GNU General  Public License as published by the
+ * Free Software Foundation;  either version 2 of the  License, or (at your
+ * option) any later version.
+ */
+
+/include/ "fsl/p1010si-pre.dtsi"
+
+/ {
+	model = "fsl,P1010RDB-PA";
+	compatible = "fsl,P1010RDB";
+
+	/include/ "p1010rdb.dtsi"
+};
+
+&phy0 {
+	interrupts = <3 1 0 0>;
+};
+
+&phy1 {
+	interrupts = <2 1 0 0>;
+};
+
+&phy2 {
+	interrupts = <2 1 0 0>;
+};
+
+/include/ "fsl/p1010si-post.dtsi"
diff --git a/arch/powerpc/boot/dts/p1010rdb-pb.dts b/arch/powerpc/boot/dts/p1010rdb-pb.dts
new file mode 100644
index 0000000..37f9366
--- /dev/null
+++ b/arch/powerpc/boot/dts/p1010rdb-pb.dts
@@ -0,0 +1,33 @@
+/*
+ * P1010 RDB-PB Device Tree Source
+ *
+ * Copyright 2011 Freescale Semiconductor Inc.
+ *
+ * This program is free software; you can redistribute  it and/or modify it
+ * under  the terms of  the GNU General  Public License as published by the
+ * Free Software Foundation;  either version 2 of the  License, or (at your
+ * option) any later version.
+ */
+
+/include/ "fsl/p1010si-pre.dtsi"
+
+/ {
+	model = "fsl,P1010RDB-PB";
+	compatible = "fsl,P1010RDB";
+
+	/include/ "p1010rdb.dtsi"
+};
+
+&phy0 {
+	interrupts = <0 1 0 0>;
+};
+
+&phy1 {
+	interrupts = <2 1 0 0>;
+};
+
+&phy2 {
+	interrupts = <1 1 0 0>;
+};
+
+/include/ "fsl/p1010si-post.dtsi"
diff --git a/arch/powerpc/boot/dts/p1010rdb.dts b/arch/powerpc/boot/dts/p1010rdb.dts
deleted file mode 100644
index b868d22..0000000
--- a/arch/powerpc/boot/dts/p1010rdb.dts
+++ /dev/null
@@ -1,66 +0,0 @@
-/*
- * P1010 RDB Device Tree Source
- *
- * Copyright 2011 Freescale Semiconductor Inc.
- *
- * This program is free software; you can redistribute  it and/or modify it
- * under  the terms of  the GNU General  Public License as published by the
- * Free Software Foundation;  either version 2 of the  License, or (at your
- * option) any later version.
- */
-
-/include/ "fsl/p1010si-pre.dtsi"
-
-/ {
-	model = "fsl,P1010RDB";
-	compatible = "fsl,P1010RDB";
-
-	memory {
-		device_type = "memory";
-	};
-
-	board_ifc: ifc: ifc@ffe1e000 {
-		/* NOR, NAND Flashes and CPLD on board */
-		ranges = <0x0 0x0 0x0 0xee000000 0x02000000
-			  0x1 0x0 0x0 0xff800000 0x00010000
-			  0x3 0x0 0x0 0xffb00000 0x00000020>;
-		reg = <0x0 0xffe1e000 0 0x2000>;
-	};
-
-	board_soc: soc: soc@ffe00000 {
-		ranges = <0x0 0x0 0xffe00000 0x100000>;
-	};
-
-	pci0: pcie@ffe09000 {
-		reg = <0 0xffe09000 0 0x1000>;
-		ranges = <0x2000000 0x0 0xa0000000 0 0xa0000000 0x0 0x20000000
-			  0x1000000 0x0 0x00000000 0 0xffc10000 0x0 0x10000>;
-		pcie@0 {
-			ranges = <0x2000000 0x0 0xa0000000
-				  0x2000000 0x0 0xa0000000
-				  0x0 0x20000000
-
-				  0x1000000 0x0 0x0
-				  0x1000000 0x0 0x0
-				  0x0 0x100000>;
-		};
-	};
-
-	pci1: pcie@ffe0a000 {
-		reg = <0 0xffe0a000 0 0x1000>;
-		ranges = <0x2000000 0x0 0x80000000 0 0x80000000 0x0 0x20000000
-			  0x1000000 0x0 0x00000000 0 0xffc00000 0x0 0x10000>;
-		pcie@0 {
-			ranges = <0x2000000 0x0 0x80000000
-				  0x2000000 0x0 0x80000000
-				  0x0 0x20000000
-
-				  0x1000000 0x0 0x0
-				  0x1000000 0x0 0x0
-				  0x0 0x100000>;
-		};
-	};
-};
-
-/include/ "p1010rdb.dtsi"
-/include/ "fsl/p1010si-post.dtsi"
diff --git a/arch/powerpc/boot/dts/p1010rdb.dtsi b/arch/powerpc/boot/dts/p1010rdb.dtsi
index 7fc3402..5e5ca56 100644
--- a/arch/powerpc/boot/dts/p1010rdb.dtsi
+++ b/arch/powerpc/boot/dts/p1010rdb.dtsi
@@ -32,7 +32,17 @@
  * SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
  */
 
-&board_ifc {
+memory {
+	device_type = "memory";
+};
+
+board_ifc: ifc: ifc@ffe1e000 {
+	/* NOR, NAND Flashes and CPLD on board */
+	ranges = <0x0 0x0 0x0 0xee000000 0x02000000
+		  0x1 0x0 0x0 0xff800000 0x00010000
+		  0x3 0x0 0x0 0xffb00000 0x00000020>;
+	reg = <0x0 0xffe1e000 0 0x2000>;
+
 	nor@0,0 {
 		#address-cells = <1>;
 		#size-cells = <1>;
@@ -124,7 +134,9 @@
 	};
 };
 
-&board_soc {
+board_soc: soc: soc@ffe00000 {
+	ranges = <0x0 0x0 0xffe00000 0x100000>;
+
 	i2c@3000 {
 		eeprom@50 {
 			compatible = "st,24c256";
@@ -199,17 +211,14 @@
 
 	mdio@24000 {
 		phy0: ethernet-phy@0 {
-			interrupts = <3 1 0 0>;
 			reg = <0x1>;
 		};
 
 		phy1: ethernet-phy@1 {
-			interrupts = <2 1 0 0>;
 			reg = <0x0>;
 		};
 
 		phy2: ethernet-phy@2 {
-			interrupts = <2 1 0 0>;
 			reg = <0x2>;
 		};
 
@@ -261,3 +270,35 @@
 		ptimer-handle = <&ptp_timer>;
 	};
 };
+
+pci0: pcie@ffe09000 {
+	reg = <0 0xffe09000 0 0x1000>;
+	ranges = <0x2000000 0x0 0xa0000000 0 0xa0000000 0x0 0x20000000
+		  0x1000000 0x0 0x00000000 0 0xffc10000 0x0 0x10000>;
+
+	pcie@0 {
+		ranges = <0x2000000 0x0 0xa0000000
+			  0x2000000 0x0 0xa0000000
+			  0x0 0x20000000
+
+			  0x1000000 0x0 0x0
+			  0x1000000 0x0 0x0
+			  0x0 0x100000>;
+	};
+};
+
+pci1: pcie@ffe0a000 {
+	reg = <0 0xffe0a000 0 0x1000>;
+	ranges = <0x2000000 0x0 0x80000000 0 0x80000000 0x0 0x20000000
+		  0x1000000 0x0 0x00000000 0 0xffc00000 0x0 0x10000>;
+
+	pcie@0 {
+		ranges = <0x2000000 0x0 0x80000000
+			  0x2000000 0x0 0x80000000
+			  0x0 0x20000000
+
+			  0x1000000 0x0 0x0
+			  0x1000000 0x0 0x0
+			  0x0 0x100000>;
+	};
+};
-- 
1.8.0

Return-Path: <B45475@freescale.com>
Received: from ch1outboundpool.messaging.microsoft.com
 (ch1ehsobe002.messaging.microsoft.com [216.32.181.182])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 30E2C2C036B
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 14 Oct 2013 17:54:12 +1100 (EST)
Received: from mail65-ch1 (localhost [127.0.0.1])	by mail65-ch1-R.bigfish.com
 (Postfix) with ESMTP id 8CE15360126	for
 <linuxppc-dev@lists.ozlabs.org>; Mon,
 14 Oct 2013 06:54:07 +0000 (UTC)
Received: from CH1EHSMHS007.bigfish.com (snatpool1.int.messaging.microsoft.com
 [10.43.68.250])	by mail65-ch1.bigfish.com (Postfix) with ESMTP id
 44CD8C00AD
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 14 Oct 2013 06:54:05 +0000 (UTC)
From: Zhao Qiang <B45475@freescale.com>
To: <linuxppc-dev@lists.ozlabs.org>
Subject: [PATCH v4 2/2] powerpc/p1010rdb:update dts to adapt to both old and
 new p1010rdb
Date: Mon, 14 Oct 2013 14:46:14 +0800
Message-ID: <1381733174-17384-2-git-send-email-B45475@freescale.com>
In-Reply-To: <1381733174-17384-1-git-send-email-B45475@freescale.com>
References: <1381733174-17384-1-git-send-email-B45475@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: Zhao Qiang <B45475@freescale.com>, R61911@freescale.com,
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
Changes for v2
	- Take p1010rdb_36b.dts into account

Changes for v3
	- Do sharing
	- add "fsl,P1010RDB-PB"

Changes for v4
	- remove "fsl,P1010RDB"

 arch/powerpc/boot/dts/p1010rdb-pa.dts              | 35 ++++++++++++
 .../dts/{p1010rdb_36b.dts => p1010rdb-pa_36b.dts}  | 53 ++++-------------
 arch/powerpc/boot/dts/p1010rdb-pb.dts              | 35 ++++++++++++
 .../dts/{p1010rdb_36b.dts => p1010rdb-pb_36b.dts}  | 57 +++++--------------
 arch/powerpc/boot/dts/p1010rdb.dts                 | 66 ----------------------
 arch/powerpc/boot/dts/p1010rdb.dtsi                |  3 -
 arch/powerpc/boot/dts/p1010rdb_32b.dtsi            | 45 +++++++++++++++
 arch/powerpc/boot/dts/p1010rdb_36b.dtsi            | 45 +++++++++++++++
 8 files changed, 184 insertions(+), 155 deletions(-)
 create mode 100644 arch/powerpc/boot/dts/p1010rdb-pa.dts
 copy arch/powerpc/boot/dts/{p1010rdb_36b.dts => p1010rdb-pa_36b.dts} (64%)
 create mode 100644 arch/powerpc/boot/dts/p1010rdb-pb.dts
 rename arch/powerpc/boot/dts/{p1010rdb_36b.dts => p1010rdb-pb_36b.dts} (63%)
 delete mode 100644 arch/powerpc/boot/dts/p1010rdb.dts
 create mode 100644 arch/powerpc/boot/dts/p1010rdb_32b.dtsi
 create mode 100644 arch/powerpc/boot/dts/p1010rdb_36b.dtsi

diff --git a/arch/powerpc/boot/dts/p1010rdb-pa.dts b/arch/powerpc/boot/dts/p1010rdb-pa.dts
new file mode 100644
index 0000000..8a74700
--- /dev/null
+++ b/arch/powerpc/boot/dts/p1010rdb-pa.dts
@@ -0,0 +1,35 @@
+/*
+ * P1010 RDB Device Tree Source
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
+	model = "fsl,P1010RDB";
+	compatible = "fsl,P1010RDB";
+
+	/include/ "p1010rdb_32b.dtsi"
+};
+
+/include/ "p1010rdb.dtsi"
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
diff --git a/arch/powerpc/boot/dts/p1010rdb_36b.dts b/arch/powerpc/boot/dts/p1010rdb-pa_36b.dts
similarity index 64%
copy from arch/powerpc/boot/dts/p1010rdb_36b.dts
copy to arch/powerpc/boot/dts/p1010rdb-pa_36b.dts
index 64776f4..2004ee7 100644
--- a/arch/powerpc/boot/dts/p1010rdb_36b.dts
+++ b/arch/powerpc/boot/dts/p1010rdb-pa_36b.dts
@@ -38,52 +38,21 @@
 	model = "fsl,P1010RDB";
 	compatible = "fsl,P1010RDB";
 
-	memory {
-		device_type = "memory";
-	};
-
-	board_ifc: ifc: ifc@fffe1e000 {
-		/* NOR, NAND Flashes and CPLD on board */
-		ranges = <0x0 0x0 0xf 0xee000000 0x02000000
-			  0x1 0x0 0xf 0xff800000 0x00010000
-			  0x3 0x0 0xf 0xffb00000 0x00000020>;
-		reg = <0xf 0xffe1e000 0 0x2000>;
-	};
-
-	board_soc: soc: soc@fffe00000 {
-		ranges = <0x0 0xf 0xffe00000 0x100000>;
-	};
+	/include/ "p1010rdb_36b.dtsi"
+};
 
-	pci0: pcie@fffe09000 {
-		reg = <0xf 0xffe09000 0 0x1000>;
-		ranges = <0x2000000 0x0 0xc0000000 0xc 0x20000000 0x0 0x20000000
-			  0x1000000 0x0 0x00000000 0xf 0xffc10000 0x0 0x10000>;
-		pcie@0 {
-			ranges = <0x2000000 0x0 0xc0000000
-				  0x2000000 0x0 0xc0000000
-				  0x0 0x20000000
+/include/ "p1010rdb.dtsi"
 
-				  0x1000000 0x0 0x0
-				  0x1000000 0x0 0x0
-				  0x0 0x100000>;
-		};
-	};
+&phy0 {
+	interrupts = <3 1 0 0>;
+};
 
-	pci1: pcie@fffe0a000 {
-		reg = <0xf 0xffe0a000 0 0x1000>;
-		ranges = <0x2000000 0x0 0xc0000000 0xc 0x20000000 0x0 0x20000000
-			  0x1000000 0x0 0x00000000 0xf 0xffc10000 0x0 0x10000>;
-		pcie@0 {
-			ranges = <0x2000000 0x0 0xc0000000
-				  0x2000000 0x0 0xc0000000
-				  0x0 0x20000000
+&phy1 {
+	interrupts = <2 1 0 0>;
+};
 
-				  0x1000000 0x0 0x0
-				  0x1000000 0x0 0x0
-				  0x0 0x100000>;
-		};
-	};
+&phy2 {
+	interrupts = <2 1 0 0>;
 };
 
-/include/ "p1010rdb.dtsi"
 /include/ "fsl/p1010si-post.dtsi"
diff --git a/arch/powerpc/boot/dts/p1010rdb-pb.dts b/arch/powerpc/boot/dts/p1010rdb-pb.dts
new file mode 100644
index 0000000..6eeb7d3
--- /dev/null
+++ b/arch/powerpc/boot/dts/p1010rdb-pb.dts
@@ -0,0 +1,35 @@
+/*
+ * P1010 RDB Device Tree Source
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
+	compatible = "fsl,P1010RDB-PB";
+
+	/include/ "p1010rdb_32b.dtsi"
+};
+
+/include/ "p1010rdb.dtsi"
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
diff --git a/arch/powerpc/boot/dts/p1010rdb_36b.dts b/arch/powerpc/boot/dts/p1010rdb-pb_36b.dts
similarity index 63%
rename from arch/powerpc/boot/dts/p1010rdb_36b.dts
rename to arch/powerpc/boot/dts/p1010rdb-pb_36b.dts
index 64776f4..7ab3c90 100644
--- a/arch/powerpc/boot/dts/p1010rdb_36b.dts
+++ b/arch/powerpc/boot/dts/p1010rdb-pb_36b.dts
@@ -35,55 +35,24 @@
 /include/ "fsl/p1010si-pre.dtsi"
 
 / {
-	model = "fsl,P1010RDB";
-	compatible = "fsl,P1010RDB";
+	model = "fsl,P1010RDB-PB";
+	compatible = "fsl,P1010RDB-PB";
 
-	memory {
-		device_type = "memory";
-	};
-
-	board_ifc: ifc: ifc@fffe1e000 {
-		/* NOR, NAND Flashes and CPLD on board */
-		ranges = <0x0 0x0 0xf 0xee000000 0x02000000
-			  0x1 0x0 0xf 0xff800000 0x00010000
-			  0x3 0x0 0xf 0xffb00000 0x00000020>;
-		reg = <0xf 0xffe1e000 0 0x2000>;
-	};
-
-	board_soc: soc: soc@fffe00000 {
-		ranges = <0x0 0xf 0xffe00000 0x100000>;
-	};
+	/include/ "p1010rdb_36b.dtsi"
+};
 
-	pci0: pcie@fffe09000 {
-		reg = <0xf 0xffe09000 0 0x1000>;
-		ranges = <0x2000000 0x0 0xc0000000 0xc 0x20000000 0x0 0x20000000
-			  0x1000000 0x0 0x00000000 0xf 0xffc10000 0x0 0x10000>;
-		pcie@0 {
-			ranges = <0x2000000 0x0 0xc0000000
-				  0x2000000 0x0 0xc0000000
-				  0x0 0x20000000
+/include/ "p1010rdb.dtsi"
 
-				  0x1000000 0x0 0x0
-				  0x1000000 0x0 0x0
-				  0x0 0x100000>;
-		};
-	};
+&phy0 {
+	interrupts = <0 1 0 0>;
+};
 
-	pci1: pcie@fffe0a000 {
-		reg = <0xf 0xffe0a000 0 0x1000>;
-		ranges = <0x2000000 0x0 0xc0000000 0xc 0x20000000 0x0 0x20000000
-			  0x1000000 0x0 0x00000000 0xf 0xffc10000 0x0 0x10000>;
-		pcie@0 {
-			ranges = <0x2000000 0x0 0xc0000000
-				  0x2000000 0x0 0xc0000000
-				  0x0 0x20000000
+&phy1 {
+	interrupts = <2 1 0 0>;
+};
 
-				  0x1000000 0x0 0x0
-				  0x1000000 0x0 0x0
-				  0x0 0x100000>;
-		};
-	};
+&phy2 {
+	interrupts = <1 1 0 0>;
 };
 
-/include/ "p1010rdb.dtsi"
 /include/ "fsl/p1010si-post.dtsi"
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
index ec7c27a..4853399 100644
--- a/arch/powerpc/boot/dts/p1010rdb.dtsi
+++ b/arch/powerpc/boot/dts/p1010rdb.dtsi
@@ -193,17 +193,14 @@
 
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
 
diff --git a/arch/powerpc/boot/dts/p1010rdb_32b.dtsi b/arch/powerpc/boot/dts/p1010rdb_32b.dtsi
new file mode 100644
index 0000000..4453e43
--- /dev/null
+++ b/arch/powerpc/boot/dts/p1010rdb_32b.dtsi
@@ -0,0 +1,45 @@
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
+};
+
+board_soc: soc: soc@ffe00000 {
+	ranges = <0x0 0x0 0xffe00000 0x100000>;
+};
+
+pci0: pcie@ffe09000 {
+	reg = <0 0xffe09000 0 0x1000>;
+	ranges = <0x2000000 0x0 0xa0000000 0 0xa0000000 0x0 0x20000000
+		  0x1000000 0x0 0x00000000 0 0xffc10000 0x0 0x10000>;
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
diff --git a/arch/powerpc/boot/dts/p1010rdb_36b.dtsi b/arch/powerpc/boot/dts/p1010rdb_36b.dtsi
new file mode 100644
index 0000000..f8f3888
--- /dev/null
+++ b/arch/powerpc/boot/dts/p1010rdb_36b.dtsi
@@ -0,0 +1,45 @@
+memory {
+	device_type = "memory";
+};
+
+board_ifc: ifc: ifc@fffe1e000 {
+	/* NOR, NAND Flashes and CPLD on board */
+	ranges = <0x0 0x0 0xf 0xee000000 0x02000000
+		  0x1 0x0 0xf 0xff800000 0x00010000
+		  0x3 0x0 0xf 0xffb00000 0x00000020>;
+	reg = <0xf 0xffe1e000 0 0x2000>;
+};
+
+board_soc: soc: soc@fffe00000 {
+	ranges = <0x0 0xf 0xffe00000 0x100000>;
+};
+
+pci0: pcie@fffe09000 {
+	reg = <0xf 0xffe09000 0 0x1000>;
+	ranges = <0x2000000 0x0 0xc0000000 0xc 0x20000000 0x0 0x20000000
+		  0x1000000 0x0 0x00000000 0xf 0xffc10000 0x0 0x10000>;
+	pcie@0 {
+		ranges = <0x2000000 0x0 0xc0000000
+			  0x2000000 0x0 0xc0000000
+			  0x0 0x20000000
+
+			  0x1000000 0x0 0x0
+			  0x1000000 0x0 0x0
+			  0x0 0x100000>;
+	};
+};
+
+pci1: pcie@fffe0a000 {
+	reg = <0xf 0xffe0a000 0 0x1000>;
+	ranges = <0x2000000 0x0 0xc0000000 0xc 0x20000000 0x0 0x20000000
+		  0x1000000 0x0 0x00000000 0xf 0xffc10000 0x0 0x10000>;
+	pcie@0 {
+		ranges = <0x2000000 0x0 0xc0000000
+			  0x2000000 0x0 0xc0000000
+			  0x0 0x20000000
+
+			  0x1000000 0x0 0x0
+			  0x1000000 0x0 0x0
+			  0x0 0x100000>;
+	};
+};
-- 
1.8.0

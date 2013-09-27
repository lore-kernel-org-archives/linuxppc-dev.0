Return-Path: <B45475@freescale.com>
Received: from co9outboundpool.messaging.microsoft.com
 (co9ehsobe003.messaging.microsoft.com [207.46.163.26])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 19E522C0340
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 27 Sep 2013 11:27:34 +1000 (EST)
Received: from mail150-co9 (localhost [127.0.0.1])	by
 mail150-co9-R.bigfish.com (Postfix) with ESMTP id E272D2001E8	for
 <linuxppc-dev@lists.ozlabs.org>; Fri, 27 Sep 2013 01:27:29 +0000 (UTC)
Received: from CO9EHSMHS018.bigfish.com (unknown [10.236.132.243])	by
 mail150-co9.bigfish.com (Postfix) with ESMTP id 925B560062	for
 <linuxppc-dev@lists.ozlabs.org>; Fri, 27 Sep 2013 01:27:28 +0000 (UTC)
From: Zhao Qiang <B45475@freescale.com>
To: <linuxppc-dev@lists.ozlabs.org>
Subject: [PATCH] powerpc/p1010rdb:update mtd of nand to adapt to both old and
 new p1010rdb
Date: Fri, 27 Sep 2013 09:21:46 +0800
Message-ID: <1380244906-28792-1-git-send-email-B45475@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: Zhao Qiang <B45475@freescale.com>, B36685@freescale.com,
 R61911@freescale.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

P1010rdb-pa and p1010rdb-pb have different mtd of nand.
So update dts to adapt to both p1010rdb-pa and p1010rdb-pb.

Signed-off-by: Zhao Qiang <B45475@freescale.com>
---
 arch/powerpc/boot/dts/p1010rdb-pa.dts | 40 +++++++++++++++++++++++++++++++++++
 arch/powerpc/boot/dts/p1010rdb-pb.dts | 34 +++++++++++++++++++++++++++++
 arch/powerpc/boot/dts/p1010rdb.dtsi   | 40 +----------------------------------
 3 files changed, 75 insertions(+), 39 deletions(-)

diff --git a/arch/powerpc/boot/dts/p1010rdb-pa.dts b/arch/powerpc/boot/dts/p1010rdb-pa.dts
index e1688d4..9b4ca89 100644
--- a/arch/powerpc/boot/dts/p1010rdb-pa.dts
+++ b/arch/powerpc/boot/dts/p1010rdb-pa.dts
@@ -18,6 +18,46 @@
 	/include/ "p1010rdb.dtsi"
 };
 
+&ifc_nand {
+	partition@0 {
+		/* This location must not be altered  */
+		/* 1MB for u-boot Bootloader Image */
+		reg = <0x0 0x00100000>;
+		label = "NAND U-Boot Image";
+		read-only;
+	};
+
+	partition@100000 {
+		/* 1MB for DTB Image */
+		reg = <0x00100000 0x00100000>;
+		label = "NAND DTB Image";
+	};
+
+	partition@200000 {
+		/* 4MB for Linux Kernel Image */
+		reg = <0x00200000 0x00400000>;
+		label = "NAND Linux Kernel Image";
+	};
+
+	partition@600000 {
+		/* 4MB for Compressed Root file System Image */
+		reg = <0x00600000 0x00400000>;
+		label = "NAND Compressed RFS Image";
+	};
+
+	partition@a00000 {
+		/* 15MB for JFFS2 based Root file System */
+		reg = <0x00a00000 0x00f00000>;
+		label = "NAND JFFS2 Root File System";
+	};
+
+	partition@1900000 {
+		/* 7MB for User Area */
+		reg = <0x01900000 0x00700000>;
+		label = "NAND User area";
+	};
+};
+
 &phy0 {
 	interrupts = <3 1 0 0>;
 };
diff --git a/arch/powerpc/boot/dts/p1010rdb-pb.dts b/arch/powerpc/boot/dts/p1010rdb-pb.dts
index 37f9366..f4c97fd 100644
--- a/arch/powerpc/boot/dts/p1010rdb-pb.dts
+++ b/arch/powerpc/boot/dts/p1010rdb-pb.dts
@@ -18,6 +18,40 @@
 	/include/ "p1010rdb.dtsi"
 };
 
+&ifc_nand {
+	partition@0 {
+		/* This location must not be altered  */
+		/* 2MB for u-boot Image and environment */
+		reg = <0x0 0x00200000>;
+		label = "NAND U-Boot Image and env";
+		read-only;
+	};
+
+	partition@200000 {
+		/* 1MB for DTB Image */
+		reg = <0x00200000 0x00100000>;
+		label = "NAND DTB Image";
+	};
+
+	partition@300000 {
+		/* 5MB for Linux Kernel Image */
+		reg = <0x00300000 0x00500000>;
+		label = "NAND Linux Kernel Image";
+	};
+
+	partition@800000 {
+		/* 56MB for Compressed Root file System Image */
+		reg = <0x00800000 0x03800000>;
+		label = "NAND  ROOTFS";
+	};
+
+	partition@4000000 {
+		/* 1984MB for User Area */
+		reg = <0x04000000 0x7c000000>;
+		label = "NAND User area";
+	};
+};
+
 &phy0 {
 	interrupts = <0 1 0 0>;
 };
diff --git a/arch/powerpc/boot/dts/p1010rdb.dtsi b/arch/powerpc/boot/dts/p1010rdb.dtsi
index 5e5ca56..61abc18 100644
--- a/arch/powerpc/boot/dts/p1010rdb.dtsi
+++ b/arch/powerpc/boot/dts/p1010rdb.dtsi
@@ -79,49 +79,11 @@ board_ifc: ifc: ifc@ffe1e000 {
 		};
 	};
 
-	nand@1,0 {
+	ifc_nand: nand@1,0 {
 		#address-cells = <1>;
 		#size-cells = <1>;
 		compatible = "fsl,ifc-nand";
 		reg = <0x1 0x0 0x10000>;
-
-		partition@0 {
-			/* This location must not be altered  */
-			/* 1MB for u-boot Bootloader Image */
-			reg = <0x0 0x00100000>;
-			label = "NAND U-Boot Image";
-			read-only;
-		};
-
-		partition@100000 {
-			/* 1MB for DTB Image */
-			reg = <0x00100000 0x00100000>;
-			label = "NAND DTB Image";
-		};
-
-		partition@200000 {
-			/* 4MB for Linux Kernel Image */
-			reg = <0x00200000 0x00400000>;
-			label = "NAND Linux Kernel Image";
-		};
-
-		partition@600000 {
-			/* 4MB for Compressed Root file System Image */
-			reg = <0x00600000 0x00400000>;
-			label = "NAND Compressed RFS Image";
-		};
-
-		partition@a00000 {
-			/* 15MB for JFFS2 based Root file System */
-			reg = <0x00a00000 0x00f00000>;
-			label = "NAND JFFS2 Root File System";
-		};
-
-		partition@1900000 {
-			/* 7MB for User Area */
-			reg = <0x01900000 0x00700000>;
-			label = "NAND User area";
-		};
 	};
 
 	cpld@3,0 {
-- 
1.8.0

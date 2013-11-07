Return-Path: <qiang.zhao@freescale.com>
Received: from db8outboundpool.messaging.microsoft.com
 (mail-db8lp0185.outbound.messaging.microsoft.com [213.199.154.185])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 7A86C2C0417
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  7 Nov 2013 14:13:43 +1100 (EST)
From: Zhao Qiang <B45475@freescale.com>
To: <bcousson@baylibre.com>, <tony@atomide.com>, <devicetree@vger.kernel.org>
Subject: [PATCH 3/3] powerpc/p1010rdb:update mtd of nand to adapt to both old
 and new p1010rdb
Date: Thu, 7 Nov 2013 10:29:29 +0800
Message-ID: <1383791369-29324-3-git-send-email-B45475@freescale.com>
In-Reply-To: <1383791369-29324-1-git-send-email-B45475@freescale.com>
References: <1383791369-29324-1-git-send-email-B45475@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: Zhao Qiang <B45475@freescale.com>, linuxppc-dev@lists.ozlabs.org
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

Move the nand-mtd from p1010rdb.dtsi to p1010rdb-pa*.dts.
Remove nand-mtd for p1010rdb-pb, whick will use mtdparts
from u-boot instead of nand-mtd in device tree.

Signed-off-by: Zhao Qiang <B45475@freescale.com>
---
 arch/powerpc/boot/dts/p1010rdb-pa.dts     | 14 +----
 arch/powerpc/boot/dts/p1010rdb-pa.dtsi    | 85 +++++++++++++++++++++++++++++++
 arch/powerpc/boot/dts/p1010rdb-pa_36b.dts | 14 +----
 arch/powerpc/boot/dts/p1010rdb.dtsi       | 40 +--------------
 4 files changed, 88 insertions(+), 65 deletions(-)
 create mode 100644 arch/powerpc/boot/dts/p1010rdb-pa.dtsi

diff --git a/arch/powerpc/boot/dts/p1010rdb-pa.dts b/arch/powerpc/boot/dts/p1010rdb-pa.dts
index 8a74700..767d4c0 100644
--- a/arch/powerpc/boot/dts/p1010rdb-pa.dts
+++ b/arch/powerpc/boot/dts/p1010rdb-pa.dts
@@ -19,17 +19,5 @@
 };
 
 /include/ "p1010rdb.dtsi"
-
-&phy0 {
-	interrupts = <3 1 0 0>;
-};
-
-&phy1 {
-	interrupts = <2 1 0 0>;
-};
-
-&phy2 {
-	interrupts = <2 1 0 0>;
-};
-
+/include/ "p1010rdb-pa.dtsi"
 /include/ "fsl/p1010si-post.dtsi"
diff --git a/arch/powerpc/boot/dts/p1010rdb-pa.dtsi b/arch/powerpc/boot/dts/p1010rdb-pa.dtsi
new file mode 100644
index 0000000..4c5a7bf
--- /dev/null
+++ b/arch/powerpc/boot/dts/p1010rdb-pa.dtsi
@@ -0,0 +1,85 @@
+/*
+ * P1010 RDB Device Tree Source stub (no addresses or top-level ranges)
+ *
+ * Copyright 2013 Freescale Semiconductor Inc.
+ *
+ * Redistribution and use in source and binary forms, with or without
+ * modification, are permitted provided that the following conditions are met:
+ *     * Redistributions of source code must retain the above copyright
+ *       notice, this list of conditions and the following disclaimer.
+ *     * Redistributions in binary form must reproduce the above copyright
+ *       notice, this list of conditions and the following disclaimer in the
+ *       documentation and/or other materials provided with the distribution.
+ *     * Neither the name of Freescale Semiconductor nor the
+ *       names of its contributors may be used to endorse or promote products
+ *       derived from this software without specific prior written permission.
+ *
+ *
+ * ALTERNATIVELY, this software may be distributed under the terms of the
+ * GNU General Public License ("GPL") as published by the Free Software
+ * Foundation, either version 2 of that License or (at your option) any
+ * later version.
+ *
+ * THIS SOFTWARE IS PROVIDED BY Freescale Semiconductor ``AS IS'' AND ANY
+ * EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
+ * WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
+ * DISCLAIMED. IN NO EVENT SHALL Freescale Semiconductor BE LIABLE FOR ANY
+ * DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
+ * (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
+ * LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
+ * ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
+ * (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
+ * SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
+ */
+
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
diff --git a/arch/powerpc/boot/dts/p1010rdb-pa_36b.dts b/arch/powerpc/boot/dts/p1010rdb-pa_36b.dts
index 2004ee7..3033371 100644
--- a/arch/powerpc/boot/dts/p1010rdb-pa_36b.dts
+++ b/arch/powerpc/boot/dts/p1010rdb-pa_36b.dts
@@ -42,17 +42,5 @@
 };
 
 /include/ "p1010rdb.dtsi"
-
-&phy0 {
-	interrupts = <3 1 0 0>;
-};
-
-&phy1 {
-	interrupts = <2 1 0 0>;
-};
-
-&phy2 {
-	interrupts = <2 1 0 0>;
-};
-
+/include/ "p1010rdb-pa.dtsi"
 /include/ "fsl/p1010si-post.dtsi"
diff --git a/arch/powerpc/boot/dts/p1010rdb.dtsi b/arch/powerpc/boot/dts/p1010rdb.dtsi
index 4853399..ea534ef 100644
--- a/arch/powerpc/boot/dts/p1010rdb.dtsi
+++ b/arch/powerpc/boot/dts/p1010rdb.dtsi
@@ -69,49 +69,11 @@
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
1.8.4

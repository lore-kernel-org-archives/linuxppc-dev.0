Return-Path: <B45475@freescale.com>
Received: from am1outboundpool.messaging.microsoft.com
 (am1ehsobe001.messaging.microsoft.com [213.199.154.204])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 8D09C2C0082
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 30 Sep 2013 16:28:40 +1000 (EST)
Received: from mail43-am1 (localhost [127.0.0.1])	by mail43-am1-R.bigfish.com
 (Postfix) with ESMTP id B3DC532029F	for
 <linuxppc-dev@lists.ozlabs.org>; Mon,
 30 Sep 2013 06:28:33 +0000 (UTC)
Received: from AM1EHSMHS013.bigfish.com (unknown [10.3.201.233])	by
 mail43-am1.bigfish.com (Postfix) with ESMTP id DCA26200330	for
 <linuxppc-dev@lists.ozlabs.org>; Mon, 30 Sep 2013 06:28:31 +0000 (UTC)
From: Zhao Qiang <B45475@freescale.com>
To: <linuxppc-dev@lists.ozlabs.org>
Subject: [PATCH v2] powerpc/p1010rdb:update dts to adapt to both old and new
 p1010rdb
Date: Mon, 30 Sep 2013 14:22:13 +0800
Message-ID: <1380522133-7704-1-git-send-email-B45475@freescale.com>
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
Changes for v2
	- Take p1010rdb_36b.dts into account

 arch/powerpc/boot/dts/p1010rdb-pa.dts     |  79 ++++++++++++++++++++++
 arch/powerpc/boot/dts/p1010rdb-pa_36b.dts | 105 ++++++++++++++++++++++++++++++
 arch/powerpc/boot/dts/p1010rdb-pb.dts     |  79 ++++++++++++++++++++++
 arch/powerpc/boot/dts/p1010rdb-pb_36b.dts | 105 ++++++++++++++++++++++++++++++
 arch/powerpc/boot/dts/p1010rdb.dts        |  66 -------------------
 arch/powerpc/boot/dts/p1010rdb.dtsi       |   3 -
 arch/powerpc/boot/dts/p1010rdb_36b.dts    |  92 --------------------------
 7 files changed, 368 insertions(+), 161 deletions(-)
 create mode 100644 arch/powerpc/boot/dts/p1010rdb-pa.dts
 create mode 100644 arch/powerpc/boot/dts/p1010rdb-pa_36b.dts
 create mode 100644 arch/powerpc/boot/dts/p1010rdb-pb.dts
 create mode 100644 arch/powerpc/boot/dts/p1010rdb-pb_36b.dts
 delete mode 100644 arch/powerpc/boot/dts/p1010rdb.dts
 delete mode 100644 arch/powerpc/boot/dts/p1010rdb_36b.dts

diff --git a/arch/powerpc/boot/dts/p1010rdb-pa.dts b/arch/powerpc/boot/dts/p1010rdb-pa.dts
new file mode 100644
index 0000000..35f1eb9
--- /dev/null
+++ b/arch/powerpc/boot/dts/p1010rdb-pa.dts
@@ -0,0 +1,79 @@
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
+	memory {
+		device_type = "memory";
+	};
+
+	board_ifc: ifc: ifc@ffe1e000 {
+		/* NOR, NAND Flashes and CPLD on board */
+		ranges = <0x0 0x0 0x0 0xee000000 0x02000000
+			  0x1 0x0 0x0 0xff800000 0x00010000
+			  0x3 0x0 0x0 0xffb00000 0x00000020>;
+		reg = <0x0 0xffe1e000 0 0x2000>;
+	};
+
+	board_soc: soc: soc@ffe00000 {
+		ranges = <0x0 0x0 0xffe00000 0x100000>;
+	};
+
+	pci0: pcie@ffe09000 {
+		reg = <0 0xffe09000 0 0x1000>;
+		ranges = <0x2000000 0x0 0xa0000000 0 0xa0000000 0x0 0x20000000
+			  0x1000000 0x0 0x00000000 0 0xffc10000 0x0 0x10000>;
+		pcie@0 {
+			ranges = <0x2000000 0x0 0xa0000000
+				  0x2000000 0x0 0xa0000000
+				  0x0 0x20000000
+
+				  0x1000000 0x0 0x0
+				  0x1000000 0x0 0x0
+				  0x0 0x100000>;
+		};
+	};
+
+	pci1: pcie@ffe0a000 {
+		reg = <0 0xffe0a000 0 0x1000>;
+		ranges = <0x2000000 0x0 0x80000000 0 0x80000000 0x0 0x20000000
+			  0x1000000 0x0 0x00000000 0 0xffc00000 0x0 0x10000>;
+		pcie@0 {
+			ranges = <0x2000000 0x0 0x80000000
+				  0x2000000 0x0 0x80000000
+				  0x0 0x20000000
+
+				  0x1000000 0x0 0x0
+				  0x1000000 0x0 0x0
+				  0x0 0x100000>;
+		};
+	};
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
diff --git a/arch/powerpc/boot/dts/p1010rdb-pa_36b.dts b/arch/powerpc/boot/dts/p1010rdb-pa_36b.dts
new file mode 100644
index 0000000..c73bd16
--- /dev/null
+++ b/arch/powerpc/boot/dts/p1010rdb-pa_36b.dts
@@ -0,0 +1,105 @@
+/*
+ * P1010 RDB-PA Device Tree Source (36-bit address map)
+ *
+ * Copyright 2011 Freescale Semiconductor Inc.
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
+/include/ "fsl/p1010si-pre.dtsi"
+
+/ {
+	model = "fsl,P1010RDB-PA";
+	compatible = "fsl,P1010RDB";
+
+	memory {
+		device_type = "memory";
+	};
+
+	board_ifc: ifc: ifc@fffe1e000 {
+		/* NOR, NAND Flashes and CPLD on board */
+		ranges = <0x0 0x0 0xf 0xee000000 0x02000000
+			  0x1 0x0 0xf 0xff800000 0x00010000
+			  0x3 0x0 0xf 0xffb00000 0x00000020>;
+		reg = <0xf 0xffe1e000 0 0x2000>;
+	};
+
+	board_soc: soc: soc@fffe00000 {
+		ranges = <0x0 0xf 0xffe00000 0x100000>;
+		tdm@16000 {
+			status = "disabled";
+		};
+	};
+
+	pci0: pcie@fffe09000 {
+		reg = <0xf 0xffe09000 0 0x1000>;
+		ranges = <0x2000000 0x0 0xc0000000 0xc 0x20000000 0x0 0x20000000
+			  0x1000000 0x0 0x00000000 0xf 0xffc10000 0x0 0x10000>;
+		pcie@0 {
+			ranges = <0x2000000 0x0 0xc0000000
+				  0x2000000 0x0 0xc0000000
+				  0x0 0x20000000
+
+				  0x1000000 0x0 0x0
+				  0x1000000 0x0 0x0
+				  0x0 0x100000>;
+		};
+	};
+
+	pci1: pcie@fffe0a000 {
+		reg = <0xf 0xffe0a000 0 0x1000>;
+		ranges = <0x2000000 0x0 0xc0000000 0xc 0x20000000 0x0 0x20000000
+			  0x1000000 0x0 0x00000000 0xf 0xffc10000 0x0 0x10000>;
+		pcie@0 {
+			ranges = <0x2000000 0x0 0xc0000000
+				  0x2000000 0x0 0xc0000000
+				  0x0 0x20000000
+
+				  0x1000000 0x0 0x0
+				  0x1000000 0x0 0x0
+				  0x0 0x100000>;
+		};
+	};
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
diff --git a/arch/powerpc/boot/dts/p1010rdb-pb.dts b/arch/powerpc/boot/dts/p1010rdb-pb.dts
new file mode 100644
index 0000000..cb1265b
--- /dev/null
+++ b/arch/powerpc/boot/dts/p1010rdb-pb.dts
@@ -0,0 +1,79 @@
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
+	memory {
+		device_type = "memory";
+	};
+
+	board_ifc: ifc: ifc@ffe1e000 {
+		/* NOR, NAND Flashes and CPLD on board */
+		ranges = <0x0 0x0 0x0 0xee000000 0x02000000
+			  0x1 0x0 0x0 0xff800000 0x00010000
+			  0x3 0x0 0x0 0xffb00000 0x00000020>;
+		reg = <0x0 0xffe1e000 0 0x2000>;
+	};
+
+	board_soc: soc: soc@ffe00000 {
+		ranges = <0x0 0x0 0xffe00000 0x100000>;
+	};
+
+	pci0: pcie@ffe09000 {
+		reg = <0 0xffe09000 0 0x1000>;
+		ranges = <0x2000000 0x0 0xa0000000 0 0xa0000000 0x0 0x20000000
+			  0x1000000 0x0 0x00000000 0 0xffc10000 0x0 0x10000>;
+		pcie@0 {
+			ranges = <0x2000000 0x0 0xa0000000
+				  0x2000000 0x0 0xa0000000
+				  0x0 0x20000000
+
+				  0x1000000 0x0 0x0
+				  0x1000000 0x0 0x0
+				  0x0 0x100000>;
+		};
+	};
+
+	pci1: pcie@ffe0a000 {
+		reg = <0 0xffe0a000 0 0x1000>;
+		ranges = <0x2000000 0x0 0x80000000 0 0x80000000 0x0 0x20000000
+			  0x1000000 0x0 0x00000000 0 0xffc00000 0x0 0x10000>;
+		pcie@0 {
+			ranges = <0x2000000 0x0 0x80000000
+				  0x2000000 0x0 0x80000000
+				  0x0 0x20000000
+
+				  0x1000000 0x0 0x0
+				  0x1000000 0x0 0x0
+				  0x0 0x100000>;
+		};
+	};
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
diff --git a/arch/powerpc/boot/dts/p1010rdb-pb_36b.dts b/arch/powerpc/boot/dts/p1010rdb-pb_36b.dts
new file mode 100644
index 0000000..dd78e05
--- /dev/null
+++ b/arch/powerpc/boot/dts/p1010rdb-pb_36b.dts
@@ -0,0 +1,105 @@
+/*
+ * P1010 RDB-PB Device Tree Source (36-bit address map)
+ *
+ * Copyright 2011 Freescale Semiconductor Inc.
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
+/include/ "fsl/p1010si-pre.dtsi"
+
+/ {
+	model = "fsl,P1010RDB-PB";
+	compatible = "fsl,P1010RDB";
+
+	memory {
+		device_type = "memory";
+	};
+
+	board_ifc: ifc: ifc@fffe1e000 {
+		/* NOR, NAND Flashes and CPLD on board */
+		ranges = <0x0 0x0 0xf 0xee000000 0x02000000
+			  0x1 0x0 0xf 0xff800000 0x00010000
+			  0x3 0x0 0xf 0xffb00000 0x00000020>;
+		reg = <0xf 0xffe1e000 0 0x2000>;
+	};
+
+	board_soc: soc: soc@fffe00000 {
+		ranges = <0x0 0xf 0xffe00000 0x100000>;
+		tdm@16000 {
+			status = "disabled";
+		};
+	};
+
+	pci0: pcie@fffe09000 {
+		reg = <0xf 0xffe09000 0 0x1000>;
+		ranges = <0x2000000 0x0 0xc0000000 0xc 0x20000000 0x0 0x20000000
+			  0x1000000 0x0 0x00000000 0xf 0xffc10000 0x0 0x10000>;
+		pcie@0 {
+			ranges = <0x2000000 0x0 0xc0000000
+				  0x2000000 0x0 0xc0000000
+				  0x0 0x20000000
+
+				  0x1000000 0x0 0x0
+				  0x1000000 0x0 0x0
+				  0x0 0x100000>;
+		};
+	};
+
+	pci1: pcie@fffe0a000 {
+		reg = <0xf 0xffe0a000 0 0x1000>;
+		ranges = <0x2000000 0x0 0xc0000000 0xc 0x20000000 0x0 0x20000000
+			  0x1000000 0x0 0x00000000 0xf 0xffc10000 0x0 0x10000>;
+		pcie@0 {
+			ranges = <0x2000000 0x0 0xc0000000
+				  0x2000000 0x0 0xc0000000
+				  0x0 0x20000000
+
+				  0x1000000 0x0 0x0
+				  0x1000000 0x0 0x0
+				  0x0 0x100000>;
+		};
+	};
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
index 7fc3402..2433ae4 100644
--- a/arch/powerpc/boot/dts/p1010rdb.dtsi
+++ b/arch/powerpc/boot/dts/p1010rdb.dtsi
@@ -199,17 +199,14 @@
 
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
 
diff --git a/arch/powerpc/boot/dts/p1010rdb_36b.dts b/arch/powerpc/boot/dts/p1010rdb_36b.dts
deleted file mode 100644
index e159b42..0000000
--- a/arch/powerpc/boot/dts/p1010rdb_36b.dts
+++ /dev/null
@@ -1,92 +0,0 @@
-/*
- * P1010 RDB Device Tree Source (36-bit address map)
- *
- * Copyright 2011 Freescale Semiconductor Inc.
- *
- * Redistribution and use in source and binary forms, with or without
- * modification, are permitted provided that the following conditions are met:
- *     * Redistributions of source code must retain the above copyright
- *       notice, this list of conditions and the following disclaimer.
- *     * Redistributions in binary form must reproduce the above copyright
- *       notice, this list of conditions and the following disclaimer in the
- *       documentation and/or other materials provided with the distribution.
- *     * Neither the name of Freescale Semiconductor nor the
- *       names of its contributors may be used to endorse or promote products
- *       derived from this software without specific prior written permission.
- *
- *
- * ALTERNATIVELY, this software may be distributed under the terms of the
- * GNU General Public License ("GPL") as published by the Free Software
- * Foundation, either version 2 of that License or (at your option) any
- * later version.
- *
- * THIS SOFTWARE IS PROVIDED BY Freescale Semiconductor ``AS IS'' AND ANY
- * EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
- * WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
- * DISCLAIMED. IN NO EVENT SHALL Freescale Semiconductor BE LIABLE FOR ANY
- * DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
- * (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
- * LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
- * ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
- * (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
- * SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
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
-		tdm@16000 {
-			status = "disabled";
-		};
-	};
-
-	pci0: pcie@fffe09000 {
-		reg = <0xf 0xffe09000 0 0x1000>;
-		ranges = <0x2000000 0x0 0xc0000000 0xc 0x20000000 0x0 0x20000000
-			  0x1000000 0x0 0x00000000 0xf 0xffc10000 0x0 0x10000>;
-		pcie@0 {
-			ranges = <0x2000000 0x0 0xc0000000
-				  0x2000000 0x0 0xc0000000
-				  0x0 0x20000000
-
-				  0x1000000 0x0 0x0
-				  0x1000000 0x0 0x0
-				  0x0 0x100000>;
-		};
-	};
-
-	pci1: pcie@fffe0a000 {
-		reg = <0xf 0xffe0a000 0 0x1000>;
-		ranges = <0x2000000 0x0 0xc0000000 0xc 0x20000000 0x0 0x20000000
-			  0x1000000 0x0 0x00000000 0xf 0xffc10000 0x0 0x10000>;
-		pcie@0 {
-			ranges = <0x2000000 0x0 0xc0000000
-				  0x2000000 0x0 0xc0000000
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
-- 
1.8.0

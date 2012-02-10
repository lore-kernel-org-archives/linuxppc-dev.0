Return-Path: <mylinux@10.ap.freescale.net>
Received: from AM1EHSOBE002.bigfish.com (am1ehsobe001.messaging.microsoft.com
 [213.199.154.204])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 67BE1B6EF3
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 10 Feb 2012 19:01:42 +1100 (EST)
Received: from mail97-am1 (localhost [127.0.0.1])	by mail97-am1-R.bigfish.com
 (Postfix) with ESMTP id 1A2BAE0558	for
 <linuxppc-dev@lists.ozlabs.org>; Fri,
 10 Feb 2012 08:01:30 +0000 (UTC)
Received: from AM1EHSMHS007.bigfish.com (unknown [10.3.201.229])	by
 mail97-am1.bigfish.com (Postfix) with ESMTP id 8AD7F1A004A	for
 <linuxppc-dev@lists.ozlabs.org>; Fri, 10 Feb 2012 08:01:28 +0000 (UTC)
Received: from 10.ap.freescale.net ([10.213.130.145])	by
 az33smr02.freescale.net (8.13.1/8.13.0) with ESMTP id q1A81Nrg003063	for
 <linuxppc-dev@lists.ozlabs.org>; Fri, 10 Feb 2012 02:01:24 -0600 (CST)
From: <b29983@freescale.com>
To: <linuxppc-dev@lists.ozlabs.org>
Subject: [PATCH 1/2 V3] powerpc/85xx: Add P1024rdb dts support
Date: Fri, 10 Feb 2012 16:00:51 +0800
Message-ID: <1328860851-392-1-git-send-email-b29983@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: Tang Yuantian <Yuantian.Tang@freescale.com>,
 Jin Qing <b24347@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Tang Yuantian <Yuantian.Tang@freescale.com>

Signed-off-by: Jin Qing <b24347@freescale.com>
Signed-off-by: Li Yang <leoli@freescale.com>
Signed-off-by: Tang Yuantian <Yuantian.Tang@freescale.com>
---
v3:
	-correct the patch author

 arch/powerpc/boot/dts/p1024rdb.dtsi    |  228 ++++++++++++++++++++++++++++++++
 arch/powerpc/boot/dts/p1024rdb_32b.dts |   87 ++++++++++++
 arch/powerpc/boot/dts/p1024rdb_36b.dts |   87 ++++++++++++
 3 files changed, 402 insertions(+), 0 deletions(-)
 create mode 100644 arch/powerpc/boot/dts/p1024rdb.dtsi
 create mode 100644 arch/powerpc/boot/dts/p1024rdb_32b.dts
 create mode 100644 arch/powerpc/boot/dts/p1024rdb_36b.dts

diff --git a/arch/powerpc/boot/dts/p1024rdb.dtsi b/arch/powerpc/boot/dts/p1024rdb.dtsi
new file mode 100644
index 0000000..eb3141d
--- /dev/null
+++ b/arch/powerpc/boot/dts/p1024rdb.dtsi
@@ -0,0 +1,228 @@
+/*
+ * P1024 RDB Device Tree Source stub (no addresses or top-level ranges)
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
+&lbc {
+	nor@0,0 {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		compatible = "cfi-flash";
+		reg = <0x0 0x0 0x1000000>;
+		bank-width = <2>;
+		device-width = <1>;
+
+		partition@0 {
+			/* This location must not be altered  */
+			/* 256KB for Vitesse 7385 Switch firmware */
+			reg = <0x0 0x00040000>;
+			label = "NOR Vitesse-7385 Firmware";
+			read-only;
+		};
+
+		partition@40000 {
+			/* 256KB for DTB Image */
+			reg = <0x00040000 0x00040000>;
+			label = "NOR DTB Image";
+		};
+
+		partition@80000 {
+			/* 3.5 MB for Linux Kernel Image */
+			reg = <0x00080000 0x00380000>;
+			label = "NOR Linux Kernel Image";
+		};
+
+		partition@400000 {
+			/* 11MB for JFFS2 based Root file System */
+			reg = <0x00400000 0x00b00000>;
+			label = "NOR JFFS2 Root File System";
+		};
+
+		partition@f00000 {
+			/* This location must not be altered  */
+			/* 512KB for u-boot Bootloader Image */
+			/* 512KB for u-boot Environment Variables */
+			reg = <0x00f00000 0x00100000>;
+			label = "NOR U-Boot Image";
+			read-only;
+		};
+	};
+
+	nand@1,0 {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		compatible = "fsl,p1020-fcm-nand",
+				 "fsl,elbc-fcm-nand";
+		reg = <0x1 0x0 0x40000>;
+
+		partition@0 {
+			/* This location must not be altered  */
+			/* 1MB for u-boot Bootloader Image */
+			reg = <0x0 0x00100000>;
+			label = "NAND U-Boot Image";
+			read-only;
+		};
+
+		partition@100000 {
+			/* 1MB for DTB Image */
+			reg = <0x00100000 0x00100000>;
+			label = "NAND DTB Image";
+		};
+
+		partition@200000 {
+			/* 4MB for Linux Kernel Image */
+			reg = <0x00200000 0x00400000>;
+			label = "NAND Linux Kernel Image";
+		};
+
+		partition@600000 {
+			/* 4MB for Compressed Root file System Image */
+			reg = <0x00600000 0x00400000>;
+			label = "NAND Compressed RFS Image";
+		};
+
+		partition@a00000 {
+			/* 15MB for JFFS2 based Root file System */
+			reg = <0x00a00000 0x00f00000>;
+			label = "NAND JFFS2 Root File System";
+		};
+
+		partition@1900000 {
+			/* 7MB for User Writable Area */
+			reg = <0x01900000 0x00700000>;
+			label = "NAND Writable User area";
+		};
+	};
+};
+
+&soc {
+	spi@7000 {
+		flash@0 {
+			#address-cells = <1>;
+			#size-cells = <1>;
+			compatible = "spansion,m25p80";
+			reg = <0>;
+			spi-max-frequency = <40000000>;
+
+			partition@0 {
+				/* 512KB for u-boot Bootloader Image */
+				reg = <0x0 0x00080000>;
+				label = "SPI U-Boot Image";
+				read-only;
+			};
+
+			partition@80000 {
+				/* 512KB for DTB Image */
+				reg = <0x00080000 0x00080000>;
+				label = "SPI DTB Image";
+			};
+
+			partition@100000 {
+				/* 4MB for Linux Kernel Image */
+				reg = <0x00100000 0x00400000>;
+				label = "SPI Linux Kernel Image";
+			};
+
+			partition@500000 {
+				/* 4MB for Compressed RFS Image */
+				reg = <0x00500000 0x00400000>;
+				label = "SPI Compressed RFS Image";
+			};
+
+			partition@900000 {
+				/* 7MB for JFFS2 based RFS */
+				reg = <0x00900000 0x00700000>;
+				label = "SPI JFFS2 RFS";
+			};
+		};
+	};
+
+	i2c@3000 {
+		rtc@68 {
+			compatible = "dallas,ds1339";
+			reg = <0x68>;
+		};
+	};
+
+	usb@22000 {
+		phy_type = "ulpi";
+	};
+
+	usb@23000 {
+		status = "disabled";
+	};
+
+	mdio@24000 {
+		phy0: ethernet-phy@0 {
+			interrupts = <3 1 0 0>;
+			reg = <0x0>;
+		};
+		phy1: ethernet-phy@1 {
+			interrupts = <2 1 0 0>;
+			reg = <0x1>;
+		};
+		phy2: ethernet-phy@2 {
+			interrupts = <1 1 0 0>;
+			reg = <0x2>;
+		};
+	};
+
+	mdio@25000 {
+		tbi0: tbi-phy@11 {
+			reg = <0x11>;
+			device_type = "tbi-phy";
+		};
+	};
+
+	mdio@26000 {
+		tbi1: tbi-phy@11 {
+			reg = <0x11>;
+			device_type = "tbi-phy";
+		};
+	};
+
+	ethernet@b0000 {
+		phy-handle = <&phy2>;
+		phy-connection-type = "rgmii-id";
+	};
+
+	ethernet@b1000 {
+		phy-handle = <&phy0>;
+		tbi-handle = <&tbi0>;
+		phy-connection-type = "sgmii";
+	};
+
+	ethernet@b2000 {
+		phy-handle = <&phy1>;
+		phy-connection-type = "rgmii-id";
+	};
+};
diff --git a/arch/powerpc/boot/dts/p1024rdb_32b.dts b/arch/powerpc/boot/dts/p1024rdb_32b.dts
new file mode 100644
index 0000000..2f86327
--- /dev/null
+++ b/arch/powerpc/boot/dts/p1024rdb_32b.dts
@@ -0,0 +1,87 @@
+/*
+ * P1024 RDB 32Bit Physical Address Map Device Tree Source
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
+/include/ "fsl/p1020si-pre.dtsi"
+/ {
+	model = "fsl,P1024RDB";
+	compatible = "fsl,P1024RDB";
+
+	memory {
+		device_type = "memory";
+	};
+
+	lbc: localbus@ffe05000 {
+		reg = <0x0 0xffe05000 0 0x1000>;
+		ranges = <0x0 0x0 0x0 0xef000000 0x01000000
+			  0x1 0x0 0x0 0xff800000 0x00040000>;
+	};
+
+	soc: soc@ffe00000 {
+		ranges = <0x0 0x0 0xffe00000 0x100000>;
+	};
+
+	pci0: pcie@ffe09000 {
+		reg = <0x0 0xffe09000 0 0x1000>;
+		ranges = <0x2000000 0x0 0xe0000000 0x0 0xa0000000 0x0 0x20000000
+			  0x1000000 0x0 0x00000000 0x0 0xffc10000 0x0 0x10000>;
+		pcie@0 {
+			ranges = <0x2000000 0x0 0xe0000000
+				  0x2000000 0x0 0xe0000000
+				  0x0 0x20000000
+
+				  0x1000000 0x0 0x0
+				  0x1000000 0x0 0x0
+				  0x0 0x100000>;
+		};
+	};
+
+	pci1: pcie@ffe0a000 {
+		reg = <0xf 0xffe0a000 0 0x1000>;
+		ranges = <0x2000000 0x0 0xe0000000 0x0 0x80000000 0x0 0x20000000
+			  0x1000000 0x0 0x00000000 0x0 0xffc00000 0x0 0x10000>;
+		pcie@0 {
+			reg = <0x0 0x0 0x0 0x0 0x0>;
+			ranges = <0x2000000 0x0 0xe0000000
+				  0x2000000 0x0 0xe0000000
+				  0x0 0x20000000
+
+				  0x1000000 0x0 0x0
+				  0x1000000 0x0 0x0
+				  0x0 0x100000>;
+		};
+	};
+};
+
+/include/ "p1024rdb.dtsi"
+/include/ "fsl/p1020si-post.dtsi"
diff --git a/arch/powerpc/boot/dts/p1024rdb_36b.dts b/arch/powerpc/boot/dts/p1024rdb_36b.dts
new file mode 100644
index 0000000..550495e
--- /dev/null
+++ b/arch/powerpc/boot/dts/p1024rdb_36b.dts
@@ -0,0 +1,87 @@
+/*
+ * P1024 RDB 36Bit Physical Address Map Device Tree Source
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
+/include/ "fsl/p1020si-pre.dtsi"
+/ {
+	model = "fsl,P1024RDB";
+	compatible = "fsl,P1024RDB";
+
+	memory {
+		device_type = "memory";
+	};
+
+	lbc: localbus@fffe05000 {
+		reg = <0xf 0xffe05000 0 0x1000>;
+		ranges = <0x0 0x0 0xf 0xef000000 0x01000000
+			  0x1 0x0 0xf 0xff800000 0x00040000>;
+	};
+
+	soc: soc@fffe00000 {
+		ranges = <0x0 0xf 0xffe00000 0x100000>;
+	};
+
+	pci0: pcie@fffe09000 {
+		reg = <0xf 0xffe09000 0 0x1000>;
+		ranges = <0x2000000 0x0 0xe0000000 0xc 0x20000000 0x0 0x20000000
+			  0x1000000 0x0 0x00000000 0xf 0xffc10000 0x0 0x10000>;
+		pcie@0 {
+			ranges = <0x2000000 0x0 0xe0000000
+				  0x2000000 0x0 0xe0000000
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
+		ranges = <0x2000000 0x0 0xe0000000 0xc 0x00000000 0x0 0x20000000
+			  0x1000000 0x0 0x00000000 0xf 0xffc00000 0x0 0x10000>;
+		pcie@0 {
+			reg = <0x0 0x0 0x0 0x0 0x0>;
+			ranges = <0x2000000 0x0 0xe0000000
+				  0x2000000 0x0 0xe0000000
+				  0x0 0x20000000
+
+				  0x1000000 0x0 0x0
+				  0x1000000 0x0 0x0
+				  0x0 0x100000>;
+		};
+	};
+};
+
+/include/ "p1024rdb.dtsi"
+/include/ "fsl/p1020si-post.dtsi"
-- 
1.6.4

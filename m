Return-Path: <mylinux@udp143655uds.ap.freescale.net>
Received: from ch1outboundpool.messaging.microsoft.com
 (ch1ehsobe006.messaging.microsoft.com [216.32.181.186])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (verified OK))
 by ozlabs.org (Postfix) with ESMTPS id 9E5E4B6FAA
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  9 Jan 2012 19:38:03 +1100 (EST)
Received: from mail213-ch1 (localhost [127.0.0.1])	by
 mail213-ch1-R.bigfish.com (Postfix) with ESMTP id 1E8345801BD	for
 <linuxppc-dev@lists.ozlabs.org>; Mon,  9 Jan 2012 08:37:54 +0000 (UTC)
Received: from CH1EHSMHS022.bigfish.com (snatpool1.int.messaging.microsoft.com
 [10.43.68.249])	by mail213-ch1.bigfish.com (Postfix) with ESMTP id
 CB21550004D	for <linuxppc-dev@lists.ozlabs.org>; Mon,  9 Jan 2012 08:37:50
 +0000 (UTC)
Received: from udp143655uds.ap.freescale.net (10.ap.freescale.net
 [10.192.208.115])	by az33smr01.freescale.net (8.13.1/8.13.0) with ESMTP id
 q098blZR022884	for <linuxppc-dev@lists.ozlabs.org>; Mon, 9 Jan 2012 02:37:50
 -0600 (CST)
From: <b29983@freescale.com>
To: <linuxppc-dev@lists.ozlabs.org>
Subject: [PATCH] powerpc/85xx: Add P1024rdb dts support
Date: Mon, 9 Jan 2012 16:37:38 +0800
Message-ID: <1326098258-32097-1-git-send-email-b29983@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: Tang Yuantian <B29983@freescale.com>, Jin Qing <b24347@freescale.com>,
 Tang Yuantian <Yuantian.Tang@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Tang Yuantian <B29983@freescale.com>

Signed-off-by: Jin Qing <b24347@freescale.com>
Signed-off-by: Li Yang <leoli@freescale.com>
Signed-off-by: Tang Yuantian <Yuantian.Tang@freescale.com>
---
 arch/powerpc/boot/dts/fsl/p1024si-pre.dtsi    |   68 ++++++++
 arch/powerpc/boot/dts/p1024rdb.dts            |   87 ++++++++++
 arch/powerpc/boot/dts/p1024rdb.dtsi           |  228 +++++++++++++++++++++++++
 arch/powerpc/boot/dts/p1024rdb_36b.dts        |   87 ++++++++++
 arch/powerpc/boot/dts/p1024rdb_camp_core0.dts |  106 ++++++++++++
 arch/powerpc/boot/dts/p1024rdb_camp_core1.dts |  161 +++++++++++++++++
 6 files changed, 737 insertions(+), 0 deletions(-)
 create mode 100644 arch/powerpc/boot/dts/fsl/p1024si-pre.dtsi
 create mode 100644 arch/powerpc/boot/dts/p1024rdb.dts
 create mode 100644 arch/powerpc/boot/dts/p1024rdb.dtsi
 create mode 100644 arch/powerpc/boot/dts/p1024rdb_36b.dts
 create mode 100644 arch/powerpc/boot/dts/p1024rdb_camp_core0.dts
 create mode 100644 arch/powerpc/boot/dts/p1024rdb_camp_core1.dts

diff --git a/arch/powerpc/boot/dts/fsl/p1024si-pre.dtsi b/arch/powerpc/boot/dts/fsl/p1024si-pre.dtsi
new file mode 100644
index 0000000..4a0406b
--- /dev/null
+++ b/arch/powerpc/boot/dts/fsl/p1024si-pre.dtsi
@@ -0,0 +1,68 @@
+/*
+ * P1024 Silicon/SoC Device Tree Source (pre include)
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
+/dts-v1/;
+/ {
+	compatible = "fsl,P1024";
+	#address-cells = <2>;
+	#size-cells = <2>;
+	interrupt-parent = <&mpic>;
+
+	aliases {
+		serial0 = &serial0;
+		serial1 = &serial1;
+		ethernet0 = &enet0;
+		ethernet1 = &enet1;
+		ethernet2 = &enet2;
+		pci0 = &pci0;
+		pci1 = &pci1;
+	};
+
+	cpus {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		PowerPC,P1024@0 {
+			device_type = "cpu";
+			reg = <0x0>;
+			next-level-cache = <&L2>;
+		};
+
+		PowerPC,P1024@1 {
+			device_type = "cpu";
+			reg = <0x1>;
+			next-level-cache = <&L2>;
+		};
+	};
+};
diff --git a/arch/powerpc/boot/dts/p1024rdb.dts b/arch/powerpc/boot/dts/p1024rdb.dts
new file mode 100644
index 0000000..1a89f9c
--- /dev/null
+++ b/arch/powerpc/boot/dts/p1024rdb.dts
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
+/include/ "fsl/p1024si-pre.dtsi"
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
diff --git a/arch/powerpc/boot/dts/p1024rdb_36b.dts b/arch/powerpc/boot/dts/p1024rdb_36b.dts
new file mode 100644
index 0000000..abfa328
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
+/include/ "fsl/p1024si-pre.dtsi"
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
diff --git a/arch/powerpc/boot/dts/p1024rdb_camp_core0.dts b/arch/powerpc/boot/dts/p1024rdb_camp_core0.dts
new file mode 100644
index 0000000..abab1b0
--- /dev/null
+++ b/arch/powerpc/boot/dts/p1024rdb_camp_core0.dts
@@ -0,0 +1,106 @@
+/*
+ * P1024 RDB Core0 Device Tree Source in CAMP mode.
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
+ *
+ *
+ * In CAMP mode, each core needs to have its own dts. Only mpic and L2 cache
+ * can be shared, all the other devices must be assigned to one core only.
+ * This dts file allows core0 to have all the devices except that USB, SDHCI
+ * enet0.
+ *
+ * Please note to add "-b 0" for core0's dts compiling.
+ */
+
+/include/ "p1024rdb.dts"
+
+/ {
+	model = "fsl,P1024RDB";
+	compatible = "fsl,P1024RDB", "fsl,MPC85XXRDB-CAMP";
+
+	aliases {
+		ethernet1 = &enet1;
+		ethernet2 = &enet2;
+		serial0 = &serial0;
+		pci0 = &pci0;
+		pci1 = &pci1;
+	};
+
+	cpus {
+		PowerPC,P1024@1 {
+			status = "disabled";
+		};
+	};
+
+	localbus@ffe05000 {
+		status = "disabled";
+	};
+
+	soc@ffe00000 {
+		serial1: serial@4600 {
+			status = "disabled";
+		};
+
+		mdio@24000 {
+			phy2: ethernet-phy@2 {
+				status = "disabled";
+			};
+		};
+
+		enet0: ethernet@b0000 {
+			status = "disabled";
+		};
+
+		sdhci@2e000 {
+			status = "disabled";
+		};
+
+		usb@22000 {
+			status = "disabled";
+		};
+
+		mpic: pic@40000 {
+			protected-sources = <
+			42 29 30 34	/* serial1, enet0-queue-group0 */
+			17 18 24 45	/* enet0-queue-group1, crypto */
+			1 28 46 72	/* phy2 usb sdhc */
+			>;
+		};
+	};
+
+	pci0: pcie@ffe09000 {
+		status = "disabled";
+	};
+
+	pci1: pcie@ffe0a000 {
+		status = "disabled";
+	};
+};
diff --git a/arch/powerpc/boot/dts/p1024rdb_camp_core1.dts b/arch/powerpc/boot/dts/p1024rdb_camp_core1.dts
new file mode 100644
index 0000000..461af60
--- /dev/null
+++ b/arch/powerpc/boot/dts/p1024rdb_camp_core1.dts
@@ -0,0 +1,161 @@
+/*
+ * P1024 RDB Core1 Device Tree Source in CAMP mode.
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
+ *
+ *
+ * In CAMP mode, each core needs to have its own dts. Only mpic and L2 cache
+ * can be shared, all the other devices must be assigned to one core only.
+ * This dts file allows core0 to have USB, SDHCI and enet0.
+ *
+ * Please note to add "-b 1" for core1's dts compiling.
+ */
+
+/include/ "p1024rdb.dts"
+
+/ {
+	model = "fsl,P1024RDB";
+	compatible = "fsl,P1024RDB", "fsl,MPC85XXRDB-CAMP";
+
+	aliases {
+		ethernet0 = &enet0;
+		serial0 = &serial1;
+	};
+
+	cpus {
+		PowerPC,P1024@0 {
+			status = "disabled";
+		};
+	};
+
+	localbus@ffe05000 {
+		status = "disabled";
+	};
+
+	soc@ffe00000 {
+		ecm-law@0 {
+			status = "disabled";
+		};
+
+		ecm@1000 {
+			status = "disabled";
+		};
+
+		memory-controller@2000 {
+			status = "disabled";
+		};
+
+		i2c@3000 {
+			status = "disabled";
+		};
+
+		i2c@3100 {
+			status = "disabled";
+		};
+
+		serial0: serial@4500 {
+			status = "disabled";
+		};
+
+		spi@7000 {
+			status = "disabled";
+		};
+
+		gpio: gpio-controller@f000 {
+			status = "disabled";
+		};
+
+		dma@c300 {
+			status = "disabled";
+		};
+
+		dma@21300 {
+			status = "disabled";
+		};
+
+		mdio@24000 {
+			phy0: ethernet-phy@0 {
+				status = "disabled";
+			};
+			phy1: ethernet-phy@1 {
+				status = "disabled";
+			};
+		};
+
+		mdio@25000 {
+			status = "disabled";
+		};
+
+		enet1: ethernet@b1000 {
+			status = "disabled";
+		};
+
+		enet2: ethernet@b2000 {
+			status = "disabled";
+		};
+
+		mpic: pic@40000 {
+			protected-sources = <
+			16 		/* ecm, mem, L2, pci0, pci1 */
+			43 42 59	/* i2c, serial0, spi */
+			47 63 62 	/* gpio, tdm */
+			20 21 22 23	/* dma */
+			03 02 58	/* mdio crypto */
+			35 36 40	/* enet1-queue-group0 */
+			51 52 67	/* enet1-queue-group1 */
+			31 32 33	/* enet2-queue-group0 */
+			25 26 27	/* enet2-queue-group1 */
+			0xb0 0xb1 0xb2	/* message */
+			0xb3 0xb4 0xb5
+			0xb6 0xb7
+			0xe0 0xe1 0xe2	/* msi */
+			0xe3 0xe4 0xe5
+			0xe6 0xe7
+			>;
+		};
+
+		msi@41600 {
+			status = "disabled";
+		};
+
+		global-utilities@e0000 {	//global utilities block
+			status = "disabled";
+		};
+	};
+
+	pci0: pcie@ffe09000 {
+		status = "disabled";
+	};
+
+	pci1: pcie@ffe0a000 {
+		status = "disabled";
+	};
+};
-- 
1.6.4

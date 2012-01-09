Return-Path: <B29983@freescale.com>
Received: from ch1outboundpool.messaging.microsoft.com
 (ch1ehsobe001.messaging.microsoft.com [216.32.181.181])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (verified OK))
 by ozlabs.org (Postfix) with ESMTPS id B6C46B6FAC
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  9 Jan 2012 19:34:36 +1100 (EST)
Received: from mail101-ch1 (localhost [127.0.0.1])	by
 mail101-ch1-R.bigfish.com (Postfix) with ESMTP id DFFD160194	for
 <linuxppc-dev@lists.ozlabs.org>; Mon,  9 Jan 2012 08:34:24 +0000 (UTC)
Received: from CH1EHSMHS004.bigfish.com (snatpool1.int.messaging.microsoft.com
 [10.43.68.243])	by mail101-ch1.bigfish.com (Postfix) with ESMTP id
 50C4C4003F
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  9 Jan 2012 08:34:24 +0000 (UTC)
From: <Yuantian.Tang@freescale.com>
To: <linuxppc-dev@lists.ozlabs.org>
Subject: [PATCH] powerpc/85xx: Add p2020rdb-pc dts support
Date: Mon, 9 Jan 2012 15:43:03 +0800
Message-ID: <1326094983-28059-1-git-send-email-Yuantian.Tang@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: Tang Yuantian <b29983@freescale.com>,
 Poonam Aggrwal <poonam.aggrwal@freescale.com>,
 Prabhakar Kushwaha <prabhakar@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Tang Yuantian <B29983@freescale.com>

Signed-off-by: Prabhakar Kushwaha <prabhakar@freescale.com>
Signed-off-by: Poonam Aggrwal <poonam.aggrwal@freescale.com>
Signed-off-by: Tang Yuantian <b29983@freescale.com>
---
 arch/powerpc/boot/dts/p2020rdb-pc.dts            |   96 +++++++++
 arch/powerpc/boot/dts/p2020rdb-pc.dtsi           |  241 ++++++++++++++++++++++
 arch/powerpc/boot/dts/p2020rdb-pc_36b.dts        |   96 +++++++++
 arch/powerpc/boot/dts/p2020rdb-pc_camp_core0.dts |   90 ++++++++
 arch/powerpc/boot/dts/p2020rdb-pc_camp_core1.dts |  152 ++++++++++++++
 5 files changed, 675 insertions(+), 0 deletions(-)
 create mode 100644 arch/powerpc/boot/dts/p2020rdb-pc.dts
 create mode 100644 arch/powerpc/boot/dts/p2020rdb-pc.dtsi
 create mode 100644 arch/powerpc/boot/dts/p2020rdb-pc_36b.dts
 create mode 100644 arch/powerpc/boot/dts/p2020rdb-pc_camp_core0.dts
 create mode 100644 arch/powerpc/boot/dts/p2020rdb-pc_camp_core1.dts

diff --git a/arch/powerpc/boot/dts/p2020rdb-pc.dts b/arch/powerpc/boot/dts/p2020rdb-pc.dts
new file mode 100644
index 0000000..852e5b2
--- /dev/null
+++ b/arch/powerpc/boot/dts/p2020rdb-pc.dts
@@ -0,0 +1,96 @@
+/*
+ * P2020 RDB-PC 32Bit Physical Address Map Device Tree Source
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
+/include/ "fsl/p2020si-pre.dtsi"
+
+/ {
+	model = "fsl,P2020RDB";
+	compatible = "fsl,P2020RDB-PC";
+
+	memory {
+		device_type = "memory";
+	};
+
+	lbc: localbus@ffe05000 {
+		reg = <0 0xffe05000 0 0x1000>;
+
+		/* NOR and NAND Flashes */
+		ranges = <0x0 0x0 0x0 0xef000000 0x01000000
+			  0x1 0x0 0x0 0xff800000 0x00040000
+			  0x2 0x0 0x0 0xffb00000 0x00020000
+			  0x3 0x0 0x0 0xffa00000 0x00020000>;
+	};
+
+	soc: soc@ffe00000 {
+		ranges = <0x0 0x0 0xffe00000 0x100000>;
+	};
+
+	pci0: pcie@ffe08000 {
+		reg = <0 0xffe08000 0 0x1000>;
+		status = "disabled";
+	};
+
+	pci1: pcie@ffe09000 {
+		reg = <0 0xffe09000 0 0x1000>;
+		ranges = <0x2000000 0x0 0xe0000000 0 0xa0000000 0x0 0x20000000
+			  0x1000000 0x0 0x00000000 0 0xffc10000 0x0 0x10000>;
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
+	pci2: pcie@ffe0a000 {
+		reg = <0 0xffe0a000 0 0x1000>;
+		ranges = <0x2000000 0x0 0xe0000000 0 0x80000000 0x0 0x20000000
+			  0x1000000 0x0 0x00000000 0 0xffc00000 0x0 0x10000>;
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
+};
+
+/include/ "p2020rdb-pc.dtsi"
+/include/ "fsl/p2020si-post.dtsi"
diff --git a/arch/powerpc/boot/dts/p2020rdb-pc.dtsi b/arch/powerpc/boot/dts/p2020rdb-pc.dtsi
new file mode 100644
index 0000000..c21d1c7
--- /dev/null
+++ b/arch/powerpc/boot/dts/p2020rdb-pc.dtsi
@@ -0,0 +1,241 @@
+/*
+ * P2020 RDB-PC Device Tree Source stub (no addresses or top-level ranges)
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
+		compatible = "fsl,p2020-fcm-nand",
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
+			/* 7MB for JFFS2 based Root file System */
+			reg = <0x00a00000 0x00700000>;
+			label = "NAND JFFS2 Root File System";
+		};
+
+		partition@1100000 {
+			/* 15MB for JFFS2 based Root file System */
+			reg = <0x01100000 0x00f00000>;
+			label = "NAND Writable User area";
+		};
+	};
+
+	L2switch@2,0 {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		compatible = "vitesse-7385";
+		reg = <0x2 0x0 0x20000>;
+	};
+
+	cpld@3,0 {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		compatible = "cpld";
+		reg = <0x3 0x0 0x20000>;
+		read-only;
+	};
+};
+
+&soc {
+	i2c@3000 {
+		rtc@68 {
+			compatible = "pericom,pt7c4338";
+			reg = <0x68>;
+		};
+	};
+
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
+	usb@22000 {
+		phy_type = "ulpi";
+	};
+
+	mdio@24520 {
+		phy0: ethernet-phy@0 {
+			interrupts = <3 1 0 0>;
+			reg = <0x0>;
+			};
+		phy1: ethernet-phy@1 {
+			interrupts = <2 1 0 0>;
+			reg = <0x1>;
+			};
+	};
+
+	mdio@25520 {
+		tbi0: tbi-phy@11 {
+			reg = <0x11>;
+			device_type = "tbi-phy";
+		};
+	};
+
+	mdio@26520 {
+		status = "disabled";
+	};
+
+	ptp_clock@24e00 {
+		fsl,tclk-period = <5>;
+		fsl,tmr-prsc = <200>;
+		fsl,tmr-add = <0xCCCCCCCD>;
+		fsl,tmr-fiper1 = <0x3B9AC9FB>;
+		fsl,tmr-fiper2 = <0x0001869B>;
+		fsl,max-adj = <249999999>;
+	};
+
+	enet0: ethernet@24000 {
+		fixed-link = <1 1 1000 0 0>;
+		phy-connection-type = "rgmii-id";
+	};
+
+	enet1: ethernet@25000 {
+		tbi-handle = <&tbi0>;
+		phy-handle = <&phy0>;
+		phy-connection-type = "sgmii";
+	};
+
+	enet2: ethernet@26000 {
+		phy-handle = <&phy1>;
+		phy-connection-type = "rgmii-id";
+	};
+};
diff --git a/arch/powerpc/boot/dts/p2020rdb-pc_36b.dts b/arch/powerpc/boot/dts/p2020rdb-pc_36b.dts
new file mode 100644
index 0000000..b5a56ca
--- /dev/null
+++ b/arch/powerpc/boot/dts/p2020rdb-pc_36b.dts
@@ -0,0 +1,96 @@
+/*
+ * P2020 RDB-PC 36Bit Physical Address Map Device Tree Source
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
+/include/ "fsl/p2020si-pre.dtsi"
+
+/ {
+	model = "fsl,P2020RDB";
+	compatible = "fsl,P2020RDB-PC";
+
+	memory {
+		device_type = "memory";
+	};
+
+	lbc: localbus@fffe05000 {
+		reg = <0xf 0xffe05000 0 0x1000>;
+
+		/* NOR and NAND Flashes */
+		ranges = <0x0 0x0 0xf 0xef000000 0x01000000
+			  0x1 0x0 0xf 0xff800000 0x00040000
+			  0x2 0x0 0xf 0xffb00000 0x00020000
+			  0x3 0x0 0xf 0xffa00000 0x00020000>;
+	};
+
+	soc: soc@fffe00000 {
+		ranges = <0x0 0xf 0xffe00000 0x100000>;
+	};
+
+	pci0: pcie@fffe08000 {
+		reg = <0xf 0xffe08000 0 0x1000>;
+		status = "disabled";
+	};
+
+	pci1: pcie@fffe09000 {
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
+	pci2: pcie@fffe0a000 {
+		reg = <0xf 0xffe0a000 0 0x1000>;
+		ranges = <0x2000000 0x0 0xe0000000 0xc 0x00000000 0x0 0x20000000
+			  0x1000000 0x0 0x00000000 0xf 0xffc00000 0x0 0x10000>;
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
+};
+
+/include/ "p2020rdb-pc.dtsi"
+/include/ "fsl/p2020si-post.dtsi"
diff --git a/arch/powerpc/boot/dts/p2020rdb-pc_camp_core0.dts b/arch/powerpc/boot/dts/p2020rdb-pc_camp_core0.dts
new file mode 100644
index 0000000..5f44fa2
--- /dev/null
+++ b/arch/powerpc/boot/dts/p2020rdb-pc_camp_core0.dts
@@ -0,0 +1,90 @@
+/*
+ * P2020 RDB-PC P2020 RDB Core0 Device Tree Source in CAMP mode.
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
+ * In CAMP mode, each core needs to have its own dts. Only mpic and L2 cache
+ * can be shared, all the other devices must be assigned to one core only.
+ *
+ * Please note to add "-b 0" for core0's dts compiling.
+ */
+
+/include/ "p2020rdb-pc.dts"
+
+/ {
+	model = "fsl,P2020RDB";
+	compatible = "fsl,P2020RDB-PC", "fsl,MPC85XXRDB-CAMP";
+
+	cpus {
+		PowerPC,P2020@1 {
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
+		dma@c300 {
+			status = "disabled";
+		};
+
+		enet0: ethernet@24000 {
+			status = "disabled";
+		};
+
+		mpic: pic@40000 {
+			protected-sources = <
+			42 76 77 78 79 /* serial1 , dma2 */
+			29 30 34 26 /* enet0, pci1 */
+			0xe0 0xe1 0xe2 0xe3 /* msi */
+			0xe4 0xe5 0xe6 0xe7
+			>;
+		};
+
+		msi@41600 {
+			status = "disabled";
+		};
+	};
+
+	pci1: pcie@ffe09000 {
+		status = "disabled";
+	};
+
+	pci2: pcie@ffe0a000 {
+		status = "disabled";
+	};
+};
diff --git a/arch/powerpc/boot/dts/p2020rdb-pc_camp_core1.dts b/arch/powerpc/boot/dts/p2020rdb-pc_camp_core1.dts
new file mode 100644
index 0000000..2d3c8cf
--- /dev/null
+++ b/arch/powerpc/boot/dts/p2020rdb-pc_camp_core1.dts
@@ -0,0 +1,152 @@
+/*
+ * P2020 RDB-PC P2020 RDB Core1 Device Tree Source in CAMP mode.
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
+ * In CAMP mode, each core needs to have its own dts. Only mpic and L2 cache
+ * can be shared, all the other devices must be assigned to one core only.
+ *
+ * Please note to add "-b 1" for core1's dts compiling.
+ */
+
+/include/ "p2020rdb-pc.dts"
+
+/ {
+	model = "fsl,P2020RDB";
+	compatible = "fsl,P2020RDB-PC", "fsl,MPC85XXRDB-CAMP";
+
+	aliases {
+		ethernet0 = &enet0;
+		serial0 = &serial1;
+	};
+
+	cpus {
+		PowerPC,P2020@0 {
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
+		gpio-controller@f000 {
+			status = "disabled";
+		};
+
+		dma@21300 {
+			status = "disabled";
+		};
+
+		usb@22000 {
+			status = "disabled";
+		};
+
+		mdio@24520 {
+			status = "disabled";
+		};
+
+		mdio@25520 {
+			status = "disabled";
+		};
+
+		mdio@26520 {
+			status = "disabled";
+		};
+
+		enet1: ethernet@25000 {
+			status = "disabled";
+		};
+
+		enet2: ethernet@26000 {
+			status = "disabled";
+		};
+
+		sdhci@2e000 {
+			status = "disabled";
+		};
+
+		crypto@30000 {
+			status = "disabled";
+		};
+
+		mpic: pic@40000 {
+			protected-sources = <
+			17 18 43 42 59 47 /*ecm, mem, i2c, serial0, spi,gpio */
+			16 20 21 22 23 28 	/* L2, dma1, USB */
+			03 35 36 40 31 32 33 	/* mdio, enet1, enet2 */
+			72 45 58 25 		/* sdhci, crypto , pci */
+			>;
+		};
+
+		global-utilities@e0000 {	//global utilities block
+			status = "disabled";
+		};
+
+	};
+
+	pci1: pcie@ffe09000 {
+		status = "disabled";
+	};
+
+	pci2: pcie@ffe0a000 {
+		status = "disabled";
+	};
+};
-- 
1.6.4

Return-Path: <B32736@freescale.com>
Received: from TX2EHSOBE002.bigfish.com (tx2ehsobe002.messaging.microsoft.com
 [65.55.88.12]) (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 28626B72AA
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  9 Feb 2012 16:43:09 +1100 (EST)
From: Zhicheng Fan <B32736@freescale.com>
To: <galak@kernel.crashing.org>, <linuxppc-dev@lists.ozlabs.org>
Subject: [PATCH 2/2 v4] powerpc/dts: Add dts for p1020rdb-pc board
Date: Thu, 9 Feb 2012 13:40:36 +0800
Message-ID: <1328766036-17697-2-git-send-email-B32736@freescale.com>
In-Reply-To: <1328766036-17697-1-git-send-email-B32736@freescale.com>
References: <1328766036-17697-1-git-send-email-B32736@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: Zhicheng Fan <b32736@freeescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Zhicheng Fan <b32736@freeescale.com>

P1020RDB-PC Overview
------------------
1Gbyte DDR3 SDRAM
32 Mbyte NAND flash
10 16Mbyte NOR flash
16 Mbyte SPI flash
SD connector to interface with the SD memory card
Real-time clock on I2C bus

PCIe:
- x1 PCIe slot
- x1 mini-PCIe slot

10/100/1000 BaseT Ethernet ports:
- eTSEC1, RGMII: one 10/100/1000 port using VitesseTM VSC7385 L2 switch
- eTSEC2, SGMII: one 10/100/1000 port using VitesseTM VSC8221
- eTSEC3, RGMII: one 10/100/1000 port using AtherosTM AR8021

USB 2.0 port:
- Two USB2.0 Type A receptacles
- One USB2.0 signal to Mini PCIe slot

Dual RJ45 UART ports:
- DUART interface: supports two UARTs up to 115200 bps for console display

Signed-off-by: Zhicheng Fan <b32736@freeescale.com>
---
 arch/powerpc/boot/dts/p1020rdb-pc.dts            |   90 ++++++++
 arch/powerpc/boot/dts/p1020rdb-pc.dtsi           |  247 ++++++++++++++++++++++
 arch/powerpc/boot/dts/p1020rdb-pc_36b.dts        |   90 ++++++++
 arch/powerpc/boot/dts/p1020rdb-pc_camp_core0.dts |   64 ++++++
 arch/powerpc/boot/dts/p1020rdb-pc_camp_core1.dts |  142 +++++++++++++
 5 files changed, 633 insertions(+), 0 deletions(-)
 create mode 100644 arch/powerpc/boot/dts/p1020rdb-pc.dts
 create mode 100644 arch/powerpc/boot/dts/p1020rdb-pc.dtsi
 create mode 100644 arch/powerpc/boot/dts/p1020rdb-pc_36b.dts
 create mode 100644 arch/powerpc/boot/dts/p1020rdb-pc_camp_core0.dts
 create mode 100644 arch/powerpc/boot/dts/p1020rdb-pc_camp_core1.dts

diff --git a/arch/powerpc/boot/dts/p1020rdb-pc.dts b/arch/powerpc/boot/dts/p1020rdb-pc.dts
new file mode 100644
index 0000000..5c333b0
--- /dev/null
+++ b/arch/powerpc/boot/dts/p1020rdb-pc.dts
@@ -0,0 +1,90 @@
+/*
+ * P1020 RDB-PC Device Tree Source
+ *
+ * Copyright 2012 Freescale Semiconductor Inc.
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
+	model = "fsl,P1020RDB-PC";
+	compatible = "fsl,P1020RDB-PC";
+
+	memory {
+		device_type = "memory";
+	};
+
+	lbc: localbus@ffe05000 {
+		reg = <0 0xffe05000 0 0x1000>;
+
+		/* NOR, NAND Flashes and Vitesse 5 port L2 switch */
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
+	pci0: pcie@ffe09000 {
+		ranges = <0x2000000 0x0 0xa0000000 0 0xa0000000 0x0 0x20000000
+			  0x1000000 0x0 0x00000000 0 0xffc10000 0x0 0x10000>;
+		reg = <0 0xffe09000 0 0x1000>;
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
+/include/ "p1020rdb-pc.dtsi"
+/include/ "fsl/p1020si-post.dtsi"
diff --git a/arch/powerpc/boot/dts/p1020rdb-pc.dtsi b/arch/powerpc/boot/dts/p1020rdb-pc.dtsi
new file mode 100644
index 0000000..c952cd3
--- /dev/null
+++ b/arch/powerpc/boot/dts/p1020rdb-pc.dtsi
@@ -0,0 +1,247 @@
+/*
+ * P1020 RDB-PC Device Tree Source stub (no addresses or top-level ranges)
+ *
+ * Copyright 2012 Freescale Semiconductor Inc.
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
+			     "fsl,elbc-fcm-nand";
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
+			compatible = "spansion,s25sl12801";
+			reg = <0>;
+			spi-max-frequency = <40000000>; /* input clock */
+
+			partition@u-boot {
+				/* 512KB for u-boot Bootloader Image */
+				reg = <0x0 0x00080000>;
+				label = "u-boot";
+				read-only;
+			};
+
+			partition@dtb {
+				/* 512KB for DTB Image*/
+				reg = <0x00080000 0x00080000>;
+				label = "dtb";
+			};
+
+			partition@kernel {
+				/* 4MB for Linux Kernel Image */
+				reg = <0x00100000 0x00400000>;
+				label = "kernel";
+			};
+
+			partition@fs {
+				/* 4MB for Compressed RFS Image */
+				reg = <0x00500000 0x00400000>;
+				label = "file system";
+			};
+
+			partition@jffs-fs {
+				/* 7MB for JFFS2 based RFS */
+				reg = <0x00900000 0x00700000>;
+				label = "file system jffs2";
+			};
+		};
+	};
+
+	usb@22000 {
+		phy_type = "ulpi";
+	};
+
+	/* USB2 is shared with localbus, so it must be disabled
+	   by default. We can't put 'status = "disabled";' here
+	   since U-Boot doesn't clear the status property when
+	   it enables USB2. OTOH, U-Boot does create a new node
+	   when there isn't any. So, just comment it out.
+	usb@23000 {
+		phy_type = "ulpi";
+	};
+	*/
+
+	mdio@24000 {
+		phy0: ethernet-phy@0 {
+			interrupt-parent = <&mpic>;
+			interrupts = <3 1>;
+			reg = <0x0>;
+		};
+
+		phy1: ethernet-phy@1 {
+			interrupt-parent = <&mpic>;
+			interrupts = <2 1>;
+			reg = <0x1>;
+		};
+
+		tbi0: tbi-phy@11 {
+			device_type = "tbi-phy";
+			reg = <0x11>;
+		};
+	};
+
+	mdio@25000 {
+		tbi1: tbi-phy@11 {
+			reg = <0x11>;
+			device_type = "tbi-phy";
+		};
+	};
+
+	enet0: ethernet@b0000 {
+		fixed-link = <1 1 1000 0 0>;
+		phy-connection-type = "rgmii-id";
+
+	};
+
+	enet1: ethernet@b1000 {
+		phy-handle = <&phy0>;
+		tbi-handle = <&tbi1>;
+		phy-connection-type = "sgmii";
+	};
+
+	enet2: ethernet@b2000 {
+		phy-handle = <&phy1>;
+		phy-connection-type = "rgmii-id";
+	};
+};
diff --git a/arch/powerpc/boot/dts/p1020rdb-pc_36b.dts b/arch/powerpc/boot/dts/p1020rdb-pc_36b.dts
new file mode 100644
index 0000000..ca736a0
--- /dev/null
+++ b/arch/powerpc/boot/dts/p1020rdb-pc_36b.dts
@@ -0,0 +1,90 @@
+/*
+ * P1020 RDB-PC Device Tree Source (36-bit address map)
+ *
+ * Copyright 2012 Freescale Semiconductor Inc.
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
+	model = "fsl,P1020RDB-PC";
+	compatible = "fsl,P1020RDB-PC";
+
+	memory {
+		device_type = "memory";
+	};
+
+	lbc: localbus@fffe05000 {
+		reg = <0xf 0xffe05000 0 0x1000>;
+
+		/* NOR, NAND Flashes and Vitesse 5 port L2 switch */
+		ranges = <0x0 0x0 0xf 0xef000000 0x01000000
+			  0x1 0x0 0xf 0xff800000 0x00040000
+			  0x2 0x0 0xf 0xffb00000 0x00040000
+			  0x3 0x0 0xf 0xffa00000 0x00020000>;
+	};
+
+	soc: soc@fffe00000 {
+		ranges = <0x0 0xf 0xffe00000 0x100000>;
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
+		ranges = <0x2000000 0x0 0x80000000 0xc 0x00000000 0x0 0x20000000
+			  0x1000000 0x0 0x00000000 0xf 0xffc00000 0x0 0x10000>;
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
+/include/ "p1020rdb.dtsi"
+/include/ "fsl/p1020si-post.dtsi"
diff --git a/arch/powerpc/boot/dts/p1020rdb-pc_camp_core0.dts b/arch/powerpc/boot/dts/p1020rdb-pc_camp_core0.dts
new file mode 100644
index 0000000..9f93b3a
--- /dev/null
+++ b/arch/powerpc/boot/dts/p1020rdb-pc_camp_core0.dts
@@ -0,0 +1,64 @@
+/*
+ * P1020 RDB-PC  Core0 Device Tree Source in CAMP mode.
+ *
+ * In CAMP mode, each core needs to have its own dts. Only mpic and L2 cache
+ * can be shared, all the other devices must be assigned to one core only.
+ * This dts file allows core0 to have memory, l2, i2c, spi, gpio, tdm, dma, usb,
+ * eth1, eth2, sdhc, crypto, global-util, message, pci0, pci1, msi.
+ *
+ * Please note to add "-b 0" for core0's dts compiling.
+ *
+ * Copyright 2012 Freescale Semiconductor Inc.
+ *
+ * This program is free software; you can redistribute  it and/or modify it
+ * under  the terms of  the GNU General  Public License as published by the
+ * Free Software Foundation;  either version 2 of the  License, or (at your
+ * option) any later version.
+ */
+
+/include/ "p1020rdb-pc.dts"
+
+/ {
+	model = "fsl,P1020RDB-PC";
+	compatible = "fsl,P1020RDB-PC";
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
+		PowerPC,P1020@1 {
+			status = "disabled";
+		};
+	};
+
+	memory {
+		device_type = "memory";
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
+		enet0: ethernet@b0000 {
+			status = "disabled";
+		};
+
+		mpic: pic@40000 {
+			protected-sources = <
+			42 29 30 34	/* serial1, enet0-queue-group0 */
+			17 18 24 45	/* enet0-queue-group1, crypto */
+			>;
+			pic-no-reset;
+		};
+	};
+};
diff --git a/arch/powerpc/boot/dts/p1020rdb-pc_camp_core1.dts b/arch/powerpc/boot/dts/p1020rdb-pc_camp_core1.dts
new file mode 100644
index 0000000..d3281ab
--- /dev/null
+++ b/arch/powerpc/boot/dts/p1020rdb-pc_camp_core1.dts
@@ -0,0 +1,142 @@
+/*
+ * P1020 RDB-PC Core1 Device Tree Source in CAMP mode.
+ *
+ * In CAMP mode, each core needs to have its own dts. Only mpic and L2 cache
+ * can be shared, all the other devices must be assigned to one core only.
+ * This dts allows core1 to have l2, eth0, crypto.
+ *
+ * Please note to add "-b 1" for core1's dts compiling.
+ *
+ * Copyright 2012 Freescale Semiconductor Inc.
+ *
+ * This program is free software; you can redistribute  it and/or modify it
+ * under  the terms of  the GNU General  Public License as published by the
+ * Free Software Foundation;  either version 2 of the  License, or (at your
+ * option) any later version.
+ */
+
+/include/ "p1020rdb-pc.dts"
+
+/ {
+	model = "fsl,P1020RDB-PC";
+	compatible = "fsl,P1020RDB-PC";
+
+	aliases {
+		ethernet0 = &enet0;
+		serial0 = &serial1;
+		};
+
+	cpus {
+		PowerPC,P1020@0 {
+			status = "disabled";
+		};
+	};
+
+	memory {
+		device_type = "memory";
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
+		dma@21300 {
+			status = "disabled";
+		};
+
+		mdio@24000 {
+			status = "disabled";
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
+		usb@22000 {
+			status = "disabled";
+		};
+
+		sdhci@2e000 {
+			status = "disabled";
+		};
+
+		mpic: pic@40000 {
+			protected-sources = <
+			16 		/* ecm, mem, L2, pci0, pci1 */
+			43 42 59	/* i2c, serial0, spi */
+			47 63 62 	/* gpio, tdm */
+			20 21 22 23	/* dma */
+			03 02 		/* mdio */
+			35 36 40	/* enet1-queue-group0 */
+			51 52 67	/* enet1-queue-group1 */
+			31 32 33	/* enet2-queue-group0 */
+			25 26 27	/* enet2-queue-group1 */
+			28 72 58 	/* usb, sdhci, crypto */
+			0xb0 0xb1 0xb2	/* message */
+			0xb3 0xb4 0xb5
+			0xb6 0xb7
+			0xe0 0xe1 0xe2	/* msi */
+			0xe3 0xe4 0xe5
+			0xe6 0xe7		/* sdhci, crypto , pci */
+			>;
+			pic-no-reset;
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
1.7.0.4

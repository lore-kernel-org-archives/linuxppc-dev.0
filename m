Return-Path: <B32736@freescale.com>
Received: from VA3EHSOBE005.bigfish.com (va3ehsobe004.messaging.microsoft.com
 [216.32.180.14]) (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 26312B71AA
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 10 Feb 2012 21:21:09 +1100 (EST)
From: Zhicheng Fan <B32736@freescale.com>
To: <linuxppc-dev@lists.ozlabs.org>, <galak@kernel.crashing.org>
Subject: [PATCH 2/2 v3] powerpc/dts: Add dts for p1025rdb board
Date: Fri, 10 Feb 2012 18:18:16 +0800
Message-ID: <1328869096-23994-2-git-send-email-B32736@freescale.com>
In-Reply-To: <1328869096-23994-1-git-send-email-B32736@freescale.com>
References: <1328869096-23994-1-git-send-email-B32736@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: Zhicheng Fan <b32736@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Zhicheng Fan <b32736@freescale.com>

P1025RDB Overview
------------------
1Gbyte DDR3 SDRAM
32 Mbyte NAND flash
16Mbyte NOR flash
16 Mbyte SPI flash
SD connector to interface with the SD memory card
Real-time clock on I2C bus

PCIe:
- x1 PCIe slot
- x1 mini-PCIe slot

10/100/1000 BaseT Ethernet ports:
- eTSEC1, RGMII: one 10/100/1000 port using AtherosTM AR8021
- eTSEC2, SGMII: one 10/100/1000 port using VitesseTM VSC8221
- eTSEC3, RGMII: one 10/100/1000 port using AtherosTM AR8021

USB 2.0 port:
- Two USB2.0 Type A receptacles
- One USB2.0 signal to Mini PCIe slot

Dual RJ45 UART ports:
- DUART interface: supports two UARTs up to 115200 bps for console display

Signed-off-by: Zhicheng Fan <b32736@freescale.com>
---
 arch/powerpc/boot/dts/p1025rdb.dtsi    |  286 ++++++++++++++++++++++++++++++++
 arch/powerpc/boot/dts/p1025rdb_32b.dts |  137 +++++++++++++++
 arch/powerpc/boot/dts/p1025rdb_36b.dts |   88 ++++++++++
 3 files changed, 511 insertions(+), 0 deletions(-)
 create mode 100644 arch/powerpc/boot/dts/p1025rdb.dtsi
 create mode 100644 arch/powerpc/boot/dts/p1025rdb_32b.dts
 create mode 100644 arch/powerpc/boot/dts/p1025rdb_36b.dts

diff --git a/arch/powerpc/boot/dts/p1025rdb.dtsi b/arch/powerpc/boot/dts/p1025rdb.dtsi
new file mode 100644
index 0000000..cf3676f
--- /dev/null
+++ b/arch/powerpc/boot/dts/p1025rdb.dtsi
@@ -0,0 +1,286 @@
+/*
+ * P1025 RDB Device Tree Source stub (no addresses or top-level ranges)
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
+		compatible = "fsl,p1025-fcm-nand",
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
+};
+
+&soc {
+	i2c@3000 {
+		rtc@68 {
+			compatible = "dallas,ds1339";
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
+				/* 512KB for DTB Image */
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
+			reg = <0x11>;
+			device_type = "tbi-phy";
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
+	mdio@26000 {
+		tbi2: tbi-phy@11 {
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
+
+	par_io@e0100 {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		reg = <0xe0100 0x60>;
+		ranges = <0x0 0xe0100 0x60>;
+		device_type = "par_io";
+		num-ports = <3>;
+		pio1: ucc_pin@01 {
+			pio-map = <
+		/* port  pin  dir  open_drain  assignment  has_irq */
+				0x1  0x13 0x1  0x0  0x1  0x0    /* QE_MUX_MDC */
+				0x1  0x14 0x3  0x0  0x1  0x0    /* QE_MUX_MDIO */
+				0x0  0x17 0x2  0x0  0x2  0x0    /* CLK12 */
+				0x0  0x18 0x2  0x0  0x1  0x0    /* CLK9 */
+				0x0  0x7  0x1  0x0  0x2  0x0    /* ENET1_TXD0_SER1_TXD0 */
+				0x0  0x9  0x1  0x0  0x2  0x0    /* ENET1_TXD1_SER1_TXD1 */
+				0x0  0xb  0x1  0x0  0x2  0x0    /* ENET1_TXD2_SER1_TXD2 */
+				0x0  0xc  0x1  0x0  0x2  0x0    /* ENET1_TXD3_SER1_TXD3 */
+				0x0  0x6  0x2  0x0  0x2  0x0    /* ENET1_RXD0_SER1_RXD0 */
+				0x0  0xa  0x2  0x0  0x2  0x0    /* ENET1_RXD1_SER1_RXD1 */
+				0x0  0xe  0x2  0x0  0x2  0x0    /* ENET1_RXD2_SER1_RXD2 */
+				0x0  0xf  0x2  0x0  0x2  0x0    /* ENET1_RXD3_SER1_RXD3 */
+				0x0  0x5  0x1  0x0  0x2  0x0    /* ENET1_TX_EN_SER1_RTS_B */
+				0x0  0xd  0x1  0x0  0x2  0x0    /* ENET1_TX_ER */
+				0x0  0x4  0x2  0x0  0x2  0x0    /* ENET1_RX_DV_SER1_CTS_B */
+				0x0  0x8  0x2  0x0  0x2  0x0    /* ENET1_RX_ER_SER1_CD_B */
+				0x0  0x11 0x2  0x0  0x2  0x0    /* ENET1_CRS */
+				0x0  0x10 0x2  0x0  0x2  0x0>;    /* ENET1_COL */
+		};
+
+		pio2: ucc_pin@02 {
+			pio-map = <
+		/* port  pin  dir  open_drain  assignment  has_irq */
+				0x1  0x13 0x1  0x0  0x1  0x0    /* QE_MUX_MDC */
+				0x1  0x14 0x3  0x0  0x1  0x0    /* QE_MUX_MDIO */
+				0x1  0xb  0x2  0x0  0x1  0x0    /* CLK13 */
+				0x1  0x7  0x1  0x0  0x2  0x0    /* ENET5_TXD0_SER5_TXD0 */
+				0x1  0xa  0x1  0x0  0x2  0x0    /* ENET5_TXD1_SER5_TXD1 */
+				0x1  0x6  0x2  0x0  0x2  0x0    /* ENET5_RXD0_SER5_RXD0 */
+				0x1  0x9  0x2  0x0  0x2  0x0    /* ENET5_RXD1_SER5_RXD1 */
+				0x1  0x5  0x1  0x0  0x2  0x0    /* ENET5_TX_EN_SER5_RTS_B */
+				0x1  0x4  0x2  0x0  0x2  0x0    /* ENET5_RX_DV_SER5_CTS_B */
+				0x1  0x8  0x2  0x0  0x2  0x0>;    /* ENET5_RX_ER_SER5_CD_B */
+		};
+	};
+};
diff --git a/arch/powerpc/boot/dts/p1025rdb_32b.dts b/arch/powerpc/boot/dts/p1025rdb_32b.dts
new file mode 100644
index 0000000..b0ffc13
--- /dev/null
+++ b/arch/powerpc/boot/dts/p1025rdb_32b.dts
@@ -0,0 +1,137 @@
+/*
+ * P1025 RDB Device Tree Source (32-bit address map)
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
+/include/ "fsl/p1021si-pre.dtsi"
+/ {
+	model = "fsl,P1025RDB";
+	compatible = "fsl,P1025RDB";
+
+	memory {
+		device_type = "memory";
+	};
+
+	lbc: localbus@ffe05000 {
+		reg = <0 0xffe05000 0 0x1000>;
+
+		/* NOR, NAND Flashes */
+		ranges = <0x0 0x0 0x0 0xef000000 0x01000000
+			  0x1 0x0 0x0 0xff800000 0x00040000>;
+	};
+
+	soc: soc@ffe00000 {
+		ranges = <0x0 0x0 0xffe00000 0x100000>;
+	};
+
+	pci0: pcie@ffe09000 {
+		ranges = <0x2000000 0x0 0xe0000000 0 0xe0000000 0x0 0x20000000
+			  0x1000000 0x0 0x00000000 0 0xffc10000 0x0 0x10000>;
+		reg = <0 0xffe09000 0 0x1000>;
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
+		reg = <0 0xffe0a000 0 0x1000>;
+		ranges = <0x2000000 0x0 0xe0000000 0 0xe0000000 0x0 0x20000000
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
+
+	qe: qe@ffe80000 {
+		ranges = <0x0 0x0 0xffe80000 0x40000>;
+		reg = <0 0xffe80000 0 0x480>;
+		brg-frequency = <0>;
+		bus-frequency = <0>;
+		status = "disabled"; /* no firmware loaded */
+
+		enet3: ucc@2000 {
+			device_type = "network";
+			compatible = "ucc_geth";
+			local-mac-address = [ 00 00 00 00 00 00 ];
+			rx-clock-name = "clk12";
+			tx-clock-name = "clk9";
+			pio-handle = <&pio1>;
+			phy-handle = <&qe_phy0>;
+			phy-connection-type = "mii";
+		};
+
+		mdio@2120 {
+			qe_phy0: ethernet-phy@0 {
+				interrupt-parent = <&mpic>;
+				interrupts = <4 1 0 0>;
+				reg = <0x6>;
+				device_type = "ethernet-phy";
+			};
+			qe_phy1: ethernet-phy@03 {
+				interrupt-parent = <&mpic>;
+				interrupts = <5 1 0 0>;
+				reg = <0x3>;
+				device_type = "ethernet-phy";
+			};
+			tbi-phy@11 {
+				reg = <0x11>;
+				device_type = "tbi-phy";
+			};
+		};
+
+		enet4: ucc@2400 {
+			device_type = "network";
+			compatible = "ucc_geth";
+			local-mac-address = [ 00 00 00 00 00 00 ];
+			rx-clock-name = "none";
+			tx-clock-name = "clk13";
+			pio-handle = <&pio2>;
+			phy-handle = <&qe_phy1>;
+			phy-connection-type = "rmii";
+		};
+	};
+};
+
+/include/ "p1025rdb.dtsi"
+/include/ "fsl/p1021si-post.dtsi"
diff --git a/arch/powerpc/boot/dts/p1025rdb_36b.dts b/arch/powerpc/boot/dts/p1025rdb_36b.dts
new file mode 100644
index 0000000..4ce4bfa
--- /dev/null
+++ b/arch/powerpc/boot/dts/p1025rdb_36b.dts
@@ -0,0 +1,88 @@
+/*
+ * P1025 RDB Device Tree Source (36-bit address map)
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
+/include/ "fsl/p1021si-pre.dtsi"
+/ {
+	model = "fsl,P1025RDB";
+	compatible = "fsl,P1025RDB";
+
+	memory {
+		device_type = "memory";
+	};
+
+	lbc: localbus@fffe05000 {
+		reg = <0xf 0xffe05000 0 0x1000>;
+
+		/* NOR, NAND Flashes */
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
+		ranges = <0x2000000 0x0 0xe0000000 0xe 0x20000000 0x0 0x20000000
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
+/include/ "p1025rdb.dtsi"
+/include/ "fsl/p1021si-post.dtsi"
-- 
1.7.0.4

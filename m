Return-Path: <Shengzhou.Liu@freescale.com>
Received: from va3outboundpool.messaging.microsoft.com
 (va3ehsobe002.messaging.microsoft.com [216.32.180.12])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 33B452C00D8
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 Dec 2013 22:00:21 +1100 (EST)
Received: from mail91-va3 (localhost [127.0.0.1])	by mail91-va3-R.bigfish.com
 (Postfix) with ESMTP id 76B1C600E5	for
 <linuxppc-dev@lists.ozlabs.org>; Wed,
 25 Dec 2013 11:00:16 +0000 (UTC)
From: Shengzhou Liu <Shengzhou.Liu@freescale.com>
To: <linuxppc-dev@lists.ozlabs.org>, <scottwood@freescale.com>
Subject: [PATCH 4/4] powerpc/fsl-booke: Add initial T208x QDS board support
Date: Wed, 25 Dec 2013 18:06:58 +0800
Message-ID: <1387966018-10131-4-git-send-email-Shengzhou.Liu@freescale.com>
In-Reply-To: <1387966018-10131-1-git-send-email-Shengzhou.Liu@freescale.com>
References: <1387966018-10131-1-git-send-email-Shengzhou.Liu@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: Shengzhou Liu <Shengzhou.Liu@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Add support for Freescale T2080/T2081 QDS Development System Board.
T2081QDS board shares the same PCB with T1040QDS with some differences.

The T2080QDS Development System is a high-performance computing,
evaluation, and development platform that supports T2080 QorIQ
Power Architecture processor, with following major features:

T2080QDS feature overview:
Processor:
 - T2080 SoC integrating four 64-bit dual-threads e6500 cores up to 1.8GHz
Memory:
 - Single memory controller capable of supporting DDR3 and DDR3-LV devices
 - Two DDR3 memory, 4GB, Dual rank @ 1866 Mbps data rate, and ECC support
Ethernet interfaces:
 - Two 1Gbps RGMII on-board ports
 - Four 10Gbps XFI on-board cages
 - 1Gbps/2.5Gbps SGMII Riser card
 - 10Gbps XAUI Riser card
Accelerator:
 - DPAA components consist of FMan, BMan, QMan, PME, DCE and SEC
SerDes:
 - 16 lanes up to 10.3125GHz
 - Supports Aurora debug, PEX, SATA, SGMII, sRIO, HiGig, XFI and XAUI
IFC:
 - 128MB NOR Flash, 512MB NAND Flash, PromJet debug port and FPGA
eSPI:
 - Three SPI flash (16MB N25Q128A + 16MB EN25S64 + 512KB SST25WF040)
USB:
 - Two USB2.0 ports with internal PHY (one Type-A + one micro Type-AB)
PCIE:
 - Four PCI Express controllers (two PCIe 2.0 and two PCIe 3.0 with SR-IOV)
SATA:
 - Two SATA 2.0 ports on-board
SRIO:
 - Two Serial RapidIO 2.0 ports up to 5 GHz
eSDHC:
 - Supports SD/MMC/eMMC Card
DMA:
 - Three 8-channels DMA controllers
I2C:
 - Four I2C controllers.
UART:
 - Dual 4-pins UART serial ports
System Logic:
 - QIXIS-II FPGA system controll

Differences between T2080 and T2081:
  Feature               T2080 T2081
  1G Ethernet numbers:  8     6
  10G Ethernet numbers: 4     2
  SerDes lanes:         16    8
  Serial RapidIO,RMan:  2     no
  SATA Controller:      2     no
  Aurora:               yes   no
  SoC Package:          896-pins 780-pins

Signed-off-by: Shengzhou Liu <Shengzhou.Liu@freescale.com>
---
 arch/powerpc/boot/dts/t2080qds.dts            |  57 +++++++
 arch/powerpc/boot/dts/t2081qds.dts            |  46 ++++++
 arch/powerpc/boot/dts/t208xqds.dtsi           | 213 ++++++++++++++++++++++++++
 arch/powerpc/platforms/85xx/Kconfig           |   2 +-
 arch/powerpc/platforms/85xx/corenet_generic.c |   4 +
 5 files changed, 321 insertions(+), 1 deletion(-)
 create mode 100644 arch/powerpc/boot/dts/t2080qds.dts
 create mode 100644 arch/powerpc/boot/dts/t2081qds.dts
 create mode 100644 arch/powerpc/boot/dts/t208xqds.dtsi

diff --git a/arch/powerpc/boot/dts/t2080qds.dts b/arch/powerpc/boot/dts/t2080qds.dts
new file mode 100644
index 0000000..aa1d6d8
--- /dev/null
+++ b/arch/powerpc/boot/dts/t2080qds.dts
@@ -0,0 +1,57 @@
+/*
+ * T2080QDS Device Tree Source
+ *
+ * Copyright 2013 Freescale Semiconductor Inc.
+ *
+ * Redistribution and use in source and binary forms, with or without
+ * modification, are permitted provided that the following conditions are met:
+ *     * Redistributions of source code must retain the above copyright
+ *	 notice, this list of conditions and the following disclaimer.
+ *     * Redistributions in binary form must reproduce the above copyright
+ *	 notice, this list of conditions and the following disclaimer in the
+ *	 documentation and/or other materials provided with the distribution.
+ *     * Neither the name of Freescale Semiconductor nor the
+ *	 names of its contributors may be used to endorse or promote products
+ *	 derived from this software without specific prior written permission.
+ *
+ *
+ * ALTERNATIVELY, this software may be distributed under the terms of the
+ * GNU General Public License ("GPL") as published by the Free Software
+ * Foundation, either version 2 of that License or (at your option) any
+ * later version.
+ *
+ * THIS SOFTWARE IS PROVIDED BY Freescale Semiconductor "AS IS" AND ANY
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
+/include/ "fsl/t208xsi-pre.dtsi"
+/include/ "t208xqds.dtsi"
+
+/ {
+	model = "fsl,T2080QDS";
+	compatible = "fsl,T2080QDS";
+	#address-cells = <2>;
+	#size-cells = <2>;
+	interrupt-parent = <&mpic>;
+
+	rio: rapidio@ffe0c0000 {
+		reg = <0xf 0xfe0c0000 0 0x11000>;
+
+		port1 {
+			ranges = <0 0 0xc 0x20000000 0 0x10000000>;
+		};
+		port2 {
+			ranges = <0 0 0xc 0x30000000 0 0x10000000>;
+		};
+	};
+};
+
+/include/ "fsl/t2080si-post.dtsi"
diff --git a/arch/powerpc/boot/dts/t2081qds.dts b/arch/powerpc/boot/dts/t2081qds.dts
new file mode 100644
index 0000000..8ec80a7
--- /dev/null
+++ b/arch/powerpc/boot/dts/t2081qds.dts
@@ -0,0 +1,46 @@
+/*
+ * T2081QDS Device Tree Source
+ *
+ * Copyright 2013 Freescale Semiconductor Inc.
+ *
+ * Redistribution and use in source and binary forms, with or without
+ * modification, are permitted provided that the following conditions are met:
+ *     * Redistributions of source code must retain the above copyright
+ *	 notice, this list of conditions and the following disclaimer.
+ *     * Redistributions in binary form must reproduce the above copyright
+ *	 notice, this list of conditions and the following disclaimer in the
+ *	 documentation and/or other materials provided with the distribution.
+ *     * Neither the name of Freescale Semiconductor nor the
+ *	 names of its contributors may be used to endorse or promote products
+ *	 derived from this software without specific prior written permission.
+ *
+ *
+ * ALTERNATIVELY, this software may be distributed under the terms of the
+ * GNU General Public License ("GPL") as published by the Free Software
+ * Foundation, either version 2 of that License or (at your option) any
+ * later version.
+ *
+ * THIS SOFTWARE IS PROVIDED BY Freescale Semiconductor "AS IS" AND ANY
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
+/include/ "fsl/t208xsi-pre.dtsi"
+/include/ "t208xqds.dtsi"
+
+/ {
+	model = "fsl,T2081QDS";
+	compatible = "fsl,T2081QDS";
+	#address-cells = <2>;
+	#size-cells = <2>;
+	interrupt-parent = <&mpic>;
+};
+
+/include/ "fsl/t2081si-post.dtsi"
diff --git a/arch/powerpc/boot/dts/t208xqds.dtsi b/arch/powerpc/boot/dts/t208xqds.dtsi
new file mode 100644
index 0000000..54e2a1e
--- /dev/null
+++ b/arch/powerpc/boot/dts/t208xqds.dtsi
@@ -0,0 +1,213 @@
+/*
+ * T2080/T2081 QDS Device Tree Source
+ *
+ * Copyright 2013 Freescale Semiconductor Inc.
+ *
+ * Redistribution and use in source and binary forms, with or without
+ * modification, are permitted provided that the following conditions are met:
+ *     * Redistributions of source code must retain the above copyright
+ *	 notice, this list of conditions and the following disclaimer.
+ *     * Redistributions in binary form must reproduce the above copyright
+ *	 notice, this list of conditions and the following disclaimer in the
+ *	 documentation and/or other materials provided with the distribution.
+ *     * Neither the name of Freescale Semiconductor nor the
+ *	 names of its contributors may be used to endorse or promote products
+ *	 derived from this software without specific prior written permission.
+ *
+ *
+ * ALTERNATIVELY, this software may be distributed under the terms of the
+ * GNU General Public License ("GPL") as published by the Free Software
+ * Foundation, either version 2 of that License or (at your option) any
+ * later version.
+ *
+ * THIS SOFTWARE IS PROVIDED BY Freescale Semiconductor "AS IS" AND ANY
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
+/ {
+	model = "fsl,T2080QDS";
+	compatible = "fsl,T2080QDS";
+	#address-cells = <2>;
+	#size-cells = <2>;
+	interrupt-parent = <&mpic>;
+
+	ifc: localbus@ffe124000 {
+		reg = <0xf 0xfe124000 0 0x2000>;
+		ranges = <0 0 0xf 0xe8000000 0x08000000
+			  2 0 0xf 0xff800000 0x00010000
+			  3 0 0xf 0xffdf0000 0x00008000>;
+
+		nor@0,0 {
+			#address-cells = <1>;
+			#size-cells = <1>;
+			compatible = "cfi-flash";
+			reg = <0x0 0x0 0x8000000>;
+			bank-width = <2>;
+			device-width = <1>;
+		};
+
+		nand@2,0 {
+			#address-cells = <1>;
+			#size-cells = <1>;
+			compatible = "fsl,ifc-nand";
+			reg = <0x2 0x0 0x10000>;
+		};
+
+		boardctrl: board-control@3,0 {
+			#address-cells = <1>;
+			#size-cells = <1>;
+			compatible = "fsl,fpga-qixis";
+			reg = <3 0 0x300>;
+			ranges = <0 3 0 0x300>;
+		};
+	};
+
+	memory {
+		device_type = "memory";
+	};
+
+	dcsr: dcsr@f00000000 {
+		ranges = <0x00000000 0xf 0x00000000 0x01072000>;
+	};
+
+	soc: soc@ffe000000 {
+		ranges = <0x00000000 0xf 0xfe000000 0x1000000>;
+		reg = <0xf 0xfe000000 0 0x00001000>;
+		spi@110000 {
+			flash@0 {
+				#address-cells = <1>;
+				#size-cells = <1>;
+				compatible = "spansion,s25sl12801";
+				reg = <0>;
+				spi-max-frequency = <40000000>; /* input clock */
+			};
+
+			flash@1 {
+				#address-cells = <1>;
+				#size-cells = <1>;
+				compatible = "sst,sst25wf040";
+				reg = <1>;
+				spi-max-frequency = <40000000>; /* input clock */
+			};
+		};
+
+		i2c@118000 {
+			pca9547@77 {
+				compatible = "nxp,pca9547";
+				reg = <0x77>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				i2c@0 {
+					#address-cells = <1>;
+					#size-cells = <0>;
+					reg = <0x0>;
+
+					eeprom@50 {
+						compatible = "at24,24c256";
+						reg = <0x50>;
+					};
+
+					eeprom@51 {
+						compatible = "at24,24c02";
+						reg = <0x51>;
+					};
+
+					eeprom@57 {
+						compatible = "at24,24c02";
+						reg = <0x57>;
+					};
+
+					rtc@68 {
+						compatible = "dallas,ds3232";
+						reg = <0x68>;
+						interrupts = <0x1 0x1 0 0>;
+					};
+				};
+
+				i2c@1 {
+					#address-cells = <1>;
+					#size-cells = <0>;
+					reg = <0x1>;
+
+					eeprom@55 {
+						compatible = "at24,24c02";
+						reg = <0x55>;
+					};
+				};
+			};
+		};
+
+		sdhc@114000 {
+			voltage-ranges = <1800 1800 3300 3300>;
+		};
+	};
+
+	pci0: pcie@ffe240000 {
+		reg = <0xf 0xfe240000 0 0x10000>;
+		ranges = <0x02000000 0 0xe0000000 0xc 0x00000000 0x0 0x20000000
+			  0x01000000 0 0x00000000 0xf 0xf8000000 0x0 0x00010000>;
+		pcie@0 {
+			ranges = <0x02000000 0 0xe0000000
+				  0x02000000 0 0xe0000000
+				  0 0x20000000
+
+				  0x01000000 0 0x00000000
+				  0x01000000 0 0x00000000
+				  0 0x00010000>;
+		};
+	};
+
+	pci1: pcie@ffe250000 {
+		reg = <0xf 0xfe250000 0 0x10000>;
+		ranges = <0x02000000 0x0 0xe0000000 0xc 0x20000000 0x0 0x10000000
+			  0x01000000 0x0 0x00000000 0xf 0xf8010000 0x0 0x00010000>;
+		pcie@0 {
+			ranges = <0x02000000 0 0xe0000000
+				  0x02000000 0 0xe0000000
+				  0 0x20000000
+
+				  0x01000000 0 0x00000000
+				  0x01000000 0 0x00000000
+				  0 0x00010000>;
+		};
+	};
+
+	pci2: pcie@ffe260000 {
+		reg = <0xf 0xfe260000 0 0x1000>;
+		ranges = <0x02000000 0 0xe0000000 0xc 0x30000000 0 0x10000000
+			  0x01000000 0 0x00000000 0xf 0xf8020000 0 0x00010000>;
+		pcie@0 {
+			ranges = <0x02000000 0 0xe0000000
+				  0x02000000 0 0xe0000000
+				  0 0x20000000
+
+				  0x01000000 0 0x00000000
+				  0x01000000 0 0x00000000
+				  0 0x00010000>;
+		};
+	};
+
+	pci3: pcie@ffe270000 {
+		reg = <0xf 0xfe270000 0 0x10000>;
+		ranges = <0x02000000 0 0xe0000000 0xc 0x40000000 0 0x10000000
+			  0x01000000 0 0x00000000 0xf 0xf8030000 0 0x00010000>;
+		pcie@0 {
+			ranges = <0x02000000 0 0xe0000000
+				  0x02000000 0 0xe0000000
+				  0 0x20000000
+
+				  0x01000000 0 0x00000000
+				  0x01000000 0 0x00000000
+				  0 0x00010000>;
+		};
+	};
+};
diff --git a/arch/powerpc/platforms/85xx/Kconfig b/arch/powerpc/platforms/85xx/Kconfig
index 4d46349..e3578b7 100644
--- a/arch/powerpc/platforms/85xx/Kconfig
+++ b/arch/powerpc/platforms/85xx/Kconfig
@@ -259,7 +259,7 @@ config CORENET_GENERIC
 	  For 32bit kernel, the following boards are supported:
 	    P2041 RDB, P3041 DS and P4080 DS
 	  For 64bit kernel, the following boards are supported:
-	    T4240 QDS and B4 QDS
+	    T208x QDS, T4240 QDS and B4 QDS
 	  The following boards are supported for both 32bit and 64bit kernel:
 	    P5020 DS and P5040 DS
 
diff --git a/arch/powerpc/platforms/85xx/corenet_generic.c b/arch/powerpc/platforms/85xx/corenet_generic.c
index fbd871e..77fd71f 100644
--- a/arch/powerpc/platforms/85xx/corenet_generic.c
+++ b/arch/powerpc/platforms/85xx/corenet_generic.c
@@ -102,6 +102,8 @@ static const char * const boards[] __initconst = {
 	"fsl,P4080DS",
 	"fsl,P5020DS",
 	"fsl,P5040DS",
+	"fsl,T2080QDS",
+	"fsl,T2081QDS",
 	"fsl,T4240QDS",
 	"fsl,B4860QDS",
 	"fsl,B4420QDS",
@@ -115,6 +117,8 @@ static const char * const hv_boards[] __initconst = {
 	"fsl,P4080DS-hv",
 	"fsl,P5020DS-hv",
 	"fsl,P5040DS-hv",
+	"fsl,T2080QDS-hv",
+	"fsl,T2081QDS-hv"
 	"fsl,T4240QDS-hv",
 	"fsl,B4860QDS-hv",
 	"fsl,B4420QDS-hv",
-- 
1.8.0

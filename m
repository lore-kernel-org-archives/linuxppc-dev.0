Return-Path: <Shengzhou.Liu@freescale.com>
Received: from co9outboundpool.messaging.microsoft.com
 (co9ehsobe004.messaging.microsoft.com [207.46.163.27])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 5471B2C0328
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  3 Mar 2014 21:56:56 +1100 (EST)
Received: from mail51-co9 (localhost [127.0.0.1])	by mail51-co9-R.bigfish.com
 (Postfix) with ESMTP id 4EE744C0277	for
 <linuxppc-dev@lists.ozlabs.org>; Mon, 3 Mar 2014 10:56:52 +0000 (UTC)
From: Shengzhou Liu <Shengzhou.Liu@freescale.com>
To: <linuxppc-dev@lists.ozlabs.org>, <scottwood@freescale.com>
Subject: [PATCH 3/3] powerpc/t2080rdb: Add T2080RDB board support
Date: Mon, 3 Mar 2014 17:50:20 +0800
Message-ID: <1393840220-31086-3-git-send-email-Shengzhou.Liu@freescale.com>
In-Reply-To: <1393840220-31086-1-git-send-email-Shengzhou.Liu@freescale.com>
References: <1393840220-31086-1-git-send-email-Shengzhou.Liu@freescale.com>
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

T2080PCIe-RDB is a Freescale Reference Design Board that hosts the T2080 SoC.
The board feature overview:
Processor:
 - T2080 SoC integrating four 64-bit dual-threads e6500 cores up to 1.8GHz
DDR Memory:
 - Single memory controller capable of supporting DDR3 and DDR3-LP devices
 - 72bit 4GB DDR3-LP SODIMM in slot
Ethernet interfaces:
 - Two 10M/100M/1Gbps RGMII ports on-board
 - Two 10Gbps SFP+ ports on-board
 - Two 10Gbps Base-T ports on-board
Accelerator:
 - DPAA components consist of FMan, BMan, QMan, PME, DCE and SEC
SerDes 16 lanes configuration:
 - SerDes-1 Lane A-B: to two 10G SFP+ (MAC9 & MAC10)
 - SerDes-1 Lane C-D: to two 10G Base-T (MAC1 & MAC2)
 - SerDes-1 Lane E-H: to PCIe goldfinger (PCIe4 x4, Gen3)
 - SerDes-2 Lane A-D: to PCIe slot (PCIe1 x4, Gen2)
 - SerDes-2 Lane E-F: to C293 secure co-processor (PCIe2 x2)
 - SerDes-2 Lane G-H: to SATA1 & SATA2
IFC/Local Bus
 - NOR:  128MB 16-bit NOR flash
 - NAND: 512MB 8-bit NAND flash
 - CPLD: for system controlling with programable header on-board
eSPI:
 - 64MB N25Q512 SPI flash
USB:
 - Two USB2.0 ports with internal PHY (both Type-A)
PCIe:
 - One PCIe x4 gold-finger
 - One PCIe x4 connector
 - One PCIe x2 end-point device (C293 crypto co-processor)
SATA:
 - Two SATA 2.0 ports on-board
SDHC:
 - support a TF-card on-board
I2C:
 - Four I2C controllers.
UART:
 - Dual 4-pins UART serial ports

This board can work in two mode: standalone mode and PCIe endpoint mode.

Signed-off-by: Shengzhou Liu <Shengzhou.Liu@freescale.com>
---
 arch/powerpc/boot/dts/t2080rdb.dts            |  57 +++++++
 arch/powerpc/boot/dts/t208xrdb.dtsi           | 210 ++++++++++++++++++++++++++
 arch/powerpc/platforms/85xx/Kconfig           |   2 +-
 arch/powerpc/platforms/85xx/corenet_generic.c |   4 +-
 4 files changed, 271 insertions(+), 2 deletions(-)
 create mode 100644 arch/powerpc/boot/dts/t2080rdb.dts
 create mode 100644 arch/powerpc/boot/dts/t208xrdb.dtsi

diff --git a/arch/powerpc/boot/dts/t2080rdb.dts b/arch/powerpc/boot/dts/t2080rdb.dts
new file mode 100644
index 0000000..e889104
--- /dev/null
+++ b/arch/powerpc/boot/dts/t2080rdb.dts
@@ -0,0 +1,57 @@
+/*
+ * T2080PCIe-RDB Board Device Tree Source
+ *
+ * Copyright 2014 Freescale Semiconductor Inc.
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
+/include/ "t208xrdb.dtsi"
+
+/ {
+	model = "fsl,T2080RDB";
+	compatible = "fsl,T2080RDB";
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
diff --git a/arch/powerpc/boot/dts/t208xrdb.dtsi b/arch/powerpc/boot/dts/t208xrdb.dtsi
new file mode 100644
index 0000000..439a5c1
--- /dev/null
+++ b/arch/powerpc/boot/dts/t208xrdb.dtsi
@@ -0,0 +1,210 @@
+/*
+ * T2080/T2081PCIe-RDB Board Device Tree Source
+ *
+ * Copyright 2014 Freescale Semiconductor Inc.
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
+	model = "fsl,T2080RDB";
+	compatible = "fsl,T2080RDB";
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
+
+			bank-width = <2>;
+			device-width = <1>;
+		};
+
+		nand@1,0 {
+			#address-cells = <1>;
+			#size-cells = <1>;
+			compatible = "fsl,ifc-nand";
+			reg = <0x2 0x0 0x10000>;
+		};
+
+		boardctrl: board-control@2,0 {
+			#address-cells = <1>;
+			#size-cells = <1>;
+			compatible = "fsl,t2080-cpld";
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
+				compatible = "micron,n25q512a";
+				reg = <0>;
+				spi-max-frequency = <10000000>; /* input clock */
+			};
+
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
index e3578b7..a8a0f2f 100644
--- a/arch/powerpc/platforms/85xx/Kconfig
+++ b/arch/powerpc/platforms/85xx/Kconfig
@@ -259,7 +259,7 @@ config CORENET_GENERIC
 	  For 32bit kernel, the following boards are supported:
 	    P2041 RDB, P3041 DS and P4080 DS
 	  For 64bit kernel, the following boards are supported:
-	    T208x QDS, T4240 QDS and B4 QDS
+	    T208x QDS/RDB, T4240 QDS and B4 QDS
 	  The following boards are supported for both 32bit and 64bit kernel:
 	    P5020 DS and P5040 DS
 
diff --git a/arch/powerpc/platforms/85xx/corenet_generic.c b/arch/powerpc/platforms/85xx/corenet_generic.c
index 77fd71f..a4fdb7e 100644
--- a/arch/powerpc/platforms/85xx/corenet_generic.c
+++ b/arch/powerpc/platforms/85xx/corenet_generic.c
@@ -103,6 +103,7 @@ static const char * const boards[] __initconst = {
 	"fsl,P5020DS",
 	"fsl,P5040DS",
 	"fsl,T2080QDS",
+	"fsl,T2080RDB",
 	"fsl,T2081QDS",
 	"fsl,T4240QDS",
 	"fsl,B4860QDS",
@@ -118,7 +119,8 @@ static const char * const hv_boards[] __initconst = {
 	"fsl,P5020DS-hv",
 	"fsl,P5040DS-hv",
 	"fsl,T2080QDS-hv",
-	"fsl,T2081QDS-hv"
+	"fsl,T2080RDB-hv",
+	"fsl,T2081QDS-hv",
 	"fsl,T4240QDS-hv",
 	"fsl,B4860QDS-hv",
 	"fsl,B4420QDS-hv",
-- 
1.8.0

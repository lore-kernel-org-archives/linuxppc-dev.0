Return-Path: <Shengzhou.Liu@freescale.com>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1bon0147.outbound.protection.outlook.com [157.56.111.147])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 0DADF1A0EAE
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 29 Jan 2015 20:28:05 +1100 (AEDT)
From: Shengzhou Liu <Shengzhou.Liu@freescale.com>
To: <linuxppc-dev@lists.ozlabs.org>, <scottwood@freescale.com>
Subject: [PATCH 3/4] powerpc/fsl-booke: Add T1024RDB board support
Date: Thu, 29 Jan 2015 15:52:26 +0800
Message-ID: <1422517947-28722-3-git-send-email-Shengzhou.Liu@freescale.com>
In-Reply-To: <1422517947-28722-1-git-send-email-Shengzhou.Liu@freescale.com>
References: <1422517947-28722-1-git-send-email-Shengzhou.Liu@freescale.com>
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

T1024RDB is a Freescale Reference Design Board that hosts the T1024 SoC.

T1024RDB board Overview
-----------------------
- Processor: T1024 SoC integrating two 64-bit e5500 cores up to 1.4GHz
- DDR: 64-bit 4GB DDR3L UDIMM with ECC and interleaving support
- Ethernet: two 10M/100M/1Gbps RGMII ports and one 10Gbps Base-T port on-board
- Accelerator: DPAA components consist of FMan, BMan, QMan, PME, DCE and SEC
- SerDes: 4 lanes up to 10.3125GHz
- IFC: 128MB NOR Flash, 1GB NAND Flash and CPLD system controlling
- PCIe: one PCIe slot and two Mini-PCIe connectors on-board
- USB: two Type-A USB2.0 ports with internal PHY
- eSDHC: one SDHC/MMC/eMMC connector
- eSPI: one 64MB N25Q512 SPI flash
- QE-TDM: support TDM Riser card
   - 32-bit RISC controller for flexible support of the communications peripherals
   - Serial DMA channel for receive and transmit on all serial channels
   - Two universal communication controllers, supporting TDM, HDLC, and UART
- I2C: four I2C controllers
- UART: two UART on board
- Deep sleep power management implementaion

Signed-off-by: Shengzhou Liu <Shengzhou.Liu@freescale.com>
---
 arch/powerpc/boot/dts/t1024rdb.dts            | 185 ++++++++++++++++++++++++++
 arch/powerpc/platforms/85xx/Kconfig           |   2 +-
 arch/powerpc/platforms/85xx/corenet_generic.c |   1 +
 3 files changed, 187 insertions(+), 1 deletion(-)
 create mode 100644 arch/powerpc/boot/dts/t1024rdb.dts

diff --git a/arch/powerpc/boot/dts/t1024rdb.dts b/arch/powerpc/boot/dts/t1024rdb.dts
new file mode 100644
index 0000000..a6b88e3
--- /dev/null
+++ b/arch/powerpc/boot/dts/t1024rdb.dts
@@ -0,0 +1,185 @@
+/*
+ * T1024 RDB Device Tree Source
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
+/include/ "fsl/t102xsi-pre.dtsi"
+
+/ {
+	model = "fsl,T1024RDB";
+	compatible = "fsl,T1024RDB";
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
+		nand@1,0 {
+			#address-cells = <1>;
+			#size-cells = <1>;
+			compatible = "fsl,ifc-nand";
+			reg = <0x2 0x0 0x10000>;
+		};
+
+		board-control@2,0 {
+			#address-cells = <1>;
+			#size-cells = <1>;
+			compatible = "fsl,t1024-cpld", "fsl,deepsleep-cpld";
+			reg = <3 0 0x300>;
+			ranges = <0 3 0 0x300>;
+			bank-width = <1>;
+			device-width = <1>;
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
+				compatible = "micron,n25q512ax3";
+				reg = <0>;
+				spi-max-frequency = <10000000>; /* input clock */
+			};
+
+			slic@1 {
+				compatible = "maxim,ds26522";
+				reg = <1>;
+				spi-max-frequency = <2000000>;
+			};
+
+			slic@2 {
+				compatible = "maxim,ds26522";
+				reg = <2>;
+				spi-max-frequency = <2000000>;
+			};
+		};
+
+		i2c@118000 {
+			adt7461@4c {
+				/* Thermal Monitor */
+				compatible = "adi,adt7461";
+				reg = <0x4c>;
+			};
+
+			eeprom@50 {
+				compatible = "at24,24c256";
+				reg = <0x50>;
+			};
+
+			rtc@68 {
+				compatible = "dallas,ds1339";
+				reg = <0x68>;
+				interrupts = <0x1 0x1 0 0>;
+			};
+		};
+
+		i2c@118100 {
+			pca9546@77 {
+				compatible = "nxp,pca9546";
+				reg = <0x77>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+			};
+		};
+	};
+
+	pci0: pcie@ffe240000 {
+		reg = <0xf 0xfe240000 0 0x10000>;
+		ranges = <0x02000000 0 0xe0000000 0xc 0x00000000 0x0 0x10000000
+			  0x01000000 0 0x00000000 0xf 0xf8000000 0x0 0x00010000>;
+		pcie@0 {
+			ranges = <0x02000000 0 0xe0000000
+				  0x02000000 0 0xe0000000
+				  0 0x10000000
+
+				  0x01000000 0 0x00000000
+				  0x01000000 0 0x00000000
+				  0 0x00010000>;
+		};
+	};
+
+	pci1: pcie@ffe250000 {
+		reg = <0xf 0xfe250000 0 0x10000>;
+		ranges = <0x02000000 0x0 0xe0000000 0xc 0x10000000 0x0 0x10000000
+			  0x01000000 0x0 0x00000000 0xf 0xf8010000 0x0 0x00010000>;
+		pcie@0 {
+			ranges = <0x02000000 0 0xe0000000
+				  0x02000000 0 0xe0000000
+				  0 0x10000000
+
+				  0x01000000 0 0x00000000
+				  0x01000000 0 0x00000000
+				  0 0x00010000>;
+		};
+	};
+
+	pci2: pcie@ffe260000 {
+		reg = <0xf 0xfe260000 0 0x10000>;
+		ranges = <0x02000000 0 0xe0000000 0xc 0x20000000 0 0x10000000
+			  0x01000000 0 0x00000000 0xf 0xf8020000 0 0x00010000>;
+		pcie@0 {
+			ranges = <0x02000000 0 0xe0000000
+				  0x02000000 0 0xe0000000
+				  0 0x10000000
+
+				  0x01000000 0 0x00000000
+				  0x01000000 0 0x00000000
+				  0 0x00010000>;
+		};
+	};
+};
+
+/include/ "fsl/t1024si-post.dtsi"
diff --git a/arch/powerpc/platforms/85xx/Kconfig b/arch/powerpc/platforms/85xx/Kconfig
index 0226dc2..6b6a626 100644
--- a/arch/powerpc/platforms/85xx/Kconfig
+++ b/arch/powerpc/platforms/85xx/Kconfig
@@ -276,7 +276,7 @@ config CORENET_GENERIC
 	  For 64bit kernel, the following boards are supported:
 	    T208x QDS/RDB, T4240 QDS/RDB and B4 QDS
 	  The following boards are supported for both 32bit and 64bit kernel:
-	    P5020 DS, P5040 DS, T102x QDS, T104x QDS/RDB
+	    P5020 DS, P5040 DS, T102x QDS/RDB, T104x QDS/RDB
 
 endif # FSL_SOC_BOOKE
 
diff --git a/arch/powerpc/platforms/85xx/corenet_generic.c b/arch/powerpc/platforms/85xx/corenet_generic.c
index 457e35b..31a15bf 100644
--- a/arch/powerpc/platforms/85xx/corenet_generic.c
+++ b/arch/powerpc/platforms/85xx/corenet_generic.c
@@ -139,6 +139,7 @@ static const char * const boards[] __initconst = {
 	"fsl,B4420QDS",
 	"fsl,B4220QDS",
 	"fsl,T1024QDS",
+	"fsl,T1024RDB",
 	"fsl,T1040QDS",
 	"fsl,T1042QDS",
 	"fsl,T1040RDB",
-- 
1.8.0

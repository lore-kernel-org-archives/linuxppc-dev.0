Return-Path: <Shengzhou.Liu@freescale.com>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1bbn0104.outbound.protection.outlook.com [157.56.111.104])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id B21D31A1A44
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 29 Jan 2015 20:29:44 +1100 (AEDT)
From: Shengzhou Liu <Shengzhou.Liu@freescale.com>
To: <linuxppc-dev@lists.ozlabs.org>, <scottwood@freescale.com>
Subject: [PATCH 4/4] powerpc/fsl-booke: Add T1023 RDB board support
Date: Thu, 29 Jan 2015 15:52:27 +0800
Message-ID: <1422517947-28722-4-git-send-email-Shengzhou.Liu@freescale.com>
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

T1023RDB is a Freescale Reference Design Board that hosts T1023 SoC.

T1023RDB board Overview
-----------------------
- T1023 SoC integrating two 64-bit e5500 cores up to 1.4GHz
- CoreNet fabric supporting coherent and noncoherent transactions with
  prioritization and bandwidth allocation
- SDRAM memory: 2GB Micron MT40A512M8HX unbuffered 32-bit DDR4 without ECC
- Accelerator: DPAA components consist of FMan, BMan, QMan, DCE and SEC
- Ethernet interfaces:
  - one 1G RGMII port on-board(RTL8211F PHY)
  - one 1G SGMII port on-board(RTL8211F PHY)
  - one 2.5G SGMII port on-board(AQR105 PHY)
- PCIe: Two Mini-PCIe connectors on-board.
- SerDes: 4 lanes up to 10.3125GHz
- NOR:  128MB S29GL01GS110TFIV10 Spansion NOR Flash
- NAND: 512MB S34MS04G200BFI000 Spansion NAND Flash
- eSPI: 64MB S25FL512SAGMFI010 Spansion SPI flash.
- USB: one Type-A USB 2.0 port with internal PHY
- eSDHC: support SD/MMC and eMMC card
- 256Kbit M24256 I2C EEPROM
- RTC: Real-time clock DS1339 on I2C bus
- UART: one serial port on-board with RJ45 connector
- Debugging: JTAG/COP for T1023 debugging

Signed-off-by: Shengzhou Liu <Shengzhou.Liu@freescale.com>
---
 arch/powerpc/boot/dts/t1023rdb.dts            | 150 ++++++++++++++++++++++++++
 arch/powerpc/platforms/85xx/corenet_generic.c |   1 +
 2 files changed, 151 insertions(+)
 create mode 100644 arch/powerpc/boot/dts/t1023rdb.dts

diff --git a/arch/powerpc/boot/dts/t1023rdb.dts b/arch/powerpc/boot/dts/t1023rdb.dts
new file mode 100644
index 0000000..b187cfe
--- /dev/null
+++ b/arch/powerpc/boot/dts/t1023rdb.dts
@@ -0,0 +1,150 @@
+/*
+ * T1023 RDB Device Tree Source
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
+	model = "fsl,T1023RDB";
+	compatible = "fsl,T1023RDB";
+	#address-cells = <2>;
+	#size-cells = <2>;
+	interrupt-parent = <&mpic>;
+
+	ifc: localbus@ffe124000 {
+		reg = <0xf 0xfe124000 0 0x2000>;
+		ranges = <0 0 0xf 0xe8000000 0x08000000
+			  1 0 0xf 0xff800000 0x00010000>;
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
+				compatible = "spansion,s25fl512s";
+				reg = <0>;
+				spi-max-frequency = <10000000>; /* input clock */
+			};
+		};
+
+		i2c@118000 {
+			eeprom@50 {
+				compatible = "stm,m24256";
+				reg = <0x50>;
+			};
+
+			rtc@68 {
+				compatible = "dallas,ds1339";
+				reg = <0x68>;
+				interrupts = <0x5 0x1 0 0>;
+			};
+		};
+
+		i2c@118100 {
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
+/include/ "fsl/t1023si-post.dtsi"
diff --git a/arch/powerpc/platforms/85xx/corenet_generic.c b/arch/powerpc/platforms/85xx/corenet_generic.c
index 31a15bf..26d850a 100644
--- a/arch/powerpc/platforms/85xx/corenet_generic.c
+++ b/arch/powerpc/platforms/85xx/corenet_generic.c
@@ -138,6 +138,7 @@ static const char * const boards[] __initconst = {
 	"fsl,B4860QDS",
 	"fsl,B4420QDS",
 	"fsl,B4220QDS",
+	"fsl,T1023RDB",
 	"fsl,T1024QDS",
 	"fsl,T1024RDB",
 	"fsl,T1040QDS",
-- 
1.8.0

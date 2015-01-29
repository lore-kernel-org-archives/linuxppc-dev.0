Return-Path: <Shengzhou.Liu@freescale.com>
Received: from na01-bl2-obe.outbound.protection.outlook.com
 (mail-bl2on0116.outbound.protection.outlook.com [65.55.169.116])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3DF4C1A152D
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 29 Jan 2015 20:28:11 +1100 (AEDT)
From: Shengzhou Liu <Shengzhou.Liu@freescale.com>
To: <linuxppc-dev@lists.ozlabs.org>, <scottwood@freescale.com>
Subject: [PATCH 2/4] powerpc/fsl-booke: Add T1024 QDS board support
Date: Thu, 29 Jan 2015 15:52:25 +0800
Message-ID: <1422517947-28722-2-git-send-email-Shengzhou.Liu@freescale.com>
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

Add support for Freescale T1024/T1023 QorIQ Development System Board.

T1024QDS is a high-performance computing evaluation, development and
test platform for T1024 QorIQ Power Architecture processor.

T1024QDS board Overview
-----------------------
- T1024 SoC integrating two 64-bit e5500 cores up to 1.4GHz
- CoreNet fabric supporting coherent and noncoherent transactions with
  prioritization and bandwidth allocation
- 32-/64-bit DDR3L/DDR4 SDRAM memory controller with ECC and interleaving support
- Accelerator: DPAA components consist of FMan, BMan, QMan, PME, DCE and SEC
- Ethernet interfaces:
  - Two 10M/100M/1G RGMII ports on-board
  - Three 1G/2.5Gbps SGMII ports
  - Four 1Gbps QSGMII ports
  - one 10Gbps XFI or 10G Base-KR interface
- SerDes: 4 lanes up to 10.3125GHz Supporting SGMII/QSGMII, XFI, PCIe, SATA and Aurora
- PCIe: Three PCI Express controllers with five PCIe slots.
- IFC: 128MB NOR Flash, 2GB NAND Flash, PromJet debug port and Qixis FPGA
- Video: DIU supports video up to 1280x1024x32 bpp.
  - Chrontel CH7201 for HDMI connection.
  - TI DS90C387R for direct LCD connection.
  - Raw (not encoded) video connector for testing or other encoders.
- QUICC Engine block
  - 32-bit RISC controller for flexible support of the communications peripherals
  - Serial DMA channel for receive and transmit on all serial channels
  - Two universal communication controllers, supporting TDM, HDLC, and UART
- Deep sleep power management implementaion (wakeup from GPIO/Timer/Ethernet/USB)
- eSPI: Three SPI flash devices.
- SATA: one SATA 2.O.
- USB: Two USB2.0 ports with internal PHY (one Type-A and one micro Type mini-AB)
- eSDHC: Support SD, SDHC, SDXC and MMC/eMMC.
- I2C: Four I2C controllers.
- UART: Two UART on board.

Signed-off-by: Shengzhou Liu <Shengzhou.Liu@freescale.com>
---
 arch/powerpc/boot/dts/t1024qds.dts            |  46 +++++
 arch/powerpc/boot/dts/t102xqds.dtsi           | 247 ++++++++++++++++++++++++++
 arch/powerpc/platforms/85xx/Kconfig           |   2 +-
 arch/powerpc/platforms/85xx/corenet_generic.c |   1 +
 4 files changed, 295 insertions(+), 1 deletion(-)
 create mode 100644 arch/powerpc/boot/dts/t1024qds.dts
 create mode 100644 arch/powerpc/boot/dts/t102xqds.dtsi

diff --git a/arch/powerpc/boot/dts/t1024qds.dts b/arch/powerpc/boot/dts/t1024qds.dts
new file mode 100644
index 0000000..30d0d51
--- /dev/null
+++ b/arch/powerpc/boot/dts/t1024qds.dts
@@ -0,0 +1,46 @@
+/*
+ * T1024 QDS Device Tree Source
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
+/include/ "t102xqds.dtsi"
+
+/ {
+	model = "fsl,T1024QDS";
+	compatible = "fsl,T1024QDS";
+	#address-cells = <2>;
+	#size-cells = <2>;
+	interrupt-parent = <&mpic>;
+};
+
+/include/ "fsl/t1024si-post.dtsi"
diff --git a/arch/powerpc/boot/dts/t102xqds.dtsi b/arch/powerpc/boot/dts/t102xqds.dtsi
new file mode 100644
index 0000000..a7eae95
--- /dev/null
+++ b/arch/powerpc/boot/dts/t102xqds.dtsi
@@ -0,0 +1,247 @@
+/*
+ * T102x QDS Device Tree Source
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
+	model = "fsl,T1024QDS";
+	compatible = "fsl,T1024QDS";
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
+		board-control@3,0 {
+			#address-cells = <1>;
+			#size-cells = <1>;
+			compatible = "fsl,tetra-fpga", "fsl,fpga-qixis";
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
+				compatible = "micron,n25q128a11";  /* 16MB */
+				reg = <0>;
+				spi-max-frequency = <10000000>; /* input clock */
+			};
+
+			flash@1 {
+				#address-cells = <1>;
+				#size-cells = <1>;
+				compatible = "sst,sst25wf040";  /* 512KB */
+				reg = <1>;
+				spi-max-frequency = <10000000>; /* input clock */
+			};
+
+			flash@2 {
+				#address-cells = <1>;
+				#size-cells = <1>;
+				compatible = "eon,en25s64";   /* 8MB */
+				reg = <2>;
+				spi-max-frequency = <10000000>; /* input clock */
+			};
+
+			slic@2 {
+				compatible = "maxim,ds26522";
+				reg = <2>;
+				spi-max-frequency = <2000000>;
+			};
+
+			slic@3 {
+				compatible = "maxim,ds26522";
+				reg = <3>;
+				spi-max-frequency = <2000000>;
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
+						compatible = "at24,24c512";
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
+				};
+
+				i2c@2 {
+					#address-cells = <1>;
+					#size-cells = <0>;
+					reg = <0x2>;
+
+					ina220@40 {
+						compatible = "ti,ina220";
+						reg = <0x40>;
+						shunt-resistor = <1000>;
+					};
+
+					ina220@41 {
+						compatible = "ti,ina220";
+						reg = <0x41>;
+						shunt-resistor = <1000>;
+					};
+				};
+
+				i2c@3 {
+					#address-cells = <1>;
+					#size-cells = <0>;
+					reg = <0x3>;
+
+					adt7461@4c {
+						/* Thermal Monitor */
+						compatible = "adi,adt7461";
+						reg = <0x4c>;
+					};
+
+					eeprom@55 {
+						compatible = "at24,24c02";
+						reg = <0x55>;
+					};
+
+					eeprom@56 {
+						compatible = "at24,24c512";
+						reg = <0x56>;
+					};
+
+					eeprom@57 {
+						compatible = "at24,24c512";
+						reg = <0x57>;
+					};
+				};
+			};
+			rtc@68 {
+				compatible = "dallas,ds3232";
+				reg = <0x68>;
+				interrupts = <0x5 0x1 0 0>;
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
diff --git a/arch/powerpc/platforms/85xx/Kconfig b/arch/powerpc/platforms/85xx/Kconfig
index f22635a..0226dc2 100644
--- a/arch/powerpc/platforms/85xx/Kconfig
+++ b/arch/powerpc/platforms/85xx/Kconfig
@@ -276,7 +276,7 @@ config CORENET_GENERIC
 	  For 64bit kernel, the following boards are supported:
 	    T208x QDS/RDB, T4240 QDS/RDB and B4 QDS
 	  The following boards are supported for both 32bit and 64bit kernel:
-	    P5020 DS, P5040 DS and T104xQDS/RDB
+	    P5020 DS, P5040 DS, T102x QDS, T104x QDS/RDB
 
 endif # FSL_SOC_BOOKE
 
diff --git a/arch/powerpc/platforms/85xx/corenet_generic.c b/arch/powerpc/platforms/85xx/corenet_generic.c
index e56b89a..457e35b 100644
--- a/arch/powerpc/platforms/85xx/corenet_generic.c
+++ b/arch/powerpc/platforms/85xx/corenet_generic.c
@@ -138,6 +138,7 @@ static const char * const boards[] __initconst = {
 	"fsl,B4860QDS",
 	"fsl,B4420QDS",
 	"fsl,B4220QDS",
+	"fsl,T1024QDS",
 	"fsl,T1040QDS",
 	"fsl,T1042QDS",
 	"fsl,T1040RDB",
-- 
1.8.0

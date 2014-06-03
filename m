Return-Path: <Chunhe.Lan@freescale.com>
Received: from na01-by2-obe.outbound.protection.outlook.com
 (mail-by2lp0243.outbound.protection.outlook.com [207.46.163.243])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 9EB1D1A0039
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  3 Jun 2014 20:22:35 +1000 (EST)
From: Chunhe Lan <Chunhe.Lan@freescale.com>
To: <linuxppc-dev@lists.ozlabs.org>
Subject: [PATCH v3] powerpc/85xx: Add T4240RDB board support
Date: Tue, 3 Jun 2014 18:25:14 +0800
Message-ID: <1401791114-3263-1-git-send-email-Chunhe.Lan@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: Scott Wood <scottwood@freescale.com>, Chunhe Lan <Chunhe.Lan@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

T4240RDB board Specification
----------------------------
Memory subsystem:
     6GB DDR3
     128MB NOR flash
     2GB NAND flash
Ethernet:
     Eight 1G SGMII ports
     Four 10Gbps SFP+ ports
PCIe:
     Two PCIe slots
USB:
     Two USB2.0 Type A ports
SDHC:
     One SD-card port
SATA:
     One SATA port
UART:
     Dual RJ45 ports

Signed-off-by: Chunhe Lan <Chunhe.Lan@freescale.com>
Cc: Scott Wood <scottwood@freescale.com>
---
 arch/powerpc/boot/dts/t4240rdb.dts            |  186 +++++++++++++++++++++++++
 arch/powerpc/configs/corenet64_smp_defconfig  |    4 +
 arch/powerpc/platforms/85xx/Kconfig           |    2 +-
 arch/powerpc/platforms/85xx/corenet_generic.c |    2 +
 4 files changed, 193 insertions(+), 1 deletions(-)
 create mode 100644 arch/powerpc/boot/dts/t4240rdb.dts

diff --git a/arch/powerpc/boot/dts/t4240rdb.dts b/arch/powerpc/boot/dts/t4240rdb.dts
new file mode 100644
index 0000000..53761d4
--- /dev/null
+++ b/arch/powerpc/boot/dts/t4240rdb.dts
@@ -0,0 +1,186 @@
+/*
+ * T4240RDB Device Tree Source
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
+/include/ "fsl/t4240si-pre.dtsi"
+
+/ {
+	model = "fsl,T4240RDB";
+	compatible = "fsl,T4240RDB";
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
+		nand@2,0 {
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
+				compatible = "sst,sst25wf040";
+				reg = <0>;
+				spi-max-frequency = <40000000>; /* input clock */
+			};
+		};
+
+		i2c@118000 {
+			eeprom@52 {
+				compatible = "at24,24c256";
+				reg = <0x52>;
+			};
+			eeprom@54 {
+				compatible = "at24,24c256";
+				reg = <0x54>;
+			};
+			eeprom@56 {
+				compatible = "at24,24c256";
+				reg = <0x56>;
+			};
+			rtc@68 {
+				compatible = "dallas,ds1374";
+				reg = <0x68>;
+				interrupts = <0x1 0x1 0 0>;
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
+		ranges = <0x02000000 0x0 0xe0000000 0xc 0x20000000 0x0 0x20000000
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
+		ranges = <0x02000000 0 0xe0000000 0xc 0x40000000 0 0x20000000
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
+		ranges = <0x02000000 0 0xe0000000 0xc 0x60000000 0 0x20000000
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
+/include/ "fsl/t4240si-post.dtsi"
diff --git a/arch/powerpc/configs/corenet64_smp_defconfig b/arch/powerpc/configs/corenet64_smp_defconfig
index 5c7fa19..4f17b3d 100644
--- a/arch/powerpc/configs/corenet64_smp_defconfig
+++ b/arch/powerpc/configs/corenet64_smp_defconfig
@@ -96,6 +96,8 @@ CONFIG_SATA_SIL24=y
 CONFIG_NETDEVICES=y
 CONFIG_DUMMY=y
 CONFIG_E1000E=y
+CONFIG_PHYLIB=y
+CONFIG_VITESSE_PHY=y
 CONFIG_INPUT_FF_MEMLESS=m
 # CONFIG_INPUT_MOUSEDEV is not set
 # CONFIG_INPUT_KEYBOARD is not set
@@ -125,6 +127,8 @@ CONFIG_MMC=y
 CONFIG_MMC_SDHCI=y
 CONFIG_EDAC=y
 CONFIG_EDAC_MM_EDAC=y
+CONFIG_RTC_CLASS=y
+CONFIG_RTC_DRV_DS1374=y
 CONFIG_DMADEVICES=y
 CONFIG_FSL_DMA=y
 CONFIG_EXT2_FS=y
diff --git a/arch/powerpc/platforms/85xx/Kconfig b/arch/powerpc/platforms/85xx/Kconfig
index c17aae8..d66321e 100644
--- a/arch/powerpc/platforms/85xx/Kconfig
+++ b/arch/powerpc/platforms/85xx/Kconfig
@@ -265,7 +265,7 @@ config CORENET_GENERIC
 	  For 32bit kernel, the following boards are supported:
 	    P2041 RDB, P3041 DS and P4080 DS
 	  For 64bit kernel, the following boards are supported:
-	    T4240 QDS and B4 QDS
+	    T4240 QDS/RDB and B4 QDS
 	  The following boards are supported for both 32bit and 64bit kernel:
 	    P5020 DS and P5040 DS
 
diff --git a/arch/powerpc/platforms/85xx/corenet_generic.c b/arch/powerpc/platforms/85xx/corenet_generic.c
index 8e4b1e1..3d91a26 100644
--- a/arch/powerpc/platforms/85xx/corenet_generic.c
+++ b/arch/powerpc/platforms/85xx/corenet_generic.c
@@ -119,6 +119,7 @@ static const char * const boards[] __initconst = {
 	"fsl,P5020DS",
 	"fsl,P5040DS",
 	"fsl,T4240QDS",
+	"fsl,T4240RDB",
 	"fsl,B4860QDS",
 	"fsl,B4420QDS",
 	"fsl,B4220QDS",
@@ -132,6 +133,7 @@ static const char * const hv_boards[] __initconst = {
 	"fsl,P5020DS-hv",
 	"fsl,P5040DS-hv",
 	"fsl,T4240QDS-hv",
+	"fsl,T4240RDB-hv",
 	"fsl,B4860QDS-hv",
 	"fsl,B4420QDS-hv",
 	"fsl,B4220QDS-hv",
-- 
1.7.6.5

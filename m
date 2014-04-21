Return-Path: <prabhakar@freescale.com>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (dns-bn1lp0143.outbound.protection.outlook.com [207.46.163.143])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 5CE261400E0
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 21 Apr 2014 21:51:08 +1000 (EST)
From: Prabhakar Kushwaha <prabhakar@freescale.com>
To: <linuxppc-dev@lists.ozlabs.org>
Subject: [PATCH][v10] powerpc/fsl-booke: Add initial T104x_QDS board support
Date: Mon, 21 Apr 2014 17:04:45 +0530
Message-ID: <1398080085-3841-1-git-send-email-prabhakar@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Cc: scottwood@freescale.com, Priyanka Jain <Priyanka.Jain@freescale.com>,
 Poonam Aggrwal <poonam.aggrwal@freescale.com>,
 Prabhakar Kushwaha <prabhakar@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

 Add support for T104x board in board file t104x_qds.c, It is common for
 both T1040 and T1042 as they share same QDS board.

 T1040QDS board Overview
 -----------------------
 - SERDES Connections, 8 lanes supporting:
      — PCI Express: supporting Gen 1 and Gen 2;
      — SGMII
      — QSGMII
      — SATA 2.0
      — Aurora debug with dedicated connectors (T1040 only)
 - DDR Controller
     - Supports rates of up to 1600 MHz data-rate
     - Supports one DDR3LP UDIMM/RDIMMs, of single-, dual- or quad-rank types.
 -IFC/Local Bus
     - NAND flash: 8-bit, async, up to 2GB.
     - NOR: 8-bit or 16-bit, non-multiplexed, up to 512MB
     - GASIC: Simple (minimal) target within Qixis FPGA
     - PromJET rapid memory download support
 - Ethernet
     - Two on-board RGMII 10/100/1G ethernet ports.
     - PHY #0 remains powered up during deep-sleep (T1040 only)
 - QIXIS System Logic FPGA
 - Clocks
     - System and DDR clock (SYSCLK, “DDRCLK”)
     - SERDES clocks
 - Power Supplies
 - Video
     - DIU supports video at up to 1280x1024x32bpp
 - USB
     - Supports two USB 2.0 ports with integrated PHYs
     — Two type A ports with 5V@1.5A per port.
     — Second port can be converted to OTG mini-AB
 - SDHC
     - SDHC port connects directly to an adapter card slot, featuring:
     - Supporting SD slots for: SD, SDHC (1x, 4x, 8x) and/or MMC
     — Supporting eMMC memory devices
 - SPI
    -  On-board support of 3 different devices and sizes
 - Other IO
    - Two Serial ports
    - ProfiBus port
    - Four I2C ports

Add T104xQDS support in Kconfig and Makefile. Also create device tree.
Following features are currently not implmented.
  - SerDes: Aurora
  - IFC: GASIC, Promjet
  - QIXIS
  - Ethernet
  - DIU
  - power supplies management
  - ProfiBus

Signed-off-by: Priyanka Jain <Priyanka.Jain@freescale.com>
Signed-off-by: Poonam Aggrwal <poonam.aggrwal@freescale.com>
Signed-off-by: Prabhakar Kushwaha <prabhakar@freescale.com>
---

 Changes for v2: Incorporated Scott's comments
	- Created t104xqds.dtsi, both t1040qds & t1042qds include it
	- Updated get_irq 
 Changes for v3: Sending as it is
 Changes for v4: Updated description
 Changes for v5: Incorporated Scott's comments
 	- Ported on top of Kevin's patch
 Changes for v6: Updated depedencies
 Changes for v7: Incororated Scott's commetns
    - Create patch set
 Changes for v8: Sending as it is
 Changes for v9:
    - removed partitions
    - updated FPGA node
    - Fix PCIe range fields
 Changes for v10:
    - Updated SPI flash compatible

 arch/powerpc/boot/dts/t1040qds.dts            |   46 +++++++
 arch/powerpc/boot/dts/t1042qds.dts            |   46 +++++++
 arch/powerpc/boot/dts/t104xqds.dtsi           |  166 +++++++++++++++++++++++++
 arch/powerpc/platforms/85xx/Kconfig           |    2 +-
 arch/powerpc/platforms/85xx/corenet_generic.c |    4 +
 5 files changed, 263 insertions(+), 1 deletion(-)
 create mode 100644 arch/powerpc/boot/dts/t1040qds.dts
 create mode 100644 arch/powerpc/boot/dts/t1042qds.dts
 create mode 100644 arch/powerpc/boot/dts/t104xqds.dtsi

diff --git a/arch/powerpc/boot/dts/t1040qds.dts b/arch/powerpc/boot/dts/t1040qds.dts
new file mode 100644
index 0000000..973c29c
--- /dev/null
+++ b/arch/powerpc/boot/dts/t1040qds.dts
@@ -0,0 +1,46 @@
+/*
+ * T1040QDS Device Tree Source
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
+/include/ "fsl/t104xsi-pre.dtsi"
+/include/ "t104xqds.dtsi"
+
+/ {
+	model = "fsl,T1040QDS";
+	compatible = "fsl,T1040QDS";
+	#address-cells = <2>;
+	#size-cells = <2>;
+	interrupt-parent = <&mpic>;
+};
+
+/include/ "fsl/t1040si-post.dtsi"
diff --git a/arch/powerpc/boot/dts/t1042qds.dts b/arch/powerpc/boot/dts/t1042qds.dts
new file mode 100644
index 0000000..45bd037
--- /dev/null
+++ b/arch/powerpc/boot/dts/t1042qds.dts
@@ -0,0 +1,46 @@
+/*
+ * T1042QDS Device Tree Source
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
+/include/ "fsl/t104xsi-pre.dtsi"
+/include/ "t104xqds.dtsi"
+
+/ {
+	model = "fsl,T1042QDS";
+	compatible = "fsl,T1042QDS";
+	#address-cells = <2>;
+	#size-cells = <2>;
+	interrupt-parent = <&mpic>;
+};
+
+/include/ "fsl/t1042si-post.dtsi"
diff --git a/arch/powerpc/boot/dts/t104xqds.dtsi b/arch/powerpc/boot/dts/t104xqds.dtsi
new file mode 100644
index 0000000..da0a886
--- /dev/null
+++ b/arch/powerpc/boot/dts/t104xqds.dtsi
@@ -0,0 +1,166 @@
+/*
+ * T104xQDS Device Tree Source
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
+	model = "fsl,T1040QDS";
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
+
+		board-control@3,0 {
+			#address-cells = <1>;
+			#size-cells = <1>;
+			compatible = "fsl,fpga-qixis";
+			reg = <3 0 0x300>;
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
+
+		spi@110000 {
+			flash@0 {
+				#address-cells = <1>;
+				#size-cells = <1>;
+				compatible = "micron,n25q128a11";
+				reg = <0>;
+				spi-max-frequency = <10000000>; /* input clock */
+			};
+		};
+
+		i2c@118000 {
+			pca9547@77 {
+				compatible = "philips,pca9547";
+				reg = <0x77>;
+			};
+			rtc@68 {
+				compatible = "dallas,ds3232";
+				reg = <0x68>;
+				interrupts = <0x1 0x1 0 0>;
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
+
+	pci3: pcie@ffe270000 {
+		reg = <0xf 0xfe270000 0 0x10000>;
+		ranges = <0x02000000 0 0xe0000000 0xc 0x30000000 0 0x10000000
+			  0x01000000 0 0x00000000 0xf 0xf8030000 0 0x00010000>;
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
index c17aae8..b9fc713 100644
--- a/arch/powerpc/platforms/85xx/Kconfig
+++ b/arch/powerpc/platforms/85xx/Kconfig
@@ -267,7 +267,7 @@ config CORENET_GENERIC
 	  For 64bit kernel, the following boards are supported:
 	    T4240 QDS and B4 QDS
 	  The following boards are supported for both 32bit and 64bit kernel:
-	    P5020 DS and P5040 DS
+	    P5020 DS, P5040 DS and T104xQDS
 
 endif # FSL_SOC_BOOKE
 
diff --git a/arch/powerpc/platforms/85xx/corenet_generic.c b/arch/powerpc/platforms/85xx/corenet_generic.c
index 8e4b1e1..32bad8d 100644
--- a/arch/powerpc/platforms/85xx/corenet_generic.c
+++ b/arch/powerpc/platforms/85xx/corenet_generic.c
@@ -122,6 +122,8 @@ static const char * const boards[] __initconst = {
 	"fsl,B4860QDS",
 	"fsl,B4420QDS",
 	"fsl,B4220QDS",
+	"fsl,T1040QDS",
+	"fsl,T1042QDS",
 	NULL
 };
 
@@ -135,6 +137,8 @@ static const char * const hv_boards[] __initconst = {
 	"fsl,B4860QDS-hv",
 	"fsl,B4420QDS-hv",
 	"fsl,B4220QDS-hv",
+	"fsl,T1040QDS-hv",
+	"fsl,T1042QDS-hv",
 	NULL
 };
 
-- 
1.7.9.5

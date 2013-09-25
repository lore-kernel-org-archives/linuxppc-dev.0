Return-Path: <B32579@freescale.com>
Received: from co1outboundpool.messaging.microsoft.com
 (co1ehsobe004.messaging.microsoft.com [216.32.180.187])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 468B02C03C2
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 Sep 2013 20:11:47 +1000 (EST)
From: Prabhakar Kushwaha <prabhakar@freescale.com>
To: <linuxppc-dev@lists.ozlabs.org>
Subject: =?UTF-8?q?=5BPATCH=5D=5Bv5=5D=20powerpc/fsl-booke=3A=20Add=20initial=20T104x=5FQDS=20board=20support?=
Date: Wed, 25 Sep 2013 15:41:16 +0530
Message-ID: <1380103876-15971-1-git-send-email-prabhakar@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Cc: scottwood@freescale.com, Poonam Aggrwal <poonam.aggrwal@freescale.com>,
 Prabhakar Kushwaha <prabhakar@freescale.com>,
 Priyanka Jain <Priyanka.Jain@freescale.com>
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
      =E2=80=94 PCI Express: supporting Gen 1 and Gen 2;
      =E2=80=94 SGMII
      =E2=80=94 QSGMII
      =E2=80=94 SATA 2.0
      =E2=80=94 Aurora debug with dedicated connectors (T1040 only)
 - DDR Controller
     - Supports rates of up to 1600 MHz data-rate
     - Supports one DDR3LP UDIMM/RDIMMs, of single-, dual- or quad-rank t=
ypes.
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
     - System and DDR clock (SYSCLK, =E2=80=9CDDRCLK=E2=80=9D)
     - SERDES clocks
 - Power Supplies
 - Video
     - DIU supports video at up to 1280x1024x32bpp
 - USB
     - Supports two USB 2.0 ports with integrated PHYs
     =E2=80=94 Two type A ports with 5V@1.5A per port.
     =E2=80=94 Second port can be converted to OTG mini-AB
 - SDHC
     - SDHC port connects directly to an adapter card slot, featuring:
     - Supporting SD slots for: SD, SDHC (1x, 4x, 8x) and/or MMC
     =E2=80=94 Supporting eMMC memory devices
 - SPI
    -  On-board support of 3 different devices and sizes
 - Other IO
    - Two Serial ports
    - ProfiBus port
    - Four I2C ports

Add T104xQDS support in Kconfig and Makefile. Also create device tree.
Following features are currently not implmented.=20
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
 Based upon git://git.kernel.org/pub/scm/linux/kernel/git/benh/powerpc.gi=
t
 Branch merge

 Changes for v2: Incorporated Scott's comments
	- Created t104xqds.dtsi, both t1040qds & t1042qds include it
	- Updated get_irq=20
 Changes for v3: Sending as it is
 Changes for v4: Updated description
 Changes for v5: Incorporated Scott's comments
 	- Ported on top of Kevin's patch
=20
 This patch depends upon followng patches in mentioned order
 1) powerpc/b4qds: enable coreint
   http://patchwork.ozlabs.org/patch/274390/

 2) powerpc/85xx: introduce corenet_generic machine
   http://patchwork.ozlabs.org/patch/277341/

 3) powerpc/85xx: rename the corenet_ds.c to corenet_generic.c
   http://patchwork.ozlabs.org/patch/277342/

 4) powerpc/85xx: use one kernel option for all the CoreNet_Generic board=
s
   http://patchwork.ozlabs.org/patch/277343/


 arch/powerpc/boot/dts/t1040qds.dts            |   46 ++++++
 arch/powerpc/boot/dts/t1042qds.dts            |   46 ++++++
 arch/powerpc/boot/dts/t104xqds.dtsi           |  192 +++++++++++++++++++=
++++++
 arch/powerpc/platforms/85xx/corenet_generic.c |    4 +
 4 files changed, 288 insertions(+)
 create mode 100644 arch/powerpc/boot/dts/t1040qds.dts
 create mode 100644 arch/powerpc/boot/dts/t1042qds.dts
 create mode 100644 arch/powerpc/boot/dts/t104xqds.dtsi

diff --git a/arch/powerpc/boot/dts/t1040qds.dts b/arch/powerpc/boot/dts/t=
1040qds.dts
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
+ * modification, are permitted provided that the following conditions ar=
e met:
+ *     * Redistributions of source code must retain the above copyright
+ *	 notice, this list of conditions and the following disclaimer.
+ *     * Redistributions in binary form must reproduce the above copyrig=
ht
+ *	 notice, this list of conditions and the following disclaimer in the
+ *	 documentation and/or other materials provided with the distribution.
+ *     * Neither the name of Freescale Semiconductor nor the
+ *	 names of its contributors may be used to endorse or promote products
+ *	 derived from this software without specific prior written permission=
.
+ *
+ *
+ * ALTERNATIVELY, this software may be distributed under the terms of th=
e
+ * GNU General Public License ("GPL") as published by the Free Software
+ * Foundation, either version 2 of that License or (at your option) any
+ * later version.
+ *
+ * THIS SOFTWARE IS PROVIDED BY Freescale Semiconductor "AS IS" AND ANY
+ * EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMP=
LIED
+ * WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE AR=
E
+ * DISCLAIMED. IN NO EVENT SHALL Freescale Semiconductor BE LIABLE FOR A=
NY
+ * DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DA=
MAGES
+ * (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SE=
RVICES;
+ * LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUS=
ED AND
+ * ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR=
 TORT
+ * (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE=
 OF THIS
+ * SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
+ */
+
+/include/ "fsl/t104xsi-pre.dtsi"
+/include/ "t104xqds.dtsi"
+
+/ {
+	model =3D "fsl,T1040QDS";
+	compatible =3D "fsl,T1040QDS";
+	#address-cells =3D <2>;
+	#size-cells =3D <2>;
+	interrupt-parent =3D <&mpic>;
+};
+
+/include/ "fsl/t1040si-post.dtsi"
diff --git a/arch/powerpc/boot/dts/t1042qds.dts b/arch/powerpc/boot/dts/t=
1042qds.dts
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
+ * modification, are permitted provided that the following conditions ar=
e met:
+ *     * Redistributions of source code must retain the above copyright
+ *	 notice, this list of conditions and the following disclaimer.
+ *     * Redistributions in binary form must reproduce the above copyrig=
ht
+ *	 notice, this list of conditions and the following disclaimer in the
+ *	 documentation and/or other materials provided with the distribution.
+ *     * Neither the name of Freescale Semiconductor nor the
+ *	 names of its contributors may be used to endorse or promote products
+ *	 derived from this software without specific prior written permission=
.
+ *
+ *
+ * ALTERNATIVELY, this software may be distributed under the terms of th=
e
+ * GNU General Public License ("GPL") as published by the Free Software
+ * Foundation, either version 2 of that License or (at your option) any
+ * later version.
+ *
+ * THIS SOFTWARE IS PROVIDED BY Freescale Semiconductor "AS IS" AND ANY
+ * EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMP=
LIED
+ * WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE AR=
E
+ * DISCLAIMED. IN NO EVENT SHALL Freescale Semiconductor BE LIABLE FOR A=
NY
+ * DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DA=
MAGES
+ * (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SE=
RVICES;
+ * LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUS=
ED AND
+ * ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR=
 TORT
+ * (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE=
 OF THIS
+ * SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
+ */
+
+/include/ "fsl/t104xsi-pre.dtsi"
+/include/ "t104xqds.dtsi"
+
+/ {
+	model =3D "fsl,T1042QDS";
+	compatible =3D "fsl,T1042QDS";
+	#address-cells =3D <2>;
+	#size-cells =3D <2>;
+	interrupt-parent =3D <&mpic>;
+};
+
+/include/ "fsl/t1042si-post.dtsi"
diff --git a/arch/powerpc/boot/dts/t104xqds.dtsi b/arch/powerpc/boot/dts/=
t104xqds.dtsi
new file mode 100644
index 0000000..5a518b3
--- /dev/null
+++ b/arch/powerpc/boot/dts/t104xqds.dtsi
@@ -0,0 +1,192 @@
+/*
+ * T104xQDS Device Tree Source
+ *
+ * Copyright 2013 Freescale Semiconductor Inc.
+ *
+ * Redistribution and use in source and binary forms, with or without
+ * modification, are permitted provided that the following conditions ar=
e met:
+ *     * Redistributions of source code must retain the above copyright
+ *	 notice, this list of conditions and the following disclaimer.
+ *     * Redistributions in binary form must reproduce the above copyrig=
ht
+ *	 notice, this list of conditions and the following disclaimer in the
+ *	 documentation and/or other materials provided with the distribution.
+ *     * Neither the name of Freescale Semiconductor nor the
+ *	 names of its contributors may be used to endorse or promote products
+ *	 derived from this software without specific prior written permission=
.
+ *
+ *
+ * ALTERNATIVELY, this software may be distributed under the terms of th=
e
+ * GNU General Public License ("GPL") as published by the Free Software
+ * Foundation, either version 2 of that License or (at your option) any
+ * later version.
+ *
+ * THIS SOFTWARE IS PROVIDED BY Freescale Semiconductor "AS IS" AND ANY
+ * EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMP=
LIED
+ * WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE AR=
E
+ * DISCLAIMED. IN NO EVENT SHALL Freescale Semiconductor BE LIABLE FOR A=
NY
+ * DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DA=
MAGES
+ * (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SE=
RVICES;
+ * LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUS=
ED AND
+ * ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR=
 TORT
+ * (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE=
 OF THIS
+ * SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
+ */
+
+/ {
+	model =3D "fsl,T1040QDS";
+	compatible =3D "fsl,T1040QDS";
+	#address-cells =3D <2>;
+	#size-cells =3D <2>;
+	interrupt-parent =3D <&mpic>;
+
+	ifc: localbus@ffe124000 {
+		reg =3D <0xf 0xfe124000 0 0x2000>;
+		ranges =3D <0 0 0xf 0xe8000000 0x08000000
+			  2 0 0xf 0xff800000 0x00010000
+			  3 0 0xf 0xffdf0000 0x00008000>;
+
+		nor@0,0 {
+			#address-cells =3D <1>;
+			#size-cells =3D <1>;
+			compatible =3D "cfi-flash";
+			reg =3D <0x0 0x0 0x8000000>;
+
+			bank-width =3D <2>;
+			device-width =3D <1>;
+		};
+
+		nand@2,0 {
+			#address-cells =3D <1>;
+			#size-cells =3D <1>;
+			compatible =3D "fsl,ifc-nand";
+			reg =3D <0x2 0x0 0x10000>;
+
+			partition@0 {
+				/* This location must not be altered  */
+				/* 1MB for u-boot Bootloader Image */
+				reg =3D <0x0 0x00100000>;
+				label =3D "NAND U-Boot Image";
+				read-only;
+			};
+
+			partition@100000 {
+				/* 1MB for DTB Image */
+				reg =3D <0x00100000 0x00100000>;
+				label =3D "NAND DTB Image";
+			};
+
+			partition@200000 {
+				/* 10MB for Linux Kernel Image */
+				reg =3D <0x00200000 0x00A00000>;
+				label =3D "NAND Linux Kernel Image";
+			};
+
+			partition@C00000 {
+				/* 500MB for Root file System Image */
+				reg =3D <0x00c00000 0x1F400000>;
+				label =3D "NAND RFS Image";
+			};
+		};
+
+		board-control@3,0 {
+			#address-cells =3D <1>;
+			#size-cells =3D <1>;
+			compatible =3D "fsl,tetra-fpga", "fsl,fpga-qixis";
+			reg =3D <3 0 0x300>;
+		};
+	};
+
+	memory {
+		device_type =3D "memory";
+	};
+
+	dcsr: dcsr@f00000000 {
+		ranges =3D <0x00000000 0xf 0x00000000 0x01072000>;
+	};
+
+	soc: soc@ffe000000 {
+		ranges =3D <0x00000000 0xf 0xfe000000 0x1000000>;
+		reg =3D <0xf 0xfe000000 0 0x00001000>;
+		spi@110000 {
+			flash@0 {
+				#address-cells =3D <1>;
+				#size-cells =3D <1>;
+				compatible =3D "micron,n25q512a";
+				reg =3D <0>;
+				spi-max-frequency =3D <10000000>; /* input clock */
+			};
+		};
+
+		i2c@118000 {
+			pca9547@77 {
+				compatible =3D "philips,pca9547";
+				reg =3D <0x77>;
+			};
+			rtc@68 {
+				compatible =3D "dallas,ds3232";
+				reg =3D <0x68>;
+				interrupts =3D <0x1 0x1 0 0>;
+			};
+		};
+	};
+
+	pci0: pcie@ffe240000 {
+		reg =3D <0xf 0xfe240000 0 0x10000>;
+		ranges =3D <0x02000000 0 0xe0000000 0xc 0x00000000 0x0 0x10000000
+			  0x01000000 0 0x00000000 0xf 0xf8000000 0x0 0x00010000>;
+		pcie@0 {
+			ranges =3D <0x02000000 0 0xe0000000
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
+		reg =3D <0xf 0xfe250000 0 0x10000>;
+		ranges =3D <0x02000000 0x0 0xe0000000 0xc 0x20000000 0x0 0x10000000
+			  0x01000000 0x0 0x00000000 0xf 0xf8010000 0x0 0x00010000>;
+		pcie@0 {
+			ranges =3D <0x02000000 0 0xe0000000
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
+		reg =3D <0xf 0xfe260000 0 0x1000>;
+		ranges =3D <0x02000000 0 0xe0000000 0xc 0x40000000 0 0x10000000
+			  0x01000000 0 0x00000000 0xf 0xf8020000 0 0x00010000>;
+		pcie@0 {
+			ranges =3D <0x02000000 0 0xe0000000
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
+		reg =3D <0xf 0xfe270000 0 0x10000>;
+		ranges =3D <0x02000000 0 0xe0000000 0xc 0x60000000 0 0x10000000
+			  0x01000000 0 0x00000000 0xf 0xf8030000 0 0x00010000>;
+		pcie@0 {
+			ranges =3D <0x02000000 0 0xe0000000
+				  0x02000000 0 0xe0000000
+				  0 0x10000000
+
+				  0x01000000 0 0x00000000
+				  0x01000000 0 0x00000000
+				  0 0x00010000>;
+		};
+	};
+};
diff --git a/arch/powerpc/platforms/85xx/corenet_generic.c b/arch/powerpc=
/platforms/85xx/corenet_generic.c
index fbd871e..f4a7621 100644
--- a/arch/powerpc/platforms/85xx/corenet_generic.c
+++ b/arch/powerpc/platforms/85xx/corenet_generic.c
@@ -106,6 +106,8 @@ static const char * const boards[] __initconst =3D {
 	"fsl,B4860QDS",
 	"fsl,B4420QDS",
 	"fsl,B4220QDS",
+	"fsl,T1040QDS",
+	"fsl,T1042QDS",
 	NULL
 };
=20
@@ -119,6 +121,8 @@ static const char * const hv_boards[] __initconst =3D=
 {
 	"fsl,B4860QDS-hv",
 	"fsl,B4420QDS-hv",
 	"fsl,B4220QDS-hv",
+	"fsl,T1040QDS-hv",
+	"fsl,T1042QDS-hv",
 	NULL
 };
=20
--=20
1.7.9.5

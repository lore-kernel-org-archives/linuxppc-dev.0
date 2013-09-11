Return-Path: <B32579@freescale.com>
Received: from va3outboundpool.messaging.microsoft.com
 (va3ehsobe002.messaging.microsoft.com [216.32.180.12])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 3AE5E2C0439
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 11 Sep 2013 16:58:44 +1000 (EST)
From: Prabhakar Kushwaha <prabhakar@freescale.com>
To: <linuxppc-dev@lists.ozlabs.org>
Subject: [PATCH 1/2] powerpc/fsl-booke: Add initial T104x_QDS board support
Date: Wed, 11 Sep 2013 12:28:26 +0530
Message-ID: <1378882706-19488-1-git-send-email-prabhakar@freescale.com>
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

Signed-off-by: Priyanka Jain <Priyanka.Jain@freescale.com>
Signed-off-by: Poonam Aggrwal <poonam.aggrwal@freescale.com>
Signed-off-by: Prabhakar Kushwaha <prabhakar@freescale.com>
---
Based upon git://git.kernel.org/pub/scm/linux/kernel/git/scottwood/linux.=
git

TODO: Add noded for ethernet and board stuff

 arch/powerpc/boot/dts/t1040qds.dts      |  201 +++++++++++++++++++++++++=
++++++
 arch/powerpc/boot/dts/t1042qds.dts      |  201 +++++++++++++++++++++++++=
++++++
 arch/powerpc/platforms/85xx/Kconfig     |   20 +++
 arch/powerpc/platforms/85xx/Makefile    |    1 +
 arch/powerpc/platforms/85xx/t104x_qds.c |  102 ++++++++++++++++
 5 files changed, 525 insertions(+)
 create mode 100644 arch/powerpc/boot/dts/t1040qds.dts
 create mode 100644 arch/powerpc/boot/dts/t1042qds.dts
 create mode 100644 arch/powerpc/platforms/85xx/t104x_qds.c

diff --git a/arch/powerpc/boot/dts/t1040qds.dts b/arch/powerpc/boot/dts/t=
1040qds.dts
new file mode 100644
index 0000000..cea5632
--- /dev/null
+++ b/arch/powerpc/boot/dts/t1040qds.dts
@@ -0,0 +1,201 @@
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
+
+/ {
+	model =3D "fsl,T1040QDS";
+	compatible =3D "fsl,T1040QDS";
+	#address-cells =3D <2>;
+	#size-cells =3D <2>;
+	interrupt-parent =3D <&mpic>;
+
+	aliases {
+		 /* TODO */
+		};
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
+                        pca9547@77 {
+                                compatible =3D "philips,pca9547";
+                                reg =3D <0x77>;
+                        };
+                       rtc@68 {
+                                compatible =3D "dallas,ds3232";
+                                reg =3D <0x68>;
+                                interrupts =3D <0x1 0x1 0 0>;
+                        };
+		};
+
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
+
+/include/ "fsl/t1040si-post.dtsi"
diff --git a/arch/powerpc/boot/dts/t1042qds.dts b/arch/powerpc/boot/dts/t=
1042qds.dts
new file mode 100644
index 0000000..42662e1
--- /dev/null
+++ b/arch/powerpc/boot/dts/t1042qds.dts
@@ -0,0 +1,201 @@
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
+
+/ {
+	model =3D "fsl,T1042QDS";
+	compatible =3D "fsl,T1042QDS";
+	#address-cells =3D <2>;
+	#size-cells =3D <2>;
+	interrupt-parent =3D <&mpic>;
+
+	aliases {
+		 /* TODO */
+		};
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
+                        pca9547@77 {
+                                compatible =3D "philips,pca9547";
+                                reg =3D <0x77>;
+                        };
+                       rtc@68 {
+                                compatible =3D "dallas,ds3232";
+                                reg =3D <0x68>;
+                                interrupts =3D <0x1 0x1 0 0>;
+                        };
+		};
+
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
+
+/include/ "fsl/t1042si-post.dtsi"
diff --git a/arch/powerpc/platforms/85xx/Kconfig b/arch/powerpc/platforms=
/85xx/Kconfig
index efdd37c..503c211 100644
--- a/arch/powerpc/platforms/85xx/Kconfig
+++ b/arch/powerpc/platforms/85xx/Kconfig
@@ -289,6 +289,26 @@ config P5040_DS
 	help
 	  This option enables support for the P5040 DS board
=20
+config T104x_QDS
+	bool "Freescale T104x QDS"
+	select DEFAULT_UIMAGE
+	select E500
+	select PPC_E500MC
+	select PHYS_64BIT
+	select SWIOTLB
+	select ARCH_REQUIRE_GPIOLIB
+	select GENERIC_GPIO
+	select HAS_RAPIDIO
+	select PPC_EPAPR_HV_PIC
+	select HAS_FSL_QBMAN
+	select MDIO_BUS_MUX if FSL_DPAA_ETH
+	select MDIO_BUS_MUX_MMIOREG if FSL_DPAA_ETH
+	help
+	  This option enables support for the T04x QDS board
+	  The T104x application development system T104x QDS is a complete
+	  debugging environment intended for engineers developing
+	  applications for the T1040/T1042.
+
 config PPC_QEMU_E500
 	bool "QEMU generic e500 platform"
 	select DEFAULT_UIMAGE
diff --git a/arch/powerpc/platforms/85xx/Makefile b/arch/powerpc/platform=
s/85xx/Makefile
index 2eab37e..9c25a38 100644
--- a/arch/powerpc/platforms/85xx/Makefile
+++ b/arch/powerpc/platforms/85xx/Makefile
@@ -22,6 +22,7 @@ obj-$(CONFIG_P3041_DS)    +=3D p3041_ds.o corenet_ds.o
 obj-$(CONFIG_P4080_DS)    +=3D p4080_ds.o corenet_ds.o
 obj-$(CONFIG_P5020_DS)    +=3D p5020_ds.o corenet_ds.o
 obj-$(CONFIG_P5040_DS)    +=3D p5040_ds.o corenet_ds.o
+obj-$(CONFIG_T104x_QDS)   +=3D t104x_qds.o corenet_ds.o
 obj-$(CONFIG_T4240_QDS)   +=3D t4240_qds.o corenet_ds.o
 obj-$(CONFIG_B4_QDS)	  +=3D b4_qds.o corenet_ds.o
 obj-$(CONFIG_STX_GP3)	  +=3D stx_gp3.o
diff --git a/arch/powerpc/platforms/85xx/t104x_qds.c b/arch/powerpc/platf=
orms/85xx/t104x_qds.c
new file mode 100644
index 0000000..d28da14
--- /dev/null
+++ b/arch/powerpc/platforms/85xx/t104x_qds.c
@@ -0,0 +1,102 @@
+/*
+ * T104x QDS Setup
+ * Should apply for QDS platform of T1040 and it's personalities.
+ * viz T1040/T1042
+ *
+ * Copyright 2013 Freescale Semiconductor Inc.
+ *
+ * This program is free software; you can redistribute	it and/or modify =
it
+ * under  the terms of	the GNU General	 Public License as published by t=
he
+ * Free Software Foundation;  either version 2 of the  License, or (at y=
our
+ * option) any later version.
+ */
+
+#include <linux/kernel.h>
+#include <linux/pci.h>
+#include <linux/kdev_t.h>
+#include <linux/delay.h>
+#include <linux/interrupt.h>
+#include <linux/phy.h>
+
+#include <asm/time.h>
+#include <asm/machdep.h>
+#include <asm/pci-bridge.h>
+#include <mm/mmu_decl.h>
+#include <asm/prom.h>
+#include <asm/udbg.h>
+#include <asm/mpic.h>
+
+#include <linux/of_platform.h>
+#include <sysdev/fsl_soc.h>
+#include <sysdev/fsl_pci.h>
+#include <asm/ehv_pic.h>
+
+#include "corenet_ds.h"
+
+/*
+ * Called very early, device-tree isn't unflattened
+ */
+static int __init t104x_qds_probe(void)
+{
+	unsigned long root =3D of_get_flat_dt_root();
+#ifdef CONFIG_SMP
+	extern struct smp_ops_t smp_85xx_ops;
+#endif
+
+	if (of_flat_dt_is_compatible(root, "fsl,T1040QDS") ||
+		of_flat_dt_is_compatible(root, "fsl,T1042QDS"))
+
+		return 1;
+
+	/* Check if we're running under the Freescale hypervisor */
+	if (of_flat_dt_is_compatible(root, "fsl,T1040QDS-hv") ||
+		of_flat_dt_is_compatible(root, "fsl,T1042QDS-hv")) {
+		ppc_md.init_IRQ =3D ehv_pic_init;
+		ppc_md.get_irq =3D ehv_pic_get_irq;
+		ppc_md.restart =3D fsl_hv_restart;
+		ppc_md.power_off =3D fsl_hv_halt;
+		ppc_md.halt =3D fsl_hv_halt;
+#ifdef CONFIG_SMP
+		/*
+		 * Disable the timebase sync operations because we can't write
+		 * to the timebase registers under the hypervisor.
+		  */
+		smp_85xx_ops.give_timebase =3D NULL;
+		smp_85xx_ops.take_timebase =3D NULL;
+#endif
+
+		return 1;
+	}
+
+	return 0;
+}
+
+define_machine(t104x_qds) {
+	.name			=3D "T104x QDS",
+	.probe			=3D t104x_qds_probe,
+	.setup_arch		=3D corenet_ds_setup_arch,
+	.init_IRQ		=3D corenet_ds_pic_init,
+#ifdef CONFIG_PCI
+	.pcibios_fixup_bus	=3D fsl_pcibios_fixup_bus,
+#endif
+/* coreint doesn't play nice with lazy EE, use legacy mpic for now */
+#ifdef CONFIG_PPC64
+	.get_irq		=3D mpic_get_irq,
+#else
+	.get_irq		=3D mpic_get_coreint_irq,
+#endif
+	.restart		=3D fsl_rstcr_restart,
+	.calibrate_decr		=3D generic_calibrate_decr,
+	.progress		=3D udbg_progress,
+#ifdef CONFIG_PPC64
+	.power_save		=3D book3e_idle,
+#else
+	.power_save		=3D e500_idle,
+#endif
+};
+
+machine_arch_initcall(t104x_qds, corenet_ds_publish_devices);
+
+#ifdef CONFIG_SWIOTLB
+machine_arch_initcall(t104x_qds, swiotlb_setup_bus_notifier);
+#endif
--=20
1.7.9.5

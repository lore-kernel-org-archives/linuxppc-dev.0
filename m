Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 7AAE8B6EEF
	for <linuxppc-dev@ozlabs.org>; Sat, 21 Nov 2009 08:35:03 +1100 (EST)
Received: from localhost (localhost.localdomain [127.0.0.1])
	by gate.crashing.org (8.14.1/8.13.8) with ESMTP id nAKLYuED020122
	for <linuxppc-dev@ozlabs.org>; Fri, 20 Nov 2009 15:34:57 -0600
From: Kumar Gala <galak@kernel.crashing.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] powerpc/p4080: Add basic support for p4080ds platform
Date: Fri, 20 Nov 2009 15:34:56 -0600
Message-Id: <1258752896-2973-1-git-send-email-galak@kernel.crashing.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Add basic support for the P4080 DS reference board.  None of the data
path devices (ethernet, crypto, pme) are support at this time.

Signed-off-by: Kumar Gala <galak@kernel.crashing.org>
---
 arch/powerpc/boot/dts/p4080ds.dts        |  554 ++++++++++++++++++++++++++++++
 arch/powerpc/platforms/85xx/Kconfig      |   12 +
 arch/powerpc/platforms/85xx/Makefile     |    1 +
 arch/powerpc/platforms/85xx/corenet_ds.c |  125 +++++++
 arch/powerpc/platforms/85xx/corenet_ds.h |   19 +
 arch/powerpc/platforms/85xx/p4080_ds.c   |   74 ++++
 6 files changed, 785 insertions(+), 0 deletions(-)
 create mode 100644 arch/powerpc/boot/dts/p4080ds.dts
 create mode 100644 arch/powerpc/platforms/85xx/corenet_ds.c
 create mode 100644 arch/powerpc/platforms/85xx/corenet_ds.h
 create mode 100644 arch/powerpc/platforms/85xx/p4080_ds.c

diff --git a/arch/powerpc/boot/dts/p4080ds.dts b/arch/powerpc/boot/dts/p4080ds.dts
new file mode 100644
index 0000000..6b29eab
--- /dev/null
+++ b/arch/powerpc/boot/dts/p4080ds.dts
@@ -0,0 +1,554 @@
+/*
+ * P4080DS Device Tree Source
+ *
+ * Copyright 2009 Freescale Semiconductor Inc.
+ *
+ * This program is free software; you can redistribute	it and/or modify it
+ * under  the terms of	the GNU General	 Public License as published by the
+ * Free Software Foundation;  either version 2 of the  License, or (at your
+ * option) any later version.
+ */
+
+/dts-v1/;
+
+/ {
+	model = "fsl,P4080DS";
+	compatible = "fsl,P4080DS";
+	#address-cells = <2>;
+	#size-cells = <2>;
+
+	aliases {
+		ccsr = &soc;
+
+		serial0 = &serial0;
+		serial1 = &serial1;
+		serial2 = &serial2;
+		serial3 = &serial3;
+		pci0 = &pci0;
+		pci1 = &pci1;
+		pci2 = &pci2;
+		usb0 = &usb0;
+		usb1 = &usb1;
+		dma0 = &dma0;
+		dma1 = &dma1;
+		sdhc = &sdhc;
+
+		rio0 = &rapidio0;
+	};
+
+	cpus {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		cpu0: PowerPC,4080@0 {
+			device_type = "cpu";
+			reg = <0>;
+			next-level-cache = <&L2_0>;
+			L2_0: l2-cache {
+			};
+		};
+		cpu1: PowerPC,4080@1 {
+			device_type = "cpu";
+			reg = <1>;
+			next-level-cache = <&L2_1>;
+			L2_1: l2-cache {
+			};
+		};
+		cpu2: PowerPC,4080@2 {
+			device_type = "cpu";
+			reg = <2>;
+			next-level-cache = <&L2_2>;
+			L2_2: l2-cache {
+			};
+		};
+		cpu3: PowerPC,4080@3 {
+			device_type = "cpu";
+			reg = <3>;
+			next-level-cache = <&L2_3>;
+			L2_3: l2-cache {
+			};
+		};
+		cpu4: PowerPC,4080@4 {
+			device_type = "cpu";
+			reg = <4>;
+			next-level-cache = <&L2_4>;
+			L2_4: l2-cache {
+			};
+		};
+		cpu5: PowerPC,4080@5 {
+			device_type = "cpu";
+			reg = <5>;
+			next-level-cache = <&L2_5>;
+			L2_5: l2-cache {
+			};
+		};
+		cpu6: PowerPC,4080@6 {
+			device_type = "cpu";
+			reg = <6>;
+			next-level-cache = <&L2_6>;
+			L2_6: l2-cache {
+			};
+		};
+		cpu7: PowerPC,4080@7 {
+			device_type = "cpu";
+			reg = <7>;
+			next-level-cache = <&L2_7>;
+			L2_7: l2-cache {
+			};
+		};
+	};
+
+	memory {
+		device_type = "memory";
+	};
+
+	soc: soc@ffe000000 {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		device_type = "soc";
+		compatible = "simple-bus";
+		ranges = <0x00000000 0xf 0xfe000000 0x1000000>;
+		reg = <0xf 0xfe000000 0 0x00001000>;
+
+		corenet-law@0 {
+			compatible = "fsl,corenet-law";
+			reg = <0x0 0x1000>;
+			fsl,num-laws = <32>;
+		};
+
+		memory-controller@8000 {
+			compatible = "fsl,p4080-memory-controller";
+			reg = <0x8000 0x1000>;
+			interrupt-parent = <&mpic>;
+			interrupts = <0x12 2>;
+		};
+
+		memory-controller@9000 {
+			compatible = "fsl,p4080-memory-controller";
+			reg = <0x9000 0x1000>;
+			interrupt-parent = <&mpic>;
+			interrupts = <0x12 2>;
+		};
+
+		corenet-cf@18000 {
+			compatible = "fsl,corenet-cf";
+			reg = <0x18000 0x1000>;
+			fsl,ccf-num-csdids = <32>;
+			fsl,ccf-num-snoopids = <32>;
+		};
+
+		iommu@20000 {
+			compatible = "fsl,p4080-pamu";
+			reg = <0x20000 0x10000>;
+			interrupts = <24 2>;
+			interrupt-parent = <&mpic>;
+		};
+
+		mpic: pic@40000 {
+			interrupt-controller;
+			#address-cells = <0>;
+			#interrupt-cells = <2>;
+			reg = <0x40000 0x40000>;
+			compatible = "chrp,open-pic";
+			device_type = "open-pic";
+		};
+
+		dma0: dma@100300 {
+			#address-cells = <1>;
+			#size-cells = <1>;
+			compatible = "fsl,p4080-dma", "fsl,eloplus-dma";
+			reg = <0x100300 0x4>;
+			ranges = <0x0 0x100100 0x200>;
+			cell-index = <0>;
+			dma-channel@0 {
+				compatible = "fsl,p4080-dma-channel",
+						"fsl,eloplus-dma-channel";
+				reg = <0x0 0x80>;
+				cell-index = <0>;
+				interrupt-parent = <&mpic>;
+				interrupts = <28 2>;
+			};
+			dma-channel@80 {
+				compatible = "fsl,p4080-dma-channel",
+						"fsl,eloplus-dma-channel";
+				reg = <0x80 0x80>;
+				cell-index = <1>;
+				interrupt-parent = <&mpic>;
+				interrupts = <29 2>;
+			};
+			dma-channel@100 {
+				compatible = "fsl,p4080-dma-channel",
+						"fsl,eloplus-dma-channel";
+				reg = <0x100 0x80>;
+				cell-index = <2>;
+				interrupt-parent = <&mpic>;
+				interrupts = <30 2>;
+			};
+			dma-channel@180 {
+				compatible = "fsl,p4080-dma-channel",
+						"fsl,eloplus-dma-channel";
+				reg = <0x180 0x80>;
+				cell-index = <3>;
+				interrupt-parent = <&mpic>;
+				interrupts = <31 2>;
+			};
+		};
+
+		dma1: dma@101300 {
+			#address-cells = <1>;
+			#size-cells = <1>;
+			compatible = "fsl,p4080-dma", "fsl,eloplus-dma";
+			reg = <0x101300 0x4>;
+			ranges = <0x0 0x101100 0x200>;
+			cell-index = <1>;
+			dma-channel@0 {
+				compatible = "fsl,p4080-dma-channel",
+						"fsl,eloplus-dma-channel";
+				reg = <0x0 0x80>;
+				cell-index = <0>;
+				interrupt-parent = <&mpic>;
+				interrupts = <32 2>;
+			};
+			dma-channel@80 {
+				compatible = "fsl,p4080-dma-channel",
+						"fsl,eloplus-dma-channel";
+				reg = <0x80 0x80>;
+				cell-index = <1>;
+				interrupt-parent = <&mpic>;
+				interrupts = <33 2>;
+			};
+			dma-channel@100 {
+				compatible = "fsl,p4080-dma-channel",
+						"fsl,eloplus-dma-channel";
+				reg = <0x100 0x80>;
+				cell-index = <2>;
+				interrupt-parent = <&mpic>;
+				interrupts = <34 2>;
+			};
+			dma-channel@180 {
+				compatible = "fsl,p4080-dma-channel",
+						"fsl,eloplus-dma-channel";
+				reg = <0x180 0x80>;
+				cell-index = <3>;
+				interrupt-parent = <&mpic>;
+				interrupts = <35 2>;
+			};
+		};
+
+		spi@110000 {
+			cell-index = <0>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			compatible = "fsl,espi";
+			reg = <0x110000 0x1000>;
+			interrupts = <53 0x2>;
+			interrupt-parent = <&mpic>;
+			espi,num-ss-bits = <4>;
+			mode = "cpu";
+
+			fsl_m25p80@0 {
+				#address-cells = <1>;
+				#size-cells = <1>;
+				compatible = "fsl,espi-flash";
+				reg = <0>;
+				linux,modalias = "fsl_m25p80";
+				spi-max-frequency = <40000000>; /* input clock */
+				partition@u-boot {
+					label = "u-boot";
+					reg = <0x00000000 0x00100000>;
+					read-only;
+				};
+				partition@kernel {
+					label = "kernel";
+					reg = <0x00100000 0x00500000>;
+					read-only;
+				};
+				partition@dtb {
+					label = "dtb";
+					reg = <0x00600000 0x00100000>;
+					read-only;
+				};
+				partition@fs {
+					label = "file system";
+					reg = <0x00700000 0x00900000>;
+				};
+			};
+		};
+
+		sdhc: sdhc@114000 {
+			compatible = "fsl,p4080-esdhc", "fsl,esdhc";
+			reg = <0x114000 0x1000>;
+			interrupts = <48 2>;
+			interrupt-parent = <&mpic>;
+		};
+
+		i2c@118000 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			cell-index = <0>;
+			compatible = "fsl-i2c";
+			reg = <0x118000 0x100>;
+			interrupts = <38 2>;
+			interrupt-parent = <&mpic>;
+			dfsrr;
+		};
+
+		i2c@118100 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			cell-index = <1>;
+			compatible = "fsl-i2c";
+			reg = <0x118100 0x100>;
+			interrupts = <38 2>;
+			interrupt-parent = <&mpic>;
+			dfsrr;
+			eeprom@51 {
+				compatible = "at24,24c256";
+				reg = <0x51>;
+			};
+			eeprom@52 {
+				compatible = "at24,24c256";
+				reg = <0x52>;
+			};
+			rtc@68 {
+				compatible = "dallas,ds3232";
+				reg = <0x68>;
+				interrupts = <0 0x1>;
+				interrupt-parent = <&mpic>;
+			};
+		};
+
+		i2c@119000 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			cell-index = <2>;
+			compatible = "fsl-i2c";
+			reg = <0x119000 0x100>;
+			interrupts = <39 2>;
+			interrupt-parent = <&mpic>;
+			dfsrr;
+		};
+
+		i2c@119100 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			cell-index = <3>;
+			compatible = "fsl-i2c";
+			reg = <0x119100 0x100>;
+			interrupts = <39 2>;
+			interrupt-parent = <&mpic>;
+			dfsrr;
+		};
+
+		serial0: serial@11c500 {
+			cell-index = <0>;
+			device_type = "serial";
+			compatible = "ns16550";
+			reg = <0x11c500 0x100>;
+			clock-frequency = <0>;
+			interrupts = <36 2>;
+			interrupt-parent = <&mpic>;
+		};
+
+		serial1: serial@11c600 {
+			cell-index = <1>;
+			device_type = "serial";
+			compatible = "ns16550";
+			reg = <0x11c600 0x100>;
+			clock-frequency = <0>;
+			interrupts = <36 2>;
+			interrupt-parent = <&mpic>;
+		};
+
+		serial2: serial@11d500 {
+			cell-index = <2>;
+			device_type = "serial";
+			compatible = "ns16550";
+			reg = <0x11d500 0x100>;
+			clock-frequency = <0>;
+			interrupts = <37 2>;
+			interrupt-parent = <&mpic>;
+		};
+
+		serial3: serial@11d600 {
+			cell-index = <3>;
+			device_type = "serial";
+			compatible = "ns16550";
+			reg = <0x11d600 0x100>;
+			clock-frequency = <0>;
+			interrupts = <37 2>;
+			interrupt-parent = <&mpic>;
+		};
+
+		gpio0: gpio@130000 {
+			compatible = "fsl,p4080-gpio";
+			reg = <0x130000 0x1000>;
+			interrupts = <55 2>;
+			interrupt-parent = <&mpic>;
+			#gpio-cells = <2>;
+			gpio-controller;
+		};
+
+		usb0: usb@210000 {
+			compatible = "fsl,p4080-usb2-mph",
+					"fsl,mpc85xx-usb2-mph", "fsl-usb2-mph";
+			reg = <0x210000 0x1000>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			interrupt-parent = <&mpic>;
+			interrupts = <44 0x2>;
+			phy_type = "ulpi";
+		};
+
+		usb1: usb@211000 {
+			compatible = "fsl,p4080-usb2-dr",
+					"fsl,mpc85xx-usb2-dr", "fsl-usb2-dr";
+			reg = <0x211000 0x1000>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			interrupt-parent = <&mpic>;
+			interrupts = <45 0x2>;
+			dr_mode = "host";
+			phy_type = "ulpi";
+		};
+	};
+
+	rapidio0: rapidio@ffe0c0000 {
+		#address-cells = <2>;
+		#size-cells = <2>;
+		compatible = "fsl,rapidio-delta";
+		reg = <0xf 0xfe0c0000 0 0x20000>;
+		ranges = <0 0 0xf 0xf5000000 0 0x01000000>;
+		interrupt-parent = <&mpic>;
+		/* err_irq bell_outb_irq bell_inb_irq
+			msg1_tx_irq msg1_rx_irq	msg2_tx_irq msg2_rx_irq */
+		interrupts = <16 2 56 2 57 2 60 2 61 2 62 2 63 2>;
+	};
+
+	localbus@ffe124000 {
+		compatible = "fsl,p4080-elbc", "fsl,elbc", "simple-bus";
+		reg = <0xf 0xfe124000 0 0x1000>;
+		interrupts = <25 2>;
+		#address-cells = <2>;
+		#size-cells = <1>;
+
+		ranges = <0 0 0xf 0xe8000000 0x08000000>;
+
+		flash@0,0 {
+			compatible = "cfi-flash";
+			reg = <0 0 0x08000000>;
+			bank-width = <2>;
+			device-width = <2>;
+		};
+	};
+
+	pci0: pcie@ffe200000 {
+		compatible = "fsl,p4080-pcie";
+		device_type = "pci";
+		#interrupt-cells = <1>;
+		#size-cells = <2>;
+		#address-cells = <3>;
+		reg = <0xf 0xfe200000 0 0x1000>;
+		bus-range = <0x0 0xff>;
+		ranges = <0x02000000 0 0xe0000000 0xc 0x00000000 0x0 0x20000000
+			  0x01000000 0 0x00000000 0xf 0xf8000000 0x0 0x00010000>;
+		clock-frequency = <0x1fca055>;
+		interrupt-parent = <&mpic>;
+		interrupts = <16 2>;
+
+		interrupt-map-mask = <0xf800 0 0 7>;
+		interrupt-map = <
+			/* IDSEL 0x0 */
+			0000 0 0 1 &mpic 40 1
+			0000 0 0 2 &mpic 1 1
+			0000 0 0 3 &mpic 2 1
+			0000 0 0 4 &mpic 3 1
+			>;
+		pcie@0 {
+			reg = <0 0 0 0 0>;
+			#size-cells = <2>;
+			#address-cells = <3>;
+			device_type = "pci";
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
+	pci1: pcie@ffe201000 {
+		compatible = "fsl,p4080-pcie";
+		device_type = "pci";
+		#interrupt-cells = <1>;
+		#size-cells = <2>;
+		#address-cells = <3>;
+		reg = <0xf 0xfe201000 0 0x1000>;
+		bus-range = <0 0xff>;
+		ranges = <0x02000000 0x0 0xe0000000 0xc 0x20000000 0x0 0x20000000
+			  0x01000000 0x0 0x00000000 0xf 0xf8010000 0x0 0x00010000>;
+		clock-frequency = <0x1fca055>;
+		interrupt-parent = <&mpic>;
+		interrupts = <16 2>;
+		interrupt-map-mask = <0xf800 0 0 7>;
+		interrupt-map = <
+			/* IDSEL 0x0 */
+			0000 0 0 1 &mpic 41 1
+			0000 0 0 2 &mpic 5 1
+			0000 0 0 3 &mpic 6 1
+			0000 0 0 4 &mpic 7 1
+			>;
+		pcie@0 {
+			reg = <0 0 0 0 0>;
+			#size-cells = <2>;
+			#address-cells = <3>;
+			device_type = "pci";
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
+	pci2: pcie@ffe202000 {
+		compatible = "fsl,p4080-pcie";
+		device_type = "pci";
+		#interrupt-cells = <1>;
+		#size-cells = <2>;
+		#address-cells = <3>;
+		reg = <0xf 0xfe202000 0 0x1000>;
+		bus-range = <0x0 0xff>;
+		ranges = <0x02000000 0 0xe0000000 0xc 0x40000000 0 0x20000000
+			  0x01000000 0 0x00000000 0xf 0xf8020000 0 0x00010000>;
+		clock-frequency = <0x1fca055>;
+		interrupt-parent = <&mpic>;
+		interrupts = <16 2>;
+		interrupt-map-mask = <0xf800 0 0 7>;
+		interrupt-map = <
+			/* IDSEL 0x0 */
+			0000 0 0 1 &mpic 42 1
+			0000 0 0 2 &mpic 9 1
+			0000 0 0 3 &mpic 10 1
+			0000 0 0 4 &mpic 11 1
+			>;
+		pcie@0 {
+			reg = <0 0 0 0 0>;
+			#size-cells = <2>;
+			#address-cells = <3>;
+			device_type = "pci";
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
+};
diff --git a/arch/powerpc/platforms/85xx/Kconfig b/arch/powerpc/platforms/85xx/Kconfig
index 5de0d63..d951218 100644
--- a/arch/powerpc/platforms/85xx/Kconfig
+++ b/arch/powerpc/platforms/85xx/Kconfig
@@ -145,6 +145,18 @@ config SBC8560
 	help
 	  This option enables support for the Wind River SBC8560 board
 
+config P4080_DS
+	bool "Freescale P4080 DS"
+	select DEFAULT_UIMAGE
+	select PPC_FSL_BOOK3E
+	select PPC_E500MC
+	select PHYS_64BIT
+	select SWIOTLB
+	select MPC8xxx_GPIO
+	select HAS_RAPIDIO
+	help
+	  This option enables support for the P4080 DS board
+
 endif # FSL_SOC_BOOKE
 
 config TQM85xx
diff --git a/arch/powerpc/platforms/85xx/Makefile b/arch/powerpc/platforms/85xx/Makefile
index 9098aea..387c128 100644
--- a/arch/powerpc/platforms/85xx/Makefile
+++ b/arch/powerpc/platforms/85xx/Makefile
@@ -10,6 +10,7 @@ obj-$(CONFIG_MPC8536_DS)  += mpc8536_ds.o
 obj-$(CONFIG_MPC85xx_DS)  += mpc85xx_ds.o
 obj-$(CONFIG_MPC85xx_MDS) += mpc85xx_mds.o
 obj-$(CONFIG_MPC85xx_RDB) += mpc85xx_rdb.o
+obj-$(CONFIG_P4080_DS)    += p4080_ds.o corenet_ds.o
 obj-$(CONFIG_STX_GP3)	  += stx_gp3.o
 obj-$(CONFIG_TQM85xx)	  += tqm85xx.o
 obj-$(CONFIG_SBC8560)     += sbc8560.o
diff --git a/arch/powerpc/platforms/85xx/corenet_ds.c b/arch/powerpc/platforms/85xx/corenet_ds.c
new file mode 100644
index 0000000..534c2ec
--- /dev/null
+++ b/arch/powerpc/platforms/85xx/corenet_ds.c
@@ -0,0 +1,125 @@
+/*
+ * Corenet based SoC DS Setup
+ *
+ * Maintained by Kumar Gala (see MAINTAINERS for contact information)
+ *
+ * Copyright 2009 Freescale Semiconductor Inc.
+ *
+ * This program is free software; you can redistribute  it and/or modify it
+ * under  the terms of  the GNU General  Public License as published by the
+ * Free Software Foundation;  either version 2 of the  License, or (at your
+ * option) any later version.
+ */
+
+#include <linux/kernel.h>
+#include <linux/pci.h>
+#include <linux/kdev_t.h>
+#include <linux/delay.h>
+#include <linux/interrupt.h>
+#include <linux/lmb.h>
+
+#include <asm/system.h>
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
+
+void __init corenet_ds_pic_init(void)
+{
+	struct mpic *mpic;
+	struct resource r;
+	struct device_node *np = NULL;
+	unsigned int flags = MPIC_PRIMARY | MPIC_BIG_ENDIAN |
+				MPIC_BROKEN_FRR_NIRQS | MPIC_SINGLE_DEST_CPU;
+
+	np = of_find_node_by_type(np, "open-pic");
+
+	if (np == NULL) {
+		printk(KERN_ERR "Could not find open-pic node\n");
+		return;
+	}
+
+	if (of_address_to_resource(np, 0, &r)) {
+		printk(KERN_ERR "Failed to map mpic register space\n");
+		of_node_put(np);
+		return;
+	}
+
+	if (ppc_md.get_irq == mpic_get_coreint_irq)
+		flags |= MPIC_ENABLE_COREINT;
+
+	mpic = mpic_alloc(np, r.start, flags, 0, 256, " OpenPIC  ");
+	BUG_ON(mpic == NULL);
+
+	mpic_init(mpic);
+}
+
+#ifdef CONFIG_PCI
+static int primary_phb_addr;
+#endif
+
+/*
+ * Setup the architecture
+ */
+#ifdef CONFIG_SMP
+void __init mpc85xx_smp_init(void);
+#endif
+
+void __init corenet_ds_setup_arch(void)
+{
+#ifdef CONFIG_PCI
+	struct device_node *np;
+	struct pci_controller *hose;
+#endif
+	dma_addr_t max = 0xffffffff;
+
+#ifdef CONFIG_SMP
+	mpc85xx_smp_init();
+#endif
+
+#ifdef CONFIG_PCI
+	for_each_compatible_node(np, "pci", "fsl,p4080-pcie") {
+		struct resource rsrc;
+		of_address_to_resource(np, 0, &rsrc);
+		if ((rsrc.start & 0xfffff) == primary_phb_addr)
+			fsl_add_bridge(np, 1);
+		else
+			fsl_add_bridge(np, 0);
+
+		hose = pci_find_hose_for_OF_device(np);
+		max = min(max, hose->dma_window_base_cur +
+				hose->dma_window_size);
+	}
+#endif
+
+#ifdef CONFIG_SWIOTLB
+	if (lmb_end_of_DRAM() > max) {
+		ppc_swiotlb_enable = 1;
+		set_pci_dma_ops(&swiotlb_dma_ops);
+		ppc_md.pci_dma_dev_setup = pci_dma_dev_setup_swiotlb;
+	}
+#endif
+	pr_info("%s board from Freescale Semiconductor\n", ppc_md.name);
+}
+
+static const struct of_device_id of_device_ids[] __devinitconst = {
+	{
+		.compatible	= "simple-bus"
+	},
+	{
+		.compatible	= "fsl,rapidio-delta",
+	},
+	{}
+};
+
+int __init corenet_ds_publish_devices(void)
+{
+	return of_platform_bus_probe(NULL, of_device_ids, NULL);
+}
diff --git a/arch/powerpc/platforms/85xx/corenet_ds.h b/arch/powerpc/platforms/85xx/corenet_ds.h
new file mode 100644
index 0000000..ddd700b
--- /dev/null
+++ b/arch/powerpc/platforms/85xx/corenet_ds.h
@@ -0,0 +1,19 @@
+/*
+ * Corenet based SoC DS Setup
+ *
+ * Copyright 2009 Freescale Semiconductor Inc.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ */
+
+#ifndef CORENET_DS_H
+#define CORENET_DS_H
+
+extern void __init corenet_ds_pic_init(void);
+extern void __init corenet_ds_setup_arch(void);
+extern int __init corenet_ds_publish_devices(void);
+
+#endif
diff --git a/arch/powerpc/platforms/85xx/p4080_ds.c b/arch/powerpc/platforms/85xx/p4080_ds.c
new file mode 100644
index 0000000..8417046
--- /dev/null
+++ b/arch/powerpc/platforms/85xx/p4080_ds.c
@@ -0,0 +1,74 @@
+/*
+ * P4080 DS Setup
+ *
+ * Maintained by Kumar Gala (see MAINTAINERS for contact information)
+ *
+ * Copyright 2009 Freescale Semiconductor Inc.
+ *
+ * This program is free software; you can redistribute  it and/or modify it
+ * under  the terms of  the GNU General  Public License as published by the
+ * Free Software Foundation;  either version 2 of the  License, or (at your
+ * option) any later version.
+ */
+
+#include <linux/kernel.h>
+#include <linux/pci.h>
+#include <linux/kdev_t.h>
+#include <linux/delay.h>
+#include <linux/interrupt.h>
+
+#include <asm/system.h>
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
+
+#include "corenet_ds.h"
+
+#ifdef CONFIG_PCI
+static int primary_phb_addr;
+#endif
+
+/*
+ * Called very early, device-tree isn't unflattened
+ */
+static int __init p4080_ds_probe(void)
+{
+	unsigned long root = of_get_flat_dt_root();
+
+	if (of_flat_dt_is_compatible(root, "fsl,P4080DS")) {
+#ifdef CONFIG_PCI
+		/* treat PCIe1 as primary,
+		 * shouldn't matter as we have no ISA on the board
+		 */
+		primary_phb_addr = 0x0000;
+#endif
+		return 1;
+	} else {
+		return 0;
+	}
+}
+
+define_machine(p4080_ds) {
+	.name			= "P4080 DS",
+	.probe			= p4080_ds_probe,
+	.setup_arch		= corenet_ds_setup_arch,
+	.init_IRQ		= corenet_ds_pic_init,
+#ifdef CONFIG_PCI
+	.pcibios_fixup_bus	= fsl_pcibios_fixup_bus,
+#endif
+	.get_irq		= mpic_get_coreint_irq,
+	.restart		= fsl_rstcr_restart,
+	.calibrate_decr		= generic_calibrate_decr,
+	.progress		= udbg_progress,
+};
+
+machine_device_initcall(p4080_ds, corenet_ds_publish_devices);
+machine_arch_initcall(p4080_ds, swiotlb_setup_bus_notifier);
-- 
1.6.0.6

Return-Path: <rmachet@slac.stanford.edu>
Received: from nospam3.slac.stanford.edu (nospam3.slac.stanford.edu
	[134.79.18.120])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 51127DDEDB
	for <linuxppc-dev@ozlabs.org>; Fri, 16 May 2008 10:22:27 +1000 (EST)
Subject: [PATCH 1/5] powerpc: DTS file for the C2K
From: Remi Machet <rmachet@slac.stanford.edu>
To: Paul Mackerras <paulus@samba.org>
Content-Type: text/plain
Date: Thu, 15 May 2008 17:22:50 -0700
Message-Id: <1210897371.13992.13.camel@pcds-ts102.slac.stanford.edu>
Mime-Version: 1.0
Cc: Linux PPC <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Support for the C2K cPCI Single Board Computer from GEFanuc
(PowerPC MPC7448 with a Marvell MV64460 chipset)
All features of the board are not supported yet, but the board
boots, flash works, all Ethernet ports are working and PCI 
devices are all found (USB and SATA on PCI1 do not work yet).

Part 1 of 5: DTS file describing the board peripherals. As far as I know
all peripherals except the FPGA are listed in there (I did not included
the FPGA because a lot of work is needed there).

Signed-off-by: Remi Machet <rmachet@slac.stanford.edu>
---
 c2k.dts |  353 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 353 insertions(+)

diff --git a/arch/powerpc/boot/dts/c2k.dts b/arch/powerpc/boot/dts/c2k.dts
new file mode 100644
index 0000000..21281b8
--- /dev/null
+++ b/arch/powerpc/boot/dts/c2k.dts
@@ -0,0 +1,353 @@
+/* Device Tree Source for GEFanuc C2K
+ *
+ * Author: Remi Machet <rmachet@slac.stanford.edu>
+ * 
+ * Originated from prpmc2800.dts
+ *
+ * 2008 (c) Stanford University
+ * 2007 (c) MontaVista, Software, Inc.  
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License version 2 as published
+ * by the Free Software Foundation.
+ */
+
+/dts-v1/;
+
+/ {
+	#address-cells = <1>;
+	#size-cells = <1>;
+	model = "C2K";
+	compatible = "GEFanuc,C2K";
+	coherency-off;
+
+	cpus {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		PowerPC,7447 {
+			device_type = "cpu";
+			reg = <0>;
+			clock-frequency = <996000000>;	/* 996 MHz */
+			bus-frequency = <166666667>;	/* 166.6666 MHz */
+			timebase-frequency = <41666667>;	/* 166.6666/4 MHz */
+			i-cache-line-size = <32>;
+			d-cache-line-size = <32>;
+			i-cache-size = <32768>;
+			d-cache-size = <32768>;
+		};
+	};
+
+	memory {
+		device_type = "memory";
+		reg = <0x00000000 0x40000000>;	/* 1GB */
+	};
+
+	system-controller@d8000000 { /* Marvell Discovery */
+		#address-cells = <1>;
+		#size-cells = <1>;
+		model = "mv64460";
+		compatible = "marvell,mv64360";
+		clock-frequency = <166666667>;		/* 166.66... MHz */
+		reg = <0xd8000000 0x00010000>;
+		virtual-reg = <0xd8000000>;
+		ranges = <0xd4000000 0xd4000000 0x01000000	/* PCI 0 I/O Space */
+			  0x80000000 0x80000000 0x08000000	/* PCI 0 MEM Space */
+			  0xd0000000 0xd0000000 0x01000000	/* PCI 1 I/O Space */
+			  0xa0000000 0xa0000000 0x08000000	/* PCI 1 MEM Space */
+			  0xf8000000 0xf8000000 0x08000000	/* User FLASH */
+			  0x00000000 0xd8000000 0x00010000	/* Bridge's regs */
+			  0xd8140000 0xd8140000 0x00040000>;	/* Integrated SRAM */
+
+		mdio {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			device_type = "mdio";
+			compatible = "marvell,mv64360-mdio";
+			PHY0: ethernet-phy@0 {
+				device_type = "ethernet-phy";
+				interrupts = <76>;	/* GPP 12 */
+				interrupt-parent = <&PIC>;
+				reg = <0>;
+			};
+			PHY1: ethernet-phy@1 {
+				device_type = "ethernet-phy";
+				interrupts = <76>;	/* GPP 12 */
+				interrupt-parent = <&PIC>;
+				reg = <1>;
+			};
+			PHY2: ethernet-phy@2 {
+				device_type = "ethernet-phy";
+				interrupts = <76>;	/* GPP 12 */
+				interrupt-parent = <&PIC>;
+				reg = <2>;
+			};
+		};
+
+		ethernet-group@2000 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			compatible = "marvell,mv64360-eth-group";
+			reg = <0x2000 0x2000>;
+			ethernet@0 {
+				device_type = "network";
+				compatible = "marvell,mv64360-eth";
+				reg = <0>;
+				interrupts = <32>;
+				interrupt-parent = <&PIC>;
+				phy = <&PHY0>;
+				local-mac-address = [ 00 00 00 00 00 00 ];
+			};
+			ethernet@1 {
+				device_type = "network";
+				compatible = "marvell,mv64360-eth";
+				reg = <1>;
+				interrupts = <33>;
+				interrupt-parent = <&PIC>;
+				phy = <&PHY1>;
+				local-mac-address = [ 00 00 00 00 00 00 ];
+			};
+			ethernet@2 {
+				device_type = "network";
+				compatible = "marvell,mv64360-eth";
+				reg = <2>;
+				interrupts = <34>;
+				interrupt-parent = <&PIC>;
+				phy = <&PHY2>;
+				local-mac-address = [ 00 00 00 00 00 00 ];
+			};
+		};
+
+		SDMA0: sdma@4000 {
+			compatible = "marvell,mv64360-sdma";
+			reg = <0x4000 0xc18>;
+			virtual-reg = <0xd8004000>;
+			interrupt-base = <0>;
+			interrupts = <36>;
+			interrupt-parent = <&PIC>;
+		};
+
+		SDMA1: sdma@6000 {
+			compatible = "marvell,mv64360-sdma";
+			reg = <0x6000 0xc18>;
+			virtual-reg = <0xd8006000>;
+			interrupt-base = <0>;
+			interrupts = <38>;
+			interrupt-parent = <&PIC>;
+		};
+
+		BRG0: brg@b200 {
+			compatible = "marvell,mv64360-brg";
+			reg = <0xb200 0x8>;
+			clock-src = <8>;
+			clock-frequency = <133333333>;
+			current-speed = <115200>;
+		};
+
+		BRG1: brg@b208 {
+			compatible = "marvell,mv64360-brg";
+			reg = <0xb208 0x8>;
+			clock-src = <8>;
+			clock-frequency = <133333333>;
+			current-speed = <115200>;
+		};
+
+		CUNIT: cunit@f200 {
+			reg = <0xf200 0x200>;
+		};
+
+		MPSCROUTING: mpscrouting@b400 {
+			reg = <0xb400 0xc>;
+		};
+
+		MPSCINTR: mpscintr@b800 {
+			reg = <0xb800 0x100>;
+			virtual-reg = <0xd800b800>;
+		};
+
+		MPSC0: mpsc@8000 {
+			device_type = "serial";
+			compatible = "marvell,mv64360-mpsc";
+			reg = <0x8000 0x38>;
+			virtual-reg = <0xd8008000>;
+			sdma = <&SDMA0>;
+			brg = <&BRG0>;
+			cunit = <&CUNIT>;
+			mpscrouting = <&MPSCROUTING>;
+			mpscintr = <&MPSCINTR>;
+			cell-index = <0>;
+			interrupts = <40>;
+			interrupt-parent = <&PIC>;
+		};
+
+		MPSC1: mpsc@9000 {
+			device_type = "serial";
+			compatible = "marvell,mv64360-mpsc";
+			reg = <0x9000 0x38>;
+			virtual-reg = <0xd8009000>;
+			sdma = <&SDMA1>;
+			brg = <&BRG1>;
+			cunit = <&CUNIT>;
+			mpscrouting = <&MPSCROUTING>;
+			mpscintr = <&MPSCINTR>;
+			cell-index = <1>;
+			interrupts = <42>;
+			interrupt-parent = <&PIC>;
+		};
+
+		wdt@b410 {			/* watchdog timer */
+			compatible = "marvell,mv64360-wdt";
+			reg = <0xb410 0x8>;
+		};
+
+		i2c@c000 {
+			device_type = "i2c";
+			compatible = "marvell,mv64360-i2c";
+			reg = <0xc000 0x20>;
+			virtual-reg = <0xd800c000>;
+			interrupts = <37>;
+			interrupt-parent = <&PIC>;
+		};
+
+		PIC: pic {
+			#interrupt-cells = <1>;
+			#address-cells = <0>;
+			compatible = "marvell,mv64360-pic";
+			reg = <0x0000 0x88>;
+			interrupt-controller;
+		};
+
+		mpp@f000 {
+			compatible = "marvell,mv64360-mpp";
+			reg = <0xf000 0x10>;
+		};
+
+		gpp@f100 {
+			compatible = "marvell,mv64360-gpp";
+			reg = <0xf100 0x20>;
+		};
+
+		PCI0: pci@80000000 {
+			#address-cells = <3>;
+			#size-cells = <2>;
+			#interrupt-cells = <1>;
+			device_type = "pci";
+			compatible = "marvell,mv64360-pci";
+			cell-index = <0>;
+			reg = <0x0cf8 0x8>;
+			ranges = <0x01000000 0x0 0x00000000 0xd4000000 0x0 0x01000000
+				  0x02000000 0x0 0x80000000 0x80000000 0x0 0x08000000>;
+			bus-range = <0 255>;
+			clock-frequency = <66000000>;
+			interrupt-pci-iack = <0x0c34>;
+			interrupt-parent = <&PIC>;
+			interrupt-map-mask = <0x0000 0x0 0x0 0x7>;
+			interrupt-map = <
+				/* Only one interrupt line for PMC0 slot (INTA) */
+				0x0000 0 0 1 &PIC 88
+			>;
+		};
+
+
+		PCI1: pci@a0000000 {
+			#address-cells = <3>;
+			#size-cells = <2>;
+			#interrupt-cells = <1>;
+			device_type = "pci";
+			compatible = "marvell,mv64360-pci";
+			cell-index = <1>;
+			reg = <0x0c78 0x8>;
+			ranges = <0x01000000 0x0 0x00000000 0xd0000000 0x0 0x01000000
+				  0x02000000 0x0 0x80000000 0xa0000000 0x0 0x08000000>;
+			bus-range = <0 255>;
+			clock-frequency = <66000000>;
+			interrupt-pci-iack = <0x0cb4>;
+			interrupt-parent = <&PIC>;
+			interrupt-map-mask = <0xf800 0x00 0x00 0x7>;
+			interrupt-map = <
+				/* IDSEL 0x01: PMC1 ? */
+				0x0800 0 0 1 &PIC 88
+				/* IDSEL 0x02: cPCI bridge */
+				0x1000 0 0 1 &PIC 88
+				/* IDSEL 0x03: USB controller */
+				0x1800 0 0 1 &PIC 91
+				/* IDSEL 0x04: SATA controller */
+				0x2000 0 0 1 &PIC 95
+			>;
+		};
+
+		cpu-error@0070 {
+			compatible = "marvell,mv64360-cpu-error";
+			reg = <0x0070 0x10 0x0128 0x28>;
+			interrupts = <3>;
+			interrupt-parent = <&PIC>;
+		};
+
+		sram-ctrl@0380 {
+			compatible = "marvell,mv64360-sram-ctrl";
+			reg = <0x0380 0x80>;
+			interrupts = <13>;
+			interrupt-parent = <&PIC>;
+		};
+
+		pci-error@1d40 {
+			compatible = "marvell,mv64360-pci-error";
+			reg = <0x1d40 0x40 0x0c28 0x4>;
+			interrupts = <12>;
+			interrupt-parent = <&PIC>;
+		};
+
+		pci-error@1dc0 {
+			compatible = "marvell,mv64360-pci-error";
+			reg = <0x1dc0 0x40 0x0ca8 0x4>;
+			interrupts = <16>;
+			interrupt-parent = <&PIC>;
+		};
+
+		mem-ctrl@1400 {
+			compatible = "marvell,mv64360-mem-ctrl";
+			reg = <0x1400 0x60>;
+			interrupts = <17>;
+			interrupt-parent = <&PIC>;
+		};
+		/* Devices attached to the device controller */
+		devicebus {
+			compatible = "marvell,mv64306-devctrl";
+			#address-cells = <1>;
+			#size-cells = <1>;
+			nor_flash {
+				compatible = "cfi-flash";
+				reg = <0xf8000000 0x8000000>; /* 128MB */
+				bank-width = <4>;
+				device-width = <1>;
+				#address-cells = <1>;
+				#size-cells = <1>;
+				partition@0 {
+					label = "boot";
+					reg = <0x00000000 0x00080000>;
+				};
+				partition@40000 {
+					label = "kernel";
+					reg = <0x00080000 0x00400000>;
+				};
+				partition@440000 {
+					label = "initrd";
+					reg = <0x00480000 0x00B80000>;
+				};
+				partition@1000000 {
+					label = "rootfs";
+					reg = <0x01000000 0x06800000>;
+				};
+				partition@7800000 {
+					label = "recovery";
+					reg = <0x07800000 0x00800000>;
+					read-only;
+				};
+			};
+		};
+	};
+	chosen {
+		bootargs = "ip=off root=/dev/mtdblock3 rootfstype=jffs2";
+		linux,stdout-path = &MPSC0;
+	};
+};

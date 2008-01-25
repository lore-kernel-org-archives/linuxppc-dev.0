Return-Path: <kim.phillips@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 4F017DE707
	for <linuxppc-dev@ozlabs.org>; Fri, 25 Jan 2008 13:47:29 +1100 (EST)
Date: Thu, 24 Jan 2008 20:47:18 -0600
From: Kim Phillips <kim.phillips@freescale.com>
To: linuxppc-dev@ozlabs.org, Kumar Gala <galak@kernel.crashing.org>
Subject: [PATCH 8/9] powerpc: add the mpc837[789]_rdb dts files
Message-Id: <20080124204718.33a30ab5.kim.phillips@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: Joe D'Abbraccio <ljd015@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Add the dts files for the MPC838xE Reference Development Board (RDB).

The board is a mini-ITX reference board with 256M DDR2, 8M flash,
32M NAND, USB, PCI, gigabit ethernet, SATA, and serial.

the difference among the three files is the 8377 has two, the 8378
none, and the 8379 has four sata controllers.

partially based on the 8379 mds device trees.

Signed-off-by: Joe D'Abbraccio <ljd015@freescale.com>
Signed-off-by: Kim Phillips <kim.phillips@freescale.com>
---
 arch/powerpc/boot/dts/mpc8377_rdb.dts |  296 +++++++++++++++++++++++++++++++
 arch/powerpc/boot/dts/mpc8378_rdb.dts |  282 ++++++++++++++++++++++++++++++
 arch/powerpc/boot/dts/mpc8379_rdb.dts |  310 +++++++++++++++++++++++++++++++++
 3 files changed, 888 insertions(+), 0 deletions(-)
 create mode 100644 arch/powerpc/boot/dts/mpc8377_rdb.dts
 create mode 100644 arch/powerpc/boot/dts/mpc8378_rdb.dts
 create mode 100644 arch/powerpc/boot/dts/mpc8379_rdb.dts

diff --git a/arch/powerpc/boot/dts/mpc8377_rdb.dts b/arch/powerpc/boot/dts/mpc8377_rdb.dts
new file mode 100644
index 0000000..6bd018d
--- /dev/null
+++ b/arch/powerpc/boot/dts/mpc8377_rdb.dts
@@ -0,0 +1,296 @@
+/*
+ * MPC8377E RDB Device Tree Source
+ *
+ * Copyright 2007, 2008 Freescale Semiconductor Inc.
+ *
+ * This program is free software; you can redistribute  it and/or modify it
+ * under  the terms of  the GNU General  Public License as published by the
+ * Free Software Foundation;  either version 2 of the  License, or (at your
+ * option) any later version.
+ */
+
+/dts-v1/;
+
+/ {
+	compatible = "fsl,mpc8377erdb";
+	#address-cells = <1>;
+	#size-cells = <1>;
+
+	aliases {
+		ethernet0 = &enet0;
+		ethernet1 = &enet1;
+		serial0 = &serial0;
+		serial1 = &serial1;
+		pci0 = &pci0;
+	};
+
+	cpus {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		PowerPC,8377@0 {
+			device_type = "cpu";
+			reg = <0>;
+			d-cache-line-size = <32>;
+			i-cache-line-size = <32>;
+			d-cache-size = <32768>;
+			i-cache-size = <32768>;
+			timebase-frequency = <0>;
+			bus-frequency = <0>;
+			clock-frequency = <0>;
+		};
+	};
+
+	memory {
+		device_type = "memory";
+		reg = <0x00000000 0x10000000>;	// 256MB at 0
+	};
+
+	localbus@e0005000 {
+		#address-cells = <2>;
+		#size-cells = <1>;
+		compatible = "fsl,mpc8377-elbc", "fsl,elbc", "simple-bus";
+		reg = <0xe0005000 0x1000>;
+		interrupts = <77 8>;
+		interrupt-parent = <&ipic>;
+
+		// CS0 and CS1 are swapped when
+		// booting from nand, but the
+		// addresses are the same.
+		ranges = <0 0 0xfe000000 0x00800000
+		          1 0 0xe0600000 0x00008000
+		          2 0 0xf0000000 0x00020000
+		          3 0 0xfa000000 0x00008000>;
+
+		flash@0,0 {
+			#address-cells = <1>;
+			#size-cells = <1>;
+			compatible = "cfi-flash";
+			reg = <0 0 0x800000>;
+			bank-width = <2>;
+			device-width = <1>;
+		};
+
+		nand@1,0 {
+			#address-cells = <1>;
+			#size-cells = <1>;
+			compatible = "fsl,mpc8377-fcm-nand",
+			             "fsl,elbc-fcm-nand";
+			reg = <1 0 0x8000>;
+
+			u-boot@0 {
+				reg = <0x0 0x100000>;
+				read-only;
+			};
+
+			kernel@100000 {
+				reg = <0x100000 0x300000>;
+			};
+			fs@400000 {
+				reg = <0x400000 0x1c00000>;
+			};
+		};
+	};
+
+	immr@e0000000 {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		device_type = "soc";
+		compatible = "simple-bus";
+		ranges = <0 0xe0000000 0x00100000>;
+		reg = <0xe0000000 0x00000200>;
+		bus-frequency = <0>;
+
+		wdt@200 {
+			device_type = "watchdog";
+			compatible = "mpc83xx_wdt";
+			reg = <0x200 0x100>;
+		};
+
+		i2c@3000 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			cell-index = <0>;
+			compatible = "fsl-i2c";
+			reg = <0x3000 0x100>;
+			interrupts = <14 8>;
+			interrupt-parent = < &ipic >;
+			dfsrr;
+			rtc@68 {
+				device_type = "rtc";
+				compatible = "dallas,ds1339";
+				reg = <0x68>;
+			};
+		};
+
+		i2c@3100 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			cell-index = <1>;
+			compatible = "fsl-i2c";
+			reg = <0x3100 0x100>;
+			interrupts = <15 8>;
+			interrupt-parent = < &ipic >;
+			dfsrr;
+		};
+
+		spi@7000 {
+			device_type = "spi";
+			compatible = "fsl_spi";
+			reg = <0x7000 0x1000>;
+			interrupts = <16 8>;
+			interrupt-parent = < &ipic >;
+			mode = "cpu";
+		};
+
+		/* phy type (ULPI, UTMI, UTMI_WIDE, SERIAL) */
+		usb@23000 {
+			compatible = "fsl-usb2-dr";
+			reg = <0x23000 0x1000>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			interrupt-parent = < &ipic >;
+			interrupts = <38 8>;
+			phy_type = "utmi";
+		};
+
+		mdio@24520 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			compatible = "fsl,gianfar-mdio";
+			reg = <0x24520 0x20>;
+			phy2: ethernet-phy@2 {
+				interrupt-parent = < &ipic >;
+				interrupts = <17 8>;
+				reg = <2>;
+				device_type = "ethernet-phy";
+			};
+			phy3: ethernet-phy@3 {
+				interrupt-parent = < &ipic >;
+				interrupts = <18 8>;
+				reg = <3>;
+				device_type = "ethernet-phy";
+			};
+		};
+
+		enet0: ethernet@24000 {
+			cell-index = <0>;
+			device_type = "network";
+			model = "eTSEC";
+			compatible = "gianfar";
+			reg = <0x24000 0x1000>;
+			local-mac-address = [ 00 00 00 00 00 00 ];
+			interrupts = <32 8 33 8 34 8>;
+			phy-connection-type = "mii";
+			interrupt-parent = < &ipic >;
+			phy-handle = < &phy2 >;
+		};
+
+		enet1: ethernet@25000 {
+			cell-index = <1>;
+			device_type = "network";
+			model = "eTSEC";
+			compatible = "gianfar";
+			reg = <0x25000 0x1000>;
+			local-mac-address = [ 00 00 00 00 00 00 ];
+			interrupts = <35 8 36 8 37 8>;
+			phy-connection-type = "mii";
+			interrupt-parent = < &ipic >;
+			phy-handle = < &phy3 >;
+		};
+
+		serial0: serial@4500 {
+			cell-index = <0>;
+			device_type = "serial";
+			compatible = "ns16550";
+			reg = <0x4500 0x100>;
+			clock-frequency = <0>;
+			interrupts = <9 8>;
+			interrupt-parent = < &ipic >;
+		};
+
+		serial1: serial@4600 {
+			cell-index = <1>;
+			device_type = "serial";
+			compatible = "ns16550";
+			reg = <0x4600 0x100>;
+			clock-frequency = <0>;
+			interrupts = <10 8>;
+			interrupt-parent = < &ipic >;
+		};
+
+		crypto@30000 {
+			model = "SEC3";
+			device_type = "crypto";
+			compatible = "talitos";
+			reg = <0x30000 0x10000>;
+			interrupts = <11 8>;
+			interrupt-parent = < &ipic >;
+			/* Rev. 3.0 geometry */
+			num-channels = <4>;
+			channel-fifo-len = <24>;
+			exec-units-mask = <0x000001fe>;
+			descriptor-types-mask = <0x03ab0ebf>;
+		};
+
+		sata@18000 {
+			compatible = "fsl,mpc8377-sata", "fsl,pq-sata";
+			reg = <0x18000 0x1000>;
+			interrupts = <44 8>;
+			interrupt-parent = < &ipic >;
+		};
+
+		sata@19000 {
+			compatible = "fsl,mpc8377-sata", "fsl,pq-sata";
+			reg = <0x19000 0x1000>;
+			interrupts = <45 8>;
+			interrupt-parent = < &ipic >;
+		};
+
+		/* IPIC
+		 * interrupts cell = <intr #, sense>
+		 * sense values match linux IORESOURCE_IRQ_* defines:
+		 * sense == 8: Level, low assertion
+		 * sense == 2: Edge, high-to-low change
+		 */
+		ipic: interrupt-controller@700 {
+			compatible = "fsl,ipic";
+			interrupt-controller;
+			#address-cells = <0>;
+			#interrupt-cells = <2>;
+			reg = <0x700 0x100>;
+		};
+	};
+
+	pci0: pci@e0008500 {
+		interrupt-map-mask = <0xf800 0 0 7>;
+		interrupt-map = <
+				/* IRQ5 = 21 = 0x15, IRQ6 = 0x16, IRQ7 = 23 = 0x17 */
+
+				/* IDSEL AD14 IRQ6 inta */
+				 0x7000 0 0 1 &ipic 22 8
+
+				/* IDSEL AD15 IRQ5 inta, IRQ6 intb, IRQ7 intd */
+				 0x7800 0 0 1 &ipic 21 8
+				 0x7800 0 0 2 &ipic 22 8
+				 0x7800 0 0 4 &ipic 23 8
+
+				/* IDSEL AD28 IRQ7 inta, IRQ5 intb IRQ6 intc*/
+				 0xE000 0 0 1 &ipic 23 8
+				 0xE000 0 0 2 &ipic 21 8
+				 0xE000 0 0 3 &ipic 22 8>;
+		interrupt-parent = < &ipic >;
+		interrupts = <66 8>;
+		bus-range = <0 0>;
+		ranges = <0x02000000 0 0x90000000 0x90000000 0 0x10000000
+		          0x42000000 0 0x80000000 0x80000000 0 0x10000000
+		          0x01000000 0 0x00000000 0xe2000000 0 0x00100000>;
+		clock-frequency = <66666666>;
+		#interrupt-cells = <1>;
+		#size-cells = <2>;
+		#address-cells = <3>;
+		reg = <0xe0008500 0x100>;
+		compatible = "fsl,mpc8349-pci";
+		device_type = "pci";
+	};
+};
diff --git a/arch/powerpc/boot/dts/mpc8378_rdb.dts b/arch/powerpc/boot/dts/mpc8378_rdb.dts
new file mode 100644
index 0000000..66f1402
--- /dev/null
+++ b/arch/powerpc/boot/dts/mpc8378_rdb.dts
@@ -0,0 +1,282 @@
+/*
+ * MPC8378E RDB Device Tree Source
+ *
+ * Copyright 2007, 2008 Freescale Semiconductor Inc.
+ *
+ * This program is free software; you can redistribute  it and/or modify it
+ * under  the terms of  the GNU General  Public License as published by the
+ * Free Software Foundation;  either version 2 of the  License, or (at your
+ * option) any later version.
+ */
+
+/dts-v1/;
+
+/ {
+	compatible = "fsl,mpc8378erdb";
+	#address-cells = <1>;
+	#size-cells = <1>;
+
+	aliases {
+		ethernet0 = &enet0;
+		ethernet1 = &enet1;
+		serial0 = &serial0;
+		serial1 = &serial1;
+		pci0 = &pci0;
+	};
+
+	cpus {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		PowerPC,8378@0 {
+			device_type = "cpu";
+			reg = <0>;
+			d-cache-line-size = <32>;
+			i-cache-line-size = <32>;
+			d-cache-size = <32768>;
+			i-cache-size = <32768>;
+			timebase-frequency = <0>;
+			bus-frequency = <0>;
+			clock-frequency = <0>;
+		};
+	};
+
+	memory {
+		device_type = "memory";
+		reg = <0x00000000 0x10000000>;	// 256MB at 0
+	};
+
+	localbus@e0005000 {
+		#address-cells = <2>;
+		#size-cells = <1>;
+		compatible = "fsl,mpc8378-elbc", "fsl,elbc", "simple-bus";
+		reg = <0xe0005000 0x1000>;
+		interrupts = <77 8>;
+		interrupt-parent = <&ipic>;
+
+		// CS0 and CS1 are swapped when
+		// booting from nand, but the
+		// addresses are the same.
+		ranges = <0 0 0xfe000000 0x00800000
+		          1 0 0xe0600000 0x00008000
+		          2 0 0xf0000000 0x00020000
+		          3 0 0xfa000000 0x00008000>;
+
+		flash@0,0 {
+			#address-cells = <1>;
+			#size-cells = <1>;
+			compatible = "cfi-flash";
+			reg = <0 0 0x800000>;
+			bank-width = <2>;
+			device-width = <1>;
+		};
+
+		nand@1,0 {
+			#address-cells = <1>;
+			#size-cells = <1>;
+			compatible = "fsl,mpc8378-fcm-nand",
+			             "fsl,elbc-fcm-nand";
+			reg = <1 0 0x8000>;
+
+			u-boot@0 {
+				reg = <0x0 0x100000>;
+				read-only;
+			};
+
+			kernel@100000 {
+				reg = <0x100000 0x300000>;
+			};
+			fs@400000 {
+				reg = <0x400000 0x1c00000>;
+			};
+		};
+	};
+
+	immr@e0000000 {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		device_type = "soc";
+		compatible = "simple-bus";
+		ranges = <0 0xe0000000 0x00100000>;
+		reg = <0xe0000000 0x00000200>;
+		bus-frequency = <0>;
+
+		wdt@200 {
+			device_type = "watchdog";
+			compatible = "mpc83xx_wdt";
+			reg = <0x200 0x100>;
+		};
+
+		i2c@3000 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			cell-index = <0>;
+			compatible = "fsl-i2c";
+			reg = <0x3000 0x100>;
+			interrupts = <14 8>;
+			interrupt-parent = < &ipic >;
+			dfsrr;
+			rtc@68 {
+				device_type = "rtc";
+				compatible = "dallas,ds1339";
+				reg = <0x68>;
+			};
+		};
+
+		i2c@3100 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			cell-index = <1>;
+			compatible = "fsl-i2c";
+			reg = <0x3100 0x100>;
+			interrupts = <15 8>;
+			interrupt-parent = < &ipic >;
+			dfsrr;
+		};
+
+		spi@7000 {
+			device_type = "spi";
+			compatible = "fsl_spi";
+			reg = <0x7000 0x1000>;
+			interrupts = <16 8>;
+			interrupt-parent = < &ipic >;
+			mode = "cpu";
+		};
+
+		/* phy type (ULPI, UTMI, UTMI_WIDE, SERIAL) */
+		usb@23000 {
+			compatible = "fsl-usb2-dr";
+			reg = <0x23000 0x1000>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			interrupt-parent = < &ipic >;
+			interrupts = <38 8>;
+			phy_type = "utmi";
+		};
+
+		mdio@24520 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			compatible = "fsl,gianfar-mdio";
+			reg = <0x24520 0x20>;
+			phy2: ethernet-phy@2 {
+				interrupt-parent = < &ipic >;
+				interrupts = <17 8>;
+				reg = <2>;
+				device_type = "ethernet-phy";
+			};
+			phy3: ethernet-phy@3 {
+				interrupt-parent = < &ipic >;
+				interrupts = <18 8>;
+				reg = <3>;
+				device_type = "ethernet-phy";
+			};
+		};
+
+		enet0: ethernet@24000 {
+			cell-index = <0>;
+			device_type = "network";
+			model = "eTSEC";
+			compatible = "gianfar";
+			reg = <0x24000 0x1000>;
+			local-mac-address = [ 00 00 00 00 00 00 ];
+			interrupts = <32 8 33 8 34 8>;
+			phy-connection-type = "mii";
+			interrupt-parent = < &ipic >;
+			phy-handle = < &phy2 >;
+		};
+
+		enet1: ethernet@25000 {
+			cell-index = <1>;
+			device_type = "network";
+			model = "eTSEC";
+			compatible = "gianfar";
+			reg = <0x25000 0x1000>;
+			local-mac-address = [ 00 00 00 00 00 00 ];
+			interrupts = <35 8 36 8 37 8>;
+			phy-connection-type = "mii";
+			interrupt-parent = < &ipic >;
+			phy-handle = < &phy3 >;
+		};
+
+		serial0: serial@4500 {
+			cell-index = <0>;
+			device_type = "serial";
+			compatible = "ns16550";
+			reg = <0x4500 0x100>;
+			clock-frequency = <0>;
+			interrupts = <9 8>;
+			interrupt-parent = < &ipic >;
+		};
+
+		serial1: serial@4600 {
+			cell-index = <1>;
+			device_type = "serial";
+			compatible = "ns16550";
+			reg = <0x4600 0x100>;
+			clock-frequency = <0>;
+			interrupts = <10 8>;
+			interrupt-parent = < &ipic >;
+		};
+
+		crypto@30000 {
+			model = "SEC3";
+			device_type = "crypto";
+			compatible = "talitos";
+			reg = <0x30000 0x10000>;
+			interrupts = <11 8>;
+			interrupt-parent = < &ipic >;
+			/* Rev. 3.0 geometry */
+			num-channels = <4>;
+			channel-fifo-len = <24>;
+			exec-units-mask = <0x000001fe>;
+			descriptor-types-mask = <0x03ab0ebf>;
+		};
+
+		/* IPIC
+		 * interrupts cell = <intr #, sense>
+		 * sense values match linux IORESOURCE_IRQ_* defines:
+		 * sense == 8: Level, low assertion
+		 * sense == 2: Edge, high-to-low change
+		 */
+		ipic: interrupt-controller@700 {
+			compatible = "fsl,ipic";
+			interrupt-controller;
+			#address-cells = <0>;
+			#interrupt-cells = <2>;
+			reg = <0x700 0x100>;
+		};
+	};
+
+	pci0: pci@e0008500 {
+		interrupt-map-mask = <0xf800 0 0 7>;
+		interrupt-map = <
+				/* IRQ5 = 21 = 0x15, IRQ6 = 0x16, IRQ7 = 23 = 0x17 */
+
+				/* IDSEL AD14 IRQ6 inta */
+				 0x7000 0 0 1 &ipic 22 8
+
+				/* IDSEL AD15 IRQ5 inta, IRQ6 intb, IRQ7 intd */
+				 0x7800 0 0 1 &ipic 21 8
+				 0x7800 0 0 2 &ipic 22 8
+				 0x7800 0 0 4 &ipic 23 8
+
+				/* IDSEL AD28 IRQ7 inta, IRQ5 intb IRQ6 intc*/
+				 0xE000 0 0 1 &ipic 23 8
+				 0xE000 0 0 2 &ipic 21 8
+				 0xE000 0 0 3 &ipic 22 8>;
+		interrupt-parent = < &ipic >;
+		interrupts = <66 8>;
+		bus-range = <0 0>;
+		ranges = <0x02000000 0 0x90000000 0x90000000 0 0x10000000
+		          0x42000000 0 0x80000000 0x80000000 0 0x10000000
+		          0x01000000 0 0x00000000 0xe2000000 0 0x00100000>;
+		clock-frequency = <66666666>;
+		#interrupt-cells = <1>;
+		#size-cells = <2>;
+		#address-cells = <3>;
+		reg = <0xe0008500 0x100>;
+		compatible = "fsl,mpc8349-pci";
+		device_type = "pci";
+	};
+};
diff --git a/arch/powerpc/boot/dts/mpc8379_rdb.dts b/arch/powerpc/boot/dts/mpc8379_rdb.dts
new file mode 100644
index 0000000..eb54bed
--- /dev/null
+++ b/arch/powerpc/boot/dts/mpc8379_rdb.dts
@@ -0,0 +1,310 @@
+/*
+ * MPC8379E RDB Device Tree Source
+ *
+ * Copyright 2007, 2008 Freescale Semiconductor Inc.
+ *
+ * This program is free software; you can redistribute  it and/or modify it
+ * under  the terms of  the GNU General  Public License as published by the
+ * Free Software Foundation;  either version 2 of the  License, or (at your
+ * option) any later version.
+ */
+
+/dts-v1/;
+
+/ {
+	compatible = "fsl,mpc8379erdb";
+	#address-cells = <1>;
+	#size-cells = <1>;
+
+	aliases {
+		ethernet0 = &enet0;
+		ethernet1 = &enet1;
+		serial0 = &serial0;
+		serial1 = &serial1;
+		pci0 = &pci0;
+	};
+
+	cpus {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		PowerPC,8379@0 {
+			device_type = "cpu";
+			reg = <0>;
+			d-cache-line-size = <32>;
+			i-cache-line-size = <32>;
+			d-cache-size = <32768>;
+			i-cache-size = <32768>;
+			timebase-frequency = <0>;
+			bus-frequency = <0>;
+			clock-frequency = <0>;
+		};
+	};
+
+	memory {
+		device_type = "memory";
+		reg = <0x00000000 0x10000000>;	// 256MB at 0
+	};
+
+	localbus@e0005000 {
+		#address-cells = <2>;
+		#size-cells = <1>;
+		compatible = "fsl,mpc8379-elbc", "fsl,elbc", "simple-bus";
+		reg = <0xe0005000 0x1000>;
+		interrupts = <77 8>;
+		interrupt-parent = <&ipic>;
+
+		// CS0 and CS1 are swapped when
+		// booting from nand, but the
+		// addresses are the same.
+		ranges = <0 0 0xfe000000 0x00800000
+		          1 0 0xe0600000 0x00008000
+		          2 0 0xf0000000 0x00020000
+		          3 0 0xfa000000 0x00008000>;
+
+		flash@0,0 {
+			#address-cells = <1>;
+			#size-cells = <1>;
+			compatible = "cfi-flash";
+			reg = <0 0 0x800000>;
+			bank-width = <2>;
+			device-width = <1>;
+		};
+
+		nand@1,0 {
+			#address-cells = <1>;
+			#size-cells = <1>;
+			compatible = "fsl,mpc8379-fcm-nand",
+			             "fsl,elbc-fcm-nand";
+			reg = <1 0 0x8000>;
+
+			u-boot@0 {
+				reg = <0x0 0x100000>;
+				read-only;
+			};
+
+			kernel@100000 {
+				reg = <0x100000 0x300000>;
+			};
+			fs@400000 {
+				reg = <0x400000 0x1c00000>;
+			};
+		};
+	};
+
+	immr@e0000000 {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		device_type = "soc";
+		compatible = "simple-bus";
+		ranges = <0 0xe0000000 0x00100000>;
+		reg = <0xe0000000 0x00000200>;
+		bus-frequency = <0>;
+
+		wdt@200 {
+			device_type = "watchdog";
+			compatible = "mpc83xx_wdt";
+			reg = <0x200 0x100>;
+		};
+
+		i2c@3000 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			cell-index = <0>;
+			compatible = "fsl-i2c";
+			reg = <0x3000 0x100>;
+			interrupts = <14 8>;
+			interrupt-parent = < &ipic >;
+			dfsrr;
+			rtc@68 {
+				device_type = "rtc";
+				compatible = "dallas,ds1339";
+				reg = <0x68>;
+			};
+		};
+
+		i2c@3100 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			cell-index = <1>;
+			compatible = "fsl-i2c";
+			reg = <0x3100 0x100>;
+			interrupts = <15 8>;
+			interrupt-parent = < &ipic >;
+			dfsrr;
+		};
+
+		spi@7000 {
+			device_type = "spi";
+			compatible = "fsl_spi";
+			reg = <0x7000 0x1000>;
+			interrupts = <16 8>;
+			interrupt-parent = < &ipic >;
+			mode = "cpu";
+		};
+
+		/* phy type (ULPI, UTMI, UTMI_WIDE, SERIAL) */
+		usb@23000 {
+			compatible = "fsl-usb2-dr";
+			reg = <0x23000 0x1000>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			interrupt-parent = < &ipic >;
+			interrupts = <38 8>;
+			phy_type = "utmi";
+		};
+
+		mdio@24520 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			compatible = "fsl,gianfar-mdio";
+			reg = <0x24520 0x20>;
+			phy2: ethernet-phy@2 {
+				interrupt-parent = < &ipic >;
+				interrupts = <17 8>;
+				reg = <2>;
+				device_type = "ethernet-phy";
+			};
+			phy3: ethernet-phy@3 {
+				interrupt-parent = < &ipic >;
+				interrupts = <18 8>;
+				reg = <3>;
+				device_type = "ethernet-phy";
+			};
+		};
+
+		enet0: ethernet@24000 {
+			cell-index = <0>;
+			device_type = "network";
+			model = "eTSEC";
+			compatible = "gianfar";
+			reg = <0x24000 0x1000>;
+			local-mac-address = [ 00 00 00 00 00 00 ];
+			interrupts = <32 8 33 8 34 8>;
+			phy-connection-type = "mii";
+			interrupt-parent = < &ipic >;
+			phy-handle = < &phy2 >;
+		};
+
+		enet1: ethernet@25000 {
+			cell-index = <1>;
+			device_type = "network";
+			model = "eTSEC";
+			compatible = "gianfar";
+			reg = <0x25000 0x1000>;
+			local-mac-address = [ 00 00 00 00 00 00 ];
+			interrupts = <35 8 36 8 37 8>;
+			phy-connection-type = "mii";
+			interrupt-parent = < &ipic >;
+			phy-handle = < &phy3 >;
+		};
+
+		serial0: serial@4500 {
+			cell-index = <0>;
+			device_type = "serial";
+			compatible = "ns16550";
+			reg = <0x4500 0x100>;
+			clock-frequency = <0>;
+			interrupts = <9 8>;
+			interrupt-parent = < &ipic >;
+		};
+
+		serial1: serial@4600 {
+			cell-index = <1>;
+			device_type = "serial";
+			compatible = "ns16550";
+			reg = <0x4600 0x100>;
+			clock-frequency = <0>;
+			interrupts = <10 8>;
+			interrupt-parent = < &ipic >;
+		};
+
+		crypto@30000 {
+			model = "SEC3";
+			device_type = "crypto";
+			compatible = "talitos";
+			reg = <0x30000 0x10000>;
+			interrupts = <11 8>;
+			interrupt-parent = < &ipic >;
+			/* Rev. 3.0 geometry */
+			num-channels = <4>;
+			channel-fifo-len = <24>;
+			exec-units-mask = <0x000001fe>;
+			descriptor-types-mask = <0x03ab0ebf>;
+		};
+
+		sata@18000 {
+			compatible = "fsl,mpc8379-sata", "fsl,pq-sata";
+			reg = <0x18000 0x1000>;
+			interrupts = <44 8>;
+			interrupt-parent = < &ipic >;
+		};
+
+		sata@19000 {
+			compatible = "fsl,mpc8379-sata", "fsl,pq-sata";
+			reg = <0x19000 0x1000>;
+			interrupts = <45 8>;
+			interrupt-parent = < &ipic >;
+		};
+
+		sata@1a000 {
+			compatible = "fsl,mpc8379-sata", "fsl,pq-sata";
+			reg = <0x1a000 0x1000>;
+			interrupts = <46 8>;
+			interrupt-parent = < &ipic >;
+		};
+
+		sata@1b000 {
+			compatible = "fsl,mpc8379-sata", "fsl,pq-sata";
+			reg = <0x1b000 0x1000>;
+			interrupts = <47 8>;
+			interrupt-parent = < &ipic >;
+		};
+
+		/* IPIC
+		 * interrupts cell = <intr #, sense>
+		 * sense values match linux IORESOURCE_IRQ_* defines:
+		 * sense == 8: Level, low assertion
+		 * sense == 2: Edge, high-to-low change
+		 */
+		ipic: interrupt-controller@700 {
+			compatible = "fsl,ipic";
+			interrupt-controller;
+			#address-cells = <0>;
+			#interrupt-cells = <2>;
+			reg = <0x700 0x100>;
+		};
+	};
+
+	pci0: pci@e0008500 {
+		interrupt-map-mask = <0xf800 0 0 7>;
+		interrupt-map = <
+				/* IRQ5 = 21 = 0x15, IRQ6 = 0x16, IRQ7 = 23 = 0x17 */
+
+				/* IDSEL AD14 IRQ6 inta */
+				 0x7000 0 0 1 &ipic 22 8
+
+				/* IDSEL AD15 IRQ5 inta, IRQ6 intb, IRQ7 intd */
+				 0x7800 0 0 1 &ipic 21 8
+				 0x7800 0 0 2 &ipic 22 8
+				 0x7800 0 0 4 &ipic 23 8
+
+				/* IDSEL AD28 IRQ7 inta, IRQ5 intb IRQ6 intc*/
+				 0xE000 0 0 1 &ipic 23 8
+				 0xE000 0 0 2 &ipic 21 8
+				 0xE000 0 0 3 &ipic 22 8>;
+		interrupt-parent = < &ipic >;
+		interrupts = <66 8>;
+		bus-range = <0 0>;
+		ranges = <0x02000000 0 0x90000000 0x90000000 0 0x10000000
+		          0x42000000 0 0x80000000 0x80000000 0 0x10000000
+		          0x01000000 0 0x00000000 0xe2000000 0 0x00100000>;
+		clock-frequency = <66666666>;
+		#interrupt-cells = <1>;
+		#size-cells = <2>;
+		#address-cells = <3>;
+		reg = <0xe0008500 0x100>;
+		compatible = "fsl,mpc8349-pci";
+		device_type = "pci";
+	};
+};
-- 
1.5.2.2

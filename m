Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 528F1DDE0D
	for <linuxppc-dev@ozlabs.org>; Fri, 25 Jan 2008 18:42:33 +1100 (EST)
Received: from localhost (localhost.localdomain [127.0.0.1])
	by gate.crashing.org (8.13.8/8.13.8) with ESMTP id m0P7gS67008781
	for <linuxppc-dev@ozlabs.org>; Fri, 25 Jan 2008 01:42:29 -0600
Date: Fri, 25 Jan 2008 01:40:05 -0600 (CST)
From: Kumar Gala <galak@kernel.crashing.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] [POWERPC] 85xx: Port TQM85xx boards over from arch/ppc
Message-ID: <Pine.LNX.4.64.0801250139180.7955@blarg.am.freescale.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Signed-off-by: Kumar Gala <galak@kernel.crashing.org>
---
 arch/powerpc/boot/dts/tqm8540.dts      |  204 +++++++
 arch/powerpc/boot/dts/tqm8541.dts      |  228 +++++++
 arch/powerpc/boot/dts/tqm8555.dts      |  228 +++++++
 arch/powerpc/boot/dts/tqm8560.dts      |  245 ++++++++
 arch/powerpc/configs/tqm8540_defconfig | 1032 +++++++++++++++++++++++++++++++
 arch/powerpc/configs/tqm8541_defconfig | 1044 ++++++++++++++++++++++++++++++++
 arch/powerpc/configs/tqm8555_defconfig | 1044 ++++++++++++++++++++++++++++++++
 arch/powerpc/configs/tqm8560_defconfig | 1044 ++++++++++++++++++++++++++++++++
 arch/powerpc/platforms/85xx/Kconfig    |   39 ++
 arch/powerpc/platforms/85xx/Makefile   |    1 +
 arch/powerpc/platforms/85xx/tqm85xx.c  |  191 ++++++
 11 files changed, 5300 insertions(+), 0 deletions(-)
 create mode 100644 arch/powerpc/boot/dts/tqm8540.dts
 create mode 100644 arch/powerpc/boot/dts/tqm8541.dts
 create mode 100644 arch/powerpc/boot/dts/tqm8555.dts
 create mode 100644 arch/powerpc/boot/dts/tqm8560.dts
 create mode 100644 arch/powerpc/configs/tqm8540_defconfig
 create mode 100644 arch/powerpc/configs/tqm8541_defconfig
 create mode 100644 arch/powerpc/configs/tqm8555_defconfig
 create mode 100644 arch/powerpc/configs/tqm8560_defconfig
 create mode 100644 arch/powerpc/platforms/85xx/tqm85xx.c

diff --git a/arch/powerpc/boot/dts/tqm8540.dts b/arch/powerpc/boot/dts/tqm8540.dts
new file mode 100644
index 0000000..a6e3989
--- /dev/null
+++ b/arch/powerpc/boot/dts/tqm8540.dts
@@ -0,0 +1,204 @@
+/*
+ * TQM 8540 Device Tree Source
+ *
+ * Copyright 2008 Freescale Semiconductor Inc.
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
+	model = "tqm,8540";
+	compatible = "tqm,8540", "tqm,85xx";
+	#address-cells = <1>;
+	#size-cells = <1>;
+
+	aliases {
+		ethernet0 = &enet0;
+		ethernet1 = &enet1;
+		ethernet2 = &enet2;
+		serial0 = &serial0;
+		serial1 = &serial1;
+		pci0 = &pci0;
+	};
+
+	cpus {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		PowerPC,8540@0 {
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
+		reg = <0x00000000 0x10000000>;
+	};
+
+	soc8540@e0000000 {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		device_type = "soc";
+		ranges = <0x0 0xe0000000 0x100000>;
+		reg = <0xe0000000 0x200>;
+		bus-frequency = <0>;
+		compatible = "fsl,mpc8540-immr", "simple-bus";
+
+		memory-controller@2000 {
+			compatible = "fsl,8540-memory-controller";
+			reg = <0x2000 0x1000>;
+			interrupt-parent = <&mpic>;
+			interrupts = <18 2>;
+		};
+
+		l2-cache-controller@20000 {
+			compatible = "fsl,8540-l2-cache-controller";
+			reg = <0x20000 0x1000>;
+			cache-line-size = <32>;
+			cache-size = <0x40000>;	// L2, 256K
+			interrupt-parent = <&mpic>;
+			interrupts = <16 2>;
+		};
+
+		i2c@3000 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			cell-index = <0>;
+			compatible = "fsl-i2c";
+			reg = <0x3000 0x100>;
+			interrupts = <43 2>;
+			interrupt-parent = <&mpic>;
+			dfsrr;
+
+			rtc@68 {
+				compatible = "dallas,ds1337";
+				reg = <0x68>;
+			};
+		};
+
+		mdio@24520 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			compatible = "fsl,gianfar-mdio";
+			reg = <0x24520 0x20>;
+
+			phy1: ethernet-phy@1 {
+				interrupt-parent = <&mpic>;
+				interrupts = <8 1>;
+				reg = <1>;
+				device_type = "ethernet-phy";
+			};
+			phy2: ethernet-phy@2 {
+				interrupt-parent = <&mpic>;
+				interrupts = <8 1>;
+				reg = <2>;
+				device_type = "ethernet-phy";
+			};
+			phy3: ethernet-phy@3 {
+				interrupt-parent = <&mpic>;
+				interrupts = <8 1>;
+				reg = <3>;
+				device_type = "ethernet-phy";
+			};
+		};
+
+		enet0: ethernet@24000 {
+			cell-index = <0>;
+			device_type = "network";
+			model = "TSEC";
+			compatible = "gianfar";
+			reg = <0x24000 0x1000>;
+			local-mac-address = [ 00 00 00 00 00 00 ];
+			interrupts = <29 2 30 2 34 2>;
+			interrupt-parent = <&mpic>;
+			phy-handle = <&phy2>;
+		};
+
+		enet1: ethernet@25000 {
+			cell-index = <1>;
+			device_type = "network";
+			model = "TSEC";
+			compatible = "gianfar";
+			reg = <0x25000 0x1000>;
+			local-mac-address = [ 00 00 00 00 00 00 ];
+			interrupts = <35 2 36 2 40 2>;
+			interrupt-parent = <&mpic>;
+			phy-handle = <&phy1>;
+		};
+
+		enet2: ethernet@26000 {
+			cell-index = <2>;
+			device_type = "network";
+			model = "FEC";
+			compatible = "gianfar";
+			reg = <0x26000 0x1000>;
+			local-mac-address = [ 00 00 00 00 00 00 ];
+			interrupts = <41 2>;
+			interrupt-parent = <&mpic>;
+			phy-handle = <&phy3>;
+		};
+
+		serial0: serial@4500 {
+			cell-index = <0>;
+			device_type = "serial";
+			compatible = "ns16550";
+			reg = <0x4500 0x100>; 	// reg base, size
+			clock-frequency = <0>; 	// should we fill in in uboot?
+			interrupts = <42 2>;
+			interrupt-parent = <&mpic>;
+		};
+
+		serial1: serial@4600 {
+			cell-index = <1>;
+			device_type = "serial";
+			compatible = "ns16550";
+			reg = <0x4600 0x100>;	// reg base, size
+			clock-frequency = <0>; 	// should we fill in in uboot?
+			interrupts = <42 2>;
+			interrupt-parent = <&mpic>;
+		};
+
+		mpic: pic@40000 {
+			interrupt-controller;
+			#address-cells = <0>;
+			#interrupt-cells = <2>;
+			reg = <0x40000 0x40000>;
+			device_type = "open-pic";
+		};
+	};
+
+	pci0: pci@e0008000 {
+		cell-index = <0>;
+		#interrupt-cells = <1>;
+		#size-cells = <2>;
+		#address-cells = <3>;
+		compatible = "fsl,mpc8540-pcix", "fsl,mpc8540-pci";
+		device_type = "pci";
+		reg = <0xe0008000 0x1000>;
+		clock-frequency = <66666666>;
+		interrupt-map-mask = <0xf800 0x0 0x0 0x7>;
+		interrupt-map = <
+				/* IDSEL 28 */
+				 0xe000 0 0 1 &mpic 2 1
+				 0xe000 0 0 2 &mpic 3 1>;
+
+		interrupt-parent = <&mpic>;
+		interrupts = <24 2>;
+		bus-range = <0 0>;
+		ranges = <0x02000000 0 0x80000000 0x80000000 0 0x20000000
+			  0x01000000 0 0x00000000 0xe2000000 0 0x01000000>;
+	};
+};
diff --git a/arch/powerpc/boot/dts/tqm8541.dts b/arch/powerpc/boot/dts/tqm8541.dts
new file mode 100644
index 0000000..11bdb0f
--- /dev/null
+++ b/arch/powerpc/boot/dts/tqm8541.dts
@@ -0,0 +1,228 @@
+/*
+ * TQM 8541 Device Tree Source
+ *
+ * Copyright 2008 Freescale Semiconductor Inc.
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
+	model = "tqm,8541";
+	compatible = "tqm,8541", "tqm,85xx";
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
+		PowerPC,8541@0 {
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
+		reg = <0x00000000 0x10000000>;
+	};
+
+	soc8541@e0000000 {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		device_type = "soc";
+		ranges = <0x0 0xe0000000 0x100000>;
+		reg = <0xe0000000 0x200>;
+		bus-frequency = <0>;
+		compatible = "fsl,mpc8541-immr", "simple-bus";
+
+		memory-controller@2000 {
+			compatible = "fsl,8540-memory-controller";
+			reg = <0x2000 0x1000>;
+			interrupt-parent = <&mpic>;
+			interrupts = <18 2>;
+		};
+
+		l2-cache-controller@20000 {
+			compatible = "fsl,8540-l2-cache-controller";
+			reg = <0x20000 0x1000>;
+			cache-line-size = <32>;
+			cache-size = <0x40000>;	// L2, 256K
+			interrupt-parent = <&mpic>;
+			interrupts = <16 2>;
+		};
+
+		i2c@3000 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			cell-index = <0>;
+			compatible = "fsl-i2c";
+			reg = <0x3000 0x100>;
+			interrupts = <43 2>;
+			interrupt-parent = <&mpic>;
+			dfsrr;
+
+			rtc@68 {
+				compatible = "dallas,ds1337";
+				reg = <0x68>;
+			};
+		};
+
+		mdio@24520 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			compatible = "fsl,gianfar-mdio";
+			reg = <0x24520 0x20>;
+
+			phy1: ethernet-phy@1 {
+				interrupt-parent = <&mpic>;
+				interrupts = <8 1>;
+				reg = <1>;
+				device_type = "ethernet-phy";
+			};
+			phy2: ethernet-phy@2 {
+				interrupt-parent = <&mpic>;
+				interrupts = <8 1>;
+				reg = <2>;
+				device_type = "ethernet-phy";
+			};
+			phy3: ethernet-phy@3 {
+				interrupt-parent = <&mpic>;
+				interrupts = <8 1>;
+				reg = <3>;
+				device_type = "ethernet-phy";
+			};
+		};
+
+		enet0: ethernet@24000 {
+			cell-index = <0>;
+			device_type = "network";
+			model = "TSEC";
+			compatible = "gianfar";
+			reg = <0x24000 0x1000>;
+			local-mac-address = [ 00 00 00 00 00 00 ];
+			interrupts = <29 2 30 2 34 2>;
+			interrupt-parent = <&mpic>;
+			phy-handle = <&phy2>;
+		};
+
+		enet1: ethernet@25000 {
+			cell-index = <1>;
+			device_type = "network";
+			model = "TSEC";
+			compatible = "gianfar";
+			reg = <0x25000 0x1000>;
+			local-mac-address = [ 00 00 00 00 00 00 ];
+			interrupts = <35 2 36 2 40 2>;
+			interrupt-parent = <&mpic>;
+			phy-handle = <&phy1>;
+		};
+
+		serial0: serial@4500 {
+			cell-index = <0>;
+			device_type = "serial";
+			compatible = "ns16550";
+			reg = <0x4500 0x100>; 	// reg base, size
+			clock-frequency = <0>; 	// should we fill in in uboot?
+			interrupts = <42 2>;
+			interrupt-parent = <&mpic>;
+		};
+
+		serial1: serial@4600 {
+			cell-index = <1>;
+			device_type = "serial";
+			compatible = "ns16550";
+			reg = <0x4600 0x100>;	// reg base, size
+			clock-frequency = <0>; 	// should we fill in in uboot?
+			interrupts = <42 2>;
+			interrupt-parent = <&mpic>;
+		};
+
+		mpic: pic@40000 {
+			interrupt-controller;
+			#address-cells = <0>;
+			#interrupt-cells = <2>;
+			reg = <0x40000 0x40000>;
+			device_type = "open-pic";
+		};
+
+		cpm@919c0 {
+			#address-cells = <1>;
+			#size-cells = <1>;
+			compatible = "fsl,mpc8541-cpm", "fsl,cpm2", "simple-bus";
+			reg = <0x919c0 0x30>;
+			ranges;
+
+			muram@80000 {
+				#address-cells = <1>;
+				#size-cells = <1>;
+				ranges = <0 0x80000 0x10000>;
+
+				data@0 {
+					compatible = "fsl,cpm-muram-data";
+					reg = <0 0x2000 0x9000 0x1000>;
+				};
+			};
+
+			brg@919f0 {
+				compatible = "fsl,mpc8541-brg",
+				             "fsl,cpm2-brg",
+				             "fsl,cpm-brg";
+				reg = <0x919f0 0x10 0x915f0 0x10>;
+				clock-frequency = <0>;
+			};
+
+			cpmpic: pic@90c00 {
+				interrupt-controller;
+				#address-cells = <0>;
+				#interrupt-cells = <2>;
+				interrupts = <46 2>;
+				interrupt-parent = <&mpic>;
+				reg = <0x90c00 0x80>;
+				compatible = "fsl,mpc8541-cpm-pic", "fsl,cpm2-pic";
+			};
+		};
+	};
+
+	pci0: pci@e0008000 {
+		cell-index = <0>;
+		#interrupt-cells = <1>;
+		#size-cells = <2>;
+		#address-cells = <3>;
+		compatible = "fsl,mpc8540-pcix", "fsl,mpc8540-pci";
+		device_type = "pci";
+		reg = <0xe0008000 0x1000>;
+		clock-frequency = <66666666>;
+		interrupt-map-mask = <0xf800 0x0 0x0 0x7>;
+		interrupt-map = <
+				/* IDSEL 28 */
+				 0xe000 0 0 1 &mpic 2 1
+				 0xe000 0 0 2 &mpic 3 1>;
+
+		interrupt-parent = <&mpic>;
+		interrupts = <24 2>;
+		bus-range = <0 0>;
+		ranges = <0x02000000 0 0x80000000 0x80000000 0 0x20000000
+			  0x01000000 0 0x00000000 0xe2000000 0 0x01000000>;
+	};
+};
diff --git a/arch/powerpc/boot/dts/tqm8555.dts b/arch/powerpc/boot/dts/tqm8555.dts
new file mode 100644
index 0000000..eef9a6b
--- /dev/null
+++ b/arch/powerpc/boot/dts/tqm8555.dts
@@ -0,0 +1,228 @@
+/*
+ * TQM 8555 Device Tree Source
+ *
+ * Copyright 2008 Freescale Semiconductor Inc.
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
+	model = "tqm,8555";
+	compatible = "tqm,8555", "tqm,85xx";
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
+		PowerPC,8555@0 {
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
+		reg = <0x00000000 0x10000000>;
+	};
+
+	soc8555@e0000000 {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		device_type = "soc";
+		ranges = <0x0 0xe0000000 0x100000>;
+		reg = <0xe0000000 0x200>;
+		bus-frequency = <0>;
+		compatible = "fsl,mpc8555-immr", "simple-bus";
+
+		memory-controller@2000 {
+			compatible = "fsl,8540-memory-controller";
+			reg = <0x2000 0x1000>;
+			interrupt-parent = <&mpic>;
+			interrupts = <18 2>;
+		};
+
+		l2-cache-controller@20000 {
+			compatible = "fsl,8540-l2-cache-controller";
+			reg = <0x20000 0x1000>;
+			cache-line-size = <32>;
+			cache-size = <0x40000>;	// L2, 256K
+			interrupt-parent = <&mpic>;
+			interrupts = <16 2>;
+		};
+
+		i2c@3000 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			cell-index = <0>;
+			compatible = "fsl-i2c";
+			reg = <0x3000 0x100>;
+			interrupts = <43 2>;
+			interrupt-parent = <&mpic>;
+			dfsrr;
+
+			rtc@68 {
+				compatible = "dallas,ds1337";
+				reg = <0x68>;
+			};
+		};
+
+		mdio@24520 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			compatible = "fsl,gianfar-mdio";
+			reg = <0x24520 0x20>;
+
+			phy1: ethernet-phy@1 {
+				interrupt-parent = <&mpic>;
+				interrupts = <8 1>;
+				reg = <1>;
+				device_type = "ethernet-phy";
+			};
+			phy2: ethernet-phy@2 {
+				interrupt-parent = <&mpic>;
+				interrupts = <8 1>;
+				reg = <2>;
+				device_type = "ethernet-phy";
+			};
+			phy3: ethernet-phy@3 {
+				interrupt-parent = <&mpic>;
+				interrupts = <8 1>;
+				reg = <3>;
+				device_type = "ethernet-phy";
+			};
+		};
+
+		enet0: ethernet@24000 {
+			cell-index = <0>;
+			device_type = "network";
+			model = "TSEC";
+			compatible = "gianfar";
+			reg = <0x24000 0x1000>;
+			local-mac-address = [ 00 00 00 00 00 00 ];
+			interrupts = <29 2 30 2 34 2>;
+			interrupt-parent = <&mpic>;
+			phy-handle = <&phy2>;
+		};
+
+		enet1: ethernet@25000 {
+			cell-index = <1>;
+			device_type = "network";
+			model = "TSEC";
+			compatible = "gianfar";
+			reg = <0x25000 0x1000>;
+			local-mac-address = [ 00 00 00 00 00 00 ];
+			interrupts = <35 2 36 2 40 2>;
+			interrupt-parent = <&mpic>;
+			phy-handle = <&phy1>;
+		};
+
+		serial0: serial@4500 {
+			cell-index = <0>;
+			device_type = "serial";
+			compatible = "ns16550";
+			reg = <0x4500 0x100>; 	// reg base, size
+			clock-frequency = <0>; 	// should we fill in in uboot?
+			interrupts = <42 2>;
+			interrupt-parent = <&mpic>;
+		};
+
+		serial1: serial@4600 {
+			cell-index = <1>;
+			device_type = "serial";
+			compatible = "ns16550";
+			reg = <0x4600 0x100>;	// reg base, size
+			clock-frequency = <0>; 	// should we fill in in uboot?
+			interrupts = <42 2>;
+			interrupt-parent = <&mpic>;
+		};
+
+		mpic: pic@40000 {
+			interrupt-controller;
+			#address-cells = <0>;
+			#interrupt-cells = <2>;
+			reg = <0x40000 0x40000>;
+			device_type = "open-pic";
+		};
+
+		cpm@919c0 {
+			#address-cells = <1>;
+			#size-cells = <1>;
+			compatible = "fsl,mpc8555-cpm", "fsl,cpm2", "simple-bus";
+			reg = <0x919c0 0x30>;
+			ranges;
+
+			muram@80000 {
+				#address-cells = <1>;
+				#size-cells = <1>;
+				ranges = <0 0x80000 0x10000>;
+
+				data@0 {
+					compatible = "fsl,cpm-muram-data";
+					reg = <0 0x2000 0x9000 0x1000>;
+				};
+			};
+
+			brg@919f0 {
+				compatible = "fsl,mpc8555-brg",
+				             "fsl,cpm2-brg",
+				             "fsl,cpm-brg";
+				reg = <0x919f0 0x10 0x915f0 0x10>;
+				clock-frequency = <0>;
+			};
+
+			cpmpic: pic@90c00 {
+				interrupt-controller;
+				#address-cells = <0>;
+				#interrupt-cells = <2>;
+				interrupts = <46 2>;
+				interrupt-parent = <&mpic>;
+				reg = <0x90c00 0x80>;
+				compatible = "fsl,mpc8555-cpm-pic", "fsl,cpm2-pic";
+			};
+		};
+	};
+
+	pci0: pci@e0008000 {
+		cell-index = <0>;
+		#interrupt-cells = <1>;
+		#size-cells = <2>;
+		#address-cells = <3>;
+		compatible = "fsl,mpc8540-pcix", "fsl,mpc8540-pci";
+		device_type = "pci";
+		reg = <0xe0008000 0x1000>;
+		clock-frequency = <66666666>;
+		interrupt-map-mask = <0xf800 0x0 0x0 0x7>;
+		interrupt-map = <
+				/* IDSEL 28 */
+				 0xe000 0 0 1 &mpic 2 1
+				 0xe000 0 0 2 &mpic 3 1>;
+
+		interrupt-parent = <&mpic>;
+		interrupts = <24 2>;
+		bus-range = <0 0>;
+		ranges = <0x02000000 0 0x80000000 0x80000000 0 0x20000000
+			  0x01000000 0 0x00000000 0xe2000000 0 0x01000000>;
+	};
+};
diff --git a/arch/powerpc/boot/dts/tqm8560.dts b/arch/powerpc/boot/dts/tqm8560.dts
new file mode 100644
index 0000000..8ca7fdd
--- /dev/null
+++ b/arch/powerpc/boot/dts/tqm8560.dts
@@ -0,0 +1,245 @@
+/*
+ * TQM 8560 Device Tree Source
+ *
+ * Copyright 2008 Freescale Semiconductor Inc.
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
+	model = "tqm,8560";
+	compatible = "tqm,8560", "tqm,85xx";
+	#address-cells = <1>;
+	#size-cells = <1>;
+
+	aliases {
+		ethernet0 = &enet0;
+		ethernet1 = &enet1;
+		ethernet2 = &enet2;
+		serial0 = &serial0;
+		serial1 = &serial1;
+		pci0 = &pci0;
+	};
+
+	cpus {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		PowerPC,8560@0 {
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
+		reg = <0x00000000 0x10000000>;
+	};
+
+	soc8560@e0000000 {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		device_type = "soc";
+		ranges = <0x0 0xe0000000 0x100000>;
+		reg = <0xe0000000 0x200>;
+		bus-frequency = <0>;
+		compatible = "fsl,mpc8560-immr", "simple-bus";
+
+		memory-controller@2000 {
+			compatible = "fsl,8540-memory-controller";
+			reg = <0x2000 0x1000>;
+			interrupt-parent = <&mpic>;
+			interrupts = <18 2>;
+		};
+
+		l2-cache-controller@20000 {
+			compatible = "fsl,8540-l2-cache-controller";
+			reg = <0x20000 0x1000>;
+			cache-line-size = <32>;
+			cache-size = <0x40000>;	// L2, 256K
+			interrupt-parent = <&mpic>;
+			interrupts = <16 2>;
+		};
+
+		i2c@3000 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			cell-index = <0>;
+			compatible = "fsl-i2c";
+			reg = <0x3000 0x100>;
+			interrupts = <43 2>;
+			interrupt-parent = <&mpic>;
+			dfsrr;
+
+			rtc@68 {
+				compatible = "dallas,ds1337";
+				reg = <0x68>;
+			};
+		};
+
+		mdio@24520 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			compatible = "fsl,gianfar-mdio";
+			reg = <0x24520 0x20>;
+
+			phy1: ethernet-phy@1 {
+				interrupt-parent = <&mpic>;
+				interrupts = <8 1>;
+				reg = <1>;
+				device_type = "ethernet-phy";
+			};
+			phy2: ethernet-phy@2 {
+				interrupt-parent = <&mpic>;
+				interrupts = <8 1>;
+				reg = <2>;
+				device_type = "ethernet-phy";
+			};
+			phy3: ethernet-phy@3 {
+				interrupt-parent = <&mpic>;
+				interrupts = <8 1>;
+				reg = <3>;
+				device_type = "ethernet-phy";
+			};
+		};
+
+		enet0: ethernet@24000 {
+			cell-index = <0>;
+			device_type = "network";
+			model = "TSEC";
+			compatible = "gianfar";
+			reg = <0x24000 0x1000>;
+			local-mac-address = [ 00 00 00 00 00 00 ];
+			interrupts = <29 2 30 2 34 2>;
+			interrupt-parent = <&mpic>;
+			phy-handle = <&phy2>;
+		};
+
+		enet1: ethernet@25000 {
+			cell-index = <1>;
+			device_type = "network";
+			model = "TSEC";
+			compatible = "gianfar";
+			reg = <0x25000 0x1000>;
+			local-mac-address = [ 00 00 00 00 00 00 ];
+			interrupts = <35 2 36 2 40 2>;
+			interrupt-parent = <&mpic>;
+			phy-handle = <&phy1>;
+		};
+
+		mpic: pic@40000 {
+			interrupt-controller;
+			#address-cells = <0>;
+			#interrupt-cells = <2>;
+			reg = <0x40000 0x40000>;
+			device_type = "open-pic";
+		};
+
+		cpm@919c0 {
+			#address-cells = <1>;
+			#size-cells = <1>;
+			compatible = "fsl,mpc8560-cpm", "fsl,cpm2", "simple-bus";
+			reg = <0x919c0 0x30>;
+			ranges;
+
+			muram@80000 {
+				#address-cells = <1>;
+				#size-cells = <1>;
+				ranges = <0 0x80000 0x10000>;
+
+				data@0 {
+					compatible = "fsl,cpm-muram-data";
+					reg = <0 0x4000 0x9000 0x2000>;
+				};
+			};
+
+			brg@919f0 {
+				compatible = "fsl,mpc8560-brg",
+				             "fsl,cpm2-brg",
+				             "fsl,cpm-brg";
+				reg = <0x919f0 0x10 0x915f0 0x10>;
+				clock-frequency = <0>;
+			};
+
+			cpmpic: pic@90c00 {
+				interrupt-controller;
+				#address-cells = <0>;
+				#interrupt-cells = <2>;
+				interrupts = <46 2>;
+				interrupt-parent = <&mpic>;
+				reg = <0x90c00 0x80>;
+				compatible = "fsl,mpc8560-cpm-pic", "fsl,cpm2-pic";
+			};
+
+			serial0: serial@91a00 {
+				device_type = "serial";
+				compatible = "fsl,mpc8560-scc-uart",
+				             "fsl,cpm2-scc-uart";
+				reg = <0x91a00 0x20 0x88000 0x100>;
+				fsl,cpm-brg = <1>;
+				fsl,cpm-command = <0x800000>;
+				current-speed = <115200>;
+				interrupts = <40 8>;
+				interrupt-parent = <&cpmpic>;
+			};
+
+			serial1: serial@91a20 {
+				device_type = "serial";
+				compatible = "fsl,mpc8560-scc-uart",
+				             "fsl,cpm2-scc-uart";
+				reg = <0x91a20 0x20 0x88100 0x100>;
+				fsl,cpm-brg = <2>;
+				fsl,cpm-command = <0x4a00000>;
+				current-speed = <115200>;
+				interrupts = <41 8>;
+				interrupt-parent = <&cpmpic>;
+			};
+
+			enet2: ethernet@91340 {
+				device_type = "network";
+				compatible = "fsl,mpc8560-fcc-enet",
+				             "fsl,cpm2-fcc-enet";
+				reg = <0x91340 0x20 0x88600 0x100 0x913d0 0x1>;
+				local-mac-address = [ 00 00 00 00 00 00 ];
+				fsl,cpm-command = <0x1a400300>;
+				interrupts = <34 8>;
+				interrupt-parent = <&cpmpic>;
+				phy-handle = <&phy3>;
+			};
+		};
+	};
+
+	pci0: pci@e0008000 {
+		cell-index = <0>;
+		#interrupt-cells = <1>;
+		#size-cells = <2>;
+		#address-cells = <3>;
+		compatible = "fsl,mpc8540-pcix", "fsl,mpc8540-pci";
+		device_type = "pci";
+		reg = <0xe0008000 0x1000>;
+		clock-frequency = <66666666>;
+		interrupt-map-mask = <0xf800 0x0 0x0 0x7>;
+		interrupt-map = <
+				/* IDSEL 28 */
+				 0xe000 0 0 1 &mpic 2 1
+				 0xe000 0 0 2 &mpic 3 1>;
+
+		interrupt-parent = <&mpic>;
+		interrupts = <24 2>;
+		bus-range = <0 0>;
+		ranges = <0x02000000 0 0x80000000 0x80000000 0 0x20000000
+			  0x01000000 0 0x00000000 0xe2000000 0 0x01000000>;
+	};
+};
diff --git a/arch/powerpc/platforms/85xx/Kconfig b/arch/powerpc/platforms/85xx/Kconfig
index 26f9cd5..7896f06 100644
--- a/arch/powerpc/platforms/85xx/Kconfig
+++ b/arch/powerpc/platforms/85xx/Kconfig
@@ -46,8 +46,47 @@ config STX_GP3
 	select DEFAULT_UIMAGE
 	select PPC_CPM_NEW_BINDING

+config TQM8540
+	bool "TQ Components TQM8540"
+	help
+	  This option enables support for the TQ Components TQM8540 board.
+	select DEFAULT_UIMAGE
+	select PPC_CPM_NEW_BINDING
+	select TQM85xx
+
+config TQM8541
+	bool "TQ Components TQM8541"
+	help
+	  This option enables support for the TQ Components TQM8541 board.
+	select DEFAULT_UIMAGE
+	select PPC_CPM_NEW_BINDING
+	select TQM85xx
+	select CPM2
+
+config TQM8555
+	bool "TQ Components TQM8555"
+	help
+	  This option enables support for the TQ Components TQM8555 board.
+	select DEFAULT_UIMAGE
+	select PPC_CPM_NEW_BINDING
+	select TQM85xx
+	select CPM2
+
+config TQM8560
+	bool "TQ Components TQM8560"
+	help
+	  This option enables support for the TQ Components TQM8560 board.
+	select DEFAULT_UIMAGE
+	select PPC_CPM_NEW_BINDING
+	select TQM85xx
+	select CPM2
+
 endchoice

+config TQM85xx
+	bool
+	select MPC85xx
+
 config MPC8540
 	bool
 	select PPC_UDBG_16550
diff --git a/arch/powerpc/platforms/85xx/Makefile b/arch/powerpc/platforms/85xx/Makefile
index bf7d2e1..8c761d1 100644
--- a/arch/powerpc/platforms/85xx/Makefile
+++ b/arch/powerpc/platforms/85xx/Makefile
@@ -7,3 +7,4 @@ obj-$(CONFIG_MPC85xx_CDS) += mpc85xx_cds.o
 obj-$(CONFIG_MPC85xx_DS)  += mpc85xx_ds.o
 obj-$(CONFIG_MPC85xx_MDS) += mpc85xx_mds.o
 obj-$(CONFIG_STX_GP3)	  += stx_gp3.o
+obj-$(CONFIG_TQM85xx)	  += tqm85xx.o
diff --git a/arch/powerpc/platforms/85xx/tqm85xx.c b/arch/powerpc/platforms/85xx/tqm85xx.c
new file mode 100644
index 0000000..2a08b31
--- /dev/null
+++ b/arch/powerpc/platforms/85xx/tqm85xx.c
@@ -0,0 +1,191 @@
+/*
+ * Based on MPC8560 ADS and arch/ppc tqm85xx ports
+ *
+ * Maintained by Kumar Gala (see MAINTAINERS for contact information)
+ *
+ * Copyright 2008 Freescale Semiconductor Inc.
+ *
+ * Copyright (c) 2005-2006 DENX Software Engineering
+ * Stefan Roese <sr@denx.de>
+ *
+ * Based on original work by
+ * 	Kumar Gala <kumar.gala@freescale.com>
+ *      Copyright 2004 Freescale Semiconductor Inc.
+ *
+ * This program is free software; you can redistribute  it and/or modify it
+ * under  the terms of  the GNU General  Public License as published by the
+ * Free Software Foundation;  either version 2 of the  License, or (at your
+ * option) any later version.
+ */
+
+#include <linux/stddef.h>
+#include <linux/kernel.h>
+#include <linux/pci.h>
+#include <linux/kdev_t.h>
+#include <linux/delay.h>
+#include <linux/seq_file.h>
+#include <linux/of_platform.h>
+
+#include <asm/system.h>
+#include <asm/time.h>
+#include <asm/machdep.h>
+#include <asm/pci-bridge.h>
+#include <asm/mpic.h>
+#include <asm/prom.h>
+#include <mm/mmu_decl.h>
+#include <asm/udbg.h>
+
+#include <sysdev/fsl_soc.h>
+#include <sysdev/fsl_pci.h>
+
+#ifdef CONFIG_CPM2
+#include <asm/cpm2.h>
+#include <sysdev/cpm2_pic.h>
+
+static void cpm2_cascade(unsigned int irq, struct irq_desc *desc)
+{
+	int cascade_irq;
+
+	while ((cascade_irq = cpm2_get_irq()) >= 0)
+		generic_handle_irq(cascade_irq);
+
+	desc->chip->eoi(irq);
+}
+#endif /* CONFIG_CPM2 */
+
+static void __init tqm85xx_pic_init(void)
+{
+	struct mpic *mpic;
+	struct resource r;
+	struct device_node *np;
+#ifdef CONFIG_CPM2
+	int irq;
+#endif
+
+	np = of_find_node_by_type(NULL, "open-pic");
+	if (!np) {
+		printk(KERN_ERR "Could not find open-pic node\n");
+		return;
+	}
+
+	if (of_address_to_resource(np, 0, &r)) {
+		printk(KERN_ERR "Could not map mpic register space\n");
+		of_node_put(np);
+		return;
+	}
+
+	mpic = mpic_alloc(np, r.start,
+			MPIC_PRIMARY | MPIC_WANTS_RESET | MPIC_BIG_ENDIAN,
+			0, 256, " OpenPIC  ");
+	BUG_ON(mpic == NULL);
+	of_node_put(np);
+
+	mpic_init(mpic);
+
+#ifdef CONFIG_CPM2
+	/* Setup CPM2 PIC */
+	np = of_find_compatible_node(NULL, NULL, "fsl,cpm2-pic");
+	if (np == NULL) {
+		printk(KERN_ERR "PIC init: can not find fsl,cpm2-pic node\n");
+		return;
+	}
+	irq = irq_of_parse_and_map(np, 0);
+
+	if (irq == NO_IRQ) {
+		of_node_put(np);
+		printk(KERN_ERR "PIC init: got no IRQ for cpm cascade\n");
+		return;
+	}
+
+	cpm2_pic_init(np);
+	of_node_put(np);
+	set_irq_chained_handler(irq, cpm2_cascade);
+#endif
+}
+
+/*
+ * Setup the architecture
+ */
+static void __init tqm85xx_setup_arch(void)
+{
+#ifdef CONFIG_PCI
+	struct device_node *np;
+#endif
+
+	if (ppc_md.progress)
+		ppc_md.progress("tqm85xx_setup_arch()", 0);
+
+#ifdef CONFIG_CPM2
+	cpm2_reset();
+#endif
+
+#ifdef CONFIG_PCI
+	for_each_compatible_node(np, "pci", "fsl,mpc8540-pci")
+		fsl_add_bridge(np, 1);
+#endif
+}
+
+static void tqm85xx_show_cpuinfo(struct seq_file *m)
+{
+	uint pvid, svid, phid1;
+	uint memsize = total_memory;
+
+	pvid = mfspr(SPRN_PVR);
+	svid = mfspr(SPRN_SVR);
+
+	seq_printf(m, "Vendor\t\t: TQ Components\n");
+	seq_printf(m, "PVR\t\t: 0x%x\n", pvid);
+	seq_printf(m, "SVR\t\t: 0x%x\n", svid);
+
+	/* Display cpu Pll setting */
+	phid1 = mfspr(SPRN_HID1);
+	seq_printf(m, "PLL setting\t: 0x%x\n", ((phid1 >> 24) & 0x3f));
+
+	/* Display the amount of memory */
+	seq_printf(m, "Memory\t\t: %d MB\n", memsize / (1024 * 1024));
+}
+
+static struct of_device_id __initdata of_bus_ids[] = {
+	{ .name = "soc", },
+	{ .type = "soc", },
+	{ .name = "cpm", },
+	{ .name = "localbus", },
+	{ .compatible = "simple-bus", },
+	{},
+};
+
+static int __init declare_of_platform_devices(void)
+{
+	of_platform_bus_probe(NULL, of_bus_ids, NULL);
+
+	return 0;
+}
+machine_device_initcall(tqm85xx, declare_of_platform_devices);
+
+/*
+ * Called very early, device-tree isn't unflattened
+ */
+static int __init tqm85xx_probe(void)
+{
+	unsigned long root = of_get_flat_dt_root();
+
+	if ((of_flat_dt_is_compatible(root, "tqm,8540")) ||
+	    (of_flat_dt_is_compatible(root, "tqm,8541")) ||
+	    (of_flat_dt_is_compatible(root, "tqm,8555")) ||
+	    (of_flat_dt_is_compatible(root, "tqm,8560")))
+		return 1;
+
+	return 0;
+}
+
+define_machine(tqm85xx) {
+	.name			= "TQM85xx",
+	.probe			= tqm85xx_probe,
+	.setup_arch		= tqm85xx_setup_arch,
+	.init_IRQ		= tqm85xx_pic_init,
+	.show_cpuinfo		= tqm85xx_show_cpuinfo,
+	.get_irq		= mpic_get_irq,
+	.restart		= fsl_rstcr_restart,
+	.calibrate_decr		= generic_calibrate_decr,
+	.progress		= udbg_progress,
+};
-- 
1.5.3.7

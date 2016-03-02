Return-Path: <alessio.bogani@elettra.eu>
Received: from elettra.eu (m1.elettra.trieste.it [140.105.206.201])
 by lists.ozlabs.org (Postfix) with ESMTP id 283AB1A0B51
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  2 Mar 2016 21:50:54 +1100 (AEDT)
From: Alessio Igor Bogani <alessio.bogani@elettra.eu>
To: Scott Wood <oss@buserror.net>,
	Kumar Gala <galak@kernel.crashing.org>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 Alessio Igor Bogani <alessio.bogani@elettra.eu>
Subject: [RFC PATCH v2 1/3] powerpc/86xx: Move dts files to fsl directory
Date: Wed,  2 Mar 2016 11:50:46 +0100
Message-Id: <1456915848-18868-1-git-send-email-alessio.bogani@elettra.eu>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Signed-off-by: Alessio Igor Bogani <alessio.bogani@elettra.eu>
---
v1 -> v2
    Address suggestion made by Scott Wood
          Split the second patch in two
          Don't remove "fsl,mpic" which it is required for 4-cell
            interrupt specifiers
          Remove pointless compatible in the dtsi
          Use the right value for pcie clock-frequency (100 Mhz)

 arch/powerpc/boot/dts/fsl/gef_ppc9a.dts        | 425 ++++++++++++++++
 arch/powerpc/boot/dts/fsl/gef_sbc310.dts       | 459 +++++++++++++++++
 arch/powerpc/boot/dts/fsl/gef_sbc610.dts       | 423 ++++++++++++++++
 arch/powerpc/boot/dts/fsl/mpc8641_hpcn.dts     | 663 +++++++++++++++++++++++++
 arch/powerpc/boot/dts/fsl/mpc8641_hpcn_36b.dts | 605 ++++++++++++++++++++++
 arch/powerpc/boot/dts/fsl/sbc8641d.dts         | 447 +++++++++++++++++
 arch/powerpc/boot/dts/gef_ppc9a.dts            | 425 ----------------
 arch/powerpc/boot/dts/gef_sbc310.dts           | 459 -----------------
 arch/powerpc/boot/dts/gef_sbc610.dts           | 423 ----------------
 arch/powerpc/boot/dts/mpc8641_hpcn.dts         | 663 -------------------------
 arch/powerpc/boot/dts/mpc8641_hpcn_36b.dts     | 605 ----------------------
 arch/powerpc/boot/dts/sbc8641d.dts             | 447 -----------------
 12 files changed, 3022 insertions(+), 3022 deletions(-)
 create mode 100644 arch/powerpc/boot/dts/fsl/gef_ppc9a.dts
 create mode 100644 arch/powerpc/boot/dts/fsl/gef_sbc310.dts
 create mode 100644 arch/powerpc/boot/dts/fsl/gef_sbc610.dts
 create mode 100644 arch/powerpc/boot/dts/fsl/mpc8641_hpcn.dts
 create mode 100644 arch/powerpc/boot/dts/fsl/mpc8641_hpcn_36b.dts
 create mode 100644 arch/powerpc/boot/dts/fsl/sbc8641d.dts
 delete mode 100644 arch/powerpc/boot/dts/gef_ppc9a.dts
 delete mode 100644 arch/powerpc/boot/dts/gef_sbc310.dts
 delete mode 100644 arch/powerpc/boot/dts/gef_sbc610.dts
 delete mode 100644 arch/powerpc/boot/dts/mpc8641_hpcn.dts
 delete mode 100644 arch/powerpc/boot/dts/mpc8641_hpcn_36b.dts
 delete mode 100644 arch/powerpc/boot/dts/sbc8641d.dts

diff --git a/arch/powerpc/boot/dts/fsl/gef_ppc9a.dts b/arch/powerpc/boot/dts/fsl/gef_ppc9a.dts
new file mode 100644
index 0000000..83eb0fd
--- /dev/null
+++ b/arch/powerpc/boot/dts/fsl/gef_ppc9a.dts
@@ -0,0 +1,425 @@
+/*
+ * GE PPC9A Device Tree Source
+ *
+ * Copyright 2008 GE Intelligent Platforms Embedded Systems, Inc.
+ *
+ * This program is free software; you can redistribute  it and/or modify it
+ * under  the terms of  the GNU General  Public License as published by the
+ * Free Software Foundation;  either version 2 of the  License, or (at your
+ * option) any later version.
+ *
+ * Based on: SBS CM6 Device Tree Source
+ * Copyright 2007 SBS Technologies GmbH & Co. KG
+ * And: mpc8641_hpcn.dts (MPC8641 HPCN Device Tree Source)
+ * Copyright 2006 Freescale Semiconductor Inc.
+ */
+
+/*
+ * Compiled with dtc -I dts -O dtb -o gef_ppc9a.dtb gef_ppc9a.dts
+ */
+
+/dts-v1/;
+
+/ {
+	model = "GEF_PPC9A";
+	compatible = "gef,ppc9a";
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
+		PowerPC,8641@0 {
+			device_type = "cpu";
+			reg = <0>;
+			d-cache-line-size = <32>;	// 32 bytes
+			i-cache-line-size = <32>;	// 32 bytes
+			d-cache-size = <32768>;		// L1, 32K
+			i-cache-size = <32768>;		// L1, 32K
+			timebase-frequency = <0>;	// From uboot
+			bus-frequency = <0>;		// From uboot
+			clock-frequency = <0>;		// From uboot
+		};
+		PowerPC,8641@1 {
+			device_type = "cpu";
+			reg = <1>;
+			d-cache-line-size = <32>;	// 32 bytes
+			i-cache-line-size = <32>;	// 32 bytes
+			d-cache-size = <32768>;		// L1, 32K
+			i-cache-size = <32768>;		// L1, 32K
+			timebase-frequency = <0>;	// From uboot
+			bus-frequency = <0>;		// From uboot
+			clock-frequency = <0>;		// From uboot
+		};
+	};
+
+	memory {
+		device_type = "memory";
+		reg = <0x0 0x40000000>;	// set by uboot
+	};
+
+	localbus@fef05000 {
+		#address-cells = <2>;
+		#size-cells = <1>;
+		compatible = "fsl,mpc8641-localbus", "simple-bus";
+		reg = <0xfef05000 0x1000>;
+		interrupts = <19 2>;
+		interrupt-parent = <&mpic>;
+
+		ranges = <0 0 0xff000000 0x01000000	// 16MB Boot flash
+			  1 0 0xe8000000 0x08000000	// Paged Flash 0
+			  2 0 0xe0000000 0x08000000	// Paged Flash 1
+			  3 0 0xfc100000 0x00020000	// NVRAM
+			  4 0 0xfc000000 0x00008000	// FPGA
+			  5 0 0xfc008000 0x00008000	// AFIX FPGA
+			  6 0 0xfd000000 0x00800000	// IO FPGA (8-bit)
+			  7 0 0xfd800000 0x00800000>;	// IO FPGA (32-bit)
+
+		/* flash@0,0 is a mirror of part of the memory in flash@1,0
+		flash@0,0 {
+			compatible = "gef,ppc9a-firmware-mirror", "cfi-flash";
+			reg = <0x0 0x0 0x1000000>;
+			bank-width = <4>;
+			device-width = <2>;
+			#address-cells = <1>;
+			#size-cells = <1>;
+			partition@0 {
+				label = "firmware";
+				reg = <0x0 0x1000000>;
+				read-only;
+			};
+		};
+		*/
+
+		flash@1,0 {
+			compatible = "gef,ppc9a-paged-flash", "cfi-flash";
+			reg = <0x1 0x0 0x8000000>;
+			bank-width = <4>;
+			device-width = <2>;
+			#address-cells = <1>;
+			#size-cells = <1>;
+			partition@0 {
+				label = "user";
+				reg = <0x0 0x7800000>;
+			};
+			partition@7800000 {
+				label = "firmware";
+				reg = <0x7800000 0x800000>;
+				read-only;
+			};
+		};
+
+		nvram@3,0 {
+			device_type = "nvram";
+			compatible = "simtek,stk14ca8";
+			reg = <0x3 0x0 0x20000>;
+		};
+
+		fpga@4,0 {
+			compatible = "gef,ppc9a-fpga-regs";
+			reg = <0x4 0x0 0x40>;
+		};
+
+		wdt@4,2000 {
+			compatible = "gef,ppc9a-fpga-wdt", "gef,fpga-wdt-1.00",
+				"gef,fpga-wdt";
+			reg = <0x4 0x2000 0x8>;
+			interrupts = <0x1a 0x4>;
+			interrupt-parent = <&gef_pic>;
+		};
+		/* Second watchdog available, driver currently supports one.
+		wdt@4,2010 {
+			compatible = "gef,ppc9a-fpga-wdt", "gef,fpga-wdt-1.00",
+				"gef,fpga-wdt";
+			reg = <0x4 0x2010 0x8>;
+			interrupts = <0x1b 0x4>;
+			interrupt-parent = <&gef_pic>;
+		};
+		*/
+		gef_pic: pic@4,4000 {
+			#interrupt-cells = <1>;
+			interrupt-controller;
+			compatible = "gef,ppc9a-fpga-pic", "gef,fpga-pic-1.00";
+			reg = <0x4 0x4000 0x20>;
+			interrupts = <0x8
+				      0x9>;
+			interrupt-parent = <&mpic>;
+
+		};
+		gef_gpio: gpio@7,14000 {
+			#gpio-cells = <2>;
+			compatible = "gef,ppc9a-gpio", "gef,sbc610-gpio";
+			reg = <0x7 0x14000 0x24>;
+			gpio-controller;
+		};
+	};
+
+	soc@fef00000 {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		#interrupt-cells = <2>;
+		device_type = "soc";
+		compatible = "fsl,mpc8641-soc", "simple-bus";
+		ranges = <0x0 0xfef00000 0x00100000>;
+		bus-frequency = <33333333>;
+
+		mcm-law@0 {
+			compatible = "fsl,mcm-law";
+			reg = <0x0 0x1000>;
+			fsl,num-laws = <10>;
+		};
+
+		mcm@1000 {
+			compatible = "fsl,mpc8641-mcm", "fsl,mcm";
+			reg = <0x1000 0x1000>;
+			interrupts = <17 2>;
+			interrupt-parent = <&mpic>;
+		};
+
+		i2c1: i2c@3000 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			compatible = "fsl-i2c";
+			reg = <0x3000 0x100>;
+			interrupts = <0x2b 0x2>;
+			interrupt-parent = <&mpic>;
+			dfsrr;
+
+			hwmon@48 {
+				compatible = "national,lm92";
+				reg = <0x48>;
+			};
+
+			hwmon@4c {
+				compatible = "adi,adt7461";
+				reg = <0x4c>;
+			};
+
+			rtc@51 {
+				compatible = "epson,rx8581";
+				reg = <0x00000051>;
+			};
+
+			eti@6b {
+				compatible = "dallas,ds1682";
+				reg = <0x6b>;
+			};
+		};
+
+		i2c2: i2c@3100 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			compatible = "fsl-i2c";
+			reg = <0x3100 0x100>;
+			interrupts = <0x2b 0x2>;
+			interrupt-parent = <&mpic>;
+			dfsrr;
+		};
+
+		dma@21300 {
+			#address-cells = <1>;
+			#size-cells = <1>;
+			compatible = "fsl,mpc8641-dma", "fsl,eloplus-dma";
+			reg = <0x21300 0x4>;
+			ranges = <0x0 0x21100 0x200>;
+			cell-index = <0>;
+			dma-channel@0 {
+				compatible = "fsl,mpc8641-dma-channel",
+					   "fsl,eloplus-dma-channel";
+				reg = <0x0 0x80>;
+				cell-index = <0>;
+				interrupt-parent = <&mpic>;
+				interrupts = <20 2>;
+			};
+			dma-channel@80 {
+				compatible = "fsl,mpc8641-dma-channel",
+					   "fsl,eloplus-dma-channel";
+				reg = <0x80 0x80>;
+				cell-index = <1>;
+				interrupt-parent = <&mpic>;
+				interrupts = <21 2>;
+			};
+			dma-channel@100 {
+				compatible = "fsl,mpc8641-dma-channel",
+					   "fsl,eloplus-dma-channel";
+				reg = <0x100 0x80>;
+				cell-index = <2>;
+				interrupt-parent = <&mpic>;
+				interrupts = <22 2>;
+			};
+			dma-channel@180 {
+				compatible = "fsl,mpc8641-dma-channel",
+					   "fsl,eloplus-dma-channel";
+				reg = <0x180 0x80>;
+				cell-index = <3>;
+				interrupt-parent = <&mpic>;
+				interrupts = <23 2>;
+			};
+		};
+
+		enet0: ethernet@24000 {
+			#address-cells = <1>;
+			#size-cells = <1>;
+			cell-index = <0>;
+			device_type = "network";
+			model = "TSEC";
+			compatible = "gianfar";
+			reg = <0x24000 0x1000>;
+			ranges = <0x0 0x24000 0x1000>;
+			local-mac-address = [ 00 00 00 00 00 00 ];
+			interrupts = <29 2 30  2 34 2>;
+			interrupt-parent = <&mpic>;
+			tbi-handle = <&tbi0>;
+			phy-handle = <&phy0>;
+			phy-connection-type = "gmii";
+
+			mdio@520 {
+				#address-cells = <1>;
+				#size-cells = <0>;
+				compatible = "fsl,gianfar-mdio";
+				reg = <0x520 0x20>;
+
+				phy0: ethernet-phy@0 {
+					interrupt-parent = <&gef_pic>;
+					interrupts = <0x9 0x4>;
+					reg = <1>;
+				};
+				phy2: ethernet-phy@2 {
+					interrupt-parent = <&gef_pic>;
+					interrupts = <0x8 0x4>;
+					reg = <3>;
+				};
+				tbi0: tbi-phy@11 {
+					reg = <0x11>;
+					device_type = "tbi-phy";
+				};
+			};
+		};
+
+		enet1: ethernet@26000 {
+			#address-cells = <1>;
+			#size-cells = <1>;
+			cell-index = <2>;
+			device_type = "network";
+			model = "TSEC";
+			compatible = "gianfar";
+			reg = <0x26000 0x1000>;
+			ranges = <0x0 0x26000 0x1000>;
+			local-mac-address = [ 00 00 00 00 00 00 ];
+			interrupts = <31 2 32 2 33 2>;
+			interrupt-parent = <&mpic>;
+			tbi-handle = <&tbi2>;
+			phy-handle = <&phy2>;
+			phy-connection-type = "gmii";
+
+			mdio@520 {
+				#address-cells = <1>;
+				#size-cells = <0>;
+				compatible = "fsl,gianfar-tbi";
+				reg = <0x520 0x20>;
+
+				tbi2: tbi-phy@11 {
+					reg = <0x11>;
+					device_type = "tbi-phy";
+				};
+			};
+		};
+
+		serial0: serial@4500 {
+			cell-index = <0>;
+			device_type = "serial";
+			compatible = "fsl,ns16550", "ns16550";
+			reg = <0x4500 0x100>;
+			clock-frequency = <0>;
+			interrupts = <0x2a 0x2>;
+			interrupt-parent = <&mpic>;
+		};
+
+		serial1: serial@4600 {
+			cell-index = <1>;
+			device_type = "serial";
+			compatible = "fsl,ns16550", "ns16550";
+			reg = <0x4600 0x100>;
+			clock-frequency = <0>;
+			interrupts = <0x1c 0x2>;
+			interrupt-parent = <&mpic>;
+		};
+
+		mpic: pic@40000 {
+			clock-frequency = <0>;
+			interrupt-controller;
+			#address-cells = <0>;
+			#interrupt-cells = <2>;
+			reg = <0x40000 0x40000>;
+			compatible = "chrp,open-pic";
+			device_type = "open-pic";
+		};
+
+		msi@41600 {
+			compatible = "fsl,mpc8641-msi", "fsl,mpic-msi";
+			reg = <0x41600 0x80>;
+			msi-available-ranges = <0 0x100>;
+			interrupts = <
+				0xe0 0
+				0xe1 0
+				0xe2 0
+				0xe3 0
+				0xe4 0
+				0xe5 0
+				0xe6 0
+				0xe7 0>;
+			interrupt-parent = <&mpic>;
+		};
+
+		global-utilities@e0000 {
+			compatible = "fsl,mpc8641-guts";
+			reg = <0xe0000 0x1000>;
+			fsl,has-rstcr;
+		};
+	};
+
+	pci0: pcie@fef08000 {
+		compatible = "fsl,mpc8641-pcie";
+		device_type = "pci";
+		#interrupt-cells = <1>;
+		#size-cells = <2>;
+		#address-cells = <3>;
+		reg = <0xfef08000 0x1000>;
+		bus-range = <0x0 0xff>;
+		ranges = <0x02000000 0x0 0x80000000 0x80000000 0x0 0x40000000
+			  0x01000000 0x0 0x00000000 0xfe000000 0x0 0x00400000>;
+		clock-frequency = <33333333>;
+		interrupt-parent = <&mpic>;
+		interrupts = <0x18 0x2>;
+		interrupt-map-mask = <0xf800 0x0 0x0 0x7>;
+		interrupt-map = <
+			0x0000 0x0 0x0 0x1 &mpic 0x0 0x1
+			0x0000 0x0 0x0 0x2 &mpic 0x1 0x1
+			0x0000 0x0 0x0 0x3 &mpic 0x2 0x1
+			0x0000 0x0 0x0 0x4 &mpic 0x3 0x1
+		>;
+
+		pcie@0 {
+			reg = <0 0 0 0 0>;
+			#size-cells = <2>;
+			#address-cells = <3>;
+			device_type = "pci";
+			ranges = <0x02000000 0x0 0x80000000
+				  0x02000000 0x0 0x80000000
+				  0x0 0x40000000
+
+				  0x01000000 0x0 0x00000000
+				  0x01000000 0x0 0x00000000
+				  0x0 0x00400000>;
+		};
+	};
+};
diff --git a/arch/powerpc/boot/dts/fsl/gef_sbc310.dts b/arch/powerpc/boot/dts/fsl/gef_sbc310.dts
new file mode 100644
index 0000000..d426dd3
--- /dev/null
+++ b/arch/powerpc/boot/dts/fsl/gef_sbc310.dts
@@ -0,0 +1,459 @@
+/*
+ * GE SBC310 Device Tree Source
+ *
+ * Copyright 2008 GE Intelligent Platforms Embedded Systems, Inc.
+ *
+ * This program is free software; you can redistribute  it and/or modify it
+ * under  the terms of  the GNU General  Public License as published by the
+ * Free Software Foundation;  either version 2 of the  License, or (at your
+ * option) any later version.
+ *
+ * Based on: SBS CM6 Device Tree Source
+ * Copyright 2007 SBS Technologies GmbH & Co. KG
+ * And: mpc8641_hpcn.dts (MPC8641 HPCN Device Tree Source)
+ * Copyright 2006 Freescale Semiconductor Inc.
+ */
+
+/*
+ * Compiled with dtc -I dts -O dtb -o gef_sbc310.dtb gef_sbc310.dts
+ */
+
+/dts-v1/;
+
+/ {
+	model = "GEF_SBC310";
+	compatible = "gef,sbc310";
+	#address-cells = <1>;
+	#size-cells = <1>;
+
+	aliases {
+		ethernet0 = &enet0;
+		ethernet1 = &enet1;
+		serial0 = &serial0;
+		serial1 = &serial1;
+		pci0 = &pci0;
+		pci1 = &pci1;
+	};
+
+	cpus {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		PowerPC,8641@0 {
+			device_type = "cpu";
+			reg = <0>;
+			d-cache-line-size = <32>;	// 32 bytes
+			i-cache-line-size = <32>;	// 32 bytes
+			d-cache-size = <32768>;		// L1, 32K
+			i-cache-size = <32768>;		// L1, 32K
+			timebase-frequency = <0>;	// From uboot
+			bus-frequency = <0>;		// From uboot
+			clock-frequency = <0>;		// From uboot
+		};
+		PowerPC,8641@1 {
+			device_type = "cpu";
+			reg = <1>;
+			d-cache-line-size = <32>;	// 32 bytes
+			i-cache-line-size = <32>;	// 32 bytes
+			d-cache-size = <32768>;		// L1, 32K
+			i-cache-size = <32768>;		// L1, 32K
+			timebase-frequency = <0>;	// From uboot
+			bus-frequency = <0>;		// From uboot
+			clock-frequency = <0>;		// From uboot
+		};
+	};
+
+	memory {
+		device_type = "memory";
+		reg = <0x0 0x40000000>;	// set by uboot
+	};
+
+	localbus@fef05000 {
+		#address-cells = <2>;
+		#size-cells = <1>;
+		compatible = "fsl,mpc8641-localbus", "simple-bus";
+		reg = <0xfef05000 0x1000>;
+		interrupts = <19 2>;
+		interrupt-parent = <&mpic>;
+
+		ranges = <0 0 0xff000000 0x01000000	// 16MB Boot flash
+			  1 0 0xe0000000 0x08000000	// Paged Flash 0
+			  2 0 0xe8000000 0x08000000	// Paged Flash 1
+			  3 0 0xfc100000 0x00020000	// NVRAM
+			  4 0 0xfc000000 0x00010000>;	// FPGA
+
+		/* flash@0,0 is a mirror of part of the memory in flash@1,0
+		flash@0,0 {
+			compatible = "gef,sbc310-firmware-mirror", "cfi-flash";
+			reg = <0x0 0x0 0x01000000>;
+			bank-width = <2>;
+			device-width = <2>;
+			#address-cells = <1>;
+			#size-cells = <1>;
+			partition@0 {
+				label = "firmware";
+				reg = <0x0 0x01000000>;
+				read-only;
+			};
+		};
+		*/
+
+		flash@1,0 {
+			compatible = "gef,sbc310-paged-flash", "cfi-flash";
+			reg = <0x1 0x0 0x8000000>;
+			bank-width = <2>;
+			device-width = <2>;
+			#address-cells = <1>;
+			#size-cells = <1>;
+			partition@0 {
+				label = "user";
+				reg = <0x0 0x7800000>;
+			};
+			partition@7800000 {
+				label = "firmware";
+				reg = <0x7800000 0x800000>;
+				read-only;
+			};
+		};
+
+		nvram@3,0 {
+			device_type = "nvram";
+			compatible = "simtek,stk14ca8";
+			reg = <0x3 0x0 0x20000>;
+		};
+
+		fpga@4,0 {
+			compatible = "gef,fpga-regs";
+			reg = <0x4 0x0 0x40>;
+		};
+
+		wdt@4,2000 {
+			compatible = "gef,sbc310-fpga-wdt", "gef,fpga-wdt-1.00",
+				"gef,fpga-wdt";
+			reg = <0x4 0x2000 0x8>;
+			interrupts = <0x1a 0x4>;
+			interrupt-parent = <&gef_pic>;
+		};
+/*
+		wdt@4,2010 {
+			compatible = "gef,sbc310-fpga-wdt", "gef,fpga-wdt-1.00",
+				"gef,fpga-wdt";
+			reg = <0x4 0x2010 0x8>;
+			interrupts = <0x1b 0x4>;
+			interrupt-parent = <&gef_pic>;
+		};
+*/
+		gef_pic: pic@4,4000 {
+			#interrupt-cells = <1>;
+			interrupt-controller;
+			compatible = "gef,sbc310-fpga-pic", "gef,fpga-pic";
+			reg = <0x4 0x4000 0x20>;
+			interrupts = <0x8
+				      0x9>;
+			interrupt-parent = <&mpic>;
+
+		};
+		gef_gpio: gpio@4,8000 {
+			#gpio-cells = <2>;
+			compatible = "gef,sbc310-gpio";
+			reg = <0x4 0x8000 0x24>;
+			gpio-controller;
+		};
+	};
+
+	soc@fef00000 {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		#interrupt-cells = <2>;
+		device_type = "soc";
+		compatible = "fsl,mpc8641-soc", "simple-bus";
+		ranges = <0x0 0xfef00000 0x00100000>;
+		bus-frequency = <33333333>;
+
+		mcm-law@0 {
+			compatible = "fsl,mcm-law";
+			reg = <0x0 0x1000>;
+			fsl,num-laws = <10>;
+		};
+
+		mcm@1000 {
+			compatible = "fsl,mpc8641-mcm", "fsl,mcm";
+			reg = <0x1000 0x1000>;
+			interrupts = <17 2>;
+			interrupt-parent = <&mpic>;
+		};
+
+		i2c1: i2c@3000 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			compatible = "fsl-i2c";
+			reg = <0x3000 0x100>;
+			interrupts = <0x2b 0x2>;
+			interrupt-parent = <&mpic>;
+			dfsrr;
+
+			rtc@51 {
+				compatible = "epson,rx8581";
+				reg = <0x00000051>;
+			};
+		};
+
+		i2c2: i2c@3100 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			compatible = "fsl-i2c";
+			reg = <0x3100 0x100>;
+			interrupts = <0x2b 0x2>;
+			interrupt-parent = <&mpic>;
+			dfsrr;
+
+			hwmon@48 {
+				compatible = "national,lm92";
+				reg = <0x48>;
+			};
+
+			hwmon@4c {
+				compatible = "adi,adt7461";
+				reg = <0x4c>;
+			};
+
+			eti@6b {
+				compatible = "dallas,ds1682";
+				reg = <0x6b>;
+			};
+		};
+
+		dma@21300 {
+			#address-cells = <1>;
+			#size-cells = <1>;
+			compatible = "fsl,mpc8641-dma", "fsl,eloplus-dma";
+			reg = <0x21300 0x4>;
+			ranges = <0x0 0x21100 0x200>;
+			cell-index = <0>;
+			dma-channel@0 {
+				compatible = "fsl,mpc8641-dma-channel",
+					   "fsl,eloplus-dma-channel";
+				reg = <0x0 0x80>;
+				cell-index = <0>;
+				interrupt-parent = <&mpic>;
+				interrupts = <20 2>;
+			};
+			dma-channel@80 {
+				compatible = "fsl,mpc8641-dma-channel",
+					   "fsl,eloplus-dma-channel";
+				reg = <0x80 0x80>;
+				cell-index = <1>;
+				interrupt-parent = <&mpic>;
+				interrupts = <21 2>;
+			};
+			dma-channel@100 {
+				compatible = "fsl,mpc8641-dma-channel",
+					   "fsl,eloplus-dma-channel";
+				reg = <0x100 0x80>;
+				cell-index = <2>;
+				interrupt-parent = <&mpic>;
+				interrupts = <22 2>;
+			};
+			dma-channel@180 {
+				compatible = "fsl,mpc8641-dma-channel",
+					   "fsl,eloplus-dma-channel";
+				reg = <0x180 0x80>;
+				cell-index = <3>;
+				interrupt-parent = <&mpic>;
+				interrupts = <23 2>;
+			};
+		};
+
+		enet0: ethernet@24000 {
+			#address-cells = <1>;
+			#size-cells = <1>;
+			cell-index = <0>;
+			device_type = "network";
+			model = "TSEC";
+			compatible = "gianfar";
+			reg = <0x24000 0x1000>;
+			ranges = <0x0 0x24000 0x1000>;
+			local-mac-address = [ 00 00 00 00 00 00 ];
+			interrupts = <29 2 30  2 34 2>;
+			interrupt-parent = <&mpic>;
+			tbi-handle = <&tbi0>;
+			phy-handle = <&phy0>;
+			phy-connection-type = "gmii";
+
+			mdio@520 {
+				#address-cells = <1>;
+				#size-cells = <0>;
+				compatible = "fsl,gianfar-mdio";
+				reg = <0x520 0x20>;
+
+				phy0: ethernet-phy@0 {
+					interrupt-parent = <&gef_pic>;
+					interrupts = <0x9 0x4>;
+					reg = <1>;
+				};
+				phy2: ethernet-phy@2 {
+					interrupt-parent = <&gef_pic>;
+					interrupts = <0x8 0x4>;
+					reg = <3>;
+				};
+				tbi0: tbi-phy@11 {
+					reg = <0x11>;
+					device_type = "tbi-phy";
+				};
+			};
+		};
+
+		enet1: ethernet@26000 {
+			#address-cells = <1>;
+			#size-cells = <1>;
+			cell-index = <2>;
+			device_type = "network";
+			model = "TSEC";
+			compatible = "gianfar";
+			reg = <0x26000 0x1000>;
+			ranges = <0x0 0x26000 0x1000>;
+			local-mac-address = [ 00 00 00 00 00 00 ];
+			interrupts = <31 2 32 2 33 2>;
+			interrupt-parent = <&mpic>;
+			tbi-handle = <&tbi2>;
+			phy-handle = <&phy2>;
+			phy-connection-type = "gmii";
+
+			mdio@520 {
+				#address-cells = <1>;
+				#size-cells = <0>;
+				compatible = "fsl,gianfar-tbi";
+				reg = <0x520 0x20>;
+
+				tbi2: tbi-phy@11 {
+					reg = <0x11>;
+					device_type = "tbi-phy";
+				};
+			};
+		};
+
+		serial0: serial@4500 {
+			cell-index = <0>;
+			device_type = "serial";
+			compatible = "fsl,ns16550", "ns16550";
+			reg = <0x4500 0x100>;
+			clock-frequency = <0>;
+			interrupts = <0x2a 0x2>;
+			interrupt-parent = <&mpic>;
+		};
+
+		serial1: serial@4600 {
+			cell-index = <1>;
+			device_type = "serial";
+			compatible = "fsl,ns16550", "ns16550";
+			reg = <0x4600 0x100>;
+			clock-frequency = <0>;
+			interrupts = <0x1c 0x2>;
+			interrupt-parent = <&mpic>;
+		};
+
+		mpic: pic@40000 {
+			clock-frequency = <0>;
+			interrupt-controller;
+			#address-cells = <0>;
+			#interrupt-cells = <2>;
+			reg = <0x40000 0x40000>;
+			compatible = "chrp,open-pic";
+			device_type = "open-pic";
+		};
+
+		msi@41600 {
+			compatible = "fsl,mpc8641-msi", "fsl,mpic-msi";
+			reg = <0x41600 0x80>;
+			msi-available-ranges = <0 0x100>;
+			interrupts = <
+				0xe0 0
+				0xe1 0
+				0xe2 0
+				0xe3 0
+				0xe4 0
+				0xe5 0
+				0xe6 0
+				0xe7 0>;
+			interrupt-parent = <&mpic>;
+		};
+
+		global-utilities@e0000 {
+			compatible = "fsl,mpc8641-guts";
+			reg = <0xe0000 0x1000>;
+			fsl,has-rstcr;
+		};
+	};
+
+	pci0: pcie@fef08000 {
+		compatible = "fsl,mpc8641-pcie";
+		device_type = "pci";
+		#interrupt-cells = <1>;
+		#size-cells = <2>;
+		#address-cells = <3>;
+		reg = <0xfef08000 0x1000>;
+		bus-range = <0x0 0xff>;
+		ranges = <0x02000000 0x0 0x80000000 0x80000000 0x0 0x40000000
+			  0x01000000 0x0 0x00000000 0xfe000000 0x0 0x00400000>;
+		clock-frequency = <33333333>;
+		interrupt-parent = <&mpic>;
+		interrupts = <0x18 0x2>;
+		interrupt-map-mask = <0xff00 0x0 0x0 0x7>;
+		interrupt-map = <
+			0x0000 0x0 0x0 0x1 &mpic 0x0 0x2
+			0x0000 0x0 0x0 0x2 &mpic 0x1 0x2
+			0x0000 0x0 0x0 0x3 &mpic 0x2 0x2
+			0x0000 0x0 0x0 0x4 &mpic 0x3 0x2
+		>;
+
+		pcie@0 {
+			reg = <0 0 0 0 0>;
+			#size-cells = <2>;
+			#address-cells = <3>;
+			device_type = "pci";
+			ranges = <0x02000000 0x0 0x80000000
+				  0x02000000 0x0 0x80000000
+				  0x0 0x40000000
+
+				  0x01000000 0x0 0x00000000
+				  0x01000000 0x0 0x00000000
+				  0x0 0x00400000>;
+		};
+	};
+
+	pci1: pcie@fef09000 {
+		compatible = "fsl,mpc8641-pcie";
+		device_type = "pci";
+		#interrupt-cells = <1>;
+		#size-cells = <2>;
+		#address-cells = <3>;
+		reg = <0xfef09000 0x1000>;
+		bus-range = <0x0 0xff>;
+		ranges = <0x02000000 0x0 0xc0000000 0xc0000000 0x0 0x20000000
+			  0x01000000 0x0 0x00000000 0xfe400000 0x0 0x00400000>;
+		clock-frequency = <33333333>;
+		interrupt-parent = <&mpic>;
+		interrupts = <0x19 0x2>;
+		interrupt-map-mask = <0xf800 0x0 0x0 0x7>;
+		interrupt-map = <
+			0x0000 0x0 0x0 0x1 &mpic 0x4 0x2
+			0x0000 0x0 0x0 0x2 &mpic 0x5 0x2
+			0x0000 0x0 0x0 0x3 &mpic 0x6 0x2
+			0x0000 0x0 0x0 0x4 &mpic 0x7 0x2
+			>;
+
+		pcie@0 {
+			reg = <0 0 0 0 0>;
+			#size-cells = <2>;
+			#address-cells = <3>;
+			device_type = "pci";
+			ranges = <0x02000000 0x0 0xc0000000
+				  0x02000000 0x0 0xc0000000
+				  0x0 0x20000000
+
+				  0x01000000 0x0 0x00000000
+				  0x01000000 0x0 0x00000000
+				  0x0 0x00400000>;
+		};
+	};
+};
diff --git a/arch/powerpc/boot/dts/fsl/gef_sbc610.dts b/arch/powerpc/boot/dts/fsl/gef_sbc610.dts
new file mode 100644
index 0000000..5db3399
--- /dev/null
+++ b/arch/powerpc/boot/dts/fsl/gef_sbc610.dts
@@ -0,0 +1,423 @@
+/*
+ * GE SBC610 Device Tree Source
+ *
+ * Copyright 2008 GE Intelligent Platforms Embedded Systems, Inc.
+ *
+ * This program is free software; you can redistribute  it and/or modify it
+ * under  the terms of  the GNU General  Public License as published by the
+ * Free Software Foundation;  either version 2 of the  License, or (at your
+ * option) any later version.
+ *
+ * Based on: SBS CM6 Device Tree Source
+ * Copyright 2007 SBS Technologies GmbH & Co. KG
+ * And: mpc8641_hpcn.dts (MPC8641 HPCN Device Tree Source)
+ * Copyright 2006 Freescale Semiconductor Inc.
+ */
+
+/*
+ * Compiled with dtc -I dts -O dtb -o gef_sbc610.dtb gef_sbc610.dts
+ */
+
+/dts-v1/;
+
+/ {
+	model = "GEF_SBC610";
+	compatible = "gef,sbc610";
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
+		PowerPC,8641@0 {
+			device_type = "cpu";
+			reg = <0>;
+			d-cache-line-size = <32>;	// 32 bytes
+			i-cache-line-size = <32>;	// 32 bytes
+			d-cache-size = <32768>;		// L1, 32K
+			i-cache-size = <32768>;		// L1, 32K
+			timebase-frequency = <0>;	// From uboot
+			bus-frequency = <0>;		// From uboot
+			clock-frequency = <0>;		// From uboot
+		};
+		PowerPC,8641@1 {
+			device_type = "cpu";
+			reg = <1>;
+			d-cache-line-size = <32>;	// 32 bytes
+			i-cache-line-size = <32>;	// 32 bytes
+			d-cache-size = <32768>;		// L1, 32K
+			i-cache-size = <32768>;		// L1, 32K
+			timebase-frequency = <0>;	// From uboot
+			bus-frequency = <0>;		// From uboot
+			clock-frequency = <0>;		// From uboot
+		};
+	};
+
+	memory {
+		device_type = "memory";
+		reg = <0x0 0x40000000>;	// set by uboot
+	};
+
+	localbus@fef05000 {
+		#address-cells = <2>;
+		#size-cells = <1>;
+		compatible = "fsl,mpc8641-localbus", "simple-bus";
+		reg = <0xfef05000 0x1000>;
+		interrupts = <19 2>;
+		interrupt-parent = <&mpic>;
+
+		ranges = <0 0 0xff000000 0x01000000	// 16MB Boot flash
+			  1 0 0xe8000000 0x08000000	// Paged Flash 0
+			  2 0 0xe0000000 0x08000000	// Paged Flash 1
+			  3 0 0xfc100000 0x00020000	// NVRAM
+			  4 0 0xfc000000 0x00008000	// FPGA
+			  5 0 0xfc008000 0x00008000	// AFIX FPGA
+			  6 0 0xfd000000 0x00800000	// IO FPGA (8-bit)
+			  7 0 0xfd800000 0x00800000>;	// IO FPGA (32-bit)
+
+		/* flash@0,0 is a mirror of part of the memory in flash@1,0
+		flash@0,0 {
+			compatible = "gef,sbc610-firmware-mirror", "cfi-flash";
+			reg = <0x0 0x0 0x1000000>;
+			bank-width = <4>;
+			device-width = <2>;
+			#address-cells = <1>;
+			#size-cells = <1>;
+			partition@0 {
+				label = "firmware";
+				reg = <0x0 0x1000000>;
+				read-only;
+			};
+		};
+		*/
+
+		flash@1,0 {
+			compatible = "gef,sbc610-paged-flash", "cfi-flash";
+			reg = <0x1 0x0 0x8000000>;
+			bank-width = <4>;
+			device-width = <2>;
+			#address-cells = <1>;
+			#size-cells = <1>;
+			partition@0 {
+				label = "user";
+				reg = <0x0 0x7800000>;
+			};
+			partition@7800000 {
+				label = "firmware";
+				reg = <0x7800000 0x800000>;
+				read-only;
+			};
+		};
+
+		nvram@3,0 {
+			device_type = "nvram";
+			compatible = "simtek,stk14ca8";
+			reg = <0x3 0x0 0x20000>;
+		};
+
+		fpga@4,0 {
+			compatible = "gef,fpga-regs";
+			reg = <0x4 0x0 0x40>;
+		};
+
+		wdt@4,2000 {
+			compatible = "gef,fpga-wdt";
+			reg = <0x4 0x2000 0x8>;
+			interrupts = <0x1a 0x4>;
+			interrupt-parent = <&gef_pic>;
+		};
+		/* Second watchdog available, driver currently supports one.
+		wdt@4,2010 {
+			compatible = "gef,fpga-wdt";
+			reg = <0x4 0x2010 0x8>;
+			interrupts = <0x1b 0x4>;
+			interrupt-parent = <&gef_pic>;
+		};
+		*/
+		gef_pic: pic@4,4000 {
+			#interrupt-cells = <1>;
+			interrupt-controller;
+			compatible = "gef,fpga-pic";
+			reg = <0x4 0x4000 0x20>;
+			interrupts = <0x8
+				      0x9>;
+			interrupt-parent = <&mpic>;
+
+		};
+		gef_gpio: gpio@7,14000 {
+			#gpio-cells = <2>;
+			compatible = "gef,sbc610-gpio";
+			reg = <0x7 0x14000 0x24>;
+			gpio-controller;
+		};
+	};
+
+	soc@fef00000 {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		#interrupt-cells = <2>;
+		device_type = "soc";
+		compatible = "simple-bus";
+		ranges = <0x0 0xfef00000 0x00100000>;
+		bus-frequency = <33333333>;
+
+		mcm-law@0 {
+			compatible = "fsl,mcm-law";
+			reg = <0x0 0x1000>;
+			fsl,num-laws = <10>;
+		};
+
+		mcm@1000 {
+			compatible = "fsl,mpc8641-mcm", "fsl,mcm";
+			reg = <0x1000 0x1000>;
+			interrupts = <17 2>;
+			interrupt-parent = <&mpic>;
+		};
+
+		i2c1: i2c@3000 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			compatible = "fsl-i2c";
+			reg = <0x3000 0x100>;
+			interrupts = <0x2b 0x2>;
+			interrupt-parent = <&mpic>;
+			dfsrr;
+
+			hwmon@48 {
+				compatible = "national,lm92";
+				reg = <0x48>;
+			};
+
+			hwmon@4c {
+				compatible = "adi,adt7461";
+				reg = <0x4c>;
+			};
+
+			rtc@51 {
+				compatible = "epson,rx8581";
+				reg = <0x00000051>;
+			};
+
+			eti@6b {
+				compatible = "dallas,ds1682";
+				reg = <0x6b>;
+			};
+		};
+
+		i2c2: i2c@3100 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			compatible = "fsl-i2c";
+			reg = <0x3100 0x100>;
+			interrupts = <0x2b 0x2>;
+			interrupt-parent = <&mpic>;
+			dfsrr;
+		};
+
+		dma@21300 {
+			#address-cells = <1>;
+			#size-cells = <1>;
+			compatible = "fsl,mpc8641-dma", "fsl,eloplus-dma";
+			reg = <0x21300 0x4>;
+			ranges = <0x0 0x21100 0x200>;
+			cell-index = <0>;
+			dma-channel@0 {
+				compatible = "fsl,mpc8641-dma-channel",
+					   "fsl,eloplus-dma-channel";
+				reg = <0x0 0x80>;
+				cell-index = <0>;
+				interrupt-parent = <&mpic>;
+				interrupts = <20 2>;
+			};
+			dma-channel@80 {
+				compatible = "fsl,mpc8641-dma-channel",
+					   "fsl,eloplus-dma-channel";
+				reg = <0x80 0x80>;
+				cell-index = <1>;
+				interrupt-parent = <&mpic>;
+				interrupts = <21 2>;
+			};
+			dma-channel@100 {
+				compatible = "fsl,mpc8641-dma-channel",
+					   "fsl,eloplus-dma-channel";
+				reg = <0x100 0x80>;
+				cell-index = <2>;
+				interrupt-parent = <&mpic>;
+				interrupts = <22 2>;
+			};
+			dma-channel@180 {
+				compatible = "fsl,mpc8641-dma-channel",
+					   "fsl,eloplus-dma-channel";
+				reg = <0x180 0x80>;
+				cell-index = <3>;
+				interrupt-parent = <&mpic>;
+				interrupts = <23 2>;
+			};
+		};
+
+		enet0: ethernet@24000 {
+			#address-cells = <1>;
+			#size-cells = <1>;
+			cell-index = <0>;
+			device_type = "network";
+			model = "TSEC";
+			compatible = "gianfar";
+			reg = <0x24000 0x1000>;
+			ranges = <0x0 0x24000 0x1000>;
+			local-mac-address = [ 00 00 00 00 00 00 ];
+			interrupts = <29 2 30  2 34 2>;
+			interrupt-parent = <&mpic>;
+			tbi-handle = <&tbi0>;
+			phy-handle = <&phy0>;
+			phy-connection-type = "gmii";
+
+			mdio@520 {
+				#address-cells = <1>;
+				#size-cells = <0>;
+				compatible = "fsl,gianfar-mdio";
+				reg = <0x520 0x20>;
+
+				phy0: ethernet-phy@0 {
+					interrupt-parent = <&gef_pic>;
+					interrupts = <0x9 0x4>;
+					reg = <1>;
+				};
+				phy2: ethernet-phy@2 {
+					interrupt-parent = <&gef_pic>;
+					interrupts = <0x8 0x4>;
+					reg = <3>;
+				};
+				tbi0: tbi-phy@11 {
+					reg = <0x11>;
+					device_type = "tbi-phy";
+				};
+			};
+		};
+
+		enet1: ethernet@26000 {
+			#address-cells = <1>;
+			#size-cells = <1>;
+			cell-index = <2>;
+			device_type = "network";
+			model = "TSEC";
+			compatible = "gianfar";
+			reg = <0x26000 0x1000>;
+			ranges = <0x0 0x26000 0x1000>;
+			local-mac-address = [ 00 00 00 00 00 00 ];
+			interrupts = <31 2 32 2 33 2>;
+			interrupt-parent = <&mpic>;
+			tbi-handle = <&tbi2>;
+			phy-handle = <&phy2>;
+			phy-connection-type = "gmii";
+
+			mdio@520 {
+				#address-cells = <1>;
+				#size-cells = <0>;
+				compatible = "fsl,gianfar-tbi";
+				reg = <0x520 0x20>;
+
+				tbi2: tbi-phy@11 {
+					reg = <0x11>;
+					device_type = "tbi-phy";
+				};
+			};
+		};
+
+		serial0: serial@4500 {
+			cell-index = <0>;
+			device_type = "serial";
+			compatible = "fsl,ns16550", "ns16550";
+			reg = <0x4500 0x100>;
+			clock-frequency = <0>;
+			interrupts = <0x2a 0x2>;
+			interrupt-parent = <&mpic>;
+		};
+
+		serial1: serial@4600 {
+			cell-index = <1>;
+			device_type = "serial";
+			compatible = "fsl,ns16550", "ns16550";
+			reg = <0x4600 0x100>;
+			clock-frequency = <0>;
+			interrupts = <0x1c 0x2>;
+			interrupt-parent = <&mpic>;
+		};
+
+		mpic: pic@40000 {
+			clock-frequency = <0>;
+			interrupt-controller;
+			#address-cells = <0>;
+			#interrupt-cells = <2>;
+			reg = <0x40000 0x40000>;
+			compatible = "chrp,open-pic";
+			device_type = "open-pic";
+		};
+
+		msi@41600 {
+			compatible = "fsl,mpc8641-msi", "fsl,mpic-msi";
+			reg = <0x41600 0x80>;
+			msi-available-ranges = <0 0x100>;
+			interrupts = <
+				0xe0 0
+				0xe1 0
+				0xe2 0
+				0xe3 0
+				0xe4 0
+				0xe5 0
+				0xe6 0
+				0xe7 0>;
+			interrupt-parent = <&mpic>;
+		};
+
+		global-utilities@e0000 {
+			compatible = "fsl,mpc8641-guts";
+			reg = <0xe0000 0x1000>;
+			fsl,has-rstcr;
+		};
+	};
+
+	pci0: pcie@fef08000 {
+		compatible = "fsl,mpc8641-pcie";
+		device_type = "pci";
+		#interrupt-cells = <1>;
+		#size-cells = <2>;
+		#address-cells = <3>;
+		reg = <0xfef08000 0x1000>;
+		bus-range = <0x0 0xff>;
+		ranges = <0x02000000 0x0 0x80000000 0x80000000 0x0 0x40000000
+			  0x01000000 0x0 0x00000000 0xfe000000 0x0 0x00400000>;
+		clock-frequency = <33333333>;
+		interrupt-parent = <&mpic>;
+		interrupts = <0x18 0x2>;
+		interrupt-map-mask = <0xf800 0x0 0x0 0x7>;
+		interrupt-map = <
+			0x0000 0x0 0x0 0x1 &mpic 0x0 0x1
+			0x0000 0x0 0x0 0x2 &mpic 0x1 0x1
+			0x0000 0x0 0x0 0x3 &mpic 0x2 0x1
+			0x0000 0x0 0x0 0x4 &mpic 0x3 0x1
+		>;
+
+		pcie@0 {
+			reg = <0 0 0 0 0>;
+			#size-cells = <2>;
+			#address-cells = <3>;
+			device_type = "pci";
+			ranges = <0x02000000 0x0 0x80000000
+				  0x02000000 0x0 0x80000000
+				  0x0 0x40000000
+
+				  0x01000000 0x0 0x00000000
+				  0x01000000 0x0 0x00000000
+				  0x0 0x00400000>;
+		};
+	};
+};
diff --git a/arch/powerpc/boot/dts/fsl/mpc8641_hpcn.dts b/arch/powerpc/boot/dts/fsl/mpc8641_hpcn.dts
new file mode 100644
index 0000000..662169e
--- /dev/null
+++ b/arch/powerpc/boot/dts/fsl/mpc8641_hpcn.dts
@@ -0,0 +1,663 @@
+/*
+ * MPC8641 HPCN Device Tree Source
+ *
+ * Copyright 2006 Freescale Semiconductor Inc.
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
+	model = "MPC8641HPCN";
+	compatible = "fsl,mpc8641hpcn";
+	#address-cells = <1>;
+	#size-cells = <1>;
+
+	aliases {
+		ethernet0 = &enet0;
+		ethernet1 = &enet1;
+		ethernet2 = &enet2;
+		ethernet3 = &enet3;
+		serial0 = &serial0;
+		serial1 = &serial1;
+		pci0 = &pci0;
+		pci1 = &pci1;
+	};
+
+	cpus {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		PowerPC,8641@0 {
+			device_type = "cpu";
+			reg = <0>;
+			d-cache-line-size = <32>;
+			i-cache-line-size = <32>;
+			d-cache-size = <32768>;		// L1
+			i-cache-size = <32768>;		// L1
+			timebase-frequency = <0>;	// From uboot
+			bus-frequency = <0>;		// From uboot
+			clock-frequency = <0>;		// From uboot
+		};
+		PowerPC,8641@1 {
+			device_type = "cpu";
+			reg = <1>;
+			d-cache-line-size = <32>;
+			i-cache-line-size = <32>;
+			d-cache-size = <32768>;
+			i-cache-size = <32768>;
+			timebase-frequency = <0>;	// From uboot
+			bus-frequency = <0>;		// From uboot
+			clock-frequency = <0>;		// From uboot
+		};
+	};
+
+	memory {
+		device_type = "memory";
+		reg = <0x00000000 0x40000000>;	// 1G at 0x0
+	};
+
+	localbus@ffe05000 {
+		#address-cells = <2>;
+		#size-cells = <1>;
+		compatible = "fsl,mpc8641-localbus", "simple-bus";
+		reg = <0xffe05000 0x1000>;
+		interrupts = <19 2>;
+		interrupt-parent = <&mpic>;
+
+		ranges = <0 0 0xef800000 0x00800000
+			  2 0 0xffdf8000 0x00008000
+			  3 0 0xffdf0000 0x00008000>;
+
+		flash@0,0 {
+			compatible = "cfi-flash";
+			reg = <0 0 0x00800000>;
+			bank-width = <2>;
+			device-width = <2>;
+			#address-cells = <1>;
+			#size-cells = <1>;
+			partition@0 {
+				label = "kernel";
+				reg = <0x00000000 0x00300000>;
+			};
+			partition@300000 {
+				label = "firmware b";
+				reg = <0x00300000 0x00100000>;
+				read-only;
+			};
+			partition@400000 {
+				label = "fs";
+				reg = <0x00400000 0x00300000>;
+			};
+			partition@700000 {
+				label = "firmware a";
+				reg = <0x00700000 0x00100000>;
+				read-only;
+			};
+		};
+	};
+
+	soc8641@ffe00000 {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		device_type = "soc";
+		compatible = "simple-bus";
+		ranges = <0x00000000 0xffe00000 0x00100000>;
+		bus-frequency = <0>;
+
+		mcm-law@0 {
+			compatible = "fsl,mcm-law";
+			reg = <0x0 0x1000>;
+			fsl,num-laws = <10>;
+		};
+
+		mcm@1000 {
+			compatible = "fsl,mpc8641-mcm", "fsl,mcm";
+			reg = <0x1000 0x1000>;
+			interrupts = <17 2>;
+			interrupt-parent = <&mpic>;
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
+		};
+
+		i2c@3100 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			cell-index = <1>;
+			compatible = "fsl-i2c";
+			reg = <0x3100 0x100>;
+			interrupts = <43 2>;
+			interrupt-parent = <&mpic>;
+			dfsrr;
+		};
+
+		dma@21300 {
+			#address-cells = <1>;
+			#size-cells = <1>;
+			compatible = "fsl,mpc8641-dma", "fsl,eloplus-dma";
+			reg = <0x21300 0x4>;
+			ranges = <0x0 0x21100 0x200>;
+			cell-index = <0>;
+			dma-channel@0 {
+				compatible = "fsl,mpc8641-dma-channel",
+						"fsl,eloplus-dma-channel";
+				reg = <0x0 0x80>;
+				cell-index = <0>;
+				interrupt-parent = <&mpic>;
+				interrupts = <20 2>;
+			};
+			dma-channel@80 {
+				compatible = "fsl,mpc8641-dma-channel",
+						"fsl,eloplus-dma-channel";
+				reg = <0x80 0x80>;
+				cell-index = <1>;
+				interrupt-parent = <&mpic>;
+				interrupts = <21 2>;
+			};
+			dma-channel@100 {
+				compatible = "fsl,mpc8641-dma-channel",
+						"fsl,eloplus-dma-channel";
+				reg = <0x100 0x80>;
+				cell-index = <2>;
+				interrupt-parent = <&mpic>;
+				interrupts = <22 2>;
+			};
+			dma-channel@180 {
+				compatible = "fsl,mpc8641-dma-channel",
+						"fsl,eloplus-dma-channel";
+				reg = <0x180 0x80>;
+				cell-index = <3>;
+				interrupt-parent = <&mpic>;
+				interrupts = <23 2>;
+			};
+		};
+
+		enet0: ethernet@24000 {
+			#address-cells = <1>;
+			#size-cells = <1>;
+			cell-index = <0>;
+			device_type = "network";
+			model = "TSEC";
+			compatible = "gianfar";
+			reg = <0x24000 0x1000>;
+			ranges = <0x0 0x24000 0x1000>;
+			local-mac-address = [ 00 00 00 00 00 00 ];
+			interrupts = <29 2 30  2 34 2>;
+			interrupt-parent = <&mpic>;
+			tbi-handle = <&tbi0>;
+			phy-handle = <&phy0>;
+			phy-connection-type = "rgmii-id";
+
+			mdio@520 {
+				#address-cells = <1>;
+				#size-cells = <0>;
+				compatible = "fsl,gianfar-mdio";
+				reg = <0x520 0x20>;
+
+				phy0: ethernet-phy@0 {
+					interrupt-parent = <&mpic>;
+					interrupts = <10 1>;
+					reg = <0>;
+				};
+				phy1: ethernet-phy@1 {
+					interrupt-parent = <&mpic>;
+					interrupts = <10 1>;
+					reg = <1>;
+				};
+				phy2: ethernet-phy@2 {
+					interrupt-parent = <&mpic>;
+					interrupts = <10 1>;
+					reg = <2>;
+				};
+				phy3: ethernet-phy@3 {
+					interrupt-parent = <&mpic>;
+					interrupts = <10 1>;
+					reg = <3>;
+				};
+				tbi0: tbi-phy@11 {
+					reg = <0x11>;
+					device_type = "tbi-phy";
+				};
+			};
+		};
+
+		enet1: ethernet@25000 {
+			#address-cells = <1>;
+			#size-cells = <1>;
+			cell-index = <1>;
+			device_type = "network";
+			model = "TSEC";
+			compatible = "gianfar";
+			reg = <0x25000 0x1000>;
+			ranges = <0x0 0x25000 0x1000>;
+			local-mac-address = [ 00 00 00 00 00 00 ];
+			interrupts = <35 2 36 2 40 2>;
+			interrupt-parent = <&mpic>;
+			tbi-handle = <&tbi1>;
+			phy-handle = <&phy1>;
+			phy-connection-type = "rgmii-id";
+
+			mdio@520 {
+				#address-cells = <1>;
+				#size-cells = <0>;
+				compatible = "fsl,gianfar-tbi";
+				reg = <0x520 0x20>;
+
+				tbi1: tbi-phy@11 {
+					reg = <0x11>;
+					device_type = "tbi-phy";
+				};
+			};
+		};
+
+		enet2: ethernet@26000 {
+			#address-cells = <1>;
+			#size-cells = <1>;
+			cell-index = <2>;
+			device_type = "network";
+			model = "TSEC";
+			compatible = "gianfar";
+			reg = <0x26000 0x1000>;
+			ranges = <0x0 0x26000 0x1000>;
+			local-mac-address = [ 00 00 00 00 00 00 ];
+			interrupts = <31 2 32 2 33 2>;
+			interrupt-parent = <&mpic>;
+			tbi-handle = <&tbi2>;
+			phy-handle = <&phy2>;
+			phy-connection-type = "rgmii-id";
+
+			mdio@520 {
+				#address-cells = <1>;
+				#size-cells = <0>;
+				compatible = "fsl,gianfar-tbi";
+				reg = <0x520 0x20>;
+
+				tbi2: tbi-phy@11 {
+					reg = <0x11>;
+					device_type = "tbi-phy";
+				};
+			};
+		};
+
+		enet3: ethernet@27000 {
+			#address-cells = <1>;
+			#size-cells = <1>;
+			cell-index = <3>;
+			device_type = "network";
+			model = "TSEC";
+			compatible = "gianfar";
+			reg = <0x27000 0x1000>;
+			ranges = <0x0 0x27000 0x1000>;
+			local-mac-address = [ 00 00 00 00 00 00 ];
+			interrupts = <37 2 38 2 39 2>;
+			interrupt-parent = <&mpic>;
+			tbi-handle = <&tbi3>;
+			phy-handle = <&phy3>;
+			phy-connection-type = "rgmii-id";
+
+			mdio@520 {
+				#address-cells = <1>;
+				#size-cells = <0>;
+				compatible = "fsl,gianfar-tbi";
+				reg = <0x520 0x20>;
+
+				tbi3: tbi-phy@11 {
+					reg = <0x11>;
+					device_type = "tbi-phy";
+				};
+			};
+		};
+
+		serial0: serial@4500 {
+			cell-index = <0>;
+			device_type = "serial";
+			compatible = "fsl,ns16550", "ns16550";
+			reg = <0x4500 0x100>;
+			clock-frequency = <0>;
+			interrupts = <42 2>;
+			interrupt-parent = <&mpic>;
+		};
+
+		serial1: serial@4600 {
+			cell-index = <1>;
+			device_type = "serial";
+			compatible = "fsl,ns16550", "ns16550";
+			reg = <0x4600 0x100>;
+			clock-frequency = <0>;
+			interrupts = <28 2>;
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
+		rmu: rmu@d3000 {
+			#address-cells = <1>;
+			#size-cells = <1>;
+			compatible = "fsl,srio-rmu";
+			reg = <0xd3000 0x500>;
+			ranges = <0x0 0xd3000 0x500>;
+
+			message-unit@0 {
+				compatible = "fsl,srio-msg-unit";
+				reg = <0x0 0x100>;
+				interrupts = <
+					53 2 /* msg1_tx_irq */
+					54 2>;/* msg1_rx_irq */
+			};
+			message-unit@100 {
+				compatible = "fsl,srio-msg-unit";
+				reg = <0x100 0x100>;
+				interrupts = <
+					55 2  /* msg2_tx_irq */
+					56 2>;/* msg2_rx_irq */
+			};
+			doorbell-unit@400 {
+				compatible = "fsl,srio-dbell-unit";
+				reg = <0x400 0x80>;
+				interrupts = <
+					49 2  /* bell_outb_irq */
+					50 2>;/* bell_inb_irq */
+			};
+			port-write-unit@4e0 {
+				compatible = "fsl,srio-port-write-unit";
+				reg = <0x4e0 0x20>;
+				interrupts = <48 2>;
+			};
+		};
+
+		global-utilities@e0000 {
+			compatible = "fsl,mpc8641-guts";
+			reg = <0xe0000 0x1000>;
+			fsl,has-rstcr;
+		};
+	};
+
+	pci0: pcie@ffe08000 {
+		compatible = "fsl,mpc8641-pcie";
+		device_type = "pci";
+		#interrupt-cells = <1>;
+		#size-cells = <2>;
+		#address-cells = <3>;
+		reg = <0xffe08000 0x1000>;
+		bus-range = <0x0 0xff>;
+		ranges = <0x02000000 0x0 0x80000000 0x80000000 0x0 0x20000000
+			  0x01000000 0x0 0x00000000 0xffc00000 0x0 0x00010000>;
+		clock-frequency = <33333333>;
+		interrupt-parent = <&mpic>;
+		interrupts = <24 2>;
+		interrupt-map-mask = <0xff00 0 0 7>;
+		interrupt-map = <
+			/* IDSEL 0x11 func 0 - PCI slot 1 */
+			0x8800 0 0 1 &mpic 2 1
+			0x8800 0 0 2 &mpic 3 1
+			0x8800 0 0 3 &mpic 4 1
+			0x8800 0 0 4 &mpic 1 1
+
+			/* IDSEL 0x11 func 1 - PCI slot 1 */
+			0x8900 0 0 1 &mpic 2 1
+			0x8900 0 0 2 &mpic 3 1
+			0x8900 0 0 3 &mpic 4 1
+			0x8900 0 0 4 &mpic 1 1
+
+			/* IDSEL 0x11 func 2 - PCI slot 1 */
+			0x8a00 0 0 1 &mpic 2 1
+			0x8a00 0 0 2 &mpic 3 1
+			0x8a00 0 0 3 &mpic 4 1
+			0x8a00 0 0 4 &mpic 1 1
+
+			/* IDSEL 0x11 func 3 - PCI slot 1 */
+			0x8b00 0 0 1 &mpic 2 1
+			0x8b00 0 0 2 &mpic 3 1
+			0x8b00 0 0 3 &mpic 4 1
+			0x8b00 0 0 4 &mpic 1 1
+
+			/* IDSEL 0x11 func 4 - PCI slot 1 */
+			0x8c00 0 0 1 &mpic 2 1
+			0x8c00 0 0 2 &mpic 3 1
+			0x8c00 0 0 3 &mpic 4 1
+			0x8c00 0 0 4 &mpic 1 1
+
+			/* IDSEL 0x11 func 5 - PCI slot 1 */
+			0x8d00 0 0 1 &mpic 2 1
+			0x8d00 0 0 2 &mpic 3 1
+			0x8d00 0 0 3 &mpic 4 1
+			0x8d00 0 0 4 &mpic 1 1
+
+			/* IDSEL 0x11 func 6 - PCI slot 1 */
+			0x8e00 0 0 1 &mpic 2 1
+			0x8e00 0 0 2 &mpic 3 1
+			0x8e00 0 0 3 &mpic 4 1
+			0x8e00 0 0 4 &mpic 1 1
+
+			/* IDSEL 0x11 func 7 - PCI slot 1 */
+			0x8f00 0 0 1 &mpic 2 1
+			0x8f00 0 0 2 &mpic 3 1
+			0x8f00 0 0 3 &mpic 4 1
+			0x8f00 0 0 4 &mpic 1 1
+
+			/* IDSEL 0x12 func 0 - PCI slot 2 */
+			0x9000 0 0 1 &mpic 3 1
+			0x9000 0 0 2 &mpic 4 1
+			0x9000 0 0 3 &mpic 1 1
+			0x9000 0 0 4 &mpic 2 1
+
+			/* IDSEL 0x12 func 1 - PCI slot 2 */
+			0x9100 0 0 1 &mpic 3 1
+			0x9100 0 0 2 &mpic 4 1
+			0x9100 0 0 3 &mpic 1 1
+			0x9100 0 0 4 &mpic 2 1
+
+			/* IDSEL 0x12 func 2 - PCI slot 2 */
+			0x9200 0 0 1 &mpic 3 1
+			0x9200 0 0 2 &mpic 4 1
+			0x9200 0 0 3 &mpic 1 1
+			0x9200 0 0 4 &mpic 2 1
+
+			/* IDSEL 0x12 func 3 - PCI slot 2 */
+			0x9300 0 0 1 &mpic 3 1
+			0x9300 0 0 2 &mpic 4 1
+			0x9300 0 0 3 &mpic 1 1
+			0x9300 0 0 4 &mpic 2 1
+
+			/* IDSEL 0x12 func 4 - PCI slot 2 */
+			0x9400 0 0 1 &mpic 3 1
+			0x9400 0 0 2 &mpic 4 1
+			0x9400 0 0 3 &mpic 1 1
+			0x9400 0 0 4 &mpic 2 1
+
+			/* IDSEL 0x12 func 5 - PCI slot 2 */
+			0x9500 0 0 1 &mpic 3 1
+			0x9500 0 0 2 &mpic 4 1
+			0x9500 0 0 3 &mpic 1 1
+			0x9500 0 0 4 &mpic 2 1
+
+			/* IDSEL 0x12 func 6 - PCI slot 2 */
+			0x9600 0 0 1 &mpic 3 1
+			0x9600 0 0 2 &mpic 4 1
+			0x9600 0 0 3 &mpic 1 1
+			0x9600 0 0 4 &mpic 2 1
+
+			/* IDSEL 0x12 func 7 - PCI slot 2 */
+			0x9700 0 0 1 &mpic 3 1
+			0x9700 0 0 2 &mpic 4 1
+			0x9700 0 0 3 &mpic 1 1
+			0x9700 0 0 4 &mpic 2 1
+
+			// IDSEL 0x1c  USB
+			0xe000 0 0 1 &i8259 12 2
+			0xe100 0 0 2 &i8259 9 2
+			0xe200 0 0 3 &i8259 10 2
+			0xe300 0 0 4 &i8259 11 2
+
+			// IDSEL 0x1d  Audio
+			0xe800 0 0 1 &i8259 6 2
+
+			// IDSEL 0x1e Legacy
+			0xf000 0 0 1 &i8259 7 2
+			0xf100 0 0 1 &i8259 7 2
+
+			// IDSEL 0x1f IDE/SATA
+			0xf800 0 0 1 &i8259 14 2
+			0xf900 0 0 1 &i8259 5 2
+			>;
+
+		pcie@0 {
+			reg = <0 0 0 0 0>;
+			#size-cells = <2>;
+			#address-cells = <3>;
+			device_type = "pci";
+			ranges = <0x02000000 0x0 0x80000000
+				  0x02000000 0x0 0x80000000
+				  0x0 0x20000000
+
+				  0x01000000 0x0 0x00000000
+				  0x01000000 0x0 0x00000000
+				  0x0 0x00010000>;
+			uli1575@0 {
+				reg = <0 0 0 0 0>;
+				#size-cells = <2>;
+				#address-cells = <3>;
+				ranges = <0x02000000 0x0 0x80000000
+					  0x02000000 0x0 0x80000000
+					  0x0 0x20000000
+					  0x01000000 0x0 0x00000000
+					  0x01000000 0x0 0x00000000
+					  0x0 0x00010000>;
+				isa@1e {
+					device_type = "isa";
+					#interrupt-cells = <2>;
+					#size-cells = <1>;
+					#address-cells = <2>;
+					reg = <0xf000 0 0 0 0>;
+					ranges = <1 0 0x01000000 0 0
+						  0x00001000>;
+					interrupt-parent = <&i8259>;
+
+					i8259: interrupt-controller@20 {
+						reg = <1 0x20 2
+						       1 0xa0 2
+						       1 0x4d0 2>;
+						interrupt-controller;
+						device_type = "interrupt-controller";
+						#address-cells = <0>;
+						#interrupt-cells = <2>;
+						compatible = "chrp,iic";
+						interrupts = <9 2>;
+						interrupt-parent = <&mpic>;
+					};
+
+					i8042@60 {
+						#size-cells = <0>;
+						#address-cells = <1>;
+						reg = <1 0x60 1 1 0x64 1>;
+						interrupts = <1 3 12 3>;
+						interrupt-parent =
+							<&i8259>;
+
+						keyboard@0 {
+							reg = <0>;
+							compatible = "pnpPNP,303";
+						};
+
+						mouse@1 {
+							reg = <1>;
+							compatible = "pnpPNP,f03";
+						};
+					};
+
+					rtc@70 {
+						compatible =
+							"pnpPNP,b00";
+						reg = <1 0x70 2>;
+					};
+
+					gpio@400 {
+						reg = <1 0x400 0x80>;
+					};
+				};
+			};
+		};
+
+	};
+
+	pci1: pcie@ffe09000 {
+		compatible = "fsl,mpc8641-pcie";
+		device_type = "pci";
+		#interrupt-cells = <1>;
+		#size-cells = <2>;
+		#address-cells = <3>;
+		reg = <0xffe09000 0x1000>;
+		bus-range = <0 0xff>;
+		ranges = <0x02000000 0x0 0xa0000000 0xa0000000 0x0 0x20000000
+			  0x01000000 0x0 0x00000000 0xffc10000 0x0 0x00010000>;
+		clock-frequency = <33333333>;
+		interrupt-parent = <&mpic>;
+		interrupts = <25 2>;
+		interrupt-map-mask = <0xf800 0 0 7>;
+		interrupt-map = <
+			/* IDSEL 0x0 */
+			0x0000 0 0 1 &mpic 4 1
+			0x0000 0 0 2 &mpic 5 1
+			0x0000 0 0 3 &mpic 6 1
+			0x0000 0 0 4 &mpic 7 1
+			>;
+		pcie@0 {
+			reg = <0 0 0 0 0>;
+			#size-cells = <2>;
+			#address-cells = <3>;
+			device_type = "pci";
+			ranges = <0x02000000 0x0 0xa0000000
+				  0x02000000 0x0 0xa0000000
+				  0x0 0x20000000
+
+				  0x01000000 0x0 0x00000000
+				  0x01000000 0x0 0x00000000
+				  0x0 0x00010000>;
+		};
+	};
+/*
+ * Only one of Rapid IO or PCI can be present due to HW limitations and
+ * due to the fact that the 2 now share address space in the new memory
+ * map.  The most likely case is that we have PCI, so comment out the
+ * rapidio node.  Leave it here for reference.
+
+	rapidio@ffec0000 {
+		reg = <0xffec0000 0x11000>;
+		compatible = "fsl,srio";
+		interrupt-parent = <&mpic>;
+		interrupts = <48 2>;
+		#address-cells = <2>;
+		#size-cells = <2>;
+		fsl,srio-rmu-handle = <&rmu>;
+		ranges;
+
+		port1 {
+			#address-cells = <2>;
+			#size-cells = <2>;
+			cell-index = <1>;
+			ranges = <0 0 0x80000000 0 0x20000000>;
+		};
+	};
+*/
+
+};
diff --git a/arch/powerpc/boot/dts/fsl/mpc8641_hpcn_36b.dts b/arch/powerpc/boot/dts/fsl/mpc8641_hpcn_36b.dts
new file mode 100644
index 0000000..bb575e2
--- /dev/null
+++ b/arch/powerpc/boot/dts/fsl/mpc8641_hpcn_36b.dts
@@ -0,0 +1,605 @@
+/*
+ * MPC8641 HPCN Device Tree Source
+ *
+ * Copyright 2008-2009 Freescale Semiconductor Inc.
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
+	model = "MPC8641HPCN";
+	compatible = "fsl,mpc8641hpcn";
+	#address-cells = <2>;
+	#size-cells = <2>;
+
+	aliases {
+		ethernet0 = &enet0;
+		ethernet1 = &enet1;
+		ethernet2 = &enet2;
+		ethernet3 = &enet3;
+		serial0 = &serial0;
+		serial1 = &serial1;
+		pci0 = &pci0;
+		pci1 = &pci1;
+	};
+
+	cpus {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		PowerPC,8641@0 {
+			device_type = "cpu";
+			reg = <0>;
+			d-cache-line-size = <32>;	// 32 bytes
+			i-cache-line-size = <32>;	// 32 bytes
+			d-cache-size = <32768>;		// L1, 32K
+			i-cache-size = <32768>;		// L1, 32K
+			timebase-frequency = <0>;	// 33 MHz, from uboot
+			bus-frequency = <0>;		// From uboot
+			clock-frequency = <0>;		// From uboot
+		};
+		PowerPC,8641@1 {
+			device_type = "cpu";
+			reg = <1>;
+			d-cache-line-size = <32>;	// 32 bytes
+			i-cache-line-size = <32>;	// 32 bytes
+			d-cache-size = <32768>;		// L1, 32K
+			i-cache-size = <32768>;		// L1, 32K
+			timebase-frequency = <0>;	// 33 MHz, from uboot
+			bus-frequency = <0>;		// From uboot
+			clock-frequency = <0>;		// From uboot
+		};
+	};
+
+	memory {
+		device_type = "memory";
+		reg = <0x0 0x00000000 0x0 0x40000000>;	// 1G at 0x0
+	};
+
+	localbus@fffe05000 {
+		#address-cells = <2>;
+		#size-cells = <1>;
+		compatible = "fsl,mpc8641-localbus", "simple-bus";
+		reg = <0x0f 0xffe05000 0x0 0x1000>;
+		interrupts = <19 2>;
+		interrupt-parent = <&mpic>;
+
+		ranges = <0 0 0xf 0xef800000 0x00800000
+			  2 0 0xf 0xffdf8000 0x00008000
+			  3 0 0xf 0xffdf0000 0x00008000>;
+
+		flash@0,0 {
+			compatible = "cfi-flash";
+			reg = <0 0 0x00800000>;
+			bank-width = <2>;
+			device-width = <2>;
+			#address-cells = <1>;
+			#size-cells = <1>;
+			partition@0 {
+				label = "kernel";
+				reg = <0x00000000 0x00300000>;
+			};
+			partition@300000 {
+				label = "firmware b";
+				reg = <0x00300000 0x00100000>;
+				read-only;
+			};
+			partition@400000 {
+				label = "fs";
+				reg = <0x00400000 0x00300000>;
+			};
+			partition@700000 {
+				label = "firmware a";
+				reg = <0x00700000 0x00100000>;
+				read-only;
+			};
+		};
+	};
+
+	soc8641@fffe00000 {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		device_type = "soc";
+		compatible = "simple-bus";
+		ranges = <0x00000000 0x0f 0xffe00000 0x00100000>;
+		bus-frequency = <0>;
+
+		mcm-law@0 {
+			compatible = "fsl,mcm-law";
+			reg = <0x0 0x1000>;
+			fsl,num-laws = <10>;
+		};
+
+		mcm@1000 {
+			compatible = "fsl,mpc8641-mcm", "fsl,mcm";
+			reg = <0x1000 0x1000>;
+			interrupts = <17 2>;
+			interrupt-parent = <&mpic>;
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
+		};
+
+		i2c@3100 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			cell-index = <1>;
+			compatible = "fsl-i2c";
+			reg = <0x3100 0x100>;
+			interrupts = <43 2>;
+			interrupt-parent = <&mpic>;
+			dfsrr;
+		};
+
+		dma@21300 {
+			#address-cells = <1>;
+			#size-cells = <1>;
+			compatible = "fsl,mpc8641-dma", "fsl,eloplus-dma";
+			reg = <0x21300 0x4>;
+			ranges = <0x0 0x21100 0x200>;
+			cell-index = <0>;
+			dma-channel@0 {
+				compatible = "fsl,mpc8641-dma-channel",
+						"fsl,eloplus-dma-channel";
+				reg = <0x0 0x80>;
+				cell-index = <0>;
+				interrupt-parent = <&mpic>;
+				interrupts = <20 2>;
+			};
+			dma-channel@80 {
+				compatible = "fsl,mpc8641-dma-channel",
+						"fsl,eloplus-dma-channel";
+				reg = <0x80 0x80>;
+				cell-index = <1>;
+				interrupt-parent = <&mpic>;
+				interrupts = <21 2>;
+			};
+			dma-channel@100 {
+				compatible = "fsl,mpc8641-dma-channel",
+						"fsl,eloplus-dma-channel";
+				reg = <0x100 0x80>;
+				cell-index = <2>;
+				interrupt-parent = <&mpic>;
+				interrupts = <22 2>;
+			};
+			dma-channel@180 {
+				compatible = "fsl,mpc8641-dma-channel",
+						"fsl,eloplus-dma-channel";
+				reg = <0x180 0x80>;
+				cell-index = <3>;
+				interrupt-parent = <&mpic>;
+				interrupts = <23 2>;
+			};
+		};
+
+		enet0: ethernet@24000 {
+			#address-cells = <1>;
+			#size-cells = <1>;
+			cell-index = <0>;
+			device_type = "network";
+			model = "TSEC";
+			compatible = "gianfar";
+			reg = <0x24000 0x1000>;
+			ranges = <0x0 0x24000 0x1000>;
+			local-mac-address = [ 00 00 00 00 00 00 ];
+			interrupts = <29 2 30 2 34 2>;
+			interrupt-parent = <&mpic>;
+			tbi-handle = <&tbi0>;
+			phy-handle = <&phy0>;
+			phy-connection-type = "rgmii-id";
+
+			mdio@520 {
+				#address-cells = <1>;
+				#size-cells = <0>;
+				compatible = "fsl,gianfar-mdio";
+				reg = <0x520 0x20>;
+
+				phy0: ethernet-phy@0 {
+					interrupt-parent = <&mpic>;
+					interrupts = <10 1>;
+					reg = <0>;
+				};
+				phy1: ethernet-phy@1 {
+					interrupt-parent = <&mpic>;
+					interrupts = <10 1>;
+					reg = <1>;
+				};
+				phy2: ethernet-phy@2 {
+					interrupt-parent = <&mpic>;
+					interrupts = <10 1>;
+					reg = <2>;
+				};
+				phy3: ethernet-phy@3 {
+					interrupt-parent = <&mpic>;
+					interrupts = <10 1>;
+					reg = <3>;
+				};
+				tbi0: tbi-phy@11 {
+					reg = <0x11>;
+					device_type = "tbi-phy";
+				};
+			};
+		};
+
+		enet1: ethernet@25000 {
+			#address-cells = <1>;
+			#size-cells = <1>;
+			cell-index = <1>;
+			device_type = "network";
+			model = "TSEC";
+			compatible = "gianfar";
+			reg = <0x25000 0x1000>;
+			ranges = <0x0 0x25000 0x1000>;
+			local-mac-address = [ 00 00 00 00 00 00 ];
+			interrupts = <35 2 36 2 40 2>;
+			interrupt-parent = <&mpic>;
+			tbi-handle = <&tbi1>;
+			phy-handle = <&phy1>;
+			phy-connection-type = "rgmii-id";
+
+			mdio@520 {
+				#address-cells = <1>;
+				#size-cells = <0>;
+				compatible = "fsl,gianfar-tbi";
+				reg = <0x520 0x20>;
+
+				tbi1: tbi-phy@11 {
+					reg = <0x11>;
+					device_type = "tbi-phy";
+				};
+			};
+		};
+
+		enet2: ethernet@26000 {
+			#address-cells = <1>;
+			#size-cells = <1>;
+			cell-index = <2>;
+			device_type = "network";
+			model = "TSEC";
+			compatible = "gianfar";
+			reg = <0x26000 0x1000>;
+			ranges = <0x0 0x26000 0x1000>;
+			local-mac-address = [ 00 00 00 00 00 00 ];
+			interrupts = <31 2 32 2 33 2>;
+			interrupt-parent = <&mpic>;
+			tbi-handle = <&tbi2>;
+			phy-handle = <&phy2>;
+			phy-connection-type = "rgmii-id";
+
+			mdio@520 {
+				#address-cells = <1>;
+				#size-cells = <0>;
+				compatible = "fsl,gianfar-tbi";
+				reg = <0x520 0x20>;
+
+				tbi2: tbi-phy@11 {
+					reg = <0x11>;
+					device_type = "tbi-phy";
+				};
+			};
+		};
+
+		enet3: ethernet@27000 {
+			#address-cells = <1>;
+			#size-cells = <1>;
+			cell-index = <3>;
+			device_type = "network";
+			model = "TSEC";
+			compatible = "gianfar";
+			reg = <0x27000 0x1000>;
+			ranges = <0x0 0x27000 0x1000>;
+			local-mac-address = [ 00 00 00 00 00 00 ];
+			interrupts = <37 2 38 2 39 2>;
+			interrupt-parent = <&mpic>;
+			tbi-handle = <&tbi3>;
+			phy-handle = <&phy3>;
+			phy-connection-type = "rgmii-id";
+
+			mdio@520 {
+				#address-cells = <1>;
+				#size-cells = <0>;
+				compatible = "fsl,gianfar-tbi";
+				reg = <0x520 0x20>;
+
+				tbi3: tbi-phy@11 {
+					reg = <0x11>;
+					device_type = "tbi-phy";
+				};
+			};
+		};
+
+		serial0: serial@4500 {
+			cell-index = <0>;
+			device_type = "serial";
+			compatible = "fsl,ns16550", "ns16550";
+			reg = <0x4500 0x100>;
+			clock-frequency = <0>;
+			interrupts = <42 2>;
+			interrupt-parent = <&mpic>;
+		};
+
+		serial1: serial@4600 {
+			cell-index = <1>;
+			device_type = "serial";
+			compatible = "fsl,ns16550", "ns16550";
+			reg = <0x4600 0x100>;
+			clock-frequency = <0>;
+			interrupts = <28 2>;
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
+		global-utilities@e0000 {
+			compatible = "fsl,mpc8641-guts";
+			reg = <0xe0000 0x1000>;
+			fsl,has-rstcr;
+		};
+	};
+
+	pci0: pcie@fffe08000 {
+		cell-index = <0>;
+		compatible = "fsl,mpc8641-pcie";
+		device_type = "pci";
+		#interrupt-cells = <1>;
+		#size-cells = <2>;
+		#address-cells = <3>;
+		reg = <0x0f 0xffe08000 0x0 0x1000>;
+		bus-range = <0x0 0xff>;
+		ranges = <0x02000000 0x0 0xe0000000 0x0c 0x00000000 0x0 0x20000000
+			  0x01000000 0x0 0x00000000 0x0f 0xffc00000 0x0 0x00010000>;
+		clock-frequency = <33333333>;
+		interrupt-parent = <&mpic>;
+		interrupts = <24 2>;
+		interrupt-map-mask = <0xff00 0 0 7>;
+		interrupt-map = <
+			/* IDSEL 0x11 func 0 - PCI slot 1 */
+			0x8800 0 0 1 &mpic 2 1
+			0x8800 0 0 2 &mpic 3 1
+			0x8800 0 0 3 &mpic 4 1
+			0x8800 0 0 4 &mpic 1 1
+
+			/* IDSEL 0x11 func 1 - PCI slot 1 */
+			0x8900 0 0 1 &mpic 2 1
+			0x8900 0 0 2 &mpic 3 1
+			0x8900 0 0 3 &mpic 4 1
+			0x8900 0 0 4 &mpic 1 1
+
+			/* IDSEL 0x11 func 2 - PCI slot 1 */
+			0x8a00 0 0 1 &mpic 2 1
+			0x8a00 0 0 2 &mpic 3 1
+			0x8a00 0 0 3 &mpic 4 1
+			0x8a00 0 0 4 &mpic 1 1
+
+			/* IDSEL 0x11 func 3 - PCI slot 1 */
+			0x8b00 0 0 1 &mpic 2 1
+			0x8b00 0 0 2 &mpic 3 1
+			0x8b00 0 0 3 &mpic 4 1
+			0x8b00 0 0 4 &mpic 1 1
+
+			/* IDSEL 0x11 func 4 - PCI slot 1 */
+			0x8c00 0 0 1 &mpic 2 1
+			0x8c00 0 0 2 &mpic 3 1
+			0x8c00 0 0 3 &mpic 4 1
+			0x8c00 0 0 4 &mpic 1 1
+
+			/* IDSEL 0x11 func 5 - PCI slot 1 */
+			0x8d00 0 0 1 &mpic 2 1
+			0x8d00 0 0 2 &mpic 3 1
+			0x8d00 0 0 3 &mpic 4 1
+			0x8d00 0 0 4 &mpic 1 1
+
+			/* IDSEL 0x11 func 6 - PCI slot 1 */
+			0x8e00 0 0 1 &mpic 2 1
+			0x8e00 0 0 2 &mpic 3 1
+			0x8e00 0 0 3 &mpic 4 1
+			0x8e00 0 0 4 &mpic 1 1
+
+			/* IDSEL 0x11 func 7 - PCI slot 1 */
+			0x8f00 0 0 1 &mpic 2 1
+			0x8f00 0 0 2 &mpic 3 1
+			0x8f00 0 0 3 &mpic 4 1
+			0x8f00 0 0 4 &mpic 1 1
+
+			/* IDSEL 0x12 func 0 - PCI slot 2 */
+			0x9000 0 0 1 &mpic 3 1
+			0x9000 0 0 2 &mpic 4 1
+			0x9000 0 0 3 &mpic 1 1
+			0x9000 0 0 4 &mpic 2 1
+
+			/* IDSEL 0x12 func 1 - PCI slot 2 */
+			0x9100 0 0 1 &mpic 3 1
+			0x9100 0 0 2 &mpic 4 1
+			0x9100 0 0 3 &mpic 1 1
+			0x9100 0 0 4 &mpic 2 1
+
+			/* IDSEL 0x12 func 2 - PCI slot 2 */
+			0x9200 0 0 1 &mpic 3 1
+			0x9200 0 0 2 &mpic 4 1
+			0x9200 0 0 3 &mpic 1 1
+			0x9200 0 0 4 &mpic 2 1
+
+			/* IDSEL 0x12 func 3 - PCI slot 2 */
+			0x9300 0 0 1 &mpic 3 1
+			0x9300 0 0 2 &mpic 4 1
+			0x9300 0 0 3 &mpic 1 1
+			0x9300 0 0 4 &mpic 2 1
+
+			/* IDSEL 0x12 func 4 - PCI slot 2 */
+			0x9400 0 0 1 &mpic 3 1
+			0x9400 0 0 2 &mpic 4 1
+			0x9400 0 0 3 &mpic 1 1
+			0x9400 0 0 4 &mpic 2 1
+
+			/* IDSEL 0x12 func 5 - PCI slot 2 */
+			0x9500 0 0 1 &mpic 3 1
+			0x9500 0 0 2 &mpic 4 1
+			0x9500 0 0 3 &mpic 1 1
+			0x9500 0 0 4 &mpic 2 1
+
+			/* IDSEL 0x12 func 6 - PCI slot 2 */
+			0x9600 0 0 1 &mpic 3 1
+			0x9600 0 0 2 &mpic 4 1
+			0x9600 0 0 3 &mpic 1 1
+			0x9600 0 0 4 &mpic 2 1
+
+			/* IDSEL 0x12 func 7 - PCI slot 2 */
+			0x9700 0 0 1 &mpic 3 1
+			0x9700 0 0 2 &mpic 4 1
+			0x9700 0 0 3 &mpic 1 1
+			0x9700 0 0 4 &mpic 2 1
+
+			// IDSEL 0x1c  USB
+			0xe000 0 0 1 &i8259 12 2
+			0xe100 0 0 2 &i8259 9 2
+			0xe200 0 0 3 &i8259 10 2
+			0xe300 0 0 4 &i8259 11 2
+
+			// IDSEL 0x1d  Audio
+			0xe800 0 0 1 &i8259 6 2
+
+			// IDSEL 0x1e Legacy
+			0xf000 0 0 1 &i8259 7 2
+			0xf100 0 0 1 &i8259 7 2
+
+			// IDSEL 0x1f IDE/SATA
+			0xf800 0 0 1 &i8259 14 2
+			0xf900 0 0 1 &i8259 5 2
+			>;
+
+		pcie@0 {
+			reg = <0 0 0 0 0>;
+			#size-cells = <2>;
+			#address-cells = <3>;
+			device_type = "pci";
+			ranges = <0x02000000 0x0 0xe0000000
+				  0x02000000 0x0 0xe0000000
+				  0x0 0x20000000
+
+				  0x01000000 0x0 0x00000000
+				  0x01000000 0x0 0x00000000
+				  0x0 0x00010000>;
+			uli1575@0 {
+				reg = <0 0 0 0 0>;
+				#size-cells = <2>;
+				#address-cells = <3>;
+				ranges = <0x02000000 0x0 0xe0000000
+					  0x02000000 0x0 0xe0000000
+					  0x0 0x20000000
+					  0x01000000 0x0 0x00000000
+					  0x01000000 0x0 0x00000000
+					  0x0 0x00010000>;
+				isa@1e {
+					device_type = "isa";
+					#interrupt-cells = <2>;
+					#size-cells = <1>;
+					#address-cells = <2>;
+					reg = <0xf000 0 0 0 0>;
+					ranges = <1 0 0x01000000 0 0
+						  0x00001000>;
+					interrupt-parent = <&i8259>;
+
+					i8259: interrupt-controller@20 {
+						reg = <1 0x20 2
+						       1 0xa0 2
+						       1 0x4d0 2>;
+						interrupt-controller;
+						device_type = "interrupt-controller";
+						#address-cells = <0>;
+						#interrupt-cells = <2>;
+						compatible = "chrp,iic";
+						interrupts = <9 2>;
+						interrupt-parent = <&mpic>;
+					};
+
+					i8042@60 {
+						#size-cells = <0>;
+						#address-cells = <1>;
+						reg = <1 0x60 1 1 0x64 1>;
+						interrupts = <1 3 12 3>;
+						interrupt-parent =
+							<&i8259>;
+
+						keyboard@0 {
+							reg = <0>;
+							compatible = "pnpPNP,303";
+						};
+
+						mouse@1 {
+							reg = <1>;
+							compatible = "pnpPNP,f03";
+						};
+					};
+
+					rtc@70 {
+						compatible =
+							"pnpPNP,b00";
+						reg = <1 0x70 2>;
+					};
+
+					gpio@400 {
+						reg = <1 0x400 0x80>;
+					};
+				};
+			};
+		};
+
+	};
+
+	pci1: pcie@fffe09000 {
+		cell-index = <1>;
+		compatible = "fsl,mpc8641-pcie";
+		device_type = "pci";
+		#interrupt-cells = <1>;
+		#size-cells = <2>;
+		#address-cells = <3>;
+		reg = <0x0f 0xffe09000 0x0 0x1000>;
+		bus-range = <0x0 0xff>;
+		ranges = <0x02000000 0x0 0xe0000000 0x0c 0x20000000 0x0 0x20000000
+			  0x01000000 0x0 0x00000000 0x0f 0xffc10000 0x0 0x00010000>;
+		clock-frequency = <33333333>;
+		interrupt-parent = <&mpic>;
+		interrupts = <25 2>;
+		interrupt-map-mask = <0xf800 0 0 7>;
+		interrupt-map = <
+			/* IDSEL 0x0 */
+			0x0000 0 0 1 &mpic 4 1
+			0x0000 0 0 2 &mpic 5 1
+			0x0000 0 0 3 &mpic 6 1
+			0x0000 0 0 4 &mpic 7 1
+			>;
+		pcie@0 {
+			reg = <0 0 0 0 0>;
+			#size-cells = <2>;
+			#address-cells = <3>;
+			device_type = "pci";
+			ranges = <0x02000000 0x0 0xe0000000
+				  0x02000000 0x0 0xe0000000
+				  0x0 0x20000000
+
+				  0x01000000 0x0 0x00000000
+				  0x01000000 0x0 0x00000000
+				  0x0 0x00010000>;
+		};
+	};
+};
diff --git a/arch/powerpc/boot/dts/fsl/sbc8641d.dts b/arch/powerpc/boot/dts/fsl/sbc8641d.dts
new file mode 100644
index 0000000..68f0ed7
--- /dev/null
+++ b/arch/powerpc/boot/dts/fsl/sbc8641d.dts
@@ -0,0 +1,447 @@
+/*
+ * SBC8641D Device Tree Source
+ *
+ * Copyright 2008 Wind River Systems Inc.
+ *
+ * Paul Gortmaker (see MAINTAINERS for contact information)
+ *
+ * Based largely on the mpc8641_hpcn.dts by Freescale Semiconductor Inc.
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
+	model = "SBC8641D";
+	compatible = "wind,sbc8641";
+	#address-cells = <1>;
+	#size-cells = <1>;
+
+	aliases {
+		ethernet0 = &enet0;
+		ethernet1 = &enet1;
+		ethernet2 = &enet2;
+		ethernet3 = &enet3;
+		serial0 = &serial0;
+		serial1 = &serial1;
+		pci0 = &pci0;
+		pci1 = &pci1;
+	};
+
+	cpus {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		PowerPC,8641@0 {
+			device_type = "cpu";
+			reg = <0>;
+			d-cache-line-size = <32>;
+			i-cache-line-size = <32>;
+			d-cache-size = <32768>;		// L1
+			i-cache-size = <32768>;		// L1
+			timebase-frequency = <0>;	// From uboot
+			bus-frequency = <0>;		// From uboot
+			clock-frequency = <0>;		// From uboot
+		};
+		PowerPC,8641@1 {
+			device_type = "cpu";
+			reg = <1>;
+			d-cache-line-size = <32>;
+			i-cache-line-size = <32>;
+			d-cache-size = <32768>;
+			i-cache-size = <32768>;
+			timebase-frequency = <0>;	// From uboot
+			bus-frequency = <0>;		// From uboot
+			clock-frequency = <0>;		// From uboot
+		};
+	};
+
+	memory {
+		device_type = "memory";
+		reg = <0x00000000 0x20000000>;	// 512M at 0x0
+	};
+
+	localbus@f8005000 {
+		#address-cells = <2>;
+		#size-cells = <1>;
+		compatible = "fsl,mpc8641-localbus", "simple-bus";
+		reg = <0xf8005000 0x1000>;
+		interrupts = <19 2>;
+		interrupt-parent = <&mpic>;
+
+		ranges = <0 0 0xff000000 0x01000000	// 16MB Boot flash
+			  1 0 0xf0000000 0x00010000	// 64KB EEPROM
+			  2 0 0xf1000000 0x00100000	// EPLD (1MB)
+			  3 0 0xe0000000 0x04000000	// 64MB LB SDRAM (CS3)
+			  4 0 0xe4000000 0x04000000	// 64MB LB SDRAM (CS4)
+			  6 0 0xf4000000 0x00100000	// LCD display (1MB)
+			  7 0 0xe8000000 0x04000000>;	// 64MB OneNAND
+
+		flash@0,0 {
+			compatible = "cfi-flash";
+			reg = <0 0 0x01000000>;
+			bank-width = <2>;
+			device-width = <2>;
+			#address-cells = <1>;
+			#size-cells = <1>;
+			partition@0 {
+				label = "dtb";
+				reg = <0x00000000 0x00100000>;
+				read-only;
+			};
+			partition@300000 {
+				label = "kernel";
+				reg = <0x00100000 0x00400000>;
+				read-only;
+			};
+			partition@400000 {
+				label = "fs";
+				reg = <0x00500000 0x00a00000>;
+			};
+			partition@700000 {
+				label = "firmware";
+				reg = <0x00f00000 0x00100000>;
+				read-only;
+			};
+		};
+
+		epld@2,0 {
+			compatible = "wrs,epld-localbus";
+			#address-cells = <2>;
+			#size-cells = <1>;
+			reg = <2 0 0x100000>;
+			ranges = <0 0 5 0 1	// User switches
+				  1 0 5 1 1	// Board ID/Rev
+				  3 0 5 3 1>;	// LEDs
+		};
+	};
+
+	soc@f8000000 {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		device_type = "soc";
+		compatible = "simple-bus";
+		ranges = <0x00000000 0xf8000000 0x00100000>;
+		bus-frequency = <0>;
+
+		mcm-law@0 {
+			compatible = "fsl,mcm-law";
+			reg = <0x0 0x1000>;
+			fsl,num-laws = <10>;
+		};
+
+		mcm@1000 {
+			compatible = "fsl,mpc8641-mcm", "fsl,mcm";
+			reg = <0x1000 0x1000>;
+			interrupts = <17 2>;
+			interrupt-parent = <&mpic>;
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
+		};
+
+		i2c@3100 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			cell-index = <1>;
+			compatible = "fsl-i2c";
+			reg = <0x3100 0x100>;
+			interrupts = <43 2>;
+			interrupt-parent = <&mpic>;
+			dfsrr;
+		};
+
+		dma@21300 {
+			#address-cells = <1>;
+			#size-cells = <1>;
+			compatible = "fsl,mpc8641-dma", "fsl,eloplus-dma";
+			reg = <0x21300 0x4>;
+			ranges = <0x0 0x21100 0x200>;
+			cell-index = <0>;
+			dma-channel@0 {
+				compatible = "fsl,mpc8641-dma-channel",
+						"fsl,eloplus-dma-channel";
+				reg = <0x0 0x80>;
+				cell-index = <0>;
+				interrupt-parent = <&mpic>;
+				interrupts = <20 2>;
+			};
+			dma-channel@80 {
+				compatible = "fsl,mpc8641-dma-channel",
+						"fsl,eloplus-dma-channel";
+				reg = <0x80 0x80>;
+				cell-index = <1>;
+				interrupt-parent = <&mpic>;
+				interrupts = <21 2>;
+			};
+			dma-channel@100 {
+				compatible = "fsl,mpc8641-dma-channel",
+						"fsl,eloplus-dma-channel";
+				reg = <0x100 0x80>;
+				cell-index = <2>;
+				interrupt-parent = <&mpic>;
+				interrupts = <22 2>;
+			};
+			dma-channel@180 {
+				compatible = "fsl,mpc8641-dma-channel",
+						"fsl,eloplus-dma-channel";
+				reg = <0x180 0x80>;
+				cell-index = <3>;
+				interrupt-parent = <&mpic>;
+				interrupts = <23 2>;
+			};
+		};
+
+		enet0: ethernet@24000 {
+			#address-cells = <1>;
+			#size-cells = <1>;
+			cell-index = <0>;
+			device_type = "network";
+			model = "TSEC";
+			compatible = "gianfar";
+			reg = <0x24000 0x1000>;
+			ranges = <0x0 0x24000 0x1000>;
+			local-mac-address = [ 00 00 00 00 00 00 ];
+			interrupts = <29 2 30  2 34 2>;
+			interrupt-parent = <&mpic>;
+			tbi-handle = <&tbi0>;
+			phy-handle = <&phy0>;
+			phy-connection-type = "rgmii-id";
+
+			mdio@520 {
+				#address-cells = <1>;
+				#size-cells = <0>;
+				compatible = "fsl,gianfar-mdio";
+				reg = <0x520 0x20>;
+
+				phy0: ethernet-phy@1f {
+					reg = <0x1f>;
+				};
+				phy1: ethernet-phy@0 {
+					reg = <0>;
+				};
+				phy2: ethernet-phy@1 {
+					reg = <1>;
+				};
+				phy3: ethernet-phy@2 {
+					reg = <2>;
+				};
+				tbi0: tbi-phy@11 {
+					reg = <0x11>;
+					device_type = "tbi-phy";
+				};
+			};
+		};
+
+		enet1: ethernet@25000 {
+			#address-cells = <1>;
+			#size-cells = <1>;
+			cell-index = <1>;
+			device_type = "network";
+			model = "TSEC";
+			compatible = "gianfar";
+			reg = <0x25000 0x1000>;
+			ranges = <0x0 0x25000 0x1000>;
+			local-mac-address = [ 00 00 00 00 00 00 ];
+			interrupts = <35 2 36 2 40 2>;
+			interrupt-parent = <&mpic>;
+			tbi-handle = <&tbi1>;
+			phy-handle = <&phy1>;
+			phy-connection-type = "rgmii-id";
+
+			mdio@520 {
+				#address-cells = <1>;
+				#size-cells = <0>;
+				compatible = "fsl,gianfar-tbi";
+				reg = <0x520 0x20>;
+
+				tbi1: tbi-phy@11 {
+					reg = <0x11>;
+					device_type = "tbi-phy";
+				};
+			};
+		};
+
+		enet2: ethernet@26000 {
+			#address-cells = <1>;
+			#size-cells = <1>;
+			cell-index = <2>;
+			device_type = "network";
+			model = "TSEC";
+			compatible = "gianfar";
+			reg = <0x26000 0x1000>;
+			ranges = <0x0 0x26000 0x1000>;
+			local-mac-address = [ 00 00 00 00 00 00 ];
+			interrupts = <31 2 32 2 33 2>;
+			interrupt-parent = <&mpic>;
+			tbi-handle = <&tbi2>;
+			phy-handle = <&phy2>;
+			phy-connection-type = "rgmii-id";
+
+			mdio@520 {
+				#address-cells = <1>;
+				#size-cells = <0>;
+				compatible = "fsl,gianfar-tbi";
+				reg = <0x520 0x20>;
+
+				tbi2: tbi-phy@11 {
+					reg = <0x11>;
+					device_type = "tbi-phy";
+				};
+			};
+		};
+
+		enet3: ethernet@27000 {
+			#address-cells = <1>;
+			#size-cells = <1>;
+			cell-index = <3>;
+			device_type = "network";
+			model = "TSEC";
+			compatible = "gianfar";
+			reg = <0x27000 0x1000>;
+			ranges = <0x0 0x27000 0x1000>;
+			local-mac-address = [ 00 00 00 00 00 00 ];
+			interrupts = <37 2 38 2 39 2>;
+			interrupt-parent = <&mpic>;
+			tbi-handle = <&tbi3>;
+			phy-handle = <&phy3>;
+			phy-connection-type = "rgmii-id";
+
+			mdio@520 {
+				#address-cells = <1>;
+				#size-cells = <0>;
+				compatible = "fsl,gianfar-tbi";
+				reg = <0x520 0x20>;
+
+				tbi3: tbi-phy@11 {
+					reg = <0x11>;
+					device_type = "tbi-phy";
+				};
+			};
+		};
+
+		serial0: serial@4500 {
+			cell-index = <0>;
+			device_type = "serial";
+			compatible = "fsl,ns16550", "ns16550";
+			reg = <0x4500 0x100>;
+			clock-frequency = <0>;
+			interrupts = <42 2>;
+			interrupt-parent = <&mpic>;
+		};
+
+		serial1: serial@4600 {
+			cell-index = <1>;
+			device_type = "serial";
+			compatible = "fsl,ns16550", "ns16550";
+			reg = <0x4600 0x100>;
+			clock-frequency = <0>;
+			interrupts = <28 2>;
+			interrupt-parent = <&mpic>;
+		};
+
+		mpic: pic@40000 {
+			clock-frequency = <0>;
+			interrupt-controller;
+			#address-cells = <0>;
+			#interrupt-cells = <2>;
+			reg = <0x40000 0x40000>;
+			compatible = "chrp,open-pic";
+			device_type = "open-pic";
+			big-endian;
+		};
+
+		global-utilities@e0000 {
+			compatible = "fsl,mpc8641-guts";
+			reg = <0xe0000 0x1000>;
+			fsl,has-rstcr;
+		};
+	};
+
+	pci0: pcie@f8008000 {
+		compatible = "fsl,mpc8641-pcie";
+		device_type = "pci";
+		#interrupt-cells = <1>;
+		#size-cells = <2>;
+		#address-cells = <3>;
+		reg = <0xf8008000 0x1000>;
+		bus-range = <0x0 0xff>;
+		ranges = <0x02000000 0x0 0x80000000 0x80000000 0x0 0x20000000
+			  0x01000000 0x0 0x00000000 0xe2000000 0x0 0x00100000>;
+		clock-frequency = <33333333>;
+		interrupt-parent = <&mpic>;
+		interrupts = <24 2>;
+		interrupt-map-mask = <0xff00 0 0 7>;
+		interrupt-map = <
+			/* IDSEL 0x0 */
+			0x0000 0 0 1 &mpic 0 1
+			0x0000 0 0 2 &mpic 1 1
+			0x0000 0 0 3 &mpic 2 1
+			0x0000 0 0 4 &mpic 3 1
+			>;
+
+		pcie@0 {
+			reg = <0 0 0 0 0>;
+			#size-cells = <2>;
+			#address-cells = <3>;
+			device_type = "pci";
+			ranges = <0x02000000 0x0 0x80000000
+				  0x02000000 0x0 0x80000000
+				  0x0 0x20000000
+
+				  0x01000000 0x0 0x00000000
+				  0x01000000 0x0 0x00000000
+				  0x0 0x00100000>;
+		};
+
+	};
+
+	pci1: pcie@f8009000 {
+		compatible = "fsl,mpc8641-pcie";
+		device_type = "pci";
+		#interrupt-cells = <1>;
+		#size-cells = <2>;
+		#address-cells = <3>;
+		reg = <0xf8009000 0x1000>;
+		bus-range = <0 0xff>;
+		ranges = <0x02000000 0x0 0xa0000000 0xa0000000 0x0 0x20000000
+			  0x01000000 0x0 0x00000000 0xe3000000 0x0 0x00100000>;
+		clock-frequency = <33333333>;
+		interrupt-parent = <&mpic>;
+		interrupts = <25 2>;
+		interrupt-map-mask = <0xf800 0 0 7>;
+		interrupt-map = <
+			/* IDSEL 0x0 */
+			0x0000 0 0 1 &mpic 4 1
+			0x0000 0 0 2 &mpic 5 1
+			0x0000 0 0 3 &mpic 6 1
+			0x0000 0 0 4 &mpic 7 1
+			>;
+
+		pcie@0 {
+			reg = <0 0 0 0 0>;
+			#size-cells = <2>;
+			#address-cells = <3>;
+			device_type = "pci";
+			ranges = <0x02000000 0x0 0xa0000000
+				  0x02000000 0x0 0xa0000000
+				  0x0 0x20000000
+
+				  0x01000000 0x0 0x00000000
+				  0x01000000 0x0 0x00000000
+				  0x0 0x00100000>;
+		};
+	};
+};
diff --git a/arch/powerpc/boot/dts/gef_ppc9a.dts b/arch/powerpc/boot/dts/gef_ppc9a.dts
deleted file mode 100644
index 83eb0fd..0000000
--- a/arch/powerpc/boot/dts/gef_ppc9a.dts
+++ /dev/null
@@ -1,425 +0,0 @@
-/*
- * GE PPC9A Device Tree Source
- *
- * Copyright 2008 GE Intelligent Platforms Embedded Systems, Inc.
- *
- * This program is free software; you can redistribute  it and/or modify it
- * under  the terms of  the GNU General  Public License as published by the
- * Free Software Foundation;  either version 2 of the  License, or (at your
- * option) any later version.
- *
- * Based on: SBS CM6 Device Tree Source
- * Copyright 2007 SBS Technologies GmbH & Co. KG
- * And: mpc8641_hpcn.dts (MPC8641 HPCN Device Tree Source)
- * Copyright 2006 Freescale Semiconductor Inc.
- */
-
-/*
- * Compiled with dtc -I dts -O dtb -o gef_ppc9a.dtb gef_ppc9a.dts
- */
-
-/dts-v1/;
-
-/ {
-	model = "GEF_PPC9A";
-	compatible = "gef,ppc9a";
-	#address-cells = <1>;
-	#size-cells = <1>;
-
-	aliases {
-		ethernet0 = &enet0;
-		ethernet1 = &enet1;
-		serial0 = &serial0;
-		serial1 = &serial1;
-		pci0 = &pci0;
-	};
-
-	cpus {
-		#address-cells = <1>;
-		#size-cells = <0>;
-
-		PowerPC,8641@0 {
-			device_type = "cpu";
-			reg = <0>;
-			d-cache-line-size = <32>;	// 32 bytes
-			i-cache-line-size = <32>;	// 32 bytes
-			d-cache-size = <32768>;		// L1, 32K
-			i-cache-size = <32768>;		// L1, 32K
-			timebase-frequency = <0>;	// From uboot
-			bus-frequency = <0>;		// From uboot
-			clock-frequency = <0>;		// From uboot
-		};
-		PowerPC,8641@1 {
-			device_type = "cpu";
-			reg = <1>;
-			d-cache-line-size = <32>;	// 32 bytes
-			i-cache-line-size = <32>;	// 32 bytes
-			d-cache-size = <32768>;		// L1, 32K
-			i-cache-size = <32768>;		// L1, 32K
-			timebase-frequency = <0>;	// From uboot
-			bus-frequency = <0>;		// From uboot
-			clock-frequency = <0>;		// From uboot
-		};
-	};
-
-	memory {
-		device_type = "memory";
-		reg = <0x0 0x40000000>;	// set by uboot
-	};
-
-	localbus@fef05000 {
-		#address-cells = <2>;
-		#size-cells = <1>;
-		compatible = "fsl,mpc8641-localbus", "simple-bus";
-		reg = <0xfef05000 0x1000>;
-		interrupts = <19 2>;
-		interrupt-parent = <&mpic>;
-
-		ranges = <0 0 0xff000000 0x01000000	// 16MB Boot flash
-			  1 0 0xe8000000 0x08000000	// Paged Flash 0
-			  2 0 0xe0000000 0x08000000	// Paged Flash 1
-			  3 0 0xfc100000 0x00020000	// NVRAM
-			  4 0 0xfc000000 0x00008000	// FPGA
-			  5 0 0xfc008000 0x00008000	// AFIX FPGA
-			  6 0 0xfd000000 0x00800000	// IO FPGA (8-bit)
-			  7 0 0xfd800000 0x00800000>;	// IO FPGA (32-bit)
-
-		/* flash@0,0 is a mirror of part of the memory in flash@1,0
-		flash@0,0 {
-			compatible = "gef,ppc9a-firmware-mirror", "cfi-flash";
-			reg = <0x0 0x0 0x1000000>;
-			bank-width = <4>;
-			device-width = <2>;
-			#address-cells = <1>;
-			#size-cells = <1>;
-			partition@0 {
-				label = "firmware";
-				reg = <0x0 0x1000000>;
-				read-only;
-			};
-		};
-		*/
-
-		flash@1,0 {
-			compatible = "gef,ppc9a-paged-flash", "cfi-flash";
-			reg = <0x1 0x0 0x8000000>;
-			bank-width = <4>;
-			device-width = <2>;
-			#address-cells = <1>;
-			#size-cells = <1>;
-			partition@0 {
-				label = "user";
-				reg = <0x0 0x7800000>;
-			};
-			partition@7800000 {
-				label = "firmware";
-				reg = <0x7800000 0x800000>;
-				read-only;
-			};
-		};
-
-		nvram@3,0 {
-			device_type = "nvram";
-			compatible = "simtek,stk14ca8";
-			reg = <0x3 0x0 0x20000>;
-		};
-
-		fpga@4,0 {
-			compatible = "gef,ppc9a-fpga-regs";
-			reg = <0x4 0x0 0x40>;
-		};
-
-		wdt@4,2000 {
-			compatible = "gef,ppc9a-fpga-wdt", "gef,fpga-wdt-1.00",
-				"gef,fpga-wdt";
-			reg = <0x4 0x2000 0x8>;
-			interrupts = <0x1a 0x4>;
-			interrupt-parent = <&gef_pic>;
-		};
-		/* Second watchdog available, driver currently supports one.
-		wdt@4,2010 {
-			compatible = "gef,ppc9a-fpga-wdt", "gef,fpga-wdt-1.00",
-				"gef,fpga-wdt";
-			reg = <0x4 0x2010 0x8>;
-			interrupts = <0x1b 0x4>;
-			interrupt-parent = <&gef_pic>;
-		};
-		*/
-		gef_pic: pic@4,4000 {
-			#interrupt-cells = <1>;
-			interrupt-controller;
-			compatible = "gef,ppc9a-fpga-pic", "gef,fpga-pic-1.00";
-			reg = <0x4 0x4000 0x20>;
-			interrupts = <0x8
-				      0x9>;
-			interrupt-parent = <&mpic>;
-
-		};
-		gef_gpio: gpio@7,14000 {
-			#gpio-cells = <2>;
-			compatible = "gef,ppc9a-gpio", "gef,sbc610-gpio";
-			reg = <0x7 0x14000 0x24>;
-			gpio-controller;
-		};
-	};
-
-	soc@fef00000 {
-		#address-cells = <1>;
-		#size-cells = <1>;
-		#interrupt-cells = <2>;
-		device_type = "soc";
-		compatible = "fsl,mpc8641-soc", "simple-bus";
-		ranges = <0x0 0xfef00000 0x00100000>;
-		bus-frequency = <33333333>;
-
-		mcm-law@0 {
-			compatible = "fsl,mcm-law";
-			reg = <0x0 0x1000>;
-			fsl,num-laws = <10>;
-		};
-
-		mcm@1000 {
-			compatible = "fsl,mpc8641-mcm", "fsl,mcm";
-			reg = <0x1000 0x1000>;
-			interrupts = <17 2>;
-			interrupt-parent = <&mpic>;
-		};
-
-		i2c1: i2c@3000 {
-			#address-cells = <1>;
-			#size-cells = <0>;
-			compatible = "fsl-i2c";
-			reg = <0x3000 0x100>;
-			interrupts = <0x2b 0x2>;
-			interrupt-parent = <&mpic>;
-			dfsrr;
-
-			hwmon@48 {
-				compatible = "national,lm92";
-				reg = <0x48>;
-			};
-
-			hwmon@4c {
-				compatible = "adi,adt7461";
-				reg = <0x4c>;
-			};
-
-			rtc@51 {
-				compatible = "epson,rx8581";
-				reg = <0x00000051>;
-			};
-
-			eti@6b {
-				compatible = "dallas,ds1682";
-				reg = <0x6b>;
-			};
-		};
-
-		i2c2: i2c@3100 {
-			#address-cells = <1>;
-			#size-cells = <0>;
-			compatible = "fsl-i2c";
-			reg = <0x3100 0x100>;
-			interrupts = <0x2b 0x2>;
-			interrupt-parent = <&mpic>;
-			dfsrr;
-		};
-
-		dma@21300 {
-			#address-cells = <1>;
-			#size-cells = <1>;
-			compatible = "fsl,mpc8641-dma", "fsl,eloplus-dma";
-			reg = <0x21300 0x4>;
-			ranges = <0x0 0x21100 0x200>;
-			cell-index = <0>;
-			dma-channel@0 {
-				compatible = "fsl,mpc8641-dma-channel",
-					   "fsl,eloplus-dma-channel";
-				reg = <0x0 0x80>;
-				cell-index = <0>;
-				interrupt-parent = <&mpic>;
-				interrupts = <20 2>;
-			};
-			dma-channel@80 {
-				compatible = "fsl,mpc8641-dma-channel",
-					   "fsl,eloplus-dma-channel";
-				reg = <0x80 0x80>;
-				cell-index = <1>;
-				interrupt-parent = <&mpic>;
-				interrupts = <21 2>;
-			};
-			dma-channel@100 {
-				compatible = "fsl,mpc8641-dma-channel",
-					   "fsl,eloplus-dma-channel";
-				reg = <0x100 0x80>;
-				cell-index = <2>;
-				interrupt-parent = <&mpic>;
-				interrupts = <22 2>;
-			};
-			dma-channel@180 {
-				compatible = "fsl,mpc8641-dma-channel",
-					   "fsl,eloplus-dma-channel";
-				reg = <0x180 0x80>;
-				cell-index = <3>;
-				interrupt-parent = <&mpic>;
-				interrupts = <23 2>;
-			};
-		};
-
-		enet0: ethernet@24000 {
-			#address-cells = <1>;
-			#size-cells = <1>;
-			cell-index = <0>;
-			device_type = "network";
-			model = "TSEC";
-			compatible = "gianfar";
-			reg = <0x24000 0x1000>;
-			ranges = <0x0 0x24000 0x1000>;
-			local-mac-address = [ 00 00 00 00 00 00 ];
-			interrupts = <29 2 30  2 34 2>;
-			interrupt-parent = <&mpic>;
-			tbi-handle = <&tbi0>;
-			phy-handle = <&phy0>;
-			phy-connection-type = "gmii";
-
-			mdio@520 {
-				#address-cells = <1>;
-				#size-cells = <0>;
-				compatible = "fsl,gianfar-mdio";
-				reg = <0x520 0x20>;
-
-				phy0: ethernet-phy@0 {
-					interrupt-parent = <&gef_pic>;
-					interrupts = <0x9 0x4>;
-					reg = <1>;
-				};
-				phy2: ethernet-phy@2 {
-					interrupt-parent = <&gef_pic>;
-					interrupts = <0x8 0x4>;
-					reg = <3>;
-				};
-				tbi0: tbi-phy@11 {
-					reg = <0x11>;
-					device_type = "tbi-phy";
-				};
-			};
-		};
-
-		enet1: ethernet@26000 {
-			#address-cells = <1>;
-			#size-cells = <1>;
-			cell-index = <2>;
-			device_type = "network";
-			model = "TSEC";
-			compatible = "gianfar";
-			reg = <0x26000 0x1000>;
-			ranges = <0x0 0x26000 0x1000>;
-			local-mac-address = [ 00 00 00 00 00 00 ];
-			interrupts = <31 2 32 2 33 2>;
-			interrupt-parent = <&mpic>;
-			tbi-handle = <&tbi2>;
-			phy-handle = <&phy2>;
-			phy-connection-type = "gmii";
-
-			mdio@520 {
-				#address-cells = <1>;
-				#size-cells = <0>;
-				compatible = "fsl,gianfar-tbi";
-				reg = <0x520 0x20>;
-
-				tbi2: tbi-phy@11 {
-					reg = <0x11>;
-					device_type = "tbi-phy";
-				};
-			};
-		};
-
-		serial0: serial@4500 {
-			cell-index = <0>;
-			device_type = "serial";
-			compatible = "fsl,ns16550", "ns16550";
-			reg = <0x4500 0x100>;
-			clock-frequency = <0>;
-			interrupts = <0x2a 0x2>;
-			interrupt-parent = <&mpic>;
-		};
-
-		serial1: serial@4600 {
-			cell-index = <1>;
-			device_type = "serial";
-			compatible = "fsl,ns16550", "ns16550";
-			reg = <0x4600 0x100>;
-			clock-frequency = <0>;
-			interrupts = <0x1c 0x2>;
-			interrupt-parent = <&mpic>;
-		};
-
-		mpic: pic@40000 {
-			clock-frequency = <0>;
-			interrupt-controller;
-			#address-cells = <0>;
-			#interrupt-cells = <2>;
-			reg = <0x40000 0x40000>;
-			compatible = "chrp,open-pic";
-			device_type = "open-pic";
-		};
-
-		msi@41600 {
-			compatible = "fsl,mpc8641-msi", "fsl,mpic-msi";
-			reg = <0x41600 0x80>;
-			msi-available-ranges = <0 0x100>;
-			interrupts = <
-				0xe0 0
-				0xe1 0
-				0xe2 0
-				0xe3 0
-				0xe4 0
-				0xe5 0
-				0xe6 0
-				0xe7 0>;
-			interrupt-parent = <&mpic>;
-		};
-
-		global-utilities@e0000 {
-			compatible = "fsl,mpc8641-guts";
-			reg = <0xe0000 0x1000>;
-			fsl,has-rstcr;
-		};
-	};
-
-	pci0: pcie@fef08000 {
-		compatible = "fsl,mpc8641-pcie";
-		device_type = "pci";
-		#interrupt-cells = <1>;
-		#size-cells = <2>;
-		#address-cells = <3>;
-		reg = <0xfef08000 0x1000>;
-		bus-range = <0x0 0xff>;
-		ranges = <0x02000000 0x0 0x80000000 0x80000000 0x0 0x40000000
-			  0x01000000 0x0 0x00000000 0xfe000000 0x0 0x00400000>;
-		clock-frequency = <33333333>;
-		interrupt-parent = <&mpic>;
-		interrupts = <0x18 0x2>;
-		interrupt-map-mask = <0xf800 0x0 0x0 0x7>;
-		interrupt-map = <
-			0x0000 0x0 0x0 0x1 &mpic 0x0 0x1
-			0x0000 0x0 0x0 0x2 &mpic 0x1 0x1
-			0x0000 0x0 0x0 0x3 &mpic 0x2 0x1
-			0x0000 0x0 0x0 0x4 &mpic 0x3 0x1
-		>;
-
-		pcie@0 {
-			reg = <0 0 0 0 0>;
-			#size-cells = <2>;
-			#address-cells = <3>;
-			device_type = "pci";
-			ranges = <0x02000000 0x0 0x80000000
-				  0x02000000 0x0 0x80000000
-				  0x0 0x40000000
-
-				  0x01000000 0x0 0x00000000
-				  0x01000000 0x0 0x00000000
-				  0x0 0x00400000>;
-		};
-	};
-};
diff --git a/arch/powerpc/boot/dts/gef_sbc310.dts b/arch/powerpc/boot/dts/gef_sbc310.dts
deleted file mode 100644
index d426dd3..0000000
--- a/arch/powerpc/boot/dts/gef_sbc310.dts
+++ /dev/null
@@ -1,459 +0,0 @@
-/*
- * GE SBC310 Device Tree Source
- *
- * Copyright 2008 GE Intelligent Platforms Embedded Systems, Inc.
- *
- * This program is free software; you can redistribute  it and/or modify it
- * under  the terms of  the GNU General  Public License as published by the
- * Free Software Foundation;  either version 2 of the  License, or (at your
- * option) any later version.
- *
- * Based on: SBS CM6 Device Tree Source
- * Copyright 2007 SBS Technologies GmbH & Co. KG
- * And: mpc8641_hpcn.dts (MPC8641 HPCN Device Tree Source)
- * Copyright 2006 Freescale Semiconductor Inc.
- */
-
-/*
- * Compiled with dtc -I dts -O dtb -o gef_sbc310.dtb gef_sbc310.dts
- */
-
-/dts-v1/;
-
-/ {
-	model = "GEF_SBC310";
-	compatible = "gef,sbc310";
-	#address-cells = <1>;
-	#size-cells = <1>;
-
-	aliases {
-		ethernet0 = &enet0;
-		ethernet1 = &enet1;
-		serial0 = &serial0;
-		serial1 = &serial1;
-		pci0 = &pci0;
-		pci1 = &pci1;
-	};
-
-	cpus {
-		#address-cells = <1>;
-		#size-cells = <0>;
-
-		PowerPC,8641@0 {
-			device_type = "cpu";
-			reg = <0>;
-			d-cache-line-size = <32>;	// 32 bytes
-			i-cache-line-size = <32>;	// 32 bytes
-			d-cache-size = <32768>;		// L1, 32K
-			i-cache-size = <32768>;		// L1, 32K
-			timebase-frequency = <0>;	// From uboot
-			bus-frequency = <0>;		// From uboot
-			clock-frequency = <0>;		// From uboot
-		};
-		PowerPC,8641@1 {
-			device_type = "cpu";
-			reg = <1>;
-			d-cache-line-size = <32>;	// 32 bytes
-			i-cache-line-size = <32>;	// 32 bytes
-			d-cache-size = <32768>;		// L1, 32K
-			i-cache-size = <32768>;		// L1, 32K
-			timebase-frequency = <0>;	// From uboot
-			bus-frequency = <0>;		// From uboot
-			clock-frequency = <0>;		// From uboot
-		};
-	};
-
-	memory {
-		device_type = "memory";
-		reg = <0x0 0x40000000>;	// set by uboot
-	};
-
-	localbus@fef05000 {
-		#address-cells = <2>;
-		#size-cells = <1>;
-		compatible = "fsl,mpc8641-localbus", "simple-bus";
-		reg = <0xfef05000 0x1000>;
-		interrupts = <19 2>;
-		interrupt-parent = <&mpic>;
-
-		ranges = <0 0 0xff000000 0x01000000	// 16MB Boot flash
-			  1 0 0xe0000000 0x08000000	// Paged Flash 0
-			  2 0 0xe8000000 0x08000000	// Paged Flash 1
-			  3 0 0xfc100000 0x00020000	// NVRAM
-			  4 0 0xfc000000 0x00010000>;	// FPGA
-
-		/* flash@0,0 is a mirror of part of the memory in flash@1,0
-		flash@0,0 {
-			compatible = "gef,sbc310-firmware-mirror", "cfi-flash";
-			reg = <0x0 0x0 0x01000000>;
-			bank-width = <2>;
-			device-width = <2>;
-			#address-cells = <1>;
-			#size-cells = <1>;
-			partition@0 {
-				label = "firmware";
-				reg = <0x0 0x01000000>;
-				read-only;
-			};
-		};
-		*/
-
-		flash@1,0 {
-			compatible = "gef,sbc310-paged-flash", "cfi-flash";
-			reg = <0x1 0x0 0x8000000>;
-			bank-width = <2>;
-			device-width = <2>;
-			#address-cells = <1>;
-			#size-cells = <1>;
-			partition@0 {
-				label = "user";
-				reg = <0x0 0x7800000>;
-			};
-			partition@7800000 {
-				label = "firmware";
-				reg = <0x7800000 0x800000>;
-				read-only;
-			};
-		};
-
-		nvram@3,0 {
-			device_type = "nvram";
-			compatible = "simtek,stk14ca8";
-			reg = <0x3 0x0 0x20000>;
-		};
-
-		fpga@4,0 {
-			compatible = "gef,fpga-regs";
-			reg = <0x4 0x0 0x40>;
-		};
-
-		wdt@4,2000 {
-			compatible = "gef,sbc310-fpga-wdt", "gef,fpga-wdt-1.00",
-				"gef,fpga-wdt";
-			reg = <0x4 0x2000 0x8>;
-			interrupts = <0x1a 0x4>;
-			interrupt-parent = <&gef_pic>;
-		};
-/*
-		wdt@4,2010 {
-			compatible = "gef,sbc310-fpga-wdt", "gef,fpga-wdt-1.00",
-				"gef,fpga-wdt";
-			reg = <0x4 0x2010 0x8>;
-			interrupts = <0x1b 0x4>;
-			interrupt-parent = <&gef_pic>;
-		};
-*/
-		gef_pic: pic@4,4000 {
-			#interrupt-cells = <1>;
-			interrupt-controller;
-			compatible = "gef,sbc310-fpga-pic", "gef,fpga-pic";
-			reg = <0x4 0x4000 0x20>;
-			interrupts = <0x8
-				      0x9>;
-			interrupt-parent = <&mpic>;
-
-		};
-		gef_gpio: gpio@4,8000 {
-			#gpio-cells = <2>;
-			compatible = "gef,sbc310-gpio";
-			reg = <0x4 0x8000 0x24>;
-			gpio-controller;
-		};
-	};
-
-	soc@fef00000 {
-		#address-cells = <1>;
-		#size-cells = <1>;
-		#interrupt-cells = <2>;
-		device_type = "soc";
-		compatible = "fsl,mpc8641-soc", "simple-bus";
-		ranges = <0x0 0xfef00000 0x00100000>;
-		bus-frequency = <33333333>;
-
-		mcm-law@0 {
-			compatible = "fsl,mcm-law";
-			reg = <0x0 0x1000>;
-			fsl,num-laws = <10>;
-		};
-
-		mcm@1000 {
-			compatible = "fsl,mpc8641-mcm", "fsl,mcm";
-			reg = <0x1000 0x1000>;
-			interrupts = <17 2>;
-			interrupt-parent = <&mpic>;
-		};
-
-		i2c1: i2c@3000 {
-			#address-cells = <1>;
-			#size-cells = <0>;
-			compatible = "fsl-i2c";
-			reg = <0x3000 0x100>;
-			interrupts = <0x2b 0x2>;
-			interrupt-parent = <&mpic>;
-			dfsrr;
-
-			rtc@51 {
-				compatible = "epson,rx8581";
-				reg = <0x00000051>;
-			};
-		};
-
-		i2c2: i2c@3100 {
-			#address-cells = <1>;
-			#size-cells = <0>;
-			compatible = "fsl-i2c";
-			reg = <0x3100 0x100>;
-			interrupts = <0x2b 0x2>;
-			interrupt-parent = <&mpic>;
-			dfsrr;
-
-			hwmon@48 {
-				compatible = "national,lm92";
-				reg = <0x48>;
-			};
-
-			hwmon@4c {
-				compatible = "adi,adt7461";
-				reg = <0x4c>;
-			};
-
-			eti@6b {
-				compatible = "dallas,ds1682";
-				reg = <0x6b>;
-			};
-		};
-
-		dma@21300 {
-			#address-cells = <1>;
-			#size-cells = <1>;
-			compatible = "fsl,mpc8641-dma", "fsl,eloplus-dma";
-			reg = <0x21300 0x4>;
-			ranges = <0x0 0x21100 0x200>;
-			cell-index = <0>;
-			dma-channel@0 {
-				compatible = "fsl,mpc8641-dma-channel",
-					   "fsl,eloplus-dma-channel";
-				reg = <0x0 0x80>;
-				cell-index = <0>;
-				interrupt-parent = <&mpic>;
-				interrupts = <20 2>;
-			};
-			dma-channel@80 {
-				compatible = "fsl,mpc8641-dma-channel",
-					   "fsl,eloplus-dma-channel";
-				reg = <0x80 0x80>;
-				cell-index = <1>;
-				interrupt-parent = <&mpic>;
-				interrupts = <21 2>;
-			};
-			dma-channel@100 {
-				compatible = "fsl,mpc8641-dma-channel",
-					   "fsl,eloplus-dma-channel";
-				reg = <0x100 0x80>;
-				cell-index = <2>;
-				interrupt-parent = <&mpic>;
-				interrupts = <22 2>;
-			};
-			dma-channel@180 {
-				compatible = "fsl,mpc8641-dma-channel",
-					   "fsl,eloplus-dma-channel";
-				reg = <0x180 0x80>;
-				cell-index = <3>;
-				interrupt-parent = <&mpic>;
-				interrupts = <23 2>;
-			};
-		};
-
-		enet0: ethernet@24000 {
-			#address-cells = <1>;
-			#size-cells = <1>;
-			cell-index = <0>;
-			device_type = "network";
-			model = "TSEC";
-			compatible = "gianfar";
-			reg = <0x24000 0x1000>;
-			ranges = <0x0 0x24000 0x1000>;
-			local-mac-address = [ 00 00 00 00 00 00 ];
-			interrupts = <29 2 30  2 34 2>;
-			interrupt-parent = <&mpic>;
-			tbi-handle = <&tbi0>;
-			phy-handle = <&phy0>;
-			phy-connection-type = "gmii";
-
-			mdio@520 {
-				#address-cells = <1>;
-				#size-cells = <0>;
-				compatible = "fsl,gianfar-mdio";
-				reg = <0x520 0x20>;
-
-				phy0: ethernet-phy@0 {
-					interrupt-parent = <&gef_pic>;
-					interrupts = <0x9 0x4>;
-					reg = <1>;
-				};
-				phy2: ethernet-phy@2 {
-					interrupt-parent = <&gef_pic>;
-					interrupts = <0x8 0x4>;
-					reg = <3>;
-				};
-				tbi0: tbi-phy@11 {
-					reg = <0x11>;
-					device_type = "tbi-phy";
-				};
-			};
-		};
-
-		enet1: ethernet@26000 {
-			#address-cells = <1>;
-			#size-cells = <1>;
-			cell-index = <2>;
-			device_type = "network";
-			model = "TSEC";
-			compatible = "gianfar";
-			reg = <0x26000 0x1000>;
-			ranges = <0x0 0x26000 0x1000>;
-			local-mac-address = [ 00 00 00 00 00 00 ];
-			interrupts = <31 2 32 2 33 2>;
-			interrupt-parent = <&mpic>;
-			tbi-handle = <&tbi2>;
-			phy-handle = <&phy2>;
-			phy-connection-type = "gmii";
-
-			mdio@520 {
-				#address-cells = <1>;
-				#size-cells = <0>;
-				compatible = "fsl,gianfar-tbi";
-				reg = <0x520 0x20>;
-
-				tbi2: tbi-phy@11 {
-					reg = <0x11>;
-					device_type = "tbi-phy";
-				};
-			};
-		};
-
-		serial0: serial@4500 {
-			cell-index = <0>;
-			device_type = "serial";
-			compatible = "fsl,ns16550", "ns16550";
-			reg = <0x4500 0x100>;
-			clock-frequency = <0>;
-			interrupts = <0x2a 0x2>;
-			interrupt-parent = <&mpic>;
-		};
-
-		serial1: serial@4600 {
-			cell-index = <1>;
-			device_type = "serial";
-			compatible = "fsl,ns16550", "ns16550";
-			reg = <0x4600 0x100>;
-			clock-frequency = <0>;
-			interrupts = <0x1c 0x2>;
-			interrupt-parent = <&mpic>;
-		};
-
-		mpic: pic@40000 {
-			clock-frequency = <0>;
-			interrupt-controller;
-			#address-cells = <0>;
-			#interrupt-cells = <2>;
-			reg = <0x40000 0x40000>;
-			compatible = "chrp,open-pic";
-			device_type = "open-pic";
-		};
-
-		msi@41600 {
-			compatible = "fsl,mpc8641-msi", "fsl,mpic-msi";
-			reg = <0x41600 0x80>;
-			msi-available-ranges = <0 0x100>;
-			interrupts = <
-				0xe0 0
-				0xe1 0
-				0xe2 0
-				0xe3 0
-				0xe4 0
-				0xe5 0
-				0xe6 0
-				0xe7 0>;
-			interrupt-parent = <&mpic>;
-		};
-
-		global-utilities@e0000 {
-			compatible = "fsl,mpc8641-guts";
-			reg = <0xe0000 0x1000>;
-			fsl,has-rstcr;
-		};
-	};
-
-	pci0: pcie@fef08000 {
-		compatible = "fsl,mpc8641-pcie";
-		device_type = "pci";
-		#interrupt-cells = <1>;
-		#size-cells = <2>;
-		#address-cells = <3>;
-		reg = <0xfef08000 0x1000>;
-		bus-range = <0x0 0xff>;
-		ranges = <0x02000000 0x0 0x80000000 0x80000000 0x0 0x40000000
-			  0x01000000 0x0 0x00000000 0xfe000000 0x0 0x00400000>;
-		clock-frequency = <33333333>;
-		interrupt-parent = <&mpic>;
-		interrupts = <0x18 0x2>;
-		interrupt-map-mask = <0xff00 0x0 0x0 0x7>;
-		interrupt-map = <
-			0x0000 0x0 0x0 0x1 &mpic 0x0 0x2
-			0x0000 0x0 0x0 0x2 &mpic 0x1 0x2
-			0x0000 0x0 0x0 0x3 &mpic 0x2 0x2
-			0x0000 0x0 0x0 0x4 &mpic 0x3 0x2
-		>;
-
-		pcie@0 {
-			reg = <0 0 0 0 0>;
-			#size-cells = <2>;
-			#address-cells = <3>;
-			device_type = "pci";
-			ranges = <0x02000000 0x0 0x80000000
-				  0x02000000 0x0 0x80000000
-				  0x0 0x40000000
-
-				  0x01000000 0x0 0x00000000
-				  0x01000000 0x0 0x00000000
-				  0x0 0x00400000>;
-		};
-	};
-
-	pci1: pcie@fef09000 {
-		compatible = "fsl,mpc8641-pcie";
-		device_type = "pci";
-		#interrupt-cells = <1>;
-		#size-cells = <2>;
-		#address-cells = <3>;
-		reg = <0xfef09000 0x1000>;
-		bus-range = <0x0 0xff>;
-		ranges = <0x02000000 0x0 0xc0000000 0xc0000000 0x0 0x20000000
-			  0x01000000 0x0 0x00000000 0xfe400000 0x0 0x00400000>;
-		clock-frequency = <33333333>;
-		interrupt-parent = <&mpic>;
-		interrupts = <0x19 0x2>;
-		interrupt-map-mask = <0xf800 0x0 0x0 0x7>;
-		interrupt-map = <
-			0x0000 0x0 0x0 0x1 &mpic 0x4 0x2
-			0x0000 0x0 0x0 0x2 &mpic 0x5 0x2
-			0x0000 0x0 0x0 0x3 &mpic 0x6 0x2
-			0x0000 0x0 0x0 0x4 &mpic 0x7 0x2
-			>;
-
-		pcie@0 {
-			reg = <0 0 0 0 0>;
-			#size-cells = <2>;
-			#address-cells = <3>;
-			device_type = "pci";
-			ranges = <0x02000000 0x0 0xc0000000
-				  0x02000000 0x0 0xc0000000
-				  0x0 0x20000000
-
-				  0x01000000 0x0 0x00000000
-				  0x01000000 0x0 0x00000000
-				  0x0 0x00400000>;
-		};
-	};
-};
diff --git a/arch/powerpc/boot/dts/gef_sbc610.dts b/arch/powerpc/boot/dts/gef_sbc610.dts
deleted file mode 100644
index 5db3399..0000000
--- a/arch/powerpc/boot/dts/gef_sbc610.dts
+++ /dev/null
@@ -1,423 +0,0 @@
-/*
- * GE SBC610 Device Tree Source
- *
- * Copyright 2008 GE Intelligent Platforms Embedded Systems, Inc.
- *
- * This program is free software; you can redistribute  it and/or modify it
- * under  the terms of  the GNU General  Public License as published by the
- * Free Software Foundation;  either version 2 of the  License, or (at your
- * option) any later version.
- *
- * Based on: SBS CM6 Device Tree Source
- * Copyright 2007 SBS Technologies GmbH & Co. KG
- * And: mpc8641_hpcn.dts (MPC8641 HPCN Device Tree Source)
- * Copyright 2006 Freescale Semiconductor Inc.
- */
-
-/*
- * Compiled with dtc -I dts -O dtb -o gef_sbc610.dtb gef_sbc610.dts
- */
-
-/dts-v1/;
-
-/ {
-	model = "GEF_SBC610";
-	compatible = "gef,sbc610";
-	#address-cells = <1>;
-	#size-cells = <1>;
-
-	aliases {
-		ethernet0 = &enet0;
-		ethernet1 = &enet1;
-		serial0 = &serial0;
-		serial1 = &serial1;
-		pci0 = &pci0;
-	};
-
-	cpus {
-		#address-cells = <1>;
-		#size-cells = <0>;
-
-		PowerPC,8641@0 {
-			device_type = "cpu";
-			reg = <0>;
-			d-cache-line-size = <32>;	// 32 bytes
-			i-cache-line-size = <32>;	// 32 bytes
-			d-cache-size = <32768>;		// L1, 32K
-			i-cache-size = <32768>;		// L1, 32K
-			timebase-frequency = <0>;	// From uboot
-			bus-frequency = <0>;		// From uboot
-			clock-frequency = <0>;		// From uboot
-		};
-		PowerPC,8641@1 {
-			device_type = "cpu";
-			reg = <1>;
-			d-cache-line-size = <32>;	// 32 bytes
-			i-cache-line-size = <32>;	// 32 bytes
-			d-cache-size = <32768>;		// L1, 32K
-			i-cache-size = <32768>;		// L1, 32K
-			timebase-frequency = <0>;	// From uboot
-			bus-frequency = <0>;		// From uboot
-			clock-frequency = <0>;		// From uboot
-		};
-	};
-
-	memory {
-		device_type = "memory";
-		reg = <0x0 0x40000000>;	// set by uboot
-	};
-
-	localbus@fef05000 {
-		#address-cells = <2>;
-		#size-cells = <1>;
-		compatible = "fsl,mpc8641-localbus", "simple-bus";
-		reg = <0xfef05000 0x1000>;
-		interrupts = <19 2>;
-		interrupt-parent = <&mpic>;
-
-		ranges = <0 0 0xff000000 0x01000000	// 16MB Boot flash
-			  1 0 0xe8000000 0x08000000	// Paged Flash 0
-			  2 0 0xe0000000 0x08000000	// Paged Flash 1
-			  3 0 0xfc100000 0x00020000	// NVRAM
-			  4 0 0xfc000000 0x00008000	// FPGA
-			  5 0 0xfc008000 0x00008000	// AFIX FPGA
-			  6 0 0xfd000000 0x00800000	// IO FPGA (8-bit)
-			  7 0 0xfd800000 0x00800000>;	// IO FPGA (32-bit)
-
-		/* flash@0,0 is a mirror of part of the memory in flash@1,0
-		flash@0,0 {
-			compatible = "gef,sbc610-firmware-mirror", "cfi-flash";
-			reg = <0x0 0x0 0x1000000>;
-			bank-width = <4>;
-			device-width = <2>;
-			#address-cells = <1>;
-			#size-cells = <1>;
-			partition@0 {
-				label = "firmware";
-				reg = <0x0 0x1000000>;
-				read-only;
-			};
-		};
-		*/
-
-		flash@1,0 {
-			compatible = "gef,sbc610-paged-flash", "cfi-flash";
-			reg = <0x1 0x0 0x8000000>;
-			bank-width = <4>;
-			device-width = <2>;
-			#address-cells = <1>;
-			#size-cells = <1>;
-			partition@0 {
-				label = "user";
-				reg = <0x0 0x7800000>;
-			};
-			partition@7800000 {
-				label = "firmware";
-				reg = <0x7800000 0x800000>;
-				read-only;
-			};
-		};
-
-		nvram@3,0 {
-			device_type = "nvram";
-			compatible = "simtek,stk14ca8";
-			reg = <0x3 0x0 0x20000>;
-		};
-
-		fpga@4,0 {
-			compatible = "gef,fpga-regs";
-			reg = <0x4 0x0 0x40>;
-		};
-
-		wdt@4,2000 {
-			compatible = "gef,fpga-wdt";
-			reg = <0x4 0x2000 0x8>;
-			interrupts = <0x1a 0x4>;
-			interrupt-parent = <&gef_pic>;
-		};
-		/* Second watchdog available, driver currently supports one.
-		wdt@4,2010 {
-			compatible = "gef,fpga-wdt";
-			reg = <0x4 0x2010 0x8>;
-			interrupts = <0x1b 0x4>;
-			interrupt-parent = <&gef_pic>;
-		};
-		*/
-		gef_pic: pic@4,4000 {
-			#interrupt-cells = <1>;
-			interrupt-controller;
-			compatible = "gef,fpga-pic";
-			reg = <0x4 0x4000 0x20>;
-			interrupts = <0x8
-				      0x9>;
-			interrupt-parent = <&mpic>;
-
-		};
-		gef_gpio: gpio@7,14000 {
-			#gpio-cells = <2>;
-			compatible = "gef,sbc610-gpio";
-			reg = <0x7 0x14000 0x24>;
-			gpio-controller;
-		};
-	};
-
-	soc@fef00000 {
-		#address-cells = <1>;
-		#size-cells = <1>;
-		#interrupt-cells = <2>;
-		device_type = "soc";
-		compatible = "simple-bus";
-		ranges = <0x0 0xfef00000 0x00100000>;
-		bus-frequency = <33333333>;
-
-		mcm-law@0 {
-			compatible = "fsl,mcm-law";
-			reg = <0x0 0x1000>;
-			fsl,num-laws = <10>;
-		};
-
-		mcm@1000 {
-			compatible = "fsl,mpc8641-mcm", "fsl,mcm";
-			reg = <0x1000 0x1000>;
-			interrupts = <17 2>;
-			interrupt-parent = <&mpic>;
-		};
-
-		i2c1: i2c@3000 {
-			#address-cells = <1>;
-			#size-cells = <0>;
-			compatible = "fsl-i2c";
-			reg = <0x3000 0x100>;
-			interrupts = <0x2b 0x2>;
-			interrupt-parent = <&mpic>;
-			dfsrr;
-
-			hwmon@48 {
-				compatible = "national,lm92";
-				reg = <0x48>;
-			};
-
-			hwmon@4c {
-				compatible = "adi,adt7461";
-				reg = <0x4c>;
-			};
-
-			rtc@51 {
-				compatible = "epson,rx8581";
-				reg = <0x00000051>;
-			};
-
-			eti@6b {
-				compatible = "dallas,ds1682";
-				reg = <0x6b>;
-			};
-		};
-
-		i2c2: i2c@3100 {
-			#address-cells = <1>;
-			#size-cells = <0>;
-			compatible = "fsl-i2c";
-			reg = <0x3100 0x100>;
-			interrupts = <0x2b 0x2>;
-			interrupt-parent = <&mpic>;
-			dfsrr;
-		};
-
-		dma@21300 {
-			#address-cells = <1>;
-			#size-cells = <1>;
-			compatible = "fsl,mpc8641-dma", "fsl,eloplus-dma";
-			reg = <0x21300 0x4>;
-			ranges = <0x0 0x21100 0x200>;
-			cell-index = <0>;
-			dma-channel@0 {
-				compatible = "fsl,mpc8641-dma-channel",
-					   "fsl,eloplus-dma-channel";
-				reg = <0x0 0x80>;
-				cell-index = <0>;
-				interrupt-parent = <&mpic>;
-				interrupts = <20 2>;
-			};
-			dma-channel@80 {
-				compatible = "fsl,mpc8641-dma-channel",
-					   "fsl,eloplus-dma-channel";
-				reg = <0x80 0x80>;
-				cell-index = <1>;
-				interrupt-parent = <&mpic>;
-				interrupts = <21 2>;
-			};
-			dma-channel@100 {
-				compatible = "fsl,mpc8641-dma-channel",
-					   "fsl,eloplus-dma-channel";
-				reg = <0x100 0x80>;
-				cell-index = <2>;
-				interrupt-parent = <&mpic>;
-				interrupts = <22 2>;
-			};
-			dma-channel@180 {
-				compatible = "fsl,mpc8641-dma-channel",
-					   "fsl,eloplus-dma-channel";
-				reg = <0x180 0x80>;
-				cell-index = <3>;
-				interrupt-parent = <&mpic>;
-				interrupts = <23 2>;
-			};
-		};
-
-		enet0: ethernet@24000 {
-			#address-cells = <1>;
-			#size-cells = <1>;
-			cell-index = <0>;
-			device_type = "network";
-			model = "TSEC";
-			compatible = "gianfar";
-			reg = <0x24000 0x1000>;
-			ranges = <0x0 0x24000 0x1000>;
-			local-mac-address = [ 00 00 00 00 00 00 ];
-			interrupts = <29 2 30  2 34 2>;
-			interrupt-parent = <&mpic>;
-			tbi-handle = <&tbi0>;
-			phy-handle = <&phy0>;
-			phy-connection-type = "gmii";
-
-			mdio@520 {
-				#address-cells = <1>;
-				#size-cells = <0>;
-				compatible = "fsl,gianfar-mdio";
-				reg = <0x520 0x20>;
-
-				phy0: ethernet-phy@0 {
-					interrupt-parent = <&gef_pic>;
-					interrupts = <0x9 0x4>;
-					reg = <1>;
-				};
-				phy2: ethernet-phy@2 {
-					interrupt-parent = <&gef_pic>;
-					interrupts = <0x8 0x4>;
-					reg = <3>;
-				};
-				tbi0: tbi-phy@11 {
-					reg = <0x11>;
-					device_type = "tbi-phy";
-				};
-			};
-		};
-
-		enet1: ethernet@26000 {
-			#address-cells = <1>;
-			#size-cells = <1>;
-			cell-index = <2>;
-			device_type = "network";
-			model = "TSEC";
-			compatible = "gianfar";
-			reg = <0x26000 0x1000>;
-			ranges = <0x0 0x26000 0x1000>;
-			local-mac-address = [ 00 00 00 00 00 00 ];
-			interrupts = <31 2 32 2 33 2>;
-			interrupt-parent = <&mpic>;
-			tbi-handle = <&tbi2>;
-			phy-handle = <&phy2>;
-			phy-connection-type = "gmii";
-
-			mdio@520 {
-				#address-cells = <1>;
-				#size-cells = <0>;
-				compatible = "fsl,gianfar-tbi";
-				reg = <0x520 0x20>;
-
-				tbi2: tbi-phy@11 {
-					reg = <0x11>;
-					device_type = "tbi-phy";
-				};
-			};
-		};
-
-		serial0: serial@4500 {
-			cell-index = <0>;
-			device_type = "serial";
-			compatible = "fsl,ns16550", "ns16550";
-			reg = <0x4500 0x100>;
-			clock-frequency = <0>;
-			interrupts = <0x2a 0x2>;
-			interrupt-parent = <&mpic>;
-		};
-
-		serial1: serial@4600 {
-			cell-index = <1>;
-			device_type = "serial";
-			compatible = "fsl,ns16550", "ns16550";
-			reg = <0x4600 0x100>;
-			clock-frequency = <0>;
-			interrupts = <0x1c 0x2>;
-			interrupt-parent = <&mpic>;
-		};
-
-		mpic: pic@40000 {
-			clock-frequency = <0>;
-			interrupt-controller;
-			#address-cells = <0>;
-			#interrupt-cells = <2>;
-			reg = <0x40000 0x40000>;
-			compatible = "chrp,open-pic";
-			device_type = "open-pic";
-		};
-
-		msi@41600 {
-			compatible = "fsl,mpc8641-msi", "fsl,mpic-msi";
-			reg = <0x41600 0x80>;
-			msi-available-ranges = <0 0x100>;
-			interrupts = <
-				0xe0 0
-				0xe1 0
-				0xe2 0
-				0xe3 0
-				0xe4 0
-				0xe5 0
-				0xe6 0
-				0xe7 0>;
-			interrupt-parent = <&mpic>;
-		};
-
-		global-utilities@e0000 {
-			compatible = "fsl,mpc8641-guts";
-			reg = <0xe0000 0x1000>;
-			fsl,has-rstcr;
-		};
-	};
-
-	pci0: pcie@fef08000 {
-		compatible = "fsl,mpc8641-pcie";
-		device_type = "pci";
-		#interrupt-cells = <1>;
-		#size-cells = <2>;
-		#address-cells = <3>;
-		reg = <0xfef08000 0x1000>;
-		bus-range = <0x0 0xff>;
-		ranges = <0x02000000 0x0 0x80000000 0x80000000 0x0 0x40000000
-			  0x01000000 0x0 0x00000000 0xfe000000 0x0 0x00400000>;
-		clock-frequency = <33333333>;
-		interrupt-parent = <&mpic>;
-		interrupts = <0x18 0x2>;
-		interrupt-map-mask = <0xf800 0x0 0x0 0x7>;
-		interrupt-map = <
-			0x0000 0x0 0x0 0x1 &mpic 0x0 0x1
-			0x0000 0x0 0x0 0x2 &mpic 0x1 0x1
-			0x0000 0x0 0x0 0x3 &mpic 0x2 0x1
-			0x0000 0x0 0x0 0x4 &mpic 0x3 0x1
-		>;
-
-		pcie@0 {
-			reg = <0 0 0 0 0>;
-			#size-cells = <2>;
-			#address-cells = <3>;
-			device_type = "pci";
-			ranges = <0x02000000 0x0 0x80000000
-				  0x02000000 0x0 0x80000000
-				  0x0 0x40000000
-
-				  0x01000000 0x0 0x00000000
-				  0x01000000 0x0 0x00000000
-				  0x0 0x00400000>;
-		};
-	};
-};
diff --git a/arch/powerpc/boot/dts/mpc8641_hpcn.dts b/arch/powerpc/boot/dts/mpc8641_hpcn.dts
deleted file mode 100644
index 1c03060..0000000
--- a/arch/powerpc/boot/dts/mpc8641_hpcn.dts
+++ /dev/null
@@ -1,663 +0,0 @@
-/*
- * MPC8641 HPCN Device Tree Source
- *
- * Copyright 2006 Freescale Semiconductor Inc.
- *
- * This program is free software; you can redistribute  it and/or modify it
- * under  the terms of  the GNU General  Public License as published by the
- * Free Software Foundation;  either version 2 of the  License, or (at your
- * option) any later version.
- */
-
-/dts-v1/;
-
-/ {
-	model = "MPC8641HPCN";
-	compatible = "fsl,mpc8641hpcn";
-	#address-cells = <1>;
-	#size-cells = <1>;
-
-	aliases {
-		ethernet0 = &enet0;
-		ethernet1 = &enet1;
-		ethernet2 = &enet2;
-		ethernet3 = &enet3;
-		serial0 = &serial0;
-		serial1 = &serial1;
-		pci0 = &pci0;
-		pci1 = &pci1;
-	};
-
-	cpus {
-		#address-cells = <1>;
-		#size-cells = <0>;
-
-		PowerPC,8641@0 {
-			device_type = "cpu";
-			reg = <0>;
-			d-cache-line-size = <32>;
-			i-cache-line-size = <32>;
-			d-cache-size = <32768>;		// L1
-			i-cache-size = <32768>;		// L1
-			timebase-frequency = <0>;	// From uboot
-			bus-frequency = <0>;		// From uboot
-			clock-frequency = <0>;		// From uboot
-		};
-		PowerPC,8641@1 {
-			device_type = "cpu";
-			reg = <1>;
-			d-cache-line-size = <32>;
-			i-cache-line-size = <32>;
-			d-cache-size = <32768>;
-			i-cache-size = <32768>;
-			timebase-frequency = <0>;	// From uboot
-			bus-frequency = <0>;		// From uboot
-			clock-frequency = <0>;		// From uboot
-		};
-	};
-
-	memory {
-		device_type = "memory";
-		reg = <0x00000000 0x40000000>;	// 1G at 0x0
-	};
-
-	localbus@ffe05000 {
-		#address-cells = <2>;
-		#size-cells = <1>;
-		compatible = "fsl,mpc8641-localbus", "simple-bus";
-		reg = <0xffe05000 0x1000>;
-		interrupts = <19 2>;
-		interrupt-parent = <&mpic>;
-
-		ranges = <0 0 0xef800000 0x00800000
-			  2 0 0xffdf8000 0x00008000
-			  3 0 0xffdf0000 0x00008000>;
-
-		flash@0,0 {
-			compatible = "cfi-flash";
-			reg = <0 0 0x00800000>;
-			bank-width = <2>;
-			device-width = <2>;
-			#address-cells = <1>;
-			#size-cells = <1>;
-			partition@0 {
-				label = "kernel";
-				reg = <0x00000000 0x00300000>;
-			};
-			partition@300000 {
-				label = "firmware b";
-				reg = <0x00300000 0x00100000>;
-				read-only;
-			};
-			partition@400000 {
-				label = "fs";
-				reg = <0x00400000 0x00300000>;
-			};
-			partition@700000 {
-				label = "firmware a";
-				reg = <0x00700000 0x00100000>;
-				read-only;
-			};
-		};
-	};
-
-	soc8641@ffe00000 {
-		#address-cells = <1>;
-		#size-cells = <1>;
-		device_type = "soc";
-		compatible = "simple-bus";
-		ranges = <0x00000000 0xffe00000 0x00100000>;
-		bus-frequency = <0>;
-
-		mcm-law@0 {
-			compatible = "fsl,mcm-law";
-			reg = <0x0 0x1000>;
-			fsl,num-laws = <10>;
-		};
-
-		mcm@1000 {
-			compatible = "fsl,mpc8641-mcm", "fsl,mcm";
-			reg = <0x1000 0x1000>;
-			interrupts = <17 2>;
-			interrupt-parent = <&mpic>;
-		};
-
-		i2c@3000 {
-			#address-cells = <1>;
-			#size-cells = <0>;
-			cell-index = <0>;
-			compatible = "fsl-i2c";
-			reg = <0x3000 0x100>;
-			interrupts = <43 2>;
-			interrupt-parent = <&mpic>;
-			dfsrr;
-		};
-
-		i2c@3100 {
-			#address-cells = <1>;
-			#size-cells = <0>;
-			cell-index = <1>;
-			compatible = "fsl-i2c";
-			reg = <0x3100 0x100>;
-			interrupts = <43 2>;
-			interrupt-parent = <&mpic>;
-			dfsrr;
-		};
-
-		dma@21300 {
-			#address-cells = <1>;
-			#size-cells = <1>;
-			compatible = "fsl,mpc8641-dma", "fsl,eloplus-dma";
-			reg = <0x21300 0x4>;
-			ranges = <0x0 0x21100 0x200>;
-			cell-index = <0>;
-			dma-channel@0 {
-				compatible = "fsl,mpc8641-dma-channel",
-						"fsl,eloplus-dma-channel";
-				reg = <0x0 0x80>;
-				cell-index = <0>;
-				interrupt-parent = <&mpic>;
-				interrupts = <20 2>;
-			};
-			dma-channel@80 {
-				compatible = "fsl,mpc8641-dma-channel",
-						"fsl,eloplus-dma-channel";
-				reg = <0x80 0x80>;
-				cell-index = <1>;
-				interrupt-parent = <&mpic>;
-				interrupts = <21 2>;
-			};
-			dma-channel@100 {
-				compatible = "fsl,mpc8641-dma-channel",
-						"fsl,eloplus-dma-channel";
-				reg = <0x100 0x80>;
-				cell-index = <2>;
-				interrupt-parent = <&mpic>;
-				interrupts = <22 2>;
-			};
-			dma-channel@180 {
-				compatible = "fsl,mpc8641-dma-channel",
-						"fsl,eloplus-dma-channel";
-				reg = <0x180 0x80>;
-				cell-index = <3>;
-				interrupt-parent = <&mpic>;
-				interrupts = <23 2>;
-			};
-		};
-
-		enet0: ethernet@24000 {
-			#address-cells = <1>;
-			#size-cells = <1>;
-			cell-index = <0>;
-			device_type = "network";
-			model = "TSEC";
-			compatible = "gianfar";
-			reg = <0x24000 0x1000>;
-			ranges = <0x0 0x24000 0x1000>;
-			local-mac-address = [ 00 00 00 00 00 00 ];
-			interrupts = <29 2 30  2 34 2>;
-			interrupt-parent = <&mpic>;
-			tbi-handle = <&tbi0>;
-			phy-handle = <&phy0>;
-			phy-connection-type = "rgmii-id";
-
-			mdio@520 {
-				#address-cells = <1>;
-				#size-cells = <0>;
-				compatible = "fsl,gianfar-mdio";
-				reg = <0x520 0x20>;
-
-				phy0: ethernet-phy@0 {
-					interrupt-parent = <&mpic>;
-					interrupts = <10 1>;
-					reg = <0>;
-				};
-				phy1: ethernet-phy@1 {
-					interrupt-parent = <&mpic>;
-					interrupts = <10 1>;
-					reg = <1>;
-				};
-				phy2: ethernet-phy@2 {
-					interrupt-parent = <&mpic>;
-					interrupts = <10 1>;
-					reg = <2>;
-				};
-				phy3: ethernet-phy@3 {
-					interrupt-parent = <&mpic>;
-					interrupts = <10 1>;
-					reg = <3>;
-				};
-				tbi0: tbi-phy@11 {
-					reg = <0x11>;
-					device_type = "tbi-phy";
-				};
-			};
-		};
-
-		enet1: ethernet@25000 {
-			#address-cells = <1>;
-			#size-cells = <1>;
-			cell-index = <1>;
-			device_type = "network";
-			model = "TSEC";
-			compatible = "gianfar";
-			reg = <0x25000 0x1000>;
-			ranges = <0x0 0x25000 0x1000>;
-			local-mac-address = [ 00 00 00 00 00 00 ];
-			interrupts = <35 2 36 2 40 2>;
-			interrupt-parent = <&mpic>;
-			tbi-handle = <&tbi1>;
-			phy-handle = <&phy1>;
-			phy-connection-type = "rgmii-id";
-
-			mdio@520 {
-				#address-cells = <1>;
-				#size-cells = <0>;
-				compatible = "fsl,gianfar-tbi";
-				reg = <0x520 0x20>;
-
-				tbi1: tbi-phy@11 {
-					reg = <0x11>;
-					device_type = "tbi-phy";
-				};
-			};
-		};
-		
-		enet2: ethernet@26000 {
-			#address-cells = <1>;
-			#size-cells = <1>;
-			cell-index = <2>;
-			device_type = "network";
-			model = "TSEC";
-			compatible = "gianfar";
-			reg = <0x26000 0x1000>;
-			ranges = <0x0 0x26000 0x1000>;
-			local-mac-address = [ 00 00 00 00 00 00 ];
-			interrupts = <31 2 32 2 33 2>;
-			interrupt-parent = <&mpic>;
-			tbi-handle = <&tbi2>;
-			phy-handle = <&phy2>;
-			phy-connection-type = "rgmii-id";
-
-			mdio@520 {
-				#address-cells = <1>;
-				#size-cells = <0>;
-				compatible = "fsl,gianfar-tbi";
-				reg = <0x520 0x20>;
-
-				tbi2: tbi-phy@11 {
-					reg = <0x11>;
-					device_type = "tbi-phy";
-				};
-			};
-		};
-
-		enet3: ethernet@27000 {
-			#address-cells = <1>;
-			#size-cells = <1>;
-			cell-index = <3>;
-			device_type = "network";
-			model = "TSEC";
-			compatible = "gianfar";
-			reg = <0x27000 0x1000>;
-			ranges = <0x0 0x27000 0x1000>;
-			local-mac-address = [ 00 00 00 00 00 00 ];
-			interrupts = <37 2 38 2 39 2>;
-			interrupt-parent = <&mpic>;
-			tbi-handle = <&tbi3>;
-			phy-handle = <&phy3>;
-			phy-connection-type = "rgmii-id";
-
-			mdio@520 {
-				#address-cells = <1>;
-				#size-cells = <0>;
-				compatible = "fsl,gianfar-tbi";
-				reg = <0x520 0x20>;
-
-				tbi3: tbi-phy@11 {
-					reg = <0x11>;
-					device_type = "tbi-phy";
-				};
-			};
-		};
-
-		serial0: serial@4500 {
-			cell-index = <0>;
-			device_type = "serial";
-			compatible = "fsl,ns16550", "ns16550";
-			reg = <0x4500 0x100>;
-			clock-frequency = <0>;
-			interrupts = <42 2>;
-			interrupt-parent = <&mpic>;
-		};
-
-		serial1: serial@4600 {
-			cell-index = <1>;
-			device_type = "serial";
-			compatible = "fsl,ns16550", "ns16550";
-			reg = <0x4600 0x100>;
-			clock-frequency = <0>;
-			interrupts = <28 2>;
-			interrupt-parent = <&mpic>;
-		};
-
-		mpic: pic@40000 {
-			interrupt-controller;
-			#address-cells = <0>;
-			#interrupt-cells = <2>;
-			reg = <0x40000 0x40000>;
-			compatible = "chrp,open-pic";
-			device_type = "open-pic";
-		};
-
-		rmu: rmu@d3000 {
-			#address-cells = <1>;
-			#size-cells = <1>;
-			compatible = "fsl,srio-rmu";
-			reg = <0xd3000 0x500>;
-			ranges = <0x0 0xd3000 0x500>;
-
-			message-unit@0 {
-				compatible = "fsl,srio-msg-unit";
-				reg = <0x0 0x100>;
-				interrupts = <
-					53 2 /* msg1_tx_irq */
-					54 2>;/* msg1_rx_irq */
-			};
-			message-unit@100 {
-				compatible = "fsl,srio-msg-unit";
-				reg = <0x100 0x100>;
-				interrupts = <
-					55 2  /* msg2_tx_irq */
-					56 2>;/* msg2_rx_irq */
-			};
-			doorbell-unit@400 {
-				compatible = "fsl,srio-dbell-unit";
-				reg = <0x400 0x80>;
-				interrupts = <
-					49 2  /* bell_outb_irq */
-					50 2>;/* bell_inb_irq */
-			};
-			port-write-unit@4e0 {
-				compatible = "fsl,srio-port-write-unit";
-				reg = <0x4e0 0x20>;
-				interrupts = <48 2>;
-			};
-		};
-
-		global-utilities@e0000 {
-			compatible = "fsl,mpc8641-guts";
-			reg = <0xe0000 0x1000>;
-			fsl,has-rstcr;
-		};
-	};
-
-	pci0: pcie@ffe08000 {
-		compatible = "fsl,mpc8641-pcie";
-		device_type = "pci";
-		#interrupt-cells = <1>;
-		#size-cells = <2>;
-		#address-cells = <3>;
-		reg = <0xffe08000 0x1000>;
-		bus-range = <0x0 0xff>;
-		ranges = <0x02000000 0x0 0x80000000 0x80000000 0x0 0x20000000
-			  0x01000000 0x0 0x00000000 0xffc00000 0x0 0x00010000>;
-		clock-frequency = <33333333>;
-		interrupt-parent = <&mpic>;
-		interrupts = <24 2>;
-		interrupt-map-mask = <0xff00 0 0 7>;
-		interrupt-map = <
-			/* IDSEL 0x11 func 0 - PCI slot 1 */
-			0x8800 0 0 1 &mpic 2 1
-			0x8800 0 0 2 &mpic 3 1
-			0x8800 0 0 3 &mpic 4 1
-			0x8800 0 0 4 &mpic 1 1
-
-			/* IDSEL 0x11 func 1 - PCI slot 1 */
-			0x8900 0 0 1 &mpic 2 1
-			0x8900 0 0 2 &mpic 3 1
-			0x8900 0 0 3 &mpic 4 1
-			0x8900 0 0 4 &mpic 1 1
-
-			/* IDSEL 0x11 func 2 - PCI slot 1 */
-			0x8a00 0 0 1 &mpic 2 1
-			0x8a00 0 0 2 &mpic 3 1
-			0x8a00 0 0 3 &mpic 4 1
-			0x8a00 0 0 4 &mpic 1 1
-
-			/* IDSEL 0x11 func 3 - PCI slot 1 */
-			0x8b00 0 0 1 &mpic 2 1
-			0x8b00 0 0 2 &mpic 3 1
-			0x8b00 0 0 3 &mpic 4 1
-			0x8b00 0 0 4 &mpic 1 1
-
-			/* IDSEL 0x11 func 4 - PCI slot 1 */
-			0x8c00 0 0 1 &mpic 2 1
-			0x8c00 0 0 2 &mpic 3 1
-			0x8c00 0 0 3 &mpic 4 1
-			0x8c00 0 0 4 &mpic 1 1
-
-			/* IDSEL 0x11 func 5 - PCI slot 1 */
-			0x8d00 0 0 1 &mpic 2 1
-			0x8d00 0 0 2 &mpic 3 1
-			0x8d00 0 0 3 &mpic 4 1
-			0x8d00 0 0 4 &mpic 1 1
-
-			/* IDSEL 0x11 func 6 - PCI slot 1 */
-			0x8e00 0 0 1 &mpic 2 1
-			0x8e00 0 0 2 &mpic 3 1
-			0x8e00 0 0 3 &mpic 4 1
-			0x8e00 0 0 4 &mpic 1 1
-
-			/* IDSEL 0x11 func 7 - PCI slot 1 */
-			0x8f00 0 0 1 &mpic 2 1
-			0x8f00 0 0 2 &mpic 3 1
-			0x8f00 0 0 3 &mpic 4 1
-			0x8f00 0 0 4 &mpic 1 1
-
-			/* IDSEL 0x12 func 0 - PCI slot 2 */
-			0x9000 0 0 1 &mpic 3 1
-			0x9000 0 0 2 &mpic 4 1
-			0x9000 0 0 3 &mpic 1 1
-			0x9000 0 0 4 &mpic 2 1
-
-			/* IDSEL 0x12 func 1 - PCI slot 2 */
-			0x9100 0 0 1 &mpic 3 1
-			0x9100 0 0 2 &mpic 4 1
-			0x9100 0 0 3 &mpic 1 1
-			0x9100 0 0 4 &mpic 2 1
-
-			/* IDSEL 0x12 func 2 - PCI slot 2 */
-			0x9200 0 0 1 &mpic 3 1
-			0x9200 0 0 2 &mpic 4 1
-			0x9200 0 0 3 &mpic 1 1
-			0x9200 0 0 4 &mpic 2 1
-
-			/* IDSEL 0x12 func 3 - PCI slot 2 */
-			0x9300 0 0 1 &mpic 3 1
-			0x9300 0 0 2 &mpic 4 1
-			0x9300 0 0 3 &mpic 1 1
-			0x9300 0 0 4 &mpic 2 1
-
-			/* IDSEL 0x12 func 4 - PCI slot 2 */
-			0x9400 0 0 1 &mpic 3 1
-			0x9400 0 0 2 &mpic 4 1
-			0x9400 0 0 3 &mpic 1 1
-			0x9400 0 0 4 &mpic 2 1
-
-			/* IDSEL 0x12 func 5 - PCI slot 2 */
-			0x9500 0 0 1 &mpic 3 1
-			0x9500 0 0 2 &mpic 4 1
-			0x9500 0 0 3 &mpic 1 1
-			0x9500 0 0 4 &mpic 2 1
-
-			/* IDSEL 0x12 func 6 - PCI slot 2 */
-			0x9600 0 0 1 &mpic 3 1
-			0x9600 0 0 2 &mpic 4 1
-			0x9600 0 0 3 &mpic 1 1
-			0x9600 0 0 4 &mpic 2 1
-
-			/* IDSEL 0x12 func 7 - PCI slot 2 */
-			0x9700 0 0 1 &mpic 3 1
-			0x9700 0 0 2 &mpic 4 1
-			0x9700 0 0 3 &mpic 1 1
-			0x9700 0 0 4 &mpic 2 1
-
-			// IDSEL 0x1c  USB
-			0xe000 0 0 1 &i8259 12 2
-			0xe100 0 0 2 &i8259 9 2
-			0xe200 0 0 3 &i8259 10 2
-			0xe300 0 0 4 &i8259 11 2
-
-			// IDSEL 0x1d  Audio
-			0xe800 0 0 1 &i8259 6 2
-
-			// IDSEL 0x1e Legacy
-			0xf000 0 0 1 &i8259 7 2
-			0xf100 0 0 1 &i8259 7 2
-
-			// IDSEL 0x1f IDE/SATA
-			0xf800 0 0 1 &i8259 14 2
-			0xf900 0 0 1 &i8259 5 2
-			>;
-
-		pcie@0 {
-			reg = <0 0 0 0 0>;
-			#size-cells = <2>;
-			#address-cells = <3>;
-			device_type = "pci";
-			ranges = <0x02000000 0x0 0x80000000
-				  0x02000000 0x0 0x80000000
-				  0x0 0x20000000
-
-				  0x01000000 0x0 0x00000000
-				  0x01000000 0x0 0x00000000
-				  0x0 0x00010000>;
-			uli1575@0 {
-				reg = <0 0 0 0 0>;
-				#size-cells = <2>;
-				#address-cells = <3>;
-				ranges = <0x02000000 0x0 0x80000000
-					  0x02000000 0x0 0x80000000
-					  0x0 0x20000000
-					  0x01000000 0x0 0x00000000
-					  0x01000000 0x0 0x00000000
-					  0x0 0x00010000>;
-				isa@1e {
-					device_type = "isa";
-					#interrupt-cells = <2>;
-					#size-cells = <1>;
-					#address-cells = <2>;
-					reg = <0xf000 0 0 0 0>;
-					ranges = <1 0 0x01000000 0 0
-						  0x00001000>;
-					interrupt-parent = <&i8259>;
-
-					i8259: interrupt-controller@20 {
-						reg = <1 0x20 2
-						       1 0xa0 2
-						       1 0x4d0 2>;
-						interrupt-controller;
-						device_type = "interrupt-controller";
-						#address-cells = <0>;
-						#interrupt-cells = <2>;
-						compatible = "chrp,iic";
-						interrupts = <9 2>;
-						interrupt-parent = <&mpic>;
-					};
-
-					i8042@60 {
-						#size-cells = <0>;
-						#address-cells = <1>;
-						reg = <1 0x60 1 1 0x64 1>;
-						interrupts = <1 3 12 3>;
-						interrupt-parent =
-							<&i8259>;
-
-						keyboard@0 {
-							reg = <0>;
-							compatible = "pnpPNP,303";
-						};
-
-						mouse@1 {
-							reg = <1>;
-							compatible = "pnpPNP,f03";
-						};
-					};
-
-					rtc@70 {
-						compatible =
-							"pnpPNP,b00";
-						reg = <1 0x70 2>;
-					};
-
-					gpio@400 {
-						reg = <1 0x400 0x80>;
-					};
-				};
-			};
-		};
-
-	};
-
-	pci1: pcie@ffe09000 {
-		compatible = "fsl,mpc8641-pcie";
-		device_type = "pci";
-		#interrupt-cells = <1>;
-		#size-cells = <2>;
-		#address-cells = <3>;
-		reg = <0xffe09000 0x1000>;
-		bus-range = <0 0xff>;
-		ranges = <0x02000000 0x0 0xa0000000 0xa0000000 0x0 0x20000000
-			  0x01000000 0x0 0x00000000 0xffc10000 0x0 0x00010000>;
-		clock-frequency = <33333333>;
-		interrupt-parent = <&mpic>;
-		interrupts = <25 2>;
-		interrupt-map-mask = <0xf800 0 0 7>;
-		interrupt-map = <
-			/* IDSEL 0x0 */
-			0x0000 0 0 1 &mpic 4 1
-			0x0000 0 0 2 &mpic 5 1
-			0x0000 0 0 3 &mpic 6 1
-			0x0000 0 0 4 &mpic 7 1
-			>;
-		pcie@0 {
-			reg = <0 0 0 0 0>;
-			#size-cells = <2>;
-			#address-cells = <3>;
-			device_type = "pci";
-			ranges = <0x02000000 0x0 0xa0000000
-				  0x02000000 0x0 0xa0000000
-				  0x0 0x20000000
-
-				  0x01000000 0x0 0x00000000
-				  0x01000000 0x0 0x00000000
-				  0x0 0x00010000>;
-		};
-	};
-/*
- * Only one of Rapid IO or PCI can be present due to HW limitations and
- * due to the fact that the 2 now share address space in the new memory
- * map.  The most likely case is that we have PCI, so comment out the
- * rapidio node.  Leave it here for reference.
-
-	rapidio@ffec0000 {
-		reg = <0xffec0000 0x11000>;
-		compatible = "fsl,srio";
-		interrupt-parent = <&mpic>;
-		interrupts = <48 2>;
-		#address-cells = <2>;
-		#size-cells = <2>;
-		fsl,srio-rmu-handle = <&rmu>;
-		ranges;
-
-		port1 {
-			#address-cells = <2>;
-			#size-cells = <2>;
-			cell-index = <1>;
-			ranges = <0 0 0x80000000 0 0x20000000>;
-		};
-	};
-*/
-
-};
diff --git a/arch/powerpc/boot/dts/mpc8641_hpcn_36b.dts b/arch/powerpc/boot/dts/mpc8641_hpcn_36b.dts
deleted file mode 100644
index bb575e2..0000000
--- a/arch/powerpc/boot/dts/mpc8641_hpcn_36b.dts
+++ /dev/null
@@ -1,605 +0,0 @@
-/*
- * MPC8641 HPCN Device Tree Source
- *
- * Copyright 2008-2009 Freescale Semiconductor Inc.
- *
- * This program is free software; you can redistribute  it and/or modify it
- * under  the terms of  the GNU General  Public License as published by the
- * Free Software Foundation;  either version 2 of the  License, or (at your
- * option) any later version.
- */
-
-/dts-v1/;
-
-/ {
-	model = "MPC8641HPCN";
-	compatible = "fsl,mpc8641hpcn";
-	#address-cells = <2>;
-	#size-cells = <2>;
-
-	aliases {
-		ethernet0 = &enet0;
-		ethernet1 = &enet1;
-		ethernet2 = &enet2;
-		ethernet3 = &enet3;
-		serial0 = &serial0;
-		serial1 = &serial1;
-		pci0 = &pci0;
-		pci1 = &pci1;
-	};
-
-	cpus {
-		#address-cells = <1>;
-		#size-cells = <0>;
-
-		PowerPC,8641@0 {
-			device_type = "cpu";
-			reg = <0>;
-			d-cache-line-size = <32>;	// 32 bytes
-			i-cache-line-size = <32>;	// 32 bytes
-			d-cache-size = <32768>;		// L1, 32K
-			i-cache-size = <32768>;		// L1, 32K
-			timebase-frequency = <0>;	// 33 MHz, from uboot
-			bus-frequency = <0>;		// From uboot
-			clock-frequency = <0>;		// From uboot
-		};
-		PowerPC,8641@1 {
-			device_type = "cpu";
-			reg = <1>;
-			d-cache-line-size = <32>;	// 32 bytes
-			i-cache-line-size = <32>;	// 32 bytes
-			d-cache-size = <32768>;		// L1, 32K
-			i-cache-size = <32768>;		// L1, 32K
-			timebase-frequency = <0>;	// 33 MHz, from uboot
-			bus-frequency = <0>;		// From uboot
-			clock-frequency = <0>;		// From uboot
-		};
-	};
-
-	memory {
-		device_type = "memory";
-		reg = <0x0 0x00000000 0x0 0x40000000>;	// 1G at 0x0
-	};
-
-	localbus@fffe05000 {
-		#address-cells = <2>;
-		#size-cells = <1>;
-		compatible = "fsl,mpc8641-localbus", "simple-bus";
-		reg = <0x0f 0xffe05000 0x0 0x1000>;
-		interrupts = <19 2>;
-		interrupt-parent = <&mpic>;
-
-		ranges = <0 0 0xf 0xef800000 0x00800000
-			  2 0 0xf 0xffdf8000 0x00008000
-			  3 0 0xf 0xffdf0000 0x00008000>;
-
-		flash@0,0 {
-			compatible = "cfi-flash";
-			reg = <0 0 0x00800000>;
-			bank-width = <2>;
-			device-width = <2>;
-			#address-cells = <1>;
-			#size-cells = <1>;
-			partition@0 {
-				label = "kernel";
-				reg = <0x00000000 0x00300000>;
-			};
-			partition@300000 {
-				label = "firmware b";
-				reg = <0x00300000 0x00100000>;
-				read-only;
-			};
-			partition@400000 {
-				label = "fs";
-				reg = <0x00400000 0x00300000>;
-			};
-			partition@700000 {
-				label = "firmware a";
-				reg = <0x00700000 0x00100000>;
-				read-only;
-			};
-		};
-	};
-
-	soc8641@fffe00000 {
-		#address-cells = <1>;
-		#size-cells = <1>;
-		device_type = "soc";
-		compatible = "simple-bus";
-		ranges = <0x00000000 0x0f 0xffe00000 0x00100000>;
-		bus-frequency = <0>;
-
-		mcm-law@0 {
-			compatible = "fsl,mcm-law";
-			reg = <0x0 0x1000>;
-			fsl,num-laws = <10>;
-		};
-
-		mcm@1000 {
-			compatible = "fsl,mpc8641-mcm", "fsl,mcm";
-			reg = <0x1000 0x1000>;
-			interrupts = <17 2>;
-			interrupt-parent = <&mpic>;
-		};
-
-		i2c@3000 {
-			#address-cells = <1>;
-			#size-cells = <0>;
-			cell-index = <0>;
-			compatible = "fsl-i2c";
-			reg = <0x3000 0x100>;
-			interrupts = <43 2>;
-			interrupt-parent = <&mpic>;
-			dfsrr;
-		};
-
-		i2c@3100 {
-			#address-cells = <1>;
-			#size-cells = <0>;
-			cell-index = <1>;
-			compatible = "fsl-i2c";
-			reg = <0x3100 0x100>;
-			interrupts = <43 2>;
-			interrupt-parent = <&mpic>;
-			dfsrr;
-		};
-
-		dma@21300 {
-			#address-cells = <1>;
-			#size-cells = <1>;
-			compatible = "fsl,mpc8641-dma", "fsl,eloplus-dma";
-			reg = <0x21300 0x4>;
-			ranges = <0x0 0x21100 0x200>;
-			cell-index = <0>;
-			dma-channel@0 {
-				compatible = "fsl,mpc8641-dma-channel",
-						"fsl,eloplus-dma-channel";
-				reg = <0x0 0x80>;
-				cell-index = <0>;
-				interrupt-parent = <&mpic>;
-				interrupts = <20 2>;
-			};
-			dma-channel@80 {
-				compatible = "fsl,mpc8641-dma-channel",
-						"fsl,eloplus-dma-channel";
-				reg = <0x80 0x80>;
-				cell-index = <1>;
-				interrupt-parent = <&mpic>;
-				interrupts = <21 2>;
-			};
-			dma-channel@100 {
-				compatible = "fsl,mpc8641-dma-channel",
-						"fsl,eloplus-dma-channel";
-				reg = <0x100 0x80>;
-				cell-index = <2>;
-				interrupt-parent = <&mpic>;
-				interrupts = <22 2>;
-			};
-			dma-channel@180 {
-				compatible = "fsl,mpc8641-dma-channel",
-						"fsl,eloplus-dma-channel";
-				reg = <0x180 0x80>;
-				cell-index = <3>;
-				interrupt-parent = <&mpic>;
-				interrupts = <23 2>;
-			};
-		};
-
-		enet0: ethernet@24000 {
-			#address-cells = <1>;
-			#size-cells = <1>;
-			cell-index = <0>;
-			device_type = "network";
-			model = "TSEC";
-			compatible = "gianfar";
-			reg = <0x24000 0x1000>;
-			ranges = <0x0 0x24000 0x1000>;
-			local-mac-address = [ 00 00 00 00 00 00 ];
-			interrupts = <29 2 30 2 34 2>;
-			interrupt-parent = <&mpic>;
-			tbi-handle = <&tbi0>;
-			phy-handle = <&phy0>;
-			phy-connection-type = "rgmii-id";
-
-			mdio@520 {
-				#address-cells = <1>;
-				#size-cells = <0>;
-				compatible = "fsl,gianfar-mdio";
-				reg = <0x520 0x20>;
-
-				phy0: ethernet-phy@0 {
-					interrupt-parent = <&mpic>;
-					interrupts = <10 1>;
-					reg = <0>;
-				};
-				phy1: ethernet-phy@1 {
-					interrupt-parent = <&mpic>;
-					interrupts = <10 1>;
-					reg = <1>;
-				};
-				phy2: ethernet-phy@2 {
-					interrupt-parent = <&mpic>;
-					interrupts = <10 1>;
-					reg = <2>;
-				};
-				phy3: ethernet-phy@3 {
-					interrupt-parent = <&mpic>;
-					interrupts = <10 1>;
-					reg = <3>;
-				};
-				tbi0: tbi-phy@11 {
-					reg = <0x11>;
-					device_type = "tbi-phy";
-				};
-			};
-		};
-
-		enet1: ethernet@25000 {
-			#address-cells = <1>;
-			#size-cells = <1>;
-			cell-index = <1>;
-			device_type = "network";
-			model = "TSEC";
-			compatible = "gianfar";
-			reg = <0x25000 0x1000>;
-			ranges = <0x0 0x25000 0x1000>;
-			local-mac-address = [ 00 00 00 00 00 00 ];
-			interrupts = <35 2 36 2 40 2>;
-			interrupt-parent = <&mpic>;
-			tbi-handle = <&tbi1>;
-			phy-handle = <&phy1>;
-			phy-connection-type = "rgmii-id";
-
-			mdio@520 {
-				#address-cells = <1>;
-				#size-cells = <0>;
-				compatible = "fsl,gianfar-tbi";
-				reg = <0x520 0x20>;
-
-				tbi1: tbi-phy@11 {
-					reg = <0x11>;
-					device_type = "tbi-phy";
-				};
-			};
-		};
-
-		enet2: ethernet@26000 {
-			#address-cells = <1>;
-			#size-cells = <1>;
-			cell-index = <2>;
-			device_type = "network";
-			model = "TSEC";
-			compatible = "gianfar";
-			reg = <0x26000 0x1000>;
-			ranges = <0x0 0x26000 0x1000>;
-			local-mac-address = [ 00 00 00 00 00 00 ];
-			interrupts = <31 2 32 2 33 2>;
-			interrupt-parent = <&mpic>;
-			tbi-handle = <&tbi2>;
-			phy-handle = <&phy2>;
-			phy-connection-type = "rgmii-id";
-
-			mdio@520 {
-				#address-cells = <1>;
-				#size-cells = <0>;
-				compatible = "fsl,gianfar-tbi";
-				reg = <0x520 0x20>;
-
-				tbi2: tbi-phy@11 {
-					reg = <0x11>;
-					device_type = "tbi-phy";
-				};
-			};
-		};
-
-		enet3: ethernet@27000 {
-			#address-cells = <1>;
-			#size-cells = <1>;
-			cell-index = <3>;
-			device_type = "network";
-			model = "TSEC";
-			compatible = "gianfar";
-			reg = <0x27000 0x1000>;
-			ranges = <0x0 0x27000 0x1000>;
-			local-mac-address = [ 00 00 00 00 00 00 ];
-			interrupts = <37 2 38 2 39 2>;
-			interrupt-parent = <&mpic>;
-			tbi-handle = <&tbi3>;
-			phy-handle = <&phy3>;
-			phy-connection-type = "rgmii-id";
-
-			mdio@520 {
-				#address-cells = <1>;
-				#size-cells = <0>;
-				compatible = "fsl,gianfar-tbi";
-				reg = <0x520 0x20>;
-
-				tbi3: tbi-phy@11 {
-					reg = <0x11>;
-					device_type = "tbi-phy";
-				};
-			};
-		};
-
-		serial0: serial@4500 {
-			cell-index = <0>;
-			device_type = "serial";
-			compatible = "fsl,ns16550", "ns16550";
-			reg = <0x4500 0x100>;
-			clock-frequency = <0>;
-			interrupts = <42 2>;
-			interrupt-parent = <&mpic>;
-		};
-
-		serial1: serial@4600 {
-			cell-index = <1>;
-			device_type = "serial";
-			compatible = "fsl,ns16550", "ns16550";
-			reg = <0x4600 0x100>;
-			clock-frequency = <0>;
-			interrupts = <28 2>;
-			interrupt-parent = <&mpic>;
-		};
-
-		mpic: pic@40000 {
-			interrupt-controller;
-			#address-cells = <0>;
-			#interrupt-cells = <2>;
-			reg = <0x40000 0x40000>;
-			compatible = "chrp,open-pic";
-			device_type = "open-pic";
-		};
-
-		global-utilities@e0000 {
-			compatible = "fsl,mpc8641-guts";
-			reg = <0xe0000 0x1000>;
-			fsl,has-rstcr;
-		};
-	};
-
-	pci0: pcie@fffe08000 {
-		cell-index = <0>;
-		compatible = "fsl,mpc8641-pcie";
-		device_type = "pci";
-		#interrupt-cells = <1>;
-		#size-cells = <2>;
-		#address-cells = <3>;
-		reg = <0x0f 0xffe08000 0x0 0x1000>;
-		bus-range = <0x0 0xff>;
-		ranges = <0x02000000 0x0 0xe0000000 0x0c 0x00000000 0x0 0x20000000
-			  0x01000000 0x0 0x00000000 0x0f 0xffc00000 0x0 0x00010000>;
-		clock-frequency = <33333333>;
-		interrupt-parent = <&mpic>;
-		interrupts = <24 2>;
-		interrupt-map-mask = <0xff00 0 0 7>;
-		interrupt-map = <
-			/* IDSEL 0x11 func 0 - PCI slot 1 */
-			0x8800 0 0 1 &mpic 2 1
-			0x8800 0 0 2 &mpic 3 1
-			0x8800 0 0 3 &mpic 4 1
-			0x8800 0 0 4 &mpic 1 1
-
-			/* IDSEL 0x11 func 1 - PCI slot 1 */
-			0x8900 0 0 1 &mpic 2 1
-			0x8900 0 0 2 &mpic 3 1
-			0x8900 0 0 3 &mpic 4 1
-			0x8900 0 0 4 &mpic 1 1
-
-			/* IDSEL 0x11 func 2 - PCI slot 1 */
-			0x8a00 0 0 1 &mpic 2 1
-			0x8a00 0 0 2 &mpic 3 1
-			0x8a00 0 0 3 &mpic 4 1
-			0x8a00 0 0 4 &mpic 1 1
-
-			/* IDSEL 0x11 func 3 - PCI slot 1 */
-			0x8b00 0 0 1 &mpic 2 1
-			0x8b00 0 0 2 &mpic 3 1
-			0x8b00 0 0 3 &mpic 4 1
-			0x8b00 0 0 4 &mpic 1 1
-
-			/* IDSEL 0x11 func 4 - PCI slot 1 */
-			0x8c00 0 0 1 &mpic 2 1
-			0x8c00 0 0 2 &mpic 3 1
-			0x8c00 0 0 3 &mpic 4 1
-			0x8c00 0 0 4 &mpic 1 1
-
-			/* IDSEL 0x11 func 5 - PCI slot 1 */
-			0x8d00 0 0 1 &mpic 2 1
-			0x8d00 0 0 2 &mpic 3 1
-			0x8d00 0 0 3 &mpic 4 1
-			0x8d00 0 0 4 &mpic 1 1
-
-			/* IDSEL 0x11 func 6 - PCI slot 1 */
-			0x8e00 0 0 1 &mpic 2 1
-			0x8e00 0 0 2 &mpic 3 1
-			0x8e00 0 0 3 &mpic 4 1
-			0x8e00 0 0 4 &mpic 1 1
-
-			/* IDSEL 0x11 func 7 - PCI slot 1 */
-			0x8f00 0 0 1 &mpic 2 1
-			0x8f00 0 0 2 &mpic 3 1
-			0x8f00 0 0 3 &mpic 4 1
-			0x8f00 0 0 4 &mpic 1 1
-
-			/* IDSEL 0x12 func 0 - PCI slot 2 */
-			0x9000 0 0 1 &mpic 3 1
-			0x9000 0 0 2 &mpic 4 1
-			0x9000 0 0 3 &mpic 1 1
-			0x9000 0 0 4 &mpic 2 1
-
-			/* IDSEL 0x12 func 1 - PCI slot 2 */
-			0x9100 0 0 1 &mpic 3 1
-			0x9100 0 0 2 &mpic 4 1
-			0x9100 0 0 3 &mpic 1 1
-			0x9100 0 0 4 &mpic 2 1
-
-			/* IDSEL 0x12 func 2 - PCI slot 2 */
-			0x9200 0 0 1 &mpic 3 1
-			0x9200 0 0 2 &mpic 4 1
-			0x9200 0 0 3 &mpic 1 1
-			0x9200 0 0 4 &mpic 2 1
-
-			/* IDSEL 0x12 func 3 - PCI slot 2 */
-			0x9300 0 0 1 &mpic 3 1
-			0x9300 0 0 2 &mpic 4 1
-			0x9300 0 0 3 &mpic 1 1
-			0x9300 0 0 4 &mpic 2 1
-
-			/* IDSEL 0x12 func 4 - PCI slot 2 */
-			0x9400 0 0 1 &mpic 3 1
-			0x9400 0 0 2 &mpic 4 1
-			0x9400 0 0 3 &mpic 1 1
-			0x9400 0 0 4 &mpic 2 1
-
-			/* IDSEL 0x12 func 5 - PCI slot 2 */
-			0x9500 0 0 1 &mpic 3 1
-			0x9500 0 0 2 &mpic 4 1
-			0x9500 0 0 3 &mpic 1 1
-			0x9500 0 0 4 &mpic 2 1
-
-			/* IDSEL 0x12 func 6 - PCI slot 2 */
-			0x9600 0 0 1 &mpic 3 1
-			0x9600 0 0 2 &mpic 4 1
-			0x9600 0 0 3 &mpic 1 1
-			0x9600 0 0 4 &mpic 2 1
-
-			/* IDSEL 0x12 func 7 - PCI slot 2 */
-			0x9700 0 0 1 &mpic 3 1
-			0x9700 0 0 2 &mpic 4 1
-			0x9700 0 0 3 &mpic 1 1
-			0x9700 0 0 4 &mpic 2 1
-
-			// IDSEL 0x1c  USB
-			0xe000 0 0 1 &i8259 12 2
-			0xe100 0 0 2 &i8259 9 2
-			0xe200 0 0 3 &i8259 10 2
-			0xe300 0 0 4 &i8259 11 2
-
-			// IDSEL 0x1d  Audio
-			0xe800 0 0 1 &i8259 6 2
-
-			// IDSEL 0x1e Legacy
-			0xf000 0 0 1 &i8259 7 2
-			0xf100 0 0 1 &i8259 7 2
-
-			// IDSEL 0x1f IDE/SATA
-			0xf800 0 0 1 &i8259 14 2
-			0xf900 0 0 1 &i8259 5 2
-			>;
-
-		pcie@0 {
-			reg = <0 0 0 0 0>;
-			#size-cells = <2>;
-			#address-cells = <3>;
-			device_type = "pci";
-			ranges = <0x02000000 0x0 0xe0000000
-				  0x02000000 0x0 0xe0000000
-				  0x0 0x20000000
-
-				  0x01000000 0x0 0x00000000
-				  0x01000000 0x0 0x00000000
-				  0x0 0x00010000>;
-			uli1575@0 {
-				reg = <0 0 0 0 0>;
-				#size-cells = <2>;
-				#address-cells = <3>;
-				ranges = <0x02000000 0x0 0xe0000000
-					  0x02000000 0x0 0xe0000000
-					  0x0 0x20000000
-					  0x01000000 0x0 0x00000000
-					  0x01000000 0x0 0x00000000
-					  0x0 0x00010000>;
-				isa@1e {
-					device_type = "isa";
-					#interrupt-cells = <2>;
-					#size-cells = <1>;
-					#address-cells = <2>;
-					reg = <0xf000 0 0 0 0>;
-					ranges = <1 0 0x01000000 0 0
-						  0x00001000>;
-					interrupt-parent = <&i8259>;
-
-					i8259: interrupt-controller@20 {
-						reg = <1 0x20 2
-						       1 0xa0 2
-						       1 0x4d0 2>;
-						interrupt-controller;
-						device_type = "interrupt-controller";
-						#address-cells = <0>;
-						#interrupt-cells = <2>;
-						compatible = "chrp,iic";
-						interrupts = <9 2>;
-						interrupt-parent = <&mpic>;
-					};
-
-					i8042@60 {
-						#size-cells = <0>;
-						#address-cells = <1>;
-						reg = <1 0x60 1 1 0x64 1>;
-						interrupts = <1 3 12 3>;
-						interrupt-parent =
-							<&i8259>;
-
-						keyboard@0 {
-							reg = <0>;
-							compatible = "pnpPNP,303";
-						};
-
-						mouse@1 {
-							reg = <1>;
-							compatible = "pnpPNP,f03";
-						};
-					};
-
-					rtc@70 {
-						compatible =
-							"pnpPNP,b00";
-						reg = <1 0x70 2>;
-					};
-
-					gpio@400 {
-						reg = <1 0x400 0x80>;
-					};
-				};
-			};
-		};
-
-	};
-
-	pci1: pcie@fffe09000 {
-		cell-index = <1>;
-		compatible = "fsl,mpc8641-pcie";
-		device_type = "pci";
-		#interrupt-cells = <1>;
-		#size-cells = <2>;
-		#address-cells = <3>;
-		reg = <0x0f 0xffe09000 0x0 0x1000>;
-		bus-range = <0x0 0xff>;
-		ranges = <0x02000000 0x0 0xe0000000 0x0c 0x20000000 0x0 0x20000000
-			  0x01000000 0x0 0x00000000 0x0f 0xffc10000 0x0 0x00010000>;
-		clock-frequency = <33333333>;
-		interrupt-parent = <&mpic>;
-		interrupts = <25 2>;
-		interrupt-map-mask = <0xf800 0 0 7>;
-		interrupt-map = <
-			/* IDSEL 0x0 */
-			0x0000 0 0 1 &mpic 4 1
-			0x0000 0 0 2 &mpic 5 1
-			0x0000 0 0 3 &mpic 6 1
-			0x0000 0 0 4 &mpic 7 1
-			>;
-		pcie@0 {
-			reg = <0 0 0 0 0>;
-			#size-cells = <2>;
-			#address-cells = <3>;
-			device_type = "pci";
-			ranges = <0x02000000 0x0 0xe0000000
-				  0x02000000 0x0 0xe0000000
-				  0x0 0x20000000
-
-				  0x01000000 0x0 0x00000000
-				  0x01000000 0x0 0x00000000
-				  0x0 0x00010000>;
-		};
-	};
-};
diff --git a/arch/powerpc/boot/dts/sbc8641d.dts b/arch/powerpc/boot/dts/sbc8641d.dts
deleted file mode 100644
index 68f0ed7..0000000
--- a/arch/powerpc/boot/dts/sbc8641d.dts
+++ /dev/null
@@ -1,447 +0,0 @@
-/*
- * SBC8641D Device Tree Source
- *
- * Copyright 2008 Wind River Systems Inc.
- *
- * Paul Gortmaker (see MAINTAINERS for contact information)
- *
- * Based largely on the mpc8641_hpcn.dts by Freescale Semiconductor Inc.
- *
- * This program is free software; you can redistribute  it and/or modify it
- * under  the terms of  the GNU General  Public License as published by the
- * Free Software Foundation;  either version 2 of the  License, or (at your
- * option) any later version.
- */
-
-/dts-v1/;
-
-/ {
-	model = "SBC8641D";
-	compatible = "wind,sbc8641";
-	#address-cells = <1>;
-	#size-cells = <1>;
-
-	aliases {
-		ethernet0 = &enet0;
-		ethernet1 = &enet1;
-		ethernet2 = &enet2;
-		ethernet3 = &enet3;
-		serial0 = &serial0;
-		serial1 = &serial1;
-		pci0 = &pci0;
-		pci1 = &pci1;
-	};
-
-	cpus {
-		#address-cells = <1>;
-		#size-cells = <0>;
-
-		PowerPC,8641@0 {
-			device_type = "cpu";
-			reg = <0>;
-			d-cache-line-size = <32>;
-			i-cache-line-size = <32>;
-			d-cache-size = <32768>;		// L1
-			i-cache-size = <32768>;		// L1
-			timebase-frequency = <0>;	// From uboot
-			bus-frequency = <0>;		// From uboot
-			clock-frequency = <0>;		// From uboot
-		};
-		PowerPC,8641@1 {
-			device_type = "cpu";
-			reg = <1>;
-			d-cache-line-size = <32>;
-			i-cache-line-size = <32>;
-			d-cache-size = <32768>;
-			i-cache-size = <32768>;
-			timebase-frequency = <0>;	// From uboot
-			bus-frequency = <0>;		// From uboot
-			clock-frequency = <0>;		// From uboot
-		};
-	};
-
-	memory {
-		device_type = "memory";
-		reg = <0x00000000 0x20000000>;	// 512M at 0x0
-	};
-
-	localbus@f8005000 {
-		#address-cells = <2>;
-		#size-cells = <1>;
-		compatible = "fsl,mpc8641-localbus", "simple-bus";
-		reg = <0xf8005000 0x1000>;
-		interrupts = <19 2>;
-		interrupt-parent = <&mpic>;
-
-		ranges = <0 0 0xff000000 0x01000000	// 16MB Boot flash
-			  1 0 0xf0000000 0x00010000	// 64KB EEPROM
-			  2 0 0xf1000000 0x00100000	// EPLD (1MB)
-			  3 0 0xe0000000 0x04000000	// 64MB LB SDRAM (CS3)
-			  4 0 0xe4000000 0x04000000	// 64MB LB SDRAM (CS4)
-			  6 0 0xf4000000 0x00100000	// LCD display (1MB)
-			  7 0 0xe8000000 0x04000000>;	// 64MB OneNAND
-
-		flash@0,0 {
-			compatible = "cfi-flash";
-			reg = <0 0 0x01000000>;
-			bank-width = <2>;
-			device-width = <2>;
-			#address-cells = <1>;
-			#size-cells = <1>;
-			partition@0 {
-				label = "dtb";
-				reg = <0x00000000 0x00100000>;
-				read-only;
-			};
-			partition@300000 {
-				label = "kernel";
-				reg = <0x00100000 0x00400000>;
-				read-only;
-			};
-			partition@400000 {
-				label = "fs";
-				reg = <0x00500000 0x00a00000>;
-			};
-			partition@700000 {
-				label = "firmware";
-				reg = <0x00f00000 0x00100000>;
-				read-only;
-			};
-		};
-
-		epld@2,0 {
-			compatible = "wrs,epld-localbus";
-			#address-cells = <2>;
-			#size-cells = <1>;
-			reg = <2 0 0x100000>;
-			ranges = <0 0 5 0 1	// User switches
-				  1 0 5 1 1	// Board ID/Rev
-				  3 0 5 3 1>;	// LEDs
-		};
-	};
-
-	soc@f8000000 {
-		#address-cells = <1>;
-		#size-cells = <1>;
-		device_type = "soc";
-		compatible = "simple-bus";
-		ranges = <0x00000000 0xf8000000 0x00100000>;
-		bus-frequency = <0>;
-
-		mcm-law@0 {
-			compatible = "fsl,mcm-law";
-			reg = <0x0 0x1000>;
-			fsl,num-laws = <10>;
-		};
-
-		mcm@1000 {
-			compatible = "fsl,mpc8641-mcm", "fsl,mcm";
-			reg = <0x1000 0x1000>;
-			interrupts = <17 2>;
-			interrupt-parent = <&mpic>;
-		};
-
-		i2c@3000 {
-			#address-cells = <1>;
-			#size-cells = <0>;
-			cell-index = <0>;
-			compatible = "fsl-i2c";
-			reg = <0x3000 0x100>;
-			interrupts = <43 2>;
-			interrupt-parent = <&mpic>;
-			dfsrr;
-		};
-
-		i2c@3100 {
-			#address-cells = <1>;
-			#size-cells = <0>;
-			cell-index = <1>;
-			compatible = "fsl-i2c";
-			reg = <0x3100 0x100>;
-			interrupts = <43 2>;
-			interrupt-parent = <&mpic>;
-			dfsrr;
-		};
-
-		dma@21300 {
-			#address-cells = <1>;
-			#size-cells = <1>;
-			compatible = "fsl,mpc8641-dma", "fsl,eloplus-dma";
-			reg = <0x21300 0x4>;
-			ranges = <0x0 0x21100 0x200>;
-			cell-index = <0>;
-			dma-channel@0 {
-				compatible = "fsl,mpc8641-dma-channel",
-						"fsl,eloplus-dma-channel";
-				reg = <0x0 0x80>;
-				cell-index = <0>;
-				interrupt-parent = <&mpic>;
-				interrupts = <20 2>;
-			};
-			dma-channel@80 {
-				compatible = "fsl,mpc8641-dma-channel",
-						"fsl,eloplus-dma-channel";
-				reg = <0x80 0x80>;
-				cell-index = <1>;
-				interrupt-parent = <&mpic>;
-				interrupts = <21 2>;
-			};
-			dma-channel@100 {
-				compatible = "fsl,mpc8641-dma-channel",
-						"fsl,eloplus-dma-channel";
-				reg = <0x100 0x80>;
-				cell-index = <2>;
-				interrupt-parent = <&mpic>;
-				interrupts = <22 2>;
-			};
-			dma-channel@180 {
-				compatible = "fsl,mpc8641-dma-channel",
-						"fsl,eloplus-dma-channel";
-				reg = <0x180 0x80>;
-				cell-index = <3>;
-				interrupt-parent = <&mpic>;
-				interrupts = <23 2>;
-			};
-		};
-
-		enet0: ethernet@24000 {
-			#address-cells = <1>;
-			#size-cells = <1>;
-			cell-index = <0>;
-			device_type = "network";
-			model = "TSEC";
-			compatible = "gianfar";
-			reg = <0x24000 0x1000>;
-			ranges = <0x0 0x24000 0x1000>;
-			local-mac-address = [ 00 00 00 00 00 00 ];
-			interrupts = <29 2 30  2 34 2>;
-			interrupt-parent = <&mpic>;
-			tbi-handle = <&tbi0>;
-			phy-handle = <&phy0>;
-			phy-connection-type = "rgmii-id";
-
-			mdio@520 {
-				#address-cells = <1>;
-				#size-cells = <0>;
-				compatible = "fsl,gianfar-mdio";
-				reg = <0x520 0x20>;
-
-				phy0: ethernet-phy@1f {
-					reg = <0x1f>;
-				};
-				phy1: ethernet-phy@0 {
-					reg = <0>;
-				};
-				phy2: ethernet-phy@1 {
-					reg = <1>;
-				};
-				phy3: ethernet-phy@2 {
-					reg = <2>;
-				};
-				tbi0: tbi-phy@11 {
-					reg = <0x11>;
-					device_type = "tbi-phy";
-				};
-			};
-		};
-
-		enet1: ethernet@25000 {
-			#address-cells = <1>;
-			#size-cells = <1>;
-			cell-index = <1>;
-			device_type = "network";
-			model = "TSEC";
-			compatible = "gianfar";
-			reg = <0x25000 0x1000>;
-			ranges = <0x0 0x25000 0x1000>;
-			local-mac-address = [ 00 00 00 00 00 00 ];
-			interrupts = <35 2 36 2 40 2>;
-			interrupt-parent = <&mpic>;
-			tbi-handle = <&tbi1>;
-			phy-handle = <&phy1>;
-			phy-connection-type = "rgmii-id";
-
-			mdio@520 {
-				#address-cells = <1>;
-				#size-cells = <0>;
-				compatible = "fsl,gianfar-tbi";
-				reg = <0x520 0x20>;
-
-				tbi1: tbi-phy@11 {
-					reg = <0x11>;
-					device_type = "tbi-phy";
-				};
-			};
-		};
-
-		enet2: ethernet@26000 {
-			#address-cells = <1>;
-			#size-cells = <1>;
-			cell-index = <2>;
-			device_type = "network";
-			model = "TSEC";
-			compatible = "gianfar";
-			reg = <0x26000 0x1000>;
-			ranges = <0x0 0x26000 0x1000>;
-			local-mac-address = [ 00 00 00 00 00 00 ];
-			interrupts = <31 2 32 2 33 2>;
-			interrupt-parent = <&mpic>;
-			tbi-handle = <&tbi2>;
-			phy-handle = <&phy2>;
-			phy-connection-type = "rgmii-id";
-
-			mdio@520 {
-				#address-cells = <1>;
-				#size-cells = <0>;
-				compatible = "fsl,gianfar-tbi";
-				reg = <0x520 0x20>;
-
-				tbi2: tbi-phy@11 {
-					reg = <0x11>;
-					device_type = "tbi-phy";
-				};
-			};
-		};
-
-		enet3: ethernet@27000 {
-			#address-cells = <1>;
-			#size-cells = <1>;
-			cell-index = <3>;
-			device_type = "network";
-			model = "TSEC";
-			compatible = "gianfar";
-			reg = <0x27000 0x1000>;
-			ranges = <0x0 0x27000 0x1000>;
-			local-mac-address = [ 00 00 00 00 00 00 ];
-			interrupts = <37 2 38 2 39 2>;
-			interrupt-parent = <&mpic>;
-			tbi-handle = <&tbi3>;
-			phy-handle = <&phy3>;
-			phy-connection-type = "rgmii-id";
-
-			mdio@520 {
-				#address-cells = <1>;
-				#size-cells = <0>;
-				compatible = "fsl,gianfar-tbi";
-				reg = <0x520 0x20>;
-
-				tbi3: tbi-phy@11 {
-					reg = <0x11>;
-					device_type = "tbi-phy";
-				};
-			};
-		};
-
-		serial0: serial@4500 {
-			cell-index = <0>;
-			device_type = "serial";
-			compatible = "fsl,ns16550", "ns16550";
-			reg = <0x4500 0x100>;
-			clock-frequency = <0>;
-			interrupts = <42 2>;
-			interrupt-parent = <&mpic>;
-		};
-
-		serial1: serial@4600 {
-			cell-index = <1>;
-			device_type = "serial";
-			compatible = "fsl,ns16550", "ns16550";
-			reg = <0x4600 0x100>;
-			clock-frequency = <0>;
-			interrupts = <28 2>;
-			interrupt-parent = <&mpic>;
-		};
-
-		mpic: pic@40000 {
-			clock-frequency = <0>;
-			interrupt-controller;
-			#address-cells = <0>;
-			#interrupt-cells = <2>;
-			reg = <0x40000 0x40000>;
-			compatible = "chrp,open-pic";
-			device_type = "open-pic";
-			big-endian;
-		};
-
-		global-utilities@e0000 {
-			compatible = "fsl,mpc8641-guts";
-			reg = <0xe0000 0x1000>;
-			fsl,has-rstcr;
-		};
-	};
-
-	pci0: pcie@f8008000 {
-		compatible = "fsl,mpc8641-pcie";
-		device_type = "pci";
-		#interrupt-cells = <1>;
-		#size-cells = <2>;
-		#address-cells = <3>;
-		reg = <0xf8008000 0x1000>;
-		bus-range = <0x0 0xff>;
-		ranges = <0x02000000 0x0 0x80000000 0x80000000 0x0 0x20000000
-			  0x01000000 0x0 0x00000000 0xe2000000 0x0 0x00100000>;
-		clock-frequency = <33333333>;
-		interrupt-parent = <&mpic>;
-		interrupts = <24 2>;
-		interrupt-map-mask = <0xff00 0 0 7>;
-		interrupt-map = <
-			/* IDSEL 0x0 */
-			0x0000 0 0 1 &mpic 0 1
-			0x0000 0 0 2 &mpic 1 1
-			0x0000 0 0 3 &mpic 2 1
-			0x0000 0 0 4 &mpic 3 1
-			>;
-
-		pcie@0 {
-			reg = <0 0 0 0 0>;
-			#size-cells = <2>;
-			#address-cells = <3>;
-			device_type = "pci";
-			ranges = <0x02000000 0x0 0x80000000
-				  0x02000000 0x0 0x80000000
-				  0x0 0x20000000
-
-				  0x01000000 0x0 0x00000000
-				  0x01000000 0x0 0x00000000
-				  0x0 0x00100000>;
-		};
-
-	};
-
-	pci1: pcie@f8009000 {
-		compatible = "fsl,mpc8641-pcie";
-		device_type = "pci";
-		#interrupt-cells = <1>;
-		#size-cells = <2>;
-		#address-cells = <3>;
-		reg = <0xf8009000 0x1000>;
-		bus-range = <0 0xff>;
-		ranges = <0x02000000 0x0 0xa0000000 0xa0000000 0x0 0x20000000
-			  0x01000000 0x0 0x00000000 0xe3000000 0x0 0x00100000>;
-		clock-frequency = <33333333>;
-		interrupt-parent = <&mpic>;
-		interrupts = <25 2>;
-		interrupt-map-mask = <0xf800 0 0 7>;
-		interrupt-map = <
-			/* IDSEL 0x0 */
-			0x0000 0 0 1 &mpic 4 1
-			0x0000 0 0 2 &mpic 5 1
-			0x0000 0 0 3 &mpic 6 1
-			0x0000 0 0 4 &mpic 7 1
-			>;
-
-		pcie@0 {
-			reg = <0 0 0 0 0>;
-			#size-cells = <2>;
-			#address-cells = <3>;
-			device_type = "pci";
-			ranges = <0x02000000 0x0 0xa0000000
-				  0x02000000 0x0 0xa0000000
-				  0x0 0x20000000
-
-				  0x01000000 0x0 0x00000000
-				  0x01000000 0x0 0x00000000
-				  0x0 0x00100000>;
-		};
-	};
-};
-- 
2.7.2

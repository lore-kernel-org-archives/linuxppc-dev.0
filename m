Return-Path: <agust@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id A74E32C00B9
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Apr 2013 05:10:22 +1000 (EST)
From: Anatolij Gustschin <agust@denx.de>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH] powerpc/512x: add ifm ac14xx board
Date: Wed, 10 Apr 2013 21:10:09 +0200
Message-Id: <1365621009-32482-1-git-send-email-agust@denx.de>
Cc: Anatolij Gustschin <agust@denx.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Add dts file for ac14xx board and its board compatible
string to the generic mpc512x board match list.

Signed-off-by: Anatolij Gustschin <agust@denx.de>
---
 arch/powerpc/boot/dts/ac14xx.dts              |  392 +++++++++++++++++++++++++
 arch/powerpc/platforms/512x/mpc512x_generic.c |    1 +
 2 files changed, 393 insertions(+), 0 deletions(-)
 create mode 100644 arch/powerpc/boot/dts/ac14xx.dts

diff --git a/arch/powerpc/boot/dts/ac14xx.dts b/arch/powerpc/boot/dts/ac14xx.dts
new file mode 100644
index 0000000..a27a460
--- /dev/null
+++ b/arch/powerpc/boot/dts/ac14xx.dts
@@ -0,0 +1,392 @@
+/*
+ * Device Tree Source for the MPC5121e based ac14xx board
+ *
+ * Copyright 2012 Anatolij Gustschin <agust@denx.de>
+ *
+ * This program is free software; you can redistribute  it and/or modify it
+ * under  the terms of  the GNU General  Public License as published by the
+ * Free Software Foundation;  either version 2 of the  License, or (at your
+ * option) any later version.
+ */
+
+
+/include/ "mpc5121.dtsi"
+
+/ {
+	model = "ac14xx";
+	compatible = "ifm,ac14xx", "fsl,mpc5121";
+	#address-cells = <1>;
+	#size-cells = <1>;
+
+	aliases {
+		serial0 = &serial0;
+		serial1 = &serial7;
+		spi4 = &spi4;
+		spi5 = &spi5;
+	};
+
+	cpus {
+		PowerPC,5121@0 {
+			timebase-frequency = <40000000>;	/*  40 MHz (csb/4) */
+			bus-frequency = <160000000>;		/* 160 MHz csb bus */
+			clock-frequency = <400000000>;		/* 400 MHz ppc core */
+		};
+	};
+
+	memory {
+		reg = <0x00000000 0x10000000>;			/* 256MB at 0 */
+	};
+
+	nfc@40000000 {
+		status = "disabled";
+	};
+
+	localbus@80000020 {
+		ranges = <0x0 0x0 0xfc000000 0x04000000	/* CS0: NOR flash */
+			  0x1 0x0 0xe0000000 0x00010000 /* CS1: FRAM */
+			  0x2 0x0 0xe0100000 0x00080000 /* CS2: asi1 */
+			  0x3 0x0 0xe0300000 0x00020000 /* CS3: comm */
+			  0x5 0x0 0xe0400000 0x00010000 /* CS5: safety */
+			  0x6 0x0 0xe0200000 0x00080000>; /* CS6: asi2 */
+
+		flash@0,0 {
+			compatible = "cfi-flash";
+			reg = <0 0x00000000 0x04000000>;
+			#address-cells = <1>;
+			#size-cells = <1>;
+			bank-width = <2>;
+			device-width = <2>;
+
+			partition@0 {
+				label = "dtb-kernel-production";
+				reg = <0x00000000 0x00400000>;
+			};
+			partition@1 {
+				label = "filesystem-production";
+				reg = <0x00400000 0x03400000>;
+			};
+
+			partition@2 {
+				label = "recovery";
+				reg = <0x03800000 0x00700000>;
+			};
+
+			partition@3 {
+				label = "uboot-code";
+				reg = <0x03f00000 0x00040000>;
+			};
+			partition@4 {
+				label = "uboot-env1";
+				reg = <0x03f40000 0x00020000>;
+			};
+			partition@5 {
+				label = "uboot-env2";
+				reg = <0x03f60000 0x00020000>;
+			};
+		};
+
+		fram@1,0 {
+			compatible = "ifm,ac14xx-fram", "linux,uio-pdrv-genirq";
+			reg = <1 0x00000000 0x00010000>;
+		};
+
+		asi@2,0 {
+			/* masters mapping: CS, CS offset, size */
+			reg = <2 0x00000000 0x00080000
+			       6 0x00000000 0x00080000>;
+			#address-cells = <1>;
+			#size-cells = <1>;
+			compatible = "ifm,ac14xx-asi-fpga";
+			gpios = <
+				&gpio_pic 26 0	/* prog */
+				&gpio_pic 27 0	/* done */
+				&gpio_pic 10 0	/* reset */
+				>;
+
+			master@1 {
+				interrupts = <20 0x2>;
+				interrupt-parent = <&gpio_pic>;
+				chipselect = <2 0x00009000 0x00009100>;
+				label = "AS-i master 1";
+			};
+
+			master@2 {
+				interrupts = <21 0x2>;
+				interrupt-parent = <&gpio_pic>;
+				chipselect = <6 0x00009000 0x00009100>;
+				label = "AS-i master 2";
+			};
+		};
+
+		netx@3,0 {
+			compatible = "ifm,netx";
+			reg = <0x3 0x00000000 0x00020000>;
+			chipselect = <3 0x00101140 0x00203100>;
+			interrupts = <17 0x8>;
+			gpios = <&gpio_pic 15 0>;
+		};
+
+		safety@5,0 {
+			compatible = "ifm,safety";
+			reg = <0x5 0x00000000 0x00010000>;
+			chipselect = <5 0x00009000 0x00009100>;
+			interrupts = <22 0x2>;
+			interrupt-parent = <&gpio_pic>;
+			gpios = <
+				&gpio_pic 12 0	/* prog */
+				&gpio_pic 11 0	/* done */
+				>;
+		};
+	};
+
+	soc@80000000 {
+
+		clock@f00 {
+			compatible = "fsl,mpc5121rev2-clock", "fsl,mpc5121-clock";
+		};
+
+		/*
+		 * GPIO PIC:
+		 * interrupts cell = <pin nr, sense>
+		 * sense == 8: Level, low assertion
+		 * sense == 2: Edge, high-to-low change
+		 */
+		gpio_pic: gpio@1100 {
+			gpio-controller;
+			#gpio-cells = <2>;
+			interrupt-controller;
+			#interrupt-cells = <2>;
+		};
+
+		sdhc@1500 {
+			cd-gpios = <&gpio_pic 23 0>;	/* card detect */
+			wp-gpios = <&gpio_pic 24 0>;	/* write protect */
+			wp-inverted;			/* WP active high */
+		};
+
+		i2c@1700 {
+			/* use Fast-mode */
+			clock-frequency = <400000>;
+
+			at24@30 {
+				compatible = "at24,24c01";
+				reg = <0x30>;
+			};
+
+			at24@31 {
+				compatible = "at24,24c01";
+				reg = <0x31>;
+			};
+
+			temp@48 {
+				compatible = "ad,ad7414";
+				reg = <0x48>;
+			};
+
+			at24@50 {
+				compatible = "at24,24c01";
+				reg = <0x50>;
+			};
+
+			at24@51 {
+				compatible = "at24,24c01";
+				reg = <0x51>;
+			};
+
+			at24@52 {
+				compatible = "at24,24c01";
+				reg = <0x52>;
+			};
+
+			at24@53 {
+				compatible = "at24,24c01";
+				reg = <0x53>;
+			};
+
+			at24@54 {
+				compatible = "at24,24c01";
+				reg = <0x54>;
+			};
+
+			at24@55 {
+				compatible = "at24,24c01";
+				reg = <0x55>;
+			};
+
+			at24@56 {
+				compatible = "at24,24c01";
+				reg = <0x56>;
+			};
+
+			at24@57 {
+				compatible = "at24,24c01";
+				reg = <0x57>;
+			};
+
+			rtc@68 {
+				compatible = "stm,m41t00";
+				reg = <0x68>;
+			};
+		};
+
+		axe_pic: axe-base@2000 {
+			compatible = "fsl,mpc5121-axe-base";
+			reg = <0x2000 0x100>;
+			interrupts = <42 0x8>;
+			interrupt-controller;
+			#interrupt-cells = <2>;
+		};
+
+		axe-app {
+			compatible = "fsl,mpc5121-axe-app";
+			interrupt-parent = <&axe_pic>;
+			interrupts = <
+					/* soft interrupts */
+					0 0x0	1 0x0	2 0x0	3 0x0
+					4 0x0	5 0x0	6 0x0	7 0x0
+					/* fifo interrupts */
+					8 0x0	9 0x0	10 0x0	11 0x0
+				>;
+		};
+
+		display@2100 {
+			edid = [00 FF FF FF FF FF FF 00 14 94 00 00 00 00 00 00
+				0A 12 01 03 80 1C 23 78 CA 88 FF 94 52 54 8E 27
+				1E 4C 50 00 00 00 01 01 01 01 01 01 01 01 01 01
+				01 01 01 01 01 01 FB 00 B0 14 00 DC 05 00 08 04
+				21 00 1C 23 00 00 00 18 00 00 00 FD 00 38 3C 1F
+				3C 01 0A 20 20 20 20 20 20 20 00 00 00 FC 00 45
+				54 30 31 38 30 30 33 44 4D 55 0A 0A 00 00 00 10
+				00 41 30 30 30 30 30 30 30 30 30 30 30 31 00 D5];
+		};
+
+		can@2300 {
+			status = "disabled";
+		};
+
+		can@2380 {
+			status = "disabled";
+		};
+
+		viu@2400 {
+			status = "disabled";
+		};
+
+		mdio@2800 {
+			phy0: ethernet-phy@1f {
+				compatible = "smsc,lan8700";
+				reg = <0x1f>;
+			};
+		};
+
+		enet: ethernet@2800 {
+			phy-handle = <&phy0>;
+		};
+
+		usb@3000 {
+			status = "disabled";
+		};
+
+		usb@4000 {
+			status = "disabled";
+		};
+
+		/* PSC3 serial port A, aka ttyPSC0 */
+		serial0: psc@11300 {
+			compatible = "fsl,mpc5121-psc-uart", "fsl,mpc5121-psc";
+			fsl,rx-fifo-size = <512>;
+			fsl,tx-fifo-size = <512>;
+		};
+
+		/* PSC4 in SPI mode */
+		spi4: psc@11400 {
+			compatible = "fsl,mpc5121-psc-spi", "fsl,mpc5121-psc";
+			fsl,rx-fifo-size = <768>;
+			fsl,tx-fifo-size = <768>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			num-cs = <1>;
+			cs-gpios = <&gpio_pic 25 0>;
+
+			flash: m25p128@0 {
+				compatible = "st,m25p128";
+				spi-max-frequency = <20000000>;
+				reg = <0>;
+				#address-cells = <1>;
+				#size-cells = <1>;
+
+				partition@0 {
+					label = "spi-flash0";
+					reg = <0x00000000 0x01000000>;
+				};
+			};
+		};
+
+		/* PSC5 in SPI mode */
+		spi5: psc@11500 {
+			compatible = "fsl,mpc5121-psc-spi", "fsl,mpc5121-psc";
+			fsl,mode = "spi-master";
+			fsl,rx-fifo-size = <128>;
+			fsl,tx-fifo-size = <128>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			lcd@0 {
+				compatible = "ilitek,ili922x";
+				reg = <0>;
+				spi-max-frequency = <100000>;
+				spi-cpol;
+				spi-cpha;
+			};
+		};
+
+		/* PSC7 serial port C, aka ttyPSC2 */
+		serial7: psc@11700 {
+			compatible = "fsl,mpc5121-psc-uart", "fsl,mpc5121-psc";
+			fsl,rx-fifo-size = <512>;
+			fsl,tx-fifo-size = <512>;
+		};
+
+		matrix_keypad@0 {
+			compatible = "gpio-matrix-keypad";
+			debounce-delay-ms = <5>;
+			col-scan-delay-us = <1>;
+			gpio-activelow;
+			col-gpios-binary;
+			col-switch-delay-ms = <200>;
+
+			col-gpios = <&gpio_pic 1 0>;	/* pin1 */
+
+			row-gpios = <&gpio_pic 2 0	/* pin2 */
+				     &gpio_pic 3 0	/* pin3 */
+				     &gpio_pic 4 0>;	/* pin4 */
+
+			linux,keymap = <0x0000006e	/* FN LEFT */
+					0x01000067	/* UP */
+					0x02000066	/* FN RIGHT */
+					0x00010069	/* LEFT */
+					0x0101006a	/* DOWN */
+					0x0201006c>;	/* RIGHT */
+		};
+	};
+
+	leds {
+		compatible = "gpio-leds";
+
+		backlight {
+			label = "backlight";
+			gpios = <&gpio_pic 0 0>;
+			default-state = "keep";
+		};
+		green {
+			label = "green";
+			gpios = <&gpio_pic 18 0>;
+			default-state = "keep";
+		};
+		red {
+			label = "red";
+			gpios = <&gpio_pic 19 0>;
+			default-state = "keep";
+		};
+	};
+};
diff --git a/arch/powerpc/platforms/512x/mpc512x_generic.c b/arch/powerpc/platforms/512x/mpc512x_generic.c
index 6dfcb51..5fb919b 100644
--- a/arch/powerpc/platforms/512x/mpc512x_generic.c
+++ b/arch/powerpc/platforms/512x/mpc512x_generic.c
@@ -29,6 +29,7 @@
 static const char * const board[] __initconst = {
 	"prt,prtlvt",
 	"fsl,mpc5125ads",
+	"ifm,ac14xx",
 	NULL
 };
 
-- 
1.7.5.4

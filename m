Return-Path: <m8@semihalf.com>
Received: from mail.semihalf.com (mail.semihalf.com [83.12.36.68])
	by ozlabs.org (Postfix) with ESMTP id B6833DE183
	for <linuxppc-dev@ozlabs.org>; Wed, 24 Oct 2007 09:14:30 +1000 (EST)
Received: from localhost (unknown [127.0.0.1])
	by mail.semihalf.com (Postfix) with ESMTP id 59EF914466
	for <linuxppc-dev@ozlabs.org>; Wed, 24 Oct 2007 01:14:31 +0200 (CEST)
Received: from mail.semihalf.com ([127.0.0.1])
	by localhost (mail.semihalf.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 08109-09 for <linuxppc-dev@ozlabs.org>;
	Wed, 24 Oct 2007 01:14:28 +0200 (CEST)
Received: from hekate.izotz.org (frozen.izotz.org [83.175.187.135])
	by mail.semihalf.com (Postfix) with ESMTP id E2DAF142C1
	for <linuxppc-dev@ozlabs.org>; Wed, 24 Oct 2007 01:14:27 +0200 (CEST)
From: Marian Balakowicz <m8@semihalf.com>
Subject: [PATCH 10/11] [POWERPC] Promess Motion-PRO DTS
To: linuxppc-dev@ozlabs.org
Date: Wed, 24 Oct 2007 01:14:04 +0200
Message-ID: <20071023231404.29359.34377.stgit@hekate.izotz.org>
In-Reply-To: <20071023231302.29359.27417.stgit@hekate.izotz.org>
References: <20071023231302.29359.27417.stgit@hekate.izotz.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Add device tree source file for Motion-PRO board.

Signed-off-by: Marian Balakowicz <m8@semihalf.com>
---

 arch/powerpc/boot/dts/motionpro.dts |  360 +++++++++++++++++++++++++++++++++++
 1 files changed, 360 insertions(+), 0 deletions(-)
 create mode 100644 arch/powerpc/boot/dts/motionpro.dts


diff --git a/arch/powerpc/boot/dts/motionpro.dts b/arch/powerpc/boot/dts/motionpro.dts
new file mode 100644
index 0000000..5b9896a
--- /dev/null
+++ b/arch/powerpc/boot/dts/motionpro.dts
@@ -0,0 +1,360 @@
+/*
+ * Motion-PRO board Device Tree Source
+ *
+ * Copyright (C) 2007 Semihalf
+ * Marian Balakowicz <m8@semihalf.com>
+ *
+ * This program is free software; you can redistribute  it and/or modify it
+ * under  the terms of  the GNU General  Public License as published by the
+ * Free Software Foundation;  either version 2 of the  License, or (at your
+ * option) any later version.
+ */
+
+/*
+ * WARNING: Do not depend on this tree layout remaining static just yet.
+ * The MPC5200 device tree conventions are still in flux
+ * Keep an eye on the linuxppc-dev mailing list for more details
+ */
+
+/ {
+	model = "promess,motionpro";
+	compatible = "promess,motionpro","generic-mpc5200";
+	#address-cells = <1>;
+	#size-cells = <1>;
+
+	cpus {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		PowerPC,5200@0 {
+			device_type = "cpu";
+			reg = <0>;
+			d-cache-line-size = <20>;
+			i-cache-line-size = <20>;
+			d-cache-size = <4000>;		// L1, 16K
+			i-cache-size = <4000>;		// L1, 16K
+			timebase-frequency = <0>;	// from bootloader
+			bus-frequency = <0>;		// from bootloader
+			clock-frequency = <0>;		// from bootloader
+		};
+	};
+
+	memory {
+		device_type = "memory";
+		reg = <00000000 04000000>;	// 64MB
+	};
+
+	soc5200@f0000000 {
+		model = "fsl,mpc5200b";
+		compatible = "mpc5200";
+		revision = "";			// from bootloader
+		device_type = "soc";
+		ranges = <0 f0000000 0000c000>;
+		reg = <f0000000 00000100>;
+		bus-frequency = <0>;		// from bootloader
+		system-frequency = <0>;		// from bootloader
+
+		cdm@200 {
+			compatible = "mpc5200b-cdm","mpc5200-cdm";
+			reg = <200 38>;
+		};
+
+		mpc5200_pic: pic@500 {
+			// 5200 interrupts are encoded into two levels;
+			interrupt-controller;
+			#interrupt-cells = <3>;
+			device_type = "interrupt-controller";
+			compatible = "mpc5200b-pic","mpc5200-pic";
+			reg = <500 80>;
+		};
+
+		gpt@600 {	// General Purpose Timer
+			compatible = "fsl,mpc5200b-gpt","fsl,mpc5200-gpt";
+			cell-index = <0>;
+			reg = <600 10>;
+			interrupts = <1 9 0>;
+			interrupt-parent = <&mpc5200_pic>;
+			fsl,has-wdt;
+		};
+
+		gpt@610 {	// General Purpose Timer
+			compatible = "fsl,mpc5200b-gpt","fsl,mpc5200-gpt";
+			cell-index = <1>;
+			reg = <610 10>;
+			interrupts = <1 a 0>;
+			interrupt-parent = <&mpc5200_pic>;
+		};
+
+		gpt@620 {	// General Purpose Timer
+			compatible = "fsl,mpc5200b-gpt","fsl,mpc5200-gpt";
+			cell-index = <2>;
+			reg = <620 10>;
+			interrupts = <1 b 0>;
+			interrupt-parent = <&mpc5200_pic>;
+		};
+
+		gpt@630 {	// General Purpose Timer
+			compatible = "fsl,mpc5200b-gpt","fsl,mpc5200-gpt";
+			cell-index = <3>;
+			reg = <630 10>;
+			interrupts = <1 c 0>;
+			interrupt-parent = <&mpc5200_pic>;
+		};
+
+		gpt@640 {	// General Purpose Timer
+			compatible = "fsl,mpc5200b-gpt","fsl,mpc5200-gpt";
+			cell-index = <4>;
+			reg = <640 10>;
+			interrupts = <1 d 0>;
+			interrupt-parent = <&mpc5200_pic>;
+		};
+
+		gpt@650 {	// General Purpose Timer
+			compatible = "fsl,mpc5200b-gpt","fsl,mpc5200-gpt";
+			cell-index = <5>;
+			reg = <650 10>;
+			interrupts = <1 e 0>;
+			interrupt-parent = <&mpc5200_pic>;
+		};
+
+		gpt@660 {	// Motion-PRO status LED
+			compatible = "promess,motionpro-statusled";
+			cell-index = <6>;
+			reg = <660 10>;
+			interrupts = <1 f 0>;
+			interrupt-parent = <&mpc5200_pic>;
+		};
+
+		gpt@670 {	// Motion-PRO ready LED
+			compatible = "promess,motionpro-readyled";
+			cell-index = <7>;
+			reg = <670 10>;
+			interrupts = <1 10 0>;
+			interrupt-parent = <&mpc5200_pic>;
+		};
+
+		rtc@800 {	// Real time clock
+			compatible = "mpc5200b-rtc","mpc5200-rtc";
+			device_type = "rtc";
+			reg = <800 100>;
+			interrupts = <1 5 0 1 6 0>;
+			interrupt-parent = <&mpc5200_pic>;
+		};
+
+		mscan@980 {
+			compatible = "mpc5200b-mscan","mpc5200-mscan";
+			cell-index = <1>;
+			interrupts = <2 12 0>;
+			interrupt-parent = <&mpc5200_pic>;
+			reg = <980 80>;
+		};
+
+		gpio@b00 {
+			compatible = "mpc5200b-gpio","mpc5200-gpio";
+			reg = <b00 40>;
+			interrupts = <1 7 0>;
+			interrupt-parent = <&mpc5200_pic>;
+		};
+
+		gpio-wkup@c00 {
+			compatible = "mpc5200b-gpio-wkup","mpc5200-gpio-wkup";
+			reg = <c00 40>;
+			interrupts = <1 8 0 0 3 0>;
+			interrupt-parent = <&mpc5200_pic>;
+		};
+
+
+		spi@f00 {
+			device_type = "spi";
+			compatible = "mpc5200b-spi","mpc5200-spi";
+			reg = <f00 20>;
+			interrupts = <2 d 0 2 e 0>;
+			interrupt-parent = <&mpc5200_pic>;
+		};
+
+		usb@1000 {
+			device_type = "usb-ohci-be";
+			compatible = "mpc5200b-ohci","mpc5200-ohci","ohci-be";
+			reg = <1000 ff>;
+			interrupts = <2 6 0>;
+			interrupt-parent = <&mpc5200_pic>;
+		};
+
+		dma-controller@1200 {
+			compatible = "mpc5200b-bestcomm","mpc5200-bestcomm";
+			reg = <1200 80>;
+			interrupts = <3 0 0  3 1 0  3 2 0  3 3 0
+			              3 4 0  3 5 0  3 6 0  3 7 0
+			              3 8 0  3 9 0  3 a 0  3 b 0
+			              3 c 0  3 d 0  3 e 0  3 f 0>;
+			interrupt-parent = <&mpc5200_pic>;
+		};
+
+		xlb@1f00 {
+			compatible = "mpc5200b-xlb","mpc5200-xlb";
+			reg = <1f00 100>;
+		};
+
+		serial@2000 {		// PSC1
+			device_type = "serial";
+			compatible = "mpc5200b-psc-uart","mpc5200-psc-uart";
+			port-number = <0>;  // Logical port assignment
+			cell-index = <0>;
+			reg = <2000 100>;
+			interrupts = <2 1 0>;
+			interrupt-parent = <&mpc5200_pic>;
+		};
+
+		// PSC2 in spi master mode 
+		spi@2200 {		// PSC2
+			device_type = "spi";
+			compatible = "mpc5200b-psc-spi","mpc5200-psc-spi";
+			cell-index = <1>;
+			reg = <2200 100>;
+			interrupts = <2 2 0>;
+			interrupt-parent = <&mpc5200_pic>;
+		};
+
+		// PSC5 in uart mode
+		serial@2800 {		// PSC5
+			device_type = "serial";
+			compatible = "mpc5200b-psc-uart","mpc5200-psc-uart";
+			port-number = <4>;  // Logical port assignment
+			cell-index = <4>;
+			reg = <2800 100>;
+			interrupts = <2 c 0>;
+			interrupt-parent = <&mpc5200_pic>;
+		};
+
+		ethernet@3000 {
+			device_type = "network";
+			compatible = "mpc5200b-fec","mpc5200-fec";
+			reg = <3000 800>;
+			local-mac-address = [ 00 00 00 00 00 00 ]; /* Filled in by U-Boot */
+			interrupts = <2 5 0>;
+			interrupt-parent = <&mpc5200_pic>;
+		};
+
+		ata@3a00 {
+			device_type = "ata";
+			compatible = "mpc5200b-ata","mpc5200-ata";
+			reg = <3a00 100>;
+			interrupts = <2 7 0>;
+			interrupt-parent = <&mpc5200_pic>;
+		};
+
+		i2c@3d40 {
+			device_type = "i2c";
+			compatible = "mpc5200b-i2c","mpc5200-i2c","fsl-i2c";
+			reg = <3d40 40>;
+			interrupts = <2 10 0>;
+			interrupt-parent = <&mpc5200_pic>;
+			fsl5200-clocking;
+		};
+
+		sram@8000 {
+			compatible = "mpc5200b-sram","mpc5200-sram","sram";
+			reg = <8000 4000>;
+		};
+	};
+
+	lpb {
+		model = "fsl,lpb";
+		compatible = "lpb";
+		device_type = "lpb";
+		ranges = <50000000 50000000 00030000
+			  ff000000 ff000000 01000000>;
+
+		// 8-bit DualPort SRAM on LocalPlus Bus CS1
+		kollmorgen@50000000 {
+			compatible = "promess,motionpro-kollmorgen";
+			reg = <50000000 ffff>;
+			interrupts = <1 1 0>;
+			interrupt-parent = <&mpc5200_pic>;
+		};
+
+		// 8-bit board CPLD on LocalPlus Bus CS2
+		cpld@50010000 {
+			compatible = "promess,motionpro-cpld";
+			reg = <50010000 ffff>;
+		};
+
+		// 8-bit custom Anybus Module on LocalPlus Bus CS3
+		anybus50020000 {
+			compatible = "promess,motionpro-anybus";
+			reg = <50020000 ffff>;
+		};
+		pro_module_general@50020000 {
+			compatible = "promess,pro_module_general";
+			reg = <50020000 3>;
+		};
+		pro_module_dio@50020800 {
+			compatible = "promess,pro_module_dio";
+			reg = <50020800 2>;
+		};
+
+		// 16-bit flash device at LocalPlus Bus CS0
+		flash@ff000000 {
+			compatible = "cfi-flash";
+			reg = <ff000000 01000000>;
+			bank-width = <2>;
+			device-width = <2>;
+			#size-cells = <1>;
+			#address-cells = <1>;
+			partition@0 {
+				label = "fs";
+				reg = <0 d00000>;
+			};
+			partition@d00000 {
+				label = "kernel";
+				reg = <d00000 200000>;
+			};
+			partition@f00000 {
+				label = "uboot";
+				reg = <f00000 40000>;
+			};
+			partition@f40000 {
+				label = "env";
+				reg = <f40000 20000>;
+			};
+			partition@f60000 {
+				label = "redund_env";
+				reg = <f60000 20000>;
+			};
+			partition@f80000 {
+				label = "dtb";
+				reg = <f80000 20000>;
+			};
+			partition@fa0000 {
+				label = "user_data";
+				reg = <fa0000 60000>;
+			};
+		};
+	};
+
+	pci@f0000d00 {
+		#interrupt-cells = <1>;
+		#size-cells = <2>;
+		#address-cells = <3>;
+		device_type = "pci";
+		compatible = "mpc5200b-pci","mpc5200-pci";
+		reg = <f0000d00 100>;
+		interrupt-map-mask = <f800 0 0 7>;
+		interrupt-map = <c000 0 0 1 &mpc5200_pic 0 0 3 // 1st slot
+				 c000 0 0 2 &mpc5200_pic 1 1 3
+				 c000 0 0 3 &mpc5200_pic 1 2 3
+				 c000 0 0 4 &mpc5200_pic 1 3 3
+
+				 c800 0 0 1 &mpc5200_pic 1 1 3 // 2nd slot
+				 c800 0 0 2 &mpc5200_pic 1 2 3
+				 c800 0 0 3 &mpc5200_pic 1 3 3
+				 c800 0 0 4 &mpc5200_pic 0 0 3>;
+		clock-frequency = <0>; // From boot loader
+		interrupts = <2 8 0 2 9 0 2 a 0>;
+		interrupt-parent = <&mpc5200_pic>;
+		bus-range = <0 0>;
+		ranges = <42000000 0 80000000 80000000 0 20000000
+			  02000000 0 a0000000 a0000000 0 10000000
+			  01000000 0 00000000 b0000000 0 01000000>;
+	};
+};

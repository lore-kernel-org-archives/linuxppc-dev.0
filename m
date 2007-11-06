Return-Path: <m8@semihalf.com>
Received: from mail.semihalf.com (mail.semihalf.com [83.15.139.206])
	by ozlabs.org (Postfix) with ESMTP id F03B5DE1A0
	for <linuxppc-dev@ozlabs.org>; Wed,  7 Nov 2007 07:06:20 +1100 (EST)
Received: from localhost (unknown [127.0.0.1])
	by mail.semihalf.com (Postfix) with ESMTP id 57E6F14377
	for <linuxppc-dev@ozlabs.org>; Tue,  6 Nov 2007 21:07:12 +0100 (CET)
Received: from mail.semihalf.com ([127.0.0.1])
	by localhost (mail.semihalf.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 00580-03 for <linuxppc-dev@ozlabs.org>;
	Tue,  6 Nov 2007 21:07:10 +0100 (CET)
Received: from hekate.izotz.org (frozen.izotz.org [83.175.187.135])
	by mail.semihalf.com (Postfix) with ESMTP id D028C14399
	for <linuxppc-dev@ozlabs.org>; Tue,  6 Nov 2007 21:07:08 +0100 (CET)
From: Marian Balakowicz <m8@semihalf.com>
Subject: [PATCH v3 09/13] [POWERPC] CM5200 DTS
To: linuxppc-dev@ozlabs.org
Date: Tue, 06 Nov 2007 21:06:07 +0100
Message-ID: <20071106200606.10913.38096.stgit@hekate.izotz.org>
In-Reply-To: <20071106200446.10913.29338.stgit@hekate.izotz.org>
References: <20071106200446.10913.29338.stgit@hekate.izotz.org>
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

Add device tree source file for CM5200 board.

Signed-off-by: Marian Balakowicz <m8@semihalf.com>
---

 arch/powerpc/boot/dts/cm5200.dts |  236 ++++++++++++++++++++++++++++++++++++++
 1 files changed, 236 insertions(+), 0 deletions(-)
 create mode 100644 arch/powerpc/boot/dts/cm5200.dts


diff --git a/arch/powerpc/boot/dts/cm5200.dts b/arch/powerpc/boot/dts/cm5200.dts
new file mode 100644
index 0000000..74e82bf
--- /dev/null
+++ b/arch/powerpc/boot/dts/cm5200.dts
@@ -0,0 +1,236 @@
+/*
+ * CM5200 board Device Tree Source
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
+	model = "schindler,cm5200";
+	compatible = "schindler,cm5200","mpc5200-simple-platform";
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
+		compatible = "fsl,mpc5200b";
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
+			compatible = "mpc5200b-pic","mpc5200-pic";
+			reg = <500 80>;
+		};
+
+		gpt@600 {	// General Purpose Timer
+			compatible = "fsl,mpc5200b-gpt","fsl,mpc5200-gpt";
+			reg = <600 10>;
+			interrupts = <1 9 0>;
+			interrupt-parent = <&mpc5200_pic>;
+			fsl,has-wdt;
+		};
+
+		gpt@610 {	// General Purpose Timer
+			compatible = "fsl,mpc5200b-gpt","fsl,mpc5200-gpt";
+			reg = <610 10>;
+			interrupts = <1 a 0>;
+			interrupt-parent = <&mpc5200_pic>;
+		};
+
+		gpt@620 {	// General Purpose Timer
+			compatible = "fsl,mpc5200b-gpt","fsl,mpc5200-gpt";
+			reg = <620 10>;
+			interrupts = <1 b 0>;
+			interrupt-parent = <&mpc5200_pic>;
+		};
+
+		gpt@630 {	// General Purpose Timer
+			compatible = "fsl,mpc5200b-gpt","fsl,mpc5200-gpt";
+			reg = <630 10>;
+			interrupts = <1 c 0>;
+			interrupt-parent = <&mpc5200_pic>;
+		};
+
+		gpt@640 {	// General Purpose Timer
+			compatible = "fsl,mpc5200b-gpt","fsl,mpc5200-gpt";
+			reg = <640 10>;
+			interrupts = <1 d 0>;
+			interrupt-parent = <&mpc5200_pic>;
+		};
+
+		gpt@650 {	// General Purpose Timer
+			compatible = "fsl,mpc5200b-gpt","fsl,mpc5200-gpt";
+			reg = <650 10>;
+			interrupts = <1 e 0>;
+			interrupt-parent = <&mpc5200_pic>;
+		};
+
+		gpt@660 {	// General Purpose Timer
+			compatible = "fsl,mpc5200b-gpt","fsl,mpc5200-gpt";
+			reg = <660 10>;
+			interrupts = <1 f 0>;
+			interrupt-parent = <&mpc5200_pic>;
+		};
+
+		gpt@670 {	// General Purpose Timer
+			compatible = "fsl,mpc5200b-gpt","fsl,mpc5200-gpt";
+			reg = <670 10>;
+			interrupts = <1 10 0>;
+			interrupt-parent = <&mpc5200_pic>;
+		};
+
+		rtc@800 {	// Real time clock
+			compatible = "mpc5200b-rtc","mpc5200-rtc";
+			reg = <800 100>;
+			interrupts = <1 5 0 1 6 0>;
+			interrupt-parent = <&mpc5200_pic>;
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
+		spi@f00 {
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
+			reg = <2000 100>;
+			interrupts = <2 1 0>;
+			interrupt-parent = <&mpc5200_pic>;
+		};
+
+		serial@2200 {		// PSC2
+			device_type = "serial";
+			compatible = "mpc5200-psc-uart";
+			port-number = <1>;  // Logical port assignment
+			reg = <2200 100>;
+			interrupts = <2 2 0>;
+			interrupt-parent = <&mpc5200_pic>;
+		};
+
+		serial@2400 {		// PSC3
+			device_type = "serial";
+			compatible = "mpc5200-psc-uart";
+			port-number = <2>;  // Logical port assignment
+			reg = <2400 100>;
+			interrupts = <2 3 0>;
+			interrupt-parent = <&mpc5200_pic>;
+		};
+
+		serial@2c00 {		// PSC6
+			device_type = "serial";
+			compatible = "mpc5200b-psc-uart","mpc5200-psc-uart";
+			port-number = <5>;  // Logical port assignment
+			reg = <2c00 100>;
+			interrupts = <2 4 0>;
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
+		i2c@3d40 {
+			compatible = "mpc5200b-i2c","mpc5200-i2c","fsl-i2c";
+			reg = <3d40 40>;
+			interrupts = <2 10 0>;
+			interrupt-parent = <&mpc5200_pic>;
+			fsl5200-clocking;
+		};
+
+		sram@8000 {
+			compatible = "mpc5200b-sram","mpc5200-sram";
+			reg = <8000 4000>;
+		};
+	};
+};

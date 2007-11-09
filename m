Return-Path: <m8@semihalf.com>
Received: from mail.semihalf.com (mail.semihalf.com [83.15.139.206])
	by ozlabs.org (Postfix) with ESMTP id 08BBEDE180
	for <linuxppc-dev@ozlabs.org>; Sat, 10 Nov 2007 04:12:32 +1100 (EST)
Received: from localhost (unknown [127.0.0.1])
	by mail.semihalf.com (Postfix) with ESMTP id 8FF1E14355
	for <linuxppc-dev@ozlabs.org>; Fri,  9 Nov 2007 18:13:39 +0100 (CET)
Received: from mail.semihalf.com ([127.0.0.1])
	by localhost (mail.semihalf.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 15902-09 for <linuxppc-dev@ozlabs.org>;
	Fri,  9 Nov 2007 18:13:38 +0100 (CET)
Received: from hekate.izotz.org (frozen.izotz.org [83.175.187.135])
	by mail.semihalf.com (Postfix) with ESMTP id D1F911431C
	for <linuxppc-dev@ozlabs.org>; Fri,  9 Nov 2007 18:13:37 +0100 (CET)
From: Marian Balakowicz <m8@semihalf.com>
Subject: [PATCH v4 07/13] [POWERPC] TQM5200 DTS
To: linuxppc-dev@ozlabs.org
Date: Fri, 09 Nov 2007 18:12:20 +0100
Message-ID: <20071109171220.16289.59198.stgit@hekate.izotz.org>
In-Reply-To: <20071109171137.16289.39575.stgit@hekate.izotz.org>
References: <20071109171137.16289.39575.stgit@hekate.izotz.org>
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

Add device tree source file for TQM5200 board.

Signed-off-by: Marian Balakowicz <m8@semihalf.com>
---

 arch/powerpc/boot/dts/tqm5200.dts |  184 +++++++++++++++++++++++++++++++++++++
 1 files changed, 184 insertions(+), 0 deletions(-)
 create mode 100644 arch/powerpc/boot/dts/tqm5200.dts


diff --git a/arch/powerpc/boot/dts/tqm5200.dts b/arch/powerpc/boot/dts/tqm5200.dts
new file mode 100644
index 0000000..5017cec
--- /dev/null
+++ b/arch/powerpc/boot/dts/tqm5200.dts
@@ -0,0 +1,184 @@
+/*
+ * TQM5200 board Device Tree Source
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
+	model = "tqc,tqm5200";
+	compatible = "tqc,tqm5200";
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
+		model = "fsl,mpc5200";
+		compatible = "fsl,mpc5200";
+		revision = "";			// from bootloader
+		device_type = "soc";
+		ranges = <0 f0000000 0000c000>;
+		reg = <f0000000 00000100>;
+		bus-frequency = <0>;		// from bootloader
+		system-frequency = <0>;		// from bootloader
+
+		cdm@200 {
+			compatible = "mpc5200-cdm";
+			reg = <200 38>;
+		};
+
+		mpc5200_pic: pic@500 {
+			// 5200 interrupts are encoded into two levels;
+			interrupt-controller;
+			#interrupt-cells = <3>;
+			compatible = "mpc5200-pic";
+			reg = <500 80>;
+		};
+
+		gpt@600 {	// General Purpose Timer
+			compatible = "fsl,mpc5200-gpt";
+			reg = <600 10>;
+			interrupts = <1 9 0>;
+			interrupt-parent = <&mpc5200_pic>;
+			fsl,has-wdt;
+		};
+
+		gpio@b00 {
+			compatible = "mpc5200-gpio";
+			reg = <b00 40>;
+			interrupts = <1 7 0>;
+			interrupt-parent = <&mpc5200_pic>;
+		};
+
+		usb@1000 {
+			compatible = "mpc5200-ohci","ohci-be";
+			reg = <1000 ff>;
+			interrupts = <2 6 0>;
+			interrupt-parent = <&mpc5200_pic>;
+		};
+
+		dma-controller@1200 {
+			compatible = "mpc5200-bestcomm";
+			reg = <1200 80>;
+			interrupts = <3 0 0  3 1 0  3 2 0  3 3 0
+			              3 4 0  3 5 0  3 6 0  3 7 0
+			              3 8 0  3 9 0  3 a 0  3 b 0
+			              3 c 0  3 d 0  3 e 0  3 f 0>;
+			interrupt-parent = <&mpc5200_pic>;
+		};
+
+		xlb@1f00 {
+			compatible = "mpc5200-xlb";
+			reg = <1f00 100>;
+		};
+
+		serial@2000 {		// PSC1
+			device_type = "serial";
+			compatible = "mpc5200-psc-uart";
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
+		ethernet@3000 {
+			device_type = "network";
+			compatible = "mpc5200-fec";
+			reg = <3000 800>;
+			local-mac-address = [ 00 00 00 00 00 00 ]; /* Filled in by U-Boot */
+			interrupts = <2 5 0>;
+			interrupt-parent = <&mpc5200_pic>;
+		};
+
+		ata@3a00 {
+			compatible = "mpc5200-ata";
+			reg = <3a00 100>;
+			interrupts = <2 7 0>;
+			interrupt-parent = <&mpc5200_pic>;
+		};
+
+		i2c@3d40 {
+			compatible = "mpc5200-i2c","fsl-i2c";
+			reg = <3d40 40>;
+			interrupts = <2 10 0>;
+			interrupt-parent = <&mpc5200_pic>;
+			fsl5200-clocking;
+		};
+
+		sram@8000 {
+			compatible = "mpc5200-sram";
+			reg = <8000 4000>;
+		};
+	};
+
+	pci@f0000d00 {
+		#interrupt-cells = <1>;
+		#size-cells = <2>;
+		#address-cells = <3>;
+		device_type = "pci";
+		compatible = "fsl,mpc5200-pci";
+		reg = <f0000d00 100>;
+		interrupt-map-mask = <f800 0 0 7>;
+		interrupt-map = <c000 0 0 1 &mpc5200_pic 0 0 3
+				 c000 0 0 2 &mpc5200_pic 0 0 3
+				 c000 0 0 3 &mpc5200_pic 0 0 3
+				 c000 0 0 4 &mpc5200_pic 0 0 3>;
+		clock-frequency = <0>; // From boot loader
+		interrupts = <2 8 0 2 9 0 2 a 0>;
+		interrupt-parent = <&mpc5200_pic>;
+		bus-range = <0 0>;
+		ranges = <42000000 0 80000000 80000000 0 10000000
+			  02000000 0 90000000 90000000 0 10000000
+			  01000000 0 00000000 a0000000 0 01000000>;
+	};
+};

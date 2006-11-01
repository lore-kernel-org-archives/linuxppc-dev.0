Return-Path: <grant.likely@secretlab.ca>
Received: from sandbox.secretlab.ca (S01060016b61d1226.cg.shawcable.net
	[68.147.191.145]) by ozlabs.org (Postfix) with ESMTP id 8C4EA67BBC
	for <linuxppc-embedded@ozlabs.org>;
	Wed,  1 Nov 2006 19:40:16 +1100 (EST)
From: Grant Likely <grant.likely@secretlab.ca>
To: Sylvain Munaut <tnt@246tnt.com>, linuxppc-embedded@ozlabs.org,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [PATCH] [POWERPC] Device tree for Freescale Lite5200(b) eval board
Date: Wed,  1 Nov 2006 01:39:50 -0700
Message-Id: <11623704061869-git-send-email-grant.likely@secretlab.ca>
In-Reply-To: <11623703962380-git-send-email-grant.likely@secretlab.ca>
References: <11623703962380-git-send-email-grant.likely@secretlab.ca>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Signed-off-by: Grant Likely <grant.likely@secretlab.ca>
---
 arch/powerpc/boot/dts/lite5200b.dts |  268 +++++++++++++++++++++++++++++++++++
 1 files changed, 268 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/boot/dts/lite5200b.dts b/arch/powerpc/boot/dts/lite5200b.dts
new file mode 100644
index 0000000..5863ce5
--- /dev/null
+++ b/arch/powerpc/boot/dts/lite5200b.dts
@@ -0,0 +1,268 @@
+/*
+ * Lite5200b board Device Tree Source
+ *
+ * Copyright 2006 Secret Lab Technologies Ltd.
+ * Grant Likely <grant.likely@secretlab.ca>
+ *
+ * This program is free software; you can redistribute  it and/or modify it
+ * under  the terms of  the GNU General  Public License as published by the
+ * Free Software Foundation;  either version 2 of the  License, or (at your
+ * option) any later version.
+ */
+
+/ {
+	model = "Lite5200b";
+	compatible = "mpc5200b\0mpc52xx";
+	#address-cells = <1>;
+	#size-cells = <1>;
+
+	cpus {
+		#cpus = <1>;
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
+			32-bit;
+		};
+	};
+
+	memory {
+		device_type = "memory";
+		reg = <00000000 10000000>;	// 256MB
+	};
+
+	soc5200@f0000000 {
+		#interrupt-cells = <2>;
+		device_type = "soc";
+		ranges = <0 f0000000 f0010000>;
+		reg = <f0000000 00010000>;
+		bus-frequency = <0>;		// from bootloader
+
+		pic@500 {
+			// 5200 interrupts are encoded into two levels;
+			// Level 1 is 2 bits; [CRIT=0,MAIN=1,PERF=2,SDMA=3]
+			// Level 2 is 6 bits
+			// The levels are encoded into the lower byte of
+			// a single cell; // in binary: 1122 2222
+			linux,phandle = <500>;
+			interrupt-controller;
+			device_type = "interrupt_controller";
+			compatible = "mpc5200b-pic\0mpc52xx-pic";
+			reg = <500 80>;
+			built-in;
+		};
+
+		gpt@600 {	// General Purpose Timer
+			compatible = "mpc5200b-gpt\0mpc52xx-gpt";
+			device_type = "gpt";
+			reg = <600 10>;
+			interrupts = <49 2>;
+			interrupt-parent = <500>;
+		};
+
+		gpt@610 {	// General Purpose Timer
+			compatible = "mpc5200b-gpt\0mpc52xx-gpt";
+			device_type = "gpt";
+			reg = <610 10>;
+			interrupts = <4a 2>;
+			interrupt-parent = <500>;
+		};
+
+		gpt@620 {	// General Purpose Timer
+			compatible = "mpc5200b-gpt\0mpc52xx-gpt";
+			device_type = "gpt";
+			reg = <620 10>;
+			interrupts = <4b 2>;
+			interrupt-parent = <500>;
+		};
+
+		gpt@630 {	// General Purpose Timer
+			compatible = "mpc5200b-gpt\0mpc52xx-gpt";
+			device_type = "gpt";
+			reg = <630 10>;
+			interrupts = <4c 2>;
+			interrupt-parent = <500>;
+		};
+
+		gpt@640 {	// General Purpose Timer
+			compatible = "mpc5200b-gpt\0mpc52xx-gpt";
+			device_type = "gpt";
+			reg = <640 10>;
+			interrupts = <4d 2>;
+			interrupt-parent = <500>;
+		};
+
+		gpt@650 {	// General Purpose Timer
+			compatible = "mpc5200b-gpt\0mpc52xx-gpt";
+			device_type = "gpt";
+			reg = <650 10>;
+			interrupts = <4e 2>;
+			interrupt-parent = <500>;
+		};
+
+		gpt@660 {	// General Purpose Timer
+			compatible = "mpc5200b-gpt\0mpc52xx-gpt";
+			device_type = "gpt";
+			reg = <660 10>;
+			interrupts = <4f 2>;
+			interrupt-parent = <500>;
+		};
+
+		gpt@670 {	// General Purpose Timer
+			compatible = "mpc5200b-gpt\0mpc52xx-gpt";
+			device_type = "gpt";
+			reg = <670 10>;
+			interrupts = <50 2>;
+			interrupt-parent = <500>;
+		};
+
+		rtc@800 {	// Real time clock
+			compatible = "mpc5200-rtc";
+			device_type = "rtc";
+			reg = <800 100>;
+			interrupts = <45 2 46 2>;
+			interrupt-parent = <500>;
+		};
+
+		mscan@900 {
+			device_type = "mscan";
+			compatible = "mpc5200-mscan";
+			interrupts = <91 2>;
+			interrupt-parent = <500>;
+			reg = <900 80>;
+		};
+
+		mscan@980 {
+			device_type = "mscan";
+			compatible = "mpc5200-mscan";
+			interrupts = <52 2>;
+			interrupt-parent = <500>;
+			reg = <980 80>;
+		};
+
+		pci@0d00 {
+			#interrupt-cells = <1>;
+			#size-cells = <2>;
+			#address-cells = <3>;
+			device_type = "pci";
+			compatible = "mpc5200-pci";
+			// I actually know very little about setting up PCI,
+			// so anything here would just be pulled out of my
+			// butt.  Instead I'll leave these placeholders until
+			// I figure out what it should be
+			//
+			// interrupt-map-mask = <>;
+			// interrupt-map = <>;
+			// bus-range = <>;
+			// ranges = <>;
+			//
+			clock-frequency = <3f940aa>;
+			interrupts = <88 2 89 2 8a 2>;
+			interrupt-parent = <500>;
+		};
+
+		spi@f00 {
+			device_type = "spi";
+			compatible = "mpc5200-spi";
+			reg = <f00 20>;
+			interrupts = <8d 2 20e 2>;
+			interrupt-parent = <500>;
+		};
+
+		serial@2000 {		// PSC1
+			device_type = "serial";
+			compatible = "mpc5200b-psc\0mpc52xx-psc";
+			port-number = <0>;  // Logical port assignment
+			reg = <2000 100>;
+			interrupts = <81 2>;
+			interrupt-parent = <500>;
+		};
+
+		// PSC2 in spi mode example
+		spi@2200 {		// PSC2
+			device_type = "spi";
+			compatible = "mpc5200b-psc\0mpc52xx-psc";
+			reg = <2200 100>;
+			interrupts = <82 2>;
+			interrupt-parent = <500>;
+		};
+
+		// PSC3 in CODEC mode example
+		i2s@2400 {		// PSC3
+			device_type = "i2s";
+			compatible = "mpc5200b-psc\0mpc52xx-psc";
+			reg = <2400 100>;
+			interrupts = <83 2>;
+			interrupt-parent = <500>;
+		};
+
+		// PSC4 unconfigured
+		//serial@2600 {		// PSC4
+		//	device_type = "serial";
+		//	compatible = "mpc5200b-psc\0mpc52xx-psc";
+		//	reg = <2600 100>;
+		//	interrupts = <8b 2>;
+		//	interrupt-parent = <500>;
+		//};
+
+		// PSC5 unconfigured
+		//serial@2800 {		// PSC5
+		//	device_type = "serial";
+		//	compatible = "mpc5200b-psc\0mpc52xx-psc";
+		//	reg = <2800 100>;
+		//	interrupts = <8c 2>;
+		//	interrupt-parent = <500>;
+		//};
+
+		// PSC6 in AC97 mode example
+		ac97@2c00 {		// PSC6
+			device_type = "ac97";
+			compatible = "mpc5200b-psc\0mpc52xx-psc";
+			reg = <2c00 100>;
+			interrupts = <84 2>;
+			interrupt-parent = <500>;
+		};
+
+		ethernet@3000 {
+			device_type = "network";
+			compatible = "mpc5200-fec";
+			reg = <3000 800>;
+			mac-address = [ 02 03 04 05 06 07 ]; // Bad!
+			interrupts = <85 2>;
+			interrupt-parent = <500>;
+		};
+
+		ata@3a00 {
+			device_type = "ata";
+			compatible = "mpc5200-ata";
+			reg = <3a00 100>;
+			interrupts = <87 2>;
+			interrupt-parent = <500>;
+		};
+
+		i2c@3d00 {
+			device_type = "i2c";
+			compatible = "mpc5200-i2c";
+			reg = <3d00 40>;
+			interrupts = <8f 2>;
+			interrupt-parent = <500>;
+		};
+
+		i2c@3d40 {
+			device_type = "i2c";
+			compatible = "mpc5200-i2c";
+			reg = <3d40 40>;
+			interrupts = <90 2>;
+			interrupt-parent = <500>;
+		};
+	};
+};
-- 
1.4.3.rc2.g0503

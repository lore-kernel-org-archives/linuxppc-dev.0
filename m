Return-Path: <grant.likely@secretlab.ca>
Received: from sandbox.secretlab.ca (S01060016b61d1226.cg.shawcable.net
	[68.147.191.145]) by ozlabs.org (Postfix) with ESMTP id 5E99F67BEC
	for <linuxppc-dev@ozlabs.org>; Tue,  7 Nov 2006 11:34:40 +1100 (EST)
From: Grant Likely <grant.likely@secretlab.ca>
To: Sylvain Munaut <tnt@246tnt.com>, linuxppc-dev@ozlabs.org,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>, nd@bplan-gmbh.de
Subject: [PATCH 1/5] Add Lite5200B device tree
Date: Mon,  6 Nov 2006 17:34:21 -0700
Message-Id: <11628596751096-git-send-email-grant.likely@secretlab.ca>
In-Reply-To: <11628596653052-git-send-email-grant.likely@secretlab.ca>
References: <11628596653052-git-send-email-grant.likely@secretlab.ca>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Signed-off-by: Grant Likely <grant.likely@secretlab.ca>
---
 arch/powerpc/boot/dts/lite5200b.dts |  275 +++++++++++++++++++++++++++++++++++
 1 files changed, 275 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/boot/dts/lite5200b.dts b/arch/powerpc/boot/dts/lite5200b.dts
new file mode 100644
index 0000000..eff10b7
--- /dev/null
+++ b/arch/powerpc/boot/dts/lite5200b.dts
@@ -0,0 +1,275 @@
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
+		#interrupt-cells = <3>;
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
+			#interrupt-cells = <3>;
+			device_type = "interrupt-controller";
+			compatible = "mpc5200b-pic\0mpc5200-pic\0mpc52xx-pic";
+			reg = <500 80>;
+			built-in;
+		};
+
+		gpt@600 {	// General Purpose Timer
+			compatible = "mpc5200b-gpt\0mpc52xx-gpt";
+			device_type = "gpt";
+			reg = <600 10>;
+			interrupts = <1 9 2>;
+			interrupt-parent = <500>;
+		};
+
+		gpt@610 {	// General Purpose Timer
+			compatible = "mpc5200b-gpt\0mpc52xx-gpt";
+			device_type = "gpt";
+			reg = <610 10>;
+			interrupts = <1 a 2>;
+			interrupt-parent = <500>;
+		};
+
+		gpt@620 {	// General Purpose Timer
+			compatible = "mpc5200b-gpt\0mpc52xx-gpt";
+			device_type = "gpt";
+			reg = <620 10>;
+			interrupts = <1 b 2>;
+			interrupt-parent = <500>;
+		};
+
+		gpt@630 {	// General Purpose Timer
+			compatible = "mpc5200b-gpt\0mpc52xx-gpt";
+			device_type = "gpt";
+			reg = <630 10>;
+			interrupts = <1 c 2>;
+			interrupt-parent = <500>;
+		};
+
+		gpt@640 {	// General Purpose Timer
+			compatible = "mpc5200b-gpt\0mpc52xx-gpt";
+			device_type = "gpt";
+			reg = <640 10>;
+			interrupts = <1 d 2>;
+			interrupt-parent = <500>;
+		};
+
+		gpt@650 {	// General Purpose Timer
+			compatible = "mpc5200b-gpt\0mpc52xx-gpt";
+			device_type = "gpt";
+			reg = <650 10>;
+			interrupts = <1 e 2>;
+			interrupt-parent = <500>;
+		};
+
+		gpt@660 {	// General Purpose Timer
+			compatible = "mpc5200b-gpt\0mpc52xx-gpt";
+			device_type = "gpt";
+			reg = <660 10>;
+			interrupts = <1 f 2>;
+			interrupt-parent = <500>;
+		};
+
+		gpt@670 {	// General Purpose Timer
+			compatible = "mpc5200b-gpt\0mpc52xx-gpt";
+			device_type = "gpt";
+			reg = <670 10>;
+			interrupts = <1 10 2>;
+			interrupt-parent = <500>;
+		};
+
+		rtc@800 {	// Real time clock
+			compatible = "mpc5200b-rtc\0mpc52xx-rtc";
+			device_type = "rtc";
+			reg = <800 100>;
+			interrupts = <1 5 2 1 6 2>;
+			interrupt-parent = <500>;
+		};
+
+		mscan@900 {
+			device_type = "mscan";
+			compatible = "mpc5200b-mscan\0mpc52xx-mscan";
+			interrupts = <2 11 2>;
+			interrupt-parent = <500>;
+			reg = <900 80>;
+		};
+
+		mscan@980 {
+			device_type = "mscan";
+			compatible = "mpc5200b-mscan\0mpc52xx-mscan";
+			interrupts = <1 12 2>;
+			interrupt-parent = <500>;
+			reg = <980 80>;
+		};
+
+		pci@0d00 {
+			#interrupt-cells = <1>;
+			#size-cells = <2>;
+			#address-cells = <3>;
+			device_type = "pci";
+			compatible = "mpc5200b-pci\0mpc52xx-pci";
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
+			interrupts = <2 8 2 2 9 2 2 a 2>;
+			interrupt-parent = <500>;
+		};
+
+		spi@f00 {
+			device_type = "spi";
+			compatible = "mpc5200b-spi\0mpc52xx-spi";
+			reg = <f00 20>;
+			interrupts = <2 d 2 2 e 2>;
+			interrupt-parent = <500>;
+		};
+
+		bestcomm@1200 {
+			device_type = "dma-controller";
+			compatible = "mpc5200b-bestcomm\0mpc5200-bestcomm\0mpc52xx-bestcomm";
+			reg = <1200 80>;
+		};
+
+		serial@2000 {		// PSC1
+			device_type = "serial";
+			compatible = "mpc5200b-psc-serial\0mpc52xx-psc-serial";
+			port-number = <0>;  // Logical port assignment
+			reg = <2000 100>;
+			interrupts = <2 1 2>;
+			interrupt-parent = <500>;
+		};
+
+		// PSC2 in spi mode example
+		spi@2200 {		// PSC2
+			device_type = "spi";
+			compatible = "mpc5200b-psc-spi\0mpc52xx-psc-spi";
+			reg = <2200 100>;
+			interrupts = <2 2 2>;
+			interrupt-parent = <500>;
+		};
+
+		// PSC3 in CODEC mode example
+		i2s@2400 {		// PSC3
+			device_type = "i2s";
+			compatible = "mpc5200b-psc-i2s\0mpc52xx-psc-i2s";
+			reg = <2400 100>;
+			interrupts = <2 3 2>;
+			interrupt-parent = <500>;
+		};
+
+		// PSC4 unconfigured
+		//serial@2600 {		// PSC4
+		//	device_type = "serial";
+		//	compatible = "mpc5200b-psc-serial\0mpc52xx-psc-serial";
+		//	reg = <2600 100>;
+		//	interrupts = <2 b 2>;
+		//	interrupt-parent = <500>;
+		//};
+
+		// PSC5 unconfigured
+		//serial@2800 {		// PSC5
+		//	device_type = "serial";
+		//	compatible = "mpc5200b-psc-serial\0mpc52xx-psc-serial";
+		//	reg = <2800 100>;
+		//	interrupts = <2 c 2>;
+		//	interrupt-parent = <500>;
+		//};
+
+		// PSC6 in AC97 mode example
+		ac97@2c00 {		// PSC6
+			device_type = "ac97";
+			compatible = "mpc5200b-psc-ac97\0mpc52xx-psc-ac97";
+			reg = <2c00 100>;
+			interrupts = <2 4 2>;
+			interrupt-parent = <500>;
+		};
+
+		ethernet@3000 {
+			device_type = "network";
+			compatible = "mpc5200b-fec\0mpc52xx-fec";
+			reg = <3000 800>;
+			mac-address = [ 02 03 04 05 06 07 ]; // Bad!
+			interrupts = <2 5 2>;
+			interrupt-parent = <500>;
+		};
+
+		ata@3a00 {
+			device_type = "ata";
+			compatible = "mpc5200b-ata\0mpc52xx-ata";
+			reg = <3a00 100>;
+			interrupts = <2 7 2>;
+			interrupt-parent = <500>;
+		};
+
+		i2c@3d00 {
+			device_type = "i2c";
+			compatible = "mpc5200b-i2c\0mpc52xx-i2c";
+			reg = <3d00 40>;
+			interrupts = <2 f 2>;
+			interrupt-parent = <500>;
+		};
+
+		i2c@3d40 {
+			device_type = "i2c";
+			compatible = "mpc5200b-i2c\0mpc52xx-i2c";
+			reg = <3d40 40>;
+			interrupts = <2 10 2>;
+			interrupt-parent = <500>;
+		};
+	};
+};
-- 
1.4.3.rc2.g0503

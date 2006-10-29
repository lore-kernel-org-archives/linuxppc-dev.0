Return-Path: <glikely@gmail.com>
Received: from ug-out-1314.google.com (ug-out-1314.google.com [66.249.92.172])
	by ozlabs.org (Postfix) with ESMTP id 2D2F567C58
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 30 Oct 2006 09:59:00 +1100 (EST)
Received: by ug-out-1314.google.com with SMTP id 30so886961ugc
	for <linuxppc-embedded@ozlabs.org>;
	Sun, 29 Oct 2006 14:58:58 -0800 (PST)
Message-ID: <528646bc0610291458k2fc64bcw141ddd2af54696dc@mail.gmail.com>
Date: Sun, 29 Oct 2006 16:58:58 -0600
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@gmail.com
To: "linuxppc-embedded list" <linuxppc-embedded@ozlabs.org>,
	"Sylvain Munaut" <tnt@246tnt.com>
Subject: device tree for lite5200b
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Sylvain,

Here's my second draft of a device tree for the lite5200b.  Enjoy

Note: The interrupt mappings are not correct.  I assumed 2 bits for L1
and 8 for L2.  Nicolas' code uses 2 and 6.

g.

/*
 * Lite5200b board Device Tree Source
 *
 * Copyright 2006 Secret Lab Technologies Ltd.
 * Grant Likely <grant.likely@secretlab.ca>
 *
 * This program is free software; you can redistribute  it and/or modify it
 * under  the terms of  the GNU General  Public License as published by the
 * Free Software Foundation;  either version 2 of the  License, or (at your
 * option) any later version.
 */

/ {
	model = "Lite5200b";
	compatible = "mpc5200";
	#address-cells = <1>;
	#size-cells = <1>;

	cpus {
		#cpus = <1>;
		#address-cells = <1>;
		#size-cells = <0>;

		PowerPC,5200@0 {
			device_type = "cpu";
			reg = <0>;
			d-cache-line-size = <20>;
			i-cache-line-size = <20>;
			d-cache-size = <4000>;		// L1, 16K
			i-cache-size = <4000>;		// L1, 16K
			timebase-frequency = <0>;	// from bootloader
			bus-frequency = <0>;		// from bootloader
			clock-frequency = <0>;		// from bootloader
			32-bit;
		};
	};

	memory {
		device_type = "memory";
		reg = <00000000 10000000>;	// 256MB
	};

	soc5200@f0000000 {
		#interrupt-cells = <2>;
		device_type = "soc";
		ranges = <0 f0000000 f0010000>;
		reg = <f0000000 00010000>;
		bus-frequency = <0>;		// from bootloader

		pic@500 {
			// 5200 interrupts are encoded into two levels;
			// Level 1 is 2 bits; [CRIT=0,MAIN=1,PERF=2,SDMA=3]
			// Level 2 is 5 bits
			// The levels are encoded into a single cell:
			// in binary: xxxx xx11 xxx2 2222
			linux,phandle = <500>;
			interrupt-controller;
			device_type = "interrupt_controller";
			compatible = "mpc52xx-pic";
			reg = <500 80>;
			built-in;
		};

		gpt@600 {	// General Purpose Timer
			compatible = "mpc5200-gpt";
			device_type = "gpt";
			reg = <600 10>;
			interrupts = <109 2>;
			interrupt-parent = <500>;
		};

		gpt@610 {	// General Purpose Timer
			compatible = "mpc5200-gpt";
			device_type = "gpt";
			reg = <610 10>;
			interrupts = <10a 2>;
			interrupt-parent = <500>;
		};

		gpt@620 {	// General Purpose Timer
			compatible = "mpc5200-gpt";
			device_type = "gpt";
			reg = <620 10>;
			interrupts = <10b 2>;
			interrupt-parent = <500>;
		};

		gpt@630 {	// General Purpose Timer
			compatible = "mpc5200-gpt";
			device_type = "gpt";
			reg = <630 10>;
			interrupts = <10c 2>;
			interrupt-parent = <500>;
		};

		gpt@640 {	// General Purpose Timer
			compatible = "mpc5200-gpt";
			device_type = "gpt";
			reg = <640 10>;
			interrupts = <10d 2>;
			interrupt-parent = <500>;
		};

		gpt@650 {	// General Purpose Timer
			compatible = "mpc5200-gpt";
			device_type = "gpt";
			reg = <650 10>;
			interrupts = <10e 2>;
			interrupt-parent = <500>;
		};

		gpt@660 {	// General Purpose Timer
			compatible = "mpc5200-gpt";
			device_type = "gpt";
			reg = <660 10>;
			interrupts = <10f 2>;
			interrupt-parent = <500>;
		};

		gpt@670 {	// General Purpose Timer
			compatible = "mpc5200-gpt";
			device_type = "gpt";
			reg = <670 10>;
			interrupts = <110 2>;
			interrupt-parent = <500>;
		};

		rtc@800 {	// Real time clock
			compatible = "mpc5200-rtc";
			device_type = "rtc";
			reg = <800 100>;
			interrupts = <105 2 106 2>;
			interrupt-parent = <500>;
		};

		mscan@900 {
			device_type = "mscan";
			compatible = "mpc5200-mscan";
			interrupts = <211 2>;
			interrupt-parent = <500>;
			reg = <900 80>;
		};

		mscan@980 {
			device_type = "mscan";
			compatible = "mpc5200-mscan";
			interrupts = <212 2>;
			interrupt-parent = <500>;
			reg = <980 80>;
		};

		pci@0d00 {
			#interrupt-cells = <1>;
			#size-cells = <2>;
			#address-cells = <3>;
			device_type = "pci";
			compatible = "mpc5200-pci";
			// I actually know very little about setting up PCI,
			// so anything here would just be pulled out of my
			// butt.  Instead I'll leave these placeholders until
			// I figure out what it should be
			//
			// interrupt-map-mask = <>;
			// interrupt-map = <>;
			// bus-range = <>;
			// ranges = <>;
			//
			clock-frequency = <3f940aa>;
			interrupts = <208 2 209 2 20a 2>;
			interrupt-parent = <500>;
		};

		spi@f00 {
			device_type = "spi";
			compatible = "mpc5200-spi";
			reg = <f00 20>;
			interrupts = <20d 2 20e 2>;
			interrupt-parent = <500>;
		};

		serial@2000 {		// PSC1
			device_type = "serial";
			compatible = "mpc5200-psc";
			reg = <2000 100>;
			interrupts = <201 2>;
			interrupt-parent = <500>;
		};

		// PSC2 in spi mode example
		spi@2200 {		// PSC2
			device_type = "spi";
			compatible = "mpc5200-psc";
			reg = <2200 100>;
			interrupts = <202 2>;
			interrupt-parent = <500>;
		};

		// PSC3 in CODEC mode example
		i2s@2400 {		// PSC3
			device_type = "i2s";
			compatible = "mpc5200-psc";
			reg = <2400 100>;
			interrupts = <203 2>;
			interrupt-parent = <500>;
		};

		// PSC4 unconfigured
		//serial@2600 {		// PSC4
		//	device_type = "serial";
		//	compatible = "mpc5200-psc";
		//	reg = <2600 100>;
		//	interrupts = <20b 2>;
		//	interrupt-parent = <500>;
		//};

		// PSC5 unconfigured
		//serial@2800 {		// PSC5
		//	device_type = "serial";
		//	compatible = "mpc5200-psc";
		//	reg = <2800 100>;
		//	interrupts = <20c 2>;
		//	interrupt-parent = <500>;
		//};

		// PSC6 in AC97 mode example
		ac97@2c00 {		// PSC6
			device_type = "ac97";
			compatible = "mpc5200-psc";
			reg = <2c00 100>;
			interrupts = <204 2>;
			interrupt-parent = <500>;
		};

		ethernet@3000 {
			device_type = "network";
			compatible = "mpc5200-fec";
			reg = <3000 800>;
			mac-address = [ 02 03 04 05 06 07 ]; // Bad!
			interrupts = <205 2>;
			interrupt-parent = <500>;
		};

		ata@3a00 {
			device_type = "ata";
			compatible = "mpc5200-ata";
			reg = <3a00 100>;
			interrupts = <207 2>;
			interrupt-parent = <500>;
		};

		i2c@3d00 {
			device_type = "i2c";
			compatible = "mpc5200-i2c";
			reg = <3d00 40>;
			interrupts = <20f 2>;
			interrupt-parent = <500>;
		};

		i2c@3d40 {
			device_type = "i2c";
			compatible = "mpc5200-i2c";
			reg = <3d40 40>;
			interrupts = <210 2>;
			interrupt-parent = <500>;
		};
	};
};
-- 
Grant Likely, B.Sc. P.Eng.
Secret Lab Technologies Ltd.
grant.likely@secretlab.ca
(403) 399-0195

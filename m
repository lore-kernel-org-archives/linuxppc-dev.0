Return-Path: <devtty0@gmail.com>
Received: from nf-out-0910.google.com (nf-out-0910.google.com [64.233.182.184])
	by ozlabs.org (Postfix) with ESMTP id F07D2DDE3E
	for <linuxppc-dev@ozlabs.org>; Thu,  1 Mar 2007 10:30:04 +1100 (EST)
Received: by nf-out-0910.google.com with SMTP id m18so648846nfc
	for <linuxppc-dev@ozlabs.org>; Wed, 28 Feb 2007 15:30:02 -0800 (PST)
Message-ID: <45E61161.9040900@gmail.com>
Date: Thu, 01 Mar 2007 00:33:53 +0100
From: Luotao Fu <devtty0@gmail.com>
MIME-Version: 1.0
To: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: problems with pci bus on a pm520 board
References: <45E5ED35.7090207@gmail.com>
	<0a1927a91e52d34352e8a545b7dc57d0@kernel.crashing.org>
In-Reply-To: <0a1927a91e52d34352e8a545b7dc57d0@kernel.crashing.org>
Content-Type: multipart/mixed; boundary="------------070606030000040607000602"
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This is a multi-part message in MIME format.
--------------070606030000040607000602
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Hi,

Segher Boessenkool wrote:
>> 11.* is the usb controller
> 
> Three OHCIs or is one an EHCI?

exactly, two ohci and one ehci.

> 
> 
> 32-bit PCI read I suppose.  Use the BDI to figure out what
> address is accessed, and what source code corresponds to
> this access.

right, I'll take a look as soon as I can grab the bdi.

> 
>> The funny thing is that the e100
>> driver also does some reading calls on iomem in the initialisation, such
>> as readb() in e100_eeprom_read(). It however doesn't cause system
>> freezing and the driver quits with an error message that the eeprom is
>> corrupted. I suppose the problem is somehow still on the pci
>> configuration in the device tree.
> 
> Linux normally is perfectly happy if you leave out all of
> the PCI devices from your device tree (except the root
> bridges of course).

I didn't make any extra entry for the pci devices.

> 
> 
>> Along with this mail I attached my dts file.
> 
> No you didn't.

Ooops. sorry. I'll attach it to this mail.

> 
> 
> Segher
> 
> 

P.S
forgot the cc in my first reply mail, sorry for double posting Segher.
It's getting late here.....
;-)

Thanx
Cheers
Luotao Fu


--------------070606030000040607000602
Content-Type: text/plain;
 name="testboard.dts"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="testboard.dts"

/*
 *
 * JohnDeere Vehicleserver (based on pm520 board by microsys) devicetree file
 * Copyright 2006 Pengutronix
 * Luotao Fu <l.fu@pengutronix.de>
 *
 * This program is free software; you can redistribute  it and/or modify it
 * under  the terms of  the GNU General  Public License as published by the
 * Free Software Foundation;  either version 2 of the  License, or (at your
 * option) any later version.
 */

/ {
	model = "testboard";
	compatible = "testboard\0mpc5200b\0mpc5200";
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
			timebase-frequency = <1e84800>;	// 32MHz
			bus-frequency = <7de2900>;	// 132MHz
			clock-frequency = <179a7b00>;	// 396MHz
			32-bit;
		};
	};

	memory {
		device_type = "memory";
		reg = <00000000 08000000>;	// 128MB
	};

	soc5200@f0000000 {
		#interrupt-cells = <3>;
		device_type = "soc";
		ranges = <0 f0000000 f0010000>;
		reg = <f0000000 00010000>;
		bus-frequency = <7de2900>;	// 132MHz

		cdm@200 {
			compatible = "mpc5200b-cdm\0mpc5200-cdm";
			reg = <200 38>;
		};

		pic@500 {
			// 5200 interrupts are encoded into two levels;
			linux,phandle = <500>;
			interrupt-controller;
			#interrupt-cells = <3>;
			device_type = "interrupt-controller";
			compatible = "mpc5200b-pic\0mpc5200-pic";
			reg = <500 80>;
			built-in;
		};

		gpt@600 {	// General Purpose Timer
			compatible = "mpc5200b-gpt\0mpc5200-gpt";
			device_type = "gpt";
			reg = <600 10>;
			interrupts = <1 9 0>;
			interrupt-parent = <500>;
		};

		gpt@610 {	// General Purpose Timer
			compatible = "mpc5200b-gpt\0mpc5200-gpt";
			device_type = "gpt";
			reg = <610 10>;
			interrupts = <1 a 0>;
			interrupt-parent = <500>;
		};

		gpt@620 {	// General Purpose Timer
			compatible = "mpc5200b-gpt\0mpc5200-gpt";
			device_type = "gpt";
			reg = <620 10>;
			interrupts = <1 b 0>;
			interrupt-parent = <500>;
		};

		gpt@630 {	// General Purpose Timer
			compatible = "mpc5200b-gpt\0mpc5200-gpt";
			device_type = "gpt";
			reg = <630 10>;
			interrupts = <1 c 0>;
			interrupt-parent = <500>;
		};

		gpt@640 {	// General Purpose Timer
			compatible = "mpc5200b-gpt\0mpc5200-gpt";
			device_type = "gpt";
			reg = <640 10>;
			interrupts = <1 d 0>;
			interrupt-parent = <500>;
		};

		gpt@650 {	// General Purpose Timer
			compatible = "mpc5200b-gpt\0mpc5200-gpt";
			device_type = "gpt";
			reg = <650 10>;
			interrupts = <1 e 0>;
			interrupt-parent = <500>;
		};

		gpt@660 {	// General Purpose Timer
			compatible = "mpc5200b-gpt\0mpc5200-gpt";
			device_type = "gpt";
			reg = <660 10>;
			interrupts = <1 f 0>;
			interrupt-parent = <500>;
		};

		gpt@670 {	// General Purpose Timer
			compatible = "mpc5200b-gpt\0mpc5200-gpt";
			device_type = "gpt";
			reg = <670 10>;
			interrupts = <1 10 0>;
			interrupt-parent = <500>;
		};

		rtc@800 {	// Real time clock
			compatible = "mpc5200b-rtc\0mpc5200-rtc";
			device_type = "rtc";
			reg = <800 100>;
			interrupts = <1 5 0 1 6 0>;
			interrupt-parent = <500>;
		};

		mscan@900 {
			device_type = "mscan";
			compatible = "mpc5200b-mscan\0mpc5200-mscan";
			interrupts = <2 11 0>;
			interrupt-parent = <500>;
			reg = <900 80>;
		};

		mscan@980 {
			device_type = "mscan";
			compatible = "mpc5200b-mscan\0mpc5200-mscan";
			interrupts = <2 12 0>;
			interrupt-parent = <500>;
			reg = <980 80>;
		};

		gpio@b00 {
			compatible = "mpc5200b-gpio\0mpc5200-gpio";
			reg = <b00 40>;
			interrupts = <1 7 0>;
			interrupt-parent = <500>;
		};

		gpio-wkup@b00 {
			compatible = "mpc5200b-gpio-wkup\0mpc5200-gpio-wkup";
			reg = <c00 40>;
			interrupts = <1 8 0 0 3 0>;
			interrupt-parent = <500>;
		};

		pci@0d00 {
			#interrupt-cells = <1>;
			#size-cells = <2>;
			#address-cells = <3>;
			device_type = "pci";
			compatible = "mpc5200b-pci\0mpc5200-pci";
			reg = <d00 100>;
			interrupt-map-mask = <f800 0 0 7>;
			interrupt-map = <8000 0 0 1 500 1 1 3 // e100, 10.0
			                 8000 0 0 2 500 1 1 3
			                 8000 0 0 3 500 1 1 3
			                 8000 0 0 4 500 1 1 3

			                 8800 0 0 1 500 1 0 3 // usb 11.0, 11.1, 11.2
			                 8800 0 0 2 500 1 2 3
			                 8800 0 0 3 500 1 3 3
			                 8800 0 0 4 500 0 0 3>;
			clock-frequency = <0>; // From boot loader
			interrupts = <2 8 0 2 9 0 2 a 0>;
			interrupt-parent = <500>;
			bus-range = <0 0>;
			ranges = <42000000 0 80000000 80000000 0 20000000
			          02000000 0 a0000000 a0000000 0 10000000
			          01000000 0 00000000 b0000000 0 01000000>;
		};

		spi@f00 {
			device_type = "spi";
			compatible = "mpc5200b-spi\0mpc5200-spi";
			reg = <f00 20>;
			interrupts = <2 d 0 2 e 0>;
			interrupt-parent = <500>;
		};

		bestcomm@1200 {
			device_type = "dma-controller";
			compatible = "mpc5200b-bestcomm\0mpc5200-bestcomm";
			reg = <1200 80>;
			interrupts = <3 0 0  3 1 0  3 2 0  3 3 0
			              3 4 0  3 5 0  3 6 0  3 7 0
			              3 8 0  3 9 0  3 a 0  3 b 0
			              3 c 0  3 d 0  3 e 0  3 f 0>;
			interrupt-parent = <500>;
		};

		xlb@1f00 {
			compatible = "mpc5200b-xlb\0mpc5200-xlb";
			reg = <1f00 100>;
		};

		// PSC1 is uart
		serial@2000 {		// PSC1
			device_type = "serial";
			compatible = "mpc5200b-psc-uart\0mpc5200-psc-uart";
			reg = <2000 100>;
			interrupts = <2 1 0>;
			interrupt-parent = <500>;
		};

		// PSC6 is uart
		serial@2c00 {		// PSC6
			device_type = "serial";
			compatible = "mpc5200b-psc-uart\0mpc5200-psc-uart";
			reg = <2c00 100>;
			interrupts = <2 4 0>;
			interrupt-parent = <500>;
		};

		ethernet@3000 {
			device_type = "network";
			compatible = "mpc52xx-fec\0mpc5200-ethernet";
			reg = <3000 800>;
			mac-address = [ 02 03 04 05 06 07 ]; // Bad!
			interrupts = <2 5 0>;
			interrupt-parent = <500>;
		};

		i2c@3d00 {
			device_type = "i2c";
			compatible = "mpc5200b-i2c\0mpc5200-i2c";
			reg = <3d00 40>;
			interrupts = <2 f 0>;
			interrupt-parent = <500>;
		};

		i2c@3d40 {
			device_type = "i2c";
			compatible = "mpc5200b-i2c\0mpc5200-i2c";
			reg = <3d40 40>;
			interrupts = <2 10 0>;
			interrupt-parent = <500>;
		};
		sram@8000 {
			device_type = "sram";
			compatible = "mpc5200b-sram\0mpc5200-sram\0sram";
			reg = <8000 4000>;
		};
	};
};


--------------070606030000040607000602--

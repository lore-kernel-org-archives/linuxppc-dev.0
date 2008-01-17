Return-Path: <paul.gortmaker@windriver.com>
Received: from yow-pgortmak-d1.corp.ad.wrs.com (unknown [209.5.119.169])
	by ozlabs.org (Postfix) with ESMTP id 19802DDE2B
	for <linuxppc-dev@ozlabs.org>; Fri, 18 Jan 2008 07:50:40 +1100 (EST)
Date: Thu, 17 Jan 2008 15:50:38 -0500
From: Paul Gortmaker <paul.gortmaker@windriver.com>
To: David Gibson <david@gibson.dropbear.id.au>
Subject: Re: [PATCH 4/7] sbc8560: Add device tree source for Wind River
	SBC8560 board
Message-ID: <20080117205037.GA4122@windriver.com>
References: <ef7d84e06c45289f51f35845ccaa63bbf31827db.1199715362.git.paul.gortmaker@windriver.com>
	<d10d083bafb978936975111f09669120201072ec.1199715362.git.paul.gortmaker@windriver.com>
	<20080110025622.GE17816@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20080110025622.GE17816@localhost.localdomain>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

In message: Re: [PATCH 4/7] sbc8560: Add device tree source for Wind River SBC8560 board
on 10/01/2008 David Gibson wrote:

> > +	epld@fc000000 {
> > +		#address-cells = <1>;
> > +		#size-cells = <1>;
> > +		compatible = "localbus";
> 
> This compatible doesn't look specific enough.  It should at least have
> a vendor prefix.

Sorry for the delayed reply.  I've gone with "wrs,epld-localbus" based on
the format of all the existing localbus entries.

> 
> > +		ranges = <0 fc000000 00c00000>;
> 
> Typically, we've been doing these external bust controller type
> gadgets with address-cells = <2>, the first cell explicitly encoding
> the chipselect.  This gets us closer to the ideal of the device tree
> encoding only hardware information, not how the bridge controller is
> configured (although "ranges" will still have to contain configuration
> dependent information).

OK, I think I've captured the intent of what you mean here.  It makes
the dts appear a lot more complex to a non-dts person (IMHO), but it
does capture the full details of the board this way.

I've put in a 2 address cell localbus entry, put in all the devices
listed in TFM for each CS#, of which the EPLD is on CS5, and since
the EPLD sub-decodes off of CS5, it too is a bus with 2 address cells
and the equivalent of a CS# for each sub-device.  It takes a bit to get
your head around the various ranges = <...> with varying #s of parameters
(or at least it did for me) but I think I have it mapped out properly.
The UARTs still work, and since they are out in the weeds now, some three
nodes deep, it has to be at least partially correct...

[All the good stuff with the localbus is near the bottom of the dts.]

Paul.


/*
 * SBC8560 Device Tree Source
 *
 * Copyright 2007 Wind River Systems Inc.
 *
 * Paul Gortmaker (see MAINTAINERS for contact information)
 *
 * This program is free software; you can redistribute  it and/or modify it
 * under  the terms of  the GNU General  Public License as published by the
 * Free Software Foundation;  either version 2 of the  License, or (at your
 * option) any later version.
 */

/dts-v1/;

/ {
	model = "SBC8560";
	compatible = "SBC8560";
	#address-cells = <1>;
	#size-cells = <1>;

	aliases {
		ethernet0 = &enet0;
		ethernet1 = &enet1;
		ethernet2 = &enet2;
		ethernet3 = &enet3;
		serial0 = &serial0;
		serial1 = &serial1;
		pci0 = &pci0;
	};

	cpus {
		#address-cells = <1>;
		#size-cells = <0>;

		PowerPC,8560@0 {
			device_type = "cpu";
			reg = <0>;
			d-cache-line-size = <0x20>;	// 32 bytes
			i-cache-line-size = <0x20>;	// 32 bytes
			d-cache-size = <0x8000>;		// L1, 32K
			i-cache-size = <0x8000>;		// L1, 32K
			timebase-frequency = <0>;	// From uboot
			bus-frequency = <0>;
			clock-frequency = <0>;
		};
	};

	memory {
		device_type = "memory";
		reg = <0x00000000 0x20000000>;
	};

	soc@ff700000 {
		#address-cells = <1>;
		#size-cells = <1>;
		device_type = "soc";
		ranges = <0x0 0xff700000 0x00100000>;
		reg = <0xff700000 0x00100000>;
		clock-frequency = <0>;

		memory-controller@2000 {
			compatible = "fsl,8560-memory-controller";
			reg = <0x2000 0x1000>;
			interrupt-parent = <&mpic>;
			interrupts = <0x12 0x2>;
		};

		l2-cache-controller@20000 {
			compatible = "fsl,8560-l2-cache-controller";
			reg = <0x20000 0x1000>;
			cache-line-size = <0x20>;	// 32 bytes
			cache-size = <0x40000>;	// L2, 256K
			interrupt-parent = <&mpic>;
			interrupts = <0x10 0x2>;
		};

		i2c@3000 {
			#address-cells = <1>;
			#size-cells = <0>;
			cell-index = <0>;
			compatible = "fsl-i2c";
			reg = <0x3000 0x100>;
			interrupts = <0x2b 0x2>;
			interrupt-parent = <&mpic>;
			dfsrr;
		};

		i2c@3100 {
			#address-cells = <1>;
			#size-cells = <0>;
			cell-index = <1>;
			compatible = "fsl-i2c";
			reg = <0x3100 0x100>;
			interrupts = <0x2b 0x2>;
			interrupt-parent = <&mpic>;
			dfsrr;
		};

		mdio@24520 {
			#address-cells = <1>;
			#size-cells = <0>;
			compatible = "fsl,gianfar-mdio";
			reg = <0x24520 0x20>;
			phy0: ethernet-phy@19 {
				interrupt-parent = <&mpic>;
				interrupts = <0x6 0x1>;
				reg = <0x19>;
				device_type = "ethernet-phy";
			};
			phy1: ethernet-phy@1a {
				interrupt-parent = <&mpic>;
				interrupts = <0x7 0x1>;
				reg = <0x1a>;
				device_type = "ethernet-phy";
			};
			phy2: ethernet-phy@1b {
				interrupt-parent = <&mpic>;
				interrupts = <0x8 0x1>;
				reg = <0x1b>;
				device_type = "ethernet-phy";
			};
			phy3: ethernet-phy@1c {
				interrupt-parent = <&mpic>;
				interrupts = <0x8 0x1>;
				reg = <0x1c>;
				device_type = "ethernet-phy";
			};
		};

		enet0: ethernet@24000 {
			cell-index = <0>;
			device_type = "network";
			model = "TSEC";
			compatible = "gianfar";
			reg = <0x24000 0x1000>;
			local-mac-address = [ 00 00 00 00 00 00 ];
			interrupts = <0x1d 0x2 0x1e 0x2 0x22 0x2>;
			interrupt-parent = <&mpic>;
			phy-handle = <&phy0>;
		};

		enet1: ethernet@25000 {
			cell-index = <1>;
			device_type = "network";
			model = "TSEC";
			compatible = "gianfar";
			reg = <0x25000 0x1000>;
			local-mac-address = [ 00 00 00 00 00 00 ];
			interrupts = <0x23 0x2 0x24 0x2 0x28 0x2>;
			interrupt-parent = <&mpic>;
			phy-handle = <&phy1>;
		};

		mpic: pic@40000 {
			interrupt-controller;
			#address-cells = <0>;
			#size-cells = <0>;
			#interrupt-cells = <2>;
			reg = <0x40000 0x40000>;
			device_type = "open-pic";
		};

		cpm@919c0 {
			#address-cells = <1>;
			#size-cells = <1>;
			compatible = "fsl,mpc8560-cpm", "fsl,cpm2";
			reg = <0x919c0 0x30>;
			ranges;

			muram@80000 {
				#address-cells = <1>;
				#size-cells = <1>;
				ranges = <0x0 0x80000 0x10000>;

				data@0 {
					compatible = "fsl,cpm-muram-data";
					reg = <0x0 0x4000 0x9000 0x2000>;
				};
			};

			brg@919f0 {
				compatible = "fsl,mpc8560-brg",
				             "fsl,cpm2-brg",
				             "fsl,cpm-brg";
				reg = <0x919f0 0x10 0x915f0 0x10>;
				clock-frequency = <165000000>;
			};

			cpmpic: pic@90c00 {
				interrupt-controller;
				#address-cells = <0>;
				#interrupt-cells = <2>;
				interrupts = <0x2e 0x2>;
				interrupt-parent = <&mpic>;
				reg = <0x90c00 0x80>;
				compatible = "fsl,mpc8560-cpm-pic", "fsl,cpm2-pic";
			};

			enet2: ethernet@91320 {
				device_type = "network";
				compatible = "fsl,mpc8560-fcc-enet",
				             "fsl,cpm2-fcc-enet";
				reg = <0x91320 0x20 0x88500 0x100 0x913b0 0x1>;
				local-mac-address = [ 00 00 00 00 00 00 ];
				fsl,cpm-command = <0x16200300>;
				interrupts = <0x21 0x8>;
				interrupt-parent = <&cpmpic>;
				phy-handle = <&phy2>;
			};

			enet3: ethernet@91340 {
				device_type = "network";
				compatible = "fsl,mpc8560-fcc-enet",
				             "fsl,cpm2-fcc-enet";
				reg = <0x91340 0x20 0x88600 0x100 0x913d0 0x1>;
				local-mac-address = [ 00 00 00 00 00 00 ];
				fsl,cpm-command = <0x1a400300>;
				interrupts = <0x22 0x8>;
				interrupt-parent = <&cpmpic>;
				phy-handle = <&phy3>;
			};
		};

		global-utilities@e0000 {
			compatible = "fsl,mpc8560-guts";
			reg = <0xe0000 0x1000>;
			fsl,has-rstcr;
		};
	};

	pci0: pci@ff708000 {
		cell-index = <0>;
		#interrupt-cells = <1>;
		#size-cells = <2>;
		#address-cells = <3>;
		compatible = "fsl,mpc8540-pcix", "fsl,mpc8540-pci";
		device_type = "pci";
		reg = <0xff708000 0x1000>;
		clock-frequency = <66666666>;
		interrupt-map-mask = <0xf800 0x0 0x0 0x7>;
		interrupt-map = <

			/* IDSEL 0x02 */
			0x1000 0x0 0x0 0x1 &mpic 0x2 0x1
			0x1000 0x0 0x0 0x2 &mpic 0x3 0x1
			0x1000 0x0 0x0 0x3 &mpic 0x4 0x1
			0x1000 0x0 0x0 0x4 &mpic 0x5 0x1>;

		interrupt-parent = <&mpic>;
		interrupts = <0x18 0x2>;
		bus-range = <0x0 0x0>;
		ranges = <0x02000000 0x0 0x80000000 0x80000000 0x0 0x20000000
			  0x01000000 0x0 0x00000000 0xe2000000 0x0 0x00100000>;
	};

	localbus@ff705000 {
		compatible = "fsl,mpc8560-localbus";
		#address-cells = <2>;
		#size-cells = <1>;
		reg = <0xff705000 0x100>;	// BRx, ORx, etc.

		ranges = <
			0x0 0x0 0xff800000 0x0800000	// 8MB boot flash
			0x1 0x0 0xe4000000 0x4000000	// 64MB flash
			0x3 0x0 0x20000000 0x4000000	// 64MB SDRAM
			0x4 0x0 0x24000000 0x4000000	// 64MB SDRAM
			0x5 0x0 0xfc000000 0x0c00000	// EPLD
			0x6 0x0 0xe0000000 0x4000000	// 64MB flash
			0x7 0x0 0x80000000 0x0200000	// ATM1,2
		>;

		epld@5,0 {
			compatible = "wrs,epld-localbus";
			#address-cells = <2>;
			#size-cells = <1>;
			reg = <0x5 0x0 0xc00000>;
			ranges = <
				0x0 0x0 0x5 0x000000 0x1fff	// LED disp.
				0x1 0x0 0x5 0x100000 0x1fff	// switches
				0x2 0x0 0x5 0x200000 0x1fff	// ID reg.
				0x3 0x0 0x5 0x300000 0x1fff	// status reg.
				0x4 0x0 0x5 0x400000 0x1fff	// reset reg.
				0x5 0x0 0x5 0x500000 0x1fff	// Wind port
				0x7 0x0 0x5 0x700000 0x1fff	// UART #1
				0x8 0x0 0x5 0x800000 0x1fff	// UART #2
				0x9 0x0 0x5 0x900000 0x1fff	// RTC
				0xb 0x0 0x5 0xb00000 0x1fff	// EEPROM
			>;

			bidr@2,0 {
				compatible = "wrs,sbc8560-bidr";
				reg = <0x2 0x0 0x10>;
			};

			bcsr@3,0 {
				compatible = "wrs,sbc8560-bcsr";
				reg = <0x3 0x0 0x10>;
			};

			brstcr@4,0 {
				compatible = "wrs,sbc8560-brstcr";
				reg = <0x4 0x0 0x10>;
			};

			serial0: serial@7,0 {
				device_type = "serial";
				compatible = "ns16550";
				reg = <0x7 0x0 0x100>;
				clock-frequency = <1843200>;
				interrupts = <0x9 0x2>;
				interrupt-parent = <&mpic>;
			};

			serial1: serial@8,0 {
				device_type = "serial";
				compatible = "ns16550";
				reg = <0x8 0x0 0x100>;
				clock-frequency = <1843200>;
				interrupts = <0xa 0x2>;
				interrupt-parent = <&mpic>;
			};

			rtc@9,0 {
				compatible = "m48t59";
				reg = <0x9 0x0 0x1fff>;
			};
		};
	};
};

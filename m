Return-Path: <sha@pengutronix.de>
Received: from metis.extern.pengutronix.de (metis.extern.pengutronix.de
	[83.236.181.26]) (using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id DA435DE145
	for <linuxppc-dev@ozlabs.org>; Thu, 10 Apr 2008 20:45:22 +1000 (EST)
Date: Thu, 10 Apr 2008 12:46:55 +0200
From: Sascha Hauer <s.hauer@pengutronix.de>
To: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH] FCC: fix confused base / offset
Message-ID: <20080410104655.GH10465@pengutronix.de>
References: <20080409130610.GE10465@pengutronix.de>
	<20080409161110.GA5296@ld0162-tx32.am.freescale.net>
	<20080409165324.GF10465@pengutronix.de>
	<47FCFF64.9050109@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <47FCFF64.9050109@freescale.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Apr 09, 2008 at 12:39:48PM -0500, Scott Wood wrote:
> Sascha Hauer wrote:
>> Right, so it's probably not worth the effort. I stumbled on this while
>> porting my board to the new binding code. I was quite confused when
>> seeing this so I made this fix to understand what's going on here.
>>
>> BTW have you tested the FCC driver with the new binding code?
>
> Yes.
>
>> I do not
>> manage to get it working. Everything seems to be fine but
>> fs_enet_start_xmit does not send a packet and no interrupts are
>> arriving.
>
> What does your device tree look like?  

See bottom of this mail. The board really is a 8260 based board. Our
bootloader does not fill in the clock values, so they are hardcoded. I'm
not very sure about the muram entries because the dpram is organized
slightly different on the 8260. It has some dedicated FCC space and I
don't know how to properly encode this in the device tree.

> Are all the pins and clocks set up properly?

should be. I temporarily removed all gpio setup code from the board
file, so it should be same as the bootloader leaves it.

> Does the PHY negotiate OK?

Well I put some printks into the phy_read/write functions so I can say
that it at least properly talks to the phy.

> Is any error reported in the descriptor?

No


>
> arch/ppc is going away entirely in June or so.

I'm looking forward to it ;)

Sascha


/*
 * MPC8272 ADS Device Tree Source
 *
 * Copyright 2005 Freescale Semiconductor Inc.
 *
 * This program is free software; you can redistribute  it and/or modify it
 * under  the terms of  the GNU General  Public License as published by the
 * Free Software Foundation;  either version 2 of the  License, or (at your
 * option) any later version.
 */

/ {
	model = "rsdproto";
	compatible = "fsl,rsdproto";
	#address-cells = <1>;
	#size-cells = <1>;

	cpus {
		#address-cells = <1>;
		#size-cells = <0>;

		PowerPC,8260@0 {
			device_type = "cpu";
			reg = <0>;
			d-cache-line-size = <d#32>;
			i-cache-line-size = <d#32>;
			d-cache-size = <d#16384>;
			i-cache-size = <d#16384>;
			timebase-frequency = <d#125000000>;
			bus-frequency = <d#50000000>;
			clock-frequency = <d#150000000>;
		};
	};

	memory {
		device_type = "memory";
		reg = <0 8000000>;
	};

	soc@f0000000 {
		#address-cells = <1>;
		#size-cells = <1>;
		device_type = "soc";
		compatible = "fsl,mpc8272", "fsl,pq2-soc";
		ranges = <00000000 f0000000 00053000>;

		// Temporary -- will go away once kernel uses ranges for get_immrbase().
		reg = <f0000000 00053000>;

		cpm@119c0 {
			#address-cells = <1>;
			#size-cells = <1>;
			compatible = "fsl,mpc8272-cpm", "fsl,cpm2";
			reg = <119c0 30>;
			ranges;

			muram@0 {
				#address-cells = <1>;
				#size-cells = <1>;
				ranges = <0 0 10000>;

				data@0 {
					compatible = "fsl,cpm-muram-data";
					reg = <0 2000 8000 800>;
				};
			};

			brg@119f0 {
				compatible = "fsl,mpc8272-brg",
				             "fsl,cpm2-brg",
				             "fsl,cpm-brg";
				reg = <119f0 10 115f0 10>;
				clock-frequency = <d#50000000>;
			};

			serial@11a00 {
				device_type = "serial";
				compatible = "fsl,mpc8272-scc-uart",
				             "fsl,cpm2-scc-uart";
				reg = <11a00 20 8000 100>;
				interrupts = <28 8>;
				interrupt-parent = <&PIC>;
				fsl,cpm-brg = <1>;
				fsl,cpm-command = <00800000>;
			};

			serial@11a60 {
				device_type = "serial";
				compatible = "fsl,mpc8272-scc-uart",
				             "fsl,cpm2-scc-uart";
				reg = <11a60 20 8300 100>;
				interrupts = <2b 8>;
				interrupt-parent = <&PIC>;
				fsl,cpm-brg = <4>;
				fsl,cpm-command = <0ce00000>;
			};

			mdio@10d40 {
				device_type = "mdio";
				compatible = "fsl,mpc8272ads-mdio-bitbang",
				             "fsl,mpc8272-mdio-bitbang",
				             "fsl,cpm2-mdio-bitbang";
				reg = <10d40 14>;
				#address-cells = <1>;
				#size-cells = <0>;
				fsl,mdio-pin = <09>;
				fsl,mdc-pin = <0a>;

				PHY0: ethernet-phy@0 {
					interrupt-parent = <&PIC>;
					interrupts = <17 4>;
					reg = <0>;
					device_type = "ethernet-phy";
				};
			};

			ethernet@11300 {
				device_type = "network";
				compatible = "fsl,mpc8272-fcc-enet",
				             "fsl,cpm2-fcc-enet";
				reg = <11320 20 8500 100 113b0 30>;
				local-mac-address = [ 80 10 20 30 40 50 ];
				interrupts = <21 2>;
				interrupt-parent = <&PIC>;
				phy-handle = <&PHY0>;
				linux,network-index = <0>;
				fsl,cpm-command = <16200300>;
			};
		};

		PIC: interrupt-controller@10c00 {
			#interrupt-cells = <2>;
			interrupt-controller;
			reg = <10c00 80>;
			compatible = "fsl,mpc8272-pic", "fsl,cpm2-pic";
		};

	};
};


-- 
Pengutronix e.K. - Linux Solutions for Science and Industry
-----------------------------------------------------------
Kontakt-Informationen finden Sie im Header dieser Mail oder
auf der Webseite -> http://www.pengutronix.de/impressum/ <-

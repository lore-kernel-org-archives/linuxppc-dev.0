Return-Path: <dgibson@ozlabs.org>
Date: Fri, 21 Dec 2007 10:57:24 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Paul Gortmaker <paul.gortmaker@windriver.com>
Subject: Re: [PATCH 3/4] sbc8560: Add device tree source for Wind River
	SBC8560 board
Message-ID: <20071220235724.GA2665@localhost.localdomain>
References: <442fe9c9343f3c694932bcdc5f819c493c33c76b.1198107769.git.paul.gortmaker@windriver.com>
	<6be237dcf5b58d604afa6cea3079ec7de02a8de9.1198107769.git.paul.gortmaker@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <6be237dcf5b58d604afa6cea3079ec7de02a8de9.1198107769.git.paul.gortmaker@windriver.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Dec 20, 2007 at 09:54:31AM -0500, Paul Gortmaker wrote:
> This adds the device tree source for the Wind River SBC8560 board.  The
> biggest difference between this and the MPC8560ADS reference platform
> is the use of an external 16550 compatible UART instead of the CPM2.
> 
> Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
> ---
>  arch/powerpc/boot/dts/sbc8560.dts |  202 +++++++++++++++++++++++++++++++++++++
>  1 files changed, 202 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/powerpc/boot/dts/sbc8560.dts b/arch/powerpc/boot/dts/sbc8560.dts
> new file mode 100644
> index 0000000..85fc488
> --- /dev/null
> +++ b/arch/powerpc/boot/dts/sbc8560.dts
> @@ -0,0 +1,202 @@
> +/*
> + * SBC8560 Device Tree Source
> + *
> + * Copyright 2007 Wind River Systems Inc.
> + *
> + * Paul Gortmaker (see MAINTAINERS for contact information)
> + *
> + * This program is free software; you can redistribute  it and/or modify it
> + * under  the terms of  the GNU General  Public License as published by the
> + * Free Software Foundation;  either version 2 of the  License, or (at your
> + * option) any later version.
> + */
> +
> +
> +/ {
> +	model = "SBC8560";
> +	compatible = "SBC8560";
> +	#address-cells = <1>;
> +	#size-cells = <1>;
> +
> +	cpus {
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +
> +		PowerPC,8560@0 {
> +			device_type = "cpu";
> +			reg = <0>;
> +			d-cache-line-size = <20>;	// 32 bytes
> +			i-cache-line-size = <20>;	// 32 bytes
> +			d-cache-size = <8000>;		// L1, 32K
> +			i-cache-size = <8000>;		// L1, 32K
> +			timebase-frequency = <0>;	// From uboot
> +			bus-frequency = <0>;
> +			clock-frequency = <0>;
> +			32-bit;

Drop the "32-bit".  It was created in analogy with the "64-bit"
property, but nothing ever actually specified it.

> +		};
> +	};
> +
> +	memory {
> +		device_type = "memory";
> +		reg = <00000000 20000000>;
> +	};
> +
> +	soc8560@ff700000 {

I believe we're trying to call these "soc@address" now rather than
"socXXXX@address".

> +		#address-cells = <1>;
> +		#size-cells = <1>;
> +		#interrupt-cells = <2>;
> +		device_type = "soc";
> +		ranges = <0 ff700000 00100000>;
> +		reg = <ff700000 00100000>;
> +		bus-frequency = <0>;

This should be "clock-frequency" not "bus-frequency" although I don't
know if you can fix this within your code, or if it's a pre-existing
brokenness.

[snip]
> +		i2c@3000 {
> +			device_type = "i2c";

Drop this device_type.

> +			compatible = "fsl-i2c";
> +			reg = <3000 100>;
> +			interrupts = <2b 2>;
> +			interrupt-parent = <&mpic>;
> +			dfsrr;
> +		};
> +
> +		mdio@24520 {
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +			device_type = "mdio";
> +			compatible = "gianfar";

And this one, and change the compatible.  The gianfar driver has
recently been updated to change this.

[snip]
> +		ethernet@24000 {
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +			device_type = "network";
> +			model = "TSEC";
> +			compatible = "gianfar";

Likewise here.

> +			reg = <24000 1000>;
> +			local-mac-address = [ 00 00 00 00 00 00 ];
> +			interrupts = <1d 2 1e 2 22 2>;
> +			interrupt-parent = <&mpic>;
> +			phy-handle = <&phy0>;
> +		};

[snip]
> +		mpic: pic@40000 {
> +			clock-frequency = <0>;

The mpic has a clock-frequency??

> +			interrupt-controller;
> +			#address-cells = <0>;

Should have #size-cells = <0> too.

> +			#interrupt-cells = <2>;
> +			reg = <40000 40000>;
> +			built-in;
> +			compatible = "chrp,open-pic";
> +			device_type = "open-pic";
> +			big-endian;
> +		};
> +
> +		global-utilities@e0000 {
> +			compatible = "fsl,mpc8560-guts";
> +			reg = <e0000 1000>;
> +			fsl,has-rstcr;
> +		};
> +	};
> +
> +	duart@fc700000 {
> +		#address-cells = <1>;
> +		#size-cells = <1>;
> +		#interrupt-cells = <2>;

This is neither an interrupt-controller nor an interrupt-nexus, so it
shouldn't have #interrupt-cells.

> +		device_type = "soc";		// console checks for this!

!?  If console checks this (whatever that means), then console is
doing crap...

This is clearly *not* a SoC, and should have a proper compatible, not
this crap device type.  Come to that, is this really an independent
device or does it belong within the soc or on the localbus or
something?

> +		ranges = <0 fc700000 00200000>;
> +		reg = <fc700000 00200000>;

Ranges and reg should not overlap like this, except in very unusal
cases.  I'm really not sure what this duart node is support to
represent, in any case.

> +		serial@000000 {

No leading zeroes on the unit address part of the name

> +			device_type = "serial";
> +			compatible = "ns16550";
> +			reg = <000000 100>;
> +			clock-frequency = <1C2000>;
> +			interrupts = <9 2>;
> +			interrupt-parent = <&mpic>;
> +		};
> +
> +		serial@100000 {
> +			device_type = "serial";
> +			compatible = "ns16550";
> +			reg = <100000 100>;
> +			clock-frequency = <1C2000>;
> +			interrupts = <a 2>;
> +			interrupt-parent = <&mpic>;
> +		};
> +	};
> +
> +	rtc@fc900000 {

Again, it looks very much like the duart and rtc belong off some
external bus controller, not directly on the CPU bus (which is what
the top-level of the device tree represents).

> +		#address-cells = <1>;
> +		#size-cells = <1>;

This has no child nodes, so no need for #address-cells and #size-cells.

> +		device_type = "rtc";

Drop device_type, we're trying to avoid them.

> +		compatible = "m48t59";
> +		reg = <fc900000 2000>;
> +	};
> +};

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

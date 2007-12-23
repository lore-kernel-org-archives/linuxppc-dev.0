Return-Path: <dgibson@ozlabs.org>
Date: Mon, 24 Dec 2007 10:03:42 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Jochen Friedrich <jochen@scram.de>
Subject: Re: [PATCH/RFC] powerpc: DBox2 Board Support
Message-ID: <20071223230342.GA20636@localhost.localdomain>
References: <476D61DB.2090201@scram.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <476D61DB.2090201@scram.de>
Cc: Scott Wood <scottwood@freescale.com>, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sat, Dec 22, 2007 at 08:13:31PM +0100, Jochen Friedrich wrote:
> This patch adds device tree source, default config and setup code for
> DBox2 devices.

[snip]
> diff --git a/arch/powerpc/boot/dts/dbox2.dts b/arch/powerpc/boot/dts/dbox2.dts
> new file mode 100644
> index 0000000..8d91510
> --- /dev/null
> +++ b/arch/powerpc/boot/dts/dbox2.dts
> @@ -0,0 +1,263 @@
> +/*
> + * DBOX2 Device Tree Source
> + *
> + * Copyright 2007 Jochen Friedrich <jochen@scram.de>
> + *
> + * This program is free software; you can redistribute  it and/or modify it
> + * under  the terms of  the GNU General  Public License as published by the
> + * Free Software Foundation;  either version 2 of the  License, or (at your
> + * option) any later version.
> + */
> +
> +/ {
> +	model = "Dbox2";
> +	compatible = "betaresearch,dbox2";
> +	#address-cells = <1>;
> +	#size-cells = <1>;
> +
> +	cpus {
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +
> +		PowerPC,823@0 {
> +			device_type = "cpu";
> +			reg = <0>;
> +			d-cache-line-size = <d#16>;
> +			i-cache-line-size = <d#16>;
> +			d-cache-size = <d#1024>;
> +			i-cache-size = <d#2048>;
> +			timebase-frequency = <0>;
> +			bus-frequency = <0>;
> +			clock-frequency = <0>;
> +			interrupts = <f 2>;	// decrementer interrupt
> +			interrupt-parent = <&PIC>;
> +		};
> +	};
> +
> +	memory {
> +		device_type = "memory";
> +		reg = <0 2000000>;
> +	};
> +
> +	localbus@8000000 {
> +		compatible = "betaresearch,dbox2-localbus";

Is this bus interface really board specific?  I would have thought the
localbus bridge would have been part of the SoC in which case the
compatible string should mention the 823 rather than the dbox.

> +		#address-cells = <1>;

It's also usual for these localbus things, to have #address-cells of
2, with the chipselect explicitly present as the first cell.

> +		#size-cells = <1>;
> +		reg = <8000000 18000000>;
> +
> +		ranges = <0 8000000 18000000>;
> +
> +		enx@0 {
> +			compatible = "c-cube,enx";

What are these mysterious enx, gtx, etc. devices?  Some comments might
be nice.

[snip]
> +		flash@8000000 {
> +			// Flash also has info about model needed by setup
> +			compatible = "cfi-flash",
> +				     "betaresearch,dbox2-config";

compatible strings should be listed with most specific first, most
general last.  That would put "cfi-flash" after the dbox2 specific
string, I believe.

[snip]
> +	soc@ff000000 {
> +		compatible = "fsl,mpc823",
> +			     "fsl,pq1-soc";
> +		#address-cells = <1>;
> +		#size-cells = <1>;
> +		device_type = "soc";
> +		ranges = <0 ff000000 00004000>;
> +		reg = <ff000000 00004000>;
> +		bus-frequency = <0>;
> +
> +		PIC: pic@0 {
> +			interrupt-controller;
> +			#address-cells = <0>;
> +			#interrupt-cells = <2>;
> +			reg = <0 24>;
> +			compatible = "fsl,mpc823-pic",
> +				     "fsl,pq1-pic";
> +		};
> +
> +		wdt@0 {
> +			device_type = "watchdog";

Drop this device_type.

> +			compatible = "fsl,mpc823-wdt",
> +				     "fsl,pq1-wdt";
> +			reg = <0 10>;
> +		};
> +
> +		cpm@9c0 {
> +			#address-cells = <1>;
> +			#size-cells = <1>;
> +			ranges;
> +			reg = <9c0 40>;
> +			command-proc = <9c0>;
> +			interrupts = <0 2>;	// cpm error interrupt
> +			interrupt-parent = <&CPM_PIC>;
> +			compatible = "fsl,mpc823-cpm",
> +				     "fsl,cpm1";
> +
> +			muram@2000 {
> +				#address-cells = <1>;
> +				#size-cells = <1>;
> +				ranges = <0 2000 2000>;
> +
> +				data@0 {
> +					compatible = "fsl,cpm-muram-data";
> +					reg = <0 1c00>;
> +				};
> +			};
> +
> +			// Port D is LCD exclusive. Don't export as GPIO
> +			CPM1_PIO: pio@970 {
> +				compatible = "fsl,cpm1-pario";
> +				reg = <970 180>;
> +				num-ports = <3>;
> +				#gpio-cells = <2>;
> +			};
> +
> +			lcd@970 {
> +				reg = <970 10>;
> +				compatible = "samsung,ks0713";

Is this representing an LCD controller, or the display itself.  Either
way I'm surprised there's something here in the SoC that has a
compatible string that's not "fsl,something"

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

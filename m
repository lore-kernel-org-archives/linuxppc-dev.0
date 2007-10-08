Return-Path: <dgibson@ozlabs.org>
Date: Mon, 8 Oct 2007 11:50:22 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Marian Balakowicz <m8@semihalf.com>
Subject: Re: [PATCH 04/15] [POWERPC] CM5200 DTS
Message-ID: <20071008015021.GA12499@localhost.localdomain>
References: <47075FA7.3030108@semihalf.com> <4708C112.9020506@semihalf.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <4708C112.9020506@semihalf.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sun, Oct 07, 2007 at 01:20:50PM +0200, Marian Balakowicz wrote:
> 
> Add device tree source file for CM5200 board.
> 
> Signed-off-by Marian Balakowicz <m8@semihalf.com>
> Signed-off-by: Jan Wrobel <wrr@semihalf.com>
> ---
> 
>  cm5200.dts |  284 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 284 insertions(+)
> 
> diff --git a/arch/powerpc/boot/dts/cm5200.dts b/arch/powerpc/boot/dts/cm5200.dts
> new file mode 100644
> index 0000000..96d2ee4
> --- /dev/null
> +++ b/arch/powerpc/boot/dts/cm5200.dts
> @@ -0,0 +1,284 @@
> +/*
> + * CM5200 board Device Tree Source
> + *
> + * Copyright (C) 2007 Semihalf
> + * Modified for CM5200 by Jan Wrobel <wrr@semihalf.com>
> + *
> + * Copyright 2006-2007 Secret Lab Technologies Ltd.
> + * Grant Likely <grant.likely@secretlab.ca>
> + *
> + * This program is free software; you can redistribute  it and/or modify it
> + * under  the terms of  the GNU General  Public License as published by the
> + * Free Software Foundation;  either version 2 of the  License, or (at your
> + * option) any later version.
> + */
> +
> +/*
> + * WARNING: Do not depend on this tree layout remaining static just yet.
> + * The MPC5200 device tree conventions are still in flux
> + * Keep an eye on the linuxppc-dev mailing list for more details
> + */
> +
> +/ {
> +	model = "cm5200";
> +	compatible = "fsl,cm5200\0generic-mpc5200";

dtc now supports the syntax "fsl,cm5200", "generic-mpc5200" so you
don't need the ugly inline \0.

> +	#address-cells = <1>;
> +	#size-cells = <1>;
> +
> +	cpus {
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +
> +		PowerPC,5200@0 {
> +			device_type = "cpu";
> +			reg = <0>;
> +			d-cache-line-size = <20>;
> +			i-cache-line-size = <20>;
> +			d-cache-size = <4000>;		// L1, 16K
> +			i-cache-size = <4000>;		// L1, 16K
> +			timebase-frequency = <0>;	// from bootloader
> +			bus-frequency = <0>;		// from bootloader
> +			clock-frequency = <0>;		// from bootloader
> +			32-bit;
> +		};
> +	};
> +
> +	memory {
> +		device_type = "memory";
> +		reg = <00000000 04000000>;	// 64MB
> +	};
> +
> +	soc5200@f0000000 {
> +		model = "fsl,mpc5200b";
> +		compatible = "mpc5200";
> +		revision = "";			// from bootloader
> +		#interrupt-cells = <3>;
> +		device_type = "soc";
> +		ranges = <0 f0000000 f0010000>;
> +		reg = <f0000000 00010000>;
> +		bus-frequency = <0>;		// from bootloader
> +		system-frequency = <0>;		// from bootloader

[snip]
> +		flash@c000000 {
> +			device_type = "rom";
> +			compatible = "direct-mapped";
> +			reg = <0c000000 02000000>;
> +			probe-type = "CFI";
> +			bank-width = <2>;
> +			partitions = <00000000 00060000
> +				00060000 00020000
> +				00080000 00020000
> +				000a0000 00020000
> +				000c0000 00200000
> +				002c0000 01b40000
> +				01e00000 00200000>;
> +			partition-names = "uboot\0env\0redund_env\0dtb\0kernel\0rootfs\0config";
> +		};

First, this is the old flash binding, please use the new one.

Second, is the flash really part of the SoC?

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

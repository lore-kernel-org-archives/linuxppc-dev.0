Return-Path: <dgibson@ozlabs.org>
Date: Wed, 2 Jan 2008 22:20:30 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Jochen Friedrich <jochen@scram.de>
Subject: Re: [PATCHv3] powerpc: DBox2 Board Support
Message-ID: <20080102112030.GB23168@localhost.localdomain>
References: <477522DB.4000100@scram.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <477522DB.4000100@scram.de>
Cc: Scott Wood <scottwood@freescale.com>, linuxppc-dev@ozlabs.org,
	linux-kernel@vger.kernel.org,
	"linuxppc-embedded@ozlabs.org" <linuxppc-embedded@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, Dec 28, 2007 at 05:22:51PM +0100, Jochen Friedrich wrote:
> This patch adds device tree source, default config and setup code for
> DBox2 devices.

[snip]
> +++ b/arch/powerpc/boot/dts/dbox2.dts
> @@ -0,0 +1,251 @@
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
> +	model = "unknown,dbox2"; // boot wrapper fills in correct manufacturer

Probably better just to leave model out of the dts and let the
bootwrapper add it.

[snip]
> +		cam@3,0 {
> +			compatible = "betaresearch,dbox2-cam";
> +			reg = <3 0 20000 6 0 20000>;
> +			interrupts = <6 2>;
> +			interrupt-parent = <&PIC>;
> +			gpios = <1 1c 1 1d 1 1e 1 1f>;
> +			gpio-parent = <&CPM1_PIO>;
> +		};
> +
> +		mpegdec@4,0 {

The established generic names don't generally use abbreviations.  So I
would suggest "mpeg-decoder" here instead.

> +			compatible = "c-cube,avia";
> +			reg = <4 0 200>;
> +			interrupts = <8 2>;
> +			interrupt-parent = <&PIC>;
> +		};
> +
> +		mpegdemux@5,0 {

Likewise "mpeg-demultiplexer"

> +			compatible = "c-cube,enx";
> +			reg = <5 0 3400 7 0 200000>;
> +			interrupts = <2 2>;
> +			interrupt-parent = <&PIC>;
> +		};
> +
> +		flash@0,0 {
> +			compatible = "cfi-flash";
> +			reg = <0 0 800000>;
> +			bank-width = <4>;
> +			device-width = <1>;
> +			#address-cells = <1>;
> +			#size-cells = <1>;
> +			partition@0 {
> +				label = "BR bootloader";
> +				reg = <0 20000>;
> +				read-only;
> +			};
> +			partition@20000 {
> +				label = "FLFS (U-Boot)";
> +				reg = <20000 20000>;
> +			};
> +			partition@40000 {
> +				label = "rootfs";
> +				reg = <40000 7c0000>;
> +			};
> +			ovpartition@20000 {

Uh.. I really don't know what the MTD driver will handle these
overlapping partitions.  I suspect it will not be pretty...

> +				label = "Flash without bootloader";
> +				reg = <20000 7e0000>;
> +			};
> +			ovpartition@0 {
> +				label = "Complete Flash";
> +				reg = <0 800000>;
> +				read-only;
> +			};
> +		};
> +	};

[snip]
> +	chosen {
> +		linux,stdout-path = "/soc/cpm/serial@a80";

Probably worth using a path reference here, now they're implemented.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

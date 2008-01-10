Return-Path: <dgibson@ozlabs.org>
Date: Thu, 10 Jan 2008 13:56:22 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Paul Gortmaker <paul.gortmaker@windriver.com>
Subject: Re: [PATCH 4/7] sbc8560: Add device tree source for Wind River
	SBC8560 board
Message-ID: <20080110025622.GE17816@localhost.localdomain>
References: <ef7d84e06c45289f51f35845ccaa63bbf31827db.1199715362.git.paul.gortmaker@windriver.com>
	<d10d083bafb978936975111f09669120201072ec.1199715362.git.paul.gortmaker@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <d10d083bafb978936975111f09669120201072ec.1199715362.git.paul.gortmaker@windriver.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, Jan 07, 2008 at 09:25:29AM -0500, Paul Gortmaker wrote:
> This adds the device tree source for the Wind River SBC8560 board.  The
> biggest difference between this and the MPC8560ADS reference platform
> dts is the use of an external 16550 compatible UART instead of the CPM2.
> 
> Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
> ---
>  arch/powerpc/boot/dts/sbc8560.dts |  285 +++++++++++++++++++++++++++++++++++++

[snip]
> +	epld@fc000000 {
> +		#address-cells = <1>;
> +		#size-cells = <1>;
> +		compatible = "localbus";

This compatible doesn't look specific enough.  It should at least have
a vendor prefix.

> +		ranges = <0 fc000000 00c00000>;

Typically, we've been doing these external bust controller type
gadgets with address-cells = <2>, the first cell explicitly encoding
the chipselect.  This gets us closer to the ideal of the device tree
encoding only hardware information, not how the bridge controller is
configured (although "ranges" will still have to contain configuration
dependent information).


> +
> +		serial0: serial@700000 {
> +			device_type = "serial";
> +			compatible = "ns16550";
> +			reg = <700000 100>;
> +			clock-frequency = <1C2000>;
> +			interrupts = <9 2>;
> +			interrupt-parent = <&mpic>;
> +		};
> +
> +		serial1: serial@800000 {
> +			device_type = "serial";
> +			compatible = "ns16550";
> +			reg = <800000 100>;
> +			clock-frequency = <1C2000>;
> +			interrupts = <a 2>;
> +			interrupt-parent = <&mpic>;
> +		};
> +
> +		rtc@900000 {
> +			compatible = "m48t59";
> +			reg = <900000 2000>;
> +		};
> +	};
> +};

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

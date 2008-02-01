Return-Path: <dgibson@ozlabs.org>
Date: Fri, 1 Feb 2008 18:54:08 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Paul Gortmaker <paul.gortmaker@windriver.com>
Subject: Re: [PATCH 2/10] sbc8560: Add v1 device tree source for Wind River
	SBC8560 board
Message-ID: <20080201075408.GC18684@localhost.localdomain>
References: <e3ccba7097a77e66f07663fe9d1f174c06183528.1201217172.git.paul.gortmaker@windriver.com>
	<7107e511a0f989ad55335855fa0f241f09eff52f.1201217172.git.paul.gortmaker@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <7107e511a0f989ad55335855fa0f241f09eff52f.1201217172.git.paul.gortmaker@windriver.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Jan 24, 2008 at 06:41:24PM -0500, Paul Gortmaker wrote:
> This adds a v1 device tree source for the Wind River SBC8560 board.  The
> biggest difference between this and the MPC8560ADS reference platform
> dts is the use of an external 16550 compatible UART instead of the CPM2.
> 
> Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>

[snip]
> +/dts-v1/;
> +
> +/ {
> +	model = "SBC8560";
> +	compatible = "SBC8560";

This is not the conventional format for board-level compatible
entries, which should generally be "vendor,model" and all in lower
case.

[snip]
> +		enet0: ethernet@24000 {
> +			cell-index = <0>;
> +			device_type = "network";
> +			model = "TSEC";
> +			compatible = "gianfar";

This looks like the old dodgy gianfar binding, and needs updating
(mdio node will probably also need changes).

[snip]
> +	localbus@ff705000 {
> +		compatible = "fsl,mpc8560-localbus";
> +		#address-cells = <2>;
> +		#size-cells = <1>;
> +		reg = <0xff705000 0x100>;	// BRx, ORx, etc.
> +
> +		ranges = <
> +			0x0 0x0 0xff800000 0x0800000	// 8MB boot flash
> +			0x1 0x0 0xe4000000 0x4000000	// 64MB flash
> +			0x3 0x0 0x20000000 0x4000000	// 64MB SDRAM
> +			0x4 0x0 0x24000000 0x4000000	// 64MB SDRAM
> +			0x5 0x0 0xfc000000 0x0c00000	// EPLD
> +			0x6 0x0 0xe0000000 0x4000000	// 64MB flash
> +			0x7 0x0 0x80000000 0x0200000	// ATM1,2
> +		>;
> +
> +		epld@5,0 {

I'm not entirely convinced on this two-level representation.  I think
the FSL people need to get together and define a binding (or set of
bindings) for their various chipselect style external bus bridges.

> +			compatible = "wrs,epld-localbus";
> +			#address-cells = <2>;
> +			#size-cells = <1>;
> +			reg = <0x5 0x0 0xc00000>;
> +			ranges = <
> +				0x0 0x0 0x5 0x000000 0x1fff	// LED disp.
> +				0x1 0x0 0x5 0x100000 0x1fff	// switches
> +				0x2 0x0 0x5 0x200000 0x1fff	// ID reg.
> +				0x3 0x0 0x5 0x300000 0x1fff	// status reg.
> +				0x4 0x0 0x5 0x400000 0x1fff	// reset reg.
> +				0x5 0x0 0x5 0x500000 0x1fff	// Wind port
> +				0x7 0x0 0x5 0x700000 0x1fff	// UART #1
> +				0x8 0x0 0x5 0x800000 0x1fff	// UART #2
> +				0x9 0x0 0x5 0x900000 0x1fff	// RTC
> +				0xb 0x0 0x5 0xb00000 0x1fff	// EEPROM
> +			>;

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

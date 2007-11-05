Return-Path: <dgibson@ozlabs.org>
Date: Mon, 5 Nov 2007 11:47:39 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Marian Balakowicz <m8@semihalf.com>
Subject: Re: [PATCH v2 06/12] [POWERPC] TQM5200 DTS
Message-ID: <20071105004739.GG19867@localhost.localdomain>
References: <20071103235210.31906.83423.stgit@hekate.izotz.org>
	<20071103235247.31906.76777.stgit@hekate.izotz.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20071103235247.31906.76777.stgit@hekate.izotz.org>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sun, Nov 04, 2007 at 12:52:47AM +0100, Marian Balakowicz wrote:
> Add device tree source file for TQM5200 board.
> 
> Signed-off-by: Marian Balakowicz <m8@semihalf.com>

[snip]
> +	soc5200@f0000000 {

soc@address is the new convention, I believe, but I guess you need
compatibility with older bootstraps.

> +		model = "fsl,mpc5200";
> +		compatible = "mpc5200";

This compatible looks bogus; it should have the "fsl," at least.

[snip]
> +		mpc5200_pic: pic@500 {
> +			// 5200 interrupts are encoded into two levels;
> +			interrupt-controller;
> +			#interrupt-cells = <3>;
> +			device_type = "interrupt-controller";

No device_type here.

> +			compatible = "mpc5200-pic";
> +			reg = <500 80>;
> +		};
> +
> +		gpt@600 {	// General Purpose Timer
> +			compatible = "fsl,mpc5200-gpt";
> +			cell-index = <0>;

Ok, is this actually a suitable usage for cell-index?  It should only
be used when the cell-index number is used to program some soc-global
register.  It should not be used just for ordering or logical-indexing
purposes.

[snip]
> +		serial@2000 {		// PSC1
> +			device_type = "serial";
> +			compatible = "mpc5200-psc-uart";
> +			port-number = <0>;  // Logical port assignment
> +			cell-index = <0>;

Ditto w.r.t. cell-index.

port-number also looks bogus - the device tree should not generally
contain logical numbering information in this manner.  How and what
uses the port-number property?

> +		sram@8000 {
> +			compatible = "mpc5200-sram","sram";

Uh.. is there an "sram" binding?  "sram" doesn't look specific enough
for a compatible property.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

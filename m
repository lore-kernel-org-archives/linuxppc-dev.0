Return-Path: <dgibson@ozlabs.org>
Date: Wed, 24 Oct 2007 11:51:15 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Marian Balakowicz <m8@semihalf.com>
Subject: Re: [PATCH 05/11] [POWERPC] TQM5200 DTS
Message-ID: <20071024015115.GK10595@localhost.localdomain>
References: <20071023231302.29359.27417.stgit@hekate.izotz.org>
	<20071023231333.29359.35252.stgit@hekate.izotz.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20071023231333.29359.35252.stgit@hekate.izotz.org>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Oct 24, 2007 at 01:13:33AM +0200, Marian Balakowicz wrote:
> Add device tree source file for TQM5200 board.
> 
> Signed-off-by: Marian Balakowicz <m8@semihalf.com>
> ---
> 
>  arch/powerpc/boot/dts/tqm5200.dts |  236 +++++++++++++++++++++++++++++++++++++
>  1 files changed, 236 insertions(+), 0 deletions(-)
>  create mode 100644 arch/powerpc/boot/dts/tqm5200.dts
> 
> 
> diff --git a/arch/powerpc/boot/dts/tqm5200.dts b/arch/powerpc/boot/dts/tqm5200.dts
> new file mode 100644
> index 0000000..01c7778
> --- /dev/null
> +++ b/arch/powerpc/boot/dts/tqm5200.dts
> @@ -0,0 +1,236 @@
> +/*
> + * TQM5200 board Device Tree Source
[snip]
> +	soc5200@f0000000 {

I thought we were moving towards calling these just /soc@address?

> +		model = "fsl,mpc5200";
> +		compatible = "mpc5200";

That should have a vendor prefix.

[snip]
> +		serial@2000 {		// PSC1
> +			device_type = "serial";
> +			compatible = "mpc5200-psc-uart";
> +			port-number = <0>;  // Logical port assignment

How are these port-number things used?  The device tree shouldn't
generally contain information that isn't inherent to the hardware.
There can be reasons for hacks like this, but we should avoid them if
possible.

> +			cell-index = <0>;

cell-index should only be used if the index number is used when
manipulating the hardware (e.g. if there's a global control register
which takes this number).

[snip]
> +		ata@3a00 {
> +			device_type = "ata";

No such thing as device_type = "ata", drop it.  In general, never
include a device_type unless a binding explicitly says to do so.

[snip]
> +	lpb@fc000000 {
> +		model = "fsl,lpb";
> +		compatible = "lpb";

Not nearly specific enough.  Must include a vendor prefix at least,
and should have a lot more revision information.  You should always be
able to pick the right driver with compatible alone, "model" should
generally be for human consumption, the driver shouldn't need it.

> +		device_type = "lpb";

Drop this.  Again, presence of a device_type property is the
exception, not the rule.

> +		ranges = <0 fc000000 02000000>;

You need #address-cells and #size-cells properties, too.

[snip]

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

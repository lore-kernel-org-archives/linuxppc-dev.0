Return-Path: <dgibson@ozlabs.org>
Date: Fri, 11 May 2007 09:37:47 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: "Mark A. Greer" <mgreer@mvista.com>
Subject: Re: [PATCH 11/13] powerpc: Add DTS file for the Motorola PrPMC2800
	platform
Message-ID: <20070510233747.GC27188@localhost.localdomain>
References: <20070510200237.GA19756@mag.az.mvista.com>
	<20070510200859.GL19756@mag.az.mvista.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070510200859.GL19756@mag.az.mvista.com>
Cc: linuxppc-dev <Linuxppc-dev@ozlabs.org>, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, May 10, 2007 at 01:08:59PM -0700, Mark A. Greer wrote:
> 
> Add the device tree source file for the prpmc2800 line of processor PMCs.
> Several of the property values are updated by the bootwrapper but sane
> defaults have been chosen in case the bootwrapper can't determine the
> exact processor board variant.  The defaults should allow the kernel
> to boot despite having non-optimal device tree property values.
> 
> Signed-off-by: Mark A. Greer <mgreer@mvista.com>
> ---
>  arch/powerpc/boot/dts/prpmc2800.dts |  316 ++++++++++++++++++++++++++
>  1 file changed, 316 insertions(+)
> 
> Index: powerpc/arch/powerpc/boot/dts/prpmc2800.dts
> ===================================================================
> --- /dev/null
> +++ powerpc/arch/powerpc/boot/dts/prpmc2800.dts
> @@ -0,0 +1,316 @@
[snip]
> +		PowerPC,7447 {
> +			device_type = "cpu";
> +			reg = <0>;
> +			clock-frequency = <2bb0b140>;	/* Default (733 MHz) */
> +			bus-frequency = <7f28155>;	/* 133.333333 MHz */
> +			timebase-frequency = <1fca055>;	/* 33.333333 MHz */
> +			/* Following required by dtc but not used */
> +			i-cache-line-size = <0>;
> +			d-cache-line-size = <0>;
> +			i-cache-size = <0>;
> +			d-cache-size = <0>;

As Kumar also says, these should not be zero just to shut up dtc's
warning.

[snip]
> +		flash@a0000000 {
> +			device_type = "rom";
> +			compatible = "direct-mapped";
> +			reg = <a0000000 4000000>; /* Default (64MB) */
> +			probe-type = "CFI";
> +			bank-width = <4>;
> +			partitions = <00000000 00100000 /* RO */
> +				      00100000 00040001 /* RW */
> +				      00140000 00400000 /* RO */
> +				      00540000 039c0000 /* RO */
> +				      03f00000 00100000>; /* RO */
> +			partition-names = "FW Image A\0FW Config Data\0Kernel Image\0Filesystem\0FW Image B";

dtc now supports the syntax:
	partition-names = "FW Image A", "FW Config Data", ...
for multi-string properties to make this sort of thing less ugly.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

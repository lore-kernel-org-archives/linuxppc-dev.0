Return-Path: <dgibson@ozlabs.org>
Date: Sat, 15 Dec 2007 12:55:43 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH v2 2/4] mpc8313erdb: Add NAND to device tree, and call
	of_platform_bus_probe().
Message-ID: <20071215015543.GD6935@localhost.localdomain>
References: <20071214185826.GB10584@loki.buserror.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20071214185826.GB10584@loki.buserror.net>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, Dec 14, 2007 at 12:58:26PM -0600, Scott Wood wrote:
> Signed-off-by: Scott Wood <scottwood@freescale.com>
> ---
> As requested, compatible is used rather than name for probing.
> The simple-bus name comes from ePAPR drafts.
> 
>  arch/powerpc/boot/dts/mpc8313erdb.dts     |   38 +++++++++++++++++++++++++++++
>  arch/powerpc/platforms/83xx/mpc8313_rdb.c |   16 ++++++++++++
>  2 files changed, 54 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/powerpc/boot/dts/mpc8313erdb.dts b/arch/powerpc/boot/dts/mpc8313erdb.dts
> index c5b6665..66b53ec 100644
> --- a/arch/powerpc/boot/dts/mpc8313erdb.dts
> +++ b/arch/powerpc/boot/dts/mpc8313erdb.dts
> @@ -45,10 +45,48 @@
>  		reg = <00000000 08000000>;	// 128MB at 0
>  	};
>  
> +	localbus {

Should be "localbus@e0005000".

> +		#address-cells = <2>;
> +		#size-cells = <1>;
> +		compatible = "fsl,mpc8313-elbc", "fsl,elbc", "simple-bus";
> +		reg = <e0005000 1000>;
> +		interrupts = <d#77 8>;
> +		interrupt-parent = <&ipic>;
> +
> +		// CS0 and CS1 are swapped when
> +		// booting from nand, but the
> +		// addresses are the same.

Should the bootwrapper have some kind of fixup to poke in the correct
chipselect values based on the state?

Or should we have a function to fill in the elbc's ranges property
based on the bridge control registers, as we do for the ebc on 4xx.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

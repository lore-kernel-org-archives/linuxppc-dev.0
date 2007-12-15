Return-Path: <dgibson@ozlabs.org>
Date: Sat, 15 Dec 2007 12:52:07 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH 2/4] mpc8313erdb: Add NAND to device tree, and call
	of_platform_bus_probe().
Message-ID: <20071215015207.GC6935@localhost.localdomain>
References: <20071213171632.GA4491@loki.buserror.net>
	<20071213171714.GA4510@loki.buserror.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20071213171714.GA4510@loki.buserror.net>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Dec 13, 2007 at 11:17:14AM -0600, Scott Wood wrote:
> Signed-off-by: Scott Wood <scottwood@freescale.com>
> ---
>  arch/powerpc/boot/dts/mpc8313erdb.dts     |   37 +++++++++++++++++++++++++++++
>  arch/powerpc/platforms/83xx/mpc8313_rdb.c |   17 +++++++++++++
>  2 files changed, 54 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/powerpc/boot/dts/mpc8313erdb.dts b/arch/powerpc/boot/dts/mpc8313erdb.dts
> index 9e7eba9..86e851a 100644
> --- a/arch/powerpc/boot/dts/mpc8313erdb.dts
> +++ b/arch/powerpc/boot/dts/mpc8313erdb.dts
> @@ -37,6 +37,43 @@
>  		reg = <00000000 08000000>;	// 128MB at 0
>  	};
>  
> +	localbus {

Should be "localbus@e0005000".

> +		#address-cells = <2>;
> +		#size-cells = <1>;
> +		compatible = "fsl,mpc8313-elbc", "fsl,elbc";
> +		reg = <e0005000 1000>;
> +		interrupts = <d#77 8>;

The IPIC has interrupt numbers up to 77?  Wow..

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

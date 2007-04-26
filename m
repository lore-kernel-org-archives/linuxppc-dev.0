Return-Path: <dgibson@ozlabs.org>
Date: Thu, 26 Apr 2007 10:08:52 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Dave Jiang <djiang@mvista.com>
Subject: Re: [PATCH] powerpc: Add EDAC platform devices for 85xx
Message-ID: <20070426000852.GA2193@localhost.localdomain>
References: <20070425213700.GA8814@blade.az.mvista.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070425213700.GA8814@blade.az.mvista.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Apr 25, 2007 at 02:37:00PM -0700, Dave Jiang wrote:
> Add memory controller and l2-cache controller entries in the dts files for 85xx
> platforms. Also adding code to create the platform devices used by EDAC drivers
> to claim the resources in order to access the error registers and interrupts. 
> 
> Signed-off-by: Dave Jiang <djiang@mvista.com>
> 
> ---
> 
>  arch/powerpc/boot/dts/mpc8540ads.dts |   21 ++++++
>  arch/powerpc/boot/dts/mpc8548cds.dts |   21 ++++++
>  arch/powerpc/boot/dts/mpc8560ads.dts |   23 +++++++-
>  arch/powerpc/sysdev/fsl_soc.c        |  115 ++++++++++++++++++++++++++++++++++
>  4 files changed, 179 insertions(+), 1 deletions(-)
> 
> diff --git a/arch/powerpc/boot/dts/mpc8540ads.dts b/arch/powerpc/boot/dts/mpc8540ads.dts
> index f261d64..8bb7593 100644
> --- a/arch/powerpc/boot/dts/mpc8540ads.dts
> +++ b/arch/powerpc/boot/dts/mpc8540ads.dts
> @@ -48,6 +48,27 @@
>  		reg = <e0000000 00100000>;	// CCSRBAR 1M
>  		bus-frequency = <0>;
>  
> +		mem-ctrl@2000 {
> +			device_type = "mem-ctrl";
> +			compatible = "85xx";
> +			reg = <2000 1000>;
> +			linux,phandle = <2000>;
> +			interrupt-parent = <40000>;

Please don't use explicit phandles.  Use dtc's label feature where you
need to put phandles into properties.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

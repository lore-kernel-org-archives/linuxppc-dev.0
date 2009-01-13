Return-Path: <dgibson@ozlabs.org>
Date: Tue, 13 Jan 2009 13:23:16 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Yuri Tikhonov <yur@emcraft.com>
Subject: Re: [PATCH 11/11][v2] ppc440spe-adma: ADMA driver for PPC440SP(e)
	systems
Message-ID: <20090113022316.GA3628@yookeroo.seuss>
References: <200901130343.56020.yur@emcraft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <200901130343.56020.yur@emcraft.com>
Cc: wd@denx.de, dzu@denx.de, linux-raid@vger.kernel.org,
	linuxppc-dev@ozlabs.org, yanok@emcraft.com, dan.j.williams@intel.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Jan 13, 2009 at 03:43:55AM +0300, Yuri Tikhonov wrote:
> Adds the platform device definitions and the architecture specific support
> routines for the ppc440spe adma driver.
> 
> Any board equipped with PPC440SP(e) controller may utilize this driver.
> 
> diff --git a/arch/powerpc/boot/dts/katmai.dts b/arch/powerpc/boot/dts/katmai.dts
> index 077819b..f2f77c8 100644
> --- a/arch/powerpc/boot/dts/katmai.dts
> +++ b/arch/powerpc/boot/dts/katmai.dts
> @@ -16,7 +16,7 @@
>  
>  / {
>  	#address-cells = <2>;
> -	#size-cells = <1>;
> +	#size-cells = <2>;

You've changed the root level size-cells, but haven't updated the
sub-nodes (such as /memory) accordingly.

>  	model = "amcc,katmai";
>  	compatible = "amcc,katmai";
>  	dcr-parent = <&{/cpus/cpu@0}>;
> @@ -392,6 +392,30 @@
>  				0x0 0x0 0x0 0x3 &UIC3 0xa 0x4 /* swizzled int C */
>  				0x0 0x0 0x0 0x4 &UIC3 0xb 0x4 /* swizzled int D */>;
>  		};
> +		DMA0: dma0 {

No 'compatible' property, which seems dubious.

> +			interrupt-parent = <&DMA0>;
> +			interrupts = <0 1>;
> +			#interrupt-cells = <1>;
> +			#address-cells = <0>;
> +			#size-cells = <0>;
> +			interrupt-map = <
> +				0 &UIC0 0x14 4
> +				1 &UIC1 0x16 4>;
> +		};
> +		DMA1: dma1 {
> +			interrupt-parent = <&DMA1>;
> +			interrupts = <0 1>;
> +			#interrupt-cells = <1>;
> +			#address-cells = <0>;
> +			#size-cells = <0>;
> +			interrupt-map = <
> +				0 &UIC0 0x16 4
> +				1 &UIC1 0x16 4>;

Are these interrupt-maps correct?  The second interrupt from both dma
controllers is routed to the same line on UIC1?

> +		};
> +		xor {
> +			interrupt-parent = <&UIC1>;
> +			interrupts = <0x1f 4>;

What the hell is this thing?  No compatible property, nor even a
meaningful name.

> +		};
>  	};
-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

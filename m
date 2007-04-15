Return-Path: <dale@farnsworth.org>
Date: 15 Apr 2007 03:48:19 -0700
Message-ID: <20070415104819.6709.qmail@farnsworth.org>
From: "Dale Farnsworth" <dale@farnsworth.org>
To: grant.likely@secretlab.ca, Linuxppc-embedded@ozlabs.org
Subject: Re: [PATCH 1/5] [PPC] Rework Kconfig dependancies for Xilinx Virtex
	ppc405 platform
In-Reply-To: <11766220692537-git-send-email-grant.likely@secretlab.ca>
References: <1176622062492-git-send-email-grant.likely@secretlab.ca>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

In article <11766220692537-git-send-email-grant.likely@secretlab.ca> you write:
> Reverse dependency order for Xilinx Virtex parts.  For these parts, It
> makes more sense for boards/chips to specify which features they
> provide instead of the features listing the parts they are implemented
> in.  I think it also makes adding new board ports simpler.
> 
> Signed-off-by: Grant Likely <grant.likely@secretlab.ca>
> ---
>  arch/ppc/platforms/4xx/Kconfig |   13 +++++++------
>  1 files changed, 7 insertions(+), 6 deletions(-)
> 
> diff --git a/arch/ppc/platforms/4xx/Kconfig b/arch/ppc/platforms/4xx/Kconfig
> index 705ae56..f74e25b 100644
> --- a/arch/ppc/platforms/4xx/Kconfig
> +++ b/arch/ppc/platforms/4xx/Kconfig
> @@ -54,11 +54,13 @@ config WALNUT
>  
>  config XILINX_ML300
>  	bool "Xilinx-ML300"
> +	select XILINX_VIRTEX_II_PRO
>  	help
>  	  This option enables support for the Xilinx ML300 evaluation board.
>  
>  config XILINX_ML403
>  	bool "Xilinx-ML403"
> +	select XILINX_VIRTEX_4_FX
>  	help
>  	  This option enables support for the Xilinx ML403 evaluation board.
>  endchoice
> @@ -215,18 +217,17 @@ config 405GPR
>  
>  config XILINX_VIRTEX_II_PRO
>  	bool
> -	depends on XILINX_ML300
> -	default y
> +	select XILINX_VIRTEX
> +	default n

Since these variables are not user selectable, it's better to
remove the "default n", so they don't show up when not selected.

>  config XILINX_VIRTEX_4_FX
>  	bool
> -	depends on XILINX_ML403
> -	default y
> +	select XILINX_VIRTEX
> +	default n
>  
>  config XILINX_VIRTEX
>  	bool
> -	depends on XILINX_VIRTEX_II_PRO || XILINX_VIRTEX_4_FX
> -	default y
> +	default n
>  
>  config STB03xxx
>  	bool
> -- 
> 1.5.1

-Dale

Return-Path: <galak@kernel.crashing.org>
Received: from nommos.sslcatacombnetworking.com
	(nommos.sslcatacombnetworking.com [67.18.224.114])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 3771EDDE34
	for <linuxppc-dev@ozlabs.org>; Tue,  8 May 2007 23:34:16 +1000 (EST)
In-Reply-To: <20070508013044.6407.20509.stgit@localhost.localdomain>
References: <20070508013044.6407.20509.stgit@localhost.localdomain>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <522959B8-DDF1-4AA1-87AE-336793EDA181@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH] [POWERPC] 8xx: PQ SoC IRDA support
Date: Tue, 8 May 2007 08:33:19 -0500
To: Vitaly Bordug <vitb@kernel.crashing.org>
Cc: Andrew Morton <akpm@osdl.org>, linuxppc-dev@ozlabs.org,
	Samuel Ortiz <samuel@sortiz.org>, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On May 7, 2007, at 8:30 PM, Vitaly Bordug wrote:

>
> Adds support of IRDA transceiver residing on PowerQUICC processors and
> enabling such on mpc885ads reference board. The driver is implemented
> using of_device concept, hereby implies arch/powerpc support of the  
> target.
>
> Signed-off-by: Vitaly Bordug <vitb@kernel.crashing.org>
>
> Signed-off-by: Vitaly Bordug <vitb@kernel.crashing.org>
> ---
>
>  arch/powerpc/Kconfig                         |    1
>  arch/powerpc/boot/dts/mpc885ads.dts          |   10
>  arch/powerpc/platforms/8xx/mpc885ads_setup.c |   39 +
>  arch/powerpc/sysdev/fsl_soc.c                |   58 ++
>  drivers/net/irda/Kconfig                     |    4
>  drivers/net/irda/Makefile                    |    1
>  drivers/net/irda/m8xx-sir.c                  |  715 +++++++++++++++ 
> +++++++++++
>  include/asm-ppc/commproc.h                   |   67 ++
>  8 files changed, 895 insertions(+), 0 deletions(-)
>
> diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
> index a8e08f4..c283907 100644
> --- a/arch/powerpc/Kconfig
> +++ b/arch/powerpc/Kconfig
> @@ -605,6 +605,7 @@ endmenu
>  config ISA_DMA_API
>  	bool
>  	default y
> +	depends on !PPC_8xx
>
>  menu "Bus options"
>
> diff --git a/arch/powerpc/boot/dts/mpc885ads.dts b/arch/powerpc/ 
> boot/dts/mpc885ads.dts
> index 110bf61..95b280c 100644
> --- a/arch/powerpc/boot/dts/mpc885ads.dts
> +++ b/arch/powerpc/boot/dts/mpc885ads.dts
> @@ -178,6 +178,16 @@
>  				interrupt-parent = <930>;
>  				phy-handle = <e8002>;
>  			};
> +
> +			scc@a20 {
> +				device_type = "network";
> +				compatible = "fsl,irda";

is this specific enough?  52xx also has irda and I'm guessing they'd  
require different drivers (haven't looked).

> +				model = "SCC";
> +				device-id = <2>;
> +				reg = <a20 18 3d00 80>;
> +				interrupts = <1d 3>;
> +				interrupt-parent = <930>;
> +			};
>  		};
>  	};
>  };

[snip]

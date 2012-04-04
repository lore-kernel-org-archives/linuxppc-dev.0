Return-Path: <shawn.guo@linaro.org>
Received: from mail-iy0-f179.google.com (mail-iy0-f179.google.com
 [209.85.210.179])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id BAB62B7000
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  4 Apr 2012 23:32:24 +1000 (EST)
Received: by iakh37 with SMTP id h37so355106iak.38
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 04 Apr 2012 06:32:22 -0700 (PDT)
Date: Wed, 4 Apr 2012 21:32:50 +0800
From: Shawn Guo <shawn.guo@linaro.org>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH] powerpc: select PPC_CLOCK unconditionally for FSL_SOC
Message-ID: <20120404133246.GA25168@S2101-09.ap.freescale.net>
References: <1333085936-8977-1-git-send-email-shawn.guo@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1333085936-8977-1-git-send-email-shawn.guo@linaro.org>
Cc: alsa-devel@alsa-project.org, linuxppc-dev@lists.ozlabs.org,
 Timur Tabi <timur@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Kumar,

Gentle ping ...

Regards,
Shawn

On Fri, Mar 30, 2012 at 01:38:56PM +0800, Shawn Guo wrote:
> Freescale PowerPC SoCs share a number of IP blocks with Freescale
> ARM/IMX SoCs, FlexCAN, SSI, FEC, eSDHC, USB, etc.  There are some
> effort consolidating those drivers to make them work for both
> architectures.
> 
> One outstanding difference between two architectures is ARM/IMX will
> turn off module clocks during platform initialization for power saving
> and expects drivers manage clocks using clk API, while PowerPC
> mostly does not do that, and thus does not always build in clk API.
> 
> Listing all those driver Kconfig options in "select PPC_CLOCK if" seems
> not scalable for long term maintenance, and could easily introduce
> Kconfig recursive dependency.  This patch chooses to select PPC_CLOCK
> unconditionally for FSL_SOC to always build clk API for PowerPC in.
> 
> Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
> ---
>  arch/powerpc/Kconfig |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
> index feab3ba..63fa7fb 100644
> --- a/arch/powerpc/Kconfig
> +++ b/arch/powerpc/Kconfig
> @@ -661,7 +661,7 @@ config SBUS
>  config FSL_SOC
>  	bool
>  	select HAVE_CAN_FLEXCAN if NET && CAN
> -	select PPC_CLOCK if CAN_FLEXCAN
> +	select PPC_CLOCK
>  
>  config FSL_PCI
>   	bool
> -- 
> 1.7.5.4
> 

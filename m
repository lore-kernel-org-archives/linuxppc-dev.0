Return-Path: <baruch@tkos.co.il>
Received: from tango.tkos.co.il (tango.tkos.co.il [62.219.50.35])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id F2646B6F70
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 12 Jul 2011 14:15:52 +1000 (EST)
Date: Tue, 12 Jul 2011 07:15:02 +0300
From: Baruch Siach <baruch@tkos.co.il>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [RFC PATCH] powerpc: 85xx: Make e500/e500v2 depend on !E500MC
Message-ID: <20110712041502.GA24957@sapphire.tkos.co.il>
References: <fef1cfc9a418ec5aa3302915dcb392882f7dd5d2.1308545584.git.baruch@tkos.co.il>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <fef1cfc9a418ec5aa3302915dcb392882f7dd5d2.1308545584.git.baruch@tkos.co.il>
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Kumar,

On Mon, Jun 20, 2011 at 07:56:10AM +0300, Baruch Siach wrote:
> CONFIG_E500MC breaks e500/e500v2 systems. It defines L1_CACHE_SHIFT to 6, thus
> breaking clear_pages(), probably others too.

Ping?
Ack/Nack?

baruch

> Cc: Kumar Gala <galak@kernel.crashing.org>
> Signed-off-by: Baruch Siach <baruch@tkos.co.il>
> ---
> Is this the right approach?
> 
>  arch/powerpc/platforms/85xx/Kconfig |    4 ++++
>  1 files changed, 4 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/powerpc/platforms/85xx/Kconfig b/arch/powerpc/platforms/85xx/Kconfig
> index b6976e1..5b8546d 100644
> --- a/arch/powerpc/platforms/85xx/Kconfig
> +++ b/arch/powerpc/platforms/85xx/Kconfig
> @@ -13,6 +13,8 @@ if FSL_SOC_BOOKE
>  
>  if PPC32
>  
> +if !PPC_E500MC
> +
>  config MPC8540_ADS
>  	bool "Freescale MPC8540 ADS"
>  	select DEFAULT_UIMAGE
> @@ -155,6 +157,8 @@ config SBC8560
>  	help
>  	  This option enables support for the Wind River SBC8560 board
>  
> +endif # !PPC_E500MC
> +
>  config P3041_DS
>  	bool "Freescale P3041 DS"
>  	select DEFAULT_UIMAGE
> -- 
> 1.7.5.3

-- 
                                                     ~. .~   Tk Open Systems
=}------------------------------------------------ooO--U--Ooo------------{=
   - baruch@tkos.co.il - tel: +972.2.679.5364, http://www.tkos.co.il -

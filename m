Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 20355B6FC3
 for <linuxppc-dev@ozlabs.org>; Fri, 17 Feb 2012 19:42:35 +1100 (EST)
Message-ID: <1329468145.2892.60.camel@pasglop>
Subject: Re: [PATCH 1/2] powerpc/85xx: fix problem that prevents PHYS_64BIT
 from configurable
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Li Yang <leoli@freescale.com>
Date: Fri, 17 Feb 2012 19:42:25 +1100
In-Reply-To: <1329394210-1014-1-git-send-email-leoli@freescale.com>
References: <1329394210-1014-1-git-send-email-leoli@freescale.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2012-02-16 at 20:10 +0800, Li Yang wrote:
> Fix the problem that large physical address support cannot be
> disabled when some platforms which only provides 36-bit support
> are selected.  According to the philosophy of kernel config
> enabling a platform support doesn't mean the kernel is only
> running on that platform.  Remove the auto selection of PHYS_64BIT
> option for these platforms.  They will need to use a 36bit default
> config that selects PHYS_64BIT explicitly.

No, but unless I'm wrong, with your patch, enabling those platforms will
build the code ... but they won't work unless you -also- enable
PHYS_64BIT one way or another. I thus disagree.

If I enable CONFIG_P1022_DS, I expect those boards to work.

If that's going to negatively impact perfs on other boards that I also
enabled, then so be it (and we should document it in the help text).

Cheers,
Ben.

> The reason why we need to keep PHYS_64BIT option configurable is
> that enabling it cause negative performance impact on various
> aspects like TLB miss and physical address manipulating.  We should
> not enable it unless really needed, e.g. use large memory of 4GB
> or bigger.
> 
> Signed-off-by: Li Yang <leoli@freescale.com>
> ---
>  arch/powerpc/platforms/85xx/Kconfig |    6 ------
>  1 files changed, 0 insertions(+), 6 deletions(-)
> 
> diff --git a/arch/powerpc/platforms/85xx/Kconfig b/arch/powerpc/platforms/85xx/Kconfig
> index d7946be..d9bc0bd 100644
> --- a/arch/powerpc/platforms/85xx/Kconfig
> +++ b/arch/powerpc/platforms/85xx/Kconfig
> @@ -80,7 +80,6 @@ config P1010_RDB
>  config P1022_DS
>  	bool "Freescale P1022 DS"
>  	select DEFAULT_UIMAGE
> -	select PHYS_64BIT	# The DTS has 36-bit addresses
>  	select SWIOTLB
>  	help
>  	  This option enables support for the Freescale P1022DS reference board.
> @@ -175,7 +174,6 @@ config P2041_RDB
>  	bool "Freescale P2041 RDB"
>  	select DEFAULT_UIMAGE
>  	select PPC_E500MC
> -	select PHYS_64BIT
>  	select SWIOTLB
>  	select ARCH_REQUIRE_GPIOLIB
>  	select GPIO_MPC8XXX
> @@ -188,7 +186,6 @@ config P3041_DS
>  	bool "Freescale P3041 DS"
>  	select DEFAULT_UIMAGE
>  	select PPC_E500MC
> -	select PHYS_64BIT
>  	select SWIOTLB
>  	select ARCH_REQUIRE_GPIOLIB
>  	select GPIO_MPC8XXX
> @@ -201,7 +198,6 @@ config P3060_QDS
>  	bool "Freescale P3060 QDS"
>  	select DEFAULT_UIMAGE
>  	select PPC_E500MC
> -	select PHYS_64BIT
>  	select SWIOTLB
>  	select GPIO_MPC8XXX
>  	select HAS_RAPIDIO
> @@ -213,7 +209,6 @@ config P4080_DS
>  	bool "Freescale P4080 DS"
>  	select DEFAULT_UIMAGE
>  	select PPC_E500MC
> -	select PHYS_64BIT
>  	select SWIOTLB
>  	select ARCH_REQUIRE_GPIOLIB
>  	select GPIO_MPC8XXX
> @@ -229,7 +224,6 @@ config P5020_DS
>  	select DEFAULT_UIMAGE
>  	select E500
>  	select PPC_E500MC
> -	select PHYS_64BIT
>  	select SWIOTLB
>  	select ARCH_REQUIRE_GPIOLIB
>  	select GPIO_MPC8XXX

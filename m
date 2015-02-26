Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 68D0E1A002B
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 26 Feb 2015 17:38:44 +1100 (AEDT)
In-Reply-To: <1424421344.27448.43.camel@kernel.crashing.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 linuxppc dev list <linuxppc-dev@lists.ozlabs.org>
From: Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [3/3] powerpc/dma: Remove ZONE_DMA completely
Message-Id: <20150226063844.4C8A31400EA@ozlabs.org>
Date: Thu, 26 Feb 2015 17:38:44 +1100 (AEDT)
Cc: Scott Wood <scottwood@freescale.com>, Anton Blanchard <anton@au1.ibm.com>,
 Brian J King <bjking1@us.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2015-20-02 at 08:35:44 UTC, Benjamin Herrenschmidt wrote:
> We don't initialize it, we don't use it, remove it.
> 
> We can bring it back if we ever wish to have support for devices
> who have smaller than 32-bit DMA limitations but I don't think
> we care much anymore.
> 
> Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> ---
>  arch/powerpc/Kconfig      |    2 +-
>  arch/powerpc/kernel/dma.c |   10 +---------
>  2 files changed, 2 insertions(+), 10 deletions(-)
> 
> diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
> index 22b0940..4efbfba 100644
> --- a/arch/powerpc/Kconfig
> +++ b/arch/powerpc/Kconfig
> @@ -712,7 +712,7 @@ config ISA
>  
>  config ZONE_DMA
>  	bool
> -	default y
> +	default n
>  
>  config NEED_DMA_MAP_STATE
>  	def_bool (PPC64 || NOT_COHERENT_CACHE)
> diff --git a/arch/powerpc/kernel/dma.c b/arch/powerpc/kernel/dma.c
> index e24e0ae..6306d4e 100644
> --- a/arch/powerpc/kernel/dma.c
> +++ b/arch/powerpc/kernel/dma.c
> @@ -63,16 +63,8 @@ void *dma_direct_alloc_coherent(struct device *dev, size_t size,
>  		return NULL;
>  	}
>  
> -	switch (zone) {
> -	case ZONE_DMA:
> -		flag |= GFP_DMA;
> -		break;
> -#ifdef CONFIG_ZONE_DMA32
> -	case ZONE_DMA32:
> +	if (zone == ZONE_DMA32)
>  		flag |= GFP_DMA32;
> -		break;
> -#endif
> -	};

You still need the ifdef, else eg. ppc6xx_defconfig:

  arch/powerpc/kernel/dma.c:66:14: error: 'ZONE_DMA32' undeclared (first use in this function)

cheers

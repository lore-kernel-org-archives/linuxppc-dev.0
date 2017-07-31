Return-Path: <christophe.leroy@c-s.fr>
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xLXxL3PDqzDqBf
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 31 Jul 2017 18:41:41 +1000 (AEST)
Subject: Re: [PATCH] powerpc/asm/cacheflush: Cleanup cacheflush function params
To: Matt Brown <matthew.brown.dev@gmail.com>, linuxppc-dev@lists.ozlabs.org,
 linux-ide@vger.kernel.org, dri-devel@lists.freedesktop.org,
 adi-buildroot-devel@lists.sourceforge.net, linux-mmc@vger.kernel.org,
 linux-mtd@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
 linux-spi@vger.kernel.org, linux-serial@vger.kernel.org,
 linux-usb@vger.kernel.org
References: <20170720062850.2195-1-matthew.brown.dev@gmail.com>
From: Christophe LEROY <christophe.leroy@c-s.fr>
Message-ID: <25421c43-7371-c23e-e784-f4df61400cd0@c-s.fr>
Date: Mon, 31 Jul 2017 10:41:35 +0200
MIME-Version: 1.0
In-Reply-To: <20170720062850.2195-1-matthew.brown.dev@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



Le 20/07/2017 à 08:28, Matt Brown a écrit :
> The cacheflush prototypes currently use start and stop values and each
> call requires typecasting the address to an unsigned long.
> This patch changes the cacheflush prototypes to follow the x86 style of
> using a base and size values, with base being a void pointer.
> 
> All callers of the cacheflush functions, including drivers, have been
> modified to conform to the new prototypes.
> 
> The 64 bit cacheflush functions which were implemented in assembly code
> (flush_dcache_range, flush_inval_dcache_range) have been translated into
> C for readability and coherence.
> 
> Signed-off-by: Matt Brown <matthew.brown.dev@gmail.com>
> ---
>   arch/powerpc/include/asm/cacheflush.h        | 47 +++++++++++++++++--------
>   arch/powerpc/kernel/misc_64.S                | 52 ----------------------------
>   arch/powerpc/mm/dma-noncoherent.c            | 15 ++++----
>   arch/powerpc/platforms/512x/mpc512x_shared.c | 10 +++---
>   arch/powerpc/platforms/85xx/smp.c            |  6 ++--
>   arch/powerpc/sysdev/dart_iommu.c             |  5 +--
>   drivers/ata/pata_bf54x.c                     |  3 +-
>   drivers/char/agp/uninorth-agp.c              |  6 ++--
>   drivers/gpu/drm/drm_cache.c                  |  3 +-
>   drivers/macintosh/smu.c                      | 15 ++++----
>   drivers/mmc/host/bfin_sdh.c                  |  3 +-
>   drivers/mtd/nand/bf5xx_nand.c                |  6 ++--
>   drivers/soc/fsl/qbman/dpaa_sys.h             |  2 +-
>   drivers/soc/fsl/qbman/qman_ccsr.c            |  3 +-
>   drivers/spi/spi-bfin5xx.c                    | 10 +++---
>   drivers/tty/serial/mpsc.c                    | 46 ++++++++----------------
>   drivers/usb/musb/blackfin.c                  |  6 ++--
>   17 files changed, 86 insertions(+), 152 deletions(-)
> 

[...]

> diff --git a/arch/powerpc/mm/dma-noncoherent.c b/arch/powerpc/mm/dma-noncoherent.c
> index 3825284..5fd3171 100644
> --- a/arch/powerpc/mm/dma-noncoherent.c
> +++ b/arch/powerpc/mm/dma-noncoherent.c
> @@ -204,9 +204,9 @@ __dma_alloc_coherent(struct device *dev, size_t size, dma_addr_t *handle, gfp_t
>   	 * kernel direct-mapped region for device DMA.
>   	 */
>   	{
> -		unsigned long kaddr = (unsigned long)page_address(page);
> +		void *kaddr = page_address(page);
>   		memset(page_address(page), 0, size);
> -		flush_dcache_range(kaddr, kaddr + size);
> +		flush_dcache_range(kaddr, size);
>   	}
>   
>   	/*
> @@ -316,9 +316,6 @@ EXPORT_SYMBOL(__dma_free_coherent);
>    */
>   void __dma_sync(void *vaddr, size_t size, int direction)
>   {
> -	unsigned long start = (unsigned long)vaddr;
> -	unsigned long end   = start + size;
> -
>   	switch (direction) {
>   	case DMA_NONE:
>   		BUG();
> @@ -328,15 +325,15 @@ void __dma_sync(void *vaddr, size_t size, int direction)
>   		 * the potential for discarding uncommitted data from the cache
>   		 */
>   		if ((start | end) & (L1_CACHE_BYTES - 1))

How can the above compile when 'start' and 'end' are removed ?
Shouldn't it be replaced by

if ((vaddr | size) & (L1_CACHE_BYTES - 1))

> -			flush_dcache_range(start, end);
> +			flush_dcache_range(vaddr, size);
>   		else
> -			invalidate_dcache_range(start, end);
> +			invalidate_dcache_range(vaddr, size);
>   		break;
>   	case DMA_TO_DEVICE:		/* writeback only */
> -		clean_dcache_range(start, end);
> +		clean_dcache_range(vaddr, size);
>   		break;
>   	case DMA_BIDIRECTIONAL:	/* writeback and invalidate */
> -		flush_dcache_range(start, end);
> +		flush_dcache_range(vaddr, size);
>   		break;
>   	}
>   }

[...]

Christophe

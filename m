Return-Path: <christophe.leroy@c-s.fr>
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3y5xXG2S2QzDr0r
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  3 Oct 2017 22:25:01 +1100 (AEDT)
Subject: Re: [PATCH 07/11] powerpc: make dma_cache_sync a no-op
To: Christoph Hellwig <hch@lst.de>, iommu@lists.linux-foundation.org
Cc: Chris Zankel <chris@zankel.net>, Michal Simek <monstr@monstr.eu>,
 linux-ia64@vger.kernel.org, linux-mips@linux-mips.org,
 linux-sh@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-xtensa@linux-xtensa.org, x86@kernel.org, linux-kernel@vger.kernel.org,
 David Howells <dhowells@redhat.com>, Max Filippov <jcmvbkbc@gmail.com>,
 Guan Xuetao <gxt@mprc.pku.edu.cn>, Robin Murphy <robin.murphy@arm.com>,
 Marek Szyprowski <m.szyprowski@samsung.com>
References: <20171003104311.10058-1-hch@lst.de>
 <20171003104311.10058-8-hch@lst.de>
From: Christophe LEROY <christophe.leroy@c-s.fr>
Message-ID: <670a0571-1a36-51a3-db52-64bc61184c35@c-s.fr>
Date: Tue, 3 Oct 2017 13:24:57 +0200
MIME-Version: 1.0
In-Reply-To: <20171003104311.10058-8-hch@lst.de>
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



Le 03/10/2017 à 12:43, Christoph Hellwig a écrit :
> powerpc does not implement DMA_ATTR_NON_CONSISTENT allocations, so it
> doesn't make any sense to do any work in dma_cache_sync given that it
> must be a no-op when dma_alloc_attrs returns coherent memory.
What about arch/powerpc/mm/dma-noncoherent.c ?

Powerpc 8xx doesn't have coherent memory.

Christophe

> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>   arch/powerpc/include/asm/dma-mapping.h | 2 --
>   1 file changed, 2 deletions(-)
> 
> diff --git a/arch/powerpc/include/asm/dma-mapping.h b/arch/powerpc/include/asm/dma-mapping.h
> index eaece3d3e225..320846442bfb 100644
> --- a/arch/powerpc/include/asm/dma-mapping.h
> +++ b/arch/powerpc/include/asm/dma-mapping.h
> @@ -144,8 +144,6 @@ static inline phys_addr_t dma_to_phys(struct device *dev, dma_addr_t daddr)
>   static inline void dma_cache_sync(struct device *dev, void *vaddr, size_t size,
>   		enum dma_data_direction direction)
>   {
> -	BUG_ON(direction == DMA_NONE);
> -	__dma_sync(vaddr, size, (int)direction);
>   }
>   
>   #endif /* __KERNEL__ */
> 

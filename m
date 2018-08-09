Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41m8HC3SrszDqkP
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  9 Aug 2018 10:28:07 +1000 (AEST)
Message-ID: <bfa22816fee0759cfee28705b427be3586c7d2e3.camel@kernel.crashing.org>
Subject: Re: [PATCH 10/20] powerpc/dma-noncoherent: don't disable irqs over
 kmap_atomic
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Christoph Hellwig <hch@lst.de>, Paul Mackerras <paulus@samba.org>,
 Michael Ellerman <mpe@ellerman.id.au>, Tony Luck <tony.luck@intel.com>,
 Fenghua Yu <fenghua.yu@intel.com>
Cc: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Robin Murphy
 <robin.murphy@arm.com>, linuxppc-dev@lists.ozlabs.org,
 iommu@lists.linux-foundation.org, linux-ia64@vger.kernel.org
Date: Thu, 09 Aug 2018 10:27:46 +1000
In-Reply-To: <20180730163824.10064-11-hch@lst.de>
References: <20180730163824.10064-1-hch@lst.de>
 <20180730163824.10064-11-hch@lst.de>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2018-07-30 at 18:38 +0200, Christoph Hellwig wrote:
> The requirement to disable local irqs over kmap_atomic is long gone,
> so remove those calls.

Really ? I'm trying to verify that and getting lost in a mess of macros
from hell in the per-cpu stuff but if you look at our implementation
of kmap_atomic_prot(), all it does is a preempt_disable(), and then
it uses kmap_atomic_idx_push():

	int idx = __this_cpu_inc_return(__kmap_atomic_idx) - 1;

Note the use of __this_cpu_inc_return(), not this_cpu_inc_return(),
ie this is the non-interrupt safe version...

Ben.

> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  arch/powerpc/mm/dma-noncoherent.c | 6 +-----
>  1 file changed, 1 insertion(+), 5 deletions(-)
> 
> diff --git a/arch/powerpc/mm/dma-noncoherent.c b/arch/powerpc/mm/dma-noncoherent.c
> index 382528475433..d1c16456abac 100644
> --- a/arch/powerpc/mm/dma-noncoherent.c
> +++ b/arch/powerpc/mm/dma-noncoherent.c
> @@ -357,12 +357,10 @@ static inline void __dma_sync_page_highmem(struct page *page,
>  {
>  	size_t seg_size = min((size_t)(PAGE_SIZE - offset), size);
>  	size_t cur_size = seg_size;
> -	unsigned long flags, start, seg_offset = offset;
> +	unsigned long start, seg_offset = offset;
>  	int nr_segs = 1 + ((size - seg_size) + PAGE_SIZE - 1)/PAGE_SIZE;
>  	int seg_nr = 0;
>  
> -	local_irq_save(flags);
> -
>  	do {
>  		start = (unsigned long)kmap_atomic(page + seg_nr) + seg_offset;
>  
> @@ -378,8 +376,6 @@ static inline void __dma_sync_page_highmem(struct page *page,
>  		cur_size += seg_size;
>  		seg_offset = 0;
>  	} while (seg_nr < nr_segs);
> -
> -	local_irq_restore(flags);
>  }
>  #endif /* CONFIG_HIGHMEM */
>  

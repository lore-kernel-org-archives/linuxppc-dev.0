Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 1DD12DDE0A
	for <linuxppc-dev@ozlabs.org>; Sat,  1 Dec 2007 07:35:44 +1100 (EST)
Subject: Re: [RFC][PATCH] [POWERPC] Allow caching of kmap_atomic page
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <Pine.LNX.4.64.0711300311490.1799@blarg.am.freescale.net>
References: <Pine.LNX.4.64.0711300311490.1799@blarg.am.freescale.net>
Content-Type: text/plain
Date: Sat, 01 Dec 2007 07:35:15 +1100
Message-Id: <1196454915.13230.90.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Fri, 2007-11-30 at 03:14 -0600, Kumar Gala wrote:
> Skip updating the kmap_pte and flushing the TLB if the pte we
> are about to write is the same as the one we wrote last time we
> called kmap_atomic for this km_type.
> 
> Also expose the flags to allow a caller to specify their own
> flags for things like non-cacheable IO memory.
> 
> ---
> 
> This is the starts of some work Ben and I were discussion to allow us to
> use kmap_atomic to access a page size region of PCI CFG space when its
> provided as direct MMIO.
> 
> We also intend to provide a means to preload the TLB for SW managed TLB
> machines.

We probably need to move that outside of highmem though...

Cheers,
Ben.

> - k
> 
>  include/asm-powerpc/highmem.h |   16 +++++++++++++---
>  1 files changed, 13 insertions(+), 3 deletions(-)
> 
> diff --git a/include/asm-powerpc/highmem.h b/include/asm-powerpc/highmem.h
> index f7b21ee..a50bb00 100644
> --- a/include/asm-powerpc/highmem.h
> +++ b/include/asm-powerpc/highmem.h
> @@ -73,10 +73,12 @@ static inline void kunmap(struct page *page)
>   * be used in IRQ contexts, so in some (very limited) cases we need
>   * it.
>   */
> -static inline void *kmap_atomic(struct page *page, enum km_type type)
> +static inline void *__kmap_atomic(struct page *page,
> +				  enum km_type type, unsigned long flags)
>  {
>  	unsigned int idx;
>  	unsigned long vaddr;
> +	pte_t pte;
> 
>  	/* even !CONFIG_PREEMPT needs this, for in_atomic in do_page_fault */
>  	pagefault_disable();
> @@ -88,12 +90,20 @@ static inline void *kmap_atomic(struct page *page, enum km_type type)
>  #ifdef HIGHMEM_DEBUG
>  	BUG_ON(!pte_none(*(kmap_pte+idx)));
>  #endif
> -	set_pte_at(&init_mm, vaddr, kmap_pte+idx, mk_pte(page, kmap_prot));
> -	flush_tlb_page(NULL, vaddr);
> +	pte = mk_pte(page, flags);
> +	if (!pte_same(kmap_pte[idx], pte)) {
> +		set_pte_at(&init_mm, vaddr, kmap_pte+idx, pte);
> +		flush_tlb_page(NULL, vaddr);
> +	}
> 
>  	return (void*) vaddr;
>  }
> 
> +static inline void *kmap_atomic(struct page *page, enum km_type type)
> +{
> +	return __kmap_atomic(page, type, kmap_prot);
> +}
> +
>  static inline void kunmap_atomic(void *kvaddr, enum km_type type)
>  {
>  #ifdef HIGHMEM_DEBUG

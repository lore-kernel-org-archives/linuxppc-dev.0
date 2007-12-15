Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id A5CF2DDDEE
	for <linuxppc-dev@ozlabs.org>; Sat, 15 Dec 2007 17:17:56 +1100 (EST)
Subject: Re: [PATCH 07/10] powerpc: Implement kmap_atomic_pfn on powerpc
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Dale Farnsworth <dale@farnsworth.org>
In-Reply-To: <20071122154638.GA26514@xyzzy.farnsworth.org>
References: <20071122154638.GA26514@xyzzy.farnsworth.org>
Content-Type: text/plain
Date: Sat, 15 Dec 2007 17:17:41 +1100
Message-Id: <1197699461.6696.45.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Thu, 2007-11-22 at 08:46 -0700, Dale Farnsworth wrote:
> This is needed for the ppc32 /dev/oldmem driver of crash dump.

Kumar's working (well, last I heard he was) on a fixmap mechanism
so we can do that sort of thing without CONFIG_HIGHMEM, you may
want to sync with him here, that would allow to shrink the crash
kernel by not having highmem selected.

Cheers,
Ben.
 
> Signed-off-by: Dale Farnsworth <dale@farnsworth.org>
> ---
>  include/asm-powerpc/highmem.h |   18 ++++++++++++++++++
>  1 files changed, 18 insertions(+), 0 deletions(-)
> 
> diff --git a/include/asm-powerpc/highmem.h b/include/asm-powerpc/highmem.h
> index f7b21ee..88d9e05 100644
> --- a/include/asm-powerpc/highmem.h
> +++ b/include/asm-powerpc/highmem.h
> @@ -117,6 +117,24 @@ static inline void kunmap_atomic(void *kvaddr, enum km_type type)
>  	pagefault_enable();
>  }
>  
> +/* This is the same as kmap_atomic() but can map memory that doesn't
> + * have a struct page associated with it.
> + */
> +static inline void *kmap_atomic_pfn(unsigned long pfn, enum km_type type)
> +{
> +	unsigned int idx;
> +	unsigned long vaddr;
> +
> +	pagefault_disable();
> +
> +	idx = type + KM_TYPE_NR * smp_processor_id();
> +	vaddr = KMAP_FIX_BEGIN + idx * PAGE_SIZE;
> +	set_pte_at(&init_mm, vaddr, kmap_pte+idx, pfn_pte(pfn, kmap_prot));
> +	flush_tlb_page(NULL, vaddr);
> +
> +	return (void*) vaddr;
> +}
> +
>  static inline struct page *kmap_atomic_to_page(void *ptr)
>  {
>  	unsigned long idx, vaddr = (unsigned long) ptr;

Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 1E7F1B7B91
	for <linuxppc-dev@ozlabs.org>; Tue, 27 Oct 2009 13:28:39 +1100 (EST)
Subject: Re: [2/6] Cleanup management of kmem_caches for pagetables
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: David Gibson <david@gibson.dropbear.id.au>
In-Reply-To: <20091016052212.E565EB7BBB@ozlabs.org>
References: <20091016052212.E565EB7BBB@ozlabs.org>
Content-Type: text/plain; charset="UTF-8"
Date: Tue, 27 Oct 2009 13:28:19 +1100
Message-ID: <1256610499.2076.69.camel@pasglop>
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

On Fri, 2009-10-16 at 16:22 +1100, David Gibson wrote:

Minor nits... if you can respin today I should push it out to -next

> +void pgtable_cache_add(unsigned shift, void (*ctor)(void *))
> +{
> +	char *name;
> +	unsigned long table_size = sizeof(void *) << shift;
> +	unsigned long align = table_size;

This is a bit thick.. could use some air. Just separate the definitions
from the assignments so you can make the code breath a bit :-)

Also the above warrants a comment explaining that this won't work for
PTE pages since sizeof(PTE) >= sizeof(void *) and the day we finally
move out of pte page == struct page, the code here will have to be
adapted.

> +	/* When batching pgtable pointers for RCU freeing, we store
> +	 * the index size in the low bits.  Table alignment must be
> +	 * big enough to fit it */
> +	unsigned long minalign = MAX_PGTABLE_INDEX_SIZE + 1;
> +	struct kmem_cache *new;
> +
> +	/* It would be nice if this was a BUILD_BUG_ON(), but at the
> +	 * moment, gcc doesn't seem to recognize is_power_of_2 as a
> +	 * constant expression, so so much for that. */
> +	BUG_ON(!is_power_of_2(minalign));
> +	BUG_ON((shift < 1) || (shift > MAX_PGTABLE_INDEX_SIZE));
> +
> +	if (PGT_CACHE(shift))
> +		return; /* Already have a cache of this size */

Blank line here too

> +	align = max_t(unsigned long, align, minalign);
> +	name = kasprintf(GFP_KERNEL, "pgtable-2^%d", shift);
> +	new = kmem_cache_create(name, table_size, align, 0, ctor);
> +	PGT_CACHE(shift) = new;

And here

> +	pr_debug("Allocated pgtable cache for order %d\n", shift);
> +}
> +
>  
>  void pgtable_cache_init(void)
>  {
> -	pgtable_cache[0] = kmem_cache_create(pgtable_cache_name[0], PGD_TABLE_SIZE, PGD_TABLE_SIZE, SLAB_PANIC, pgd_ctor);
> -	pgtable_cache[1] = kmem_cache_create(pgtable_cache_name[1], PMD_TABLE_SIZE, PMD_TABLE_SIZE, SLAB_PANIC, pmd_ctor);
> +	pgtable_cache_add(PGD_INDEX_SIZE, pgd_ctor);
> +	pgtable_cache_add(PMD_INDEX_SIZE, pmd_ctor);
> +	if (!PGT_CACHE(PGD_INDEX_SIZE) || !PGT_CACHE(PMD_INDEX_SIZE))
> +		panic("Couldn't allocate pgtable caches");
> +	BUG_ON(PUD_INDEX_SIZE && !PGT_CACHE(PUD_INDEX_SIZE));
>  }

panic vs. BUG_ON() ... could be a bit more consistent.
 
>  #ifdef CONFIG_SPARSEMEM_VMEMMAP
> Index: working-2.6/arch/powerpc/include/asm/pgalloc-64.h
> ===================================================================
> --- working-2.6.orig/arch/powerpc/include/asm/pgalloc-64.h	2009-10-16 12:53:45.000000000 +1100
> +++ working-2.6/arch/powerpc/include/asm/pgalloc-64.h	2009-10-16 12:53:51.000000000 +1100
> @@ -11,27 +11,30 @@
>  #include <linux/cpumask.h>
>  #include <linux/percpu.h>
>  
> +/*
> + * This needs to be big enough to allow any pagetable sizes we need,
> + * but small enough to fit in the low bits of any page table pointer.
> + * In other words all pagetables, even tiny ones, must be aligned to
> + * allow at least enough low 0 bits to contain this value.
> + */
> +#define MAX_PGTABLE_INDEX_SIZE	0xf

This also has the constraint of being a (power of 2) - 1... worth
mentioning somewhere ?

Also if you could comment somewhere that index size == 0 means a PTE
page ? Not totally obvious at first.

Cheers,
Ben.

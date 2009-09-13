Return-Path: <benh@kernel.crashing.org>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 75762B7067
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon, 14 Sep 2009 08:28:26 +1000 (EST)
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id A8C2EDDD04
	for <linuxppc-dev@ozlabs.org>; Mon, 14 Sep 2009 08:28:25 +1000 (EST)
Subject: Re: [2/5] Cleanup management of kmem_caches for pagetables
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: David Gibson <david@gibson.dropbear.id.au>
In-Reply-To: <20090909055916.58003B7B60@bilbo.ozlabs.org>
References: <20090909055916.58003B7B60@bilbo.ozlabs.org>
Content-Type: text/plain
Date: Mon, 14 Sep 2009 08:28:11 +1000
Message-Id: <1252880891.8375.94.camel@pasglop>
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

On Wed, 2009-09-09 at 15:59 +1000, David Gibson wrote:

> 6 files changed, 73 insertions(+), 108 deletions(-)

That's a pretty good start :-)

> +struct kmem_cache *pgtable_cache[PGF_SHIFT_MASK];
> +
> +void pgtable_cache_add(unsigned shift, void (*ctor)(void *))
> +{
> +	char *name;
> +	unsigned long table_size = sizeof(void *) << shift;
> +	struct kmem_cache *new;
> +
> +	BUG_ON((shift < 1) || (shift > PGF_SHIFT_MASK));
> +	if (PGT_CACHE(shift))
> +		return; /* Already have a cache of this size */
> +	name = kasprintf(GFP_KERNEL, "pgtable-2^%d", shift);
> +	new = kmem_cache_create(name, table_size, table_size, 0, ctor);
> +	PGT_CACHE(shift) = new;
> +}

I'm getting partial to verbose boot nowadays :-) At least a pr_debug if
not a pr_info up there "Allocated pgtable for order %d" or something
like that might end up being of some use when debugging things.

>  void pgtable_cache_init(void)
>  {
> -	pgtable_cache[0] = kmem_cache_create(pgtable_cache_name[0], PGD_TABLE_SIZE, PGD_TABLE_SIZE, SLAB_PANIC, pgd_ctor);
> -	pgtable_cache[1] = kmem_cache_create(pgtable_cache_name[1], PMD_TABLE_SIZE, PMD_TABLE_SIZE, SLAB_PANIC, pmd_ctor);
> +	pgtable_cache_add(PGD_INDEX_SIZE, pgd_ctor);
> +	pgtable_cache_add(PMD_INDEX_SIZE, pmd_ctor);
> +	if (!PGT_CACHE(PGD_INDEX_SIZE) || !PGT_CACHE(PMD_INDEX_SIZE))
> +		panic("Couldn't allocate pgtable caches");
> +	BUG_ON(!PGT_CACHE(PUD_INDEX_SIZE));

What if PUD_INDEX_SIZE is 0 ? (64k pages)

Couldn't we just do a

	if (PUD_INDEX_SIZE)
		pgtable_cache_add(PUD_INDEX_SIZE...)

If it's the same size as another cache it would just not do anything... 

> -static inline void pgtable_free(pgtable_free_t pgf)
> +static inline void pgtable_free(void *table, unsigned index_size)
>  {
> -	void *p = (void *)(pgf.val & ~PGF_CACHENUM_MASK);
> -	int cachenum = pgf.val & PGF_CACHENUM_MASK;
> -
> -	if (cachenum == PTE_NONCACHE_NUM)
> -		free_page((unsigned long)p);
> -	else
> -		kmem_cache_free(pgtable_cache[cachenum], p);
> +	if (!index_size)
> +		free_page((unsigned long)table);
> +	else {
> +		BUG_ON(index_size > PGF_SHIFT_MASK);
> +		kmem_cache_free(PGT_CACHE(index_size), table);
> +	}
>  }

Out of curiosity, what is the index_size == 0 case for ? Do we still use
it ? Agh... found it ... we don't put PTE pages in a cache, just use
gfp. I suppose that's lower overhead.

>  /* This needs to be big enough to allow for MMU_PAGE_COUNT + 2 to be stored
>   * and small enough to fit in the low bits of any naturally aligned page
>   * table cache entry. Arbitrarily set to 0x1f, that should give us some
>   * room to grow
>   */

The comment above will need updating (don't just remove it, please -do-
explain what it's all about :-)

> -#define PGF_CACHENUM_MASK	0x1f
> -
> -static inline pgtable_free_t pgtable_free_cache(void *p, int cachenum,
> -						unsigned long mask)
> -{
> -	BUG_ON(cachenum > PGF_CACHENUM_MASK);
> -
> -	return (pgtable_free_t){.val = ((unsigned long) p & ~mask) | cachenum};
> -}
> +#define PGF_SHIFT_MASK		0xf

That does bring one question tho... You still fill the batch by sticking
the shift into the low bits of the table right ? Which means that your
table must have at least 4 bits 0 at the bottom, ie, it must at least
have 2 pointers on 64-bit and 4 on 32-bit. Maybe you should add some
runtime test for the later (your comparisons to 1 do the job for 64-bit
but not for 32-bit or did I miss something ?)

Overall, a really nice cleanup... the previous stuff was hairy and prone
to breakage (see how it broke it twice due to misaligned cache names
array during the build-up of the book3e support). I'm actually tempted,
with a bit more testing, to sneak that into .32 despite arriving a bit
late, because the current code is really fragile.

Cheers,
Ben.

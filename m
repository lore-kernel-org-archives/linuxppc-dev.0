Return-Path: <dgibson@ozlabs.org>
Date: Tue, 27 Oct 2009 14:46:02 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [2/6] Cleanup management of kmem_caches for pagetables
Message-ID: <20091027034602.GB20694@yookeroo.seuss>
References: <20091016052212.E565EB7BBB@ozlabs.org>
	<1256610499.2076.69.camel@pasglop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1256610499.2076.69.camel@pasglop>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Oct 27, 2009 at 01:28:19PM +1100, Benjamin Herrenschmidt wrote:
> On Fri, 2009-10-16 at 16:22 +1100, David Gibson wrote:
> 
> Minor nits... if you can respin today I should push it out to -next
> 
> > +void pgtable_cache_add(unsigned shift, void (*ctor)(void *))
> > +{
> > +	char *name;
> > +	unsigned long table_size = sizeof(void *) << shift;
> > +	unsigned long align = table_size;
> 
> This is a bit thick.. could use some air. Just separate the definitions
> from the assignments so you can make the code breath a bit :-)

Ok.

> Also the above warrants a comment explaining that this won't work for
> PTE pages since sizeof(PTE) >= sizeof(void *) and the day we finally
> move out of pte page == struct page, the code here will have to be
> adapted.

Ok.

[snip]
> >  void pgtable_cache_init(void)
> >  {
> > -	pgtable_cache[0] = kmem_cache_create(pgtable_cache_name[0], PGD_TABLE_SIZE, PGD_TABLE_SIZE, SLAB_PANIC, pgd_ctor);
> > -	pgtable_cache[1] = kmem_cache_create(pgtable_cache_name[1], PMD_TABLE_SIZE, PMD_TABLE_SIZE, SLAB_PANIC, pmd_ctor);
> > +	pgtable_cache_add(PGD_INDEX_SIZE, pgd_ctor);
> > +	pgtable_cache_add(PMD_INDEX_SIZE, pmd_ctor);
> > +	if (!PGT_CACHE(PGD_INDEX_SIZE) || !PGT_CACHE(PMD_INDEX_SIZE))
> > +		panic("Couldn't allocate pgtable caches");
> > +	BUG_ON(PUD_INDEX_SIZE && !PGT_CACHE(PUD_INDEX_SIZE));
> >  }
> 
> panic vs. BUG_ON() ... could be a bit more consistent.

Uh.. there is actually a rationale for the difference here.  The
panic() is due to a a runtime error - couldn't allocate the caches -
which isn't necessarily a kernel bug (could be hardware error, or
ludicrously short on memory).

The trick is that allocating the PGD and PMD caches is supposed to
also create the PUD cache, because the PUD index size is always the
same as either the PGD or PUD cache.  If that's not true, we've broken
the assumptions the code is based on, hence BUG().

> >  #ifdef CONFIG_SPARSEMEM_VMEMMAP
> > Index: working-2.6/arch/powerpc/include/asm/pgalloc-64.h
> > ===================================================================
> > --- working-2.6.orig/arch/powerpc/include/asm/pgalloc-64.h	2009-10-16 12:53:45.000000000 +1100
> > +++ working-2.6/arch/powerpc/include/asm/pgalloc-64.h	2009-10-16 12:53:51.000000000 +1100
> > @@ -11,27 +11,30 @@
> >  #include <linux/cpumask.h>
> >  #include <linux/percpu.h>
> >  
> > +/*
> > + * This needs to be big enough to allow any pagetable sizes we need,
> > + * but small enough to fit in the low bits of any page table pointer.
> > + * In other words all pagetables, even tiny ones, must be aligned to
> > + * allow at least enough low 0 bits to contain this value.
> > + */
> > +#define MAX_PGTABLE_INDEX_SIZE	0xf
> 
> This also has the constraint of being a (power of 2) - 1... worth
> mentioning somewhere ?
> 
> Also if you could comment somewhere that index size == 0 means a PTE
> page ? Not totally obvious at first.

Ok, I've expanded on this comment.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

Return-Path: <dgibson@ozlabs.org>
Date: Tue, 27 Oct 2009 15:56:27 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [3/6] Allow more flexible layouts for hugepage pagetables
Message-ID: <20091027045627.GC20694@yookeroo.seuss>
References: <20091016052212.E1DE0B7BBD@ozlabs.org>
	<1256613059.11607.18.camel@pasglop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1256613059.11607.18.camel@pasglop>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Oct 27, 2009 at 02:10:59PM +1100, Benjamin Herrenschmidt wrote:
> On Fri, 2009-10-16 at 16:22 +1100, David Gibson wrote:
> 
> So far haven't seen anything blatantly wrong, in fact, this patch
> results in some nice cleanups.
> 
> One thing tho...
> 
> > -#ifdef CONFIG_HUGETLB_PAGE
> > -       /* Handle hugepage regions */
> > -       if (HPAGE_SHIFT && mmu_huge_psizes[psize]) {
> > -               DBG_LOW(" -> huge page !\n");
> > -               return hash_huge_page(mm, access, ea, vsid, local, trap);
> > -       }
> > -#endif /* CONFIG_HUGETLB_PAGE */
> > -
> >  #ifndef CONFIG_PPC_64K_PAGES
> >         /* If we use 4K pages and our psize is not 4K, then we are hitting
> >          * a special driver mapping, we need to align the address before
> > @@ -961,12 +954,18 @@ int hash_page(unsigned long ea, unsigned
> >  #endif /* CONFIG_PPC_64K_PAGES */
> 
> You basically made the above code be run with huge pages. This may not
> be what you want ... It will result in cropping the low EA bits probably
> at a stage where you don't want that (it might also be a non-issue, I
> just want you to double check :-)

Ok, I've done that, and adjusted the comment accordingly.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 83601B6F2B
	for <linuxppc-dev@ozlabs.org>; Tue, 27 Oct 2009 14:11:08 +1100 (EST)
Subject: Re: [3/6] Allow more flexible layouts for hugepage pagetables
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: David Gibson <david@gibson.dropbear.id.au>
In-Reply-To: <20091016052212.E1DE0B7BBD@ozlabs.org>
References: <20091016052212.E1DE0B7BBD@ozlabs.org>
Content-Type: text/plain; charset="UTF-8"
Date: Tue, 27 Oct 2009 14:10:59 +1100
Message-ID: <1256613059.11607.18.camel@pasglop>
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

So far haven't seen anything blatantly wrong, in fact, this patch
results in some nice cleanups.

One thing tho...

> -#ifdef CONFIG_HUGETLB_PAGE
> -       /* Handle hugepage regions */
> -       if (HPAGE_SHIFT && mmu_huge_psizes[psize]) {
> -               DBG_LOW(" -> huge page !\n");
> -               return hash_huge_page(mm, access, ea, vsid, local, trap);
> -       }
> -#endif /* CONFIG_HUGETLB_PAGE */
> -
>  #ifndef CONFIG_PPC_64K_PAGES
>         /* If we use 4K pages and our psize is not 4K, then we are hitting
>          * a special driver mapping, we need to align the address before
> @@ -961,12 +954,18 @@ int hash_page(unsigned long ea, unsigned
>  #endif /* CONFIG_PPC_64K_PAGES */

You basically made the above code be run with huge pages. This may not
be what you want ... It will result in cropping the low EA bits probably
at a stage where you don't want that (it might also be a non-issue, I
just want you to double check :-)

I suppose one option would be to remove that alignment and duplicate
the PTEs when creating those "special" mappings (afaik the only user
is spufs using 64K pages to map the local store)

Cheers,
Ben.

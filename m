Return-Path: <oss@buserror.net>
Received: from host.buserror.net (host.buserror.net [209.198.135.123])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tYL1V2PvYzDw6h
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  7 Dec 2016 12:06:54 +1100 (AEDT)
Message-ID: <1481072799.32531.23.camel@buserror.net>
From: Scott Wood <oss@buserror.net>
To: Christophe LEROY <christophe.leroy@c-s.fr>, Benjamin Herrenschmidt
 <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Michael
 Ellerman <mpe@ellerman.id.au>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date: Tue, 06 Dec 2016 19:06:39 -0600
In-Reply-To: <f4f6dfc6-92e5-fa98-6dcf-6da0bf8aa5e3@c-s.fr>
References: <cover.1474441301.git.christophe.leroy@c-s.fr>
 <69b1226ce134761fd7ab81a498bdb85cd737280f.1474441302.git.christophe.leroy@c-s.fr>
 <1480987116.32531.17.camel@buserror.net>
 <f4f6dfc6-92e5-fa98-6dcf-6da0bf8aa5e3@c-s.fr>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Subject: Re: [PATCH v3 2/3] powerpc: get hugetlbpage handling more generic
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2016-12-06 at 07:34 +0100, Christophe LEROY wrote:
> 
> Le 06/12/2016 à 02:18, Scott Wood a écrit :
> > 
> > On Wed, 2016-09-21 at 10:11 +0200, Christophe Leroy wrote:
> > > 
> > > Today there are two implementations of hugetlbpages which are managed
> > > by exclusive #ifdefs:
> > > * FSL_BOOKE: several directory entries points to the same single
> > > hugepage
> > > * BOOK3S: one upper level directory entry points to a table of hugepages
> > > 
> > > In preparation of implementation of hugepage support on the 8xx, we
> > > need a mix of the two above solutions, because the 8xx needs both cases
> > > depending on the size of pages:
> > > * In 4k page size mode, each PGD entry covers a 4M bytes area. It means
> > > that 2 PGD entries will be necessary to cover an 8M hugepage while a
> > > single PGD entry will cover 8x 512k hugepages.
> > > * In 16 page size mode, each PGD entry covers a 64M bytes area. It means
> > > that 8x 8M hugepages will be covered by one PGD entry and 64x 512k
> > > hugepages will be covers by one PGD entry.
> > > 
> > > This patch:
> > > * removes #ifdefs in favor of if/else based on the range sizes
> > > * merges the two huge_pte_alloc() functions as they are pretty similar
> > > * merges the two hugetlbpage_init() functions as they are pretty similar
> > [snip]
> > > 
> > > @@ -860,16 +803,34 @@ static int __init hugetlbpage_init(void)
> > >  		 * if we have pdshift and shift value same, we don't
> > >  		 * use pgt cache for hugepd.
> > >  		 */
> > > -		if (pdshift != shift) {
> > > +		if (pdshift > shift) {
> > >  			pgtable_cache_add(pdshift - shift, NULL);
> > >  			if (!PGT_CACHE(pdshift - shift))
> > >  				panic("hugetlbpage_init(): could not
> > > create
> > > "
> > >  				      "pgtable cache for %d bit
> > > pagesize\n", shift);
> > >  		}
> > > +#ifdef CONFIG_PPC_FSL_BOOK3E
> > > +		else if (!hugepte_cache) {
> > This else never triggers on book3e, because the way this function
> > calculates
> > pdshift is wrong for book3e (it uses PyD_SHIFT instead of
> > HUGEPD_PxD_SHIFT).
> >  We later get OOMs because huge_pte_alloc() calculates pdshift correctly,
> > tries to use hugepte_cache, and fails.
> Ok, I'll check it again, I was expecting it to still work properly on 
> book3e, because after applying patch 3 it works properly on the 8xx.

On 8xx you probably happen to have a page size that yields "pdshift <= shift"
even with the incorrect pdshift calculation, causing hugepte_cache to be
allocated.  The smallest hugepage size on 8xx is 512k compared to 4M on fsl-
book3e.

-Scott

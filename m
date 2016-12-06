Return-Path: <oss@buserror.net>
Received: from host.buserror.net (host.buserror.net [209.198.135.123])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tXkKq2Pl9zDvb1
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  6 Dec 2016 12:18:55 +1100 (AEDT)
Message-ID: <1480987116.32531.17.camel@buserror.net>
From: Scott Wood <oss@buserror.net>
To: Christophe Leroy <christophe.leroy@c-s.fr>, Benjamin Herrenschmidt
 <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Michael
 Ellerman <mpe@ellerman.id.au>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date: Mon, 05 Dec 2016 19:18:36 -0600
In-Reply-To: <69b1226ce134761fd7ab81a498bdb85cd737280f.1474441302.git.christophe.leroy@c-s.fr>
References: <cover.1474441301.git.christophe.leroy@c-s.fr>
 <69b1226ce134761fd7ab81a498bdb85cd737280f.1474441302.git.christophe.leroy@c-s.fr>
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

On Wed, 2016-09-21 at 10:11 +0200, Christophe Leroy wrote:
> Today there are two implementations of hugetlbpages which are managed
> by exclusive #ifdefs:
> * FSL_BOOKE: several directory entries points to the same single hugepage
> * BOOK3S: one upper level directory entry points to a table of hugepages
> 
> In preparation of implementation of hugepage support on the 8xx, we
> need a mix of the two above solutions, because the 8xx needs both cases
> depending on the size of pages:
> * In 4k page size mode, each PGD entry covers a 4M bytes area. It means
> that 2 PGD entries will be necessary to cover an 8M hugepage while a
> single PGD entry will cover 8x 512k hugepages.
> * In 16 page size mode, each PGD entry covers a 64M bytes area. It means
> that 8x 8M hugepages will be covered by one PGD entry and 64x 512k
> hugepages will be covers by one PGD entry.
> 
> This patch:
> * removes #ifdefs in favor of if/else based on the range sizes
> * merges the two huge_pte_alloc() functions as they are pretty similar
> * merges the two hugetlbpage_init() functions as they are pretty similar
[snip]
> @@ -860,16 +803,34 @@ static int __init hugetlbpage_init(void)
>  		 * if we have pdshift and shift value same, we don't
>  		 * use pgt cache for hugepd.
>  		 */
> -		if (pdshift != shift) {
> +		if (pdshift > shift) {
>  			pgtable_cache_add(pdshift - shift, NULL);
>  			if (!PGT_CACHE(pdshift - shift))
>  				panic("hugetlbpage_init(): could not create
> "
>  				      "pgtable cache for %d bit
> pagesize\n", shift);
>  		}
> +#ifdef CONFIG_PPC_FSL_BOOK3E
> +		else if (!hugepte_cache) {

This else never triggers on book3e, because the way this function calculates
pdshift is wrong for book3e (it uses PyD_SHIFT instead of HUGEPD_PxD_SHIFT).
 We later get OOMs because huge_pte_alloc() calculates pdshift correctly,
tries to use hugepte_cache, and fails.

If the point of this patch is to remove the compile-time decision on whether
to do things the book3e way, why are there still ifdefs such as the ones
controlling the definition of HUGEPD_PxD_SHIFT?  How does what you're doing on
8xx (for certain page sizes) differ from book3e?

-Scott

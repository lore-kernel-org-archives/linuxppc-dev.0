Return-Path: <schwidefsky@de.ibm.com>
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id C3A621A0359
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 24 Feb 2016 19:39:25 +1100 (AEDT)
Received: from localhost
 by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <schwidefsky@de.ibm.com>;
 Wed, 24 Feb 2016 08:39:21 -0000
Received: from b06cxnps4076.portsmouth.uk.ibm.com
 (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
 by d06dlp03.portsmouth.uk.ibm.com (Postfix) with ESMTP id 202241B08061
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 24 Feb 2016 08:39:38 +0000 (GMT)
Received: from d06av06.portsmouth.uk.ibm.com (d06av06.portsmouth.uk.ibm.com
 [9.149.37.217])
 by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u1O8dINI5898524
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 24 Feb 2016 08:39:18 GMT
Received: from d06av06.portsmouth.uk.ibm.com (localhost [127.0.0.1])
 by d06av06.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u1O8dGUn007277
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 24 Feb 2016 03:39:18 -0500
Date: Wed, 24 Feb 2016 09:39:15 +0100
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
To: "Kirill A. Shutemov" <kirill@shutemov.name>
Cc: Gerald Schaefer <gerald.schaefer@de.ibm.com>, Christian Borntraeger
 <borntraeger@de.ibm.com>, "Kirill A. Shutemov"
 <kirill.shutemov@linux.intel.com>,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org, "Aneesh Kumar K.V"
 <aneesh.kumar@linux.vnet.ibm.com>, Andrew Morton
 <akpm@linux-foundation.org>, Linus Torvalds
 <torvalds@linux-foundation.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras
 <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org, Catalin Marinas
 <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>,
 linux-arm-kernel@lists.infradead.org, Heiko Carstens
 <heiko.carstens@de.ibm.com>, linux-s390@vger.kernel.org, Sebastian Ott
 <sebott@linux.vnet.ibm.com>
Subject: Re: [BUG] random kernel crashes after THP rework on s390 (maybe
 also on PowerPC and ARM)
Message-ID: <20160224093915.6e163a33@mschwide>
In-Reply-To: <20160223193345.GC21820@node.shutemov.name>
References: <20160211192223.4b517057@thinkpad>
 <20160211190942.GA10244@node.shutemov.name>
 <20160211205702.24f0d17a@thinkpad>
 <20160212154116.GA15142@node.shutemov.name>
 <56BE00E7.1010303@de.ibm.com> <20160212181640.4eabb85f@thinkpad>
 <20160223103221.GA1418@node.shutemov.name>
 <20160223191907.25719a4d@thinkpad>
 <20160223193345.GC21820@node.shutemov.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 23 Feb 2016 22:33:45 +0300
"Kirill A. Shutemov" <kirill@shutemov.name> wrote:

> On Tue, Feb 23, 2016 at 07:19:07PM +0100, Gerald Schaefer wrote:
> > I'll check with Martin, maybe it is actually trivial, then we can
> > do a quick test it to rule that one out.
> 
> Oh. I found a bug in __split_huge_pmd_locked(). Although, not sure if it's
> _the_ bug.
> 
> pmdp_invalidate() is called for the wrong address :-/
> I guess that can be destructive on the architecture, right?
> 
> Could you check this?
> 
> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> index 1c317b85ea7d..4246bc70e55a 100644
> --- a/mm/huge_memory.c
> +++ b/mm/huge_memory.c
> @@ -2865,7 +2865,7 @@ static void __split_huge_pmd_locked(struct vm_area_struct *vma, pmd_t *pmd,
>  	pgtable = pgtable_trans_huge_withdraw(mm, pmd);
>  	pmd_populate(mm, &_pmd, pgtable);
> 
> -	for (i = 0; i < HPAGE_PMD_NR; i++, haddr += PAGE_SIZE) {
> +	for (i = 0; i < HPAGE_PMD_NR; i++) {
>  		pte_t entry, *pte;
>  		/*
>  		 * Note that NUMA hinting access restrictions are not
> @@ -2886,9 +2886,9 @@ static void __split_huge_pmd_locked(struct vm_area_struct *vma, pmd_t *pmd,
>  		}
>  		if (dirty)
>  			SetPageDirty(page + i);
> -		pte = pte_offset_map(&_pmd, haddr);
> +		pte = pte_offset_map(&_pmd, haddr + i * PAGE_SIZE);
>  		BUG_ON(!pte_none(*pte));
> -		set_pte_at(mm, haddr, pte, entry);
> +		set_pte_at(mm, haddr + i * PAGE_SIZE, pte, entry);
>  		atomic_inc(&page[i]._mapcount);
>  		pte_unmap(pte);
>  	}
> @@ -2938,7 +2938,7 @@ static void __split_huge_pmd_locked(struct vm_area_struct *vma, pmd_t *pmd,
>  	pmd_populate(mm, pmd, pgtable);
> 
>  	if (freeze) {
> -		for (i = 0; i < HPAGE_PMD_NR; i++, haddr += PAGE_SIZE) {
> +		for (i = 0; i < HPAGE_PMD_NR; i++) {
>  			page_remove_rmap(page + i, false);
>  			put_page(page + i);
>  		}

Test is running and it looks good so far. For the final assessment I defer
to Gerald and Sebastian.

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.

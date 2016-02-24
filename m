Return-Path: <sebott@linux.vnet.ibm.com>
Received: from e06smtp14.uk.ibm.com (e06smtp14.uk.ibm.com [195.75.94.110])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4C19A1A03B8
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 24 Feb 2016 23:12:06 +1100 (AEDT)
Received: from localhost
 by e06smtp14.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <sebott@linux.vnet.ibm.com>;
 Wed, 24 Feb 2016 12:12:03 -0000
Received: from b06cxnps3074.portsmouth.uk.ibm.com
 (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
 by d06dlp03.portsmouth.uk.ibm.com (Postfix) with ESMTP id 712711B0804B
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 24 Feb 2016 12:12:20 +0000 (GMT)
Received: from d06av10.portsmouth.uk.ibm.com (d06av10.portsmouth.uk.ibm.com
 [9.149.37.251])
 by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u1OCC0eK63504422
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 24 Feb 2016 12:12:00 GMT
Received: from d06av10.portsmouth.uk.ibm.com (localhost [127.0.0.1])
 by d06av10.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u1OBC08V003113
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 24 Feb 2016 04:12:02 -0700
Date: Wed, 24 Feb 2016 13:11:58 +0100 (CET)
From: Sebastian Ott <sebott@linux.vnet.ibm.com>
To: Martin Schwidefsky <schwidefsky@de.ibm.com>
cc: "Kirill A. Shutemov" <kirill@shutemov.name>,
 Gerald Schaefer <gerald.schaefer@de.ibm.com>,
 Christian Borntraeger <borntraeger@de.ibm.com>,
 "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Michael Ellerman <mpe@ellerman.id.au>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org,
 Catalin Marinas <catalin.marinas@arm.com>,
 Will Deacon <will.deacon@arm.com>, linux-arm-kernel@lists.infradead.org,
 Heiko Carstens <heiko.carstens@de.ibm.com>, linux-s390@vger.kernel.org
Subject: Re: [BUG] random kernel crashes after THP rework on s390 (maybe also
 on PowerPC and ARM)
In-Reply-To: <20160224093915.6e163a33@mschwide>
Message-ID: <alpine.LFD.2.20.1602241307130.1533@schleppi>
References: <20160211192223.4b517057@thinkpad>
 <20160211190942.GA10244@node.shutemov.name>
 <20160211205702.24f0d17a@thinkpad>
 <20160212154116.GA15142@node.shutemov.name> <56BE00E7.1010303@de.ibm.com>
 <20160212181640.4eabb85f@thinkpad> <20160223103221.GA1418@node.shutemov.name>
 <20160223191907.25719a4d@thinkpad> <20160223193345.GC21820@node.shutemov.name>
 <20160224093915.6e163a33@mschwide>
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

On Wed, 24 Feb 2016, Martin Schwidefsky wrote:
> On Tue, 23 Feb 2016 22:33:45 +0300
> "Kirill A. Shutemov" <kirill@shutemov.name> wrote:
> 
> > On Tue, Feb 23, 2016 at 07:19:07PM +0100, Gerald Schaefer wrote:
> > > I'll check with Martin, maybe it is actually trivial, then we can
> > > do a quick test it to rule that one out.
> > 
> > Oh. I found a bug in __split_huge_pmd_locked(). Although, not sure if it's
> > _the_ bug.
> > 
> > pmdp_invalidate() is called for the wrong address :-/
> > I guess that can be destructive on the architecture, right?
> > 
> > Could you check this?
> > 
> > diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> > index 1c317b85ea7d..4246bc70e55a 100644
> > --- a/mm/huge_memory.c
> > +++ b/mm/huge_memory.c
> > @@ -2865,7 +2865,7 @@ static void __split_huge_pmd_locked(struct vm_area_struct *vma, pmd_t *pmd,
> >  	pgtable = pgtable_trans_huge_withdraw(mm, pmd);
> >  	pmd_populate(mm, &_pmd, pgtable);
> > 
> > -	for (i = 0; i < HPAGE_PMD_NR; i++, haddr += PAGE_SIZE) {
> > +	for (i = 0; i < HPAGE_PMD_NR; i++) {
> >  		pte_t entry, *pte;
> >  		/*
> >  		 * Note that NUMA hinting access restrictions are not
> > @@ -2886,9 +2886,9 @@ static void __split_huge_pmd_locked(struct vm_area_struct *vma, pmd_t *pmd,
> >  		}
> >  		if (dirty)
> >  			SetPageDirty(page + i);
> > -		pte = pte_offset_map(&_pmd, haddr);
> > +		pte = pte_offset_map(&_pmd, haddr + i * PAGE_SIZE);
> >  		BUG_ON(!pte_none(*pte));
> > -		set_pte_at(mm, haddr, pte, entry);
> > +		set_pte_at(mm, haddr + i * PAGE_SIZE, pte, entry);
> >  		atomic_inc(&page[i]._mapcount);
> >  		pte_unmap(pte);
> >  	}
> > @@ -2938,7 +2938,7 @@ static void __split_huge_pmd_locked(struct vm_area_struct *vma, pmd_t *pmd,
> >  	pmd_populate(mm, pmd, pgtable);
> > 
> >  	if (freeze) {
> > -		for (i = 0; i < HPAGE_PMD_NR; i++, haddr += PAGE_SIZE) {
> > +		for (i = 0; i < HPAGE_PMD_NR; i++) {
> >  			page_remove_rmap(page + i, false);
> >  			put_page(page + i);
> >  		}
> 
> Test is running and it looks good so far. For the final assessment I defer
> to Gerald and Sebastian.
> 

Yes, that one worked. My testsystem is doing make -j10 && make clean
in a loop since 4 hours now. Thanks!

Sebastian

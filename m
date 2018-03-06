Return-Path: <npiggin@gmail.com>
Received: from mail-pg0-x244.google.com (mail-pg0-x244.google.com
 [IPv6:2607:f8b0:400e:c05::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zwtSj6BGvzF1Wh
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  7 Mar 2018 10:36:05 +1100 (AEDT)
Received: by mail-pg0-x244.google.com with SMTP id g8so166527pgv.7
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 06 Mar 2018 15:36:05 -0800 (PST)
Date: Wed, 7 Mar 2018 09:35:53 +1000
From: Nicholas Piggin <npiggin@gmail.com>
To: Christophe LEROY <christophe.leroy@c-s.fr>
Cc: linuxppc-dev@lists.ozlabs.org, "Aneesh Kumar K . V"
 <aneesh.kumar@linux.vnet.ibm.com>
Subject: Re: [PATCH 10/10] powerpc/mm/slice: remove radix calls to the slice
 code
Message-ID: <20180307093553.4fb0191c@roar.ozlabs.ibm.com>
In-Reply-To: <01d94f39-91fc-53c4-79ad-b43b3234c2ea@c-s.fr>
References: <20180306132507.10649-1-npiggin@gmail.com>
 <20180306132507.10649-11-npiggin@gmail.com>
 <01d94f39-91fc-53c4-79ad-b43b3234c2ea@c-s.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 6 Mar 2018 16:12:34 +0100
Christophe LEROY <christophe.leroy@c-s.fr> wrote:

> Le 06/03/2018 à 14:25, Nicholas Piggin a écrit :
> > This is a tidy up which removes radix MMU calls into the slice
> > code.
> > 
> > Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> > ---
> >   arch/powerpc/include/asm/hugetlb.h |  9 ++++++---
> >   arch/powerpc/mm/hugetlbpage.c      |  5 +++--
> >   arch/powerpc/mm/slice.c            | 17 ++++-------------
> >   3 files changed, 13 insertions(+), 18 deletions(-)
> > 
> > diff --git a/arch/powerpc/include/asm/hugetlb.h b/arch/powerpc/include/asm/hugetlb.h
> > index 1a4847f67ea8..59885d444695 100644
> > --- a/arch/powerpc/include/asm/hugetlb.h
> > +++ b/arch/powerpc/include/asm/hugetlb.h
> > @@ -90,16 +90,19 @@ pte_t *huge_pte_offset_and_shift(struct mm_struct *mm,
> >   void flush_dcache_icache_hugepage(struct page *page);
> >   
> >   #if defined(CONFIG_PPC_MM_SLICES)
> > -int is_hugepage_only_range(struct mm_struct *mm, unsigned long addr,
> > +int slice_is_hugepage_only_range(struct mm_struct *mm, unsigned long addr,
> >   			   unsigned long len);
> > -#else
> > +#endif
> >   static inline int is_hugepage_only_range(struct mm_struct *mm,
> >   					 unsigned long addr,
> >   					 unsigned long len)
> >   {
> > +#if defined(CONFIG_PPC_MM_SLICES)
> > +	if (!radix_enabled())
> > +		return slice_is_hugepage_only_range(mm, addr, len);
> > +#endif
> >   	return 0;  
> 
> Might be easier to understand as
> 
> 	if (!IS_ENABLED(CONFIG_PPC_MM_SLICES) || radix_enabled())
> 		return 0;
> 	return slice_is_hugepage_only_range(mm, addr, len);

Yep.


> >   unsigned long vma_mmu_pagesize(struct vm_area_struct *vma)
> >   {
> >   #ifdef CONFIG_PPC_MM_SLICES
> > -	unsigned int psize = get_slice_psize(vma->vm_mm, vma->vm_start);
> >   	/* With radix we don't use slice, so derive it from vma*/
> > -	if (!radix_enabled())
> > +	if (!radix_enabled()) {
> > +		unsigned int psize = get_slice_psize(vma->vm_mm, vma->vm_start);  
> 
> Insert a blank line here.

Okay.

Thanks for the review, it's really appreciated.

Thanks,
Nick

Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41x2nQ2NJHzF2Dd
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 23 Aug 2018 21:51:37 +1000 (AEST)
Message-ID: <123ac03b1e446ea31fa908b734a5f778e4bf03cf.camel@kernel.crashing.org>
Subject: Re: [PATCH 2/2] powerpc/mm/hash: Only need the Nest MMU workaround
 for R -> RW transition
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Nicholas Piggin <npiggin@gmail.com>, "Aneesh Kumar K.V"
 <aneesh.kumar@linux.ibm.com>
Cc: paulus@samba.org, mpe@ellerman.id.au, linuxppc-dev@lists.ozlabs.org
Date: Thu, 23 Aug 2018 21:51:19 +1000
In-Reply-To: <20180823192319.5f06041f@roar.ozlabs.ibm.com>
References: <20180822171605.15054-1-aneesh.kumar@linux.ibm.com>
 <20180822171605.15054-2-aneesh.kumar@linux.ibm.com>
 <20180823192319.5f06041f@roar.ozlabs.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2018-08-23 at 19:23 +1000, Nicholas Piggin wrote:
> On Wed, 22 Aug 2018 22:46:05 +0530
> "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com> wrote:
> 
> > The Nest MMU workaround is only needed for RW upgrades. Avoid doing that
> > for other pte updates.
> > 
> > We also avoid clearing the pte while marking it invalid. This is because other
> > page table walk will find this pte none and can result in unexpected behaviour
> > due to that. Instead we clear _PAGE_PRESENT and set the software pte bit
> > _PAGE_INVALID. pte_present is already updated to check for bot the bits. This
> > make sure page table walkers will find the pte present and things like
> > pte_pfn(pte) returns the right value.
> > 
> > Based on the original patch from Benjamin Herrenschmidt <benh@kernel.crashing.org>
> > 
> > Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
> > ---
> >  arch/powerpc/mm/pgtable-radix.c | 8 +++++---
> 
> This is powerpc/mm/radix, isn't it? Subject says hash.
> 
> Could we make this fix POWER9 only and use a RSV bit for it
> rather than use up a SW bit? Other than that,

Well, the SW bit is necessary for THP as well isn't it ?
> 
> Reviewed-by: Nicholas Piggin <npiggin@gmail.com>
> 
> >  1 file changed, 5 insertions(+), 3 deletions(-)
> > 
> > diff --git a/arch/powerpc/mm/pgtable-radix.c b/arch/powerpc/mm/pgtable-radix.c
> > index 7be99fd9af15..c879979faa73 100644
> > --- a/arch/powerpc/mm/pgtable-radix.c
> > +++ b/arch/powerpc/mm/pgtable-radix.c
> > @@ -1045,20 +1045,22 @@ void radix__ptep_set_access_flags(struct vm_area_struct *vma, pte_t *ptep,
> >  	struct mm_struct *mm = vma->vm_mm;
> >  	unsigned long set = pte_val(entry) & (_PAGE_DIRTY | _PAGE_ACCESSED |
> >  					      _PAGE_RW | _PAGE_EXEC);
> > +
> > +	unsigned long change = pte_val(entry) ^ pte_val(*ptep);
> >  	/*
> >  	 * To avoid NMMU hang while relaxing access, we need mark
> >  	 * the pte invalid in between.
> >  	 */
> > -	if (atomic_read(&mm->context.copros) > 0) {
> > +	if ((change & _PAGE_RW) && atomic_read(&mm->context.copros) > 0) {
> >  		unsigned long old_pte, new_pte;
> >  
> > -		old_pte = __radix_pte_update(ptep, ~0, 0);
> > +		old_pte = __radix_pte_update(ptep, _PAGE_PRESENT, _PAGE_INVALID);
> >  		/*
> >  		 * new value of pte
> >  		 */
> >  		new_pte = old_pte | set;
> >  		radix__flush_tlb_page_psize(mm, address, psize);
> > -		__radix_pte_update(ptep, 0, new_pte);
> > +		__radix_pte_update(ptep, _PAGE_INVALID, new_pte);
> >  	} else {
> >  		__radix_pte_update(ptep, 0, set);
> >  		/*

Return-Path: <marcelo.tosatti@cyclades.com>
Received: from hera.kernel.org (hera.kernel.org [140.211.167.34])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id BD3B3686AF
	for <linuxppc-embedded@ozlabs.org>;
	Tue,  8 Nov 2005 00:45:15 +1100 (EST)
Date: Mon, 7 Nov 2005 06:44:31 -0200
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: Pantelis Antoniou <pantelis.antoniou@gmail.com>
Message-ID: <20051107084431.GA15180@logos.cnet>
References: <200510302203.25390.pantelis.antoniou@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <200510302203.25390.pantelis.antoniou@gmail.com>
Cc: Dan Malek <dan@embeddedalley.com>, linuxppc-embedded@ozlabs.org
Subject: Re: [PATCH 2.6.14] mm: 8xx MM fix for
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi folks,

Seems the bug is exposed by the change which avoids flushing the
TLB when not necessary (in case the pte has not changed), introduced
recently:

__handle_mm_fault():

        entry = pte_mkyoung(entry);
        if (!pte_same(old_entry, entry)) {
                ptep_set_access_flags(vma, address, pte, entry, write_access);
                update_mmu_cache(vma, address, entry);
                lazy_mmu_prot_update(entry);
        } else {
                /*
                 * This is needed only for protection faults but the arch code
                 * is not yet telling us if this is a protection fault or not.
                 * This still avoids useless tlb flushes for .text page faults
                 * with threads.
                 */
                if (write_access)
                        flush_tlb_page(vma, address);
        }

The "update_mmu_cache()" call was unconditional before, which caused the TLB
to be flushed by:

        if (pfn_valid(pfn)) {
                struct page *page = pfn_to_page(pfn);
                if (!PageReserved(page)
                    && !test_bit(PG_arch_1, &page->flags)) {
                        if (vma->vm_mm == current->active_mm) {
#ifdef CONFIG_8xx
                        /* On 8xx, cache control instructions (particularly 
                         * "dcbst" from flush_dcache_icache) fault as write 
                         * operation if there is an unpopulated TLB entry 
                         * for the address in question. To workaround that, 
                         * we invalidate the TLB here, thus avoiding dcbst 
                         * misbehaviour.
                         */
                                _tlbie(address);
#endif
                                __flush_dcache_icache((void *) address);
                        } else
                                flush_dcache_icache_page(page);
                        set_bit(PG_arch_1, &page->flags);
                }

Which worked to due to pure luck: PG_arch_1 was always unset before, but
now it isnt.

The root of the problem are the changes against the 8xx TLB handlers introduced
during v2.6. What happens is the TLBMiss handlers load the zeroed pte into
the TLB, causing the TLBError handler to be invoked (thats two TLB faults per 
pagefault), which then jumps to the generic MM code to setup the pte.

The bug is that the zeroed TLB is not invalidated (the same reason
for the "dcbst" misbehaviour), resulting in infinite TLBError faults.

Dan, I wonder why we just don't go back to v2.4 behaviour. It is not very
clear to me that "two exception" speedup offsets the additional code required
for "one exception" version. Have you actually done any measurements? 

There is chance that the additional code ends up in the same cacheline,
which would mean no huge gain by the "two exception" approach. Might be
even harmful for performance (you need two exceptions instead of one
after all).

The "two exception" approach requires a TLB flush (to nuke the zeroed)
at each PTE update for correct behaviour (which BTW is another slowdown):

--- ../git/linux-2.6/arch/ppc/mm/init.c	2005-11-01 07:58:12.000000000 -0600
+++ linux-2.6-git-wednov02/arch/ppc/mm/init.c	2005-11-07 06:13:58.000000000 -0600
@@ -597,19 +597,12 @@
 
 	if (pfn_valid(pfn)) {
 		struct page *page = pfn_to_page(pfn);
+#ifdef CONFIG_8xx
+		_tlbie(address);
+#endif
 		if (!PageReserved(page)
 		    && !test_bit(PG_arch_1, &page->flags)) {
 			if (vma->vm_mm == current->active_mm) {
-#ifdef CONFIG_8xx
-			/* On 8xx, cache control instructions (particularly 
-		 	 * "dcbst" from flush_dcache_icache) fault as write 
-			 * operation if there is an unpopulated TLB entry 
-			 * for the address in question. To workaround that, 
-			 * we invalidate the TLB here, thus avoiding dcbst 
-			 * misbehaviour.
-			 */
-				_tlbie(address);
-#endif
 				__flush_dcache_icache((void *) address);
 			} else
 				flush_dcache_icache_page(page);


On Sun, Oct 30, 2005 at 11:03:24PM +0300, Pantelis Antoniou wrote:
> Latest MMU changes caused 8xx to stop working. Flushing tlb of the faulting
> address fixes the problem.
> 
> ---
> commit 978e2f36b1ae53e37ba27b3ab8f1c5ddbb8c8a10
> tree 7dd0e403c240162b1925db0834d694f4b4a0e95e
> parent ca02ea5aebcda886d1552c6af73ca96c02bf9fed
> author Pantelis Antoniou <panto@pantathon> Sun, 30 Oct 2005 21:53:48 +0200
> committer Pantelis Antoniou <panto@pantathon> Sun, 30 Oct 2005 21:53:48 +0200
> 
>  arch/ppc/mm/fault.c |   13 +++++++++++++
>  1 files changed, 13 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/ppc/mm/fault.c b/arch/ppc/mm/fault.c
> --- a/arch/ppc/mm/fault.c
> +++ b/arch/ppc/mm/fault.c
> @@ -240,6 +240,19 @@ good_area:
>  			goto bad_area;
>  		if (!(vma->vm_flags & (VM_READ | VM_EXEC)))
>  			goto bad_area;
> +
> +#ifdef CONFIG_8xx
> +		{
> +		/* 8xx is retarded; news at 11 */
> +		pte_t *ptep = NULL;
> +
> +		if (get_pteptr(mm, address, &ptep) && pte_present(*ptep))
> +			_tlbie(address);
> +
> +		if (ptep != NULL)
> +			pte_unmap(ptep);
> +		}
> +#endif
>  	}
>  
>  	/*

Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 62B531A024F
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 28 May 2014 19:27:21 +1000 (EST)
Received: from e23smtp04.au.ibm.com (e23smtp04.au.ibm.com [202.81.31.146])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3431E1400CF
 for <linuxppc-dev@ozlabs.org>; Wed, 28 May 2014 19:27:21 +1000 (EST)
Received: from /spool/local
 by e23smtp04.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Wed, 28 May 2014 19:27:17 +1000
Received: from d23relay03.au.ibm.com (d23relay03.au.ibm.com [9.190.235.21])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id E4E942BB0047
 for <linuxppc-dev@ozlabs.org>; Wed, 28 May 2014 19:27:14 +1000 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay03.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s4S9Qxuu7471470
 for <linuxppc-dev@ozlabs.org>; Wed, 28 May 2014 19:26:59 +1000
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s4S9REj5003582
 for <linuxppc-dev@ozlabs.org>; Wed, 28 May 2014 19:27:14 +1000
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@ozlabs.org
Subject: Re: [PATCH 1/2] powerpc/mm: Check paca psize is up to date for huge
 mappings
In-Reply-To: <1401265278-29307-1-git-send-email-mpe@ellerman.id.au>
References: <1401265278-29307-1-git-send-email-mpe@ellerman.id.au>
Date: Wed, 28 May 2014 14:57:02 +0530
Message-ID: <8761kqmexl.fsf@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: aneesh.kumar@in.ibm.com, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Michael Ellerman <mpe@ellerman.id.au> writes:

> We have a bug in our hugepage handling which exhibits as an infinite
> loop of hash faults. If the fault is being taken in the kernel it will
> typically trigger the softlockup detector, or the RCU stall detector.
>
> The bug is as follows:
>
>  1. mmap(0xa0000000, ..., MAP_FIXED | MAP_HUGE_TLB | MAP_ANONYMOUS ..)
>  2. Slice code converts the slice psize to 16M.
>  3. The code on lines 539-540 of slice.c in slice_get_unmapped_area()
>     synchronises the mm->context with the paca->context. So the paca slice
>     mask is updated to include the 16M slice.
>  3. Either:
>     * mmap() fails because there are no huge pages available.
>     * mmap() succeeds and the mapping is then munmapped.
>     In both cases the slice psize remains at 16M in both the paca & mm.
>  4. mmap(0xa0000000, ..., MAP_FIXED | MAP_ANONYMOUS ..)
>  5. The slice psize is converted back to 64K. Because of the check on line 539
>     of slice.c we DO NOT update the paca->context. The paca slice mask is now
>     out of sync with the mm slice mask.
>  6. User/kernel accesses 0xa0000000.
>  7. The SLB miss handler slb_allocate_realmode() **uses the paca slice mask**
>     to create an SLB entry and inserts it in the SLB.
> 18. With the 16M SLB entry in place the hardware does a hash lookup, no entry
>     is found so a data access exception is generated.
> 19. The data access handler calls do_page_fault() -> handle_mm_fault().
> 10. __handle_mm_fault() creates a THP mapping with do_huge_pmd_anonymous_page().
> 11. The hardware retries the access, there is still nothing in the hash table
>     so once again a data access exception is generated.
> 12. hash_page() calls into __hash_page_thp() and inserts a mapping in the
>     hash. Although the THP mapping maps 16M the hashing is done using 64K
>     as the segment page size.
> 13. hash_page() returns immediately after calling __hash_page_thp(), skipping
>     over the code at line 1125. Resulting in the mismatch between the
>     paca->context and mm->context not being detected.
> 14. The hardware retries the access, the hash it generates using the 16M
>     SLB entry does NOT match the hash we inserted.
> 15. We take another data access and go into __hash_page_thp().
> 16. We see a valid entry in the hpte_slot_array and so we call updatepp()
>     which succeeds.
> 17. Goto 14.
>
> We could fix this in two ways. The first would be to remove or modify
> the check on line 539 of slice.c.
>
> The second option is to cause the check of paca psize in hash_page() on
> line 1125 to also be done for THP pages.
>
> We prefer the latter, because the check & update of the paca psize is
> not done until we know it's necessary. It's also done only on the
> current cpu, so we don't need to IPI all other cpus.
>
> Without further rearranging the code, the simplest fix is to pull out
> the code that checks paca psize and call it in two places. Firstly for
> THP/hugetlb, and secondly for other mappings as before.
>
> Thanks to Dave Jones for trinity, which originally found this bug.
>
> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>

Reviewed-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>

> ---
>  arch/powerpc/mm/hash_utils_64.c | 31 ++++++++++++++++++++-----------
>  1 file changed, 20 insertions(+), 11 deletions(-)
>
> diff --git a/arch/powerpc/mm/hash_utils_64.c b/arch/powerpc/mm/hash_utils_64.c
> index d766d6e..6650699 100644
> --- a/arch/powerpc/mm/hash_utils_64.c
> +++ b/arch/powerpc/mm/hash_utils_64.c
> @@ -960,6 +960,22 @@ void hash_failure_debug(unsigned long ea, unsigned long access,
>  		trap, vsid, ssize, psize, lpsize, pte);
>  }
>  
> +static void check_paca_psize(unsigned long ea, struct mm_struct *mm,
> +			     int psize, bool user_region)
> +{
> +	if (user_region) {
> +		if (psize != get_paca_psize(ea)) {
> +			get_paca()->context = mm->context;
> +			slb_flush_and_rebolt();
> +		}
> +	} else if (get_paca()->vmalloc_sllp !=
> +		   mmu_psize_defs[mmu_vmalloc_psize].sllp) {
> +		get_paca()->vmalloc_sllp =
> +			mmu_psize_defs[mmu_vmalloc_psize].sllp;
> +		slb_vmalloc_update();
> +	}
> +}
> +
>  /* Result code is:
>   *  0 - handled
>   *  1 - normal page fault
> @@ -1081,6 +1097,8 @@ int hash_page(unsigned long ea, unsigned long access, unsigned long trap)
>  			WARN_ON(1);
>  		}
>  #endif
> +		check_paca_psize(ea, mm, psize, user_region);
> +
>  		goto bail;
>  	}
>  
> @@ -1121,17 +1139,8 @@ int hash_page(unsigned long ea, unsigned long access, unsigned long trap)
>  #endif
>  		}
>  	}
> -	if (user_region) {
> -		if (psize != get_paca_psize(ea)) {
> -			get_paca()->context = mm->context;
> -			slb_flush_and_rebolt();
> -		}
> -	} else if (get_paca()->vmalloc_sllp !=
> -		   mmu_psize_defs[mmu_vmalloc_psize].sllp) {
> -		get_paca()->vmalloc_sllp =
> -			mmu_psize_defs[mmu_vmalloc_psize].sllp;
> -		slb_vmalloc_update();
> -	}
> +
> +	check_paca_psize(ea, mm, psize, user_region);
>  #endif /* CONFIG_PPC_64K_PAGES */
>  
>  #ifdef CONFIG_PPC_HAS_HASH_64K
> -- 
> 1.9.1
>
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev

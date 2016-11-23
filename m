Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tP4dj4tFzzDw9P
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 24 Nov 2016 01:36:09 +1100 (AEDT)
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
 uANEYHu1023303
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 Nov 2016 09:36:07 -0500
Received: from e33.co.us.ibm.com (e33.co.us.ibm.com [32.97.110.151])
 by mx0b-001b2d01.pphosted.com with ESMTP id 26w8vj826w-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 Nov 2016 09:36:06 -0500
Received: from localhost
 by e33.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Wed, 23 Nov 2016 07:36:06 -0700
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: Balbir Singh <bsingharora@gmail.com>, benh@kernel.crashing.org,
 paulus@samba.org, mpe@ellerman.id.au
Cc: linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v5 1/7] powerpc/mm: update ptep_set_access_flag to not do
 full mm tlb flush
In-Reply-To: <248c0fa0-4094-429c-fa3b-1a53c75bcfbe@gmail.com>
References: <20161123111003.459-1-aneesh.kumar@linux.vnet.ibm.com>
 <fe12e986-0c81-a71c-29a2-a8ca4ea2600c@gmail.com>
 <87y40ah0pa.fsf@linux.vnet.ibm.com>
 <248c0fa0-4094-429c-fa3b-1a53c75bcfbe@gmail.com>
Date: Wed, 23 Nov 2016 20:06:00 +0530
MIME-Version: 1.0
Content-Type: text/plain
Message-Id: <87shqigt67.fsf@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Balbir Singh <bsingharora@gmail.com> writes:

> On 23/11/16 22:53, Aneesh Kumar K.V wrote:
>> Balbir Singh <bsingharora@gmail.com> writes:
>> 
>>> On 23/11/16 22:09, Aneesh Kumar K.V wrote:
>>>> When we are updating pte, we just need to flush the tlb mapping for
>>>> that pte. Right now we do a full mm flush because we don't track page
>>>> size. Update the interface to track the page size and use that to
>>>> do the right tlb flush.
>>>>
>>>
>>> Could you also clarify the scope -- this seems to be _radix_ only.
>>> The problem statement is not very clear and why doesn't the flush_tlb_page()
>>> following ptep_set_access_flags() work? What else do we need to do?
>> 
>> Yes it modifies only radix part.  Don't understand the flush_tlb_page()
>> part of the comment above. We are modifying the tlbflush that we need to do in the pte update
>> sequence for DD1. ie, we need to do the flush before we can set the pte
>> with new value.
>> 
>> Also in this specific case, we can idealy drop that flush_tlb_page,
>> because relaxing an access really don't need a tlb flush from generic
>> architecture point of view. I left it there to make sure, we measure and
>> get the invalidate path correct before going ahead with that
>> optimization.
>> 
>
> OK.. here is my untested solution. I've only compiled it.
> It breaks the 64/hash/radix abstractions, but it makes the
> changes much simpler
>
> Signed-off-by: Balbir Singh <bsingharora@gmail.com>

I find the below one more confusing and complicated, spreading the
details of DD1 around the code. I am not sure what extra i could have
done to simplify the code. We have done the arch pte updates such that
most of the update use the pte_update() interface and the one which relax
the access bits get to ptep_set_access_flag. All pte updated rules are
contained there. What you did below is that you moved the dd1 sequence
out to a place where page size is available. What I did in my patch is to
pass page size around. IMHO it is a matter of style. I also want to pass
page size around so that we keep huge_pte_update, pte_update,
ptep_set_access_flags all similar.


>
> diff --git a/arch/powerpc/include/asm/book3s/64/radix.h b/arch/powerpc/include/asm/book3s/64/radix.h
> index 2a46dea..2454217 100644
> --- a/arch/powerpc/include/asm/book3s/64/radix.h
> +++ b/arch/powerpc/include/asm/book3s/64/radix.h
> @@ -162,6 +162,30 @@ static inline unsigned long radix__pte_update(struct mm_struct *mm,
>  	return old_pte;
>  }
>
> +static inline void radix__ptep_dd1_set_access_flags(struct mm_struct *mm,
> +						unsigned long addr,
> +						pte_t *ptep, pte_t entry,
> +						unsigned long page_size)
> +{
> +
> +	unsigned long set = pte_val(entry) & (_PAGE_DIRTY | _PAGE_ACCESSED |
> +					      _PAGE_RW | _PAGE_EXEC);
> +
> +	unsigned long old_pte, new_pte;
> +
> +	old_pte = __radix_pte_update(ptep, ~0, 0);
> +	asm volatile("ptesync" : : : "memory");
> +	/*
> +	 * new value of pte
> +	 */
> +	new_pte = old_pte | set;
> +
> +	radix__flush_tlb_page_psize(mm, addr, page_size);
> +	__radix_pte_update(ptep, 0, new_pte);
> +
> +	asm volatile("ptesync" : : : "memory");
> +}
> +
>  /*
>   * Set the dirty and/or accessed bits atomically in a linux PTE, this
>   * function doesn't need to invalidate tlb.
> @@ -173,26 +197,7 @@ static inline void radix__ptep_set_access_flags(struct mm_struct *mm,
>  	unsigned long set = pte_val(entry) & (_PAGE_DIRTY | _PAGE_ACCESSED |
>  					      _PAGE_RW | _PAGE_EXEC);
>
> -	if (cpu_has_feature(CPU_FTR_POWER9_DD1)) {
> -
> -		unsigned long old_pte, new_pte;
> -
> -		old_pte = __radix_pte_update(ptep, ~0, 0);
> -		asm volatile("ptesync" : : : "memory");
> -		/*
> -		 * new value of pte
> -		 */
> -		new_pte = old_pte | set;
> -
> -		/*
> -		 * For now let's do heavy pid flush
> -		 * radix__flush_tlb_page_psize(mm, addr, mmu_virtual_psize);
> -		 */
> -		radix__flush_tlb_mm(mm);
> -
> -		__radix_pte_update(ptep, 0, new_pte);
> -	} else
> -		__radix_pte_update(ptep, 0, set);
> +	__radix_pte_update(ptep, 0, set);
>  	asm volatile("ptesync" : : : "memory");
>  }
>
> diff --git a/arch/powerpc/mm/pgtable-book3s64.c b/arch/powerpc/mm/pgtable-book3s64.c
> index f4f437c..0c7ee0e 100644
> --- a/arch/powerpc/mm/pgtable-book3s64.c
> +++ b/arch/powerpc/mm/pgtable-book3s64.c
> @@ -7,12 +7,14 @@
>   * 2 of the License, or (at your option) any later version.
>   */
>
> +#include <linux/kernel.h>
>  #include <linux/sched.h>
>  #include <asm/pgalloc.h>
>  #include <asm/tlb.h>
>
>  #include "mmu_decl.h"
>  #include <trace/events/thp.h>
> +#include <linux/hugetlb.h>
>
>  int (*register_process_table)(unsigned long base, unsigned long page_size,
>  			      unsigned long tbl_size);
> @@ -35,7 +37,15 @@ int pmdp_set_access_flags(struct vm_area_struct *vma, unsigned long address,
>  #endif
>  	changed = !pmd_same(*(pmdp), entry);
>  	if (changed) {
> -		__ptep_set_access_flags(vma->vm_mm, pmdp_ptep(pmdp), pmd_pte(entry));
> +		if (radix_enabled() && cpu_has_feature(CPU_FTR_POWER9_DD1)) {
> +			unsigned long page_size;
> +			page_size = is_vm_hugetlb_page(vma) ? PAGE_SIZE :
> +					huge_page_size(hstate_vma(vma));
> +
> +			radix__ptep_dd1_set_access_flags(vma->vm_mm, address,
> +					pmdp_ptep(pmdp), pmd_pte(entry), page_size);
> +		} else
> +			__ptep_set_access_flags(vma->vm_mm, pmdp_ptep(pmdp), pmd_pte(entry));
>  		flush_pmd_tlb_range(vma, address, address + HPAGE_PMD_SIZE);
>  	}
>  	return changed;
> diff --git a/arch/powerpc/mm/pgtable.c b/arch/powerpc/mm/pgtable.c
> index 911fdfb..ebb464e 100644
> --- a/arch/powerpc/mm/pgtable.c
> +++ b/arch/powerpc/mm/pgtable.c
> @@ -224,7 +224,16 @@ int ptep_set_access_flags(struct vm_area_struct *vma, unsigned long address,
>  	if (changed) {
>  		if (!is_vm_hugetlb_page(vma))
>  			assert_pte_locked(vma->vm_mm, address);
> -		__ptep_set_access_flags(vma->vm_mm, ptep, entry);
> +		/* Workaround to call radix update directly for DD1 */
> +		if (radix_enabled() && cpu_has_feature(CPU_FTR_POWER9_DD1)) {
> +			unsigned long page_size;
> +			page_size = is_vm_hugetlb_page(vma) ? PAGE_SIZE :
> +					huge_page_size(hstate_vma(vma));
> +
> +			radix__ptep_dd1_set_access_flags(vma->vm_mm, address,
> +					ptep, entry, page_size);
> +		} else
> +			__ptep_set_access_flags(vma->vm_mm, ptep, entry);
>  		flush_tlb_page(vma, address);
>  	}
>  	return changed;

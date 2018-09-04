Return-Path: <aneesh.kumar@linux.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 424N850DRyzF3LS
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  4 Sep 2018 20:18:12 +1000 (AEST)
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w8499KY1097030
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 4 Sep 2018 05:10:32 -0400
Received: from e15.ny.us.ibm.com (e15.ny.us.ibm.com [129.33.205.205])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2m9nxc3euh-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 04 Sep 2018 05:10:31 -0400
Received: from localhost
 by e15.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.ibm.com>;
 Tue, 4 Sep 2018 05:10:31 -0400
Subject: Re: [PATCH] KVM: PPC: Book3S HV: Don't use compound_order to
 determine host mapping size
To: Nicholas Piggin <npiggin@gmail.com>, kvm-ppc@vger.kernel.org
Cc: Paul Mackerras <paulus@ozlabs.org>,
 David Gibson <david@gibson.dropbear.id.au>, linuxppc-dev@lists.ozlabs.org
References: <20180904081601.32703-1-npiggin@gmail.com>
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
Date: Tue, 4 Sep 2018 14:40:25 +0530
MIME-Version: 1.0
In-Reply-To: <20180904081601.32703-1-npiggin@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Message-Id: <1dedb1ae-98eb-e35e-7bd9-2a1d1bf09047@linux.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 09/04/2018 01:46 PM, Nicholas Piggin wrote:
> THP paths can defer splitting compound pages until after the actual
> remap and TLB flushes to split a huge PMD/PUD. This causes radix
> partition scope page table mappings to get out of synch with the host
> qemu page table mappings.

May be we can improve this further?

With deferred_split_huge_page() during partial unmap we split the huge 
pmd entries but defer splitting the compound page to shrinker 
(9a982250f773cc8c76f1eee68a770b7cbf2faf78). That means we can find the 
page as huge/compound page even when the actual mapping is not.

Instead of looking at whether the page is compound or not, always walk 
the page table and find the pte shift so that we map it correctly in the
partition scoped table.

Reviewed-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>


> 
> This results in random memory corruption in the guest when running
> with THP. The easiest way to reproduce is use KVM baloon to free up
> a lot of memory in the guest and then shrink the balloon to give the
> memory back, while some work is being done in the guest.
> 
> Cc: Paul Mackerras <paulus@ozlabs.org>
> Cc: David Gibson <david@gibson.dropbear.id.au>
> Cc: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
> Cc: linuxppc-dev@lists.ozlabs.org
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> ---
>   arch/powerpc/kvm/book3s_64_mmu_radix.c | 88 ++++++++++----------------
>   1 file changed, 34 insertions(+), 54 deletions(-)
> 
> diff --git a/arch/powerpc/kvm/book3s_64_mmu_radix.c b/arch/powerpc/kvm/book3s_64_mmu_radix.c
> index 0af1c0aea1fe..d8792445d95a 100644
> --- a/arch/powerpc/kvm/book3s_64_mmu_radix.c
> +++ b/arch/powerpc/kvm/book3s_64_mmu_radix.c
> @@ -525,8 +525,8 @@ int kvmppc_book3s_radix_page_fault(struct kvm_run *run, struct kvm_vcpu *vcpu,
>   				   unsigned long ea, unsigned long dsisr)
>   {
>   	struct kvm *kvm = vcpu->kvm;
> -	unsigned long mmu_seq, pte_size;
> -	unsigned long gpa, gfn, hva, pfn;
> +	unsigned long mmu_seq;
> +	unsigned long gpa, gfn, hva;
>   	struct kvm_memory_slot *memslot;
>   	struct page *page = NULL;
>   	long ret;
> @@ -623,9 +623,10 @@ int kvmppc_book3s_radix_page_fault(struct kvm_run *run, struct kvm_vcpu *vcpu,
>   	 */
>   	hva = gfn_to_hva_memslot(memslot, gfn);
>   	if (upgrade_p && __get_user_pages_fast(hva, 1, 1, &page) == 1) {
> -		pfn = page_to_pfn(page);
>   		upgrade_write = true;
>   	} else {
> +		unsigned long pfn;
> +
>   		/* Call KVM generic code to do the slow-path check */
>   		pfn = __gfn_to_pfn_memslot(memslot, gfn, false, NULL,
>   					   writing, upgrade_p);
> @@ -639,63 +640,42 @@ int kvmppc_book3s_radix_page_fault(struct kvm_run *run, struct kvm_vcpu *vcpu,
>   		}
>   	}
>   
> -	/* See if we can insert a 1GB or 2MB large PTE here */
> -	level = 0;
> -	if (page && PageCompound(page)) {
> -		pte_size = PAGE_SIZE << compound_order(compound_head(page));
> -		if (pte_size >= PUD_SIZE &&
> -		    (gpa & (PUD_SIZE - PAGE_SIZE)) ==
> -		    (hva & (PUD_SIZE - PAGE_SIZE))) {
> -			level = 2;
> -			pfn &= ~((PUD_SIZE >> PAGE_SHIFT) - 1);
> -		} else if (pte_size >= PMD_SIZE &&
> -			   (gpa & (PMD_SIZE - PAGE_SIZE)) ==
> -			   (hva & (PMD_SIZE - PAGE_SIZE))) {
> -			level = 1;
> -			pfn &= ~((PMD_SIZE >> PAGE_SHIFT) - 1);
> -		}
> -	}
> -
>   	/*
> -	 * Compute the PTE value that we need to insert.
> +	 * Read the PTE from the process' radix tree and use that
> +	 * so we get the shift and attribute bits.
>   	 */
> -	if (page) {
> -		pgflags = _PAGE_READ | _PAGE_EXEC | _PAGE_PRESENT | _PAGE_PTE |
> -			_PAGE_ACCESSED;
> -		if (writing || upgrade_write)
> -			pgflags |= _PAGE_WRITE | _PAGE_DIRTY;
> -		pte = pfn_pte(pfn, __pgprot(pgflags));
> +	local_irq_disable();
> +	ptep = __find_linux_pte(vcpu->arch.pgdir, hva, NULL, &shift);
> +	pte = *ptep;
> +	local_irq_enable();
> +
> +	/* Get pte level from shift/size */
> +	if (shift == PUD_SHIFT &&
> +	    (gpa & (PUD_SIZE - PAGE_SIZE)) ==
> +	    (hva & (PUD_SIZE - PAGE_SIZE))) {
> +		level = 2;
> +	} else if (shift == PMD_SHIFT &&
> +		   (gpa & (PMD_SIZE - PAGE_SIZE)) ==
> +		   (hva & (PMD_SIZE - PAGE_SIZE))) {
> +		level = 1;
>   	} else {
> -		/*
> -		 * Read the PTE from the process' radix tree and use that
> -		 * so we get the attribute bits.
> -		 */
> -		local_irq_disable();
> -		ptep = __find_linux_pte(vcpu->arch.pgdir, hva, NULL, &shift);
> -		pte = *ptep;
> -		local_irq_enable();
> -		if (shift == PUD_SHIFT &&
> -		    (gpa & (PUD_SIZE - PAGE_SIZE)) ==
> -		    (hva & (PUD_SIZE - PAGE_SIZE))) {
> -			level = 2;
> -		} else if (shift == PMD_SHIFT &&
> -			   (gpa & (PMD_SIZE - PAGE_SIZE)) ==
> -			   (hva & (PMD_SIZE - PAGE_SIZE))) {
> -			level = 1;
> -		} else if (shift && shift != PAGE_SHIFT) {
> -			/* Adjust PFN */
> -			unsigned long mask = (1ul << shift) - PAGE_SIZE;
> -			pte = __pte(pte_val(pte) | (hva & mask));
> -		}
> -		pte = __pte(pte_val(pte) | _PAGE_EXEC | _PAGE_ACCESSED);
> -		if (writing || upgrade_write) {
> -			if (pte_val(pte) & _PAGE_WRITE)
> -				pte = __pte(pte_val(pte) | _PAGE_DIRTY);
> -		} else {
> -			pte = __pte(pte_val(pte) & ~(_PAGE_WRITE | _PAGE_DIRTY));
> +		level = 0;
> +
> +		/* Can not cope with unknown page shift */
> +		if (shift && shift != PAGE_SHIFT) {
> +			WARN_ON_ONCE(1);
> +			return -EFAULT;
>   		}
>   	}
>   
> +	pte = __pte(pte_val(pte) | _PAGE_EXEC | _PAGE_ACCESSED);
> +	if (writing || upgrade_write) {
> +		if (pte_val(pte) & _PAGE_WRITE)
> +			pte = __pte(pte_val(pte) | _PAGE_DIRTY);
> +	} else {
> +		pte = __pte(pte_val(pte) & ~(_PAGE_WRITE | _PAGE_DIRTY));
> +	}
> +
>   	/* Allocate space in the tree and write the PTE */
>   	ret = kvmppc_create_pte(kvm, pte, gpa, level, mmu_seq);
>   
> 

Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tQ2sy4WRjzDt3F
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 25 Nov 2016 15:20:06 +1100 (AEDT)
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
 uAP4JCwX006626
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 24 Nov 2016 23:20:04 -0500
Received: from e32.co.us.ibm.com (e32.co.us.ibm.com [32.97.110.150])
 by mx0b-001b2d01.pphosted.com with ESMTP id 26x6m708jk-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 24 Nov 2016 23:20:03 -0500
Received: from localhost
 by e32.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Thu, 24 Nov 2016 21:20:03 -0700
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: Paul Mackerras <paulus@ozlabs.org>
Cc: benh@kernel.crashing.org, mpe@ellerman.id.au, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v5 1/7] powerpc/mm: update ptep_set_access_flag to not do
 full mm tlb flush
In-Reply-To: <20161125024843.GA24925@fergus.ozlabs.ibm.com>
References: <20161123111003.459-1-aneesh.kumar@linux.vnet.ibm.com>
 <20161125024843.GA24925@fergus.ozlabs.ibm.com>
Date: Fri, 25 Nov 2016 09:49:57 +0530
MIME-Version: 1.0
Content-Type: text/plain
Message-Id: <87fumgjimq.fsf@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Paul Mackerras <paulus@ozlabs.org> writes:

> On Wed, Nov 23, 2016 at 04:39:57PM +0530, Aneesh Kumar K.V wrote:
>> When we are updating pte, we just need to flush the tlb mapping for
>> that pte. Right now we do a full mm flush because we don't track page
>> size. Update the interface to track the page size and use that to
>> do the right tlb flush.
> [...]
>
>> +int radix_get_mmu_psize(unsigned long page_size)
>> +{
>> +	int psize;
>> +
>> +	if (page_size == (1UL << mmu_psize_defs[mmu_virtual_psize].shift))
>> +		psize = mmu_virtual_psize;
>> +	else if (page_size == (1UL << mmu_psize_defs[MMU_PAGE_2M].shift))
>> +		psize = MMU_PAGE_2M;
>> +	else if (page_size == (1UL << mmu_psize_defs[MMU_PAGE_1G].shift))
>> +		psize = MMU_PAGE_1G;
>
> Do we actually have support for 1G pages yet?  I couldn't see where
> they get instantiated.

We use that for kernel linear mapping.

>
>> +	else
>> +		return -1;
>> +	return psize;
>> +}
>> +
>> +
>>  static int __init radix_dt_scan_page_sizes(unsigned long node,
>>  					   const char *uname, int depth,
>>  					   void *data)
>> diff --git a/arch/powerpc/mm/pgtable.c b/arch/powerpc/mm/pgtable.c
>> index 911fdfb63ec1..503ae9bd3efe 100644
>> --- a/arch/powerpc/mm/pgtable.c
>> +++ b/arch/powerpc/mm/pgtable.c
>> @@ -219,12 +219,18 @@ int ptep_set_access_flags(struct vm_area_struct *vma, unsigned long address,
>>  			  pte_t *ptep, pte_t entry, int dirty)
>>  {
>>  	int changed;
>> +	unsigned long page_size;
>> +
>>  	entry = set_access_flags_filter(entry, vma, dirty);
>>  	changed = !pte_same(*(ptep), entry);
>>  	if (changed) {
>> -		if (!is_vm_hugetlb_page(vma))
>> +		if (!is_vm_hugetlb_page(vma)) {
>> +			page_size = PAGE_SIZE;
>>  			assert_pte_locked(vma->vm_mm, address);
>> -		__ptep_set_access_flags(vma->vm_mm, ptep, entry);
>> +		} else
>> +			page_size = huge_page_size(hstate_vma(vma));
>
> I don't understand how this can work with THP.  You're determining the
> page size using only the VMA, but with a THP VMA surely we get
> different page sizes at different addresses?

That applies only for hugetlb pages. Ie, for hugetlb vma we use
vm_area_struct to determine the hugepage size.

For THP hugepage configuration we end up calling 

int pmdp_set_access_flags(struct vm_area_struct *vma, unsigned long address,
			  pmd_t *pmdp, pmd_t entry, int dirty)

and for that we do
	__ptep_set_access_flags(vma->vm_mm, pmdp_ptep(pmdp), pmd_pte(entry),
				address, HPAGE_PMD_SIZE);


>
> More generally, I'm OK with adding the address parameter to
> __ptep_set_access_flags, but I think Ben's suggestion of encoding the
> page size in the PTE value is a good one.  I think it is as simple as
> the patch below (assuming we only support 2MB large pages for now).
> That would simplify things a bit and also it would mean that we are
> sure we know the page size correctly even with THP.
>
> diff --git a/arch/powerpc/include/asm/book3s/64/pgtable.h b/arch/powerpc/include/asm/book3s/64/pgtable.h
> index 9fd77f8..e4f3581 100644
> --- a/arch/powerpc/include/asm/book3s/64/pgtable.h
> +++ b/arch/powerpc/include/asm/book3s/64/pgtable.h
> @@ -32,7 +32,8 @@
>  #define _PAGE_SOFT_DIRTY	0x00000
>  #endif
>  #define _PAGE_SPECIAL		_RPAGE_SW2 /* software: special page */
> -
> +#define _PAGE_GIGANTIC		_RPAGE_SW0	/* software: 1GB page */
> +#define _PAGE_LARGE		_RPAGE_SW1	/* software: 2MB page */

I already use _RPAGE_SW1 for _PAGE_DEVMAP (pmem/nvdimm, patch set to the
list but not merged yet). We are really low on software free bits w.r.t
pte and I was avoiding using that.

I was thinking this series is a simpler cleanup of different page table
update interface to take page size as argument.


>
>  #define _PAGE_PTE		(1ul << 62)	/* distinguishes PTEs from pointers */
>  #define _PAGE_PRESENT		(1ul << 63)	/* pte contains a translation */
> diff --git a/arch/powerpc/mm/pgtable-book3s64.c b/arch/powerpc/mm/pgtable-book3s64.c
> index f4f437c..7ff0289 100644
> --- a/arch/powerpc/mm/pgtable-book3s64.c
> +++ b/arch/powerpc/mm/pgtable-book3s64.c
> @@ -86,7 +86,7 @@ pmd_t pfn_pmd(unsigned long pfn, pgprot_t pgprot)
>  {
>  	unsigned long pmdv;
>
> -	pmdv = (pfn << PAGE_SHIFT) & PTE_RPN_MASK;
> +	pmdv = ((pfn << PAGE_SHIFT) & PTE_RPN_MASK) | _PAGE_LARGE;
>  	return pmd_set_protbits(__pmd(pmdv), pgprot);
>  }
>

I will look at this and see if can make the patch simpler. But do we
really want to use the pte bit for this ? Aren't we low on free pte bits
?

-aneesh

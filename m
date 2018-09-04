Return-Path: <aneesh.kumar@linux.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 424L1W4GPczF3HH
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  4 Sep 2018 18:42:23 +1000 (AEST)
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w848dUKu130482
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 4 Sep 2018 04:42:20 -0400
Received: from e14.ny.us.ibm.com (e14.ny.us.ibm.com [129.33.205.204])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2m9kqtqxrr-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 04 Sep 2018 04:42:20 -0400
Received: from localhost
 by e14.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.ibm.com>;
 Tue, 4 Sep 2018 04:42:19 -0400
Subject: Re: [RFC PATCH 2/3] powerpc/mm/iommu: Allow large IOMMU page size
 only for hugetlb backing
To: David Gibson <david@gibson.dropbear.id.au>
Cc: npiggin@gmail.com, benh@kernel.crashing.org, paulus@samba.org,
 mpe@ellerman.id.au, Alexey Kardashevskiy <aik@ozlabs.ru>,
 linuxppc-dev@lists.ozlabs.org
References: <20180903163733.27965-1-aneesh.kumar@linux.ibm.com>
 <20180903163733.27965-3-aneesh.kumar@linux.ibm.com>
 <20180904040643.GG2679@umbus.fritz.box>
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
Date: Tue, 4 Sep 2018 14:12:12 +0530
MIME-Version: 1.0
In-Reply-To: <20180904040643.GG2679@umbus.fritz.box>
Content-Type: text/plain; charset=windows-1252; format=flowed
Message-Id: <4b684d8a-c8a1-3ed0-070c-9fee6b1ae783@linux.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 09/04/2018 09:36 AM, David Gibson wrote:
> On Mon, Sep 03, 2018 at 10:07:32PM +0530, Aneesh Kumar K.V wrote:
>> THP pages can get split during different code paths. An incremented reference
>> count do imply we will not split the compound page. But the pmd entry can be
>> converted to level 4 pte entries. Keep the code simpler by allowing large
>> IOMMU page size only if the guest ram is backed by hugetlb pages.
>>
>> Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
> 
> So, I oked this in earlier discussion, but I had another thought and
> now I'm not so sure.
> 
> 
>> ---
>>   arch/powerpc/mm/mmu_context_iommu.c | 16 ++--------------
>>   1 file changed, 2 insertions(+), 14 deletions(-)
>>
>> diff --git a/arch/powerpc/mm/mmu_context_iommu.c b/arch/powerpc/mm/mmu_context_iommu.c
>> index c9ee9e23845f..f472965f7638 100644
>> --- a/arch/powerpc/mm/mmu_context_iommu.c
>> +++ b/arch/powerpc/mm/mmu_context_iommu.c
>> @@ -212,21 +212,9 @@ long mm_iommu_get(struct mm_struct *mm, unsigned long ua, unsigned long entries,
>>   		}
>>   populate:
>>   		pageshift = PAGE_SHIFT;
>> -		if (mem->pageshift > PAGE_SHIFT && PageCompound(page)) {
>> -			pte_t *pte;
>> +		if (mem->pageshift > PAGE_SHIFT && PageHuge(page)) {
> 
> We can definitely only support large IOMMU pages with static
> hugepages, not THPs, so the change from PageCompound to PageHuge is
> definitely correct and a good idea.
> 
>>   			struct page *head = compound_head(page);
>> -			unsigned int compshift = compound_order(head);
>> -			unsigned int pteshift;
>> -
>> -			local_irq_save(flags); /* disables as well */
>> -			pte = find_linux_pte(mm->pgd, cur_ua, NULL, &pteshift);
>> -
>> -			/* Double check it is still the same pinned page */
>> -			if (pte && pte_page(*pte) == head &&
>> -			    pteshift == compshift + PAGE_SHIFT)
>> -				pageshift = max_t(unsigned int, pteshift,
>> -						PAGE_SHIFT);
>> -			local_irq_restore(flags);
>> +			pageshift = compound_order(head) + PAGE_SHIFT;
> 
> But, my concern with this part is: are we totally certain there's no
> way to get part of a hugetlbfs page mapped with regular sized PTEs
> (probably in addition to the expected hugetlb mapping).

We don't map hugetlb pages that way. They are always pmd mapped on 
book3s64.


> 
> I'm thinking weirdness like mremap(), mapping another hugetlb using
> process's address space via /proc/*/mem or maybe something even more
> exotic.
> 
> Now, it's possible that we don't really care here - even if it's not
> technically right for this mapping, we could argue that as long as the
> process has access to part of the hugepage, the whole thing is fair
> game for a DMA mapping.  In that case merely double checking that this
> mapping is properly aligned would suffice (i.e. that:
>      (ua >> PAGE_SHIFT) == (page's index within the compound page)
> 
>>   		}
>>   		mem->pageshift = min(mem->pageshift, pageshift);
>>   		mem->hpas[i] = page_to_pfn(page) << PAGE_SHIFT;
> 


-aneesh

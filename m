Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zdJsw6vNpzF0lk
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 10 Feb 2018 02:30:28 +1100 (AEDT)
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w19FTcbE004191
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 9 Feb 2018 10:30:26 -0500
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.149])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2g1dfgjmjb-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 09 Feb 2018 10:30:25 -0500
Received: from localhost
 by e31.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Fri, 9 Feb 2018 08:30:25 -0700
Subject: Re: [PATCH 1/2] powerpc/mm: Fix crashes with PUD level hugetlb config
To: Ram Pai <linuxram@us.ibm.com>
Cc: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
 linuxppc-dev@lists.ozlabs.org
References: <20180208103442.22045-1-aneesh.kumar@linux.vnet.ibm.com>
 <20180208192201.GA5559@ram.oc3035372033.ibm.com>
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Date: Fri, 9 Feb 2018 21:00:17 +0530
MIME-Version: 1.0
In-Reply-To: <20180208192201.GA5559@ram.oc3035372033.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Message-Id: <7d7c4b70-09ca-4cd5-219e-7686a712aba7@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



On 02/09/2018 12:52 AM, Ram Pai wrote:
> On Thu, Feb 08, 2018 at 04:04:41PM +0530, Aneesh Kumar K.V wrote:
>> To support memory keys, we moved the hash pte slot information to the second
>> half of the page table. This was ok with PTE entries at level 4 and level 3.
>> We already allocate larger page table pages at those level to accomodate extra
>> details. For level 4 we already have the extra space which was used to track
>> 4k hash page table entry details and at pmd level the extra space was allocated
>> to track the THP details.
>>
>> With hugetlbfs PTE, we used this extra space at the PMD level to store the
>> slot details. But we also support hugetlbfs PTE at PUD leve and PUD level page
>> didn't allocate extra space. This resulted in memory corruption.
>>
>> Fix this by allocating extra space at PUD level when HUGETLB is enabled. We
>> may need further changes to allocate larger space at PMD level when we enable
>> HUGETLB. That will be done in next patch.
>>
>> Fixes:bf9a95f9a6481bc6e(" powerpc: Free up four 64K PTE bits in 64K backed HPTE pages")
> 
> hmm.. did not know that hugetlbs operated at the PUD level. Thanks for
> catching this.
> 
>>
>> Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
>> ---
>> NOTE: In the long run we may want to look at my patch series to remove slot
> ...snip...
>>   }
>>
>>   static inline pmd_t *pmd_alloc_one(struct mm_struct *mm, unsigned long addr)
>> diff --git a/arch/powerpc/include/asm/book3s/64/pgtable.h b/arch/powerpc/include/asm/book3s/64/pgtable.h
>> index 51017726d495..3c14663d457d 100644
>> --- a/arch/powerpc/include/asm/book3s/64/pgtable.h
>> +++ b/arch/powerpc/include/asm/book3s/64/pgtable.h
>> @@ -232,11 +232,13 @@ extern unsigned long __pmd_index_size;
>>   extern unsigned long __pud_index_size;
>>   extern unsigned long __pgd_index_size;
>>   extern unsigned long __pmd_cache_index;
>> +extern unsigned long __pud_cache_index;
>>   #define PTE_INDEX_SIZE  __pte_index_size
>>   #define PMD_INDEX_SIZE  __pmd_index_size
>>   #define PUD_INDEX_SIZE  __pud_index_size
>>   #define PGD_INDEX_SIZE  __pgd_index_size
>>   #define PMD_CACHE_INDEX __pmd_cache_index
>> +#define PUD_CACHE_INDEX __pmd_cache_index
> 
> This is a typo. Should be 'pud' not a 'pmd'.
> 
> #define PUD_CACHE_INDEX __pud_cache_index

Thanks fixed that.

-aneesh

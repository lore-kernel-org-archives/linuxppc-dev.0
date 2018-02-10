Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zdz7H3GqZzF0jl
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 11 Feb 2018 04:14:18 +1100 (AEDT)
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w1AHEGHj052984
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 10 Feb 2018 12:14:16 -0500
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.149])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2g1tjb6duh-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 10 Feb 2018 12:14:16 -0500
Received: from localhost
 by e31.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Sat, 10 Feb 2018 10:14:13 -0700
Subject: Re: [PATCH 1/2] powerpc/mm: Fix crashes with PUD level hugetlb config
To: Ram Pai <linuxram@us.ibm.com>
Cc: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
 linuxppc-dev@lists.ozlabs.org
References: <20180208103442.22045-1-aneesh.kumar@linux.vnet.ibm.com>
 <87r2pvfr5g.fsf@linux.vnet.ibm.com> <87o9kxfa7d.fsf@linux.vnet.ibm.com>
 <20180210165010.GC5559@ram.oc3035372033.ibm.com>
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Date: Sat, 10 Feb 2018 22:44:01 +0530
MIME-Version: 1.0
In-Reply-To: <20180210165010.GC5559@ram.oc3035372033.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Message-Id: <91be190d-2162-5e02-b4c1-f03b3f3a44f2@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



On 02/10/2018 10:20 PM, Ram Pai wrote:
> On Sat, Feb 10, 2018 at 03:17:02PM +0530, Aneesh Kumar K.V wrote:
>> Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com> writes:
>>
>>> "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com> writes:
>>>
>>>> To support memory keys, we moved the hash pte slot information to the second
>>>> half of the page table. This was ok with PTE entries at level 4 and level 3.
>>>> We already allocate larger page table pages at those level to accomodate extra
>>>> details. For level 4 we already have the extra space which was used to track
>>>> 4k hash page table entry details and at pmd level the extra space was allocated
>>>> to track the THP details.
>>>>
>>>> With hugetlbfs PTE, we used this extra space at the PMD level to store the
>>>> slot details. But we also support hugetlbfs PTE at PUD leve and PUD level page
>>>> didn't allocate extra space. This resulted in memory corruption.
>>>>
>>>> Fix this by allocating extra space at PUD level when HUGETLB is enabled. We
>>>> may need further changes to allocate larger space at PMD level when we enable
>>>> HUGETLB. That will be done in next patch.
>>>>
>>>> Fixes:bf9a95f9a6481bc6e(" powerpc: Free up four 64K PTE bits in 64K backed HPTE pages")
>>>>
>>>> Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
>>>
>>> Another fix, I still get random memory corruption with hugetlb test with
>>> 16G hugepage config.
>>
>> Another one. I am not sure whether we really want this in this form. But
>> with this tests are running fine.
>>
>> -aneesh
>>
>> commit 658fe8c310a913e69e5bc9a40d4c28a3b88d5c08
>> Author: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
>> Date:   Sat Feb 10 13:17:34 2018 +0530
>>
>>      powerpc/mm/hash64: memset the pagetable pages on allocation.
>>      
>>      Now that we are using second half of the table to store slot details and we
>>      don't clear them in the huge_pte_get_and_clear, we need to make sure we zero
>>      out the range on allocation. This done some extra work because the first half
>>      of the table is cleared by huge_pte_get_and_clear and memset in this patch
>>      zero-out the full table page.
>>      
>>      We need to do this for pgd and pud because both get allocated from the same slab
>>      cache.
> 
> Do we need to zero pgd aswell to resolve your corruption? pud is not
> sufficient? Or was it done to avoid issues in the future in case pgd
> is used as the leaf; possibly for Terra_huge_pages?
> 

it is the other way round, we need to zero-out pgd. pud zerout can be 
optional because first half of the page table is always cleared in the 
unmap path.

-aneesh

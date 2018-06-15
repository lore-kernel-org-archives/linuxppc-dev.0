Return-Path: <aneesh.kumar@linux.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 416bwQ4WhqzF1LY
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 15 Jun 2018 20:15:34 +1000 (AEST)
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w5FADoEF120489
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 15 Jun 2018 06:15:31 -0400
Received: from e12.ny.us.ibm.com (e12.ny.us.ibm.com [129.33.205.202])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2jm99dwht8-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 15 Jun 2018 06:15:31 -0400
Received: from localhost
 by e12.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.ibm.com>;
 Fri, 15 Jun 2018 06:15:30 -0400
Subject: Re: [PATCH] powerpc/mm: Fix kernel crash on page table free
To: Christophe Leroy <christophe.leroy@c-s.fr>, benh@kernel.crashing.org,
 paulus@samba.org, mpe@ellerman.id.au
Cc: linuxppc-dev@lists.ozlabs.org
References: <20180530123225.7732-1-aneesh.kumar@linux.ibm.com>
 <1bbbfc4d-c47c-2383-454c-430a014beb9e@c-s.fr>
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
Date: Fri, 15 Jun 2018 15:45:23 +0530
MIME-Version: 1.0
In-Reply-To: <1bbbfc4d-c47c-2383-454c-430a014beb9e@c-s.fr>
Content-Type: text/plain; charset=utf-8; format=flowed
Message-Id: <186c9af6-17d1-d28f-a53c-3bf58d69ada1@linux.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 06/15/2018 03:24 AM, Christophe Leroy wrote:
> 
> 
> On 05/30/2018 12:32 PM, Aneesh Kumar K.V wrote:
>> Fix the below crash on BookE 64. pgtable_page_dtor expects struct page 
>> *arg.
>>
>> Also call the destructor on non book3s platforms correctly. This free 
>> up the
>> split ptl locks correctly if we had allocated them before.
>>
>> Call Trace:
>> [c0000000f30c7520] [c00000000021eeec] .kmem_cache_free+0x9c/0x44c 
>> (unreliable)
>> [c0000000f30c75c0] [c0000000001ee07c] .ptlock_free+0x1c/0x30
>> [c0000000f30c7630] [c0000000001ee260] .tlb_remove_table+0xdc/0x224
>> [c0000000f30c76c0] [c0000000001ee640] .free_pgd_range+0x298/0x500
>> [c0000000f30c77d0] [c000000000232afc] .shift_arg_pages+0x10c/0x1e0
>> [c0000000f30c7910] [c000000000232dd0] .setup_arg_pages+0x200/0x25c
>> [c0000000f30c79c0] [c0000000002ad4fc] .load_elf_binary+0x450/0x16c8
>> [c0000000f30c7b10] [c000000000234914] 
>> .search_binary_handler.part.11+0x9c/0x248
>> [c0000000f30c7bb0] [c00000000023595c] 
>> .do_execveat_common.isra.13+0x868/0xc18
>> [c0000000f30c7cb0] [c00000000000184c] .run_init_process+0x34/0x4c
>> [c0000000f30c7d30] [c000000000001880] .try_to_run_init_process+0x1c/0x68
>> [c0000000f30c7db0] [c000000000002bd8] .kernel_init+0xdc/0x130
>> [c0000000f30c7e30] [c0000000000009dc] .ret_from_kernel_thread+0x58/0x7c
>>
>> Fixes: 702346768 ("powerpc/mm/nohash: Remove pte fragment dependency 
>> from nohash")
>> Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
>> ---
>>   arch/powerpc/include/asm/book3s/32/pgalloc.h | 1 +
>>   arch/powerpc/include/asm/nohash/32/pgalloc.h | 1 +
>>   arch/powerpc/include/asm/nohash/64/pgalloc.h | 2 +-
>>   3 files changed, 3 insertions(+), 1 deletion(-)
>>
>> diff --git a/arch/powerpc/include/asm/book3s/32/pgalloc.h 
>> b/arch/powerpc/include/asm/book3s/32/pgalloc.h
>> index 5073cc75f1c8..6a6673907e45 100644
>> --- a/arch/powerpc/include/asm/book3s/32/pgalloc.h
>> +++ b/arch/powerpc/include/asm/book3s/32/pgalloc.h
>> @@ -99,6 +99,7 @@ static inline void pte_free(struct mm_struct *mm, 
>> pgtable_t ptepage)
>>   static inline void pgtable_free(void *table, unsigned index_size)
>>   {
>>       if (!index_size) {
>> +        pgtable_page_dtor(virt_to_page(table));
> 
> __pte_free_tlb() already calls pgtable_page_dtor(table) before calling
> pgtable_free() via pgtable_free_tlb().
> 
> Is it normal to call it twice ?

No. We should call pgtable_page_dtor only in the rcu callback. So we 
should remove it from __pte_free_tlb().

> 
>>           free_page((unsigned long)table);
>>       } else {
>>           BUG_ON(index_size > MAX_PGTABLE_INDEX_SIZE);
>> diff --git a/arch/powerpc/include/asm/nohash/32/pgalloc.h 
>> b/arch/powerpc/include/asm/nohash/32/pgalloc.h
>> index 29d37bd1f3b3..1707781d2f20 100644
>> --- a/arch/powerpc/include/asm/nohash/32/pgalloc.h
>> +++ b/arch/powerpc/include/asm/nohash/32/pgalloc.h
>> @@ -100,6 +100,7 @@ static inline void pte_free(struct mm_struct *mm, 
>> pgtable_t ptepage)
>>   static inline void pgtable_free(void *table, unsigned index_size)
>>   {
>>       if (!index_size) {
>> +        pgtable_page_dtor(virt_to_page(table));
> 
> Same here

I don't have the facility to test anything other than book3s64. Can you 
do a patch for this?

-aneesh

Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e28smtp03.in.ibm.com (e28smtp03.in.ibm.com [125.16.236.3])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id EAA7A1A003F
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 18 Jan 2016 18:42:21 +1100 (AEDT)
Received: from localhost
 by e28smtp03.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Mon, 18 Jan 2016 13:03:40 +0530
Received: from d28av05.in.ibm.com (d28av05.in.ibm.com [9.184.220.67])
 by d28relay02.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u0I7X1Pp131404
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 18 Jan 2016 13:03:04 +0530
Received: from d28av05.in.ibm.com (localhost [127.0.0.1])
 by d28av05.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u0I7Wodh028483
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 18 Jan 2016 13:02:59 +0530
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: Balbir Singh <bsingharora@gmail.com>, benh@kernel.crashing.org,
 paulus@samba.org, mpe@ellerman.id.au, Michael Neuling <mikey@neuling.org>
Cc: linuxppc-dev@lists.ozlabs.org
Subject: Re: [RFC PATCH V1 03/33] powerpc/mm: Switch book3s 64 with 64K page
 size to 4 level page table
In-Reply-To: <56983C74.1000304@gmail.com>
References: <1452582968-22669-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <1452582968-22669-4-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <56983C74.1000304@gmail.com>
Date: Mon, 18 Jan 2016 13:02:36 +0530
Message-ID: <87a8o3mjfv.fsf@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Balbir Singh <bsingharora@gmail.com> writes:

> On 12/01/16 18:15, Aneesh Kumar K.V wrote:
>> This is needed so that we can support both hash and radix page table
>> using single kernel. Radix kernel uses a 4 level table.
>>

.....

> diff --git a/arch/powerpc/include/asm/book3s/64/hash-64k.h b/arch/powerpc/include/asm/book3s/64/hash-64k.h
>> index 849bbec80f7b..5c9392b71a6b 100644
>> --- a/arch/powerpc/include/asm/book3s/64/hash-64k.h
>> +++ b/arch/powerpc/include/asm/book3s/64/hash-64k.h
>> @@ -1,15 +1,14 @@
>>  #ifndef _ASM_POWERPC_BOOK3S_64_HASH_64K_H
>>  #define _ASM_POWERPC_BOOK3S_64_HASH_64K_H
>>  
>> -#include <asm-generic/pgtable-nopud.h>
>> -
>>  #define PTE_INDEX_SIZE  8
>> -#define PMD_INDEX_SIZE  10
>> -#define PUD_INDEX_SIZE	0
>> +#define PMD_INDEX_SIZE  5
>> +#define PUD_INDEX_SIZE	5
>>  #define PGD_INDEX_SIZE  12
>
>
> 10 splits to 5 and 5 for PMD/PUD? Does this impact huge page?


Nope. We have huge page at top level and pmd level. (16G and 16M)

>
>>  
>>  #define PTRS_PER_PTE	(1 << PTE_INDEX_SIZE)
>>  #define PTRS_PER_PMD	(1 << PMD_INDEX_SIZE)
>> +#define PTRS_PER_PUD	(1 << PUD_INDEX_SIZE)
>>  #define PTRS_PER_PGD	(1 << PGD_INDEX_SIZE)
>>  
>>  /* With 4k base page size, hugepage PTEs go at the PMD level */
>> @@ -20,8 +19,13 @@
>>  #define PMD_SIZE	(1UL << PMD_SHIFT)
>>  #define PMD_MASK	(~(PMD_SIZE-1))
>>  
>> +/* PUD_SHIFT determines what a third-level page table entry can map */
>> +#define PUD_SHIFT	(PMD_SHIFT + PMD_INDEX_SIZE)
>> +#define PUD_SIZE	(1UL << PUD_SHIFT)
>> +#define PUD_MASK	(~(PUD_SIZE-1))
>> +
>>  /* PGDIR_SHIFT determines what a third-level page table entry can map */
>> -#define PGDIR_SHIFT	(PMD_SHIFT + PMD_INDEX_SIZE)
>> +#define PGDIR_SHIFT	(PUD_SHIFT + PUD_INDEX_SIZE)
>>  #define PGDIR_SIZE	(1UL << PGDIR_SHIFT)
>>  #define PGDIR_MASK	(~(PGDIR_SIZE-1))
>>  
>> @@ -61,6 +65,8 @@
>>  #define PMD_MASKED_BITS		(PTE_FRAG_SIZE - 1)
>>  /* Bits to mask out from a PGD/PUD to get to the PMD page */
>>  #define PUD_MASKED_BITS		0x1ff
>> +/* FIXME!! check this */
>
> Shouldn't PUD_MASKED_BITS be 0x1f?
>
>> +#define PGD_MASKED_BITS		0
>>  
> 0?
>


The MASKED_BITS need to be cleaned up hence the FIXME!! Linux page table
are aligned differently and I didn't want to cleanup that in this
series. IMHO using #defines like above instead of deriving it from the
pmd table align value is wrong. Will get to that later. 



>>  #ifndef __ASSEMBLY__
>>  
>> @@ -130,11 +136,9 @@ extern bool __rpte_sub_valid(real_pte_t rpte, unsigned long index);
>>  #else
>>  #define PMD_TABLE_SIZE	(sizeof(pmd_t) << PMD_INDEX_SIZE)
>>  #endif
>> +#define PUD_TABLE_SIZE	(sizeof(pud_t) << PUD_INDEX_SIZE)
>>  #define PGD_TABLE_SIZE	(sizeof(pgd_t) << PGD_INDEX_SIZE)
>>  
>> -#define pgd_pte(pgd)	(pud_pte(((pud_t){ pgd })))
>> -#define pte_pgd(pte)	((pgd_t)pte_pud(pte))
>> -
>>  #ifdef CONFIG_HUGETLB_PAGE

-aneesh

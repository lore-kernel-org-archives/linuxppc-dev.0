Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 52B6C1A06C2
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  1 Mar 2016 16:31:25 +1100 (AEDT)
Received: from localhost
 by e35.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Mon, 29 Feb 2016 22:31:22 -0700
Received: from b03cxnp07028.gho.boulder.ibm.com
 (b03cxnp07028.gho.boulder.ibm.com [9.17.130.15])
 by d03dlp02.boulder.ibm.com (Postfix) with ESMTP id A093E3E4003F
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 29 Feb 2016 22:31:20 -0700 (MST)
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
 by b03cxnp07028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u215VK4625428150
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 29 Feb 2016 22:31:20 -0700
Received: from d03av01.boulder.ibm.com (localhost [127.0.0.1])
 by d03av01.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u215VKPA008098
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 29 Feb 2016 22:31:20 -0700
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: Balbir Singh <bsingharora@gmail.com>, benh@kernel.crashing.org,
 paulus@samba.org, mpe@ellerman.id.au
Cc: linuxppc-dev@lists.ozlabs.org
Subject: Re: [RFC PATCH] powerpc/mm: Use big endian page table for book3s 64
In-Reply-To: <56D3A61B.5040308@gmail.com>
References: <1456458814-7497-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <56D3A61B.5040308@gmail.com>
Date: Tue, 01 Mar 2016 11:01:15 +0530
Message-ID: <87y4a2pxwc.fsf@linux.vnet.ibm.com>
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

> On 26/02/16 14:53, Aneesh Kumar K.V wrote:
>> This enables us to share the same page table code for
>> both radix and hash. Radix use a hardware defined big endian
>                              ^uses
>> page table
>>
>> Asm -> C conversion makes it simpler to build code for both little
>> and big endian page table.
>
>>
>> Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
>> ---
>> Note:
>> Any suggestion on how we can do that pte update better so that we can build
>> a LE and BE page table kernel will be helpful.
> Ideally this should not break software compatibility for VM migration,
> but might be worth testing. Basically a hypervisor with BE page tables
> and software endian older kernel instance. Also look for any tools
> that work off of saved dump images with PTE entries in them -
> crash/kdump/etc



I will check this.


>>  arch/powerpc/include/asm/book3s/64/hash.h   |  75 ++++++++++++--------
>>  arch/powerpc/include/asm/kvm_book3s_64.h    |  12 ++--
>>  arch/powerpc/include/asm/page.h             |   4 ++
>>  arch/powerpc/include/asm/pgtable-be-types.h | 104 ++++++++++++++++++++++++++++
>>  arch/powerpc/mm/hash64_4k.c                 |   6 +-
>>  arch/powerpc/mm/hash64_64k.c                |  11 +--
>>  arch/powerpc/mm/hugepage-hash64.c           |   5 +-
>>  arch/powerpc/mm/hugetlbpage-hash64.c        |   5 +-
>>  arch/powerpc/mm/pgtable-hash64.c            |  42 +++++------
>>  9 files changed, 197 insertions(+), 67 deletions(-)
>>  create mode 100644 arch/powerpc/include/asm/pgtable-be-types.h
>>
>> diff --git a/arch/powerpc/include/asm/book3s/64/hash.h b/arch/powerpc/include/asm/book3s/64/hash.h
>> index 9b451cb8294a..9153bda5f395 100644
>> --- a/arch/powerpc/include/asm/book3s/64/hash.h
>> +++ b/arch/powerpc/include/asm/book3s/64/hash.h
>> @@ -1,6 +1,9 @@
>>  #ifndef _ASM_POWERPC_BOOK3S_64_HASH_H
>>  #define _ASM_POWERPC_BOOK3S_64_HASH_H
>>  #ifdef __KERNEL__
>> +#ifndef __ASSEMBLY__
>> +#include <asm/cmpxchg.h>
>> +#endif
> Do we still need PTE_ATOMIC_UPDATE as 1 after these changes?


yes. we are not changing anything with respect to _PAGE_BUSY handling.

>>  
>>  /*
>>   * Common bits between 4K and 64K pages in a linux-style PTE.
>> @@ -249,27 +252,35 @@ static inline unsigned long pte_update(struct mm_struct *mm,
>>  				       unsigned long set,
>>  				       int huge)
>>  {
>> -	unsigned long old, tmp;
>> -
>> -	__asm__ __volatile__(
>> -	"1:	ldarx	%0,0,%3		# pte_update\n\
>> -	andi.	%1,%0,%6\n\
>> -	bne-	1b \n\
>> -	andc	%1,%0,%4 \n\
>> -	or	%1,%1,%7\n\
>> -	stdcx.	%1,0,%3 \n\
>> -	bne-	1b"
>> -	: "=&r" (old), "=&r" (tmp), "=m" (*ptep)
>> -	: "r" (ptep), "r" (clr), "m" (*ptep), "i" (_PAGE_BUSY), "r" (set)
>> -	: "cc" );
>> +	pte_t pte;
>> +	unsigned long old_pte, new_pte;
>> +
>> +	do {
>> +reload:
>> +		pte = READ_ONCE(*ptep);
>> +		old_pte = pte_val(pte);
>> +
>> +		/* If PTE busy, retry */
>> +		if (unlikely(old_pte & _PAGE_BUSY))
>> +			goto reload;
> A loop within another? goto to upward labels can be ugly..
>
>     do {
>         pte = READ_ONCE(*ptep);
>         old_pte = pte_val(pte);
>
>         while (unlikely(old_pte & _PAGE_BUSY)) {
>             cpu_relax(); /* Do we need this? */
>             pte = READ_ONCE(*ptep);
>             old_pte = pte_val(pte);
>         }
>
> The above four lines can be abstracted further to loop_while_page_busy() if required :)

I will check this.


>> +		/*
>> +		 * Try to lock the PTE, add ACCESSED and DIRTY if it was
>> +		 * a write access. Since this is 4K insert of 64K page size
>> +		 * also add _PAGE_COMBO
>> +		 */
>> +		new_pte = (old_pte | set) & ~clr;
>> +
>> +	} while (cpu_to_be64(old_pte) != __cmpxchg_u64((unsigned long *)ptep,
>> +						   cpu_to_be64(old_pte),
>> +						   cpu_to_be64(new_pte)));
>>  	/* huge pages use the old page table lock */
>>  	if (!huge)
>>  		assert_pte_locked(mm, addr);
>>  
>> -	if (old & _PAGE_HASHPTE)
>> -		hpte_need_flush(mm, addr, ptep, old, huge);
>> +	if (old_pte & _PAGE_HASHPTE)
>> +		hpte_need_flush(mm, addr, ptep, old_pte, huge);
>>  
>> -	return old;
>> +	return old_pte;
>>  }

-aneesh

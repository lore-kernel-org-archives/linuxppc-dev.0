Return-Path: <bsingharora@gmail.com>
Received: from mail-pf0-x230.google.com (mail-pf0-x230.google.com
 [IPv6:2607:f8b0:400e:c00::230])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 8EE891A00A5
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 29 Feb 2016 13:58:41 +1100 (AEDT)
Received: by mail-pf0-x230.google.com with SMTP id w128so38517369pfb.2
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 28 Feb 2016 18:58:41 -0800 (PST)
Subject: Re: [RFC PATCH] powerpc/mm: Use big endian page table for book3s 64
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
 benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au
References: <1456458814-7497-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <56D3A61B.5040308@gmail.com>
Cc: linuxppc-dev@lists.ozlabs.org
From: Balbir Singh <bsingharora@gmail.com>
Message-ID: <56D3B3DB.1090406@gmail.com>
Date: Mon, 29 Feb 2016 13:58:35 +1100
MIME-Version: 1.0
In-Reply-To: <56D3A61B.5040308@gmail.com>
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



On 29/02/16 12:59, Balbir Singh wrote:
>
> On 26/02/16 14:53, Aneesh Kumar K.V wrote:
>> This enables us to share the same page table code for
>> both radix and hash. Radix use a hardware defined big endian
>                              ^uses
>> page table
>>
>> Asm -> C conversion makes it simpler to build code for both little
>> and big endian page table.
>> Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
>> ---
>> Note:
>> Any suggestion on how we can do that pte update better so that we can build
>> a LE and BE page table kernel will be helpful.
> Ideally this should not break software compatibility for VM migration, but might be worth testing. Basically a hypervisor with BE page tables and software endian older kernel instance. Also look for any tools that work off of saved dump images with PTE entries in them - crash/kdump/etc
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
>>
Another minor nit-pick

(I presume that is the case, but anyway)
Can you check if the compiler is optimizing this such that

cpu_to_be64(old_pte) and cpu_to_be64(new_pte) is called just once?


<snip>
Balbir Singh.

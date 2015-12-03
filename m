Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e23smtp08.au.ibm.com (e23smtp08.au.ibm.com [202.81.31.141])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id A0AC81A0C39
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  4 Dec 2015 05:58:12 +1100 (AEDT)
Received: from localhost
 by e23smtp08.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Fri, 4 Dec 2015 04:58:10 +1000
Received: from d23relay08.au.ibm.com (d23relay08.au.ibm.com [9.185.71.33])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id 667C72CE8050
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  4 Dec 2015 05:57:56 +1100 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay08.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 tB3IvVGd37421160
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 4 Dec 2015 05:57:39 +1100
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 tB3IvNgS000583
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 4 Dec 2015 05:57:24 +1100
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: Anshuman Khandual <khandual@linux.vnet.ibm.com>, benh@kernel.crashing.org,
 paulus@samba.org, mpe@ellerman.id.au, Scott Wood <scottwood@freescale.com>,
 Denis Kirjanov <kda@linux-powerpc.org>
Cc: linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH V6 20/35] powerpc/mm: Don't track subpage valid bit in
 pte_t
In-Reply-To: <565FEB82.8060608@linux.vnet.ibm.com>
References: <1448941020-15168-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <1448941020-15168-21-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <565FEB82.8060608@linux.vnet.ibm.com>
Date: Fri, 04 Dec 2015 00:27:03 +0530
Message-ID: <8737vj743k.fsf@linux.vnet.ibm.com>
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

Anshuman Khandual <khandual@linux.vnet.ibm.com> writes:

> On 12/01/2015 09:06 AM, Aneesh Kumar K.V wrote:
>> This free up 11 bits in pte_t. In the later patch we also change
>> the pte_t format so that we can start supporting migration pte
>> at pmd level. We now track 4k subpage valid bit as below
>> 
>> If we have _PAGE_COMBO set, we override the _PAGE_F_GIX_SHIFT
>> and _PAGE_F_SECOND. Together we have 4 bits, each of them
>> used to indicate whether any of the 4 4k subpage in that group
>> is valid. ie,
>> 
>> [ group 1 bit ]   [ group 2 bit ]  ..... [ group 4 ]
>> [ subpage 1 - 4]  [ subpage 5- 8]  ..... [ subpage 13 - 16]
>> 
>> We still track each 4k subpage slot number and secondary hash
>> information in the second half of pgtable_t. Removing the subpage
>> tracking have some significant overhead on aim9 and ebizzy benchmark and
>> to support THP with 4K subpage, we do need a pgtable_t of 4096 bytes.
>> 
>> Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
>
> We removed 16 bits which used to track individual sub pages and added
> back 4 bits to track newly created sub page groups. So we save 12 bits
> there. How it is 11 bits ? Have we added back one more bit into pte_t
> some where for sub page purpose which I am missing ?


We added back 5 bits, (I guess you are missing _PAGE_HASHPTE )


>
>> ---
>>  arch/powerpc/include/asm/book3s/64/hash-4k.h  | 10 +-------
>>  arch/powerpc/include/asm/book3s/64/hash-64k.h | 35 ++++++---------------------
>>  arch/powerpc/include/asm/book3s/64/hash.h     | 10 ++++----
>>  arch/powerpc/mm/hash64_64k.c                  | 34 ++++++++++++++++++++++++--

.....
......

> diff --git a/arch/powerpc/mm/hash64_64k.c b/arch/powerpc/mm/hash64_64k.c
>> index 9ffeae2cbb57..f1b86ba63430 100644
>> --- a/arch/powerpc/mm/hash64_64k.c
>> +++ b/arch/powerpc/mm/hash64_64k.c
>> @@ -15,6 +15,35 @@
>>  #include <linux/mm.h>
>>  #include <asm/machdep.h>
>>  #include <asm/mmu.h>
>> +/*
>> + * index from 0 - 15
>> + */
>> +bool __rpte_sub_valid(real_pte_t rpte, unsigned long index)
>> +{
>> +	unsigned long g_idx;
>> +	unsigned long ptev = pte_val(rpte.pte);
>> +
>> +	g_idx = (ptev & _PAGE_COMBO_VALID) >> _PAGE_F_GIX_SHIFT;
>> +	index = index >> 2;
>> +	if (g_idx & (0x1 << index))
>> +		return true;
>> +	else
>> +		return false;
>> +}
>
> This function checks for validity of the sub page group not individual
> sub page index. Because we dont track individual sub page index validity
> any more, wondering if that is even possible.
>

That is correct. We are not tracking individual subpage validity after
this patch. That is explained in the commit message.


>> +/*
>> + * index from 0 - 15
>> + */
>> +static unsigned long mark_subptegroup_valid(unsigned long ptev, unsigned long index)
>> +{
>> +	unsigned long g_idx;
>> +
>> +	if (!(ptev & _PAGE_COMBO))
>> +		return ptev;
>> +	index = index >> 2;
>> +	g_idx = 0x1 << index;
>> +
>> +	return ptev | (g_idx << _PAGE_F_GIX_SHIFT);
>> +}
>>  
>>  int __hash_page_4K(unsigned long ea, unsigned long access, unsigned long vsid,
>>  		   pte_t *ptep, unsigned long trap, unsigned long flags,
>> @@ -102,7 +131,7 @@ int __hash_page_4K(unsigned long ea, unsigned long access, unsigned long vsid,
>>  	 */
>>  	if (!(old_pte & _PAGE_COMBO)) {
>>  		flush_hash_page(vpn, rpte, MMU_PAGE_64K, ssize, flags);
>> -		old_pte &= ~_PAGE_HPTE_SUB;
>> +		old_pte &= ~_PAGE_HASHPTE | _PAGE_F_GIX | _PAGE_F_SECOND;
>
> Or  use _PAGE_COMBO_VALID directly instead ?


Nope we are not clearning a combo related detail there. We are
invalidating an old 64K mapping there. (yes, the values are matching but
we should not use the _PAGE_COMBO_VALID there).


>
>>  		goto htab_insert_hpte;
>>  	}
>>  	/*
>> @@ -192,7 +221,8 @@ repeat:
>>  	/* __real_pte use pte_val() any idea why ? FIXME!! */
>>  	rpte.hidx &= ~(0xfUL << (subpg_index << 2));
>>  	*hidxp = rpte.hidx  | (slot << (subpg_index << 2));
>> -	new_pte |= (_PAGE_HPTE_SUB0 >> subpg_index);
>> +	new_pte = mark_subptegroup_valid(new_pte, subpg_index);
>> +	new_pte |=  _PAGE_HASHPTE;
>>  	/*
>>  	 * check __real_pte for details on matching smp_rmb()
>>  	 */
>> diff --git a/arch/powerpc/mm/hash_low_64.S b/arch/powerpc/mm/hash_low_64.S
>> index 6b4d4c1d0628..359839a57f26 100644
>> --- a/arch/powerpc/mm/hash_low_64.S
>> +++ b/arch/powerpc/mm/hash_low_64.S
>> @@ -285,7 +285,7 @@ htab_modify_pte:
>>  
>>  	/* Secondary group ? if yes, get a inverted hash value */
>>  	mr	r5,r28
>> -	andi.	r0,r31,_PAGE_SECONDARY
>> +	andi.	r0,r31,_PAGE_F_SECOND
>>  	beq	1f
>>  	not	r5,r5
>>  1:
>> @@ -473,11 +473,7 @@ ht64_insert_pte:
>>  	lis	r0,_PAGE_HPTEFLAGS@h
>>  	ori	r0,r0,_PAGE_HPTEFLAGS@l
>>  	andc	r30,r30,r0
>> -#ifdef CONFIG_PPC_64K_PAGES
>> -	oris	r30,r30,_PAGE_HPTE_SUB0@h
>> -#else
>>  	ori	r30,r30,_PAGE_HASHPTE
>> -#endif
>>  	/* Phyical address in r5 */
>>  	rldicl	r5,r31,64-PTE_RPN_SHIFT,PTE_RPN_SHIFT
>>  	sldi	r5,r5,PAGE_SHIFT
>> diff --git a/arch/powerpc/mm/hugetlbpage-hash64.c b/arch/powerpc/mm/hugetlbpage-hash64.c
>> index d94b1af53a93..7584e8445512 100644
>> --- a/arch/powerpc/mm/hugetlbpage-hash64.c
>> +++ b/arch/powerpc/mm/hugetlbpage-hash64.c
>> @@ -91,11 +91,8 @@ int __hash_page_huge(unsigned long ea, unsigned long access, unsigned long vsid,
>>  		pa = pte_pfn(__pte(old_pte)) << PAGE_SHIFT;
>>  
>>  		/* clear HPTE slot informations in new PTE */
>> -#ifdef CONFIG_PPC_64K_PAGES
>> -		new_pte = (new_pte & ~_PAGE_HPTEFLAGS) | _PAGE_HPTE_SUB0;
>> -#else
>>  		new_pte = (new_pte & ~_PAGE_HPTEFLAGS) | _PAGE_HASHPTE;
>> -#endif
>> +
>>  		/* Add in WIMG bits */
>>  		rflags |= (new_pte & (_PAGE_WRITETHRU | _PAGE_NO_CACHE |
>>  				      _PAGE_COHERENT | _PAGE_GUARDED));
>> diff --git a/arch/powerpc/mm/pgtable_64.c b/arch/powerpc/mm/pgtable_64.c
>> index d692ae31cfc7..3967e3cce03e 100644
>> --- a/arch/powerpc/mm/pgtable_64.c
>> +++ b/arch/powerpc/mm/pgtable_64.c
>> @@ -625,7 +625,7 @@ void pmdp_splitting_flush(struct vm_area_struct *vma,
>>  	"1:	ldarx	%0,0,%3\n\
>>  		andi.	%1,%0,%6\n\
>>  		bne-	1b \n\
>> -		ori	%1,%0,%4 \n\
>> +		oris	%1,%0,%4@h \n\
>
> Why is this change required ?


Because _PAGE_SPLITTING is beyond 16 bits now ?

-aneesh

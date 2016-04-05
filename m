Return-Path: <bsingharora@gmail.com>
Received: from mail-pa0-x234.google.com (mail-pa0-x234.google.com
 [IPv6:2607:f8b0:400e:c03::234])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qfDlK4Yw5zDq6R
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  5 Apr 2016 13:25:49 +1000 (AEST)
Received: by mail-pa0-x234.google.com with SMTP id tt10so1156082pab.3
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 04 Apr 2016 20:25:49 -0700 (PDT)
Subject: Re: [PATCH 02/65] powerpc/mm: use _PAGE_READ to indicate Read access
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
 benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au
References: <1459067053-10835-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <1459067053-10835-2-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <56FC75F0.9010500@gmail.com> <87shz1xw2q.fsf@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org
From: Balbir Singh <bsingharora@gmail.com>
Message-ID: <57033035.8040904@gmail.com>
Date: Tue, 5 Apr 2016 13:25:41 +1000
MIME-Version: 1.0
In-Reply-To: <87shz1xw2q.fsf@linux.vnet.ibm.com>
Content-Type: text/plain; charset=windows-1252
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



On 05/04/16 00:55, Aneesh Kumar K.V wrote:
> Balbir Singh <bsingharora@gmail.com> writes:
>
>> [ text/plain ]
>>
>>
>> On 27/03/16 19:23, Aneesh Kumar K.V wrote:
>>> This split _PAGE_RW bit to _PAGE_READ and _PAGE_WRITE. It also remove
>>> the dependency on _PAGE_USER for implying read only. Few things to note
>>> here is that, we have read implied with write and execute permission.
>>> Hence we should always find _PAGE_READ set on hash pte fault.
>>>
>>> We still can't switch PROT_NONE to !(_PAGE_RWX). Auto numa do depend
>>> on marking a prot none pte _PAGE_WRITE. (For more details look at
>>> b191f9b106ea "mm: numa: preserve PTE write permissions across a NUMA hinting fault")
>>>
> ......
>
>
>>> diff --git a/arch/powerpc/mm/hash_utils_64.c b/arch/powerpc/mm/hash_utils_64.c
>>> index 90dd9280894f..ea23403b3fc0 100644
>>> --- a/arch/powerpc/mm/hash_utils_64.c
>>> +++ b/arch/powerpc/mm/hash_utils_64.c
>>> @@ -175,8 +175,9 @@ unsigned long htab_convert_pte_flags(unsigned long pteflags)
>>>  	 * or PP=0x3 for read-only (including writeable but clean pages).
>>>  	 */
>>>  	if (pteflags & _PAGE_USER) {
>>> -		rflags |= 0x2;
>>> -		if (!((pteflags & _PAGE_RW) && (pteflags & _PAGE_DIRTY)))
>>> +		if (pteflags & _PAGE_RWX)
>> Should this be pteflags & _PAGE_RW?
> That will work, because we always have _PAGE_READ set for _PAGE_EXEC.
> But what we really need to check here is READ/WRITE/EXEC.
Does READ/WRITE matter for pp bits?

>
>>> +			rflags |= 0x2;
>>> +		if (!((pteflags & _PAGE_WRITE) && (pteflags & _PAGE_DIRTY)))
>>>  			rflags |= 0x1;
>> if pteflags == _PAGE_USER | _PAGE_WRITE | _PAGE_DIRTY, what is rflags set to?
>>
>
> rflags will be 0x2. and for readlyonly 0x3. That is documented above. 
Yep the comment says that, I  think the comment can enhanced to add more information

For example

pp = 0x3 for PAGE_READ | PAGE_EXEC (read-only)
pp = 0x2 if the page is writable (read-write)



>
>
>>
>>>  	}
>>>  	/*
>>> @@ -1205,7 +1206,7 @@ EXPORT_SYMBOL_GPL(hash_page);
>>>  int __hash_page(unsigned long ea, unsigned long msr, unsigned long trap,
>>>  		unsigned long dsisr)
>>>  {
>>> -	unsigned long access = _PAGE_PRESENT;
>>> +	unsigned long access = _PAGE_PRESENT | _PAGE_READ;
>>>  	unsigned long flags = 0;
>>>  	struct mm_struct *mm = current->mm;
>
> ....
>
>>> diff --git a/arch/powerpc/mm/pgtable.c b/arch/powerpc/mm/pgtable.c
>>> index 83dfd7925c72..98b5c03e344d 100644
>>> --- a/arch/powerpc/mm/pgtable.c
>>> +++ b/arch/powerpc/mm/pgtable.c
>>> @@ -177,8 +177,8 @@ void set_pte_at(struct mm_struct *mm, unsigned long addr, pte_t *ptep,
>>>  	 * _PAGE_PRESENT, but we can be sure that it is not in hpte.
>>>  	 * Hence we can use set_pte_at for them.
>>>  	 */
>>> -	VM_WARN_ON((pte_val(*ptep) & (_PAGE_PRESENT | _PAGE_USER)) ==
>>> -		(_PAGE_PRESENT | _PAGE_USER));
>>> +	VM_WARN_ON(pte_present(*ptep) && !pte_protnone(*ptep));
>>> +
>> What was wrong with the previous check? The compiler will optimize it, but the new
>> check uses two pte_val() calls on *ptep
> That was confusing, even though we documented it clearly above, it does
> confuse, because checking for _PAGE_USER is an indirect hint for prot
> numa ptes.
>
>
>>>  	/*
>>>  	 * Add the pte bit when tryint set a pte
>>>  	 */
>>> diff --git a/arch/powerpc/mm/pgtable_64.c b/arch/powerpc/mm/pgtable_64.c
>>> index aa742aa35b64..00d8d985bba3 100644
>>> --- a/arch/powerpc/mm/pgtable_64.c
>>> +++ b/arch/powerpc/mm/pgtable_64.c
>>> @@ -277,7 +277,7 @@ void __iomem * ioremap_prot(phys_addr_t addr, unsigned long size,
>>>  	void *caller = __builtin_return_address(0);
>>>  
>>>  	/* writeable implies dirty for kernel addresses */
>>> -	if (flags & _PAGE_RW)
>>> +	if (flags & _PAGE_WRITE)
>>>  		flags |= _PAGE_DIRTY;
>>>  
>>>  	/* we don't want to let _PAGE_USER and _PAGE_EXEC leak out */
>>> @@ -681,8 +681,7 @@ void set_pmd_at(struct mm_struct *mm, unsigned long addr,
>>>  		pmd_t *pmdp, pmd_t pmd)
>>>  {
>>>  #ifdef CONFIG_DEBUG_VM
>>> -	WARN_ON((pmd_val(*pmdp) & (_PAGE_PRESENT | _PAGE_USER)) ==
>>> -		(_PAGE_PRESENT | _PAGE_USER));
>>> +	WARN_ON(pte_present(pmd_pte(*pmdp)) && !pte_protnone(pmd_pte(*pmdp)));
>> Same as above, plus I think we can move these to VM_WARN_ON just to be consistent
> We already have #ifdef CONFIG_DEBUG_VM around, hence we can avoid using
> VM_WARN_ON.
-just nit-picking
Balbir Singh

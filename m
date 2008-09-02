Return-Path: <becky.bruce@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 4C90ADDE22
	for <linuxppc-dev@ozlabs.org>; Wed,  3 Sep 2008 02:19:59 +1000 (EST)
Message-Id: <44677536-2308-40AF-8844-7192489664B9@freescale.com>
From: Becky Bruce <becky.bruce@freescale.com>
To: benh@kernel.crashing.org
In-Reply-To: <1220246399.13010.25.camel@pasglop>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v926)
Subject: Re: [PATCH v2] POWERPC: Allow 32-bit pgtable code to support 36-bit
	physical
Date: Tue, 2 Sep 2008 11:19:49 -0500
References: <1219876690-21163-1-git-send-email-becky.bruce@freescale.com>
	<1220246399.13010.25.camel@pasglop>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Sep 1, 2008, at 12:19 AM, Benjamin Herrenschmidt wrote:

Thanks for taking the time to dig through this :)

>
>> +#ifdef CONFIG_PTE_64BIT
>> +#define PTE_FLAGS_OFFSET	4	/* offset of PTE flags, in bytes */
>> +#define LNX_PTE_SIZE		8	/* size of a linux PTE, in bytes */
>> +#else
>> +#define PTE_FLAGS_OFFSET	0
>> +#define LNX_PTE_SIZE		4
>> +#endif
>
> s/LNX_PTE_SIZE/PTE_BYTES or PTE_SIZE, no need for that horrible LNX
> prefix. In fact, if it's only used by the asm, then ditch it and
> have asm-offsets.c create something based on sizeof(pte_t).

The reason I did that was to distinguish between the size of a  
software PTE entry, and the actual size of the hardware entry.  In the  
case of 36b physical, the hardware PTE size is the same as it always  
is; but we've grown the Linux PTE.  We can call it something else, or  
I can change as you suggest; I was worried that the next person to  
come along might get confused.  I suppose there aren't too many of us  
that are crazy enough to muck around in this code, so maybe it's not  
that big of a deal.

>
>
>> #define pte_none(pte)		((pte_val(pte) & ~_PTE_NONE_MASK) == 0)
>> #define pte_present(pte)	(pte_val(pte) & _PAGE_PRESENT)
>> -#define pte_clear(mm,addr,ptep)	do { pte_update(ptep, ~0, 0); }  
>> while (0)
>> +#define pte_clear(mm, addr, ptep) \
>> +	do { pte_update(ptep, ~_PAGE_HASHPTE, 0); } while (0)
>
> Where does this previous definition of pte_clear comes from ? It's  
> bogus
> (and it's not like that upstream). Your "updated" ones looks ok  
> though.
>
> But whatever tree has the "previous" one would break hash based ppc32
> if merged or is there some other related changes in Kumar tree that
> make the above safe ?

That's from Kumar's tree of changes for BookE.... he'll need to answer  
that.  I think he put out a patchset with that work; not sure if it  
was correct in this particular or not.

>
>
>> #define pmd_none(pmd)		(!pmd_val(pmd))
>> #define	pmd_bad(pmd)		(pmd_val(pmd) & _PMD_BAD)
>> @@ -664,8 +670,30 @@ static inline void set_pte_at(struct mm_struct  
>> *mm, unsigned long addr,
>> 			      pte_t *ptep, pte_t pte)
>> {
>> #if _PAGE_HASHPTE != 0
>> +#ifndef CONFIG_PTE_64BIT
>> 	pte_update(ptep, ~_PAGE_HASHPTE, pte_val(pte) & ~_PAGE_HASHPTE);
>> #else
>> +	/*
>> +	 * We have to do the write of the 64b pte as 2 stores.  This
>> +	 * code assumes that the entry we're storing to is currently
>> +	 * not valid and that all callers have the page table lock.
>> +	 * Having the entry be not valid protects readers who might read
>> +	 * between the first and second stores.
>> +	 */
>> +	unsigned int tmp;
>
> Do you know for sure the entry isn't valid ? On ppc64, we explicitely
> test for that and if it was valid, we clear and flush it. The generic
> code has been going on and off about calling set_pte_at() on an  
> already
> valid PTE, I wouldn't rely too much on it guaranteeing it will not
> happen. The 32b PTE code is safe because it preserves _PAGE_HASHPTE .

IIRC, we discussed this at some point, months ago, and decided this  
was the case. If it *can* be valid, and it's possible to have a reader  
on another cpu, I think we end up having to go through a very gross  
sequence where we have to mark it invalid before we start mucking  
around with it; otherwise a reader can get half-and-half.  Perhaps I'm  
missing a key restriction here?

>
>
> Note also that once you have (which you don't now) the guarantee
> that your previous PTE is invalid, then you can safely do two normal
> stores instead of a lwarx/stwcx. loop. In any case, having the stw in
> the middle of the loop doesn't sound very useful.

If the pte is invalid, and we're SMP, we need the store to the high  
word to occur before the stwcx that sets the valid bit, unless you're  
certain we can't have a reader on another cpu.  If we're not SMP, then  
I agree, let's move that store.

I thought we discussed at some point the possibility that there might  
be an updater on another CPU?  Is this not possible?  If not, I'll  
change it.  The existing code is also lwarx/stwcxing via pte_update();  
is there no reason for that?  We should probably change that as well,  
if that's the case.

>
>
>> +	__asm__ __volatile__("\
>> +1:	lwarx	%0,0,%4\n\
>> +	rlwimi	%L2,%0,0,30,30\n\
>> +	stw	%2,0(%3)\n\
>> +	eieio\n\
>> +	stwcx.  %L2,0,%4\n\
>> +	bne-	1b"
>> +	: "=&r" (tmp), "=m" (*ptep)
>> +	: "r" (pte), "r" (ptep), "r" ((unsigned long)(ptep) + 4),  
>> "m" (*ptep)
>> +	: "cc");
>> +#endif	/* CONFIG_PTE_64BIT */
>> +#else /* _PAGE_HASHPTE == 0 */
>> #if defined(CONFIG_PTE_64BIT) && defined(CONFIG_SMP)
>> 	__asm__ __volatile__("\
>> 		stw%U0%X0 %2,%0\n\
>> diff --git a/arch/powerpc/mm/hash_low_32.S b/arch/powerpc/mm/ 
>> hash_low_32.S
>> index b9ba7d9..d63e20a 100644
>> --- a/arch/powerpc/mm/hash_low_32.S
>> +++ b/arch/powerpc/mm/hash_low_32.S
>> @@ -75,7 +75,7 @@ _GLOBAL(hash_page_sync)
>>  * Returns to the caller if the access is illegal or there is no
>>  * mapping for the address.  Otherwise it places an appropriate PTE
>>  * in the hash table and returns from the exception.
>> - * Uses r0, r3 - r8, ctr, lr.
>> + * Uses r0, r3 - r8, r10, ctr, lr.
>>  */
>> 	.text
>> _GLOBAL(hash_page)
>> @@ -106,9 +106,15 @@ _GLOBAL(hash_page)
>> 	addi	r5,r5,swapper_pg_dir@l	/* kernel page table */
>> 	rlwimi	r3,r9,32-12,29,29	/* MSR_PR -> _PAGE_USER */
>> 112:	add	r5,r5,r7		/* convert to phys addr */
>> +#ifndef CONFIG_PTE_64BIT
>> 	rlwimi	r5,r4,12,20,29		/* insert top 10 bits of address */
>> 	lwz	r8,0(r5)		/* get pmd entry */
>> 	rlwinm.	r8,r8,0,0,19		/* extract address of pte page */
>> +#else
>> +	rlwinm	r8,r4,13,19,29		/* Compute pgdir/pmd offset */
>> +	lwzx	r8,r8,r5		/* Get L1 entry */
>> +	rlwinm. r8,r8,0,0,20		/* extract pt base address */
>> +#endif
>
> Any reason you wrote the above using a different technique ? If you
> believe that rlwinm/lwzx is going to be more efficient than rlwimi/ 
> lwz,
> maybe we should fix the old one ... or am I missing something totally
> obvious ? :-)

Nothing so exciting there - I borrowed this code from the BookE  
version.  I'm happy to change it.

Thanks, Ben!

Cheers,
Becky

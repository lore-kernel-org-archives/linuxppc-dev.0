Return-Path: <becky.bruce@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 20D80DE296
	for <linuxppc-dev@ozlabs.org>; Fri, 29 Aug 2008 01:36:49 +1000 (EST)
Received: from az33smr01.freescale.net (az33smr01.freescale.net [10.64.34.199])
	by az33egw02.freescale.net (8.12.11/az33egw02) with ESMTP id
	m7SFaiiR004692
	for <linuxppc-dev@ozlabs.org>; Thu, 28 Aug 2008 08:36:44 -0700 (MST)
Message-Id: <C16F93B0-766C-43E8-B4B5-40BC0FEE298F@freescale.com>
From: Becky Bruce <becky.bruce@freescale.com>
To: Scott Wood <scottwood@freescale.com>
In-Reply-To: <48B5E6B7.3000903@freescale.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v926)
Subject: Re: [PATCH v2] POWERPC: Allow 32-bit pgtable code to support 36-bit
	physical
Date: Thu, 28 Aug 2008 10:36:43 -0500
References: <1219876690-21163-1-git-send-email-becky.bruce@freescale.com>
	<48B5E6B7.3000903@freescale.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Aug 27, 2008, at 6:43 PM, Scott Wood wrote:

> Becky Bruce wrote:
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
>> +
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
>
> Could the stw to the same reservation granule as the stwcx cancel  
> the reservation on some implementations?  P

Not on the same processor.

> lus, if you're assuming that the entry is currently invalid and all  
> callers have the page table lock, do we need the lwarx/stwcx at  
> all?  At the least, it should check PTE_ATOMIC_UPDATES.

I'm pretty sure I went through this in great detail at one point and  
concluded that I did in fact need the lwarx/stwcx.  IIRC, it has to do  
with other non-set_pte_at writers not necessarily holding the page  
table lock. FYI, the existing 32-bit PTE code is doing atomic updates  
as well.

About PTE_ATOMIC_UPDATES, I didn't add that in because hashed page  
table implementations require atomic updates.  Adding it in would  
create another clause in that code, because I would still need to  
order the operations with a 64-bit PTE and I can't call pte_update as  
it only changes the low word of the pte.   I wasn't feeling too keen  
on adding untested pagetable code into the kernel :)  I can add it if  
the peanut gallery wants it, but I'll be marking it with a big fat  
"BUYER BEWARE".


>
>
> %2 should be "+&r", not "r".
>
>> diff --git a/arch/powerpc/platforms/Kconfig.cputype b/arch/powerpc/ 
>> platforms/Kconfig.cputype
>> index 7f65127..ca5b58b 100644
>> --- a/arch/powerpc/platforms/Kconfig.cputype
>> +++ b/arch/powerpc/platforms/Kconfig.cputype
>> @@ -128,18 +128,22 @@ config FSL_EMB_PERFMON
>>  config PTE_64BIT
>> 	bool
>> -	depends on 44x || E500
>> +	depends on 44x || E500 || 6xx
>> 	default y if 44x
>> -	default y if E500 && PHYS_64BIT
>> +	default y if PHYS_64BIT
>
> How is this different from PHYS_64BIT?

One is the width of the PTE and one is the width of a physical  
address.  It's entirely plausible to have a 64-bit PTE because you  
have a bunch of status bits, and only have 32-bit physical  
addressing.  That's why there are 2 options.

>
>
>> config PHYS_64BIT
>> -	bool 'Large physical address support' if E500
>> -	depends on 44x || E500
>> +	bool 'Large physical address support' if E500 || 6xx
>
> Maybe "if !44x", or have 44x "select" this, rather than listing all  
> arches where it's optional.

Not sure exactly what you're suggesting here........

>
>
>> +	depends on 44x || E500 || 6xx
>> 	select RESOURCES_64BIT
>> 	default y if 44x
>> 	---help---
>> 	  This option enables kernel support for larger than 32-bit physical
>> -	  addresses.  This features is not be available on all e500 cores.
>> +	  addresses.  This features is not be available on all cores.
>
> "This features is not be"?

Heh, I didn't type that :)  But I can fix it.

Thanks,
B

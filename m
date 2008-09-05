Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 5BBE5DDE17
	for <linuxppc-dev@ozlabs.org>; Sat,  6 Sep 2008 05:44:50 +1000 (EST)
Message-Id: <828A65C6-A5DD-41C6-BA38-25BE04D76AA2@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: benh@kernel.crashing.org
In-Reply-To: <1220497970.4879.36.camel@pasglop>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v926)
Subject: Re: [PATCH v3 2/4] powerpc: Fixes for CONFIG_PTE_64BIT for SMP support
Date: Fri, 5 Sep 2008 14:44:44 -0500
References: <1220465344-16753-1-git-send-email-galak@kernel.crashing.org>
	<1220465344-16753-2-git-send-email-galak@kernel.crashing.org>
	<1220497970.4879.36.camel@pasglop>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Sep 3, 2008, at 10:12 PM, Benjamin Herrenschmidt wrote:

> On Wed, 2008-09-03 at 13:09 -0500, Kumar Gala wrote:
>> There are some minor issues with support 64-bit PTEs on a 32-bit  
>> processor
>> when dealing with SMP.
>>
>> * We need to order the stores in set_pte_at to make sure the flag  
>> word
>>  is set second.
>> * Change pte_clear to use pte_update so only the flag word is cleared
>>
>> Signed-off-by: Kumar Gala <galak@kernel.crashing.org>
>> ---
>>
>> Fixed pte_clear to not break on 6xx.
>
> Thanks :-)
>
>> static inline unsigned long long pte_update(pte_t *p,
>> 					    unsigned long clr,
>> 					    unsigned long set)
>> @@ -658,8 +656,17 @@ static inline void set_pte_at(struct mm_struct  
>> *mm, unsigned long addr,
>> #if _PAGE_HASHPTE != 0
>> 	pte_update(ptep, ~_PAGE_HASHPTE, pte_val(pte) & ~_PAGE_HASHPTE);
>> #else
>> +#if defined(CONFIG_PTE_64BIT) && defined(CONFIG_SMP)
>
> Minor nit, but there's #elif :-)
>
>> +	__asm__ __volatile__("\
>> +		stw%U0%X0 %2,%0\n\
>> +		eieio\n\
>> +		stw%U0%X0 %L2,%1"
>> +	: "=m" (*ptep), "=m" (*((unsigned char *)ptep+4))
>> +	: "r" (pte) : "memory");
>
> Any reason why it has to be in assembly ? Can gcc re-order stores  
> around
> eieio() if written in C ? I would hope not but heh ... it's gcc :-)

I'm leaving it asm.  Its more explicit and easier to read in my  
opinion and I don't give gcc a chance to screw us over.
>
> I also wonder if you should first ensure that the PTE is invalid and
> if not, clear it and flush the TLB page ... Or at least add a
> WARN_ON(pte_valid()) in case we get that wrong ...

I believe that's an issue since kmap_atomic() will call set_pte_at and  
have the valid bit set.

- k

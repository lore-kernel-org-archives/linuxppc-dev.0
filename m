Return-Path: <christophe.leroy@c-s.fr>
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40m8yC3tdQzF1Q6
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 16 May 2018 19:58:10 +1000 (AEST)
Subject: Re: [PATCH 09/17] powerpc: make __ioremap_caller() common to PPC32
 and PPC64
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
References: <cover.1525435203.git.christophe.leroy@c-s.fr>
 <457781f2de403852ba2a60257c3d9aca75c4d2c8.1525435203.git.christophe.leroy@c-s.fr>
 <87lgcusc6z.fsf@linux.vnet.ibm.com>
From: Christophe LEROY <christophe.leroy@c-s.fr>
Message-ID: <15126127-bf0d-c82f-040e-7578edf081c2@c-s.fr>
Date: Wed, 16 May 2018 11:58:05 +0200
MIME-Version: 1.0
In-Reply-To: <87lgcusc6z.fsf@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



Le 08/05/2018 à 11:56, Aneesh Kumar K.V a écrit :
> Christophe Leroy <christophe.leroy@c-s.fr> writes:
> 
>> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
>> ---
>>   arch/powerpc/include/asm/book3s/64/pgtable.h |   1 +
>>   arch/powerpc/mm/ioremap.c                    | 126 +++++++--------------------
>>   2 files changed, 34 insertions(+), 93 deletions(-)
>>
>> diff --git a/arch/powerpc/include/asm/book3s/64/pgtable.h b/arch/powerpc/include/asm/book3s/64/pgtable.h
>> index c5c6ead06bfb..2bebdd8302cb 100644
>> --- a/arch/powerpc/include/asm/book3s/64/pgtable.h
>> +++ b/arch/powerpc/include/asm/book3s/64/pgtable.h
>> @@ -18,6 +18,7 @@
>>   #define _PAGE_RO		0
>>   #define _PAGE_USER		0
>>   #define _PAGE_HWWRITE		0
>> +#define _PAGE_COHERENT		0
> 
> This is something I was trying to avoid when I split the headers. We do
> support _PAGE_USER it is !_PAGE_PRIVILEGED. It gets really confusing
> when we have these conflicting names because we are trying to make code
> common across platforms.

Euh ... Here patch adds _PAGE_COHERENT

_PAGE_USER was added some time ago.

Well, we have three cases:

BOOK3S64 and NOHASH32/8xx has _PAGE_PRIVILEGED and no _PAGE_USER
BOOKE has both _PAGE_PRIVILEGED and _PAGE_USER
Others have _PAGE_USER and no _PAGE_PRIVILEGED

So when giving user rights to a page, some will set _PAGE_USER, some 
will unset _PAGE_PRIVILEGED and some will do both.

_PAGE_USER and _PAGE_PRIVILEGED being used outside of the subarch headers,
- either we have to add uggly ifdefs
- or we can just make sure unused flags are set as 0, then  (x | 0) and 
(x & ~0) will do nothing and will be eliminated by the compiler.

Today, this is done in asm/pte-common.h. Unfortunately, all headers 
except book3s64 do include pte-common.

Another solution would be to make sure _PAGE_xxx flags are not used 
outside of subarch specific headers. That would mean having specific 
helpers defined in each subarch header, but is it really worth it ?




Lets take the exemple of an even more tricky one :
- Some subarchs have _PAGE_RW, others have _PAGE_RO instead. In 
addition, the 8xx has _PAGE_NA
- Book3s64 has _PAGE_READ and _PAGE_WRITE.
- In some places, _PAGE_RW has been redefined has _PAGE_READ | _PAGE_WRITE

It has really become pretty complex. Why having defined new flags 
instead of using _PAGE_RO for _PAGE_READ and _PAGE_RW for _PAGE_READ | 
_PAGE_WRITE ? Does it make any sense to have the possibility to set 
_PAGE_WRITE without _PAGE_READ ?


I feel like having simple generic code like:

	flags = (flags & ~_PAGE_PRIVILEGED) | _PAGE_USER;

is better than having almost same code duplicated in several places or 
ugly ifdefs like:

#if defined(CONFIG_BOOK3S64) || defined(CONFIG_PPC_8xx) || defined 
(CONFIG_BOOKE)
	flags &= ~_PAGE_PRIVILEGED;
#endif
#if !defined(CONFIG_BOOK3S64) && !defined(CONFIG_PPC_8xx)
	flags |= _PAGE_USER;
#endif


It looks to me that patch 
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=812fadcb941a81d1f3948b10a95a4dce663da3e4 
allowed a nice code simplification, don't you feel the same ?

Christophe

> 
> 
>>   
>>   #define _PAGE_EXEC		0x00001 /* execute permission */
>>   #define _PAGE_WRITE		0x00002 /* write access allowed */
>> diff --git a/arch/powerpc/mm/ioremap.c b/arch/powerpc/mm/ioremap.c
>> index 65d611d44d38..59be5dfcb3e9 100644
>> --- a/arch/powerpc/mm/ioremap.c
>> +++ b/arch/powerpc/mm/ioremap.c
>> @@ -33,95 +33,6 @@ unsigned long ioremap_bot;
>>   unsigned long ioremap_bot = IOREMAP_BASE;
>>   #endif
>>   
>> -#ifdef CONFIG_PPC32
>> -
>> -void __iomem *
>> -__ioremap_caller(phys_addr_t addr, unsigned long size, unsigned long flags,
>> -		 void *caller)
>> -{
>> -	unsigned long v, i;
>> -	phys_addr_t p;
>> -	int err;
>> -
>> -	/* Make sure we have the base flags */
>> -	if ((flags & _PAGE_PRESENT) == 0)
>> -		flags |= pgprot_val(PAGE_KERNEL);
>> -
>> -	/* Non-cacheable page cannot be coherent */
>> -	if (flags & _PAGE_NO_CACHE)
>> -		flags &= ~_PAGE_COHERENT;
>> -
>> -	/*
>> -	 * Choose an address to map it to.
>> -	 * Once the vmalloc system is running, we use it.
>> -	 * Before then, we use space going up from IOREMAP_BASE
>> -	 * (ioremap_bot records where we're up to).
>> -	 */
>> -	p = addr & PAGE_MASK;
>> -	size = PAGE_ALIGN(addr + size) - p;
>> -
>> -	/*
>> -	 * If the address lies within the first 16 MB, assume it's in ISA
>> -	 * memory space
>> -	 */
>> -	if (p < 16*1024*1024)
>> -		p += _ISA_MEM_BASE;
>> -
>> -#ifndef CONFIG_CRASH_DUMP
>> -	/*
>> -	 * Don't allow anybody to remap normal RAM that we're using.
>> -	 * mem_init() sets high_memory so only do the check after that.
>> -	 */
>> -	if (slab_is_available() && (p < virt_to_phys(high_memory)) &&
>> -	    page_is_ram(__phys_to_pfn(p))) {
>> -		printk("__ioremap(): phys addr 0x%llx is RAM lr %ps\n",
>> -		       (unsigned long long)p, __builtin_return_address(0));
>> -		return NULL;
>> -	}
>> -#endif
>> -
>> -	if (size == 0)
>> -		return NULL;
>> -
>> -	/*
>> -	 * Is it already mapped?  Perhaps overlapped by a previous
>> -	 * mapping.
>> -	 */
>> -	v = p_block_mapped(p);
>> -	if (v)
>> -		goto out;
>> -
>> -	if (slab_is_available()) {
>> -		struct vm_struct *area;
>> -		area = get_vm_area_caller(size, VM_IOREMAP, caller);
>> -		if (area == 0)
>> -			return NULL;
>> -		area->phys_addr = p;
>> -		v = (unsigned long) area->addr;
>> -	} else {
>> -		v = ioremap_bot;
>> -		ioremap_bot += size;
>> -	}
>> -
>> -	/*
>> -	 * Should check if it is a candidate for a BAT mapping
>> -	 */
>> -
>> -	err = 0;
>> -	for (i = 0; i < size && err == 0; i += PAGE_SIZE)
>> -		err = map_kernel_page(v+i, p+i, flags);
>> -	if (err) {
>> -		if (slab_is_available())
>> -			vunmap((void *)v);
>> -		return NULL;
>> -	}
>> -
>> -out:
>> -	return (void __iomem *) (v + ((unsigned long)addr & ~PAGE_MASK));
>> -}
>> -
>> -#else
>> -
>>   /**
>>    * __ioremap_at - Low level function to establish the page tables
>>    *                for an IO mapping
>> @@ -135,6 +46,10 @@ void __iomem * __ioremap_at(phys_addr_t pa, void *ea, unsigned long size,
>>   	if ((flags & _PAGE_PRESENT) == 0)
>>   		flags |= pgprot_val(PAGE_KERNEL);
>>   
>> +	/* Non-cacheable page cannot be coherent */
>> +	if (flags & _PAGE_NO_CACHE)
>> +		flags &= ~_PAGE_COHERENT;
>> +
>>   	/* We don't support the 4K PFN hack with ioremap */
>>   	if (flags & H_PAGE_4K_PFN)
>>   		return NULL;
>> @@ -187,6 +102,33 @@ void __iomem * __ioremap_caller(phys_addr_t addr, unsigned long size,
>>   	if ((size == 0) || (paligned == 0))
>>   		return NULL;
>>   
>> +	/*
>> +	 * If the address lies within the first 16 MB, assume it's in ISA
>> +	 * memory space
>> +	 */
>> +	if (IS_ENABLED(CONFIG_PPC32) && paligned < 16*1024*1024)
>> +		paligned += _ISA_MEM_BASE;
>> +
>> +	/*
>> +	 * Don't allow anybody to remap normal RAM that we're using.
>> +	 * mem_init() sets high_memory so only do the check after that.
>> +	 */
>> +	if (!IS_ENABLED(CONFIG_CRASH_DUMP) &&
>> +	    slab_is_available() && (paligned < virt_to_phys(high_memory)) &&
>> +	    page_is_ram(__phys_to_pfn(paligned))) {
>> +		printk("__ioremap(): phys addr 0x%llx is RAM lr %ps\n",
>> +		       (u64)paligned, __builtin_return_address(0));
>> +		return NULL;
>> +	}
>> +
>> +	/*
>> +	 * Is it already mapped?  Perhaps overlapped by a previous
>> +	 * mapping.
>> +	 */
>> +	ret = (void __iomem *)p_block_mapped(paligned);
>> +	if (ret)
>> +		goto out;
>> +
>>   	if (slab_is_available()) {
>>   		struct vm_struct *area;
>>   
>> @@ -205,14 +147,12 @@ void __iomem * __ioremap_caller(phys_addr_t addr, unsigned long size,
>>   		if (ret)
>>   			ioremap_bot += size;
>>   	}
>> -
>> +out:
>>   	if (ret)
>> -		ret += addr & ~PAGE_MASK;
>> +		ret += (unsigned long)addr & ~PAGE_MASK;
>>   	return ret;
>>   }
>>   
>> -#endif
>> -
>>   /*
>>    * Unmap an IO region and remove it from imalloc'd list.
>>    * Access to IO memory should be serialized by driver.
>> -- 
>> 2.13.3

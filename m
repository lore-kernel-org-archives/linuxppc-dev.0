Return-Path: <christophe.leroy@c-s.fr>
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wbnYZ2v9hzDqBJ
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 29 May 2017 16:55:14 +1000 (AEST)
Subject: Re: [PATCH v1 1/8] powerpc/lib/code-patching: Enhance code patching
To: Balbir Singh <bsingharora@gmail.com>, linuxppc-dev@lists.ozlabs.org,
 mpe@ellerman.id.au
Cc: naveen.n.rao@linux.vnet.ibm.com, ananth@linux.vnet.ibm.com,
 paulus@samba.org, rashmica.g@gmail.com
References: <20170525033650.10891-1-bsingharora@gmail.com>
 <20170525033650.10891-2-bsingharora@gmail.com>
 <58bd28a3-f9bf-4c27-8f5b-32377f3d5f9f@c-s.fr>
 <1496012325.21894.9.camel@gmail.com>
From: Christophe LEROY <christophe.leroy@c-s.fr>
Message-ID: <1f319400-a68d-ff1c-574f-8fddf9e9e739@c-s.fr>
Date: Mon, 29 May 2017 08:55:01 +0200
MIME-Version: 1.0
In-Reply-To: <1496012325.21894.9.camel@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



Le 29/05/2017 à 00:58, Balbir Singh a écrit :
> On Sun, 2017-05-28 at 16:29 +0200, christophe leroy wrote:
>>
>> Le 25/05/2017 à 05:36, Balbir Singh a écrit :
>>> Today our patching happens via direct copy and
>>> patch_instruction. The patching code is well
>>> contained in the sense that copying bits are limited.
>>>
>>> While considering implementation of CONFIG_STRICT_RWX,
>>> the first requirement is to a create another mapping
>>> that will allow for patching. We create the window using
>>> text_poke_area, allocated via get_vm_area(), which might
>>> be an overkill. We can do per-cpu stuff as well. The
>>> downside of these patches that patch_instruction is
>>> now synchornized using a lock. Other arches do similar
>>> things, but use fixmaps. The reason for not using
>>> fixmaps is to make use of any randomization in the
>>> future. The code also relies on set_pte_at and pte_clear
>>> to do the appropriate tlb flushing.
>>>
>>> Signed-off-by: Balbir Singh <bsingharora@gmail.com>
>>
>> [...]
>>
>>> +static int kernel_map_addr(void *addr)
>>> +{
>>> +	unsigned long pfn;
>>>   	int err;
>>>
>>> -	__put_user_size(instr, addr, 4, err);
>>> +	if (is_vmalloc_addr(addr))
>>> +		pfn = vmalloc_to_pfn(addr);
>>> +	else
>>> +		pfn = __pa_symbol(addr) >> PAGE_SHIFT;
>>> +
>>> +	err = map_kernel_page((unsigned long)text_poke_area->addr,
>>> +			(pfn << PAGE_SHIFT), _PAGE_KERNEL_RW | _PAGE_PRESENT);
>>
>> map_kernel_page() doesn't exist on powerpc32, so compilation fails.
>>
>> However a similar function exists and is called map_page()
>>
>> Maybe the below modification could help (not tested yet)
>>
>> Christophe
>>
> 
> Thanks, I'll try and get a compile, as an alternative how about
> 
> #ifdef CONFIG_PPC32
> #define map_kernel_page map_page
> #endif
> 

My preference goes to renaming the PPC32 function, first because the 
PPC64 name fits better, second because too many defines kills 
readability, third because two functions doing the same thing are worth 
being called the same, and fourth because we surely have opportunity to 
merge both functions on day.

Christophe

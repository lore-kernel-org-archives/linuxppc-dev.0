Return-Path: <khandual@linux.vnet.ibm.com>
Received: from e23smtp07.au.ibm.com (e23smtp07.au.ibm.com [202.81.31.140])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 336C11A1766
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  4 Feb 2016 21:57:23 +1100 (AEDT)
Received: from localhost
 by e23smtp07.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <khandual@linux.vnet.ibm.com>;
 Thu, 4 Feb 2016 20:57:22 +1000
Received: from d23relay06.au.ibm.com (d23relay06.au.ibm.com [9.185.63.219])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id 267882BB004D
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  4 Feb 2016 21:57:16 +1100 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay06.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u14AuvxC55640082
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 4 Feb 2016 21:57:05 +1100
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u14Auhhf016124
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 4 Feb 2016 21:56:43 +1100
Message-ID: <56B32E54.90307@linux.vnet.ibm.com>
Date: Thu, 04 Feb 2016 16:26:20 +0530
From: Anshuman Khandual <khandual@linux.vnet.ibm.com>
MIME-Version: 1.0
To: David Gibson <david@gibson.dropbear.id.au>
CC: lvivier@redhat.com, thuth@redhat.com, aik@ozlabs.ru, paulus@samba.org,
 linuxppc-dev@lists.ozlabs.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: Re: [RFCv2 5/9] arch/powerpc: Split hash page table sizing heuristic
 into a helper
References: <1454045043-25545-1-git-send-email-david@gibson.dropbear.id.au>
 <1454045043-25545-6-git-send-email-david@gibson.dropbear.id.au>
 <56AF0380.3020500@linux.vnet.ibm.com> <20160202010447.GC15080@voom.fritz.box>
In-Reply-To: <20160202010447.GC15080@voom.fritz.box>
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 02/02/2016 06:34 AM, David Gibson wrote:
> On Mon, Feb 01, 2016 at 12:34:32PM +0530, Anshuman Khandual wrote:
>> On 01/29/2016 10:53 AM, David Gibson wrote:
>>> htab_get_table_size() either retrieve the size of the hash page table (HPT)
>>> from the device tree - if the HPT size is determined by firmware - or
>>> uses a heuristic to determine a good size based on RAM size if the kernel
>>> is responsible for allocating the HPT.
>>>
>>> To support a PAPR extension allowing resizing of the HPT, we're going to
>>> want the memory size -> HPT size logic elsewhere, so split it out into a
>>> helper function.
>>>
>>> Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
>>> ---
>>>  arch/powerpc/include/asm/mmu-hash64.h |  3 +++
>>>  arch/powerpc/mm/hash_utils_64.c       | 30 +++++++++++++++++-------------
>>>  2 files changed, 20 insertions(+), 13 deletions(-)
>>>
>>> diff --git a/arch/powerpc/include/asm/mmu-hash64.h b/arch/powerpc/include/asm/mmu-hash64.h
>>> index 7352d3f..cf070fd 100644
>>> --- a/arch/powerpc/include/asm/mmu-hash64.h
>>> +++ b/arch/powerpc/include/asm/mmu-hash64.h
>>> @@ -607,6 +607,9 @@ static inline unsigned long get_kernel_vsid(unsigned long ea, int ssize)
>>>  	context = (MAX_USER_CONTEXT) + ((ea >> 60) - 0xc) + 1;
>>>  	return get_vsid(context, ea, ssize);
>>>  }
>>> +
>>> +unsigned htab_shift_for_mem_size(unsigned long mem_size);
>>> +
>>>  #endif /* __ASSEMBLY__ */
>>>  
>>>  #endif /* _ASM_POWERPC_MMU_HASH64_H_ */
>>> diff --git a/arch/powerpc/mm/hash_utils_64.c b/arch/powerpc/mm/hash_utils_64.c
>>> index e88a86e..d63f7dc 100644
>>> --- a/arch/powerpc/mm/hash_utils_64.c
>>> +++ b/arch/powerpc/mm/hash_utils_64.c
>>> @@ -606,10 +606,24 @@ static int __init htab_dt_scan_pftsize(unsigned long node,
>>>  	return 0;
>>>  }
>>>  
>>> -static unsigned long __init htab_get_table_size(void)
>>> +unsigned htab_shift_for_mem_size(unsigned long mem_size)
>>>  {
>>> -	unsigned long mem_size, rnd_mem_size, pteg_count, psize;
>>> +	unsigned memshift = __ilog2(mem_size);
>>> +	unsigned pshift = mmu_psize_defs[mmu_virtual_psize].shift;
>>> +	unsigned pteg_shift;
>>> +
>>> +	/* round mem_size up to next power of 2 */
>>> +	if ((1UL << memshift) < mem_size)
>>> +		memshift += 1;
>>> +
>>> +	/* aim for 2 pages / pteg */
>>
>> While here I guess its a good opportunity to write couple of lines
>> about why one PTE group for every two physical pages on the system,
> 
> Well, that don't really know, it's just copied from the existing code.

Aneesh, would you know why ?

> 
>> why minimum (1UL << 11 = 2048) number of PTE groups required,

Aneesh, would you know why ?

> 
> Ok.
> 
>> why
>> (1U << 7 = 128) entries per PTE group
> 
> Um.. what?  Because that's how big a PTEG is, I don't think
> re-explaining the HPT structure here is useful.

Agreed, though think some where these things should be macros not used
as hard coded numbers like this.

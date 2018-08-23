Return-Path: <christophe.leroy@c-s.fr>
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41wzt64j4szF2Py
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 23 Aug 2018 19:40:28 +1000 (AEST)
Subject: Re: [PATCH v2 3/4] powerpc/mm: fix a warning when a cache is common
 to PGD and hugepages
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 aneesh.kumar@linux.vnet.ibm.com
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
References: <2f96bf1a8df1091c642de099ed07c34b5ab9b90a.1534258290.git.christophe.leroy@c-s.fr>
 <4aaca2d27429e6bdadc340fd3b96e7c350c4b2f4.1534258290.git.christophe.leroy@c-s.fr>
 <6dea8d0c-c4ab-49aa-da26-a729c18fa818@linux.ibm.com>
 <006e5f33-b816-7508-faac-da26a860659c@c-s.fr>
 <3e6412ac-c645-908f-a3bb-c9a2a72f4b68@linux.ibm.com>
From: Christophe LEROY <christophe.leroy@c-s.fr>
Message-ID: <cb121f38-ac89-4971-fd84-5473e7e9ced5@c-s.fr>
Date: Thu, 23 Aug 2018 11:40:22 +0200
MIME-Version: 1.0
In-Reply-To: <3e6412ac-c645-908f-a3bb-c9a2a72f4b68@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



Le 22/08/2018 à 16:20, Aneesh Kumar K.V a écrit :
> On 08/17/2018 04:14 PM, Christophe LEROY wrote:
>>
>>
>> Le 17/08/2018 à 05:32, Aneesh Kumar K.V a écrit :
>>> On 08/14/2018 08:24 PM, Christophe Leroy wrote:
>>>> While implementing TLB miss HW assistance on the 8xx, the following
>>>> warning was encountered:
>>>>
>>>> [  423.732965] WARNING: CPU: 0 PID: 345 at mm/slub.c:2412 
>>>> ___slab_alloc.constprop.30+0x26c/0x46c
>>>> [  423.733033] CPU: 0 PID: 345 Comm: mmap Not tainted 
>>>> 4.18.0-rc8-00664-g2dfff9121c55 #671
>>>> [  423.733075] NIP:  c0108f90 LR: c0109ad0 CTR: 00000004
>>>> [  423.733121] REGS: c455bba0 TRAP: 0700   Not tainted 
>>>> (4.18.0-rc8-00664-g2dfff9121c55)
>>>> [  423.733147] MSR:  00021032 <ME,IR,DR,RI>  CR: 24224848  XER: 
>>>> 20000000
>>>> [  423.733319]
>>>> [  423.733319] GPR00: c0109ad0 c455bc50 c4521910 c60053c0 007080c0 
>>>> c0011b34 c7fa41e0 c455be30
>>>> [  423.733319] GPR08: 00000001 c00103a0 c7fa41e0 c49afcc4 24282842 
>>>> 10018840 c079b37c 00000040
>>>> [  423.733319] GPR16: 73f00000 00210d00 00000000 00000001 c455a000 
>>>> 00000100 00000200 c455a000
>>>> [  423.733319] GPR24: c60053c0 c0011b34 007080c0 c455a000 c455a000 
>>>> c7fa41e0 00000000 00009032
>>>> [  423.734190] NIP [c0108f90] ___slab_alloc.constprop.30+0x26c/0x46c
>>>> [  423.734257] LR [c0109ad0] kmem_cache_alloc+0x210/0x23c
>>>> [  423.734283] Call Trace:
>>>> [  423.734326] [c455bc50] [00000100] 0x100 (unreliable)
>>>> [  423.734430] [c455bcc0] [c0109ad0] kmem_cache_alloc+0x210/0x23c
>>>> [  423.734543] [c455bcf0] [c0011b34] huge_pte_alloc+0xc0/0x1dc
>>>> [  423.734633] [c455bd20] [c01044dc] hugetlb_fault+0x408/0x48c
>>>> [  423.734720] [c455bdb0] [c0104b20] follow_hugetlb_page+0x14c/0x44c
>>>> [  423.734826] [c455be10] [c00e8e54] __get_user_pages+0x1c4/0x3dc
>>>> [  423.734919] [c455be80] [c00e9924] __mm_populate+0xac/0x140
>>>> [  423.735020] [c455bec0] [c00db14c] vm_mmap_pgoff+0xb4/0xb8
>>>> [  423.735127] [c455bf00] [c00f27c0] ksys_mmap_pgoff+0xcc/0x1fc
>>>> [  423.735222] [c455bf40] [c000e0f8] ret_from_syscall+0x0/0x38
>>>> [  423.735271] Instruction dump:
>>>> [  423.735321] 7cbf482e 38fd0008 7fa6eb78 7fc4f378 4bfff5dd 7fe3fb78 
>>>> 4bfffe24 81370010
>>>> [  423.735536] 71280004 41a2ff88 4840c571 4bffff80 <0fe00000> 
>>>> 4bfffeb8 81340010 712a0004
>>>> [  423.735757] ---[ end trace e9b222919a470790 ]---
>>>>
>>>> This warning occurs when calling kmem_cache_zalloc() on a
>>>> cache having a constructor.
>>>>
>>>> In this case it happens because PGD cache and 512k hugepte cache are
>>>> the same size (4k). While a cache with constructor is created for
>>>> the PGD, hugepages create cache without constructor and uses
>>>> kmem_cache_zalloc(). As both expect a cache with the same size,
>>>> the hugepages reuse the cache created for PGD, hence the conflict.
>>>>
>>>> In order to avoid this conflict, this patch:
>>>> - modifies pgtable_cache_add() so that a zeroising constructor is
>>>> added for any cache size.
>>>> - replaces calls to kmem_cache_zalloc() by kmem_cache_alloc()
>>>>
>>>
>>> Can't we just do kmem_cache_alloc with gfp flags __GFP_ZERO? and 
>>> remove the constructor completely?
>>
>> I don't understand what you mean. That's exactly what I did in v1 (by 
>> using kmem_cache_zalloc()), and you commented that doing this we would 
>> zeroise at allocation whereas the constructors are called when adding 
>> memory to the slab and when freeing the allocated block. Or did I 
>> misunderstood your comment ?
>>
>> static inline void *kmem_cache_zalloc(struct kmem_cache *k, gfp_t flags)
>> {
>>      return kmem_cache_alloc(k, flags | __GFP_ZERO);
>> }
>>
>>
> 
> I completely misunderstood kmem_cache_zalloc. I took it as we zero out 
> after each alloc. I guess your earlier patch is then good. We may want 
> to double check this, I haven't looked at the slab internals.

In fact no, you were right. When kmem_cache_alloc() is called with 
__GFP_ZERO, the object gets zeroised at allocation. This is done (at 
least in SLUB) at the end of function slab_alloc_node()

> 
> What we want is to make sure when we add new memory to slab, we want it 
> zeroed. If we are allocating objects from existing slab memory pool, we 
> don't need to zero out, because when we release objects to slab we make 
> sure we clear it.

It looks like when we use constructors, they are called when adding an 
object to the slab and when releasing it back to the slab. So that's 
exactly what we want then, and therefore I have the feeling that we 
should go with this v2 approach.
Those constructors are tiny (most of them are 3 insns) and we have only 
16 cache sizes hence 16 constructors so it shoudln't be an issue to have 
unused ones.
The only small problème I have is that some version of GCC seems to 
complain about big memset() (132k and 256k ones). Is there a way to tell 
GCC we really want to do it ?

Christophe

> 
> -aneesh

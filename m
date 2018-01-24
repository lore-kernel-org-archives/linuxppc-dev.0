Return-Path: <christophe.leroy@c-s.fr>
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zRKr43GL1zDqGr
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 24 Jan 2018 20:39:16 +1100 (AEDT)
Subject: Re: [PATCH v3 5/5] powerpc/mm: Fix growth direction for hugepages
 mmaps with slice
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Scott Wood <oss@buserror.net>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
References: <6920f6efe2dcdabf59350b2d31ee6bd4bdef57f4.1516783089.git.christophe.leroy@c-s.fr>
 <362a93307a09b521878c47a8999a39a228184293.1516783089.git.christophe.leroy@c-s.fr>
 <c6eff627-9d86-dab1-e91e-9ea5a98c4c55@linux.vnet.ibm.com>
 <c532efa7-33a4-1f4f-e83a-5eaeba65b799@c-s.fr>
 <9aea8b6f-0d1a-b700-efe4-8efcebc5d16d@linux.vnet.ibm.com>
From: Christophe LEROY <christophe.leroy@c-s.fr>
Message-ID: <c6ca42a1-eae3-8f07-79e5-a71b3cdfea81@c-s.fr>
Date: Wed, 24 Jan 2018 10:39:11 +0100
MIME-Version: 1.0
In-Reply-To: <9aea8b6f-0d1a-b700-efe4-8efcebc5d16d@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



Le 24/01/2018 à 10:35, Aneesh Kumar K.V a écrit :
> 
> 
> On 01/24/2018 02:57 PM, Christophe LEROY wrote:
>>
>>
>> Le 24/01/2018 à 10:15, Aneesh Kumar K.V a écrit :
>>>
>>>
>>> On 01/24/2018 02:32 PM, Christophe Leroy wrote:
>>>> An application running with libhugetlbfs fails to allocate
>>>> additional pages to HEAP due to the hugemap being done
>>>> inconditionally as topdown mapping:
>>>>
>>>> mmap(0x10080000, 1572864, PROT_READ|PROT_WRITE, 
>>>> MAP_PRIVATE|MAP_ANONYMOUS|0x40000, -1, 0) = 0x73e80000
>>>> [...]
>>>> mmap(0x74000000, 1048576, PROT_READ|PROT_WRITE, 
>>>> MAP_PRIVATE|MAP_ANONYMOUS|0x40000, -1, 0x180000) = 0x73d80000
>>>> munmap(0x73d80000, 1048576)             = 0
>>>> [...]
>>>> mmap(0x74000000, 1572864, PROT_READ|PROT_WRITE, 
>>>> MAP_PRIVATE|MAP_ANONYMOUS|0x40000, -1, 0x180000) = 0x73d00000
>>>> munmap(0x73d00000, 1572864)             = 0
>>>> [...]
>>>> mmap(0x74000000, 1572864, PROT_READ|PROT_WRITE, 
>>>> MAP_PRIVATE|MAP_ANONYMOUS|0x40000, -1, 0x180000) = 0x73d00000
>>>> munmap(0x73d00000, 1572864)             = 0
>>>> [...]
>>>>
>>>> As one can see from the above strace log, mmap() allocates further
>>>> pages below the initial one because no space is available on top of it.
>>>>
>>>> This patch fixes it by requesting bottomup mapping as the non
>>>> generic hugetlb_get_unmapped_area() does
>>>>
>>>> Fixes: d0f13e3c20b6f ("[POWERPC] Introduce address space "slices" ")
>>>> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
>>>> ---
>>>>   v3: Was a standalone patch before, but conflicts with this serie.
>>>>
>>>>   arch/powerpc/mm/hugetlbpage.c | 2 +-
>>>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>>>
>>>> diff --git a/arch/powerpc/mm/hugetlbpage.c 
>>>> b/arch/powerpc/mm/hugetlbpage.c
>>>> index 79e1378ee303..368ea6b248ad 100644
>>>> --- a/arch/powerpc/mm/hugetlbpage.c
>>>> +++ b/arch/powerpc/mm/hugetlbpage.c
>>>> @@ -558,7 +558,7 @@ unsigned long hugetlb_get_unmapped_area(struct 
>>>> file *file, unsigned long addr,
>>>>           return radix__hugetlb_get_unmapped_area(file, addr, len,
>>>>                                  pgoff, flags);
>>>>   #endif
>>>> -    return slice_get_unmapped_area(addr, len, flags, mmu_psize, 1);
>>>> +    return slice_get_unmapped_area(addr, len, flags, mmu_psize, 0);
>>>>   }
>>>>   #endif
>>>
>>> Why make this change also for PPC64? Can you do this #ifdef 8xx?.You 
>>> can ideally move hugetlb_get_unmapped_area to slice.h and then make 
>>> this much simpler for 8xxx?
>>>
>>
>> Did you try with HUGETLB_MORECORE_HEAPBASE=0x11000000 on PPC64 as I 
>> suggested in my last email on this subject (22/01/2018 9:22) ?
> 
> 
> yes. The test ran fine for me

You tried with 0x30000000, it works as well on PPC32.

I'd really like you to try with 0x11000000 which is in the same slice as 
the 10020000-10030000 range.

Christophe

> 
> kvaneesh@ltctulc6a-p1:[~]$  HUGETLB_MORECORE=yes 
> HUGETLB_MORECORE_HEAPBASE=0x30000000 ./a.out
> 10000000-10010000 r-xp 00000000 fc:00 9044312 /home/kvaneesh/a.out
> 10010000-10020000 r--p 00000000 fc:00 9044312 /home/kvaneesh/a.out
> 10020000-10030000 rw-p 00010000 fc:00 9044312 /home/kvaneesh/a.out
> 30000000-33000000 rw-p 00000000 00:0d 1062697 /anon_hugepage (deleted)
> 33000000-35000000 rw-p 03000000 00:0d 1062698 /anon_hugepage (deleted)
> 35000000-37000000 rw-p 05000000 00:0d 1062699 /anon_hugepage (deleted)
> 7ffff7d60000-7ffff7f10000 r-xp 00000000 fc:00 9250090 
> /lib/powerpc64le-linux-gnu/libc-2.23.so
> 7ffff7f10000-7ffff7f20000 r--p 001a0000 fc:00 9250090 
> /lib/powerpc64le-linux-gnu/libc-2.23.so
> 7ffff7f20000-7ffff7f30000 rw-p 001b0000 fc:00 9250090 
> /lib/powerpc64le-linux-gnu/libc-2.23.so
> 7ffff7f40000-7ffff7f60000 r-xp 00000000 fc:00 10754812 
> /usr/lib/libhugetlbfs.so.0
> 7ffff7f60000-7ffff7f70000 r--p 00010000 fc:00 10754812 
> /usr/lib/libhugetlbfs.so.0
> 7ffff7f70000-7ffff7f80000 rw-p 00020000 fc:00 10754812 
> /usr/lib/libhugetlbfs.so.0
> 7ffff7f80000-7ffff7fa0000 r-xp 00000000 00:00 0 [vdso]
> 7ffff7fa0000-7ffff7fe0000 r-xp 00000000 fc:00 9250107 
> /lib/powerpc64le-linux-gnu/ld-2.23.so
> 7ffff7fe0000-7ffff7ff0000 r--p 00030000 fc:00 9250107 
> /lib/powerpc64le-linux-gnu/ld-2.23.so
> 7ffff7ff0000-7ffff8000000 rw-p 00040000 fc:00 9250107 
> /lib/powerpc64le-linux-gnu/ld-2.23.so
> 7ffffffd0000-800000000000 rw-p 00000000 00:00 0 [stack]
> 
> 
>>
>> Before doing anything specific to the PPC32/8xx, I'd like to be sure 
>> the issue is definitly only on PPC32.
>>
> 
> I am not sure I understand the problem correctly. If there is a free 
> space in the required range, both topdown/bottomup search should be able 
> to find it. Unless topdown found another free area suitable for hugetlb 
> allocation above. My take is we should not change the topdown to 
> bottomup without really understanding the failure scenarios.
> 
> -aneesh

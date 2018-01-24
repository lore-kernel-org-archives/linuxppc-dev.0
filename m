Return-Path: <christophe.leroy@c-s.fr>
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zRKZd62cpzDqjr
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 24 Jan 2018 20:27:37 +1100 (AEDT)
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
From: Christophe LEROY <christophe.leroy@c-s.fr>
Message-ID: <c532efa7-33a4-1f4f-e83a-5eaeba65b799@c-s.fr>
Date: Wed, 24 Jan 2018 10:27:33 +0100
MIME-Version: 1.0
In-Reply-To: <c6eff627-9d86-dab1-e91e-9ea5a98c4c55@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



Le 24/01/2018 à 10:15, Aneesh Kumar K.V a écrit :
> 
> 
> On 01/24/2018 02:32 PM, Christophe Leroy wrote:
>> An application running with libhugetlbfs fails to allocate
>> additional pages to HEAP due to the hugemap being done
>> inconditionally as topdown mapping:
>>
>> mmap(0x10080000, 1572864, PROT_READ|PROT_WRITE, 
>> MAP_PRIVATE|MAP_ANONYMOUS|0x40000, -1, 0) = 0x73e80000
>> [...]
>> mmap(0x74000000, 1048576, PROT_READ|PROT_WRITE, 
>> MAP_PRIVATE|MAP_ANONYMOUS|0x40000, -1, 0x180000) = 0x73d80000
>> munmap(0x73d80000, 1048576)             = 0
>> [...]
>> mmap(0x74000000, 1572864, PROT_READ|PROT_WRITE, 
>> MAP_PRIVATE|MAP_ANONYMOUS|0x40000, -1, 0x180000) = 0x73d00000
>> munmap(0x73d00000, 1572864)             = 0
>> [...]
>> mmap(0x74000000, 1572864, PROT_READ|PROT_WRITE, 
>> MAP_PRIVATE|MAP_ANONYMOUS|0x40000, -1, 0x180000) = 0x73d00000
>> munmap(0x73d00000, 1572864)             = 0
>> [...]
>>
>> As one can see from the above strace log, mmap() allocates further
>> pages below the initial one because no space is available on top of it.
>>
>> This patch fixes it by requesting bottomup mapping as the non
>> generic hugetlb_get_unmapped_area() does
>>
>> Fixes: d0f13e3c20b6f ("[POWERPC] Introduce address space "slices" ")
>> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
>> ---
>>   v3: Was a standalone patch before, but conflicts with this serie.
>>
>>   arch/powerpc/mm/hugetlbpage.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/arch/powerpc/mm/hugetlbpage.c 
>> b/arch/powerpc/mm/hugetlbpage.c
>> index 79e1378ee303..368ea6b248ad 100644
>> --- a/arch/powerpc/mm/hugetlbpage.c
>> +++ b/arch/powerpc/mm/hugetlbpage.c
>> @@ -558,7 +558,7 @@ unsigned long hugetlb_get_unmapped_area(struct 
>> file *file, unsigned long addr,
>>           return radix__hugetlb_get_unmapped_area(file, addr, len,
>>                                  pgoff, flags);
>>   #endif
>> -    return slice_get_unmapped_area(addr, len, flags, mmu_psize, 1);
>> +    return slice_get_unmapped_area(addr, len, flags, mmu_psize, 0);
>>   }
>>   #endif
> 
> Why make this change also for PPC64? Can you do this #ifdef 8xx?.You can 
> ideally move hugetlb_get_unmapped_area to slice.h and then make this 
> much simpler for 8xxx?
> 

Did you try with HUGETLB_MORECORE_HEAPBASE=0x11000000 on PPC64 as I 
suggested in my last email on this subject (22/01/2018 9:22) ?

Before doing anything specific to the PPC32/8xx, I'd like to be sure the 
issue is definitly only on PPC32.

Thanks,
Christophe

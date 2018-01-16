Return-Path: <christophe.leroy@c-s.fr>
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zLbl344v8zF0Sq
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 17 Jan 2018 03:48:31 +1100 (AEDT)
Subject: Re: [PATCH v2] powerpc/mm: Fix growth direction for hugepages mmaps
 with slice
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Scott Wood <oss@buserror.net>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
References: <20180109101810.2471D6C6CF@localhost.localdomain>
 <87wp0haizf.fsf@linux.vnet.ibm.com>
From: Christophe LEROY <christophe.leroy@c-s.fr>
Message-ID: <d5f6060f-3061-dc3c-66f7-3cec05d50169@c-s.fr>
Date: Tue, 16 Jan 2018 17:48:23 +0100
MIME-Version: 1.0
In-Reply-To: <87wp0haizf.fsf@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



Le 16/01/2018 à 17:03, Aneesh Kumar K.V a écrit :
> Christophe Leroy <christophe.leroy@c-s.fr> writes:
> 
>> An application running with libhugetlbfs fails to allocate
>> additional pages to HEAP due to the hugemap being done
>> inconditionally as topdown mapping:
>>
>> mmap(0x10080000, 1572864, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS|0x40000, -1, 0) = 0x73e80000
>> [...]
>> mmap(0x74000000, 1048576, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS|0x40000, -1, 0x180000) = 0x73d80000
>> munmap(0x73d80000, 1048576)             = 0
>> [...]
>> mmap(0x74000000, 1572864, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS|0x40000, -1, 0x180000) = 0x73d00000
>> munmap(0x73d00000, 1572864)             = 0
>> [...]
>> mmap(0x74000000, 1572864, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS|0x40000, -1, 0x180000) = 0x73d00000
>> munmap(0x73d00000, 1572864)             = 0
>> [...]
>>
> 
> Can you explain the failure details above. I am not sure I understand
> what to read from the above output.

libhugetlbfs first requests an area of size 1.5Mbytes, at address 0x10080000
mmap() returns an area at address 0x73e80000

Then libhugetlbfs requests an additional area on top of that, ie at 
address 0x74000000, to expand the heap.
But mmap() returns an area at address 0x73d80000, ie under the previous 
area.

This is not the behaviour when using the generic (ie without mm_slices) 
hugepages code, and this is not what libhugetlbfs expects for expending 
the heap.

> 
>> As one can see from the above strace log, mmap() allocates further
>> pages below the initial one.
>>
>> This patch fixes it by taking into account MAP_GROWSDOWN flag.
> 
> Rest of the kernel don't depend on that flag to select a topdown search
> or not. So what is special with hugetlb? IF we select legacy mmap that
> is when we select a bottomup search. Hugetlb on ppc64 always did a
> topdown search.

The generic hugepage code does a bottomup search. First page is 
allocated at address 0x30000000 and following pages are allocated at 
requested addresses when requested, then libhugetlbfs has no issue 
expanding the heap when required.

> 
>>
>> Fixes: d0f13e3c20b6f ("[POWERPC] Introduce address space "slices" ")
>> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
>> ---
>>   v2: Added missing include
>>
>>   arch/powerpc/mm/hugetlbpage.c | 4 +++-
>>   1 file changed, 3 insertions(+), 1 deletion(-)
>>
>> diff --git a/arch/powerpc/mm/hugetlbpage.c b/arch/powerpc/mm/hugetlbpage.c
>> index 79e1378ee303..0eadf9f199de 100644
>> --- a/arch/powerpc/mm/hugetlbpage.c
>> +++ b/arch/powerpc/mm/hugetlbpage.c
>> @@ -19,6 +19,7 @@
>>   #include <linux/moduleparam.h>
>>   #include <linux/swap.h>
>>   #include <linux/swapops.h>
>> +#include <linux/mman.h>
>>   #include <asm/pgtable.h>
>>   #include <asm/pgalloc.h>
>>   #include <asm/tlb.h>
>> @@ -558,7 +559,8 @@ unsigned long hugetlb_get_unmapped_area(struct file *file, unsigned long addr,
>>   		return radix__hugetlb_get_unmapped_area(file, addr, len,
>>   						       pgoff, flags);
>>   #endif
>> -	return slice_get_unmapped_area(addr, len, flags, mmu_psize, 1);
>> +	return slice_get_unmapped_area(addr, len, flags, mmu_psize,
>> +				       flags & MAP_GROWSDOWN);
>>   }
>>   #endif
>>   
>> -- 
>> 2.13.3

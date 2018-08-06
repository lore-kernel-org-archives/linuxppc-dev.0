Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41kVm76TmPzF3HG
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  6 Aug 2018 18:13:59 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Hari Bathini <hbathini@linux.vnet.ibm.com>,
 Mahesh Jagannath Salgaonkar <mahesh@linux.vnet.ibm.com>,
 Hari Bathini <hbathini@linux.ibm.com>
Cc: stable@vger.kernel.org, linuxppc-dev <linuxppc-dev@ozlabs.org>
Subject: Re: [PATCH] powerpc/fadump: handle crash memory ranges array overflow
In-Reply-To: <a552618a-64e0-6c54-29cd-7d8b49093350@linux.vnet.ibm.com>
References: <153304539025.23724.13483958866671131484.stgit@hbathini.in.ibm.com>
 <c0232b82-57d7-db09-6ddb-68370bee4ff2@linux.vnet.ibm.com>
 <a552618a-64e0-6c54-29cd-7d8b49093350@linux.vnet.ibm.com>
Date: Mon, 06 Aug 2018 18:13:56 +1000
Message-ID: <87effboqt7.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hari Bathini <hbathini@linux.vnet.ibm.com> writes:
> On Monday 06 August 2018 09:52 AM, Mahesh Jagannath Salgaonkar wrote:
>> On 07/31/2018 07:26 PM, Hari Bathini wrote:
>>> Crash memory ranges is an array of memory ranges of the crashing kernel
>>> to be exported as a dump via /proc/vmcore file. The size of the array
>>> is set based on INIT_MEMBLOCK_REGIONS, which works alright in most cases
>>> where memblock memory regions count is less than INIT_MEMBLOCK_REGIONS
>>> value. But this count can grow beyond INIT_MEMBLOCK_REGIONS value since
>>> commit 142b45a72e22 ("memblock: Add array resizing support").
>>>
...
>>>
>>> Fixes: 2df173d9e85d ("fadump: Initialize elfcore header and add PT_LOAD program headers.")
>>> Cc: stable@vger.kernel.org
>>> Cc: Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>
>>> Signed-off-by: Hari Bathini <hbathini@linux.ibm.com>
>>> ---
>>>   arch/powerpc/include/asm/fadump.h |    2 +
>>>   arch/powerpc/kernel/fadump.c      |   63 ++++++++++++++++++++++++++++++++++---
>>>   2 files changed, 59 insertions(+), 6 deletions(-)
>>>
>>> diff --git a/arch/powerpc/include/asm/fadump.h b/arch/powerpc/include/asm/fadump.h
>>> index 5a23010..ff708b3 100644
>>> --- a/arch/powerpc/include/asm/fadump.h
>>> +++ b/arch/powerpc/include/asm/fadump.h
>>> @@ -196,7 +196,7 @@ struct fadump_crash_info_header {
>>>   };
>>>
>>>   /* Crash memory ranges */
>>> -#define INIT_CRASHMEM_RANGES	(INIT_MEMBLOCK_REGIONS + 2)
>>> +#define INIT_CRASHMEM_RANGES	INIT_MEMBLOCK_REGIONS
>>>
>>>   struct fad_crash_memory_ranges {
>>>   	unsigned long long	base;
>>> diff --git a/arch/powerpc/kernel/fadump.c b/arch/powerpc/kernel/fadump.c
>>> index 07e8396..1c1df4f 100644
>>> --- a/arch/powerpc/kernel/fadump.c
>>> +++ b/arch/powerpc/kernel/fadump.c
...
>
>> Also alongwith this change, Should we also double the initial array size
>> (e.g. INIT_CRASHMEM_RANGES * 2) to reduce our chances to go for memory
>> allocation ?
>
> Agreed that doubling the static array size reduces the likelihood of the 
> need for
> dynamic array resizing. Will do that.
>
> Nonetheless, if we get to the point where 2K memory allocation fails on 
> a system with so many memory ranges, it is likely that the kernel has some basic 
> problems to deal with first :)

Yes, this all seems a bit silly. 

Why not just allocate a 64K page and be done with it?

AFAICS we're not being called too early to do that, and if you can't
allocate a single page then the system is going to OOM anyway.

cheers

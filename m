Return-Path: <christophe.leroy@c-s.fr>
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3r5kwq2GqnzDq7n
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 13 May 2016 19:25:31 +1000 (AEST)
Subject: Re: [PATCH v2 1/7] powerpc/8xx: Fix vaddr for IMMR early remap
To: Scott Wood <oss@buserror.net>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>
References: <cover.1462052179.git.christophe.leroy@c-s.fr>
 <79e1d41f9e91bc3450dac1e8a90c4fb07f031f84.1462052179.git.christophe.leroy@c-s.fr>
 <1462999096.16584.95.camel@buserror.net>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
From: Christophe Leroy <christophe.leroy@c-s.fr>
Message-ID: <7c0b4b7d-e0fe-0d04-6ada-eb49d460e784@c-s.fr>
Date: Fri, 13 May 2016 11:25:25 +0200
MIME-Version: 1.0
In-Reply-To: <1462999096.16584.95.camel@buserror.net>
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


Le 11/05/2016 à 22:38, Scott Wood a écrit :
> On Wed, 2016-05-11 at 17:03 +0200, Christophe Leroy wrote:
>> Memory: 124428K/131072K available (3748K kernel code, 188K rwdata,
>> 648K rodata, 508K init, 290K bss, 6644K reserved)
>> Kernel virtual memory layout:
>>    * 0xfffdf000..0xfffff000  : fixmap
>>    * 0xfde00000..0xfe000000  : consistent mem
>>    * 0xfddf6000..0xfde00000  : early ioremap
>>    * 0xc9000000..0xfddf6000  : vmalloc & ioremap
>> SLUB: HWalign=16, Order=0-3, MinObjects=0, CPUs=1, Nodes=1
>>
>> Today, IMMR is mapped 1:1 at startup
>>
>> Mapping IMMR 1:1 is just wrong because it may overlap with another
>> area. On most mpc8xx boards it is OK as IMMR is set to 0xff000000
>> but for instance on EP88xC board, IMMR is at 0xfa200000 which
>> overlaps with VM ioremap area
>>
>> This patch fixes the virtual address for remapping IMMR with the fixmap
>> regardless of the value of IMMR.
>>
>> The size of IMMR area is 256kbytes (CPM at offset 0, security engine
>> at offset 128k) so a 512k page is enough
>>
>> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
>> ---
>> v2: No change
>>
>>   arch/powerpc/include/asm/fixmap.h |  7 +++++++
>>   arch/powerpc/kernel/asm-offsets.c |  8 ++++++++
>>   arch/powerpc/kernel/head_8xx.S    | 11 ++++++-----
>>   arch/powerpc/mm/mmu_decl.h        |  7 +++++++
>>   arch/powerpc/sysdev/cpm_common.c  | 15 ++++++++++++---
>>   5 files changed, 40 insertions(+), 8 deletions(-)
>>
>> diff --git a/arch/powerpc/include/asm/fixmap.h
>> b/arch/powerpc/include/asm/fixmap.h
>> index 90f604b..4508b32 100644
>> --- a/arch/powerpc/include/asm/fixmap.h
>> +++ b/arch/powerpc/include/asm/fixmap.h
>> @@ -51,6 +51,13 @@ enum fixed_addresses {
>>   	FIX_KMAP_BEGIN,	/* reserved pte's for temporary kernel
>> mappings */
>>   	FIX_KMAP_END = FIX_KMAP_BEGIN+(KM_TYPE_NR*NR_CPUS)-1,
>>   #endif
>> +#ifdef CONFIG_PPC_8xx
>> +	/* For IMMR we need an aligned 512K area */
>> +#define FIX_IMMR_SIZE	(512 * 1024 / PAGE_SIZE)
>> +	FIX_IMMR_START,
>> +	FIX_IMMR_BASE = __ALIGN_MASK(FIX_IMMR_START, FIX_IMMR_SIZE - 1) - 1 +
>> +
>> +		       FIX_IMMR_SIZE,
>> +#endif
> What happens if FIX_IMMR_START is, for example, 0x100?  Then
> "__ALIGN_MASK(FIX_IMMR_START, FIX_IMMR_SIZE - 1) - 1" would be 0xff -- you've
> gone backwards.  FIX_IMMR_BASE would be 0x17f, translating to an address of
> 0xffe80000.  IMMR would end at 0xfff00000.  The kmap range would begin at
> 0xffeff000 and you'd have an overlap.
>
> I think what you want is:
> 	FIX_IMMR_BASE = (FIX_IMMR_START & ~(FIX_IMMR_SIZE - 1)) +
> 			FIX_IMMR_SIZE - 1,
>
Why would the kmap range begin at 0xffeff000 ?
If FIX_IMMR_START is 0x100, this means FIX_KMAP_END is 0x0ff, so the 
kmap range should begin at 0xfff00000, shouldn't it ?

Christophe

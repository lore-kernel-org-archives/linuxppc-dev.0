Return-Path: <christophe.leroy@c-s.fr>
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zLb1g13FszDr4v
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 17 Jan 2018 03:16:07 +1100 (AEDT)
Subject: Re: [PATCH 3/3] powerpc/8xx: Increase the number of mm slices
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Scott Wood <oss@buserror.net>, Nicholas Piggin <npiggin@gmail.com>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
References: <9a5dadc10f88e2fc0ac9fb5d18c5424df33f3f4c.1515169256.git.christophe.leroy@c-s.fr>
 <aed2799c8b369bd2ffba9967ed052e21d33e76f0.1515169256.git.christophe.leroy@c-s.fr>
 <87zi5dajgj.fsf@linux.vnet.ibm.com>
From: Christophe LEROY <christophe.leroy@c-s.fr>
Message-ID: <61ade5ee-b72e-edf6-6b5d-0d1b03e27cab@c-s.fr>
Date: Tue, 16 Jan 2018 17:16:02 +0100
MIME-Version: 1.0
In-Reply-To: <87zi5dajgj.fsf@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



Le 16/01/2018 à 16:53, Aneesh Kumar K.V a écrit :
> Christophe Leroy <christophe.leroy@c-s.fr> writes:
> 
>> On the 8xx, we can have as many slices as PMD entries.
>> This means we could have 1024 slices in 4k size pages mode
>> and 64 slices in 16k size pages.
>>
>> However, due to a stack overflow in slice_get_unmapped_area(),
>> we limit to 512 slices.
>>
>> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
>> ---
>>   arch/powerpc/include/asm/mmu-8xx.h | 6 +++++-
>>   arch/powerpc/include/asm/page_32.h | 3 ++-
>>   2 files changed, 7 insertions(+), 2 deletions(-)
>>
>> diff --git a/arch/powerpc/include/asm/mmu-8xx.h b/arch/powerpc/include/asm/mmu-8xx.h
>> index d669d0062da4..40aa7b0cd0dc 100644
>> --- a/arch/powerpc/include/asm/mmu-8xx.h
>> +++ b/arch/powerpc/include/asm/mmu-8xx.h
>> @@ -171,7 +171,11 @@ typedef struct {
>>   	unsigned long vdso_base;
>>   #ifdef CONFIG_PPC_MM_SLICES
>>   	u16 user_psize;		/* page size index */
>> -	unsigned char low_slices_psize[8]; /* 16 slices */
>> +#if defined(CONFIG_PPC_16K_PAGES)
>> +	unsigned char low_slices_psize[32]; /* 64 slices */
>> +#else
>> +	unsigned char low_slices_psize[256]; /* 512 slices */
>> +#endif
> 
> These #ifdef should be 8xx and then 16K.

We are in file asm/mmu-8xx.h so it obviously only applies to 8xx

Christophe

> 
> 
>>   	unsigned char high_slices_psize[0];
>>   	unsigned long slb_addr_limit;
>>   #endif
>> diff --git a/arch/powerpc/include/asm/page_32.h b/arch/powerpc/include/asm/page_32.h
>> index f7d1bd1183c8..43695ce7ee07 100644
>> --- a/arch/powerpc/include/asm/page_32.h
>> +++ b/arch/powerpc/include/asm/page_32.h
>> @@ -62,7 +62,8 @@ extern void copy_page(void *to, void *from);
>>   
>>   #ifdef CONFIG_PPC_MM_SLICES
>>   
>> -#define SLICE_LOW_SHIFT		28
>> +/* SLICE_LOW_SHIFT >= 23 to avoid stack overflow in slice_get_unmapped_area() */
>> +#define SLICE_LOW_SHIFT		(PMD_SHIFT > 23 ? PMD_SHIFT : 23)
>>   #define SLICE_HIGH_SHIFT	0
>>   
>>   #define SLICE_LOW_TOP		(0xfffffffful)
>> -- 
>> 2.13.3

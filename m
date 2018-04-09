Return-Path: <christophe.leroy@c-s.fr>
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40KPJX3kvXzDqhm
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  9 Apr 2018 18:55:08 +1000 (AEST)
Subject: Re: [PATCH V6 2/4] powerpc/mm: Add support for handling > 512TB
 address in SLB miss
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
 benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au
Cc: linuxppc-dev@lists.ozlabs.org
References: <20180326100450.18614-1-aneesh.kumar@linux.vnet.ibm.com>
 <20180326100450.18614-3-aneesh.kumar@linux.vnet.ibm.com>
 <e593156a-d06a-9f1d-c2d3-564553c24cce@c-s.fr>
 <d3d9108d-38a3-0caf-8944-4ee422090421@linux.ibm.com>
From: Christophe LEROY <christophe.leroy@c-s.fr>
Message-ID: <33974c11-ec3e-8f38-bb0f-59345b94cf7f@c-s.fr>
Date: Mon, 9 Apr 2018 10:55:00 +0200
MIME-Version: 1.0
In-Reply-To: <d3d9108d-38a3-0caf-8944-4ee422090421@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



Le 09/04/2018 à 10:33, Aneesh Kumar K.V a écrit :
> On 04/09/2018 12:49 PM, Christophe LEROY wrote:
>>
>>
>> Le 26/03/2018 à 12:04, Aneesh Kumar K.V a écrit :
>>> For addresses above 512TB we allocate additional mmu contexts. To make
>>> it all easy, addresses above 512TB are handled with IR/DR=1 and with
>>> stack frame setup.
>>>
>>> The mmu_context_t is also updated to track the new extended_ids. To
>>> support upto 4PB we need a total 8 contexts.
>>>
>>> Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
>>> [mpe: Minor formatting tweaks and comment wording, switch BUG to WARN
>>>        in get_ea_context().]
>>> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
>>
>> Compilation fails on mpc885_ads_defconfig + CONFIG_HUGETLBFS :
>>
>>    CC      arch/powerpc/mm/slice.o
>> arch/powerpc/mm/slice.c: In function 'slice_get_unmapped_area':
>> arch/powerpc/mm/slice.c:655:2: error: implicit declaration of function 
>> 'need_extra_context' [-Werror=implicit-function-declaration]
>> arch/powerpc/mm/slice.c:656:3: error: implicit declaration of function 
>> 'alloc_extended_context' [-Werror=implicit-function-declaration]
>> cc1: all warnings being treated as errors
>> make[1]: *** [arch/powerpc/mm/slice.o] Error 1
>> make: *** [arch/powerpc/mm] Error 2
> 
> 
> something like below?
> 
> diff --git a/arch/powerpc/mm/slice.c b/arch/powerpc/mm/slice.c
> index 9cd87d1..205fe55 100644
> --- a/arch/powerpc/mm/slice.c
> +++ b/arch/powerpc/mm/slice.c
> @@ -35,6 +35,7 @@
>   #include <asm/mmu.h>
>   #include <asm/copro.h>
>   #include <asm/hugetlb.h>
> +#include <asm/mmu_context.h>
> 
>   static DEFINE_SPINLOCK(slice_convert_lock);
> 
> 
> PPC64 was including that header via include/linux/pkeys.h

Yes compilation OK now.

Christophe

> 
> -aneesh

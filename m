Return-Path: <christophe.leroy@c-s.fr>
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40QQ6c1m7vzF20W
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 17 Apr 2018 22:48:55 +1000 (AEST)
Subject: Re: [PATCH] powerpc/8xx: Build fix with Hugetlbfs enabled
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
 benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au
Cc: linuxppc-dev@lists.ozlabs.org
References: <20180416112724.9677-1-aneesh.kumar@linux.ibm.com>
 <20180416112724.9677-2-aneesh.kumar@linux.ibm.com>
From: Christophe LEROY <christophe.leroy@c-s.fr>
Message-ID: <3f7e76ad-6d0c-4dc7-047c-94b35ebdac2d@c-s.fr>
Date: Tue, 17 Apr 2018 14:48:50 +0200
MIME-Version: 1.0
In-Reply-To: <20180416112724.9677-2-aneesh.kumar@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



Le 16/04/2018 à 13:27, Aneesh Kumar K.V a écrit :
> 8xx use slice code when hugetlbfs is enabled. We missed a header include on
> 8xx which resulted in the below build failure.
> 
> config: mpc885_ads_defconfig + CONFIG_HUGETLBFS
> 
>     CC      arch/powerpc/mm/slice.o
> arch/powerpc/mm/slice.c: In function 'slice_get_unmapped_area':
> arch/powerpc/mm/slice.c:655:2: error: implicit declaration of function 'need_extra_context' [-Werror=implicit-function-declaration]
> arch/powerpc/mm/slice.c:656:3: error: implicit declaration of function 'alloc_extended_context' [-Werror=implicit-function-declaration]
> cc1: all warnings being treated as errors
> make[1]: *** [arch/powerpc/mm/slice.o] Error 1
> make: *** [arch/powerpc/mm] Error 2
> 
> on PPC64 the mmu_context.h was included via linux/pkeys.h
> 
> CC: Christophe LEROY <christophe.leroy@c-s.fr>
> Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>

Tested-by: Christophe Leroy <christophe.leroy@c-s.fr>

> ---
>   arch/powerpc/mm/slice.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/arch/powerpc/mm/slice.c b/arch/powerpc/mm/slice.c
> index 9cd87d11fe4e..205fe557ca10 100644
> --- a/arch/powerpc/mm/slice.c
> +++ b/arch/powerpc/mm/slice.c
> @@ -35,6 +35,7 @@
>   #include <asm/mmu.h>
>   #include <asm/copro.h>
>   #include <asm/hugetlb.h>
> +#include <asm/mmu_context.h>
>   
>   static DEFINE_SPINLOCK(slice_convert_lock);
>   
> 

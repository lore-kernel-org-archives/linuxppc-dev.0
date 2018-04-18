Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40QrcK5SSbzF1s3
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 18 Apr 2018 15:42:41 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>, benh@kernel.crashing.org,
 paulus@samba.org
Cc: linuxppc-dev@lists.ozlabs.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
 Christophe LEROY <christophe.leroy@c-s.fr>
Subject: Re: [PATCH] powerpc/8xx: Build fix with Hugetlbfs enabled
In-Reply-To: <20180416112724.9677-2-aneesh.kumar@linux.ibm.com>
References: <20180416112724.9677-1-aneesh.kumar@linux.ibm.com>
 <20180416112724.9677-2-aneesh.kumar@linux.ibm.com>
Date: Wed, 18 Apr 2018 15:42:41 +1000
Message-ID: <87in8poysu.fsf@concordia.ellerman.id.au>
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

"Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com> writes:

> 8xx use slice code when hugetlbfs is enabled. We missed a header include on
> 8xx which resulted in the below build failure.
>
> config: mpc885_ads_defconfig + CONFIG_HUGETLBFS
>
>    CC      arch/powerpc/mm/slice.o
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
> ---
>  arch/powerpc/mm/slice.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/arch/powerpc/mm/slice.c b/arch/powerpc/mm/slice.c
> index 9cd87d11fe4e..205fe557ca10 100644
> --- a/arch/powerpc/mm/slice.c
> +++ b/arch/powerpc/mm/slice.c
> @@ -35,6 +35,7 @@
>  #include <asm/mmu.h>
>  #include <asm/copro.h>
>  #include <asm/hugetlb.h>
> +#include <asm/mmu_context.h>

I already merged this, didn't I?

cheers

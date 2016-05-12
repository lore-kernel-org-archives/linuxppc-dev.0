Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3r4xnD1dDLzDqBg
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 12 May 2016 12:31:12 +1000 (AEST)
Received: from e23smtp02.au.ibm.com (e23smtp02.au.ibm.com [202.81.31.144])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3r4xnD0JYlz9t0t
 for <linuxppc-dev@ozlabs.org>; Thu, 12 May 2016 12:31:12 +1000 (AEST)
Received: from localhost
 by e23smtp02.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Thu, 12 May 2016 12:31:10 +1000
Received: from d23relay10.au.ibm.com (d23relay10.au.ibm.com [9.190.26.77])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id 3D7DC3578052
 for <linuxppc-dev@ozlabs.org>; Thu, 12 May 2016 12:30:42 +1000 (EST)
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay10.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u4C2UIVc38273238
 for <linuxppc-dev@ozlabs.org>; Thu, 12 May 2016 12:30:26 +1000
Received: from d23av03.au.ibm.com (localhost [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u4C2TQNB019408
 for <linuxppc-dev@ozlabs.org>; Thu, 12 May 2016 12:29:26 +1000
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@ozlabs.org
Cc: alistair@popple.id.au
Subject: Re: [PATCH 2/2] powerpc: Fix crash at boot with CONFIG_PPC_RADIX_MMU=n
In-Reply-To: <1462949231-28355-2-git-send-email-mpe@ellerman.id.au>
References: <1462949231-28355-1-git-send-email-mpe@ellerman.id.au>
 <1462949231-28355-2-git-send-email-mpe@ellerman.id.au>
Date: Thu, 12 May 2016 07:59:08 +0530
Message-ID: <87mvnwhuvf.fsf@skywalker.in.ibm.com>
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

Michael Ellerman <mpe@ellerman.id.au> writes:

> Currently a kernel that is built with CONFIG_PPC_RADIX_MMU=n, and then
> booted on a 64-bit Hash MMU system will crash on the first SLB miss,
> typically with an oops something like:
>
>   Unrecoverable exception 4100 at c000000000969504
>   cpu 0x0: Vector: 4100  at [c000000000de78e0]
>       pc: c000000000969504: memmap_init_zone+0x160/0x2dc
>       lr: c0000000009694b0: memmap_init_zone+0x10c/0x2dc
>   ...
>   [c000000000de7b60] c000000000968ec8 init_currently_empty_zone+0x3c/0x11c (unreliable)
>   [c000000000de7bf0] c000000000969bc0 free_area_init_node+0x540/0x688
>   [c000000000de7cf0] c000000000c4b3b4 free_area_init_nodes+0x7b4/0x864
>   [c000000000de7df0] c000000000c2fce0 paging_init+0x88/0xa4
>   [c000000000de7e60] c000000000c2b49c setup_arch+0x29c/0x2ec
>   [c000000000de7f00] c000000000c23b7c start_kernel+0x88/0x524
>   [c000000000de7f90] c000000000008c60 start_here_common+0x20/0xa0
>
> This is caused by the branch in slb_miss_realmode() that jumps directly
> to the unrecoverable case when MMU_FTR_RADIX is set:
>
>   BEGIN_MMU_FTR_SECTION
>   	b	2f
>   END_MMU_FTR_SECTION_IFSET(MMU_FTR_RADIX)
>
> When CONFIG_PPC_RADIX_MMU=n, MMU_FTR_RADIX == 0, and so the test
> becomes:
>
> 	(cur_cpu_spec->mmu_features & 0) == 0
>
> Which is always true. This causes the branch to *not* be patched with a
> nop, which is incorrect.
>
> The root cause is my change to Aneesh's patch to make MMU_FTR_RADIX == 0
> when CONFIG_PPC_RADIX_MMU=n, which was designed to allow the
> radix_enabled() checks to compile out.
>
> We can achieve the same result (in fact identical code generation) by
> instead using MMU_FTRS_POSSIBLE and only adding MMU_FTR_RADIX to it when
> CONFIG_PPC_RADIX_MMU=y.
>
> Fixes: 418d145591b6 ("powerpc/mm/radix: Add MMU_FTR_RADIX")
> Reported-by: Alistair Popple <alistair@popple.id.au>
> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>

Reviewed-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>

> ---
>  arch/powerpc/include/asm/mmu.h | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
>
> diff --git a/arch/powerpc/include/asm/mmu.h b/arch/powerpc/include/asm/mmu.h
> index a5e37c93700b..ad68da9344c8 100644
> --- a/arch/powerpc/include/asm/mmu.h
> +++ b/arch/powerpc/include/asm/mmu.h
> @@ -91,11 +91,7 @@
>  /*
>   * Radix page table available
>   */
> -#ifdef CONFIG_PPC_RADIX_MMU
>  #define MMU_FTR_RADIX                  ASM_CONST(0x80000000)
> -#else
> -#define MMU_FTR_RADIX                  ASM_CONST(0)
> -#endif
>
>  /* MMU feature bit sets for various CPUs */
>  #define MMU_FTRS_DEFAULT_HPTE_ARCH_V2	\
> @@ -128,7 +124,11 @@ enum {
>  		MMU_FTR_USE_TLBRSRV | MMU_FTR_USE_PAIRED_MAS |
>  		MMU_FTR_NO_SLBIE_B | MMU_FTR_16M_PAGE | MMU_FTR_TLBIEL |
>  		MMU_FTR_LOCKLESS_TLBIE | MMU_FTR_CI_LARGE_PAGE |
> -		MMU_FTR_1T_SEGMENT | MMU_FTR_RADIX,
> +		MMU_FTR_1T_SEGMENT |
> +#ifdef CONFIG_PPC_RADIX_MMU
> +		MMU_FTR_RADIX |
> +#endif
> +		0
>  };
>
>  static inline int mmu_has_feature(unsigned long feature)
> -- 
> 2.5.0

Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sgVyX0V2NzDsnZ
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 23 Sep 2016 21:10:28 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Hari Bathini <hbathini@linux.vnet.ibm.com>
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
 Mahesh J Salgaonkar <mahesh@linux.vnet.ibm.com>
Subject: Re: [PATCH v2] powerpc/mm: export current mmu mode info
In-Reply-To: <147456009252.14735.18189822731283851598.stgit@hbathini.in.ibm.com>
References: <147456009252.14735.18189822731283851598.stgit@hbathini.in.ibm.com>
Date: Fri, 23 Sep 2016 21:10:27 +1000
Message-ID: <87y42i7ty4.fsf@concordia.ellerman.id.au>
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

> diff --git a/arch/powerpc/include/asm/mmu.h b/arch/powerpc/include/asm/mmu.h
> index e2fb408..558987c 100644
> --- a/arch/powerpc/include/asm/mmu.h
> +++ b/arch/powerpc/include/asm/mmu.h
> @@ -199,6 +199,21 @@ static inline void mmu_clear_feature(unsigned long feature)
>  
>  extern unsigned int __start___mmu_ftr_fixup, __stop___mmu_ftr_fixup;
>  
> +/*
> + * Possible MMU modes
> + */
> +#define MMU_MODE_NONE           0
> +#define MMU_MODE_RADIX          1
> +#define MMU_MODE_HASH           2
> +#define MMU_MODE_HASH32         3
> +#define MMU_MODE_NOHASH         4
> +#define MMU_MODE_NOHASH32       5

These are already defined in the same file:

/*
 * MMU families
 */
#define MMU_FTR_HPTE_TABLE		ASM_CONST(0x00000001)
#define MMU_FTR_TYPE_8xx		ASM_CONST(0x00000002)
#define MMU_FTR_TYPE_40x		ASM_CONST(0x00000004)
#define MMU_FTR_TYPE_44x		ASM_CONST(0x00000008)
#define MMU_FTR_TYPE_FSL_E		ASM_CONST(0x00000010)
#define MMU_FTR_TYPE_47x		ASM_CONST(0x00000020)
#define MMU_FTR_TYPE_RADIX		ASM_CONST(0x00000040)

And the values for the current CPU are in cur_cpu_spec->mmu_features.

So if you must export anything, make it that value, and hopefully the
rest of the patch goes away.

cheers

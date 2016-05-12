Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3r4xkh0VYWzDqBg
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 12 May 2016 12:29:00 +1000 (AEST)
Received: from e28smtp06.in.ibm.com (e28smtp06.in.ibm.com [125.16.236.6])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3r4xkg1TqXz9t49
 for <linuxppc-dev@ozlabs.org>; Thu, 12 May 2016 12:28:59 +1000 (AEST)
Received: from localhost
 by e28smtp06.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Thu, 12 May 2016 07:58:55 +0530
Received: from d28relay06.in.ibm.com (d28relay06.in.ibm.com [9.184.220.150])
 by d28dlp03.in.ibm.com (Postfix) with ESMTP id 3AD781258060
 for <linuxppc-dev@ozlabs.org>; Thu, 12 May 2016 08:01:00 +0530 (IST)
Received: from d28av05.in.ibm.com (d28av05.in.ibm.com [9.184.220.67])
 by d28relay06.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u4C2Sphp39321798
 for <linuxppc-dev@ozlabs.org>; Thu, 12 May 2016 07:58:51 +0530
Received: from d28av05.in.ibm.com (localhost [127.0.0.1])
 by d28av05.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u4C2Sowg025428
 for <linuxppc-dev@ozlabs.org>; Thu, 12 May 2016 07:58:50 +0530
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@ozlabs.org
Cc: alistair@popple.id.au
Subject: Re: [PATCH 1/2] powerpc: Add mask of possible MMU features
In-Reply-To: <1462949231-28355-1-git-send-email-mpe@ellerman.id.au>
References: <1462949231-28355-1-git-send-email-mpe@ellerman.id.au>
Date: Thu, 12 May 2016 07:58:50 +0530
Message-ID: <87posshuvx.fsf@skywalker.in.ibm.com>
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

> Follow the example of the cpu feature code, and add a mask of possible
> MMU features, MMU_FTRS_POSSIBLE.
>
> This is used in mmu_has_feature(), which allows the possible mask to act
> as a shortcut for any features that are not possible, but still allows
> the feature bit itself to be defined.
>
> We will use this feature in the next commit to fix a bug with the
> recently add MMU_FTR_RADIX.
>
> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>

Reviewed-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>

> ---
>  arch/powerpc/include/asm/mmu.h | 14 +++++++++++++-
>  1 file changed, 13 insertions(+), 1 deletion(-)
>
> diff --git a/arch/powerpc/include/asm/mmu.h b/arch/powerpc/include/asm/mmu.h
> index d91dc886c90f..a5e37c93700b 100644
> --- a/arch/powerpc/include/asm/mmu.h
> +++ b/arch/powerpc/include/asm/mmu.h
> @@ -119,9 +119,21 @@
>  DECLARE_PER_CPU(int, next_tlbcam_idx);
>  #endif
>
> +enum {
> +	MMU_FTRS_POSSIBLE = MMU_FTR_HPTE_TABLE | MMU_FTR_TYPE_8xx |
> +		MMU_FTR_TYPE_40x | MMU_FTR_TYPE_44x | MMU_FTR_TYPE_FSL_E |
> +		MMU_FTR_TYPE_47x | MMU_FTR_USE_HIGH_BATS | MMU_FTR_BIG_PHYS |
> +		MMU_FTR_USE_TLBIVAX_BCAST | MMU_FTR_USE_TLBILX |
> +		MMU_FTR_LOCK_BCAST_INVAL | MMU_FTR_NEED_DTLB_SW_LRU |
> +		MMU_FTR_USE_TLBRSRV | MMU_FTR_USE_PAIRED_MAS |
> +		MMU_FTR_NO_SLBIE_B | MMU_FTR_16M_PAGE | MMU_FTR_TLBIEL |
> +		MMU_FTR_LOCKLESS_TLBIE | MMU_FTR_CI_LARGE_PAGE |
> +		MMU_FTR_1T_SEGMENT | MMU_FTR_RADIX,
> +};
> +
>  static inline int mmu_has_feature(unsigned long feature)
>  {
> -	return (cur_cpu_spec->mmu_features & feature);
> +	return (MMU_FTRS_POSSIBLE & cur_cpu_spec->mmu_features & feature);
>  }
>
>  static inline void mmu_clear_feature(unsigned long feature)
> -- 
> 2.5.0

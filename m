Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e17.ny.us.ibm.com (e17.ny.us.ibm.com [129.33.205.207])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id BAD8C1A04FA
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 18 Feb 2016 02:01:21 +1100 (AEDT)
Received: from localhost
 by e17.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Wed, 17 Feb 2016 10:01:19 -0500
Received: from b01cxnp22033.gho.pok.ibm.com (b01cxnp22033.gho.pok.ibm.com
 [9.57.198.23])
 by d01dlp03.pok.ibm.com (Postfix) with ESMTP id 84C2EC90045
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 17 Feb 2016 10:01:13 -0500 (EST)
Received: from d01av04.pok.ibm.com (d01av04.pok.ibm.com [9.56.224.64])
 by b01cxnp22033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u1HF1F7030212218
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 17 Feb 2016 15:01:15 GMT
Received: from d01av04.pok.ibm.com (localhost [127.0.0.1])
 by d01av04.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u1HF1Fw1004365
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 17 Feb 2016 10:01:15 -0500
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: Michael Neuling <mikey@neuling.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: linuxppc-dev@lists.ozlabs.org, Michael Neuling <mikey@neuling.org>
Subject: Re: [PATCH 1/2] powerpc/powernv: Create separate subcores CPU feature
 bit
In-Reply-To: <1455685668-30198-1-git-send-email-mikey@neuling.org>
References: <1455685668-30198-1-git-send-email-mikey@neuling.org>
Date: Wed, 17 Feb 2016 20:29:22 +0530
Message-ID: <878u2jz8l1.fsf@linux.vnet.ibm.com>
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

Michael Neuling <mikey@neuling.org> writes:

> Subcores isn't really part of the 2.07 architecture but currently we
> turn it on using the 2.07 feature bit.  Subcores is really a POWER8
> specific feature.
>
> This adds a new CPU_FTR bit just for subcores and moves the subcore
> init code over to use this.
>

Reviewed-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>

> Signed-off-by: Michael Neuling <mikey@neuling.org>
> ---
>  arch/powerpc/include/asm/cputable.h      | 3 ++-
>  arch/powerpc/platforms/powernv/subcore.c | 2 +-
>  2 files changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/arch/powerpc/include/asm/cputable.h b/arch/powerpc/include/asm/cputable.h
> index b118072..a47e175 100644
> --- a/arch/powerpc/include/asm/cputable.h
> +++ b/arch/powerpc/include/asm/cputable.h
> @@ -196,6 +196,7 @@ enum {
>  #define CPU_FTR_DAWR			LONG_ASM_CONST(0x0400000000000000)
>  #define CPU_FTR_DABRX			LONG_ASM_CONST(0x0800000000000000)
>  #define CPU_FTR_PMAO_BUG		LONG_ASM_CONST(0x1000000000000000)
> +#define CPU_FTR_SUBCORE			LONG_ASM_CONST(0x2000000000000000)
>
>  #ifndef __ASSEMBLY__
>
> @@ -443,7 +444,7 @@ enum {
>  	    CPU_FTR_STCX_CHECKS_ADDRESS | CPU_FTR_POPCNTB | CPU_FTR_POPCNTD | \
>  	    CPU_FTR_ICSWX | CPU_FTR_CFAR | CPU_FTR_HVMODE | CPU_FTR_VMX_COPY | \
>  	    CPU_FTR_DBELL | CPU_FTR_HAS_PPR | CPU_FTR_DAWR | \
> -	    CPU_FTR_ARCH_207S | CPU_FTR_TM_COMP)
> +	    CPU_FTR_ARCH_207S | CPU_FTR_TM_COMP | CPU_FTR_SUBCORE)
>  #define CPU_FTRS_POWER8E (CPU_FTRS_POWER8 | CPU_FTR_PMAO_BUG)
>  #define CPU_FTRS_POWER8_DD1 (CPU_FTRS_POWER8 & ~CPU_FTR_DBELL)
>  #define CPU_FTRS_CELL	(CPU_FTR_USE_TB | CPU_FTR_LWSYNC | \
> diff --git a/arch/powerpc/platforms/powernv/subcore.c b/arch/powerpc/platforms/powernv/subcore.c
> index 503a73f..0babef1 100644
> --- a/arch/powerpc/platforms/powernv/subcore.c
> +++ b/arch/powerpc/platforms/powernv/subcore.c
> @@ -407,7 +407,7 @@ static DEVICE_ATTR(subcores_per_core, 0644,
>
>  static int subcore_init(void)
>  {
> -	if (!cpu_has_feature(CPU_FTR_ARCH_207S))
> +	if (!cpu_has_feature(CPU_FTR_SUBCORE))
>  		return 0;
>
>  	/*
> -- 
> 2.5.0

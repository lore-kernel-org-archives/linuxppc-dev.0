Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qwdy65K7CzDq5f
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 29 Apr 2016 00:10:06 +1000 (AEST)
In-Reply-To: <1460182444-2468-68-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
 benh@kernel.crashing.org, paulus@samba.org
From: Michael Ellerman <mpe@ellerman.id.au>
Cc: linuxppc-dev@lists.ozlabs.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: Re: [V2,67/68] powerpc/mm/radix: Cputable update for radix
Message-Id: <3qwdy64HWXz9t79@ozlabs.org>
Date: Fri, 29 Apr 2016 00:10:06 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sat, 2016-09-04 at 06:14:03 UTC, "Aneesh Kumar K.V" wrote:
> With P9 Radix we need to do
> 
> * set UPRT = 1
> * set different TLB set count
> 
> In this patch we delay the UPRT=1 to early mmu init. This help us to
> keep the cpu table setup and restore cpu callback the same across
> different MMU model.
> 
> This also implies that a cpu_restore cur_cpu_spec callback won't set
> UPRT=1. We currently use that for secondary cpu init and on primary
> after we did an opal reinit for endian switch. In both the case
> we call early_mmu_init after the above operations. This set UPRT
> to correct value.

This probably needs a new subject and updated change log as it is mainly adding
the setup code.

> diff --git a/arch/powerpc/kernel/cputable.c b/arch/powerpc/kernel/cputable.c
> index 6c662b8de90d..e009722d5914 100644
> --- a/arch/powerpc/kernel/cputable.c
> +++ b/arch/powerpc/kernel/cputable.c
> @@ -514,7 +514,7 @@ static struct cpu_spec __initdata cpu_specs[] = {
>  		.cpu_features		= CPU_FTRS_POWER9,
>  		.cpu_user_features	= COMMON_USER_POWER9,
>  		.cpu_user_features2	= COMMON_USER2_POWER9,
> -		.mmu_features		= MMU_FTRS_POWER9,
> +		.mmu_features		= MMU_FTRS_POWER9 | MMU_FTR_RADIX,

I think we discussed this before, but I want to drop this.

That will mean the only way MMU_FTR_RADIX is enabled is via ibm,pa-features (in
the next patch).

cheers

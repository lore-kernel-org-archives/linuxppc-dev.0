Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rWLRL6KJWzDqMv
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 17 Jun 2016 23:18:22 +1000 (AEST)
In-Reply-To: <1465629495-17166-1-git-send-email-maddy@linux.vnet.ibm.com>
To: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
From: Michael Ellerman <mpe@ellerman.id.au>
Cc: mikey@ozlabs.au.ibm.com, Madhavan Srinivasan <maddy@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org
Subject: Re: [1/4] powerpc/perf: Initialise PMU related regs on POWER9
Message-Id: <3rWLRL51nkz9t2F@ozlabs.org>
Date: Fri, 17 Jun 2016 23:18:22 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sat, 2016-11-06 at 07:18:12 UTC, Madhavan Srinivasan wrote:
> diff --git a/arch/powerpc/kernel/cpu_setup_power.S b/arch/powerpc/kernel/cpu_setup_power.S
> index 584e119fa8b0..a2080fde0cc5 100644
> --- a/arch/powerpc/kernel/cpu_setup_power.S
> +++ b/arch/powerpc/kernel/cpu_setup_power.S
> @@ -219,3 +223,16 @@ __init_PMU:
>  	mtspr	SPRN_MMCR1,r5
>  	mtspr	SPRN_MMCR2,r5
>  	blr
> +
> +__init_PMU_HV_300:
> +	li	r5,0
> +	mtspr	SPRN_MMCRC,r5
> +	blr
> +
> +__init_PMU_300:
> +	li	r5,0
> +	mtspr	SPRN_MMCRA,r5
> +	mtspr	SPRN_MMCR0,r5
> +	mtspr	SPRN_MMCR1,r5
> +	mtspr	SPRN_MMCR2,r5
> +	blr

With the exception of MMCRS, these are the same as the Power8 code. So there
should be able to be some common code.

cheers

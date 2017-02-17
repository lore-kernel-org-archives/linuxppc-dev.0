Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vPq242YdDzDq5x
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 17 Feb 2017 21:26:36 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Russell Currey <ruscur@russell.cc>, linuxppc-dev@lists.ozlabs.org
Cc: mikey@neuling.org, Russell Currey <ruscur@russell.cc>
Subject: Re: [PATCH v2] powerpc: Add POWER9 architected mode to cputable
In-Reply-To: <20170217020135.6361-1-ruscur@russell.cc>
References: <20170217020135.6361-1-ruscur@russell.cc>
Date: Fri, 17 Feb 2017 21:26:35 +1100
Message-ID: <87y3x5i04k.fsf@concordia.ellerman.id.au>
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

Russell Currey <ruscur@russell.cc> writes:

> diff --git a/arch/powerpc/kernel/cputable.c b/arch/powerpc/kernel/cputable.c
> index 6a82ef039c50..d23a54b09436 100644
> --- a/arch/powerpc/kernel/cputable.c
> +++ b/arch/powerpc/kernel/cputable.c
> @@ -386,6 +386,25 @@ static struct cpu_spec __initdata cpu_specs[] = {
>  		.machine_check_early	= __machine_check_early_realmode_p8,
>  		.platform		= "power8",
>  	},
> +	{	/* 3.00-compliant processor, i.e. Power9 "architected" mode */
> +		.pvr_mask		= 0xffffffff,
> +		.pvr_value		= 0x0f000005,
> +		.cpu_name		= "POWER9 (architected)",
> +		.cpu_features		= CPU_FTRS_POWER9,
> +		.cpu_user_features	= COMMON_USER_POWER9,
> +		.cpu_user_features2	= COMMON_USER2_POWER9,
> +		.mmu_features		= MMU_FTRS_POWER9,
> +		.icache_bsize		= 128,
> +		.dcache_bsize		= 128,
> +		.num_pmcs		= 6,

It's important *not* to set num_pmcs for the architected PVRs.

See the comment in setup_cpu_spec():

	/*
	 * If we are overriding a previous value derived from the real
	 * PVR with a new value obtained using a logical PVR value,
	 * don't modify the performance monitor fields.
	 */
	if (old.num_pmcs && !s->num_pmcs) {
		t->num_pmcs = old.num_pmcs;
		t->pmc_type = old.pmc_type;

I realise that having that requirement in the code is serious foot gun
material on our part, but c'est la vie.

The reason we do that is there's no "compat mode" for the PMU. So if you
boot on a Power9, and then the logical PVR says "actually pretend you're
on a Power8", we flip most of the cpu_spec to have the Power8 values,
but *not* the PMU fields. That way the Power9 PMU code will still detect
that it's on a Power9 and work correctly.

Possibly now that oprofile is more or less dead we can rip all that crap
out, and have perf just look at the PVR directly.

cheers

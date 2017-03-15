Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vjqCm3RXBzDqMd
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 15 Mar 2017 22:30:28 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Oliver O'Halloran <oohall@gmail.com>, linuxppc-dev@lists.ozlabs.org
Cc: Oliver O'Halloran <oohall@gmail.com>
Subject: Re: [PATCH 5/5] powerpc/smp: Add Power9 scheduler topology
In-Reply-To: <20170302004920.21948-5-oohall@gmail.com>
References: <20170302004920.21948-1-oohall@gmail.com>
 <20170302004920.21948-5-oohall@gmail.com>
Date: Wed, 15 Mar 2017 22:30:26 +1100
Message-ID: <87y3w6kca5.fsf@concordia.ellerman.id.au>
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

Oliver O'Halloran <oohall@gmail.com> writes:

> diff --git a/arch/powerpc/kernel/smp.c b/arch/powerpc/kernel/smp.c
> index 5571f30ff72d..5e1811b24415 100644
> --- a/arch/powerpc/kernel/smp.c
> +++ b/arch/powerpc/kernel/smp.c
> @@ -724,10 +724,17 @@ static void update_cpu_masks(int cpu, bool onlining)
>  
>  	update_thread_mask(cpu, onlining);
>  
> +	/* we need the l2 cache mask for the power9 scheduler topology */
> +	if (cpu_has_feature(CPU_FTR_ARCH_300))
> +		update_mask_by_l2(cpu, onlining, cpu_cache_mask);

I guess I missed something somewhere, why do we need to check the CPU
feature?

...
> @@ -829,7 +862,10 @@ void __init smp_cpus_done(unsigned int max_cpus)
>  
>  	dump_numa_cpu_topology();
>  
> -	set_sched_topology(powerpc_topology);
> +	if (cpu_has_feature(CPU_FTR_ARCH_300))
> +		set_sched_topology(power9_topology);
> +	else
> +		set_sched_topology(powerpc_topology);
  
Ideally this would just all come from the device tree. If we detect that
the L2 is shared then we tell the scheduler that, we shouldn't need to
know that P9 is special. It certainly doesn't say anywhere in ISA 3.00
that the L2 is shared.

cheers

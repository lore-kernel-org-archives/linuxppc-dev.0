Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vjpy33F59zDqYB
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 15 Mar 2017 22:18:35 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Oliver O'Halloran <oohall@gmail.com>, linuxppc-dev@lists.ozlabs.org
Cc: Oliver O'Halloran <oohall@gmail.com>
Subject: Re: [PATCH 3/5] powerpc/smp: Add update_cpu_masks()
In-Reply-To: <20170302004920.21948-3-oohall@gmail.com>
References: <20170302004920.21948-1-oohall@gmail.com>
 <20170302004920.21948-3-oohall@gmail.com>
Date: Wed, 15 Mar 2017 22:18:34 +1100
Message-ID: <874lyulred.fsf@concordia.ellerman.id.au>
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

> When adding and removing a CPU from the system the per-cpu masks that
> are used by the scheduler to construct scheduler domains need to be updated
> to account for the cpu entering or exiting the system. Currently logic this
> is open-coded for the thread sibling mask and shared for the core mask.

"logic this is"

> This patch moves all the logic for rebuilding these masks into a single
> function and simplifies the logic which determines which CPUs are within
> a "core".

The diff is hard to read but I think it's OK. Other than ...

> diff --git a/arch/powerpc/kernel/smp.c b/arch/powerpc/kernel/smp.c
> index 1c531887ca51..3922cace927e 100644
> --- a/arch/powerpc/kernel/smp.c
> +++ b/arch/powerpc/kernel/smp.c
> @@ -630,14 +630,20 @@ int cpu_first_thread_of_core(int core)
>  }
>  EXPORT_SYMBOL_GPL(cpu_first_thread_of_core);
>  
> -static void traverse_siblings_chip_id(int cpu, bool add, int chipid)
> +static bool update_core_mask_by_chip_id(int cpu, bool add)
                                                         ^
                                                         call it
                                                         onlining like below

>  {
>  	const struct cpumask *mask = add ? cpu_online_mask : cpu_present_mask;
> +	int chipid = cpu_to_chip_id(cpu);
>  	int i;
>  
> +	if (chipid == -1)
> +		return false;
> +
>  	for_each_cpu(i, mask)
>  		if (cpu_to_chip_id(i) == chipid)
>  			set_cpus_related(cpu, i, add, cpu_core_mask);
> +
> +	return true;
>  }
>  
>  /* Must be called when no change can occur to cpu_present_mask,
> @@ -662,42 +668,72 @@ static struct device_node *cpu_to_l2cache(int cpu)
>  	return cache;
>  }
>  
> -static void traverse_core_siblings(int cpu, bool add)
> +static bool update_core_mask_by_l2(int cpu, bool onlining)
>  {
> +	const struct cpumask *mask = onlining ? cpu_online_mask : cpu_present_mask;
>  	struct device_node *l2_cache, *np;
> -	const struct cpumask *mask;
> -	int chip_id;
>  	int i;
>  
> -	/* threads that share a chip-id are considered siblings (same die) */
> -	chip_id = cpu_to_chip_id(cpu);
> -
> -	if (chip_id >= 0) {
> -		traverse_siblings_chip_id(cpu, add, chip_id);
> -		return;
> -	}
> -
> -	/* if the chip-id fails then group siblings by the L2 cache */
>  	l2_cache = cpu_to_l2cache(cpu);
> -	mask = add ? cpu_online_mask : cpu_present_mask;
> +	if (l2_cache == NULL)
> +		return false;
> +
>  	for_each_cpu(i, mask) {
>  		np = cpu_to_l2cache(i);
>  		if (!np)
>  			continue;
>  
>  		if (np == l2_cache)
> -			set_cpus_related(cpu, i, add, cpu_core_mask);
> +			set_cpus_related(cpu, i, onlining, cpu_core_mask);
>  
>  		of_node_put(np);
>  	}
>  	of_node_put(l2_cache);
> +
> +	return true;
> +}
> +
> +static void update_thread_mask(int cpu, bool onlining)
> +{
> +	int base = cpu_first_thread_sibling(cpu);
> +	int i;
> +
> +	pr_info("CPUDEBUG: onlining cpu %d, base %d, thread_per_core %d",
> +		cpu, base, threads_per_core);

That's too spammy for cpu hotplug. Make it pr_debug() at most.

cheers

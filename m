Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41n3Bt30JrzDqrN
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 10 Aug 2018 21:42:30 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Srikar Dronamraju <srikar@linux.vnet.ibm.com>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Cc: Michael Bringmann <mbringm@us.ibm.com>,
 Manjunatha H R <manjuhr1@in.ibm.com>,
 Srikar Dronamraju <srikar@linux.vnet.ibm.com>,
 Anshuman Khandual <khandual@linux.vnet.ibm.com>
Subject: Re: [PATCH v3] powerpc/topology: Check at boot for topology updates
In-Reply-To: <1533884198-20862-1-git-send-email-srikar@linux.vnet.ibm.com>
References: <1533884198-20862-1-git-send-email-srikar@linux.vnet.ibm.com>
Date: Fri, 10 Aug 2018 21:42:28 +1000
Message-ID: <87bmaa8n2z.fsf@concordia.ellerman.id.au>
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

Hi Srikar,

Thanks for debugging this.

Srikar Dronamraju <srikar@linux.vnet.ibm.com> writes:
> diff --git a/arch/powerpc/include/asm/topology.h b/arch/powerpc/include/asm/topology.h
> index 16b077801a5f..70f2d2285ba7 100644
> --- a/arch/powerpc/include/asm/topology.h
> +++ b/arch/powerpc/include/asm/topology.h
> @@ -113,6 +114,10 @@ static inline int timed_topology_update(int nsecs)
>  {
>  	return 0;
>  }
> +
> +#ifdef CONFIG_SMP
> +static inline void check_topology_updates(void) {}
> +#endif

I realise that's only called from smp.c but it doesn't really need to be
inside #ifdef CONFIG_SMP, it's harmless to have an empty version for
SMP=n.

> diff --git a/arch/powerpc/kernel/smp.c b/arch/powerpc/kernel/smp.c
> index 4794d6b4f4d2..2aa0ffd954c9 100644
> --- a/arch/powerpc/kernel/smp.c
> +++ b/arch/powerpc/kernel/smp.c
> @@ -1156,6 +1156,12 @@ void __init smp_cpus_done(unsigned int max_cpus)
>  	if (smp_ops && smp_ops->bringup_done)
>  		smp_ops->bringup_done();
>  
> +	/*
> +	 * On a shared LPAR, associativity needs to be requested.
> +	 * Hence, check for numa topology updates before dumping
> +	 * cpu topology
> +	 */
> +	check_topology_updates();

I get that you're calling it here because you want to get it correct
before we do the dump below, but we could move the dump later also.

You mention we need to do the check before the sched domains are
initialised, but where exactly does that happen?

> diff --git a/arch/powerpc/mm/numa.c b/arch/powerpc/mm/numa.c
> index 0c7e05d89244..32c13a208589 100644
> --- a/arch/powerpc/mm/numa.c
> +++ b/arch/powerpc/mm/numa.c
> @@ -1515,6 +1515,7 @@ int start_topology_update(void)
>  		   lppaca_shared_proc(get_lppaca())) {
>  		if (!vphn_enabled) {
>  			vphn_enabled = 1;
> +			topology_update_needed = 1;

I really don't understand what topology_update_needed is for.
We set it here.

>  			setup_cpu_associativity_change_counters();
>  			timer_setup(&topology_timer, topology_timer_fn,
>  				    TIMER_DEFERRABLE);
> @@ -1551,6 +1552,19 @@ int prrn_is_enabled(void)
>  	return prrn_enabled;
>  }
>  
> +void __init check_topology_updates(void)
> +{
> +	/* Do not poll for changes if disabled at boot */
> +	if (topology_updates_enabled)
> +		start_topology_update();

Here we call start_topology_update(), which might set
topology_update_needed to 1.

> +
> +	if (topology_update_needed) {

And then we check it here?
Why is this logic not *in* start_topology_update() ?

> +		bitmap_fill(cpumask_bits(&cpu_associativity_changes_mask),
> +			    nr_cpumask_bits);
> +		numa_update_cpu_topology(false);
> +	}
> +}

I'm not really clear on what check_topology_update() is responsible for
doing vs topology_update_init(). Why do we need both?

> @@ -1608,10 +1618,6 @@ static int topology_update_init(void)
>  		return -ENOMEM;
>  
>  	topology_inited = 1;

What does that mean? Didn't we already do the init earlier?

> -	if (topology_update_needed)
> -		bitmap_fill(cpumask_bits(&cpu_associativity_changes_mask),
> -					nr_cpumask_bits);
> -
>  	return 0;
>  }
>  device_initcall(topology_update_init);


cheers

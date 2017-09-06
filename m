Return-Path: <nfont@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xnR055XNLzDqXp
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  7 Sep 2017 00:33:25 +1000 (AEST)
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 v86EUTc9095941
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 6 Sep 2017 10:33:23 -0400
Received: from e12.ny.us.ibm.com (e12.ny.us.ibm.com [129.33.205.202])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2cth6x7eck-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 06 Sep 2017 10:33:22 -0400
Received: from localhost
 by e12.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <nfont@linux.vnet.ibm.com>;
 Wed, 6 Sep 2017 10:33:22 -0400
Subject: Re: [PATCH V13 3/4] powerpc/hotplug: Improve responsiveness of
 hotplug change
To: Michael Bringmann <mwb@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
Cc: Michael Ellerman <mpe@ellerman.id.au>,
 John Allen <jallen@linux.vnet.ibm.com>
References: <1df8eebb-8313-dbcd-5be1-d0fa26293589@linux.vnet.ibm.com>
From: Nathan Fontenot <nfont@linux.vnet.ibm.com>
Date: Wed, 6 Sep 2017 09:33:18 -0500
MIME-Version: 1.0
In-Reply-To: <1df8eebb-8313-dbcd-5be1-d0fa26293589@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8
Message-Id: <8486f103-e5be-5c85-c8b2-556aa11107b0@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 09/01/2017 10:48 AM, Michael Bringmann wrote:
> powerpc/hotplug: On Power systems with shared configurations of CPUs
> and memory, there are some issues with the association of additional
> CPUs and memory to nodes when hot-adding resources.  During hotplug
> CPU operations, this patch resets the timer on topology update work
> function to a small value to better ensure that the CPU topology is
> detected and configured sooner.

Looking through the changes you've made here I don't see where the
topology timeout ever gets set to the default timeout. When calculating
the next timeout you use topology_timer_secs which is initialized to 1, so
the timer pops every second after initialization. Then after a dlpar cpu
operation the timer is set to pop every second. There is no place that I
see where the timeout is set to the default 60 seconds.

> 
> Signed-off-by: Michael Bringmann <mwb@linux.vnet.ibm.com>
> ---
>  arch/powerpc/include/asm/topology.h          |    8 ++++++++
>  arch/powerpc/mm/numa.c                       |   21 ++++++++++++++++++++-
>  arch/powerpc/platforms/pseries/hotplug-cpu.c |    2 ++
>  3 files changed, 30 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/powerpc/include/asm/topology.h b/arch/powerpc/include/asm/topology.h
> index dc4e159..beb9bca 100644
> --- a/arch/powerpc/include/asm/topology.h
> +++ b/arch/powerpc/include/asm/topology.h
> @@ -98,6 +98,14 @@ static inline int prrn_is_enabled(void)
>  }
>  #endif /* CONFIG_NUMA && CONFIG_PPC_SPLPAR */
> 
> +#if defined(CONFIG_HOTPLUG_CPU) || defined(CONFIG_NEED_MULTIPLE_NODES)
> +#if defined(CONFIG_PPC_SPLPAR)
> +extern int timed_topology_update(int nsecs);
> +#else
> +#define	timed_topology_update(nsecs)
> +#endif /* CONFIG_PPC_SPLPAR */
> +#endif /* CONFIG_HOTPLUG_CPU || CONFIG_NEED_MULTIPLE_NODES */
> +
>  #include <asm-generic/topology.h>
> 
>  #ifdef CONFIG_SMP
> diff --git a/arch/powerpc/mm/numa.c b/arch/powerpc/mm/numa.c
> index c08d736..3a5b334 100644
> --- a/arch/powerpc/mm/numa.c
> +++ b/arch/powerpc/mm/numa.c
> @@ -1148,15 +1148,34 @@ struct topology_update_data {
>  	int new_nid;
>  };
> 
> +#define TOPOLOGY_DEF_TIMER_SECS	60
> +
>  static u8 vphn_cpu_change_counts[NR_CPUS][MAX_DISTANCE_REF_POINTS];
>  static cpumask_t cpu_associativity_changes_mask;
>  static int vphn_enabled;
>  static int prrn_enabled;
>  static void reset_topology_timer(void);
> +static int topology_timer_secs = 1;
>  static int topology_inited;
>  static int topology_update_needed;
> 
>  /*
> + * Change polling interval for associativity changes.
> + */
> +int timed_topology_update(int nsecs)
> +{
> +	if (nsecs > 0)
> +		topology_timer_secs = nsecs;
> +	else
> +		topology_timer_secs = TOPOLOGY_DEF_TIMER_SECS;
> +
> +	if (vphn_enabled)
> +		reset_topology_timer();

Should this whole thing be wrapped by if (vphn_enabled) ?

-Nathan

> +
> +	return 0;
> +}
> +
> +/*
>   * Store the current values of the associativity change counters in the
>   * hypervisor.
>   */
> @@ -1489,7 +1508,7 @@ static void topology_timer_fn(unsigned long ignored)
>  static void reset_topology_timer(void)
>  {
>  	topology_timer.data = 0;
> -	topology_timer.expires = jiffies + 60 * HZ;
> +	topology_timer.expires = jiffies + topology_timer_secs * HZ;
>  	mod_timer(&topology_timer, topology_timer.expires);
>  }
> 
> diff --git a/arch/powerpc/platforms/pseries/hotplug-cpu.c b/arch/powerpc/platforms/pseries/hotplug-cpu.c
> index 6afd1ef..5a7fb1e 100644
> --- a/arch/powerpc/platforms/pseries/hotplug-cpu.c
> +++ b/arch/powerpc/platforms/pseries/hotplug-cpu.c
> @@ -356,6 +356,7 @@ static int dlpar_online_cpu(struct device_node *dn)
>  			BUG_ON(get_cpu_current_state(cpu)
>  					!= CPU_STATE_OFFLINE);
>  			cpu_maps_update_done();
> +			timed_topology_update(1);
>  			rc = device_online(get_cpu_device(cpu));
>  			if (rc)
>  				goto out;
> @@ -522,6 +523,7 @@ static int dlpar_offline_cpu(struct device_node *dn)
>  				set_preferred_offline_state(cpu,
>  							    CPU_STATE_OFFLINE);
>  				cpu_maps_update_done();
> +				timed_topology_update(1);
>  				rc = device_offline(get_cpu_device(cpu));
>  				if (rc)
>  					goto out;
> 

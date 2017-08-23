Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xclr66YjczDrJg
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 Aug 2017 21:41:26 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Michael Bringmann <mwb@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
Cc: Nathan Fontenot <nfont@linux.vnet.ibm.com>,
 Michael Bringmann <mwb@linux.vnet.ibm.com>,
 John Allen <jallen@linux.vnet.ibm.com>
Subject: Re: [PATCH V9 1/2] powerpc/numa: Update CPU topology when VPHN enabled
In-Reply-To: <9a2f448d-0a5d-95e7-5ec1-b7bac1cb1f75@linux.vnet.ibm.com>
References: <9a2f448d-0a5d-95e7-5ec1-b7bac1cb1f75@linux.vnet.ibm.com>
Date: Wed, 23 Aug 2017 21:41:25 +1000
Message-ID: <87efs2y0ii.fsf@concordia.ellerman.id.au>
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

Michael Bringmann <mwb@linux.vnet.ibm.com> writes:

> powerpc/numa: Correct the currently broken capability to set the
> topology for shared CPUs in LPARs.  At boot time for shared CPU
> lpars, the topology for each shared CPU is set to node zero, however,
> this is now updated correctly using the Virtual Processor Home Node
> (VPHN) capabilities information provided by the pHyp.
>
> Also, update initialization checks for device-tree attributes to
> independently recognize PRRN or VPHN usage.

Did you ever do anything to address Nathan's comments on v4 ?

  http://patchwork.ozlabs.org/patch/767587/


Also your change log doesn't describe anything about what the patch does
and why it is the correct fix for the problem.

When a DLPAR happens you modify the VPHN timer to run in 1 nsec, but you
don't wait for it. Why would we not just run the logic synchronously?

It also seems to make VPHN and PRRN no longer exclusive, which looking
at PAPR seems like it might be correct, but is also a major change so
please justify it in detail.

Comments below.


> diff --git a/arch/powerpc/mm/numa.c b/arch/powerpc/mm/numa.c
> index b95c584..3fd4536 100644
> --- a/arch/powerpc/mm/numa.c
> +++ b/arch/powerpc/mm/numa.c
> @@ -906,7 +907,7 @@ void __init initmem_init(void)
>  
>  	/*
>  	 * Reduce the possible NUMA nodes to the online NUMA nodes,
> -	 * since we do not support node hotplug. This ensures that  we
> +	 * since we do not support node hotplug. This ensures that we

Please do whitespace/spelling changes in a separate patch.

>  	 * lower the maximum NUMA node ID to what is actually present.
>  	 */
>  	nodes_and(node_possible_map, node_possible_map, node_online_map);
> @@ -1148,11 +1149,32 @@ struct topology_update_data {
>  	int new_nid;
>  };
>  
> +#define	TOPOLOGY_DEF_TIMER_SECS		60
> +
>  static u8 vphn_cpu_change_counts[NR_CPUS][MAX_DISTANCE_REF_POINTS];
>  static cpumask_t cpu_associativity_changes_mask;
>  static int vphn_enabled;
>  static int prrn_enabled;
>  static void reset_topology_timer(void);
> +static int topology_timer_secs = TOPOLOGY_DEF_TIMER_SECS;
> +static int topology_inited;
> +static int topology_update_needed;

None of this code should be in numa.c. Which is not your fault but I'm
inclined to move it before we make it worse.

> +
> +/*
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
> +
> +	return 0;
> +}
>  
>  /*
>   * Store the current values of the associativity change counters in the
> @@ -1246,6 +1268,12 @@ static long vphn_get_associativity(unsigned long cpu,
>  			"hcall_vphn() experienced a hardware fault "
>  			"preventing VPHN. Disabling polling...\n");
>  		stop_topology_update();
> +		break;
> +	case H_SUCCESS:
> +		printk(KERN_INFO
> +			"VPHN hcall succeeded. Reset polling...\n");

We don't need that to hit everyone's console once a minute. Remove it or
pr_debug() if you like.

> @@ -1363,6 +1394,8 @@ int numa_update_cpu_topology(bool cpus_locked)
>  			cpumask_andnot(&cpu_associativity_changes_mask,
>  					&cpu_associativity_changes_mask,
>  					cpu_sibling_mask(cpu));
> +			pr_info("Assoc chg gives same node %d for cpu%d\n",
> +					new_nid, cpu);

No thanks.

> @@ -1379,6 +1412,9 @@ int numa_update_cpu_topology(bool cpus_locked)
>  		cpu = cpu_last_thread_sibling(cpu);
>  	}
>  
> +	if (i)
> +		updates[i-1].next = NULL;

???

> @@ -1453,6 +1490,14 @@ static void topology_schedule_update(void)
>  	schedule_work(&topology_work);
>  }
>  
> +void shared_topology_update(void)
> +{
> +	if (firmware_has_feature(FW_FEATURE_VPHN) &&
> +		   lppaca_shared_proc(get_lppaca()))
> +		topology_schedule_update();
> +}
> +EXPORT_SYMBOL(shared_topology_update);

There's no reason for that to be exported AFAICS.

> diff --git a/arch/powerpc/platforms/pseries/dlpar.c b/arch/powerpc/platforms/pseries/dlpar.c
> index 3918769..ba9a4a0 100644
> --- a/arch/powerpc/platforms/pseries/dlpar.c
> +++ b/arch/powerpc/platforms/pseries/dlpar.c
> @@ -592,6 +592,8 @@ static ssize_t dlpar_show(struct class *class, struct class_attribute *attr,
>  
>  static int __init pseries_dlpar_init(void)
>  {
> +	shared_topology_update();
> +

I don't see any reason to call that from here.

It could just as easily be a machine init call in the file where it lives.


cheers

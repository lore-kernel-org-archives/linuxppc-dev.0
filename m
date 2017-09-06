Return-Path: <nfont@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xnQk93HxpzDrKx
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  7 Sep 2017 00:21:21 +1000 (AEST)
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 v86EL9ZX058185
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 6 Sep 2017 10:21:19 -0400
Received: from e14.ny.us.ibm.com (e14.ny.us.ibm.com [129.33.205.204])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2ctey86n1q-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 06 Sep 2017 10:21:15 -0400
Received: from localhost
 by e14.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <nfont@linux.vnet.ibm.com>;
 Wed, 6 Sep 2017 10:20:27 -0400
Subject: Re: [PATCH V13 1/4] powerpc/vphn: Update CPU topology when VPHN
 enabled
To: Michael Bringmann <mwb@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
Cc: Michael Ellerman <mpe@ellerman.id.au>,
 John Allen <jallen@linux.vnet.ibm.com>
References: <9d924c2f-9ad7-f544-519c-5ae967105069@linux.vnet.ibm.com>
From: Nathan Fontenot <nfont@linux.vnet.ibm.com>
Date: Wed, 6 Sep 2017 09:20:23 -0500
MIME-Version: 1.0
In-Reply-To: <9d924c2f-9ad7-f544-519c-5ae967105069@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8
Message-Id: <ed69e975-2282-0a50-484c-84db5156583e@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 09/01/2017 10:48 AM, Michael Bringmann wrote:
> powerpc/vphn: On Power systems with shared configurations of CPUs
> and memory, there are some issues with the association of additional
> CPUs and memory to nodes when hot-adding resources.  This patch
> corrects the currently broken capability to set the topology for
> shared CPUs in LPARs.  At boot time for shared CPU lpars, the
> topology for each CPU was being set to node zero.  Now when
> numa_update_cpu_topology() is called appropriately, the Virtual
> Processor Home Node (VPHN) capabilities information provided by the
> pHyp allows the appropriate node in the shared configuration to be
> selected for the CPU.
> 
> Signed-off-by: Michael Bringmann <mwb@linux.vnet.ibm.com>
> ---
> Changes in V13:
>   -- Split patch for improved review
> ---
>  arch/powerpc/mm/numa.c |   31 ++++++++++++++++++++++++++++---
>  1 file changed, 28 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/powerpc/mm/numa.c b/arch/powerpc/mm/numa.c
> index b95c584..312f6ee 100644
> --- a/arch/powerpc/mm/numa.c
> +++ b/arch/powerpc/mm/numa.c
> @@ -1153,6 +1153,8 @@ struct topology_update_data {
>  static int vphn_enabled;
>  static int prrn_enabled;
>  static void reset_topology_timer(void);
> +static int topology_inited;
> +static int topology_update_needed;
> 
>  /*
>   * Store the current values of the associativity change counters in the
> @@ -1246,6 +1248,11 @@ static long vphn_get_associativity(unsigned long cpu,
>  			"hcall_vphn() experienced a hardware fault "
>  			"preventing VPHN. Disabling polling...\n");
>  		stop_topology_update();
> +		break;
> +	case H_SUCCESS:
> +		dbg("VPHN hcall succeeded. Reset polling...\n");
> +		timed_topology_update(0);
> +		break;
>  	}
> 
>  	return rc;
> @@ -1323,8 +1330,11 @@ int numa_update_cpu_topology(bool cpus_locked)
>  	struct device *dev;
>  	int weight, new_nid, i = 0;
> 
> -	if (!prrn_enabled && !vphn_enabled)
> +	if (!prrn_enabled && !vphn_enabled) {
> +		if (!topology_inited)
> +			topology_update_needed = 1;
>  		return 0;
> +	}
> 
>  	weight = cpumask_weight(&cpu_associativity_changes_mask);
>  	if (!weight)
> @@ -1363,6 +1373,8 @@ int numa_update_cpu_topology(bool cpus_locked)
>  			cpumask_andnot(&cpu_associativity_changes_mask,
>  					&cpu_associativity_changes_mask,
>  					cpu_sibling_mask(cpu));
> +			pr_info("Assoc chg gives same node %d for cpu%d\n",
> +					new_nid, cpu);

As mentioned previously, this should either be removed or changed to a
debug statement.

>  			cpu = cpu_last_thread_sibling(cpu);
>  			continue;
>  		}
> @@ -1433,6 +1445,7 @@ int numa_update_cpu_topology(bool cpus_locked)
> 
>  out:
>  	kfree(updates);
> +	topology_update_needed = 0;
>  	return changed;
>  }
> 
> @@ -1453,6 +1466,13 @@ static void topology_schedule_update(void)
>  	schedule_work(&topology_work);
>  }
> 
> +void shared_topology_update(void)
> +{
> +	if (firmware_has_feature(FW_FEATURE_VPHN) &&
> +		   lppaca_shared_proc(get_lppaca()))

Could we just check vphn_enabled here? The init routine will set this to true
only if the feature is supported and we are using shared processors.

Also, this routine seems a bit odd. The only place it is called from is an
init routine, topology_update_init. Is there a reason this check couldn't just
be in that routine, or it seems like you could just call topology_schedule_update
directly from start_topology_update when vphn is initialized.

-Nathan

> +		topology_schedule_update();
> +}
> +
>  static void topology_timer_fn(unsigned long ignored)
>  {
>  	if (prrn_enabled && cpumask_weight(&cpu_associativity_changes_mask))
> @@ -1519,7 +1539,6 @@ int start_topology_update(void)
>  	if (firmware_has_feature(FW_FEATURE_PRRN)) {
>  		if (!prrn_enabled) {
>  			prrn_enabled = 1;
> -			vphn_enabled = 0;
>  #ifdef CONFIG_SMP
>  			rc = of_reconfig_notifier_register(&dt_update_nb);
>  #endif
> @@ -1527,7 +1546,6 @@ int start_topology_update(void)
>  	} else if (firmware_has_feature(FW_FEATURE_VPHN) &&
>  		   lppaca_shared_proc(get_lppaca())) {
>  		if (!vphn_enabled) {
> -			prrn_enabled = 0;
>  			vphn_enabled = 1;
>  			setup_cpu_associativity_change_counters();
>  			init_timer_deferrable(&topology_timer);
> @@ -1613,9 +1631,16 @@ static int topology_update_init(void)
>  	if (topology_updates_enabled)
>  		start_topology_update();
> 
> +	shared_topology_update();
> +
>  	if (!proc_create("powerpc/topology_updates", 0644, NULL, &topology_ops))
>  		return -ENOMEM;
> 
> +	topology_inited = 1;
> +	if (topology_update_needed)
> +		bitmap_fill(cpumask_bits(&cpu_associativity_changes_mask),
> +					nr_cpumask_bits);
> +
>  	return 0;
>  }
>  device_initcall(topology_update_init);
> 

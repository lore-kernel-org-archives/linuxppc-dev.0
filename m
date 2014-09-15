Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id D71FA1A0054
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 15 Sep 2014 15:05:36 +1000 (EST)
Message-ID: <1410757536.32643.1.camel@concordia>
Subject: Re: [RFC PATCH] powerpc/numa: add ability to disable and debug
 topology updates
From: Michael Ellerman <mpe@ellerman.id.au>
To: Nishanth Aravamudan <nacc@linux.vnet.ibm.com>
Date: Mon, 15 Sep 2014 15:05:36 +1000
In-Reply-To: <20140909200913.GG22906@linux.vnet.ibm.com>
References: <20140909200913.GG22906@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2014-09-09 at 13:09 -0700, Nishanth Aravamudan wrote:
> We have hit a few customer issues with the topology update code (VPHN
> and PRRN). It would be nice to be able to debug the notifications coming
> from the hypervisor in both cases to the LPAR, as well as to disable
> reacting to the notifications, to narrow down the source of the
> problems. Add a basic level of such functionality, similar to the numa=
> command-line parameter.
> 
> Signed-off-by: Nishanth Aravamudan <nacc@linux.vnet.ibm.com>
> ---
> This is pretty rough, but has been useful in the field already. I'm not
> sure if more information would be useful than this basic amount.
> 
> diff --git a/Documentation/kernel-parameters.txt b/Documentation/kernel-parameters.txt
> index 5ae8608ca9f5..6e3b9e3a2ab4 100644
> --- a/Documentation/kernel-parameters.txt
> +++ b/Documentation/kernel-parameters.txt
> @@ -3370,6 +3370,13 @@ bytes respectively. Such letter suffixes can also be entirely omitted.
>  			e.g. base its process migration decisions on it.
>  			Default is on.
>  
> +	topology_updates= [KNL, PPC, NUMA]
> +			Format: {off | debug}
> +			Specify if the kernel should ignore (off) or
> +			emit more information (debug) when the
> +			hypervisor sends NUMA topology updates to an
> +			LPAR.

Boot-time parameters are kind of a pain, not least because they require a reboot
to activate.

Does it really need to be a boot param, or could it be a debugfs or sysctl
flag? ie. do we need to disable it immediately at boot or would it be OK if it
was /etc/rc.local or similar that turned it off ?

It looks like arch_update_cpu_topology() is called quite early, from
init_sched_domains(), but in that case I don't see how
cpu_associativity_changes_mask can be non-zero, ie. we'll never do any work
via that path.

As far as the debug goes, we could just use pr_debug() with
CONFIG_DYNAMIC_DEBUG, it's not quite as easy to enable as a kernel parameter
but for the odd bit of debugging it should be fine.

I guess the downside there is you have to do some work before you know if
you're printing anything out. More below ...

> diff --git a/arch/powerpc/mm/numa.c b/arch/powerpc/mm/numa.c
> index d7737a542fd7..72c5ad313cbe 100644
> --- a/arch/powerpc/mm/numa.c
> +++ b/arch/powerpc/mm/numa.c
> @@ -1160,6 +1160,28 @@ static int __init early_numa(char *p)
>  }
>  early_param("numa", early_numa);
>  
> +static int topology_updates_enabled = 1;
> +static int topology_updates_debug = 0;
> +
> +static int __init early_topology_updates(char *p)
> +{
> +	if (!p)
> +		return 0;
> +
> +	if (strstr(p, "off")) {
> +		printk(KERN_INFO "Disabling topology updates\n");
> +		topology_updates_enabled = 0;
> +	}

Can you add a:
	#define pr_fmt(fmt) "numa: " fmt

At the top of the file and then use pr_xxx() for these?

> +	if (strstr(p, "debug")) {
> +		printk(KERN_INFO "Enabling topology updates debug\n");
> +		topology_updates_debug = 1;
> +	}
> +
> +	return 0;
> +}
> +early_param("topology_updates", early_topology_updates);
> +
>  #ifdef CONFIG_MEMORY_HOTPLUG
>  /*
>   * Find the node associated with a hot added memory section for
> @@ -1546,6 +1568,9 @@ int arch_update_cpu_topology(void)
>  	struct device *dev;
>  	int weight, new_nid, i = 0;
>  
> +	if (!topology_updates_enabled)
> +		return 0;
> +
> 	weight = cpumask_weight(&cpu_associativity_changes_mask);
> 	if (!weight)
> 		return 0;
> @@ -1610,6 +1635,25 @@ int arch_update_cpu_topology(void)
>  	 *
>  	 * And for the similar reason, we will skip all the following updating.
>  	 */

The comment should stay attached to the check below of updated_cpus, ie. this
block should preceed the comment.

> +	if (topology_updates_debug) {
> +		char *buf = kmalloc_array(NR_CPUS*5, sizeof(char), GFP_KERNEL);
> +		cpumask_scnprintf(buf, NR_CPUS*5, &updated_cpus);
> +		printk(KERN_DEBUG "Topology update for the following CPUs:\n");
> +		printk(KERN_DEBUG " %s\n", buf);
> +		printk(KERN_DEBUG "cpumask_weight(&updated_cpus)) = %u\n",
> +						cpumask_weight(&updated_cpus));

Do we really need to print the cpumask? The same information is available below
right, just in a more verbose form?

Assuming we can skip that we can just use pr_debug() for these I think and drop
the debug flag. Or is this a super hot-path that I'm not aware of?

> +		if (cpumask_weight(&updated_cpus)) {
> +			for (ud = &updates[0]; ud; ud = ud->next) {
> +				printk(KERN_DEBUG "cpu %d moving from node %d "
> +						  "to %d\n", ud->cpu,
> +						  ud->old_nid, ud->new_nid);
> +			}
> +		}
> +		kfree(buf);
> +	}
> +
>  	if (!cpumask_weight(&updated_cpus))
>  		goto out;
>  
> @@ -1807,8 +1851,10 @@ static const struct file_operations topology_ops = {
>  
>  static int topology_update_init(void)
>  {
> -	start_topology_update();
> -	proc_create("powerpc/topology_updates", 0644, NULL, &topology_ops);
> +	if (topology_updates_enabled) {
> +		start_topology_update();
> +		proc_create("powerpc/topology_updates", 0644, NULL, &topology_ops);
> +	}

It was already broken, but can you fix the (lack of) error handling here please?

>  
>  	return 0;
>  }

cheers

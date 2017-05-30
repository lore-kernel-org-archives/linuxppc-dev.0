Return-Path: <nfont@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wch9C5XP7zDq5x
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 31 May 2017 03:55:43 +1000 (AEST)
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v4UHsHTv015912
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 30 May 2017 13:55:38 -0400
Received: from e38.co.us.ibm.com (e38.co.us.ibm.com [32.97.110.159])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2asbaexp57-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 30 May 2017 13:55:38 -0400
Received: from localhost
 by e38.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <nfont@linux.vnet.ibm.com>;
 Tue, 30 May 2017 11:55:37 -0600
Subject: Re: [PATCH V4 1/2] powerpc/numa: Update CPU topology when VPHN enabled
To: Michael Bringmann <mwb@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
Cc: Tyrel Datwyler <tyreld@linux.vnet.ibm.com>,
 Andrew Donnellan <andrew.donnellan@au1.ibm.com>,
 Sahil Mehta <sahilmehta17@gmail.com>, Rashmica Gupta <rashmicy@gmail.com>,
 Reza Arbab <arbab@linux.vnet.ibm.com>, Ingo Molnar <mingo@kernel.org>,
 John Allen <jallen@linux.vnet.ibm.com>, Paul Mackerras <paulus@samba.org>,
 Bharata B Rao <bharata@linux.vnet.ibm.com>,
 Shailendra Singh <shailendras@nvidia.com>,
 Thomas Gleixner <tglx@linutronix.de>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
References: <89d48cc9-d730-b299-c81e-83d77e22100d@linux.vnet.ibm.com>
From: Nathan Fontenot <nfont@linux.vnet.ibm.com>
Date: Tue, 30 May 2017 12:55:31 -0500
MIME-Version: 1.0
In-Reply-To: <89d48cc9-d730-b299-c81e-83d77e22100d@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8
Message-Id: <a89026b4-810e-4ad7-9d27-204633281e5b@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 05/26/2017 04:29 PM, Michael Bringmann wrote:
> 
> powerpc/numa: Correct the currently broken capability to set the
> topology for shared CPUs in LPARs.  At boot time for shared CPU
> lpars, the topology for each shared CPU is set to node zero, however,
> this is now updated correctly using the Virtual Processor Home Node
> (VPHN) capabilities information provided by the pHyp. The VPHN handling
> in Linux is disabled, if PRRN handling is present.

I'm still not sure this is what we want. Looking at the topology updating
code, we only enable VPHN if PRRN is not present.

My understanding of the current situation is that the node for partitions
with shared cpus are not set. The reason for this is that the device tree
presented to a partition using shared cpus at boot puts all cpus in node
zero and then uses the VPHN capability to inform the partition which node
each cpu really belongs to.

Additionally, I think this is how DLPAR of shared cpu partitions work.
After the cpu is DLPAR added we should get a VPHN notification to inform
us of the true node that the cpu belongs to.

When the PRRN capability was introduced it was thought to be a follow-on
to the VPHN capability and so the code to start topology updating only
enables VPHN if PRRN is not present. I think what we need to do is always
enable VPHN for shared cpu partitions.

-Nathan

> 
> Signed-off-by: Michael Bringmann <mwb@linux.vnet.ibm.com>
> ---
> Changes in V4:
>  -- Fix conditional compile bug.
> ---
>  arch/powerpc/mm/numa.c                 |   19 ++++++++++++++++++-
>  arch/powerpc/platforms/pseries/dlpar.c |    2 ++
>  2 files changed, 20 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/powerpc/mm/numa.c b/arch/powerpc/mm/numa.c
> index 371792e..afcee3f 100644
> --- a/arch/powerpc/mm/numa.c
> +++ b/arch/powerpc/mm/numa.c
> @@ -29,6 +29,7 @@
>  #include <linux/seq_file.h>
>  #include <linux/uaccess.h>
>  #include <linux/slab.h>
> +#include <linux/sched.h>
>  #include <asm/cputhreads.h>
>  #include <asm/sparsemem.h>
>  #include <asm/prom.h>
> @@ -1153,6 +1154,8 @@ struct topology_update_data {
>  static int vphn_enabled;
>  static int prrn_enabled;
>  static void reset_topology_timer(void);
> +static int topology_inited;
> +static int topology_update_needed;
> 
>  /*
>   * Store the current values of the associativity change counters in the
> @@ -1321,8 +1324,11 @@ int arch_update_cpu_topology(void)
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
> @@ -1361,6 +1367,8 @@ int arch_update_cpu_topology(void)
>  			cpumask_andnot(&cpu_associativity_changes_mask,
>  					&cpu_associativity_changes_mask,
>  					cpu_sibling_mask(cpu));
> +			pr_info("Assoc chg gives same node %d for cpu%d\n",
> +					new_nid, cpu);
>  			cpu = cpu_last_thread_sibling(cpu);
>  			continue;
>  		}
> @@ -1377,6 +1385,9 @@ int arch_update_cpu_topology(void)
>  		cpu = cpu_last_thread_sibling(cpu);
>  	}
> 
> +	if (i)
> +		updates[i-1].next = NULL;
> +
>  	pr_debug("Topology update for the following CPUs:\n");
>  	if (cpumask_weight(&updated_cpus)) {
>  		for (ud = &updates[0]; ud; ud = ud->next) {
> @@ -1423,6 +1434,7 @@ int arch_update_cpu_topology(void)
> 
>  out:
>  	kfree(updates);
> +	topology_update_needed = 0;
>  	return changed;
>  }
> 
> @@ -1600,6 +1612,11 @@ static int topology_update_init(void)
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
> diff --git a/arch/powerpc/platforms/pseries/dlpar.c b/arch/powerpc/platforms/pseries/dlpar.c
> index bda18d8..5106263 100644
> --- a/arch/powerpc/platforms/pseries/dlpar.c
> +++ b/arch/powerpc/platforms/pseries/dlpar.c
> @@ -592,6 +592,8 @@ static ssize_t dlpar_show(struct class *class, struct class_attribute *attr,
> 
>  static int __init pseries_dlpar_init(void)
>  {
> +	arch_update_cpu_topology();
> +
>  	pseries_hp_wq = alloc_workqueue("pseries hotplug workqueue",
>  					WQ_UNBOUND, 1);
>  	return sysfs_create_file(kernel_kobj, &class_attr_dlpar.attr);
> 

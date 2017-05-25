Return-Path: <tyreld@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wYjy02zXVzDqlK
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 26 May 2017 08:05:44 +1000 (AEST)
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v4PLxLQu004466
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 25 May 2017 18:05:40 -0400
Received: from e38.co.us.ibm.com (e38.co.us.ibm.com [32.97.110.159])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2ap6k0trcv-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 25 May 2017 18:05:39 -0400
Received: from localhost
 by e38.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <tyreld@linux.vnet.ibm.com>;
 Thu, 25 May 2017 16:05:39 -0600
Subject: Re: [PATCH V2 1/2] powerpc/numa: Update CPU topology when VPHN enabled
To: Michael Bringmann <mwb@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, Paul Mackerras <paulus@samba.org>
References: <6d5f8438-094b-41b4-a95b-97f89c4d6a08@linux.vnet.ibm.com>
Cc: Tyrel Datwyler <tyreld@linux.vnet.ibm.com>,
 Sahil Mehta <sahilmehta17@gmail.com>, Rashmica Gupta <rashmicy@gmail.com>,
 Reza Arbab <arbab@linux.vnet.ibm.com>, Ingo Molnar <mingo@kernel.org>,
 John Allen <jallen@linux.vnet.ibm.com>,
 Shailendra Singh <shailendras@nvidia.com>,
 Andrew Donnellan <andrew.donnellan@au1.ibm.com>,
 Bharata B Rao <bharata@linux.vnet.ibm.com>,
 Nathan Fontenot <nfont@linux.vnet.ibm.com>,
 Thomas Gleixner <tglx@linutronix.de>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
From: Tyrel Datwyler <tyreld@linux.vnet.ibm.com>
Date: Thu, 25 May 2017 15:05:31 -0700
MIME-Version: 1.0
In-Reply-To: <6d5f8438-094b-41b4-a95b-97f89c4d6a08@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8
Message-Id: <fad5d7ab-8057-02f0-9750-0a78ace40ccb@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 05/25/2017 10:35 AM, Michael Bringmann wrote:
> 
> powerpc/numa: Correct the currently broken capability to set the
> topology for shared CPUs in LPARs.  At boot time for shared CPU
> lpars, the topology for each shared CPU is set to node zero, however,
> this is now updated correctly using the Virtual Processor Home Node
> (VPHN) capabilities information provided by the pHyp. The VPHN handling
> in Linux is disabled, if PRRN handling is present.
> 
> Signed-off-by: Michael Bringmann <mwb@linux.vnet.ibm.com>
> ---
>  arch/powerpc/mm/numa.c                       |   19 ++++++++++++++++++-
>  arch/powerpc/platforms/pseries/dlpar.c       |    2 ++
>  arch/powerpc/platforms/pseries/hotplug-cpu.c |    3 ++-
>  3 files changed, 22 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/powerpc/mm/numa.c b/arch/powerpc/mm/numa.c
> index 371792e..15c2dd5 100644
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
> @@ -42,6 +43,8 @@
>  #include <asm/vdso.h>
>  
>  static int numa_enabled = 1;
> +static int topology_inited;
> +static int topology_update_needed;
>  
>  static char *cmdline __initdata;
>  
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
> diff --git a/arch/powerpc/platforms/pseries/hotplug-cpu.c b/arch/powerpc/platforms/pseries/hotplug-cpu.c
> index 7bc0e91..b5eff35 100644
> --- a/arch/powerpc/platforms/pseries/hotplug-cpu.c
> +++ b/arch/powerpc/platforms/pseries/hotplug-cpu.c
> @@ -619,7 +619,8 @@ static int dlpar_cpu_remove_by_index(u32 drc_index)
>  	}
>  
>  	rc = dlpar_cpu_remove(dn, drc_index);
> -	of_node_put(dn);
> +	if (rc)
> +		of_node_put(dn);

This if statement is unnecessary. A reference to dn is grabbed with cpu_drc_index_to_dn()
earlier in the function. So, regardless of whether dlpar_cpu_remove() succeeds or fails we
still need to release the reference we took. I suspect that maybe you threw this in there
to prevent the of_node underflow that was being seen during dlpar remove of cpus. A fix
for that should already be upstream. Either way this hunk doesn't seem to have anything to
do with the rest of this VPHN patch, and should have been a separate patch with its own
change log explaining the reasoning.

-Tyrel

>  	return rc;
>  }
>  
> 

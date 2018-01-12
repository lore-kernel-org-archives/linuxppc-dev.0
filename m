Return-Path: <nfont@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zJ8Y526GtzF0bG
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 13 Jan 2018 04:16:25 +1100 (AEDT)
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w0CHDfAd073449
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 12 Jan 2018 12:16:23 -0500
Received: from e13.ny.us.ibm.com (e13.ny.us.ibm.com [129.33.205.203])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2fevvvgstf-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 12 Jan 2018 12:16:22 -0500
Received: from localhost
 by e13.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <nfont@linux.vnet.ibm.com>;
 Fri, 12 Jan 2018 12:16:21 -0500
Subject: Re: [PATCH V2] powerpc/kernel: Add 'ibm,thread-groups' property for
 CPU allocation
To: Michael Bringmann <mwb@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org
References: <aeffc542-db28-7d1f-3263-52919b2d07c2@linux.vnet.ibm.com>
From: Nathan Fontenot <nfont@linux.vnet.ibm.com>
Date: Fri, 12 Jan 2018 11:16:18 -0600
MIME-Version: 1.0
In-Reply-To: <aeffc542-db28-7d1f-3263-52919b2d07c2@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8
Message-Id: <d7825e1c-ca1f-3bbe-be41-897b3e98e928@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 01/08/2018 11:19 AM, Michael Bringmann wrote:
> Add code to parse the new property 'ibm,thread-groups" when it is
> present.  The content of this property explicitly defines the number
> of threads per core as well as the PowerPC 'threads_core_mask'.
> The design provides a common device-tree for both P9 normal core and
> P9 fused core systems.  The new property has been observed to be
> available on P9 pHyp systems, but it is not always present on
> OpenPower BMC systems.
> 
> The property updates the kernel to know which CPUs/threads of each
> core are actually present, and then use the map when adding cores
> to the system at boot, or during hotplug operations.
> 
> * Previously, the information about the number of threads per core
>   was inferred solely from the "ibm,ppc-interrupt-server#s" property
>   in the system device tree.
> * Also previous to this property, The mask of threads per CPU was
>   inferred to be a strict linear series from 0..(nthreads-1).
> * After reading the "ibm,thread-group" property, we can determine
>   the number of threads per core to be the 'bitmask weight' of the
>   CPU thread mask.
> * Also after reading the property, we can determine which of the
>   possible threads we are allowed to online for each CPU.  It is no
>   longer a simple linear sequence, but may be discontinuous e.g.
>   activate threads 1,2,3,5,6,7 on a core instead of 0-5 sequentially.
> 
> Implementation of the "ibm,thread-groups" property is spread across
> a few files in the powerpc specific code:
> 
> * prom.c: Parse the property and create 'ppc_thread_group_mask'.
>           Use the mask in operation of early_init_dt_scan_cpus().
> * setup-common.c: Import 'ppc_thread_group_mask' and use the value
>           in the operation of cpu_init_thread_core_maps(), and
>           smp_setup_cpu_maps.
> * hotplug-cpu.c: Use 'ppc_thread_group_mask' in several locations
>           where the code previously expected to iterate over a
>           linear series of active threads (0..nthreads-1).
> 
> Note that the "ibm,thread-groups" property also includes semantics
> of 'thread-group' i.e. define one or more subgroups of the available
> threads, each group of threads to be used for a specific class of
> task.  Translating thread group semantics into Linux kernel features
> is TBD.

One thing I don't see addressed in the comments or in the code is
migration support. I think we need to update the thread group mask
post-migration to reflect the threads per core on the new system.

-Nathan

> 
> Signed-off-by: Michael Bringmann <mwb@linux.vnet.ibm.com>
> ---
> Changes in V2:
>   -- Add more information and examples to the patch description.
>   -- Rename 'pseries_thread_group_mask' to 'ppc_thread_group_mask'
>   -- Remove unnecessary debug message complaining about absence of
>      property.
>   -- Reduce indent complexity of early_init_dt_scan_cpus().
> ---
>  arch/powerpc/include/asm/cputhreads.h        |    2 +
>  arch/powerpc/kernel/prom.c                   |   74 ++++++++++++++++++++++++++
>  arch/powerpc/kernel/setup-common.c           |   30 +++++++----
>  arch/powerpc/platforms/pseries/hotplug-cpu.c |   13 ++++-
>  4 files changed, 107 insertions(+), 12 deletions(-)
> 
> diff --git a/arch/powerpc/include/asm/cputhreads.h b/arch/powerpc/include/asm/cputhreads.h
> index d71a909..8e444d4 100644
> --- a/arch/powerpc/include/asm/cputhreads.h
> +++ b/arch/powerpc/include/asm/cputhreads.h
> @@ -31,6 +31,8 @@
>  #define threads_core_mask	(*get_cpu_mask(0))
>  #endif
> 
> +extern cpumask_t ppc_thread_group_mask;
> +
>  /* cpu_thread_mask_to_cores - Return a cpumask of one per cores
>   *                            hit by the argument
>   *
> diff --git a/arch/powerpc/kernel/prom.c b/arch/powerpc/kernel/prom.c
> index b15bae2..0a49231 100644
> --- a/arch/powerpc/kernel/prom.c
> +++ b/arch/powerpc/kernel/prom.c
> @@ -68,6 +68,9 @@
>  #define DBG(fmt...)
>  #endif
> 
> +cpumask_t ppc_thread_group_mask;
> +EXPORT_SYMBOL(ppc_thread_group_mask);
> +
>  #ifdef CONFIG_PPC64
>  int __initdata iommu_is_off;
>  int __initdata iommu_force_on;
> @@ -303,6 +306,71 @@ static void __init check_cpu_feature_properties(unsigned long node)
>  	}
>  }
> 
> +static void __init early_init_setup_thread_group_mask(unsigned long node,
> +						cpumask_t *thread_group_mask)
> +{
> +	const __be32 *thrgrp;
> +	int len, rc = 0;
> +	u32 cc_type = 0, no_split = 0, thr_per_split = 0;
> +	int j, k;
> +
> +	cpumask_clear(thread_group_mask);
> +
> +	thrgrp = of_get_flat_dt_prop(node, "ibm,thread-groups", &len);
> +	if (!thrgrp)
> +		return;
> +
> +	/* Process the thread groups for the Core thread mask */
> +	/* Characteristic type per table */
> +	cc_type = of_read_number(thrgrp++, 1);
> +
> +	/*
> +	 * 1 : Group shares common L1, translation cache, and
> +	 *     instruction data flow
> +	 * >1 : Reserved
> +	 */
> +	if (cc_type != 1) {
> +		rc = -EINVAL;
> +		goto endit;
> +	}
> +
> +	/* No. splits */
> +	no_split = of_read_number(thrgrp++, 1);
> +	if (no_split == 0) {
> +		rc = -EINVAL;
> +		goto endit;
> +	}
> +
> +	/* Threads per split */
> +	thr_per_split = of_read_number(thrgrp++, 1);
> +	if (thr_per_split == 0) {
> +		rc = -EINVAL;
> +		goto endit;
> +	}
> +
> +	DBG("INFO: Node %d; ibm,thread-group "
> +		"(cc_t=%d, no_spl=%d, thr_p_spl=%d)\n",
> +		(int)node, (int)cc_type, (int)no_split,
> +		(int)thr_per_split);
> +
> +	for (j = 0; j < no_split; j++) {
> +		for (k = 0; k < thr_per_split; k++) {
> +			u32 t = of_read_number(thrgrp++, 1);
> +
> +			cpumask_set_cpu(t, thread_group_mask);
> +			DBG("INFO: Node %d; enable thread %d\n",
> +				(int)node, (int)t);
> +		}
> +	}
> +
> +endit:
> +	if (rc) {
> +		DBG("WARNING: Node %d; error processing "
> +		    "ibm,thread-group property\n", (int)node);
> +		cpumask_setall(thread_group_mask);
> +	}
> +}
> +
>  static int __init early_init_dt_scan_cpus(unsigned long node,
>  					  const char *uname, int depth,
>  					  void *data)
> @@ -326,11 +394,17 @@ static int __init early_init_dt_scan_cpus(unsigned long node,
> 
>  	nthreads = len / sizeof(int);
> 
> +	/* Figure out the thread subset */
> +	early_init_setup_thread_group_mask(node, &ppc_thread_group_mask);
> +
>  	/*
>  	 * Now see if any of these threads match our boot cpu.
>  	 * NOTE: This must match the parsing done in smp_setup_cpu_maps.
>  	 */
>  	for (i = 0; i < nthreads; i++) {
> +		if (!cpumask_test_cpu(i % nthreads, &ppc_thread_group_mask))
> +			continue;
> +
>  		/*
>  		 * version 2 of the kexec param format adds the phys cpuid of
>  		 * booted proc.
> diff --git a/arch/powerpc/kernel/setup-common.c b/arch/powerpc/kernel/setup-common.c
> index 2075322..53cadcd 100644
> --- a/arch/powerpc/kernel/setup-common.c
> +++ b/arch/powerpc/kernel/setup-common.c
> @@ -427,13 +427,16 @@ void __init check_for_initrd(void)
>  EXPORT_SYMBOL_GPL(threads_shift);
>  EXPORT_SYMBOL_GPL(threads_core_mask);
> 
> -static void __init cpu_init_thread_core_maps(int tpc)
> +static void __init cpu_init_thread_core_maps(int tpc,
> +				cpumask_t *thread_group_mask)
>  {
> +	cpumask_t work_mask;
>  	int i;
> 
>  	threads_per_core = tpc;
>  	threads_per_subcore = tpc;
>  	cpumask_clear(&threads_core_mask);
> +	cpumask_clear(&work_mask);
> 
>  	/* This implementation only supports power of 2 number of threads
>  	 * for simplicity and performance
> @@ -442,14 +445,14 @@ static void __init cpu_init_thread_core_maps(int tpc)
>  	BUG_ON(tpc != (1 << threads_shift));
> 
>  	for (i = 0; i < tpc; i++)
> -		cpumask_set_cpu(i, &threads_core_mask);
> +		cpumask_set_cpu(i, &work_mask);
> +	cpumask_and(&threads_core_mask, &work_mask, thread_group_mask);
> 
>  	printk(KERN_INFO "CPU maps initialized for %d thread%s per core\n",
>  	       tpc, tpc > 1 ? "s" : "");
>  	printk(KERN_DEBUG " (thread shift is %d)\n", threads_shift);
>  }
> 
> -
>  /**
>   * setup_cpu_maps - initialize the following cpu maps:
>   *                  cpu_possible_mask
> @@ -503,17 +506,24 @@ void __init smp_setup_cpu_maps(void)
>  		for (j = 0; j < nthreads && cpu < nr_cpu_ids; j++) {
>  			bool avail;
> 
> -			DBG("    thread %d -> cpu %d (hard id %d)\n",
> -			    j, cpu, be32_to_cpu(intserv[j]));
> -
>  			avail = of_device_is_available(dn);
>  			if (!avail)
>  				avail = !of_property_match_string(dn,
>  						"enable-method", "spin-table");
> 
> -			set_cpu_present(cpu, avail);
> -			set_hard_smp_processor_id(cpu, be32_to_cpu(intserv[j]));
> -			set_cpu_possible(cpu, true);
> +			DBG("    thread %d -> cpu %d (hard id %d)\n",
> +			    j, cpu, be32_to_cpu(intserv[j]));
> +
> +			if (cpumask_test_cpu(cpu % nthreads,
> +						&ppc_thread_group_mask)) {
> +				set_cpu_present(cpu, avail);
> +				set_hard_smp_processor_id(cpu,
> +						be32_to_cpu(intserv[j]));
> +				set_cpu_possible(cpu, true);
> +			} else {
> +				set_cpu_present(cpu, false);
> +				set_cpu_possible(cpu, false);
> +			}
>  			cpu++;
>  		}
>  	}
> @@ -572,7 +582,7 @@ void __init smp_setup_cpu_maps(void)
>  	 * every CPU in the system. If that is not the case, then some code
>  	 * here will have to be reworked
>  	 */
> -	cpu_init_thread_core_maps(nthreads);
> +	cpu_init_thread_core_maps(nthreads, &ppc_thread_group_mask);
> 
>  	/* Now that possible cpus are set, set nr_cpu_ids for later use */
>  	setup_nr_cpu_ids();
> diff --git a/arch/powerpc/platforms/pseries/hotplug-cpu.c b/arch/powerpc/platforms/pseries/hotplug-cpu.c
> index a7d14aa7..4125eaa 100644
> --- a/arch/powerpc/platforms/pseries/hotplug-cpu.c
> +++ b/arch/powerpc/platforms/pseries/hotplug-cpu.c
> @@ -36,6 +36,7 @@
>  #include <asm/xics.h>
>  #include <asm/xive.h>
>  #include <asm/plpar_wrappers.h>
> +#include <asm/cputhreads.h>
> 
>  #include "pseries.h"
>  #include "offline_states.h"
> @@ -258,8 +259,10 @@ static int pseries_add_processor(struct device_node *np)
>  	zalloc_cpumask_var(&tmp, GFP_KERNEL);
> 
>  	nthreads = len / sizeof(u32);
> -	for (i = 0; i < nthreads; i++)
> -		cpumask_set_cpu(i, tmp);
> +	for (i = 0; i < nthreads; i++) {
> +		if (cpumask_test_cpu(i % nthreads, &ppc_thread_group_mask))
> +			cpumask_set_cpu(i, tmp);
> +	}
> 
>  	cpu_maps_update_begin();
> 
> @@ -324,6 +327,8 @@ static void pseries_remove_processor(struct device_node *np)
> 
>  	cpu_maps_update_begin();
>  	for (i = 0; i < nthreads; i++) {
> +		if (!cpumask_test_cpu(i % nthreads, &ppc_thread_group_mask))
> +			continue;
>  		thread = be32_to_cpu(intserv[i]);
>  		for_each_present_cpu(cpu) {
>  			if (get_hard_smp_processor_id(cpu) != thread)
> @@ -356,6 +361,8 @@ static int dlpar_online_cpu(struct device_node *dn)
> 
>  	cpu_maps_update_begin();
>  	for (i = 0; i < nthreads; i++) {
> +		if (!cpumask_test_cpu(i % nthreads, &ppc_thread_group_mask))
> +			continue;
>  		thread = be32_to_cpu(intserv[i]);
>  		for_each_present_cpu(cpu) {
>  			if (get_hard_smp_processor_id(cpu) != thread)
> @@ -522,6 +529,8 @@ static int dlpar_offline_cpu(struct device_node *dn)
> 
>  	cpu_maps_update_begin();
>  	for (i = 0; i < nthreads; i++) {
> +		if (!cpumask_test_cpu(i % nthreads, &ppc_thread_group_mask))
> +			continue;
>  		thread = be32_to_cpu(intserv[i]);
>  		for_each_present_cpu(cpu) {
>  			if (get_hard_smp_processor_id(cpu) != thread)
> 

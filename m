Return-Path: <linuxppc-dev+bounces-21688-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6AAB1CD6E45
	for <linuxppc-dev@archiver.kernel.org>; Fri, 29 May 2026 07:58:37 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gRbMc17gSz2xnZ;
	Fri, 29 May 2026 17:58:36 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1780041516;
	cv=none; b=MIDNkSsL9aWiAJ9Cb1WlPaaOjBsfQJ/SxnVR59TPwpzcRM5ZCEZVPum8kkB5PG6HtksgRu0QPF8J3NeUyGqja2s/gZngByRkzLoiR7DLbSLShIzcfPWI5zw+J8JgOGoOpXJmjnyPFagB9ZzfVIX5ZWZJSey3ehJ24Mv2eybAHIOEzv1JMCgq8LKfYHcgO+Jpb62AHy6vB5kuM15vnOJ6mAUpktjjzi0sBBOhXJW6k9Tlhbdh3xDkDDn3E1NliWR16CwtGQFXd7cNNFjzFuAIs8/ZXcAEm9XV7XSWpqFWsGBbWOhvQoqLJfabA7YWiZVb/LGXzMC2o+HOU1++FHp6iA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1780041516; c=relaxed/relaxed;
	bh=nn+9YXyfJKX23Oc4un6567veI3wLVMvLdLpASTOROk0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QBmg36xC3SSp6a8ctiuKh1pf5mmuDU7sMgL9sMoBqvCjr636Qgv+3dAFZxfZUNLOX85dNFGyrwYgwlNsMOnocfXYsHsdlzyZu+xCsIDAa10bAgEn430NsyCvvzkNDWTEpAd1482IQeYOWbMXwI14sxSuGtgF8ArNtPG7H9lJ+AA3VCtJ5iq5PtLd7UU80N3kk9AuDL3vw7Q5DcTY/wq+QzOevyG8CHApacf5hzZ/8qlBi6yFiz0a18+T4tNpCEF+uH7hJiQiLbbUt6q11/CgyrsnSBD52LakYEpdzyLNccVqFXqSTZYQbPjQ/TQaxwLeYMcq1H1dlmtxxnP9xd853w==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=h/cNSQuw; dkim-atps=neutral; spf=pass (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=chleroy@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=h/cNSQuw;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=chleroy@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [IPv6:2600:3c04:e001:324:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gRbMZ55BVz2xLs
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 29 May 2026 17:58:34 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 977CF60565;
	Fri, 29 May 2026 07:58:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 068161F00893;
	Fri, 29 May 2026 07:58:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780041512;
	bh=nn+9YXyfJKX23Oc4un6567veI3wLVMvLdLpASTOROk0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=h/cNSQuwvmuR1CB2YQQHsieD9YyomGRGpfEstXnyozaZ2stDalEElgGKRdSer5LYn
	 PiAUWBXpS5qSbPillQGkEsgo+hdd9k0trM3L+VO8Lg+LAzMC0nZuJJk3T66RXkSXgA
	 B0ykO0WwES4jDlQ6Uf92Wfb+utBYId5pQjsFpyG2LPS8sNjXu3XSN0E8sPwf/0myCv
	 DTs+hyX48/SM8Z28f+naan0d/c+Dep3BdS5NSuvVY1F3gx39MhCcXzQN+q5RL785cG
	 1HozMnkTmzHfgP3rboNeuVbS3OIR9JDAlIL+W1T9MjvtdUYbKoCvY9fkLFj7cBaTON
	 vyuMjnq3uZvOA==
Message-ID: <6387fb12-76f1-4503-8ac2-3ca777c0186e@kernel.org>
Date: Fri, 29 May 2026 09:58:25 +0200
X-Mailing-List: linuxppc-dev@lists.ozlabs.org
List-Id: <linuxppc-dev.lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev+help@lists.ozlabs.org>
List-Owner: <mailto:linuxppc-dev+owner@lists.ozlabs.org>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Archive: <https://lore.kernel.org/linuxppc-dev/>,
  <https://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Subscribe: <mailto:linuxppc-dev+subscribe@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-digest@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-nomail@lists.ozlabs.org>
List-Unsubscribe: <mailto:linuxppc-dev+unsubscribe@lists.ozlabs.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] powerpc/topology: Support coregroup in PowerNV
To: Srikar Dronamraju <srikar@linux.ibm.com>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 Madhavan Srinivasan <maddy@linux.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>,
 Naveen N Rao <naveen@kernel.org>
Cc: skiboot@lists.ozlags.org, arbab@linux.ibm.com, mahesh@linux.ibm.com,
 linux-kernel@vger.kernel.org
References: <20260524010017.140408-1-srikar@linux.ibm.com>
Content-Language: fr-FR
From: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
In-Reply-To: <20260524010017.140408-1-srikar@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



Le 24/05/2026 à 03:00, Srikar Dronamraju a écrit :
> Coregroup support was only available on PowerPC on PowerVM LPARs.
> However if firmware were to expose coregroup-id to the kernel, then
> coregroup can even be supported on PowerNV too.
> 
> PowerPC Linux kernel will detect support for coregroup by looking at the
> primary_domain_index. Till now on PowerNV systems, primary_domain_index
> has been the penultimate domain in cpunode ibm,associativity device-tree
> property. This would be taken as hint that coregroup support is not
> available in the firmware.
> 
> If on PowerNV systems, primary_domain_index is not the penultimate
> domain in cpunode ibm,associativity device-tree property, then it would
> be taken as a hint that coregroup support is available in the firmware.
> 
> This logic makes it compatible with PowerVM Systems, where
> primary_domain_index is not the penultimate domain in cpunode
> ibm,associativity device-tree property.
> 
> $ lscpu
> Architecture:        ppc64le
> Byte Order:          Little Endian
> CPU(s):              480
> On-line CPU(s) list: 0-479
> Thread(s) per core:  8
> Core(s) per socket:  15
> Socket(s):           4
> NUMA node(s):        4
> Model:               2.0 (pvr 0080 0200)
> Model name:          POWER10, altivec supported
> CPU max MHz:         3249.0000
> CPU min MHz:         3249.0000
> L1d cache:           32K
> L1i cache:           48K
> L2 cache:            1024K
> L3 cache:            4096K
> NUMA node0 CPU(s):   0-119
> NUMA node1 CPU(s):   120-239
> NUMA node2 CPU(s):   240-359
> NUMA node3 CPU(s):   360-479
> 
> with-out patched firmware and/or Linux-kernel
> ---------------------------------------------
> $ grep -h -r . /sys/devices/system/cpu/*/topology/die_id |sort | uniq -c | sort -n -r
>      120 27
>      120 18
>      120 9
>      120 0
> 
> $ grep -h -r . /sys/devices/system/cpu/*/topology/die_cpus_list |sort | uniq -c | sort -n -r
>      120 360-479
>      120 240-359
>      120 120-239
>      120 0-119
> 
> with patched firmware and Linux-kernel
> --------------------------------------
> grep -h -r . /sys/devices/system/cpu/*/topology/die_id |sort | uniq -c | sort -n -r
>       64 6
>       64 4
>       64 2
>       64 0
>       56 7
>       56 5
>       56 3
>       56 1
> grep -h -r . /sys/devices/system/cpu/*/topology/die_cpus_list |sort | uniq -c | sort -n -r
>       64 360-375,392-407,424-439,456-471
>       64 240-255,272-287,296-311,328-343
>       64 120-135,152-167,184-199,208-223
>       64 0-15,32-47,64-79,88-103
>       56 376-391,408-423,440-455,472-479
>       56 256-271,288-295,312-327,344-359
>       56 16-31,48-63,80-87,104-119
>       56 136-151,168-183,200-207,224-239
> 
> Observation:
> Without the patched kernel and/or skiboot, die-id and numa were same.
> With patched kernel and/or skiboot, we see 2 die-id per node.
> Signed-off-by: Srikar Dronamraju <srikar@linux.ibm.com>
> ---
>   arch/powerpc/include/asm/topology.h | 15 +++--
>   arch/powerpc/mm/numa.c              | 87 ++++++++++++++++++++++-------
>   2 files changed, 73 insertions(+), 29 deletions(-)
> 
> diff --git a/arch/powerpc/include/asm/topology.h b/arch/powerpc/include/asm/topology.h
> index 66ed5fe1b718..568e6bc55726 100644
> --- a/arch/powerpc/include/asm/topology.h
> +++ b/arch/powerpc/include/asm/topology.h
> @@ -71,6 +71,7 @@ extern void map_cpu_to_node(int cpu, int node);
>   extern void unmap_cpu_from_node(unsigned long cpu);
>   #endif /* CONFIG_HOTPLUG_CPU */
>   
> +extern int cpu_to_coregroup_id(int cpu);

No new 'extern' for function prototypes (allthough it is only a move), 
that's pointless. checkpatch.pl --strict will likely complain about it.

>   #else
>   
>   static inline int early_cpu_to_node(int cpu) { return 0; }
> @@ -107,14 +108,6 @@ static inline void map_cpu_to_node(int cpu, int node) {}
>   static inline void unmap_cpu_from_node(unsigned long cpu) {}
>   #endif /* CONFIG_HOTPLUG_CPU */
>   #endif /* CONFIG_SMP */
> -
> -#endif /* CONFIG_NUMA */
> -
> -#if defined(CONFIG_NUMA) && defined(CONFIG_PPC_SPLPAR)
> -void find_and_update_cpu_nid(int cpu);
> -extern int cpu_to_coregroup_id(int cpu);
> -#else
> -static inline void find_and_update_cpu_nid(int cpu) {}
>   static inline int cpu_to_coregroup_id(int cpu)
>   {
>   #ifdef CONFIG_SMP
> @@ -124,6 +117,12 @@ static inline int cpu_to_coregroup_id(int cpu)
>   #endif
>   }
>   
> +#endif /* CONFIG_NUMA */
> +
> +#if defined(CONFIG_NUMA) && defined(CONFIG_PPC_SPLPAR)
> +void find_and_update_cpu_nid(int cpu);
> +#else
> +static inline void find_and_update_cpu_nid(int cpu) {}
>   #endif /* CONFIG_NUMA && CONFIG_PPC_SPLPAR */
>   
>   #include <asm-generic/topology.h>
> diff --git a/arch/powerpc/mm/numa.c b/arch/powerpc/mm/numa.c
> index f4cf3ae036de..9b45cc9e1f27 100644
> --- a/arch/powerpc/mm/numa.c
> +++ b/arch/powerpc/mm/numa.c
> @@ -432,7 +432,7 @@ static void __init initialize_form2_numa_distance_lookup_table(void)
>   
>   static int __init find_primary_domain_index(void)
>   {
> -	int index;
> +	int index = -1;
>   	struct device_node *root;
>   
>   	/*
> @@ -502,12 +502,9 @@ static int __init find_primary_domain_index(void)
>   		distance_ref_points_depth = MAX_DISTANCE_REF_POINTS;
>   	}
>   
> -	of_node_put(root);
> -	return index;
> -
>   err:
>   	of_node_put(root);
> -	return -1;
> +	return index;
>   }
>   
>   static void __init get_n_mem_cells(int *n_addr_cells, int *n_size_cells)
> @@ -892,12 +889,32 @@ static int __init numa_setup_drmem_lmb(struct drmem_lmb *lmb,
>   	return 0;
>   }
>   
> +/*
> + * If hierarchy extends beyond primary_domain_index + 1, then next
> + * level corresponds to coregroup.
> + */
> +static int detect_and_enable_coregroup(const __be32 *associativity, int index)
> +{
> +	if (!associativity)
> +		return -1;

Even if 'index' is not 0 ?

> +
> +	if (!index) {
> +		index = of_read_number(associativity, 1);
> +
> +		if (index > primary_domain_index + 1)
> +			coregroup_enabled = 1;
> +		else
> +			index = -1;
> +	}
> +	return index;
> +}

I'd prefer something more flat:

	if (index)
		return index;

	index =  of_read_number(associativity, 1);

	if (index <= primary_domain_index + 1)
		return -1;

	coregroup_enabled = 1;
	return index;

> +
>   static int __init parse_numa_properties(void)
>   {
>   	struct device_node *memory, *pci;
> -	int default_nid = 0;
> -	unsigned long i;
> +	int default_nid = 0, index = 0;
>   	const __be32 *associativity;
> +	unsigned long i;
>   
>   	if (numa_enabled == 0) {
>   		pr_warn("disabled by user\n");
> @@ -930,7 +947,6 @@ static int __init parse_numa_properties(void)
>   	 */
>   	for_each_present_cpu(i) {
>   		__be32 vphn_assoc[VPHN_ASSOC_BUFSIZE];
> -		struct device_node *cpu;
>   		int nid = NUMA_NO_NODE;
>   
>   		memset(vphn_assoc, 0, VPHN_ASSOC_BUFSIZE * sizeof(__be32));
> @@ -938,7 +954,10 @@ static int __init parse_numa_properties(void)
>   		if (__vphn_get_associativity(i, vphn_assoc) == 0) {
>   			nid = associativity_to_nid(vphn_assoc);
>   			initialize_form1_numa_distance(vphn_assoc);
> +			if (!index)
> +				index = detect_and_enable_coregroup(vphn_assoc, index);
>   		} else {
> +			struct device_node *cpu;
>   
>   			/*
>   			 * Don't fall back to default_nid yet -- we will plug
> @@ -951,6 +970,8 @@ static int __init parse_numa_properties(void)
>   			associativity = of_get_associativity(cpu);
>   			if (associativity) {
>   				nid = associativity_to_nid(associativity);
> +				if (!index)
> +					index = detect_and_enable_coregroup(associativity, index);
>   				initialize_form1_numa_distance(associativity);
>   			}
>   			of_node_put(cpu);
> @@ -1431,9 +1452,26 @@ void find_and_update_cpu_nid(int cpu)
>   	pr_debug("%s:%d cpu %d nid %d\n", __func__, __LINE__, cpu, new_nid);
>   }
>   
> +static int topology_update_init(void)
> +{
> +	topology_inited = 1;
> +	return 0;
> +}
> +device_initcall(topology_update_init);
> +
> +#else
> +static long vphn_get_associativity(unsigned long cpu,
> +					__be32 *associativity)
> +{
> +	return -1;
> +}
> +#endif /* CONFIG_PPC_SPLPAR */
> +
>   int cpu_to_coregroup_id(int cpu)
>   {
> -	__be32 associativity[VPHN_ASSOC_BUFSIZE] = {0};
> +	int coregroup_id = cpu_to_core_id(cpu);
> +	struct device_node *cpunode = NULL;
> +	const __be32 *associativity;
>   	int index;
>   
>   	if (cpu < 0 || cpu > nr_cpu_ids)
> @@ -1442,24 +1480,31 @@ int cpu_to_coregroup_id(int cpu)
>   	if (!coregroup_enabled)
>   		goto out;
>   
> -	if (!firmware_has_feature(FW_FEATURE_VPHN))
> -		goto out;
> +	if (firmware_has_feature(FW_FEATURE_VPHN)) {
> +		__be32 tmp[VPHN_ASSOC_BUFSIZE] = {0};
>   
> -	if (vphn_get_associativity(cpu, associativity))
> +		if (vphn_get_associativity(cpu, tmp))
> +			goto out;
> +
> +		associativity = tmp;
> +
> +	} else {
> +		cpunode = of_get_cpu_node(cpu, NULL);
> +		if (!cpunode)
> +			goto out;
> +
> +		associativity = of_get_associativity(cpunode);
> +	}
> +	if (!associativity)
>   		goto out;
>   
>   	index = of_read_number(associativity, 1);
>   	if (index > primary_domain_index + 1)
> -		return of_read_number(&associativity[index - 1], 1);
> +		coregroup_id = of_read_number(&associativity[index - 1], 1);
>   
>   out:
> -	return cpu_to_core_id(cpu);
> -}
> +	if (cpunode)
> +		of_node_put(cpunode);
>   
> -static int topology_update_init(void)
> -{
> -	topology_inited = 1;
> -	return 0;
> +	return coregroup_id;
>   }
> -device_initcall(topology_update_init);
> -#endif /* CONFIG_PPC_SPLPAR */



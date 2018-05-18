Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40nTMk657FzF2Br
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 18 May 2018 23:21:22 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Michael Neuling <mikey@neuling.org>,
 Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com>,
 Akshay Adiga <akshay.adiga@linux.vnet.ibm.com>,
 Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>,
 Balbir Singh <bsingharora@gmail.com>, Oliver O'Halloran <oohall@gmail.com>,
 Nicholas Piggin <npiggin@gmail.com>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>
Subject: Re: [PATCH 1/2] powerpc: Detect the presence of big-core with
 interleaved threads
In-Reply-To: <1526037444-22876-2-git-send-email-ego@linux.vnet.ibm.com>
References: <1526037444-22876-1-git-send-email-ego@linux.vnet.ibm.com>
 <1526037444-22876-2-git-send-email-ego@linux.vnet.ibm.com>
Date: Fri, 18 May 2018 23:21:22 +1000
Message-ID: <87h8n5xfot.fsf@concordia.ellerman.id.au>
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

"Gautham R. Shenoy" <ego@linux.vnet.ibm.com> writes:

> diff --git a/arch/powerpc/kernel/setup-common.c b/arch/powerpc/kernel/setup-common.c
> index 0af5c11..884dff2 100644
> --- a/arch/powerpc/kernel/setup-common.c
> +++ b/arch/powerpc/kernel/setup-common.c
> @@ -436,8 +438,56 @@ static void __init cpu_init_thread_core_maps(int tpc)
>  	printk(KERN_DEBUG " (thread shift is %d)\n", threads_shift);
>  }
>  
> -
>  u32 *cpu_to_phys_id = NULL;
> +/*
> + * check_for_interleaved_big_core - Checks if the core represented by
> + *	 dn is a big-core whose threads are interleavings of the
> + *	 threads of the component small cores.
> + *
> + * @dn: device node corresponding to the core.
> + *
> + * Returns true if the core is a interleaved big-core.
> + * Returns false otherwise.
> + */
> +static inline bool check_for_interleaved_big_core(struct device_node *dn)
> +{
> +	int len, nr_groups, threads_per_group;
> +	const __be32 *thread_groups;
> +	__be32 *thread_list, *first_cpu_idx;
> +	int cur_cpu, next_cpu, i, j;
> +
> +	thread_groups = of_get_property(dn, "ibm,thread-groups", &len);
> +	if (!thread_groups)
> +		return false;

There are better device tree APIs than bare of_get_property() these
days, can you try to use those?

> +	nr_groups = be32_to_cpu(*(thread_groups + 1));
> +	if (nr_groups <= 1)
> +		return false;

eg. this would be of_property_read_u32_index()

> +
> +	threads_per_group = be32_to_cpu(*(thread_groups + 2));
> +	thread_list = (__be32 *)thread_groups + 3;
> +
> +	/*
> +	 * In case of an interleaved big-core, the thread-ids of the
> +	 * big-core can be obtained by interleaving the the thread-ids
> +	 * of the component small
> +	 *
> +	 * Eg: On a 8-thread big-core with two SMT4 small cores, the
> +	 * threads of the two component small cores will be
> +	 * {0, 2, 4, 6} and {1, 3, 5, 7}.
> +	 */
> +	for (i = 0; i < nr_groups; i++) {
> +		first_cpu_idx = thread_list + i * threads_per_group;
> +
> +		for (j = 0; j < threads_per_group - 1; j++) {
> +			cur_cpu = be32_to_cpu(*(first_cpu_idx + j));
> +			next_cpu = be32_to_cpu(*(first_cpu_idx + j + 1));
> +			if (next_cpu != cur_cpu + nr_groups)
> +				return false;
> +		}
> +	}
> +	return true;
> +}
>  
>  /**
>   * setup_cpu_maps - initialize the following cpu maps:
> @@ -565,7 +615,16 @@ void __init smp_setup_cpu_maps(void)
>  	vdso_data->processorCount = num_present_cpus();
>  #endif /* CONFIG_PPC64 */
>  
> -        /* Initialize CPU <=> thread mapping/
> +	dn = of_find_node_by_type(NULL, "cpu");
> +	if (dn) {
> +		if (check_for_interleaved_big_core(dn)) {
> +			has_interleaved_big_core = true;
> +			pr_info("Detected interleaved big-cores\n");
> +		}
> +		of_node_put(dn);
> +	}

This is a bit untidy, given how unlikely it is that you would have no
CPUs :)

You should be able to do the lookup of the property and the setting of
has_interleaved_big_core all inside check_for_interleaved_big_core().

cheers

Return-Path: <muriloo@linux.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41KsDz25n4zF1LZ
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  4 Jul 2018 03:53:54 +1000 (AEST)
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w63HnWhx055309
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 3 Jul 2018 13:53:52 -0400
Received: from e12.ny.us.ibm.com (e12.ny.us.ibm.com [129.33.205.202])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2k0dpcrjs6-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 03 Jul 2018 13:53:52 -0400
Received: from localhost
 by e12.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <muriloo@linux.ibm.com>;
 Tue, 3 Jul 2018 13:53:51 -0400
Date: Tue, 3 Jul 2018 14:53:46 -0300
From: Murilo Opsfelder Araujo <muriloo@linux.ibm.com>
To: "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Michael Neuling <mikey@neuling.org>,
 Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com>,
 Akshay Adiga <akshay.adiga@linux.vnet.ibm.com>,
 Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>,
 "Oliver O'Halloran" <oohall@gmail.com>,
 Nicholas Piggin <npiggin@gmail.com>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
Subject: Re: [v2 PATCH 2/2] powerpc: Enable CPU_FTR_ASYM_SMT for interleaved
 big-cores
References: <cover.1530609795.git.ego@linux.vnet.ibm.com>
 <573a559dff87da1d68a55bf6ada97b7697102909.1530609795.git.ego@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <573a559dff87da1d68a55bf6ada97b7697102909.1530609795.git.ego@linux.vnet.ibm.com>
Message-Id: <20180703175346.GB6474@kermit-br-ibm-com.br.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Jul 03, 2018 at 04:33:51PM +0530, Gautham R. Shenoy wrote:
> From: "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>
> 
> A pair of IBM POWER9 SMT4 cores can be fused together to form a big-core
> with 8 SMT threads. This can be discovered via the "ibm,thread-groups"
> CPU property in the device tree which will indicate which group of
> threads that share the L1 cache, translation cache and instruction data
> flow. If there are multiple such group of threads, then the core is a
> big-core.
> 
> Furthermore, if the thread-ids of the threads of the big-core can be
> obtained by interleaving the thread-ids of the thread-groups
> (component small core), then such a big-core is called an interleaved
> big-core.
> 
> Eg: Threads in the pair of component SMT4 cores of an interleaved
> big-core are numbered {0,2,4,6} and {1,3,5,7} respectively.
> 
> The SMT4 cores forming a big-core are more or less independent
> units. Thus when multiple tasks are scheduled to run on the fused
> core, we get the best performance when the tasks are spread across the
> pair of SMT4 cores.
> 
> This patch enables CPU_FTR_ASYM_SMT bit in the cpu-features on
> detecting the presence of interleaved big-cores at boot up. This will
> will bias the load-balancing of tasks on smaller numbered threads,
> which will automatically result in spreading the tasks uniformly
> across the associated pair of SMT4 cores.
> 
> Signed-off-by: Gautham R. Shenoy <ego@linux.vnet.ibm.com>
> ---
>  arch/powerpc/kernel/setup-common.c | 67 +++++++++++++++++++++++++++++++++++++-
>  1 file changed, 66 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/powerpc/kernel/setup-common.c b/arch/powerpc/kernel/setup-common.c
> index a78ec66..f63d797 100644
> --- a/arch/powerpc/kernel/setup-common.c
> +++ b/arch/powerpc/kernel/setup-common.c
> @@ -537,6 +537,56 @@ int get_cpu_thread_group_start(int cpu, struct thread_groups *tg)
>  	return -1;
>  }
>  
> +/*
> + * check_interleaved_big_core - Checks if the thread group tg
> + * corresponds to a big-core whose threads are interleavings of the
> + * threads of the component small cores.
> + *
> + * @tg: A thread-group struct for the core.
> + *
> + * Returns true if the core is a interleaved big-core.
> + * Returns false otherwise.
> + */
> +static inline bool check_interleaved_big_core(struct thread_groups *tg)
> +{
> +	int nr_groups;
> +	int threads_per_group;
> +	int cur_cpu, next_cpu, i, j;
> +
> +	nr_groups = tg->nr_groups;
> +	threads_per_group = tg->threads_per_group;
> +
> +	if (tg->property != 1)
> +		return false;
> +
> +	if (nr_groups < 2 || threads_per_group < 2)
> +		return false;
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
> +		int group_start = i * threads_per_group;
> +
> +		for (j = 0; j < threads_per_group - 1; j++) {
> +			int cur_idx = group_start + j;
> +
> +			cur_cpu = tg->thread_list[cur_idx];
> +			next_cpu = tg->thread_list[cur_idx + 1];
> +			if (next_cpu != cur_cpu + nr_groups)
> +				return false;
> +		}
> +	}
> +
> +	return true;
> +}
> +
>  /**
>   * setup_cpu_maps - initialize the following cpu maps:
>   *                  cpu_possible_mask
> @@ -560,6 +610,7 @@ void __init smp_setup_cpu_maps(void)
>  	struct device_node *dn;
>  	int cpu = 0;
>  	int nthreads = 1;
> +	bool has_interleaved_big_core = true;
>  
>  	DBG("smp_setup_cpu_maps()\n");
>  
> @@ -613,6 +664,12 @@ void __init smp_setup_cpu_maps(void)
>  		if (parse_thread_groups(dn, &tg) ||
>  		    tg.nr_groups < 1 || tg.property != 1) {
>  			has_big_cores = false;
> +			has_interleaved_big_core = false;
> +		}
> +
> +		if (has_interleaved_big_core) {
> +			has_interleaved_big_core =
> +				check_interleaved_big_core(&tg);
>  		}
>  
>  		if (cpu >= nr_cpu_ids) {
> @@ -669,7 +726,15 @@ void __init smp_setup_cpu_maps(void)
>  	vdso_data->processorCount = num_present_cpus();
>  #endif /* CONFIG_PPC64 */
>  
> -        /* Initialize CPU <=> thread mapping/
> +	if (has_interleaved_big_core) {
> +		int key = __builtin_ctzl(CPU_FTR_ASYM_SMT);
> +
> +		cur_cpu_spec->cpu_features |= CPU_FTR_ASYM_SMT;
> +		static_branch_enable(&cpu_feature_keys[key]);
> +		pr_info("Detected interleaved big-cores\n");
> +	}

Shouldn't we use cpu_has_feature(CPU_FTR_ASYM_SMT) before setting it?

> +
> +	/* Initialize CPU <=> thread mapping/
>  	 *
>  	 * WARNING: We assume that the number of threads is the same for
>  	 * every CPU in the system. If that is not the case, then some code
> -- 
> 1.9.4
> 

-- 
Murilo

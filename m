Return-Path: <maddy@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xDzPW33WNzDrCh
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 22 Jul 2017 17:13:19 +1000 (AEST)
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 v6M78wbH040222
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 22 Jul 2017 03:13:17 -0400
Received: from e23smtp04.au.ibm.com (e23smtp04.au.ibm.com [202.81.31.146])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2bv0s1t5as-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 22 Jul 2017 03:13:17 -0400
Received: from localhost
 by e23smtp04.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <maddy@linux.vnet.ibm.com>;
 Sat, 22 Jul 2017 17:13:14 +1000
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay07.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v6M7DCkB24117328
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 22 Jul 2017 17:13:12 +1000
Received: from d23av04.au.ibm.com (localhost [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v6M7DAbU027402
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 22 Jul 2017 17:13:11 +1000
Subject: Re: [PATCH v13 5/5] powerpc/perf: Add thread imc pmu support
To: mpe@ellerman.id.au
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 Anju T Sudhakar <anju@linux.vnet.ibm.com>,
 Hemant Kumar <hemant@linux.vnet.ibm.com>
References: <1500413796-18340-1-git-send-email-maddy@linux.vnet.ibm.com>
 <1500413796-18340-6-git-send-email-maddy@linux.vnet.ibm.com>
From: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
Date: Sat, 22 Jul 2017 12:43:05 +0530
MIME-Version: 1.0
In-Reply-To: <1500413796-18340-6-git-send-email-maddy@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Message-Id: <ace9a65b-1fc1-a75e-6ecb-ec2ce5ec0241@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

my bad, missed to change the authership of this patch.

From: Anju T Sudhakar <anju@linux.vnet.ibm.com>

On Wednesday 19 July 2017 03:06 AM, Madhavan Srinivasan wrote:
> Add support to register Thread In-Memory Collection pmu counters.
> Patch adds thread imc specific data structures, along with memory
> init functions and cpuhotplug support.
>
> Signed-off-by: Anju T Sudhakar <anju@linux.vnet.ibm.com>
> Signed-off-by: Hemant Kumar <hemant@linux.vnet.ibm.com>
> Signed-off-by: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
> ---
>   arch/powerpc/perf/imc-pmu.c | 269 +++++++++++++++++++++++++++++++++++++++++++-
>   include/linux/cpuhotplug.h  |   1 +
>   2 files changed, 266 insertions(+), 4 deletions(-)
>
> diff --git a/arch/powerpc/perf/imc-pmu.c b/arch/powerpc/perf/imc-pmu.c
> index cd8ba3b98d29..d9a4a7ab5281 100644
> --- a/arch/powerpc/perf/imc-pmu.c
> +++ b/arch/powerpc/perf/imc-pmu.c
> @@ -34,6 +34,11 @@ static cpumask_t core_imc_cpumask;
>   struct imc_pmu_ref *core_imc_refc;
>   static struct imc_pmu *core_imc_pmu;
>
> +//Thread imc data structs and variables
> +static DEFINE_PER_CPU(u64 *, thread_imc_mem);
> +static struct imc_pmu *thread_imc_pmu;
> +static int thread_imc_mem_size;
> +
>   struct imc_pmu *imc_event_to_pmu(struct perf_event *event)
>   {
>   	return container_of(event->pmu, struct imc_pmu, pmu);
> @@ -725,15 +730,188 @@ static int core_imc_event_init(struct perf_event *event)
>   	return 0;
>   }
>
> -static u64 * get_event_base_addr(struct perf_event *event)
> +/*
> + * Allocates a page of memory for each of the online cpus, and write the
> + * physical base address of that page to the LDBAR for that cpu.
> + *
> + * LDBAR Register Layout:
> + *
> + *  0          4         8         12        16        20        24        28
> + * | - - - - | - - - - | - - - - | - - - - | - - - - | - - - - | - - - - | - - - - |
> + *   | |       [   ]    [                   Counter Address [8:50]
> + *   | * Mode    |
> + *   |           * PB Scope
> + *   * Enable/Disable
> + *
> + *  32        36        40        44        48        52        56        60
> + * | - - - - | - - - - | - - - - | - - - - | - - - - | - - - - | - - - - | - - - - |
> + *           Counter Address [8:50]              ]
> + *
> + */
> +static int thread_imc_mem_alloc(int cpu_id, int size)
> +{
> +	u64 ldbar_value, *local_mem = per_cpu(thread_imc_mem, cpu_id);
> +	int phys_id = topology_physical_package_id(cpu_id);
> +
> +	if (!local_mem) {
> +		/*
> +		 * This case could happen only once at start, since we dont
> +		 * free the memory in cpu offline path.
> +		 */
> +		local_mem = page_address(alloc_pages_node(phys_id,
> +				  GFP_KERNEL | __GFP_ZERO | __GFP_THISNODE,
> +				  get_order(size)));
> +		if (!local_mem)
> +			return -ENOMEM;
> +
> +		per_cpu(thread_imc_mem, cpu_id) = local_mem;
> +	}
> +
> +	ldbar_value = ((u64)local_mem & THREAD_IMC_LDBAR_MASK) | THREAD_IMC_ENABLE;
> +
> +	mtspr(SPRN_LDBAR, ldbar_value);
> +	return 0;
> +}
> +
> +static int ppc_thread_imc_cpu_online(unsigned int cpu)
>   {
> +	return thread_imc_mem_alloc(cpu, thread_imc_mem_size);
> +}
> +
> +static int ppc_thread_imc_cpu_offline(unsigned int cpu)
> +{
> +	mtspr(SPRN_LDBAR, 0);
> +	return 0;
> +}
> +
> +static int thread_imc_cpu_init(void)
> +{
> +	return cpuhp_setup_state(CPUHP_AP_PERF_POWERPC_THREAD_IMC_ONLINE,
> +			  "perf/powerpc/imc_thread:online",
> +			  ppc_thread_imc_cpu_online,
> +			  ppc_thread_imc_cpu_offline);
> +}
> +
> +void thread_imc_pmu_sched_task(struct perf_event_context *ctx,
> +				      bool sched_in)
> +{
> +	int core_id;
> +	struct imc_pmu_ref *ref;
> +
> +	if (!is_core_imc_mem_inited(smp_processor_id()))
> +		return;
> +
> +	core_id = smp_processor_id() / threads_per_core;
>   	/*
> -	 * Subsequent patch will add code to detect caller imc pmu
> -	 * and return accordingly.
> +	 * imc pmus are enabled only when it is used.
> +	 * See if this is triggered for the first time.
> +	 * If yes, take the mutex lock and enable the counters.
> +	 * If not, just increment the count in ref count struct.
>   	 */
> +	ref = &core_imc_refc[core_id];
> +	if (!ref)
> +		return;
> +
> +	if (sched_in) {
> +		mutex_lock(&ref->lock);
> +		if (ref->refc == 0) {
> +			if (opal_imc_counters_start(OPAL_IMC_COUNTERS_CORE,
> +			     get_hard_smp_processor_id(smp_processor_id()))) {
> +				mutex_unlock(&ref->lock);
> +				pr_err("thread-imc: Unable to start the counter\
> +							for core %d\n", core_id);
> +				return;
> +			}
> +		}
> +		++ref->refc;
> +		mutex_unlock(&ref->lock);
> +	} else {
> +		mutex_lock(&ref->lock);
> +		ref->refc--;
> +		if (ref->refc == 0) {
> +			if (opal_imc_counters_stop(OPAL_IMC_COUNTERS_CORE,
> +			    get_hard_smp_processor_id(smp_processor_id()))) {
> +				mutex_unlock(&ref->lock);
> +				pr_err("thread-imc: Unable to stop the counters\
> +							for core %d\n", core_id);
> +				return;
> +			}
> +		} else if (ref->refc < 0) {
> +			ref->refc = 0;
> +		}
> +		mutex_unlock(&ref->lock);
> +	}
> +
> +	return;
> +}
> +
> +static int thread_imc_event_init(struct perf_event *event)
> +{
> +	u32 config = event->attr.config;
> +	struct task_struct *target;
> +	struct imc_pmu *pmu;
> +
> +	if (event->attr.type != event->pmu->type)
> +		return -ENOENT;
> +
> +	/* Sampling not supported */
> +	if (event->hw.sample_period)
> +		return -EINVAL;
> +
> +	event->hw.idx = -1;
> +	pmu = imc_event_to_pmu(event);
> +
> +	/* Sanity check for config offset */
> +	if (((config & IMC_EVENT_OFFSET_MASK) > pmu->counter_mem_size))
> +		return -EINVAL;
> +
> +	target = event->hw.target;
> +	if (!target)
> +		return -EINVAL;
> +
> +	event->pmu->task_ctx_nr = perf_sw_context;
> +	return 0;
> +}
> +
> +static bool is_thread_imc_pmu(struct perf_event *event)
> +{
> +	if (!strncmp(event->pmu->name, "thread_imc", strlen("thread_imc")))
> +		return true;
> +
> +	return false;
> +}
> +
> +static u64 * get_event_base_addr(struct perf_event *event)
> +{
> +	u64 addr;
> +
> +	if (is_thread_imc_pmu(event)) {
> +		addr = (u64)per_cpu(thread_imc_mem, smp_processor_id());
> +		return (u64 *)(addr + (event->attr.config & IMC_EVENT_OFFSET_MASK));
> +	}
> +
>   	return (u64 *)event->hw.event_base;
>   }
>
> +static void thread_imc_pmu_start_txn(struct pmu *pmu,
> +				     unsigned int txn_flags)
> +{
> +	if (txn_flags & ~PERF_PMU_TXN_ADD)
> +		return;
> +	perf_pmu_disable(pmu);
> +}
> +
> +static void thread_imc_pmu_cancel_txn(struct pmu *pmu)
> +{
> +	perf_pmu_enable(pmu);
> +}
> +
> +static int thread_imc_pmu_commit_txn(struct pmu *pmu)
> +{
> +	perf_pmu_enable(pmu);
> +	return 0;
> +}
> +
>   static u64 imc_read_counter(struct perf_event *event)
>   {
>   	u64 *addr, data;
> @@ -791,6 +969,26 @@ static int imc_event_add(struct perf_event *event, int flags)
>   	return 0;
>   }
>
> +static int thread_imc_event_add(struct perf_event *event, int flags)
> +{
> +	if (flags & PERF_EF_START)
> +		imc_event_start(event, flags);
> +
> +	/* Enable the sched_task to start the engine */
> +	perf_sched_cb_inc(event->ctx->pmu);
> +	return 0;
> +}
> +
> +static void thread_imc_event_del(struct perf_event *event, int flags)
> +{
> +	/*
> +	 * Take a snapshot and calculate the delta and update
> +	 * the event counter values.
> +	 */
> +	imc_event_update(event);
> +	perf_sched_cb_dec(event->ctx->pmu);
> +}
> +
>   /* update_pmu_ops : Populate the appropriate operations for "pmu" */
>   static int update_pmu_ops(struct imc_pmu *pmu)
>   {
> @@ -812,6 +1010,15 @@ static int update_pmu_ops(struct imc_pmu *pmu)
>   		pmu->pmu.event_init = core_imc_event_init;
>   		pmu->attr_groups[IMC_CPUMASK_ATTR] = &imc_pmu_cpumask_attr_group;
>   		break;
> +	case IMC_DOMAIN_THREAD:
> +		pmu->pmu.event_init = thread_imc_event_init;
> +		pmu->pmu.sched_task = thread_imc_pmu_sched_task;
> +		pmu->pmu.add = thread_imc_event_add;
> +		pmu->pmu.del = thread_imc_event_del;
> +		pmu->pmu.start_txn = thread_imc_pmu_start_txn;
> +		pmu->pmu.cancel_txn = thread_imc_pmu_cancel_txn;
> +		pmu->pmu.commit_txn = thread_imc_pmu_commit_txn;
> +		break;
>   	default:
>   		break;
>   	}
> @@ -879,6 +1086,31 @@ static void cleanup_all_core_imc_memory(void)
>   	kfree(core_imc_refc);
>   }
>
> +static void thread_imc_ldbar_disable(void *dummy)
> +{
> +	/*
> +	 * By Zeroing LDBAR, we disable thread-imc
> +	 * updates.
> +	 */
> +	mtspr(SPRN_LDBAR, 0);
> +}
> +
> +void thread_imc_disable(void)
> +{
> +	on_each_cpu(thread_imc_ldbar_disable, NULL, 1);
> +}
> +
> +static void cleanup_all_thread_imc_memory(void)
> +{
> +	int i, order = get_order(thread_imc_mem_size);
> +
> +	for_each_online_cpu(i) {
> +		if (per_cpu(thread_imc_mem, i))
> +			free_pages((u64)per_cpu(thread_imc_mem, i), order);
> +
> +	}
> +}
> +
>   /*
>    * Common function to unregister cpu hotplug callback and
>    * free the memory.
> @@ -905,6 +1137,12 @@ static void imc_common_cpuhp_mem_free(struct imc_pmu *pmu_ptr)
>   		cleanup_all_core_imc_memory();
>   	}
>
> +	/* Free thread_imc memory */
> +	if (pmu_ptr->domain == IMC_DOMAIN_THREAD) {
> +		cpuhp_remove_state(CPUHP_AP_PERF_POWERPC_THREAD_IMC_ONLINE);
> +		cleanup_all_thread_imc_memory();
> +	}
> +
>   	/* Only free the attr_groups which are dynamically allocated  */
>   	kfree(pmu_ptr->attr_groups[IMC_EVENT_ATTR]->attrs);
>   	kfree(pmu_ptr->attr_groups[IMC_EVENT_ATTR]);
> @@ -920,7 +1158,7 @@ static int imc_mem_init(struct imc_pmu *pmu_ptr, struct device_node *parent,
>   								int pmu_index)
>   {
>   	const char *s;
> -	int nr_cores;
> +	int nr_cores, cpu, res;
>
>   	if (of_property_read_string(parent, "name", &s))
>   		return -ENODEV;
> @@ -956,6 +1194,21 @@ static int imc_mem_init(struct imc_pmu *pmu_ptr, struct device_node *parent,
>
>   		core_imc_pmu = pmu_ptr;
>   		break;
> +	case IMC_DOMAIN_THREAD:
> +		/* Update the pmu name */
> +		pmu_ptr->pmu.name = kasprintf(GFP_KERNEL, "%s%s", s, "_imc");
> +		if (!pmu_ptr->pmu.name)
> +			return -ENOMEM;
> +
> +		thread_imc_mem_size = pmu_ptr->counter_mem_size;
> +		for_each_online_cpu(cpu) {
> +			res = thread_imc_mem_alloc(cpu, pmu_ptr->counter_mem_size);
> +			if (res)
> +				return res;
> +		}
> +
> +		thread_imc_pmu = pmu_ptr;
> +		break;
>   	default:
>   		return -EINVAL;
>   	}
> @@ -1014,6 +1267,14 @@ int init_imc_pmu(struct device_node *parent, struct imc_pmu *pmu_ptr, int pmu_id
>   		}
>
>   		break;
> +	case IMC_DOMAIN_THREAD:
> +		ret = thread_imc_cpu_init();
> +		if (ret) {
> +			cleanup_all_thread_imc_memory();
> +			return ret;
> +		}
> +
> +		break;
>   	default:
>   		return  -1;	/* Unknown domain */
>   	}
> diff --git a/include/linux/cpuhotplug.h b/include/linux/cpuhotplug.h
> index 1be505db0090..1bc7dcfbf7b3 100644
> --- a/include/linux/cpuhotplug.h
> +++ b/include/linux/cpuhotplug.h
> @@ -141,6 +141,7 @@ enum cpuhp_state {
>   	CPUHP_AP_PERF_ARM_QCOM_L3_ONLINE,
>   	CPUHP_AP_PERF_POWERPC_NEST_IMC_ONLINE,
>   	CPUHP_AP_PERF_POWERPC_CORE_IMC_ONLINE,
> +	CPUHP_AP_PERF_POWERPC_THREAD_IMC_ONLINE,
>   	CPUHP_AP_WORKQUEUE_ONLINE,
>   	CPUHP_AP_RCUTREE_ONLINE,
>   	CPUHP_AP_ONLINE_DYN,

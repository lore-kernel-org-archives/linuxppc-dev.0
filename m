Return-Path: <maddy@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wkH3f5c7XzDqVh
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  9 Jun 2017 06:25:18 +1000 (AEST)
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v58KNo2E068514
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 8 Jun 2017 16:25:16 -0400
Received: from e23smtp05.au.ibm.com (e23smtp05.au.ibm.com [202.81.31.147])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2aycvr1n73-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 08 Jun 2017 16:25:15 -0400
Received: from localhost
 by e23smtp05.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <maddy@linux.vnet.ibm.com>;
 Fri, 9 Jun 2017 06:25:11 +1000
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay08.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v58KP3l73998164
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 9 Jun 2017 06:25:03 +1000
Received: from d23av04.au.ibm.com (localhost [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v58KP16A023116
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 9 Jun 2017 06:25:01 +1000
From: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
To: mpe@ellerman.id.au
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 stewart@linux.vnet.ibm.com, eranian@google.com,
 benh@kernel.crashing.org, paulus@samba.org, sukadev@linux.vnet.ibm.com,
 ego@linux.vnet.ibm.com, mikey@neuling.org, dja@axtens.net,
 anton@samba.org, Anju T Sudhakar <anju@linux.vnet.ibm.com>,
 Hemant Kumar <hemant@linux.vnet.ibm.com>,
 Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
Subject: [PATCH v10 09/10] powerpc/perf: Thread IMC PMU functions
Date: Fri,  9 Jun 2017 01:54:42 +0530
Message-Id: <1496953482-17017-1-git-send-email-maddy@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Anju T Sudhakar <anju@linux.vnet.ibm.com>

Code to add PMU functions required for event initialization,
read, update, add, del etc. for thread IMC PMU. Thread IMC PMUs are used
for per-task monitoring.

For each CPU, a page of memory is allocated and is kept static i.e.,
these pages will exist till the machine shuts down. The base address of
this page is assigned to the ldbar of that cpu. As soon as we do that,
the thread IMC counters start running for that cpu and the data of these
counters are assigned to the page allocated. But we use this for
per-task monitoring. Whenever we start monitoring a task, the event is
added is onto the task. At that point, we read the initial value of the
event. Whenever, we stop monitoring the task, the final value is taken
and the difference is the event data.

Now, a task can move to a different cpu. Suppose a task X is moving from
cpu A to cpu B. When the task is scheduled out of A, we get an
event_del for A, and hence, the event data is updated. And, we stop
updating the X's event data. As soon as X moves on to B, event_add is
called for B, and we again update the event_data. And this is how it
keeps on updating the event data even when the task is scheduled on to
different cpus.

Signed-off-by: Anju T Sudhakar <anju@linux.vnet.ibm.com>
Signed-off-by: Hemant Kumar <hemant@linux.vnet.ibm.com>
Signed-off-by: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/imc-pmu.h        |   4 +
 arch/powerpc/perf/imc-pmu.c               | 219 +++++++++++++++++++++++++++++-
 arch/powerpc/platforms/powernv/opal-imc.c |   2 +
 3 files changed, 218 insertions(+), 7 deletions(-)

diff --git a/arch/powerpc/include/asm/imc-pmu.h b/arch/powerpc/include/asm/imc-pmu.h
index 6659846c21ab..56b2ace565f4 100644
--- a/arch/powerpc/include/asm/imc-pmu.h
+++ b/arch/powerpc/include/asm/imc-pmu.h
@@ -43,6 +43,9 @@
 #define IMC_DTB_COMPAT			"ibm,opal-in-memory-counters"
 #define IMC_DTB_UNIT_COMPAT		"ibm,imc-counters"
 
+#define THREAD_IMC_LDBAR_MASK           0x0003ffffffffe000
+#define THREAD_IMC_ENABLE               0x8000000000000000
+
 /*
  * Structure to hold memory address information for imc units.
  */
@@ -102,4 +105,5 @@ extern struct imc_pmu *per_nest_pmu_arr[IMC_MAX_PMUS];
 extern struct imc_pmu *core_imc_pmu;
 extern int imc_control(unsigned long type, bool operation);
 extern int __init init_imc_pmu(struct imc_events *events, int idx, struct imc_pmu *pmu_ptr);
+void thread_imc_disable(void);
 #endif /* PPC_POWERNV_IMC_PMU_DEF_H */
diff --git a/arch/powerpc/perf/imc-pmu.c b/arch/powerpc/perf/imc-pmu.c
index e15a8df3d3b7..ca8c0b8e157a 100644
--- a/arch/powerpc/perf/imc-pmu.c
+++ b/arch/powerpc/perf/imc-pmu.c
@@ -18,6 +18,9 @@
 #include <asm/smp.h>
 #include <linux/string.h>
 
+/* Maintains base address for all the cpus */
+static DEFINE_PER_CPU(u64 *, thread_imc_mem);
+
 /* Needed for sanity check */
 extern u64 nest_max_offset;
 extern u64 core_max_offset;
@@ -39,6 +42,7 @@ static struct cpumask imc_result_mask;
 static DEFINE_MUTEX(imc_control_mutex);
 
 struct imc_pmu *core_imc_pmu;
+static int thread_imc_mem_size;
 
 struct imc_pmu *imc_event_to_pmu(struct perf_event *event)
 {
@@ -317,18 +321,59 @@ bool is_core_imc_mem_inited(int cpu)
 }
 
 /*
- * imc_mem_init : Function to support memory allocation for core imc.
+ * Allocates a page of memory for each of the online cpus, and, writes the
+ * physical base address of that page to the LDBAR for that cpu. This starts
+ * the thread IMC counters.
+ */
+static int thread_imc_mem_alloc(int cpu_id, int size)
+{
+	u64 ldbar_value, *local_mem;
+	int phys_id = topology_physical_package_id(cpu_id);
+
+	if (per_cpu(thread_imc_mem, cpu_id) != NULL)
+		return 0;
+
+	local_mem = alloc_pages_exact_nid(phys_id,
+				(size_t)size, GFP_KERNEL | __GFP_ZERO);
+	if (!local_mem)
+		return -ENOMEM;
+
+	per_cpu(thread_imc_mem, cpu_id) = local_mem;
+
+	ldbar_value = ((u64)local_mem & (u64)THREAD_IMC_LDBAR_MASK) |
+						(u64)THREAD_IMC_ENABLE;
+
+	mtspr(SPRN_LDBAR, ldbar_value);
+	return 0;
+}
+
+/*
+ * imc_mem_init : Function to support memory allocation for core and thread imc.
  */
 static int imc_mem_init(struct imc_pmu *pmu_ptr)
 {
-	int nr_cores;
+	int nr_cores, cpu, res;
 
 	if (pmu_ptr->imc_counter_mmaped)
 		return 0;
-	nr_cores = num_present_cpus() / threads_per_core;
-	pmu_ptr->mem_info = kzalloc((sizeof(struct imc_mem_info) * nr_cores), GFP_KERNEL);
-	if (!pmu_ptr->mem_info)
-		return -ENOMEM;
+	switch (pmu_ptr->domain) {
+	case IMC_DOMAIN_CORE:
+		nr_cores = num_present_cpus() / threads_per_core;
+		pmu_ptr->mem_info = kzalloc((sizeof(struct imc_mem_info) * nr_cores), GFP_KERNEL);
+		if (!pmu_ptr->mem_info)
+			return -ENOMEM;
+		break;
+	case IMC_DOMAIN_THREAD:
+		thread_imc_mem_size = pmu_ptr->counter_mem_size;
+		for_each_online_cpu(cpu) {
+			res = thread_imc_mem_alloc(cpu, pmu_ptr->counter_mem_size);
+			if (res)
+				return res;
+		}
+		break;
+	default:
+		return -EINVAL;
+	}
 	return 0;
 }
 
@@ -522,6 +567,75 @@ static int core_imc_event_init(struct perf_event *event)
 	return 0;
 }
 
+static int thread_imc_event_init(struct perf_event *event)
+{
+	int rc;
+	struct task_struct *target;
+
+	if (event->attr.type != event->pmu->type)
+		return -ENOENT;
+
+	/* Sampling not supported */
+	if (event->hw.sample_period)
+		return -EINVAL;
+
+	event->hw.idx = -1;
+
+	/* Sanity check for config (event offset) */
+	if (event->attr.config > thread_max_offset)
+		return -EINVAL;
+
+	target = event->hw.target;
+
+	if (!target)
+		return -EINVAL;
+
+	if (!is_core_imc_mem_inited(event->cpu))
+		return -ENODEV;
+
+	event->pmu->task_ctx_nr = perf_sw_context;
+	/*
+	 * Core pmu units are enabled only when it is used.
+	 * See if this is triggered for the first time.
+	 * If yes, take the mutex lock and enable the core counters.
+	 * If not, just increment the count in core_events.
+	 */
+	if (atomic_inc_return(&core_events) == 1) {
+		mutex_lock(&imc_core_reserve);
+		rc = imc_control(OPAL_IMC_COUNTERS_CORE, true);
+		mutex_unlock(&imc_core_reserve);
+		if (rc) {
+			atomic_dec_return(&core_events);
+			pr_err("IMC: Unable to start the counters\n");
+			return -ENODEV;
+		}
+	}
+	event->destroy = core_imc_counters_release;
+	return 0;
+}
+
+static void thread_imc_read_counter(struct perf_event *event)
+{
+	u64 *addr, data;
+
+	addr = per_cpu(thread_imc_mem, smp_processor_id()) + event->attr.config;
+	data = __be64_to_cpu(READ_ONCE(*addr));
+	local64_set(&event->hw.prev_count, data);
+}
+
+static void thread_imc_perf_event_update(struct perf_event *event)
+{
+	u64 counter_prev, counter_new, final_count, *addr;
+
+	addr = per_cpu(thread_imc_mem, smp_processor_id()) + event->attr.config;
+	counter_prev = local64_read(&event->hw.prev_count);
+	counter_new = __be64_to_cpu(READ_ONCE(*addr));
+	final_count = counter_new - counter_prev;
+
+	local64_set(&event->hw.prev_count, counter_new);
+	local64_add(final_count, &event->count);
+}
+
 static void imc_read_counter(struct perf_event *event)
 {
 	u64 *addr, data;
@@ -583,6 +697,53 @@ static int imc_event_add(struct perf_event *event, int flags)
 	return 0;
 }
 
+static void thread_imc_event_start(struct perf_event *event, int flags)
+{
+	thread_imc_read_counter(event);
+}
+
+static void thread_imc_event_stop(struct perf_event *event, int flags)
+{
+	thread_imc_perf_event_update(event);
+}
+
+static void thread_imc_event_del(struct perf_event *event, int flags)
+{
+	thread_imc_perf_event_update(event);
+}
+
+static int thread_imc_event_add(struct perf_event *event, int flags)
+{
+	thread_imc_event_start(event, flags);
+
+	return 0;
+}
+
+static void thread_imc_pmu_start_txn(struct pmu *pmu,
+				     unsigned int txn_flags)
+{
+	if (txn_flags & ~PERF_PMU_TXN_ADD)
+		return;
+	perf_pmu_disable(pmu);
+}
+
+static void thread_imc_pmu_cancel_txn(struct pmu *pmu)
+{
+	perf_pmu_enable(pmu);
+}
+
+static int thread_imc_pmu_commit_txn(struct pmu *pmu)
+{
+	perf_pmu_enable(pmu);
+	return 0;
+}
+
+static void thread_imc_pmu_sched_task(struct perf_event_context *ctx,
+				  bool sched_in)
+{
+	return;
+}
+
 /* update_pmu_ops : Populate the appropriate operations for "pmu" */
 static int update_pmu_ops(struct imc_pmu *pmu)
 {
@@ -603,7 +764,26 @@ static int update_pmu_ops(struct imc_pmu *pmu)
 	pmu->attr_groups[IMC_CPUMASK_ATTR] = &imc_pmu_cpumask_attr_group;
 	pmu->attr_groups[IMC_FORMAT_ATTR] = &imc_format_group;
 	pmu->pmu.attr_groups = pmu->attr_groups;
-
+	if (pmu->domain == IMC_DOMAIN_THREAD) {
+		pmu->pmu.event_init = thread_imc_event_init;
+		pmu->pmu.start = thread_imc_event_start;
+		pmu->pmu.add = thread_imc_event_add;
+		pmu->pmu.del = thread_imc_event_del;
+		pmu->pmu.stop = thread_imc_event_stop;
+		pmu->pmu.read = thread_imc_perf_event_update;
+		pmu->pmu.start_txn = thread_imc_pmu_start_txn;
+		pmu->pmu.cancel_txn = thread_imc_pmu_cancel_txn;
+		pmu->pmu.commit_txn = thread_imc_pmu_commit_txn;
+		pmu->pmu.sched_task = thread_imc_pmu_sched_task;
+
+		/*
+		 * Since thread_imc does not have any CPUMASK attr,
+		 * this may drop the "events" attr all together.
+		 * So swap the IMC_EVENT_ATTR slot with IMC_CPUMASK_ATTR.
+		 */
+		pmu->attr_groups[IMC_CPUMASK_ATTR] = pmu->attr_groups[IMC_EVENT_ATTR];
+		pmu->attr_groups[IMC_EVENT_ATTR] = NULL;
+	}
 	return 0;
 }
 
@@ -664,6 +844,27 @@ static int update_events_in_group(struct imc_events *events,
 	return 0;
 }
 
+static void thread_imc_ldbar_disable(void *dummy)
+{
+	/* LDBAR spr is a per-thread */
+	mtspr(SPRN_LDBAR, 0);
+}
+
+void thread_imc_disable(void)
+{
+	on_each_cpu(thread_imc_ldbar_disable, NULL, 1);
+}
+
+static void cleanup_all_thread_imc_memory(void)
+{
+	int i;
+
+	for_each_online_cpu(i) {
+		if (per_cpu(thread_imc_mem, cpu))
+			free_pages(per_cpu(thread_imc_mem, cpu), 0);
+	}
+}
+
 /*
  * init_imc_pmu : Setup and register the IMC pmu device.
  *
@@ -731,5 +932,9 @@ int __init init_imc_pmu(struct imc_events *events, int idx,
 		cpuhp_remove_state(CPUHP_AP_PERF_POWERPC_CORE_IMC_ONLINE);
 	}
 
+	/* For thread_imc, we have allocated memory, we need to free it */
+	if (pmu_ptr->domain == IMC_DOMAIN_THREAD)
+		cleanup_all_thread_imc_memory();
+
 	return ret;
 }
diff --git a/arch/powerpc/platforms/powernv/opal-imc.c b/arch/powerpc/platforms/powernv/opal-imc.c
index 5fa008cb1b93..2e89096fec0c 100644
--- a/arch/powerpc/platforms/powernv/opal-imc.c
+++ b/arch/powerpc/platforms/powernv/opal-imc.c
@@ -542,6 +542,8 @@ static void opal_imc_counters_shutdown(struct platform_device *pdev)
 {
 	/* Disable the IMC Core functions */
 	imc_control(OPAL_IMC_COUNTERS_CORE, false);
+	/* Disable the IMC Thread functions */
+	thread_imc_disable();
 }
 
 static const struct of_device_id opal_imc_match[] = {
-- 
2.7.4

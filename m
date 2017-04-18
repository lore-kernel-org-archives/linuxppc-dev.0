Return-Path: <anju@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3w6rz24q0qzDq8t
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 19 Apr 2017 03:02:22 +1000 (AEST)
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v3IGwk2b021627
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 18 Apr 2017 13:02:20 -0400
Received: from e28smtp09.in.ibm.com (e28smtp09.in.ibm.com [125.16.236.9])
 by mx0b-001b2d01.pphosted.com with ESMTP id 29wpbrhakc-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 18 Apr 2017 13:02:20 -0400
Received: from localhost
 by e28smtp09.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <anju@linux.vnet.ibm.com>;
 Tue, 18 Apr 2017 22:32:16 +0530
Received: from d28av06.in.ibm.com (d28av06.in.ibm.com [9.184.220.48])
 by d28relay10.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v3IH0oBd21364946
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 18 Apr 2017 22:30:50 +0530
Received: from d28av06.in.ibm.com (localhost [127.0.0.1])
 by d28av06.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v3IH2ABn024818
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 18 Apr 2017 22:32:13 +0530
From: Anju T Sudhakar <anju@linux.vnet.ibm.com>
To: mpe@ellerman.id.au
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 ego@linux.vnet.ibm.com, bsingharora@gmail.com,
 benh@kernel.crashing.org, paulus@samba.org, anton@samba.org,
 sukadev@linux.vnet.ibm.com, mikey@neuling.org,
 stewart@linux.vnet.ibm.com, dja@axtens.net, eranian@google.com,
 hemant@linux.vnet.ibm.com, maddy@linux.vnet.ibm.com,
 anju@linux.vnet.ibm.com
Subject: [PATCH v7 9/10] powerpc/perf: Thread IMC PMU functions
Date: Tue, 18 Apr 2017 22:31:49 +0530
In-Reply-To: <1492534910-7991-1-git-send-email-anju@linux.vnet.ibm.com>
References: <1492534910-7991-1-git-send-email-anju@linux.vnet.ibm.com>
Message-Id: <1492534910-7991-10-git-send-email-anju@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This patch adds the PMU functions required for event initialization,
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
 arch/powerpc/include/asm/imc-pmu.h        |   5 +
 arch/powerpc/perf/imc-pmu.c               | 201 ++++++++++++++++++++++++++++++
 arch/powerpc/platforms/powernv/opal-imc.c |   3 +
 3 files changed, 209 insertions(+)

diff --git a/arch/powerpc/include/asm/imc-pmu.h b/arch/powerpc/include/asm/imc-pmu.h
index 6260e61..cc04712 100644
--- a/arch/powerpc/include/asm/imc-pmu.h
+++ b/arch/powerpc/include/asm/imc-pmu.h
@@ -42,6 +42,7 @@
  * IMC Core engine expects 8K bytes of memory for counter collection.
  */
 #define IMC_CORE_COUNTER_MEM		8192
+#define IMC_THREAD_COUNTER_MEM		8192
 
 /*
  *Compatbility macros for IMC devices
@@ -51,6 +52,9 @@
 #define IMC_DTB_CORE_COMPAT		"ibm,imc-counters-core"
 #define IMC_DTB_THREAD_COMPAT		"ibm,imc-counters-thread"
 
+#define THREAD_IMC_LDBAR_MASK           0x0003ffffffffe000
+#define THREAD_IMC_ENABLE               0x8000000000000000
+
 /*
  * Structure to hold per chip specific memory address
  * information for nest pmus. Nest Counter data are exported
@@ -110,4 +114,5 @@ extern struct imc_pmu *per_nest_pmu_arr[IMC_MAX_PMUS];
 extern struct imc_pmu *core_imc_pmu;
 extern int __init init_imc_pmu(struct imc_events *events,int idx, struct imc_pmu *pmu_ptr);
 void core_imc_disable(void);
+void thread_imc_disable(void);
 #endif /* PPC_POWERNV_IMC_PMU_DEF_H */
diff --git a/arch/powerpc/perf/imc-pmu.c b/arch/powerpc/perf/imc-pmu.c
index ac69d81..b055748 100644
--- a/arch/powerpc/perf/imc-pmu.c
+++ b/arch/powerpc/perf/imc-pmu.c
@@ -38,6 +38,9 @@ static u64 per_core_pdbar_add[IMC_MAX_CHIPS][IMC_MAX_CORES];
 static cpumask_t core_imc_cpumask;
 struct imc_pmu *core_imc_pmu;
 
+/* Maintains base address for all the cpus */
+static u64 per_cpu_add[NR_CPUS];
+
 /* Needed for sanity check */
 extern u64 nest_max_offset;
 extern u64 core_max_offset;
@@ -482,6 +485,56 @@ static int core_imc_event_init(struct perf_event *event)
 	return 0;
 }
 
+static int thread_imc_event_init(struct perf_event *event)
+{
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
+	event->pmu->task_ctx_nr = perf_sw_context;
+	return 0;
+}
+
+static void thread_imc_read_counter(struct perf_event *event)
+{
+	u64 *addr, data;
+	int cpu_id = smp_processor_id();
+
+	addr = (u64 *)(per_cpu_add[cpu_id] + event->attr.config);
+	data = __be64_to_cpu(READ_ONCE(*addr));
+	local64_set(&event->hw.prev_count, data);
+}
+
+static void thread_imc_perf_event_update(struct perf_event *event)
+{
+	u64 counter_prev, counter_new, final_count, *addr;
+	int cpu_id = smp_processor_id();
+
+	addr = (u64 *)(per_cpu_add[cpu_id] + event->attr.config);
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
@@ -723,6 +776,84 @@ static int core_imc_event_add(struct perf_event *event, int flags)
 }
 
 
+static void thread_imc_event_start(struct perf_event *event, int flags)
+{
+	int rc;
+
+	/*
+	 * Core pmu units are enabled only when it is used.
+	 * See if this is triggered for the first time.
+	 * If yes, take the mutex lock and enable the core counters.
+	 * If not, just increment the count in core_events.
+	 */
+	if (atomic_inc_return(&core_events) == 1) {
+		mutex_lock(&imc_core_reserve);
+		rc = core_imc_control(IMC_COUNTER_ENABLE);
+		mutex_unlock(&imc_core_reserve);
+		if (rc)
+			pr_err("IMC: Unbale to start the counters\n");
+	}
+	thread_imc_read_counter(event);
+}
+
+static void thread_imc_event_stop(struct perf_event *event, int flags)
+{
+	int rc;
+
+	thread_imc_perf_event_update(event);
+	/*
+	 * See if we need to disable the IMC PMU.
+	 * If no events are currently in use, then we have to take a
+	 * mutex to ensure that we don't race with another task doing
+	 * enable or disable the core counters.
+	 */
+	if (atomic_dec_return(&core_events) == 0) {
+		mutex_lock(&imc_core_reserve);
+		rc = core_imc_control(IMC_COUNTER_DISABLE);
+		mutex_unlock(&imc_core_reserve);
+		if (rc)
+			pr_err("IMC: Disable counters failed\n");
+
+	}
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
@@ -749,6 +880,19 @@ static int update_pmu_ops(struct imc_pmu *pmu)
 	pmu->attr_groups[IMC_FORMAT_ATTR] = &imc_format_group;
 	pmu->pmu.attr_groups = pmu->attr_groups;
 
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
+	}
+
 	return 0;
 }
 
@@ -809,6 +953,56 @@ static int update_events_in_group(struct imc_events *events,
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
+static void cleanup_thread_imc_memory(void *dummy)
+{
+	int cpu_id = smp_processor_id();
+	u64 addr = per_cpu_add[cpu_id];
+
+	/* Only if the address is non-zero, shall we free it */
+	if (addr)
+		free_pages(addr, 0);
+}
+
+static void cleanup_all_thread_imc_memory(void)
+{
+	on_each_cpu(cleanup_thread_imc_memory, NULL, 1);
+}
+
+/*
+ * Allocates a page of memory for each of the online cpus, and, writes the
+ * physical base address of that page to the LDBAR for that cpu. This starts
+ * the thread IMC counters.
+ */
+static void thread_imc_mem_alloc(void *dummy)
+{
+	u64 ldbar_addr, ldbar_value;
+	int cpu_id = smp_processor_id();
+	int phys_id = topology_physical_package_id(smp_processor_id());
+
+	per_cpu_add[cpu_id] = (u64)alloc_pages_exact_nid(phys_id,
+			(size_t)IMC_THREAD_COUNTER_MEM, GFP_KERNEL | __GFP_ZERO);
+	ldbar_addr = (u64)virt_to_phys((void *)per_cpu_add[cpu_id]);
+	ldbar_value = (ldbar_addr & (u64)THREAD_IMC_LDBAR_MASK) |
+		(u64)THREAD_IMC_ENABLE;
+	mtspr(SPRN_LDBAR, ldbar_value);
+}
+
+void thread_imc_cpu_init(void)
+{
+	on_each_cpu(thread_imc_mem_alloc, NULL, 1);
+}
+
 /*
  * init_imc_pmu : Setup and register the IMC pmu device.
  *
@@ -836,6 +1030,9 @@ int __init init_imc_pmu(struct imc_events *events, int idx,
 		if (ret)
 			return ret;
 		break;
+	case IMC_DOMAIN_THREAD:
+		thread_imc_cpu_init();
+		break;
 	default:
 		return -1;  /* Unknown domain */
 	}
@@ -868,5 +1065,9 @@ int __init init_imc_pmu(struct imc_events *events, int idx,
 	if (pmu_ptr->domain == IMC_DOMAIN_CORE)
 		cleanup_all_core_imc_memory();
 
+	/* For thread_imc, we have allocated memory, we need to free it */
+	if (pmu_ptr->domain == IMC_DOMAIN_THREAD)
+		cleanup_all_thread_imc_memory();
+
 	return ret;
 }
diff --git a/arch/powerpc/platforms/powernv/opal-imc.c b/arch/powerpc/platforms/powernv/opal-imc.c
index 940f6b9..e36722b 100644
--- a/arch/powerpc/platforms/powernv/opal-imc.c
+++ b/arch/powerpc/platforms/powernv/opal-imc.c
@@ -582,6 +582,9 @@ static void opal_imc_counters_shutdown(struct platform_device *pdev)
 {
 	/* Disable the IMC Core functions */
 	core_imc_disable();
+
+	/* Disable the IMC Thread functions */
+	thread_imc_disable();
 }
 
 static const struct of_device_id opal_imc_match[] = {
-- 
2.7.4

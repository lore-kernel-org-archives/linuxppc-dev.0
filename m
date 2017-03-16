Return-Path: <maddy@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vkL0R0GYszDqYy
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 Mar 2017 18:37:26 +1100 (AEDT)
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v2G7SdHl105278
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 Mar 2017 03:37:18 -0400
Received: from e23smtp02.au.ibm.com (e23smtp02.au.ibm.com [202.81.31.144])
 by mx0a-001b2d01.pphosted.com with ESMTP id 297bu78meu-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 Mar 2017 03:37:18 -0400
Received: from localhost
 by e23smtp02.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <maddy@linux.vnet.ibm.com>;
 Thu, 16 Mar 2017 17:37:15 +1000
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay10.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v2G7b53l53149764
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 Mar 2017 18:37:13 +1100
Received: from d23av04.au.ibm.com (localhost [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v2G7adUR010665
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 Mar 2017 18:36:40 +1100
From: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
To: mpe@ellerman.id.au
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 Hemant Kumar <hemant@linux.vnet.ibm.com>,
 "Gautham R . Shenoy" <ego@linux.vnet.ibm.com>,
 Balbir Singh <bsingharora@gmail.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Anton Blanchard <anton@samba.org>,
 Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>,
 Michael Neuling <mikey@neuling.org>,
 Stewart Smith <stewart@linux.vnet.ibm.com>,
 Daniel Axtens <dja@axtens.net>, Stephane Eranian <eranian@google.com>,
 Anju T Sudhakar <anju@linux.vnet.ibm.com>,
 Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
Subject: [PATCH v5 10/13] powerpc/perf: Thread IMC PMU functions
Date: Thu, 16 Mar 2017 13:05:04 +0530
In-Reply-To: <1489649707-8021-1-git-send-email-maddy@linux.vnet.ibm.com>
References: <1489649707-8021-1-git-send-email-maddy@linux.vnet.ibm.com>
Message-Id: <1489649707-8021-11-git-send-email-maddy@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Hemant Kumar <hemant@linux.vnet.ibm.com>

This patch adds the PMU functions required for event initialization,
read, update, add, del etc. for thread IMC PMU. Thread IMC PMUs are used
for per-task monitoring. These PMUs don't need any hotplugging support.

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

Cc: Gautham R. Shenoy <ego@linux.vnet.ibm.com>
Cc: Balbir Singh <bsingharora@gmail.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Paul Mackerras <paulus@samba.org>
Cc: Anton Blanchard <anton@samba.org>
Cc: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
Cc: Michael Neuling <mikey@neuling.org>
Cc: Stewart Smith <stewart@linux.vnet.ibm.com>
Cc: Daniel Axtens <dja@axtens.net>
Cc: Stephane Eranian <eranian@google.com>
Cc: Anju T Sudhakar <anju@linux.vnet.ibm.com>
Signed-off-by: Hemant Kumar <hemant@linux.vnet.ibm.com>
Signed-off-by: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/imc-pmu.h |   4 +
 arch/powerpc/perf/imc-pmu.c        | 161 ++++++++++++++++++++++++++++++++++++-
 2 files changed, 164 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/include/asm/imc-pmu.h b/arch/powerpc/include/asm/imc-pmu.h
index f2b4f122e6c2..8b7141ba2f2b 100644
--- a/arch/powerpc/include/asm/imc-pmu.h
+++ b/arch/powerpc/include/asm/imc-pmu.h
@@ -22,6 +22,7 @@
 #define IMC_MAX_PMUS			32
 #define IMC_MAX_PMU_NAME_LEN		256
 #define IMC_MAX_CORES			256
+#define IMC_MAX_CPUS                    2048
 
 #define NEST_IMC_ENGINE_START		1
 #define NEST_IMC_ENGINE_STOP		0
@@ -34,6 +35,9 @@
 #define IMC_DTB_CORE_COMPAT	"ibm,imc-counters-core"
 #define IMC_DTB_THREAD_COMPAT   "ibm,imc-counters-thread"
 
+#define THREAD_IMC_LDBAR_MASK           0x0003ffffffffe000
+#define THREAD_IMC_ENABLE               0x8000000000000000
+
 /*
  * Structure to hold per chip specific memory address
  * information for nest pmus. Nest Counter data are exported
diff --git a/arch/powerpc/perf/imc-pmu.c b/arch/powerpc/perf/imc-pmu.c
index 32eea6941e95..6fc1fbc0067c 100644
--- a/arch/powerpc/perf/imc-pmu.c
+++ b/arch/powerpc/perf/imc-pmu.c
@@ -23,6 +23,9 @@ static u64 per_core_pdbar_add[IMC_MAX_CHIPS][IMC_MAX_CORES];
 static cpumask_t core_imc_cpumask;
 struct imc_pmu *core_imc_pmu;
 
+/* Maintains base address for all the cpus */
+static u64 per_cpu_add[IMC_MAX_CPUS];
+
 /* Needed for sanity check */
 extern u64 nest_max_offset;
 extern u64 core_max_offset;
@@ -443,6 +446,56 @@ static int core_imc_event_init(struct perf_event *event)
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
+	data = __be64_to_cpu(*addr);
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
+	counter_new = __be64_to_cpu(*addr);
+	final_count = counter_new - counter_prev;
+
+	local64_set(&event->hw.prev_count, counter_new);
+	local64_add(final_count, &event->count);
+}
+
 static void imc_read_counter(struct perf_event *event)
 {
 	u64 *addr, data;
@@ -483,6 +536,53 @@ static int imc_event_add(struct perf_event *event, int flags)
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
@@ -492,17 +592,31 @@ static int update_pmu_ops(struct imc_pmu *pmu)
 	pmu->pmu.task_ctx_nr = perf_invalid_context;
 	if (pmu->domain == IMC_DOMAIN_NEST) {
 		pmu->pmu.event_init = nest_imc_event_init;
+		pmu->attr_groups[2] = &imc_pmu_cpumask_attr_group;
 	} else if (pmu->domain == IMC_DOMAIN_CORE) {
 		pmu->pmu.event_init = core_imc_event_init;
+		pmu->attr_groups[2] = &imc_pmu_cpumask_attr_group;
 	}
+
 	pmu->pmu.add = imc_event_add;
 	pmu->pmu.del = imc_event_stop;
 	pmu->pmu.start = imc_event_start;
 	pmu->pmu.stop = imc_event_stop;
 	pmu->pmu.read = imc_perf_event_update;
 	pmu->attr_groups[1] = &imc_format_group;
-	pmu->attr_groups[2] = &imc_pmu_cpumask_attr_group;
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
 
 	return 0;
 }
@@ -558,6 +672,44 @@ static int update_events_in_group(struct imc_events *events,
 	return 0;
 }
 
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
+
+	per_cpu_add[cpu_id] = (u64)__get_free_pages(GFP_KERNEL | __GFP_ZERO,
+						    0);
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
  * init_imc_pmu : Setup the IMC pmu device in "pmu_ptr" and its events
  *                "events".
@@ -581,6 +733,9 @@ int init_imc_pmu(struct imc_events *events, int idx,
 		if (ret)
 			return ret;
 		break;
+	case IMC_DOMAIN_THREAD:
+		thread_imc_cpu_init();
+		break;
 	default:
 		return -1;  /* Unknown domain */
 	}
@@ -612,5 +767,9 @@ int init_imc_pmu(struct imc_events *events, int idx,
 	if (pmu_ptr->domain == IMC_DOMAIN_CORE)
 		cleanup_all_core_imc_memory();
 
+	/* For thread_imc, we have allocated memory, we need to free it */
+	if (pmu_ptr->domain == IMC_DOMAIN_THREAD)
+		cleanup_all_thread_imc_memory();
+
 	return ret;
 }
-- 
2.7.4

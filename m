Return-Path: <anju@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40nKhv0RMqzF29J
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 18 May 2018 17:35:42 +1000 (AEST)
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w4I7ZJT6138598
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 18 May 2018 03:35:39 -0400
Received: from e06smtp14.uk.ibm.com (e06smtp14.uk.ibm.com [195.75.94.110])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2j1p4rsagu-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 18 May 2018 03:35:39 -0400
Received: from localhost
 by e06smtp14.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <anju@linux.vnet.ibm.com>;
 Fri, 18 May 2018 08:35:31 +0100
From: Anju T Sudhakar <anju@linux.vnet.ibm.com>
To: mpe@ellerman.id.au
Cc: maddy@linux.vnet.ibm.com, linuxppc-dev@lists.ozlabs.org,
 anju@linux.vnet.ibm.com
Subject: [PATCH] powerpc/perf: Remove sched_task function defined for
 thread-imc
Date: Fri, 18 May 2018 13:05:25 +0530
Message-Id: <1526628925-31075-1-git-send-email-anju@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Call trace observed while running perf-fuzzer:

[  329.228068] CPU: 43 PID: 9088 Comm: perf_fuzzer Not tainted 4.13.0-32-generic #35~lp1746225
[  329.228070] task: c000003f776ac900 task.stack: c000003f77728000
[  329.228071] NIP: c000000000299b70 LR: c0000000002a4534 CTR: c00000000029bb80
[  329.228073] REGS: c000003f7772b760 TRAP: 0700   Not tainted  (4.13.0-32-generic)
[  329.228073] MSR: 900000000282b033 <SF,HV,VEC,VSX,EE,FP,ME,IR,DR,RI,LE>
[  329.228079]   CR: 24008822  XER: 00000000
[  329.228080] CFAR: c000000000299a70 SOFTE: 0
GPR00: c0000000002a4534 c000003f7772b9e0 c000000001606200 c000003fef858908
GPR04: c000003f776ac900 0000000000000001 ffffffffffffffff 0000003fee730000
GPR08: 0000000000000000 0000000000000000 c0000000011220d8 0000000000000002
GPR12: c00000000029bb80 c000000007a3d900 0000000000000000 0000000000000000
GPR16: 0000000000000000 0000000000000000 0000000000000000 0000000000000000
GPR20: 0000000000000000 0000000000000000 c000003f776ad090 c000000000c71354
GPR24: c000003fef716780 0000003fee730000 c000003fe69d4200 c000003f776ad330
GPR28: c0000000011220d8 0000000000000001 c0000000014c6108 c000003fef858900
[  329.228098] NIP [c000000000299b70] perf_pmu_sched_task+0x170/0x180
[  329.228100] LR [c0000000002a4534] __perf_event_task_sched_in+0xc4/0x230
[  329.228101] Call Trace:
[  329.228102] [c000003f7772b9e0] [c0000000002a0678] perf_iterate_sb+0x158/0x2a0 (unreliable)
[  329.228105] [c000003f7772ba30] [c0000000002a4534] __perf_event_task_sched_in+0xc4/0x230
[  329.228107] [c000003f7772bab0] [c0000000001396dc] finish_task_switch+0x21c/0x310
[  329.228109] [c000003f7772bb60] [c000000000c71354] __schedule+0x304/0xb80
[  329.228111] [c000003f7772bc40] [c000000000c71c10] schedule+0x40/0xc0
[  329.228113] [c000003f7772bc60] [c0000000001033f4] do_wait+0x254/0x2e0
[  329.228115] [c000003f7772bcd0] [c000000000104ac0] kernel_wait4+0xa0/0x1a0
[  329.228117] [c000003f7772bd70] [c000000000104c24] SyS_wait4+0x64/0xc0
[  329.228121] [c000003f7772be30] [c00000000000b184] system_call+0x58/0x6c
[  329.228121] Instruction dump:
[  329.228123] 3beafea0 7faa4800 409eff18 e8010060 eb610028 ebc10040 7c0803a6 38210050
[  329.228127] eb81ffe0 eba1ffe8 ebe1fff8 4e800020 <0fe00000> 4bffffbc 60000000 60420000
[  329.228131] ---[ end trace 8c46856d314c1811 ]---
[  375.755943] hrtimer: interrupt took 31601 ns


The context switch call-backs for thread-imc are defined in sched_task function.
So when thread-imc events are grouped with software pmu events,
perf_pmu_sched_task hits the WARN_ON_ONCE condition, since software PMUs are
assumed not to have a sched_task defined. 
 
Patch to move the thread_imc enable/disable opal call back from sched_task to
event_[add/del] function

Signed-off-by: Anju T Sudhakar <anju@linux.vnet.ibm.com>
---
 arch/powerpc/perf/imc-pmu.c | 108 +++++++++++++++++++++-----------------------
 1 file changed, 51 insertions(+), 57 deletions(-)

diff --git a/arch/powerpc/perf/imc-pmu.c b/arch/powerpc/perf/imc-pmu.c
index d7532e7..71d9ba7 100644
--- a/arch/powerpc/perf/imc-pmu.c
+++ b/arch/powerpc/perf/imc-pmu.c
@@ -866,59 +866,6 @@ static int thread_imc_cpu_init(void)
 			  ppc_thread_imc_cpu_offline);
 }
 
-void thread_imc_pmu_sched_task(struct perf_event_context *ctx,
-				      bool sched_in)
-{
-	int core_id;
-	struct imc_pmu_ref *ref;
-
-	if (!is_core_imc_mem_inited(smp_processor_id()))
-		return;
-
-	core_id = smp_processor_id() / threads_per_core;
-	/*
-	 * imc pmus are enabled only when it is used.
-	 * See if this is triggered for the first time.
-	 * If yes, take the mutex lock and enable the counters.
-	 * If not, just increment the count in ref count struct.
-	 */
-	ref = &core_imc_refc[core_id];
-	if (!ref)
-		return;
-
-	if (sched_in) {
-		mutex_lock(&ref->lock);
-		if (ref->refc == 0) {
-			if (opal_imc_counters_start(OPAL_IMC_COUNTERS_CORE,
-			     get_hard_smp_processor_id(smp_processor_id()))) {
-				mutex_unlock(&ref->lock);
-				pr_err("thread-imc: Unable to start the counter\
-							for core %d\n", core_id);
-				return;
-			}
-		}
-		++ref->refc;
-		mutex_unlock(&ref->lock);
-	} else {
-		mutex_lock(&ref->lock);
-		ref->refc--;
-		if (ref->refc == 0) {
-			if (opal_imc_counters_stop(OPAL_IMC_COUNTERS_CORE,
-			    get_hard_smp_processor_id(smp_processor_id()))) {
-				mutex_unlock(&ref->lock);
-				pr_err("thread-imc: Unable to stop the counters\
-							for core %d\n", core_id);
-				return;
-			}
-		} else if (ref->refc < 0) {
-			ref->refc = 0;
-		}
-		mutex_unlock(&ref->lock);
-	}
-
-	return;
-}
-
 static int thread_imc_event_init(struct perf_event *event)
 {
 	u32 config = event->attr.config;
@@ -1045,22 +992,70 @@ static int imc_event_add(struct perf_event *event, int flags)
 
 static int thread_imc_event_add(struct perf_event *event, int flags)
 {
+	int core_id;
+	struct imc_pmu_ref *ref;
+
 	if (flags & PERF_EF_START)
 		imc_event_start(event, flags);
 
-	/* Enable the sched_task to start the engine */
-	perf_sched_cb_inc(event->ctx->pmu);
+	if (!is_core_imc_mem_inited(smp_processor_id()))
+		return -EINVAL;
+
+	core_id = smp_processor_id() / threads_per_core;
+	/*
+	 * imc pmus are enabled only when it is used.
+	 * See if this is triggered for the first time.
+	 * If yes, take the mutex lock and enable the counters.
+	 * If not, just increment the count in ref count struct.
+	 */
+	ref = &core_imc_refc[core_id];
+	if (!ref)
+		return -EINVAL;
+
+	mutex_lock(&ref->lock);
+	if (ref->refc == 0) {
+		if (opal_imc_counters_start(OPAL_IMC_COUNTERS_CORE,
+		    get_hard_smp_processor_id(smp_processor_id()))) {
+			mutex_unlock(&ref->lock);
+			pr_err("thread-imc: Unable to start the counter\
+				for core %d\n", core_id);
+			return -EINVAL;
+		}
+	}
+	++ref->refc;
+	mutex_unlock(&ref->lock);
 	return 0;
 }
 
 static void thread_imc_event_del(struct perf_event *event, int flags)
 {
+
+	int core_id;
+	struct imc_pmu_ref *ref;
+
 	/*
 	 * Take a snapshot and calculate the delta and update
 	 * the event counter values.
 	 */
 	imc_event_update(event);
-	perf_sched_cb_dec(event->ctx->pmu);
+
+	core_id = smp_processor_id() / threads_per_core;
+	ref = &core_imc_refc[core_id];
+
+	mutex_lock(&ref->lock);
+	ref->refc--;
+	if (ref->refc == 0) {
+		if (opal_imc_counters_stop(OPAL_IMC_COUNTERS_CORE,
+		    get_hard_smp_processor_id(smp_processor_id()))) {
+			mutex_unlock(&ref->lock);
+			pr_err("thread-imc: Unable to stop the counters\
+				for core %d\n", core_id);
+			return;
+		}
+	} else if (ref->refc < 0) {
+		ref->refc = 0;
+	}
+	mutex_unlock(&ref->lock);
 }
 
 /* update_pmu_ops : Populate the appropriate operations for "pmu" */
@@ -1086,7 +1081,6 @@ static int update_pmu_ops(struct imc_pmu *pmu)
 		break;
 	case IMC_DOMAIN_THREAD:
 		pmu->pmu.event_init = thread_imc_event_init;
-		pmu->pmu.sched_task = thread_imc_pmu_sched_task;
 		pmu->pmu.add = thread_imc_event_add;
 		pmu->pmu.del = thread_imc_event_del;
 		pmu->pmu.start_txn = thread_imc_pmu_start_txn;
-- 
2.7.4

Return-Path: <maddy@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wkH3z1H8bzDqW5
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  9 Jun 2017 06:25:35 +1000 (AEST)
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v58KNmpW060058
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 8 Jun 2017 16:25:33 -0400
Received: from e23smtp01.au.ibm.com (e23smtp01.au.ibm.com [202.81.31.143])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2aybve47s7-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 08 Jun 2017 16:25:33 -0400
Received: from localhost
 by e23smtp01.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <maddy@linux.vnet.ibm.com>;
 Fri, 9 Jun 2017 06:25:30 +1000
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay06.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v58KPR3R58589342
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 9 Jun 2017 06:25:27 +1000
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v58KPIit017967
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 9 Jun 2017 06:25:19 +1000
From: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
To: mpe@ellerman.id.au
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 stewart@linux.vnet.ibm.com, eranian@google.com,
 benh@kernel.crashing.org, paulus@samba.org, sukadev@linux.vnet.ibm.com,
 ego@linux.vnet.ibm.com, mikey@neuling.org, dja@axtens.net,
 anton@samba.org, tglx@linutronix.de,
 Anju T Sudhakar <anju@linux.vnet.ibm.com>,
 Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
Subject: [PATCH v10 10/10] powerpc/perf: Thread imc cpuhotplug support
Date: Fri,  9 Jun 2017 01:55:16 +0530
Message-Id: <1496953516-17143-1-git-send-email-maddy@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Anju T Sudhakar <anju@linux.vnet.ibm.com>

Code to add support for thread IMC on cpuhotplug.
When a cpu goes offline, the LDBAR for that cpu is disabled, and when it comes
back online the previous ldbar value is written back to the LDBAR for that cpu.

To register the hotplug functions for thread_imc, a new state
CPUHP_AP_PERF_POWERPC_THREAD_IMC_ONLINE is added to the list of existing
states.

Signed-off-by: Anju T Sudhakar <anju@linux.vnet.ibm.com>
Signed-off-by: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
---
 arch/powerpc/perf/imc-pmu.c | 42 +++++++++++++++++++++++++++++++++++++++---
 include/linux/cpuhotplug.h  |  1 +
 2 files changed, 40 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/perf/imc-pmu.c b/arch/powerpc/perf/imc-pmu.c
index ca8c0b8e157a..69bc411a82af 100644
--- a/arch/powerpc/perf/imc-pmu.c
+++ b/arch/powerpc/perf/imc-pmu.c
@@ -377,6 +377,37 @@ static int imc_mem_init(struct imc_pmu *pmu_ptr)
 	return 0;
 }
 
+static int ppc_thread_imc_cpu_online(unsigned int cpu)
+{
+	int rc = 0;
+	u64 ldbar_value;
+
+	if (per_cpu(thread_imc_mem, cpu) == NULL)
+		rc = thread_imc_mem_alloc(cpu, thread_imc_mem_size);
+
+	if (rc)
+		mtspr(SPRN_LDBAR, 0);
+
+	ldbar_value = ((u64)per_cpu(thread_imc_mem, cpu) & (u64)THREAD_IMC_LDBAR_MASK) |
+							(u64)THREAD_IMC_ENABLE;
+	mtspr(SPRN_LDBAR, ldbar_value);
+	return 0;
+}
+
+static int ppc_thread_imc_cpu_offline(unsigned int cpu)
+{
+	mtspr(SPRN_LDBAR, 0);
+	return 0;
+}
+
+void thread_imc_cpu_init(void)
+{
+	cpuhp_setup_state(CPUHP_AP_PERF_POWERPC_THREAD_IMC_ONLINE,
+			  "perf/powerpc/imc_thread:online",
+			  ppc_thread_imc_cpu_online,
+			  ppc_thread_imc_cpu_offline);
+}
+
 static int ppc_core_imc_cpu_online(unsigned int cpu)
 {
 	const struct cpumask *l_cpumask;
@@ -860,8 +891,8 @@ static void cleanup_all_thread_imc_memory(void)
 	int i;
 
 	for_each_online_cpu(i) {
-		if (per_cpu(thread_imc_mem, cpu))
-			free_pages(per_cpu(thread_imc_mem, cpu), 0);
+		if (per_cpu(thread_imc_mem, i))
+			free_pages((u64)per_cpu(thread_imc_mem, i), 0);
 	}
 }
 
@@ -899,6 +930,9 @@ int __init init_imc_pmu(struct imc_events *events, int idx,
 		if (ret)
 			return ret;
 		break;
+	case IMC_DOMAIN_THREAD:
+		thread_imc_cpu_init();
+		break;
 	default:
 		return -1;  /* Unknown domain */
 	}
@@ -933,8 +967,10 @@ int __init init_imc_pmu(struct imc_events *events, int idx,
 	}
 
 	/* For thread_imc, we have allocated memory, we need to free it */
-	if (pmu_ptr->domain == IMC_DOMAIN_THREAD)
+	if (pmu_ptr->domain == IMC_DOMAIN_THREAD) {
 		cleanup_all_thread_imc_memory();
+		cpuhp_remove_state(CPUHP_AP_PERF_POWERPC_THREAD_IMC_ONLINE);
+	}
 
 	return ret;
 }
diff --git a/include/linux/cpuhotplug.h b/include/linux/cpuhotplug.h
index e145fffec093..937d1ec8c3e9 100644
--- a/include/linux/cpuhotplug.h
+++ b/include/linux/cpuhotplug.h
@@ -141,6 +141,7 @@ enum cpuhp_state {
 	CPUHP_AP_PERF_ARM_QCOM_L3_ONLINE,
 	CPUHP_AP_PERF_POWERPC_NEST_IMC_ONLINE,
 	CPUHP_AP_PERF_POWERPC_CORE_IMC_ONLINE,
+	CPUHP_AP_PERF_POWERPC_THREAD_IMC_ONLINE,
 	CPUHP_AP_WORKQUEUE_ONLINE,
 	CPUHP_AP_RCUTREE_ONLINE,
 	CPUHP_AP_ONLINE_DYN,
-- 
2.7.4

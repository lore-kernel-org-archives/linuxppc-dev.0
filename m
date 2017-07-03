Return-Path: <anju@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3x1MYc5dqWzDr4D
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  3 Jul 2017 19:40:04 +1000 (AEST)
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v639dQ5N002495
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 3 Jul 2017 05:40:01 -0400
Received: from e23smtp06.au.ibm.com (e23smtp06.au.ibm.com [202.81.31.148])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2bfk9vrdq7-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 03 Jul 2017 05:40:01 -0400
Received: from localhost
 by e23smtp06.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <anju@linux.vnet.ibm.com>;
 Mon, 3 Jul 2017 19:39:58 +1000
Received: from d23av05.au.ibm.com (d23av05.au.ibm.com [9.190.234.119])
 by d23relay06.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v639dlYb9502968
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 3 Jul 2017 19:39:55 +1000
Received: from d23av05.au.ibm.com (localhost [127.0.0.1])
 by d23av05.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v639dMK5025405
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 3 Jul 2017 19:39:22 +1000
From: Anju T Sudhakar <anju@linux.vnet.ibm.com>
To: mpe@ellerman.id.au
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 ego@linux.vnet.ibm.com, bsingharora@gmail.com, anton@samba.org,
 sukadev@linux.vnet.ibm.com, mikey@neuling.org,
 stewart@linux.vnet.ibm.com, dja@axtens.net, eranian@google.com,
 hemant@linux.vnet.ibm.com, maddy@linux.vnet.ibm.com,
 anju@linux.vnet.ibm.com, tglx@linutronix.de
Subject: [PATCH v12 10/10] powerpc/perf: Thread IMC PMU functions
Date: Mon,  3 Jul 2017 15:08:48 +0530
In-Reply-To: <1499074728-30680-1-git-send-email-anju@linux.vnet.ibm.com>
References: <1499074728-30680-1-git-send-email-anju@linux.vnet.ibm.com>
Message-Id: <1499074728-30680-3-git-send-email-anju@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Code to add support for thread IMC on cpuhotplug.
When a cpu goes offline, the LDBAR for that cpu is disabled, and when it comes
back online the previous ldbar value is written back to the LDBAR for that cpu.

To register the hotplug functions for thread_imc, a new state
CPUHP_AP_PERF_POWERPC_THREAD_IMC_ONLINE is added to the list of existing
states.

Signed-off-by: Anju T Sudhakar <anju@linux.vnet.ibm.com>
Signed-off-by: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
---
 arch/powerpc/perf/imc-pmu.c | 38 +++++++++++++++++++++++++++++++++++++-
 include/linux/cpuhotplug.h  |  1 +
 2 files changed, 38 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/perf/imc-pmu.c b/arch/powerpc/perf/imc-pmu.c
index bea4dafc2aad..700e3cb0c89f 100644
--- a/arch/powerpc/perf/imc-pmu.c
+++ b/arch/powerpc/perf/imc-pmu.c
@@ -931,6 +931,37 @@ static int thread_imc_mem_alloc(int cpu_id, int size)
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
 /*
  * imc_mem_init : Function to support memory allocation for core imc.
  */
@@ -1044,6 +1075,9 @@ int init_imc_pmu(struct imc_events *events, int idx,
 			return ret;
 		}
 		break;
+	case IMC_DOMAIN_THREAD:
+		thread_imc_cpu_init();
+		break;
 	default:
 		return  -1;	/* Unknown domain */
 	}
@@ -1095,7 +1129,9 @@ int init_imc_pmu(struct imc_events *events, int idx,
 		cleanup_all_core_imc_memory(pmu_ptr);
 	}
 	/* For thread_imc, we have allocated memory, we need to free it */
-	if (pmu_ptr->domain == IMC_DOMAIN_THREAD)
+	if (pmu_ptr->domain == IMC_DOMAIN_THREAD) {
+		cpuhp_remove_state(CPUHP_AP_PERF_POWERPC_THREAD_IMC_ONLINE);
 		cleanup_all_thread_imc_memory();
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
2.11.0

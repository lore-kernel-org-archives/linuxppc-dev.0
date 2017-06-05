Return-Path: <anju@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3whDkP5kdgzDqNl
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  5 Jun 2017 22:33:17 +1000 (AEST)
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v55CT6mO118515
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 5 Jun 2017 08:33:15 -0400
Received: from e23smtp06.au.ibm.com (e23smtp06.au.ibm.com [202.81.31.148])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2aw0w8qduv-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 05 Jun 2017 08:33:14 -0400
Received: from localhost
 by e23smtp06.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <anju@linux.vnet.ibm.com>;
 Mon, 5 Jun 2017 22:33:12 +1000
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay08.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v55CX12163045716
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 5 Jun 2017 22:33:09 +1000
Received: from d23av04.au.ibm.com (localhost [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v55CWYGe020467
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 5 Jun 2017 22:32:35 +1000
From: Anju T Sudhakar <anju@linux.vnet.ibm.com>
To: mpe@ellerman.id.au
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 ego@linux.vnet.ibm.com, bsingharora@gmail.com, anton@samba.org,
 sukadev@linux.vnet.ibm.com, mikey@neuling.org,
 stewart@linux.vnet.ibm.com, dja@axtens.net, eranian@google.com,
 hemant@linux.vnet.ibm.com, maddy@linux.vnet.ibm.com,
 anju@linux.vnet.ibm.com, tglx@linutronix.de
Subject: [PATCH v9 10/10] powerpc/perf: Thread imc cpuhotplug support
Date: Mon,  5 Jun 2017 18:02:02 +0530
In-Reply-To: <1496665922-702-1-git-send-email-anju@linux.vnet.ibm.com>
References: <1496665922-702-1-git-send-email-anju@linux.vnet.ibm.com>
Message-Id: <1496665922-702-3-git-send-email-anju@linux.vnet.ibm.com>
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
 arch/powerpc/perf/imc-pmu.c | 35 +++++++++++++++++++++++++++++++++--
 include/linux/cpuhotplug.h  |  1 +
 2 files changed, 34 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/perf/imc-pmu.c b/arch/powerpc/perf/imc-pmu.c
index 13ff6dc..ee582b0 100644
--- a/arch/powerpc/perf/imc-pmu.c
+++ b/arch/powerpc/perf/imc-pmu.c
@@ -396,14 +396,22 @@ bool is_core_imc_mem_inited(int cpu)
  */
 static void thread_imc_mem_alloc(int cpu_id)
 {
-	u64 ldbar_addr, ldbar_value;
 	int phys_id = topology_physical_package_id(cpu_id);
 
 	per_cpu_add[cpu_id] = (u64)alloc_pages_exact_nid(phys_id,
 			(size_t)IMC_THREAD_COUNTER_MEM, GFP_KERNEL | __GFP_ZERO);
+}
+
+static void thread_imc_update_ldbar(unsigned int cpu_id)
+{
+	u64 ldbar_addr, ldbar_value;
+
+	if (per_cpu_add[cpu_id] == 0)
+		thread_imc_mem_alloc(cpu_id);
+
 	ldbar_addr = (u64)virt_to_phys((void *)per_cpu_add[cpu_id]);
 	ldbar_value = (ldbar_addr & (u64)THREAD_IMC_LDBAR_MASK) |
-		(u64)THREAD_IMC_ENABLE;
+			(u64)THREAD_IMC_ENABLE;
 	mtspr(SPRN_LDBAR, ldbar_value);
 }
 
@@ -442,6 +450,26 @@ static void core_imc_change_cpu_context(int old_cpu, int new_cpu)
 	perf_pmu_migrate_context(&core_imc_pmu->pmu, old_cpu, new_cpu);
 }
 
+static int ppc_thread_imc_cpu_online(unsigned int cpu)
+{
+	thread_imc_update_ldbar(cpu);
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
@@ -953,6 +981,9 @@ int __init init_imc_pmu(struct imc_events *events, int idx,
 		if (ret)
 			return ret;
 		break;
+	case IMC_DOMAIN_THREAD:
+		thread_imc_cpu_init();
+		break;
 	default:
 		return -1;  /* Unknown domain */
 	}
diff --git a/include/linux/cpuhotplug.h b/include/linux/cpuhotplug.h
index e145fff..937d1ec 100644
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

Return-Path: <maddy@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vkL0m6jBVzDqbG
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 Mar 2017 18:37:44 +1100 (AEDT)
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v2G7WCcx068676
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 Mar 2017 03:37:33 -0400
Received: from e23smtp01.au.ibm.com (e23smtp01.au.ibm.com [202.81.31.143])
 by mx0a-001b2d01.pphosted.com with ESMTP id 297nd02vxn-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 Mar 2017 03:37:33 -0400
Received: from localhost
 by e23smtp01.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <maddy@linux.vnet.ibm.com>;
 Thu, 16 Mar 2017 17:37:29 +1000
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay08.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v2G7bIJw42205290
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 Mar 2017 18:37:26 +1100
Received: from d23av04.au.ibm.com (localhost [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v2G7ar0P011137
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 Mar 2017 18:36:54 +1100
From: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
To: mpe@ellerman.id.au
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 Anju T Sudhakar <anju@linux.vnet.ibm.com>,
 "Gautham R . Shenoy" <ego@linux.vnet.ibm.com>,
 Balbir Singh <bsingharora@gmail.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Anton Blanchard <anton@samba.org>,
 Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>,
 Michael Neuling <mikey@neuling.org>,
 Stewart Smith <stewart@linux.vnet.ibm.com>,
 Daniel Axtens <dja@axtens.net>, Stephane Eranian <eranian@google.com>,
 Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
Subject: [PATCH 12/13] powerpc/perf: Thread imc cpuhotplug support
Date: Thu, 16 Mar 2017 13:05:06 +0530
In-Reply-To: <1489649707-8021-1-git-send-email-maddy@linux.vnet.ibm.com>
References: <1489649707-8021-1-git-send-email-maddy@linux.vnet.ibm.com>
Message-Id: <1489649707-8021-13-git-send-email-maddy@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Anju T Sudhakar <anju@linux.vnet.ibm.com>

This patch adds support for thread IMC on cpuhotplug.

When a cpu goes offline, the LDBAR for that cpu is disabled, and when it comes
back online the previous ldbar value is written back to the LDBAR for that cpu.

To register the hotplug functions for thread_imc, a new state
CPUHP_AP_PERF_POWERPC_THREADIMC_ONLINE is added to the list of existing
states.

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
Signed-off-by: Anju T Sudhakar <anju@linux.vnet.ibm.com>
Signed-off-by: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
---
 arch/powerpc/perf/imc-pmu.c | 33 ++++++++++++++++++++++++++++-----
 include/linux/cpuhotplug.h  |  1 +
 2 files changed, 29 insertions(+), 5 deletions(-)

diff --git a/arch/powerpc/perf/imc-pmu.c b/arch/powerpc/perf/imc-pmu.c
index 6802960db51c..2ff39fe2a5ce 100644
--- a/arch/powerpc/perf/imc-pmu.c
+++ b/arch/powerpc/perf/imc-pmu.c
@@ -687,6 +687,16 @@ static void cleanup_all_thread_imc_memory(void)
 	on_each_cpu(cleanup_thread_imc_memory, NULL, 1);
 }
 
+static void thread_imc_update_ldbar(unsigned int cpu_id)
+{
+	u64 ldbar_addr, ldbar_value;
+
+	ldbar_addr = (u64)virt_to_phys((void *)per_cpu_add[cpu_id]);
+	ldbar_value = (ldbar_addr & (u64)THREAD_IMC_LDBAR_MASK) |
+			(u64)THREAD_IMC_ENABLE;
+	mtspr(SPRN_LDBAR, ldbar_value);
+}
+
 /*
  * Allocates a page of memory for each of the online cpus, and, writes the
  * physical base address of that page to the LDBAR for that cpu. This starts
@@ -694,20 +704,33 @@ static void cleanup_all_thread_imc_memory(void)
  */
 static void thread_imc_mem_alloc(void *dummy)
 {
-	u64 ldbar_addr, ldbar_value;
 	int cpu_id = smp_processor_id();
 
 	per_cpu_add[cpu_id] = (u64)__get_free_pages(GFP_KERNEL | __GFP_ZERO,
 						    0);
-	ldbar_addr = (u64)virt_to_phys((void *)per_cpu_add[cpu_id]);
-	ldbar_value = (ldbar_addr & (u64)THREAD_IMC_LDBAR_MASK) |
-		(u64)THREAD_IMC_ENABLE;
-	mtspr(SPRN_LDBAR, ldbar_value);
+	thread_imc_update_ldbar(cpu_id);
+}
+
+static int ppc_thread_imc_cpu_online(unsigned int cpu)
+{
+	thread_imc_update_ldbar(cpu);
+	return 0;
+
+}
+
+static int ppc_thread_imc_cpu_offline(unsigned int cpu)
+{
+	mtspr(SPRN_LDBAR, 0);
+	return 0;
 }
 
 void thread_imc_cpu_init(void)
 {
 	on_each_cpu(thread_imc_mem_alloc, NULL, 1);
+	cpuhp_setup_state(CPUHP_AP_PERF_POWERPC_THREADIMC_ONLINE,
+			  "POWER_THREAD_IMC_ONLINE",
+			   ppc_thread_imc_cpu_online,
+			   ppc_thread_imc_cpu_offline);
 }
 
 static void thread_imc_ldbar_disable(void *dummy)
diff --git a/include/linux/cpuhotplug.h b/include/linux/cpuhotplug.h
index abde85d9511a..724df46b2c3c 100644
--- a/include/linux/cpuhotplug.h
+++ b/include/linux/cpuhotplug.h
@@ -138,6 +138,7 @@ enum cpuhp_state {
 	CPUHP_AP_PERF_ARM_L2X0_ONLINE,
 	CPUHP_AP_PERF_POWERPC_NEST_ONLINE,
 	CPUHP_AP_PERF_POWERPC_COREIMC_ONLINE,
+	CPUHP_AP_PERF_POWERPC_THREADIMC_ONLINE,
 	CPUHP_AP_PERF_ARM_QCOM_L2_ONLINE,
 	CPUHP_AP_WORKQUEUE_ONLINE,
 	CPUHP_AP_RCUTREE_ONLINE,
-- 
2.7.4

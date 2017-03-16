Return-Path: <maddy@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vkL0R14M7zDqZ1
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 Mar 2017 18:37:26 +1100 (AEDT)
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v2G7SaEg070690
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 Mar 2017 03:37:25 -0400
Received: from e23smtp08.au.ibm.com (e23smtp08.au.ibm.com [202.81.31.141])
 by mx0a-001b2d01.pphosted.com with ESMTP id 297cf6ekb3-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 Mar 2017 03:37:24 -0400
Received: from localhost
 by e23smtp08.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <maddy@linux.vnet.ibm.com>;
 Thu, 16 Mar 2017 17:37:22 +1000
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay09.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v2G7bBZV51314924
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 Mar 2017 18:37:19 +1100
Received: from d23av04.au.ibm.com (localhost [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v2G7aja8010824
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 Mar 2017 18:36:46 +1100
From: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
To: mpe@ellerman.id.au
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 Madhavan Srinivasan <maddy@linux.vnet.ibm.com>,
 "Gautham R . Shenoy" <ego@linux.vnet.ibm.com>,
 Balbir Singh <bsingharora@gmail.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Anton Blanchard <anton@samba.org>,
 Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>,
 Michael Neuling <mikey@neuling.org>,
 Stewart Smith <stewart@linux.vnet.ibm.com>,
 Daniel Axtens <dja@axtens.net>, Stephane Eranian <eranian@google.com>,
 Anju T Sudhakar <anju@linux.vnet.ibm.com>
Subject: [PATCH 11/13] powerpc/powernv: Add device shutdown function for Core
 IMC
Date: Thu, 16 Mar 2017 13:05:05 +0530
In-Reply-To: <1489649707-8021-1-git-send-email-maddy@linux.vnet.ibm.com>
References: <1489649707-8021-1-git-send-email-maddy@linux.vnet.ibm.com>
Message-Id: <1489649707-8021-12-git-send-email-maddy@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Core In Memory Collection device programs the hardware
counters and have them runing always. But if the hardware
counter were not stopped at device shutdown (like kexec),
could lead to memory corruption. Patch to stop the hardware
counters via device "shutdown" callback.

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
 arch/powerpc/include/asm/imc-pmu.h        |  2 ++
 arch/powerpc/perf/imc-pmu.c               | 12 +++++++++++-
 arch/powerpc/platforms/powernv/opal-imc.c |  9 +++++++++
 3 files changed, 22 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/include/asm/imc-pmu.h b/arch/powerpc/include/asm/imc-pmu.h
index 8b7141ba2f2b..00f380fce1a5 100644
--- a/arch/powerpc/include/asm/imc-pmu.h
+++ b/arch/powerpc/include/asm/imc-pmu.h
@@ -80,4 +80,6 @@ struct imc_pmu {
 #define UNKNOWN_DOMAIN		-1
 
 int imc_get_domain(struct device_node *pmu_dev);
+void core_imc_disable(void);
+void thread_imc_disable(void);
 #endif /* PPC_POWERNV_IMC_PMU_DEF_H */
diff --git a/arch/powerpc/perf/imc-pmu.c b/arch/powerpc/perf/imc-pmu.c
index 6fc1fbc0067c..6802960db51c 100644
--- a/arch/powerpc/perf/imc-pmu.c
+++ b/arch/powerpc/perf/imc-pmu.c
@@ -317,7 +317,7 @@ static void core_imc_control_disable(void)
 	opal_core_imc_counters_control(OPAL_CORE_IMC_DISABLE, 0, 0, 0);
 }
 
-static void core_imc_disable(void)
+void core_imc_disable(void)
 {
 	on_each_cpu_mask(&core_imc_cpumask,
 			 (smp_call_func_t)core_imc_control_disable, NULL, 1);
@@ -710,6 +710,16 @@ void thread_imc_cpu_init(void)
 	on_each_cpu(thread_imc_mem_alloc, NULL, 1);
 }
 
+static void thread_imc_ldbar_disable(void *dummy)
+{
+        mtspr(SPRN_LDBAR, 0);
+}
+
+void thread_imc_disable(void)
+{
+        on_each_cpu(thread_imc_ldbar_disable, NULL, 1);
+}
+
 /*
  * init_imc_pmu : Setup the IMC pmu device in "pmu_ptr" and its events
  *                "events".
diff --git a/arch/powerpc/platforms/powernv/opal-imc.c b/arch/powerpc/platforms/powernv/opal-imc.c
index 70f4b0924fae..2bc05ba19e3b 100644
--- a/arch/powerpc/platforms/powernv/opal-imc.c
+++ b/arch/powerpc/platforms/powernv/opal-imc.c
@@ -34,6 +34,8 @@
 extern struct perchip_nest_info nest_perchip_info[IMC_MAX_CHIPS];
 extern struct imc_pmu *per_nest_pmu_arr[IMC_MAX_PMUS];
 extern struct imc_pmu *core_imc_pmu;
+extern void core_imc_disable(void);
+extern void thread_imc_disable(void);
 
 extern int init_imc_pmu(struct imc_events *events,
 			int idx, struct imc_pmu *pmu_ptr);
@@ -532,6 +534,12 @@ static int opal_imc_counters_probe(struct platform_device *pdev)
 	return -ENODEV;
 }
 
+static void opal_imc_counters_shutdown(struct platform_device *pdev)
+{
+	core_imc_disable();
+	thread_imc_disable();
+}
+
 static const struct of_device_id opal_imc_match[] = {
 	{ .compatible = IMC_DTB_COMPAT },
 	{},
@@ -543,6 +551,7 @@ static struct platform_driver opal_imc_driver = {
 		.of_match_table = opal_imc_match,
 	},
 	.probe = opal_imc_counters_probe,
+	.shutdown = opal_imc_counters_shutdown,
 };
 
 MODULE_DEVICE_TABLE(of, opal_imc_match);
-- 
2.7.4

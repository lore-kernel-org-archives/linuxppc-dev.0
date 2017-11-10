Return-Path: <maddy@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yYX3J1hbczDrLQ
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 11 Nov 2017 07:40:11 +1100 (AEDT)
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 vAAKe8fZ003904
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 10 Nov 2017 15:40:09 -0500
Received: from e06smtp15.uk.ibm.com (e06smtp15.uk.ibm.com [195.75.94.111])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2e5dhj9ty1-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 10 Nov 2017 15:40:09 -0500
Received: from localhost
 by e06smtp15.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <maddy@linux.vnet.ibm.com>;
 Fri, 10 Nov 2017 20:40:07 -0000
From: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
To: mpe@ellerman.id.au
Cc: linuxppc-dev@lists.ozlabs.org,
 Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
Subject: [PATCH 2/2] powerpc/perf: Fix IMC_MAX_PMU macro
Date: Sat, 11 Nov 2017 02:09:49 +0530
In-Reply-To: <1510346389-16505-1-git-send-email-maddy@linux.vnet.ibm.com>
References: <1510346389-16505-1-git-send-email-maddy@linux.vnet.ibm.com>
Message-Id: <1510346389-16505-2-git-send-email-maddy@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

IMC_MAX_PMU is used for static storage (per_nest_pmu_arr) which holds
nest pmu information. Current value for the macro is 32 based on
the initial number of nest pmu units supported by the nest microcode.
But going forward, microcode could support more nest units. Instead
of static storage, patch to fix the code to dynamically allocate an
array based on the number of nest imc units found in the device tree.

Fixes:8f95faaac56c1 ('powerpc/powernv: Detect and create IMC device')
Signed-off-by: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/imc-pmu.h        |  6 +-----
 arch/powerpc/perf/imc-pmu.c               | 15 ++++++++++++---
 arch/powerpc/platforms/powernv/opal-imc.c | 16 ++++++++++++++++
 3 files changed, 29 insertions(+), 8 deletions(-)

diff --git a/arch/powerpc/include/asm/imc-pmu.h b/arch/powerpc/include/asm/imc-pmu.h
index 7f74c282710f..fad0e6ff460f 100644
--- a/arch/powerpc/include/asm/imc-pmu.h
+++ b/arch/powerpc/include/asm/imc-pmu.h
@@ -21,11 +21,6 @@
 #include <asm/opal.h>
 
 /*
- * For static allocation of some of the structures.
- */
-#define IMC_MAX_PMUS			32
-
-/*
  * Compatibility macros for IMC devices
  */
 #define IMC_DTB_COMPAT			"ibm,opal-in-memory-counters"
@@ -125,4 +120,5 @@ enum {
 extern int init_imc_pmu(struct device_node *parent,
 				struct imc_pmu *pmu_ptr, int pmu_id);
 extern void thread_imc_disable(void);
+extern int get_max_nest_dev(void);
 #endif /* __ASM_POWERPC_IMC_PMU_H */
diff --git a/arch/powerpc/perf/imc-pmu.c b/arch/powerpc/perf/imc-pmu.c
index 74db696ef365..c40cb5f7ceaf 100644
--- a/arch/powerpc/perf/imc-pmu.c
+++ b/arch/powerpc/perf/imc-pmu.c
@@ -26,7 +26,7 @@
  */
 static DEFINE_MUTEX(nest_init_lock);
 static DEFINE_PER_CPU(struct imc_pmu_ref *, local_nest_imc_refc);
-static struct imc_pmu *per_nest_pmu_arr[IMC_MAX_PMUS];
+static struct imc_pmu **per_nest_pmu_arr;
 static cpumask_t nest_imc_cpumask;
 struct imc_pmu_ref *nest_imc_refc;
 static int nest_pmus;
@@ -286,13 +286,14 @@ static struct imc_pmu_ref *get_nest_pmu_ref(int cpu)
 static void nest_change_cpu_context(int old_cpu, int new_cpu)
 {
 	struct imc_pmu **pn = per_nest_pmu_arr;
-	int i;
 
 	if (old_cpu < 0 || new_cpu < 0)
 		return;
 
-	for (i = 0; *pn && i < IMC_MAX_PMUS; i++, pn++)
+	while (*pn) {
 		perf_pmu_migrate_context(&(*pn)->pmu, old_cpu, new_cpu);
+		pn++;
+	}
 }
 
 static int ppc_nest_imc_cpu_offline(unsigned int cpu)
@@ -1192,6 +1193,7 @@ static void imc_common_cpuhp_mem_free(struct imc_pmu *pmu_ptr)
 		kfree(pmu_ptr->attr_groups[IMC_EVENT_ATTR]->attrs);
 	kfree(pmu_ptr->attr_groups[IMC_EVENT_ATTR]);
 	kfree(pmu_ptr);
+	kfree(per_nest_pmu_arr);
 	return;
 }
 
@@ -1216,6 +1218,13 @@ static int imc_mem_init(struct imc_pmu *pmu_ptr, struct device_node *parent,
 			return -ENOMEM;
 
 		/* Needed for hotplug/migration */
+		if (!per_nest_pmu_arr) {
+			per_nest_pmu_arr = kcalloc(get_max_nest_dev() + 1,
+						sizeof(struct imc_pmu *),
+						GFP_KERNEL);
+			if (!per_nest_pmu_arr)
+				return -ENOMEM;
+		}
 		per_nest_pmu_arr[pmu_index] = pmu_ptr;
 		break;
 	case IMC_DOMAIN_CORE:
diff --git a/arch/powerpc/platforms/powernv/opal-imc.c b/arch/powerpc/platforms/powernv/opal-imc.c
index b150f4deaccf..4764e6932cb7 100644
--- a/arch/powerpc/platforms/powernv/opal-imc.c
+++ b/arch/powerpc/platforms/powernv/opal-imc.c
@@ -153,6 +153,22 @@ static void disable_core_pmu_counters(void)
 	put_online_cpus();
 }
 
+int get_max_nest_dev(void)
+{
+	struct device_node *node;
+	u32 pmu_units, type;
+
+	for_each_compatible_node(node, NULL, IMC_DTB_UNIT_COMPAT) {
+		if (of_property_read_u32(node, "type", &type))
+			continue;
+
+		if (type == IMC_TYPE_CHIP)
+			pmu_units++;
+	}
+
+	return pmu_units;
+}
+
 static int opal_imc_counters_probe(struct platform_device *pdev)
 {
 	struct device_node *imc_dev = pdev->dev.of_node;
-- 
2.7.4

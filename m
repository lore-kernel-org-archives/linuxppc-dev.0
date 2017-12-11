Return-Path: <anju@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3ywC286ZBvzDqnt
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 11 Dec 2017 16:58:56 +1100 (AEDT)
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 vBB5v2eG058475
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 11 Dec 2017 00:58:54 -0500
Received: from e06smtp11.uk.ibm.com (e06smtp11.uk.ibm.com [195.75.94.107])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2eskgca6ec-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 11 Dec 2017 00:58:51 -0500
Received: from localhost
 by e06smtp11.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <anju@linux.vnet.ibm.com>;
 Mon, 11 Dec 2017 05:58:47 -0000
From: Anju T Sudhakar <anju@linux.vnet.ibm.com>
To: mpe@ellerman.id.au
Cc: linuxppc-dev@lists.ozlabs.org, maddy@linux.vnet.ibm.com,
 anju@linux.vnet.ibm.com
Subject: [PATCH 2/3] powerpc/perf: IMC code cleanup with some code refactoring
Date: Mon, 11 Dec 2017 11:28:36 +0530
In-Reply-To: <1512971917-23851-1-git-send-email-anju@linux.vnet.ibm.com>
References: <1512971917-23851-1-git-send-email-anju@linux.vnet.ibm.com>
Message-Id: <1512971917-23851-3-git-send-email-anju@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Factor out memory freeing part for attribute elements from
imc_common_cpuhp_mem_free().

Signed-off-by: Anju T Sudhakar <anju@linux.vnet.ibm.com>
---
 arch/powerpc/perf/imc-pmu.c | 31 ++++++++++++++++++++-----------
 1 file changed, 20 insertions(+), 11 deletions(-)

diff --git a/arch/powerpc/perf/imc-pmu.c b/arch/powerpc/perf/imc-pmu.c
index ef7f9dd..71f425f 100644
--- a/arch/powerpc/perf/imc-pmu.c
+++ b/arch/powerpc/perf/imc-pmu.c
@@ -1157,6 +1157,15 @@ static void cleanup_all_thread_imc_memory(void)
 	}
 }
 
+/* Function to free the attr_groups which are dynamically allocated */
+static void imc_common_mem_free(struct imc_pmu *pmu_ptr)
+{
+	if (pmu_ptr->attr_groups[IMC_EVENT_ATTR])
+		kfree(pmu_ptr->attr_groups[IMC_EVENT_ATTR]->attrs);
+	kfree(pmu_ptr->attr_groups[IMC_EVENT_ATTR]);
+	kfree(pmu_ptr);
+}
+
 /*
  * Common function to unregister cpu hotplug callback and
  * free the memory.
@@ -1189,13 +1198,6 @@ static void imc_common_cpuhp_mem_free(struct imc_pmu *pmu_ptr)
 		cpuhp_remove_state(CPUHP_AP_PERF_POWERPC_THREAD_IMC_ONLINE);
 		cleanup_all_thread_imc_memory();
 	}
-
-	/* Only free the attr_groups which are dynamically allocated  */
-	if (pmu_ptr->attr_groups[IMC_EVENT_ATTR])
-		kfree(pmu_ptr->attr_groups[IMC_EVENT_ATTR]->attrs);
-	kfree(pmu_ptr->attr_groups[IMC_EVENT_ATTR]);
-	kfree(pmu_ptr);
-	return;
 }
 
 
@@ -1244,8 +1246,10 @@ static int imc_mem_init(struct imc_pmu *pmu_ptr, struct device_node *parent,
 		core_imc_refc = kcalloc(nr_cores, sizeof(struct imc_pmu_ref),
 								GFP_KERNEL);
 
-		if (!core_imc_refc)
+		if (!core_imc_refc) {
+			kfree(pmu_ptr->mem_info);
 			return -ENOMEM;
+		}
 
 		core_imc_pmu = pmu_ptr;
 		break;
@@ -1258,8 +1262,10 @@ static int imc_mem_init(struct imc_pmu *pmu_ptr, struct device_node *parent,
 		thread_imc_mem_size = pmu_ptr->counter_mem_size;
 		for_each_online_cpu(cpu) {
 			res = thread_imc_mem_alloc(cpu, pmu_ptr->counter_mem_size);
-			if (res)
+			if (res) {
+				cleanup_all_thread_imc_memory();
 				return res;
+			}
 		}
 
 		break;
@@ -1285,8 +1291,10 @@ int init_imc_pmu(struct device_node *parent, struct imc_pmu *pmu_ptr, int pmu_id
 	int ret;
 
 	ret = imc_mem_init(pmu_ptr, parent, pmu_idx);
-	if (ret)
-		goto err_free;
+	if (ret) {
+		imc_common_mem_free(pmu_ptr);
+		return ret;
+	}
 
 	switch (pmu_ptr->domain) {
 	case IMC_DOMAIN_NEST:
@@ -1353,6 +1361,7 @@ int init_imc_pmu(struct device_node *parent, struct imc_pmu *pmu_ptr, int pmu_id
 	return 0;
 
 err_free:
+	imc_common_mem_free(pmu_ptr);
 	imc_common_cpuhp_mem_free(pmu_ptr);
 	return ret;
 }
-- 
2.7.4

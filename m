Return-Path: <anju@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40KPQs14qYzDrpY
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  9 Apr 2018 19:00:36 +1000 (AEST)
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w398xSYH073633
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 9 Apr 2018 05:00:34 -0400
Received: from e06smtp14.uk.ibm.com (e06smtp14.uk.ibm.com [195.75.94.110])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2h80wt9wa3-1
 (version=TLSv1.2 cipher=AES256-SHA256 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 09 Apr 2018 05:00:34 -0400
Received: from localhost
 by e06smtp14.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <anju@linux.vnet.ibm.com>;
 Mon, 9 Apr 2018 10:00:32 +0100
From: Anju T Sudhakar <anju@linux.vnet.ibm.com>
To: mpe@ellerman.id.au
Cc: linuxppc-dev@lists.ozlabs.org, maddy@linux.vnet.ibm.com,
 anju@linux.vnet.ibm.com
Subject: [PATCH 1/4] powerpc/perf: Rearrange memory freeing in imc init
Date: Mon,  9 Apr 2018 14:30:22 +0530
In-Reply-To: <1523264425-19544-1-git-send-email-anju@linux.vnet.ibm.com>
References: <1523264425-19544-1-git-send-email-anju@linux.vnet.ibm.com>
Message-Id: <1523264425-19544-2-git-send-email-anju@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

When any of the IMC (In-Memory Collection counter) devices fail
to initialize, imc_common_mem_free() frees set of memory. In doing so,
pmu_ptr pointer is also freed. But pmu_ptr pointer is used in subsequent
function (imc_common_cpuhp_mem_free()) which is wrong. Patch here reorders
the code to avoid such access.

Also free the memory which is dynamically allocated during imc initialization,
wherever required.

Signed-off-by: Anju T Sudhakar <anju@linux.vnet.ibm.com>
---
test matrix and static checker run details are updated in the cover letter
patch is based on 
https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git (branch: merge)

 arch/powerpc/perf/imc-pmu.c               | 32 ++++++++++++++++---------------
 arch/powerpc/platforms/powernv/opal-imc.c | 13 ++++++++++---
 2 files changed, 27 insertions(+), 18 deletions(-)

diff --git a/arch/powerpc/perf/imc-pmu.c b/arch/powerpc/perf/imc-pmu.c
index d7532e7..258b0f4 100644
--- a/arch/powerpc/perf/imc-pmu.c
+++ b/arch/powerpc/perf/imc-pmu.c
@@ -1153,7 +1153,7 @@ static void cleanup_all_core_imc_memory(void)
 	/* mem_info will never be NULL */
 	for (i = 0; i < nr_cores; i++) {
 		if (ptr[i].vbase)
-			free_pages((u64)ptr->vbase, get_order(size));
+			free_pages((u64)ptr[i].vbase, get_order(size));
 	}
 
 	kfree(ptr);
@@ -1191,7 +1191,6 @@ static void imc_common_mem_free(struct imc_pmu *pmu_ptr)
 	if (pmu_ptr->attr_groups[IMC_EVENT_ATTR])
 		kfree(pmu_ptr->attr_groups[IMC_EVENT_ATTR]->attrs);
 	kfree(pmu_ptr->attr_groups[IMC_EVENT_ATTR]);
-	kfree(pmu_ptr);
 }
 
 /*
@@ -1208,6 +1207,7 @@ static void imc_common_cpuhp_mem_free(struct imc_pmu *pmu_ptr)
 			cpuhp_remove_state(CPUHP_AP_PERF_POWERPC_NEST_IMC_ONLINE);
 			kfree(nest_imc_refc);
 			kfree(per_nest_pmu_arr);
+			per_nest_pmu_arr = NULL;
 		}
 
 		if (nest_pmus > 0)
@@ -1319,10 +1319,8 @@ int init_imc_pmu(struct device_node *parent, struct imc_pmu *pmu_ptr, int pmu_id
 	int ret;
 
 	ret = imc_mem_init(pmu_ptr, parent, pmu_idx);
-	if (ret) {
-		imc_common_mem_free(pmu_ptr);
-		return ret;
-	}
+	if (ret)
+		goto err_free_mem;
 
 	switch (pmu_ptr->domain) {
 	case IMC_DOMAIN_NEST:
@@ -1337,7 +1335,9 @@ int init_imc_pmu(struct device_node *parent, struct imc_pmu *pmu_ptr, int pmu_id
 			ret = init_nest_pmu_ref();
 			if (ret) {
 				mutex_unlock(&nest_init_lock);
-				goto err_free;
+				kfree(per_nest_pmu_arr);
+				per_nest_pmu_arr = NULL;
+				goto err_free_mem;
 			}
 			/* Register for cpu hotplug notification. */
 			ret = nest_pmu_cpumask_init();
@@ -1345,7 +1345,8 @@ int init_imc_pmu(struct device_node *parent, struct imc_pmu *pmu_ptr, int pmu_id
 				mutex_unlock(&nest_init_lock);
 				kfree(nest_imc_refc);
 				kfree(per_nest_pmu_arr);
-				goto err_free;
+				per_nest_pmu_arr = NULL;
+				goto err_free_mem;
 			}
 		}
 		nest_pmus++;
@@ -1355,7 +1356,7 @@ int init_imc_pmu(struct device_node *parent, struct imc_pmu *pmu_ptr, int pmu_id
 		ret = core_imc_pmu_cpumask_init();
 		if (ret) {
 			cleanup_all_core_imc_memory();
-			return ret;
+			goto err_free_mem;
 		}
 
 		break;
@@ -1363,7 +1364,7 @@ int init_imc_pmu(struct device_node *parent, struct imc_pmu *pmu_ptr, int pmu_id
 		ret = thread_imc_cpu_init();
 		if (ret) {
 			cleanup_all_thread_imc_memory();
-			return ret;
+			goto err_free_mem;
 		}
 
 		break;
@@ -1373,23 +1374,24 @@ int init_imc_pmu(struct device_node *parent, struct imc_pmu *pmu_ptr, int pmu_id
 
 	ret = update_events_in_group(parent, pmu_ptr);
 	if (ret)
-		goto err_free;
+		goto err_free_cpuhp_mem;
 
 	ret = update_pmu_ops(pmu_ptr);
 	if (ret)
-		goto err_free;
+		goto err_free_cpuhp_mem;
 
 	ret = perf_pmu_register(&pmu_ptr->pmu, pmu_ptr->pmu.name, -1);
 	if (ret)
-		goto err_free;
+		goto err_free_cpuhp_mem;
 
 	pr_info("%s performance monitor hardware support registered\n",
 							pmu_ptr->pmu.name);
 
 	return 0;
 
-err_free:
-	imc_common_mem_free(pmu_ptr);
+err_free_cpuhp_mem:
 	imc_common_cpuhp_mem_free(pmu_ptr);
+err_free_mem:
+	imc_common_mem_free(pmu_ptr);
 	return ret;
 }
diff --git a/arch/powerpc/platforms/powernv/opal-imc.c b/arch/powerpc/platforms/powernv/opal-imc.c
index 2a14fda..490bb72 100644
--- a/arch/powerpc/platforms/powernv/opal-imc.c
+++ b/arch/powerpc/platforms/powernv/opal-imc.c
@@ -115,8 +115,10 @@ static int imc_get_mem_addr_nest(struct device_node *node,
 		return -ENOMEM;
 
 	chipid_arr = kcalloc(nr_chips, sizeof(*chipid_arr), GFP_KERNEL);
-	if (!chipid_arr)
+	if (!chipid_arr) {
+		kfree(base_addr_arr);
 		return -ENOMEM;
+	}
 
 	if (of_property_read_u32_array(node, "chip-id", chipid_arr, nr_chips))
 		goto error;
@@ -143,7 +145,6 @@ static int imc_get_mem_addr_nest(struct device_node *node,
 	return 0;
 
 error:
-	kfree(pmu_ptr->mem_info);
 	kfree(base_addr_arr);
 	kfree(chipid_arr);
 	return -1;
@@ -183,8 +184,14 @@ static int imc_pmu_create(struct device_node *parent, int pmu_index, int domain)
 
 	/* Function to register IMC pmu */
 	ret = init_imc_pmu(parent, pmu_ptr, pmu_index);
-	if (ret)
+	if (ret) {
 		pr_err("IMC PMU %s Register failed\n", pmu_ptr->pmu.name);
+		kfree(pmu_ptr->pmu.name);
+		if (pmu_ptr->domain == IMC_DOMAIN_NEST)
+			kfree(pmu_ptr->mem_info);
+		kfree(pmu_ptr);
+		return ret;
+	}
 
 	return 0;
 
-- 
2.7.4

Return-Path: <anju@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yR8f33NnqzDr1w
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 31 Oct 2017 22:44:42 +1100 (AEDT)
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 v9VBfDSK016999
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 31 Oct 2017 07:44:39 -0400
Received: from e06smtp12.uk.ibm.com (e06smtp12.uk.ibm.com [195.75.94.108])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2dxq3rwn5m-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 31 Oct 2017 07:44:39 -0400
Received: from localhost
 by e06smtp12.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <anju@linux.vnet.ibm.com>;
 Tue, 31 Oct 2017 11:44:37 -0000
From: Anju T Sudhakar <anju@linux.vnet.ibm.com>
To: mpe@ellerman.id.au
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 maddy@linux.vnet.ibm.com, anju@linux.vnet.ibm.com
Subject: [PATCH] powerpc/perf: Clean up IMC code with some code refactoring
Date: Tue, 31 Oct 2017 17:14:33 +0530
Message-Id: <1509450273-23217-1-git-send-email-anju@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Factor out memory freeing part for attribute elements from imc_common_mem_free(),
also handle the memory leak for pmu->events in update_events_in_group(). 

Signed-off-by: Anju T Sudhakar <anju@linux.vnet.ibm.com>
---
 arch/powerpc/perf/imc-pmu.c | 24 ++++++++++++++++--------
 1 file changed, 16 insertions(+), 8 deletions(-)

diff --git a/arch/powerpc/perf/imc-pmu.c b/arch/powerpc/perf/imc-pmu.c
index 88126245881b..45623428f164 100644
--- a/arch/powerpc/perf/imc-pmu.c
+++ b/arch/powerpc/perf/imc-pmu.c
@@ -224,8 +224,10 @@ static int update_events_in_group(struct device_node *node, struct imc_pmu *pmu)
 
 	/* Allocate memory for attribute group */
 	attr_group = kzalloc(sizeof(*attr_group), GFP_KERNEL);
-	if (!attr_group)
+	if (!attr_group) {
+		kfree(pmu->events);
 		return -ENOMEM;
+	}
 
 	/*
 	 * Allocate memory for attributes.
@@ -1143,6 +1145,15 @@ static void cleanup_all_thread_imc_memory(void)
 	}
 }
 
+/* Function to free the attr_groups which are dynamically allocated */
+static void imc_common_mem_free(struct imc_pmu *pmu_ptr)
+{
+	kfree(pmu_ptr->attr_groups[IMC_EVENT_ATTR]->attrs);
+	kfree(pmu_ptr->attr_groups[IMC_EVENT_ATTR]);
+	kfree(pmu_ptr);
+	return;
+}
+
 /*
  * Common function to unregister cpu hotplug callback and
  * free the memory.
@@ -1175,11 +1186,6 @@ static void imc_common_cpuhp_mem_free(struct imc_pmu *pmu_ptr)
 		cleanup_all_thread_imc_memory();
 	}
 
-	/* Only free the attr_groups which are dynamically allocated  */
-	if (pmu_ptr->attr_groups[IMC_EVENT_ATTR])
-		kfree(pmu_ptr->attr_groups[IMC_EVENT_ATTR]->attrs);
-	kfree(pmu_ptr->attr_groups[IMC_EVENT_ATTR]);
-	kfree(pmu_ptr);
 	return;
 }
 
@@ -1318,17 +1324,19 @@ int init_imc_pmu(struct device_node *parent, struct imc_pmu *pmu_ptr, int pmu_id
 
 	ret = update_pmu_ops(pmu_ptr);
 	if (ret)
-		goto err_free;
+		goto err_free_mem;
 
 	ret = perf_pmu_register(&pmu_ptr->pmu, pmu_ptr->pmu.name, -1);
 	if (ret)
-		goto err_free;
+		goto err_free_mem;
 
 	pr_info("%s performance monitor hardware support registered\n",
 							pmu_ptr->pmu.name);
 
 	return 0;
 
+err_free_mem:
+	imc_common_mem_free(pmu_ptr);
 err_free:
 	imc_common_cpuhp_mem_free(pmu_ptr);
 	return ret;
-- 
2.14.1

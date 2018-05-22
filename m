Return-Path: <anju@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40qqgB4R5HzDqNY
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 22 May 2018 19:12:54 +1000 (AEST)
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w4M98lVd053038
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 22 May 2018 05:12:52 -0400
Received: from e06smtp14.uk.ibm.com (e06smtp14.uk.ibm.com [195.75.94.110])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2j4e6mnr1q-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 22 May 2018 05:12:52 -0400
Received: from localhost
 by e06smtp14.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <anju@linux.vnet.ibm.com>;
 Tue, 22 May 2018 10:12:49 +0100
From: Anju T Sudhakar <anju@linux.vnet.ibm.com>
To: mpe@ellerman.id.au
Cc: linuxppc-dev@lists.ozlabs.org, maddy@linux.vnet.ibm.com,
 anju@linux.vnet.ibm.com
Subject: [PATCH v2 2/4] powerpc/perf: Replace the direct return with goto
 statement
Date: Tue, 22 May 2018 14:42:35 +0530
In-Reply-To: <1526980357-25385-1-git-send-email-anju@linux.vnet.ibm.com>
References: <1526980357-25385-1-git-send-email-anju@linux.vnet.ibm.com>
Message-Id: <1526980357-25385-3-git-send-email-anju@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Replace the direct return statement in imc_mem_init() with goto, to adhere
to the kernel coding style.

Signed-off-by: Anju T Sudhakar <anju@linux.vnet.ibm.com>     
Reviewed-by: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
---
 arch/powerpc/perf/imc-pmu.c | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

diff --git a/arch/powerpc/perf/imc-pmu.c b/arch/powerpc/perf/imc-pmu.c
index c1665ff..61000d1 100644
--- a/arch/powerpc/perf/imc-pmu.c
+++ b/arch/powerpc/perf/imc-pmu.c
@@ -1236,7 +1236,7 @@ static int imc_mem_init(struct imc_pmu *pmu_ptr, struct device_node *parent,
 								int pmu_index)
 {
 	const char *s;
-	int nr_cores, cpu, res;
+	int nr_cores, cpu, res = -ENOMEM;
 
 	if (of_property_read_string(parent, "name", &s))
 		return -ENODEV;
@@ -1246,7 +1246,7 @@ static int imc_mem_init(struct imc_pmu *pmu_ptr, struct device_node *parent,
 		/* Update the pmu name */
 		pmu_ptr->pmu.name = kasprintf(GFP_KERNEL, "%s%s_imc", "nest_", s);
 		if (!pmu_ptr->pmu.name)
-			return -ENOMEM;
+			goto err;
 
 		/* Needed for hotplug/migration */
 		if (!per_nest_pmu_arr) {
@@ -1254,7 +1254,7 @@ static int imc_mem_init(struct imc_pmu *pmu_ptr, struct device_node *parent,
 						sizeof(struct imc_pmu *),
 						GFP_KERNEL);
 			if (!per_nest_pmu_arr)
-				return -ENOMEM;
+				goto err;
 		}
 		per_nest_pmu_arr[pmu_index] = pmu_ptr;
 		break;
@@ -1262,21 +1262,21 @@ static int imc_mem_init(struct imc_pmu *pmu_ptr, struct device_node *parent,
 		/* Update the pmu name */
 		pmu_ptr->pmu.name = kasprintf(GFP_KERNEL, "%s%s", s, "_imc");
 		if (!pmu_ptr->pmu.name)
-			return -ENOMEM;
+			goto err;
 
 		nr_cores = DIV_ROUND_UP(num_possible_cpus(), threads_per_core);
 		pmu_ptr->mem_info = kcalloc(nr_cores, sizeof(struct imc_mem_info),
 								GFP_KERNEL);
 
 		if (!pmu_ptr->mem_info)
-			return -ENOMEM;
+			goto err;
 
 		core_imc_refc = kcalloc(nr_cores, sizeof(struct imc_pmu_ref),
 								GFP_KERNEL);
 
 		if (!core_imc_refc) {
 			kfree(pmu_ptr->mem_info);
-			return -ENOMEM;
+			goto err;
 		}
 
 		core_imc_pmu = pmu_ptr;
@@ -1285,14 +1285,14 @@ static int imc_mem_init(struct imc_pmu *pmu_ptr, struct device_node *parent,
 		/* Update the pmu name */
 		pmu_ptr->pmu.name = kasprintf(GFP_KERNEL, "%s%s", s, "_imc");
 		if (!pmu_ptr->pmu.name)
-			return -ENOMEM;
+			goto err;
 
 		thread_imc_mem_size = pmu_ptr->counter_mem_size;
 		for_each_online_cpu(cpu) {
 			res = thread_imc_mem_alloc(cpu, pmu_ptr->counter_mem_size);
 			if (res) {
 				cleanup_all_thread_imc_memory();
-				return res;
+				goto err;
 			}
 		}
 
@@ -1302,6 +1302,8 @@ static int imc_mem_init(struct imc_pmu *pmu_ptr, struct device_node *parent,
 	}
 
 	return 0;
+err:
+	return res;
 }
 
 /*
-- 
2.7.4

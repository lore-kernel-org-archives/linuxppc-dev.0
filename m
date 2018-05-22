Return-Path: <anju@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40qqgH251QzDqjC
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 22 May 2018 19:12:59 +1000 (AEST)
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w4M98f0g080269
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 22 May 2018 05:12:57 -0400
Received: from e06smtp12.uk.ibm.com (e06smtp12.uk.ibm.com [195.75.94.108])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2j4egwd76p-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 22 May 2018 05:12:56 -0400
Received: from localhost
 by e06smtp12.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <anju@linux.vnet.ibm.com>;
 Tue, 22 May 2018 10:12:55 +0100
From: Anju T Sudhakar <anju@linux.vnet.ibm.com>
To: mpe@ellerman.id.au
Cc: linuxppc-dev@lists.ozlabs.org, maddy@linux.vnet.ibm.com,
 anju@linux.vnet.ibm.com
Subject: [PATCH v2 4/4] powerpc/perf: Unregister thread-imc if core-imc not
 supported
Date: Tue, 22 May 2018 14:42:37 +0530
In-Reply-To: <1526980357-25385-1-git-send-email-anju@linux.vnet.ibm.com>
References: <1526980357-25385-1-git-send-email-anju@linux.vnet.ibm.com>
Message-Id: <1526980357-25385-5-git-send-email-anju@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Since thread-imc internally use the core-imc hardware infrastructure
and is depended on it, having thread-imc in the kernel in the
absence of core-imc is trivial. Patch disables thread-imc, if
core-imc is not registered.

Signed-off-by: Anju T Sudhakar <anju@linux.vnet.ibm.com>
Reviewed-by: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/imc-pmu.h        |  1 +
 arch/powerpc/perf/imc-pmu.c               | 12 ++++++++++++
 arch/powerpc/platforms/powernv/opal-imc.c |  9 +++++++++
 3 files changed, 22 insertions(+)

diff --git a/arch/powerpc/include/asm/imc-pmu.h b/arch/powerpc/include/asm/imc-pmu.h
index d76cb11..69f516e 100644
--- a/arch/powerpc/include/asm/imc-pmu.h
+++ b/arch/powerpc/include/asm/imc-pmu.h
@@ -128,4 +128,5 @@ extern int init_imc_pmu(struct device_node *parent,
 				struct imc_pmu *pmu_ptr, int pmu_id);
 extern void thread_imc_disable(void);
 extern int get_max_nest_dev(void);
+extern void unregister_thread_imc(void);
 #endif /* __ASM_POWERPC_IMC_PMU_H */
diff --git a/arch/powerpc/perf/imc-pmu.c b/arch/powerpc/perf/imc-pmu.c
index f563d30..d1977b6 100644
--- a/arch/powerpc/perf/imc-pmu.c
+++ b/arch/powerpc/perf/imc-pmu.c
@@ -40,6 +40,7 @@ static struct imc_pmu *core_imc_pmu;
 /* Thread IMC data structures and variables */
 
 static DEFINE_PER_CPU(u64 *, thread_imc_mem);
+static struct imc_pmu *thread_imc_pmu;
 static int thread_imc_mem_size;
 
 struct imc_pmu *imc_event_to_pmu(struct perf_event *event)
@@ -1228,6 +1229,16 @@ static void imc_common_cpuhp_mem_free(struct imc_pmu *pmu_ptr)
 	}
 }
 
+/*
+ * Function to unregister thread-imc if core-imc
+ * is not registered.
+ */
+void unregister_thread_imc(void)
+{
+	imc_common_cpuhp_mem_free(thread_imc_pmu);
+	imc_common_mem_free(thread_imc_pmu);
+	perf_pmu_unregister(&thread_imc_pmu->pmu);
+}
 
 /*
  * imc_mem_init : Function to support memory allocation for core imc.
@@ -1296,6 +1307,7 @@ static int imc_mem_init(struct imc_pmu *pmu_ptr, struct device_node *parent,
 			}
 		}
 
+		thread_imc_pmu = pmu_ptr;
 		break;
 	default:
 		return -EINVAL;
diff --git a/arch/powerpc/platforms/powernv/opal-imc.c b/arch/powerpc/platforms/powernv/opal-imc.c
index 490bb72..58a0794 100644
--- a/arch/powerpc/platforms/powernv/opal-imc.c
+++ b/arch/powerpc/platforms/powernv/opal-imc.c
@@ -255,6 +255,7 @@ static int opal_imc_counters_probe(struct platform_device *pdev)
 {
 	struct device_node *imc_dev = pdev->dev.of_node;
 	int pmu_count = 0, domain;
+	bool core_imc_reg = false, thread_imc_reg = false;
 	u32 type;
 
 	/*
@@ -292,6 +293,10 @@ static int opal_imc_counters_probe(struct platform_device *pdev)
 		if (!imc_pmu_create(imc_dev, pmu_count, domain)) {
 			if (domain == IMC_DOMAIN_NEST)
 				pmu_count++;
+			if (domain == IMC_DOMAIN_CORE)
+				core_imc_reg = true;
+			if (domain == IMC_DOMAIN_THREAD)
+				thread_imc_reg = true;
 		}
 	}
 
@@ -299,6 +304,10 @@ static int opal_imc_counters_probe(struct platform_device *pdev)
 	if (pmu_count == 0)
 		debugfs_remove_recursive(imc_debugfs_parent);
 
+	/* If core imc is not registered, unregister thread-imc */
+	if (!core_imc_reg && thread_imc_reg)
+		unregister_thread_imc();
+
 	return 0;
 }
 
-- 
2.7.4

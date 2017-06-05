Return-Path: <anju@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3whDht5Gp6zDqKs
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  5 Jun 2017 22:31:58 +1000 (AEST)
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v55CSn9i037612
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 5 Jun 2017 08:31:56 -0400
Received: from e23smtp03.au.ibm.com (e23smtp03.au.ibm.com [202.81.31.145])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2aw6pa1rur-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 05 Jun 2017 08:31:56 -0400
Received: from localhost
 by e23smtp03.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <anju@linux.vnet.ibm.com>;
 Mon, 5 Jun 2017 22:31:48 +1000
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay10.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v55CVb4W1442234
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 5 Jun 2017 22:31:45 +1000
Received: from d23av03.au.ibm.com (localhost [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v55CV5OY005963
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 5 Jun 2017 22:31:06 +1000
From: Anju T Sudhakar <anju@linux.vnet.ibm.com>
To: mpe@ellerman.id.au
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 ego@linux.vnet.ibm.com, bsingharora@gmail.com, anton@samba.org,
 sukadev@linux.vnet.ibm.com, mikey@neuling.org,
 stewart@linux.vnet.ibm.com, dja@axtens.net, eranian@google.com,
 hemant@linux.vnet.ibm.com, maddy@linux.vnet.ibm.com,
 anju@linux.vnet.ibm.com
Subject: [PATCH v9 08/10] powerpc/powernv: Thread IMC events detection
Date: Mon,  5 Jun 2017 18:00:17 +0530
In-Reply-To: <1496665818-543-1-git-send-email-anju@linux.vnet.ibm.com>
References: <1496665818-543-1-git-send-email-anju@linux.vnet.ibm.com>
Message-Id: <1496665818-543-7-git-send-email-anju@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Code to add support for detection of thread IMC events. It adds a new
domain IMC_DOMAIN_THREAD and it is determined with the help of the
"type" property in the imc device-tree.

Signed-off-by: Anju T Sudhakar <anju@linux.vnet.ibm.com>
Signed-off-by: Hemant Kumar <hemant@linux.vnet.ibm.com>
Signed-off-by: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/imc-pmu.h        | 1 +
 arch/powerpc/include/asm/opal-api.h       | 1 +
 arch/powerpc/perf/imc-pmu.c               | 1 +
 arch/powerpc/platforms/powernv/opal-imc.c | 9 ++++++++-
 4 files changed, 11 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/include/asm/imc-pmu.h b/arch/powerpc/include/asm/imc-pmu.h
index 5227660..5cbc61d 100644
--- a/arch/powerpc/include/asm/imc-pmu.h
+++ b/arch/powerpc/include/asm/imc-pmu.h
@@ -96,6 +96,7 @@ struct imc_pmu {
  */
 #define IMC_DOMAIN_NEST		1
 #define IMC_DOMAIN_CORE		2
+#define IMC_DOMAIN_THREAD	3
 
 #define IMC_COUNTER_ENABLE     1
 #define IMC_COUNTER_DISABLE    0
diff --git a/arch/powerpc/include/asm/opal-api.h b/arch/powerpc/include/asm/opal-api.h
index 047370e..ba1f534 100644
--- a/arch/powerpc/include/asm/opal-api.h
+++ b/arch/powerpc/include/asm/opal-api.h
@@ -1008,6 +1008,7 @@ enum {
 
 /* In-Memory Collection Counters Type */
 enum {
+	IMC_COUNTER_PER_THREAD          = 0x1,
 	IMC_COUNTER_PER_SUB_CORE        = 0x2,
 	IMC_COUNTER_PER_CORE            = 0x4,
 	IMC_COUNTER_PER_QUAD            = 0x8,
diff --git a/arch/powerpc/perf/imc-pmu.c b/arch/powerpc/perf/imc-pmu.c
index 6d32c3f..e67680f 100644
--- a/arch/powerpc/perf/imc-pmu.c
+++ b/arch/powerpc/perf/imc-pmu.c
@@ -21,6 +21,7 @@
 /* Needed for sanity check */
 extern u64 nest_max_offset;
 extern u64 core_max_offset;
+extern u64 thread_max_offset;
 
 struct imc_pmu *per_nest_pmu_arr[IMC_MAX_PMUS];
 static cpumask_t nest_imc_cpumask;
diff --git a/arch/powerpc/platforms/powernv/opal-imc.c b/arch/powerpc/platforms/powernv/opal-imc.c
index d0d26dd..9bcf58b 100644
--- a/arch/powerpc/platforms/powernv/opal-imc.c
+++ b/arch/powerpc/platforms/powernv/opal-imc.c
@@ -36,6 +36,7 @@
 
 u64 nest_max_offset;
 u64 core_max_offset;
+u64 thread_max_offset;
 
 static int imc_event_prop_update(char *name, struct imc_events *events)
 {
@@ -120,6 +121,10 @@ static void update_max_value(u32 value, int pmu_domain)
 		if (core_max_offset < value)
 			core_max_offset = value;
 		break;
+	case IMC_DOMAIN_THREAD:
+		if (thread_max_offset < value)
+			thread_max_offset = value;
+		break;
 	default:
 		/* Unknown domain, return */
 		return;
@@ -405,7 +410,7 @@ static int imc_get_mem_addr_nest(struct device_node *node,
 /*
  * imc_pmu_create : Takes the parent device which is the pmu unit, pmu_index
  *		    and domain as the inputs.
- * Allocates memory for the pmu, sets up its domain (NEST/CORE), and
+ * Allocates memory for the pmu, sets up its domain (NEST/CORE/THREAD), and
  * calls imc_events_setup() to allocate memory for the events supported
  * by this pmu. Assigns a name for the pmu.
  *
@@ -524,6 +529,8 @@ static int opal_imc_counters_probe(struct platform_device *pdev)
 			domain = IMC_DOMAIN_NEST;
 		else if (type == IMC_COUNTER_PER_CORE)
 			domain = IMC_DOMAIN_CORE;
+		else if (type == IMC_COUNTER_PER_THREAD)
+			domain = IMC_DOMAIN_THREAD;
 		else
 			continue;
 		if (!imc_pmu_create(imc_dev, pmu_count, domain))
-- 
2.7.4

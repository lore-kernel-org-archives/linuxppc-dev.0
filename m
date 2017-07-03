Return-Path: <anju@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3x1MWf710nzDr8s
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  3 Jul 2017 19:38:22 +1000 (AEST)
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v639XgT2119636
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 3 Jul 2017 05:38:20 -0400
Received: from e23smtp04.au.ibm.com (e23smtp04.au.ibm.com [202.81.31.146])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2bf2b9prac-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 03 Jul 2017 05:38:20 -0400
Received: from localhost
 by e23smtp04.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <anju@linux.vnet.ibm.com>;
 Mon, 3 Jul 2017 19:38:18 +1000
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay07.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v639cElD46661768
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 3 Jul 2017 19:38:14 +1000
Received: from d23av03.au.ibm.com (localhost [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v639c58C028279
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 3 Jul 2017 19:38:06 +1000
From: Anju T Sudhakar <anju@linux.vnet.ibm.com>
To: mpe@ellerman.id.au
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 ego@linux.vnet.ibm.com, bsingharora@gmail.com, anton@samba.org,
 sukadev@linux.vnet.ibm.com, mikey@neuling.org,
 stewart@linux.vnet.ibm.com, dja@axtens.net, eranian@google.com,
 hemant@linux.vnet.ibm.com, maddy@linux.vnet.ibm.com,
 anju@linux.vnet.ibm.com
Subject: [PATCH v12 06/10] powerpc/powernv: Core IMC events detection
Date: Mon,  3 Jul 2017 15:07:51 +0530
In-Reply-To: <1499074673-30576-1-git-send-email-anju@linux.vnet.ibm.com>
References: <1499074673-30576-1-git-send-email-anju@linux.vnet.ibm.com>
Message-Id: <1499074673-30576-6-git-send-email-anju@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>

This patch adds support for detection of core IMC events along with the
Nest IMC events. It adds a new domain IMC_DOMAIN_CORE and its determined
with the help of the "type" property in the IMC device tree.

Signed-off-by: Anju T Sudhakar <anju@linux.vnet.ibm.com>
Signed-off-by: Hemant Kumar <hemant@linux.vnet.ibm.com>
Signed-off-by: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/imc-pmu.h        |  3 +++
 arch/powerpc/perf/imc-pmu.c               |  2 ++
 arch/powerpc/platforms/powernv/opal-imc.c | 14 +++++++++++---
 3 files changed, 16 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/include/asm/imc-pmu.h b/arch/powerpc/include/asm/imc-pmu.h
index aeed903b2a79..24a6112ca0b5 100644
--- a/arch/powerpc/include/asm/imc-pmu.h
+++ b/arch/powerpc/include/asm/imc-pmu.h
@@ -107,6 +107,7 @@ struct imc_pmu_ref {
 
 /* In-Memory Collection Counters Type */
 enum {
+	IMC_COUNTER_PER_CORE		= 0x4,
 	IMC_COUNTER_PER_CHIP            = 0x10,
 };
 
@@ -114,7 +115,9 @@ enum {
  * Domains for IMC PMUs
  */
 #define IMC_DOMAIN_NEST		1
+#define IMC_DOMAIN_CORE		2
 
 extern struct imc_pmu *per_nest_pmu_arr[IMC_MAX_PMUS];
+extern struct imc_pmu *core_imc_pmu;
 extern int init_imc_pmu(struct imc_events *events, int idx, struct imc_pmu *pmu_ptr);
 #endif /* PPC_POWERNV_IMC_PMU_DEF_H */
diff --git a/arch/powerpc/perf/imc-pmu.c b/arch/powerpc/perf/imc-pmu.c
index ca9662bea7d6..041d3097d42a 100644
--- a/arch/powerpc/perf/imc-pmu.c
+++ b/arch/powerpc/perf/imc-pmu.c
@@ -31,6 +31,8 @@ static DEFINE_MUTEX(imc_nest_inited_reserve);
 
 struct imc_pmu_ref *nest_imc_refc;
 
+struct imc_pmu *core_imc_pmu;
+
 struct imc_pmu *imc_event_to_pmu(struct perf_event *event)
 {
 	return container_of(event->pmu, struct imc_pmu, pmu);
diff --git a/arch/powerpc/platforms/powernv/opal-imc.c b/arch/powerpc/platforms/powernv/opal-imc.c
index 406f7c10850a..aeef59b66420 100644
--- a/arch/powerpc/platforms/powernv/opal-imc.c
+++ b/arch/powerpc/platforms/powernv/opal-imc.c
@@ -379,7 +379,7 @@ static int imc_get_mem_addr_nest(struct device_node *node,
 /*
  * imc_pmu_create : Takes the parent device which is the pmu unit, pmu_index
  *		    and domain as the inputs.
- * Allocates memory for the pmu, sets up its domain (NEST), and
+ * Allocates memory for the pmu, sets up its domain (NEST/CORE), and
  * calls imc_events_setup() to allocate memory for the events supported
  * by this pmu. Assigns a name for the pmu.
  *
@@ -406,7 +406,10 @@ static int imc_pmu_create(struct device_node *parent, int pmu_index, int domain)
 	pmu_ptr->domain = domain;
 
 	/* Needed for hotplug/migration */
-	per_nest_pmu_arr[pmu_index] = pmu_ptr;
+	if (pmu_ptr->domain == IMC_DOMAIN_CORE)
+		core_imc_pmu = pmu_ptr;
+	else if (pmu_ptr->domain == IMC_DOMAIN_NEST)
+		per_nest_pmu_arr[pmu_index] = pmu_ptr;
 
 	pp = of_find_property(parent, "name", NULL);
 	if (!pp) {
@@ -427,7 +430,10 @@ static int imc_pmu_create(struct device_node *parent, int pmu_index, int domain)
 		goto free_pmu;
 	}
 	/* Save the name to register it later */
-	sprintf(buf, "nest_%s", (char *)pp->value);
+	if (pmu_ptr->domain == IMC_DOMAIN_NEST)
+		sprintf(buf, "nest_%s", (char *)pp->value);
+	else
+		sprintf(buf, "%s_imc", (char *)pp->value);
 	pmu_ptr->pmu.name = (char *)buf;
 
 	if (of_property_read_u32(parent, "size", &pmu_ptr->counter_mem_size))
@@ -505,6 +511,8 @@ static int opal_imc_counters_probe(struct platform_device *pdev)
 			continue;
 		if (type == IMC_COUNTER_PER_CHIP)
 			domain = IMC_DOMAIN_NEST;
+		else if (type == IMC_COUNTER_PER_CORE)
+			domain = IMC_DOMAIN_CORE;
 		else
 			continue;
 		if (!imc_pmu_create(imc_dev, pmu_count, domain))
-- 
2.11.0

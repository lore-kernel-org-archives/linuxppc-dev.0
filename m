Return-Path: <anju@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wJcf759WdzDqG1
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  5 May 2017 00:21:35 +1000 (AEST)
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v44EIxBO141364
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 4 May 2017 10:21:21 -0400
Received: from e23smtp07.au.ibm.com (e23smtp07.au.ibm.com [202.81.31.140])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2a7ux5bf86-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 04 May 2017 10:21:20 -0400
Received: from localhost
 by e23smtp07.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <anju@linux.vnet.ibm.com>;
 Fri, 5 May 2017 00:21:18 +1000
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay08.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v44EL8Nq46268560
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 5 May 2017 00:21:16 +1000
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v44EKbmE012931
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 5 May 2017 00:20:38 +1000
From: Anju T Sudhakar <anju@linux.vnet.ibm.com>
To: mpe@ellerman.id.au
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 ego@linux.vnet.ibm.com, bsingharora@gmail.com, anton@samba.org,
 sukadev@linux.vnet.ibm.com, mikey@neuling.org,
 stewart@linux.vnet.ibm.com, dja@axtens.net, eranian@google.com,
 hemant@linux.vnet.ibm.com, maddy@linux.vnet.ibm.com,
 anju@linux.vnet.ibm.com
Subject: [PATCH v8 06/10] powerpc/powernv: Core IMC events detection
Date: Thu,  4 May 2017 19:49:52 +0530
In-Reply-To: <1493907596-11425-1-git-send-email-anju@linux.vnet.ibm.com>
References: <1493907596-11425-1-git-send-email-anju@linux.vnet.ibm.com>
Message-Id: <1493907596-11425-7-git-send-email-anju@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Hemant Kumar <hemant@linux.vnet.ibm.com>

This patch adds support for detection of core IMC events along with the
Nest IMC events. It adds a new domain IMC_DOMAIN_CORE and its determined
with the help of the compatibility string "ibm,imc-counters-core" based
on the IMC device tree.

Signed-off-by: Anju T Sudhakar <anju@linux.vnet.ibm.com>
Signed-off-by: Hemant Kumar <hemant@linux.vnet.ibm.com>
Signed-off-by: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/imc-pmu.h        |  4 +++-
 arch/powerpc/perf/imc-pmu.c               |  3 +++
 arch/powerpc/platforms/powernv/opal-imc.c | 28 +++++++++++++++++++++++++---
 3 files changed, 31 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/include/asm/imc-pmu.h b/arch/powerpc/include/asm/imc-pmu.h
index 1478d0f..37fdd79 100644
--- a/arch/powerpc/include/asm/imc-pmu.h
+++ b/arch/powerpc/include/asm/imc-pmu.h
@@ -42,6 +42,7 @@
  */
 #define IMC_DTB_COMPAT			"ibm,opal-in-memory-counters"
 #define IMC_DTB_NEST_COMPAT		"ibm,imc-counters-nest"
+#define IMC_DTB_CORE_COMPAT		"ibm,imc-counters-core"
 
 /*
  * Structure to hold per chip specific memory address
@@ -90,13 +91,14 @@ struct imc_pmu {
  * Domains for IMC PMUs
  */
 #define IMC_DOMAIN_NEST		1
+#define IMC_DOMAIN_CORE		2
 #define IMC_DOMAIN_UNKNOWN	-1
 
 #define IMC_COUNTER_ENABLE	1
 #define IMC_COUNTER_DISABLE	0
 
-
 extern struct perchip_nest_info nest_perchip_info[IMC_MAX_CHIPS];
 extern struct imc_pmu *per_nest_pmu_arr[IMC_MAX_PMUS];
+extern struct imc_pmu *core_imc_pmu;
 extern int __init init_imc_pmu(struct imc_events *events,int idx, struct imc_pmu *pmu_ptr);
 #endif /* PPC_POWERNV_IMC_PMU_DEF_H */
diff --git a/arch/powerpc/perf/imc-pmu.c b/arch/powerpc/perf/imc-pmu.c
index 40792424..c132df2 100644
--- a/arch/powerpc/perf/imc-pmu.c
+++ b/arch/powerpc/perf/imc-pmu.c
@@ -24,8 +24,11 @@ static atomic_t nest_events;
 /* Used to avoid races in calling enable/disable nest-pmu units*/
 static DEFINE_MUTEX(imc_nest_reserve);
 
+struct imc_pmu *core_imc_pmu;
+
 /* Needed for sanity check */
 extern u64 nest_max_offset;
+extern u64 core_max_offset;
 
 PMU_FORMAT_ATTR(event, "config:0-20");
 static struct attribute *imc_format_attrs[] = {
diff --git a/arch/powerpc/platforms/powernv/opal-imc.c b/arch/powerpc/platforms/powernv/opal-imc.c
index 61f6d67..d712ef3 100644
--- a/arch/powerpc/platforms/powernv/opal-imc.c
+++ b/arch/powerpc/platforms/powernv/opal-imc.c
@@ -34,6 +34,7 @@
 #include <asm/imc-pmu.h>
 
 u64 nest_max_offset;
+u64 core_max_offset;
 
 static int imc_event_prop_update(char *name, struct imc_events *events)
 {
@@ -114,6 +115,10 @@ static void update_max_value(u32 value, int pmu_domain)
 		if (nest_max_offset < value)
 			nest_max_offset = value;
 		break;
+	case IMC_DOMAIN_CORE:
+		if (core_max_offset < value)
+			core_max_offset = value;
+		break;
 	default:
 		/* Unknown domain, return */
 		return;
@@ -357,7 +362,7 @@ static struct imc_events *imc_events_setup(struct device_node *parent,
 /*
  * imc_pmu_create : Takes the parent device which is the pmu unit and a
  *                  pmu_index as the inputs.
- * Allocates memory for the pmu, sets up its domain (NEST), and
+ * Allocates memory for the pmu, sets up its domain (NEST/CORE), and
  * calls imc_events_setup() to allocate memory for the events supported
  * by this pmu. Assigns a name for the pmu. Calls imc_events_node_parser()
  * to setup the individual events.
@@ -386,7 +391,10 @@ static int imc_pmu_create(struct device_node *parent, int pmu_index, int domain)
 		goto free_pmu;
 
 	/* Needed for hotplug/migration */
-	per_nest_pmu_arr[pmu_index] = pmu_ptr;
+	if (pmu_ptr->domain == IMC_DOMAIN_CORE)
+		core_imc_pmu = pmu_ptr;
+	else if (pmu_ptr->domain == IMC_DOMAIN_NEST)
+		per_nest_pmu_arr[pmu_index] = pmu_ptr;
 
 	pp = of_find_property(parent, "name", NULL);
 	if (!pp) {
@@ -407,7 +415,10 @@ static int imc_pmu_create(struct device_node *parent, int pmu_index, int domain)
 		goto free_pmu;
 	}
 	/* Save the name to register it later */
-	sprintf(buf, "nest_%s", (char *)pp->value);
+	if (pmu_ptr->domain == IMC_DOMAIN_NEST)
+		sprintf(buf, "nest_%s", (char *)pp->value);
+	else
+		sprintf(buf, "%s_imc", (char *)pp->value);
 	pmu_ptr->pmu.name = (char *)buf;
 
 	/*
@@ -461,6 +472,17 @@ static void __init imc_pmu_setup(struct device_node *parent)
 			return;
 		pmu_count++;
 	}
+	/*
+	 * Loop through the imc-counters tree for each compatible
+	 * "ibm,imc-counters-core", and update "struct imc_pmu".
+	 */
+	for_each_compatible_node(child, NULL, IMC_DTB_CORE_COMPAT) {
+		domain = IMC_DOMAIN_CORE;
+		rc = imc_pmu_create(child, pmu_count, domain);
+		if (rc)
+			return;
+		pmu_count++;
+	}
 }
 
 static int opal_imc_counters_probe(struct platform_device *pdev)
-- 
2.7.4

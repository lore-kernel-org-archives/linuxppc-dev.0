Return-Path: <maddy@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vxZvX472XzDqK7
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  4 Apr 2017 00:57:12 +1000 (AEST)
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v33EsEPJ010020
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 3 Apr 2017 10:57:01 -0400
Received: from e23smtp03.au.ibm.com (e23smtp03.au.ibm.com [202.81.31.145])
 by mx0a-001b2d01.pphosted.com with ESMTP id 29kqbhd736-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 03 Apr 2017 10:57:01 -0400
Received: from localhost
 by e23smtp03.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <maddy@linux.vnet.ibm.com>;
 Tue, 4 Apr 2017 00:56:58 +1000
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay07.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v33EunhV29163686
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 4 Apr 2017 00:56:57 +1000
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v33EuK0O026451
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 4 Apr 2017 00:56:21 +1000
From: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
To: mpe@ellerman.id.au
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 ego@linux.vnet.ibm.com, bsingharora@gmail.com,
 benh@kernel.crashing.org, paulus@samba.org, anton@samba.org,
 sukadev@linux.vnet.ibm.com, mikey@neuling.org,
 stewart@linux.vnet.ibm.com, dja@axtens.net, eranian@google.com,
 Hemant Kumar <hemant@linux.vnet.ibm.com>,
 Anju T Sudhakar <anju@linux.vnet.ibm.com>,
 Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
Subject: [PATCH v6 07/11] powerpc/powernv: Core IMC events detection
Date: Mon,  3 Apr 2017 20:25:04 +0530
In-Reply-To: <1491231308-15282-1-git-send-email-maddy@linux.vnet.ibm.com>
References: <1491231308-15282-1-git-send-email-maddy@linux.vnet.ibm.com>
Message-Id: <1491231308-15282-8-git-send-email-maddy@linux.vnet.ibm.com>
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
 arch/powerpc/include/asm/imc-pmu.h        |  2 ++
 arch/powerpc/perf/imc-pmu.c               |  3 +++
 arch/powerpc/platforms/powernv/opal-imc.c | 18 ++++++++++++++++--
 3 files changed, 21 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/include/asm/imc-pmu.h b/arch/powerpc/include/asm/imc-pmu.h
index e13f51047522..2c39603ff3e7 100644
--- a/arch/powerpc/include/asm/imc-pmu.h
+++ b/arch/powerpc/include/asm/imc-pmu.h
@@ -26,6 +26,7 @@
 
 #define IMC_DTB_COMPAT			"ibm,opal-in-memory-counters"
 #define IMC_DTB_NEST_COMPAT		"ibm,imc-counters-nest"
+#define IMC_DTB_CORE_COMPAT		"ibm,imc-counters-core"
 
 /*
  * Structure to hold per chip specific memory address
@@ -63,6 +64,7 @@ struct imc_pmu {
  * Domains for IMC PMUs
  */
 #define IMC_DOMAIN_NEST		1
+#define IMC_DOMAIN_CORE		2
 #define IMC_DOMAIN_UNKNOWN	-1
 
 int imc_get_domain(struct device_node *pmu_dev);
diff --git a/arch/powerpc/perf/imc-pmu.c b/arch/powerpc/perf/imc-pmu.c
index b28835b861b3..728c67e139e0 100644
--- a/arch/powerpc/perf/imc-pmu.c
+++ b/arch/powerpc/perf/imc-pmu.c
@@ -19,8 +19,11 @@ struct perchip_nest_info nest_perchip_info[IMC_MAX_CHIPS];
 struct imc_pmu *per_nest_pmu_arr[IMC_MAX_PMUS];
 static cpumask_t nest_imc_cpumask;
 
+struct imc_pmu *core_imc_pmu;
+
 /* Needed for sanity check */
 extern u64 nest_max_offset;
+extern u64 core_max_offset;
 
 PMU_FORMAT_ATTR(event, "config:0-20");
 static struct attribute *imc_format_attrs[] = {
diff --git a/arch/powerpc/platforms/powernv/opal-imc.c b/arch/powerpc/platforms/powernv/opal-imc.c
index a98678266b0d..f6f63399ab06 100644
--- a/arch/powerpc/platforms/powernv/opal-imc.c
+++ b/arch/powerpc/platforms/powernv/opal-imc.c
@@ -34,10 +34,12 @@
 
 extern struct perchip_nest_info nest_perchip_info[IMC_MAX_CHIPS];
 extern struct imc_pmu *per_nest_pmu_arr[IMC_MAX_PMUS];
+extern struct imc_pmu *core_imc_pmu;
 
 extern int init_imc_pmu(struct imc_events *events,
 			int idx, struct imc_pmu *pmu_ptr);
 u64 nest_max_offset;
+u64 core_max_offset;
 
 static int imc_event_info(char *name, struct imc_events *events)
 {
@@ -81,6 +83,10 @@ static void update_max_value(u32 value, int pmu_domain)
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
@@ -232,6 +238,8 @@ int imc_get_domain(struct device_node *pmu_dev)
 {
 	if (of_device_is_compatible(pmu_dev, IMC_DTB_NEST_COMPAT))
 		return IMC_DOMAIN_NEST;
+	if (of_device_is_compatible(pmu_dev, IMC_DTB_CORE_COMPAT))
+		return IMC_DOMAIN_CORE;
 	else
 		return IMC_DOMAIN_UNKNOWN;
 }
@@ -299,7 +307,10 @@ static int imc_pmu_create(struct device_node *parent, int pmu_index)
 		goto free_pmu;
 
 	/* Needed for hotplug/migration */
-	per_nest_pmu_arr[pmu_index] = pmu_ptr;
+	if (pmu_ptr->domain == IMC_DOMAIN_CORE)
+		core_imc_pmu = pmu_ptr;
+	else if (pmu_ptr->domain == IMC_DOMAIN_NEST)
+		per_nest_pmu_arr[pmu_index] = pmu_ptr;
 
 	/*
 	 * "events" property inside a PMU node contains the phandle value
@@ -355,7 +366,10 @@ static int imc_pmu_create(struct device_node *parent, int pmu_index)
 	}
 
 	/* Save the name to register it later */
-	sprintf(buf, "nest_%s", (char *)pp->value);
+	if (pmu_ptr->domain == IMC_DOMAIN_NEST)
+		sprintf(buf, "nest_%s", (char *)pp->value);
+	else
+		sprintf(buf, "%s_imc", (char *)pp->value);
 	pmu_ptr->pmu.name = (char *)buf;
 
 	/*
-- 
2.7.4

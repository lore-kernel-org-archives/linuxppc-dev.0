Return-Path: <hemant@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vRTDS6KYlzDqC0
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 20 Feb 2017 14:11:20 +1100 (AEDT)
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v1K39SG0008903
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 19 Feb 2017 22:11:18 -0500
Received: from e23smtp09.au.ibm.com (e23smtp09.au.ibm.com [202.81.31.142])
 by mx0b-001b2d01.pphosted.com with ESMTP id 28qr89g69n-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 19 Feb 2017 22:11:18 -0500
Received: from localhost
 by e23smtp09.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <hemant@linux.vnet.ibm.com>;
 Mon, 20 Feb 2017 13:11:15 +1000
Received: from d23relay10.au.ibm.com (d23relay10.au.ibm.com [9.190.26.77])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id C3ED42CE8059
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 20 Feb 2017 14:11:11 +1100 (EST)
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay10.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v1K3B3Df16449590
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 20 Feb 2017 14:11:11 +1100
Received: from d23av04.au.ibm.com (localhost [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v1K3Acir006956
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 20 Feb 2017 14:10:39 +1100
From: Hemant Kumar <hemant@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: linux-kernel@vger.kernel.org, Hemant Kumar <hemant@linux.vnet.ibm.com>,
 Madhavan Srinivasan <maddy@linux.vnet.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Anton Blanchard <anton@samba.org>,
 Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>,
 Michael Neuling <mikey@neuling.org>,
 Stewart Smith <stewart@linux.vnet.ibm.com>,
 Daniel Axtens <dja@axtens.net>, Stephane Eranian <eranian@google.com>,
 Balbir Singh <bsingharora@gmail.com>,
 Anju T Sudhakar <anju@linux.vnet.ibm.com>
Subject: [PATCH v4 07/10] powerpc/powernv: Core IMC events detection
Date: Mon, 20 Feb 2017 08:39:24 +0530
In-Reply-To: <1487560167-29357-1-git-send-email-hemant@linux.vnet.ibm.com>
References: <1487560167-29357-1-git-send-email-hemant@linux.vnet.ibm.com>
Message-Id: <1487560167-29357-8-git-send-email-hemant@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This patch adds support for detection of core IMC events along with the
Nest IMC events. It adds a new domain IMC_DOMAIN_CORE and its determined
with the help of the compatibility string "ibm,imc-counters-core" based
on the IMC device tree.

Cc: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Paul Mackerras <paulus@samba.org>
Cc: Anton Blanchard <anton@samba.org>
Cc: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
Cc: Michael Neuling <mikey@neuling.org>
Cc: Stewart Smith <stewart@linux.vnet.ibm.com>
Cc: Daniel Axtens <dja@axtens.net>
Cc: Stephane Eranian <eranian@google.com>
Cc: Balbir Singh <bsingharora@gmail.com>
Cc: Anju T Sudhakar <anju@linux.vnet.ibm.com>
Signed-off-by: Hemant Kumar <hemant@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/imc-pmu.h        |  2 ++
 arch/powerpc/perf/imc-pmu.c               |  3 +++
 arch/powerpc/platforms/powernv/opal-imc.c | 18 ++++++++++++++++--
 3 files changed, 21 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/include/asm/imc-pmu.h b/arch/powerpc/include/asm/imc-pmu.h
index 7b58721..59de083 100644
--- a/arch/powerpc/include/asm/imc-pmu.h
+++ b/arch/powerpc/include/asm/imc-pmu.h
@@ -30,6 +30,7 @@
 
 #define IMC_DTB_COMPAT		"ibm,opal-in-memory-counters"
 #define IMC_DTB_NEST_COMPAT	"ibm,imc-counters-nest"
+#define IMC_DTB_CORE_COMPAT	"ibm,imc-counters-core"
 
 /*
  * Structure to hold per chip specific memory address
@@ -67,6 +68,7 @@ struct imc_pmu {
  * Domains for IMC PMUs
  */
 #define IMC_DOMAIN_NEST		1
+#define IMC_DOMAIN_CORE		2
 
 #define UNKNOWN_DOMAIN		-1
 
diff --git a/arch/powerpc/perf/imc-pmu.c b/arch/powerpc/perf/imc-pmu.c
index e46ff6d..9a0e3bc 100644
--- a/arch/powerpc/perf/imc-pmu.c
+++ b/arch/powerpc/perf/imc-pmu.c
@@ -18,8 +18,11 @@ struct perchip_nest_info nest_perchip_info[IMC_MAX_CHIPS];
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
index a65aa2d..67ce873 100644
--- a/arch/powerpc/platforms/powernv/opal-imc.c
+++ b/arch/powerpc/platforms/powernv/opal-imc.c
@@ -33,10 +33,12 @@
 
 extern struct perchip_nest_info nest_perchip_info[IMC_MAX_CHIPS];
 extern struct imc_pmu *per_nest_pmu_arr[IMC_MAX_PMUS];
+extern struct imc_pmu *core_imc_pmu;
 
 extern int init_imc_pmu(struct imc_events *events,
 			int idx, struct imc_pmu *pmu_ptr);
 u64 nest_max_offset;
+u64 core_max_offset;
 
 static int imc_event_info(char *name, struct imc_events *events)
 {
@@ -80,6 +82,10 @@ static void update_max_value(u32 value, int pmu_domain)
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
@@ -231,6 +237,8 @@ int imc_get_domain(struct device_node *pmu_dev)
 {
 	if (of_device_is_compatible(pmu_dev, IMC_DTB_NEST_COMPAT))
 		return IMC_DOMAIN_NEST;
+	if (of_device_is_compatible(pmu_dev, IMC_DTB_CORE_COMPAT))
+		return IMC_DOMAIN_CORE;
 	else
 		return UNKNOWN_DOMAIN;
 }
@@ -298,7 +306,10 @@ static int imc_pmu_create(struct device_node *parent, int pmu_index)
 		goto free_pmu;
 
 	/* Needed for hotplug/migration */
-	per_nest_pmu_arr[pmu_index] = pmu_ptr;
+	if (pmu_ptr->domain == IMC_DOMAIN_CORE)
+		core_imc_pmu = pmu_ptr;
+	else if (pmu_ptr->domain == IMC_DOMAIN_NEST)
+		per_nest_pmu_arr[pmu_index] = pmu_ptr;
 
 	/*
 	 * "events" property inside a PMU node contains the phandle value
@@ -354,7 +365,10 @@ static int imc_pmu_create(struct device_node *parent, int pmu_index)
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

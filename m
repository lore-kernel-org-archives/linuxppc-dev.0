Return-Path: <maddy@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vkL0H4wR0zDqZ7
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 Mar 2017 18:37:19 +1100 (AEDT)
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v2G7SaoD038671
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 Mar 2017 03:37:11 -0400
Received: from e23smtp02.au.ibm.com (e23smtp02.au.ibm.com [202.81.31.144])
 by mx0b-001b2d01.pphosted.com with ESMTP id 297kjmyd7p-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 Mar 2017 03:37:11 -0400
Received: from localhost
 by e23smtp02.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <maddy@linux.vnet.ibm.com>;
 Thu, 16 Mar 2017 17:37:08 +1000
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay08.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v2G7aw9P39977036
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 Mar 2017 18:37:06 +1100
Received: from d23av04.au.ibm.com (localhost [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v2G7aXfB010499
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 Mar 2017 18:36:33 +1100
From: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
To: mpe@ellerman.id.au
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 Hemant Kumar <hemant@linux.vnet.ibm.com>,
 "Gautham R . Shenoy" <ego@linux.vnet.ibm.com>,
 Balbir Singh <bsingharora@gmail.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Anton Blanchard <anton@samba.org>,
 Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>,
 Michael Neuling <mikey@neuling.org>,
 Stewart Smith <stewart@linux.vnet.ibm.com>,
 Daniel Axtens <dja@axtens.net>, Stephane Eranian <eranian@google.com>,
 Anju T Sudhakar <anju@linux.vnet.ibm.com>,
 Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
Subject: [PATCH v5 09/13] powerpc/powernv: Thread IMC events detection
Date: Thu, 16 Mar 2017 13:05:03 +0530
In-Reply-To: <1489649707-8021-1-git-send-email-maddy@linux.vnet.ibm.com>
References: <1489649707-8021-1-git-send-email-maddy@linux.vnet.ibm.com>
Message-Id: <1489649707-8021-10-git-send-email-maddy@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Hemant Kumar <hemant@linux.vnet.ibm.com>

Patch adds support for detection of thread IMC events. It adds a new
domain IMC_DOMAIN_THREAD and it is determined with the help of the
compatibility string "ibm,imc-counters-thread" based on the IMC device
tree.

Cc: Gautham R. Shenoy <ego@linux.vnet.ibm.com>
Cc: Balbir Singh <bsingharora@gmail.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Paul Mackerras <paulus@samba.org>
Cc: Anton Blanchard <anton@samba.org>
Cc: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
Cc: Michael Neuling <mikey@neuling.org>
Cc: Stewart Smith <stewart@linux.vnet.ibm.com>
Cc: Daniel Axtens <dja@axtens.net>
Cc: Stephane Eranian <eranian@google.com>
Cc: Anju T Sudhakar <anju@linux.vnet.ibm.com>
Signed-off-by: Hemant Kumar <hemant@linux.vnet.ibm.com>
Signed-off-by: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/imc-pmu.h        |  2 ++
 arch/powerpc/perf/imc-pmu.c               |  1 +
 arch/powerpc/platforms/powernv/opal-imc.c | 11 +++++++++--
 3 files changed, 12 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/include/asm/imc-pmu.h b/arch/powerpc/include/asm/imc-pmu.h
index 5e76cd06d6d8..f2b4f122e6c2 100644
--- a/arch/powerpc/include/asm/imc-pmu.h
+++ b/arch/powerpc/include/asm/imc-pmu.h
@@ -32,6 +32,7 @@
 #define IMC_DTB_COMPAT		"ibm,opal-in-memory-counters"
 #define IMC_DTB_NEST_COMPAT	"ibm,imc-counters-nest"
 #define IMC_DTB_CORE_COMPAT	"ibm,imc-counters-core"
+#define IMC_DTB_THREAD_COMPAT   "ibm,imc-counters-thread"
 
 /*
  * Structure to hold per chip specific memory address
@@ -70,6 +71,7 @@ struct imc_pmu {
  */
 #define IMC_DOMAIN_NEST		1
 #define IMC_DOMAIN_CORE		2
+#define IMC_DOMAIN_THREAD       3
 
 #define UNKNOWN_DOMAIN		-1
 
diff --git a/arch/powerpc/perf/imc-pmu.c b/arch/powerpc/perf/imc-pmu.c
index 6d5fda9279c0..32eea6941e95 100644
--- a/arch/powerpc/perf/imc-pmu.c
+++ b/arch/powerpc/perf/imc-pmu.c
@@ -26,6 +26,7 @@ struct imc_pmu *core_imc_pmu;
 /* Needed for sanity check */
 extern u64 nest_max_offset;
 extern u64 core_max_offset;
+extern u64 thread_max_offset;
 
 PMU_FORMAT_ATTR(event, "config:0-20");
 static struct attribute *imc_format_attrs[] = {
diff --git a/arch/powerpc/platforms/powernv/opal-imc.c b/arch/powerpc/platforms/powernv/opal-imc.c
index 3d60549d006f..70f4b0924fae 100644
--- a/arch/powerpc/platforms/powernv/opal-imc.c
+++ b/arch/powerpc/platforms/powernv/opal-imc.c
@@ -39,6 +39,7 @@ extern int init_imc_pmu(struct imc_events *events,
 			int idx, struct imc_pmu *pmu_ptr);
 u64 nest_max_offset;
 u64 core_max_offset;
+u64 thread_max_offset;
 
 static int imc_event_info(char *name, struct imc_events *events)
 {
@@ -86,6 +87,10 @@ static void update_max_value(u32 value, int pmu_domain)
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
@@ -239,6 +244,8 @@ int imc_get_domain(struct device_node *pmu_dev)
 		return IMC_DOMAIN_NEST;
 	if (of_device_is_compatible(pmu_dev, IMC_DTB_CORE_COMPAT))
 		return IMC_DOMAIN_CORE;
+	if (of_device_is_compatible(pmu_dev, IMC_DTB_THREAD_COMPAT))
+		return IMC_DOMAIN_THREAD;
 	else
 		return UNKNOWN_DOMAIN;
 }
@@ -277,7 +284,7 @@ static void imc_free_events(struct imc_events *events, int nr_entries)
 /*
  * imc_pmu_create : Takes the parent device which is the pmu unit and a
  *                  pmu_index as the inputs.
- * Allocates memory for the pmu, sets up its domain (NEST or CORE), and
+ * Allocates memory for the pmu, sets up its domain (NEST/CORE/THREAD), and
  * allocates memory for the events supported by this pmu. Assigns a name for
  * the pmu. Calls imc_events_node_parser() to setup the individual events.
  * If everything goes fine, it calls, init_imc_pmu() to setup the pmu device
@@ -305,7 +312,7 @@ static int imc_pmu_create(struct device_node *parent, int pmu_index)
 	if (pmu_ptr->domain == UNKNOWN_DOMAIN)
 		goto free_pmu;
 
-	/* Needed for hotplug/migration */
+	/* Needed for hotplug/migration for nest and core IMC PMUs */
 	if (pmu_ptr->domain == IMC_DOMAIN_CORE)
 		core_imc_pmu = pmu_ptr;
 	else if (pmu_ptr->domain == IMC_DOMAIN_NEST)
-- 
2.7.4

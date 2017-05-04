Return-Path: <anju@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wJcf254G5zDqCL
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  5 May 2017 00:21:30 +1000 (AEST)
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v44EKZUw058659
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 4 May 2017 10:21:28 -0400
Received: from e23smtp02.au.ibm.com (e23smtp02.au.ibm.com [202.81.31.144])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2a810yf1cp-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 04 May 2017 10:21:27 -0400
Received: from localhost
 by e23smtp02.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <anju@linux.vnet.ibm.com>;
 Fri, 5 May 2017 00:21:25 +1000
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay07.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v44ELFWx58523842
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 5 May 2017 00:21:23 +1000
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v44EKi9N013280
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 5 May 2017 00:20:45 +1000
From: Anju T Sudhakar <anju@linux.vnet.ibm.com>
To: mpe@ellerman.id.au
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 ego@linux.vnet.ibm.com, bsingharora@gmail.com, anton@samba.org,
 sukadev@linux.vnet.ibm.com, mikey@neuling.org,
 stewart@linux.vnet.ibm.com, dja@axtens.net, eranian@google.com,
 hemant@linux.vnet.ibm.com, maddy@linux.vnet.ibm.com,
 anju@linux.vnet.ibm.com
Subject: [PATCH v8 08/10] powerpc/powernv: Thread IMC events detection
Date: Thu,  4 May 2017 19:49:54 +0530
In-Reply-To: <1493907596-11425-1-git-send-email-anju@linux.vnet.ibm.com>
References: <1493907596-11425-1-git-send-email-anju@linux.vnet.ibm.com>
Message-Id: <1493907596-11425-9-git-send-email-anju@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Patch adds support for detection of thread IMC events. It adds a new
domain IMC_DOMAIN_THREAD and it is determined with the help of the
compatibility string "ibm,imc-counters-thread" based on the IMC device
tree.

Signed-off-by: Anju T Sudhakar <anju@linux.vnet.ibm.com>
Signed-off-by: Hemant Kumar <hemant@linux.vnet.ibm.com>
Signed-off-by: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/imc-pmu.h        |  2 ++
 arch/powerpc/perf/imc-pmu.c               |  1 +
 arch/powerpc/platforms/powernv/opal-imc.c | 18 +++++++++++++++++-
 3 files changed, 20 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/include/asm/imc-pmu.h b/arch/powerpc/include/asm/imc-pmu.h
index bf5fb7c..6260e61 100644
--- a/arch/powerpc/include/asm/imc-pmu.h
+++ b/arch/powerpc/include/asm/imc-pmu.h
@@ -49,6 +49,7 @@
 #define IMC_DTB_COMPAT			"ibm,opal-in-memory-counters"
 #define IMC_DTB_NEST_COMPAT		"ibm,imc-counters-nest"
 #define IMC_DTB_CORE_COMPAT		"ibm,imc-counters-core"
+#define IMC_DTB_THREAD_COMPAT		"ibm,imc-counters-thread"
 
 /*
  * Structure to hold per chip specific memory address
@@ -98,6 +99,7 @@ struct imc_pmu {
  */
 #define IMC_DOMAIN_NEST		1
 #define IMC_DOMAIN_CORE		2
+#define IMC_DOMAIN_THREAD	3
 #define IMC_DOMAIN_UNKNOWN	-1
 
 #define IMC_COUNTER_ENABLE	1
diff --git a/arch/powerpc/perf/imc-pmu.c b/arch/powerpc/perf/imc-pmu.c
index fb71825..9767714 100644
--- a/arch/powerpc/perf/imc-pmu.c
+++ b/arch/powerpc/perf/imc-pmu.c
@@ -41,6 +41,7 @@ struct imc_pmu *core_imc_pmu;
 /* Needed for sanity check */
 extern u64 nest_max_offset;
 extern u64 core_max_offset;
+extern u64 thread_max_offset;
 
 PMU_FORMAT_ATTR(event, "config:0-20");
 static struct attribute *imc_format_attrs[] = {
diff --git a/arch/powerpc/platforms/powernv/opal-imc.c b/arch/powerpc/platforms/powernv/opal-imc.c
index 23507d7..940f6b9 100644
--- a/arch/powerpc/platforms/powernv/opal-imc.c
+++ b/arch/powerpc/platforms/powernv/opal-imc.c
@@ -35,6 +35,7 @@
 
 u64 nest_max_offset;
 u64 core_max_offset;
+u64 thread_max_offset;
 
 static int imc_event_prop_update(char *name, struct imc_events *events)
 {
@@ -119,6 +120,10 @@ static void update_max_value(u32 value, int pmu_domain)
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
@@ -362,7 +367,7 @@ static struct imc_events *imc_events_setup(struct device_node *parent,
 /*
  * imc_pmu_create : Takes the parent device which is the pmu unit and a
  *                  pmu_index as the inputs.
- * Allocates memory for the pmu, sets up its domain (NEST/CORE), and
+ * Allocates memory for the pmu, sets up its domain (NEST/CORE/THREAD), and
  * calls imc_events_setup() to allocate memory for the events supported
  * by this pmu. Assigns a name for the pmu. Calls imc_events_node_parser()
  * to setup the individual events.
@@ -483,6 +488,17 @@ static void __init imc_pmu_setup(struct device_node *parent)
 			return;
 		pmu_count++;
 	}
+	/*
+	 * Loop through the imc-counters tree for each compatible
+	 * "ibm,imc-counters-thread", and update "struct imc_pmu".
+	 */
+	for_each_compatible_node(child, NULL, IMC_DTB_THREAD_COMPAT) {
+		domain = IMC_DOMAIN_THREAD;
+		rc = imc_pmu_create(child, pmu_count, domain);
+		if (rc)
+			return;
+		pmu_count++;
+	}
 }
 
 static int opal_imc_counters_probe(struct platform_device *pdev)
-- 
2.7.4

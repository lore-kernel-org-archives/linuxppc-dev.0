Return-Path: <maddy@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vxZvb3gjpzDqKP
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  4 Apr 2017 00:57:15 +1000 (AEST)
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v33EsQia008420
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 3 Apr 2017 10:57:13 -0400
Received: from e23smtp08.au.ibm.com (e23smtp08.au.ibm.com [202.81.31.141])
 by mx0b-001b2d01.pphosted.com with ESMTP id 29kqbjw6bs-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 03 Apr 2017 10:57:11 -0400
Received: from localhost
 by e23smtp08.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <maddy@linux.vnet.ibm.com>;
 Tue, 4 Apr 2017 00:57:08 +1000
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay07.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v33EuwLR42008658
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 4 Apr 2017 00:57:06 +1000
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v33EuU8J026553
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 4 Apr 2017 00:56:30 +1000
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
Subject: [PATCH v6 09/11] powerpc/powernv: Thread IMC events detection
Date: Mon,  3 Apr 2017 20:25:06 +0530
In-Reply-To: <1491231308-15282-1-git-send-email-maddy@linux.vnet.ibm.com>
References: <1491231308-15282-1-git-send-email-maddy@linux.vnet.ibm.com>
Message-Id: <1491231308-15282-10-git-send-email-maddy@linux.vnet.ibm.com>
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

Signed-off-by: Anju T Sudhakar <anju@linux.vnet.ibm.com>
Signed-off-by: Hemant Kumar <hemant@linux.vnet.ibm.com>
Signed-off-by: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/imc-pmu.h        | 2 ++
 arch/powerpc/perf/imc-pmu.c               | 1 +
 arch/powerpc/platforms/powernv/opal-imc.c | 9 ++++++++-
 3 files changed, 11 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/include/asm/imc-pmu.h b/arch/powerpc/include/asm/imc-pmu.h
index 4aa63191456a..c63bc78fd6f6 100644
--- a/arch/powerpc/include/asm/imc-pmu.h
+++ b/arch/powerpc/include/asm/imc-pmu.h
@@ -29,6 +29,7 @@
 #define IMC_DTB_COMPAT			"ibm,opal-in-memory-counters"
 #define IMC_DTB_NEST_COMPAT		"ibm,imc-counters-nest"
 #define IMC_DTB_CORE_COMPAT		"ibm,imc-counters-core"
+#define IMC_DTB_THREAD_COMPAT		"ibm,imc-counters-thread"
 
 /*
  * Structure to hold per chip specific memory address
@@ -67,6 +68,7 @@ struct imc_pmu {
  */
 #define IMC_DOMAIN_NEST		1
 #define IMC_DOMAIN_CORE		2
+#define IMC_DOMAIN_THREAD	3
 #define IMC_DOMAIN_UNKNOWN	-1
 
 int imc_get_domain(struct device_node *pmu_dev);
diff --git a/arch/powerpc/perf/imc-pmu.c b/arch/powerpc/perf/imc-pmu.c
index 45f9b35142a7..35b3564747e2 100644
--- a/arch/powerpc/perf/imc-pmu.c
+++ b/arch/powerpc/perf/imc-pmu.c
@@ -33,6 +33,7 @@ struct imc_pmu *core_imc_pmu;
 /* Needed for sanity check */
 extern u64 nest_max_offset;
 extern u64 core_max_offset;
+extern u64 thread_max_offset;
 
 PMU_FORMAT_ATTR(event, "config:0-20");
 static struct attribute *imc_format_attrs[] = {
diff --git a/arch/powerpc/platforms/powernv/opal-imc.c b/arch/powerpc/platforms/powernv/opal-imc.c
index f261fc933959..ac625cf13875 100644
--- a/arch/powerpc/platforms/powernv/opal-imc.c
+++ b/arch/powerpc/platforms/powernv/opal-imc.c
@@ -40,6 +40,7 @@ extern int init_imc_pmu(struct imc_events *events,
 			int idx, struct imc_pmu *pmu_ptr);
 u64 nest_max_offset;
 u64 core_max_offset;
+u64 thread_max_offset;
 
 static int imc_event_info(char *name, struct imc_events *events)
 {
@@ -87,6 +88,10 @@ static void update_max_value(u32 value, int pmu_domain)
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
@@ -240,6 +245,8 @@ int imc_get_domain(struct device_node *pmu_dev)
 		return IMC_DOMAIN_NEST;
 	if (of_device_is_compatible(pmu_dev, IMC_DTB_CORE_COMPAT))
 		return IMC_DOMAIN_CORE;
+	if (of_device_is_compatible(pmu_dev, IMC_DTB_THREAD_COMPAT))
+		return IMC_DOMAIN_THREAD;
 	else
 		return IMC_DOMAIN_UNKNOWN;
 }
@@ -278,7 +285,7 @@ static void imc_free_events(struct imc_events *events, int nr_entries)
 /*
  * imc_pmu_create : Takes the parent device which is the pmu unit and a
  *                  pmu_index as the inputs.
- * Allocates memory for the pmu, sets up its domain (NEST or CORE), and
+ * Allocates memory for the pmu, sets up its domain (NEST/CORE/THREAD), and
  * allocates memory for the events supported by this pmu. Assigns a name for
  * the pmu. Calls imc_events_node_parser() to setup the individual events.
  * If everything goes fine, it calls, init_imc_pmu() to setup the pmu device
-- 
2.7.4

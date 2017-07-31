Return-Path: <maddy@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xLZ6c6CsSzDsR6
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 31 Jul 2017 19:34:48 +1000 (AEST)
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 v6V9XpeZ049384
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 31 Jul 2017 05:34:46 -0400
Received: from e23smtp06.au.ibm.com (e23smtp06.au.ibm.com [202.81.31.148])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2c21ew9jmr-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 31 Jul 2017 05:34:46 -0400
Received: from localhost
 by e23smtp06.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <maddy@linux.vnet.ibm.com>;
 Mon, 31 Jul 2017 19:34:43 +1000
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay09.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v6V9XOLE31785178
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 31 Jul 2017 19:33:24 +1000
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v6V9XF8h019306
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 31 Jul 2017 19:33:15 +1000
From: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
To: mpe@ellerman.id.au
Cc: linuxppc-dev@lists.ozlabs.org,
 Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
Subject: [PATCH] powerpc/perf: Add PM_LD_MISS_L1 and PM_BR_2PATH to power9
 event list
Date: Mon, 31 Jul 2017 15:03:21 +0530
Message-Id: <1501493601-12317-1-git-send-email-maddy@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Add couple of more events (PM_LD_MISS_L1 and PM_BR_2PATH) to
power9 event list and power9_event_alternatives array (these
events can be counted in more than one PMC).

Signed-off-by: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
---
 arch/powerpc/perf/power9-events-list.h | 8 ++++++++
 arch/powerpc/perf/power9-pmu.c         | 2 ++
 2 files changed, 10 insertions(+)

diff --git a/arch/powerpc/perf/power9-events-list.h b/arch/powerpc/perf/power9-events-list.h
index 50689180a6c1..c5ed95d8f976 100644
--- a/arch/powerpc/perf/power9-events-list.h
+++ b/arch/powerpc/perf/power9-events-list.h
@@ -23,6 +23,9 @@ EVENT(PM_BR_MPRED_CMPL,				0x400f6)
 EVENT(PM_LD_REF_L1,				0x100fc)
 /* Load Missed L1 */
 EVENT(PM_LD_MISS_L1_FIN,			0x2c04e)
+EVENT(PM_LD_MISS_L1,				0x3e054)
+/* Alternate event code for PM_LD_MISS_L1 */
+EVENT(PM_LD_MISS_L1_ALT,			0x400f0)
 /* Store Missed L1 */
 EVENT(PM_ST_MISS_L1,				0x300f0)
 /* L1 cache data prefetches */
@@ -62,3 +65,8 @@ EVENT(PM_INST_DISP,				0x200f2)
 EVENT(PM_INST_DISP_ALT,				0x300f2)
 /* Alternate Branch event code */
 EVENT(PM_BR_CMPL_ALT,				0x10012)
+/* Branch event that are not strongly biased */
+EVENT(PM_BR_2PATH,				0x20036)
+/* ALternate branch event that are not strongly biased */
+EVENT(PM_BR_2PATH_ALT,				0x40036)
+
diff --git a/arch/powerpc/perf/power9-pmu.c b/arch/powerpc/perf/power9-pmu.c
index 805bdfcb38ec..ed92159adf3e 100644
--- a/arch/powerpc/perf/power9-pmu.c
+++ b/arch/powerpc/perf/power9-pmu.c
@@ -109,6 +109,8 @@ static const unsigned int power9_event_alternatives[][MAX_ALT] = {
 	{ PM_INST_DISP,			PM_INST_DISP_ALT },
 	{ PM_RUN_CYC_ALT,		PM_RUN_CYC },
 	{ PM_RUN_INST_CMPL_ALT,		PM_RUN_INST_CMPL },
+	{ PM_LD_MISS_L1,		PM_LD_MISS_L1_ALT },
+	{ PM_BR_2PATH,			PM_BR_2PATH_ALT },
 };
 
 static int power9_get_alternatives(u64 event, unsigned int flags, u64 alt[])
-- 
2.7.4

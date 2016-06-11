Return-Path: <maddy@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rRVlW3kWjzDqHF
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 11 Jun 2016 17:19:03 +1000 (AEST)
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u5B7ISTl107916
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 11 Jun 2016 03:18:59 -0400
Received: from e23smtp06.au.ibm.com (e23smtp06.au.ibm.com [202.81.31.148])
 by mx0a-001b2d01.pphosted.com with ESMTP id 23g1e5ycd5-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 11 Jun 2016 03:18:59 -0400
Received: from localhost
 by e23smtp06.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <maddy@linux.vnet.ibm.com>;
 Sat, 11 Jun 2016 17:18:57 +1000
Received: from d23relay09.au.ibm.com (d23relay09.au.ibm.com [9.185.63.181])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id 9650C2CE8046
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 11 Jun 2016 17:18:43 +1000 (EST)
Received: from d23av06.au.ibm.com (d23av06.au.ibm.com [9.190.235.151])
 by d23relay09.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u5B7IXhO55377982
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 11 Jun 2016 17:18:33 +1000
Received: from d23av06.au.ibm.com (localhost [127.0.0.1])
 by d23av06.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u5B7IWtX025357
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 11 Jun 2016 17:18:33 +1000
From: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
To: mpe@ellerman.id.au
Cc: linuxppc-dev@lists.ozlabs.org, mikey@ozlabs.au.ibm.com,
 Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
Subject: [PATCH 2/4] powerpc/perf: Add power9 event list macros for generic
 and cache events
Date: Sat, 11 Jun 2016 12:48:13 +0530
In-Reply-To: <1465629495-17166-1-git-send-email-maddy@linux.vnet.ibm.com>
References: <1465629495-17166-1-git-send-email-maddy@linux.vnet.ibm.com>
Message-Id: <1465629495-17166-2-git-send-email-maddy@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Add macros for the generic and cache events on Power9

Signed-off-by: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
---
 arch/powerpc/perf/power9-events-list.h | 55 ++++++++++++++++++++++++++++++++++
 1 file changed, 55 insertions(+)
 create mode 100644 arch/powerpc/perf/power9-events-list.h

diff --git a/arch/powerpc/perf/power9-events-list.h b/arch/powerpc/perf/power9-events-list.h
new file mode 100644
index 000000000000..cda6fcb809ca
--- /dev/null
+++ b/arch/powerpc/perf/power9-events-list.h
@@ -0,0 +1,55 @@
+/*
+ * Performance counter support for POWER9 processors.
+ *
+ * Copyright 2016 Madhavan Srinivasan, IBM Corporation.
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version
+ * 2 of the License, or (at your option) any later version.
+ */
+
+/*
+ * Power9 event codes.
+ */
+EVENT(PM_CYC,					0x0001e)
+EVENT(PM_ICT_NOSLOT_CYC,			0x100f8)
+EVENT(PM_CMPLU_STALL,				0x1e054)
+EVENT(PM_INST_CMPL,				0x00002)
+EVENT(PM_BRU_CMPL,				0x40060)
+EVENT(PM_BR_MPRED_CMPL,				0x400f6)
+
+/* All L1 D cache load references counted at finish, gated by reject */
+EVENT(PM_LD_REF_L1,				0x100fc)
+/* Load Missed L1 */
+EVENT(PM_LD_MISS_L1_FIN,			0x2c04e)
+/* Store Missed L1 */
+EVENT(PM_ST_MISS_L1,				0x300f0)
+/* L1 cache data prefetches */
+EVENT(PM_L1_PREF,				0x20054)
+/* Instruction fetches from L1 */
+EVENT(PM_INST_FROM_L1,				0x04080)
+/* Demand iCache Miss */
+EVENT(PM_L1_ICACHE_MISS,			0x200fd)
+/* Instruction Demand sectors wriittent into IL1 */
+EVENT(PM_L1_DEMAND_WRITE,			0x0408c)
+/* Instruction prefetch written into IL1 */
+EVENT(PM_IC_PREF_WRITE,				0x0408e)
+/* The data cache was reloaded from local core's L3 due to a demand load */
+EVENT(PM_DATA_FROM_L3,				0x4c042)
+/* Demand LD - L3 Miss (not L2 hit and not L3 hit) */
+EVENT(PM_DATA_FROM_L3MISS,			0x300fe)
+/* All successful D-side store dispatches for this thread */
+EVENT(PM_L2_ST,					0x16081)
+/* All successful D-side store dispatches for this thread that were L2 Miss */
+EVENT(PM_L2_ST_MISS,				0x26081)
+/* Total HW L3 prefetches(Load+store) */
+EVENT(PM_L3_PREF_ALL,				0x4e052)
+/* Data PTEG reload */
+EVENT(PM_DTLB_MISS,				0x300fc)
+/* ITLB Reloaded */
+EVENT(PM_ITLB_MISS,				0x400fc)
+/* Run_Instructions */
+EVENT(PM_RUN_INST_CMPL,				0x500fa)
+/* Run_cycles */
+EVENT(PM_RUN_CYC,				0x600f4)
-- 
1.9.1

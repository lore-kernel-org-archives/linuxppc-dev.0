Return-Path: <maddy@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vLz6f2HXVzDqBN
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 13 Feb 2017 06:20:42 +1100 (AEDT)
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v1CJJ6l2053558
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 12 Feb 2017 14:20:39 -0500
Received: from e28smtp05.in.ibm.com (e28smtp05.in.ibm.com [125.16.236.5])
 by mx0a-001b2d01.pphosted.com with ESMTP id 28hyg18erd-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 12 Feb 2017 14:20:38 -0500
Received: from localhost
 by e28smtp05.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <maddy@linux.vnet.ibm.com>;
 Mon, 13 Feb 2017 00:50:35 +0530
Received: from d28relay06.in.ibm.com (d28relay06.in.ibm.com [9.184.220.150])
 by d28dlp02.in.ibm.com (Postfix) with ESMTP id 4E7AF394004E
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 13 Feb 2017 00:50:33 +0530 (IST)
Received: from d28av01.in.ibm.com (d28av01.in.ibm.com [9.184.220.63])
 by d28relay06.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v1CJKXC27274750
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 13 Feb 2017 00:50:33 +0530
Received: from d28av01.in.ibm.com (localhost [127.0.0.1])
 by d28av01.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v1CJKWs7005297
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 13 Feb 2017 00:50:32 +0530
From: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
To: mpe@ellerman.id.au
Cc: linuxppc-dev@lists.ozlabs.org,
 Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
Subject: [PATCH v2] powerpc/perf: Add constraints for power9 l2/l3 bus events
Date: Mon, 13 Feb 2017 00:50:23 +0530
Message-Id: <1486927223-29590-1-git-send-email-maddy@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

In Power9, L2/L3 bus events are always available as a
"bank" of 4 events. To obtain the counts for any of the
l2/l3 bus events in a given bank, the user will have to
program PMC4 with corresponding l2/l3 bus event for that
bank. Patch add a mask and a new pass to updates the mask
for each PMU used by L2/L3 bus events and checks the mask
to enforce it.

Signed-off-by: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
---
Changelog v1:
Removed the callback and added a new pass

 arch/powerpc/perf/isa207-common.c | 20 +++++++++++++++++++-
 1 file changed, 19 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/perf/isa207-common.c b/arch/powerpc/perf/isa207-common.c
index 50e598cf644b..ce12e93dbd16 100644
--- a/arch/powerpc/perf/isa207-common.c
+++ b/arch/powerpc/perf/isa207-common.c
@@ -219,7 +219,7 @@ int isa207_compute_mmcr(u64 event[], int n_ev,
 			       struct perf_event *pevents[])
 {
 	unsigned long mmcra, mmcr1, mmcr2, unit, combine, psel, cache, val;
-	unsigned int pmc, pmc_inuse;
+	unsigned int pmc, pmc_inuse, mask=0;
 	int i;
 
 	pmc_inuse = 0;
@@ -312,6 +312,24 @@ int isa207_compute_mmcr(u64 event[], int n_ev,
 		hwc[i] = pmc - 1;
 	}
 
+/*
+ * Pass 3: to Check for l2/l3 bus event rule. PMC4
+ * must be programmed to use L2/L3 bus events in any other PMC[1/2/3]s
+ */
+	if (cpu_has_feature(CPU_FTR_ARCH_300)) {
+		for (i = 0; i < n_ev; ++i) {
+			pmc     = (event[i] >> EVENT_PMC_SHIFT) & EVENT_PMC_MASK;
+			unit    = (event[i] >> EVENT_UNIT_SHIFT) & EVENT_UNIT_MASK;
+			if (unit >= 6 && unit <= 9)
+				mask |= 1 << (pmc - 1);
+		}
+
+		if ((mask) && ((mask & 0xf) < 0x8)) {
+			printk(KERN_ERR "Missing PMC4 L2/L3 Bus event\n");
+			return -1;
+		}
+	}
+
 	/* Return MMCRx values */
 	mmcr[0] = 0;
 
-- 
2.7.4

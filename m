Return-Path: <sukadev@linux.vnet.ibm.com>
Received: from e9.ny.us.ibm.com (e9.ny.us.ibm.com [32.97.182.139])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e9.ny.us.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id D0DC12C015D
 for <linuxppc-dev@ozlabs.org>; Sat, 14 Sep 2013 10:49:24 +1000 (EST)
Received: from /spool/local
 by e9.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <sukadev@linux.vnet.ibm.com>;
 Fri, 13 Sep 2013 20:49:21 -0400
Received: from b01cxnp22034.gho.pok.ibm.com (b01cxnp22034.gho.pok.ibm.com
 [9.57.198.24])
 by d01dlp02.pok.ibm.com (Postfix) with ESMTP id 738A76E803F
 for <linuxppc-dev@ozlabs.org>; Fri, 13 Sep 2013 20:49:18 -0400 (EDT)
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
 by b01cxnp22034.gho.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r8E0nImu47710370
 for <linuxppc-dev@ozlabs.org>; Sat, 14 Sep 2013 00:49:18 GMT
Received: from d01av02.pok.ibm.com (loopback [127.0.0.1])
 by d01av02.pok.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r8E0nHBl001389
 for <linuxppc-dev@ozlabs.org>; Fri, 13 Sep 2013 21:49:18 -0300
From: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
To: <linux-kernel@vger.kernel.org>
Subject: [PATCH 1/8][v4] powerpc/perf: Rename Power8 macros to start with PME
Date: Fri, 13 Sep 2013 17:49:08 -0700
Message-Id: <1379119755-21025-2-git-send-email-sukadev@linux.vnet.ibm.com>
In-Reply-To: <1379119755-21025-1-git-send-email-sukadev@linux.vnet.ibm.com>
References: <1379119755-21025-1-git-send-email-sukadev@linux.vnet.ibm.com>
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>,
 Michael Ellerman <michaele@au1.ibm.com>, Stephane Eranian <eranian@google.com>,
 Anshuman Khandual <khandual@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

We use helpers like GENERIC_EVENT_ATTR() to list the generic events in
sysfs. To avoid name collisions, GENERIC_EVENT_ATTR() requires the perf
event macros to start with PME.

Signed-off-by: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
---
 arch/powerpc/perf/power8-pmu.c |   24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/arch/powerpc/perf/power8-pmu.c b/arch/powerpc/perf/power8-pmu.c
index 96a64d6..30c6b12 100644
--- a/arch/powerpc/perf/power8-pmu.c
+++ b/arch/powerpc/perf/power8-pmu.c
@@ -18,12 +18,12 @@
 /*
  * Some power8 event codes.
  */
-#define PM_CYC				0x0001e
-#define PM_GCT_NOSLOT_CYC		0x100f8
-#define PM_CMPLU_STALL			0x4000a
-#define PM_INST_CMPL			0x00002
-#define PM_BRU_FIN			0x10068
-#define PM_BR_MPRED_CMPL		0x400f6
+#define PME_PM_CYC				0x0001e
+#define PME_PM_GCT_NOSLOT_CYC			0x100f8
+#define PME_PM_CMPLU_STALL			0x4000a
+#define PME_PM_INST_CMPL			0x00002
+#define PME_PM_BRU_FIN				0x10068
+#define PME_PM_BR_MPRED_CMPL			0x400f6
 
 
 /*
@@ -550,12 +550,12 @@ static const struct attribute_group *power8_pmu_attr_groups[] = {
 };
 
 static int power8_generic_events[] = {
-	[PERF_COUNT_HW_CPU_CYCLES] =			PM_CYC,
-	[PERF_COUNT_HW_STALLED_CYCLES_FRONTEND] =	PM_GCT_NOSLOT_CYC,
-	[PERF_COUNT_HW_STALLED_CYCLES_BACKEND] =	PM_CMPLU_STALL,
-	[PERF_COUNT_HW_INSTRUCTIONS] =			PM_INST_CMPL,
-	[PERF_COUNT_HW_BRANCH_INSTRUCTIONS] =		PM_BRU_FIN,
-	[PERF_COUNT_HW_BRANCH_MISSES] =			PM_BR_MPRED_CMPL,
+	[PERF_COUNT_HW_CPU_CYCLES] =			PME_PM_CYC,
+	[PERF_COUNT_HW_STALLED_CYCLES_FRONTEND] =	PME_PM_GCT_NOSLOT_CYC,
+	[PERF_COUNT_HW_STALLED_CYCLES_BACKEND] =	PME_PM_CMPLU_STALL,
+	[PERF_COUNT_HW_INSTRUCTIONS] =			PME_PM_INST_CMPL,
+	[PERF_COUNT_HW_BRANCH_INSTRUCTIONS] =		PME_PM_BRU_FIN,
+	[PERF_COUNT_HW_BRANCH_MISSES] =			PME_PM_BR_MPRED_CMPL,
 };
 
 static u64 power8_bhrb_filter_map(u64 branch_sample_type)
-- 
1.7.9.5

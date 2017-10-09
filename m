Return-Path: <maddy@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3y9hzR5Ls9zDr4w
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Oct 2017 01:13:07 +1100 (AEDT)
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 v99ECj9D095785
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 9 Oct 2017 10:13:05 -0400
Received: from e06smtp14.uk.ibm.com (e06smtp14.uk.ibm.com [195.75.94.110])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2dg7fkmvqk-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 09 Oct 2017 10:13:04 -0400
Received: from localhost
 by e06smtp14.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <maddy@linux.vnet.ibm.com>;
 Mon, 9 Oct 2017 15:13:02 +0100
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v99ECvNA5636244
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 9 Oct 2017 14:12:58 GMT
Received: from d23av03.au.ibm.com (localhost [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v99ECmDx011220
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Oct 2017 01:12:49 +1100
From: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
To: mpe@ellerman.id.au
Cc: linuxppc-dev@lists.ozlabs.org,
 Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
Subject: [PATCH v2 2/2] powerpc/perf: Fix unit_sel/cache_sel checks
Date: Mon,  9 Oct 2017 19:42:40 +0530
In-Reply-To: <1507558360-27145-1-git-send-email-maddy@linux.vnet.ibm.com>
References: <1507558360-27145-1-git-send-email-maddy@linux.vnet.ibm.com>
Message-Id: <1507558360-27145-2-git-send-email-maddy@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Raw event code has couple of fields "unit" and "cache" in it, to capture
the "unit" to monitor for a given pmcxsel and cache reload qualifier to
program in MMCR1.

isa207_get_constraint() refers "unit" field to update the MMCRC (L2/L3)
Event bus control fields with "cache" bits of the raw event code.
These are power8 specific and not supported by PowerISA v3.0 pmu. So wrap
the checks to be power8 specific. Also, "cache" bit field is referred to
update MMCR1[16:17] and this check can be power8 specific.

Fixes: 7ffd948fae4cd ('powerpc/perf: factor out power8 pmu functions')
Signed-off-by: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
---
These changes should not have any impact since none of the published events
in power9 pmu-event json use the "cache" fields.

Changelog v1:
- Cleanup previously used macro
- Update the constraint check

 arch/powerpc/perf/isa207-common.c | 25 ++++++++++++++++++-------
 arch/powerpc/perf/isa207-common.h |  4 ++--
 2 files changed, 20 insertions(+), 9 deletions(-)

diff --git a/arch/powerpc/perf/isa207-common.c b/arch/powerpc/perf/isa207-common.c
index 2efee3f196f5..9fd2e5c7a063 100644
--- a/arch/powerpc/perf/isa207-common.c
+++ b/arch/powerpc/perf/isa207-common.c
@@ -150,6 +150,14 @@ static bool is_thresh_cmp_valid(u64 event)
 	return true;
 }
 
+static unsigned int dc_ic_rld_quad_l1_sel(u64 event)
+{
+	unsigned int cache;
+
+	cache = (event >> EVENT_CACHE_SEL_SHIFT) & MMCR1_DC_IC_QUAL_MASK;
+	return cache;
+}
+
 static inline u64 isa207_find_source(u64 idx, u32 sub_idx)
 {
 	u64 ret = PERF_MEM_NA;
@@ -285,10 +293,10 @@ int isa207_get_constraint(u64 event, unsigned long *maskp, unsigned long *valp)
 		 * have a cache selector of zero. The bank selector (bit 3) is
 		 * irrelevant, as long as the rest of the value is 0.
 		 */
-		if (cache & 0x7)
+		if (!cpu_has_feature(CPU_FTR_ARCH_300) && (cache & 0x7))
 			return -1;
 
-	} else if (event & EVENT_IS_L1) {
+	} else if (cpu_has_feature(CPU_FTR_ARCH_300) || (event & EVENT_IS_L1)) {
 		mask  |= CNST_L1_QUAL_MASK;
 		value |= CNST_L1_QUAL_VAL(cache);
 	}
@@ -391,11 +399,14 @@ int isa207_compute_mmcr(u64 event[], int n_ev,
 		/* In continuous sampling mode, update SDAR on TLB miss */
 		mmcra_sdar_mode(event[i], &mmcra);
 
-		if (event[i] & EVENT_IS_L1) {
-			cache = event[i] >> EVENT_CACHE_SEL_SHIFT;
-			mmcr1 |= (cache & 1) << MMCR1_IC_QUAL_SHIFT;
-			cache >>= 1;
-			mmcr1 |= (cache & 1) << MMCR1_DC_QUAL_SHIFT;
+		if (cpu_has_feature(CPU_FTR_ARCH_300)) {
+			cache = dc_ic_rld_quad_l1_sel(event[i]);
+			mmcr1 |= (cache) << MMCR1_DC_IC_QUAL_SHIFT;
+		} else {
+			if (event[i] & EVENT_IS_L1) {
+				cache = dc_ic_rld_quad_l1_sel(event[i]);
+				mmcr1 |= (cache) << MMCR1_DC_IC_QUAL_SHIFT;
+			}
 		}
 
 		if (is_event_marked(event[i])) {
diff --git a/arch/powerpc/perf/isa207-common.h b/arch/powerpc/perf/isa207-common.h
index 6c737d675792..493e5cc5fa8a 100644
--- a/arch/powerpc/perf/isa207-common.h
+++ b/arch/powerpc/perf/isa207-common.h
@@ -232,8 +232,8 @@
 #define MMCR1_COMBINE_SHIFT(pmc)	(35 - ((pmc) - 1))
 #define MMCR1_PMCSEL_SHIFT(pmc)		(24 - (((pmc) - 1)) * 8)
 #define MMCR1_FAB_SHIFT			36
-#define MMCR1_DC_QUAL_SHIFT		47
-#define MMCR1_IC_QUAL_SHIFT		46
+#define MMCR1_DC_IC_QUAL_MASK		0x3
+#define MMCR1_DC_IC_QUAL_SHIFT		46
 
 /* MMCR1 Combine bits macro for power9 */
 #define p9_MMCR1_COMBINE_SHIFT(pmc)	(38 - ((pmc - 1) * 2))
-- 
2.7.4

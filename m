Return-Path: <yao.jin@linux.intel.com>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vzkZZ6XcrzDqHg
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  7 Apr 2017 12:49:58 +1000 (AEST)
From: Jin Yao <yao.jin@linux.intel.com>
To: acme@kernel.org, jolsa@kernel.org, peterz@infradead.org, mingo@redhat.com,
 alexander.shishkin@linux.intel.com
Cc: Linux-kernel@vger.kernel.org, ak@linux.intel.com, kan.liang@intel.com,
 yao.jin@intel.com, linuxppc-dev@lists.ozlabs.org,
 Jin Yao <yao.jin@linux.intel.com>
Subject: [PATCH v2 2/5] perf/x86/intel: Record branch type
Date: Fri,  7 Apr 2017 18:47:43 +0800
Message-Id: <1491562066-7472-3-git-send-email-yao.jin@linux.intel.com>
In-Reply-To: <1491562066-7472-1-git-send-email-yao.jin@linux.intel.com>
References: <1491562066-7472-1-git-send-email-yao.jin@linux.intel.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Perf already has support for disassembling the branch instruction
and using the branch type for filtering. The patch just records
the branch type in perf_branch_entry.

Before recording, the patch converts the x86 branch classification
to common branch classification and compute for checking if the
branches cross 4K or 2MB areas. It's an approximate computing for
crossing 4K page or 2MB page.

Signed-off-by: Jin Yao <yao.jin@linux.intel.com>
---
 arch/x86/events/intel/lbr.c | 106 +++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 105 insertions(+), 1 deletion(-)

diff --git a/arch/x86/events/intel/lbr.c b/arch/x86/events/intel/lbr.c
index 81b321a..635a0fb 100644
--- a/arch/x86/events/intel/lbr.c
+++ b/arch/x86/events/intel/lbr.c
@@ -109,6 +109,9 @@ enum {
 	X86_BR_ZERO_CALL	= 1 << 15,/* zero length call */
 	X86_BR_CALL_STACK	= 1 << 16,/* call stack */
 	X86_BR_IND_JMP		= 1 << 17,/* indirect jump */
+
+	X86_BR_TYPE_SAVE	= 1 << 18,/* indicate to save branch type */
+
 };
 
 #define X86_BR_PLM (X86_BR_USER | X86_BR_KERNEL)
@@ -139,6 +142,9 @@ enum {
 	 X86_BR_IRQ		|\
 	 X86_BR_INT)
 
+#define AREA_4K		4096
+#define AREA_2M		(2 * 1024 * 1024)
+
 static void intel_pmu_lbr_filter(struct cpu_hw_events *cpuc);
 
 /*
@@ -670,6 +676,10 @@ static int intel_pmu_setup_sw_lbr_filter(struct perf_event *event)
 
 	if (br_type & PERF_SAMPLE_BRANCH_CALL)
 		mask |= X86_BR_CALL | X86_BR_ZERO_CALL;
+
+	if (br_type & PERF_SAMPLE_BRANCH_TYPE_SAVE)
+		mask |= X86_BR_TYPE_SAVE;
+
 	/*
 	 * stash actual user request into reg, it may
 	 * be used by fixup code for some CPU
@@ -923,6 +933,84 @@ static int branch_type(unsigned long from, unsigned long to, int abort)
 	return ret;
 }
 
+static int
+common_branch_type(int type, u64 from, u64 to)
+{
+	int ret;
+
+	type = type & (~(X86_BR_KERNEL | X86_BR_USER));
+
+	switch (type) {
+	case X86_BR_CALL:
+	case X86_BR_ZERO_CALL:
+		ret = PERF_BR_CALL;
+		break;
+
+	case X86_BR_RET:
+		ret = PERF_BR_RET;
+		break;
+
+	case X86_BR_SYSCALL:
+		ret = PERF_BR_SYSCALL;
+		break;
+
+	case X86_BR_SYSRET:
+		ret = PERF_BR_SYSRET;
+		break;
+
+	case X86_BR_INT:
+		ret = PERF_BR_INT;
+		break;
+
+	case X86_BR_IRET:
+		ret = PERF_BR_IRET;
+		break;
+
+	case X86_BR_IRQ:
+		ret = PERF_BR_IRQ;
+		break;
+
+	case X86_BR_ABORT:
+		ret = PERF_BR_FAR_BRANCH;
+		break;
+
+	case X86_BR_JCC:
+		if (to > from)
+			ret = PERF_BR_JCC_FWD;
+		else
+			ret = PERF_BR_JCC_BWD;
+		break;
+
+	case X86_BR_JMP:
+		ret = PERF_BR_JMP;
+		break;
+
+	case X86_BR_IND_CALL:
+		ret = PERF_BR_IND_CALL;
+		break;
+
+	case X86_BR_IND_JMP:
+		ret = PERF_BR_IND_JMP;
+		break;
+
+	default:
+		ret = PERF_BR_NONE;
+	}
+
+	return ret;
+}
+
+static bool
+cross_area(u64 addr1, u64 addr2, int size)
+{
+	u64 align1, align2;
+
+	align1 = addr1 & ~(size - 1);
+	align2 = addr2 & ~(size - 1);
+
+	return (align1 != align2) ? true : false;
+}
+
 /*
  * implement actual branch filter based on user demand.
  * Hardware may not exactly satisfy that request, thus
@@ -939,7 +1027,8 @@ intel_pmu_lbr_filter(struct cpu_hw_events *cpuc)
 	bool compress = false;
 
 	/* if sampling all branches, then nothing to filter */
-	if ((br_sel & X86_BR_ALL) == X86_BR_ALL)
+	if (((br_sel & X86_BR_ALL) == X86_BR_ALL) &&
+	    ((br_sel & X86_BR_TYPE_SAVE) != X86_BR_TYPE_SAVE))
 		return;
 
 	for (i = 0; i < cpuc->lbr_stack.nr; i++) {
@@ -960,6 +1049,21 @@ intel_pmu_lbr_filter(struct cpu_hw_events *cpuc)
 			cpuc->lbr_entries[i].from = 0;
 			compress = true;
 		}
+
+		if ((br_sel & X86_BR_TYPE_SAVE) == X86_BR_TYPE_SAVE) {
+			cpuc->lbr_entries[i].type = common_branch_type(type,
+								       from,
+								       to);
+			if (cross_area(from, to, AREA_2M))
+				cpuc->lbr_entries[i].cross = PERF_BR_CROSS_2M;
+			else if (cross_area(from, to, AREA_4K))
+				cpuc->lbr_entries[i].cross = PERF_BR_CROSS_4K;
+			else
+				cpuc->lbr_entries[i].cross = PERF_BR_CROSS_NONE;
+		} else {
+			cpuc->lbr_entries[i].type = PERF_BR_NONE;
+			cpuc->lbr_entries[i].cross = PERF_BR_CROSS_NONE;
+		}
 	}
 
 	if (!compress)
-- 
2.7.4

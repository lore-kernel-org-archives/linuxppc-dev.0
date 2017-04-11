Return-Path: <yao.jin@linux.intel.com>
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3w2BZn35nZzDq9H
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 11 Apr 2017 12:58:41 +1000 (AEST)
From: Jin Yao <yao.jin@linux.intel.com>
To: acme@kernel.org, jolsa@kernel.org, peterz@infradead.org, mingo@redhat.com,
 alexander.shishkin@linux.intel.com
Cc: Linux-kernel@vger.kernel.org, ak@linux.intel.com, kan.liang@intel.com,
 yao.jin@intel.com, linuxppc-dev@lists.ozlabs.org,
 Jin Yao <yao.jin@linux.intel.com>
Subject: [PATCH v3 2/5] perf/x86/intel: Record branch type
Date: Tue, 11 Apr 2017 18:56:30 +0800
Message-Id: <1491908193-25418-3-git-send-email-yao.jin@linux.intel.com>
In-Reply-To: <1491908193-25418-1-git-send-email-yao.jin@linux.intel.com>
References: <1491908193-25418-1-git-send-email-yao.jin@linux.intel.com>
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
to common branch classification.

Signed-off-by: Jin Yao <yao.jin@linux.intel.com>
---
 arch/x86/events/intel/lbr.c | 53 ++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 52 insertions(+), 1 deletion(-)

diff --git a/arch/x86/events/intel/lbr.c b/arch/x86/events/intel/lbr.c
index 81b321a..6968c63 100644
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
@@ -670,6 +673,10 @@ static int intel_pmu_setup_sw_lbr_filter(struct perf_event *event)
 
 	if (br_type & PERF_SAMPLE_BRANCH_CALL)
 		mask |= X86_BR_CALL | X86_BR_ZERO_CALL;
+
+	if (br_type & PERF_SAMPLE_BRANCH_TYPE_SAVE)
+		mask |= X86_BR_TYPE_SAVE;
+
 	/*
 	 * stash actual user request into reg, it may
 	 * be used by fixup code for some CPU
@@ -923,6 +930,44 @@ static int branch_type(unsigned long from, unsigned long to, int abort)
 	return ret;
 }
 
+#define X86_BR_TYPE_MAP_MAX	16
+
+static int
+common_branch_type(int type)
+{
+	int i, mask;
+	const int branch_map[X86_BR_TYPE_MAP_MAX] = {
+		PERF_BR_CALL,		/* X86_BR_CALL */
+		PERF_BR_RET,		/* X86_BR_RET */
+		PERF_BR_SYSCALL,	/* X86_BR_SYSCALL */
+		PERF_BR_SYSRET,		/* X86_BR_SYSRET */
+		PERF_BR_INT,		/* X86_BR_INT */
+		PERF_BR_IRET,		/* X86_BR_IRET */
+		PERF_BR_JCC,		/* X86_BR_JCC */
+		PERF_BR_JMP,		/* X86_BR_JMP */
+		PERF_BR_IRQ,		/* X86_BR_IRQ */
+		PERF_BR_IND_CALL,	/* X86_BR_IND_CALL */
+		PERF_BR_NONE,		/* X86_BR_ABORT */
+		PERF_BR_NONE,		/* X86_BR_IN_TX */
+		PERF_BR_NONE,		/* X86_BR_NO_TX */
+		PERF_BR_CALL,		/* X86_BR_ZERO_CALL */
+		PERF_BR_NONE,		/* X86_BR_CALL_STACK */
+		PERF_BR_IND_JMP,	/* X86_BR_IND_JMP */
+	};
+
+	type >>= 2; /* skip X86_BR_USER and X86_BR_KERNEL */
+	mask = ~(~0 << 1);
+
+	for (i = 0; i < X86_BR_TYPE_MAP_MAX; i++) {
+		if (type & mask)
+			return branch_map[i];
+
+		type >>= 1;
+	}
+
+	return PERF_BR_NONE;
+}
+
 /*
  * implement actual branch filter based on user demand.
  * Hardware may not exactly satisfy that request, thus
@@ -939,7 +984,8 @@ intel_pmu_lbr_filter(struct cpu_hw_events *cpuc)
 	bool compress = false;
 
 	/* if sampling all branches, then nothing to filter */
-	if ((br_sel & X86_BR_ALL) == X86_BR_ALL)
+	if (((br_sel & X86_BR_ALL) == X86_BR_ALL) &&
+	    ((br_sel & X86_BR_TYPE_SAVE) != X86_BR_TYPE_SAVE))
 		return;
 
 	for (i = 0; i < cpuc->lbr_stack.nr; i++) {
@@ -960,6 +1006,11 @@ intel_pmu_lbr_filter(struct cpu_hw_events *cpuc)
 			cpuc->lbr_entries[i].from = 0;
 			compress = true;
 		}
+
+		if ((br_sel & X86_BR_TYPE_SAVE) == X86_BR_TYPE_SAVE)
+			cpuc->lbr_entries[i].type = common_branch_type(type);
+		else
+			cpuc->lbr_entries[i].type = PERF_BR_NONE;
 	}
 
 	if (!compress)
-- 
2.7.4

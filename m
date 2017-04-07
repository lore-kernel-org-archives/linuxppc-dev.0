Return-Path: <yao.jin@linux.intel.com>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vzkZZ0WfyzDqHl
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  7 Apr 2017 12:49:57 +1000 (AEST)
From: Jin Yao <yao.jin@linux.intel.com>
To: acme@kernel.org, jolsa@kernel.org, peterz@infradead.org, mingo@redhat.com,
 alexander.shishkin@linux.intel.com
Cc: Linux-kernel@vger.kernel.org, ak@linux.intel.com, kan.liang@intel.com,
 yao.jin@intel.com, linuxppc-dev@lists.ozlabs.org,
 Jin Yao <yao.jin@linux.intel.com>
Subject: [PATCH v2 1/5] perf/core: Define the common branch type classification
Date: Fri,  7 Apr 2017 18:47:42 +0800
Message-Id: <1491562066-7472-2-git-send-email-yao.jin@linux.intel.com>
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

It is often useful to know the branch types while analyzing branch
data. For example, a call is very different from a conditional branch.

Currently we have to look it up in binary while the binary may later
not be available and even the binary is available but user has to take
some time. It is very useful for user to check it directly in perf
report.

Perf already has support for disassembling the branch instruction
to get the x86 branch type.

To keep consistent on kernel and userspace and make the classification
more common, the patch adds the common branch type classification
in perf_event.h.

PERF_BR_NONE      : unknown
PERF_BR_JCC_FWD   : conditional forward jump
PERF_BR_JCC_BWD   : conditional backward jump
PERF_BR_JMP       : jump
PERF_BR_IND_JMP   : indirect jump
PERF_BR_CALL      : call
PERF_BR_IND_CALL  : indirect call
PERF_BR_RET       : return
PERF_BR_SYSCALL   : syscall
PERF_BR_SYSRET    : syscall return
PERF_BR_IRQ       : hw interrupt/trap/fault
PERF_BR_INT       : sw interrupt
PERF_BR_IRET      : return from interrupt
PERF_BR_FAR_BRANCH: others not generic branch type

The patch adds following metrics checking for branches cross
4K or 2MB areas.

PERF_BR_CROSS_NONE: branch not cross an area
PERF_BR_CROSS_4K  : branch cross 4K area
PERF_BR_CROSS_2M  : branch cross 2MB area

Since the disassembling of branch instruction needs some overhead,
a new PERF_SAMPLE_BRANCH_TYPE_SAVE is introduced to indicate if it
needs to disassemble the branch instruction and record the branch
type.

Signed-off-by: Jin Yao <yao.jin@linux.intel.com>
---
 include/uapi/linux/perf_event.h       | 37 ++++++++++++++++++++++++++++++++++-
 tools/include/uapi/linux/perf_event.h | 37 ++++++++++++++++++++++++++++++++++-
 2 files changed, 72 insertions(+), 2 deletions(-)

diff --git a/include/uapi/linux/perf_event.h b/include/uapi/linux/perf_event.h
index d09a9cd..e2fcd53 100644
--- a/include/uapi/linux/perf_event.h
+++ b/include/uapi/linux/perf_event.h
@@ -174,6 +174,8 @@ enum perf_branch_sample_type_shift {
 	PERF_SAMPLE_BRANCH_NO_FLAGS_SHIFT	= 14, /* no flags */
 	PERF_SAMPLE_BRANCH_NO_CYCLES_SHIFT	= 15, /* no cycles */
 
+	PERF_SAMPLE_BRANCH_TYPE_SAVE_SHIFT	= 16, /* save branch type */
+
 	PERF_SAMPLE_BRANCH_MAX_SHIFT		/* non-ABI */
 };
 
@@ -198,9 +200,38 @@ enum perf_branch_sample_type {
 	PERF_SAMPLE_BRANCH_NO_FLAGS	= 1U << PERF_SAMPLE_BRANCH_NO_FLAGS_SHIFT,
 	PERF_SAMPLE_BRANCH_NO_CYCLES	= 1U << PERF_SAMPLE_BRANCH_NO_CYCLES_SHIFT,
 
+	PERF_SAMPLE_BRANCH_TYPE_SAVE	=
+		1U << PERF_SAMPLE_BRANCH_TYPE_SAVE_SHIFT,
+
 	PERF_SAMPLE_BRANCH_MAX		= 1U << PERF_SAMPLE_BRANCH_MAX_SHIFT,
 };
 
+/*
+ * Common flow change classification
+ */
+enum {
+	PERF_BR_NONE		= 0,	/* unknown */
+	PERF_BR_JCC_FWD		= 1,	/* conditional forward jump */
+	PERF_BR_JCC_BWD		= 2,	/* conditional backward jump */
+	PERF_BR_JMP		= 3,	/* jump */
+	PERF_BR_IND_JMP		= 4,	/* indirect jump */
+	PERF_BR_CALL		= 5,	/* call */
+	PERF_BR_IND_CALL	= 6,	/* indirect call */
+	PERF_BR_RET		= 7,	/* return */
+	PERF_BR_SYSCALL		= 8,	/* syscall */
+	PERF_BR_SYSRET		= 9,	/* syscall return */
+	PERF_BR_IRQ		= 10,	/* hw interrupt/trap/fault */
+	PERF_BR_INT		= 11,	/* sw interrupt */
+	PERF_BR_IRET		= 12,	/* return from interrupt */
+	PERF_BR_FAR_BRANCH	= 13,	/* others not generic branch type */
+};
+
+enum {
+	PERF_BR_CROSS_NONE	= 0,	/* branch not cross an area */
+	PERF_BR_CROSS_4K	= 1,	/* branch cross 4K */
+	PERF_BR_CROSS_2M	= 2,	/* branch cross 2MB */
+};
+
 #define PERF_SAMPLE_BRANCH_PLM_ALL \
 	(PERF_SAMPLE_BRANCH_USER|\
 	 PERF_SAMPLE_BRANCH_KERNEL|\
@@ -999,6 +1030,8 @@ union perf_mem_data_src {
  *     in_tx: running in a hardware transaction
  *     abort: aborting a hardware transaction
  *    cycles: cycles from last branch (or 0 if not supported)
+ *      type: branch type
+ *     cross: branch cross 4K or 2MB area
  */
 struct perf_branch_entry {
 	__u64	from;
@@ -1008,7 +1041,9 @@ struct perf_branch_entry {
 		in_tx:1,    /* in transaction */
 		abort:1,    /* transaction abort */
 		cycles:16,  /* cycle count to last branch */
-		reserved:44;
+		type:4,     /* branch type */
+		cross:2,    /* branch cross 4K or 2MB area */
+		reserved:38;
 };
 
 #endif /* _UAPI_LINUX_PERF_EVENT_H */
diff --git a/tools/include/uapi/linux/perf_event.h b/tools/include/uapi/linux/perf_event.h
index d09a9cd..e2fcd53 100644
--- a/tools/include/uapi/linux/perf_event.h
+++ b/tools/include/uapi/linux/perf_event.h
@@ -174,6 +174,8 @@ enum perf_branch_sample_type_shift {
 	PERF_SAMPLE_BRANCH_NO_FLAGS_SHIFT	= 14, /* no flags */
 	PERF_SAMPLE_BRANCH_NO_CYCLES_SHIFT	= 15, /* no cycles */
 
+	PERF_SAMPLE_BRANCH_TYPE_SAVE_SHIFT	= 16, /* save branch type */
+
 	PERF_SAMPLE_BRANCH_MAX_SHIFT		/* non-ABI */
 };
 
@@ -198,9 +200,38 @@ enum perf_branch_sample_type {
 	PERF_SAMPLE_BRANCH_NO_FLAGS	= 1U << PERF_SAMPLE_BRANCH_NO_FLAGS_SHIFT,
 	PERF_SAMPLE_BRANCH_NO_CYCLES	= 1U << PERF_SAMPLE_BRANCH_NO_CYCLES_SHIFT,
 
+	PERF_SAMPLE_BRANCH_TYPE_SAVE	=
+		1U << PERF_SAMPLE_BRANCH_TYPE_SAVE_SHIFT,
+
 	PERF_SAMPLE_BRANCH_MAX		= 1U << PERF_SAMPLE_BRANCH_MAX_SHIFT,
 };
 
+/*
+ * Common flow change classification
+ */
+enum {
+	PERF_BR_NONE		= 0,	/* unknown */
+	PERF_BR_JCC_FWD		= 1,	/* conditional forward jump */
+	PERF_BR_JCC_BWD		= 2,	/* conditional backward jump */
+	PERF_BR_JMP		= 3,	/* jump */
+	PERF_BR_IND_JMP		= 4,	/* indirect jump */
+	PERF_BR_CALL		= 5,	/* call */
+	PERF_BR_IND_CALL	= 6,	/* indirect call */
+	PERF_BR_RET		= 7,	/* return */
+	PERF_BR_SYSCALL		= 8,	/* syscall */
+	PERF_BR_SYSRET		= 9,	/* syscall return */
+	PERF_BR_IRQ		= 10,	/* hw interrupt/trap/fault */
+	PERF_BR_INT		= 11,	/* sw interrupt */
+	PERF_BR_IRET		= 12,	/* return from interrupt */
+	PERF_BR_FAR_BRANCH	= 13,	/* others not generic branch type */
+};
+
+enum {
+	PERF_BR_CROSS_NONE	= 0,	/* branch not cross an area */
+	PERF_BR_CROSS_4K	= 1,	/* branch cross 4K */
+	PERF_BR_CROSS_2M	= 2,	/* branch cross 2MB */
+};
+
 #define PERF_SAMPLE_BRANCH_PLM_ALL \
 	(PERF_SAMPLE_BRANCH_USER|\
 	 PERF_SAMPLE_BRANCH_KERNEL|\
@@ -999,6 +1030,8 @@ union perf_mem_data_src {
  *     in_tx: running in a hardware transaction
  *     abort: aborting a hardware transaction
  *    cycles: cycles from last branch (or 0 if not supported)
+ *      type: branch type
+ *     cross: branch cross 4K or 2MB area
  */
 struct perf_branch_entry {
 	__u64	from;
@@ -1008,7 +1041,9 @@ struct perf_branch_entry {
 		in_tx:1,    /* in transaction */
 		abort:1,    /* transaction abort */
 		cycles:16,  /* cycle count to last branch */
-		reserved:44;
+		type:4,     /* branch type */
+		cross:2,    /* branch cross 4K or 2MB area */
+		reserved:38;
 };
 
 #endif /* _UAPI_LINUX_PERF_EVENT_H */
-- 
2.7.4

Return-Path: <yao.jin@linux.intel.com>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3w2Tmb2kzGzDq5x
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 12 Apr 2017 00:23:11 +1000 (AEST)
From: Jin Yao <yao.jin@linux.intel.com>
To: acme@kernel.org, jolsa@kernel.org, peterz@infradead.org, mingo@redhat.com,
 alexander.shishkin@linux.intel.com
Cc: Linux-kernel@vger.kernel.org, ak@linux.intel.com, kan.liang@intel.com,
 yao.jin@intel.com, linuxppc-dev@lists.ozlabs.org,
 Jin Yao <yao.jin@linux.intel.com>
Subject: [PATCH v4 1/5] perf/core: Define the common branch type classification
Date: Wed, 12 Apr 2017 06:21:02 +0800
Message-Id: <1491949266-6835-2-git-send-email-yao.jin@linux.intel.com>
In-Reply-To: <1491949266-6835-1-git-send-email-yao.jin@linux.intel.com>
References: <1491949266-6835-1-git-send-email-yao.jin@linux.intel.com>
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
PERF_BR_JCC       : conditional jump
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
PERF_BR_FAR_BRANCH: not generic far branch type

The patch also adds a new field type (4 bits) in perf_branch_entry
to record the branch type.

Since the disassembling of branch instruction needs some overhead,
a new PERF_SAMPLE_BRANCH_TYPE_SAVE is introduced to indicate if it
needs to disassemble the branch instruction and record the branch
type.

Comparing to previous version, the major changes are:

1. Remove the PERF_BR_JCC_FWD/PERF_BR_JCC_BWD, they will be
   computed later in userspace.

2. Remove the "cross" field in perf_branch_entry. The cross page
   computing will be done later in userspace.

Signed-off-by: Jin Yao <yao.jin@linux.intel.com>
---
 include/uapi/linux/perf_event.h       | 29 ++++++++++++++++++++++++++++-
 tools/include/uapi/linux/perf_event.h | 29 ++++++++++++++++++++++++++++-
 2 files changed, 56 insertions(+), 2 deletions(-)

diff --git a/include/uapi/linux/perf_event.h b/include/uapi/linux/perf_event.h
index d09a9cd..69af012 100644
--- a/include/uapi/linux/perf_event.h
+++ b/include/uapi/linux/perf_event.h
@@ -174,6 +174,8 @@ enum perf_branch_sample_type_shift {
 	PERF_SAMPLE_BRANCH_NO_FLAGS_SHIFT	= 14, /* no flags */
 	PERF_SAMPLE_BRANCH_NO_CYCLES_SHIFT	= 15, /* no cycles */
 
+	PERF_SAMPLE_BRANCH_TYPE_SAVE_SHIFT	= 16, /* save branch type */
+
 	PERF_SAMPLE_BRANCH_MAX_SHIFT		/* non-ABI */
 };
 
@@ -198,9 +200,32 @@ enum perf_branch_sample_type {
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
+	PERF_BR_JCC		= 1,	/* conditional jump */
+	PERF_BR_JMP		= 2,	/* jump */
+	PERF_BR_IND_JMP		= 3,	/* indirect jump */
+	PERF_BR_CALL		= 4,	/* call */
+	PERF_BR_IND_CALL	= 5,	/* indirect call */
+	PERF_BR_RET		= 6,	/* return */
+	PERF_BR_SYSCALL		= 7,	/* syscall */
+	PERF_BR_SYSRET		= 8,	/* syscall return */
+	PERF_BR_IRQ		= 9,	/* hw interrupt/trap/fault */
+	PERF_BR_INT		= 10,	/* sw interrupt */
+	PERF_BR_IRET		= 11,	/* return from interrupt */
+	PERF_BR_FAR_BRANCH	= 12,	/* not generic far branch type */
+	PERF_BR_MAX,
+};
+
 #define PERF_SAMPLE_BRANCH_PLM_ALL \
 	(PERF_SAMPLE_BRANCH_USER|\
 	 PERF_SAMPLE_BRANCH_KERNEL|\
@@ -999,6 +1024,7 @@ union perf_mem_data_src {
  *     in_tx: running in a hardware transaction
  *     abort: aborting a hardware transaction
  *    cycles: cycles from last branch (or 0 if not supported)
+ *      type: branch type
  */
 struct perf_branch_entry {
 	__u64	from;
@@ -1008,7 +1034,8 @@ struct perf_branch_entry {
 		in_tx:1,    /* in transaction */
 		abort:1,    /* transaction abort */
 		cycles:16,  /* cycle count to last branch */
-		reserved:44;
+		type:4,     /* branch type */
+		reserved:40;
 };
 
 #endif /* _UAPI_LINUX_PERF_EVENT_H */
diff --git a/tools/include/uapi/linux/perf_event.h b/tools/include/uapi/linux/perf_event.h
index d09a9cd..69af012 100644
--- a/tools/include/uapi/linux/perf_event.h
+++ b/tools/include/uapi/linux/perf_event.h
@@ -174,6 +174,8 @@ enum perf_branch_sample_type_shift {
 	PERF_SAMPLE_BRANCH_NO_FLAGS_SHIFT	= 14, /* no flags */
 	PERF_SAMPLE_BRANCH_NO_CYCLES_SHIFT	= 15, /* no cycles */
 
+	PERF_SAMPLE_BRANCH_TYPE_SAVE_SHIFT	= 16, /* save branch type */
+
 	PERF_SAMPLE_BRANCH_MAX_SHIFT		/* non-ABI */
 };
 
@@ -198,9 +200,32 @@ enum perf_branch_sample_type {
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
+	PERF_BR_JCC		= 1,	/* conditional jump */
+	PERF_BR_JMP		= 2,	/* jump */
+	PERF_BR_IND_JMP		= 3,	/* indirect jump */
+	PERF_BR_CALL		= 4,	/* call */
+	PERF_BR_IND_CALL	= 5,	/* indirect call */
+	PERF_BR_RET		= 6,	/* return */
+	PERF_BR_SYSCALL		= 7,	/* syscall */
+	PERF_BR_SYSRET		= 8,	/* syscall return */
+	PERF_BR_IRQ		= 9,	/* hw interrupt/trap/fault */
+	PERF_BR_INT		= 10,	/* sw interrupt */
+	PERF_BR_IRET		= 11,	/* return from interrupt */
+	PERF_BR_FAR_BRANCH	= 12,	/* not generic far branch type */
+	PERF_BR_MAX,
+};
+
 #define PERF_SAMPLE_BRANCH_PLM_ALL \
 	(PERF_SAMPLE_BRANCH_USER|\
 	 PERF_SAMPLE_BRANCH_KERNEL|\
@@ -999,6 +1024,7 @@ union perf_mem_data_src {
  *     in_tx: running in a hardware transaction
  *     abort: aborting a hardware transaction
  *    cycles: cycles from last branch (or 0 if not supported)
+ *      type: branch type
  */
 struct perf_branch_entry {
 	__u64	from;
@@ -1008,7 +1034,8 @@ struct perf_branch_entry {
 		in_tx:1,    /* in transaction */
 		abort:1,    /* transaction abort */
 		cycles:16,  /* cycle count to last branch */
-		reserved:44;
+		type:4,     /* branch type */
+		reserved:40;
 };
 
 #endif /* _UAPI_LINUX_PERF_EVENT_H */
-- 
2.7.4

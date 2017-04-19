Return-Path: <yao.jin@linux.intel.com>
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3w7Dgr6TGlzDqCL
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 19 Apr 2017 17:50:32 +1000 (AEST)
From: Jin Yao <yao.jin@linux.intel.com>
To: acme@kernel.org, jolsa@kernel.org, peterz@infradead.org, mingo@redhat.com,
 alexander.shishkin@linux.intel.com
Cc: Linux-kernel@vger.kernel.org, ak@linux.intel.com, kan.liang@intel.com,
 yao.jin@intel.com, linuxppc-dev@lists.ozlabs.org,
 Jin Yao <yao.jin@linux.intel.com>
Subject: [PATCH v5 5/7] perf util: Create branch.c/.h for common branch
 functions
Date: Wed, 19 Apr 2017 23:48:12 +0800
Message-Id: <1492616894-3635-6-git-send-email-yao.jin@linux.intel.com>
In-Reply-To: <1492616894-3635-1-git-send-email-yao.jin@linux.intel.com>
References: <1492616894-3635-1-git-send-email-yao.jin@linux.intel.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Create new util/branch.c and util/branch.h to contain the common
branch functions. Such as:

branch_type_count(): Count the numbers of branch types
branch_type_name() : Return the name of branch type

The branch type is saved in branch_flags.

Change log
----------

v5: It's a new patch in v5 patch series.

Signed-off-by: Jin Yao <yao.jin@linux.intel.com>
---
 tools/perf/util/Build    |  1 +
 tools/perf/util/branch.c | 63 ++++++++++++++++++++++++++++++++++++++++++++++++
 tools/perf/util/branch.h | 23 ++++++++++++++++++
 tools/perf/util/event.h  |  3 ++-
 4 files changed, 89 insertions(+), 1 deletion(-)
 create mode 100644 tools/perf/util/branch.c
 create mode 100644 tools/perf/util/branch.h

diff --git a/tools/perf/util/Build b/tools/perf/util/Build
index 5c0ea11..40e318c 100644
--- a/tools/perf/util/Build
+++ b/tools/perf/util/Build
@@ -90,6 +90,7 @@ libperf-y += vsprintf.o
 libperf-y += drv_configs.o
 libperf-y += time-utils.o
 libperf-y += expr-bison.o
+libperf-y += branch.o
 
 libperf-$(CONFIG_LIBBPF) += bpf-loader.o
 libperf-$(CONFIG_BPF_PROLOGUE) += bpf-prologue.o
diff --git a/tools/perf/util/branch.c b/tools/perf/util/branch.c
new file mode 100644
index 0000000..702e376
--- /dev/null
+++ b/tools/perf/util/branch.c
@@ -0,0 +1,63 @@
+#include "perf.h"
+#include "util/util.h"
+#include "util/debug.h"
+#include "util/branch.h"
+
+static bool cross_area(u64 addr1, u64 addr2, int size)
+{
+	u64 align1, align2;
+
+	align1 = addr1 & ~(size - 1);
+	align2 = addr2 & ~(size - 1);
+
+	return (align1 != align2) ? true : false;
+}
+
+#define AREA_4K		4096
+#define AREA_2M		(2 * 1024 * 1024)
+
+void branch_type_count(struct branch_type_stat *stat,
+		       struct branch_flags *flags,
+		       u64 from, u64 to)
+{
+	if (flags->type == PERF_BR_NONE || from == 0)
+		return;
+
+	stat->counts[flags->type]++;
+
+	if (flags->type == PERF_BR_JCC) {
+		if (to > from)
+			stat->jcc_fwd++;
+		else
+			stat->jcc_bwd++;
+	}
+
+	if (cross_area(from, to, AREA_2M))
+		stat->cross_2m++;
+	else if (cross_area(from, to, AREA_4K))
+		stat->cross_4k++;
+}
+
+const char *branch_type_name(int type)
+{
+	const char *branch_names[PERF_BR_MAX] = {
+		"N/A",
+		"JCC",
+		"JMP",
+		"IND_JMP",
+		"CALL",
+		"IND_CALL",
+		"RET",
+		"SYSCALL",
+		"SYSRET",
+		"IRQ",
+		"INT",
+		"IRET",
+		"FAR_BRANCH",
+	};
+
+	if (type >= 0 && type < PERF_BR_MAX)
+		return branch_names[type];
+
+	return NULL;
+}
diff --git a/tools/perf/util/branch.h b/tools/perf/util/branch.h
new file mode 100644
index 0000000..26c8da6
--- /dev/null
+++ b/tools/perf/util/branch.h
@@ -0,0 +1,23 @@
+#ifndef _PERF_BRANCH_H
+#define _PERF_BRANCH_H 1
+
+#include <stdint.h>
+#include "../perf.h"
+
+struct branch_type_stat {
+	u64 counts[PERF_BR_MAX];
+	u64 jcc_fwd;
+	u64 jcc_bwd;
+	u64 cross_4k;
+	u64 cross_2m;
+};
+
+struct branch_flags;
+
+void branch_type_count(struct branch_type_stat *stat,
+		       struct branch_flags *flags,
+		       u64 from, u64 to);
+
+const char *branch_type_name(int type);
+
+#endif /* _PERF_BRANCH_H */
diff --git a/tools/perf/util/event.h b/tools/perf/util/event.h
index eb7a7b2..26b4c2e 100644
--- a/tools/perf/util/event.h
+++ b/tools/perf/util/event.h
@@ -142,7 +142,8 @@ struct branch_flags {
 	u64 in_tx:1;
 	u64 abort:1;
 	u64 cycles:16;
-	u64 reserved:44;
+	u64 type:4;
+	u64 reserved:40;
 };
 
 struct branch_entry {
-- 
2.7.4

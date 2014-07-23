Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id C4F461A06B5
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 Jul 2014 17:31:46 +1000 (EST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: <linuxppc-dev@ozlabs.org>
Subject: [PATCH 10/10] selftests/powerpc: Add test of per-event excludes
Date: Wed, 23 Jul 2014 17:31:40 +1000
Message-Id: <1406100700-9702-10-git-send-email-mpe@ellerman.id.au>
In-Reply-To: <1406100700-9702-1-git-send-email-mpe@ellerman.id.au>
References: <1406100700-9702-1-git-send-email-mpe@ellerman.id.au>
Cc: sam.bobroff@au1.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 tools/testing/selftests/powerpc/pmu/Makefile       |   2 +-
 .../selftests/powerpc/pmu/per_event_excludes.c     | 114 +++++++++++++++++++++
 2 files changed, 115 insertions(+), 1 deletion(-)
 create mode 100644 tools/testing/selftests/powerpc/pmu/per_event_excludes.c

diff --git a/tools/testing/selftests/powerpc/pmu/Makefile b/tools/testing/selftests/powerpc/pmu/Makefile
index 8595cfd7e41b..c9f4263906a5 100644
--- a/tools/testing/selftests/powerpc/pmu/Makefile
+++ b/tools/testing/selftests/powerpc/pmu/Makefile
@@ -1,7 +1,7 @@
 noarg:
 	$(MAKE) -C ../
 
-PROGS := count_instructions l3_bank_test
+PROGS := count_instructions l3_bank_test per_event_excludes
 EXTRA_SOURCES := ../harness.c event.c lib.c
 
 SUB_TARGETS = ebb
diff --git a/tools/testing/selftests/powerpc/pmu/per_event_excludes.c b/tools/testing/selftests/powerpc/pmu/per_event_excludes.c
new file mode 100644
index 000000000000..fddbbc9cae2f
--- /dev/null
+++ b/tools/testing/selftests/powerpc/pmu/per_event_excludes.c
@@ -0,0 +1,114 @@
+/*
+ * Copyright 2014, Michael Ellerman, IBM Corp.
+ * Licensed under GPLv2.
+ */
+
+#define _GNU_SOURCE
+
+#include <elf.h>
+#include <limits.h>
+#include <stdio.h>
+#include <stdbool.h>
+#include <string.h>
+#include <sys/prctl.h>
+
+#include "event.h"
+#include "lib.h"
+#include "utils.h"
+
+/*
+ * Test that per-event excludes work.
+ */
+
+static int per_event_excludes(void)
+{
+	struct event *e, events[4];
+	char *platform;
+	int i;
+
+	platform = (char *)get_auxv_entry(AT_BASE_PLATFORM);
+	FAIL_IF(!platform);
+	SKIP_IF(strcmp(platform, "power8") != 0);
+
+	/*
+	 * We need to create the events disabled, otherwise the running/enabled
+	 * counts don't match up.
+	 */
+	e = &events[0];
+	event_init_opts(e, PERF_COUNT_HW_INSTRUCTIONS,
+			PERF_TYPE_HARDWARE, "instructions");
+	e->attr.disabled = 1;
+
+	e = &events[1];
+	event_init_opts(e, PERF_COUNT_HW_INSTRUCTIONS,
+			PERF_TYPE_HARDWARE, "instructions(k)");
+	e->attr.disabled = 1;
+	e->attr.exclude_user = 1;
+	e->attr.exclude_hv = 1;
+
+	e = &events[2];
+	event_init_opts(e, PERF_COUNT_HW_INSTRUCTIONS,
+			PERF_TYPE_HARDWARE, "instructions(h)");
+	e->attr.disabled = 1;
+	e->attr.exclude_user = 1;
+	e->attr.exclude_kernel = 1;
+
+	e = &events[3];
+	event_init_opts(e, PERF_COUNT_HW_INSTRUCTIONS,
+			PERF_TYPE_HARDWARE, "instructions(u)");
+	e->attr.disabled = 1;
+	e->attr.exclude_hv = 1;
+	e->attr.exclude_kernel = 1;
+
+	FAIL_IF(event_open(&events[0]));
+
+	/*
+	 * The open here will fail if we don't have per event exclude support,
+	 * because the second event has an incompatible set of exclude settings
+	 * and we're asking for the events to be in a group.
+	 */
+	for (i = 1; i < 4; i++)
+		FAIL_IF(event_open_with_group(&events[i], events[0].fd));
+
+	/*
+	 * Even though the above will fail without per-event excludes we keep
+	 * testing in order to be thorough.
+	 */
+	prctl(PR_TASK_PERF_EVENTS_ENABLE);
+
+	/* Spin for a while */
+	for (i = 0; i < INT_MAX; i++)
+		asm volatile("" : : : "memory");
+
+	prctl(PR_TASK_PERF_EVENTS_DISABLE);
+
+	for (i = 0; i < 4; i++) {
+		FAIL_IF(event_read(&events[i]));
+		event_report(&events[i]);
+	}
+
+	/*
+	 * We should see that all events have enabled == running. That
+	 * shows that they were all on the PMU at once.
+	 */
+	for (i = 0; i < 4; i++)
+		FAIL_IF(events[i].result.running != events[i].result.enabled);
+
+	/*
+	 * We can also check that the result for instructions is >= all the
+	 * other counts. That's because it is counting all instructions while
+	 * the others are counting a subset.
+	 */
+	for (i = 1; i < 4; i++)
+		FAIL_IF(events[0].result.value < events[i].result.value);
+
+	for (i = 0; i < 4; i++)
+		event_close(&events[i]);
+
+	return 0;
+}
+
+int main(void)
+{
+	return test_harness(per_event_excludes, "per_event_excludes");
+}
-- 
1.9.1

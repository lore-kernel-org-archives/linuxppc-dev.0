Return-Path: <chris@distroguy.com>
Received: from mx-out02.mykolab.com (mx01.mykolab.com [95.128.36.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qyr2z3G53zDqCG
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  2 May 2016 13:51:53 +1000 (AEST)
Received: from mx03.mykolab.com (mx03.mykolab.com [10.20.7.101])
 by mx-out02.mykolab.com (Postfix) with ESMTPS id B3E1360135
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  2 May 2016 05:51:44 +0200 (CEST)
Date: Mon, 2 May 2016 13:51:38 +1000
From: Chris Smart <chris@distroguy.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH] selftests/powerpc: Test cp_abort during context switch
Message-ID: <20160502035133.GA28672@distroguy.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Test that performing a copy paste sequence in userspace on P9 does not
result in a leak of the copy into the paste of another process.

This is based on Anton Blanchard's context_switch benchmarking code. It
sets up two processes tied to the same CPU, one which copies and one
which pastes.

The paste should never succeed and the test fails if it does.

This is a test for commit, "8a64904 powerpc: Add support for userspace
P9 copy paste."

Patch created with much assistance from Michael Neuling
<mikey@neuling.org>

Signed-off-by: Chris Smart <chris@distroguy.com>
---
 tools/testing/selftests/powerpc/Makefile           |   1 +
 .../selftests/powerpc/context_switch/.gitignore    |   1 +
 .../selftests/powerpc/context_switch/Makefile      |  10 ++
 .../selftests/powerpc/context_switch/cp_abort.c    | 110 +++++++++++++++++++++
 tools/testing/selftests/powerpc/utils.h            |   7 ++
 5 files changed, 129 insertions(+)
 create mode 100644 tools/testing/selftests/powerpc/context_switch/.gitignore
 create mode 100644 tools/testing/selftests/powerpc/context_switch/Makefile
 create mode 100644 tools/testing/selftests/powerpc/context_switch/cp_abort.c

diff --git a/tools/testing/selftests/powerpc/Makefile b/tools/testing/selftests/powerpc/Makefile
index b08f77cbe31b..4ca83fe80654 100644
--- a/tools/testing/selftests/powerpc/Makefile
+++ b/tools/testing/selftests/powerpc/Makefile
@@ -14,6 +14,7 @@ export CFLAGS
 
 SUB_DIRS = benchmarks 		\
 	   copyloops		\
+	   context_switch	\
 	   dscr			\
 	   mm			\
 	   pmu			\
diff --git a/tools/testing/selftests/powerpc/context_switch/.gitignore b/tools/testing/selftests/powerpc/context_switch/.gitignore
new file mode 100644
index 000000000000..c1431af7b51c
--- /dev/null
+++ b/tools/testing/selftests/powerpc/context_switch/.gitignore
@@ -0,0 +1 @@
+cp_abort
diff --git a/tools/testing/selftests/powerpc/context_switch/Makefile b/tools/testing/selftests/powerpc/context_switch/Makefile
new file mode 100644
index 000000000000..e164d1466466
--- /dev/null
+++ b/tools/testing/selftests/powerpc/context_switch/Makefile
@@ -0,0 +1,10 @@
+TEST_PROGS := cp_abort
+
+all: $(TEST_PROGS)
+
+$(TEST_PROGS): ../harness.c ../utils.c
+
+include ../../lib.mk
+
+clean:
+	rm -f $(TEST_PROGS)
diff --git a/tools/testing/selftests/powerpc/context_switch/cp_abort.c b/tools/testing/selftests/powerpc/context_switch/cp_abort.c
new file mode 100644
index 000000000000..5a5b55afda0e
--- /dev/null
+++ b/tools/testing/selftests/powerpc/context_switch/cp_abort.c
@@ -0,0 +1,110 @@
+/*
+ * Adapted from Anton Blanchard's context switch microbenchmark.
+ *
+ * Copyright 2009, Anton Blanchard, IBM Corporation.
+ * Copyright 2016, Mikey Neuling, Chris Smart, IBM Corporation.
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version
+ * 2 of the License, or (at your option) any later version.
+ *
+ * This program tests the copy paste abort functionality of a P9
+ * (or later) by setting up two processes on the same CPU, one
+ * which executes the copy instruction and the other which
+ * executes paste.
+ *
+ * The paste instruction should never succeed, as the cp_abort
+ * instruction is called by the kernel during a context switch.
+ *
+ */
+
+#define _GNU_SOURCE
+
+#include <stdio.h>
+#include <unistd.h>
+#include <stdlib.h>
+#include "utils.h"
+#include <sched.h>
+
+#define READ_FD 0
+#define WRITE_FD 1
+
+#define NUM_LOOPS 1000
+
+/* This defines the "paste" instruction from Power ISA 3.0 Book II, section 4.4. */
+#define PASTE(RA, RB, L, RC) \
+	.long (0x7c00070c | (RA) << (31-15) | (RB) << (31-20) | (L) << (31-10) | (RC) << (31-31))
+
+int paste(void *i)
+{
+	int cr;
+
+	asm volatile(str(PASTE(0, %1, 1, 1))";"
+			"mfcr %0;"
+			: "=r" (cr)
+			: "b" (i)
+			: "memory"
+		    );
+	return cr;
+}
+
+/* This defines the "copy" instruction from Power ISA 3.0 Book II, section 4.4. */
+#define COPY(RA, RB, L) \
+	.long (0x7c00060c | (RA) << (31-15) | (RB) << (31-20) | (L) << (31-10))
+
+void copy(void *i)
+{
+	asm volatile(str(COPY(0, %0, 1))";"
+			:
+			: "b" (i)
+			: "memory"
+		    );
+}
+
+int test_cp_abort(void)
+{
+	/* 128 bytes for a full cache line */
+	char buf[128] __cacheline_aligned;
+	cpu_set_t cpuset;
+	int fd1[2], fd2[2], pid;
+	char c;
+
+	/* only run this test on a P9 or later */
+	SKIP_IF(!have_hwcap2(PPC_FEATURE2_ARCH_3_00));
+
+	/*
+	 * Run both processes on the same CPU, so that copy is more likely
+	 * to leak into a paste.
+	 */
+	CPU_ZERO(&cpuset);
+	CPU_SET(pick_online_cpu(), &cpuset);
+	FAIL_IF(sched_setaffinity(0, sizeof(cpuset), &cpuset));
+
+	FAIL_IF(pipe(fd1) || pipe(fd2));
+
+	pid = fork();
+	FAIL_IF(pid < 0);
+
+	if (!pid) {
+		for (int i = 0; i < NUM_LOOPS; i++) {
+			FAIL_IF((write(fd1[WRITE_FD], &c, 1)) != 1);
+			FAIL_IF((read(fd2[READ_FD], &c, 1)) != 1);
+			/* A paste succeeds if CR0 EQ bit is set */
+			FAIL_IF(paste(buf) & 0x20000000);
+		}
+	} else {
+		for (int i = 0; i < NUM_LOOPS; i++) {
+			FAIL_IF((read(fd1[READ_FD], &c, 1)) != 1);
+			copy(buf);
+			FAIL_IF((write(fd2[WRITE_FD], &c, 1) != 1));
+		}
+	}
+	return 0;
+
+}
+
+int main(int argc, char *argv[])
+{
+	return test_harness(test_cp_abort, "cp_abort");
+}
diff --git a/tools/testing/selftests/powerpc/utils.h b/tools/testing/selftests/powerpc/utils.h
index 175ac6ad10dd..3b370deafb62 100644
--- a/tools/testing/selftests/powerpc/utils.h
+++ b/tools/testing/selftests/powerpc/utils.h
@@ -6,6 +6,8 @@
 #ifndef _SELFTESTS_POWERPC_UTILS_H
 #define _SELFTESTS_POWERPC_UTILS_H
 
+#define __cacheline_aligned __attribute__((aligned(128)))
+
 #include <stdint.h>
 #include <stdbool.h>
 #include <linux/auxvec.h>
@@ -54,4 +56,9 @@ do {								\
 #define _str(s) #s
 #define str(s) _str(s)
 
+/* POWER9 feature */
+#ifndef PPC_FEATURE2_ARCH_3_00
+#define PPC_FEATURE2_ARCH_3_00 0x00800000
+#endif
+
 #endif /* _SELFTESTS_POWERPC_UTILS_H */
-- 
2.5.5

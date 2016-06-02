Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rL5SK68CRzDqXh
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  2 Jun 2016 22:02:09 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: <linuxppc-dev@ozlabs.org>
Cc: Anton Blanchard <anton@samba.org>
Subject: [PATCH] selftests/powerpc: Import Anton's mmap & futex micro
 benchmarks
Date: Thu,  2 Jun 2016 22:02:01 +1000
Message-Id: <1464868921-30413-1-git-send-email-mpe@ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

These are useful little loops for smoke testing performance.

Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 .../selftests/powerpc/benchmarks/.gitignore        |  2 ++
 .../testing/selftests/powerpc/benchmarks/Makefile  |  2 +-
 .../selftests/powerpc/benchmarks/futex_bench.c     | 42 ++++++++++++++++++++++
 .../selftests/powerpc/benchmarks/mmap_bench.c      | 41 +++++++++++++++++++++
 4 files changed, 86 insertions(+), 1 deletion(-)
 create mode 100644 tools/testing/selftests/powerpc/benchmarks/futex_bench.c
 create mode 100644 tools/testing/selftests/powerpc/benchmarks/mmap_bench.c

diff --git a/tools/testing/selftests/powerpc/benchmarks/.gitignore b/tools/testing/selftests/powerpc/benchmarks/.gitignore
index 6fa673316ac2..bce49ebd869e 100644
--- a/tools/testing/selftests/powerpc/benchmarks/.gitignore
+++ b/tools/testing/selftests/powerpc/benchmarks/.gitignore
@@ -1,2 +1,4 @@
 gettimeofday
 context_switch
+mmap_bench
+futex_bench
\ No newline at end of file
diff --git a/tools/testing/selftests/powerpc/benchmarks/Makefile b/tools/testing/selftests/powerpc/benchmarks/Makefile
index 912445ff7ce7..579cc63e6f19 100644
--- a/tools/testing/selftests/powerpc/benchmarks/Makefile
+++ b/tools/testing/selftests/powerpc/benchmarks/Makefile
@@ -1,4 +1,4 @@
-TEST_PROGS := gettimeofday context_switch
+TEST_PROGS := gettimeofday context_switch mmap_bench futex_bench
 
 CFLAGS += -O2
 
diff --git a/tools/testing/selftests/powerpc/benchmarks/futex_bench.c b/tools/testing/selftests/powerpc/benchmarks/futex_bench.c
new file mode 100644
index 000000000000..f7ba806ddcec
--- /dev/null
+++ b/tools/testing/selftests/powerpc/benchmarks/futex_bench.c
@@ -0,0 +1,42 @@
+/*
+ * Copyright 2016, Anton Blanchard, Michael Ellerman, IBM Corp.
+ * Licensed under GPLv2.
+ */
+
+#define _GNU_SOURCE
+
+#include <stdio.h>
+#include <sys/syscall.h>
+#include <time.h>
+#include <unistd.h>
+#include <linux/futex.h>
+
+#include "utils.h"
+
+#define ITERATIONS 100000000
+
+#define futex(A, B, C, D, E, F)         syscall(__NR_futex, A, B, C, D, E, F)
+
+int test_futex(void)
+{
+	struct timespec ts_start, ts_end;
+        unsigned long i = ITERATIONS;
+
+	clock_gettime(CLOCK_MONOTONIC, &ts_start);
+
+        while (i--) {
+                unsigned int addr = 0;
+                futex(&addr, FUTEX_WAKE, 1, NULL, NULL, 0);
+        }
+
+	clock_gettime(CLOCK_MONOTONIC, &ts_end);
+
+	printf("time = %.6f\n", ts_end.tv_sec - ts_start.tv_sec + (ts_end.tv_nsec - ts_start.tv_nsec) / 1e9);
+
+	return 0;
+}
+
+int main(void)
+{
+	return test_harness(test_futex, "futex_bench");
+}
diff --git a/tools/testing/selftests/powerpc/benchmarks/mmap_bench.c b/tools/testing/selftests/powerpc/benchmarks/mmap_bench.c
new file mode 100644
index 000000000000..02bb711f84b0
--- /dev/null
+++ b/tools/testing/selftests/powerpc/benchmarks/mmap_bench.c
@@ -0,0 +1,41 @@
+/*
+ * Copyright 2016, Anton Blanchard, Michael Ellerman, IBM Corp.
+ * Licensed under GPLv2.
+ */
+
+#include <stdio.h>
+#include <stdlib.h>
+#include <sys/mman.h>
+#include <time.h>
+
+#include "utils.h"
+
+#define ITERATIONS 5000000
+
+#define MEMSIZE (128 * 1024 * 1024)
+
+int test_mmap(void)
+{
+	struct timespec ts_start, ts_end;
+        unsigned long i = ITERATIONS;
+
+	clock_gettime(CLOCK_MONOTONIC, &ts_start);
+
+        while (i--) {
+                char *c = mmap(NULL, MEMSIZE, PROT_READ|PROT_WRITE,
+                               MAP_PRIVATE|MAP_ANONYMOUS, -1, 0);
+		FAIL_IF(c == MAP_FAILED);
+                munmap(c, MEMSIZE);
+        }
+
+	clock_gettime(CLOCK_MONOTONIC, &ts_end);
+
+	printf("time = %.6f\n", ts_end.tv_sec - ts_start.tv_sec + (ts_end.tv_nsec - ts_start.tv_nsec) / 1e9);
+
+	return 0;
+}
+
+int main(void)
+{
+	return test_harness(test_mmap, "mmap_bench");
+}
-- 
2.5.0

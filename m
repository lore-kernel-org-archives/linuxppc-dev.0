Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rfgkX4yyhzDqvn
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 29 Jun 2016 21:41:56 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: <linuxppc-dev@ozlabs.org>
Cc: cyrilbur@gmail.com
Subject: [PATCH v2] selftests/powerpc: exec() with suspended transaction
Date: Wed, 29 Jun 2016 21:41:51 +1000
Message-Id: <1467200511-19033-1-git-send-email-mpe@ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Cyril Bur <cyrilbur@gmail.com>

Perform an exec() class syscall with a suspended transaction.

Signed-off-by: Cyril Bur <cyrilbur@gmail.com>
[mpe: Fix build errors, use a single binary for the test]
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>

Selftest updates
---
 tools/testing/selftests/powerpc/tm/.gitignore   |  1 +
 tools/testing/selftests/powerpc/tm/Makefile     |  7 ++-
 tools/testing/selftests/powerpc/tm/tm-exec.c    | 70 +++++++++++++++++++++++++
 tools/testing/selftests/powerpc/tm/tm-syscall.c | 15 ------
 tools/testing/selftests/powerpc/tm/tm.h         | 23 +++++++-
 5 files changed, 98 insertions(+), 18 deletions(-)
 create mode 100644 tools/testing/selftests/powerpc/tm/tm-exec.c

diff --git a/tools/testing/selftests/powerpc/tm/.gitignore b/tools/testing/selftests/powerpc/tm/.gitignore
index bb942db845bf..82c0a9ce6e74 100644
--- a/tools/testing/selftests/powerpc/tm/.gitignore
+++ b/tools/testing/selftests/powerpc/tm/.gitignore
@@ -6,3 +6,4 @@ tm-vmxcopy
 tm-fork
 tm-tar
 tm-tmspr
+tm-exec
diff --git a/tools/testing/selftests/powerpc/tm/Makefile b/tools/testing/selftests/powerpc/tm/Makefile
index d0505dbd22d5..9d301d785d9e 100644
--- a/tools/testing/selftests/powerpc/tm/Makefile
+++ b/tools/testing/selftests/powerpc/tm/Makefile
@@ -1,11 +1,14 @@
-TEST_PROGS := tm-resched-dscr tm-syscall tm-signal-msr-resv tm-signal-stack tm-vmxcopy tm-fork tm-tar tm-tmspr
+TEST_PROGS := tm-resched-dscr tm-syscall tm-signal-msr-resv tm-signal-stack \
+	tm-vmxcopy tm-fork tm-tar tm-tmspr tm-exec tm-execed
 
 all: $(TEST_PROGS)
 
 $(TEST_PROGS): ../harness.c ../utils.c
 
+CFLAGS += -mhtm
+
 tm-syscall: tm-syscall-asm.S
-tm-syscall: CFLAGS += -mhtm -I../../../../../usr/include
+tm-syscall: CFLAGS += -I../../../../../usr/include
 tm-tmspr: CFLAGS += -pthread
 
 include ../../lib.mk
diff --git a/tools/testing/selftests/powerpc/tm/tm-exec.c b/tools/testing/selftests/powerpc/tm/tm-exec.c
new file mode 100644
index 000000000000..3d27fa0ece04
--- /dev/null
+++ b/tools/testing/selftests/powerpc/tm/tm-exec.c
@@ -0,0 +1,70 @@
+/*
+ * Copyright 2016, Cyril Bur, IBM Corp.
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version
+ * 2 of the License, or (at your option) any later version.
+ *
+ * Syscalls can be performed provided the transactions are suspended.
+ * The exec() class of syscall is unique as a new process is loaded.
+ *
+ * It makes little sense for after an exec() call for the previously
+ * suspended transaction to still exist.
+ */
+
+#define _GNU_SOURCE
+#include <errno.h>
+#include <inttypes.h>
+#include <libgen.h>
+#include <pthread.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <unistd.h>
+
+#include "utils.h"
+#include "tm.h"
+
+static char *path;
+
+static int test_exec(void)
+{
+	SKIP_IF(!have_htm());
+
+	asm __volatile__(
+		"tbegin.;"
+		"blt    1f; "
+		"tsuspend.;"
+		"1: ;"
+		: : : "memory");
+
+	execl(path, "tm-exec", "--child", NULL);
+
+	/* Shouldn't get here */
+	perror("execl() failed");
+	return 1;
+}
+
+static int after_exec(void)
+{
+	asm __volatile__(
+		"tbegin.;"
+		"blt    1f;"
+		"tsuspend.;"
+		"1: ;"
+		: : : "memory");
+
+	FAIL_IF(failure_is_nesting());
+	return 0;
+}
+
+int main(int argc, char *argv[])
+{
+	path = argv[0];
+
+	if (argc > 1 && strcmp(argv[1], "--child") == 0)
+		return after_exec();
+
+	return test_harness(test_exec, "tm_exec");
+}
diff --git a/tools/testing/selftests/powerpc/tm/tm-syscall.c b/tools/testing/selftests/powerpc/tm/tm-syscall.c
index 60560cb20e38..454b965a2db3 100644
--- a/tools/testing/selftests/powerpc/tm/tm-syscall.c
+++ b/tools/testing/selftests/powerpc/tm/tm-syscall.c
@@ -27,21 +27,6 @@ unsigned retries = 0;
 #define TEST_DURATION 10 /* seconds */
 #define TM_RETRIES 100
 
-long failure_code(void)
-{
-	return __builtin_get_texasru() >> 24;
-}
-
-bool failure_is_persistent(void)
-{
-	return (failure_code() & TM_CAUSE_PERSISTENT) == TM_CAUSE_PERSISTENT;
-}
-
-bool failure_is_syscall(void)
-{
-	return (failure_code() & TM_CAUSE_SYSCALL) == TM_CAUSE_SYSCALL;
-}
-
 pid_t getppid_tm(bool suspend)
 {
 	int i;
diff --git a/tools/testing/selftests/powerpc/tm/tm.h b/tools/testing/selftests/powerpc/tm/tm.h
index 24144b25772c..60318bad7d7a 100644
--- a/tools/testing/selftests/powerpc/tm/tm.h
+++ b/tools/testing/selftests/powerpc/tm/tm.h
@@ -6,8 +6,9 @@
 #ifndef _SELFTESTS_POWERPC_TM_TM_H
 #define _SELFTESTS_POWERPC_TM_TM_H
 
-#include <stdbool.h>
+#include <asm/tm.h>
 #include <asm/cputable.h>
+#include <stdbool.h>
 
 #include "../utils.h"
 
@@ -31,4 +32,24 @@ static inline bool have_htm_nosc(void)
 #endif
 }
 
+static inline long failure_code(void)
+{
+	return __builtin_get_texasru() >> 24;
+}
+
+static inline bool failure_is_persistent(void)
+{
+	return (failure_code() & TM_CAUSE_PERSISTENT) == TM_CAUSE_PERSISTENT;
+}
+
+static inline bool failure_is_syscall(void)
+{
+	return (failure_code() & TM_CAUSE_SYSCALL) == TM_CAUSE_SYSCALL;
+}
+
+static inline bool failure_is_nesting(void)
+{
+	return (__builtin_get_texasru() & 0x400000);
+}
+
 #endif /* _SELFTESTS_POWERPC_TM_TM_H */
-- 
2.5.0

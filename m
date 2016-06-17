Return-Path: <cyrilbur@gmail.com>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rW7MJ3vLQzDqtQ
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 17 Jun 2016 14:59:08 +1000 (AEST)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3rW7MH6CG2z9t2H
 for <linuxppc-dev@ozlabs.org>; Fri, 17 Jun 2016 14:59:06 +1000 (AEST)
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u5H4x25w113246
 for <linuxppc-dev@ozlabs.org>; Fri, 17 Jun 2016 00:59:05 -0400
Received: from e23smtp04.au.ibm.com (e23smtp04.au.ibm.com [202.81.31.146])
 by mx0a-001b2d01.pphosted.com with ESMTP id 23kr6276yw-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@ozlabs.org>; Fri, 17 Jun 2016 00:59:05 -0400
Received: from localhost
 by e23smtp04.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <cyrilbur@gmail.com>;
 Fri, 17 Jun 2016 14:59:01 +1000
Received: from d23relay09.au.ibm.com (d23relay09.au.ibm.com [9.185.63.181])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id 29C0F2BB0055
 for <linuxppc-dev@ozlabs.org>; Fri, 17 Jun 2016 14:59:00 +1000 (EST)
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay09.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u5H4x0oa24314060
 for <linuxppc-dev@ozlabs.org>; Fri, 17 Jun 2016 14:59:00 +1000
Received: from d23av04.au.ibm.com (localhost [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u5H4wxWi001393
 for <linuxppc-dev@ozlabs.org>; Fri, 17 Jun 2016 14:59:00 +1000
Received: from ozlabs.au.ibm.com (ozlabs.au.ibm.com [9.192.253.14])
 by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVin) with ESMTP id
 u5H4wxfV001390
 for <linuxppc-dev@ozlabs.org>; Fri, 17 Jun 2016 14:58:59 +1000
Received: from camb691.ozlabs.ibm.com (haven.au.ibm.com [9.192.254.114])
 (using TLSv1.2 with cipher DHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ozlabs.au.ibm.com (Postfix) with ESMTPSA id 206BDA0223
 for <linuxppc-dev@ozlabs.org>; Fri, 17 Jun 2016 14:58:59 +1000 (AEST)
From: Cyril Bur <cyrilbur@gmail.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH v2 1/2] selftests/powerpc: exec() with suspended transaction
Date: Fri, 17 Jun 2016 14:58:33 +1000
Message-Id: <20160617045834.22275-1-cyrilbur@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Perform an exec() class syscall with a suspended transaction.

Signed-off-by: Cyril Bur <cyrilbur@gmail.com>
---
V2: No change

 tools/testing/selftests/powerpc/tm/Makefile     |  3 +-
 tools/testing/selftests/powerpc/tm/tm-exec.c    | 55 +++++++++++++++++++++++++
 tools/testing/selftests/powerpc/tm/tm-execed.c  | 47 +++++++++++++++++++++
 tools/testing/selftests/powerpc/tm/tm-syscall.c | 15 -------
 tools/testing/selftests/powerpc/tm/tm.h         | 23 ++++++++++-
 5 files changed, 126 insertions(+), 17 deletions(-)
 create mode 100644 tools/testing/selftests/powerpc/tm/tm-exec.c
 create mode 100644 tools/testing/selftests/powerpc/tm/tm-execed.c

diff --git a/tools/testing/selftests/powerpc/tm/Makefile b/tools/testing/selftests/powerpc/tm/Makefile
index d0505db..129e9ef 100644
--- a/tools/testing/selftests/powerpc/tm/Makefile
+++ b/tools/testing/selftests/powerpc/tm/Makefile
@@ -1,4 +1,5 @@
-TEST_PROGS := tm-resched-dscr tm-syscall tm-signal-msr-resv tm-signal-stack tm-vmxcopy tm-fork tm-tar tm-tmspr
+TEST_PROGS := tm-resched-dscr tm-syscall tm-signal-msr-resv tm-signal-stack \
+	tm-vmxcopy tm-fork tm-tar tm-tmspr tm-exec tm-execed
 
 all: $(TEST_PROGS)
 
diff --git a/tools/testing/selftests/powerpc/tm/tm-exec.c b/tools/testing/selftests/powerpc/tm/tm-exec.c
new file mode 100644
index 0000000..2d1c60f
--- /dev/null
+++ b/tools/testing/selftests/powerpc/tm/tm-exec.c
@@ -0,0 +1,55 @@
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
+#include <unistd.h>
+
+#include "utils.h"
+#include "tm.h"
+
+static char *path;
+
+int test_exec(void)
+{
+	char *file;
+
+	SKIP_IF(!have_htm());
+
+	FAIL_IF(asprintf(&file, "%s/%s", path, "tm-execed") == -1);
+
+	asm __volatile__(
+		"tbegin.;"
+		"blt    1f; "
+		"tsuspend.;"
+		"1: ;"
+		: : : "memory");
+
+	execl(file, "tm-execed", NULL);
+	/* Shouldn't get here */
+	perror("execl() failed");
+	return 1;
+}
+
+int main(int argc, char *argv[])
+{
+	path = dirname(argv[0]);
+	return test_harness(test_exec, "tm_exec");
+}
diff --git a/tools/testing/selftests/powerpc/tm/tm-execed.c b/tools/testing/selftests/powerpc/tm/tm-execed.c
new file mode 100644
index 0000000..e6119e8
--- /dev/null
+++ b/tools/testing/selftests/powerpc/tm/tm-execed.c
@@ -0,0 +1,47 @@
+/*
+ * Copyright 2016, Cyril Bur, IBM Corp.
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version
+ * 2 of the License, or (at your option) any later version.
+ *
+ * Syscalls can be done provided the transactions are suspended. The
+ * exec() class of syscall is unique as a new program is loaded.
+ *
+ * It makes little sence for after an exec() call for the previously
+ * suspended transaction to still exist.
+ *
+ * This program also as by product confirms that a process exiting
+ * with a suspended transaction doesn't do anything strange.
+ */
+
+#include <errno.h>
+#include <inttypes.h>
+#include <pthread.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <unistd.h>
+
+#include "utils.h"
+#include "tm.h"
+
+int test_execed(void)
+{
+	SKIP_IF(!have_htm());
+
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
+	return test_harness(test_execed, "tm_execed");
+}
diff --git a/tools/testing/selftests/powerpc/tm/tm-syscall.c b/tools/testing/selftests/powerpc/tm/tm-syscall.c
index 60560cb..454b965 100644
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
index 24144b2..60318ba 100644
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
2.8.3

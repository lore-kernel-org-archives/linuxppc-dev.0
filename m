Return-Path: <rashmicy@gmail.com>
Received: from mail-pa0-x229.google.com (mail-pa0-x229.google.com
 [IPv6:2607:f8b0:400e:c03::229])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 346851A0910
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  2 Dec 2015 17:03:19 +1100 (AEDT)
Received: by pacej9 with SMTP id ej9so30259451pac.2
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 01 Dec 2015 22:03:17 -0800 (PST)
From: Rashmica Gupta <rashmicy@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: mikey@neuling.org
Subject: [v2] selftests/powerpc: Add test for forking inside transaction
Date: Wed,  2 Dec 2015 17:03:08 +1100
Message-Id: <1449036188-11909-1-git-send-email-rashmicy@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This test does a fork syscall inside a transaction. Basic sniff test to see
if we can enter the kernel during a transaction.

Signed-off-by: Rashmica Gupta <rashmicy@gmail.com>
---
Updated description. No functional changes.

 tools/testing/selftests/powerpc/tm/.gitignore |  1 +
 tools/testing/selftests/powerpc/tm/Makefile   |  2 +-
 tools/testing/selftests/powerpc/tm/tm-fork.c  | 42 +++++++++++++++++++++++++++
 3 files changed, 44 insertions(+), 1 deletion(-)
 create mode 100644 tools/testing/selftests/powerpc/tm/tm-fork.c

diff --git a/tools/testing/selftests/powerpc/tm/.gitignore b/tools/testing/selftests/powerpc/tm/.gitignore
index e6668217ccd0..d0c7c97e9b13 100644
--- a/tools/testing/selftests/powerpc/tm/.gitignore
+++ b/tools/testing/selftests/powerpc/tm/.gitignore
@@ -2,3 +2,4 @@ tm-resched-dscr
 tm-syscall
 tm-signal-msr-resv
 tm-signal-stack
+tm-fork
diff --git a/tools/testing/selftests/powerpc/tm/Makefile b/tools/testing/selftests/powerpc/tm/Makefile
index 578572a3700a..f7d4727662aa 100644
--- a/tools/testing/selftests/powerpc/tm/Makefile
+++ b/tools/testing/selftests/powerpc/tm/Makefile
@@ -1,4 +1,4 @@
-TEST_PROGS := tm-resched-dscr tm-syscall tm-signal-msr-resv tm-signal-stack
+TEST_PROGS := tm-resched-dscr tm-syscall tm-signal-msr-resv tm-signal-stack tm-fork
 
 all: $(TEST_PROGS)
 
diff --git a/tools/testing/selftests/powerpc/tm/tm-fork.c b/tools/testing/selftests/powerpc/tm/tm-fork.c
new file mode 100644
index 000000000000..8d48579b7778
--- /dev/null
+++ b/tools/testing/selftests/powerpc/tm/tm-fork.c
@@ -0,0 +1,42 @@
+/*
+ * Copyright 2015, Michael Neuling, IBM Corp.
+ * Licensed under GPLv2.
+ *
+ * Edited: Rashmica Gupta, Nov 2015
+ *
+ * This test does a fork syscall inside a transaction. Basic sniff test
+ * to see if we can enter the kernel during a transaction.
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
+int test_fork(void)
+{
+	SKIP_IF(!have_htm());
+
+	asm __volatile__(
+		"tbegin.;"
+		"blt    1f; "
+		"li     0, 2;"  /* fork syscall */
+		"sc  ;"
+		"tend.;"
+		"1: ;"
+		: : : "memory", "r0");
+	/* If we reach here, we've passed.  Otherwise we've probably crashed
+	 * the kernel */
+
+	return 0;
+}
+
+int main(int argc, char *argv[])
+{
+	return test_harness(test_fork, "tm_fork");
+}
-- 
2.5.0

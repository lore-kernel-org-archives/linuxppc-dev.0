Return-Path: <mikey@neuling.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 1ED151A0023
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 20 Nov 2015 15:15:42 +1100 (AEDT)
From: Michael Neuling <mikey@neuling.org>
To: mpe@ellerman.id.au,
	benh@kernel.crashing.org
Cc: mikey@neuling.org, sam.bobroff@au1.ibm.com, linuxppc-dev@ozlabs.org,
 paulus@samba.org
Subject: [PATCH v2 3/3] selftests/powerpc: Add TM signal with invalid stack
 test
Date: Fri, 20 Nov 2015 15:15:34 +1100
Message-Id: <1447992934-18905-4-git-send-email-mikey@neuling.org>
In-Reply-To: <1447992934-18905-1-git-send-email-mikey@neuling.org>
References: <1447992934-18905-1-git-send-email-mikey@neuling.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Test the kernels signal generation code to ensure it can handle an
invalid stack pointer when transactional.

Signed-off-by: Michael Neuling <mikey@neuling.org>
---
 tools/testing/selftests/powerpc/tm/.gitignore      |  1 +
 tools/testing/selftests/powerpc/tm/Makefile        |  2 +-
 .../testing/selftests/powerpc/tm/tm-signal-stack.c | 73 ++++++++++++++++++++++
 3 files changed, 75 insertions(+), 1 deletion(-)
 create mode 100644 tools/testing/selftests/powerpc/tm/tm-signal-stack.c

diff --git a/tools/testing/selftests/powerpc/tm/.gitignore b/tools/testing/selftests/powerpc/tm/.gitignore
index 61c318f..e666821 100644
--- a/tools/testing/selftests/powerpc/tm/.gitignore
+++ b/tools/testing/selftests/powerpc/tm/.gitignore
@@ -1,3 +1,4 @@
 tm-resched-dscr
 tm-syscall
 tm-signal-msr-resv
+tm-signal-stack
diff --git a/tools/testing/selftests/powerpc/tm/Makefile b/tools/testing/selftests/powerpc/tm/Makefile
index 0c28db7..0e45c7e 100644
--- a/tools/testing/selftests/powerpc/tm/Makefile
+++ b/tools/testing/selftests/powerpc/tm/Makefile
@@ -1,4 +1,4 @@
-TEST_PROGS := tm-resched-dscr tm-syscall tm-signal-msr-resv
+TEST_PROGS := tm-resched-dscr tm-syscall tm-signal-msr-resv tm-signal-stack
 
 all: $(TEST_PROGS)
 
diff --git a/tools/testing/selftests/powerpc/tm/tm-signal-stack.c b/tools/testing/selftests/powerpc/tm/tm-signal-stack.c
new file mode 100644
index 0000000..62f2a5f
--- /dev/null
+++ b/tools/testing/selftests/powerpc/tm/tm-signal-stack.c
@@ -0,0 +1,73 @@
+/*
+ * Copyright 2015, Michael Neuling, IBM Corp.
+ * Licensed under GPLv2.
+ *
+ * Test the kernel's signal delievery code to ensure that we don't
+ * trelaim twice in the kernel signal delivery code.  This can happen
+ * if we trigger a signal when in a transaction and the stack pointer
+ * is bogus.
+ *
+ * This test case registers a SEGV handler, sets the stack pointer
+ * (r1) to NULL, starts a transaction and then generates a SEGV.  The
+ * SEGV should be handled but we exit here as the stack pointer is
+ * invalid and hance we can't sigreturn.  We only need to check that
+ * this flow doesn't crash the kernel.
+ */
+
+#include <unistd.h>
+#include <sys/types.h>
+#include <sys/wait.h>
+#include <stdlib.h>
+#include <stdio.h>
+#include <signal.h>
+
+#include "utils.h"
+
+void signal_segv(int signum)
+{
+	/* This should never actually run since stack is foobar */
+	exit(1);
+}
+
+int tm_signal_stack()
+{
+	int pid;
+
+	pid = fork();
+	if (pid < 0)
+		exit(1);
+
+	if (pid) { /* Parent */
+		/*
+		 * It's likely the whole machine will crash here so if
+		 * the child ever exits, we are good.
+		 */
+		wait(NULL);
+		return 0;
+	}
+
+	/*
+	 * The flow here is:
+	 * 1) register a signal handler (so signal delievery occurs)
+	 * 2) make stack pointer (r1) = NULL
+	 * 3) start transaction
+	 * 4) cause segv
+	 */
+	if (signal(SIGSEGV, signal_segv) == SIG_ERR)
+		exit(1);
+	asm volatile("li 1, 0 ;"		/* stack ptr == NULL */
+		     "1:"
+		     ".long 0x7C00051D ;"	/* tbegin */
+		     "beq 1b ;"			/* retry forever */
+		     ".long 0x7C0005DD ; ;"	/* tsuspend */
+		     "ld 2, 0(1) ;"		/* trigger segv" */
+		     : : : "memory");
+
+	/* This should never get here due to above segv */
+	return 1;
+}
+
+int main(void)
+{
+	return test_harness(tm_signal_stack, "tm_signal_stack");
+}
-- 
2.5.0

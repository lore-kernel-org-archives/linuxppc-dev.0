Return-Path: <mikey@neuling.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id E07751A072B
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 13 Nov 2015 15:57:44 +1100 (AEDT)
From: Michael Neuling <mikey@neuling.org>
To: mpe@ellerman.id.au,
	benh@kernel.crashing.org
Cc: mikey@neuling.org, sam.bobroff@au1.ibm.com, linuxppc-dev@ozlabs.org,
 paulus@samba.org
Subject: [PATCH 2/5] selftests/powerpc: Add TM signal return selftest
Date: Fri, 13 Nov 2015 15:57:29 +1100
Message-Id: <1447390652-28355-2-git-send-email-mikey@neuling.org>
In-Reply-To: <1447390652-28355-1-git-send-email-mikey@neuling.org>
References: <1447390652-28355-1-git-send-email-mikey@neuling.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Test the kernel's signal return code to ensure that it doesn't crash
when both the transactional and suspend MSR bits are set in the signal
context.

Signed-off-by: Michael Neuling <mikey@neuling.org>
---
 tools/testing/selftests/powerpc/tm/Makefile        |  2 +-
 .../selftests/powerpc/tm/tm-signal-msr-resv.c      | 64 ++++++++++++++++++++++
 2 files changed, 65 insertions(+), 1 deletion(-)
 create mode 100644 tools/testing/selftests/powerpc/tm/tm-signal-msr-resv.c

diff --git a/tools/testing/selftests/powerpc/tm/Makefile b/tools/testing/selftests/powerpc/tm/Makefile
index 4bea62a..0c28db7 100644
--- a/tools/testing/selftests/powerpc/tm/Makefile
+++ b/tools/testing/selftests/powerpc/tm/Makefile
@@ -1,4 +1,4 @@
-TEST_PROGS := tm-resched-dscr tm-syscall
+TEST_PROGS := tm-resched-dscr tm-syscall tm-signal-msr-resv
 
 all: $(TEST_PROGS)
 
diff --git a/tools/testing/selftests/powerpc/tm/tm-signal-msr-resv.c b/tools/testing/selftests/powerpc/tm/tm-signal-msr-resv.c
new file mode 100644
index 0000000..14705ae
--- /dev/null
+++ b/tools/testing/selftests/powerpc/tm/tm-signal-msr-resv.c
@@ -0,0 +1,64 @@
+/*
+ * Copyright 2015, Michael Neuling, IBM Corp.
+ * Licensed under GPLv2.
+ *
+ * Test the kernel's signal return code to ensure that it doesn't
+ * crash when both the transactional and suspend MSR bits are set in
+ * the signal context.
+ */
+
+#include <stdlib.h>
+#include <stdio.h>
+#include <signal.h>
+
+#include "utils.h"
+
+struct sigaction act;
+
+void signal_segv(int signum, siginfo_t *info, void *uc)
+{
+	printf("PASSED\n");
+	exit(0);
+}
+
+void signal_usr1(int signum, siginfo_t *info, void *uc)
+{
+	ucontext_t *ucp = uc;
+
+	/* link tm checkpointed context to normal context */
+	ucp->uc_link = ucp;
+	/* set all TM bits */
+#ifdef __powerpc64__
+	ucp->uc_mcontext.gp_regs[PT_MSR] |= (7ULL << 32);
+#else
+	ucp->uc_mcontext.regs->gpr[PT_MSR] |= (7ULL);
+#endif
+	/* Should segv on return becuase of invalid context */
+	act.sa_sigaction = signal_segv;
+	if (sigaction(SIGSEGV, &act, NULL) < 0) {
+		perror("sigaction sigsegv");
+		exit(1);
+	}
+}
+
+int tm_signal_msr_resv()
+{
+
+	act.sa_sigaction = signal_usr1;
+	sigemptyset(&act.sa_mask);
+	act.sa_flags = SA_SIGINFO;
+	if (sigaction(SIGUSR1, &act, NULL) < 0) {
+		perror("sigaction sigusr1");
+		exit(1);
+	}
+
+	raise(SIGUSR1);
+
+	printf("FAILED\n");
+	return 1;
+}
+
+int main(void)
+{
+	return test_harness(tm_signal_msr_resv, "tm_signal_msr_resv");
+}
-- 
2.5.0

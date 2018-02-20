Return-Path: <cyrilbur@gmail.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zlhCs334GzDrbP
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 20 Feb 2018 11:23:05 +1100 (AEDT)
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w1K0JZoD048551
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 19 Feb 2018 19:23:03 -0500
Received: from e06smtp10.uk.ibm.com (e06smtp10.uk.ibm.com [195.75.94.106])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2g85nmp5d0-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 19 Feb 2018 19:23:02 -0500
Received: from localhost
 by e06smtp10.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <cyrilbur@gmail.com>;
 Tue, 20 Feb 2018 00:23:01 -0000
From: Cyril Bur <cyrilbur@gmail.com>
To: mikey@neuling.org, benh@kernel.crashing.org, linuxppc-dev@lists.ozlabs.org
Subject: [RFC PATCH 03/12] selftests/powerpc: Add tm-signal-drop-transaction
 TM test
Date: Tue, 20 Feb 2018 11:22:32 +1100
In-Reply-To: <20180220002241.29648-1-cyrilbur@gmail.com>
References: <20180220002241.29648-1-cyrilbur@gmail.com>
Message-Id: <20180220002241.29648-4-cyrilbur@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This test uses a signal to 'discard' a transaction. That is, it will
take a signal of a thread in a suspended transaction and just remove
the suspended MSR bit. Because this will send the userspace thread back
to the tebgin + 4 address, we should also set CR0 to be nice.

Signed-off-by: Cyril Bur <cyrilbur@gmail.com>
---
 tools/testing/selftests/powerpc/tm/Makefile        |  1 +
 .../powerpc/tm/tm-signal-drop-transaction.c        | 74 ++++++++++++++++++++++
 2 files changed, 75 insertions(+)
 create mode 100644 tools/testing/selftests/powerpc/tm/tm-signal-drop-transaction.c

diff --git a/tools/testing/selftests/powerpc/tm/Makefile b/tools/testing/selftests/powerpc/tm/Makefile
index a23453943ad2..7a1e53297588 100644
--- a/tools/testing/selftests/powerpc/tm/Makefile
+++ b/tools/testing/selftests/powerpc/tm/Makefile
@@ -4,6 +4,7 @@ SIGNAL_CONTEXT_CHK_TESTS := tm-signal-context-chk-gpr tm-signal-context-chk-fpu
 
 TEST_GEN_PROGS := tm-resched-dscr tm-syscall tm-signal-msr-resv tm-signal-stack \
 	tm-vmxcopy tm-fork tm-tar tm-tmspr tm-vmx-unavail tm-unavailable tm-trap \
+	tm-signal-drop-transaction \
 	$(SIGNAL_CONTEXT_CHK_TESTS)
 
 include ../../lib.mk
diff --git a/tools/testing/selftests/powerpc/tm/tm-signal-drop-transaction.c b/tools/testing/selftests/powerpc/tm/tm-signal-drop-transaction.c
new file mode 100644
index 000000000000..a8397f7e7faa
--- /dev/null
+++ b/tools/testing/selftests/powerpc/tm/tm-signal-drop-transaction.c
@@ -0,0 +1,74 @@
+/*
+ * Copyright 2018, Cyril Bur, IBM Corp.
+ * Licensed under GPLv2.
+ *
+ * This test uses a signal handler to make a thread go from
+ * transactional state to nothing state. In practice userspace, why
+ * would userspace ever do this? In theory, they can.
+ */
+
+#include <errno.h>
+#include <inttypes.h>
+#include <pthread.h>
+#include <signal.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <unistd.h>
+
+#include "utils.h"
+#include "tm.h"
+
+static bool passed;
+
+static void signal_usr1(int signum, siginfo_t *info, void *uc)
+{
+	ucontext_t *ucp = uc;
+	struct pt_regs *regs = ucp->uc_mcontext.regs;
+
+	passed = true;
+
+	/* I really hope I got that right, we wan't to clear both the MSR_TS bits */
+	regs->msr &= ~(3ULL << 33);
+	/* Set CR0 to 0b0010 */
+	regs->ccr &= ~(0xDULL << 28);
+}
+
+int test_drop(void)
+{
+	struct sigaction act;
+
+	SKIP_IF(!have_htm());
+
+	act.sa_sigaction = signal_usr1;
+	sigemptyset(&act.sa_mask);
+	act.sa_flags = SA_SIGINFO;
+	if (sigaction(SIGUSR1, &act, NULL) < 0) {
+		perror("sigaction sigusr1");
+		exit(1);
+	}
+
+
+	asm __volatile__(
+		"tbegin.;"
+		"beq    1f; "
+		"tsuspend.;"
+		"1: ;"
+		: : : "memory", "cr0");
+
+	if (!passed && !tcheck_transactional()) {
+		fprintf(stderr, "Not in suspended state: 0x%1x\n", tcheck());
+		exit(1);
+	}
+
+	kill(getpid(), SIGUSR1);
+
+	/* If we reach here, we've passed.  Otherwise we've probably crashed
+	 * the kernel */
+
+	return 0;
+}
+
+int main(int argc, char *argv[])
+{
+	return test_harness(test_drop, "tm_signal_drop_transaction");
+}
-- 
2.16.2

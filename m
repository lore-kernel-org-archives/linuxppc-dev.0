Return-Path: <cyrilbur@gmail.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sDZpY2wxhzDr4h
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 17 Aug 2016 13:44:05 +1000 (AEST)
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u7H3i2lg105372
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 16 Aug 2016 23:44:03 -0400
Received: from e23smtp08.au.ibm.com (e23smtp08.au.ibm.com [202.81.31.141])
 by mx0a-001b2d01.pphosted.com with ESMTP id 24t0330rn4-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 16 Aug 2016 23:44:03 -0400
Received: from localhost
 by e23smtp08.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <cyrilbur@gmail.com>;
 Wed, 17 Aug 2016 13:43:55 +1000
Received: from d23relay10.au.ibm.com (d23relay10.au.ibm.com [9.190.26.77])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id 2CEA92CE806B
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 17 Aug 2016 13:43:53 +1000 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay10.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u7H3hrhS21430476
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 17 Aug 2016 13:43:53 +1000
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u7H3hqrg023548
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 17 Aug 2016 13:43:52 +1000
From: Cyril Bur <cyrilbur@gmail.com>
To: linuxppc-dev@lists.ozlabs.org, wei.guo.simon@gmail.com
Cc: mikey@neuling.org, anton@samba.org
Subject: [PATCH v3 16/21] selftests/powerpc: Add checks for transactional FPUs
 in signal contexts
Date: Wed, 17 Aug 2016 13:43:18 +1000
In-Reply-To: <20160817034323.23053-1-cyrilbur@gmail.com>
References: <20160817034323.23053-1-cyrilbur@gmail.com>
Message-Id: <20160817034323.23053-17-cyrilbur@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

If a thread receives a signal while transactional the kernel creates a
second context to show the transactional state of the process. This
test loads some known values and waits for a signal and confirms that
the expected values are in the signal context.

Signed-off-by: Cyril Bur <cyrilbur@gmail.com>
---
 tools/testing/selftests/powerpc/tm/Makefile        |  2 +-
 .../powerpc/tm/tm-signal-context-chk-fpu.c         | 92 ++++++++++++++++++++++
 2 files changed, 93 insertions(+), 1 deletion(-)
 create mode 100644 tools/testing/selftests/powerpc/tm/tm-signal-context-chk-fpu.c

diff --git a/tools/testing/selftests/powerpc/tm/Makefile b/tools/testing/selftests/powerpc/tm/Makefile
index 2b6fe8f..103648f 100644
--- a/tools/testing/selftests/powerpc/tm/Makefile
+++ b/tools/testing/selftests/powerpc/tm/Makefile
@@ -1,4 +1,4 @@
-SIGNAL_CONTEXT_CHK_TESTS := tm-signal-context-chk-gpr
+SIGNAL_CONTEXT_CHK_TESTS := tm-signal-context-chk-gpr tm-signal-context-chk-fpu
 
 TEST_PROGS := tm-resched-dscr tm-syscall tm-signal-msr-resv tm-signal-stack \
 	tm-vmxcopy tm-fork tm-tar tm-tmspr $(SIGNAL_CONTEXT_CHK_TESTS)
diff --git a/tools/testing/selftests/powerpc/tm/tm-signal-context-chk-fpu.c b/tools/testing/selftests/powerpc/tm/tm-signal-context-chk-fpu.c
new file mode 100644
index 0000000..c760deb
--- /dev/null
+++ b/tools/testing/selftests/powerpc/tm/tm-signal-context-chk-fpu.c
@@ -0,0 +1,92 @@
+/*
+ * Copyright 2016, Cyril Bur, IBM Corp.
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version
+ * 2 of the License, or (at your option) any later version.
+ *
+ *
+ * Test the kernel's signal frame code.
+ *
+ * The kernel sets up two sets of ucontexts if the signal was to be
+ * delivered while the thread was in a transaction.
+ * Expected behaviour is that the checkpointed state is in the user
+ * context passed to the signal handler. The speculated state can be
+ * accessed with the uc_link pointer.
+ *
+ * The rationale for this is that if TM unaware code (which linked
+ * against TM libs) installs a signal handler it will not know of the
+ * speculative nature of the 'live' registers and may infer the wrong
+ * thing.
+ */
+
+#include <stdlib.h>
+#include <stdio.h>
+#include <signal.h>
+#include <unistd.h>
+
+#include <altivec.h>
+
+#include "utils.h"
+#include "tm.h"
+
+#define MAX_ATTEMPT 500000
+
+#define NV_FPU_REGS 18
+
+long tm_signal_self_context_load(pid_t pid, long *gprs, double *fps, vector int *vms, vector int *vss);
+
+/* Be sure there are 2x as many as there are NV FPU regs (2x18) */
+static double fps[] = {
+	 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18,
+	-1,-2,-3,-4,-5,-6,-7,-8,-9,-10,-11,-12,-13,-14,-15,-16,-17,-18
+};
+
+static sig_atomic_t fail;
+
+static void signal_usr1(int signum, siginfo_t *info, void *uc)
+{
+	int i;
+	ucontext_t *ucp = uc;
+	ucontext_t *tm_ucp = ucp->uc_link;
+
+	for (i = 0; i < NV_FPU_REGS && !fail; i++) {
+		fail = (ucp->uc_mcontext.fp_regs[i + 14] != fps[i]);
+		fail |= (tm_ucp->uc_mcontext.fp_regs[i + 14] != fps[i + NV_FPU_REGS]);
+		if (fail)
+			printf("Failed on %d FP %g or %g\n", i, ucp->uc_mcontext.fp_regs[i + 14], tm_ucp->uc_mcontext.fp_regs[i + 14]);
+	}
+}
+
+static int tm_signal_context_chk_fpu()
+{
+	struct sigaction act;
+	int i;
+	long rc;
+	pid_t pid = getpid();
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
+	i = 0;
+	while (i < MAX_ATTEMPT && !fail) {
+		rc = tm_signal_self_context_load(pid, NULL, fps, NULL, NULL);
+		FAIL_IF(rc != pid);
+		i++;
+	}
+
+	return fail;
+}
+
+int main(void)
+{
+	return test_harness(tm_signal_context_chk_fpu, "tm_signal_context_chk_fpu");
+}
-- 
2.9.3

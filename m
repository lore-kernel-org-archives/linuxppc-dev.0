Return-Path: <cyrilbur@gmail.com>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rfY3442T6zDqts
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 29 Jun 2016 16:40:48 +1000 (AEST)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3rfY340xp9z9t0X
 for <linuxppc-dev@ozlabs.org>; Wed, 29 Jun 2016 16:40:47 +1000 (AEST)
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u5T6d52F100468
 for <linuxppc-dev@ozlabs.org>; Wed, 29 Jun 2016 02:40:46 -0400
Received: from e23smtp03.au.ibm.com (e23smtp03.au.ibm.com [202.81.31.145])
 by mx0a-001b2d01.pphosted.com with ESMTP id 23usua0p1x-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@ozlabs.org>; Wed, 29 Jun 2016 02:40:46 -0400
Received: from localhost
 by e23smtp03.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <cyrilbur@gmail.com>;
 Wed, 29 Jun 2016 16:40:42 +1000
Received: from d23relay06.au.ibm.com (d23relay06.au.ibm.com [9.185.63.219])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id 688462CE8056
 for <linuxppc-dev@ozlabs.org>; Wed, 29 Jun 2016 16:40:40 +1000 (EST)
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay06.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u5T6eepx8126742
 for <linuxppc-dev@ozlabs.org>; Wed, 29 Jun 2016 16:40:40 +1000
Received: from d23av04.au.ibm.com (localhost [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u5T6eeTX022507
 for <linuxppc-dev@ozlabs.org>; Wed, 29 Jun 2016 16:40:40 +1000
From: Cyril Bur <cyrilbur@gmail.com>
To: linuxppc-dev@ozlabs.org
Cc: anton@samba.org, mikey@neuling.org
Subject: [RFC 1/3] selftests/powerpc: Add test to check TM ucontext creation
Date: Wed, 29 Jun 2016 16:34:34 +1000
In-Reply-To: <20160629063436.10003-1-cyrilbur@gmail.com>
References: <20160629063436.10003-1-cyrilbur@gmail.com>
Message-Id: <20160629063436.10003-2-cyrilbur@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Signed-off-by: Cyril Bur <cyrilbur@gmail.com>
---
 .../selftests/powerpc/tm/tm-signal-context-chk.c   | 102 +++++++++++++++++++++
 1 file changed, 102 insertions(+)
 create mode 100644 tools/testing/selftests/powerpc/tm/tm-signal-context-chk.c

diff --git a/tools/testing/selftests/powerpc/tm/tm-signal-context-chk.c b/tools/testing/selftests/powerpc/tm/tm-signal-context-chk.c
new file mode 100644
index 0000000..4c906cf
--- /dev/null
+++ b/tools/testing/selftests/powerpc/tm/tm-signal-context-chk.c
@@ -0,0 +1,102 @@
+/*
+ * Copyright 2016, Cyril Bur, IBM Corp.
+ * Licensed under GPLv2.
+ *
+ * Test the kernel's signal frame code.
+ *
+ * The kernel sets up two sets of ucontexts if the signal was to be delivered
+ * while the thread was in a transaction. Expected behaviour is that the
+ * currently executing code is in the first and the checkpointed state (the
+ * state that will be rolled back to) is in the uc_link ucontext.
+ *
+ * The reason for this is that code which is not TM aware and installs a signal
+ * handler will expect to see/modify its currently running state in the uc,
+ * this code may have dynamicially linked against code which is TM aware and is
+ * doing HTM under the hood.
+ */
+
+#include <stdlib.h>
+#include <stdio.h>
+#include <signal.h>
+#include <unistd.h>
+
+#include "utils.h"
+#include "tm.h"
+
+#define TBEGIN          ".long 0x7C00051D ;"
+#define TSUSPEND        ".long 0x7C0005DD ;"
+#define TRESUME         ".long 0x7C2005DD ;"
+#define MAX_ATTEMPT 100
+
+static double fps[] = { 1, 2, 3, 4, 5, 6, 7, 8,
+						-1, -2, -3, -4, -5, -6, -7, -8 };
+
+extern long tm_signal_self(pid_t pid, double *fps);
+
+static int signaled;
+static int fail;
+
+static void signal_usr1(int signum, siginfo_t *info, void *uc)
+{
+	int i;
+	ucontext_t *ucp = uc;
+	ucontext_t *tm_ucp = ucp->uc_link;
+
+	signaled = 1;
+
+	/* Always be 64bit, don't really care about 32bit */
+	for (i = 0; i < 8 && !fail; i++) {
+		fail = (ucp->uc_mcontext.gp_regs[i + 14] != i);
+		fail |= (tm_ucp->uc_mcontext.gp_regs[i + 14] != 0xFF - i);
+	}
+	if (fail) {
+		printf("Failed on %d gpr %lu or %lu\n", i - 1, ucp->uc_mcontext.gp_regs[i + 13], tm_ucp->uc_mcontext.gp_regs[i + 13]);
+		return;
+	}
+	for (i = 0; i < 8 && !fail; i++) {
+		fail = (ucp->uc_mcontext.fp_regs[i + 14] != fps[i]);
+		fail |= (tm_ucp->uc_mcontext.fp_regs[i + 14] != fps[i + 8]);
+	}
+	if (fail) {
+		printf("Failed on %d FP %g or %g\n", i - 1, ucp->uc_mcontext.fp_regs[i + 13], tm_ucp->uc_mcontext.fp_regs[i + 13]);
+	}
+}
+
+static int tm_signal_context_chk()
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
+	while (!signaled && i < MAX_ATTEMPT) {
+		rc = tm_signal_self(pid, fps);
+		if (!rc) {
+			fprintf(stderr, "Transaction was not doomed...\n");
+			FAIL_IF(!rc);
+		}
+		i++;
+	}
+
+	if (i == MAX_ATTEMPT) {
+		fprintf(stderr, "Tried to signal %d times and didn't work, failing!\n", MAX_ATTEMPT);
+		fail = 1;
+	}
+	return fail;
+}
+
+int main(void)
+{
+	return test_harness(tm_signal_context_chk, "tm_signal_context_chk");
+}
-- 
2.9.0

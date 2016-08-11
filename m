Return-Path: <cyrilbur@gmail.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3s9PNz3l5LzDr8S
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 12 Aug 2016 09:29:23 +1000 (AEST)
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u7BNShLi080500
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Aug 2016 19:29:21 -0400
Received: from e23smtp02.au.ibm.com (e23smtp02.au.ibm.com [202.81.31.144])
 by mx0a-001b2d01.pphosted.com with ESMTP id 24qm9v82eu-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Aug 2016 19:29:21 -0400
Received: from localhost
 by e23smtp02.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <cyrilbur@gmail.com>;
 Fri, 12 Aug 2016 09:29:19 +1000
Received: from d23relay10.au.ibm.com (d23relay10.au.ibm.com [9.190.26.77])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id 6EDB43578057
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 12 Aug 2016 09:29:16 +1000 (EST)
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay10.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u7BNTG3M28442710
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 12 Aug 2016 09:29:16 +1000
Received: from d23av03.au.ibm.com (localhost [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u7BNTGX4023378
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 12 Aug 2016 09:29:16 +1000
From: Cyril Bur <cyrilbur@gmail.com>
To: linuxppc-dev@lists.ozlabs.org, wei.guo.simon@gmail.com
Cc: anton@samba.org, mikey@neuling.org
Subject: [PATCH v2 17/20] selftests/powerpc: Add checks for transactional VSXs
 in signal contexts
Date: Fri, 12 Aug 2016 09:28:16 +1000
In-Reply-To: <20160811232819.11453-1-cyrilbur@gmail.com>
References: <20160811232819.11453-1-cyrilbur@gmail.com>
Message-Id: <20160811232819.11453-18-cyrilbur@gmail.com>
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
 tools/testing/selftests/powerpc/tm/Makefile        |   2 +-
 .../powerpc/tm/tm-signal-context-chk-vsx.c         | 125 +++++++++++++++++++++
 2 files changed, 126 insertions(+), 1 deletion(-)
 create mode 100644 tools/testing/selftests/powerpc/tm/tm-signal-context-chk-vsx.c

diff --git a/tools/testing/selftests/powerpc/tm/Makefile b/tools/testing/selftests/powerpc/tm/Makefile
index 06c44aa..9d53f8b 100644
--- a/tools/testing/selftests/powerpc/tm/Makefile
+++ b/tools/testing/selftests/powerpc/tm/Makefile
@@ -1,5 +1,5 @@
 SIGNAL_CONTEXT_CHK_TESTS := tm-signal-context-chk-gpr tm-signal-context-chk-fpu \
-	tm-signal-context-chk-vmx
+	tm-signal-context-chk-vmx tm-signal-context-chk-vsx
 
 TEST_PROGS := tm-resched-dscr tm-syscall tm-signal-msr-resv tm-signal-stack \
 	tm-vmxcopy tm-fork tm-tar tm-tmspr $(SIGNAL_CONTEXT_CHK_TESTS)
diff --git a/tools/testing/selftests/powerpc/tm/tm-signal-context-chk-vsx.c b/tools/testing/selftests/powerpc/tm/tm-signal-context-chk-vsx.c
new file mode 100644
index 0000000..b99c3d8
--- /dev/null
+++ b/tools/testing/selftests/powerpc/tm/tm-signal-context-chk-vsx.c
@@ -0,0 +1,125 @@
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
+#include <string.h>
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
+#define NV_VSX_REGS 12
+
+long tm_signal_self_context_load(pid_t pid, long *gprs, double *fps, vector int *vms, vector int *vss);
+
+static sig_atomic_t fail;
+
+vector int vss[] = {
+	{1, 2, 3, 4 },{5, 6, 7, 8 },{9, 10,11,12},
+	{13,14,15,16},{17,18,19,20},{21,22,23,24},
+	{25,26,27,28},{29,30,31,32},{33,34,35,36},
+	{37,38,39,40},{41,42,43,44},{45,46,47,48},
+	{-1, -2, -3, -4 },{-5, -6, -7, -8 },{-9, -10,-11,-12},
+	{-13,-14,-15,-16},{-17,-18,-19,-20},{-21,-22,-23,-24},
+	{-25,-26,-27,-28},{-29,-30,-31,-32},{-33,-34,-35,-36},
+	{-37,-38,-39,-40},{-41,-42,-43,-44},{-45,-46,-47,-48}
+};
+
+static void signal_usr1(int signum, siginfo_t *info, void *uc)
+{
+	int i;
+	uint8_t vsc[sizeof(vector int)];
+	uint8_t vst[sizeof(vector int)];
+	ucontext_t *ucp = uc;
+	ucontext_t *tm_ucp = ucp->uc_link;
+
+	/*
+	 * The other half of the VSX regs will be after v_regs.
+	 *
+	 * In short, vmx_reserve array holds everything. v_regs is a 16
+	 * byte aligned pointer at the start of vmx_reserve (vmx_reserve
+	 * may or may not be 16 aligned) where the v_regs structure exists.
+	 * (half of) The VSX regsters are directly after v_regs so the
+	 * easiest way to find them below.
+	 */
+	long *vsx_ptr = (long *)(ucp->uc_mcontext.v_regs + 1);
+	long *tm_vsx_ptr = (long *)(tm_ucp->uc_mcontext.v_regs + 1);
+	for (i = 0; i < NV_VSX_REGS && !fail; i++) {
+		memcpy(vsc, &ucp->uc_mcontext.fp_regs[i + 20], 8);
+		memcpy(vsc + 8, &vsx_ptr[20 + i], 8);
+		fail = memcmp(vsc, &vss[i], sizeof(vector int));
+		memcpy(vst, &tm_ucp->uc_mcontext.fp_regs[i + 20], 8);
+		memcpy(vst + 8, &tm_vsx_ptr[20 + i], 8);
+		fail |= memcmp(vst, &vss[i + NV_VSX_REGS], sizeof(vector int));
+
+		if (fail) {
+			int j;
+
+			fprintf(stderr, "Failed on %d vsx 0x", i);
+			for (j = 0; j < 16; j++)
+				fprintf(stderr, "%02x", vsc[j]);
+			fprintf(stderr, " vs 0x");
+			for (j = 0; j < 16; j++)
+				fprintf(stderr, "%02x", vst[j]);
+			fprintf(stderr, "\n");
+		}
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
+	while (i < MAX_ATTEMPT && !fail) {
+		rc = tm_signal_self_context_load(pid, NULL, NULL, NULL, vss);
+		FAIL_IF(rc != pid);
+		i++;
+	}
+
+	return fail;
+}
+
+int main(void)
+{
+	return test_harness(tm_signal_context_chk, "tm_signal_context_chk_vsx");
+}
-- 
2.9.2

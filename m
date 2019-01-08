Return-Path: <SRS0=hsDs=PQ=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 294C0C43387
	for <linuxppc-dev@archiver.kernel.org>; Tue,  8 Jan 2019 11:33:18 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 58849206C0
	for <linuxppc-dev@archiver.kernel.org>; Tue,  8 Jan 2019 11:33:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 58849206C0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43YqrW0dHwzDqQF
	for <linuxppc-dev@archiver.kernel.org>; Tue,  8 Jan 2019 22:33:15 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=none (mailfrom) smtp.mailfrom=debian.org
 (client-ip=148.163.158.5; helo=mx0a-001b2d01.pphosted.com;
 envelope-from=leitao@debian.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=debian.org
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43YqpV0RkQzDqSW
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  8 Jan 2019 22:31:29 +1100 (AEDT)
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 x08BSq19140134
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 8 Jan 2019 06:31:27 -0500
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2pvrs7g68e-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 08 Jan 2019 06:31:27 -0500
Received: from localhost
 by e34.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <leitao@debian.org>;
 Tue, 8 Jan 2019 11:31:26 -0000
Received: from b03cxnp08028.gho.boulder.ibm.com (9.17.130.20)
 by e34.co.us.ibm.com (192.168.1.134) with IBM ESMTP SMTP Gateway: Authorized
 Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Tue, 8 Jan 2019 11:31:24 -0000
Received: from b03ledav004.gho.boulder.ibm.com
 (b03ledav004.gho.boulder.ibm.com [9.17.130.235])
 by b03cxnp08028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 x08BVNxd23461948
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Tue, 8 Jan 2019 11:31:23 GMT
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 152CF78064;
 Tue,  8 Jan 2019 11:31:23 +0000 (GMT)
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id AD1E87805E;
 Tue,  8 Jan 2019 11:31:21 +0000 (GMT)
Received: from debra.ibm.com (unknown [9.18.239.29])
 by b03ledav004.gho.boulder.ibm.com (Postfix) with ESMTP;
 Tue,  8 Jan 2019 11:31:21 +0000 (GMT)
From: Breno Leitao <leitao@debian.org>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v4] selftests/powerpc: New TM signal self test
Date: Tue,  8 Jan 2019 09:31:21 -0200
X-Mailer: git-send-email 1.8.3.1
X-TM-AS-GCONF: 00
x-cbid: 19010811-0016-0000-0000-0000096FF9D1
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00010366; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000274; SDB=6.01143471; UDB=6.00595302; IPR=6.00923728; 
 MB=3.00025031; MTD=3.00000008; XFM=3.00000015; UTC=2019-01-08 11:31:26
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19010811-0017-0000-0000-000041AF9E37
Message-Id: <1546947081-18969-1-git-send-email-leitao@debian.org>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-01-08_07:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=895 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1901080096
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Cc: mikey@neuling.org, Breno Leitao <leitao@debian.org>,
 gromero@linux.vnet.ibm.com
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

A new self test that forces MSR[TS] to be set without calling any TM
instruction. This test also tries to cause a page fault at a signal
handler, exactly between MSR[TS] set and tm_recheckpoint(), forcing
thread->texasr to be rewritten with TEXASR[FS] = 0, which will cause a BUG
when tm_recheckpoint() is called.

This test is not deterministic, since it is hard to guarantee that the page
access will cause a page fault. In order to force more page faults at
signal context, the signal handler and the ucontext are being mapped into a
MADV_DONTNEED memory chunks.

Tests have shown that the bug could be exposed with few interactions in a
buggy kernel. This test is configured to loop 5000x, having a good chance
to hit the kernel issue in just one run.  This self test takes less than
two seconds to run.

This test uses set/getcontext because the kernel will recheckpoint
zeroed structures, causing the test to segfault, which is undesired because
the test needs to rerun, so, there is a signal handler for SIGSEGV which
will restart the test.

v2: Uses the MADV_DONTNEED memory advice
v3: Fix memcpy and 32-bits compilation
v4: Does not define unused macros

Signed-off-by: Breno Leitao <leitao@debian.org>
---
 tools/testing/selftests/powerpc/include/reg.h |   8 +
 .../testing/selftests/powerpc/include/utils.h |   2 +
 tools/testing/selftests/powerpc/tm/.gitignore |   1 +
 tools/testing/selftests/powerpc/tm/Makefile   |   4 +-
 .../powerpc/tm/tm-signal-context-force-tm.c   | 184 ++++++++++++++++++
 5 files changed, 198 insertions(+), 1 deletion(-)
 create mode 100644 tools/testing/selftests/powerpc/tm/tm-signal-context-force-tm.c

diff --git a/tools/testing/selftests/powerpc/include/reg.h b/tools/testing/selftests/powerpc/include/reg.h
index 52b4710469d2..a69ab6e2afd9 100644
--- a/tools/testing/selftests/powerpc/include/reg.h
+++ b/tools/testing/selftests/powerpc/include/reg.h
@@ -77,6 +77,14 @@
 #define TEXASR_TE	0x0000000004000000
 #define TEXASR_ROT	0x0000000002000000
 
+/* MSR register bits */
+#define MSR_TS_S_LG     33              /* Trans Mem state: Suspended */
+
+#define __MASK(X)       (1UL<<(X))
+
+/* macro to check TM MSR bits */
+#define MSR_TS_S        __MASK(MSR_TS_S_LG)   /* Transaction Suspended */
+
 /* Vector Instructions */
 #define VSX_XX1(xs, ra, rb)	(((xs) & 0x1f) << 21 | ((ra) << 16) |  \
 				 ((rb) << 11) | (((xs) >> 5)))
diff --git a/tools/testing/selftests/powerpc/include/utils.h b/tools/testing/selftests/powerpc/include/utils.h
index ae43a614835d..7636bf45d5d5 100644
--- a/tools/testing/selftests/powerpc/include/utils.h
+++ b/tools/testing/selftests/powerpc/include/utils.h
@@ -102,8 +102,10 @@ do {								\
 
 #if defined(__powerpc64__)
 #define UCONTEXT_NIA(UC)	(UC)->uc_mcontext.gp_regs[PT_NIP]
+#define UCONTEXT_MSR(UC)	(UC)->uc_mcontext.gp_regs[PT_MSR]
 #elif defined(__powerpc__)
 #define UCONTEXT_NIA(UC)	(UC)->uc_mcontext.uc_regs->gregs[PT_NIP]
+#define UCONTEXT_MSR(UC)	(UC)->uc_mcontext.uc_regs->gregs[PT_MSR]
 #else
 #error implement UCONTEXT_NIA
 #endif
diff --git a/tools/testing/selftests/powerpc/tm/.gitignore b/tools/testing/selftests/powerpc/tm/.gitignore
index 208452a93e2c..951fe855f7cd 100644
--- a/tools/testing/selftests/powerpc/tm/.gitignore
+++ b/tools/testing/selftests/powerpc/tm/.gitignore
@@ -11,6 +11,7 @@ tm-signal-context-chk-fpu
 tm-signal-context-chk-gpr
 tm-signal-context-chk-vmx
 tm-signal-context-chk-vsx
+tm-signal-context-force-tm
 tm-signal-sigreturn-nt
 tm-vmx-unavail
 tm-unavailable
diff --git a/tools/testing/selftests/powerpc/tm/Makefile b/tools/testing/selftests/powerpc/tm/Makefile
index 75a685359129..c0734ed0ef56 100644
--- a/tools/testing/selftests/powerpc/tm/Makefile
+++ b/tools/testing/selftests/powerpc/tm/Makefile
@@ -4,7 +4,8 @@ SIGNAL_CONTEXT_CHK_TESTS := tm-signal-context-chk-gpr tm-signal-context-chk-fpu
 
 TEST_GEN_PROGS := tm-resched-dscr tm-syscall tm-signal-msr-resv tm-signal-stack \
 	tm-vmxcopy tm-fork tm-tar tm-tmspr tm-vmx-unavail tm-unavailable tm-trap \
-	$(SIGNAL_CONTEXT_CHK_TESTS) tm-sigreturn tm-signal-sigreturn-nt
+	$(SIGNAL_CONTEXT_CHK_TESTS) tm-sigreturn tm-signal-sigreturn-nt \
+	tm-signal-context-force-tm
 
 top_srcdir = ../../../../..
 include ../../lib.mk
@@ -20,6 +21,7 @@ $(OUTPUT)/tm-vmx-unavail: CFLAGS += -pthread -m64
 $(OUTPUT)/tm-resched-dscr: ../pmu/lib.c
 $(OUTPUT)/tm-unavailable: CFLAGS += -O0 -pthread -m64 -Wno-error=uninitialized -mvsx
 $(OUTPUT)/tm-trap: CFLAGS += -O0 -pthread -m64
+$(OUTPUT)/tm-signal-context-force-tm: CFLAGS += -pthread -m64
 
 SIGNAL_CONTEXT_CHK_TESTS := $(patsubst %,$(OUTPUT)/%,$(SIGNAL_CONTEXT_CHK_TESTS))
 $(SIGNAL_CONTEXT_CHK_TESTS): tm-signal.S
diff --git a/tools/testing/selftests/powerpc/tm/tm-signal-context-force-tm.c b/tools/testing/selftests/powerpc/tm/tm-signal-context-force-tm.c
new file mode 100644
index 000000000000..31717625f318
--- /dev/null
+++ b/tools/testing/selftests/powerpc/tm/tm-signal-context-force-tm.c
@@ -0,0 +1,184 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright 2018, Breno Leitao, Gustavo Romero, IBM Corp.
+ *
+ * This test raises a SIGUSR1 signal, and toggle the MSR[TS]
+ * fields at the signal handler. With MSR[TS] being set, the kernel will
+ * force a recheckpoint, which may cause a segfault when returning to
+ * user space. Since the test needs to re-run, the segfault needs to be
+ * caught and handled.
+ *
+ * In order to continue the test even after a segfault, the context is
+ * saved prior to the signal being raised, and it is restored when there is
+ * a segmentation fault. This happens for COUNT_MAX times.
+ *
+ * This test never fails (as returning EXIT_FAILURE). It either succeeds,
+ * or crash the kernel (on a buggy kernel).
+ */
+
+#define _GNU_SOURCE
+#include <stdio.h>
+#include <stdlib.h>
+#include <signal.h>
+#include <string.h>
+#include <ucontext.h>
+#include <unistd.h>
+#include <sys/mman.h>
+
+#include "tm.h"
+#include "utils.h"
+#include "reg.h"
+
+#define COUNT_MAX       5000		/* Number of interactions */
+
+/*
+ * This test only runs on 64 bits system. Unsetting MSR_TS_S to avoid
+ * compilation issue on 32 bits system. There is no side effect, since the
+ * whole test will be skipped if it is not running on 64 bits system.
+ */
+#ifndef __powerpc64__
+#undef  MSR_TS_S
+#define MSR_TS_S	0
+#endif
+
+/* Setting contexts because the test will crash and we want to recover */
+ucontext_t init_context, main_context;
+
+static int count, first_time;
+
+void usr_signal_handler(int signo, siginfo_t *si, void *uc)
+{
+	ucontext_t *ucp = uc;
+	int ret;
+
+	/*
+	 * Allocating memory in a signal handler, and never freeing it on
+	 * purpose, forcing the heap increase, so, the memory leak is what
+	 * we want here.
+	 */
+	ucp->uc_link = mmap(NULL, sizeof(ucontext_t),
+			    PROT_READ | PROT_WRITE,
+			    MAP_PRIVATE | MAP_ANONYMOUS, 0, 0);
+	if (ucp->uc_link == (void *)-1) {
+		perror("Mmap failed");
+		exit(-1);
+	}
+
+	/* Forcing the page to be allocated in a page fault */
+	ret = madvise(ucp->uc_link, sizeof(ucontext_t), MADV_DONTNEED);
+	if (ret) {
+		perror("madvise failed");
+		exit(-1);
+	}
+
+	memcpy(&ucp->uc_link->uc_mcontext, &ucp->uc_mcontext,
+		sizeof(ucp->uc_mcontext));
+
+	/* Forcing to enable MSR[TM] */
+	UCONTEXT_MSR(ucp) |= MSR_TS_S;
+
+	/*
+	 * A fork inside a signal handler seems to be more efficient than a
+	 * fork() prior to the signal being raised.
+	 */
+	if (fork() == 0) {
+		/*
+		 * Both child and parent will return, but, child returns
+		 * with count set so it will exit in the next segfault.
+		 * Parent will continue to loop.
+		 */
+		count = COUNT_MAX;
+	}
+
+	/*
+	 * If the change above does not hit the bug, it will cause a
+	 * segmentation fault, since the ck structures are NULL.
+	 */
+}
+
+void seg_signal_handler(int signo, siginfo_t *si, void *uc)
+{
+	if (count == COUNT_MAX) {
+		/* Return to tm_signal_force_msr() and exit */
+		setcontext(&main_context);
+	}
+
+	count++;
+
+	/* Reexecute the test */
+	setcontext(&init_context);
+}
+
+void tm_trap_test(void)
+{
+	struct sigaction usr_sa, seg_sa;
+	stack_t ss;
+
+	usr_sa.sa_flags = SA_SIGINFO | SA_ONSTACK;
+	usr_sa.sa_sigaction = usr_signal_handler;
+
+	seg_sa.sa_flags = SA_SIGINFO;
+	seg_sa.sa_sigaction = seg_signal_handler;
+
+	/*
+	 * Set initial context. Will get back here from
+	 * seg_signal_handler()
+	 */
+	getcontext(&init_context);
+
+	/* Allocated an alternative signal stack area */
+	ss.ss_sp = mmap(NULL, SIGSTKSZ, PROT_READ | PROT_WRITE,
+			MAP_PRIVATE | MAP_ANONYMOUS, 0, 0);
+	ss.ss_size = SIGSTKSZ;
+	ss.ss_flags = 0;
+
+	if (ss.ss_sp == (void *)-1) {
+		perror("mmap error\n");
+		exit(-1);
+	}
+
+	/* Force the allocation through a page fault */
+	if (madvise(ss.ss_sp, SIGSTKSZ, MADV_DONTNEED)) {
+		perror("madvise\n");
+		exit(-1);
+	}
+
+	/* Setting an alternative stack to generate a page fault when
+	 * the signal is raised.
+	 */
+	if (sigaltstack(&ss, NULL)) {
+		perror("sigaltstack\n");
+		exit(-1);
+	}
+
+	/* The signal handler will enable MSR_TS */
+	sigaction(SIGUSR1, &usr_sa, NULL);
+	/* If it does not crash, it will segfault, avoid it to retest */
+	sigaction(SIGSEGV, &seg_sa, NULL);
+
+	raise(SIGUSR1);
+}
+
+int tm_signal_context_force_tm(void)
+{
+	SKIP_IF(!have_htm());
+	/*
+	 * Skipping if not running on 64 bits system, since I think it is
+	 * not possible to set mcontext's [MSR] with TS, due to it being 32
+	 * bits.
+	 */
+	SKIP_IF(!is_ppc64le());
+
+	/* Will get back here after COUNT_MAX interactions */
+	getcontext(&main_context);
+
+	if (!first_time++)
+		tm_trap_test();
+
+	return EXIT_SUCCESS;
+}
+
+int main(int argc, char **argv)
+{
+	test_harness(tm_signal_context_force_tm, "tm_signal_context_force_tm");
+}
-- 
2.19.0


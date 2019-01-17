Return-Path: <SRS0=IbMY=PZ=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7282C43387
	for <linuxppc-dev@archiver.kernel.org>; Thu, 17 Jan 2019 17:03:40 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E707620652
	for <linuxppc-dev@archiver.kernel.org>; Thu, 17 Jan 2019 17:03:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E707620652
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43gVlY4tSqzDqxk
	for <linuxppc-dev@archiver.kernel.org>; Fri, 18 Jan 2019 04:03:37 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=none (mailfrom) smtp.mailfrom=debian.org
 (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com;
 envelope-from=leitao@debian.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=debian.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43gVjp46WpzDqnG
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 18 Jan 2019 04:02:05 +1100 (AEDT)
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 x0HGsPci067744
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 17 Jan 2019 12:02:03 -0500
Received: from e12.ny.us.ibm.com (e12.ny.us.ibm.com [129.33.205.202])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2q2u86fx1y-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 17 Jan 2019 12:02:03 -0500
Received: from localhost
 by e12.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <leitao@debian.org>;
 Thu, 17 Jan 2019 17:02:01 -0000
Received: from b01cxnp23034.gho.pok.ibm.com (9.57.198.29)
 by e12.ny.us.ibm.com (146.89.104.199) with IBM ESMTP SMTP Gateway: Authorized
 Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Thu, 17 Jan 2019 17:01:57 -0000
Received: from b01ledav004.gho.pok.ibm.com (b01ledav004.gho.pok.ibm.com
 [9.57.199.109])
 by b01cxnp23034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 x0HH1uRj18022548
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Thu, 17 Jan 2019 17:01:57 GMT
Received: from b01ledav004.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id BB4CF112066;
 Thu, 17 Jan 2019 17:01:56 +0000 (GMT)
Received: from b01ledav004.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 34956112061;
 Thu, 17 Jan 2019 17:01:55 +0000 (GMT)
Received: from debra.ibm.com (unknown [9.85.149.121])
 by b01ledav004.gho.pok.ibm.com (Postfix) with ESMTP;
 Thu, 17 Jan 2019 17:01:54 +0000 (GMT)
From: Breno Leitao <leitao@debian.org>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH] Selftests/powerpc: Add a signal fuzzer selftest
Date: Thu, 17 Jan 2019 15:01:54 -0200
X-Mailer: git-send-email 1.8.3.1
X-TM-AS-GCONF: 00
x-cbid: 19011717-0060-0000-0000-000002FB3F1E
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00010424; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000275; SDB=6.01147852; UDB=6.00597956; IPR=6.00928150; 
 MB=3.00025174; MTD=3.00000008; XFM=3.00000015; UTC=2019-01-17 17:02:00
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19011717-0061-0000-0000-000047F59F0D
Message-Id: <1547744514-7276-1-git-send-email-leitao@debian.org>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-01-17_05:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=4 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1901170121
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

This is a new selftest that raises SIGUSR1 signals and handles it in a set
of different ways, trying to create different scenario for testing
purpose.

This test works raising a signal and calling sigreturn interleaved with
TM operations, as starting, suspending and terminating a transaction. The
test depends on random numbers, and, based on them, it sets different TM
states.

Other than that, the test fills out the user context struct that is passed
to the sigreturn system call with random data, in order to make sure that
the signal handler syscall can handle different and invalid states
properly.

This selftest has command line parameters to control what kind of tests the
user wants to run, as for example, if a transaction should be started prior
to signal being raised, or, after the signal being raised and before the
sigreturn. If no parameter is given, the default is enabling all options.

This test does not check if the user context is being read and set
properly by the kernel. Its purpose, at this time, is basically
guaranteeing that the kernel does not crash on invalid scenarios.

Signed-off-by: Breno Leitao <leitao@debian.org>
---
 tools/testing/selftests/powerpc/harness.c     |   6 +-
 tools/testing/selftests/powerpc/include/reg.h |   2 +
 .../testing/selftests/powerpc/signal/Makefile |   3 +-
 .../testing/selftests/powerpc/signal/sigfuz.c | 325 ++++++++++++++++++
 4 files changed, 333 insertions(+), 3 deletions(-)
 create mode 100644 tools/testing/selftests/powerpc/signal/sigfuz.c

diff --git a/tools/testing/selftests/powerpc/harness.c b/tools/testing/selftests/powerpc/harness.c
index 9d7166dfad1e..ba89353abfcc 100644
--- a/tools/testing/selftests/powerpc/harness.c
+++ b/tools/testing/selftests/powerpc/harness.c
@@ -21,6 +21,7 @@
 
 #define KILL_TIMEOUT	5
 
+/* Setting timeout to -1 disables the alarm */
 static uint64_t timeout = 120;
 
 int run_test(int (test_function)(void), char *name)
@@ -43,8 +44,9 @@ int run_test(int (test_function)(void), char *name)
 
 	setpgid(pid, pid);
 
-	/* Wake us up in timeout seconds */
-	alarm(timeout);
+	if (timeout != -1)
+		/* Wake us up in timeout seconds */
+		alarm(timeout);
 	terminated = false;
 
 wait:
diff --git a/tools/testing/selftests/powerpc/include/reg.h b/tools/testing/selftests/powerpc/include/reg.h
index a69ab6e2afd9..d577a7ecf3e5 100644
--- a/tools/testing/selftests/powerpc/include/reg.h
+++ b/tools/testing/selftests/powerpc/include/reg.h
@@ -79,11 +79,13 @@
 
 /* MSR register bits */
 #define MSR_TS_S_LG     33              /* Trans Mem state: Suspended */
+#define MSR_TS_T_LG     34              /* Trans Mem state: Active */
 
 #define __MASK(X)       (1UL<<(X))
 
 /* macros to check TM MSR bits */
 #define MSR_TS_S        __MASK(MSR_TS_S_LG)   /* Transaction Suspended */
+#define MSR_TS_T        __MASK(MSR_TS_T_LG)   /* Transaction Transactional */
 
 /* Vector Instructions */
 #define VSX_XX1(xs, ra, rb)	(((xs) & 0x1f) << 21 | ((ra) << 16) |  \
diff --git a/tools/testing/selftests/powerpc/signal/Makefile b/tools/testing/selftests/powerpc/signal/Makefile
index 209a958dca12..113838fbbe7f 100644
--- a/tools/testing/selftests/powerpc/signal/Makefile
+++ b/tools/testing/selftests/powerpc/signal/Makefile
@@ -1,8 +1,9 @@
 # SPDX-License-Identifier: GPL-2.0
-TEST_GEN_PROGS := signal signal_tm
+TEST_GEN_PROGS := signal signal_tm sigfuz
 
 CFLAGS += -maltivec
 $(OUTPUT)/signal_tm: CFLAGS += -mhtm
+$(OUTPUT)/sigfuz: CFLAGS += -pthread -m64
 
 top_srcdir = ../../../../..
 include ../../lib.mk
diff --git a/tools/testing/selftests/powerpc/signal/sigfuz.c b/tools/testing/selftests/powerpc/signal/sigfuz.c
new file mode 100644
index 000000000000..d0b9468b2f37
--- /dev/null
+++ b/tools/testing/selftests/powerpc/signal/sigfuz.c
@@ -0,0 +1,325 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright 2018, Breno Leitao, IBM Corp.
+ * Licensed under GPLv2.
+ *
+ * Sigfuz(tm): A PowerPC TM-aware signal fuzzer.
+ *
+ * This is a new selftest that raises SIGUSR1 signals and handles it in a set
+ * of different ways, trying to create different scenario for testing
+ * purpose.
+ *
+ * This test works raising a signal and calling sigreturn interleaved with
+ * TM operations, as starting, suspending and terminating a transaction. The
+ * test depends on random numbers, and, based on them, it sets different TM
+ * states.
+ *
+ * Other than that, the test fills out the user context struct that is passed
+ * to the sigreturn system call with random data, in order to make sure that
+ * the signal handler syscall can handle different and invalid states
+ * properly.
+ *
+ * This selftest has command line parameters to control what kind of tests the
+ * user wants to run, as for example, if a transaction should be started prior
+ * to signal being raised, or, after the signal being raised and before the
+ * sigreturn. If no parameter is given, the default is enabling all options.
+ *
+ * This test does not check if the user context is being read and set
+ * properly by the kernel. Its purpose, at this time, is basically
+ * guaranteeing that the kernel does not crash on invalid scenarios.
+ */
+
+#include <stdio.h>
+#include <limits.h>
+#include <sys/wait.h>
+#include <unistd.h>
+#include <stdlib.h>
+#include <signal.h>
+#include <string.h>
+#include <ucontext.h>
+#include <sys/mman.h>
+#include <pthread.h>
+#include "utils.h"
+
+/* Selftest defaults */
+#define COUNT_MAX	4000		/* Number of interactions */
+#define THREADS		16		/* Number of threads */
+
+/* Arguments options */
+#define ARG_MESS_WITH_TM_AT	0x1
+#define ARG_MESS_WITH_TM_BEFORE	0x2
+#define ARG_MESS_WITH_MSR_AT	0x4
+#define ARG_FOREVER		0x10
+#define ARG_COMPLETE		(ARG_MESS_WITH_TM_AT |		\
+				ARG_MESS_WITH_TM_BEFORE |	\
+				ARG_MESS_WITH_MSR_AT)
+
+static int args;
+static int nthread = THREADS;
+static int count_max = COUNT_MAX;
+
+/* checkpoint context */
+static ucontext_t *tmp_uc;
+
+/* Return true with 1/x probability */
+static int one_in_chance(int x)
+{
+	return rand() % x == 0;
+}
+
+/* Change TM states */
+static void mess_with_tm(void)
+{
+	/* Starts a transaction 33% of the time */
+	if (one_in_chance(3)) {
+		asm ("tbegin.	;"
+		     "beq 8	;");
+
+		/* And suspended half of them */
+		if (one_in_chance(2))
+			asm("tsuspend.	;");
+	}
+
+	/* Call 'tend' in 5% of the runs */
+	if (one_in_chance(20))
+		asm("tend.	;");
+}
+
+/* Signal handler that will be invoked with raise() */
+static void trap_signal_handler(int signo, siginfo_t *si, void *uc)
+{
+	ucontext_t *ucp = uc;
+
+	ucp->uc_link = tmp_uc;
+
+	/*
+	 * Set uc_link in three possible ways:
+	 *  - Setting a single 'int' in the whole chunk
+	 *  - Cloning ucp into uc_link
+	 *  - Allocating a new memory chunk
+	 */
+	if (one_in_chance(3)) {
+		memset(ucp->uc_link, rand(), sizeof(ucontext_t));
+	} else if (one_in_chance(2)) {
+		memcpy(ucp->uc_link, uc, sizeof(ucontext_t));
+	} else if (one_in_chance(2)) {
+		if (tmp_uc) {
+			free(tmp_uc);
+			tmp_uc = NULL;
+		}
+		tmp_uc = malloc(sizeof(ucontext_t));
+		ucp->uc_link = tmp_uc;
+		/* Trying to cause a major page fault at Kernel level */
+		madvise(ucp->uc_link, sizeof(ucontext_t), MADV_DONTNEED);
+	}
+
+	if (args & ARG_MESS_WITH_MSR_AT) {
+		/* Changing the checkpointed registers */
+		if (one_in_chance(4)) {
+			ucp->uc_link->uc_mcontext.gp_regs[PT_MSR] |= MSR_TS_S;
+		} else {
+			if (one_in_chance(2)) {
+				ucp->uc_link->uc_mcontext.gp_regs[PT_MSR] |=
+						 MSR_TS_T;
+			} else if (one_in_chance(2)) {
+				ucp->uc_link->uc_mcontext.gp_regs[PT_MSR] |=
+						MSR_TS_T | MSR_TS_S;
+			}
+		}
+
+		/* Checking the current register context */
+		if (one_in_chance(2)) {
+			ucp->uc_mcontext.gp_regs[PT_MSR] |= MSR_TS_S;
+		} else if (one_in_chance(2)) {
+			if (one_in_chance(2))
+				ucp->uc_mcontext.gp_regs[PT_MSR] |=
+					MSR_TS_T;
+			else if (one_in_chance(2))
+				ucp->uc_mcontext.gp_regs[PT_MSR] |=
+					MSR_TS_T | MSR_TS_S;
+		}
+	}
+
+	if (one_in_chance(20)) {
+		/* Nested transaction start */
+		if (one_in_chance(5))
+			mess_with_tm();
+
+		/* Return without changing any other context info */
+		return;
+	}
+
+	if (one_in_chance(10))
+		ucp->uc_mcontext.gp_regs[PT_MSR] = random();
+	if (one_in_chance(10))
+		ucp->uc_mcontext.gp_regs[PT_NIP] = random();
+	if (one_in_chance(10))
+		ucp->uc_link->uc_mcontext.gp_regs[PT_MSR] = random();
+	if (one_in_chance(10))
+		ucp->uc_link->uc_mcontext.gp_regs[PT_NIP] = random();
+
+	ucp->uc_mcontext.gp_regs[PT_TRAP] = random();
+	ucp->uc_mcontext.gp_regs[PT_DSISR] = random();
+	ucp->uc_mcontext.gp_regs[PT_DAR] = random();
+	ucp->uc_mcontext.gp_regs[PT_ORIG_R3] = random();
+	ucp->uc_mcontext.gp_regs[PT_XER] = random();
+	ucp->uc_mcontext.gp_regs[PT_RESULT] = random();
+	ucp->uc_mcontext.gp_regs[PT_SOFTE] = random();
+	ucp->uc_mcontext.gp_regs[PT_DSCR] = random();
+	ucp->uc_mcontext.gp_regs[PT_CTR] = random();
+	ucp->uc_mcontext.gp_regs[PT_LNK] = random();
+	ucp->uc_mcontext.gp_regs[PT_CCR] = random();
+	ucp->uc_mcontext.gp_regs[PT_REGS_COUNT] = random();
+
+	ucp->uc_link->uc_mcontext.gp_regs[PT_TRAP] = random();
+	ucp->uc_link->uc_mcontext.gp_regs[PT_DSISR] = random();
+	ucp->uc_link->uc_mcontext.gp_regs[PT_DAR] = random();
+	ucp->uc_link->uc_mcontext.gp_regs[PT_ORIG_R3] = random();
+	ucp->uc_link->uc_mcontext.gp_regs[PT_XER] = random();
+	ucp->uc_link->uc_mcontext.gp_regs[PT_RESULT] = random();
+	ucp->uc_link->uc_mcontext.gp_regs[PT_SOFTE] = random();
+	ucp->uc_link->uc_mcontext.gp_regs[PT_DSCR] = random();
+	ucp->uc_link->uc_mcontext.gp_regs[PT_CTR] = random();
+	ucp->uc_link->uc_mcontext.gp_regs[PT_LNK] = random();
+	ucp->uc_link->uc_mcontext.gp_regs[PT_CCR] = random();
+	ucp->uc_link->uc_mcontext.gp_regs[PT_REGS_COUNT] = random();
+
+	if (args & ARG_MESS_WITH_TM_BEFORE) {
+		if (one_in_chance(2))
+			mess_with_tm();
+	}
+}
+
+static void seg_signal_handler(int signo, siginfo_t *si, void *uc)
+{
+	/* Clear exit for process that segfaults */
+	exit(0);
+}
+
+static void *sigfuz_test(void *thrid)
+{
+	struct sigaction trap_sa, seg_sa;
+	int ret, i = 0;
+	pid_t t;
+
+	tmp_uc = malloc(sizeof(ucontext_t));
+
+	/* Main signal handler */
+	trap_sa.sa_flags = SA_SIGINFO;
+	trap_sa.sa_sigaction = trap_signal_handler;
+
+	/* SIGSEGV signal handler */
+	seg_sa.sa_flags = SA_SIGINFO;
+	seg_sa.sa_sigaction = seg_signal_handler;
+
+	/* The signal handler will enable MSR_TS */
+	sigaction(SIGUSR1, &trap_sa, NULL);
+
+	/* If it does not crash, it will segfault, avoid it to retest */
+	sigaction(SIGSEGV, &seg_sa, NULL);
+
+	while (i < count_max) {
+		t = fork();
+
+		if (t == 0) {
+			/* Once seed per process */
+			srand(time(NULL) + getpid());
+			if (args & ARG_MESS_WITH_TM_AT) {
+				if (one_in_chance(2))
+					mess_with_tm();
+			}
+			raise(SIGUSR1);
+			exit(0);
+		} else {
+			waitpid(t, &ret, 0);
+		}
+		if (!(args & ARG_FOREVER))
+			i++;
+	}
+
+	/* If not freed already, free now */
+	if (tmp_uc) {
+		free(tmp_uc);
+		tmp_uc = NULL;
+	}
+
+	return NULL;
+}
+
+static int signal_fuzzer(void)
+{
+	int t, rc;
+	pthread_t *threads;
+
+	threads = malloc(nthread * sizeof(pthread_t));
+
+	for (t = 0; t < nthread; t++) {
+		rc = pthread_create(&threads[t], NULL, sigfuz_test,
+				    (void *)&t);
+		if (rc)
+			perror("Thread creation error\n");
+	}
+
+	for (t = 0; t < nthread; t++) {
+		rc = pthread_join(threads[t], NULL);
+		if (rc)
+			perror("Thread join error\n");
+	}
+
+	free(threads);
+
+	return EXIT_SUCCESS;
+}
+
+static void show_help(char *name)
+{
+	printf("%s: Sigfuzzer for powerpc\n", name);
+	printf("Usage:\n");
+	printf("\t-b\t Mess with TM before raising a SIGUSR1 signal\n");
+	printf("\t-a\t Mess with TM after raising a SIGUSR1 signal\n");
+	printf("\t-m\t Mess with MSR[TS] bits at mcontext\n");
+	printf("\t-x\t Mess with everything above\n");
+	printf("\t-f\t Run forever (Press ^C to Quit)\n");
+	printf("\t-i\t Amount of interactions.	(Default = %d)\n", COUNT_MAX);
+	printf("\t-t\t Amount of threads.	(Default = %d)\n", THREADS);
+	exit(-1);
+}
+
+int main(int argc, char **argv)
+{
+	int opt;
+
+	while ((opt = getopt(argc, argv, "bamxt:fi:h")) != -1) {
+		if (opt == 'b') {
+			printf("Mess with TM before signal\n");
+			args |= ARG_MESS_WITH_TM_BEFORE;
+		} else if (opt == 'a') {
+			printf("Mess with TM at signal handler\n");
+			args |= ARG_MESS_WITH_TM_AT;
+		} else if (opt == 'm') {
+			printf("Mess with MSR[TS] bits in mcontext\n");
+			args |= ARG_MESS_WITH_MSR_AT;
+		} else if (opt == 'x') {
+			printf("Running with all options enabled\n");
+			args |= ARG_COMPLETE;
+		} else if (opt == 't') {
+			nthread = atoi(optarg);
+			printf("Threads = %d\n", nthread);
+		} else if (opt == 'f') {
+			args |= ARG_FOREVER;
+			printf("Press ^C to stop\n");
+			test_harness_set_timeout(-1);
+		} else if (opt == 'i') {
+			count_max = atoi(optarg);
+			printf("Running for %d interactions\n", count_max);
+		} else if (opt == 'h') {
+			show_help(argv[0]);
+		}
+	}
+
+	/* Default test suite */
+	if (!args)
+		args = ARG_COMPLETE;
+
+	test_harness(signal_fuzzer, "signal_fuzzer");
+}
-- 
2.19.0


Return-Path: <cyrilbur@gmail.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sSmZf2NPFzDrvM
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  6 Sep 2016 09:46:02 +1000 (AEST)
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
 u85NgwK5002850
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 5 Sep 2016 19:46:00 -0400
Received: from e23smtp02.au.ibm.com (e23smtp02.au.ibm.com [202.81.31.144])
 by mx0a-001b2d01.pphosted.com with ESMTP id 259dh6rm84-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 05 Sep 2016 19:46:00 -0400
Received: from localhost
 by e23smtp02.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <cyrilbur@gmail.com>;
 Tue, 6 Sep 2016 09:45:58 +1000
Received: from d23relay07.au.ibm.com (d23relay07.au.ibm.com [9.190.26.37])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id B66CF2BB005A
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  6 Sep 2016 09:45:45 +1000 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay07.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u85NjjPe57606356
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 6 Sep 2016 09:45:45 +1000
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u85NjjJf003721
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 6 Sep 2016 09:45:45 +1000
From: Cyril Bur <cyrilbur@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: wei.guo.simon@gmail.com, mikey@neuling.org
Subject: [PATCH v4 13/20] selftests/powerpc: Check that signals always get
 delivered
Date: Tue,  6 Sep 2016 09:44:41 +1000
In-Reply-To: <20160905234448.5866-1-cyrilbur@gmail.com>
References: <20160905234448.5866-1-cyrilbur@gmail.com>
Message-Id: <20160905234448.5866-14-cyrilbur@gmail.com>
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
 tools/testing/selftests/powerpc/Makefile           |   1 +
 tools/testing/selftests/powerpc/signal/Makefile    |  12 +++
 tools/testing/selftests/powerpc/signal/signal.S    |  50 ++++++++++
 tools/testing/selftests/powerpc/signal/signal.c    | 111 +++++++++++++++++++++
 tools/testing/selftests/powerpc/signal/signal_tm.c | 110 ++++++++++++++++++++
 5 files changed, 284 insertions(+)
 create mode 100644 tools/testing/selftests/powerpc/signal/Makefile
 create mode 100644 tools/testing/selftests/powerpc/signal/signal.S
 create mode 100644 tools/testing/selftests/powerpc/signal/signal.c
 create mode 100644 tools/testing/selftests/powerpc/signal/signal_tm.c

diff --git a/tools/testing/selftests/powerpc/Makefile b/tools/testing/selftests/powerpc/Makefile
index 3c40c9d..96a8593 100644
--- a/tools/testing/selftests/powerpc/Makefile
+++ b/tools/testing/selftests/powerpc/Makefile
@@ -19,6 +19,7 @@ SUB_DIRS = alignment		\
 	   dscr			\
 	   mm			\
 	   pmu			\
+	   signal		\
 	   primitives		\
 	   stringloops		\
 	   switch_endian	\
diff --git a/tools/testing/selftests/powerpc/signal/Makefile b/tools/testing/selftests/powerpc/signal/Makefile
new file mode 100644
index 0000000..97944cf
--- /dev/null
+++ b/tools/testing/selftests/powerpc/signal/Makefile
@@ -0,0 +1,12 @@
+TEST_PROGS := signal signal_tm
+
+all: $(TEST_PROGS)
+
+$(TEST_PROGS): ../harness.c ../utils.c signal.S
+
+signal_tm: CFLAGS += -mhtm
+
+include ../../lib.mk
+
+clean:
+	rm -f $(TEST_PROGS) *.o
diff --git a/tools/testing/selftests/powerpc/signal/signal.S b/tools/testing/selftests/powerpc/signal/signal.S
new file mode 100644
index 0000000..7043d52
--- /dev/null
+++ b/tools/testing/selftests/powerpc/signal/signal.S
@@ -0,0 +1,50 @@
+/*
+ * Copyright 2015, Cyril Bur, IBM Corp.
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version
+ * 2 of the License, or (at your option) any later version.
+ */
+
+#include "../basic_asm.h"
+
+/* long signal_self(pid_t pid, int sig); */
+FUNC_START(signal_self)
+	li	r0,37 /* sys_kill */
+	/* r3 already has our pid in it */
+	/* r4 already has signal type in it */
+	sc
+	bc	4,3,1f
+	subfze	r3,r3
+1:	blr
+FUNC_END(signal_self)
+
+/* long tm_signal_self(pid_t pid, int sig, int *ret); */
+FUNC_START(tm_signal_self)
+	PUSH_BASIC_STACK(8)
+	std	r5,STACK_FRAME_PARAM(0)(sp) /* ret */
+	tbegin.
+	beq	1f
+	tsuspend.
+	li	r0,37 /* sys_kill */
+	/* r3 already has our pid in it */
+	/* r4 already has signal type in it */
+	sc
+	ld	r5,STACK_FRAME_PARAM(0)(sp) /* ret */
+	bc	4,3,2f
+	subfze	r3,r3
+2:	std	r3,0(r5)
+	tabort. 0
+	tresume. /* Be nice to some cleanup, jumps back to tbegin then to 1: */
+	/*
+	 * Transaction should be proper doomed and we should never get
+	 * here
+	 */
+	li	r3,1
+	POP_BASIC_STACK(8)
+	blr
+1:	li	r3,0
+	POP_BASIC_STACK(8)
+	blr
+FUNC_END(tm_signal_self)
diff --git a/tools/testing/selftests/powerpc/signal/signal.c b/tools/testing/selftests/powerpc/signal/signal.c
new file mode 100644
index 0000000..e7dedd2
--- /dev/null
+++ b/tools/testing/selftests/powerpc/signal/signal.c
@@ -0,0 +1,111 @@
+/*
+ * Copyright 2016, Cyril Bur, IBM Corp.
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version
+ * 2 of the License, or (at your option) any later version.
+ *
+ * Sending one self a signal should always get delivered.
+ */
+
+#include <signal.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <sys/types.h>
+#include <sys/wait.h>
+#include <unistd.h>
+
+#include <altivec.h>
+
+#include "utils.h"
+
+#define MAX_ATTEMPT 500000
+#define TIMEOUT 5
+
+extern long signal_self(pid_t pid, int sig);
+
+static sig_atomic_t signaled;
+static sig_atomic_t fail;
+
+static void signal_handler(int sig)
+{
+	if (sig == SIGUSR1)
+		signaled = 1;
+	else
+		fail = 1;
+}
+
+static int test_signal()
+{
+	int i;
+	struct sigaction act;
+	pid_t ppid = getpid();
+	pid_t pid;
+
+	act.sa_handler = signal_handler;
+	act.sa_flags = 0;
+	sigemptyset(&act.sa_mask);
+	if (sigaction(SIGUSR1, &act, NULL) < 0) {
+		perror("sigaction SIGUSR1");
+		exit(1);
+	}
+	if (sigaction(SIGALRM, &act, NULL) < 0) {
+		perror("sigaction SIGALRM");
+		exit(1);
+	}
+
+	/* Don't do this for MAX_ATTEMPT, its simply too long */
+	for(i  = 0; i < 1000; i++) {
+		pid = fork();
+		if (pid == -1) {
+			perror("fork");
+			exit(1);
+		}
+		if (pid == 0) {
+			signal_self(ppid, SIGUSR1);
+			exit(1);
+		} else {
+			alarm(0); /* Disable any pending */
+			alarm(2);
+			while (!signaled && !fail)
+				asm volatile("": : :"memory");
+			if (!signaled) {
+				fprintf(stderr, "Didn't get signal from child\n");
+				FAIL_IF(1); /* For the line number */
+			}
+			/* Otherwise we'll loop too fast and fork() will eventually fail */
+			waitpid(pid, NULL, 0);
+		}
+	}
+
+	for (i = 0; i < MAX_ATTEMPT; i++) {
+		long rc;
+
+		alarm(0); /* Disable any pending */
+		signaled = 0;
+		alarm(TIMEOUT);
+		rc = signal_self(ppid, SIGUSR1);
+		if (rc) {
+			fprintf(stderr, "(%d) Fail reason: %d rc=0x%lx",
+					i, fail, rc);
+			FAIL_IF(1); /* For the line number */
+		}
+		while (!signaled && !fail)
+			asm volatile("": : :"memory");
+		if (!signaled) {
+			fprintf(stderr, "(%d) Fail reason: %d rc=0x%lx",
+					i, fail, rc);
+			FAIL_IF(1); /* For the line number */
+		}
+	}
+
+	return 0;
+}
+
+int main(void)
+{
+	test_harness_set_timeout(300);
+	return test_harness(test_signal, "signal");
+}
diff --git a/tools/testing/selftests/powerpc/signal/signal_tm.c b/tools/testing/selftests/powerpc/signal/signal_tm.c
new file mode 100644
index 0000000..2e7451a
--- /dev/null
+++ b/tools/testing/selftests/powerpc/signal/signal_tm.c
@@ -0,0 +1,110 @@
+/*
+ * Copyright 2016, Cyril Bur, IBM Corp.
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version
+ * 2 of the License, or (at your option) any later version.
+ *
+ * Sending one self a signal should always get delivered.
+ */
+
+#include <errno.h>
+#include <stdlib.h>
+#include <stdio.h>
+#include <string.h>
+#include <signal.h>
+#include <unistd.h>
+
+#include <altivec.h>
+
+#include "utils.h"
+#include "../tm/tm.h"
+
+#define MAX_ATTEMPT 500000
+#define TIMEOUT 10
+
+extern long tm_signal_self(pid_t pid, int sig, long *ret);
+
+static sig_atomic_t signaled;
+static sig_atomic_t fail;
+
+static void signal_handler(int sig)
+{
+	if (tcheck_active()) {
+		fail = 2;
+		return;
+	}
+
+	if (sig == SIGUSR1)
+		signaled = 1;
+	else
+		fail = 1;
+}
+
+static int test_signal_tm()
+{
+	int i;
+	struct sigaction act;
+
+	act.sa_handler = signal_handler;
+	act.sa_flags = 0;
+	sigemptyset(&act.sa_mask);
+	if (sigaction(SIGUSR1, &act, NULL) < 0) {
+		perror("sigaction SIGUSR1");
+		exit(1);
+	}
+	if (sigaction(SIGALRM, &act, NULL) < 0) {
+		perror("sigaction SIGALRM");
+		exit(1);
+	}
+
+	SKIP_IF(!have_htm());
+
+	for (i = 0; i < MAX_ATTEMPT; i++) {
+		/*
+		 * If anything bad happens in ASM and we fail to set ret
+		 * because *handwave* TM this will cause failure
+		 */
+		long ret = 0xdead;
+		long rc = 0xbeef;
+
+		alarm(0); /* Disable any pending */
+		signaled = 0;
+		alarm(TIMEOUT);
+		FAIL_IF(tcheck_transactional());
+		rc = tm_signal_self(getpid(), SIGUSR1, &ret);
+		if (ret == 0xdead)
+			/*
+			 * This basically means the transaction aborted before we
+			 * even got to the suspend... this is crazy but it
+			 * happens.
+			 * Yes this also means we might never make forward
+			 * progress... the alarm() will trip eventually...
+			 */
+			continue;
+
+		if (rc || ret) {
+			/* Ret is actually an errno */
+			printf("TEXASR 0x%016lx, TFIAR 0x%016lx\n",
+					__builtin_get_texasr(), __builtin_get_tfiar());
+			fprintf(stderr, "(%d) Fail reason: %d rc=0x%lx ret=0x%lx\n",
+					i, fail, rc, ret);
+			FAIL_IF(ret);
+		}
+		while(!signaled && !fail)
+			asm volatile("": : :"memory");
+		if (!signaled) {
+			fprintf(stderr, "(%d) Fail reason: %d rc=0x%lx ret=0x%lx\n",
+					i, fail, rc, ret);
+			FAIL_IF(fail); /* For the line number */
+		}
+	}
+
+	return 0;
+}
+
+int main(void)
+{
+	return test_harness(test_signal_tm, "signal_tm");
+}
-- 
2.9.3

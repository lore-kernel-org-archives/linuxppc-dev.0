Return-Path: <cyrilbur@gmail.com>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 112A21A05CA
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 23 Feb 2016 14:39:58 +1100 (AEDT)
Received: from e23smtp04.au.ibm.com (e23smtp04.au.ibm.com [202.81.31.146])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id AFB26140B9C
 for <linuxppc-dev@ozlabs.org>; Tue, 23 Feb 2016 14:39:57 +1100 (AEDT)
Received: from localhost
 by e23smtp04.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <cyrilbur@gmail.com>;
 Tue, 23 Feb 2016 13:39:57 +1000
Received: from d23relay08.au.ibm.com (d23relay08.au.ibm.com [9.185.71.33])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id AAF4A2CE8046
 for <linuxppc-dev@ozlabs.org>; Tue, 23 Feb 2016 14:39:54 +1100 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay08.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u1N3dkuZ50987022
 for <linuxppc-dev@ozlabs.org>; Tue, 23 Feb 2016 14:39:54 +1100
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u1N3dMaP015730
 for <linuxppc-dev@ozlabs.org>; Tue, 23 Feb 2016 14:39:22 +1100
From: Cyril Bur <cyrilbur@gmail.com>
To: linuxppc-dev@ozlabs.org
Cc: naveen.n.rao@linux.vnet.ibm.com
Subject: [PATCH v5 3/9] selftests/powerpc: Test FPU and VMX regs in signal
 ucontext
Date: Tue, 23 Feb 2016 14:38:16 +1100
Message-Id: <1456198702-29657-4-git-send-email-cyrilbur@gmail.com>
In-Reply-To: <1456198702-29657-1-git-send-email-cyrilbur@gmail.com>
References: <1456198702-29657-1-git-send-email-cyrilbur@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Load up the non volatile FPU and VMX regs and ensure that they are the
expected value in a signal handler

Signed-off-by: Cyril Bur <cyrilbur@gmail.com>
---
 tools/testing/selftests/powerpc/math/.gitignore   |   2 +
 tools/testing/selftests/powerpc/math/Makefile     |   4 +-
 tools/testing/selftests/powerpc/math/fpu_signal.c | 135 +++++++++++++++++++
 tools/testing/selftests/powerpc/math/vmx_signal.c | 156 ++++++++++++++++++++++
 4 files changed, 296 insertions(+), 1 deletion(-)
 create mode 100644 tools/testing/selftests/powerpc/math/fpu_signal.c
 create mode 100644 tools/testing/selftests/powerpc/math/vmx_signal.c

diff --git a/tools/testing/selftests/powerpc/math/.gitignore b/tools/testing/selftests/powerpc/math/.gitignore
index 1a6f09e..4fe13a4 100644
--- a/tools/testing/selftests/powerpc/math/.gitignore
+++ b/tools/testing/selftests/powerpc/math/.gitignore
@@ -2,3 +2,5 @@ fpu_syscall
 vmx_syscall
 fpu_preempt
 vmx_preempt
+fpu_signal
+vmx_signal
diff --git a/tools/testing/selftests/powerpc/math/Makefile b/tools/testing/selftests/powerpc/math/Makefile
index 5f5617c..10df9d8 100644
--- a/tools/testing/selftests/powerpc/math/Makefile
+++ b/tools/testing/selftests/powerpc/math/Makefile
@@ -1,4 +1,4 @@
-TEST_PROGS := fpu_syscall fpu_preempt vmx_syscall vmx_preempt
+TEST_PROGS := fpu_syscall fpu_preempt fpu_signal vmx_syscall vmx_preempt vmx_signal
 
 all: $(TEST_PROGS)
 
@@ -9,9 +9,11 @@ $(TEST_PROGS): CFLAGS = $(filter-out -flto,$(CFLAGS) -O2 -g -pthread -m64 -malti
 
 fpu_syscall: fpu_asm.S
 fpu_preempt: fpu_asm.S
+fpu_signal:  fpu_asm.S
 
 vmx_syscall: vmx_asm.S
 vmx_preempt: vmx_asm.S
+vmx_signal: vmx_asm.S
 
 include ../../lib.mk
 
diff --git a/tools/testing/selftests/powerpc/math/fpu_signal.c b/tools/testing/selftests/powerpc/math/fpu_signal.c
new file mode 100644
index 0000000..888aa51
--- /dev/null
+++ b/tools/testing/selftests/powerpc/math/fpu_signal.c
@@ -0,0 +1,135 @@
+/*
+ * Copyright 2015, Cyril Bur, IBM Corp.
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version
+ * 2 of the License, or (at your option) any later version.
+ *
+ * This test attempts to see if the FPU registers are correctly reported in a
+ * signal context. Each worker just spins checking its FPU registers, at some
+ * point a signal will interrupt it and C code will check the signal context
+ * ensuring it is also the same.
+ */
+
+#include <stdio.h>
+#include <unistd.h>
+#include <sys/syscall.h>
+#include <sys/time.h>
+#include <sys/types.h>
+#include <sys/wait.h>
+#include <stdlib.h>
+#include <pthread.h>
+
+#include "utils.h"
+
+/* Number of times each thread should receive the signal */
+#define ITERATIONS 10
+/*
+ * Factor by which to multiply number of online CPUs for total number of
+ * worker threads
+ */
+#define THREAD_FACTOR 8
+
+__thread double darray[] = {0.1, 0.2, 0.3, 0.4, 0.5, 0.6, 0.7, 0.8, 0.9, 1.0,
+		     1.1, 1.2, 1.3, 1.4, 1.5, 1.6, 1.7, 1.8, 1.9, 2.0,
+		     2.1};
+
+bool bad_context;
+int threads_starting;
+int running;
+
+extern long preempt_fpu(double *darray, int *threads_starting, int *running);
+
+void signal_fpu_sig(int sig, siginfo_t *info, void *context)
+{
+	int i;
+	ucontext_t *uc = context;
+	mcontext_t *mc = &uc->uc_mcontext;
+
+	/* Only the non volatiles were loaded up */
+	for (i = 14; i < 32; i++) {
+		if (mc->fp_regs[i] != darray[i - 14]) {
+			bad_context = true;
+			break;
+		}
+	}
+}
+
+void *signal_fpu_c(void *p)
+{
+	int i;
+	long rc;
+	struct sigaction act;
+	act.sa_sigaction = signal_fpu_sig;
+	act.sa_flags = SA_SIGINFO;
+	rc = sigaction(SIGUSR1, &act, NULL);
+	if (rc)
+		return p;
+
+	srand(pthread_self());
+	for (i = 0; i < 21; i++)
+		darray[i] = rand();
+
+	rc = preempt_fpu(darray, &threads_starting, &running);
+
+	return (void *) rc;
+}
+
+int test_signal_fpu(void)
+{
+	int i, j, rc, threads;
+	void *rc_p;
+	pthread_t *tids;
+
+	threads = sysconf(_SC_NPROCESSORS_ONLN) * THREAD_FACTOR;
+	tids = malloc(threads * sizeof(pthread_t));
+	FAIL_IF(!tids);
+
+	running = true;
+	threads_starting = threads;
+	for (i = 0; i < threads; i++) {
+		rc = pthread_create(&tids[i], NULL, signal_fpu_c, NULL);
+		FAIL_IF(rc);
+	}
+
+	setbuf(stdout, NULL);
+	printf("\tWaiting for all workers to start...");
+	while (threads_starting)
+		asm volatile("": : :"memory");
+	printf("done\n");
+
+	printf("\tSending signals to all threads %d times...", ITERATIONS);
+	for (i = 0; i < ITERATIONS; i++) {
+		for (j = 0; j < threads; j++) {
+			pthread_kill(tids[j], SIGUSR1);
+		}
+		sleep(1);
+	}
+	printf("done\n");
+
+	printf("\tStopping workers...");
+	running = 0;
+	for (i = 0; i < threads; i++) {
+		pthread_join(tids[i], &rc_p);
+
+		/*
+		 * Harness will say the fail was here, look at why signal_fpu
+		 * returned
+		 */
+		if ((long) rc_p || bad_context)
+			printf("oops\n");
+		if (bad_context)
+			fprintf(stderr, "\t!! bad_context is true\n");
+		FAIL_IF((long) rc_p || bad_context);
+	}
+	printf("done\n");
+
+	free(tids);
+	return 0;
+}
+
+int main(int argc, char *argv[])
+{
+	return test_harness(test_signal_fpu, "fpu_signal");
+}
diff --git a/tools/testing/selftests/powerpc/math/vmx_signal.c b/tools/testing/selftests/powerpc/math/vmx_signal.c
new file mode 100644
index 0000000..671d753
--- /dev/null
+++ b/tools/testing/selftests/powerpc/math/vmx_signal.c
@@ -0,0 +1,156 @@
+/*
+ * Copyright 2015, Cyril Bur, IBM Corp.
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version
+ * 2 of the License, or (at your option) any later version.
+ *
+ * This test attempts to see if the VMX registers are correctly reported in a
+ * signal context. Each worker just spins checking its VMX registers, at some
+ * point a signal will interrupt it and C code will check the signal context
+ * ensuring it is also the same.
+ */
+
+#include <stdio.h>
+#include <unistd.h>
+#include <sys/syscall.h>
+#include <sys/time.h>
+#include <sys/types.h>
+#include <sys/wait.h>
+#include <stdlib.h>
+#include <string.h>
+#include <pthread.h>
+#include <altivec.h>
+
+#include "utils.h"
+
+/* Number of times each thread should receive the signal */
+#define ITERATIONS 10
+/*
+ * Factor by which to multiply number of online CPUs for total number of
+ * worker threads
+ */
+#define THREAD_FACTOR 8
+
+__thread vector int varray[] = {{1, 2, 3, 4}, {5, 6, 7, 8}, {9, 10,11,12},
+	{13,14,15,16},{17,18,19,20},{21,22,23,24},
+	{25,26,27,28},{29,30,31,32},{33,34,35,36},
+	{37,38,39,40},{41,42,43,44},{45,46,47,48}};
+
+bool bad_context;
+int running;
+int threads_starting;
+
+extern int preempt_vmx(vector int *varray, int *threads_starting, int *sentinal);
+
+void signal_vmx_sig(int sig, siginfo_t *info, void *context)
+{
+	int i;
+	ucontext_t *uc = context;
+	mcontext_t *mc = &uc->uc_mcontext;
+
+	/* Only the non volatiles were loaded up */
+	for (i = 20; i < 32; i++) {
+		if (memcmp(mc->v_regs->vrregs[i], &varray[i - 20], 16)) {
+			int j;
+			/*
+			 * Shouldn't printf() in a signal handler, however, this is a
+			 * test and we've detected failure. Understanding what failed
+			 * is paramount. All that happens after this is tests exit with
+			 * failure.
+			 */
+			printf("VMX mismatch at reg %d!\n", i);
+			printf("Reg | Actual                  | Expected\n");
+			for (j = 20; j < 32; j++) {
+				printf("%d  | 0x%04x%04x%04x%04x      | 0x%04x%04x%04x%04x\n", j, mc->v_regs->vrregs[j][0],
+					   mc->v_regs->vrregs[j][1], mc->v_regs->vrregs[j][2], mc->v_regs->vrregs[j][3],
+					   varray[j - 20][0], varray[j - 20][1], varray[j - 20][2], varray[j - 20][3]);
+			}
+			bad_context = true;
+			break;
+		}
+	}
+}
+
+void *signal_vmx_c(void *p)
+{
+	int i, j;
+	long rc;
+	struct sigaction act;
+	act.sa_sigaction = signal_vmx_sig;
+	act.sa_flags = SA_SIGINFO;
+	rc = sigaction(SIGUSR1, &act, NULL);
+	if (rc)
+		return p;
+
+	srand(pthread_self());
+	for (i = 0; i < 12; i++)
+		for (j = 0; j < 4; j++)
+			varray[i][j] = rand();
+
+	rc = preempt_vmx(varray, &threads_starting, &running);
+
+	return (void *) rc;
+}
+
+int test_signal_vmx(void)
+{
+	int i, j, rc, threads;
+	void *rc_p;
+	pthread_t *tids;
+
+	threads = sysconf(_SC_NPROCESSORS_ONLN) * THREAD_FACTOR;
+	tids = malloc(threads * sizeof(pthread_t));
+	FAIL_IF(!tids);
+
+	running = true;
+	threads_starting = threads;
+	for (i = 0; i < threads; i++) {
+		rc = pthread_create(&tids[i], NULL, signal_vmx_c, NULL);
+		FAIL_IF(rc);
+	}
+
+	setbuf(stdout, NULL);
+	printf("\tWaiting for %d workers to start... %d", threads, threads_starting);
+	while (threads_starting) {
+		asm volatile("": : :"memory");
+		usleep(1000);
+		printf(", %d", threads_starting);
+	}
+	printf(" ...done\n");
+
+	printf("\tSending signals to all threads %d times...", ITERATIONS);
+	for (i = 0; i < ITERATIONS; i++) {
+		for (j = 0; j < threads; j++) {
+			pthread_kill(tids[j], SIGUSR1);
+		}
+		sleep(1);
+	}
+	printf("done\n");
+
+	printf("\tKilling workers...");
+	running = 0;
+	for (i = 0; i < threads; i++) {
+		pthread_join(tids[i], &rc_p);
+
+		/*
+		 * Harness will say the fail was here, look at why signal_vmx
+		 * returned
+		 */
+		if ((long) rc_p || bad_context)
+			printf("oops\n");
+		if (bad_context)
+			fprintf(stderr, "\t!! bad_context is true\n");
+		FAIL_IF((long) rc_p || bad_context);
+	}
+	printf("done\n");
+
+	free(tids);
+	return 0;
+}
+
+int main(int argc, char *argv[])
+{
+	return test_harness(test_signal_vmx, "vmx_signal");
+}
-- 
2.7.1

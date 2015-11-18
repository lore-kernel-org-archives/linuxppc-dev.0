Return-Path: <cyrilbur@gmail.com>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 817981A06F9
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 18 Nov 2015 14:29:17 +1100 (AEDT)
Received: from e23smtp09.au.ibm.com (e23smtp09.au.ibm.com [202.81.31.142])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 1978314145F
 for <linuxppc-dev@ozlabs.org>; Wed, 18 Nov 2015 14:29:17 +1100 (AEDT)
Received: from /spool/local
 by e23smtp09.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <cyrilbur@gmail.com>;
 Wed, 18 Nov 2015 13:29:16 +1000
Received: from d23relay07.au.ibm.com (d23relay07.au.ibm.com [9.190.26.37])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id 99B6E3578054
 for <linuxppc-dev@ozlabs.org>; Wed, 18 Nov 2015 14:29:13 +1100 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay07.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 tAI3T7bK35193036
 for <linuxppc-dev@ozlabs.org>; Wed, 18 Nov 2015 14:29:15 +1100
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 tAI3SfSS019415
 for <linuxppc-dev@ozlabs.org>; Wed, 18 Nov 2015 14:28:41 +1100
From: Cyril Bur <cyrilbur@gmail.com>
To: mikey@neuling.org, anton@samba.org, linuxppc-dev@ozlabs.org
Subject: [PATCH 3/8] selftests/powerpc: Test FPU and VMX regs in signal
 ucontext
Date: Wed, 18 Nov 2015 14:26:50 +1100
Message-Id: <1447817215-15804-4-git-send-email-cyrilbur@gmail.com>
In-Reply-To: <1447817215-15804-1-git-send-email-cyrilbur@gmail.com>
References: <1447817215-15804-1-git-send-email-cyrilbur@gmail.com>
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
 tools/testing/selftests/powerpc/math/Makefile     |   4 +-
 tools/testing/selftests/powerpc/math/fpu_signal.c | 119 +++++++++++++++++++++
 tools/testing/selftests/powerpc/math/vmx_signal.c | 124 ++++++++++++++++++++++
 3 files changed, 246 insertions(+), 1 deletion(-)
 create mode 100644 tools/testing/selftests/powerpc/math/fpu_signal.c
 create mode 100644 tools/testing/selftests/powerpc/math/vmx_signal.c

diff --git a/tools/testing/selftests/powerpc/math/Makefile b/tools/testing/selftests/powerpc/math/Makefile
index 9fa690f..5ce000bf 100644
--- a/tools/testing/selftests/powerpc/math/Makefile
+++ b/tools/testing/selftests/powerpc/math/Makefile
@@ -1,4 +1,4 @@
-TEST_PROGS := fpu_syscall fpu_preempt vmx_syscall vmx_preempt
+TEST_PROGS := fpu_syscall fpu_preempt fpu_signal vmx_syscall vmx_preempt vmx_signal
 
 all: $(TEST_PROGS)
 
@@ -7,9 +7,11 @@ $(TEST_PROGS): CFLAGS += -O2 -g -pthread
 
 fpu_syscall: fpu_asm.S
 fpu_preempt: fpu_asm.S
+fpu_signal:  fpu_asm.S
 
 vmx_syscall: vmx_asm.S
 vmx_preempt: vmx_asm.S
+vmx_signal: vmx_asm.S
 
 include ../../lib.mk
 
diff --git a/tools/testing/selftests/powerpc/math/fpu_signal.c b/tools/testing/selftests/powerpc/math/fpu_signal.c
new file mode 100644
index 0000000..ca61d1f
--- /dev/null
+++ b/tools/testing/selftests/powerpc/math/fpu_signal.c
@@ -0,0 +1,119 @@
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
+/* Number of times each thread should recieve the signal */
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
+int running;
+volatile int not_ready;
+extern long preempt_fpu(double *darray, volatile int *not_ready, int *sentinal);
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
+	rc = preempt_fpu(darray, &not_ready, &running);
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
+	not_ready = threads;
+	for (i = 0; i < threads; i++) {
+		rc = pthread_create(&tids[i], NULL, signal_fpu_c, NULL);
+		FAIL_IF(rc);
+	}
+
+	setbuf(stdout, NULL);
+	printf("\tWaiting for all workers to start...");
+	while (not_ready);
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
+	printf("\tKilling workers...");
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
index 0000000..007ac9e
--- /dev/null
+++ b/tools/testing/selftests/powerpc/math/vmx_signal.c
@@ -0,0 +1,124 @@
+#include <stdio.h>
+#include <unistd.h>
+#include <sys/syscall.h>
+#include <sys/time.h>
+#include <sys/types.h>
+#include <sys/wait.h>
+#include <stdlib.h>
+#include <string.h>
+#include <pthread.h>
+
+#include "utils.h"
+
+/* Number of times each thread should recieve the signal */
+#define ITERATIONS 10
+/*
+ * Factor by which to multiply number of online CPUs for total number of
+ * worker threads
+ */
+#define THREAD_FACTOR 8
+
+typedef int v4si __attribute__ ((vector_size (16)));
+__thread v4si varray[] = {{1, 2, 3, 4}, {5, 6, 7, 8}, {9, 10,11,12},
+	{13,14,15,16},{17,18,19,20},{21,22,23,24},
+	{25,26,27,28},{29,30,31,32},{33,34,35,36},
+	{37,38,39,40},{41,42,43,44},{45,46,47,48}};
+
+bool bad_context;
+int running;
+volatile int not_ready;
+
+extern int preempt_vmx(v4si *varray, volatile int *not_ready, int *sentinal);
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
+	rc = preempt_vmx(varray, &not_ready, &running);
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
+	not_ready = threads;
+	for (i = 0; i < threads; i++) {
+		rc = pthread_create(&tids[i], NULL, signal_vmx_c, NULL);
+		FAIL_IF(rc);
+	}
+
+	setbuf(stdout, NULL);
+	printf("\tWaiting for all workers to start...");
+	while (not_ready);
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
2.6.2

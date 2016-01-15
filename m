Return-Path: <cyrilbur@gmail.com>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id CA5221A02A5
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 15 Jan 2016 16:05:37 +1100 (AEDT)
Received: from e23smtp03.au.ibm.com (e23smtp03.au.ibm.com [202.81.31.145])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 8BBC2140BFA
 for <linuxppc-dev@ozlabs.org>; Fri, 15 Jan 2016 16:05:37 +1100 (AEDT)
Received: from localhost
 by e23smtp03.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <cyrilbur@gmail.com>;
 Fri, 15 Jan 2016 15:05:36 +1000
Received: from d23relay08.au.ibm.com (d23relay08.au.ibm.com [9.185.71.33])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id DBD012BB0059
 for <linuxppc-dev@ozlabs.org>; Fri, 15 Jan 2016 16:05:33 +1100 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay08.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u0F554BB36569112
 for <linuxppc-dev@ozlabs.org>; Fri, 15 Jan 2016 16:05:12 +1100
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u0F551fk030429
 for <linuxppc-dev@ozlabs.org>; Fri, 15 Jan 2016 16:05:01 +1100
Received: from ozlabs.au.ibm.com (ozlabs.au.ibm.com [9.192.253.14])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVin) with ESMTP id
 u0F55180029705
 for <linuxppc-dev@ozlabs.org>; Fri, 15 Jan 2016 16:05:01 +1100
Received: from camb691.ozlabs.ibm.com (haven.au.ibm.com [9.192.254.114])
 (using TLSv1.2 with cipher AES128-SHA256 (128/128 bits))
 (No client certificate requested)
 by ozlabs.au.ibm.com (Postfix) with ESMTPSA id 49A0DA0283
 for <linuxppc-dev@ozlabs.org>; Fri, 15 Jan 2016 16:04:37 +1100 (AEDT)
From: Cyril Bur <cyrilbur@gmail.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH V2 2/8] selftests/powerpc: Test preservation of FPU and VMX
 regs across preemption
Date: Fri, 15 Jan 2016 16:04:08 +1100
Message-Id: <1452834254-22078-3-git-send-email-cyrilbur@gmail.com>
In-Reply-To: <1452834254-22078-1-git-send-email-cyrilbur@gmail.com>
References: <1452834254-22078-1-git-send-email-cyrilbur@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Loop in assembly checking the registers with many threads.

Signed-off-by: Cyril Bur <cyrilbur@gmail.com>
---
 tools/testing/selftests/powerpc/math/.gitignore    |   2 +
 tools/testing/selftests/powerpc/math/Makefile      |   5 +-
 tools/testing/selftests/powerpc/math/fpu_asm.S     |  34 +++++++
 tools/testing/selftests/powerpc/math/fpu_preempt.c | 113 +++++++++++++++++++++
 tools/testing/selftests/powerpc/math/vmx_asm.S     |  44 +++++++-
 tools/testing/selftests/powerpc/math/vmx_preempt.c | 113 +++++++++++++++++++++
 6 files changed, 306 insertions(+), 5 deletions(-)
 create mode 100644 tools/testing/selftests/powerpc/math/fpu_preempt.c
 create mode 100644 tools/testing/selftests/powerpc/math/vmx_preempt.c

diff --git a/tools/testing/selftests/powerpc/math/.gitignore b/tools/testing/selftests/powerpc/math/.gitignore
index b19b269..1a6f09e 100644
--- a/tools/testing/selftests/powerpc/math/.gitignore
+++ b/tools/testing/selftests/powerpc/math/.gitignore
@@ -1,2 +1,4 @@
 fpu_syscall
 vmx_syscall
+fpu_preempt
+vmx_preempt
diff --git a/tools/testing/selftests/powerpc/math/Makefile b/tools/testing/selftests/powerpc/math/Makefile
index 418bef1..b6f4158 100644
--- a/tools/testing/selftests/powerpc/math/Makefile
+++ b/tools/testing/selftests/powerpc/math/Makefile
@@ -1,4 +1,4 @@
-TEST_PROGS := fpu_syscall vmx_syscall
+TEST_PROGS := fpu_syscall fpu_preempt vmx_syscall vmx_preempt
 
 all: $(TEST_PROGS)
 
@@ -6,7 +6,10 @@ $(TEST_PROGS): ../harness.c
 $(TEST_PROGS): CFLAGS += -O2 -g -pthread -m64 -maltivec
 
 fpu_syscall: fpu_asm.S
+fpu_preempt: fpu_asm.S
+
 vmx_syscall: vmx_asm.S
+vmx_preempt: vmx_asm.S
 
 include ../../lib.mk
 
diff --git a/tools/testing/selftests/powerpc/math/fpu_asm.S b/tools/testing/selftests/powerpc/math/fpu_asm.S
index 8733874..46bbe99 100644
--- a/tools/testing/selftests/powerpc/math/fpu_asm.S
+++ b/tools/testing/selftests/powerpc/math/fpu_asm.S
@@ -159,3 +159,37 @@ FUNC_START(test_fpu)
 	POP_BASIC_STACK(256)
 	blr
 FUNC_END(test_fpu)
+
+#int preempt_fpu(double *darray, int *threads_running, int *running)
+#On starting will (atomically) decrement not_ready as a signal that the FPU
+#has been loaded with darray. Will proceed to check the validity of the FPU
+#registers while running is not zero.
+FUNC_START(preempt_fpu)
+	PUSH_BASIC_STACK(256)
+	std r3,32(sp) #double *darray
+	std r4,40(sp) #volatile int *not_ready
+	std r5,48(sp) #int *running
+	PUSH_FPU(56)
+
+	bl load_fpu
+
+	#Atomic DEC
+	ld r3,40(sp)
+1:	lwarx r4,0,r3
+	addi r4,r4,-1
+	stwcx. r4,0,r3
+	bne- 1b
+
+2:	ld r3, 32(sp)
+	bl check_fpu
+	cmpdi r3,0
+	bne 3f
+	ld r4, 48(sp)
+	ld r5, 0(r4)
+	cmpwi r5,0
+	bne 2b
+
+3:	POP_FPU(56)
+	POP_BASIC_STACK(256)
+	blr
+FUNC_END(preempt_fpu)
diff --git a/tools/testing/selftests/powerpc/math/fpu_preempt.c b/tools/testing/selftests/powerpc/math/fpu_preempt.c
new file mode 100644
index 0000000..0f85b79
--- /dev/null
+++ b/tools/testing/selftests/powerpc/math/fpu_preempt.c
@@ -0,0 +1,113 @@
+/*
+ * Copyright 2015, Cyril Bur, IBM Corp.
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version
+ * 2 of the License, or (at your option) any later version.
+ *
+ * This test attempts to see if the FPU registers change across preemption.
+ * Two things should be noted here a) The check_fpu function in asm only checks
+ * the non volatile registers as it is reused from the syscall test b) There is
+ * no way to be sure preemption happened so this test just uses many threads
+ * and a long wait. As such, a successful test doesn't mean much but a failure
+ * is bad.
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
+/* Time to wait for workers to get preempted (seconds) */
+#define PREEMPT_TIME 20
+/*
+ * Factor by which to multiply number of online CPUs for total number of
+ * worker threads
+ */
+#define THREAD_FACTOR 8
+
+
+__thread double darray[] = {0.1, 0.2, 0.3, 0.4, 0.5, 0.6, 0.7, 0.8, 0.9, 1.0,
+		     1.1, 1.2, 1.3, 1.4, 1.5, 1.6, 1.7, 1.8, 1.9, 2.0,
+		     2.1};
+
+int threads_starting;
+int running;
+
+extern void preempt_fpu(double *darray, int *threads_starting, int *running);
+
+void *preempt_fpu_c(void *p)
+{
+	int i;
+	srand(pthread_self());
+	for (i = 0; i < 21; i++)
+		darray[i] = rand();
+
+	/* Test failed if it ever returns */
+	preempt_fpu(darray, &threads_starting, &running);
+
+	return p;
+}
+
+int test_preempt_fpu(void)
+{
+	int i, rc, threads;
+	pthread_t *tids;
+
+	threads = sysconf(_SC_NPROCESSORS_ONLN) * THREAD_FACTOR;
+	tids = malloc((threads) * sizeof(pthread_t));
+	FAIL_IF(!tids);
+
+	running = true;
+	threads_starting = threads;
+	for (i = 0; i < threads; i++) {
+		rc = pthread_create(&tids[i], NULL, preempt_fpu_c, NULL);
+		FAIL_IF(rc);
+	}
+
+	setbuf(stdout, NULL);
+	/* Not really necessary but nice to wait for every thread to start */
+	printf("\tWaiting for all workers to start...");
+	while(threads_starting)
+		asm volatile("": : :"memory");
+	printf("done\n");
+
+	printf("\tWaiting for %d seconds to let some workers get preempted...", PREEMPT_TIME);
+	sleep(PREEMPT_TIME);
+	printf("done\n");
+
+	printf("\tStopping workers...");
+	/*
+	 * Working are checking this value every loop. In preempt_fpu 'cmpwi r5,0; bne 2b'.
+	 * r5 will have loaded the value of running.
+	 */
+	running = 0;
+	for (i = 0; i < threads; i++) {
+		void *rc_p;
+		pthread_join(tids[i], &rc_p);
+
+		/*
+		 * Harness will say the fail was here, look at why preempt_fpu
+		 * returned
+		 */
+		if ((long) rc_p)
+			printf("oops\n");
+		FAIL_IF((long) rc_p);
+	}
+	printf("done\n");
+
+	free(tids);
+	return 0;
+}
+
+int main(int argc, char *argv[])
+{
+	return test_harness(test_preempt_fpu, "fpu_preempt");
+}
diff --git a/tools/testing/selftests/powerpc/math/vmx_asm.S b/tools/testing/selftests/powerpc/math/vmx_asm.S
index 9ed32e7..416b5b0 100644
--- a/tools/testing/selftests/powerpc/math/vmx_asm.S
+++ b/tools/testing/selftests/powerpc/math/vmx_asm.S
@@ -9,6 +9,7 @@
 
 #include "../basic_asm.h"
 
+#POS MUST BE 16 ALIGNED!
 #define PUSH_VMX(pos,reg) \
 	li	reg,pos; \
 	stvx	v20,reg,sp; \
@@ -35,6 +36,7 @@
 	addi	reg,reg,16; \
 	stvx	v31,reg,sp;
 
+#POS MUST BE 16 ALIGNED!
 #define POP_VMX(pos,reg) \
 	li	reg,pos; \
 	lvx	v20,reg,sp; \
@@ -93,7 +95,7 @@ FUNC_END(load_vmx)
 
 #Should be safe from C, only touches r4, r5 and v0,v1,v2
 FUNC_START(check_vmx)
-	PUSH_BASIC_STACK(16)
+	PUSH_BASIC_STACK(32)
 	mr r4,r3
 	li	r3,1 #assume a bad result
 	li	r5,0
@@ -162,7 +164,7 @@ FUNC_START(check_vmx)
 	cmpdi	r0,0xffffffff
 	bne	1f
 	li	r3,0
-1:	POP_BASIC_STACK(16)
+1:	POP_BASIC_STACK(32)
 	blr
 FUNC_END(check_vmx)
 
@@ -174,7 +176,7 @@ FUNC_START(test_vmx)
 	PUSH_BASIC_STACK(512)
 	std	r3,40(sp) #Address of varray
 	std r4,48(sp) #address of pid
-	PUSH_VMX(56, r4)
+	PUSH_VMX(64, r4)
 
 	bl load_vmx
 
@@ -187,7 +189,41 @@ FUNC_START(test_vmx)
 	ld r3,40(sp)
 	bl check_vmx
 
-	POP_VMX(56,r4)
+	POP_VMX(64,r4)
 	POP_BASIC_STACK(512)
 	blr
 FUNC_END(test_vmx)
+
+#int preempt_vmx(v4si *varray, int *threads_starting, int *running)
+#On starting will (atomically) decrement not_ready as a signal that the FPU
+#has been loaded with varray. Will proceed to check the validity of the FPU
+#registers while running is not zero.
+FUNC_START(preempt_vmx)
+	PUSH_BASIC_STACK(512)
+	std r3,32(sp) #v4si *varray
+	std r4,40(sp) #volatile int *not_ready
+	std r5,48(sp) #int *running
+	PUSH_VMX(64,r4)
+
+	bl load_vmx
+
+	#Atomic DEC
+	ld r3,40(sp)
+1:	lwarx r4,0,r3
+	addi r4,r4,-1
+	stwcx. r4,0,r3
+	bne- 1b
+
+2:	ld r3,32(sp)
+	bl check_vmx
+	cmpdi r3,0
+	bne 3f
+	ld r4,48(sp)
+	ld r5,0(r4)
+	cmpwi r5,0
+	bne 2b
+
+3:	POP_VMX(64,r4)
+	POP_BASIC_STACK(512)
+	blr
+FUNC_END(preempt_vmx)
diff --git a/tools/testing/selftests/powerpc/math/vmx_preempt.c b/tools/testing/selftests/powerpc/math/vmx_preempt.c
new file mode 100644
index 0000000..9474e78
--- /dev/null
+++ b/tools/testing/selftests/powerpc/math/vmx_preempt.c
@@ -0,0 +1,113 @@
+/*
+ * Copyright 2015, Cyril Bur, IBM Corp.
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version
+ * 2 of the License, or (at your option) any later version.
+ *
+ * This test attempts to see if the VMX registers change across preemption.
+ * Two things should be noted here a) The check_vmx function in asm only checks
+ * the non volatile registers as it is reused from the syscall test b) There is
+ * no way to be sure preemption happened so this test just uses many threads
+ * and a long wait. As such, a successful test doesn't mean much but a failure
+ * is bad.
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
+/* Time to wait for workers to get preempted (seconds) */
+#define PREEMPT_TIME 20
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
+int threads_starting;
+int running;
+
+extern void preempt_vmx(v4si *varray, int *threads_starting, int *running);
+
+void *preempt_vmx_c(void *p)
+{
+	int i, j;
+	srand(pthread_self());
+	for (i = 0; i < 12; i++)
+		for (j = 0; j < 4; j++)
+			varray[i][j] = rand();
+
+	/* Test fails if it ever returns */
+	preempt_vmx(varray, &threads_starting, &running);
+	return p;
+}
+
+int test_preempt_vmx(void)
+{
+	int i, rc, threads;
+	pthread_t *tids;
+
+	threads = sysconf(_SC_NPROCESSORS_ONLN) * THREAD_FACTOR;
+	tids = malloc(threads * sizeof(pthread_t));
+	FAIL_IF(!tids);
+
+	running = true;
+	threads_starting = threads;
+	for (i = 0; i < threads; i++) {
+		rc = pthread_create(&tids[i], NULL, preempt_vmx_c, NULL);
+		FAIL_IF(rc);
+	}
+
+	setbuf(stdout, NULL);
+	/* Not really nessesary but nice to wait for every thread to start */
+	printf("\tWaiting for all workers to start...");
+	while(threads_starting)
+		asm volatile("": : :"memory");
+	printf("done\n");
+
+	printf("\tWaiting for %d seconds to let some workers get preempted...", PREEMPT_TIME);
+	sleep(PREEMPT_TIME);
+	printf("done\n");
+
+	printf("\tStopping workers...");
+	/*
+	 * Working are checking this value every loop. In preempt_vmx 'cmpwi r5,0; bne 2b'.
+	 * r5 will have loaded the value of running.
+	 */
+	running = 0;
+	for (i = 0; i < threads; i++) {
+		void *rc_p;
+		pthread_join(tids[i], &rc_p);
+
+		/*
+		 * Harness will say the fail was here, look at why preempt_vmx
+		 * returned
+		 */
+		if ((long) rc_p)
+			printf("oops\n");
+		FAIL_IF((long) rc_p);
+	}
+	printf("done\n");
+
+	return 0;
+}
+
+int main(int argc, char *argv[])
+{
+	return test_harness(test_preempt_vmx, "vmx_preempt");
+}
-- 
2.7.0

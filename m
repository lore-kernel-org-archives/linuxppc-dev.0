Return-Path: <cyrilbur@gmail.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3s9PPM3zXnzDrD9
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 12 Aug 2016 09:29:43 +1000 (AEST)
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u7BNScIt080315
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Aug 2016 19:29:42 -0400
Received: from e23smtp09.au.ibm.com (e23smtp09.au.ibm.com [202.81.31.142])
 by mx0a-001b2d01.pphosted.com with ESMTP id 24qm9v82n5-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Aug 2016 19:29:41 -0400
Received: from localhost
 by e23smtp09.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <cyrilbur@gmail.com>;
 Fri, 12 Aug 2016 09:29:38 +1000
Received: from d23relay10.au.ibm.com (d23relay10.au.ibm.com [9.190.26.77])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id 9D8602CE8054
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 12 Aug 2016 09:29:35 +1000 (EST)
Received: from d23av06.au.ibm.com (d23av06.au.ibm.com [9.190.235.151])
 by d23relay10.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u7BNTZmx29556840
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 12 Aug 2016 09:29:35 +1000
Received: from d23av06.au.ibm.com (localhost [127.0.0.1])
 by d23av06.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u7BNTZ2G009402
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 12 Aug 2016 09:29:35 +1000
From: Cyril Bur <cyrilbur@gmail.com>
To: linuxppc-dev@lists.ozlabs.org, wei.guo.simon@gmail.com
Cc: anton@samba.org, mikey@neuling.org
Subject: [PATCH v2 06/20] selftests/powerpc: Check for VSX preservation across
 userspace preemption
Date: Fri, 12 Aug 2016 09:28:05 +1000
In-Reply-To: <20160811232819.11453-1-cyrilbur@gmail.com>
References: <20160811232819.11453-1-cyrilbur@gmail.com>
Message-Id: <20160811232819.11453-7-cyrilbur@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Ensure the kernel correctly switches VSX registers correctly. VSX
registers are all volatile, and despite the kernel preserving VSX
across syscalls, it doesn't have to. Test that during interrupts and
timeslices ending the VSX regs remain the same.

Signed-off-by: Cyril Bur <cyrilbur@gmail.com>
---
 tools/testing/selftests/powerpc/math/Makefile      |   4 +-
 tools/testing/selftests/powerpc/math/vsx_asm.S     |  61 +++++++++
 tools/testing/selftests/powerpc/math/vsx_preempt.c | 147 +++++++++++++++++++++
 tools/testing/selftests/powerpc/vsx_asm.h          |  71 ++++++++++
 4 files changed, 282 insertions(+), 1 deletion(-)
 create mode 100644 tools/testing/selftests/powerpc/math/vsx_asm.S
 create mode 100644 tools/testing/selftests/powerpc/math/vsx_preempt.c
 create mode 100644 tools/testing/selftests/powerpc/vsx_asm.h

diff --git a/tools/testing/selftests/powerpc/math/Makefile b/tools/testing/selftests/powerpc/math/Makefile
index 5b88875..aa6598b 100644
--- a/tools/testing/selftests/powerpc/math/Makefile
+++ b/tools/testing/selftests/powerpc/math/Makefile
@@ -1,4 +1,4 @@
-TEST_PROGS := fpu_syscall fpu_preempt fpu_signal vmx_syscall vmx_preempt vmx_signal
+TEST_PROGS := fpu_syscall fpu_preempt fpu_signal vmx_syscall vmx_preempt vmx_signal vsx_preempt
 
 all: $(TEST_PROGS)
 
@@ -13,6 +13,8 @@ vmx_syscall: vmx_asm.S
 vmx_preempt: vmx_asm.S
 vmx_signal: vmx_asm.S
 
+vsx_preempt: vsx_asm.S
+
 include ../../lib.mk
 
 clean:
diff --git a/tools/testing/selftests/powerpc/math/vsx_asm.S b/tools/testing/selftests/powerpc/math/vsx_asm.S
new file mode 100644
index 0000000..a110dd8
--- /dev/null
+++ b/tools/testing/selftests/powerpc/math/vsx_asm.S
@@ -0,0 +1,61 @@
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
+#include "../vsx_asm.h"
+
+#long check_vsx(vector int *r3);
+#This function wraps storeing VSX regs to the end of an array and a
+#call to a comparison function in C which boils down to a memcmp()
+FUNC_START(check_vsx)
+	PUSH_BASIC_STACK(32)
+	std	r3,STACK_FRAME_PARAM(0)(sp)
+	addi r3, r3, 16 * 12 #Second half of array
+	bl store_vsx
+	ld r3,STACK_FRAME_PARAM(0)(sp)
+	bl vsx_memcmp
+	POP_BASIC_STACK(32)
+	blr
+FUNC_END(check_vsx)
+
+# int preempt_vmx(vector int *varray, int *threads_starting,
+#                 int *running);
+# On starting will (atomically) decrement threads_starting as a signal
+# that the VMX have been loaded with varray. Will proceed to check the
+# validity of the VMX registers while running is not zero.
+FUNC_START(preempt_vsx)
+	PUSH_BASIC_STACK(512)
+	std r3,STACK_FRAME_PARAM(0)(sp) # vector int *varray
+	std r4,STACK_FRAME_PARAM(1)(sp) # int *threads_starting
+	std r5,STACK_FRAME_PARAM(2)(sp) # int *running
+
+	bl load_vsx
+	nop
+
+	sync
+	# Atomic DEC
+	ld r3,STACK_FRAME_PARAM(1)(sp)
+1:	lwarx r4,0,r3
+	addi r4,r4,-1
+	stwcx. r4,0,r3
+	bne- 1b
+
+2:	ld r3,STACK_FRAME_PARAM(0)(sp)
+	bl check_vsx
+	nop
+	cmpdi r3,0
+	bne 3f
+	ld r4,STACK_FRAME_PARAM(2)(sp)
+	ld r5,0(r4)
+	cmpwi r5,0
+	bne 2b
+
+3:	POP_BASIC_STACK(512)
+	blr
+FUNC_END(preempt_vsx)
diff --git a/tools/testing/selftests/powerpc/math/vsx_preempt.c b/tools/testing/selftests/powerpc/math/vsx_preempt.c
new file mode 100644
index 0000000..6387f03
--- /dev/null
+++ b/tools/testing/selftests/powerpc/math/vsx_preempt.c
@@ -0,0 +1,147 @@
+/*
+ * Copyright 2015, Cyril Bur, IBM Corp.
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version
+ * 2 of the License, or (at your option) any later version.
+ *
+ * This test attempts to see if the VSX registers change across preemption.
+ * There is no way to be sure preemption happened so this test just
+ * uses many threads and a long wait. As such, a successful test
+ * doesn't mean much but a failure is bad.
+ */
+
+#include <stdio.h>
+#include <string.h>
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
+/*
+ * Ensure there is twice the number of non-volatile VMX regs!
+ * check_vmx() is going to use the other half as space to put the live
+ * registers before calling vsx_memcmp()
+ */
+__thread vector int varray[24] = {
+	{1, 2, 3, 4 }, {5, 6, 7, 8 }, {9, 10,11,12},
+	{13,14,15,16}, {17,18,19,20}, {21,22,23,24},
+	{25,26,27,28}, {29,30,31,32}, {33,34,35,36},
+	{37,38,39,40}, {41,42,43,44}, {45,46,47,48}
+};
+
+int threads_starting;
+int running;
+
+extern long preempt_vsx(vector int *varray, int *threads_starting, int *running);
+
+long vsx_memcmp(vector int *a) {
+	vector int zero = {0, 0, 0, 0};
+	int i;
+
+	FAIL_IF(a != varray);
+
+	for(i = 0; i < 12; i++) {
+		if (memcmp(&a[i + 12], &zero, sizeof(vector int)) == 0) {
+			fprintf(stderr, "Detected zero from the VSX reg %d\n", i + 12);
+			return 2;
+		}
+	}
+
+	if (memcmp(a, &a[12], 12 * sizeof(vector int))) {
+		long *p = (long *)a;
+		fprintf(stderr, "VSX mismatch\n");
+		for (i = 0; i < 24; i=i+2)
+			fprintf(stderr, "%d: 0x%08lx%08lx | 0x%08lx%08lx\n",
+					i/2 + i%2 + 20, p[i], p[i + 1], p[i + 24], p[i + 25]);
+		return 1;
+	}
+	return 0;
+}
+
+void *preempt_vsx_c(void *p)
+{
+	int i, j;
+	long rc;
+	srand(pthread_self());
+	for (i = 0; i < 12; i++)
+		for (j = 0; j < 4; j++) {
+			varray[i][j] = rand();
+			/* Don't want zero because it hides kernel problems */
+			if (varray[i][j] == 0)
+				j--;
+		}
+	rc = preempt_vsx(varray, &threads_starting, &running);
+	if (rc == 2)
+		fprintf(stderr, "Caught zeros in VSX compares\n");
+	return (void *)rc;
+}
+
+int test_preempt_vsx(void)
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
+		rc = pthread_create(&tids[i], NULL, preempt_vsx_c, NULL);
+		FAIL_IF(rc);
+	}
+
+	setbuf(stdout, NULL);
+	/* Not really nessesary but nice to wait for every thread to start */
+	printf("\tWaiting for %d workers to start...", threads_starting);
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
+	 * Working are checking this value every loop. In preempt_vsx 'cmpwi r5,0; bne 2b'.
+	 * r5 will have loaded the value of running.
+	 */
+	running = 0;
+	for (i = 0; i < threads; i++) {
+		void *rc_p;
+		pthread_join(tids[i], &rc_p);
+
+		/*
+		 * Harness will say the fail was here, look at why preempt_vsx
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
+	return test_harness(test_preempt_vsx, "vsx_preempt");
+}
diff --git a/tools/testing/selftests/powerpc/vsx_asm.h b/tools/testing/selftests/powerpc/vsx_asm.h
new file mode 100644
index 0000000..d828bfb
--- /dev/null
+++ b/tools/testing/selftests/powerpc/vsx_asm.h
@@ -0,0 +1,71 @@
+/*
+ * Copyright 2015, Cyril Bur, IBM Corp.
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version
+ * 2 of the License, or (at your option) any later version.
+ */
+
+#include "basic_asm.h"
+
+/*
+ * Careful this will 'clobber' vsx (by design), VSX are always
+ * volatile though so unlike vmx this isn't so much of an issue
+ * Still should avoid calling from C
+ */
+FUNC_START(load_vsx)
+	li	r5,0
+	lxvx	vs20,r5,r3
+	addi	r5,r5,16
+	lxvx	vs21,r5,r3
+	addi	r5,r5,16
+	lxvx	vs22,r5,r3
+	addi	r5,r5,16
+	lxvx	vs23,r5,r3
+	addi	r5,r5,16
+	lxvx	vs24,r5,r3
+	addi	r5,r5,16
+	lxvx	vs25,r5,r3
+	addi	r5,r5,16
+	lxvx	vs26,r5,r3
+	addi	r5,r5,16
+	lxvx	vs27,r5,r3
+	addi	r5,r5,16
+	lxvx	vs28,r5,r3
+	addi	r5,r5,16
+	lxvx	vs29,r5,r3
+	addi	r5,r5,16
+	lxvx	vs30,r5,r3
+	addi	r5,r5,16
+	lxvx	vs31,r5,r3
+	blr
+FUNC_END(load_vsx)
+
+FUNC_START(store_vsx)
+	li	r5,0
+	stxvx	vs20,r5,r3
+	addi	r5,r5,16
+	stxvx	vs21,r5,r3
+	addi	r5,r5,16
+	stxvx	vs22,r5,r3
+	addi	r5,r5,16
+	stxvx	vs23,r5,r3
+	addi	r5,r5,16
+	stxvx	vs24,r5,r3
+	addi	r5,r5,16
+	stxvx	vs25,r5,r3
+	addi	r5,r5,16
+	stxvx	vs26,r5,r3
+	addi	r5,r5,16
+	stxvx	vs27,r5,r3
+	addi	r5,r5,16
+	stxvx	vs28,r5,r3
+	addi	r5,r5,16
+	stxvx	vs29,r5,r3
+	addi	r5,r5,16
+	stxvx	vs30,r5,r3
+	addi	r5,r5,16
+	stxvx	vs31,r5,r3
+	blr
+FUNC_END(store_vsx)
-- 
2.9.2

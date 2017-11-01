Return-Path: <gromero@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yRyps38DqzDr5J
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  2 Nov 2017 06:25:08 +1100 (AEDT)
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 vA1JP2xn036091
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 1 Nov 2017 15:25:05 -0400
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2dyhru0pmw-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 01 Nov 2017 15:25:04 -0400
Received: from localhost
 by e35.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gromero@linux.vnet.ibm.com>;
 Wed, 1 Nov 2017 13:25:03 -0600
From: Gustavo Romero <gromero@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: leitao@debian.org, cyrilbur@gmail.com
Subject: [PATCH] selftests/powerpc: Check FP/VEC on exception in TM
Date: Wed,  1 Nov 2017 15:23:41 -0400
Message-Id: <1509564221-7049-1-git-send-email-gromero@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Add a self test to check if FP/VEC/VSX registers are sane (restored
correctly) after a FP/VEC/VSX unavailable exception is caught during a
transaction.

This test checks all possibilities in a thread regarding the combination
of MSR.[FP|VEC] states in a thread and for each scenario raises a
FP/VEC/VSX unavailable exception in transactional state, verifying if
vs0 and vs32 registers, which are representatives of FP/VEC/VSX reg
sets, are not corrupted.

Signed-off-by: Gustavo Romero <gromero@linux.vnet.ibm.com>
Signed-off-by: Breno Leitao <leitao@debian.org>
Signed-off-by: Cyril Bur <cyrilbur@gmail.com>
---
 tools/testing/selftests/powerpc/tm/Makefile        |   3 +-
 .../testing/selftests/powerpc/tm/tm-unavailable.c  | 368 +++++++++++++++++++++
 tools/testing/selftests/powerpc/tm/tm.h            |   5 +
 3 files changed, 375 insertions(+), 1 deletion(-)
 create mode 100644 tools/testing/selftests/powerpc/tm/tm-unavailable.c

diff --git a/tools/testing/selftests/powerpc/tm/Makefile b/tools/testing/selftests/powerpc/tm/Makefile
index 7bfcd45..24855c0 100644
--- a/tools/testing/selftests/powerpc/tm/Makefile
+++ b/tools/testing/selftests/powerpc/tm/Makefile
@@ -2,7 +2,7 @@ SIGNAL_CONTEXT_CHK_TESTS := tm-signal-context-chk-gpr tm-signal-context-chk-fpu
 	tm-signal-context-chk-vmx tm-signal-context-chk-vsx
 
 TEST_GEN_PROGS := tm-resched-dscr tm-syscall tm-signal-msr-resv tm-signal-stack \
-	tm-vmxcopy tm-fork tm-tar tm-tmspr tm-vmx-unavail \
+	tm-vmxcopy tm-fork tm-tar tm-tmspr tm-vmx-unavail tm-unavailable \
 	$(SIGNAL_CONTEXT_CHK_TESTS)
 
 include ../../lib.mk
@@ -16,6 +16,7 @@ $(OUTPUT)/tm-syscall: CFLAGS += -I../../../../../usr/include
 $(OUTPUT)/tm-tmspr: CFLAGS += -pthread
 $(OUTPUT)/tm-vmx-unavail: CFLAGS += -pthread -m64
 $(OUTPUT)/tm-resched-dscr: ../pmu/lib.o
+$(OUTPUT)/tm-unavailable: CFLAGS += -O0 -pthread -m64 -Wno-error=uninitialized -mvsx
 
 SIGNAL_CONTEXT_CHK_TESTS := $(patsubst %,$(OUTPUT)/%,$(SIGNAL_CONTEXT_CHK_TESTS))
 $(SIGNAL_CONTEXT_CHK_TESTS): tm-signal.S
diff --git a/tools/testing/selftests/powerpc/tm/tm-unavailable.c b/tools/testing/selftests/powerpc/tm/tm-unavailable.c
new file mode 100644
index 0000000..69a4e8c
--- /dev/null
+++ b/tools/testing/selftests/powerpc/tm/tm-unavailable.c
@@ -0,0 +1,368 @@
+/*
+ * Copyright 2017, Gustavo Romero, Breno Leitao, Cyril Bur, IBM Corp.
+ * Licensed under GPLv2.
+ *
+ * Force FP, VEC and VSX unavailable exception during transaction in all
+ * possible scenarios regarding the MSR.FP and MSR.VEC state, e.g. when FP
+ * is enable and VEC is disable, when FP is disable and VEC is enable, and
+ * so on. Then we check if the restored state is correctly set for the
+ * FP and VEC registers to the previous state we set just before we entered
+ * in TM, i.e. we check if it corrupts somehow the recheckpointed FP and
+ * VEC/Altivec registers on abortion due to an unavailable exception in TM.
+ * N.B. In this test we do not test all the FP/Altivec/VSX registers for
+ * corruption, but only for registers vs0 and vs32, which are respectively
+ * representatives of FP and VEC/Altivec reg sets.
+ */
+
+#define _GNU_SOURCE
+#include <stdio.h>
+#include <stdlib.h>
+#include <unistd.h>
+#include <inttypes.h>
+#include <stdbool.h>
+#include <pthread.h>
+#include <sched.h>
+
+#include "tm.h"
+
+#define DEBUG 0
+
+/* Unavailable exceptions to test in HTM */
+#define FP_UNA_EXCEPTION	0
+#define VEC_UNA_EXCEPTION	1
+#define VSX_UNA_EXCEPTION	2
+
+#define NUM_EXCEPTIONS		3
+
+struct Flags {
+	int touch_fp;
+	int touch_vec;
+	int result;
+	int exception;
+} flags;
+
+bool expecting_failure(void)
+{
+	if (flags.touch_fp && flags.exception == FP_UNA_EXCEPTION)
+		return false;
+
+	if (flags.touch_vec && flags.exception == VEC_UNA_EXCEPTION)
+		return false;
+
+	/* If both FP and VEC are touched it does not mean that touching
+	 * VSX won't raise an exception. However since FP and VEC state
+	 * are already correctly loaded, the transaction is not aborted
+	 * (i.e. treclaimed/trecheckpointed) and MSR.VSX is just set as 1,
+	 * so a TM failure is not expected also in this case.
+	 */
+	if ((flags.touch_fp && flags.touch_vec) &&
+	     flags.exception == VSX_UNA_EXCEPTION)
+		return false;
+
+	return true;
+}
+
+/* Check if failure occurred whilst in transaction. */
+bool is_failure(uint64_t condition_reg)
+{
+	/* When failure handling occurs, CR0 is set to 0b1010 (0xa). Otherwise
+	 * transaction completes without failure and hence reaches out 'tend.'
+	 * that sets CR0 to 0b0100 (0x4).
+	 */
+	return ((condition_reg >> 28) & 0xa) == 0xa;
+}
+
+void *ping(void *input)
+{
+
+	/* Expected values for vs0 and vs32 after a TM failure. They must
+	 * never change, otherwise they got corrupted.
+	 */
+	uint64_t high_vs0 = 0x5555555555555555;
+	uint64_t low_vs0 = 0xffffffffffffffff;
+	uint64_t high_vs32 = 0x5555555555555555;
+	uint64_t low_vs32 = 0xffffffffffffffff;
+
+	/* Counter for busy wait */
+	uint64_t counter = 0x1ff000000;
+
+	/* Variable to keep a copy of CR register content taken just after we
+	 * leave the transactional state.
+	 */
+	uint64_t cr_ = 0;
+
+	/* Wait a bit so thread can get its name "ping".
+	 * This is not important to reproduce the issue but
+	 * it's nice to have for systemtap debugging.
+	 */
+	if (DEBUG)
+		sleep(1);
+
+	printf("If MSR.FP=%d MSR.VEC=%d: ", flags.touch_fp, flags.touch_vec);
+
+	if (flags.exception != FP_UNA_EXCEPTION &&
+	    flags.exception != VEC_UNA_EXCEPTION &&
+	    flags.exception != VSX_UNA_EXCEPTION) {
+		printf("No valid exception specified to test.\n");
+		return NULL;
+	}
+
+	asm (
+		/* Prepare to merge low and high. */
+		"	mtvsrd		33, %[high_vs0]		;"
+		"	mtvsrd		34, %[low_vs0]		;"
+
+		/*
+		 * Adjust VS0 expected value after an TM failure,
+		 * i.e. vs0 = 0x5555555555555555555FFFFFFFFFFFFFFFF
+		 */
+		"	xxmrghd		0, 33, 34		;"
+
+		/*
+		 * Adjust VS32 expected value after an TM failure,
+		 * i.e. vs32 = 0x5555555555555555555FFFFFFFFFFFFFFFF
+		 */
+		"	xxmrghd		32, 33, 34		;"
+
+		/*
+		 * Wait an amount of context switches so load_fp and load_vec
+		 * overflow and MSR.FP, MSR.VEC, and MSR.VSX become zero (off).
+		 */
+		"	mtctr		%[counter]		;"
+
+		/* Decrement CTR branch if CTR non zero. */
+		"1:	bdnz 1b					;"
+
+		/*
+		 * Check if we want to touch FP prior to the test in order
+		 * to set MSR.FP = 1 before provoking an unavailable
+		 * exception in TM.
+		 */
+		"	cmpldi		%[touch_fp], 0		;"
+		"	beq		no_fp			;"
+		"	fadd		10, 10, 10		;"
+		"no_fp:						;"
+
+		/*
+		 * Check if we want to touch VEC prior to the test in order
+		 * to set MSR.VEC = 1 before provoking an unavailable
+		 * exception in TM.
+		 */
+		"	cmpldi		%[touch_vec], 0		;"
+		"	beq		no_vec			;"
+		"	vaddcuw		10, 10, 10		;"
+		"no_vec:					;"
+
+		/*
+		 * Perhaps it would be a better idea to do the
+		 * compares outside transactional context and simply
+		 * duplicate code.
+		 */
+		"	tbegin.					;"
+		"	beq		trans_fail		;"
+
+		/* Do we do FP Unavailable? */
+		"	cmpldi		%[exception], %[ex_fp]	;"
+		"	bne		1f			;"
+		"	fadd		10, 10, 10		;"
+		"	b		done			;"
+
+		/* Do we do VEC Unavailable? */
+		"1:	cmpldi		%[exception], %[ex_vec]	;"
+		"	bne		2f			;"
+		"	vaddcuw		10, 10, 10		;"
+		"	b		done			;"
+
+		/*
+		 * Not FP or VEC, therefore VSX. Ensure this
+		 * instruction always generates a VSX Unavailable.
+		 * ISA 3.0 is tricky here.
+		 * (xxmrghd will on ISA 2.07 and ISA 3.0)
+		 */
+		"2:	xxmrghd		10, 10, 10		;"
+
+		"done:	tend. ;"
+
+		"trans_fail: ;"
+
+		/* Give values back to C. */
+		"	mfvsrd		%[high_vs0], 0		;"
+		"	xxsldwi		3, 0, 0, 2		;"
+		"	mfvsrd		%[low_vs0], 3		;"
+		"	mfvsrd		%[high_vs32], 32	;"
+		"	xxsldwi		3, 32, 32, 2		;"
+		"	mfvsrd		%[low_vs32], 3		;"
+
+		/* Give CR back to C so that it can check what happened. */
+		"	mfcr		%[cr_]		;"
+
+		: [high_vs0]  "+r" (high_vs0),
+		  [low_vs0]   "+r" (low_vs0),
+		  [high_vs32] "=r" (high_vs32),
+		  [low_vs32]  "=r" (low_vs32),
+		  [cr_]       "+r" (cr_)
+		: [touch_fp]  "r"  (flags.touch_fp),
+		  [touch_vec] "r"  (flags.touch_vec),
+		  [exception] "r"  (flags.exception),
+		  [ex_fp]     "i"  (FP_UNA_EXCEPTION),
+		  [ex_vec]    "i"  (VEC_UNA_EXCEPTION),
+		  [ex_vsx]    "i"  (VSX_UNA_EXCEPTION),
+		  [counter]   "r"  (counter)
+
+		: "cr0", "ctr", "v10", "vs0", "vs10", "vs3", "vs32", "vs33",
+		  "vs34", "fr10"
+
+		);
+
+	/* Check if we were expecting a failure and it did not occur by checking
+	 * CR0 state just after we leave the transaction. Either way we check if
+	 * vs0 or vs32 got corrupted.
+	 */
+	if (expecting_failure() && !is_failure(cr_)) {
+		printf("\n\tExpecting the transaction to fail, %s",
+			"but it didn't\n\t");
+		flags.result++;
+	}
+
+	/* Check if we were not expecting a failure and a it occurred. */
+	if (!expecting_failure() && is_failure(cr_)) {
+		printf("\n\tUnexpected transaction failure 0x%02lx\n\t",
+			failure_code());
+		return (void *) -1;
+	}
+
+	/* Check if TM failed due to the cause we were expecting. 0xda is a
+	 * TM_CAUSE_FAC_UNAV cause, otherwise it's an unexpected cause.
+	 */
+	if (is_failure(cr_) && !failure_is_unavailable()) {
+		printf("\n\tUnexpected failure cause 0x%02lx\n\t",
+			failure_code());
+		return (void *) -1;
+	}
+
+	/* 0x4 is a success and 0xa is a fail. See comment in
+	 * is_failure().
+	 */
+	if (DEBUG)
+		printf("CR0: 0x%1lx ", cr_ >> 28);
+
+	/* Check FP (vs0) for the expected value. */
+	if (high_vs0 != 0x5555555555555555 || low_vs0 != 0xFFFFFFFFFFFFFFFF) {
+		printf("FP corrupted!");
+			printf("  high = %#16" PRIx64 "  low = %#16" PRIx64 " ",
+				high_vs0, low_vs0);
+		flags.result++;
+	} else
+		printf("FP ok ");
+
+	/* Check VEC (vs32) for the expected value. */
+	if (high_vs32 != 0x5555555555555555 || low_vs32 != 0xFFFFFFFFFFFFFFFF) {
+		printf("VEC corrupted!");
+			printf("  high = %#16" PRIx64 "  low = %#16" PRIx64,
+				high_vs32, low_vs32);
+		flags.result++;
+	} else
+		printf("VEC ok");
+
+	putchar('\n');
+
+	return NULL;
+}
+
+/* Thread to force context switch */
+void *pong(void *not_used)
+{
+	/* Wait thread get its name "pong". */
+	if (DEBUG)
+		sleep(1);
+
+	/* Classed as an interactive-like thread. */
+	while (1)
+		sched_yield();
+}
+
+/* Function that creates a thread and launches the "ping" task. */
+void test_fp_vec(int fp, int vec, pthread_attr_t *attr)
+{
+	int retries = 2;
+	void *ret_value;
+	pthread_t t0;
+
+	flags.touch_fp = fp;
+	flags.touch_vec = vec;
+
+	/* Without luck it's possible that the transaction is aborted
+	 * not due to the unavailable exception caught in the middle
+	 * as we expect but also, for instance, due to a context switch
+	 * or due to a KVM reschedule (if it's running on a VM). Thus we
+	 * try a few times before giving up, checking if the failure
+	 * cause is the one we expect.
+	 */
+
+	do {
+		/* Bind 'ping' to CPU 0, as specified in 'attr'. */
+		pthread_create(&t0, attr, ping, (void *) &flags);
+		pthread_setname_np(t0, "ping");
+		pthread_join(t0, &ret_value);
+		retries--;
+	} while (ret_value != NULL && retries);
+
+	if (!retries) {
+		flags.result = 1;
+		if (DEBUG)
+			printf("All transactions failed unexpectedly\n");
+
+	}
+}
+
+int main(int argc, char **argv)
+{
+	int exception; /* FP = 0, VEC = 1, VSX = 2 */
+	pthread_t t1;
+	pthread_attr_t attr;
+	cpu_set_t cpuset;
+
+	/* Set only CPU 0 in the mask. Both threads will be bound to CPU 0. */
+	CPU_ZERO(&cpuset);
+	CPU_SET(0, &cpuset);
+
+	/* Init pthread attribute. */
+	pthread_attr_init(&attr);
+
+	/* Set CPU 0 mask into the pthread attribute. */
+	pthread_attr_setaffinity_np(&attr, sizeof(cpu_set_t), &cpuset);
+
+	pthread_create(&t1, &attr /* Bind 'pong' to CPU 0 */, pong, NULL);
+	pthread_setname_np(t1, "pong"); /* Name it for systemtap convenience */
+
+	flags.result = 0;
+
+	for (exception = 0; exception < NUM_EXCEPTIONS; exception++) {
+		printf("Checking if FP/VEC registers are sane after");
+
+		if (exception == FP_UNA_EXCEPTION)
+			printf(" a FP unavailable exception...\n");
+
+		else if (exception == VEC_UNA_EXCEPTION)
+			printf(" a VEC unavailable exception...\n");
+
+		else
+			printf(" a VSX unavailable exception...\n");
+
+		flags.exception = exception;
+
+		test_fp_vec(0, 0, &attr);
+		test_fp_vec(1, 0, &attr);
+		test_fp_vec(0, 1, &attr);
+		test_fp_vec(1, 1, &attr);
+
+	}
+
+	if (flags.result > 0) {
+		printf("result: failed!\n");
+		exit(1);
+	} else {
+		printf("result: success\n");
+		exit(0);
+	}
+}
diff --git a/tools/testing/selftests/powerpc/tm/tm.h b/tools/testing/selftests/powerpc/tm/tm.h
index 0ffff04..df42042 100644
--- a/tools/testing/selftests/powerpc/tm/tm.h
+++ b/tools/testing/selftests/powerpc/tm/tm.h
@@ -47,6 +47,11 @@ static inline bool failure_is_syscall(void)
 	return (failure_code() & TM_CAUSE_SYSCALL) == TM_CAUSE_SYSCALL;
 }
 
+static inline bool failure_is_unavailable(void)
+{
+	return (failure_code() & TM_CAUSE_FAC_UNAV) == TM_CAUSE_FAC_UNAV;
+}
+
 static inline bool failure_is_nesting(void)
 {
 	return (__builtin_get_texasru() & 0x400000);
-- 
2.7.4

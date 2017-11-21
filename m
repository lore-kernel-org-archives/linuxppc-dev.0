Return-Path: <cyrilbur@gmail.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3ygxkL3tmfzDrM8
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Nov 2017 18:17:46 +1100 (AEDT)
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 vAL79VPY081291
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Nov 2017 02:17:43 -0500
Received: from e06smtp10.uk.ibm.com (e06smtp10.uk.ibm.com [195.75.94.106])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2eca6wp04m-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Nov 2017 02:17:43 -0500
Received: from localhost
 by e06smtp10.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <cyrilbur@gmail.com>;
 Tue, 21 Nov 2017 07:17:41 -0000
From: Cyril Bur <cyrilbur@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: leitao@debian.org, gromero@linux.vnet.ibm.com
Subject: [PATCH 2/2] selftests/powerpc: Calculate spin time in tm-unavailable
Date: Tue, 21 Nov 2017 18:17:20 +1100
In-Reply-To: <20171121071720.24619-1-cyrilbur@gmail.com>
References: <20171121071720.24619-1-cyrilbur@gmail.com>
Message-Id: <20171121071720.24619-2-cyrilbur@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Currently the tm-unavailable test spins for a fixed amount of time in
an attempt to ensure the FPU/VMX/VSX facilities are off. This value was
experimentally tested to be long enough.

Problems may arise if kernel heuristics were to change. This patch
should future proof this test.

Signed-off-by: Cyril Bur <cyrilbur@gmail.com>
---
Because the test no longer needs to use such a conservative time for
the busy wait, it actually runs much faster.


 .../testing/selftests/powerpc/tm/tm-unavailable.c  | 92 ++++++++++++++++++++--
 1 file changed, 84 insertions(+), 8 deletions(-)

diff --git a/tools/testing/selftests/powerpc/tm/tm-unavailable.c b/tools/testing/selftests/powerpc/tm/tm-unavailable.c
index e6a0fad2bfd0..54aeb7a7fbb1 100644
--- a/tools/testing/selftests/powerpc/tm/tm-unavailable.c
+++ b/tools/testing/selftests/powerpc/tm/tm-unavailable.c
@@ -33,6 +33,11 @@
 #define VEC_UNA_EXCEPTION	1
 #define VSX_UNA_EXCEPTION	2
 
+#define ERR_RETRY 1
+#define ERR_ADJUST 2
+
+#define COUNTER_INCREMENT (0x1000000)
+
 #define NUM_EXCEPTIONS		3
 #define err_at_line(status, errnum, format, ...) \
 	error_at_line(status, errnum,  __FILE__, __LINE__, format ##__VA_ARGS__)
@@ -45,6 +50,7 @@ struct Flags {
 	int touch_vec;
 	int result;
 	int exception;
+	uint64_t counter;
 } flags;
 
 bool expecting_failure(void)
@@ -87,14 +93,12 @@ void *ping(void *input)
 	 * Expected values for vs0 and vs32 after a TM failure. They must never
 	 * change, otherwise they got corrupted.
 	 */
+	long rc = 0;
 	uint64_t high_vs0 = 0x5555555555555555;
 	uint64_t low_vs0 = 0xffffffffffffffff;
 	uint64_t high_vs32 = 0x5555555555555555;
 	uint64_t low_vs32 = 0xffffffffffffffff;
 
-	/* Counter for busy wait */
-	uint64_t counter = 0x1ff000000;
-
 	/*
 	 * Variable to keep a copy of CR register content taken just after we
 	 * leave the transactional state.
@@ -217,7 +221,7 @@ void *ping(void *input)
 		  [ex_fp]     "i"  (FP_UNA_EXCEPTION),
 		  [ex_vec]    "i"  (VEC_UNA_EXCEPTION),
 		  [ex_vsx]    "i"  (VSX_UNA_EXCEPTION),
-		  [counter]   "r"  (counter)
+		  [counter]   "r"  (flags.counter)
 
 		: "cr0", "ctr", "v10", "vs0", "vs10", "vs3", "vs32", "vs33",
 		  "vs34", "fr10"
@@ -232,14 +236,14 @@ void *ping(void *input)
 	if (expecting_failure() && !is_failure(cr_)) {
 		printf("\n\tExpecting the transaction to fail, %s",
 			"but it didn't\n\t");
-		flags.result++;
+		rc = ERR_ADJUST;
 	}
 
 	/* Check if we were not expecting a failure and a it occurred. */
 	if (!expecting_failure() && is_failure(cr_)) {
 		printf("\n\tUnexpected transaction failure 0x%02lx\n\t",
 			failure_code());
-		return (void *) -1;
+		rc = ERR_RETRY;
 	}
 
 	/*
@@ -249,7 +253,7 @@ void *ping(void *input)
 	if (is_failure(cr_) && !failure_is_unavailable()) {
 		printf("\n\tUnexpected failure cause 0x%02lx\n\t",
 			failure_code());
-		return (void *) -1;
+		rc = ERR_RETRY;
 	}
 
 	/* 0x4 is a success and 0xa is a fail. See comment in is_failure(). */
@@ -276,7 +280,7 @@ void *ping(void *input)
 
 	putchar('\n');
 
-	return NULL;
+	return (void *)rc;
 }
 
 /* Thread to force context switch */
@@ -291,6 +295,55 @@ void *pong(void *not_used)
 		sched_yield();
 }
 
+static void flags_set_counter(struct Flags *flags)
+{
+	uint64_t cr_;
+	int count = 0;
+
+	do {
+		if (count == 0)
+			printf("\tTrying 0x%08" PRIx64 "... ", flags->counter);
+		else
+			printf("%d, ", count);
+		fflush(stdout);
+		asm (
+			/*
+			 * Wait an amount of context switches so
+			 * load_fp and load_vec overflow and MSR.FP,
+			 * MSR.VEC, and MSR.VSX become zero (off).
+			 */
+			"	mtctr		%[counter]		;"
+
+			/* Decrement CTR branch if CTR non zero. */
+			"1:	bdnz 1b					;"
+			"	tbegin.					;"
+			"	beq		tfail			;"
+
+			/* Get a facility unavailable */
+			"	fadd		10, 10, 10		;"
+			"	tend.                                   ;"
+			"tfail:                                         ;"
+
+			/*
+			 * Give CR back to C so that it can check what
+			 * happened.
+			 */
+			"	mfcr		%[cr_]			;"
+
+			: [cr_]       "+r" (cr_)
+			: [counter]   "r"  (flags->counter)
+			: "cr0", "ctr", "fr10"
+			);
+		count++;
+		if (!is_failure(cr_) || !failure_is_unavailable()) {
+			count = 0;
+			flags->counter += COUNTER_INCREMENT;
+			putchar('\n');
+		}
+	} while (count < 3);
+	printf("3\n");
+}
+
 /* Function that creates a thread and launches the "ping" task. */
 void test_fp_vec(int fp, int vec, pthread_attr_t *attr)
 {
@@ -322,6 +375,17 @@ void test_fp_vec(int fp, int vec, pthread_attr_t *attr)
 		if (rc)
 			pr_err(rc, "pthread_join");
 
+		if ((long)ret_value == ERR_ADJUST) {
+			printf("Adjusting the facility unavailable spin time...\n");
+			/*
+			 * Be a bit more agressive just now - we'd
+			 * really like to have it work
+			 */
+			flags.counter += (2 * COUNTER_INCREMENT);
+			flags_set_counter(&flags);
+			printf("Now using 0x%08" PRIx64 "\n", flags.counter);
+		}
+
 		retries--;
 	} while (ret_value != NULL && retries);
 
@@ -340,6 +404,18 @@ int main(int argc, char **argv)
 	pthread_attr_t attr;
 	cpu_set_t cpuset;
 
+	/*
+	 * Default counter for busy wait.
+	 * 0x18000000 is a good baseline determined by experimentation
+	 * on a POWER8
+	 * The autodetecting code will bump it up if it too low.
+	 */
+	flags.counter = 0x18000000;
+
+	printf("Testing required spin time required for facility unavailable...\n");
+	flags_set_counter(&flags);
+	printf("Spin time required for a reliable facility unavailable TM failure: 0x%" PRIx64 "\n",
+			flags.counter);
 	/* Set only CPU 0 in the mask. Both threads will be bound to CPU 0. */
 	CPU_ZERO(&cpuset);
 	CPU_SET(0, &cpuset);
-- 
2.15.0

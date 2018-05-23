Return-Path: <wei.guo.simon@gmail.com>
Received: from mail-pf0-x241.google.com (mail-pf0-x241.google.com
 [IPv6:2607:f8b0:400e:c00::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40rPPm39hJzDrph
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 May 2018 17:33:16 +1000 (AEST)
Received: by mail-pf0-x241.google.com with SMTP id f189-v6so10062760pfa.7
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 May 2018 00:33:16 -0700 (PDT)
From: wei.guo.simon@gmail.com
To: linuxppc-dev@lists.ozlabs.org
Cc: Paul Mackerras <paulus@ozlabs.org>, Michael Ellerman <mpe@ellerman.id.au>,
 "Naveen N.  Rao" <naveen.n.rao@linux.vnet.ibm.com>,
 Cyril Bur <cyrilbur@gmail.com>, Simon Guo <wei.guo.simon@gmail.com>
Subject: [PATCH v5 4/4] powerpc:selftest update memcmp_64 selftest for VMX
 implementation
Date: Wed, 23 May 2018 14:48:03 +0800
Message-Id: <1527058083-6998-5-git-send-email-wei.guo.simon@gmail.com>
In-Reply-To: <1527058083-6998-1-git-send-email-wei.guo.simon@gmail.com>
References: <1527058083-6998-1-git-send-email-wei.guo.simon@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Simon Guo <wei.guo.simon@gmail.com>

This patch reworked selftest memcmp_64 so that memcmp selftest can
cover more test cases.

It adds testcases for:
- memcmp over 4K bytes size.
- s1/s2 with different/random offset on 16 bytes boundary.
- enter/exit_vmx_ops pairness.

Signed-off-by: Simon Guo <wei.guo.simon@gmail.com>
---
 .../selftests/powerpc/copyloops/asm/ppc_asm.h      |  4 +-
 .../selftests/powerpc/stringloops/asm/ppc_asm.h    | 22 +++++
 .../testing/selftests/powerpc/stringloops/memcmp.c | 98 +++++++++++++++++-----
 3 files changed, 100 insertions(+), 24 deletions(-)

diff --git a/tools/testing/selftests/powerpc/copyloops/asm/ppc_asm.h b/tools/testing/selftests/powerpc/copyloops/asm/ppc_asm.h
index 5ffe04d..dfce161 100644
--- a/tools/testing/selftests/powerpc/copyloops/asm/ppc_asm.h
+++ b/tools/testing/selftests/powerpc/copyloops/asm/ppc_asm.h
@@ -36,11 +36,11 @@
 	li	r3,0
 	blr
 
-FUNC_START(enter_vmx_copy)
+FUNC_START(enter_vmx_ops)
 	li	r3,1
 	blr
 
-FUNC_START(exit_vmx_copy)
+FUNC_START(exit_vmx_ops)
 	blr
 
 FUNC_START(memcpy_power7)
diff --git a/tools/testing/selftests/powerpc/stringloops/asm/ppc_asm.h b/tools/testing/selftests/powerpc/stringloops/asm/ppc_asm.h
index 136242e..185d257 100644
--- a/tools/testing/selftests/powerpc/stringloops/asm/ppc_asm.h
+++ b/tools/testing/selftests/powerpc/stringloops/asm/ppc_asm.h
@@ -1,4 +1,6 @@
 /* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _PPC_ASM_H
+#define __PPC_ASM_H
 #include <ppc-asm.h>
 
 #ifndef r1
@@ -6,3 +8,23 @@
 #endif
 
 #define _GLOBAL(A) FUNC_START(test_ ## A)
+
+#define CONFIG_ALTIVEC
+
+#define R14 r14
+#define R15 r15
+#define R16 r16
+#define R17 r17
+#define R18 r18
+#define R19 r19
+#define R20 r20
+#define R21 r21
+#define R22 r22
+#define R29 r29
+#define R30 r30
+#define R31 r31
+
+#define STACKFRAMESIZE	256
+#define STK_REG(i)	(112 + ((i)-14)*8)
+
+#endif
diff --git a/tools/testing/selftests/powerpc/stringloops/memcmp.c b/tools/testing/selftests/powerpc/stringloops/memcmp.c
index 8250db2..b5cf717 100644
--- a/tools/testing/selftests/powerpc/stringloops/memcmp.c
+++ b/tools/testing/selftests/powerpc/stringloops/memcmp.c
@@ -2,20 +2,40 @@
 #include <malloc.h>
 #include <stdlib.h>
 #include <string.h>
+#include <time.h>
 #include "utils.h"
 
 #define SIZE 256
 #define ITERATIONS 10000
 
+#define LARGE_SIZE (5 * 1024)
+#define LARGE_ITERATIONS 1000
+#define LARGE_MAX_OFFSET 32
+#define LARGE_SIZE_START 4096
+
+#define MAX_OFFSET_DIFF_S1_S2 48
+
+int vmx_count;
+int enter_vmx_ops(void)
+{
+	vmx_count++;
+	return 1;
+}
+
+void exit_vmx_ops(void)
+{
+	vmx_count--;
+}
 int test_memcmp(const void *s1, const void *s2, size_t n);
 
 /* test all offsets and lengths */
-static void test_one(char *s1, char *s2)
+static void test_one(char *s1, char *s2, unsigned long max_offset,
+		unsigned long size_start, unsigned long max_size)
 {
 	unsigned long offset, size;
 
-	for (offset = 0; offset < SIZE; offset++) {
-		for (size = 0; size < (SIZE-offset); size++) {
+	for (offset = 0; offset < max_offset; offset++) {
+		for (size = size_start; size < (max_size - offset); size++) {
 			int x, y;
 			unsigned long i;
 
@@ -35,70 +55,104 @@ static void test_one(char *s1, char *s2)
 				printf("\n");
 				abort();
 			}
+
+			if (vmx_count != 0) {
+				printf("vmx enter/exit not paired.(offset:%ld size:%ld s1:%p s2:%p vc:%d\n",
+					offset, size, s1, s2, vmx_count);
+				printf("\n");
+				abort();
+			}
 		}
 	}
 }
 
-static int testcase(void)
+static int testcase(bool islarge)
 {
 	char *s1;
 	char *s2;
 	unsigned long i;
 
-	s1 = memalign(128, SIZE);
+	unsigned long comp_size = (islarge ? LARGE_SIZE : SIZE);
+	unsigned long alloc_size = comp_size + MAX_OFFSET_DIFF_S1_S2;
+	int iterations = islarge ? LARGE_ITERATIONS : ITERATIONS;
+
+	s1 = memalign(128, alloc_size);
 	if (!s1) {
 		perror("memalign");
 		exit(1);
 	}
 
-	s2 = memalign(128, SIZE);
+	s2 = memalign(128, alloc_size);
 	if (!s2) {
 		perror("memalign");
 		exit(1);
 	}
 
-	srandom(1);
+	srandom(time(0));
 
-	for (i = 0; i < ITERATIONS; i++) {
+	for (i = 0; i < iterations; i++) {
 		unsigned long j;
 		unsigned long change;
+		char *rand_s1 = s1;
+		char *rand_s2 = s2;
 
-		for (j = 0; j < SIZE; j++)
+		for (j = 0; j < alloc_size; j++)
 			s1[j] = random();
 
-		memcpy(s2, s1, SIZE);
+		rand_s1 += random() % MAX_OFFSET_DIFF_S1_S2;
+		rand_s2 += random() % MAX_OFFSET_DIFF_S1_S2;
+		memcpy(rand_s2, rand_s1, comp_size);
 
 		/* change one byte */
-		change = random() % SIZE;
-		s2[change] = random() & 0xff;
-
-		test_one(s1, s2);
+		change = random() % comp_size;
+		rand_s2[change] = random() & 0xff;
+
+		if (islarge)
+			test_one(rand_s1, rand_s2, LARGE_MAX_OFFSET,
+					LARGE_SIZE_START, comp_size);
+		else
+			test_one(rand_s1, rand_s2, SIZE, 0, comp_size);
 	}
 
-	srandom(1);
+	srandom(time(0));
 
-	for (i = 0; i < ITERATIONS; i++) {
+	for (i = 0; i < iterations; i++) {
 		unsigned long j;
 		unsigned long change;
+		char *rand_s1 = s1;
+		char *rand_s2 = s2;
 
-		for (j = 0; j < SIZE; j++)
+		for (j = 0; j < alloc_size; j++)
 			s1[j] = random();
 
-		memcpy(s2, s1, SIZE);
+		rand_s1 += random() % MAX_OFFSET_DIFF_S1_S2;
+		rand_s2 += random() % MAX_OFFSET_DIFF_S1_S2;
+		memcpy(rand_s2, rand_s1, comp_size);
 
 		/* change multiple bytes, 1/8 of total */
-		for (j = 0; j < SIZE / 8; j++) {
-			change = random() % SIZE;
+		for (j = 0; j < comp_size / 8; j++) {
+			change = random() % comp_size;
 			s2[change] = random() & 0xff;
 		}
 
-		test_one(s1, s2);
+		if (islarge)
+			test_one(rand_s1, rand_s2, LARGE_MAX_OFFSET,
+					LARGE_SIZE_START, comp_size);
+		else
+			test_one(rand_s1, rand_s2, SIZE, 0, comp_size);
 	}
 
 	return 0;
 }
 
+static int testcases(void)
+{
+	testcase(0);
+	testcase(1);
+	return 0;
+}
+
 int main(void)
 {
-	return test_harness(testcase, "memcmp");
+	return test_harness(testcases, "memcmp");
 }
-- 
1.8.3.1

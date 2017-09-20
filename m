Return-Path: <wei.guo.simon@gmail.com>
Received: from mail-pf0-x243.google.com (mail-pf0-x243.google.com
 [IPv6:2607:f8b0:400e:c00::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xz2N056mrzDsMT
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 22 Sep 2017 15:38:56 +1000 (AEST)
Received: by mail-pf0-x243.google.com with SMTP id f84so57959pfj.3
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 21 Sep 2017 22:38:56 -0700 (PDT)
From: wei.guo.simon@gmail.com
To: linuxppc-dev@lists.ozlabs.org
Cc: Paul Mackerras <paulus@ozlabs.org>, Michael Ellerman <mpe@ellerman.id.au>,
 "Naveen N.  Rao" <naveen.n.rao@linux.vnet.ibm.com>,
 David Laight <David.Laight@ACULAB.COM>,
 Christophe LEROY <christophe.leroy@c-s.fr>,
 Simon Guo <wei.guo.simon@gmail.com>
Subject: [PATCH v2 3/3] powerpc:selftest update memcmp_64 selftest for VMX
 implementation
Date: Thu, 21 Sep 2017 07:34:40 +0800
Message-Id: <1505950480-14830-4-git-send-email-wei.guo.simon@gmail.com>
In-Reply-To: <1505950480-14830-1-git-send-email-wei.guo.simon@gmail.com>
References: <1505950480-14830-1-git-send-email-wei.guo.simon@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Simon Guo <wei.guo.simon@gmail.com>

This patch adjust selftest memcmp_64 so that memcmp selftest can be
compiled successfully.

It also adds testcases for memcmp over 4K bytes size.

Signed-off-by: Simon Guo <wei.guo.simon@gmail.com>
---
 .../selftests/powerpc/copyloops/asm/ppc_asm.h      |  2 +-
 .../selftests/powerpc/stringloops/asm/ppc_asm.h    | 31 +++++++++++
 .../testing/selftests/powerpc/stringloops/memcmp.c | 63 +++++++++++++++-------
 3 files changed, 75 insertions(+), 21 deletions(-)

diff --git a/tools/testing/selftests/powerpc/copyloops/asm/ppc_asm.h b/tools/testing/selftests/powerpc/copyloops/asm/ppc_asm.h
index 80d34a9..a9da02d 100644
--- a/tools/testing/selftests/powerpc/copyloops/asm/ppc_asm.h
+++ b/tools/testing/selftests/powerpc/copyloops/asm/ppc_asm.h
@@ -35,7 +35,7 @@
 	li	r3,0
 	blr
 
-FUNC_START(enter_vmx_copy)
+FUNC_START(enter_vmx_ops)
 	li	r3,1
 	blr
 
diff --git a/tools/testing/selftests/powerpc/stringloops/asm/ppc_asm.h b/tools/testing/selftests/powerpc/stringloops/asm/ppc_asm.h
index 11bece8..c8bb360 100644
--- a/tools/testing/selftests/powerpc/stringloops/asm/ppc_asm.h
+++ b/tools/testing/selftests/powerpc/stringloops/asm/ppc_asm.h
@@ -1,3 +1,5 @@
+#ifndef _PPC_ASM_H
+#define __PPC_ASM_H
 #include <ppc-asm.h>
 
 #ifndef r1
@@ -5,3 +7,32 @@
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
+#define _GLOBAL(A) FUNC_START(test_ ## A)
+#define _GLOBAL_TOC(A) _GLOBAL(A)
+
+#define PPC_MTOCRF(A, B)	mtocrf A, B
+
+FUNC_START(enter_vmx_ops)
+	li      r3, 1
+	blr
+
+#endif
diff --git a/tools/testing/selftests/powerpc/stringloops/memcmp.c b/tools/testing/selftests/powerpc/stringloops/memcmp.c
index 30b1222..4826669 100644
--- a/tools/testing/selftests/powerpc/stringloops/memcmp.c
+++ b/tools/testing/selftests/powerpc/stringloops/memcmp.c
@@ -1,20 +1,27 @@
 #include <malloc.h>
 #include <stdlib.h>
 #include <string.h>
+#include <time.h>
 #include "utils.h"
 
 #define SIZE 256
 #define ITERATIONS 10000
 
+#define LARGE_SIZE (5 * 1024)
+#define LARGE_ITERATIONS 1000
+#define LARGE_MAX_OFFSET 16
+#define LARGE_SIZE_START 4096
+
 int test_memcmp(const void *s1, const void *s2, size_t n);
 
 /* test all offsets and lengths */
-static void test_one(char *s1, char *s2)
+static void test_one(char *s1, char *s2, unsigned long max_offset,
+		unsigned long size_start)
 {
 	unsigned long offset, size;
 
-	for (offset = 0; offset < SIZE; offset++) {
-		for (size = 0; size < (SIZE-offset); size++) {
+	for (offset = 0; offset < max_offset; offset++) {
+		for (size = size_start; size < (SIZE-offset); size++) {
 			int x, y;
 			unsigned long i;
 
@@ -38,66 +45,82 @@ static void test_one(char *s1, char *s2)
 	}
 }
 
-static int testcase(void)
+static int testcase(bool islarge)
 {
 	char *s1;
 	char *s2;
 	unsigned long i;
 
-	s1 = memalign(128, SIZE);
+	unsigned long alloc_size = islarge ? LARGE_SIZE : SIZE;
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
 
-		for (j = 0; j < SIZE; j++)
+		for (j = 0; j < alloc_size; j++)
 			s1[j] = random();
 
-		memcpy(s2, s1, SIZE);
+		memcpy(s2, s1, alloc_size);
 
 		/* change one byte */
-		change = random() % SIZE;
+		change = random() % alloc_size;
 		s2[change] = random() & 0xff;
 
-		test_one(s1, s2);
+		if (islarge)
+			test_one(s1, s2, LARGE_MAX_OFFSET, LARGE_SIZE_START);
+		else
+			test_one(s1, s2, SIZE, 0);
 	}
 
-	srandom(1);
+	srandom(time(0));
 
-	for (i = 0; i < ITERATIONS; i++) {
+	for (i = 0; i < iterations; i++) {
 		unsigned long j;
 		unsigned long change;
 
-		for (j = 0; j < SIZE; j++)
+		for (j = 0; j < alloc_size; j++)
 			s1[j] = random();
 
-		memcpy(s2, s1, SIZE);
+		memcpy(s2, s1, alloc_size);
 
 		/* change multiple bytes, 1/8 of total */
-		for (j = 0; j < SIZE / 8; j++) {
-			change = random() % SIZE;
+		for (j = 0; j < alloc_size / 8; j++) {
+			change = random() % alloc_size;
 			s2[change] = random() & 0xff;
 		}
 
-		test_one(s1, s2);
+		if (islarge)
+			test_one(s1, s2, LARGE_MAX_OFFSET, LARGE_SIZE_START);
+		else
+			test_one(s1, s2, SIZE, 0);
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

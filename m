Return-Path: <paulus@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41hjYB5BMlzF2DB
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  3 Aug 2018 20:13:18 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPSA id 41hjYB1WNzz9s5c
 for <linuxppc-dev@ozlabs.org>; Fri,  3 Aug 2018 20:13:18 +1000 (AEST)
From: Paul Mackerras <paulus@ozlabs.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH v3 3/4] selftests/powerpc/64: Test exception cases in
 copy_tofrom_user
Date: Fri,  3 Aug 2018 20:13:05 +1000
Message-Id: <1533291186-5374-4-git-send-email-paulus@ozlabs.org>
In-Reply-To: <1533291186-5374-1-git-send-email-paulus@ozlabs.org>
References: <1533291186-5374-1-git-send-email-paulus@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Michael Ellerman <mpe@ellerman.id.au>

This adds a set of test cases to test the behaviour of
copy_tofrom_user when exceptions are encountered accessing the
source or destination.  Currently, copy_tofrom_user does not always
copy as many bytes as possible when an exception occurs on a store
to the destination, and that is reflected in failures in these tests.

Based on a test program from Anton Blanchard.

[paulus@ozlabs.org - test all three paths, wrote commit description,
 made EX_TABLE create an exception table.]

Signed-off-by: Paul Mackerras <paulus@ozlabs.org>
---
 .../testing/selftests/powerpc/copyloops/.gitignore |   3 +
 tools/testing/selftests/powerpc/copyloops/Makefile |  12 +-
 .../selftests/powerpc/copyloops/asm/ppc_asm.h      |  27 ++---
 .../powerpc/copyloops/copy_tofrom_user_reference.S |  24 ++++
 .../selftests/powerpc/copyloops/exc_validate.c     | 124 +++++++++++++++++++++
 tools/testing/selftests/powerpc/copyloops/stubs.S  |  19 ++++
 6 files changed, 188 insertions(+), 21 deletions(-)
 create mode 100644 tools/testing/selftests/powerpc/copyloops/copy_tofrom_user_reference.S
 create mode 100644 tools/testing/selftests/powerpc/copyloops/exc_validate.c
 create mode 100644 tools/testing/selftests/powerpc/copyloops/stubs.S

diff --git a/tools/testing/selftests/powerpc/copyloops/.gitignore b/tools/testing/selftests/powerpc/copyloops/.gitignore
index bc6c4ba..ce12cd0 100644
--- a/tools/testing/selftests/powerpc/copyloops/.gitignore
+++ b/tools/testing/selftests/powerpc/copyloops/.gitignore
@@ -8,3 +8,6 @@ memcpy_64_t1
 memcpy_64_t2
 memcpy_power7_t0
 memcpy_power7_t1
+copyuser_64_exc_t0
+copyuser_64_exc_t1
+copyuser_64_exc_t2
diff --git a/tools/testing/selftests/powerpc/copyloops/Makefile b/tools/testing/selftests/powerpc/copyloops/Makefile
index 9a5b0d2..9da0010 100644
--- a/tools/testing/selftests/powerpc/copyloops/Makefile
+++ b/tools/testing/selftests/powerpc/copyloops/Makefile
@@ -11,9 +11,10 @@ ASFLAGS = $(CFLAGS) -Wa,-mpower4
 TEST_GEN_PROGS := copyuser_64_t0 copyuser_64_t1 copyuser_64_t2 \
 		copyuser_p7_t0 copyuser_p7_t1 \
 		memcpy_64_t0 memcpy_64_t1 memcpy_64_t2 \
-		memcpy_p7_t0 memcpy_p7_t1
+		memcpy_p7_t0 memcpy_p7_t1 \
+		copyuser_64_exc_t0 copyuser_64_exc_t1 copyuser_64_exc_t2
 
-EXTRA_SOURCES := validate.c ../harness.c
+EXTRA_SOURCES := validate.c ../harness.c stubs.S
 
 include ../../lib.mk
 
@@ -41,3 +42,10 @@ $(OUTPUT)/memcpy_p7_t%:	memcpy_power7.S $(EXTRA_SOURCES)
 		-D COPY_LOOP=test_memcpy_power7 \
 		-D SELFTEST_CASE=$(subst memcpy_p7_t,,$(notdir $@)) \
 		-o $@ $^
+
+$(OUTPUT)/copyuser_64_exc_t%: copyuser_64.S exc_validate.c ../harness.c \
+		copy_tofrom_user_reference.S stubs.S
+	$(CC) $(CPPFLAGS) $(CFLAGS) \
+		-D COPY_LOOP=test___copy_tofrom_user_base \
+		-D SELFTEST_CASE=$(subst copyuser_64_exc_t,,$(notdir $@)) \
+		-o $@ $^
diff --git a/tools/testing/selftests/powerpc/copyloops/asm/ppc_asm.h b/tools/testing/selftests/powerpc/copyloops/asm/ppc_asm.h
index 91bc403..0605df8 100644
--- a/tools/testing/selftests/powerpc/copyloops/asm/ppc_asm.h
+++ b/tools/testing/selftests/powerpc/copyloops/asm/ppc_asm.h
@@ -1,4 +1,6 @@
 /* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __SELFTESTS_POWERPC_PPC_ASM_H
+#define __SELFTESTS_POWERPC_PPC_ASM_H
 #include <ppc-asm.h>
 
 #define CONFIG_ALTIVEC
@@ -26,25 +28,10 @@
 
 #define PPC_MTOCRF(A, B)	mtocrf A, B
 
-#define EX_TABLE(x, y)
-
-FUNC_START(enter_vmx_usercopy)
-	li	r3,1
-	blr
-
-FUNC_START(exit_vmx_usercopy)
-	li	r3,0
-	blr
-
-FUNC_START(enter_vmx_ops)
-	li	r3,1
-	blr
-
-FUNC_START(exit_vmx_ops)
-	blr
-
-FUNC_START(__copy_tofrom_user_base)
-	blr
+#define EX_TABLE(x, y)			\
+	.section __ex_table,"a";	\
+	.8byte	x, y;			\
+	.previous
 
 #define BEGIN_FTR_SECTION		.if test_feature
 #define FTR_SECTION_ELSE		.else
@@ -56,3 +43,5 @@ FUNC_START(__copy_tofrom_user_base)
 
 /* Default to taking the first of any alternative feature sections */
 test_feature = 1
+
+#endif /* __SELFTESTS_POWERPC_PPC_ASM_H */
diff --git a/tools/testing/selftests/powerpc/copyloops/copy_tofrom_user_reference.S b/tools/testing/selftests/powerpc/copyloops/copy_tofrom_user_reference.S
new file mode 100644
index 0000000..3363b86
--- /dev/null
+++ b/tools/testing/selftests/powerpc/copyloops/copy_tofrom_user_reference.S
@@ -0,0 +1,24 @@
+#include <asm/ppc_asm.h>
+
+_GLOBAL(copy_tofrom_user_reference)
+	cmpdi	r5,0
+	beq	4f
+
+	mtctr	r5
+
+1:	lbz	r6,0(r4)
+2:	stb	r6,0(r3)
+	addi	r3,r3,1
+	addi	r4,r4,1
+	bdnz	1b
+
+3:	mfctr	r3
+	blr
+
+4:	mr	r3,r5
+	blr
+
+.section __ex_table,"a"
+	.llong	1b,3b
+	.llong	2b,3b
+.text
diff --git a/tools/testing/selftests/powerpc/copyloops/exc_validate.c b/tools/testing/selftests/powerpc/copyloops/exc_validate.c
new file mode 100644
index 0000000..c896ea9
--- /dev/null
+++ b/tools/testing/selftests/powerpc/copyloops/exc_validate.c
@@ -0,0 +1,124 @@
+#include <stdlib.h>
+#include <string.h>
+#include <stdio.h>
+#include <signal.h>
+#include <unistd.h>
+#include <sys/mman.h>
+
+#include "utils.h"
+
+extern char __start___ex_table[];
+extern char __stop___ex_table[];
+
+#if defined(__powerpc64__)
+#define UCONTEXT_NIA(UC)	(UC)->uc_mcontext.gp_regs[PT_NIP]
+#elif defined(__powerpc__)
+#define UCONTEXT_NIA(UC)	(UC)->uc_mcontext.uc_regs->gregs[PT_NIP]
+#else
+#error implement UCONTEXT_NIA
+#endif
+
+static void segv_handler(int signr, siginfo_t *info, void *ptr)
+{
+	ucontext_t *uc = (ucontext_t *)ptr;
+	unsigned long addr = (unsigned long)info->si_addr;
+	unsigned long *ip = &UCONTEXT_NIA(uc);
+	unsigned long *ex_p = (unsigned long *)__start___ex_table;
+
+	while (ex_p < (unsigned long *)__stop___ex_table) {
+		unsigned long insn, fixup;
+
+		insn = *ex_p++;
+		fixup = *ex_p++;
+
+		if (insn == *ip) {
+			*ip = fixup;
+			return;
+		}
+	}
+
+	printf("No exception table match for NIA %lx ADDR %lx\n", *ip, addr);
+	abort();
+}
+
+static void setup_segv_handler(void)
+{
+	struct sigaction action;
+
+	memset(&action, 0, sizeof(action));
+	action.sa_sigaction = segv_handler;
+	action.sa_flags = SA_SIGINFO;
+	sigaction(SIGSEGV, &action, NULL);
+}
+
+unsigned long COPY_LOOP(void *to, const void *from, unsigned long size);
+unsigned long test_copy_tofrom_user_reference(void *to, const void *from, unsigned long size);
+
+static int total_passed;
+static int total_failed;
+
+static void do_one_test(char *dstp, char *srcp, unsigned long len)
+{
+	unsigned long got, expected;
+
+	got = COPY_LOOP(dstp, srcp, len);
+	expected = test_copy_tofrom_user_reference(dstp, srcp, len);
+
+	if (got != expected) {
+		total_failed++;
+		printf("FAIL from=%p to=%p len=%ld returned %ld, expected %ld\n",
+		       srcp, dstp, len, got, expected);
+		//abort();
+	} else
+		total_passed++;
+}
+
+//#define MAX_LEN 512
+#define MAX_LEN 16
+
+int test_copy_exception(void)
+{
+	int page_size;
+	static char *p, *q;
+	unsigned long src, dst, len;
+
+	page_size = getpagesize();
+	p = mmap(NULL, page_size * 2, PROT_READ|PROT_WRITE,
+		MAP_PRIVATE|MAP_ANONYMOUS, -1, 0);
+
+	if (p == MAP_FAILED) {
+		perror("mmap");
+		exit(1);
+	}
+
+	memset(p, 0, page_size);
+
+	setup_segv_handler();
+
+	if (mprotect(p + page_size, page_size, PROT_NONE)) {
+		perror("mprotect");
+		exit(1);
+	}
+
+	q = p + page_size - MAX_LEN;
+
+	for (src = 0; src < MAX_LEN; src++) {
+		for (dst = 0; dst < MAX_LEN; dst++) {
+			for (len = 0; len < MAX_LEN+1; len++) {
+				// printf("from=%p to=%p len=%ld\n", q+dst, q+src, len);
+				do_one_test(q+dst, q+src, len);
+			}
+		}
+	}
+
+	printf("Totals:\n");
+	printf("  Pass: %d\n", total_passed);
+	printf("  Fail: %d\n", total_failed);
+
+	return 0;
+}
+
+int main(void)
+{
+	return test_harness(test_copy_exception, str(COPY_LOOP));
+}
diff --git a/tools/testing/selftests/powerpc/copyloops/stubs.S b/tools/testing/selftests/powerpc/copyloops/stubs.S
new file mode 100644
index 0000000..ec8bcf2
--- /dev/null
+++ b/tools/testing/selftests/powerpc/copyloops/stubs.S
@@ -0,0 +1,19 @@
+#include <asm/ppc_asm.h>
+
+FUNC_START(enter_vmx_usercopy)
+	li	r3,1
+	blr
+
+FUNC_START(exit_vmx_usercopy)
+	li	r3,0
+	blr
+
+FUNC_START(enter_vmx_ops)
+	li	r3,1
+	blr
+
+FUNC_START(exit_vmx_ops)
+	blr
+
+FUNC_START(__copy_tofrom_user_base)
+	blr
-- 
2.7.4

Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4A14D1A02FA
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 25 Sep 2014 16:45:17 +1000 (EST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: <linuxppc-dev@ozlabs.org>
Subject: [PATCH] selftests/powerpc: Add test of load_unaligned_zero_pad()
Date: Thu, 25 Sep 2014 16:45:11 +1000
Message-Id: <1411627511-16023-1-git-send-email-mpe@ellerman.id.au>
Cc: Anton Blanchard <anton@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

It is a rarely exercised case, so we want to have a test to ensure it
works as required.

Signed-off-by: Anton Blanchard <anton@samba.org>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/include/asm/word-at-a-time.h          |  13 +-
 tools/testing/selftests/powerpc/Makefile           |   2 +-
 .../testing/selftests/powerpc/primitives/Makefile  |  17 +++
 .../selftests/powerpc/primitives/asm/asm-compat.h  |   1 +
 .../selftests/powerpc/primitives/asm/ppc-opcode.h  |   0
 .../powerpc/primitives/load_unaligned_zeropad.c    | 147 +++++++++++++++++++++
 .../selftests/powerpc/primitives/word-at-a-time.h  |   1 +
 7 files changed, 179 insertions(+), 2 deletions(-)
 create mode 100644 tools/testing/selftests/powerpc/primitives/Makefile
 create mode 120000 tools/testing/selftests/powerpc/primitives/asm/asm-compat.h
 create mode 100644 tools/testing/selftests/powerpc/primitives/asm/ppc-opcode.h
 create mode 100644 tools/testing/selftests/powerpc/primitives/load_unaligned_zeropad.c
 create mode 120000 tools/testing/selftests/powerpc/primitives/word-at-a-time.h

diff --git a/arch/powerpc/include/asm/word-at-a-time.h b/arch/powerpc/include/asm/word-at-a-time.h
index 07cc121e8a79..ea52b51be401 100644
--- a/arch/powerpc/include/asm/word-at-a-time.h
+++ b/arch/powerpc/include/asm/word-at-a-time.h
@@ -116,6 +116,15 @@ static inline unsigned long prep_zero_mask(unsigned long a, unsigned long bits,
 
 #endif
 
+/*
+ * We use load_unaligned_zero() in a selftest, which builds a userspace
+ * program. Some linker scripts seem to discard the .fixup section, so allow
+ * the test code to use a different section name.
+ */
+#ifndef FIXUP_SECTION
+#define FIXUP_SECTION ".fixup"
+#endif
+
 static inline unsigned long load_unaligned_zeropad(const void *addr)
 {
 	unsigned long ret, offset, tmp;
@@ -123,7 +132,7 @@ static inline unsigned long load_unaligned_zeropad(const void *addr)
 	asm(
 	"1:	" PPC_LL "%[ret], 0(%[addr])\n"
 	"2:\n"
-	".section .fixup,\"ax\"\n"
+	".section " FIXUP_SECTION ",\"ax\"\n"
 	"3:	"
 #ifdef __powerpc64__
 	"clrrdi		%[tmp], %[addr], 3\n\t"
@@ -156,4 +165,6 @@ static inline unsigned long load_unaligned_zeropad(const void *addr)
 	return ret;
 }
 
+#undef FIXUP_SECTION
+
 #endif /* _ASM_WORD_AT_A_TIME_H */
diff --git a/tools/testing/selftests/powerpc/Makefile b/tools/testing/selftests/powerpc/Makefile
index 74a78cedce37..f6ff90a76bd7 100644
--- a/tools/testing/selftests/powerpc/Makefile
+++ b/tools/testing/selftests/powerpc/Makefile
@@ -13,7 +13,7 @@ CFLAGS := -Wall -O2 -flto -Wall -Werror -DGIT_VERSION='"$(GIT_VERSION)"' -I$(CUR
 
 export CC CFLAGS
 
-TARGETS = pmu copyloops mm tm
+TARGETS = pmu copyloops mm tm primitives
 
 endif
 
diff --git a/tools/testing/selftests/powerpc/primitives/Makefile b/tools/testing/selftests/powerpc/primitives/Makefile
new file mode 100644
index 000000000000..ea737ca01732
--- /dev/null
+++ b/tools/testing/selftests/powerpc/primitives/Makefile
@@ -0,0 +1,17 @@
+CFLAGS += -I$(CURDIR)
+
+PROGS := load_unaligned_zeropad
+
+all: $(PROGS)
+
+$(PROGS): ../harness.c
+
+run_tests: all
+	@-for PROG in $(PROGS); do \
+		./$$PROG; \
+	done;
+
+clean:
+	rm -f $(PROGS) *.o
+
+.PHONY: all run_tests clean
diff --git a/tools/testing/selftests/powerpc/primitives/asm/asm-compat.h b/tools/testing/selftests/powerpc/primitives/asm/asm-compat.h
new file mode 120000
index 000000000000..b14255e15a25
--- /dev/null
+++ b/tools/testing/selftests/powerpc/primitives/asm/asm-compat.h
@@ -0,0 +1 @@
+../.././../../../../arch/powerpc/include/asm/asm-compat.h
\ No newline at end of file
diff --git a/tools/testing/selftests/powerpc/primitives/asm/ppc-opcode.h b/tools/testing/selftests/powerpc/primitives/asm/ppc-opcode.h
new file mode 100644
index 000000000000..e69de29bb2d1
diff --git a/tools/testing/selftests/powerpc/primitives/load_unaligned_zeropad.c b/tools/testing/selftests/powerpc/primitives/load_unaligned_zeropad.c
new file mode 100644
index 000000000000..d1b647509596
--- /dev/null
+++ b/tools/testing/selftests/powerpc/primitives/load_unaligned_zeropad.c
@@ -0,0 +1,147 @@
+/*
+ * Userspace test harness for load_unaligned_zeropad. Creates two
+ * pages and uses mprotect to prevent access to the second page and
+ * a SEGV handler that walks the exception tables and runs the fixup
+ * routine.
+ *
+ * The results are compared against a normal load that is that is
+ * performed while access to the second page is enabled via mprotect.
+ *
+ * Copyright (C) 2014 Anton Blanchard <anton@au.ibm.com>, IBM
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version
+ * 2 of the License, or (at your option) any later version.
+ */
+
+#include <stdlib.h>
+#include <string.h>
+#include <stdio.h>
+#include <stdbool.h>
+#include <signal.h>
+#include <unistd.h>
+#include <sys/mman.h>
+
+#define FIXUP_SECTION ".ex_fixup"
+
+#include "word-at-a-time.h"
+
+#include "utils.h"
+
+
+static int page_size;
+static char *mem_region;
+
+static int protect_region(void)
+{
+	if (mprotect(mem_region + page_size, page_size, PROT_NONE)) {
+		perror("mprotect");
+		return 1;
+	}
+
+	return 0;
+}
+
+static int unprotect_region(void)
+{
+	if (mprotect(mem_region + page_size, page_size, PROT_READ|PROT_WRITE)) {
+		perror("mprotect");
+		return 1;
+	}
+
+	return 0;
+}
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
+static int segv_error;
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
+	segv_error++;
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
+static int do_one_test(char *p, int page_offset)
+{
+	unsigned long should;
+	unsigned long got;
+
+	FAIL_IF(unprotect_region());
+	should = *(unsigned long *)p;
+	FAIL_IF(protect_region());
+
+	got = load_unaligned_zeropad(p);
+
+	if (should != got)
+		printf("offset %u load_unaligned_zeropad returned 0x%lx, should be 0x%lx\n", page_offset, got, should);
+
+	return 0;
+}
+
+static int test_body(void)
+{
+	unsigned long i;
+
+	page_size = getpagesize();
+	mem_region = mmap(NULL, page_size * 2, PROT_READ|PROT_WRITE,
+		MAP_PRIVATE|MAP_ANONYMOUS, -1, 0);
+
+	FAIL_IF(mem_region == MAP_FAILED);
+
+	for (i = 0; i < page_size; i++)
+		mem_region[i] = i;
+
+	memset(mem_region+page_size, 0, page_size);
+
+	setup_segv_handler();
+
+	for (i = 0; i < page_size; i++)
+		FAIL_IF(do_one_test(mem_region+i, i));
+
+	FAIL_IF(segv_error);
+
+	return 0;
+}
+
+int main(void)
+{
+	return test_harness(test_body, "load_unaligned_zeropad");
+}
diff --git a/tools/testing/selftests/powerpc/primitives/word-at-a-time.h b/tools/testing/selftests/powerpc/primitives/word-at-a-time.h
new file mode 120000
index 000000000000..eb74401b591f
--- /dev/null
+++ b/tools/testing/selftests/powerpc/primitives/word-at-a-time.h
@@ -0,0 +1 @@
+../../../../../arch/powerpc/include/asm/word-at-a-time.h
\ No newline at end of file
-- 
1.9.1

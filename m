Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41ZSFy1gDvzDqCG
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 Jul 2018 15:53:26 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] selftests/powerpc: Add a test of wild bctr
Date: Tue, 24 Jul 2018 15:53:22 +1000
Message-Id: <20180724055322.27720-1-mpe@ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This tests that a bctr (Branch to counter and link), ie. a function
call, to a wildly out-of-bounds address is handled correctly.

Some old kernel versions didn't handle it correctly, see eg:

  "powerpc/slb: Force a full SLB flush when we insert for a bad EA"
  https://lists.ozlabs.org/pipermail/linuxppc-dev/2017-April/157397.html

Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 tools/testing/selftests/powerpc/include/reg.h  |   1 +
 tools/testing/selftests/powerpc/mm/.gitignore  |   3 +-
 tools/testing/selftests/powerpc/mm/Makefile    |   2 +-
 tools/testing/selftests/powerpc/mm/wild_bctr.c | 153 +++++++++++++++++++++++++
 4 files changed, 157 insertions(+), 2 deletions(-)
 create mode 100644 tools/testing/selftests/powerpc/mm/wild_bctr.c

diff --git a/tools/testing/selftests/powerpc/include/reg.h b/tools/testing/selftests/powerpc/include/reg.h
index 7f348c059bc2..52b4710469d2 100644
--- a/tools/testing/selftests/powerpc/include/reg.h
+++ b/tools/testing/selftests/powerpc/include/reg.h
@@ -17,6 +17,7 @@
 				    : "memory")
 
 #define mb()		asm volatile("sync" : : : "memory");
+#define barrier()	asm volatile("" : : : "memory");
 
 #define SPRN_MMCR2     769
 #define SPRN_MMCRA     770
diff --git a/tools/testing/selftests/powerpc/mm/.gitignore b/tools/testing/selftests/powerpc/mm/.gitignore
index 7d7c42ed6de9..ba919308fe30 100644
--- a/tools/testing/selftests/powerpc/mm/.gitignore
+++ b/tools/testing/selftests/powerpc/mm/.gitignore
@@ -2,4 +2,5 @@ hugetlb_vs_thp_test
 subpage_prot
 tempfile
 prot_sao
-segv_errors
\ No newline at end of file
+segv_errors
+wild_bctr
\ No newline at end of file
diff --git a/tools/testing/selftests/powerpc/mm/Makefile b/tools/testing/selftests/powerpc/mm/Makefile
index 8ebbe96d80a8..893ad41460af 100644
--- a/tools/testing/selftests/powerpc/mm/Makefile
+++ b/tools/testing/selftests/powerpc/mm/Makefile
@@ -2,7 +2,7 @@
 noarg:
 	$(MAKE) -C ../
 
-TEST_GEN_PROGS := hugetlb_vs_thp_test subpage_prot prot_sao segv_errors
+TEST_GEN_PROGS := hugetlb_vs_thp_test subpage_prot prot_sao segv_errors wild_bctr
 TEST_GEN_FILES := tempfile
 
 include ../../lib.mk
diff --git a/tools/testing/selftests/powerpc/mm/wild_bctr.c b/tools/testing/selftests/powerpc/mm/wild_bctr.c
new file mode 100644
index 000000000000..f8a2901dc44e
--- /dev/null
+++ b/tools/testing/selftests/powerpc/mm/wild_bctr.c
@@ -0,0 +1,153 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright 2018, Michael Ellerman, IBM Corp.
+ *
+ * Test that an out-of-bounds branch to counter behaves as expected.
+ */
+
+#include <setjmp.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <sys/mman.h>
+#include <ucontext.h>
+#include <unistd.h>
+
+#include "utils.h"
+
+
+#define BAD_NIP	0x788c545a18000000ull
+
+static struct pt_regs signal_regs;
+static jmp_buf setjmp_env;
+
+static void save_regs(ucontext_t *ctxt)
+{
+	struct pt_regs *regs = ctxt->uc_mcontext.regs;
+
+	memcpy(&signal_regs, regs, sizeof(signal_regs));
+}
+
+static void segv_handler(int signum, siginfo_t *info, void *ctxt_v)
+{
+	save_regs(ctxt_v);
+	longjmp(setjmp_env, 1);
+}
+
+static void usr2_handler(int signum, siginfo_t *info, void *ctxt_v)
+{
+	save_regs(ctxt_v);
+}
+
+static int ok(void)
+{
+	printf("Everything is OK in here.\n");
+	return 0;
+}
+
+#define REG_POISON	0x5a5aUL
+#define POISONED_REG(n)	((REG_POISON << 48) | ((n) << 32) | (REG_POISON << 16) | (n))
+
+static inline void poison_regs(void)
+{
+	#define POISON_REG(n)	\
+	  "lis  " __stringify(n) "," __stringify(REG_POISON) ";" \
+	  "addi " __stringify(n) "," __stringify(n) "," __stringify(n) ";" \
+	  "sldi " __stringify(n) "," __stringify(n) ", 32 ;" \
+	  "oris " __stringify(n) "," __stringify(n) "," __stringify(REG_POISON) ";" \
+	  "addi " __stringify(n) "," __stringify(n) "," __stringify(n) ";"
+
+	asm (POISON_REG(15)
+	     POISON_REG(16)
+	     POISON_REG(17)
+	     POISON_REG(18)
+	     POISON_REG(19)
+	     POISON_REG(20)
+	     POISON_REG(21)
+	     POISON_REG(22)
+	     POISON_REG(23)
+	     POISON_REG(24)
+	     POISON_REG(25)
+	     POISON_REG(26)
+	     POISON_REG(27)
+	     POISON_REG(28)
+	     POISON_REG(29)
+	     : // inputs
+	     : // outputs
+	     : "15", "16", "17", "18", "19", "20", "21", "22", "23", "24", "25",
+	       "26", "27", "28", "29"
+	);
+	#undef POISON_REG
+}
+
+static int check_regs(void)
+{
+	unsigned long i;
+
+	for (i = 15; i <= 29; i++)
+		FAIL_IF(signal_regs.gpr[i] != POISONED_REG(i));
+
+	printf("Regs OK\n");
+	return 0;
+}
+
+static void dump_regs(void)
+{
+	for (int i = 0; i < 32; i += 4) {
+		printf("r%02d 0x%016lx  r%02d 0x%016lx  " \
+		       "r%02d 0x%016lx  r%02d 0x%016lx\n",
+		       i, signal_regs.gpr[i],
+		       i+1, signal_regs.gpr[i+1],
+		       i+2, signal_regs.gpr[i+2],
+		       i+3, signal_regs.gpr[i+3]);
+	}
+}
+
+int test_wild_bctr(void)
+{
+	int (*func_ptr)(void);
+	struct sigaction segv = {
+		.sa_sigaction = segv_handler,
+		.sa_flags = SA_SIGINFO
+	};
+	struct sigaction usr2 = {
+		.sa_sigaction = usr2_handler,
+		.sa_flags = SA_SIGINFO
+	};
+
+	FAIL_IF(sigaction(SIGSEGV, &segv, NULL));
+	FAIL_IF(sigaction(SIGUSR2, &usr2, NULL));
+
+	bzero(&signal_regs, sizeof(signal_regs));
+
+	if (setjmp(setjmp_env) == 0) {
+		func_ptr = ok;
+		func_ptr();
+
+		kill(getpid(), SIGUSR2);
+		printf("Regs before:\n");
+		dump_regs();
+		bzero(&signal_regs, sizeof(signal_regs));
+
+		poison_regs();
+
+		func_ptr = (int (*)(void))BAD_NIP;
+		func_ptr();
+
+		FAIL_IF(1); /* we didn't segv? */
+	}
+
+	FAIL_IF(signal_regs.nip != BAD_NIP);
+
+	printf("All good - took SEGV as expected branching to 0x%llx\n", BAD_NIP);
+
+	dump_regs();
+	FAIL_IF(check_regs());
+
+	return 0;
+}
+
+int main(void)
+{
+	return test_harness(test_wild_bctr, "wild_bctr");
+}
-- 
2.14.1

Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rntpS1GQHzDqws
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 11 Jul 2016 15:25:20 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: <linuxppc-dev@ozlabs.org>
Subject: [PATCH] selftests/powerpc: Add a test for PROT_SAO
Date: Mon, 11 Jul 2016 15:25:18 +1000
Message-Id: <1468214718-15190-1-git-send-email-mpe@ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

PROT_SAO is a powerpc-specific flag to mmap(), and we rely on arch
specific logic to allow it to be passed to mmap().

Add a small test to ensure mmap() accepts PROT_SAO. We don't have a good
way to test that it actually causes the mapping to be created with the
right flags, so for now we just touch the mapping so it's faulted in. In
future we might be able to do something better.

Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 tools/testing/selftests/powerpc/mm/.gitignore |  1 +
 tools/testing/selftests/powerpc/mm/Makefile   |  4 ++-
 tools/testing/selftests/powerpc/mm/prot_sao.c | 42 +++++++++++++++++++++++++++
 tools/testing/selftests/powerpc/utils.h       |  5 ++++
 4 files changed, 51 insertions(+), 1 deletion(-)
 create mode 100644 tools/testing/selftests/powerpc/mm/prot_sao.c

diff --git a/tools/testing/selftests/powerpc/mm/.gitignore b/tools/testing/selftests/powerpc/mm/.gitignore
index b43ade0ec861..e715a3f2fbf4 100644
--- a/tools/testing/selftests/powerpc/mm/.gitignore
+++ b/tools/testing/selftests/powerpc/mm/.gitignore
@@ -1,3 +1,4 @@
 hugetlb_vs_thp_test
 subpage_prot
 tempfile
+prot_sao
\ No newline at end of file
diff --git a/tools/testing/selftests/powerpc/mm/Makefile b/tools/testing/selftests/powerpc/mm/Makefile
index ee179e22308c..3bdb96eae558 100644
--- a/tools/testing/selftests/powerpc/mm/Makefile
+++ b/tools/testing/selftests/powerpc/mm/Makefile
@@ -1,13 +1,15 @@
 noarg:
 	$(MAKE) -C ../
 
-TEST_PROGS := hugetlb_vs_thp_test subpage_prot
+TEST_PROGS := hugetlb_vs_thp_test subpage_prot prot_sao
 TEST_FILES := tempfile
 
 all: $(TEST_PROGS) $(TEST_FILES)
 
 $(TEST_PROGS): ../harness.c
 
+prot_sao: ../utils.c
+
 include ../../lib.mk
 
 tempfile:
diff --git a/tools/testing/selftests/powerpc/mm/prot_sao.c b/tools/testing/selftests/powerpc/mm/prot_sao.c
new file mode 100644
index 000000000000..611530d43fa9
--- /dev/null
+++ b/tools/testing/selftests/powerpc/mm/prot_sao.c
@@ -0,0 +1,42 @@
+/*
+ * Copyright 2016, Michael Ellerman, IBM Corp.
+ * Licensed under GPLv2.
+ */
+
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <sys/mman.h>
+
+#include <asm/cputable.h>
+
+#include "utils.h"
+
+#define SIZE (64 * 1024)
+
+int test_prot_sao(void)
+{
+	char *p;
+
+	/* 2.06 or later should support SAO */
+	SKIP_IF(!have_hwcap(PPC_FEATURE_ARCH_2_06));
+
+	/*
+	 * Ensure we can ask for PROT_SAO.
+	 * We can't really verify that it does the right thing, but at least we
+	 * confirm the kernel will accept it.
+	 */
+	p = mmap(NULL, SIZE, PROT_READ | PROT_WRITE | PROT_SAO,
+		 MAP_ANONYMOUS | MAP_PRIVATE, -1, 0);
+	FAIL_IF(p == MAP_FAILED);
+
+	/* Write to the mapping, to at least cause a fault */
+	memset(p, 0xaa, SIZE);
+
+	return 0;
+}
+
+int main(void)
+{
+	return test_harness(test_prot_sao, "prot-sao");
+}
diff --git a/tools/testing/selftests/powerpc/utils.h b/tools/testing/selftests/powerpc/utils.h
index a985cfaa535e..fbd33e52ef8f 100644
--- a/tools/testing/selftests/powerpc/utils.h
+++ b/tools/testing/selftests/powerpc/utils.h
@@ -27,6 +27,11 @@ int test_harness(int (test_function)(void), char *name);
 extern void *get_auxv_entry(int type);
 int pick_online_cpu(void);
 
+static inline bool have_hwcap(unsigned long ftr)
+{
+	return ((unsigned long)get_auxv_entry(AT_HWCAP) & ftr) == ftr;
+}
+
 static inline bool have_hwcap2(unsigned long ftr2)
 {
 	return ((unsigned long)get_auxv_entry(AT_HWCAP2) & ftr2) == ftr2;
-- 
2.7.4

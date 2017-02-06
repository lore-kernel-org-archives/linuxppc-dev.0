Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vH3G85gPczDqDy
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  6 Feb 2017 21:13:36 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 2/2] selftests/powerpc: Add cache_shape sniff test
Date: Mon,  6 Feb 2017 21:13:28 +1100
Message-Id: <1486376008-2841-2-git-send-email-mpe@ellerman.id.au>
In-Reply-To: <1486376008-2841-1-git-send-email-mpe@ellerman.id.au>
References: <1486376008-2841-1-git-send-email-mpe@ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This is a very basic test of the new cache shape AUXV entries. All it
does at the moment is look for the entries and error out if we don't
find all the ones we expect. Primarily intended for folks bringing up a
new chip to check that the cache info is making it all the way to
userspace correctly.

Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 tools/testing/selftests/powerpc/Makefile           |   1 +
 .../selftests/powerpc/cache_shape/.gitignore       |   1 +
 .../testing/selftests/powerpc/cache_shape/Makefile |  10 ++
 .../selftests/powerpc/cache_shape/cache_shape.c    | 125 +++++++++++++++++++++
 4 files changed, 137 insertions(+)
 create mode 100644 tools/testing/selftests/powerpc/cache_shape/.gitignore
 create mode 100644 tools/testing/selftests/powerpc/cache_shape/Makefile
 create mode 100644 tools/testing/selftests/powerpc/cache_shape/cache_shape.c

diff --git a/tools/testing/selftests/powerpc/Makefile b/tools/testing/selftests/powerpc/Makefile
index c2c4211ba58b..e7888e0c710d 100644
--- a/tools/testing/selftests/powerpc/Makefile
+++ b/tools/testing/selftests/powerpc/Makefile
@@ -14,6 +14,7 @@ export CFLAGS
 
 SUB_DIRS = alignment		\
 	   benchmarks		\
+	   cache_shape		\
 	   copyloops		\
 	   context_switch	\
 	   dscr			\
diff --git a/tools/testing/selftests/powerpc/cache_shape/.gitignore b/tools/testing/selftests/powerpc/cache_shape/.gitignore
new file mode 100644
index 000000000000..ec1848434be5
--- /dev/null
+++ b/tools/testing/selftests/powerpc/cache_shape/.gitignore
@@ -0,0 +1 @@
+cache_shape
diff --git a/tools/testing/selftests/powerpc/cache_shape/Makefile b/tools/testing/selftests/powerpc/cache_shape/Makefile
new file mode 100644
index 000000000000..b24485ab30e2
--- /dev/null
+++ b/tools/testing/selftests/powerpc/cache_shape/Makefile
@@ -0,0 +1,10 @@
+TEST_PROGS := cache_shape
+
+all: $(TEST_PROGS)
+
+$(TEST_PROGS): ../harness.c ../utils.c
+
+include ../../lib.mk
+
+clean:
+	rm -f $(TEST_PROGS) *.o
diff --git a/tools/testing/selftests/powerpc/cache_shape/cache_shape.c b/tools/testing/selftests/powerpc/cache_shape/cache_shape.c
new file mode 100644
index 000000000000..29ec07eba7f9
--- /dev/null
+++ b/tools/testing/selftests/powerpc/cache_shape/cache_shape.c
@@ -0,0 +1,125 @@
+/*
+ * Copyright 2017, Michael Ellerman, IBM Corp.
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version
+ * 2 of the License, or (at your option) any later version.
+ */
+
+#include <elf.h>
+#include <errno.h>
+#include <fcntl.h>
+#include <link.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <sys/stat.h>
+#include <sys/types.h>
+#include <sys/wait.h>
+#include <unistd.h>
+
+#include "utils.h"
+
+#ifndef AT_L1I_CACHESIZE
+#define AT_L1I_CACHESIZE	40
+#define AT_L1I_CACHEGEOMETRY	41
+#define AT_L1D_CACHESIZE	42
+#define AT_L1D_CACHEGEOMETRY	43
+#define AT_L2_CACHESIZE		44
+#define AT_L2_CACHEGEOMETRY	45
+#define AT_L3_CACHESIZE		46
+#define AT_L3_CACHEGEOMETRY	47
+#endif
+
+static void print_size(const char *label, uint32_t val)
+{
+	printf("%s cache size: %#10x %10dB %10dK\n", label, val, val, val / 1024);
+}
+
+static void print_geo(const char *label, uint32_t val)
+{
+	uint16_t assoc;
+
+	printf("%s line size:  %#10x       ", label, val & 0xFFFF);
+
+	assoc = val >> 16;
+	if (assoc)
+		printf("%u-way", assoc);
+	else
+		printf("fully");
+
+	printf(" associative\n");
+}
+
+static int test_cache_shape()
+{
+	static char buffer[4096];
+	ElfW(auxv_t) *p;
+	int found;
+
+	FAIL_IF(read_auxv(buffer, sizeof(buffer)));
+
+	found = 0;
+
+	p = find_auxv_entry(AT_L1I_CACHESIZE, buffer);
+	if (p) {
+		found++;
+		print_size("L1I ", (uint32_t)p->a_un.a_val);
+	}
+
+	p = find_auxv_entry(AT_L1I_CACHEGEOMETRY, buffer);
+	if (p) {
+		found++;
+		print_geo("L1I ", (uint32_t)p->a_un.a_val);
+	}
+
+	p = find_auxv_entry(AT_L1D_CACHESIZE, buffer);
+	if (p) {
+		found++;
+		print_size("L1D ", (uint32_t)p->a_un.a_val);
+	}
+
+	p = find_auxv_entry(AT_L1D_CACHEGEOMETRY, buffer);
+	if (p) {
+		found++;
+		print_geo("L1D ", (uint32_t)p->a_un.a_val);
+	}
+
+	p = find_auxv_entry(AT_L2_CACHESIZE, buffer);
+	if (p) {
+		found++;
+		print_size("L2  ", (uint32_t)p->a_un.a_val);
+	}
+
+	p = find_auxv_entry(AT_L2_CACHEGEOMETRY, buffer);
+	if (p) {
+		found++;
+		print_geo("L2  ", (uint32_t)p->a_un.a_val);
+	}
+
+	p = find_auxv_entry(AT_L3_CACHESIZE, buffer);
+	if (p) {
+		found++;
+		print_size("L3  ", (uint32_t)p->a_un.a_val);
+	}
+
+	p = find_auxv_entry(AT_L3_CACHEGEOMETRY, buffer);
+	if (p) {
+		found++;
+		print_geo("L3  ", (uint32_t)p->a_un.a_val);
+	}
+
+	/* If we found none we're probably on a system where they don't exist */
+	SKIP_IF(found == 0);
+
+	/* But if we found any, we expect to find them all */
+	FAIL_IF(found != 8);
+
+	return 0;
+}
+
+int main(void)
+{
+	return test_harness(test_cache_shape, "cache_shape");
+}
-- 
2.7.4

Return-Path: <christophe.leroy@c-s.fr>
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 414kjq4FBCzF4C1
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 12 Jun 2018 19:14:55 +1000 (AEST)
Message-Id: <f41dd5beb220c4ccd6d0e16ca173c9920045b906.1528791416.git.christophe.leroy@c-s.fr>
In-Reply-To: <85de16f5629ac9f4a815230cced361908758b53a.1528791416.git.christophe.leroy@c-s.fr>
References: <85de16f5629ac9f4a815230cced361908758b53a.1528791416.git.christophe.leroy@c-s.fr>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH v6 2/4] selftests/powerpc: Add test for strlen()
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 wei.guo.simon@gmail.com, segher@kernel.crashing.org
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date: Tue, 12 Jun 2018 09:14:51 +0000 (UTC)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This patch adds a test for strlen()

string.c contains a copy of strlen() from lib/string.c

The test first tests the correctness of strlen() by comparing
the result with libc strlen(). It tests all cases of alignment.

It them tests the duration of an aligned strlen() on a 4 bytes string,
on a 16 bytes string and on a 256 bytes string.

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 v6: refactorised the benchmark test
 v5: no change
 v4: new

 .../testing/selftests/powerpc/stringloops/Makefile |   5 +-
 .../testing/selftests/powerpc/stringloops/string.c |  36 ++++++
 .../testing/selftests/powerpc/stringloops/strlen.c | 127 +++++++++++++++++++++
 3 files changed, 167 insertions(+), 1 deletion(-)
 create mode 100644 tools/testing/selftests/powerpc/stringloops/string.c
 create mode 100644 tools/testing/selftests/powerpc/stringloops/strlen.c

diff --git a/tools/testing/selftests/powerpc/stringloops/Makefile b/tools/testing/selftests/powerpc/stringloops/Makefile
index 1e7301d4bac9..df663ee9ddb3 100644
--- a/tools/testing/selftests/powerpc/stringloops/Makefile
+++ b/tools/testing/selftests/powerpc/stringloops/Makefile
@@ -10,9 +10,12 @@ $(OUTPUT)/memcmp_64: CFLAGS += -m64
 $(OUTPUT)/memcmp_32: memcmp.c
 $(OUTPUT)/memcmp_32: CFLAGS += -m32
 
+$(OUTPUT)/strlen: strlen.c string.o
+$(OUTPUT)/string.o: string.c
+
 ASFLAGS = $(CFLAGS)
 
-TEST_GEN_PROGS := memcmp_32 memcmp_64
+TEST_GEN_PROGS := memcmp_32 memcmp_64 strlen
 
 include ../../lib.mk
 
diff --git a/tools/testing/selftests/powerpc/stringloops/string.c b/tools/testing/selftests/powerpc/stringloops/string.c
new file mode 100644
index 000000000000..d05200481017
--- /dev/null
+++ b/tools/testing/selftests/powerpc/stringloops/string.c
@@ -0,0 +1,36 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ *  linux/lib/string.c
+ *
+ *  Copyright (C) 1991, 1992  Linus Torvalds
+ */
+
+/*
+ * stupid library routines.. The optimized versions should generally be found
+ * as inline code in <asm-xx/string.h>
+ *
+ * These are buggy as well..
+ *
+ * * Fri Jun 25 1999, Ingo Oeser <ioe@informatik.tu-chemnitz.de>
+ * -  Added strsep() which will replace strtok() soon (because strsep() is
+ *    reentrant and should be faster). Use only strsep() in new code, please.
+ *
+ * * Sat Feb 09 2002, Jason Thomas <jason@topic.com.au>,
+ *                    Matthew Hawkins <matt@mh.dropbear.id.au>
+ * -  Kissed strtok() goodbye
+ */
+
+#include <stddef.h>
+
+/**
+ * strlen - Find the length of a string
+ * @s: The string to be sized
+ */
+size_t test_strlen(const char *s)
+{
+	const char *sc;
+
+	for (sc = s; *sc != '\0'; ++sc)
+		/* nothing */;
+	return sc - s;
+}
diff --git a/tools/testing/selftests/powerpc/stringloops/strlen.c b/tools/testing/selftests/powerpc/stringloops/strlen.c
new file mode 100644
index 000000000000..9055ebc484d0
--- /dev/null
+++ b/tools/testing/selftests/powerpc/stringloops/strlen.c
@@ -0,0 +1,127 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <malloc.h>
+#include <stdlib.h>
+#include <string.h>
+#include <time.h>
+#include "utils.h"
+
+#define SIZE 256
+#define ITERATIONS 1000
+#define ITERATIONS_BENCH 100000
+
+int test_strlen(const void *s);
+
+/* test all offsets and lengths */
+static void test_one(char *s)
+{
+	unsigned long offset;
+
+	for (offset = 0; offset < SIZE; offset++) {
+		int x, y;
+		unsigned long i;
+
+		y = strlen(s + offset);
+		x = test_strlen(s + offset);
+
+		if (x != y) {
+			printf("strlen() returned %d, should have returned %d (%p offset %ld)\n", x, y, s, offset);
+
+			for (i = offset; i < SIZE; i++)
+				printf("%02x ", s[i]);
+			printf("\n");
+		}
+	}
+}
+
+static void bench_test(char *s)
+{
+	struct timespec ts_start, ts_end;
+	int i;
+
+	clock_gettime(CLOCK_MONOTONIC, &ts_start);
+
+	for (i = 0; i < ITERATIONS_BENCH; i++)
+		test_strlen(s);
+
+	clock_gettime(CLOCK_MONOTONIC, &ts_end);
+
+	printf("len %3.3d : time = %.6f\n", test_strlen(s), ts_end.tv_sec - ts_start.tv_sec + (ts_end.tv_nsec - ts_start.tv_nsec) / 1e9);
+}
+
+static int testcase(void)
+{
+	char *s;
+	unsigned long i;
+
+	s = memalign(128, SIZE);
+	if (!s) {
+		perror("memalign");
+		exit(1);
+	}
+
+	srandom(1);
+
+	memset(s, 0, SIZE);
+	for (i = 0; i < SIZE; i++) {
+		char c;
+
+		do {
+			c = random() & 0x7f;
+		} while (!c);
+		s[i] = c;
+		test_one(s);
+	}
+
+	for (i = 0; i < ITERATIONS; i++) {
+		unsigned long j;
+
+		for (j = 0; j < SIZE; j++) {
+			char c;
+
+			do {
+				c = random() & 0x7f;
+			} while (!c);
+			s[j] = c;
+		}
+		for (j = 0; j < sizeof(long); j++) {
+			s[SIZE - 1 - j] = 0;
+			test_one(s);
+		}
+	}
+
+	for (i = 0; i < SIZE; i++) {
+		char c;
+
+		do {
+			c = random() & 0x7f;
+		} while (!c);
+		s[i] = c;
+	}
+
+	bench_test(s);
+
+	s[16] = 0;
+	bench_test(s);
+
+	s[8] = 0;
+	bench_test(s);
+
+	s[4] = 0;
+	bench_test(s);
+
+	s[3] = 0;
+	bench_test(s);
+
+	s[2] = 0;
+	bench_test(s);
+
+	s[1] = 0;
+	bench_test(s);
+
+	return 0;
+}
+
+int main(void)
+{
+	return test_harness(testcase, "strlen");
+}
-- 
2.13.3

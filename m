Return-Path: <christophe.leroy@c-s.fr>
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 412JMd67DBzDqJl
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  8 Jun 2018 20:20:44 +1000 (AEST)
Message-Id: <3f039fa9875f2d7105d8a09de00f8ab8a8f5ea46.1528452373.git.christophe.leroy@c-s.fr>
In-Reply-To: <a348f4ffda6349467e4270e754d12150fa773462.1528452373.git.christophe.leroy@c-s.fr>
References: <a348f4ffda6349467e4270e754d12150fa773462.1528452373.git.christophe.leroy@c-s.fr>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH v4 2/4] selftests/powerpc: Add test for strlen()
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 wei.guo.simon@gmail.com
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date: Fri,  8 Jun 2018 10:20:39 +0000 (UTC)
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
 v4: new

 .../testing/selftests/powerpc/stringloops/Makefile |   5 +-
 .../testing/selftests/powerpc/stringloops/string.c |  36 ++++++
 .../testing/selftests/powerpc/stringloops/strlen.c | 123 +++++++++++++++++++++
 3 files changed, 163 insertions(+), 1 deletion(-)
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
index 000000000000..e87ca65ea156
--- /dev/null
+++ b/tools/testing/selftests/powerpc/stringloops/strlen.c
@@ -0,0 +1,123 @@
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
+static int testcase(void)
+{
+	char *s;
+	unsigned long i;
+	struct timespec ts_start, ts_end;
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
+	clock_gettime(CLOCK_MONOTONIC, &ts_start);
+
+	s[SIZE - 1] = 0;
+	for (i = 0; i < ITERATIONS_BENCH; i++)
+		test_strlen(s);
+
+	clock_gettime(CLOCK_MONOTONIC, &ts_end);
+
+	printf("len %3.3d : time = %.6f\n", SIZE, ts_end.tv_sec - ts_start.tv_sec + (ts_end.tv_nsec - ts_start.tv_nsec) / 1e9);
+
+	clock_gettime(CLOCK_MONOTONIC, &ts_start);
+
+	s[16] = 0;
+	for (i = 0; i < ITERATIONS_BENCH; i++)
+		test_strlen(s);
+
+	clock_gettime(CLOCK_MONOTONIC, &ts_end);
+
+	printf("len 16  : time = %.6f\n", ts_end.tv_sec - ts_start.tv_sec + (ts_end.tv_nsec - ts_start.tv_nsec) / 1e9);
+
+	clock_gettime(CLOCK_MONOTONIC, &ts_start);
+
+	s[4] = 0;
+	for (i = 0; i < ITERATIONS_BENCH; i++)
+		test_strlen(s);
+
+	clock_gettime(CLOCK_MONOTONIC, &ts_end);
+
+	printf("len 4   : time = %.6f\n", ts_end.tv_sec - ts_start.tv_sec + (ts_end.tv_nsec - ts_start.tv_nsec) / 1e9);
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

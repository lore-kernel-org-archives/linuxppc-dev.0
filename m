Return-Path: <anton@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3832A1A0F77
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  9 Jan 2015 12:56:35 +1100 (AEDT)
From: Anton Blanchard <anton@samba.org>
To: benh@kernel.crashing.org,
	paulus@samba.org,
	mpe@ellerman.id.au
Subject: [PATCH 2/2] powerpc: Add memcmp testcase
Date: Fri,  9 Jan 2015 12:56:31 +1100
Message-Id: <1420768591-6831-2-git-send-email-anton@samba.org>
In-Reply-To: <1420768591-6831-1-git-send-email-anton@samba.org>
References: <1420768591-6831-1-git-send-email-anton@samba.org>
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Add a testcase for the new ppc64 memcmp.

Signed-off-by: Anton Blanchard <anton@samba.org>
---
 .../testing/selftests/powerpc/stringloops/Makefile |  21 +++++
 .../selftests/powerpc/stringloops/asm/ppc_asm.h    |   7 ++
 .../selftests/powerpc/stringloops/memcmp_64.S      |   1 +
 .../selftests/powerpc/stringloops/test_memcmp.c    | 103 +++++++++++++++++++++
 4 files changed, 132 insertions(+)
 create mode 100644 tools/testing/selftests/powerpc/stringloops/Makefile
 create mode 100644 tools/testing/selftests/powerpc/stringloops/asm/ppc_asm.h
 create mode 120000 tools/testing/selftests/powerpc/stringloops/memcmp_64.S
 create mode 100644 tools/testing/selftests/powerpc/stringloops/test_memcmp.c

diff --git a/tools/testing/selftests/powerpc/stringloops/Makefile b/tools/testing/selftests/powerpc/stringloops/Makefile
new file mode 100644
index 0000000..159a299
--- /dev/null
+++ b/tools/testing/selftests/powerpc/stringloops/Makefile
@@ -0,0 +1,21 @@
+# The loops are all 64-bit code
+CFLAGS += -m64
+CFLAGS += -I$(CURDIR)
+CFLAGS += -D SELFTEST
+
+PROGS := test_memcmp
+EXTRA_SOURCES := memcmp_64.S ../harness.c
+
+all: $(PROGS)
+
+$(PROGS): $(EXTRA_SOURCES)
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
diff --git a/tools/testing/selftests/powerpc/stringloops/asm/ppc_asm.h b/tools/testing/selftests/powerpc/stringloops/asm/ppc_asm.h
new file mode 100644
index 0000000..11bece8
--- /dev/null
+++ b/tools/testing/selftests/powerpc/stringloops/asm/ppc_asm.h
@@ -0,0 +1,7 @@
+#include <ppc-asm.h>
+
+#ifndef r1
+#define r1 sp
+#endif
+
+#define _GLOBAL(A) FUNC_START(test_ ## A)
diff --git a/tools/testing/selftests/powerpc/stringloops/memcmp_64.S b/tools/testing/selftests/powerpc/stringloops/memcmp_64.S
new file mode 120000
index 0000000..9bc87e4
--- /dev/null
+++ b/tools/testing/selftests/powerpc/stringloops/memcmp_64.S
@@ -0,0 +1 @@
+../../../../../arch/powerpc/lib/memcmp_64.S
\ No newline at end of file
diff --git a/tools/testing/selftests/powerpc/stringloops/test_memcmp.c b/tools/testing/selftests/powerpc/stringloops/test_memcmp.c
new file mode 100644
index 0000000..17417dd
--- /dev/null
+++ b/tools/testing/selftests/powerpc/stringloops/test_memcmp.c
@@ -0,0 +1,103 @@
+#include <malloc.h>
+#include <stdlib.h>
+#include <string.h>
+#include "../utils.h"
+
+#define SIZE 256
+#define ITERATIONS 10000
+
+int test_memcmp(const void *s1, const void *s2, size_t n);
+
+/* test all offsets and lengths */
+static void test_one(char *s1, char *s2)
+{
+	unsigned long offset, size;
+
+	for (offset = 0; offset < SIZE; offset++) {
+		for (size = 0; size < (SIZE-offset); size++) {
+			int x, y;
+			unsigned long i;
+
+			y = memcmp(s1+offset, s2+offset, size);
+			x = test_memcmp(s1+offset, s2+offset, size);
+
+			if (((x ^ y) < 0) &&	/* Trick to compare sign */
+				((x | y) != 0)) { /* check for zero */
+				printf("memcmp returned %d, should have returned %d (offset %ld size %ld)\n", x, y, offset, size);
+
+				for (i = offset; i < offset+size; i++)
+					printf("%02x ", s1[i]);
+				printf("\n");
+
+				for (i = offset; i < offset+size; i++)
+					printf("%02x ", s2[i]);
+				printf("\n");
+				abort();
+			}
+		}
+	}
+}
+
+static int testcase(void)
+{
+	char *s1;
+	char *s2;
+	unsigned long i;
+
+	s1 = memalign(128, SIZE);
+	if (!s1) {
+		perror("memalign");
+		exit(1);
+	}
+
+	s2 = memalign(128, SIZE);
+	if (!s2) {
+		perror("memalign");
+		exit(1);
+	}
+
+	srandom(1);
+
+	for (i = 0; i < ITERATIONS; i++) {
+		unsigned long j;
+		unsigned long change;
+
+		for (j = 0; j < SIZE; j++)
+			s1[j] = random();
+
+		memcpy(s2, s1, SIZE);
+
+		/* change one byte */
+		change = random() % SIZE;
+		s2[change] = random() & 0xff;
+
+		test_one(s1, s2);
+	}
+
+	srandom(1);
+
+	for (i = 0; i < ITERATIONS; i++) {
+		unsigned long j;
+		unsigned long change;
+
+		for (j = 0; j < SIZE; j++)
+			s1[j] = random();
+
+		memcpy(s2, s1, SIZE);
+
+		/* change multiple bytes, 1/8 of total */
+		for (j = 0; j < SIZE / 8; j++) {
+			change = random() % SIZE;
+			s2[change] = random() & 0xff;
+		}
+
+		test_one(s1, s2);
+	}
+
+	return 0;
+}
+
+int main(void)
+{
+	return test_harness(testcase, "memcmp");
+}
-- 
2.1.0

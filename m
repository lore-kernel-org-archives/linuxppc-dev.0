Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id C7C481A00BF
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 Nov 2015 13:05:52 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: <linuxppc-dev@ozlabs.org>
Cc: Michael Neuling <mikey@neuling.org>
Subject: [PATCH 1/4] selftests/powerpc: Move get_auxv_entry() into utils.c
Date: Tue, 24 Nov 2015 13:05:38 +1100
Message-Id: <1448330741-4804-1-git-send-email-mpe@ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This doesn't really belong in harness.c, it's a helper function. So move
it into utils.c.

Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 tools/testing/selftests/powerpc/harness.c        | 43 ------------------
 tools/testing/selftests/powerpc/pmu/Makefile     |  2 +
 tools/testing/selftests/powerpc/pmu/ebb/Makefile |  3 +-
 tools/testing/selftests/powerpc/tm/Makefile      |  2 +-
 tools/testing/selftests/powerpc/utils.c          | 58 ++++++++++++++++++++++++
 5 files changed, 63 insertions(+), 45 deletions(-)
 create mode 100644 tools/testing/selftests/powerpc/utils.c

diff --git a/tools/testing/selftests/powerpc/harness.c b/tools/testing/selftests/powerpc/harness.c
index f7997affd143..52f9be7f61f0 100644
--- a/tools/testing/selftests/powerpc/harness.c
+++ b/tools/testing/selftests/powerpc/harness.c
@@ -116,46 +116,3 @@ int test_harness(int (test_function)(void), char *name)
 
 	return rc;
 }
-
-static char auxv[4096];
-
-void *get_auxv_entry(int type)
-{
-	ElfW(auxv_t) *p;
-	void *result;
-	ssize_t num;
-	int fd;
-
-	fd = open("/proc/self/auxv", O_RDONLY);
-	if (fd == -1) {
-		perror("open");
-		return NULL;
-	}
-
-	result = NULL;
-
-	num = read(fd, auxv, sizeof(auxv));
-	if (num < 0) {
-		perror("read");
-		goto out;
-	}
-
-	if (num > sizeof(auxv)) {
-		printf("Overflowed auxv buffer\n");
-		goto out;
-	}
-
-	p = (ElfW(auxv_t) *)auxv;
-
-	while (p->a_type != AT_NULL) {
-		if (p->a_type == type) {
-			result = (void *)p->a_un.a_val;
-			break;
-		}
-
-		p++;
-	}
-out:
-	close(fd);
-	return result;
-}
diff --git a/tools/testing/selftests/powerpc/pmu/Makefile b/tools/testing/selftests/powerpc/pmu/Makefile
index a9099d9f8f39..50326cbb372d 100644
--- a/tools/testing/selftests/powerpc/pmu/Makefile
+++ b/tools/testing/selftests/powerpc/pmu/Makefile
@@ -12,6 +12,8 @@ $(TEST_PROGS): $(EXTRA_SOURCES)
 count_instructions: loop.S count_instructions.c $(EXTRA_SOURCES)
 	$(CC) $(CFLAGS) -m64 -o $@ $^
 
+per_event_excludes: ../utils.c
+
 include ../../lib.mk
 
 DEFAULT_RUN_TESTS := $(RUN_TESTS)
diff --git a/tools/testing/selftests/powerpc/pmu/ebb/Makefile b/tools/testing/selftests/powerpc/pmu/ebb/Makefile
index 5cdc9dbf2b27..8d2279c4bb4b 100644
--- a/tools/testing/selftests/powerpc/pmu/ebb/Makefile
+++ b/tools/testing/selftests/powerpc/pmu/ebb/Makefile
@@ -18,7 +18,8 @@ TEST_PROGS := reg_access_test event_attributes_test cycles_test	\
 
 all: $(TEST_PROGS)
 
-$(TEST_PROGS): ../../harness.c ../event.c ../lib.c ebb.c ebb_handler.S trace.c busy_loop.S
+$(TEST_PROGS): ../../harness.c ../../utils.c ../event.c ../lib.c \
+	       ebb.c ebb_handler.S trace.c busy_loop.S
 
 instruction_count_test: ../loop.S
 
diff --git a/tools/testing/selftests/powerpc/tm/Makefile b/tools/testing/selftests/powerpc/tm/Makefile
index 0e45c7e688b4..3e6e7aaa5312 100644
--- a/tools/testing/selftests/powerpc/tm/Makefile
+++ b/tools/testing/selftests/powerpc/tm/Makefile
@@ -4,7 +4,7 @@ all: $(TEST_PROGS)
 
 $(TEST_PROGS): ../harness.c
 
-tm-syscall: tm-syscall-asm.S
+tm-syscall: tm-syscall-asm.S ../utils.c
 tm-syscall: CFLAGS += -mhtm -I../../../../../usr/include
 
 include ../../lib.mk
diff --git a/tools/testing/selftests/powerpc/utils.c b/tools/testing/selftests/powerpc/utils.c
new file mode 100644
index 000000000000..536113add380
--- /dev/null
+++ b/tools/testing/selftests/powerpc/utils.c
@@ -0,0 +1,58 @@
+/*
+ * Copyright 2013-2015, Michael Ellerman, IBM Corp.
+ * Licensed under GPLv2.
+ */
+
+#include <elf.h>
+#include <errno.h>
+#include <fcntl.h>
+#include <link.h>
+#include <stdio.h>
+#include <sys/stat.h>
+#include <sys/types.h>
+#include <unistd.h>
+
+#include "utils.h"
+
+static char auxv[4096];
+
+void *get_auxv_entry(int type)
+{
+	ElfW(auxv_t) *p;
+	void *result;
+	ssize_t num;
+	int fd;
+
+	fd = open("/proc/self/auxv", O_RDONLY);
+	if (fd == -1) {
+		perror("open");
+		return NULL;
+	}
+
+	result = NULL;
+
+	num = read(fd, auxv, sizeof(auxv));
+	if (num < 0) {
+		perror("read");
+		goto out;
+	}
+
+	if (num > sizeof(auxv)) {
+		printf("Overflowed auxv buffer\n");
+		goto out;
+	}
+
+	p = (ElfW(auxv_t) *)auxv;
+
+	while (p->a_type != AT_NULL) {
+		if (p->a_type == type) {
+			result = (void *)p->a_un.a_val;
+			break;
+		}
+
+		p++;
+	}
+out:
+	close(fd);
+	return result;
+}
-- 
2.5.0

Return-Path: <mikey@neuling.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3y7TyT2cS1zDqhb
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  6 Oct 2017 10:49:37 +1100 (AEDT)
From: Michael Neuling <mikey@neuling.org>
To: mpe@ellerman.id.au
Cc: linuxppc-dev@lists.ozlabs.org, mikey@neuling.org, benh@kernel.crashing.org,
 Chris Smart <chris@distroguy.com>, mauricfo@br.ibm.com,
 Nicholas Piggin <nicholas.piggin@gmail.com>
Subject: [PATCH] selftests/powerpc: Remove redundant cp_abort test
Date: Fri,  6 Oct 2017 10:48:57 +1100
Message-Id: <20171005234857.2856-1-mikey@neuling.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Paste on POWER9 only works on accelerators and no longer on real
memory. Hence this test is broken so remove it.

Signed-off-by: Michael Neuling <mikey@neuling.org>
---
 tools/testing/selftests/powerpc/Makefile           |   1 -
 .../selftests/powerpc/context_switch/.gitignore    |   1 -
 .../selftests/powerpc/context_switch/Makefile      |   5 -
 .../selftests/powerpc/context_switch/cp_abort.c    | 110 ---------------------
 4 files changed, 117 deletions(-)
 delete mode 100644 tools/testing/selftests/powerpc/context_switch/.gitignore
 delete mode 100644 tools/testing/selftests/powerpc/context_switch/Makefile
 delete mode 100644 tools/testing/selftests/powerpc/context_switch/cp_abort.c

diff --git a/tools/testing/selftests/powerpc/Makefile b/tools/testing/selftests/powerpc/Makefile
index 72c3ac2323..433d39e16f 100644
--- a/tools/testing/selftests/powerpc/Makefile
+++ b/tools/testing/selftests/powerpc/Makefile
@@ -16,7 +16,6 @@ SUB_DIRS = alignment		\
 	   benchmarks		\
 	   cache_shape		\
 	   copyloops		\
-	   context_switch	\
 	   dscr			\
 	   mm			\
 	   pmu			\
diff --git a/tools/testing/selftests/powerpc/context_switch/.gitignore b/tools/testing/selftests/powerpc/context_switch/.gitignore
deleted file mode 100644
index c1431af7b5..0000000000
--- a/tools/testing/selftests/powerpc/context_switch/.gitignore
+++ /dev/null
@@ -1 +0,0 @@
-cp_abort
diff --git a/tools/testing/selftests/powerpc/context_switch/Makefile b/tools/testing/selftests/powerpc/context_switch/Makefile
deleted file mode 100644
index e9351bb428..0000000000
--- a/tools/testing/selftests/powerpc/context_switch/Makefile
+++ /dev/null
@@ -1,5 +0,0 @@
-TEST_GEN_PROGS := cp_abort
-
-include ../../lib.mk
-
-$(TEST_GEN_PROGS): ../harness.c ../utils.c
diff --git a/tools/testing/selftests/powerpc/context_switch/cp_abort.c b/tools/testing/selftests/powerpc/context_switch/cp_abort.c
deleted file mode 100644
index 5a5b55afda..0000000000
--- a/tools/testing/selftests/powerpc/context_switch/cp_abort.c
+++ /dev/null
@@ -1,110 +0,0 @@
-/*
- * Adapted from Anton Blanchard's context switch microbenchmark.
- *
- * Copyright 2009, Anton Blanchard, IBM Corporation.
- * Copyright 2016, Mikey Neuling, Chris Smart, IBM Corporation.
- *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of the GNU General Public License
- * as published by the Free Software Foundation; either version
- * 2 of the License, or (at your option) any later version.
- *
- * This program tests the copy paste abort functionality of a P9
- * (or later) by setting up two processes on the same CPU, one
- * which executes the copy instruction and the other which
- * executes paste.
- *
- * The paste instruction should never succeed, as the cp_abort
- * instruction is called by the kernel during a context switch.
- *
- */
-
-#define _GNU_SOURCE
-
-#include <stdio.h>
-#include <unistd.h>
-#include <stdlib.h>
-#include "utils.h"
-#include <sched.h>
-
-#define READ_FD 0
-#define WRITE_FD 1
-
-#define NUM_LOOPS 1000
-
-/* This defines the "paste" instruction from Power ISA 3.0 Book II, section 4.4. */
-#define PASTE(RA, RB, L, RC) \
-	.long (0x7c00070c | (RA) << (31-15) | (RB) << (31-20) | (L) << (31-10) | (RC) << (31-31))
-
-int paste(void *i)
-{
-	int cr;
-
-	asm volatile(str(PASTE(0, %1, 1, 1))";"
-			"mfcr %0;"
-			: "=r" (cr)
-			: "b" (i)
-			: "memory"
-		    );
-	return cr;
-}
-
-/* This defines the "copy" instruction from Power ISA 3.0 Book II, section 4.4. */
-#define COPY(RA, RB, L) \
-	.long (0x7c00060c | (RA) << (31-15) | (RB) << (31-20) | (L) << (31-10))
-
-void copy(void *i)
-{
-	asm volatile(str(COPY(0, %0, 1))";"
-			:
-			: "b" (i)
-			: "memory"
-		    );
-}
-
-int test_cp_abort(void)
-{
-	/* 128 bytes for a full cache line */
-	char buf[128] __cacheline_aligned;
-	cpu_set_t cpuset;
-	int fd1[2], fd2[2], pid;
-	char c;
-
-	/* only run this test on a P9 or later */
-	SKIP_IF(!have_hwcap2(PPC_FEATURE2_ARCH_3_00));
-
-	/*
-	 * Run both processes on the same CPU, so that copy is more likely
-	 * to leak into a paste.
-	 */
-	CPU_ZERO(&cpuset);
-	CPU_SET(pick_online_cpu(), &cpuset);
-	FAIL_IF(sched_setaffinity(0, sizeof(cpuset), &cpuset));
-
-	FAIL_IF(pipe(fd1) || pipe(fd2));
-
-	pid = fork();
-	FAIL_IF(pid < 0);
-
-	if (!pid) {
-		for (int i = 0; i < NUM_LOOPS; i++) {
-			FAIL_IF((write(fd1[WRITE_FD], &c, 1)) != 1);
-			FAIL_IF((read(fd2[READ_FD], &c, 1)) != 1);
-			/* A paste succeeds if CR0 EQ bit is set */
-			FAIL_IF(paste(buf) & 0x20000000);
-		}
-	} else {
-		for (int i = 0; i < NUM_LOOPS; i++) {
-			FAIL_IF((read(fd1[READ_FD], &c, 1)) != 1);
-			copy(buf);
-			FAIL_IF((write(fd2[WRITE_FD], &c, 1) != 1));
-		}
-	}
-	return 0;
-
-}
-
-int main(int argc, char *argv[])
-{
-	return test_harness(test_cp_abort, "cp_abort");
-}
-- 
2.11.0

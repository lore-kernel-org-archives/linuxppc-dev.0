Return-Path: <cyrilbur@gmail.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zlhCz4xpYzF0V8
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 20 Feb 2018 11:23:11 +1100 (AEDT)
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w1K0IsA8051599
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 19 Feb 2018 19:23:10 -0500
Received: from e06smtp10.uk.ibm.com (e06smtp10.uk.ibm.com [195.75.94.106])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2g80r1twge-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 19 Feb 2018 19:23:09 -0500
Received: from localhost
 by e06smtp10.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <cyrilbur@gmail.com>;
 Tue, 20 Feb 2018 00:23:03 -0000
From: Cyril Bur <cyrilbur@gmail.com>
To: mikey@neuling.org, benh@kernel.crashing.org, linuxppc-dev@lists.ozlabs.org
Subject: [RFC PATCH 12/12] [WIP] selftests/powerpc: Remove incorrect
 tm-syscall selftest
Date: Tue, 20 Feb 2018 11:22:41 +1100
In-Reply-To: <20180220002241.29648-1-cyrilbur@gmail.com>
References: <20180220002241.29648-1-cyrilbur@gmail.com>
Message-Id: <20180220002241.29648-13-cyrilbur@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Currently we perform transactional memory work at late as possible.
That is we run in the kernel with the userspace checkpointed state on
the CPU untill we absolultely must remove it and store it away. Likely
a process switch, but possibly also signals or ptrace.

What this means is that if userspace does a system call in suspended
mode, it is possible that we will handle the system call and return
them without the need to to a reclaim/recheckpoint and so they can
expect to resume their transaction.

This is what tm-syscall tests for - the ability to perform a system
call in suspended state and still resume it afterwards.

TM reworks have meant that we now deal with any transactional state on
entry to the kernel, no matter the reason for entry (some expections
apply). We will categorically doom any suspended transaction that makes
a system call, making that transaction unresumeable.

This test will now always fail no matter what. I would like to note
here that this new behaviour does not break userspace at all. Hardware
Transactional Memory gives zero guarantee of forward progress and any
correct userspace has already had and will always have to implement a
non HTM fallback. Relying on this specific kernel behaviour also meant
relying on the stars aligning in the hardware such that there was no
cache overlaps and that it had a large enough footprint to handle
any system call without dooming a transaction.
---
 tools/testing/selftests/powerpc/tm/Makefile        |   4 +-
 .../testing/selftests/powerpc/tm/tm-syscall-asm.S  |  28 ------
 tools/testing/selftests/powerpc/tm/tm-syscall.c    | 106 ---------------------
 3 files changed, 1 insertion(+), 137 deletions(-)
 delete mode 100644 tools/testing/selftests/powerpc/tm/tm-syscall-asm.S
 delete mode 100644 tools/testing/selftests/powerpc/tm/tm-syscall.c

diff --git a/tools/testing/selftests/powerpc/tm/Makefile b/tools/testing/selftests/powerpc/tm/Makefile
index 7a1e53297588..88d6edffcb24 100644
--- a/tools/testing/selftests/powerpc/tm/Makefile
+++ b/tools/testing/selftests/powerpc/tm/Makefile
@@ -2,7 +2,7 @@
 SIGNAL_CONTEXT_CHK_TESTS := tm-signal-context-chk-gpr tm-signal-context-chk-fpu \
 	tm-signal-context-chk-vmx tm-signal-context-chk-vsx
 
-TEST_GEN_PROGS := tm-resched-dscr tm-syscall tm-signal-msr-resv tm-signal-stack \
+TEST_GEN_PROGS := tm-resched-dscr tm-signal-msr-resv tm-signal-stack \
 	tm-vmxcopy tm-fork tm-tar tm-tmspr tm-vmx-unavail tm-unavailable tm-trap \
 	tm-signal-drop-transaction \
 	$(SIGNAL_CONTEXT_CHK_TESTS)
@@ -13,8 +13,6 @@ $(TEST_GEN_PROGS): ../harness.c ../utils.c
 
 CFLAGS += -mhtm
 
-$(OUTPUT)/tm-syscall: tm-syscall-asm.S
-$(OUTPUT)/tm-syscall: CFLAGS += -I../../../../../usr/include
 $(OUTPUT)/tm-tmspr: CFLAGS += -pthread
 $(OUTPUT)/tm-vmx-unavail: CFLAGS += -pthread -m64
 $(OUTPUT)/tm-resched-dscr: ../pmu/lib.o
diff --git a/tools/testing/selftests/powerpc/tm/tm-syscall-asm.S b/tools/testing/selftests/powerpc/tm/tm-syscall-asm.S
deleted file mode 100644
index bd1ca25febe4..000000000000
--- a/tools/testing/selftests/powerpc/tm/tm-syscall-asm.S
+++ /dev/null
@@ -1,28 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-#include <ppc-asm.h>
-#include <asm/unistd.h>
-
-	.text
-FUNC_START(getppid_tm_active)
-	tbegin.
-	beq 1f
-	li	r0, __NR_getppid
-	sc
-	tend.
-	blr
-1:
-	li	r3, -1
-	blr
-
-FUNC_START(getppid_tm_suspended)
-	tbegin.
-	beq 1f
-	li	r0, __NR_getppid
-	tsuspend.
-	sc
-	tresume.
-	tend.
-	blr
-1:
-	li	r3, -1
-	blr
diff --git a/tools/testing/selftests/powerpc/tm/tm-syscall.c b/tools/testing/selftests/powerpc/tm/tm-syscall.c
deleted file mode 100644
index 454b965a2db3..000000000000
--- a/tools/testing/selftests/powerpc/tm/tm-syscall.c
+++ /dev/null
@@ -1,106 +0,0 @@
-/*
- * Copyright 2015, Sam Bobroff, IBM Corp.
- * Licensed under GPLv2.
- *
- * Test the kernel's system call code to ensure that a system call
- * made from within an active HTM transaction is aborted with the
- * correct failure code.
- * Conversely, ensure that a system call made from within a
- * suspended transaction can succeed.
- */
-
-#include <stdio.h>
-#include <unistd.h>
-#include <sys/syscall.h>
-#include <asm/tm.h>
-#include <sys/time.h>
-#include <stdlib.h>
-
-#include "utils.h"
-#include "tm.h"
-
-extern int getppid_tm_active(void);
-extern int getppid_tm_suspended(void);
-
-unsigned retries = 0;
-
-#define TEST_DURATION 10 /* seconds */
-#define TM_RETRIES 100
-
-pid_t getppid_tm(bool suspend)
-{
-	int i;
-	pid_t pid;
-
-	for (i = 0; i < TM_RETRIES; i++) {
-		if (suspend)
-			pid = getppid_tm_suspended();
-		else
-			pid = getppid_tm_active();
-
-		if (pid >= 0)
-			return pid;
-
-		if (failure_is_persistent()) {
-			if (failure_is_syscall())
-				return -1;
-
-			printf("Unexpected persistent transaction failure.\n");
-			printf("TEXASR 0x%016lx, TFIAR 0x%016lx.\n",
-			       __builtin_get_texasr(), __builtin_get_tfiar());
-			exit(-1);
-		}
-
-		retries++;
-	}
-
-	printf("Exceeded limit of %d temporary transaction failures.\n", TM_RETRIES);
-	printf("TEXASR 0x%016lx, TFIAR 0x%016lx.\n",
-	       __builtin_get_texasr(), __builtin_get_tfiar());
-
-	exit(-1);
-}
-
-int tm_syscall(void)
-{
-	unsigned count = 0;
-	struct timeval end, now;
-
-	SKIP_IF(!have_htm_nosc());
-
-	setbuf(stdout, NULL);
-
-	printf("Testing transactional syscalls for %d seconds...\n", TEST_DURATION);
-
-	gettimeofday(&end, NULL);
-	now.tv_sec = TEST_DURATION;
-	now.tv_usec = 0;
-	timeradd(&end, &now, &end);
-
-	for (count = 0; timercmp(&now, &end, <); count++) {
-		/*
-		 * Test a syscall within a suspended transaction and verify
-		 * that it succeeds.
-		 */
-		FAIL_IF(getppid_tm(true) == -1); /* Should succeed. */
-
-		/*
-		 * Test a syscall within an active transaction and verify that
-		 * it fails with the correct failure code.
-		 */
-		FAIL_IF(getppid_tm(false) != -1);  /* Should fail... */
-		FAIL_IF(!failure_is_persistent()); /* ...persistently... */
-		FAIL_IF(!failure_is_syscall());    /* ...with code syscall. */
-		gettimeofday(&now, 0);
-	}
-
-	printf("%d active and suspended transactions behaved correctly.\n", count);
-	printf("(There were %d transaction retries.)\n", retries);
-
-	return 0;
-}
-
-int main(void)
-{
-	return test_harness(tm_syscall, "tm_syscall");
-}
-- 
2.16.2

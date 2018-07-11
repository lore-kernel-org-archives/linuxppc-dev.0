Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41QVZl52DSzF35N
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 11 Jul 2018 17:10:23 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: linuxppc-dev@ozlabs.org
Cc: mikey@neuling.org,
	chris@distroguy.com
Subject: [PATCH 3/3] selftests/powerpc: Consolidate copy/paste test logic
Date: Wed, 11 Jul 2018 17:10:17 +1000
Message-Id: <20180711071017.5128-3-mpe@ellerman.id.au>
In-Reply-To: <20180711071017.5128-1-mpe@ellerman.id.au>
References: <20180711071017.5128-1-mpe@ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This logic was shared between multiple tests, but now that we have
removed all but one of them we can just move it into that test.

Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 .../testing/selftests/powerpc/alignment/.gitignore |  1 -
 tools/testing/selftests/powerpc/alignment/Makefile |  2 +-
 .../powerpc/alignment/copy_first_unaligned.c       | 33 +++++++++++++-
 .../alignment/copy_paste_unaligned_common.c        | 53 ----------------------
 .../alignment/copy_paste_unaligned_common.h        | 26 -----------
 5 files changed, 33 insertions(+), 82 deletions(-)
 delete mode 100644 tools/testing/selftests/powerpc/alignment/copy_paste_unaligned_common.c
 delete mode 100644 tools/testing/selftests/powerpc/alignment/copy_paste_unaligned_common.h

diff --git a/tools/testing/selftests/powerpc/alignment/.gitignore b/tools/testing/selftests/powerpc/alignment/.gitignore
index 9c9b2e9b11c4..6d4fd014511c 100644
--- a/tools/testing/selftests/powerpc/alignment/.gitignore
+++ b/tools/testing/selftests/powerpc/alignment/.gitignore
@@ -1,3 +1,2 @@
 copy_first_unaligned
-copy_paste_unaligned_common
 alignment_handler
diff --git a/tools/testing/selftests/powerpc/alignment/Makefile b/tools/testing/selftests/powerpc/alignment/Makefile
index 58d0e0ed8ff5..93baacab7693 100644
--- a/tools/testing/selftests/powerpc/alignment/Makefile
+++ b/tools/testing/selftests/powerpc/alignment/Makefile
@@ -2,4 +2,4 @@ TEST_GEN_PROGS := copy_first_unaligned alignment_handler
 
 include ../../lib.mk
 
-$(TEST_GEN_PROGS): ../harness.c ../utils.c copy_paste_unaligned_common.c
+$(TEST_GEN_PROGS): ../harness.c ../utils.c
diff --git a/tools/testing/selftests/powerpc/alignment/copy_first_unaligned.c b/tools/testing/selftests/powerpc/alignment/copy_first_unaligned.c
index 47b73b3a08bd..5a9589987702 100644
--- a/tools/testing/selftests/powerpc/alignment/copy_first_unaligned.c
+++ b/tools/testing/selftests/powerpc/alignment/copy_first_unaligned.c
@@ -11,15 +11,46 @@
  *
  */
 
+#include <signal.h>
 #include <string.h>
 #include <unistd.h>
 #include "utils.h"
 #include "instructions.h"
-#include "copy_paste_unaligned_common.h"
 
 unsigned int expected_instruction = PPC_INST_COPY_FIRST;
 unsigned int instruction_mask = 0xfc2007fe;
 
+void signal_action_handler(int signal_num, siginfo_t *info, void *ptr)
+{
+	ucontext_t *ctx = ptr;
+#ifdef __powerpc64__
+	unsigned int *pc = (unsigned int *)ctx->uc_mcontext.gp_regs[PT_NIP];
+#else
+	unsigned int *pc = (unsigned int *)ctx->uc_mcontext.uc_regs->gregs[PT_NIP];
+#endif
+
+	/*
+	 * Check that the signal was on the correct instruction, using a
+	 * mask because the compiler assigns the register at RB.
+	 */
+	if ((*pc & instruction_mask) == expected_instruction)
+		_exit(0); /* We hit the right instruction */
+
+	_exit(1);
+}
+
+void setup_signal_handler(void)
+{
+	struct sigaction signal_action;
+
+	memset(&signal_action, 0, sizeof(signal_action));
+	signal_action.sa_sigaction = signal_action_handler;
+	signal_action.sa_flags = SA_SIGINFO;
+	sigaction(SIGBUS, &signal_action, NULL);
+}
+
+char cacheline_buf[128] __cacheline_aligned;
+
 int test_copy_first_unaligned(void)
 {
 	/* Only run this test on a P9 or later */
diff --git a/tools/testing/selftests/powerpc/alignment/copy_paste_unaligned_common.c b/tools/testing/selftests/powerpc/alignment/copy_paste_unaligned_common.c
deleted file mode 100644
index d35fa5f5d2d3..000000000000
--- a/tools/testing/selftests/powerpc/alignment/copy_paste_unaligned_common.c
+++ /dev/null
@@ -1,53 +0,0 @@
-/*
- * Copyright 2016, Chris Smart, IBM Corporation.
- *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of the GNU General Public License
- * as published by the Free Software Foundation; either version
- * 2 of the License, or (at your option) any later version.
- *
- * Common code for copy, copy_first, paste and paste_last unaligned
- * tests.
- *
- */
-
-#include <signal.h>
-#include <string.h>
-#include <unistd.h>
-#include "utils.h"
-#include "instructions.h"
-#include "copy_paste_unaligned_common.h"
-
-unsigned int expected_instruction;
-unsigned int instruction_mask;
-
-char cacheline_buf[128] __cacheline_aligned;
-
-void signal_action_handler(int signal_num, siginfo_t *info, void *ptr)
-{
-	ucontext_t *ctx = ptr;
-#if defined(__powerpc64__)
-	unsigned int *pc = (unsigned int *)ctx->uc_mcontext.gp_regs[PT_NIP];
-#else
-	unsigned int *pc = (unsigned int *)ctx->uc_mcontext.uc_regs->gregs[PT_NIP];
-#endif
-
-	/*
-	 * Check that the signal was on the correct instruction, using a
-	 * mask because the compiler assigns the register at RB.
-	 */
-	if ((*pc & instruction_mask) == expected_instruction)
-		_exit(0); /* We hit the right instruction */
-
-	_exit(1);
-}
-
-void setup_signal_handler(void)
-{
-	struct sigaction signal_action;
-
-	memset(&signal_action, 0, sizeof(signal_action));
-	signal_action.sa_sigaction = signal_action_handler;
-	signal_action.sa_flags = SA_SIGINFO;
-	sigaction(SIGBUS, &signal_action, NULL);
-}
diff --git a/tools/testing/selftests/powerpc/alignment/copy_paste_unaligned_common.h b/tools/testing/selftests/powerpc/alignment/copy_paste_unaligned_common.h
deleted file mode 100644
index 053899fe506e..000000000000
--- a/tools/testing/selftests/powerpc/alignment/copy_paste_unaligned_common.h
+++ /dev/null
@@ -1,26 +0,0 @@
-/*
- * Copyright 2016, Chris Smart, IBM Corporation.
- *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of the GNU General Public License
- * as published by the Free Software Foundation; either version
- * 2 of the License, or (at your option) any later version.
- *
- * Declarations for common code for copy, copy_first, paste and
- * paste_last unaligned tests.
- *
- */
-
-#ifndef _SELFTESTS_POWERPC_COPY_PASTE_H
-#define _SELFTESTS_POWERPC_COPY_PASTE_H
-
-#include <signal.h>
-
-int main(int argc, char *argv[]);
-void signal_action_handler(int signal_num, siginfo_t *info, void *ptr);
-void setup_signal_handler(void);
-extern char cacheline_buf[128] __cacheline_aligned;
-extern unsigned int expected_instruction;
-extern unsigned int instruction_mask;
-
-#endif /* _SELFTESTS_POWERPC_COPY_PASTE_H */
-- 
2.14.1

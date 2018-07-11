Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41QVZk4RKCzF35N
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 11 Jul 2018 17:10:22 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: linuxppc-dev@ozlabs.org
Cc: mikey@neuling.org,
	chris@distroguy.com
Subject: [PATCH 1/3] selftests/powerpc: Remove Power9 copy_unaligned test
Date: Wed, 11 Jul 2018 17:10:15 +1000
Message-Id: <20180711071017.5128-1-mpe@ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This is a test of the ISA 3.0 "copy" instruction. That instruction has
an L field, which if set to 1 specifies that "the instruction
identifies the beginning of a move group" (pp 858). That's also
referred to as "copy first" vs "copy".

In ISA 3.0B the copy instruction does not have an L field, and the
corresponding bit in the instruction must be set to 1.

This test is generating a "copy" instruction, not a "copy first", and
so on Power9 (which implements 3.0B), this results in an illegal
instruction.

So just drop the test entirely. We still have copy_first_unaligned to
test the "copy first" behaviour.

Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 .../testing/selftests/powerpc/alignment/.gitignore |  1 -
 tools/testing/selftests/powerpc/alignment/Makefile |  2 +-
 .../selftests/powerpc/alignment/copy_unaligned.c   | 41 ----------------------
 3 files changed, 1 insertion(+), 43 deletions(-)
 delete mode 100644 tools/testing/selftests/powerpc/alignment/copy_unaligned.c

diff --git a/tools/testing/selftests/powerpc/alignment/.gitignore b/tools/testing/selftests/powerpc/alignment/.gitignore
index 9d383073b7ad..78ac678b175b 100644
--- a/tools/testing/selftests/powerpc/alignment/.gitignore
+++ b/tools/testing/selftests/powerpc/alignment/.gitignore
@@ -1,4 +1,3 @@
-copy_unaligned
 copy_first_unaligned
 paste_unaligned
 paste_last_unaligned
diff --git a/tools/testing/selftests/powerpc/alignment/Makefile b/tools/testing/selftests/powerpc/alignment/Makefile
index 083a48a008b4..2d09d0e28b35 100644
--- a/tools/testing/selftests/powerpc/alignment/Makefile
+++ b/tools/testing/selftests/powerpc/alignment/Makefile
@@ -1,4 +1,4 @@
-TEST_GEN_PROGS := copy_unaligned copy_first_unaligned paste_unaligned \
+TEST_GEN_PROGS := copy_first_unaligned paste_unaligned \
 	paste_last_unaligned alignment_handler
 
 include ../../lib.mk
diff --git a/tools/testing/selftests/powerpc/alignment/copy_unaligned.c b/tools/testing/selftests/powerpc/alignment/copy_unaligned.c
deleted file mode 100644
index 3a4e26461554..000000000000
--- a/tools/testing/selftests/powerpc/alignment/copy_unaligned.c
+++ /dev/null
@@ -1,41 +0,0 @@
-/*
- * Copyright 2016, Chris Smart, IBM Corporation.
- *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of the GNU General Public License
- * as published by the Free Software Foundation; either version
- * 2 of the License, or (at your option) any later version.
- *
- * Calls to copy which are not 128-byte aligned should be caught
- * and sent a SIGBUS.
- *
- */
-
-#include <string.h>
-#include <unistd.h>
-#include "utils.h"
-#include "instructions.h"
-#include "copy_paste_unaligned_common.h"
-
-unsigned int expected_instruction = PPC_INST_COPY;
-unsigned int instruction_mask = 0xfc0007fe;
-
-int test_copy_unaligned(void)
-{
-	/* Only run this test on a P9 or later */
-	SKIP_IF(!have_hwcap2(PPC_FEATURE2_ARCH_3_00));
-
-	/* Register our signal handler with SIGBUS */
-	setup_signal_handler();
-
-	/* +1 makes buf unaligned */
-	copy(cacheline_buf+1);
-
-	/* We should not get here */
-	return 1;
-}
-
-int main(int argc, char *argv[])
-{
-	return test_harness(test_copy_unaligned, "test_copy_unaligned");
-}
-- 
2.14.1

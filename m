Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41QVZl0pbfzF35L
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 11 Jul 2018 17:10:23 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: linuxppc-dev@ozlabs.org
Cc: mikey@neuling.org,
	chris@distroguy.com
Subject: [PATCH 2/3] selftests/powerpc: Remove Power9 paste tests
Date: Wed, 11 Jul 2018 17:10:16 +1000
Message-Id: <20180711071017.5128-2-mpe@ellerman.id.au>
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

Paste on POWER9 only works to accelerators and not on real memory. So
these tests just generate a SIGILL.

So just delete them.

Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 .../testing/selftests/powerpc/alignment/.gitignore |  2 -
 tools/testing/selftests/powerpc/alignment/Makefile |  3 +-
 .../powerpc/alignment/paste_last_unaligned.c       | 43 ----------------------
 .../selftests/powerpc/alignment/paste_unaligned.c  | 43 ----------------------
 4 files changed, 1 insertion(+), 90 deletions(-)
 delete mode 100644 tools/testing/selftests/powerpc/alignment/paste_last_unaligned.c
 delete mode 100644 tools/testing/selftests/powerpc/alignment/paste_unaligned.c

diff --git a/tools/testing/selftests/powerpc/alignment/.gitignore b/tools/testing/selftests/powerpc/alignment/.gitignore
index 78ac678b175b..9c9b2e9b11c4 100644
--- a/tools/testing/selftests/powerpc/alignment/.gitignore
+++ b/tools/testing/selftests/powerpc/alignment/.gitignore
@@ -1,5 +1,3 @@
 copy_first_unaligned
-paste_unaligned
-paste_last_unaligned
 copy_paste_unaligned_common
 alignment_handler
diff --git a/tools/testing/selftests/powerpc/alignment/Makefile b/tools/testing/selftests/powerpc/alignment/Makefile
index 2d09d0e28b35..58d0e0ed8ff5 100644
--- a/tools/testing/selftests/powerpc/alignment/Makefile
+++ b/tools/testing/selftests/powerpc/alignment/Makefile
@@ -1,5 +1,4 @@
-TEST_GEN_PROGS := copy_first_unaligned paste_unaligned \
-	paste_last_unaligned alignment_handler
+TEST_GEN_PROGS := copy_first_unaligned alignment_handler
 
 include ../../lib.mk
 
diff --git a/tools/testing/selftests/powerpc/alignment/paste_last_unaligned.c b/tools/testing/selftests/powerpc/alignment/paste_last_unaligned.c
deleted file mode 100644
index 6e0ad045fcc3..000000000000
--- a/tools/testing/selftests/powerpc/alignment/paste_last_unaligned.c
+++ /dev/null
@@ -1,43 +0,0 @@
-/*
- * Copyright 2016, Chris Smart, IBM Corporation.
- *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of the GNU General Public License
- * as published by the Free Software Foundation; either version
- * 2 of the License, or (at your option) any later version.
- *
- * Calls to paste_last which are not 128-byte aligned should be
- * caught and sent a SIGBUS.
- *
- */
-
-#include <string.h>
-#include <unistd.h>
-#include "utils.h"
-#include "instructions.h"
-#include "copy_paste_unaligned_common.h"
-
-unsigned int expected_instruction = PPC_INST_PASTE_LAST;
-unsigned int instruction_mask = 0xfc2007ff;
-
-int test_paste_last_unaligned(void)
-{
-	/* Only run this test on a P9 or later */
-	SKIP_IF(!have_hwcap2(PPC_FEATURE2_ARCH_3_00));
-
-	/* Register our signal handler with SIGBUS */
-	setup_signal_handler();
-
-	copy(cacheline_buf);
-
-	/* +1 makes buf unaligned */
-	paste_last(cacheline_buf+1);
-
-	/* We should not get here */
-	return 1;
-}
-
-int main(int argc, char *argv[])
-{
-	return test_harness(test_paste_last_unaligned, "test_paste_last_unaligned");
-}
diff --git a/tools/testing/selftests/powerpc/alignment/paste_unaligned.c b/tools/testing/selftests/powerpc/alignment/paste_unaligned.c
deleted file mode 100644
index 6f982b45e4bd..000000000000
--- a/tools/testing/selftests/powerpc/alignment/paste_unaligned.c
+++ /dev/null
@@ -1,43 +0,0 @@
-/*
- * Copyright 2016, Chris Smart, IBM Corporation.
- *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of the GNU General Public License
- * as published by the Free Software Foundation; either version
- * 2 of the License, or (at your option) any later version.
- *
- * Calls to paste which are not 128-byte aligned should be caught
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
-unsigned int expected_instruction = PPC_INST_PASTE;
-unsigned int instruction_mask = 0xfc0007fe;
-
-int test_paste_unaligned(void)
-{
-	/* Only run this test on a P9 or later */
-	SKIP_IF(!have_hwcap2(PPC_FEATURE2_ARCH_3_00));
-
-	/* Register our signal handler with SIGBUS */
-	setup_signal_handler();
-
-	copy(cacheline_buf);
-
-	/* +1 makes buf unaligned */
-	paste(cacheline_buf+1);
-
-	/* We should not get here */
-	return 1;
-}
-
-int main(int argc, char *argv[])
-{
-	return test_harness(test_paste_unaligned, "test_paste_unaligned");
-}
-- 
2.14.1

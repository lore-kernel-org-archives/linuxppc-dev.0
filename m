Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wjGtn1LfNzDqKp
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  7 Jun 2017 15:14:09 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: linuxppc-dev@ozlabs.org
Cc: npiggin@gmail.com
Subject: [PATCH] selftests/powerpc: Add a test of a simple copy/paste
Date: Wed,  7 Jun 2017 15:14:06 +1000
Message-Id: <1496812446-21407-1-git-send-email-mpe@ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Power9 has two new instructions, copy and paste, which copy a cacheline
and then paste it somewhere.

We already have a test that the kernel correctly aborts the copy on
context switch, but we don't have a simple test to confirm copy/paste
itself actually works. So add one.

Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 .../selftests/powerpc/context_switch/.gitignore    |   1 +
 .../selftests/powerpc/context_switch/Makefile      |   2 +-
 .../selftests/powerpc/context_switch/copy_paste.c  | 108 +++++++++++++++++++++
 3 files changed, 110 insertions(+), 1 deletion(-)
 create mode 100644 tools/testing/selftests/powerpc/context_switch/copy_paste.c

diff --git a/tools/testing/selftests/powerpc/context_switch/.gitignore b/tools/testing/selftests/powerpc/context_switch/.gitignore
index c1431af7b51c..6018c777e537 100644
--- a/tools/testing/selftests/powerpc/context_switch/.gitignore
+++ b/tools/testing/selftests/powerpc/context_switch/.gitignore
@@ -1 +1,2 @@
 cp_abort
+copy_paste
diff --git a/tools/testing/selftests/powerpc/context_switch/Makefile b/tools/testing/selftests/powerpc/context_switch/Makefile
index e9351bb4285d..f5ba79c6c3d1 100644
--- a/tools/testing/selftests/powerpc/context_switch/Makefile
+++ b/tools/testing/selftests/powerpc/context_switch/Makefile
@@ -1,4 +1,4 @@
-TEST_GEN_PROGS := cp_abort
+TEST_GEN_PROGS := cp_abort copy_paste
 
 include ../../lib.mk
 
diff --git a/tools/testing/selftests/powerpc/context_switch/copy_paste.c b/tools/testing/selftests/powerpc/context_switch/copy_paste.c
new file mode 100644
index 000000000000..0695c340bc82
--- /dev/null
+++ b/tools/testing/selftests/powerpc/context_switch/copy_paste.c
@@ -0,0 +1,108 @@
+/*
+ * Copyright 2016, Mikey Neuling, Chris Smart, IBM Corporation.
+ * Copyright 2017, Michael Ellerman, IBM Corporation.
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version
+ * 2 of the License, or (at your option) any later version.
+ *
+ * Check that copy/paste works on Power9.
+ */
+
+#define _GNU_SOURCE
+
+#include <errno.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <unistd.h>
+
+#include "utils.h"
+
+
+#define NUM_LOOPS 1000
+
+
+/* This defines the "paste" instruction from Power ISA 3.0 Book II, section 4.4. */
+#define PASTE(RA, RB, L, RC) \
+	.long (0x7c00070c | (RA) << (31-15) | (RB) << (31-20) | (L) << (31-10) | (RC) << (31-31))
+
+int paste(void *i)
+{
+	int cr;
+
+	asm volatile(str(PASTE(0, %1, 1, 1))";"
+			"mfcr %0;"
+			: "=r" (cr)
+			: "b" (i)
+			: "memory"
+		    );
+	return cr;
+}
+
+/* This defines the "copy" instruction from Power ISA 3.0 Book II, section 4.4. */
+#define COPY(RA, RB, L) \
+	.long (0x7c00060c | (RA) << (31-15) | (RB) << (31-20) | (L) << (31-10))
+
+void copy(void *i)
+{
+	asm volatile(str(COPY(0, %0, 1))";"
+			:
+			: "b" (i)
+			: "memory"
+		    );
+}
+
+int test_copy_paste(void)
+{
+	/* 128 bytes for a full cache line */
+	char orig[128] __cacheline_aligned;
+	char src[128] __cacheline_aligned;
+	char dst[128] __cacheline_aligned;
+	int rc;
+
+	/* only run this test on a P9 or later */
+	SKIP_IF(!have_hwcap2(PPC_FEATURE2_ARCH_3_00));
+
+	memset(orig, 0x5a, sizeof(orig));
+	memset(src, 0x5a, sizeof(src));
+	memset(dst, 0x00, sizeof(dst));
+
+	/* Confirm orig and src match */
+	FAIL_IF(0 != memcmp(orig, src, sizeof(orig)));
+
+	/* Confirm src & dst are different */
+	FAIL_IF(0 == memcmp(src, dst, sizeof(src)));
+
+	/*
+	 * Paste can fail, eg. if we get context switched, so we do the
+	 * copy/paste in a loop and fail the test if it never succeeds.
+	 */
+	for (int i = 0; i < NUM_LOOPS; i++) {
+		copy(src);
+		rc = paste(dst);
+
+		/* A paste succeeds if CR0 EQ bit is set */
+		if (rc & 0x20000000) {
+			rc = 0;
+			break;
+		}
+		rc = EAGAIN;
+	}
+
+	FAIL_IF(rc);
+
+	/* Confirm orig and src still match */
+	FAIL_IF(0 != memcmp(orig, src, sizeof(orig)));
+
+	/* And that src and dst now match */
+	FAIL_IF(0 != memcmp(src, dst, sizeof(src)));
+
+	return 0;
+}
+
+int main(int argc, char *argv[])
+{
+	return test_harness(test_copy_paste, "copy_paste");
+}
-- 
2.7.4

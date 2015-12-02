Return-Path: <rashmicy@gmail.com>
Received: from mail-pa0-x22f.google.com (mail-pa0-x22f.google.com
 [IPv6:2607:f8b0:400e:c03::22f])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 202B31A0910
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  2 Dec 2015 16:53:09 +1100 (AEDT)
Received: by pabfh17 with SMTP id fh17so30877442pab.0
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 01 Dec 2015 21:53:07 -0800 (PST)
From: Rashmica Gupta <rashmicy@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: mikey@neuling.org
Subject: [v2] selftests/powerpc: Add test to check is DSCR is corrupted.
Date: Wed,  2 Dec 2015 16:52:58 +1100
Message-Id: <1449035578-10920-1-git-send-email-rashmicy@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

If the transaction is aborted, the DSCR should be rolled back to the
checkpointed value before the transaction began. The value written to the
DSCR when transaction was suspended should only persist if the transaction
is successful.

Signed-off-by: Rashmica Gupta <rashmicy@gmail.com>
---
No functional changes. Fixed whitespace and styling issues.

 tools/testing/selftests/powerpc/tm/.gitignore |  1 +
 tools/testing/selftests/powerpc/tm/Makefile   |  2 +-
 tools/testing/selftests/powerpc/tm/tm-dscr.c  | 95 +++++++++++++++++++++++++++
 3 files changed, 97 insertions(+), 1 deletion(-)
 create mode 100644 tools/testing/selftests/powerpc/tm/tm-dscr.c

diff --git a/tools/testing/selftests/powerpc/tm/.gitignore b/tools/testing/selftests/powerpc/tm/.gitignore
index d0c7c97e9b13..76eae258feeb 100644
--- a/tools/testing/selftests/powerpc/tm/.gitignore
+++ b/tools/testing/selftests/powerpc/tm/.gitignore
@@ -3,3 +3,4 @@ tm-syscall
 tm-signal-msr-resv
 tm-signal-stack
 tm-fork
+tm-dscr
diff --git a/tools/testing/selftests/powerpc/tm/Makefile b/tools/testing/selftests/powerpc/tm/Makefile
index f7d4727662aa..59eec240339d 100644
--- a/tools/testing/selftests/powerpc/tm/Makefile
+++ b/tools/testing/selftests/powerpc/tm/Makefile
@@ -1,4 +1,4 @@
-TEST_PROGS := tm-resched-dscr tm-syscall tm-signal-msr-resv tm-signal-stack tm-fork
+TEST_PROGS := tm-resched-dscr tm-syscall tm-signal-msr-resv tm-signal-stack tm-fork tm-dscr
 
 all: $(TEST_PROGS)
 
diff --git a/tools/testing/selftests/powerpc/tm/tm-dscr.c b/tools/testing/selftests/powerpc/tm/tm-dscr.c
new file mode 100644
index 000000000000..b18360895496
--- /dev/null
+++ b/tools/testing/selftests/powerpc/tm/tm-dscr.c
@@ -0,0 +1,95 @@
+/*
+ * Copyright 2015, Michael Neuling, IBM Corp.
+ * Licensed under GPLv2.
+ * Original: Michael Neuling 19/7/2013
+ * Edited: Rashmica Gupta 01/12/2015
+ *
+ * Do some transactions, see if the DSCR is corrupted.
+ * If the transaction is aborted, the DSCR should be rolled back to the
+ * checkpointed value before the transaction began. The value set to DSCR
+ * while the transaction was suspended should only remain there if the
+ * transaction succeeds.
+ *
+ */
+
+#include <stdio.h>
+#include <stdlib.h>
+#include <unistd.h>
+#include <string.h>
+
+#include "tm.h"
+#include "utils.h"
+
+#define SPRN_DSCR	0x3
+
+int	num_loops	= 10000;
+
+int test_dscr(void)
+{
+	int i;
+
+	SKIP_IF(!have_htm());
+
+	for (i = 0; i < num_loops; i++)
+	{
+		uint64_t result = 0;
+		asm __volatile__(
+			"li	7, 1;"
+			"mtspr	%[dscr], 7;"	/* dscr = 1 */
+			"tbegin.;"
+			"beq	3f ;"
+			"li	4, 0x7000;"	/* Loop lots, to use time */
+			"2:;"		     	/* Start loop */
+			"li	7, 2;"
+			"mtspr	%[dscr], 7;"	/* dscr = 2 */
+			"tsuspend.;"
+			"li	7, 3;"
+			"mtspr	%[dscr], 7;"	/* dscr = 3 */
+			"tresume.;"
+			"subi	4, 4, 1;"
+			"cmpdi	4, 0;"
+			"bne	2b;"
+			"tend.;"
+
+			/* Transaction sucess! DSCR should be 3 */
+			"mfspr  7, %[dscr];"
+			"ori	%[res], 7, 4;"	/* res = 3|4 = 7 */
+			"b	4f;"
+
+			/* Abort handler.DSCR should be rolled back to 1 */
+			"3:;"
+			"mfspr  7, %[dscr];"
+			"ori	%[res], 7, 8;"	/* res = 1|8 = 9 */
+			"4:;"
+
+			: [res]"=r"(result)
+			: [dscr]"i"(SPRN_DSCR)
+			: "memory", "r0", "r4", "r7");
+
+		/* If result is anything else other than 7 or 9, the dscr
+		* value must have been corrupted. */
+		if ((result != 7) && (result != 9))
+			return 1;
+
+	}
+	return 0;
+}
+
+int main(int argc, char *argv[])
+{
+
+	/* A low number of iterations (eg 100) can cause a false pass */
+	if (argc > 1) {
+		if (strcmp(argv[1], "-h") == 0) {
+			printf("Syntax:\n\t%s [<num loops>]\n",
+			       argv[0]);
+			return 0;
+		} else {
+			num_loops = atoi(argv[1]);
+		}
+	}
+
+	printf("Starting, %d loops\n", num_loops);
+
+	test_harness(test_dscr, "tm_dscr");
+}
-- 
2.5.0

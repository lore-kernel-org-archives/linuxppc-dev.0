Return-Path: <cyrilbur@gmail.com>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qf8CB3SDCzDq6B
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  5 Apr 2016 10:01:10 +1000 (AEST)
Received: from e23smtp03.au.ibm.com (e23smtp03.au.ibm.com [202.81.31.145])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3qf8CB2PJDz9sCp
 for <linuxppc-dev@ozlabs.org>; Tue,  5 Apr 2016 10:01:10 +1000 (AEST)
Received: from localhost
 by e23smtp03.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <cyrilbur@gmail.com>;
 Tue, 5 Apr 2016 10:01:09 +1000
Received: from d23relay10.au.ibm.com (d23relay10.au.ibm.com [9.190.26.77])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id DEF32357805A
 for <linuxppc-dev@ozlabs.org>; Tue,  5 Apr 2016 10:01:06 +1000 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay10.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u3500wZ565994920
 for <linuxppc-dev@ozlabs.org>; Tue, 5 Apr 2016 10:01:06 +1000
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u3500XBA004799
 for <linuxppc-dev@ozlabs.org>; Tue, 5 Apr 2016 10:00:34 +1000
From: Cyril Bur <cyrilbur@gmail.com>
To: linuxppc-dev@ozlabs.org
Cc: mikey@neuling.org
Subject: [PATCH V2 1/5] selftests/powerpc: Add exec() test to check for spr
 sanitisation
Date: Tue,  5 Apr 2016 09:59:23 +1000
Message-Id: <1459814367-3057-1-git-send-email-cyrilbur@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Signed-off-by: Cyril Bur <cyrilbur@gmail.com>
---
 tools/testing/selftests/powerpc/syscalls/Makefile  |  3 +-
 .../testing/selftests/powerpc/syscalls/spr_exec.c  | 78 ++++++++++++++++++++++
 2 files changed, 80 insertions(+), 1 deletion(-)
 create mode 100644 tools/testing/selftests/powerpc/syscalls/spr_exec.c

diff --git a/tools/testing/selftests/powerpc/syscalls/Makefile b/tools/testing/selftests/powerpc/syscalls/Makefile
index b35c794..291ba45 100644
--- a/tools/testing/selftests/powerpc/syscalls/Makefile
+++ b/tools/testing/selftests/powerpc/syscalls/Makefile
@@ -1,10 +1,11 @@
-TEST_PROGS := ipc_unmuxed
+TEST_PROGS := ipc_unmuxed spr_exec
 
 CFLAGS += -I../../../../../usr/include
 
 all: $(TEST_PROGS)
 
 $(TEST_PROGS): ../harness.c
+spr_exec: ../utils.c
 
 include ../../lib.mk
 
diff --git a/tools/testing/selftests/powerpc/syscalls/spr_exec.c b/tools/testing/selftests/powerpc/syscalls/spr_exec.c
new file mode 100644
index 0000000..5ecd6ca
--- /dev/null
+++ b/tools/testing/selftests/powerpc/syscalls/spr_exec.c
@@ -0,0 +1,78 @@
+/*
+ * Copyright 2016, Cyril Bur, IBM Corp.
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version
+ * 2 of the License, or (at your option) any later version.
+ *
+ * This test checks that the TAR (an SPR) is correctly sanitised across
+ * execve()
+ */
+#include <asm/cputable.h>
+#include <stdlib.h>
+#include <stdio.h>
+#include <sys/auxv.h>
+#include <unistd.h>
+
+#include "utils.h"
+
+static char *name;
+static int count;
+
+static int exec_spr(void)
+{
+	unsigned long tar;
+	char buffer[10];
+	char *args[3];
+
+	asm __volatile__(
+			"mfspr %[tar], 815"
+			: [tar] "=r" (tar)
+			);
+	/* Read TAR */
+	FAIL_IF(tar != 0);
+
+	tar = 1;
+	asm __volatile__(
+			"mtspr 815, %[tar]"
+			:
+			: [tar] "r" (tar)
+			);
+
+	FAIL_IF(sprintf(buffer, "%d", count + 1) == -1);
+	args[0] = name;
+	args[1] = buffer;
+	args[2] = NULL;
+	FAIL_IF(execve(name, args, NULL) == -1);
+
+	return 0;
+}
+
+static int exec_spr_check(void)
+{
+	unsigned long tar;
+
+	asm __volatile__(
+			"mfspr %[tar], 815;"
+			: [tar] "=r" (tar)
+			);
+	/* Read TAR */
+	FAIL_IF(tar != 0);
+
+	return 0;
+}
+
+int main(int argc, char *argv[])
+{
+	SKIP_IF(!have_hwcap2(PPC_FEATURE2_TAR));
+	name = argv[0];
+	/* Do this a few times to be sure isn't a false negative */
+	if (argc == 1 || atoi(argv[1]) < 10) {
+		if (argc > 1)
+			count = atoi(argv[1]);
+		return test_harness(exec_spr, "spr_exec");
+	} else {
+		return test_harness(exec_spr_check, "spr_exec_check");
+	}
+}
-- 
2.7.4

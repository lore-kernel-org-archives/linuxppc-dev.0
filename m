Return-Path: <cyrilbur@gmail.com>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qf8CH3j0lzDqDV
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  5 Apr 2016 10:01:15 +1000 (AEST)
Received: from e23smtp03.au.ibm.com (e23smtp03.au.ibm.com [202.81.31.145])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3qf8CH2D9gz9sCj
 for <linuxppc-dev@ozlabs.org>; Tue,  5 Apr 2016 10:01:15 +1000 (AEST)
Received: from localhost
 by e23smtp03.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <cyrilbur@gmail.com>;
 Tue, 5 Apr 2016 10:01:15 +1000
Received: from d23relay06.au.ibm.com (d23relay06.au.ibm.com [9.185.63.219])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id C23953578052
 for <linuxppc-dev@ozlabs.org>; Tue,  5 Apr 2016 10:01:09 +1000 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay06.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u3500xWN61538538
 for <linuxppc-dev@ozlabs.org>; Tue, 5 Apr 2016 10:01:09 +1000
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u3500Y3m004828
 for <linuxppc-dev@ozlabs.org>; Tue, 5 Apr 2016 10:00:34 +1000
From: Cyril Bur <cyrilbur@gmail.com>
To: linuxppc-dev@ozlabs.org
Cc: mikey@neuling.org
Subject: [PATCH V2 2/5] selftests/powerpc: Add fork() test to check for spr
 being preserved
Date: Tue,  5 Apr 2016 09:59:24 +1000
Message-Id: <1459814367-3057-2-git-send-email-cyrilbur@gmail.com>
In-Reply-To: <1459814367-3057-1-git-send-email-cyrilbur@gmail.com>
References: <1459814367-3057-1-git-send-email-cyrilbur@gmail.com>
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
 .../testing/selftests/powerpc/syscalls/spr_fork.c  | 78 ++++++++++++++++++++++
 2 files changed, 80 insertions(+), 1 deletion(-)
 create mode 100644 tools/testing/selftests/powerpc/syscalls/spr_fork.c

diff --git a/tools/testing/selftests/powerpc/syscalls/Makefile b/tools/testing/selftests/powerpc/syscalls/Makefile
index 291ba45..55969f3 100644
--- a/tools/testing/selftests/powerpc/syscalls/Makefile
+++ b/tools/testing/selftests/powerpc/syscalls/Makefile
@@ -1,4 +1,4 @@
-TEST_PROGS := ipc_unmuxed spr_exec
+TEST_PROGS := ipc_unmuxed spr_exec spr_fork
 
 CFLAGS += -I../../../../../usr/include
 
@@ -6,6 +6,7 @@ all: $(TEST_PROGS)
 
 $(TEST_PROGS): ../harness.c
 spr_exec: ../utils.c
+spr_fork: ../utils.c
 
 include ../../lib.mk
 
diff --git a/tools/testing/selftests/powerpc/syscalls/spr_fork.c b/tools/testing/selftests/powerpc/syscalls/spr_fork.c
new file mode 100644
index 0000000..1a351a6
--- /dev/null
+++ b/tools/testing/selftests/powerpc/syscalls/spr_fork.c
@@ -0,0 +1,78 @@
+/*
+ * Copyright 2016, Cyril Bur, IBM Corp.
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version
+ * 2 of the License, or (at your option) any later version.
+ *
+ * This test checks that the TAR register (an SPR) is correctly preserved
+ * across a fork()
+ */
+#include <asm/cputable.h>
+#include <stdlib.h>
+#include <stdio.h>
+#include <sys/auxv.h>
+#include <sys/wait.h>
+#include <unistd.h>
+
+#include "utils.h"
+
+static int fork_spr(void)
+{
+	int child_ret;
+	unsigned long tar;
+	pid_t pid;
+	int i;
+
+
+	/* Do it a few times as there is a chance that one might luckily pass */
+	i = 0;
+	while (i < 10) {
+		/* What are the odds... */
+		tar = 0x123456;
+		asm __volatile__(
+				"mtspr 815, %[tar]"
+				:
+				: [tar] "r" (tar)
+				);
+
+		pid = fork();
+		FAIL_IF(pid == -1);
+		asm __volatile__(
+				"mfspr %[tar], 815"
+				: [tar] "=r" (tar)
+				);
+
+		FAIL_IF(tar != 0x123456);
+
+		if (pid == 0)
+			exit(0);
+
+		FAIL_IF(waitpid(pid, &child_ret, 0) == -1);
+
+		/* Child haddn't exited ? */
+		FAIL_IF(!WIFEXITED(child_ret));
+
+		/* Child detected a bad tar */
+		FAIL_IF(WEXITSTATUS(child_ret));
+
+		/* Reset it */
+		tar = 0;
+		asm __volatile__(
+				"mtspr 815, %[tar]"
+				:
+				: [tar] "r" (tar)
+				);
+
+		i++;
+	}
+
+	return 0;
+}
+
+int main(int argc, char *argv[])
+{
+	SKIP_IF(!have_hwcap2(PPC_FEATURE2_TAR));
+	return test_harness(fork_spr, "spr_fork");
+}
-- 
2.7.4

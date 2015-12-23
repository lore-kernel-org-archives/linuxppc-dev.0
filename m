Return-Path: <rashmicy@gmail.com>
Received: from mail-pa0-x22f.google.com (mail-pa0-x22f.google.com
 [IPv6:2607:f8b0:400e:c03::22f])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id DF7A91A0C29
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 Dec 2015 16:50:29 +1100 (AEDT)
Received: by mail-pa0-x22f.google.com with SMTP id uo6so23116761pac.1
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 22 Dec 2015 21:50:29 -0800 (PST)
From: Rashmica Gupta <rashmicy@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: mikey@neuling.org,
	mpe@ellermen.id.au
Subject: [PATCH 3/5] selftests/powerpc: Add test for forking inside transaction
Date: Wed, 23 Dec 2015 16:49:52 +1100
Message-Id: <1450849794-23174-4-git-send-email-rashmicy@gmail.com>
In-Reply-To: <1450849794-23174-1-git-send-email-rashmicy@gmail.com>
References: <1450849794-23174-1-git-send-email-rashmicy@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This test does a fork syscall inside a transaction. Basic sniff test to see
if we can enter the kernel during a transaction.

Signed-off-by: Rashmica Gupta <rashmicy@gmail.com>
---
 tools/testing/selftests/powerpc/tm/.gitignore |  1 +
 tools/testing/selftests/powerpc/tm/Makefile   |  2 +-
 tools/testing/selftests/powerpc/tm/tm-fork.c  | 42 +++++++++++++++++++++++++++
 3 files changed, 44 insertions(+), 1 deletion(-)
 create mode 100644 tools/testing/selftests/powerpc/tm/tm-fork.c

diff --git a/tools/testing/selftests/powerpc/tm/.gitignore b/tools/testing/selftests/powerpc/tm/.gitignore
index 7d0f14b8cb2e..d216eddcd493 100644
--- a/tools/testing/selftests/powerpc/tm/.gitignore
+++ b/tools/testing/selftests/powerpc/tm/.gitignore
@@ -3,3 +3,4 @@ tm-syscall
 tm-signal-msr-resv
 tm-signal-stack
 tm-vmxcopy
+tm-fork
diff --git a/tools/testing/selftests/powerpc/tm/Makefile b/tools/testing/selftests/powerpc/tm/Makefile
index 737f72c964e6..2db475b12720 100644
--- a/tools/testing/selftests/powerpc/tm/Makefile
+++ b/tools/testing/selftests/powerpc/tm/Makefile
@@ -1,4 +1,4 @@
-TEST_PROGS := tm-resched-dscr tm-syscall tm-signal-msr-resv tm-signal-stack tm-vmxcopy
+TEST_PROGS := tm-resched-dscr tm-syscall tm-signal-msr-resv tm-signal-stack tm-vmxcopy tm-fork
 
 all: $(TEST_PROGS)
 
diff --git a/tools/testing/selftests/powerpc/tm/tm-fork.c b/tools/testing/selftests/powerpc/tm/tm-fork.c
new file mode 100644
index 000000000000..8d48579b7778
--- /dev/null
+++ b/tools/testing/selftests/powerpc/tm/tm-fork.c
@@ -0,0 +1,42 @@
+/*
+ * Copyright 2015, Michael Neuling, IBM Corp.
+ * Licensed under GPLv2.
+ *
+ * Edited: Rashmica Gupta, Nov 2015
+ *
+ * This test does a fork syscall inside a transaction. Basic sniff test
+ * to see if we can enter the kernel during a transaction.
+ */
+
+#include <errno.h>
+#include <inttypes.h>
+#include <pthread.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <unistd.h>
+
+#include "utils.h"
+#include "tm.h"
+
+int test_fork(void)
+{
+	SKIP_IF(!have_htm());
+
+	asm __volatile__(
+		"tbegin.;"
+		"blt    1f; "
+		"li     0, 2;"  /* fork syscall */
+		"sc  ;"
+		"tend.;"
+		"1: ;"
+		: : : "memory", "r0");
+	/* If we reach here, we've passed.  Otherwise we've probably crashed
+	 * the kernel */
+
+	return 0;
+}
+
+int main(int argc, char *argv[])
+{
+	return test_harness(test_fork, "tm_fork");
+}
-- 
2.5.0

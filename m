Return-Path: <rashmicy@gmail.com>
Received: from mail-pa0-x22d.google.com (mail-pa0-x22d.google.com
 [IPv6:2607:f8b0:400e:c03::22d])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 5A6541A1E66
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  1 Dec 2015 16:08:49 +1100 (AEDT)
Received: by pacdm15 with SMTP id dm15so209061813pac.3
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 30 Nov 2015 21:08:47 -0800 (PST)
Received: from circle.ozlabs.ibm.com ([122.99.82.10])
 by smtp.gmail.com with ESMTPSA id ux3sm55304740pac.18.2015.11.30.21.08.46
 for <linuxppc-dev@lists.ozlabs.org>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
 Mon, 30 Nov 2015 21:08:47 -0800 (PST)
From: Rashmica Gupta <rashmicy@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 2/3] selftests/powerpc: Add test for forking inside transaction
Date: Tue,  1 Dec 2015 16:08:23 +1100
Message-Id: <1448946504-11653-3-git-send-email-rashmicy@gmail.com>
In-Reply-To: <1448946504-11653-1-git-send-email-rashmicy@gmail.com>
References: <1448946504-11653-1-git-send-email-rashmicy@gmail.com>
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
 tools/testing/selftests/powerpc/tm/tm-fork.c  | 41 +++++++++++++++++++++++++++
 3 files changed, 43 insertions(+), 1 deletion(-)
 create mode 100644 tools/testing/selftests/powerpc/tm/tm-fork.c

diff --git a/tools/testing/selftests/powerpc/tm/.gitignore b/tools/testing/selftests/powerpc/tm/.gitignore
index e6668217ccd0..d0c7c97e9b13 100644
--- a/tools/testing/selftests/powerpc/tm/.gitignore
+++ b/tools/testing/selftests/powerpc/tm/.gitignore
@@ -2,3 +2,4 @@ tm-resched-dscr
 tm-syscall
 tm-signal-msr-resv
 tm-signal-stack
+tm-fork
diff --git a/tools/testing/selftests/powerpc/tm/Makefile b/tools/testing/selftests/powerpc/tm/Makefile
index 578572a3700a..f7d4727662aa 100644
--- a/tools/testing/selftests/powerpc/tm/Makefile
+++ b/tools/testing/selftests/powerpc/tm/Makefile
@@ -1,4 +1,4 @@
-TEST_PROGS := tm-resched-dscr tm-syscall tm-signal-msr-resv tm-signal-stack
+TEST_PROGS := tm-resched-dscr tm-syscall tm-signal-msr-resv tm-signal-stack tm-fork
 
 all: $(TEST_PROGS)
 
diff --git a/tools/testing/selftests/powerpc/tm/tm-fork.c b/tools/testing/selftests/powerpc/tm/tm-fork.c
new file mode 100644
index 000000000000..f571a48a59a0
--- /dev/null
+++ b/tools/testing/selftests/powerpc/tm/tm-fork.c
@@ -0,0 +1,41 @@
+/*
+ * Copyright 2015, Michael Neuling, IBM Corp.
+ * Licensed under GPLv2.
+ *
+ * Edited: Rashmica Gupta, Nov 2015
+ *
+ * Fork inside a transaction
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

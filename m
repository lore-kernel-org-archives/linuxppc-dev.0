Return-Path: <ldufour@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sJ04m60v4zDrJq
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 23 Aug 2016 02:53:12 +1000 (AEST)
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u7MGmd52044847
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 22 Aug 2016 12:53:09 -0400
Received: from e06smtp06.uk.ibm.com (e06smtp06.uk.ibm.com [195.75.94.102])
 by mx0a-001b2d01.pphosted.com with ESMTP id 24y17nfp9e-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 22 Aug 2016 12:53:09 -0400
Received: from localhost
 by e06smtp06.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <ldufour@linux.vnet.ibm.com>;
 Mon, 22 Aug 2016 17:53:06 +0100
Received: from b06cxnps4074.portsmouth.uk.ibm.com
 (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
 by d06dlp01.portsmouth.uk.ibm.com (Postfix) with ESMTP id 6C75F17D805A
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 22 Aug 2016 17:54:50 +0100 (BST)
Received: from d06av03.portsmouth.uk.ibm.com (d06av03.portsmouth.uk.ibm.com
 [9.149.37.213])
 by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u7MGr56m196976
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 22 Aug 2016 16:53:05 GMT
Received: from d06av03.portsmouth.uk.ibm.com (localhost [127.0.0.1])
 by d06av03.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u7MGr4F8009286
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 22 Aug 2016 10:53:04 -0600
From: Laurent Dufour <ldufour@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org, mpe@ellerman.id.au
Cc: cyrilbur@gmail.com, wei.guo.simon@gmail.com
Subject: [PATCH] selftest/powerpc: Add test for sigreturn in transaction
Date: Mon, 22 Aug 2016 18:53:02 +0200
Message-Id: <1471884782-20403-1-git-send-email-ldufour@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Ensure that kernel is throwing away the suspended transaction when
sigreturn() is called otherwise it if fails to restore the signal
frame's TM SPRS.

Signed-off-by: Laurent Dufour <ldufour@linux.vnet.ibm.com>
---
 tools/testing/selftests/powerpc/tm/Makefile       |  2 +-
 tools/testing/selftests/powerpc/tm/tm-sigreturn.c | 89 +++++++++++++++++++++++
 2 files changed, 90 insertions(+), 1 deletion(-)
 create mode 100644 tools/testing/selftests/powerpc/tm/tm-sigreturn.c

diff --git a/tools/testing/selftests/powerpc/tm/Makefile b/tools/testing/selftests/powerpc/tm/Makefile
index 9d301d785d9e..5e0396d79c8a 100644
--- a/tools/testing/selftests/powerpc/tm/Makefile
+++ b/tools/testing/selftests/powerpc/tm/Makefile
@@ -1,5 +1,5 @@
 TEST_PROGS := tm-resched-dscr tm-syscall tm-signal-msr-resv tm-signal-stack \
-	tm-vmxcopy tm-fork tm-tar tm-tmspr tm-exec tm-execed
+	tm-vmxcopy tm-fork tm-tar tm-tmspr tm-exec tm-execed tm-sigreturn
 
 all: $(TEST_PROGS)
 
diff --git a/tools/testing/selftests/powerpc/tm/tm-sigreturn.c b/tools/testing/selftests/powerpc/tm/tm-sigreturn.c
new file mode 100644
index 000000000000..43fa83de23a5
--- /dev/null
+++ b/tools/testing/selftests/powerpc/tm/tm-sigreturn.c
@@ -0,0 +1,89 @@
+/*
+ * Copyright 2015, Laurent Dufour, IBM Corp.
+ * Licensed under GPLv2.
+ *
+ * Test the kernel's signal returning code to check reclaim is done if
+ * the sigreturn() is called while in a transaction (suspended since active
+ * is already dropped trough the system call path).
+ *
+ * The kernel must discard the transaction when entering sigreturn,
+ * since restoring the potential TM SPRS from the signal frame is requiring to
+ * not be in a transaction.
+ */
+
+#include <unistd.h>
+#include <sys/types.h>
+#include <sys/wait.h>
+#include <stdlib.h>
+#include <stdio.h>
+#include <signal.h>
+#include <string.h>
+
+#include "utils.h"
+#include "tm.h"
+
+
+void handler(int sig)
+{
+	uint64_t ret;
+
+	asm __volatile__(
+		"li             3,1             ;"
+		"tbegin.                        ;"
+		"beq            1f              ;"
+		"li             3,0             ;"
+		"tsuspend.                      ;"
+		"1:                             ;"
+		"std%X[ret]     3, %[ret]       ;"
+		: [ret]"=m"(ret)
+		:
+		: "memory", "3", "cr0");
+
+	if (ret)
+		exit(1);
+
+	/*
+	 * We return from the signal handle while in a suspended transaction
+	 */
+}
+
+
+int tm_sigreturn(void)
+{
+	struct sigaction sa;
+	uint64_t ret = 0;
+
+	memset(&sa, 0, sizeof(sa));
+	sa.sa_handler = handler;
+	sigemptyset(&sa.sa_mask);
+
+	if (sigaction(SIGSEGV, &sa, NULL))
+		exit(1);
+
+	asm __volatile__(
+		"tbegin.                        ;"
+		"beq            1f              ;"
+		"li             3,0             ;"
+		"std            3,0(3)          ;" /* trigger SEGV */
+		"li             3,1             ;"
+		"std%X[ret]     3,%[ret]        ;"
+		"tend.                          ;"
+		"b              2f              ;"
+		"1:                             ;"
+		"li             3,2             ;"
+		"std%X[ret]     3,%[ret]        ;"
+		"2:                             ;"
+		: [ret]"=m"(ret)
+		:
+		: "memory", "3", "cr0");
+
+	if (ret != 2)
+		exit(1);
+
+	exit(0);
+}
+
+int main(void)
+{
+	return test_harness(tm_sigreturn, "tm_sigreturn");
+}
-- 
2.7.4

Return-Path: <khandual@linux.vnet.ibm.com>
Received: from e28smtp05.in.ibm.com (e28smtp05.in.ibm.com [122.248.162.5])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id D3D961A0C45
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 21 May 2015 16:43:58 +1000 (AEST)
Received: from /spool/local
 by e28smtp05.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <khandual@linux.vnet.ibm.com>;
 Thu, 21 May 2015 12:13:57 +0530
Received: from d28relay03.in.ibm.com (d28relay03.in.ibm.com [9.184.220.60])
 by d28dlp01.in.ibm.com (Postfix) with ESMTP id 4645EE005B
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 21 May 2015 12:16:59 +0530 (IST)
Received: from d28av03.in.ibm.com (d28av03.in.ibm.com [9.184.220.65])
 by d28relay03.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t4L6hrYU57737346
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 21 May 2015 12:13:53 +0530
Received: from d28av03.in.ibm.com (localhost [127.0.0.1])
 by d28av03.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t4L62HH7008416
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 21 May 2015 11:32:17 +0530
From: Anshuman Khandual <khandual@linux.vnet.ibm.com>
To: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Cc: mikey@neuling.org, anton@samba.org, shuahkh@osg.samsung.com,
 mpe@ellerman.id.au
Subject: [PATCH V5 09/13] selftests,
 powerpc: Add test for DSCR value inheritence across fork
Date: Thu, 21 May 2015 12:13:09 +0530
Message-Id: <1432190593-17253-10-git-send-email-khandual@linux.vnet.ibm.com>
In-Reply-To: <1432190593-17253-1-git-send-email-khandual@linux.vnet.ibm.com>
References: <1432190593-17253-1-git-send-email-khandual@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This patch adds a test to verify that the changed DSCR value inside
any process would be inherited to it's child process across the fork
system call.

Acked-by: Shuah Khan <shuahkh@osg.samsung.com>
Signed-off-by: Anshuman Khandual <khandual@linux.vnet.ibm.com>
Signed-off-by: Anton Blanchard <anton@samba.org>
---
 tools/testing/selftests/powerpc/dscr/Makefile      |  3 +-
 .../selftests/powerpc/dscr/dscr_inherit_test.c     | 96 ++++++++++++++++++++++
 2 files changed, 98 insertions(+), 1 deletion(-)
 create mode 100644 tools/testing/selftests/powerpc/dscr/dscr_inherit_test.c

diff --git a/tools/testing/selftests/powerpc/dscr/Makefile b/tools/testing/selftests/powerpc/dscr/Makefile
index ae865d8..81239e2 100644
--- a/tools/testing/selftests/powerpc/dscr/Makefile
+++ b/tools/testing/selftests/powerpc/dscr/Makefile
@@ -1,4 +1,5 @@
-PROGS := dscr_default_test dscr_explicit_test dscr_user_test
+PROGS := dscr_default_test dscr_explicit_test dscr_user_test	\
+	 dscr_inherit_test
 
 CFLAGS := $(CFLAGS) -lpthread
 
diff --git a/tools/testing/selftests/powerpc/dscr/dscr_inherit_test.c b/tools/testing/selftests/powerpc/dscr/dscr_inherit_test.c
new file mode 100644
index 0000000..9d0ca37
--- /dev/null
+++ b/tools/testing/selftests/powerpc/dscr/dscr_inherit_test.c
@@ -0,0 +1,96 @@
+/*
+ * POWER Data Stream Control Register (DSCR) fork test
+ *
+ * This testcase modifies the DSCR using mtspr, forks and then
+ * verifies that the child process has the correct changed DSCR
+ * value using mfspr.
+ *
+ * When using the privilege state SPR, the instructions such as
+ * mfspr or mtspr are priviledged and the kernel emulates them
+ * for us. Instructions using problem state SPR can be exuecuted
+ * directly without any emulation if the HW supports them. Else
+ * they also get emulated by the kernel.
+ *
+ * Copyright (C) 2012 Anton Blanchard <anton@au.ibm.com>, IBM
+ * Copyright (C) 2015 Anshuman Khandual <khandual@linux.vnet.ibm.com>, IBM
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version
+ * 2 of the License, or (at your option) any later version.
+ */
+#include "dscr.h"
+
+int dscr_inherit(void)
+{
+	unsigned long i, dscr = 0;
+	pid_t pid;
+
+	srand(getpid());
+	set_dscr(dscr);
+
+	for (i = 0; i < COUNT; i++) {
+		unsigned long cur_dscr, cur_dscr_usr;
+
+		dscr++;
+		if (dscr > DSCR_MAX)
+			dscr = 0;
+
+		if (i % 2 == 0)
+			set_dscr_usr(dscr);
+		else
+			set_dscr(dscr);
+
+		/*
+		 * XXX: Force a context switch out so that DSCR
+		 * current value is copied into the thread struct
+		 * which is required for the child to inherit the
+		 * changed value.
+		 */
+		sleep(1);
+
+		pid = fork();
+		if (pid == -1) {
+			perror("fork() failed");
+			exit(1);
+		} else if (pid) {
+			int status;
+
+			if (waitpid(pid, &status, 0) == -1) {
+				perror("waitpid() failed");
+				exit(1);
+			}
+
+			if (!WIFEXITED(status)) {
+				fprintf(stderr, "Child didn't exit cleanly\n");
+				exit(1);
+			}
+
+			if (WEXITSTATUS(status) != 0) {
+				fprintf(stderr, "Child didn't exit cleanly\n");
+				return 1;
+			}
+		} else {
+			cur_dscr = get_dscr();
+			if (cur_dscr != dscr) {
+				fprintf(stderr, "Kernel DSCR should be %ld "
+					"but is %ld\n", dscr, cur_dscr);
+				exit(1);
+			}
+
+			cur_dscr_usr = get_dscr_usr();
+			if (cur_dscr_usr != dscr) {
+				fprintf(stderr, "User DSCR should be %ld "
+					"but is %ld\n", dscr, cur_dscr_usr);
+				exit(1);
+			}
+			exit(0);
+		}
+	}
+	return 0;
+}
+
+int main(int argc, char *argv[])
+{
+	return test_harness(dscr_inherit, "dscr_inherit_test");
+}
-- 
2.1.0

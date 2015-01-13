Return-Path: <khandual@linux.vnet.ibm.com>
Received: from e23smtp02.au.ibm.com (e23smtp02.au.ibm.com [202.81.31.144])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id CD1161A0BEF
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 13 Jan 2015 21:23:11 +1100 (AEDT)
Received: from /spool/local
 by e23smtp02.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <khandual@linux.vnet.ibm.com>;
 Tue, 13 Jan 2015 20:23:11 +1000
Received: from d23relay08.au.ibm.com (d23relay08.au.ibm.com [9.185.71.33])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id 22C95357804F
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 13 Jan 2015 21:23:08 +1100 (EST)
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay08.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t0DAN8GA44892402
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 13 Jan 2015 21:23:08 +1100
Received: from d23av03.au.ibm.com (localhost [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t0DAN7hi021762
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 13 Jan 2015 21:23:07 +1100
From: Anshuman Khandual <khandual@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH V2 09/12] selftests,
 powerpc: Add test for DSCR value inheritence across fork
Date: Tue, 13 Jan 2015 15:52:37 +0530
Message-Id: <1421144560-15901-10-git-send-email-khandual@linux.vnet.ibm.com>
In-Reply-To: <1421144560-15901-1-git-send-email-khandual@linux.vnet.ibm.com>
References: <1421144560-15901-1-git-send-email-khandual@linux.vnet.ibm.com>
Cc: mikey@neuling.org, shuahkh@osg.samsung.com, anton@samba.org
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

Signed-off-by: Anshuman Khandual <khandual@linux.vnet.ibm.com>
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
index 0000000..f1add77
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
+int test_body(void)
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
+			perror("fork() failed\n");
+			exit(1);
+		} else if (pid) {
+			int status;
+
+			if (waitpid(pid, &status, 0) == -1) {
+				perror("waitpid() failed\n");
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
+	return test_harness(test_body, "dscr_inherit_test");
+}
-- 
1.9.3

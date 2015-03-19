Return-Path: <sam.bobroff@au1.ibm.com>
Received: from e23smtp07.au.ibm.com (e23smtp07.au.ibm.com [202.81.31.140])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 2A24A1A09D4
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 Mar 2015 15:44:50 +1100 (AEDT)
Received: from /spool/local
 by e23smtp07.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <sam.bobroff@au1.ibm.com>;
 Thu, 19 Mar 2015 14:44:49 +1000
Received: from d23relay08.au.ibm.com (d23relay08.au.ibm.com [9.185.71.33])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id 42B8C3578054
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 Mar 2015 15:44:46 +1100 (EST)
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay08.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t2J4icOH37355602
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 Mar 2015 15:44:46 +1100
Received: from d23av04.au.ibm.com (localhost [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t2J4iC32008548
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 Mar 2015 15:44:12 +1100
From: Sam Bobroff <sam.bobroff@au1.ibm.com>
To: mpe@ellerman.id.au, benh@kernel.crashing.org
Subject: [PATCH 3/3] selftests/powerpc: Add transactional syscall test
Date: Thu, 19 Mar 2015 15:43:48 +1100
Message-Id: <b4a4ea23b20098512cf350b97ce98e0d1ea58531.1426740212.git.sam.bobroff@au1.ibm.com>
In-Reply-To: <cover.1426740212.git.sam.bobroff@au1.ibm.com>
References: <cover.1426740212.git.sam.bobroff@au1.ibm.com>
In-Reply-To: <cover.1426740212.git.sam.bobroff@au1.ibm.com>
References: <cover.1426740212.git.sam.bobroff@au1.ibm.com>
Cc: mikey@neuling.org, azanella@linux.vnet.ibm.com,
 linuxppc-dev@lists.ozlabs.org, matt@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Check that a syscall made during an active transaction will fail with
the correct failure code and that one made during a suspended
transaction will succeed.

Signed-off-by: Sam Bobroff <sam.bobroff@au1.ibm.com>
---
 tools/testing/selftests/powerpc/tm/Makefile     |    3 +-
 tools/testing/selftests/powerpc/tm/tm-syscall.c |  113 +++++++++++++++++++++++
 2 files changed, 115 insertions(+), 1 deletion(-)
 create mode 100644 tools/testing/selftests/powerpc/tm/tm-syscall.c

diff --git a/tools/testing/selftests/powerpc/tm/Makefile b/tools/testing/selftests/powerpc/tm/Makefile
index 2cede23..d8dab0d 100644
--- a/tools/testing/selftests/powerpc/tm/Makefile
+++ b/tools/testing/selftests/powerpc/tm/Makefile
@@ -1,4 +1,5 @@
-PROGS := tm-resched-dscr
+PROGS := tm-resched-dscr tm-syscall
+CFLAGS:=$(CFLAGS) -mhtm -Wl,-z,now
 
 all: $(PROGS)
 
diff --git a/tools/testing/selftests/powerpc/tm/tm-syscall.c b/tools/testing/selftests/powerpc/tm/tm-syscall.c
new file mode 100644
index 0000000..7c60e53
--- /dev/null
+++ b/tools/testing/selftests/powerpc/tm/tm-syscall.c
@@ -0,0 +1,113 @@
+/* Test the kernel's system call code to ensure that a system call
+ * made from within an active HTM transaction is aborted with the
+ * correct failure code.
+ * Conversely, ensure that a system call made from within a
+ * suspended transaction can succeed.
+ *
+ * It is important to compile with -Wl,-z,now to prevent
+ * lazy symbol resolution from affecting the results.
+ */
+
+#include <stdio.h>
+#include <unistd.h>
+#include <asm/tm.h>
+#include <asm/cputable.h>
+#include <linux/auxvec.h>
+
+#include "utils.h"
+
+#define TM_RETRIES 10
+#define TM_TEST_RUNS 1000
+
+int t_failure_persistent(void)
+{
+	long texasr = __builtin_get_texasr();
+	long failure_code = (texasr >> 56) & 0xff;
+
+	return failure_code & TM_CAUSE_PERSISTENT;
+}
+
+int t_failure_code_syscall(void)
+{
+	long texasr = __builtin_get_texasr();
+	long failure_code = (texasr >> 56) & 0xff;
+
+	return (failure_code & TM_CAUSE_SYSCALL) == TM_CAUSE_SYSCALL;
+}
+
+int t_active_getppid(void)
+{
+	int i;
+
+	for (i = 0; i < TM_RETRIES; i++) {
+		if (__builtin_tbegin(0)) {
+			getppid();
+			__builtin_tend(0);
+			return 1;
+		}
+		if (t_failure_persistent())
+			return 0;
+	}
+	return 0;
+}
+
+int t_active_getppid_test(void)
+{
+	int i;
+
+	for (i = 0; i < TM_TEST_RUNS; i++) {
+		if (t_active_getppid())
+			return 0;
+		if (!t_failure_persistent())
+			return 0;
+		if (!t_failure_code_syscall())
+			return 0;
+	}
+	return 1;
+}
+
+int t_suspended_getppid(void)
+{
+	int i;
+
+	for (i = 0; i < TM_RETRIES; i++) {
+		if (__builtin_tbegin(0)) {
+			__builtin_tsuspend();
+			getppid();
+			__builtin_tresume();
+			__builtin_tend(0);
+			return 1;
+		}
+		if (t_failure_persistent())
+			return 0;
+	}
+	return 0;
+}
+
+int t_suspended_getppid_test(void)
+{
+	int i;
+
+	for (i = 0; i < TM_TEST_RUNS; i++) {
+		if (!t_suspended_getppid())
+			return 0;
+	}
+	return 1;
+}
+
+int tm_syscall(void)
+{
+	SKIP_IF(!((long)get_auxv_entry(AT_HWCAP2) & PPC_FEATURE2_HTM));
+	setbuf(stdout, 0);
+	FAIL_IF(!t_active_getppid_test());
+	printf("%d active transactions correctly aborted.\n", TM_TEST_RUNS);
+	FAIL_IF(!t_suspended_getppid_test());
+	printf("%d suspended transactions succeeded.\n", TM_TEST_RUNS);
+	return 0;
+}
+
+int main(void)
+{
+	return test_harness(tm_syscall, "tm_syscall");
+}
+
-- 
1.7.10.4

Return-Path: <sam.bobroff@au1.ibm.com>
Received: from e23smtp02.au.ibm.com (e23smtp02.au.ibm.com [202.81.31.144])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 063391A056E
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  7 Apr 2015 10:55:53 +1000 (AEST)
Received: from /spool/local
 by e23smtp02.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <sam.bobroff@au1.ibm.com>;
 Tue, 7 Apr 2015 10:55:52 +1000
Received: from d23relay09.au.ibm.com (d23relay09.au.ibm.com [9.185.63.181])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id 49826357804C
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  7 Apr 2015 10:55:48 +1000 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay09.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t370tdee44368000
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 7 Apr 2015 10:55:48 +1000
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t370tEOW004295
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 7 Apr 2015 10:55:14 +1000
From: Sam Bobroff <sam.bobroff@au1.ibm.com>
To: mpe@ellerman.id.au, benh@kernel.crashing.org
Subject: [PATCH v3 3/4] selftests/powerpc: Add transactional syscall test
Date: Tue,  7 Apr 2015 10:54:49 +1000
Message-Id: <63fbf360a62f6a9fa544e07501b069f0ff4e74a3.1428368031.git.sam.bobroff@au1.ibm.com>
In-Reply-To: <cover.1428368031.git.sam.bobroff@au1.ibm.com>
References: <cover.1428368031.git.sam.bobroff@au1.ibm.com>
In-Reply-To: <cover.1428368031.git.sam.bobroff@au1.ibm.com>
References: <cover.1428368031.git.sam.bobroff@au1.ibm.com>
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
v2:

Further testing has shown that the success or failure of the transactions was
affected by minor changes to the code, compiler optimisation and linker
settings.

To address this, I've moved the transactional part of the test to a separate
function, written in assembly. I've also extended the test to as many
transactions as it can fit into ten seconds, to better test for failures that
occur more rarely. This has stabilised the results, and it's no longer
necessary to use special compiler or linker flags.

 tools/testing/selftests/powerpc/tm/.gitignore      |    1 +
 tools/testing/selftests/powerpc/tm/Makefile        |    4 +-
 .../testing/selftests/powerpc/tm/tm-syscall-asm.S  |   27 +++++
 .../testing/selftests/powerpc/tm/tm-syscall-asm.h  |    2 +
 tools/testing/selftests/powerpc/tm/tm-syscall.c    |  109 ++++++++++++++++++++
 5 files changed, 142 insertions(+), 1 deletion(-)
 create mode 100644 tools/testing/selftests/powerpc/tm/tm-syscall-asm.S
 create mode 100644 tools/testing/selftests/powerpc/tm/tm-syscall-asm.h
 create mode 100644 tools/testing/selftests/powerpc/tm/tm-syscall.c

diff --git a/tools/testing/selftests/powerpc/tm/.gitignore b/tools/testing/selftests/powerpc/tm/.gitignore
index 33d02cc..2699635d 100644
--- a/tools/testing/selftests/powerpc/tm/.gitignore
+++ b/tools/testing/selftests/powerpc/tm/.gitignore
@@ -1 +1,2 @@
 tm-resched-dscr
+tm-syscall
diff --git a/tools/testing/selftests/powerpc/tm/Makefile b/tools/testing/selftests/powerpc/tm/Makefile
index 2cede23..93bbff3 100644
--- a/tools/testing/selftests/powerpc/tm/Makefile
+++ b/tools/testing/selftests/powerpc/tm/Makefile
@@ -1,8 +1,10 @@
-PROGS := tm-resched-dscr
+PROGS := tm-resched-dscr tm-syscall
+CFLAGS:=$(CFLAGS) -mhtm
 
 all: $(PROGS)
 
 $(PROGS): ../harness.c
+tm-syscall: tm-syscall-asm.S
 
 run_tests: all
 	@-for PROG in $(PROGS); do \
diff --git a/tools/testing/selftests/powerpc/tm/tm-syscall-asm.S b/tools/testing/selftests/powerpc/tm/tm-syscall-asm.S
new file mode 100644
index 0000000..2b2daa7
--- /dev/null
+++ b/tools/testing/selftests/powerpc/tm/tm-syscall-asm.S
@@ -0,0 +1,27 @@
+#include <ppc-asm.h>
+#include <asm/unistd.h>
+
+	.text
+FUNC_START(getppid_tm_active_impl)
+	tbegin.
+	beq 1f
+	li	r0, __NR_getppid
+	sc
+	tend.
+	blr
+1:
+	li	r3, -1
+	blr
+
+FUNC_START(getppid_tm_suspended_impl)
+	tbegin.
+	beq 1f
+	li	r0, __NR_getppid
+	tsuspend.
+	sc
+	tresume.
+	tend.
+	blr
+1:
+	li	r3, -1
+	blr
diff --git a/tools/testing/selftests/powerpc/tm/tm-syscall-asm.h b/tools/testing/selftests/powerpc/tm/tm-syscall-asm.h
new file mode 100644
index 0000000..6136328
--- /dev/null
+++ b/tools/testing/selftests/powerpc/tm/tm-syscall-asm.h
@@ -0,0 +1,2 @@
+extern int getppid_tm_active_impl(void);
+extern int getppid_tm_suspended_impl(void);
diff --git a/tools/testing/selftests/powerpc/tm/tm-syscall.c b/tools/testing/selftests/powerpc/tm/tm-syscall.c
new file mode 100644
index 0000000..ff3b15c
--- /dev/null
+++ b/tools/testing/selftests/powerpc/tm/tm-syscall.c
@@ -0,0 +1,109 @@
+/* Test the kernel's system call code to ensure that a system call
+ * made from within an active HTM transaction is aborted with the
+ * correct failure code.
+ * Conversely, ensure that a system call made from within a
+ * suspended transaction can succeed.
+ */
+
+#include <stdio.h>
+#include <unistd.h>
+#include <sys/syscall.h>
+#include <asm/tm.h>
+#include <asm/cputable.h>
+#include <linux/auxvec.h>
+#include <sys/time.h>
+#include <stdlib.h>
+
+#include "utils.h"
+#include "tm-syscall-asm.h"
+
+unsigned retries = 0;
+
+#define TEST_DURATION 10 /* seconds */
+#define TM_RETRIES 100
+
+long failure_code(void)
+{
+	return __builtin_get_texasr() >> 56;
+}
+
+bool failure_is_persistent(void)
+{
+	return (failure_code() & TM_CAUSE_PERSISTENT) == TM_CAUSE_PERSISTENT;
+}
+
+bool failure_is_syscall(void)
+{
+	return (failure_code() & TM_CAUSE_SYSCALL) == TM_CAUSE_SYSCALL;
+}
+
+pid_t getppid_tm(bool suspend)
+{
+	int i;
+	pid_t pid;
+
+	for (i = 0; i < TM_RETRIES; i++) {
+		if (suspend)
+			pid = getppid_tm_suspended_impl();
+		else
+			pid = getppid_tm_active_impl();
+		if (pid >= 0)
+			return pid;
+		if (failure_is_persistent()) {
+			if (failure_is_syscall())
+				return -1;
+			printf("Unexpected persistent transaction failure.\n");
+			printf("TEXASR 0x%016lx, TFIAR 0x%016lx.\n",
+			       __builtin_get_texasr(), __builtin_get_tfiar());
+			exit(-1);
+		}
+		retries++;
+	}
+	printf("Exceeded limit of %d temporary transaction failures.\n",
+	       TM_RETRIES);
+	printf("TEXASR 0x%016lx, TFIAR 0x%016lx.\n",
+	       __builtin_get_texasr(), __builtin_get_tfiar());
+	exit(-1);
+}
+
+int tm_syscall(void)
+{
+	unsigned count = 0;
+	struct timeval end, now;
+
+	SKIP_IF(!((long)get_auxv_entry(AT_HWCAP2) & PPC_FEATURE2_HTM));
+	setbuf(stdout, 0);
+
+	printf("Testing transactional syscalls for %d seconds...\n",
+	       TEST_DURATION);
+
+	gettimeofday(&end, 0);
+	now.tv_sec = TEST_DURATION;
+	now.tv_usec = 0;
+	timeradd(&end, &now, &end);
+
+	for (count = 0; timercmp(&now, &end, <); count++) {
+		/* Test a syscall within a suspended transaction and verify
+		 * that it succeeds.
+		 */
+		FAIL_IF(getppid_tm(true) == -1); /* Should succeed. */
+
+		/* Test a syscall within an active transaction and verify that
+		 * it fails with the correct failure code.
+		 */
+		FAIL_IF(getppid_tm(false) != -1); /* Should fail... */
+		FAIL_IF(!failure_is_persistent()); /* ...persistently... */
+		FAIL_IF(!failure_is_syscall()); /* ...with code syscall. */
+		gettimeofday(&now, 0);
+	}
+	printf("%d active and suspended transactions behaved correctly.\n",
+	       count);
+	printf("(There were %d transaction retries.)\n", retries);
+
+	return 0;
+}
+
+int main(void)
+{
+	return test_harness(tm_syscall, "tm_syscall");
+}
-- 
1.7.10.4

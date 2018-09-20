Return-Path: <leitao@debian.org>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42GMzP1L9wzF3Mw
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 21 Sep 2018 02:45:20 +1000 (AEST)
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w8KGfUx7057569
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 Sep 2018 12:45:17 -0400
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.149])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2mmf9m84sd-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 Sep 2018 12:45:16 -0400
Received: from localhost
 by e31.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <leitao@debian.org>;
 Thu, 20 Sep 2018 10:45:16 -0600
From: Breno Leitao <leitao@debian.org>
To: linuxppc-dev@lists.ozlabs.org
Cc: Breno Leitao <leitao@debian.org>
Subject: [PATCH 3/3] selftests/powerpc: New PTRACE_SYSEMU test
Date: Thu, 20 Sep 2018 13:45:07 -0300
In-Reply-To: <1537461907-32003-1-git-send-email-leitao@debian.org>
References: <1537461907-32003-1-git-send-email-leitao@debian.org>
Message-Id: <1537461907-32003-3-git-send-email-leitao@debian.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This patch adds a new test for the new PTRACE_SYSEMU ptrace request.

This test also relies on PTRACE_GETREGS and PTRACE_SETREGS requests to
run properly, since the trace instruction (gettid() syscall) is being
modified at run-time (by PTRACE_SETREGS) and re-executed three times.
PTRACE_GETREGS is being used to check that the registers are still
sane.

This test basically creates a child process that executes syscalls
and the parent process check if it is being traced appropriately.  The
parent process guarantees that the SYSCALLs are being traced, with
PTRACE_SYSEMU, and ptrace stops the child application before a syscall is
executed. The way the tests validates it, is by guaranteeing that the
system calls arguments, as argv[0] (r3) which is the same register that
will have the syscall return value on powerpc, are not being corrupted on
PTRACE_SYSEMU with a return value, i.e, it continues to have the current
arguments instead, meaning that the registers where not clobbered.

This test is basically the same test for x86 located at
tools/testing/selftests/x86/ptrace_syscall.c, limited to test PTRACE_SYSEMU
request, and ported to PowerPC.

Signed-off-by: Breno Leitao <leitao@debian.org>
---
 .../testing/selftests/powerpc/ptrace/Makefile |   2 +-
 .../selftests/powerpc/ptrace/ptrace-syscall.c | 228 ++++++++++++++++++
 2 files changed, 229 insertions(+), 1 deletion(-)
 create mode 100644 tools/testing/selftests/powerpc/ptrace/ptrace-syscall.c

diff --git a/tools/testing/selftests/powerpc/ptrace/Makefile b/tools/testing/selftests/powerpc/ptrace/Makefile
index 28f5b781a553..1ee59978508d 100644
--- a/tools/testing/selftests/powerpc/ptrace/Makefile
+++ b/tools/testing/selftests/powerpc/ptrace/Makefile
@@ -2,7 +2,7 @@
 TEST_PROGS := ptrace-gpr ptrace-tm-gpr ptrace-tm-spd-gpr \
               ptrace-tar ptrace-tm-tar ptrace-tm-spd-tar ptrace-vsx ptrace-tm-vsx \
               ptrace-tm-spd-vsx ptrace-tm-spr ptrace-hwbreak ptrace-pkey core-pkey \
-              perf-hwbreak
+              perf-hwbreak ptrace-syscall
 
 include ../../lib.mk
 
diff --git a/tools/testing/selftests/powerpc/ptrace/ptrace-syscall.c b/tools/testing/selftests/powerpc/ptrace/ptrace-syscall.c
new file mode 100644
index 000000000000..3353210dcdbd
--- /dev/null
+++ b/tools/testing/selftests/powerpc/ptrace/ptrace-syscall.c
@@ -0,0 +1,228 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * A ptrace test for testing PTRACE_SYSEMU, PTRACE_SETREGS and
+ * PTRACE_GETREG.  This test basically create a child process that executes
+ * syscalls and the parent process check if it is being traced appropriated.
+ *
+ * This test is heavily based on tools/testing/selftests/x86/ptrace_syscall.c
+ * test, and it was adapted to run on Powerpc by
+ * Breno Leitao <leitao@debian.org>
+ */
+#define _GNU_SOURCE
+
+#include <sys/ptrace.h>
+#include <sys/types.h>
+#include <sys/wait.h>
+#include <sys/syscall.h>
+#include <sys/user.h>
+#include <unistd.h>
+#include <errno.h>
+#include <stddef.h>
+#include <stdio.h>
+#include <err.h>
+#include <string.h>
+#include <sys/auxv.h>
+#include "utils.h"
+
+/* Bitness-agnostic defines for user_regs_struct fields. */
+#define user_syscall_nr	gpr[0]
+#define user_arg0		gpr[3]
+#define user_arg1		gpr[4]
+#define user_arg2		gpr[5]
+#define user_arg3		gpr[6]
+#define user_arg4		gpr[7]
+#define user_arg5		gpr[8]
+#define user_ip		nip
+
+#define PTRACE_SYSEMU		0x1d
+
+static int nerrs;
+
+static void wait_trap(pid_t chld)
+{
+	siginfo_t si;
+
+	if (waitid(P_PID, chld, &si, WEXITED|WSTOPPED) != 0)
+		err(1, "waitid");
+	if (si.si_pid != chld)
+		errx(1, "got unexpected pid in event\n");
+	if (si.si_code != CLD_TRAPPED)
+		errx(1, "got unexpected event type %d\n", si.si_code);
+}
+
+static void test_ptrace_syscall_restart(void)
+{
+	int status;
+	struct pt_regs regs;
+	pid_t chld;
+
+	printf("[RUN]\tptrace-induced syscall restart\n");
+
+	chld = fork();
+	if (chld < 0)
+		err(1, "fork");
+
+	/*
+	 * Child process is running 4 syscalls after ptrace.
+	 *
+	 * 1) getpid()
+	 * 2) gettid()
+	 * 3) tgkill() -> Send SIGSTOP
+	 * 4) gettid() -> Where the tests will happen essentially
+	 */
+	if (chld == 0) {
+		if (ptrace(PTRACE_TRACEME, 0, 0, 0) != 0)
+			err(1, "PTRACE_TRACEME");
+
+		pid_t pid = getpid(), tid = syscall(SYS_gettid);
+
+		printf("\tChild will make one syscall\n");
+		syscall(SYS_tgkill, pid, tid, SIGSTOP);
+
+		syscall(SYS_gettid, 10, 11, 12, 13, 14, 15);
+		_exit(0);
+	}
+	/* Parent process below */
+
+	/* Wait for SIGSTOP sent by tgkill above. */
+	if (waitpid(chld, &status, 0) != chld || !WIFSTOPPED(status))
+		err(1, "waitpid");
+
+	printf("[RUN]\tSYSEMU\n");
+	if (ptrace(PTRACE_SYSEMU, chld, 0, 0) != 0)
+		err(1, "PTRACE_SYSEMU");
+	wait_trap(chld);
+
+	if (ptrace(PTRACE_GETREGS, chld, 0, &regs) != 0)
+		err(1, "PTRACE_GETREGS");
+
+	/*
+	 * Ptrace trapped prior to executing the syscall, thus r3 still has
+	 * the syscall number instead of the sys_gettid() result
+	 */
+	if (regs.user_syscall_nr != SYS_gettid ||
+	    regs.user_arg0 != 10 || regs.user_arg1 != 11 ||
+	    regs.user_arg2 != 12 || regs.user_arg3 != 13 ||
+	    regs.user_arg4 != 14 || regs.user_arg5 != 15) {
+		printf("[FAIL]\tInitial args are wrong (nr=%lu, args=%lu %lu %lu %lu %lu %lu)\n",
+			(unsigned long)regs.user_syscall_nr,
+			(unsigned long)regs.user_arg0,
+			(unsigned long)regs.user_arg1,
+			(unsigned long)regs.user_arg2,
+			(unsigned long)regs.user_arg3,
+			(unsigned long)regs.user_arg4,
+			(unsigned long)regs.user_arg5);
+		 nerrs++;
+	} else {
+		printf("[OK]\tInitial nr and args are correct\n"); }
+
+	printf("[RUN]\tRestart the syscall (ip = 0x%lx)\n",
+	       (unsigned long)regs.user_ip);
+
+	/*
+	 * Rewind to retry the same syscall again. This will basically test
+	 * the rewind process together with PTRACE_SETREGS and PTRACE_GETREGS.
+	 */
+	regs.user_ip -= 4;
+	if (ptrace(PTRACE_SETREGS, chld, 0, &regs) != 0)
+		err(1, "PTRACE_SETREGS");
+
+	if (ptrace(PTRACE_SYSEMU, chld, 0, 0) != 0)
+		err(1, "PTRACE_SYSEMU");
+	wait_trap(chld);
+
+	if (ptrace(PTRACE_GETREGS, chld, 0, &regs) != 0)
+		err(1, "PTRACE_GETREGS");
+
+	if (regs.user_syscall_nr != SYS_gettid ||
+	    regs.user_arg0 != 10 || regs.user_arg1 != 11 ||
+	    regs.user_arg2 != 12 || regs.user_arg3 != 13 ||
+	    regs.user_arg4 != 14 || regs.user_arg5 != 15) {
+		printf("[FAIL]\tRestart nr or args are wrong (nr=%lu, args=%lu %lu %lu %lu %lu %lu)\n",
+			(unsigned long)regs.user_syscall_nr,
+			(unsigned long)regs.user_arg0,
+			(unsigned long)regs.user_arg1,
+			(unsigned long)regs.user_arg2,
+			(unsigned long)regs.user_arg3,
+			(unsigned long)regs.user_arg4,
+			(unsigned long)regs.user_arg5);
+		nerrs++;
+	} else {
+		printf("[OK]\tRestarted nr and args are correct\n");
+	}
+
+	printf("[RUN]\tChange nr and args and restart the syscall (ip = 0x%lx)\n",
+	       (unsigned long)regs.user_ip);
+
+	/*
+	 * Inject a new syscall (getpid) in the same place the previous
+	 * syscall (gettid), rewind and re-execute.
+	 */
+	regs.user_syscall_nr = SYS_getpid;
+	regs.user_arg0 = 20;
+	regs.user_arg1 = 21;
+	regs.user_arg2 = 22;
+	regs.user_arg3 = 23;
+	regs.user_arg4 = 24;
+	regs.user_arg5 = 25;
+	regs.user_ip -= 4;
+
+	if (ptrace(PTRACE_SETREGS, chld, 0, &regs) != 0)
+		err(1, "PTRACE_SETREGS");
+
+	if (ptrace(PTRACE_SYSEMU, chld, 0, 0) != 0)
+		err(1, "PTRACE_SYSEMU");
+	wait_trap(chld);
+
+	if (ptrace(PTRACE_GETREGS, chld, 0, &regs) != 0)
+		err(1, "PTRACE_GETREGS");
+
+	/* Check that ptrace stopped at the new syscall that was
+	 * injected, and guarantee that it haven't executed, i.e, user_args
+	 * contain the arguments and not the syscall return value, for
+	 * instance.
+	 */
+	if (regs.user_syscall_nr != SYS_getpid
+		|| regs.user_arg0 != 20 || regs.user_arg1 != 21
+		|| regs.user_arg2 != 22 || regs.user_arg3 != 23
+		|| regs.user_arg4 != 24 || regs.user_arg5 != 25) {
+
+		printf("[FAIL]\tRestart nr or args are wrong (nr=%lu, args=%lu %lu %lu %lu %lu %lu)\n",
+			(unsigned long)regs.user_syscall_nr,
+			(unsigned long)regs.user_arg0,
+			(unsigned long)regs.user_arg1,
+			(unsigned long)regs.user_arg2,
+			(unsigned long)regs.user_arg3,
+			(unsigned long)regs.user_arg4,
+			(unsigned long)regs.user_arg5);
+		nerrs++;
+	} else {
+		printf("[OK]\tReplacement nr and args are correct\n");
+	}
+
+	if (ptrace(PTRACE_CONT, chld, 0, 0) != 0)
+		err(1, "PTRACE_CONT");
+
+	if (waitpid(chld, &status, 0) != chld)
+		err(1, "waitpid");
+
+	/* Guarantee that the process executed properly, returning 0 */
+	if (!WIFEXITED(status) || WEXITSTATUS(status) != 0) {
+		printf("[FAIL]\tChild failed\n");
+		nerrs++;
+	} else {
+		printf("[OK]\tChild exited cleanly\n");
+	}
+}
+
+int ptrace_syscall(void)
+{
+	test_ptrace_syscall_restart();
+
+	return nerrs;
+}
+
+int main(void)
+{
+	return test_harness(ptrace_syscall, "ptrace_syscall");
+}
-- 
2.19.0

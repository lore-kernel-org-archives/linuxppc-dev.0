Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 70D8B1A2ECA
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 15 Jul 2015 17:37:29 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: <linuxppc-dev@ozlabs.org>
Cc: <linux-kernel@vger.kernel.org>, keescook@chromium.org, luto@amacapital.net,
 wad@chromium.org, strosake@linux.vnet.ibm.com,
 bogdan.purcareata@freescale.com
Subject: [RFC PATCH 12/12] selftests/seccomp: Add powerpc support
Date: Wed, 15 Jul 2015 17:37:14 +1000
Message-Id: <1436945834-26660-12-git-send-email-mpe@ellerman.id.au>
In-Reply-To: <1436945834-26660-1-git-send-email-mpe@ellerman.id.au>
References: <1436945834-26660-1-git-send-email-mpe@ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Wire up the syscall number and regs so the tests work on powerpc.

Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 tools/testing/selftests/seccomp/seccomp_bpf.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/seccomp/seccomp_bpf.c b/tools/testing/selftests/seccomp/seccomp_bpf.c
index 51adb9afb511..05fcdb974df6 100644
--- a/tools/testing/selftests/seccomp/seccomp_bpf.c
+++ b/tools/testing/selftests/seccomp/seccomp_bpf.c
@@ -14,6 +14,7 @@
 #include <linux/filter.h>
 #include <sys/prctl.h>
 #include <sys/ptrace.h>
+#include <sys/types.h>
 #include <sys/user.h>
 #include <linux/prctl.h>
 #include <linux/ptrace.h>
@@ -1209,6 +1210,10 @@ TEST_F(TRACE_poke, getpid_runs_normally)
 # define ARCH_REGS	struct user_pt_regs
 # define SYSCALL_NUM	regs[8]
 # define SYSCALL_RET	regs[0]
+#elif defined(__powerpc__)
+# define ARCH_REGS	struct pt_regs
+# define SYSCALL_NUM	gpr[0]
+# define SYSCALL_RET	gpr[3]
 #else
 # error "Do not know how to find your architecture's registers and syscalls"
 #endif
@@ -1242,7 +1247,7 @@ void change_syscall(struct __test_metadata *_metadata,
 	ret = ptrace(PTRACE_GETREGSET, tracee, NT_PRSTATUS, &iov);
 	EXPECT_EQ(0, ret);
 
-#if defined(__x86_64__) || defined(__i386__) || defined(__aarch64__)
+#if defined(__x86_64__) || defined(__i386__) || defined(__aarch64__) || defined(__powerpc__)
 	{
 		regs.SYSCALL_NUM = syscall;
 	}
@@ -1406,6 +1411,8 @@ TEST_F(TRACE_syscall, syscall_dropped)
 #  define __NR_seccomp 383
 # elif defined(__aarch64__)
 #  define __NR_seccomp 277
+# elif defined(__powerpc__)
+#  define __NR_seccomp 358
 # else
 #  warning "seccomp syscall number unknown for this architecture"
 #  define __NR_seccomp 0xffff
-- 
2.1.0

Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFE8D606A8AF
	for <linuxppc-dev@archiver.kernel.org>; Fri, 13 Nov 2026 16:55:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cs.unibo.it header.i=@cs.unibo.it header.a=rsa-sha256 header.s=virtlab header.b=FBN+HTti
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jR3KW6TnQz2xnn;
	Sat, 14 Nov 2026 03:55:27 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=130.136.161.50
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1794588927;
	cv=none; b=EpOu7/vPilfYrQVyj2H3IyRq/JKtzL20spy3YaI2KysUPyUvzh9aY9072AT0hYS+v/2QOkaQWsV8t/PS6bzLVgV7At/AlqgvadT1DsLcawMwwVERh1wp7mRYTpwxx6o4qIWxRXVjMENzXKZ/BKUx+o1hymWOBOOjcb7ZxCbL3hXhSrDxauG9XryZ+zbs+Srg5/N3VlzjObXtQ0jFnxwQTxfLfcHhzq9LMScjHLEKbES3aDCoG+MuodPvfy+qMklOhtd6XmensR7+nYYuTonRFasz9tVJxSjGv2wTLsYxIoxQognLICpFLHLPjF3e/4HNgiH5acEnTXE2e4LTdWJXqw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1794588927; c=relaxed/relaxed;
	bh=8lP419SPnk9bISnyNiCg+XhXZjrC6NfgXVYlaoCpSY8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OmqtESnAd/zmG1yGcuBNO6PHpL5YvcHDg16OAVGhDTsCrJ418ohu/TbIkttXZQaI5Ush0nZOUb9NTQiwfazI5YOLhpfoy22oQRg5A5VMQV4hmwe6d4Y3Q9tq+l3LOvPjgkDf5dDp0skQbYm8VtTdZTMhjKVmiI8Ld7nkJMXITiul3IzaEMG0bRw44INFDRGpqbMj+uCrx/9zy6ADEnEnXoR7egPik5ApYApv8Vf0yl2/2zYXjLsGxeWe0odTMlYemDTsvIi7vjPo2FH2PqR1qqzdVpN0wU85XjyX49WGMO80G3oGYuKyQL7VMevm3Bmkt6xjuyDl8rOURBeqlh4IJA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=cs.unibo.it; dkim=pass (1024-bit key; unprotected) header.d=cs.unibo.it header.i=@cs.unibo.it header.a=rsa-sha256 header.s=virtlab header.b=FBN+HTti; dkim-atps=neutral; spf=pass (client-ip=130.136.161.50; helo=mail.virtlab.unibo.it; envelope-from=renzo@cs.unibo.it; receiver=lists.ozlabs.org) smtp.mailfrom=cs.unibo.it
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=cs.unibo.it
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=cs.unibo.it header.i=@cs.unibo.it header.a=rsa-sha256 header.s=virtlab header.b=FBN+HTti;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=cs.unibo.it (client-ip=130.136.161.50; helo=mail.virtlab.unibo.it; envelope-from=renzo@cs.unibo.it; receiver=lists.ozlabs.org)
Received: from mail.virtlab.unibo.it (mail.virtlab.unibo.it [130.136.161.50])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jR3KS60lyz2xhS
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 14 Nov 2026 03:55:24 +1100 (AEDT)
Received: from eipi10.cs.unibo.it (host0.studiodavoli.it [109.234.61.1])
	by mail.virtlab.unibo.it (Postfix) with ESMTPA id 1AC481C0264;
	Fri, 13 Nov 2026 17:55:23 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=cs.unibo.it;
	s=virtlab; t=1794588923;
	bh=uaxU0e0Lu4aUVtxqhdGDQ6/02ahHZX3ZrV5iXIX1lI4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FBN+HTtiJJn3VMV+lo7U4smas/2r8/E6PZANjJK53x+Cj85k9lnNaCacHRDOeyY2H
	 ACKke8Y9PB43xS/LkzOCPdYk9wiYVEBoOJUKkiO/02tmKDgIbNygHFLupjXhB0LAWX
	 IFnrBMMuDTs//IeEv/EUW6/2MWlJCCqOpllhLQXM=
From: Renzo Davoli <renzo@cs.unibo.it>
To: linux-kernel@vger.kernel.org
Cc: Renzo Davoli <renzo@cs.unibo.it>,
	Oleg Nesterov <oleg@redhat.com>,
	=?UTF-8?q?Michal=20Such=C3=A1nek?= <msuchanek@suse.de>,
	Kees Cook <kees@kernel.org>,
	Andy Lutomirski <luto@amacapital.net>,
	Will Drewry <wad@chromium.org>,
	Thomas Gleixner <tglx@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Shuah Khan <shuah@kernel.org>,
	"Dmitry V . Levin" <ldv@strace.io>,
	Alexey Gladkov <legion@kernel.org>,
	Eugene Syromyatnikov <evgsyr@gmail.com>,
	Davide Berardi <berardi.dav@gmail.com>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	linuxppc-dev@lists.ozlabs.org,
	linux-s390@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	strace-devel@lists.strace.io
Subject: [PATCH v10 3/3] selftests/ptrace: add a test case for PTRACE_SET_SYSCALL_INFO syscall skipping
Date: Fri, 13 Nov 2026 17:55:05 +0100
Message-ID: <20261113165509.229869-4-renzo@cs.unibo.it>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261113165509.229869-1-renzo@cs.unibo.it>
References: <20261113165509.229869-1-renzo@cs.unibo.it>
X-Mailing-List: linuxppc-dev@lists.ozlabs.org
List-Id: <linuxppc-dev.lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev+help@lists.ozlabs.org>
List-Owner: <mailto:linuxppc-dev+owner@lists.ozlabs.org>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Archive: <https://lore.kernel.org/linuxppc-dev/>,
  <https://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Subscribe: <mailto:linuxppc-dev+subscribe@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-digest@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-nomail@lists.ozlabs.org>
Precedence: list
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Check whether PTRACE_SET_SYSCALL_INFO syscall skipping semantics
implemented in the kernel matches userspace expectations.

Signed-off-by: Renzo Davoli <renzo@cs.unibo.it>
[v8: also check an error return value, and that the syscall cannot be
 changed anymore once skipped while its return value still can;
 checkpatch fixes]
Assisted-by: claude-opus-5-5
---
 .../selftests/ptrace/set_syscall_info.c       | 230 +++++++++++++++++-
 1 file changed, 229 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/ptrace/set_syscall_info.c b/tools/testing/selftests/ptrace/set_syscall_info.c
index 1cc411a41cd6..e4fc2779ee5a 100644
--- a/tools/testing/selftests/ptrace/set_syscall_info.c
+++ b/tools/testing/selftests/ptrace/set_syscall_info.c
@@ -11,9 +11,15 @@
 #include <err.h>
 #include <fcntl.h>
 #include <signal.h>
+#include <stdlib.h>
+#include <stddef.h>
 #include <asm/unistd.h>
+#include <sys/prctl.h>
 #include <linux/types.h>
 #include <linux/ptrace.h>
+#include <linux/filter.h>
+#include <linux/seccomp.h>
+#include <linux/prctl.h>
 
 #if defined(_MIPS_SIM) && _MIPS_SIM == _MIPS_SIM_NABI32
 /*
@@ -36,6 +42,7 @@ struct si_exit {
 
 static unsigned int ptrace_stop;
 static pid_t tracee_pid;
+static pid_t tracer_pid;
 
 static int
 kill_tracee(pid_t pid)
@@ -64,6 +71,25 @@ sys_ptrace(int request, pid_t pid, unsigned long addr, unsigned long data)
 		       ptrace_stop, ##__VA_ARGS__);		\
 	} while (0)
 
+static int sys_seccomp(unsigned int operation, unsigned int flags, void *args)
+{
+	return syscall(__NR_seccomp, operation, flags, args);
+}
+
+static struct sock_filter seccomp_filter[] = {
+	BPF_STMT(BPF_LD+BPF_W+BPF_ABS, offsetof(struct seccomp_data, nr)),
+
+	BPF_JUMP(BPF_JMP+BPF_JEQ+BPF_K, __NR_restart_syscall, 0, 1),
+	BPF_STMT(BPF_RET+BPF_K, SECCOMP_RET_ALLOW),
+
+	BPF_STMT(BPF_RET+BPF_K, SECCOMP_RET_TRACE),
+};
+
+static struct sock_fprog seccomp_prog = {
+	.filter = seccomp_filter,
+	.len = ARRAY_SIZE(seccomp_filter)
+};
+
 static void
 check_psi_entry(struct __test_metadata *_metadata,
 		const struct ptrace_syscall_info *info,
@@ -128,7 +154,6 @@ check_psi_exit(struct __test_metadata *_metadata,
 
 TEST(set_syscall_info)
 {
-	const pid_t tracer_pid = getpid();
 	const kernel_ulong_t dummy[] = {
 		(kernel_ulong_t) 0xdad0bef0bad0fed0ULL,
 		(kernel_ulong_t) 0xdad1bef1bad1fed1ULL,
@@ -138,6 +163,7 @@ TEST(set_syscall_info)
 		(kernel_ulong_t) 0xdad5bef5bad5fed5ULL,
 	};
 	int splice_in[2], splice_out[2];
+	tracer_pid = getpid();
 
 	ASSERT_EQ(0, pipe(splice_in));
 	ASSERT_EQ(0, pipe(splice_out));
@@ -516,4 +542,206 @@ TEST(set_syscall_info)
 	ASSERT_EQ(ptrace_stop, ARRAY_SIZE(si) * 2);
 }
 
+TEST(set_syscall_info_seccomp)
+{
+	/*
+	 * Check for seccomp filter support without installing a filter:
+	 * a NULL filter fails with EFAULT if SECCOMP_SET_MODE_FILTER is
+	 * supported, and with EINVAL or ENOSYS otherwise.
+	 */
+	ASSERT_EQ(-1, sys_seccomp(SECCOMP_SET_MODE_FILTER, 0, NULL));
+	if (errno != EFAULT)
+		SKIP(return, "SECCOMP_SET_MODE_FILTER: %m");
+
+	tracer_pid = getpid();
+	tracee_pid = fork();
+
+	ASSERT_LE(0, tracee_pid) {
+		TH_LOG("fork: %m");
+	}
+
+	/* tracee */
+	if (tracee_pid == 0) {
+		tracee_pid = getpid();
+		ASSERT_EQ(0, sys_ptrace(PTRACE_TRACEME, 0, 0, 0)) {
+			TH_LOG("PTRACE_TRACEME: %m");
+		}
+		ASSERT_EQ(0, kill(tracee_pid, SIGSTOP)) {
+			/* cannot happen */
+			TH_LOG("kill SIGSTOP: %m");
+		}
+
+		ASSERT_EQ(0, prctl(PR_SET_NO_NEW_PRIVS, 1, 0, 0, 0)) {
+			TH_LOG("prctl: %m");
+		}
+		ASSERT_EQ(0, sys_seccomp(SECCOMP_SET_MODE_FILTER, 0,
+					(void *) &seccomp_prog)) {
+			TH_LOG("seccomp: %m");
+		}
+
+		/*
+		 * From now on every syscall stops the tracee, so do not use
+		 * ASSERT_*() here: it would write() its message before
+		 * _exit(1) and the tracer would report a syscall nr mismatch
+		 * instead of the test case that failed.
+		 */
+
+		/* run getpid unmodified */
+		if (getpid() != tracee_pid)
+			_exit(1);
+
+		/* run getppid instead of getpid */
+		if (getpid() != tracer_pid)
+			_exit(1);
+
+		/* skip getpid and return 42 */
+		if (getpid() != 42)
+			_exit(1);
+
+		/* skip getpid and fail with ESRCH */
+		errno = 0;
+		if (syscall(__NR_getpid) != -1 || errno != ESRCH)
+			_exit(1);
+
+		_exit(0);
+	}
+
+	int status;
+
+	/* tracer */
+	ASSERT_LE(0, waitpid(-1, &status, 0)) {
+		LOG_KILL_TRACEE("waitpid: %m");
+	}
+
+	ASSERT_EQ(0, sys_ptrace(PTRACE_SETOPTIONS, tracee_pid, 0,
+			(PTRACE_O_TRACESECCOMP | PTRACE_O_TRACESYSGOOD)))
+		LOG_KILL_TRACEE("PTRACE_SETOPTIONS: %m");
+
+	ASSERT_EQ(0, sys_ptrace(PTRACE_CONT, tracee_pid, 0, 0)) {
+		LOG_KILL_TRACEE("PTRACE_CONT: %m");
+	}
+
+	static const char * const testname[] = {
+		"unknown error",
+		"getpid seccomp unchanged",
+		"getpid seccomp nr change: getppid",
+		"getpid seccomp skip+set retvalue",
+		"getpid seccomp skip+set error"
+	};
+
+	static const unsigned int expected_nr[] = {
+		__NR_getpid,
+		__NR_getpid,
+		__NR_getpid,
+		__NR_getpid,
+		__NR_exit_group
+	};
+
+	for (ptrace_stop = 0; ; ++ptrace_stop) {
+		ASSERT_EQ(tracee_pid, wait(&status)) {
+			/* cannot happen */
+			LOG_KILL_TRACEE("wait: %m");
+		}
+
+		if (WIFEXITED(status)) {
+			tracee_pid = 0; /* the tracee is no more */
+			ASSERT_EQ(0, WEXITSTATUS(status)) {
+				LOG_KILL_TRACEE("unexpected exit status %u",
+						WEXITSTATUS(status));
+			}
+			break;
+		}
+		ASSERT_FALSE(WIFSIGNALED(status)) {
+			tracee_pid = 0; /* the tracee is no more */
+			LOG_KILL_TRACEE("unexpected signal %u",
+					WTERMSIG(status));
+		}
+		ASSERT_TRUE(WIFSTOPPED(status)) {
+			LOG_KILL_TRACEE("unexpected wait status %#x", status);
+		}
+
+		ASSERT_EQ(status >> 8, SIGTRAP | (PTRACE_EVENT_SECCOMP << 8)) {
+			LOG_KILL_TRACEE("unexpected stop, wait status %#x", status);
+		}
+
+		struct ptrace_syscall_info info = {
+			.op = 0xff  /* invalid PTRACE_SYSCALL_INFO_* op */
+		};
+		size_t info_size = sizeof(info);
+
+		ASSERT_LT(0, sys_ptrace(PTRACE_GET_SYSCALL_INFO, tracee_pid,
+					info_size, (uintptr_t) &info)) {
+			LOG_KILL_TRACEE("PTRACE_GET_SYSCALL_INFO: %m");
+		}
+		ASSERT_EQ(PTRACE_SYSCALL_INFO_SECCOMP, info.op) {
+			LOG_KILL_TRACEE("entry op mismatch: %m");
+		}
+		ASSERT_TRUE(info.arch) {
+			LOG_KILL_TRACEE("entry arch mismatch: %m");
+		}
+		ASSERT_TRUE(info.instruction_pointer) {
+			LOG_KILL_TRACEE("entry instruction_pointer mismatch: %m");
+		}
+		ASSERT_TRUE(info.stack_pointer) {
+			LOG_KILL_TRACEE("entry stack_pointer mismatch: %m");
+		}
+
+		ASSERT_LT(ptrace_stop, ARRAY_SIZE(expected_nr)) {
+			LOG_KILL_TRACEE("ptrace stop overflow");
+		}
+		ASSERT_FALSE(info.seccomp.nr == __NR_exit_group && info.seccomp.args[0] == 1) {
+			LOG_KILL_TRACEE("tracee error: %s",
+					testname[ptrace_stop]);
+		}
+		ASSERT_EQ(info.seccomp.nr, expected_nr[ptrace_stop]) {
+			LOG_KILL_TRACEE("syscall nr mismatch");
+		}
+		const struct ptrace_syscall_info seccomp_info = info;
+
+		switch (ptrace_stop) {
+		case 0:
+		case 4:
+			break;
+		case 1:
+			info.seccomp.nr = __NR_getppid;
+			break;
+		case 2:
+			info.op = PTRACE_SYSCALL_INFO_EXIT;
+			info.exit.rval = 41;
+			info.exit.is_error = 0;
+			ASSERT_EQ(0, sys_ptrace(PTRACE_SET_SYSCALL_INFO,
+						tracee_pid, info_size,
+						(uintptr_t) &info)) {
+				LOG_KILL_TRACEE("PTRACE_SET_SYSCALL_INFO: %m");
+			}
+			/* the syscall cannot be changed anymore once skipped */
+			ASSERT_EQ(-1, sys_ptrace(PTRACE_SET_SYSCALL_INFO,
+						 tracee_pid, info_size,
+						 (uintptr_t) &seccomp_info)) {
+				LOG_KILL_TRACEE("PTRACE_SET_SYSCALL_INFO after skip succeeded");
+			}
+			ASSERT_EQ(EINVAL, errno) {
+				LOG_KILL_TRACEE("PTRACE_SET_SYSCALL_INFO after skip: %m");
+			}
+			/* but its return value can */
+			info.exit.rval = 42;
+			break;
+		case 3:
+			info.op = PTRACE_SYSCALL_INFO_EXIT;
+			info.exit.rval = -ESRCH;
+			info.exit.is_error = 1;
+			break;
+		}
+
+		ASSERT_EQ(0, sys_ptrace(PTRACE_SET_SYSCALL_INFO, tracee_pid,
+					info_size, (uintptr_t) &info)) {
+			LOG_KILL_TRACEE("PTRACE_SET_SYSCALL_INFO: %m");
+		}
+
+		ASSERT_EQ(0, sys_ptrace(PTRACE_CONT, tracee_pid, 0, 0)) {
+			LOG_KILL_TRACEE("PTRACE_CONT: %m");
+		}
+	}
+}
+
 TEST_HARNESS_MAIN
-- 
2.55.0



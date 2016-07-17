Return-Path: <wei.guo.simon@gmail.com>
Received: from mail-pa0-f67.google.com (mail-pa0-f67.google.com
 [209.85.220.67])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rsV4d1tL1zDqPQ
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 17 Jul 2016 12:05:05 +1000 (AEST)
Received: by mail-pa0-f67.google.com with SMTP id q2so8557850pap.0
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 16 Jul 2016 19:05:05 -0700 (PDT)
From: wei.guo.simon@gmail.com
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Anshuman Khandual <khandual@linux.vnet.ibm.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Shuah Khan <shuahkh@osg.samsung.com>,
 Anton Blanchard <anton@samba.org>, Cyril Bur <cyrilbur@gmail.com>,
 Simon Guo <wei.guo.simon@gmail.com>,
 Ulrich Weigand <ulrich.weigand@de.ibm.com>,
 Michael Neuling <mikey@neuling.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 Kees Cook <keescook@chromium.org>, Rashmica Gupta <rashmicy@gmail.com>,
 Khem Raj <raj.khem@gmail.com>, Jessica Yu <jeyu@redhat.com>,
 Jiri Kosina <jkosina@suse.cz>, Miroslav Benes <mbenes@suse.cz>,
 Suraj Jitindar Singh <sjitindarsingh@gmail.com>,
 Chris Smart <chris@distroguy.com>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: [PATCH v11 25/27] selftests/powerpc: Add ptrace tests for TM SPR
 registers
Date: Sun, 17 Jul 2016 09:59:58 +0800
Message-Id: <1468720800-2950-26-git-send-email-wei.guo.simon@gmail.com>
In-Reply-To: <1468720800-2950-1-git-send-email-wei.guo.simon@gmail.com>
References: <1468720800-2950-1-git-send-email-wei.guo.simon@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Anshuman Khandual <khandual@linux.vnet.ibm.com>

This patch adds ptrace interface test for TM SPR registers. This
also adds ptrace interface based helper functions related to TM
SPR registers access.

Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Paul Mackerras <paulus@samba.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Shuah Khan <shuahkh@osg.samsung.com>
Cc: Anton Blanchard <anton@samba.org>
Cc: Cyril Bur <cyrilbur@gmail.com>
Cc: Anshuman Khandual <khandual@linux.vnet.ibm.com>
Cc: Simon Guo <wei.guo.simon@gmail.com>
Cc: Ulrich Weigand <ulrich.weigand@de.ibm.com>
Cc: Michael Neuling <mikey@neuling.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Kees Cook <keescook@chromium.org>
Cc: Rashmica Gupta <rashmicy@gmail.com>
Cc: Khem Raj <raj.khem@gmail.com>
Cc: Jessica Yu <jeyu@redhat.com>
Cc: Jiri Kosina <jkosina@suse.cz>
Cc: Miroslav Benes <mbenes@suse.cz>
Cc: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
Cc: Chris Smart <chris@distroguy.com>
Cc: linuxppc-dev@lists.ozlabs.org
Cc: linux-kernel@vger.kernel.org
Cc: linux-kselftest@vger.kernel.org
Signed-off-by: Anshuman Khandual <khandual@linux.vnet.ibm.com>
Signed-off-by: Simon Guo <wei.guo.simon@gmail.com>
---
 tools/testing/selftests/powerpc/ptrace/Makefile    |   3 +-
 .../selftests/powerpc/ptrace/ptrace-tm-spr.c       | 175 +++++++++++++++++++++
 tools/testing/selftests/powerpc/ptrace/ptrace.h    |  35 +++++
 3 files changed, 212 insertions(+), 1 deletion(-)
 create mode 100644 tools/testing/selftests/powerpc/ptrace/ptrace-tm-spr.c

diff --git a/tools/testing/selftests/powerpc/ptrace/Makefile b/tools/testing/selftests/powerpc/ptrace/Makefile
index 797840a..f34670e 100644
--- a/tools/testing/selftests/powerpc/ptrace/Makefile
+++ b/tools/testing/selftests/powerpc/ptrace/Makefile
@@ -1,7 +1,8 @@
 TEST_PROGS := ptrace-ebb ptrace-gpr ptrace-tm-gpr ptrace-tm-spd-gpr \
 ptrace-tar ptrace-tm-tar ptrace-tm-spd-tar ptrace-vsx ptrace-tm-vsx \
-ptrace-tm-spd-vsx
+ptrace-tm-spd-vsx ptrace-tm-spr
 
+include ../../lib.mk
 
 all: $(TEST_PROGS)
 CFLAGS += -m64
diff --git a/tools/testing/selftests/powerpc/ptrace/ptrace-tm-spr.c b/tools/testing/selftests/powerpc/ptrace/ptrace-tm-spr.c
new file mode 100644
index 0000000..9d7f37d
--- /dev/null
+++ b/tools/testing/selftests/powerpc/ptrace/ptrace-tm-spr.c
@@ -0,0 +1,175 @@
+/*
+ * Ptrace test TM SPR registers
+ *
+ * Copyright (C) 2015 Anshuman Khandual, IBM Corporation.
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version
+ * 2 of the License, or (at your option) any later version.
+ */
+#include "ptrace.h"
+
+/* Tracee and tracer shared data */
+struct shared {
+	int flag;
+	struct tm_spr_regs regs;
+};
+unsigned long tfhar;
+
+int shm_id;
+volatile struct shared *cptr, *pptr;
+
+int shm_id1;
+volatile int *cptr1, *pptr1;
+
+#define TM_SCHED	0xde0000018c000001
+#define TM_KVM_SCHED	0xe0000001ac000001
+
+int validate_tm_spr(struct tm_spr_regs *regs)
+{
+	if (regs->tm_tfhar != (tfhar - 32))
+		return TEST_FAIL;
+
+	if ((regs->tm_texasr != TM_SCHED) && (regs->tm_texasr != TM_KVM_SCHED))
+		return TEST_FAIL;
+
+	if ((regs->tm_texasr == TM_KVM_SCHED) && (regs->tm_tfiar != 0))
+		return TEST_FAIL;
+
+	return TEST_PASS;
+}
+
+void tm_spr(void)
+{
+	unsigned long result, texasr;
+	int ret;
+
+	cptr = (struct shared *)shmat(shm_id, NULL, 0);
+	cptr1 = (int *)shmat(shm_id1, NULL, 0);
+
+trans:
+	cptr1[0] = 0;
+	asm __volatile__(
+		"1: ;"
+		TBEGIN
+		"beq 2f;"
+
+		TSUSPEND
+		"li 8, 1;"
+		"sth 8, 0(%[cptr1]);"
+		TRESUME
+		"b .;"
+
+		TEND
+		"li 0, 0;"
+		"ori %[res], 0, 0;"
+		"b 3f;"
+
+		"2: ;"
+		"mflr 31;"
+		"bl 4f;"	/* $ = TFHAR + 2 */
+		"4: ;"
+		"mflr %[tfhar];"
+		"mtlr 31;"
+
+		"li 0, 1;"
+		"ori %[res], 0, 0;"
+		"mfspr %[texasr], %[sprn_texasr];"
+
+		"3: ;"
+		: [tfhar] "=r" (tfhar), [res] "=r" (result),
+		[texasr] "=r" (texasr), [cptr1] "=r" (cptr1)
+		: [sprn_texasr] "i"  (SPRN_TEXASR)
+		: "memory", "r0", "r1", "r2", "r3", "r4",
+		"r8", "r9", "r10", "r11", "r31"
+		);
+
+	if (result) {
+		if (!cptr->flag)
+			goto trans;
+
+		ret = validate_tm_spr((struct tm_spr_regs *)&cptr->regs);
+		shmdt((void *)cptr);
+		shmdt((void *)cptr1);
+		if (ret)
+			exit(1);
+		exit(0);
+	}
+	shmdt((void *)cptr);
+	shmdt((void *)cptr1);
+	exit(1);
+}
+
+int trace_tm_spr(pid_t child)
+{
+	int ret;
+
+	ret = start_trace(child);
+	if (ret)
+		return TEST_FAIL;
+
+	ret = show_tm_spr(child, (struct tm_spr_regs *)&pptr->regs);
+	if (ret)
+		return TEST_FAIL;
+
+	printf("TFHAR: %lx TEXASR: %lx TFIAR: %lx\n", pptr->regs.tm_tfhar,
+				pptr->regs.tm_texasr, pptr->regs.tm_tfiar);
+
+	pptr->flag = 1;
+	ret = stop_trace(child);
+	if (ret)
+		return TEST_FAIL;
+
+	return TEST_PASS;
+}
+
+int ptrace_tm_spr(void)
+{
+	pid_t pid;
+	int ret, status;
+
+	SKIP_IF(!((long)get_auxv_entry(AT_HWCAP2) & PPC_FEATURE2_HTM));
+	shm_id = shmget(IPC_PRIVATE, sizeof(struct shared), 0777|IPC_CREAT);
+	shm_id1 = shmget(IPC_PRIVATE, sizeof(int), 0777|IPC_CREAT);
+	pid = fork();
+	if (pid < 0) {
+		perror("fork() failed");
+		return TEST_FAIL;
+	}
+
+	if (pid == 0)
+		tm_spr();
+
+	if (pid) {
+		pptr = (struct shared *)shmat(shm_id, NULL, 0);
+		pptr1 = (int *)shmat(shm_id1, NULL, 0);
+
+		while (!pptr1[0]);
+		ret = trace_tm_spr(pid);
+		if (ret) {
+			kill(pid, SIGKILL);
+			return TEST_FAIL;
+		}
+
+		shmdt((void *)pptr);
+		shmdt((void *)pptr1);
+		ret = wait(&status);
+		if (ret != pid) {
+			printf("Child's exit status not captured\n");
+			return TEST_FAIL;
+		}
+
+		if (WIFEXITED(status)) {
+			if (WEXITSTATUS(status))
+				return TEST_FAIL;
+		}
+		return TEST_PASS;
+	}
+	return TEST_PASS;
+}
+
+int main(int argc, char *argv[])
+{
+	return test_harness(ptrace_tm_spr, "ptrace_tm_spr");
+}
diff --git a/tools/testing/selftests/powerpc/ptrace/ptrace.h b/tools/testing/selftests/powerpc/ptrace/ptrace.h
index 442a9a0..ad9fb2e 100644
--- a/tools/testing/selftests/powerpc/ptrace/ptrace.h
+++ b/tools/testing/selftests/powerpc/ptrace/ptrace.h
@@ -67,6 +67,11 @@ struct fpr_regs {
 	unsigned long fpscr;
 };
 
+struct tm_spr_regs {
+	unsigned long tm_tfhar;
+	unsigned long tm_texasr;
+	unsigned long tm_tfiar;
+};
 
 /* Basic ptrace operations */
 int start_trace(pid_t child)
@@ -680,6 +685,36 @@ int write_vsx_ckpt(pid_t child, unsigned long *vsx)
 	return TEST_PASS;
 }
 
+/* TM SPR */
+int show_tm_spr(pid_t child, struct tm_spr_regs *out)
+{
+	struct tm_spr_regs *regs;
+	struct iovec iov;
+	int ret;
+
+	regs = (struct tm_spr_regs *) malloc(sizeof(struct tm_spr_regs));
+	if (!regs) {
+		perror("malloc() failed");
+		return TEST_FAIL;
+	}
+
+	iov.iov_base = (u64 *) regs;
+	iov.iov_len = sizeof(struct tm_spr_regs);
+
+	ret = ptrace(PTRACE_GETREGSET, child, NT_PPC_TM_SPR, &iov);
+	if (ret) {
+		perror("ptrace(PTRACE_GETREGSET) failed");
+		return TEST_FAIL;
+	}
+
+	if (out)
+		memcpy(out, regs, sizeof(struct tm_spr_regs));
+
+	return TEST_PASS;
+}
+
+
+
 /* Analyse TEXASR after TM failure */
 inline unsigned long get_tfiar(void)
 {
-- 
1.8.3.1

Return-Path: <khandual@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 7B6B51A0671
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 May 2015 01:08:46 +1000 (AEST)
Received: from e28smtp03.in.ibm.com (e28smtp03.in.ibm.com [122.248.162.3])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id A8179140D58
 for <linuxppc-dev@ozlabs.org>; Wed, 20 May 2015 01:08:45 +1000 (AEST)
Received: from /spool/local
 by e28smtp03.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <khandual@linux.vnet.ibm.com>;
 Tue, 19 May 2015 20:38:43 +0530
Received: from d28relay02.in.ibm.com (d28relay02.in.ibm.com [9.184.220.59])
 by d28dlp02.in.ibm.com (Postfix) with ESMTP id 385083940048
 for <linuxppc-dev@ozlabs.org>; Tue, 19 May 2015 20:38:42 +0530 (IST)
Received: from d28av04.in.ibm.com (d28av04.in.ibm.com [9.184.220.66])
 by d28relay02.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t4JF8cQg53805268
 for <linuxppc-dev@ozlabs.org>; Tue, 19 May 2015 20:38:39 +0530
Received: from d28av04.in.ibm.com (localhost [127.0.0.1])
 by d28av04.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t4JF8Yp4028984
 for <linuxppc-dev@ozlabs.org>; Tue, 19 May 2015 20:38:36 +0530
From: Anshuman Khandual <khandual@linux.vnet.ibm.com>
To: linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org
Subject: [PATCH V8 27/28] selftests,
 powerpc: Add ptrace tests for TM SPR registers
Date: Tue, 19 May 2015 20:38:23 +0530
Message-Id: <1432048104-4695-28-git-send-email-khandual@linux.vnet.ibm.com>
In-Reply-To: <1432048104-4695-1-git-send-email-khandual@linux.vnet.ibm.com>
References: <1432048104-4695-1-git-send-email-khandual@linux.vnet.ibm.com>
Cc: shuahkh@osg.samsung.com, mikey@neuling.org, james.hogan@imgtec.com,
 avagin@openvz.org, Paul.Clothier@imgtec.com, peterz@infradead.org,
 palves@redhat.com, nacc@linux.vnet.ibm.com, emachado@linux.vnet.ibm.com,
 oleg@redhat.com, davem@davemloft.net, dhowells@redhat.com,
 Ulrich.Weigand@de.ibm.com, kirjanov@gmail.com, davej@redhat.com,
 akpm@linux-foundation.org, sukadev@linux.vnet.ibm.com, tglx@linutronix.de,
 sam.bobroff@au1.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This patch adds ptrace interface test for TM SPR registers. This
also adds ptrace interface based helper functions related to TM
SPR registers access.

Signed-off-by: Anshuman Khandual <khandual@linux.vnet.ibm.com>
---
 tools/testing/selftests/powerpc/ptrace/Makefile    |   2 +-
 .../selftests/powerpc/ptrace/ptrace-tm-spr.c       | 156 +++++++++++++++++++++
 tools/testing/selftests/powerpc/ptrace/ptrace.h    |  35 +++++
 3 files changed, 192 insertions(+), 1 deletion(-)
 create mode 100644 tools/testing/selftests/powerpc/ptrace/ptrace-tm-spr.c

diff --git a/tools/testing/selftests/powerpc/ptrace/Makefile b/tools/testing/selftests/powerpc/ptrace/Makefile
index ea57351..a46a0e5 100644
--- a/tools/testing/selftests/powerpc/ptrace/Makefile
+++ b/tools/testing/selftests/powerpc/ptrace/Makefile
@@ -1,6 +1,6 @@
 TEST_PROGS := ptrace-ebb ptrace-gpr ptrace-tm-gpr ptrace-tm-spd-gpr \
 ptrace-tar ptrace-tm-tar ptrace-tm-spd-tar ptrace-vsx ptrace-tm-vsx \
-ptrace-tm-spd-vsx
+ptrace-tm-spd-vsx ptrace-tm-spr
 
 
 all: $(TEST_PROGS)
diff --git a/tools/testing/selftests/powerpc/ptrace/ptrace-tm-spr.c b/tools/testing/selftests/powerpc/ptrace/ptrace-tm-spr.c
new file mode 100644
index 0000000..36b9722
--- /dev/null
+++ b/tools/testing/selftests/powerpc/ptrace/ptrace-tm-spr.c
@@ -0,0 +1,156 @@
+/*
+ * Ptrace test TM SPR registers
+ *
+ * Copyright 2015 Anshuman Khandual, IBM Corporation.
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
+trans:
+	asm __volatile__(
+		"1: ;"
+		TBEGIN
+		"beq 2f;"
+
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
+		: [tfhar] "=r" (tfhar), [res] "=r" (result), [texasr] "=r" (texasr)
+		: [sprn_texasr] "i"  (SPRN_TEXASR)
+		: "memory", "r0", "r1", "r2", "r3", "r4", "r8", "r9", "r10", "r11"
+		);
+
+	if (result) {
+		if (!cptr->flag)
+			goto trans;
+
+		ret = validate_tm_spr((struct tm_spr_regs *)&cptr->regs);
+		shmdt((void *)cptr);
+		if (ret)
+			exit(1);
+		exit(0);
+	}
+	shmdt((void *)cptr);
+	exit(1);
+}
+
+int trace_tm_spr(pid_t child)
+{
+	int ret;
+
+	sleep(1);
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
+	shm_id = shmget(IPC_PRIVATE, sizeof(struct shared), 0777|IPC_CREAT);
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
+		ret = trace_tm_spr(pid);
+		if (ret) {
+			kill(pid, SIGKILL);
+			return TEST_FAIL;
+		}
+
+		pptr->flag = 1;
+		shmdt((void *)pptr);
+		ret = wait(&status);
+		if (ret != pid) {
+			printf("Child's exit status not captured\n");
+			return TEST_FAIL;
+		}
+
+		if (WIFEXITED(status)) {
+			if(WEXITSTATUS(status))
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
index 86fef91..812261a 100644
--- a/tools/testing/selftests/powerpc/ptrace/ptrace.h
+++ b/tools/testing/selftests/powerpc/ptrace/ptrace.h
@@ -82,6 +82,11 @@ struct fpr_regs {
 	unsigned long fpscr;
 };
 
+struct tm_spr_regs {
+	unsigned long tm_tfhar;
+	unsigned long tm_texasr;
+	unsigned long tm_tfiar;
+};
 
 /* Basic ptrace operations */
 int start_trace(pid_t child)
@@ -662,6 +667,36 @@ int write_vsx_ckpt(pid_t child, unsigned long *vsx)
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
2.1.0

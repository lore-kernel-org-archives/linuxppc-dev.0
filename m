Return-Path: <wei.guo.simon@gmail.com>
Received: from mail-pa0-x243.google.com (mail-pa0-x243.google.com
 [IPv6:2607:f8b0:400e:c03::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3s0Gnn05LlzDrPD
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 28 Jul 2016 13:00:45 +1000 (AEST)
Received: by mail-pa0-x243.google.com with SMTP id cf3so2698631pad.2
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 27 Jul 2016 20:00:44 -0700 (PDT)
From: wei.guo.simon@gmail.com
To: linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
Cc: Michael Ellerman <mpe@ellerman.id.au>,
 Shuah Khan <shuahkh@osg.samsung.com>, Anton Blanchard <anton@samba.org>,
 Cyril Bur <cyrilbur@gmail.com>,
 Anshuman Khandual <khandual@linux.vnet.ibm.com>,
 Simon Guo <wei.guo.simon@gmail.com>,
 Ulrich Weigand <ulrich.weigand@de.ibm.com>,
 Michael Neuling <mikey@neuling.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 Kees Cook <keescook@chromium.org>, Rashmica Gupta <rashmicy@gmail.com>,
 Khem Raj <raj.khem@gmail.com>, Jessica Yu <jeyu@redhat.com>,
 Jiri Kosina <jkosina@suse.cz>, Miroslav Benes <mbenes@suse.cz>,
 Suraj Jitindar Singh <sjitindarsingh@gmail.com>,
 Chris Smart <chris@distroguy.com>, linux-kselftest@vger.kernel.org
Subject: [PATCH v13 22/30] selftests/powerpc: Add ptrace tests for TAR, PPR,
 DSCR registers
Date: Thu, 28 Jul 2016 10:57:51 +0800
Message-Id: <1469674679-8580-23-git-send-email-wei.guo.simon@gmail.com>
In-Reply-To: <1469674679-8580-1-git-send-email-wei.guo.simon@gmail.com>
References: <1469674679-8580-1-git-send-email-wei.guo.simon@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Anshuman Khandual <khandual@linux.vnet.ibm.com>

This patch adds ptrace interface test for TAR, PPR, DSCR
registers. This also adds ptrace interface based helper
functions related to TAR, PPR, DSCR register access.

Signed-off-by: Anshuman Khandual <khandual@linux.vnet.ibm.com>
Signed-off-by: Simon Guo <wei.guo.simon@gmail.com>
---
 tools/testing/selftests/powerpc/ptrace/Makefile    |   3 +-
 .../testing/selftests/powerpc/ptrace/ptrace-tar.c  | 159 ++++++++++++++++++
 .../testing/selftests/powerpc/ptrace/ptrace-tar.h  |  50 ++++++
 tools/testing/selftests/powerpc/ptrace/ptrace.h    | 181 +++++++++++++++++++++
 4 files changed, 392 insertions(+), 1 deletion(-)
 create mode 100644 tools/testing/selftests/powerpc/ptrace/ptrace-tar.c
 create mode 100644 tools/testing/selftests/powerpc/ptrace/ptrace-tar.h

diff --git a/tools/testing/selftests/powerpc/ptrace/Makefile b/tools/testing/selftests/powerpc/ptrace/Makefile
index d0f000c..c794057 100644
--- a/tools/testing/selftests/powerpc/ptrace/Makefile
+++ b/tools/testing/selftests/powerpc/ptrace/Makefile
@@ -1,4 +1,5 @@
-TEST_PROGS := ptrace-ebb ptrace-gpr ptrace-tm-gpr ptrace-tm-spd-gpr
+TEST_PROGS := ptrace-ebb ptrace-gpr ptrace-tm-gpr ptrace-tm-spd-gpr \
+ptrace-tar
 
 all: $(TEST_PROGS)
 CFLAGS += -m64
diff --git a/tools/testing/selftests/powerpc/ptrace/ptrace-tar.c b/tools/testing/selftests/powerpc/ptrace/ptrace-tar.c
new file mode 100644
index 0000000..e7d5938
--- /dev/null
+++ b/tools/testing/selftests/powerpc/ptrace/ptrace-tar.c
@@ -0,0 +1,159 @@
+/*
+ * Ptrace test for TAR, PPR, DSCR registers
+ *
+ * Copyright (C) 2015 Anshuman Khandual, IBM Corporation.
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version
+ * 2 of the License, or (at your option) any later version.
+ */
+#include "ptrace.h"
+#include "ptrace-tar.h"
+
+/* Tracer and Tracee Shared Data */
+int shm_id;
+volatile int *cptr;
+volatile int *pptr;
+
+void tar(void)
+{
+	unsigned long reg[3];
+	int ret;
+
+	cptr = (int *)shmat(shm_id, NULL, 0);
+	printf("%-30s TAR: %u PPR: %lx DSCR: %u\n",
+			user_write, TAR_1, PPR_1, DSCR_1);
+
+	mtspr(SPRN_TAR, TAR_1);
+	mtspr(SPRN_PPR, PPR_1);
+	mtspr(SPRN_DSCR, DSCR_1);
+
+	cptr[2] = 1;
+
+	/* Wait on parent */
+	while (!cptr[0]);
+
+	reg[0] = mfspr(SPRN_TAR);
+	reg[1] = mfspr(SPRN_PPR);
+	reg[2] = mfspr(SPRN_DSCR);
+
+	printf("%-30s TAR: %lu PPR: %lx DSCR: %lu\n",
+			user_read, reg[0], reg[1], reg[2]);
+
+	/* Unblock the parent now */
+	cptr[1] = 1;
+	shmdt((int *)cptr);
+
+	ret = validate_tar_registers(reg, TAR_2, PPR_2, DSCR_2);
+	if (ret)
+		exit(1);
+	exit(0);
+}
+
+int trace_tar(pid_t child)
+{
+	unsigned long reg[3];
+	int ret;
+
+	ret = start_trace(child);
+	if (ret)
+		return TEST_FAIL;
+
+	ret = show_tar_registers(child, reg);
+	if (ret)
+		return TEST_FAIL;
+
+	printf("%-30s TAR: %lu PPR: %lx DSCR: %lu\n",
+			ptrace_read_running, reg[0], reg[1], reg[2]);
+
+	ret = validate_tar_registers(reg, TAR_1, PPR_1, DSCR_1);
+	if (ret)
+		return TEST_FAIL;
+
+	ret = stop_trace(child);
+	if (ret)
+		return TEST_FAIL;
+
+	return TEST_PASS;
+}
+
+int trace_tar_write(pid_t child)
+{
+	int ret;
+
+	ret = start_trace(child);
+	if (ret)
+		return TEST_FAIL;
+
+	ret = write_tar_registers(child, TAR_2, PPR_2, DSCR_2);
+	if (ret)
+		return TEST_FAIL;
+
+	printf("%-30s TAR: %u PPR: %lx DSCR: %u\n",
+			ptrace_write_running, TAR_2, PPR_2, DSCR_2);
+
+	ret = stop_trace(child);
+	if (ret)
+		return TEST_FAIL;
+
+	return TEST_PASS;
+}
+
+int ptrace_tar(void)
+{
+	pid_t pid;
+	int ret, status;
+
+	shm_id = shmget(IPC_PRIVATE, sizeof(int) * 3, 0777|IPC_CREAT);
+	pid = fork();
+	if (pid < 0) {
+		perror("fork() failed");
+		return TEST_FAIL;
+	}
+
+	if (pid == 0)
+		tar();
+
+	if (pid) {
+		pptr = (int *)shmat(shm_id, NULL, 0);
+		pptr[0] = 0;
+		pptr[1] = 0;
+
+		while (!pptr[2]);
+		ret = trace_tar(pid);
+		if (ret)
+			return ret;
+
+		ret = trace_tar_write(pid);
+		if (ret)
+			return ret;
+
+		/* Unblock the child now */
+		pptr[0] = 1;
+
+		/* Wait on child */
+		while (!pptr[1]);
+
+		shmdt((int *)pptr);
+
+		ret = wait(&status);
+		shmctl(shm_id, IPC_RMID, NULL);
+		if (ret != pid) {
+			printf("Child's exit status not captured\n");
+			return TEST_PASS;
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
+	return test_harness(ptrace_tar, "ptrace_tar");
+}
diff --git a/tools/testing/selftests/powerpc/ptrace/ptrace-tar.h b/tools/testing/selftests/powerpc/ptrace/ptrace-tar.h
new file mode 100644
index 0000000..aed0aac
--- /dev/null
+++ b/tools/testing/selftests/powerpc/ptrace/ptrace-tar.h
@@ -0,0 +1,50 @@
+/*
+ * Copyright (C) 2015 Anshuman Khandual, IBM Corporation.
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version
+ * 2 of the License, or (at your option) any later version.
+ */
+#define TAR_1   10
+#define TAR_2   20
+#define TAR_3   30
+#define TAR_4   40
+#define TAR_5   50
+
+#define DSCR_1  100
+#define DSCR_2  200
+#define DSCR_3  300
+#define DSCR_4  400
+#define DSCR_5  500
+
+#define PPR_1   0x4000000000000         /* or 31,31,31*/
+#define PPR_2   0x8000000000000         /* or 1,1,1 */
+#define PPR_3   0xc000000000000         /* or 6,6,6 */
+#define PPR_4   0x10000000000000        /* or 2,2,2 */
+
+char *user_read = "[User Read (Running)]";
+char *user_write = "[User Write (Running)]";
+char *ptrace_read_running = "[Ptrace Read (Running)]";
+char *ptrace_write_running = "[Ptrace Write (Running)]";
+char *ptrace_read_ckpt = "[Ptrace Read (Checkpointed)]";
+char *ptrace_write_ckpt = "[Ptrace Write (Checkpointed)]";
+
+int validate_tar_registers(unsigned long *reg, unsigned long tar,
+				unsigned long ppr, unsigned long dscr)
+{
+	int match = 1;
+
+	if (reg[0] != tar)
+		match = 0;
+
+	if (reg[1] != ppr)
+		match = 0;
+
+	if (reg[2] != dscr)
+		match = 0;
+
+	if (!match)
+		return TEST_FAIL;
+	return TEST_PASS;
+}
diff --git a/tools/testing/selftests/powerpc/ptrace/ptrace.h b/tools/testing/selftests/powerpc/ptrace/ptrace.h
index b6df47f..b9ab0b1 100644
--- a/tools/testing/selftests/powerpc/ptrace/ptrace.h
+++ b/tools/testing/selftests/powerpc/ptrace/ptrace.h
@@ -172,6 +172,187 @@ fail:
 	return TEST_FAIL;
 }
 
+/* TAR, PPR, DSCR */
+int show_tar_registers(pid_t child, unsigned long *out)
+{
+	struct iovec iov;
+	unsigned long *reg;
+	int ret;
+
+	reg = malloc(sizeof(unsigned long));
+	if (!reg) {
+		perror("malloc() failed");
+		return TEST_FAIL;
+	}
+	iov.iov_base = (u64 *) reg;
+	iov.iov_len = sizeof(unsigned long);
+
+	ret = ptrace(PTRACE_GETREGSET, child, NT_PPC_TAR, &iov);
+	if (ret) {
+		perror("ptrace(PTRACE_GETREGSET) failed");
+		goto fail;
+	}
+	if (out)
+		out[0] = *reg;
+
+	ret = ptrace(PTRACE_GETREGSET, child, NT_PPC_PPR, &iov);
+	if (ret) {
+		perror("ptrace(PTRACE_GETREGSET) failed");
+		goto fail;
+	}
+	if (out)
+		out[1] = *reg;
+
+	ret = ptrace(PTRACE_GETREGSET, child, NT_PPC_DSCR, &iov);
+	if (ret) {
+		perror("ptrace(PTRACE_GETREGSET) failed");
+		goto fail;
+	}
+	if (out)
+		out[2] = *reg;
+
+	free(reg);
+	return TEST_PASS;
+fail:
+	free(reg);
+	return TEST_FAIL;
+}
+
+int write_tar_registers(pid_t child, unsigned long tar,
+		unsigned long ppr, unsigned long dscr)
+{
+	struct iovec iov;
+	unsigned long *reg;
+	int ret;
+
+	reg = malloc(sizeof(unsigned long));
+	if (!reg) {
+		perror("malloc() failed");
+		return TEST_FAIL;
+	}
+
+	iov.iov_base = (u64 *) reg;
+	iov.iov_len = sizeof(unsigned long);
+
+	*reg = tar;
+	ret = ptrace(PTRACE_SETREGSET, child, NT_PPC_TAR, &iov);
+	if (ret) {
+		perror("ptrace(PTRACE_SETREGSET) failed");
+		goto fail;
+	}
+
+	*reg = ppr;
+	ret = ptrace(PTRACE_SETREGSET, child, NT_PPC_PPR, &iov);
+	if (ret) {
+		perror("ptrace(PTRACE_SETREGSET) failed");
+		goto fail;
+	}
+
+	*reg = dscr;
+	ret = ptrace(PTRACE_SETREGSET, child, NT_PPC_DSCR, &iov);
+	if (ret) {
+		perror("ptrace(PTRACE_SETREGSET) failed");
+		goto fail;
+	}
+
+	free(reg);
+	return TEST_PASS;
+fail:
+	free(reg);
+	return TEST_FAIL;
+}
+
+int show_tm_checkpointed_state(pid_t child, unsigned long *out)
+{
+	struct iovec iov;
+	unsigned long *reg;
+	int ret;
+
+	reg = malloc(sizeof(unsigned long));
+	if (!reg) {
+		perror("malloc() failed");
+		return TEST_FAIL;
+	}
+
+	iov.iov_base = (u64 *) reg;
+	iov.iov_len = sizeof(unsigned long);
+
+	ret = ptrace(PTRACE_GETREGSET, child, NT_PPC_TM_CTAR, &iov);
+	if (ret) {
+		perror("ptrace(PTRACE_GETREGSET) failed");
+		goto fail;
+	}
+	if (out)
+		out[0] = *reg;
+
+	ret = ptrace(PTRACE_GETREGSET, child, NT_PPC_TM_CPPR, &iov);
+	if (ret) {
+		perror("ptrace(PTRACE_GETREGSET) failed");
+		goto fail;
+	}
+	if (out)
+		out[1] = *reg;
+
+	ret = ptrace(PTRACE_GETREGSET, child, NT_PPC_TM_CDSCR, &iov);
+	if (ret) {
+		perror("ptrace(PTRACE_GETREGSET) failed");
+		goto fail;
+	}
+	if (out)
+		out[2] = *reg;
+
+	free(reg);
+	return TEST_PASS;
+
+fail:
+	free(reg);
+	return TEST_FAIL;
+}
+
+int write_ckpt_tar_registers(pid_t child, unsigned long tar,
+		unsigned long ppr, unsigned long dscr)
+{
+	struct iovec iov;
+	unsigned long *reg;
+	int ret;
+
+	reg = malloc(sizeof(unsigned long));
+	if (!reg) {
+		perror("malloc() failed");
+		return TEST_FAIL;
+	}
+
+	iov.iov_base = (u64 *) reg;
+	iov.iov_len = sizeof(unsigned long);
+
+	*reg = tar;
+	ret = ptrace(PTRACE_SETREGSET, child, NT_PPC_TM_CTAR, &iov);
+	if (ret) {
+		perror("ptrace(PTRACE_GETREGSET) failed");
+		goto fail;
+	}
+
+	*reg = ppr;
+	ret = ptrace(PTRACE_SETREGSET, child, NT_PPC_TM_CPPR, &iov);
+	if (ret) {
+		perror("ptrace(PTRACE_GETREGSET) failed");
+		goto fail;
+	}
+
+	*reg = dscr;
+	ret = ptrace(PTRACE_SETREGSET, child, NT_PPC_TM_CDSCR, &iov);
+	if (ret) {
+		perror("ptrace(PTRACE_GETREGSET) failed");
+		goto fail;
+	}
+
+	free(reg);
+	return TEST_PASS;
+fail:
+	free(reg);
+	return TEST_FAIL;
+}
+
 /* FPR */
 int show_fpr(pid_t child, unsigned long *fpr)
 {
-- 
1.8.3.1

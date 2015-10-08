Return-Path: <khandual@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 008F31A01C9
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  9 Oct 2015 01:50:49 +1100 (AEDT)
Received: from e23smtp08.au.ibm.com (e23smtp08.au.ibm.com [202.81.31.141])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 1DD04140DEF
 for <linuxppc-dev@ozlabs.org>; Fri,  9 Oct 2015 01:50:48 +1100 (AEDT)
Received: from /spool/local
 by e23smtp08.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <khandual@linux.vnet.ibm.com>;
 Fri, 9 Oct 2015 00:50:47 +1000
Received: from d23relay08.au.ibm.com (d23relay08.au.ibm.com [9.185.71.33])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id B97D22BB0051
 for <linuxppc-dev@ozlabs.org>; Fri,  9 Oct 2015 01:50:45 +1100 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay08.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t98EoPcM51511304
 for <linuxppc-dev@ozlabs.org>; Fri, 9 Oct 2015 01:50:34 +1100
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t98EoBww008676
 for <linuxppc-dev@ozlabs.org>; Fri, 9 Oct 2015 01:50:13 +1100
From: Anshuman Khandual <khandual@linux.vnet.ibm.com>
To: linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org
Cc: peterz@infradead.org, akpm@linux-foundation.org, tglx@linutronix.de,
 james.hogan@imgtec.com, avagin@openvz.org, Paul.Clothier@imgtec.com,
 palves@redhat.com, oleg@redhat.com, dhowells@redhat.com,
 davej@redhat.com, davem@davemloft.net, mikey@neuling.org,
 benh@kernel.crashing.org, sukadev@linux.vnet.ibm.com,
 mpe@ellerman.id.au, sam.bobroff@au1.ibm.com, kirjanov@gmail.com,
 shuahkh@osg.samsung.com, Ulrich.Weigand@de.ibm.com,
 emachado@linux.vnet.ibm.com
Subject: [PATCH V9 21/28] selftests, powerpc: Add ptrace tests for TAR, PPR,
 DSCR registers
Date: Thu,  8 Oct 2015 20:17:42 +0530
Message-Id: <1444315669-23487-22-git-send-email-khandual@linux.vnet.ibm.com>
In-Reply-To: <1444315669-23487-1-git-send-email-khandual@linux.vnet.ibm.com>
References: <1444315669-23487-1-git-send-email-khandual@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This patch adds ptrace interface test for TAR, PPR, DSCR
registers. This also adds ptrace interface based helper
functions related to TAR, PPR, DSCR register access.

Signed-off-by: Anshuman Khandual <khandual@linux.vnet.ibm.com>
---
 tools/testing/selftests/powerpc/ptrace/Makefile    |   3 +-
 .../testing/selftests/powerpc/ptrace/ptrace-tar.c  | 151 +++++++++++++++++
 .../testing/selftests/powerpc/ptrace/ptrace-tar.h  |  50 ++++++
 tools/testing/selftests/powerpc/ptrace/ptrace.h    | 179 +++++++++++++++++++++
 4 files changed, 382 insertions(+), 1 deletion(-)
 create mode 100644 tools/testing/selftests/powerpc/ptrace/ptrace-tar.c
 create mode 100644 tools/testing/selftests/powerpc/ptrace/ptrace-tar.h

diff --git a/tools/testing/selftests/powerpc/ptrace/Makefile b/tools/testing/selftests/powerpc/ptrace/Makefile
index a8fa080..28d4465 100644
--- a/tools/testing/selftests/powerpc/ptrace/Makefile
+++ b/tools/testing/selftests/powerpc/ptrace/Makefile
@@ -1,4 +1,5 @@
-TEST_PROGS := ptrace-ebb ptrace-gpr ptrace-tm-gpr ptrace-tm-spd-gpr
+TEST_PROGS := ptrace-ebb ptrace-gpr ptrace-tm-gpr ptrace-tm-spd-gpr \
+ptrace-tar
 
 all: $(TEST_PROGS)
 
diff --git a/tools/testing/selftests/powerpc/ptrace/ptrace-tar.c b/tools/testing/selftests/powerpc/ptrace/ptrace-tar.c
new file mode 100644
index 0000000..51978aa
--- /dev/null
+++ b/tools/testing/selftests/powerpc/ptrace/ptrace-tar.c
@@ -0,0 +1,151 @@
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
+	printf("%-30s TAR: %u PPR: %lx DSCR: %u\n", user_write, TAR_1, PPR_1, DSCR_1);
+
+	mtspr(SPRN_TAR, TAR_1);
+	mtspr(SPRN_PPR, PPR_1);
+	mtspr(SPRN_DSCR, DSCR_1);
+
+	/* Wait on parent */
+	while (!cptr[0]);
+
+	reg[0] = mfspr(SPRN_TAR);
+	reg[1] = mfspr(SPRN_PPR);
+	reg[2] = mfspr(SPRN_DSCR);
+
+	printf("%-30s TAR: %lu PPR: %lx DSCR: %lu\n", user_read, reg[0], reg[1], reg[2]);
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
+	sleep(1);
+	ret = start_trace(child);
+	if (ret)
+		return TEST_FAIL;
+
+	ret = show_tar_registers(child, reg);
+	if (ret)
+		return TEST_FAIL;
+
+	printf("%-30s TAR: %lu PPR: %lx DSCR: %lu\n", ptrace_read_running, reg[0], reg[1], reg[2]);
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
+	printf("%-30s TAR: %u PPR: %lx DSCR: %u\n", ptrace_write_running, TAR_2, PPR_2, DSCR_2);
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
+	shm_id = shmget(IPC_PRIVATE, sizeof(int) * 2, 0777|IPC_CREAT);
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
+		while(!pptr[1]);
+
+		shmdt((int *)pptr);
+
+		ret = wait(&status);
+		if (ret != pid) {
+			printf("Child's exit status not captured\n");
+			return TEST_PASS;
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
+	return test_harness(ptrace_tar, "ptrace_tar");
+}
diff --git a/tools/testing/selftests/powerpc/ptrace/ptrace-tar.h b/tools/testing/selftests/powerpc/ptrace/ptrace-tar.h
new file mode 100644
index 0000000..5031e46
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
+char *user_read="[User Read (Running)]";
+char *user_write="[User Write (Running)]";
+char *ptrace_read_running="[Ptrace Read (Running)]";
+char *ptrace_write_running="[Ptrace Write (Running)]";
+char *ptrace_read_ckpt="[Ptrace Read (Checkpointed)]";
+char *ptrace_write_ckpt="[Ptrace Write (Checkpointed)]";
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
index 439fb65..a5efdee 100644
--- a/tools/testing/selftests/powerpc/ptrace/ptrace.h
+++ b/tools/testing/selftests/powerpc/ptrace/ptrace.h
@@ -157,6 +157,185 @@ fail:
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
+int write_tar_registers(pid_t child, unsigned long tar, unsigned long ppr, unsigned long dscr)
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
+int write_ckpt_tar_registers(pid_t child, unsigned long tar, unsigned long ppr, unsigned long dscr)
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
2.1.0

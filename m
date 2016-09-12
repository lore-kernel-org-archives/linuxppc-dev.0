Return-Path: <wei.guo.simon@gmail.com>
Received: from mail-pa0-x241.google.com (mail-pa0-x241.google.com
 [IPv6:2607:f8b0:400e:c03::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sXfh84MGjzDsNT
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 12 Sep 2016 17:34:16 +1000 (AEST)
Received: by mail-pa0-x241.google.com with SMTP id p2so1180929pap.3
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 12 Sep 2016 00:34:16 -0700 (PDT)
From: wei.guo.simon@gmail.com
To: linuxppc-dev@lists.ozlabs.org
Cc: Shuah Khan <shuah@kernel.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Cyril Bur <cyrilbur@gmail.com>, Chris Smart <chris@distroguy.com>,
 Suraj Jitindar Singh <sjitindarsingh@gmail.com>,
 Michael Neuling <mikey@neuling.org>,
 Anshuman Khandual <khandual@linux.vnet.ibm.com>,
 Simon Guo <wei.guo.simon@gmail.com>, Jack Miller <jack@codezen.org>,
 Rashmica Gupta <rashmicy@gmail.com>, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org
Subject: [PATCH v14 03/15] selftests/powerpc: Add ptrace tests for EBB
Date: Mon, 12 Sep 2016 15:33:13 +0800
Message-Id: <1473665605-11890-4-git-send-email-wei.guo.simon@gmail.com>
In-Reply-To: <1473665605-11890-1-git-send-email-wei.guo.simon@gmail.com>
References: <1473665605-11890-1-git-send-email-wei.guo.simon@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Anshuman Khandual <khandual@linux.vnet.ibm.com>

This patch adds ptrace interface test for EBB/PMU specific
registers. This also adds some generic ptrace interface
based helper functions to be used by other patches later
on in the series.

Signed-off-by: Anshuman Khandual <khandual@linux.vnet.ibm.com>
Signed-off-by: Simon Guo <wei.guo.simon@gmail.com>
---
 tools/testing/selftests/powerpc/Makefile           |   3 +-
 tools/testing/selftests/powerpc/ptrace/Makefile    |   7 +
 .../testing/selftests/powerpc/ptrace/ptrace-ebb.c  | 188 +++++++++++++++++
 .../testing/selftests/powerpc/ptrace/ptrace-ebb.h  |  99 +++++++++
 tools/testing/selftests/powerpc/ptrace/ptrace.h    | 225 +++++++++++++++++++++
 5 files changed, 521 insertions(+), 1 deletion(-)
 create mode 100644 tools/testing/selftests/powerpc/ptrace/Makefile
 create mode 100644 tools/testing/selftests/powerpc/ptrace/ptrace-ebb.c
 create mode 100644 tools/testing/selftests/powerpc/ptrace/ptrace-ebb.h
 create mode 100644 tools/testing/selftests/powerpc/ptrace/ptrace.h

diff --git a/tools/testing/selftests/powerpc/Makefile b/tools/testing/selftests/powerpc/Makefile
index 1cc6d64..f9d311b 100644
--- a/tools/testing/selftests/powerpc/Makefile
+++ b/tools/testing/selftests/powerpc/Makefile
@@ -25,7 +25,8 @@ SUB_DIRS = alignment		\
 	   syscalls		\
 	   tm			\
 	   vphn         \
-	   math
+	   math		\
+	   ptrace
 
 endif
 
diff --git a/tools/testing/selftests/powerpc/ptrace/Makefile b/tools/testing/selftests/powerpc/ptrace/Makefile
new file mode 100644
index 0000000..f6948f3
--- /dev/null
+++ b/tools/testing/selftests/powerpc/ptrace/Makefile
@@ -0,0 +1,7 @@
+TEST_PROGS := ptrace-ebb
+all: $(TEST_PROGS)
+CFLAGS += -m64
+$(TEST_PROGS): ../harness.c ptrace.S ../utils.c ptrace.h
+ptrace-ebb: ../pmu/event.c ../pmu/lib.c ../pmu/ebb/ebb_handler.S ../pmu/ebb/busy_loop.S
+clean:
+	rm -f $(TEST_PROGS) *.o
diff --git a/tools/testing/selftests/powerpc/ptrace/ptrace-ebb.c b/tools/testing/selftests/powerpc/ptrace/ptrace-ebb.c
new file mode 100644
index 0000000..bc6795d
--- /dev/null
+++ b/tools/testing/selftests/powerpc/ptrace/ptrace-ebb.c
@@ -0,0 +1,188 @@
+/*
+ * Ptrace interface test for EBB
+ *
+ * Copyright (C) 2015 Anshuman Khandual, IBM Corporation.
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version
+ * 2 of the License, or (at your option) any later version.
+ */
+#include "../pmu/ebb/ebb.h"
+#include "ptrace.h"
+#include "ptrace-ebb.h"
+
+/* Tracer and Tracee Shared Data */
+int shm_id;
+volatile int *cptr, *pptr;
+
+void ebb(void)
+{
+	struct event event;
+
+	cptr = (int *)shmat(shm_id, NULL, 0);
+
+	event_init_named(&event, 0x1001e, "cycles");
+	event.attr.config |= (1ull << 63);
+	event.attr.exclusive = 1;
+	event.attr.pinned = 1;
+	event.attr.exclude_kernel = 1;
+	event.attr.exclude_hv = 1;
+	event.attr.exclude_idle = 1;
+
+	if (event_open(&event)) {
+		perror("event_open() failed");
+		exit(1);
+	}
+
+	setup_ebb_handler(standard_ebb_callee);
+	mtspr(SPRN_BESCR, 0x8000000100000000ull);
+
+	/*
+	 * make sure BESCR has been set before continue
+	 */
+	mb();
+
+	if (ebb_event_enable(&event)) {
+		perror("ebb_event_handler() failed");
+		exit(1);
+	}
+
+	mtspr(SPRN_PMC1, pmc_sample_period(SAMPLE_PERIOD));
+	core_busy_loop();
+	cptr[0] = 1;
+	while (1);
+
+	exit(0);
+}
+
+int validate_ebb(struct ebb_regs *regs)
+{
+	#if __BYTE_ORDER__ == __ORDER_BIG_ENDIAN__
+	struct opd *opd = (struct opd *) ebb_handler;
+	#endif
+
+	printf("EBBRR: %lx\n", regs->ebbrr);
+	#if __BYTE_ORDER__ == __ORDER_BIG_ENDIAN__
+	printf("EBBHR: %lx; expected: %lx\n",
+			regs->ebbhr, (unsigned long)opd->entry);
+	#else
+	printf("EBBHR: %lx; expected: %lx\n",
+			regs->ebbhr, (unsigned long)ebb_handler);
+	#endif
+	printf("BESCR: %lx\n", regs->bescr);
+
+	#if __BYTE_ORDER__ == __ORDER_BIG_ENDIAN__
+	if (regs->ebbhr != opd->entry)
+		return TEST_FAIL;
+	#else
+	if (regs->ebbhr != (unsigned long) ebb_handler)
+		return TEST_FAIL;
+	#endif
+
+	return TEST_PASS;
+}
+
+int validate_pmu(struct pmu_regs *regs)
+{
+	printf("SIAR:  %lx\n", regs->siar);
+	printf("SDAR:  %lx\n", regs->sdar);
+	printf("SIER:  %lx; expected: %lx\n",
+			regs->sier, (unsigned long)SIER_EXP);
+	printf("MMCR2: %lx; expected: %lx\n",
+			regs->mmcr2, (unsigned long)MMCR2_EXP);
+	printf("MMCR0: %lx; expected: %lx\n",
+			regs->mmcr0, (unsigned long)MMCR0_EXP);
+
+	/* Validate SIER */
+	if (regs->sier != SIER_EXP)
+		return TEST_FAIL;
+
+	/* Validate MMCR2 */
+	if (regs->mmcr2 != MMCR2_EXP)
+		return TEST_FAIL;
+
+	/* Validate MMCR0 */
+	if (regs->mmcr0 != MMCR0_EXP)
+		return TEST_FAIL;
+
+	return TEST_PASS;
+}
+
+int trace_ebb_pmu(pid_t child)
+{
+	struct ebb_regs ebb_regs;
+	struct pmu_regs pmu_regs;
+	int ret;
+
+	ret = start_trace(child);
+	if (ret)
+		return TEST_FAIL;
+
+	ret = show_ebb_registers(child, &ebb_regs);
+	if (ret)
+		return TEST_FAIL;
+
+	ret = validate_ebb(&ebb_regs);
+	if (ret)
+		return TEST_FAIL;
+
+	ret = show_pmu_registers(child, &pmu_regs);
+	if (ret)
+		return TEST_FAIL;
+
+	ret = validate_pmu(&pmu_regs);
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
+int ptrace_ebb_pmu(void)
+{
+	pid_t pid;
+	int ret, status;
+
+	shm_id = shmget(IPC_PRIVATE, sizeof(int) * 1, 0777|IPC_CREAT);
+	pid = fork();
+	if (pid < 0) {
+		perror("fork() failed");
+		return TEST_FAIL;
+	}
+
+	if (pid == 0)
+		ebb();
+
+	if (pid) {
+		pptr = (int *)shmat(shm_id, NULL, 0);
+		while (!pptr[0]);
+
+		ret = trace_ebb_pmu(pid);
+		if (ret)
+			return TEST_FAIL;
+
+		shmctl(shm_id, IPC_RMID, NULL);
+		kill(pid, SIGKILL);
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
+	return test_harness(ptrace_ebb_pmu, "ptrace_ebb_pmu");
+}
diff --git a/tools/testing/selftests/powerpc/ptrace/ptrace-ebb.h b/tools/testing/selftests/powerpc/ptrace/ptrace-ebb.h
new file mode 100644
index 0000000..740848a
--- /dev/null
+++ b/tools/testing/selftests/powerpc/ptrace/ptrace-ebb.h
@@ -0,0 +1,99 @@
+/*
+ * Inspired mostly from the EBB selftest
+ *
+ * Copyright (C) 2015 Anshuman Khandual, IBM Corporation.
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version
+ * 2 of the License, or (at your option) any later version.
+ */
+#define SAMPLE_PERIOD 100	/* EBB event sample persiod */
+
+/* Standard expected values */
+#if __BYTE_ORDER__ == __ORDER_BIG_ENDIAN__
+#define MMCR0_EXP	0x8000008000000001
+#else
+#define MMCR0_EXP	0x180000080
+#endif
+
+#define MMCR2_EXP	0
+#define SIER_EXP	0x2000000
+
+struct opd {
+	u64 entry;
+	u64 toc;
+};
+
+void (*ebb_user_func)(void);
+extern void ebb_handler(void);	/* Defined in ebb_handle.S */
+
+void ebb_hook(void)		/* Called by ebb_handler */
+{
+	if (ebb_user_func)
+		ebb_user_func();
+}
+
+void setup_ebb_handler(void (*callee)(void))
+{
+	u64 entry;
+
+#if defined(_CALL_ELF) && _CALL_ELF == 2
+	entry = (u64)ebb_handler;
+#else
+	struct opd *opd;
+
+	opd = (struct opd *)ebb_handler;
+	entry = opd->entry;
+#endif
+	ebb_user_func = callee;
+
+	/* Ensure ebb_user_func is set before we set the handler */
+	mb();
+	mtspr(SPRN_EBBHR, entry);
+
+	/* Make sure the handler is set before we return */
+	mb();
+}
+
+void reset_ebb_with_clear_mask(unsigned long mmcr0_clear_mask)
+{
+	u64 val;
+
+	/* 2) clear MMCR0[PMAO] - docs say BESCR[PMEO] should do this */
+	/* 3) set MMCR0[PMAE]   - docs say BESCR[PME] should do this */
+	val = mfspr(SPRN_MMCR0);
+	mtspr(SPRN_MMCR0, (val & ~mmcr0_clear_mask) | MMCR0_PMAE);
+
+	/* 4) clear BESCR[PMEO] */
+	mtspr(SPRN_BESCRR, BESCR_PMEO);
+
+	/* 5) set BESCR[PME] */
+	mtspr(SPRN_BESCRS, BESCR_PME);
+
+	/* 6) rfebb 1 - done in our caller */
+}
+
+void standard_ebb_callee(void)
+{
+	u64 val;
+
+	val = mfspr(SPRN_BESCR);
+	if (!(val & BESCR_PMEO))
+		printf("Spurious interrupt\n");
+
+	mtspr(SPRN_PMC1, pmc_sample_period(SAMPLE_PERIOD));
+	reset_ebb_with_clear_mask(MMCR0_PMAO | MMCR0_FC);
+}
+
+int ebb_event_enable(struct event *e)
+{
+	int rc;
+
+	rc = ioctl(e->fd, PERF_EVENT_IOC_ENABLE);
+	if (rc)
+		return rc;
+	rc = event_read(e);
+
+	return rc;
+}
diff --git a/tools/testing/selftests/powerpc/ptrace/ptrace.h b/tools/testing/selftests/powerpc/ptrace/ptrace.h
new file mode 100644
index 0000000..fbf73ca
--- /dev/null
+++ b/tools/testing/selftests/powerpc/ptrace/ptrace.h
@@ -0,0 +1,225 @@
+/*
+ * Ptrace interface test helper functions
+ *
+ * Copyright (C) 2015 Anshuman Khandual, IBM Corporation.
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version
+ * 2 of the License, or (at your option) any later version.
+ */
+#include <inttypes.h>
+#include <unistd.h>
+#include <stdlib.h>
+#include <string.h>
+#include <malloc.h>
+#include <errno.h>
+#include <time.h>
+#include <sys/ptrace.h>
+#include <sys/ioctl.h>
+#include <sys/uio.h>
+#include <sys/types.h>
+#include <sys/wait.h>
+#include <sys/signal.h>
+#include <sys/ipc.h>
+#include <sys/shm.h>
+#include <sys/user.h>
+#include <linux/elf.h>
+#include <linux/types.h>
+#include <linux/auxvec.h>
+#include "../reg.h"
+#include "utils.h"
+
+#define TEST_PASS 0
+#define TEST_FAIL 1
+
+struct ebb_regs {
+	unsigned long	ebbrr;
+	unsigned long	ebbhr;
+	unsigned long	bescr;
+};
+
+struct pmu_regs {
+	unsigned long	siar;
+	unsigned long	sdar;
+	unsigned long	sier;
+	unsigned long	mmcr2;
+	unsigned long	mmcr0;
+};
+
+struct fpr_regs {
+	unsigned long fpr[32];
+	unsigned long fpscr;
+};
+
+
+/* Basic ptrace operations */
+int start_trace(pid_t child)
+{
+	int ret;
+
+	ret = ptrace(PTRACE_ATTACH, child, NULL, NULL);
+	if (ret) {
+		perror("ptrace(PTRACE_ATTACH) failed");
+		return TEST_FAIL;
+	}
+	ret = waitpid(child, NULL, 0);
+	if (ret != child) {
+		perror("waitpid() failed");
+		return TEST_FAIL;
+	}
+	return TEST_PASS;
+}
+
+int stop_trace(pid_t child)
+{
+	int ret;
+
+	ret = ptrace(PTRACE_DETACH, child, NULL, NULL);
+	if (ret) {
+		perror("ptrace(PTRACE_DETACH) failed");
+		return TEST_FAIL;
+	}
+	return TEST_PASS;
+}
+
+int cont_trace(pid_t child)
+{
+	int ret;
+
+	ret = ptrace(PTRACE_CONT, child, NULL, NULL);
+	if (ret) {
+		perror("ptrace(PTRACE_CONT) failed");
+		return TEST_FAIL;
+	}
+	return TEST_PASS;
+}
+
+/* PMU */
+int show_pmu_registers(pid_t child, struct pmu_regs *regs)
+{
+	struct pmu_regs *pmu;
+	struct iovec iov;
+	int ret;
+
+	pmu = malloc(sizeof(struct pmu_regs));
+	if (!pmu) {
+		perror("malloc() failed");
+		return TEST_FAIL;
+	}
+
+	iov.iov_base = (struct pmu_regs *) pmu;
+	iov.iov_len = sizeof(struct pmu_regs);
+	ret = ptrace(PTRACE_GETREGSET, child, NT_PPC_PMU, &iov);
+	if (ret) {
+		perror("ptrace(PTRACE_GETREGSET) failed");
+		goto fail;
+	}
+
+	if (regs)
+		memcpy(regs, pmu, sizeof(struct pmu_regs));
+
+	free(pmu);
+	return TEST_PASS;
+fail:
+	free(pmu);
+	return TEST_FAIL;
+}
+
+/* EBB */
+int show_ebb_registers(pid_t child, struct ebb_regs *regs)
+{
+	struct ebb_regs *ebb;
+	struct iovec iov;
+	int ret;
+
+	ebb = malloc(sizeof(struct ebb_regs));
+	if (!ebb) {
+		perror("malloc() failed");
+		return TEST_FAIL;
+	}
+
+	iov.iov_base = (struct ebb_regs *) ebb;
+	iov.iov_len = sizeof(struct ebb_regs);
+	ret = ptrace(PTRACE_GETREGSET, child, NT_PPC_EBB, &iov);
+	if (ret) {
+		perror("ptrace(PTRACE_GETREGSET) failed");
+		goto fail;
+	}
+
+	if (regs)
+		memcpy(regs, ebb, sizeof(struct ebb_regs));
+
+	free(ebb);
+	return TEST_PASS;
+fail:
+	free(ebb);
+	return TEST_FAIL;
+}
+
+/* Analyse TEXASR after TM failure */
+inline unsigned long get_tfiar(void)
+{
+	unsigned long ret;
+
+	asm volatile("mfspr %0,%1" : "=r" (ret) : "i" (SPRN_TFIAR));
+	return ret;
+}
+
+void analyse_texasr(unsigned long texasr)
+{
+	printf("TEXASR: %16lx\t", texasr);
+
+	if (texasr & TEXASR_FP)
+		printf("TEXASR_FP  ");
+
+	if (texasr & TEXASR_DA)
+		printf("TEXASR_DA  ");
+
+	if (texasr & TEXASR_NO)
+		printf("TEXASR_NO  ");
+
+	if (texasr & TEXASR_FO)
+		printf("TEXASR_FO  ");
+
+	if (texasr & TEXASR_SIC)
+		printf("TEXASR_SIC  ");
+
+	if (texasr & TEXASR_NTC)
+		printf("TEXASR_NTC  ");
+
+	if (texasr & TEXASR_TC)
+		printf("TEXASR_TC  ");
+
+	if (texasr & TEXASR_TIC)
+		printf("TEXASR_TIC  ");
+
+	if (texasr & TEXASR_IC)
+		printf("TEXASR_IC  ");
+
+	if (texasr & TEXASR_IFC)
+		printf("TEXASR_IFC  ");
+
+	if (texasr & TEXASR_ABT)
+		printf("TEXASR_ABT  ");
+
+	if (texasr & TEXASR_SPD)
+		printf("TEXASR_SPD  ");
+
+	if (texasr & TEXASR_HV)
+		printf("TEXASR_HV  ");
+
+	if (texasr & TEXASR_PR)
+		printf("TEXASR_PR  ");
+
+	if (texasr & TEXASR_FS)
+		printf("TEXASR_FS  ");
+
+	if (texasr & TEXASR_TE)
+		printf("TEXASR_TE  ");
+
+	if (texasr & TEXASR_ROT)
+		printf("TEXASR_ROT  ");
+
+	printf("TFIAR :%lx\n", get_tfiar());
+}
-- 
1.8.3.1

Return-Path: <khandual@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id CC9E31A0688
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 May 2015 01:08:52 +1000 (AEST)
Received: from e28smtp06.in.ibm.com (e28smtp06.in.ibm.com [122.248.162.6])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id CF94C140E10
 for <linuxppc-dev@ozlabs.org>; Wed, 20 May 2015 01:08:51 +1000 (AEST)
Received: from /spool/local
 by e28smtp06.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <khandual@linux.vnet.ibm.com>;
 Tue, 19 May 2015 20:38:49 +0530
Received: from d28relay02.in.ibm.com (d28relay02.in.ibm.com [9.184.220.59])
 by d28dlp02.in.ibm.com (Postfix) with ESMTP id 978793940068
 for <linuxppc-dev@ozlabs.org>; Tue, 19 May 2015 20:38:47 +0530 (IST)
Received: from d28av04.in.ibm.com (d28av04.in.ibm.com [9.184.220.66])
 by d28relay02.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t4JF8aKH66977828
 for <linuxppc-dev@ozlabs.org>; Tue, 19 May 2015 20:38:37 +0530
Received: from d28av04.in.ibm.com (localhost [127.0.0.1])
 by d28av04.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t4JF8Vd0028552
 for <linuxppc-dev@ozlabs.org>; Tue, 19 May 2015 20:38:35 +0530
From: Anshuman Khandual <khandual@linux.vnet.ibm.com>
To: linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org
Subject: [PATCH V8 17/28] selftests, powerpc: Add ptrace tests for EBB
Date: Tue, 19 May 2015 20:38:13 +0530
Message-Id: <1432048104-4695-18-git-send-email-khandual@linux.vnet.ibm.com>
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

This patch adds ptrace interface test for EBB specific
registers. This also adds some generic ptrace interface
based helper functions to be used by other patches later
on in the series.

Signed-off-by: Anshuman Khandual <khandual@linux.vnet.ibm.com>
---
 tools/testing/selftests/powerpc/Makefile           |   2 +-
 tools/testing/selftests/powerpc/ptrace/Makefile    |   7 +
 .../testing/selftests/powerpc/ptrace/ptrace-ebb.c  | 144 +++++++++++++
 .../testing/selftests/powerpc/ptrace/ptrace-ebb.h  |  98 +++++++++
 tools/testing/selftests/powerpc/ptrace/ptrace.h    | 224 +++++++++++++++++++++
 5 files changed, 474 insertions(+), 1 deletion(-)
 create mode 100644 tools/testing/selftests/powerpc/ptrace/Makefile
 create mode 100644 tools/testing/selftests/powerpc/ptrace/ptrace-ebb.c
 create mode 100644 tools/testing/selftests/powerpc/ptrace/ptrace-ebb.h
 create mode 100644 tools/testing/selftests/powerpc/ptrace/ptrace.h

diff --git a/tools/testing/selftests/powerpc/Makefile b/tools/testing/selftests/powerpc/Makefile
index 5ad0423..8a5ba16 100644
--- a/tools/testing/selftests/powerpc/Makefile
+++ b/tools/testing/selftests/powerpc/Makefile
@@ -12,7 +12,7 @@ CFLAGS := -Wall -O2 -flto -Wall -Werror -DGIT_VERSION='"$(GIT_VERSION)"' -I$(CUR
 
 export CFLAGS
 
-SUB_DIRS = pmu copyloops mm tm primitives stringloops vphn switch_endian
+SUB_DIRS = pmu copyloops mm tm primitives stringloops vphn switch_endian ptrace
 
 endif
 
diff --git a/tools/testing/selftests/powerpc/ptrace/Makefile b/tools/testing/selftests/powerpc/ptrace/Makefile
new file mode 100644
index 0000000..59386ba
--- /dev/null
+++ b/tools/testing/selftests/powerpc/ptrace/Makefile
@@ -0,0 +1,7 @@
+TEST_PROGS := ptrace-ebb
+all: $(TEST_PROGS)
+
+$(TEST_PROGS): ../harness.c
+ptrace-ebb: ../pmu/event.c ../pmu/lib.c ../pmu/ebb/ebb_handler.S ../pmu/ebb/busy_loop.S
+clean:
+	rm -f $(TEST_PROGS) *.o
diff --git a/tools/testing/selftests/powerpc/ptrace/ptrace-ebb.c b/tools/testing/selftests/powerpc/ptrace/ptrace-ebb.c
new file mode 100644
index 0000000..56218c5
--- /dev/null
+++ b/tools/testing/selftests/powerpc/ptrace/ptrace-ebb.c
@@ -0,0 +1,144 @@
+/*
+ * Ptrace interface test for EBB
+ *
+ * Copyright 2015 Anshuman Khandual, IBM Corporation.
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
+void ebb(void)
+{
+	struct event event;
+
+	event_init_named(&event, 0x1001e, "cycles");
+	event.attr.config |= (1ull << 63);
+        event.attr.exclusive = 1;
+        event.attr.pinned = 1;
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
+	mb();
+
+	if (ebb_event_enable(&event)) {
+		perror("ebb_event_handler() failed");
+		exit(1);
+	}
+
+	mtspr(SPRN_PMC1, pmc_sample_period(SAMPLE_PERIOD));
+	while(1)
+		core_busy_loop();
+	exit(0);
+}
+
+int validate_ebb(struct ebb_regs *regs)
+{
+	struct opd *opd;
+
+	printf("EBBRR: %lx\n", regs->ebbrr);
+	printf("EBBHR: %lx\n", regs->ebbhr);
+	printf("BESCR: %lx\n", regs->bescr);
+	printf("SIAR:  %lx\n", regs->siar);
+	printf("SDAR:  %lx\n", regs->sdar);
+	printf("SIER:  %lx\n", regs->sier);
+	printf("MMCR2: %lx\n", regs->mmcr2);
+	printf("MMCR0: %lx\n", regs->mmcr0);
+
+	/* Validate EBBHR */
+	opd= (struct opd *) ebb_handler;
+	if (regs->ebbhr != opd->entry)
+		return TEST_FAIL;
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
+int trace_ebb(pid_t child)
+{
+	struct ebb_regs regs;
+	int ret;
+
+	sleep(2);
+	ret = start_trace(child);
+	if (ret)
+		return TEST_FAIL;
+
+	ret = show_ebb_registers(child, &regs);
+	if (ret)
+		return TEST_FAIL;
+
+	ret = validate_ebb(&regs);
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
+int ptrace_ebb(void)
+{
+	pid_t pid;
+	int ret, status;
+
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
+		ret = trace_ebb(pid);
+		if (ret)
+			return TEST_FAIL;
+
+		kill(pid, SIGKILL);
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
+	return test_harness(ptrace_ebb, "ptrace_ebb");
+}
diff --git a/tools/testing/selftests/powerpc/ptrace/ptrace-ebb.h b/tools/testing/selftests/powerpc/ptrace/ptrace-ebb.h
new file mode 100644
index 0000000..1550ab1
--- /dev/null
+++ b/tools/testing/selftests/powerpc/ptrace/ptrace-ebb.h
@@ -0,0 +1,98 @@
+/*
+ * Inspired mostly from the EBB selftest
+ *
+ * Copyright 2015 Anshuman Khandual, IBM Corporation.
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version
+ * 2 of the License, or (at your option) any later version.
+ */
+#define SAMPLE_PERIOD 100	/* EBB event sample persiod */
+
+/* Standard expected values */
+#define MMCR0_EXP	0x8000008000000001
+#define MMCR2_EXP	0
+#define SIER_EXP	0x2000000
+
+struct opd
+{
+	u64 entry;
+	u64 toc;
+};
+
+void (*ebb_user_func)(void);
+extern void ebb_handler(void);	/* Defined in ebb_handle.S */
+
+void ebb_hook(void)		/* Called by ebb_handler */
+{
+        if (ebb_user_func)
+                ebb_user_func();
+}
+
+void setup_ebb_handler(void (*callee)(void))
+{
+        u64 entry;
+
+#if defined(_CALL_ELF) && _CALL_ELF == 2
+        entry = (u64)ebb_handler;
+#else
+	struct opd *opd;
+
+        opd = (struct opd *)ebb_handler;
+        entry = opd->entry;
+#endif
+        ebb_user_func = callee;
+
+        /* Ensure ebb_user_func is set before we set the handler */
+        mb();
+        mtspr(SPRN_EBBHR, entry);
+
+        /* Make sure the handler is set before we return */
+        mb();
+}
+
+void reset_ebb_with_clear_mask(unsigned long mmcr0_clear_mask)
+{
+        u64 val;
+
+        /* 2) clear MMCR0[PMAO] - docs say BESCR[PMEO] should do this */
+        /* 3) set MMCR0[PMAE]   - docs say BESCR[PME] should do this */
+        val = mfspr(SPRN_MMCR0);
+        mtspr(SPRN_MMCR0, (val & ~mmcr0_clear_mask) | MMCR0_PMAE);
+
+        /* 4) clear BESCR[PMEO] */
+        mtspr(SPRN_BESCRR, BESCR_PMEO);
+
+        /* 5) set BESCR[PME] */
+        mtspr(SPRN_BESCRS, BESCR_PME);
+
+        /* 6) rfebb 1 - done in our caller */
+}
+
+void standard_ebb_callee(void)
+{
+	u64 val;
+
+	val = mfspr(SPRN_BESCR);
+        if (!(val & BESCR_PMEO))
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
+	mb();
+
+        rc = ioctl(e->fd, PERF_EVENT_IOC_ENABLE);
+        if (rc)
+                return rc;
+        rc = event_read(e);
+
+        mb();
+        return rc;
+}
diff --git a/tools/testing/selftests/powerpc/ptrace/ptrace.h b/tools/testing/selftests/powerpc/ptrace/ptrace.h
new file mode 100644
index 0000000..65553a6
--- /dev/null
+++ b/tools/testing/selftests/powerpc/ptrace/ptrace.h
@@ -0,0 +1,224 @@
+/*
+ * Ptrace interface test helper functions
+ *
+ * Copyright 2015 Anshuman Khandual, IBM Corporation.
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
+#include "../reg.h"
+#include "utils.h"
+
+/* ELF core note sections */
+#define NT_PPC_TAR	0x103		/* Target Address Register */
+#define NT_PPC_PPR	0x104		/* Program Priority Register */
+#define NT_PPC_DSCR	0x105		/* Data Stream Control Register */
+#define NT_PPC_EBB	0x106		/* Event Based Branch Registers */
+#define NT_PPC_TM_CGPR	0x107		/* TM checkpointed GPR Registers */
+#define NT_PPC_TM_CFPR	0x108		/* TM checkpointed FPR Registers */
+#define NT_PPC_TM_CVMX	0x109		/* TM checkpointed VMX Registers */
+#define NT_PPC_TM_CVSX	0x10a		/* TM checkpointed VSX Registers */
+#define NT_PPC_TM_SPR	0x10b		/* TM Special Purpose Registers */
+#define NT_PPC_TM_CTAR	0x10c		/* TM checkpointed Target Address Register */
+#define NT_PPC_TM_CPPR	0x10d		/* TM checkpointed Program Priority Register */
+#define NT_PPC_TM_CDSCR	0x10e		/* TM checkpointed Data Stream Control Register */
+
+/* TEXASR register bits */
+#define TEXASR_FC	0xFE00000000000000
+#define TEXASR_FP	0x0100000000000000
+#define TEXASR_DA	0x0080000000000000
+#define TEXASR_NO	0x0040000000000000
+#define TEXASR_FO	0x0020000000000000
+#define TEXASR_SIC	0x0010000000000000
+#define TEXASR_NTC	0x0008000000000000
+#define TEXASR_TC	0x0004000000000000
+#define TEXASR_TIC	0x0002000000000000
+#define TEXASR_IC	0x0001000000000000
+#define TEXASR_IFC	0x0000800000000000
+#define TEXASR_ABT	0x0000000100000000
+#define TEXASR_SPD	0x0000000080000000
+#define TEXASR_HV	0x0000000020000000
+#define TEXASR_PR	0x0000000010000000
+#define TEXASR_FS	0x0000000008000000
+#define TEXASR_TE	0x0000000004000000
+#define TEXASR_ROT	0x0000000002000000
+
+#define TEST_PASS 0
+#define TEST_FAIL 1
+
+struct ebb_regs {
+	unsigned long	ebbrr;
+	unsigned long	ebbhr;
+	unsigned long	bescr;
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
+	asm volatile("mfspr %0,%1" : "=r" (ret): "i" (SPRN_TFIAR));
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
2.1.0

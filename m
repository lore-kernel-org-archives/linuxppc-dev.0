Return-Path: <cyrilbur@gmail.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sgNV94DcmzDsml
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 23 Sep 2016 16:18:57 +1000 (AEST)
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
 u8N6HcGh110197
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 23 Sep 2016 02:18:54 -0400
Received: from e23smtp06.au.ibm.com (e23smtp06.au.ibm.com [202.81.31.148])
 by mx0a-001b2d01.pphosted.com with ESMTP id 25mqb4sn50-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 23 Sep 2016 02:18:54 -0400
Received: from localhost
 by e23smtp06.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <cyrilbur@gmail.com>;
 Fri, 23 Sep 2016 16:18:51 +1000
Received: from d23relay08.au.ibm.com (d23relay08.au.ibm.com [9.185.71.33])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id 065D62BB0065
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 23 Sep 2016 16:18:49 +1000 (EST)
Received: from d23av05.au.ibm.com (d23av05.au.ibm.com [9.190.234.119])
 by d23relay08.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u8N6Imfw2425200
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 23 Sep 2016 16:18:48 +1000
Received: from d23av05.au.ibm.com (localhost [127.0.0.1])
 by d23av05.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u8N6ImP6011106
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 23 Sep 2016 16:18:48 +1000
From: Cyril Bur <cyrilbur@gmail.com>
To: mpe@ellerman.id.au, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v5 14/20] selftests/powerpc: Add checks for transactional GPRs
 in signal contexts
Date: Fri, 23 Sep 2016 16:18:20 +1000
In-Reply-To: <20160923061826.30790-1-cyrilbur@gmail.com>
References: <20160923061826.30790-1-cyrilbur@gmail.com>
Message-Id: <20160923061826.30790-15-cyrilbur@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

If a thread receives a signal while transactional the kernel creates a
second context to show the transactional state of the process. This
test loads some known values and waits for a signal and confirms that
the expected values are in the signal context.

Signed-off-by: Cyril Bur <cyrilbur@gmail.com>
---
 tools/testing/selftests/powerpc/tm/Makefile        |   7 +-
 .../powerpc/tm/tm-signal-context-chk-gpr.c         |  90 ++++++++++++++++
 tools/testing/selftests/powerpc/tm/tm-signal.S     | 114 +++++++++++++++++++++
 3 files changed, 210 insertions(+), 1 deletion(-)
 create mode 100644 tools/testing/selftests/powerpc/tm/tm-signal-context-chk-gpr.c
 create mode 100644 tools/testing/selftests/powerpc/tm/tm-signal.S

diff --git a/tools/testing/selftests/powerpc/tm/Makefile b/tools/testing/selftests/powerpc/tm/Makefile
index 9d301d7..2b6fe8f 100644
--- a/tools/testing/selftests/powerpc/tm/Makefile
+++ b/tools/testing/selftests/powerpc/tm/Makefile
@@ -1,5 +1,7 @@
+SIGNAL_CONTEXT_CHK_TESTS := tm-signal-context-chk-gpr
+
 TEST_PROGS := tm-resched-dscr tm-syscall tm-signal-msr-resv tm-signal-stack \
-	tm-vmxcopy tm-fork tm-tar tm-tmspr tm-exec tm-execed
+	tm-vmxcopy tm-fork tm-tar tm-tmspr $(SIGNAL_CONTEXT_CHK_TESTS)
 
 all: $(TEST_PROGS)
 
@@ -11,6 +13,9 @@ tm-syscall: tm-syscall-asm.S
 tm-syscall: CFLAGS += -I../../../../../usr/include
 tm-tmspr: CFLAGS += -pthread
 
+$(SIGNAL_CONTEXT_CHK_TESTS): tm-signal.S
+$(SIGNAL_CONTEXT_CHK_TESTS): CFLAGS += -mhtm -m64
+
 include ../../lib.mk
 
 clean:
diff --git a/tools/testing/selftests/powerpc/tm/tm-signal-context-chk-gpr.c b/tools/testing/selftests/powerpc/tm/tm-signal-context-chk-gpr.c
new file mode 100644
index 0000000..df91330
--- /dev/null
+++ b/tools/testing/selftests/powerpc/tm/tm-signal-context-chk-gpr.c
@@ -0,0 +1,90 @@
+/*
+ * Copyright 2016, Cyril Bur, IBM Corp.
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version
+ * 2 of the License, or (at your option) any later version.
+ *
+ *
+ * Test the kernel's signal frame code.
+ *
+ * The kernel sets up two sets of ucontexts if the signal was to be
+ * delivered while the thread was in a transaction.
+ * Expected behaviour is that the checkpointed state is in the user
+ * context passed to the signal handler. The speculated state can be
+ * accessed with the uc_link pointer.
+ *
+ * The rationale for this is that if TM unaware code (which linked
+ * against TM libs) installs a signal handler it will not know of the
+ * speculative nature of the 'live' registers and may infer the wrong
+ * thing.
+ */
+
+#include <stdlib.h>
+#include <stdio.h>
+#include <signal.h>
+#include <unistd.h>
+
+#include <altivec.h>
+
+#include "utils.h"
+#include "tm.h"
+
+#define MAX_ATTEMPT 500000
+
+#define NV_GPR_REGS 18
+
+long tm_signal_self_context_load(pid_t pid, long *gprs, double *fps, vector int *vms, vector int *vss);
+
+static sig_atomic_t fail;
+
+static long gps[] = { 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18,
+					 -1,-2,-3,-4,-5,-6,-7,-8,-9,-10,-11,-12,-13,-14,-15,-16,-17,-18};
+
+static void signal_usr1(int signum, siginfo_t *info, void *uc)
+{
+	int i;
+	ucontext_t *ucp = uc;
+	ucontext_t *tm_ucp = ucp->uc_link;
+
+	for (i = 0; i < NV_GPR_REGS && !fail; i++) {
+		fail = (ucp->uc_mcontext.gp_regs[i + 14] != gps[i]);
+		fail |= (tm_ucp->uc_mcontext.gp_regs[i + 14] != gps[i + NV_GPR_REGS]);
+		if (fail)
+			printf("Failed on %d GPR %lu or %lu\n", i,
+					ucp->uc_mcontext.gp_regs[i + 14], tm_ucp->uc_mcontext.gp_regs[i + 14]);
+	}
+}
+
+static int tm_signal_context_chk_gpr()
+{
+	struct sigaction act;
+	int i;
+	long rc;
+	pid_t pid = getpid();
+
+	SKIP_IF(!have_htm());
+
+	act.sa_sigaction = signal_usr1;
+	sigemptyset(&act.sa_mask);
+	act.sa_flags = SA_SIGINFO;
+	if (sigaction(SIGUSR1, &act, NULL) < 0) {
+		perror("sigaction sigusr1");
+		exit(1);
+	}
+
+	i = 0;
+	while (i < MAX_ATTEMPT && !fail) {
+		rc = tm_signal_self_context_load(pid, gps, NULL, NULL, NULL);
+		FAIL_IF(rc != pid);
+		i++;
+	}
+
+	return fail;
+}
+
+int main(void)
+{
+	return test_harness(tm_signal_context_chk_gpr, "tm_signal_context_chk_gpr");
+}
diff --git a/tools/testing/selftests/powerpc/tm/tm-signal.S b/tools/testing/selftests/powerpc/tm/tm-signal.S
new file mode 100644
index 0000000..4e13e8b
--- /dev/null
+++ b/tools/testing/selftests/powerpc/tm/tm-signal.S
@@ -0,0 +1,114 @@
+/*
+ * Copyright 2015, Cyril Bur, IBM Corp.
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version
+ * 2 of the License, or (at your option) any later version.
+ */
+
+#include "../basic_asm.h"
+#include "../gpr_asm.h"
+#include "../fpu_asm.h"
+#include "../vmx_asm.h"
+#include "../vsx_asm.h"
+
+/*
+ * Large caveat here being that the caller cannot expect the
+ * signal to always be sent! The hardware can (AND WILL!) abort
+ * the transaction between the tbegin and the tsuspend (however
+ * unlikely it seems or infrequently it actually happens).
+ * You have been warned.
+ */
+/* long tm_signal_self(pid_t pid, long *gprs, double *fps, vector *vms, vector *vss); */
+FUNC_START(tm_signal_self_context_load)
+	PUSH_BASIC_STACK(512)
+	/*
+	 * Don't strictly need to save and restore as it depends on if
+	 * we're going to use them, however this reduces messy logic
+	 */
+	PUSH_VMX(STACK_FRAME_LOCAL(5,0),r8)
+	PUSH_FPU(512)
+	PUSH_NVREGS_BELOW_FPU(512)
+	std r3, STACK_FRAME_PARAM(0)(sp) /* pid */
+	std r4, STACK_FRAME_PARAM(1)(sp) /* gps */
+	std r5, STACK_FRAME_PARAM(2)(sp) /* fps */
+	std r6, STACK_FRAME_PARAM(3)(sp) /* vms */
+	std r7, STACK_FRAME_PARAM(4)(sp) /* vss */
+
+	ld r3, STACK_FRAME_PARAM(1)(sp)
+	cmpdi r3, 0
+	beq skip_gpr_lc
+	bl load_gpr
+skip_gpr_lc:
+	ld r3, STACK_FRAME_PARAM(2)(sp)
+	cmpdi	r3, 0
+	beq	skip_fpu_lc
+	bl load_fpu
+skip_fpu_lc:
+	ld r3, STACK_FRAME_PARAM(3)(sp)
+	cmpdi r3, 0
+	beq	skip_vmx_lc
+	bl load_vmx
+skip_vmx_lc:
+	ld r3, STACK_FRAME_PARAM(4)(sp)
+	cmpdi	r3, 0
+	beq	skip_vsx_lc
+	bl load_vsx
+skip_vsx_lc:
+	/*
+	 * Set r3 (return value) before tbegin. Use the pid as a known
+	 * 'all good' return value, zero is used to indicate a non-doomed
+	 * transaction.
+	 */
+	ld	r3, STACK_FRAME_PARAM(0)(sp)
+	tbegin.
+	beq	1f
+	tsuspend. /* Can't enter a syscall transactionally */
+	ld	r3, STACK_FRAME_PARAM(1)(sp)
+	cmpdi	r3, 0
+	beq skip_gpr_lt
+	/* Get the second half of the array */
+	addi	r3, r3, 8 * 18
+	bl load_gpr
+skip_gpr_lt:
+	ld r3, STACK_FRAME_PARAM(2)(sp)
+	cmpdi	r3, 0
+	beq	skip_fpu_lt
+	/* Get the second half of the array */
+	addi	r3, r3, 8 * 18
+	bl load_fpu
+skip_fpu_lt:
+	ld r3, STACK_FRAME_PARAM(3)(sp)
+	cmpdi r3, 0
+	beq	skip_vmx_lt
+	/* Get the second half of the array */
+	addi	r3, r3, 16 * 12
+	bl load_vmx
+skip_vmx_lt:
+	ld r3, STACK_FRAME_PARAM(4)(sp)
+	cmpdi	r3, 0
+	beq	skip_vsx_lt
+	/* Get the second half of the array */
+	addi	r3, r3, 16 * 12
+	bl load_vsx
+skip_vsx_lt:
+	li	r0, 37 /* sys_kill */
+	ld r3, STACK_FRAME_PARAM(0)(sp) /* pid */
+	li r4, 10 /* SIGUSR1 */
+	sc /* Taking the signal will doom the transaction */
+	tabort. 0
+	tresume. /* Be super sure we abort */
+	/*
+	 * This will cause us to resume doomed transaction and cause
+	 * hardware to cleanup, we'll end up at 1: anything between
+	 * tresume. and 1: shouldn't ever run.
+	 */
+	li r3, 0
+	1:
+	POP_VMX(STACK_FRAME_LOCAL(5,0),r4)
+	POP_FPU(512)
+	POP_NVREGS_BELOW_FPU(512)
+	POP_BASIC_STACK(512)
+	blr
+FUNC_END(tm_signal_self_context_load)
-- 
2.10.0

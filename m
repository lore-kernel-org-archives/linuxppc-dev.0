Return-Path: <wei.guo.simon@gmail.com>
Received: from mail-pf0-x244.google.com (mail-pf0-x244.google.com
 [IPv6:2607:f8b0:400e:c00::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3s0GnP06vbzDrP3
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 28 Jul 2016 13:00:25 +1000 (AEST)
Received: by mail-pf0-x244.google.com with SMTP id h186so2825193pfg.2
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 27 Jul 2016 20:00:24 -0700 (PDT)
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
Subject: [PATCH v13 20/30] selftests/powerpc: Add ptrace tests for GPR/FPR
 registers in TM
Date: Thu, 28 Jul 2016 10:57:49 +0800
Message-Id: <1469674679-8580-21-git-send-email-wei.guo.simon@gmail.com>
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

This patch adds ptrace interface test for GPR/FPR registers
inside TM context. This adds ptrace interface based helper
functions related to checkpointed GPR/FPR access.

Signed-off-by: Anshuman Khandual <khandual@linux.vnet.ibm.com>
Signed-off-by: Simon Guo <wei.guo.simon@gmail.com>
---
 tools/testing/selftests/powerpc/ptrace/Makefile    |   3 +-
 .../selftests/powerpc/ptrace/ptrace-tm-gpr.c       | 299 +++++++++++++++++++++
 2 files changed, 301 insertions(+), 1 deletion(-)
 create mode 100644 tools/testing/selftests/powerpc/ptrace/ptrace-tm-gpr.c

diff --git a/tools/testing/selftests/powerpc/ptrace/Makefile b/tools/testing/selftests/powerpc/ptrace/Makefile
index 31e8e33..170683a 100644
--- a/tools/testing/selftests/powerpc/ptrace/Makefile
+++ b/tools/testing/selftests/powerpc/ptrace/Makefile
@@ -1,8 +1,9 @@
-TEST_PROGS := ptrace-ebb ptrace-gpr
+TEST_PROGS := ptrace-ebb ptrace-gpr ptrace-tm-gpr
 
 all: $(TEST_PROGS)
 CFLAGS += -m64
 $(TEST_PROGS): ../harness.c ptrace.S ../utils.c ptrace.h
 ptrace-ebb: ../pmu/event.c ../pmu/lib.c ../pmu/ebb/ebb_handler.S ../pmu/ebb/busy_loop.S
+
 clean:
 	rm -f $(TEST_PROGS) *.o
diff --git a/tools/testing/selftests/powerpc/ptrace/ptrace-tm-gpr.c b/tools/testing/selftests/powerpc/ptrace/ptrace-tm-gpr.c
new file mode 100644
index 0000000..51eb71e
--- /dev/null
+++ b/tools/testing/selftests/powerpc/ptrace/ptrace-tm-gpr.c
@@ -0,0 +1,299 @@
+/*
+ * Ptrace test for GPR/FPR registers in TM context
+ *
+ * Copyright (C) 2015 Anshuman Khandual, IBM Corporation.
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version
+ * 2 of the License, or (at your option) any later version.
+ */
+#include "ptrace.h"
+#include "ptrace-gpr.h"
+
+/* Tracer and Tracee Shared Data */
+int shm_id;
+volatile unsigned long *cptr, *pptr;
+
+void store_gpr(unsigned long *addr);
+void store_fpr(float *addr);
+
+float a = FPR_1;
+float b = FPR_2;
+float c = FPR_3;
+
+void tm_gpr(void)
+{
+	unsigned long gpr_buf[18];
+	unsigned long result, texasr;
+	float fpr_buf[32];
+
+	printf("Starting the child\n");
+	cptr = (unsigned long *)shmat(shm_id, NULL, 0);
+
+trans:
+	cptr[1] = 0;
+	asm __volatile__(
+
+		"li 14, %[gpr_1];"
+		"li 15, %[gpr_1];"
+		"li 16, %[gpr_1];"
+		"li 17, %[gpr_1];"
+		"li 18, %[gpr_1];"
+		"li 19, %[gpr_1];"
+		"li 20, %[gpr_1];"
+		"li 21, %[gpr_1];"
+		"li 22, %[gpr_1];"
+		"li 23, %[gpr_1];"
+		"li 24, %[gpr_1];"
+		"li 25, %[gpr_1];"
+		"li 26, %[gpr_1];"
+		"li 27, %[gpr_1];"
+		"li 28, %[gpr_1];"
+		"li 29, %[gpr_1];"
+		"li 30, %[gpr_1];"
+		"li 31, %[gpr_1];"
+
+		"lfs 0, 0(%[flt_1]);"
+		"lfs 1, 0(%[flt_1]);"
+		"lfs 2, 0(%[flt_1]);"
+		"lfs 3, 0(%[flt_1]);"
+		"lfs 4, 0(%[flt_1]);"
+		"lfs 5, 0(%[flt_1]);"
+		"lfs 6, 0(%[flt_1]);"
+		"lfs 7, 0(%[flt_1]);"
+		"lfs 8, 0(%[flt_1]);"
+		"lfs 9, 0(%[flt_1]);"
+		"lfs 10, 0(%[flt_1]);"
+		"lfs 11, 0(%[flt_1]);"
+		"lfs 12, 0(%[flt_1]);"
+		"lfs 13, 0(%[flt_1]);"
+		"lfs 14, 0(%[flt_1]);"
+		"lfs 15, 0(%[flt_1]);"
+		"lfs 16, 0(%[flt_1]);"
+		"lfs 17, 0(%[flt_1]);"
+		"lfs 18, 0(%[flt_1]);"
+		"lfs 19, 0(%[flt_1]);"
+		"lfs 20, 0(%[flt_1]);"
+		"lfs 21, 0(%[flt_1]);"
+		"lfs 22, 0(%[flt_1]);"
+		"lfs 23, 0(%[flt_1]);"
+		"lfs 24, 0(%[flt_1]);"
+		"lfs 25, 0(%[flt_1]);"
+		"lfs 26, 0(%[flt_1]);"
+		"lfs 27, 0(%[flt_1]);"
+		"lfs 28, 0(%[flt_1]);"
+		"lfs 29, 0(%[flt_1]);"
+		"lfs 30, 0(%[flt_1]);"
+		"lfs 31, 0(%[flt_1]);"
+
+		"1: ;"
+		TBEGIN
+		"beq 2f;"
+
+		"li 14, %[gpr_2];"
+		"li 15, %[gpr_2];"
+		"li 16, %[gpr_2];"
+		"li 17, %[gpr_2];"
+		"li 18, %[gpr_2];"
+		"li 19, %[gpr_2];"
+		"li 20, %[gpr_2];"
+		"li 21, %[gpr_2];"
+		"li 22, %[gpr_2];"
+		"li 23, %[gpr_2];"
+		"li 24, %[gpr_2];"
+		"li 25, %[gpr_2];"
+		"li 26, %[gpr_2];"
+		"li 27, %[gpr_2];"
+		"li 28, %[gpr_2];"
+		"li 29, %[gpr_2];"
+		"li 30, %[gpr_2];"
+		"li 31, %[gpr_2];"
+
+
+		"lfs 0, 0(%[flt_2]);"
+		"lfs 1, 0(%[flt_2]);"
+		"lfs 2, 0(%[flt_2]);"
+		"lfs 3, 0(%[flt_2]);"
+		"lfs 4, 0(%[flt_2]);"
+		"lfs 5, 0(%[flt_2]);"
+		"lfs 6, 0(%[flt_2]);"
+		"lfs 7, 0(%[flt_2]);"
+		"lfs 8, 0(%[flt_2]);"
+		"lfs 9, 0(%[flt_2]);"
+		"lfs 10, 0(%[flt_2]);"
+		"lfs 11, 0(%[flt_2]);"
+		"lfs 12, 0(%[flt_2]);"
+		"lfs 13, 0(%[flt_2]);"
+		"lfs 14, 0(%[flt_2]);"
+		"lfs 15, 0(%[flt_2]);"
+		"lfs 16, 0(%[flt_2]);"
+		"lfs 17, 0(%[flt_2]);"
+		"lfs 18, 0(%[flt_2]);"
+		"lfs 19, 0(%[flt_2]);"
+		"lfs 20, 0(%[flt_2]);"
+		"lfs 21, 0(%[flt_2]);"
+		"lfs 22, 0(%[flt_2]);"
+		"lfs 23, 0(%[flt_2]);"
+		"lfs 24, 0(%[flt_2]);"
+		"lfs 25, 0(%[flt_2]);"
+		"lfs 26, 0(%[flt_2]);"
+		"lfs 27, 0(%[flt_2]);"
+		"lfs 28, 0(%[flt_2]);"
+		"lfs 29, 0(%[flt_2]);"
+		"lfs 30, 0(%[flt_2]);"
+		"lfs 31, 0(%[flt_2]);"
+		TSUSPEND
+		"li 7, 1;"
+		"stw 7, 0(%[cptr1]);"
+		TRESUME
+		"b .;"
+
+		TEND
+		"li 0, 0;"
+		"ori %[res], 0, 0;"
+		"b 3f;"
+
+		/* Transaction abort handler */
+		"2: ;"
+		"li 0, 1;"
+		"ori %[res], 0, 0;"
+		"mfspr %[texasr], %[sprn_texasr];"
+
+		"3: ;"
+		: [res] "=r" (result), [texasr] "=r" (texasr)
+		: [gpr_1]"i"(GPR_1), [gpr_2]"i"(GPR_2),
+		[sprn_texasr] "i" (SPRN_TEXASR), [flt_1] "r" (&a),
+		[flt_2] "r" (&b), [cptr1] "r" (&cptr[1])
+		: "memory", "r7", "r8", "r9", "r10",
+		"r11", "r12", "r13", "r14", "r15", "r16",
+		"r17", "r18", "r19", "r20", "r21", "r22",
+		"r23", "r24", "r25", "r26", "r27", "r28",
+		"r29", "r30", "r31"
+		);
+
+	if (result) {
+		if (!cptr[0])
+			goto trans;
+
+		shmdt((void *)cptr);
+		store_gpr(gpr_buf);
+		store_fpr(fpr_buf);
+
+		if (validate_gpr(gpr_buf, GPR_3))
+			exit(1);
+
+		if (validate_fpr_float(fpr_buf, c))
+			exit(1);
+
+		exit(0);
+	}
+	shmdt((void *)cptr);
+	exit(1);
+}
+
+int trace_tm_gpr(pid_t child)
+{
+	unsigned long gpr[18];
+	unsigned long fpr[32];
+	int ret;
+
+	ret = start_trace(child);
+	if (ret)
+		return TEST_FAIL;
+
+	ret = show_gpr(child, gpr);
+	if (ret)
+		return TEST_FAIL;
+
+	ret = validate_gpr(gpr, GPR_2);
+	if (ret)
+		return TEST_FAIL;
+
+	ret = show_fpr(child, fpr);
+	if (ret)
+		return TEST_FAIL;
+
+	ret = validate_fpr(fpr, FPR_2_REP);
+	if (ret)
+		return TEST_FAIL;
+
+	ret = show_ckpt_fpr(child, fpr);
+	if (ret)
+		return TEST_FAIL;
+
+	ret = validate_fpr(fpr, FPR_1_REP);
+	if (ret)
+		return TEST_FAIL;
+
+	ret = show_ckpt_gpr(child, gpr);
+	if (ret)
+		return TEST_FAIL;
+
+	ret = validate_gpr(gpr, GPR_1);
+	if (ret)
+		return TEST_FAIL;
+
+	ret = write_ckpt_gpr(child, GPR_3);
+	if (ret)
+		return TEST_FAIL;
+
+	ret = write_ckpt_fpr(child, FPR_3_REP);
+	if (ret)
+		return TEST_FAIL;
+
+	pptr[0] = 1;
+	ret = stop_trace(child);
+	if (ret)
+		return TEST_FAIL;
+
+	return TEST_PASS;
+}
+
+int ptrace_tm_gpr(void)
+{
+	pid_t pid;
+	int ret, status;
+
+	SKIP_IF(!((long)get_auxv_entry(AT_HWCAP2) & PPC_FEATURE2_HTM));
+	shm_id = shmget(IPC_PRIVATE, sizeof(int) * 2, 0777|IPC_CREAT);
+	pid = fork();
+	if (pid < 0) {
+		perror("fork() failed");
+		return TEST_FAIL;
+	}
+	if (pid == 0)
+		tm_gpr();
+
+	if (pid) {
+		pptr = (unsigned long *)shmat(shm_id, NULL, 0);
+
+		while (!pptr[1]);
+		ret = trace_tm_gpr(pid);
+		if (ret) {
+			kill(pid, SIGTERM);
+			return TEST_FAIL;
+		}
+
+		shmdt((void *)pptr);
+
+		ret = wait(&status);
+		shmctl(shm_id, IPC_RMID, NULL);
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
+	return test_harness(ptrace_tm_gpr, "ptrace_tm_gpr");
+}
-- 
1.8.3.1

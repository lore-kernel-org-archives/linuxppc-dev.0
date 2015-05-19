Return-Path: <khandual@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 9B24F1A0BA8
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 May 2015 01:09:57 +1000 (AEST)
Received: from e28smtp07.in.ibm.com (e28smtp07.in.ibm.com [122.248.162.7])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id F23ED140D4E
 for <linuxppc-dev@ozlabs.org>; Wed, 20 May 2015 01:09:56 +1000 (AEST)
Received: from /spool/local
 by e28smtp07.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <khandual@linux.vnet.ibm.com>;
 Tue, 19 May 2015 20:39:55 +0530
Received: from d28relay03.in.ibm.com (d28relay03.in.ibm.com [9.184.220.60])
 by d28dlp01.in.ibm.com (Postfix) with ESMTP id 27D11E0059
 for <linuxppc-dev@ozlabs.org>; Tue, 19 May 2015 20:42:57 +0530 (IST)
Received: from d28av04.in.ibm.com (d28av04.in.ibm.com [9.184.220.66])
 by d28relay03.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t4JF9q7d7471146
 for <linuxppc-dev@ozlabs.org>; Tue, 19 May 2015 20:39:52 +0530
Received: from d28av04.in.ibm.com (localhost [127.0.0.1])
 by d28av04.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t4JF8WuM028765
 for <linuxppc-dev@ozlabs.org>; Tue, 19 May 2015 20:38:36 +0530
From: Anshuman Khandual <khandual@linux.vnet.ibm.com>
To: linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org
Subject: [PATCH V8 22/28] selftests, powerpc: Add ptrace tests for TAR, PPR,
 DSCR in TM
Date: Tue, 19 May 2015 20:38:18 +0530
Message-Id: <1432048104-4695-23-git-send-email-khandual@linux.vnet.ibm.com>
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

This patch adds ptrace interface test for TAR, PPR, DSCR
registers inside TM context. This also adds ptrace
interface based helper functions related to checkpointed
TAR, PPR, DSCR register access.

Signed-off-by: Anshuman Khandual <khandual@linux.vnet.ibm.com>
---
 tools/testing/selftests/powerpc/ptrace/Makefile    |   2 +-
 .../selftests/powerpc/ptrace/ptrace-tm-tar.c       | 169 +++++++++++++++++++++
 2 files changed, 170 insertions(+), 1 deletion(-)
 create mode 100644 tools/testing/selftests/powerpc/ptrace/ptrace-tm-tar.c

diff --git a/tools/testing/selftests/powerpc/ptrace/Makefile b/tools/testing/selftests/powerpc/ptrace/Makefile
index 28d4465..a5d177b 100644
--- a/tools/testing/selftests/powerpc/ptrace/Makefile
+++ b/tools/testing/selftests/powerpc/ptrace/Makefile
@@ -1,5 +1,5 @@
 TEST_PROGS := ptrace-ebb ptrace-gpr ptrace-tm-gpr ptrace-tm-spd-gpr \
-ptrace-tar
+ptrace-tar ptrace-tm-tar
 
 all: $(TEST_PROGS)
 
diff --git a/tools/testing/selftests/powerpc/ptrace/ptrace-tm-tar.c b/tools/testing/selftests/powerpc/ptrace/ptrace-tm-tar.c
new file mode 100644
index 0000000..2ae5b25
--- /dev/null
+++ b/tools/testing/selftests/powerpc/ptrace/ptrace-tm-tar.c
@@ -0,0 +1,169 @@
+/*
+ * Ptrace test for TAR, PPR, DSCR registers in the TM context
+ *
+ * Copyright 2015 Anshuman Khandual, IBM Corporation.
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version
+ * 2 of the License, or (at your option) any later version.
+ */
+#include "ptrace.h"
+#include "ptrace-tar.h"
+
+int shm_id;
+volatile int *cptr, *pptr;
+
+
+void tm_tar(void)
+{
+	unsigned long result, texasr;
+	unsigned long regs[3];
+	int ret;
+
+	cptr = (int *)shmat(shm_id, NULL, 0);
+trans:
+	asm __volatile__(
+		"li	4, %[tar_1];"
+		"mtspr %[sprn_tar],  4;"	/* TAR_1 */
+		"li	4, %[dscr_1];"
+		"mtspr %[sprn_dscr], 4;"	/* DSCR_1 */
+		"or     31,31,31;"		/* PPR_1*/
+
+		"1: ;"
+		TBEGIN
+		"beq 2f;"
+
+		"li	4, %[tar_2];"
+		"mtspr %[sprn_tar],  4;"	/* TAR_2 */
+		"li	4, %[dscr_2];"
+		"mtspr %[sprn_dscr], 4;"	/* DSCR_2 */
+		"or     1,1,1;"			/* PPR_2 */
+		TSUSPEND
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
+
+		:[res] "=r" (result), [texasr] "=r" (texasr)
+		:[sprn_dscr]"i"(SPRN_DSCR), [sprn_tar]"i"(SPRN_TAR), [sprn_ppr]"i"(SPRN_PPR), [sprn_texasr]"i"(SPRN_TEXASR),
+		[tar_1]"i"(TAR_1), [dscr_1]"i"(DSCR_1),
+		[tar_2]"i"(TAR_2), [dscr_2]"i"(DSCR_2)
+		: "memory", "r0", "r1", "r3", "r4", "r5", "r6"
+		);
+
+	/* TM failed, analyse */
+	if (result) {
+		if (!cptr[0])
+			goto trans;
+		shmdt(&cptr);
+
+		regs[0] = mfspr(SPRN_TAR);
+		regs[1] = mfspr(SPRN_PPR);
+		regs[2] = mfspr(SPRN_DSCR);
+
+		printf("%-30s TAR: %lu PPR: %lx DSCR: %lu\n", user_read, regs[0], regs[1], regs[2]);
+
+		ret = validate_tar_registers(regs, TAR_4, PPR_4, DSCR_4);
+		if (ret)
+			exit(1);
+		exit(0);
+	}
+	shmdt(&cptr);
+	exit(1);
+}
+
+int trace_tm_tar(pid_t child)
+{
+	unsigned long regs[3];
+	int ret;
+
+	sleep(1);
+	ret = start_trace(child);
+	if (ret)
+		return TEST_FAIL;
+
+	ret = show_tar_registers(child, regs);
+	if (ret)
+		return TEST_FAIL;
+
+	printf("%-30s TAR: %lu PPR: %lx DSCR: %lu\n", ptrace_read_running, regs[0], regs[1], regs[2]);
+
+	ret = validate_tar_registers(regs, TAR_2, PPR_2, DSCR_2);
+	if (ret)
+		return TEST_FAIL;
+
+	ret = show_tm_checkpointed_state(child, regs);
+	if (ret)
+		return TEST_FAIL;
+
+	printf("%-30s TAR: %lu PPR: %lx DSCR: %lu\n", ptrace_read_ckpt, regs[0], regs[1], regs[2]);
+
+	ret = validate_tar_registers(regs, TAR_1, PPR_1, DSCR_1);
+	if (ret)
+		return TEST_FAIL;
+
+	ret = write_ckpt_tar_registers(child, TAR_4, PPR_4, DSCR_4);
+	if (ret)
+		return TEST_FAIL;
+
+	printf("%-30s TAR: %u PPR: %lx DSCR: %u\n", ptrace_write_ckpt, TAR_4, PPR_4, DSCR_4);
+
+	ret = stop_trace(child);
+	if (ret)
+		return TEST_FAIL;
+	return TEST_PASS;
+}
+
+int ptrace_tm_tar(void)
+{
+	pid_t pid;
+	int ret, status;
+
+	shm_id = shmget(IPC_PRIVATE, sizeof(int) * 1, 0777|IPC_CREAT);
+	pid = fork();
+	if (pid == 0)
+		tm_tar();
+
+	pptr = (int *)shmat(shm_id, NULL, 0);
+	pptr[0] = 0;
+
+	if (pid) {
+		ret = trace_tm_tar(pid);
+		if (ret) {
+			kill(pid, SIGTERM);
+			return TEST_FAIL;
+		}
+		pptr[0] = 1;
+		shmdt(&pptr);
+
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
+	return test_harness(ptrace_tm_tar, "ptrace_tm_tar");
+}
-- 
2.1.0

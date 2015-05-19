Return-Path: <khandual@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 1AEB31A0671
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 May 2015 01:08:54 +1000 (AEST)
Received: from e28smtp02.in.ibm.com (e28smtp02.in.ibm.com [122.248.162.2])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 5C0AC140DEF
 for <linuxppc-dev@ozlabs.org>; Wed, 20 May 2015 01:08:53 +1000 (AEST)
Received: from /spool/local
 by e28smtp02.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <khandual@linux.vnet.ibm.com>;
 Tue, 19 May 2015 20:38:51 +0530
Received: from d28relay02.in.ibm.com (d28relay02.in.ibm.com [9.184.220.59])
 by d28dlp01.in.ibm.com (Postfix) with ESMTP id C8D80E0056
 for <linuxppc-dev@ozlabs.org>; Tue, 19 May 2015 20:41:50 +0530 (IST)
Received: from d28av04.in.ibm.com (d28av04.in.ibm.com [9.184.220.66])
 by d28relay02.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t4JF8cDC55181420
 for <linuxppc-dev@ozlabs.org>; Tue, 19 May 2015 20:38:39 +0530
Received: from d28av04.in.ibm.com (localhost [127.0.0.1])
 by d28av04.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t4JF8XP7028921
 for <linuxppc-dev@ozlabs.org>; Tue, 19 May 2015 20:38:36 +0530
From: Anshuman Khandual <khandual@linux.vnet.ibm.com>
To: linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org
Subject: [PATCH V8 25/28] selftests, powerpc: Add ptrace tests for VSX,
 VMX registers in TM
Date: Tue, 19 May 2015 20:38:21 +0530
Message-Id: <1432048104-4695-26-git-send-email-khandual@linux.vnet.ibm.com>
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

This patch adds ptrace interface test for VSX, VMX registers
inside TM context. This also adds ptrace interface based helper
functions related to chckpointed VSX, VMX registers access.

Signed-off-by: Anshuman Khandual <khandual@linux.vnet.ibm.com>
---
 tools/testing/selftests/powerpc/ptrace/Makefile    |   3 +-
 .../selftests/powerpc/ptrace/ptrace-tm-vsx.c       | 195 +++++++++++++++++++++
 2 files changed, 197 insertions(+), 1 deletion(-)
 create mode 100644 tools/testing/selftests/powerpc/ptrace/ptrace-tm-vsx.c

diff --git a/tools/testing/selftests/powerpc/ptrace/Makefile b/tools/testing/selftests/powerpc/ptrace/Makefile
index 1c5437e..092fbef 100644
--- a/tools/testing/selftests/powerpc/ptrace/Makefile
+++ b/tools/testing/selftests/powerpc/ptrace/Makefile
@@ -1,5 +1,6 @@
 TEST_PROGS := ptrace-ebb ptrace-gpr ptrace-tm-gpr ptrace-tm-spd-gpr \
-ptrace-tar ptrace-tm-tar ptrace-tm-spd-tar ptrace-vsx
+ptrace-tar ptrace-tm-tar ptrace-tm-spd-tar ptrace-vsx ptrace-tm-vsx
+
 
 all: $(TEST_PROGS)
 
diff --git a/tools/testing/selftests/powerpc/ptrace/ptrace-tm-vsx.c b/tools/testing/selftests/powerpc/ptrace/ptrace-tm-vsx.c
new file mode 100644
index 0000000..2d218c9
--- /dev/null
+++ b/tools/testing/selftests/powerpc/ptrace/ptrace-tm-vsx.c
@@ -0,0 +1,195 @@
+/*
+ * Ptrace test for VMX/VSX registers in the TM context
+ *
+ * Copyright 2015 Anshuman Khandual, IBM Corporation.
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version
+ * 2 of the License, or (at your option) any later version.
+ */
+#include "ptrace.h"
+#include "ptrace-vsx.h"
+
+int shm_id;
+volatile int *cptr, *pptr;
+
+extern void loadvsx(void *p, int tmp);
+extern void storevsx(void *p, int tmp);
+
+unsigned long fp_load[VEC_MAX];
+unsigned long fp_store[VEC_MAX];
+unsigned long fp_load_ckpt[VEC_MAX];
+unsigned long fp_load_ckpt_new[VEC_MAX];
+
+__attribute__((used)) void load_vsx(void)
+{
+	loadvsx(fp_load, 0);
+}
+
+__attribute__((used)) void load_vsx_ckpt(void)
+{
+	loadvsx(fp_load_ckpt, 0);
+}
+
+void tm_vsx(void)
+{
+	unsigned long result, texasr;
+	int ret;
+
+	cptr = (int *)shmat(shm_id, NULL, 0);
+trans:
+	asm __volatile__(
+		"bl load_vsx_ckpt;"
+
+		"1: ;"
+		TBEGIN
+		"beq 2f;"
+
+		"bl load_vsx;"
+		"b .;"
+
+		TEND
+		"li 0, 0;"
+		"ori %[res], 0, 0;"
+		"b 3f;"
+
+		"2: ;"
+		"li 0, 1;"
+		"ori %[res], 0, 0;"
+		"mfspr %[texasr], %[sprn_texasr];"
+
+		"3: ;"
+		: [res] "=r" (result), [texasr] "=r" (texasr)
+		: [fp_load] "r" (fp_load), [fp_load_ckpt] "r" (fp_load_ckpt), [sprn_texasr] "i"  (SPRN_TEXASR)
+		: "memory", "r0", "r1", "r2", "r3", "r4", "r8", "r9", "r10", "r11"
+		);
+
+	if (result) {
+		if (!cptr[0])
+			goto trans;
+		shmdt((void *)cptr);
+
+		storevsx(fp_store, 0);
+		ret = compare_vsx_vmx(fp_store, fp_load_ckpt_new);
+		if (ret)
+			exit(1);
+		exit(0);
+	}
+	exit(1);
+}
+
+int trace_tm_vsx(pid_t child)
+{
+	unsigned long vsx[VSX_MAX];
+	unsigned long vmx[VMX_MAX + 2][2];
+	int ret;
+
+	sleep(1);
+	ret = start_trace(child);
+	if (ret)
+		return TEST_FAIL;
+
+	ret = show_vsx(child, vsx);
+	if (ret)
+		return TEST_FAIL;
+
+	ret = validate_vsx(vsx, fp_load);
+	if (ret)
+		return TEST_FAIL;
+
+	ret = show_vmx(child, vmx);
+	if (ret)
+		return TEST_FAIL;
+
+	ret = validate_vmx(vmx, fp_load);
+	if (ret)
+		return TEST_FAIL;
+
+	ret = show_vsx_ckpt(child, vsx);
+	if (ret)
+		return TEST_FAIL;
+
+	ret = validate_vsx(vsx, fp_load_ckpt);
+	if (ret)
+		return TEST_FAIL;
+
+	ret = show_vmx_ckpt(child, vmx);
+	if (ret)
+		return TEST_FAIL;
+
+	ret = validate_vmx(vmx, fp_load_ckpt);
+	if (ret)
+		return TEST_FAIL;
+
+	memset(vsx, 0, sizeof(vsx));
+	memset(vmx, 0, sizeof(vmx));
+
+	load_vsx_vmx(fp_load_ckpt_new, vsx, vmx);
+
+	ret = write_vsx_ckpt(child, vsx);
+	if (ret)
+		return TEST_FAIL;
+
+	ret = write_vmx_ckpt(child, vmx);
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
+int ptrace_tm_vsx(void)
+{
+	pid_t pid;
+	int ret, status, i;
+
+	shm_id = shmget(IPC_PRIVATE, sizeof(int) * 1, 0777|IPC_CREAT);
+
+	for(i = 0; i < 128; i++) {
+		fp_load[i] = 1 + rand();
+		fp_load_ckpt[i] = 1 + 2 * rand();
+		fp_load_ckpt_new[i] = 1 + 3 * rand();
+	}
+
+	pid = fork();
+	if (pid < 0) {
+		perror("fork() failed");
+		return TEST_FAIL;
+	}
+
+	if (pid == 0)
+		tm_vsx();
+
+	if (pid) {
+		pptr = (int *)shmat(shm_id, NULL, 0);
+		ret = trace_tm_vsx(pid);
+		if (ret) {
+			kill(pid, SIGKILL);
+			return TEST_FAIL;
+		}
+
+		pptr[0] = 1;
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
+	return test_harness(ptrace_tm_vsx, "ptrace_tm_vsx");
+}
-- 
2.1.0

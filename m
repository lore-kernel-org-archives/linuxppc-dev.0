Return-Path: <khandual@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 085DE1A0250
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  9 Oct 2015 01:51:17 +1100 (AEDT)
Received: from e23smtp08.au.ibm.com (e23smtp08.au.ibm.com [202.81.31.141])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id CB61B140DA3
 for <linuxppc-dev@ozlabs.org>; Fri,  9 Oct 2015 01:51:16 +1100 (AEDT)
Received: from /spool/local
 by e23smtp08.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <khandual@linux.vnet.ibm.com>;
 Fri, 9 Oct 2015 00:51:16 +1000
Received: from d23relay08.au.ibm.com (d23relay08.au.ibm.com [9.185.71.33])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id 603502BB0051
 for <linuxppc-dev@ozlabs.org>; Fri,  9 Oct 2015 01:51:14 +1100 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay08.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t98EosLE917848
 for <linuxppc-dev@ozlabs.org>; Fri, 9 Oct 2015 01:51:02 +1100
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t98EodLx009252
 for <linuxppc-dev@ozlabs.org>; Fri, 9 Oct 2015 01:50:42 +1100
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
Subject: [PATCH V9 26/28] selftests, powerpc: Add ptrace tests for VSX,
 VMX registers in suspended TM
Date: Thu,  8 Oct 2015 20:17:47 +0530
Message-Id: <1444315669-23487-27-git-send-email-khandual@linux.vnet.ibm.com>
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

This patch adds ptrace interface test for VSX, VMX registers
inside suspended TM context.

Signed-off-by: Anshuman Khandual <khandual@linux.vnet.ibm.com>
---
 tools/testing/selftests/powerpc/ptrace/Makefile    |   3 +-
 .../selftests/powerpc/ptrace/ptrace-tm-spd-vsx.c   | 212 +++++++++++++++++++++
 2 files changed, 214 insertions(+), 1 deletion(-)
 create mode 100644 tools/testing/selftests/powerpc/ptrace/ptrace-tm-spd-vsx.c

diff --git a/tools/testing/selftests/powerpc/ptrace/Makefile b/tools/testing/selftests/powerpc/ptrace/Makefile
index 092fbef..ea57351 100644
--- a/tools/testing/selftests/powerpc/ptrace/Makefile
+++ b/tools/testing/selftests/powerpc/ptrace/Makefile
@@ -1,5 +1,6 @@
 TEST_PROGS := ptrace-ebb ptrace-gpr ptrace-tm-gpr ptrace-tm-spd-gpr \
-ptrace-tar ptrace-tm-tar ptrace-tm-spd-tar ptrace-vsx ptrace-tm-vsx
+ptrace-tar ptrace-tm-tar ptrace-tm-spd-tar ptrace-vsx ptrace-tm-vsx \
+ptrace-tm-spd-vsx
 
 
 all: $(TEST_PROGS)
diff --git a/tools/testing/selftests/powerpc/ptrace/ptrace-tm-spd-vsx.c b/tools/testing/selftests/powerpc/ptrace/ptrace-tm-spd-vsx.c
new file mode 100644
index 0000000..e52a309
--- /dev/null
+++ b/tools/testing/selftests/powerpc/ptrace/ptrace-tm-spd-vsx.c
@@ -0,0 +1,212 @@
+/*
+ * Ptrace test for VMX/VSX registers in the TM Suspend context
+ *
+ * Copyright (C) 2015 Anshuman Khandual, IBM Corporation.
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
+unsigned long fp_load_new[VEC_MAX];
+unsigned long fp_store[VEC_MAX];
+unsigned long fp_load_ckpt[VEC_MAX];
+unsigned long fp_load_ckpt_new[VEC_MAX];
+
+__attribute__((used)) void load_vsx(void)
+{
+	loadvsx(fp_load, 0);
+}
+
+__attribute__((used)) void load_vsx_new(void)
+{
+	loadvsx(fp_load_new, 0);
+}
+
+__attribute__((used)) void load_vsx_ckpt(void)
+{
+	loadvsx(fp_load_ckpt, 0);
+}
+
+__attribute__((used)) void wait_parent(void)
+{
+	while(!cptr[1]);
+}
+
+void tm_spd_vsx(void)
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
+		"bl load_vsx_new;"
+		TSUSPEND
+		"bl load_vsx;"
+		"bl wait_parent;"
+		TRESUME
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
+int trace_tm_spd_vsx(pid_t child)
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
+int ptrace_tm_spd_vsx(void)
+{
+	pid_t pid;
+	int ret, status, i;
+
+	SKIP_IF(!((long)get_auxv_entry(AT_HWCAP2) & PPC_FEATURE2_HTM));
+	shm_id = shmget(IPC_PRIVATE, sizeof(int) * 2, 0777|IPC_CREAT);
+
+	for(i = 0; i < 128; i++) {
+		fp_load[i] = 1 + rand();
+		fp_load_new[i] = 1 + 2 * rand();
+		fp_load_ckpt[i] = 1 + 3 * rand();
+		fp_load_ckpt_new[i] = 1 + 4 * rand();
+	}
+
+	pid = fork();
+	if (pid < 0) {
+		perror("fork() failed");
+		return TEST_FAIL;
+	}
+
+	if (pid == 0)
+		tm_spd_vsx();
+
+	if (pid) {
+		pptr = (int *)shmat(shm_id, NULL, 0);
+		ret = trace_tm_spd_vsx(pid);
+		if (ret) {
+			kill(pid, SIGKILL);
+			return TEST_FAIL;
+		}
+
+		pptr[0] = 1;
+		pptr[1] = 1;
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
+	return test_harness(ptrace_tm_spd_vsx, "ptrace_tm_spd_vsx");
+}
-- 
2.1.0

Return-Path: <wei.guo.simon@gmail.com>
Received: from mail-pf0-x243.google.com (mail-pf0-x243.google.com
 [IPv6:2607:f8b0:400e:c00::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rzqTL4q9xzDqYr
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 27 Jul 2016 19:29:58 +1000 (AEST)
Received: by mail-pf0-x243.google.com with SMTP id h186so1525587pfg.2
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 27 Jul 2016 02:29:58 -0700 (PDT)
From: wei.guo.simon@gmail.com
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Anshuman Khandual <khandual@linux.vnet.ibm.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Shuah Khan <shuahkh@osg.samsung.com>,
 Anton Blanchard <anton@samba.org>, Cyril Bur <cyrilbur@gmail.com>,
 Simon Guo <wei.guo.simon@gmail.com>,
 Ulrich Weigand <ulrich.weigand@de.ibm.com>,
 Michael Neuling <mikey@neuling.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 Kees Cook <keescook@chromium.org>, Rashmica Gupta <rashmicy@gmail.com>,
 Khem Raj <raj.khem@gmail.com>, Jessica Yu <jeyu@redhat.com>,
 Jiri Kosina <jkosina@suse.cz>, Miroslav Benes <mbenes@suse.cz>,
 Suraj Jitindar Singh <sjitindarsingh@gmail.com>,
 Chris Smart <chris@distroguy.com>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: [PATCH v12 26/30] selftests/powerpc: Add ptrace tests for VSX,
 VMX registers in TM
Date: Wed, 27 Jul 2016 17:26:51 +0800
Message-Id: <1469611615-2935-27-git-send-email-wei.guo.simon@gmail.com>
In-Reply-To: <1469611615-2935-1-git-send-email-wei.guo.simon@gmail.com>
References: <1469611615-2935-1-git-send-email-wei.guo.simon@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Anshuman Khandual <khandual@linux.vnet.ibm.com>

This patch adds ptrace interface test for VSX, VMX registers
inside TM context. This also adds ptrace interface based helper
functions related to chckpointed VSX, VMX registers access.

Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Paul Mackerras <paulus@samba.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Shuah Khan <shuahkh@osg.samsung.com>
Cc: Anton Blanchard <anton@samba.org>
Cc: Cyril Bur <cyrilbur@gmail.com>
Cc: Anshuman Khandual <khandual@linux.vnet.ibm.com>
Cc: Simon Guo <wei.guo.simon@gmail.com>
Cc: Ulrich Weigand <ulrich.weigand@de.ibm.com>
Cc: Michael Neuling <mikey@neuling.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Kees Cook <keescook@chromium.org>
Cc: Rashmica Gupta <rashmicy@gmail.com>
Cc: Khem Raj <raj.khem@gmail.com>
Cc: Jessica Yu <jeyu@redhat.com>
Cc: Jiri Kosina <jkosina@suse.cz>
Cc: Miroslav Benes <mbenes@suse.cz>
Cc: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
Cc: Chris Smart <chris@distroguy.com>
Cc: linuxppc-dev@lists.ozlabs.org
Cc: linux-kernel@vger.kernel.org
Cc: linux-kselftest@vger.kernel.org
Signed-off-by: Anshuman Khandual <khandual@linux.vnet.ibm.com>
Signed-off-by: Simon Guo <wei.guo.simon@gmail.com>
---
 tools/testing/selftests/powerpc/ptrace/Makefile    |   3 +-
 .../selftests/powerpc/ptrace/ptrace-tm-vsx.c       | 209 +++++++++++++++++++++
 2 files changed, 211 insertions(+), 1 deletion(-)
 create mode 100644 tools/testing/selftests/powerpc/ptrace/ptrace-tm-vsx.c

diff --git a/tools/testing/selftests/powerpc/ptrace/Makefile b/tools/testing/selftests/powerpc/ptrace/Makefile
index e3d9ceb..1b07649 100644
--- a/tools/testing/selftests/powerpc/ptrace/Makefile
+++ b/tools/testing/selftests/powerpc/ptrace/Makefile
@@ -1,5 +1,6 @@
 TEST_PROGS := ptrace-ebb ptrace-gpr ptrace-tm-gpr ptrace-tm-spd-gpr \
-ptrace-tar ptrace-tm-tar ptrace-tm-spd-tar ptrace-vsx
+ptrace-tar ptrace-tm-tar ptrace-tm-spd-tar ptrace-vsx ptrace-tm-vsx
+
 
 all: $(TEST_PROGS)
 CFLAGS += -m64
diff --git a/tools/testing/selftests/powerpc/ptrace/ptrace-tm-vsx.c b/tools/testing/selftests/powerpc/ptrace/ptrace-tm-vsx.c
new file mode 100644
index 0000000..d63f45d
--- /dev/null
+++ b/tools/testing/selftests/powerpc/ptrace/ptrace-tm-vsx.c
@@ -0,0 +1,209 @@
+/*
+ * Ptrace test for VMX/VSX registers in the TM context
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
+volatile unsigned long *cptr, *pptr;
+
+void loadvsx(void *p, int tmp);
+void storevsx(void *p, int tmp);
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
+	cptr = (unsigned long *)shmat(shm_id, NULL, 0);
+
+trans:
+	cptr[1] = 0;
+	asm __volatile__(
+		"bl load_vsx_ckpt;"
+
+		"1: ;"
+		TBEGIN
+		"beq 2f;"
+
+		"bl load_vsx;"
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
+		"2: ;"
+		"li 0, 1;"
+		"ori %[res], 0, 0;"
+		"mfspr %[texasr], %[sprn_texasr];"
+
+		"3: ;"
+		: [res] "=r" (result), [texasr] "=r" (texasr)
+		: [fp_load] "r" (fp_load), [fp_load_ckpt] "r" (fp_load_ckpt),
+		[sprn_texasr] "i"  (SPRN_TEXASR), [cptr1] "r" (&cptr[1])
+		: "memory", "r0", "r1", "r2", "r3", "r4",
+		"r7", "r8", "r9", "r10", "r11"
+		);
+
+	if (result) {
+		if (!cptr[0])
+			goto trans;
+
+		shmdt((void *)cptr);
+		storevsx(fp_store, 0);
+		ret = compare_vsx_vmx(fp_store, fp_load_ckpt_new);
+		if (ret)
+			exit(1);
+		exit(0);
+	}
+	shmdt((void *)cptr);
+	exit(1);
+}
+
+int trace_tm_vsx(pid_t child)
+{
+	unsigned long vsx[VSX_MAX];
+	unsigned long vmx[VMX_MAX + 2][2];
+	int ret;
+
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
+	pptr[0] = 1;
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
+	SKIP_IF(!((long)get_auxv_entry(AT_HWCAP2) & PPC_FEATURE2_HTM));
+	shm_id = shmget(IPC_PRIVATE, sizeof(int) * 2, 0777|IPC_CREAT);
+
+	for (i = 0; i < 128; i++) {
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
+		pptr = (unsigned long *)shmat(shm_id, NULL, 0);
+		while (!pptr[1]);
+
+		ret = trace_tm_vsx(pid);
+		if (ret) {
+			kill(pid, SIGKILL);
+			shmdt((void *)pptr);
+			shmctl(shm_id, IPC_RMID, NULL);
+			return TEST_FAIL;
+		}
+
+		shmdt((void *)pptr);
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
+	return test_harness(ptrace_tm_vsx, "ptrace_tm_vsx");
+}
-- 
1.8.3.1

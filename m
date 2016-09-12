Return-Path: <wei.guo.simon@gmail.com>
Received: from mail-pf0-x244.google.com (mail-pf0-x244.google.com
 [IPv6:2607:f8b0:400e:c00::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sXfhq0WBXzDsNS
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 12 Sep 2016 17:34:51 +1000 (AEST)
Received: by mail-pf0-x244.google.com with SMTP id i75so2777131pfa.2
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 12 Sep 2016 00:34:50 -0700 (PDT)
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
Subject: [PATCH v14 10/15] selftests/powerpc: Add ptrace tests for VSX,
 VMX registers
Date: Mon, 12 Sep 2016 15:33:20 +0800
Message-Id: <1473665605-11890-11-git-send-email-wei.guo.simon@gmail.com>
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

This patch adds ptrace interface test for VSX, VMX registers.
This also adds ptrace interface based helper functions related
to VSX, VMX registers access. This also adds some assembly
helper functions related to VSX and VMX registers.

Signed-off-by: Anshuman Khandual <khandual@linux.vnet.ibm.com>
Signed-off-by: Simon Guo <wei.guo.simon@gmail.com>
---
 tools/testing/selftests/powerpc/ptrace/Makefile    |   2 +-
 .../testing/selftests/powerpc/ptrace/ptrace-vsx.c  | 140 +++++++++++
 .../testing/selftests/powerpc/ptrace/ptrace-vsx.h  | 127 ++++++++++
 tools/testing/selftests/powerpc/ptrace/ptrace.S    | 265 +++++++++++++++++++++
 tools/testing/selftests/powerpc/ptrace/ptrace.h    | 119 +++++++++
 5 files changed, 652 insertions(+), 1 deletion(-)
 create mode 100644 tools/testing/selftests/powerpc/ptrace/ptrace-vsx.c
 create mode 100644 tools/testing/selftests/powerpc/ptrace/ptrace-vsx.h

diff --git a/tools/testing/selftests/powerpc/ptrace/Makefile b/tools/testing/selftests/powerpc/ptrace/Makefile
index 2916759..e3d9ceb 100644
--- a/tools/testing/selftests/powerpc/ptrace/Makefile
+++ b/tools/testing/selftests/powerpc/ptrace/Makefile
@@ -1,5 +1,5 @@
 TEST_PROGS := ptrace-ebb ptrace-gpr ptrace-tm-gpr ptrace-tm-spd-gpr \
-ptrace-tar ptrace-tm-tar ptrace-tm-spd-tar
+ptrace-tar ptrace-tm-tar ptrace-tm-spd-tar ptrace-vsx
 
 all: $(TEST_PROGS)
 CFLAGS += -m64
diff --git a/tools/testing/selftests/powerpc/ptrace/ptrace-vsx.c b/tools/testing/selftests/powerpc/ptrace/ptrace-vsx.c
new file mode 100644
index 0000000..770b846
--- /dev/null
+++ b/tools/testing/selftests/powerpc/ptrace/ptrace-vsx.c
@@ -0,0 +1,140 @@
+/*
+ * Ptrace test for VMX/VSX registers
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
+/* Tracer and Tracee Shared Data */
+int shm_id;
+volatile int *cptr, *pptr;
+
+unsigned long fp_load[VEC_MAX];
+unsigned long fp_load_new[VEC_MAX];
+unsigned long fp_store[VEC_MAX];
+
+void vsx(void)
+{
+	int ret;
+
+	cptr = (int *)shmat(shm_id, NULL, 0);
+	loadvsx(fp_load, 0);
+	cptr[1] = 1;
+
+	while (!cptr[0]);
+	shmdt((void *) cptr);
+
+	storevsx(fp_store, 0);
+	ret = compare_vsx_vmx(fp_store, fp_load_new);
+	if (ret)
+		exit(1);
+	exit(0);
+}
+
+int trace_vsx(pid_t child)
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
+	memset(vsx, 0, sizeof(vsx));
+	memset(vmx, 0, sizeof(vmx));
+	load_vsx_vmx(fp_load_new, vsx, vmx);
+
+	ret = write_vsx(child, vsx);
+	if (ret)
+		return TEST_FAIL;
+
+	ret = write_vmx(child, vmx);
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
+int ptrace_vsx(void)
+{
+	pid_t pid;
+	int ret, status, i;
+
+	shm_id = shmget(IPC_PRIVATE, sizeof(int) * 2, 0777|IPC_CREAT);
+
+	for (i = 0; i < VEC_MAX; i++)
+		fp_load[i] = i + rand();
+
+	for (i = 0; i < VEC_MAX; i++)
+		fp_load_new[i] = i + 2 * rand();
+
+	pid = fork();
+	if (pid < 0) {
+		perror("fork() failed");
+		return TEST_FAIL;
+	}
+
+	if (pid == 0)
+		vsx();
+
+	if (pid) {
+		pptr = (int *)shmat(shm_id, NULL, 0);
+		while (!pptr[1]);
+
+		ret = trace_vsx(pid);
+		if (ret) {
+			kill(pid, SIGTERM);
+			shmdt((void *)pptr);
+			shmctl(shm_id, IPC_RMID, NULL);
+			return TEST_FAIL;
+		}
+
+		pptr[0] = 1;
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
+	}
+	return TEST_PASS;
+}
+
+int main(int argc, char *argv[])
+{
+	return test_harness(ptrace_vsx, "ptrace_vsx");
+}
diff --git a/tools/testing/selftests/powerpc/ptrace/ptrace-vsx.h b/tools/testing/selftests/powerpc/ptrace/ptrace-vsx.h
new file mode 100644
index 0000000..f4e4b42
--- /dev/null
+++ b/tools/testing/selftests/powerpc/ptrace/ptrace-vsx.h
@@ -0,0 +1,127 @@
+/*
+ * Copyright (C) 2015 Anshuman Khandual, IBM Corporation.
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version
+ * 2 of the License, or (at your option) any later version.
+ */
+#define VEC_MAX 128
+#define VSX_MAX 32
+#define VMX_MAX 32
+
+/*
+ * unsigned long vsx[32]
+ * unsigned long load[128]
+ */
+int validate_vsx(unsigned long *vsx, unsigned long *load)
+{
+	int i;
+
+	for (i = 0; i < VSX_MAX; i++) {
+		if (vsx[i] != load[2 * i + 1]) {
+			printf("vsx[%d]: %lx load[%d] %lx\n",
+					i, vsx[i], 2 * i + 1, load[2 * i + 1]);
+			return TEST_FAIL;
+		}
+	}
+	return TEST_PASS;
+}
+
+/*
+ * unsigned long vmx[32][2]
+ * unsigned long load[128]
+ */
+int validate_vmx(unsigned long vmx[][2], unsigned long *load)
+{
+	int i;
+
+	for (i = 0; i < VMX_MAX; i++) {
+		#if __BYTE_ORDER__ == __ORDER_BIG_ENDIAN__
+		if ((vmx[i][0] != load[64 + 2 * i]) ||
+				(vmx[i][1] != load[65 + 2 * i])) {
+			printf("vmx[%d][0]: %lx load[%d] %lx\n",
+					i, vmx[i][0], 64 + 2 * i,
+					load[64 + 2 * i]);
+			printf("vmx[%d][1]: %lx load[%d] %lx\n",
+					i, vmx[i][1], 65 + 2 * i,
+					load[65 + 2 * i]);
+			return TEST_FAIL;
+		}
+		#else  /*
+			* In LE each value pair is stored in an
+			* alternate manner.
+			*/
+		if ((vmx[i][0] != load[65 + 2 * i]) ||
+				(vmx[i][1] != load[64 + 2 * i])) {
+			printf("vmx[%d][0]: %lx load[%d] %lx\n",
+					i, vmx[i][0], 65 + 2 * i,
+					load[65 + 2 * i]);
+			printf("vmx[%d][1]: %lx load[%d] %lx\n",
+					i, vmx[i][1], 64 + 2 * i,
+					load[64 + 2 * i]);
+			return TEST_FAIL;
+		}
+		#endif
+	}
+	return TEST_PASS;
+}
+
+/*
+ * unsigned long store[128]
+ * unsigned long load[128]
+ */
+int compare_vsx_vmx(unsigned long *store, unsigned long *load)
+{
+	int i;
+
+	for (i = 0; i < VSX_MAX; i++) {
+		if (store[1 + 2 * i] != load[1 + 2 * i]) {
+			printf("store[%d]: %lx load[%d] %lx\n",
+					1 + 2 * i, store[i],
+					1 + 2 * i, load[i]);
+			return TEST_FAIL;
+		}
+	}
+
+	#if __BYTE_ORDER__ == __ORDER_BIG_ENDIAN__
+	for (i = 64; i < VEC_MAX; i++) {
+		if (store[i] != load[i]) {
+			printf("store[%d]: %lx load[%d] %lx\n",
+					i, store[i], i, load[i]);
+			return TEST_FAIL;
+		}
+	}
+	#else	/* In LE each value pair is stored in an alternate manner */
+	for (i = 64; i < VEC_MAX; i++) {
+		if (!(i % 2) && (store[i] != load[i+1])) {
+			printf("store[%d]: %lx load[%d] %lx\n",
+					i, store[i], i+1, load[i+1]);
+			return TEST_FAIL;
+		}
+		if ((i % 2) && (store[i] != load[i-1])) {
+			printf("here store[%d]: %lx load[%d] %lx\n",
+					i, store[i], i-1, load[i-1]);
+			return TEST_FAIL;
+		}
+	}
+	#endif
+	return TEST_PASS;
+}
+
+void load_vsx_vmx(unsigned long *load, unsigned long *vsx,
+		unsigned long vmx[][2])
+{
+	int i;
+
+	for (i = 0; i < VSX_MAX; i++)
+		vsx[i] = load[1 + 2 * i];
+
+	for (i = 0; i < VMX_MAX; i++) {
+		vmx[i][0] = load[64 + 2 * i];
+		vmx[i][1] = load[65 + 2 * i];
+	}
+}
+
+void loadvsx(void *p, int tmp);
+void storevsx(void *p, int tmp);
diff --git a/tools/testing/selftests/powerpc/ptrace/ptrace.S b/tools/testing/selftests/powerpc/ptrace/ptrace.S
index 193beea..2407792 100644
--- a/tools/testing/selftests/powerpc/ptrace/ptrace.S
+++ b/tools/testing/selftests/powerpc/ptrace/ptrace.S
@@ -129,3 +129,268 @@ FUNC_START(store_fpr)
 	stfs 31, 31*4(3)
 	blr
 FUNC_END(store_fpr)
+
+/* VMX/VSX registers - unsigned long buf[128] */
+FUNC_START(loadvsx)
+	lis	4, 0
+	LXVD2X	(0,(4),(3))
+	addi	4, 4, 16
+	LXVD2X	(1,(4),(3))
+	addi	4, 4, 16
+	LXVD2X	(2,(4),(3))
+	addi	4, 4, 16
+	LXVD2X	(3,(4),(3))
+	addi	4, 4, 16
+	LXVD2X	(4,(4),(3))
+	addi	4, 4, 16
+	LXVD2X	(5,(4),(3))
+	addi	4, 4, 16
+	LXVD2X	(6,(4),(3))
+	addi	4, 4, 16
+	LXVD2X	(7,(4),(3))
+	addi	4, 4, 16
+	LXVD2X	(8,(4),(3))
+	addi	4, 4, 16
+	LXVD2X	(9,(4),(3))
+	addi	4, 4, 16
+	LXVD2X	(10,(4),(3))
+	addi	4, 4, 16
+	LXVD2X	(11,(4),(3))
+	addi	4, 4, 16
+	LXVD2X	(12,(4),(3))
+	addi	4, 4, 16
+	LXVD2X	(13,(4),(3))
+	addi	4, 4, 16
+	LXVD2X	(14,(4),(3))
+	addi	4, 4, 16
+	LXVD2X	(15,(4),(3))
+	addi	4, 4, 16
+	LXVD2X	(16,(4),(3))
+	addi	4, 4, 16
+	LXVD2X	(17,(4),(3))
+	addi	4, 4, 16
+	LXVD2X	(18,(4),(3))
+	addi	4, 4, 16
+	LXVD2X	(19,(4),(3))
+	addi	4, 4, 16
+	LXVD2X	(20,(4),(3))
+	addi	4, 4, 16
+	LXVD2X	(21,(4),(3))
+	addi	4, 4, 16
+	LXVD2X	(22,(4),(3))
+	addi	4, 4, 16
+	LXVD2X	(23,(4),(3))
+	addi	4, 4, 16
+	LXVD2X	(24,(4),(3))
+	addi	4, 4, 16
+	LXVD2X	(25,(4),(3))
+	addi	4, 4, 16
+	LXVD2X	(26,(4),(3))
+	addi	4, 4, 16
+	LXVD2X	(27,(4),(3))
+	addi	4, 4, 16
+	LXVD2X	(28,(4),(3))
+	addi	4, 4, 16
+	LXVD2X	(29,(4),(3))
+	addi	4, 4, 16
+	LXVD2X	(30,(4),(3))
+	addi	4, 4, 16
+	LXVD2X	(31,(4),(3))
+	addi	4, 4, 16
+	LXVD2X	(32,(4),(3))
+	addi	4, 4, 16
+	LXVD2X	(33,(4),(3))
+	addi	4, 4, 16
+	LXVD2X	(34,(4),(3))
+	addi	4, 4, 16
+	LXVD2X	(35,(4),(3))
+	addi	4, 4, 16
+	LXVD2X	(36,(4),(3))
+	addi	4, 4, 16
+	LXVD2X	(37,(4),(3))
+	addi	4, 4, 16
+	LXVD2X	(38,(4),(3))
+	addi	4, 4, 16
+	LXVD2X	(39,(4),(3))
+	addi	4, 4, 16
+	LXVD2X	(40,(4),(3))
+	addi	4, 4, 16
+	LXVD2X	(41,(4),(3))
+	addi	4, 4, 16
+	LXVD2X	(42,(4),(3))
+	addi	4, 4, 16
+	LXVD2X	(43,(4),(3))
+	addi	4, 4, 16
+	LXVD2X	(44,(4),(3))
+	addi	4, 4, 16
+	LXVD2X	(45,(4),(3))
+	addi	4, 4, 16
+	LXVD2X	(46,(4),(3))
+	addi	4, 4, 16
+	LXVD2X	(47,(4),(3))
+	addi	4, 4, 16
+	LXVD2X	(48,(4),(3))
+	addi	4, 4, 16
+	LXVD2X	(49,(4),(3))
+	addi	4, 4, 16
+	LXVD2X	(50,(4),(3))
+	addi	4, 4, 16
+	LXVD2X	(51,(4),(3))
+	addi	4, 4, 16
+	LXVD2X	(52,(4),(3))
+	addi	4, 4, 16
+	LXVD2X	(53,(4),(3))
+	addi	4, 4, 16
+	LXVD2X	(54,(4),(3))
+	addi	4, 4, 16
+	LXVD2X	(55,(4),(3))
+	addi	4, 4, 16
+	LXVD2X	(56,(4),(3))
+	addi	4, 4, 16
+	LXVD2X	(57,(4),(3))
+	addi	4, 4, 16
+	LXVD2X	(58,(4),(3))
+	addi	4, 4, 16
+	LXVD2X	(59,(4),(3))
+	addi	4, 4, 16
+	LXVD2X	(60,(4),(3))
+	addi	4, 4, 16
+	LXVD2X	(61,(4),(3))
+	addi	4, 4, 16
+	LXVD2X	(62,(4),(3))
+	addi	4, 4, 16
+	LXVD2X	(63,(4),(3))
+	blr
+FUNC_END(loadvsx)
+
+FUNC_START(storevsx)
+	lis	4, 0
+	STXVD2X	(0,(4),(3))
+	addi	4, 4, 16
+	STXVD2X	(1,(4),(3))
+	addi	4, 4, 16
+	STXVD2X	(2,(4),(3))
+	addi	4, 4, 16
+	STXVD2X	(3,(4),(3))
+	addi	4, 4, 16
+	STXVD2X	(4,(4),(3))
+	addi	4, 4, 16
+	STXVD2X	(5,(4),(3))
+	addi	4, 4, 16
+	STXVD2X	(6,(4),(3))
+	addi	4, 4, 16
+	STXVD2X	(7,(4),(3))
+	addi	4, 4, 16
+	STXVD2X	(8,(4),(3))
+	addi	4, 4, 16
+	STXVD2X	(9,(4),(3))
+	addi	4, 4, 16
+	STXVD2X	(10,(4),(3))
+	addi	4, 4, 16
+	STXVD2X	(11,(4),(3))
+	addi	4, 4, 16
+	STXVD2X	(12,(4),(3))
+	addi	4, 4, 16
+	STXVD2X	(13,(4),(3))
+	addi	4, 4, 16
+	STXVD2X	(14,(4),(3))
+	addi	4, 4, 16
+	STXVD2X	(15,(4),(3))
+	addi	4, 4, 16
+	STXVD2X	(16,(4),(3))
+	addi	4, 4, 16
+	STXVD2X	(17,(4),(3))
+	addi	4, 4, 16
+	STXVD2X	(18,(4),(3))
+	addi	4, 4, 16
+	STXVD2X	(19,(4),(3))
+	addi	4, 4, 16
+	STXVD2X	(20,(4),(3))
+	addi	4, 4, 16
+	STXVD2X	(21,(4),(3))
+	addi	4, 4, 16
+	STXVD2X	(22,(4),(3))
+	addi	4, 4, 16
+	STXVD2X	(23,(4),(3))
+	addi	4, 4, 16
+	STXVD2X	(24,(4),(3))
+	addi	4, 4, 16
+	STXVD2X	(25,(4),(3))
+	addi	4, 4, 16
+	STXVD2X	(26,(4),(3))
+	addi	4, 4, 16
+	STXVD2X	(27,(4),(3))
+	addi	4, 4, 16
+	STXVD2X	(28,(4),(3))
+	addi	4, 4, 16
+	STXVD2X	(29,(4),(3))
+	addi	4, 4, 16
+	STXVD2X	(30,(4),(3))
+	addi	4, 4, 16
+	STXVD2X	(31,(4),(3))
+	addi	4, 4, 16
+	STXVD2X	(32,(4),(3))
+	addi	4, 4, 16
+	STXVD2X	(33,(4),(3))
+	addi	4, 4, 16
+	STXVD2X	(34,(4),(3))
+	addi	4, 4, 16
+	STXVD2X	(35,(4),(3))
+	addi	4, 4, 16
+	STXVD2X	(36,(4),(3))
+	addi	4, 4, 16
+	STXVD2X	(37,(4),(3))
+	addi	4, 4, 16
+	STXVD2X	(38,(4),(3))
+	addi	4, 4, 16
+	STXVD2X	(39,(4),(3))
+	addi	4, 4, 16
+	STXVD2X	(40,(4),(3))
+	addi	4, 4, 16
+	STXVD2X	(41,(4),(3))
+	addi	4, 4, 16
+	STXVD2X	(42,(4),(3))
+	addi	4, 4, 16
+	STXVD2X	(43,(4),(3))
+	addi	4, 4, 16
+	STXVD2X	(44,(4),(3))
+	addi	4, 4, 16
+	STXVD2X	(45,(4),(3))
+	addi	4, 4, 16
+	STXVD2X	(46,(4),(3))
+	addi	4, 4, 16
+	STXVD2X	(47,(4),(3))
+	addi	4, 4, 16
+	STXVD2X	(48,(4),(3))
+	addi	4, 4, 16
+	STXVD2X	(49,(4),(3))
+	addi	4, 4, 16
+	STXVD2X	(50,(4),(3))
+	addi	4, 4, 16
+	STXVD2X	(51,(4),(3))
+	addi	4, 4, 16
+	STXVD2X	(52,(4),(3))
+	addi	4, 4, 16
+	STXVD2X	(53,(4),(3))
+	addi	4, 4, 16
+	STXVD2X	(54,(4),(3))
+	addi	4, 4, 16
+	STXVD2X	(55,(4),(3))
+	addi	4, 4, 16
+	STXVD2X	(56,(4),(3))
+	addi	4, 4, 16
+	STXVD2X	(57,(4),(3))
+	addi	4, 4, 16
+	STXVD2X	(58,(4),(3))
+	addi	4, 4, 16
+	STXVD2X	(59,(4),(3))
+	addi	4, 4, 16
+	STXVD2X	(60,(4),(3))
+	addi	4, 4, 16
+	STXVD2X	(61,(4),(3))
+	addi	4, 4, 16
+	STXVD2X	(62,(4),(3))
+	addi	4, 4, 16
+	STXVD2X	(63,(4),(3))
+	blr
+FUNC_END(storevsx)
diff --git a/tools/testing/selftests/powerpc/ptrace/ptrace.h b/tools/testing/selftests/powerpc/ptrace/ptrace.h
index 86d58a9..4fb9af4 100644
--- a/tools/testing/selftests/powerpc/ptrace/ptrace.h
+++ b/tools/testing/selftests/powerpc/ptrace/ptrace.h
@@ -546,6 +546,125 @@ int write_ckpt_gpr(pid_t child, unsigned long val)
 	return TEST_PASS;
 }
 
+/* VMX */
+int show_vmx(pid_t child, unsigned long vmx[][2])
+{
+	int ret;
+
+	ret = ptrace(PTRACE_GETVRREGS, child, 0, vmx);
+	if (ret) {
+		perror("ptrace(PTRACE_GETVRREGS) failed");
+		return TEST_FAIL;
+	}
+	return TEST_PASS;
+}
+
+int show_vmx_ckpt(pid_t child, unsigned long vmx[][2])
+{
+	unsigned long regs[34][2];
+	struct iovec iov;
+	int ret;
+
+	iov.iov_base = (u64 *) regs;
+	iov.iov_len = sizeof(regs);
+	ret = ptrace(PTRACE_GETREGSET, child, NT_PPC_TM_CVMX, &iov);
+	if (ret) {
+		perror("ptrace(PTRACE_GETREGSET, NT_PPC_TM_CVMX) failed");
+		return TEST_FAIL;
+	}
+	memcpy(vmx, regs, sizeof(regs));
+	return TEST_PASS;
+}
+
+
+int write_vmx(pid_t child, unsigned long vmx[][2])
+{
+	int ret;
+
+	ret = ptrace(PTRACE_SETVRREGS, child, 0, vmx);
+	if (ret) {
+		perror("ptrace(PTRACE_SETVRREGS) failed");
+		return TEST_FAIL;
+	}
+	return TEST_PASS;
+}
+
+int write_vmx_ckpt(pid_t child, unsigned long vmx[][2])
+{
+	unsigned long regs[34][2];
+	struct iovec iov;
+	int ret;
+
+	memcpy(regs, vmx, sizeof(regs));
+	iov.iov_base = (u64 *) regs;
+	iov.iov_len = sizeof(regs);
+	ret = ptrace(PTRACE_SETREGSET, child, NT_PPC_TM_CVMX, &iov);
+	if (ret) {
+		perror("ptrace(PTRACE_SETREGSET, NT_PPC_TM_CVMX) failed");
+		return TEST_FAIL;
+	}
+	return TEST_PASS;
+}
+
+/* VSX */
+int show_vsx(pid_t child, unsigned long *vsx)
+{
+	int ret;
+
+	ret = ptrace(PTRACE_GETVSRREGS, child, 0, vsx);
+	if (ret) {
+		perror("ptrace(PTRACE_GETVSRREGS) failed");
+		return TEST_FAIL;
+	}
+	return TEST_PASS;
+}
+
+int show_vsx_ckpt(pid_t child, unsigned long *vsx)
+{
+	unsigned long regs[32];
+	struct iovec iov;
+	int ret;
+
+	iov.iov_base = (u64 *) regs;
+	iov.iov_len = sizeof(regs);
+	ret = ptrace(PTRACE_GETREGSET, child, NT_PPC_TM_CVSX, &iov);
+	if (ret) {
+		perror("ptrace(PTRACE_GETREGSET, NT_PPC_TM_CVSX) failed");
+		return TEST_FAIL;
+	}
+	memcpy(vsx, regs, sizeof(regs));
+	return TEST_PASS;
+}
+
+int write_vsx(pid_t child, unsigned long *vsx)
+{
+	int ret;
+
+	ret = ptrace(PTRACE_SETVSRREGS, child, 0, vsx);
+	if (ret) {
+		perror("ptrace(PTRACE_SETVSRREGS) failed");
+		return TEST_FAIL;
+	}
+	return TEST_PASS;
+}
+
+int write_vsx_ckpt(pid_t child, unsigned long *vsx)
+{
+	unsigned long regs[32];
+	struct iovec iov;
+	int ret;
+
+	memcpy(regs, vsx, sizeof(regs));
+	iov.iov_base = (u64 *) regs;
+	iov.iov_len = sizeof(regs);
+	ret = ptrace(PTRACE_SETREGSET, child, NT_PPC_TM_CVSX, &iov);
+	if (ret) {
+		perror("ptrace(PTRACE_SETREGSET, NT_PPC_TM_CVSX) failed");
+		return TEST_FAIL;
+	}
+	return TEST_PASS;
+}
+
 /* Analyse TEXASR after TM failure */
 inline unsigned long get_tfiar(void)
 {
-- 
1.8.3.1

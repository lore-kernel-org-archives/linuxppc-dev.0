Return-Path: <cyrilbur@gmail.com>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 054441A075A
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 23 Feb 2016 14:39:55 +1100 (AEDT)
Received: from e23smtp01.au.ibm.com (e23smtp01.au.ibm.com [202.81.31.143])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id CAA21140B9C
 for <linuxppc-dev@ozlabs.org>; Tue, 23 Feb 2016 14:39:54 +1100 (AEDT)
Received: from localhost
 by e23smtp01.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <cyrilbur@gmail.com>;
 Tue, 23 Feb 2016 13:39:53 +1000
Received: from d23relay08.au.ibm.com (d23relay08.au.ibm.com [9.185.71.33])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id 64A902BB0055
 for <linuxppc-dev@ozlabs.org>; Tue, 23 Feb 2016 14:39:52 +1100 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay08.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u1N3difB60817608
 for <linuxppc-dev@ozlabs.org>; Tue, 23 Feb 2016 14:39:52 +1100
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u1N3dKvw015659
 for <linuxppc-dev@ozlabs.org>; Tue, 23 Feb 2016 14:39:20 +1100
From: Cyril Bur <cyrilbur@gmail.com>
To: linuxppc-dev@ozlabs.org
Cc: naveen.n.rao@linux.vnet.ibm.com
Subject: [PATCH v5 1/9] selftests/powerpc: Test the preservation of FPU and
 VMX regs across syscall
Date: Tue, 23 Feb 2016 14:38:14 +1100
Message-Id: <1456198702-29657-2-git-send-email-cyrilbur@gmail.com>
In-Reply-To: <1456198702-29657-1-git-send-email-cyrilbur@gmail.com>
References: <1456198702-29657-1-git-send-email-cyrilbur@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Test that the non volatile floating point and Altivec registers get
correctly preserved across the fork() syscall.

fork() works nicely for this purpose, the registers should be the same for
both parent and child

Signed-off-by: Cyril Bur <cyrilbur@gmail.com>
---
 tools/testing/selftests/powerpc/Makefile           |   3 +-
 tools/testing/selftests/powerpc/basic_asm.h        |  62 +++++++
 tools/testing/selftests/powerpc/math/.gitignore    |   2 +
 tools/testing/selftests/powerpc/math/Makefile      |  16 ++
 tools/testing/selftests/powerpc/math/fpu_asm.S     | 161 +++++++++++++++++
 tools/testing/selftests/powerpc/math/fpu_syscall.c |  90 ++++++++++
 tools/testing/selftests/powerpc/math/vmx_asm.S     | 195 +++++++++++++++++++++
 tools/testing/selftests/powerpc/math/vmx_syscall.c |  91 ++++++++++
 8 files changed, 619 insertions(+), 1 deletion(-)
 create mode 100644 tools/testing/selftests/powerpc/basic_asm.h
 create mode 100644 tools/testing/selftests/powerpc/math/.gitignore
 create mode 100644 tools/testing/selftests/powerpc/math/Makefile
 create mode 100644 tools/testing/selftests/powerpc/math/fpu_asm.S
 create mode 100644 tools/testing/selftests/powerpc/math/fpu_syscall.c
 create mode 100644 tools/testing/selftests/powerpc/math/vmx_asm.S
 create mode 100644 tools/testing/selftests/powerpc/math/vmx_syscall.c

diff --git a/tools/testing/selftests/powerpc/Makefile b/tools/testing/selftests/powerpc/Makefile
index 0c2706b..19e8191 100644
--- a/tools/testing/selftests/powerpc/Makefile
+++ b/tools/testing/selftests/powerpc/Makefile
@@ -22,7 +22,8 @@ SUB_DIRS = benchmarks 		\
 	   switch_endian	\
 	   syscalls		\
 	   tm			\
-	   vphn
+	   vphn         \
+	   math
 
 endif
 
diff --git a/tools/testing/selftests/powerpc/basic_asm.h b/tools/testing/selftests/powerpc/basic_asm.h
new file mode 100644
index 0000000..f56482f
--- /dev/null
+++ b/tools/testing/selftests/powerpc/basic_asm.h
@@ -0,0 +1,62 @@
+#include <ppc-asm.h>
+#include <asm/unistd.h>
+
+#if defined(_CALL_ELF) && _CALL_ELF == 2
+#define STACK_FRAME_MIN_SIZE 32
+#define STACK_FRAME_TOC_POS  24
+#define __STACK_FRAME_PARAM(_param)  (32 + ((_param)*8))
+#define __STACK_FRAME_LOCAL(_num_params,_var_num)  ((STACK_FRAME_PARAM(_num_params)) + ((_var_num)*8))
+#else
+#define STACK_FRAME_MIN_SIZE 112
+#define STACK_FRAME_TOC_POS  40
+#define __STACK_FRAME_PARAM(i)  (48 + ((i)*8))
+/*
+ * Caveat: if a function passed more than 8 params, the caller will have
+ * made more space... this should be reflected by this C code.
+ * if (_num_params > 8)
+ *     total = 112 + ((_num_params - 8) * 8)
+ *
+ * And substitute the '112' for 'total' in the macro. Doable in preprocessor for ASM?
+ */
+#define __STACK_FRAME_LOCAL(_num_params,_var_num)  (112 + ((_var_num)*8))
+#endif
+/* Parameter x saved to the stack */
+#define STACK_FRAME_PARAM(var)    __STACK_FRAME_PARAM(var)
+/* Local variable x saved to the stack after x parameters */
+#define STACK_FRAME_LOCAL(num_params,var)    __STACK_FRAME_LOCAL(num_params,var)
+#define STACK_FRAME_LR_POS   16
+#define STACK_FRAME_CR_POS   8
+
+#define LOAD_REG_IMMEDIATE(reg,expr) \
+	lis	reg,(expr)@highest;	\
+	ori	reg,reg,(expr)@higher;	\
+	rldicr	reg,reg,32,31;	\
+	oris	reg,reg,(expr)@high;	\
+	ori	reg,reg,(expr)@l;
+
+/* It is very important to note here that _extra is the extra amount of
+ * stack space needed.
+ * This space must be accessed using STACK_FRAME_PARAM() or
+ * STACK_FRAME_LOCAL() macros!
+ *
+ * r1 and r2 are not defined in ppc-asm.h (instead they are defined as sp
+ * and toc). Kernel programmers tend to prefer rX even for r1 and r2, hence
+ * %1 and %r2. r0 is defined in ppc-asm.h and therefore %r0 gets
+ * preprocessed incorrectly, hence r0.
+ */
+#define PUSH_BASIC_STACK(_extra) \
+	mflr	r0; \
+	std	r0,STACK_FRAME_LR_POS(%r1); \
+	stdu	%r1,-(_extra + STACK_FRAME_MIN_SIZE)(%r1); \
+	mfcr	r0; \
+	stw	r0,STACK_FRAME_CR_POS(%r1); \
+	std	%r2,STACK_FRAME_TOC_POS(%r1);
+
+#define POP_BASIC_STACK(_extra) \
+	ld	%r2,STACK_FRAME_TOC_POS(%r1); \
+	lwz	r0,STACK_FRAME_CR_POS(%r1); \
+	mtcr	r0; \
+	addi	%r1,%r1,(_extra + STACK_FRAME_MIN_SIZE); \
+	ld	r0,STACK_FRAME_LR_POS(%r1); \
+	mtlr	r0;
+
diff --git a/tools/testing/selftests/powerpc/math/.gitignore b/tools/testing/selftests/powerpc/math/.gitignore
new file mode 100644
index 0000000..b19b269
--- /dev/null
+++ b/tools/testing/selftests/powerpc/math/.gitignore
@@ -0,0 +1,2 @@
+fpu_syscall
+vmx_syscall
diff --git a/tools/testing/selftests/powerpc/math/Makefile b/tools/testing/selftests/powerpc/math/Makefile
new file mode 100644
index 0000000..598e5df
--- /dev/null
+++ b/tools/testing/selftests/powerpc/math/Makefile
@@ -0,0 +1,16 @@
+TEST_PROGS := fpu_syscall vmx_syscall
+
+all: $(TEST_PROGS)
+
+#The general powerpc makefile adds -flto. This isn't interacting well with the custom ASM.
+#filter-out -flto to avoid false failures.
+$(TEST_PROGS): ../harness.c
+$(TEST_PROGS): CFLAGS = $(filter-out -flto,$(CFLAGS) -O2 -g -pthread -m64 -maltivec)
+
+fpu_syscall: fpu_asm.S
+vmx_syscall: vmx_asm.S
+
+include ../../lib.mk
+
+clean:
+	rm -f $(TEST_PROGS) *.o
diff --git a/tools/testing/selftests/powerpc/math/fpu_asm.S b/tools/testing/selftests/powerpc/math/fpu_asm.S
new file mode 100644
index 0000000..b12c051
--- /dev/null
+++ b/tools/testing/selftests/powerpc/math/fpu_asm.S
@@ -0,0 +1,161 @@
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
+
+#define PUSH_FPU(pos) \
+	stfd	f14,pos(sp); \
+	stfd	f15,pos+8(sp); \
+	stfd	f16,pos+16(sp); \
+	stfd	f17,pos+24(sp); \
+	stfd	f18,pos+32(sp); \
+	stfd	f19,pos+40(sp); \
+	stfd	f20,pos+48(sp); \
+	stfd	f21,pos+56(sp); \
+	stfd	f22,pos+64(sp); \
+	stfd	f23,pos+72(sp); \
+	stfd	f24,pos+80(sp); \
+	stfd	f25,pos+88(sp); \
+	stfd	f26,pos+96(sp); \
+	stfd	f27,pos+104(sp); \
+	stfd	f28,pos+112(sp); \
+	stfd	f29,pos+120(sp); \
+	stfd	f30,pos+128(sp); \
+	stfd	f31,pos+136(sp);
+
+#define POP_FPU(pos) \
+	lfd	f14,pos(sp); \
+	lfd	f15,pos+8(sp); \
+	lfd	f16,pos+16(sp); \
+	lfd	f17,pos+24(sp); \
+	lfd	f18,pos+32(sp); \
+	lfd	f19,pos+40(sp); \
+	lfd	f20,pos+48(sp); \
+	lfd	f21,pos+56(sp); \
+	lfd	f22,pos+64(sp); \
+	lfd	f23,pos+72(sp); \
+	lfd	f24,pos+80(sp); \
+	lfd	f25,pos+88(sp); \
+	lfd	f26,pos+96(sp); \
+	lfd	f27,pos+104(sp); \
+	lfd	f28,pos+112(sp); \
+	lfd	f29,pos+120(sp); \
+	lfd	f30,pos+128(sp); \
+	lfd	f31,pos+136(sp);
+
+#Careful calling this, it will 'clobber' fpu (by design)
+#Don't call this from C
+FUNC_START(load_fpu)
+	lfd	f14,0(r3)
+	lfd	f15,8(r3)
+	lfd	f16,16(r3)
+	lfd	f17,24(r3)
+	lfd	f18,32(r3)
+	lfd	f19,40(r3)
+	lfd	f20,48(r3)
+	lfd	f21,56(r3)
+	lfd	f22,64(r3)
+	lfd	f23,72(r3)
+	lfd	f24,80(r3)
+	lfd	f25,88(r3)
+	lfd	f26,96(r3)
+	lfd	f27,104(r3)
+	lfd	f28,112(r3)
+	lfd	f29,120(r3)
+	lfd	f30,128(r3)
+	lfd	f31,136(r3)
+	blr
+FUNC_END(load_fpu)
+
+FUNC_START(check_fpu)
+	mr r4,r3
+	li	r3,1 #assume a bad result
+	lfd	f0,0(r4)
+	fcmpu	cr1,f0,f14
+	bne	cr1,1f
+	lfd	f0,8(r4)
+	fcmpu	cr1,f0,f15
+	bne	cr1,1f
+	lfd	f0,16(r4)
+	fcmpu	cr1,f0,f16
+	bne	cr1,1f
+	lfd	f0,24(r4)
+	fcmpu	cr1,f0,f17
+	bne	cr1,1f
+	lfd	f0,32(r4)
+	fcmpu	cr1,f0,f18
+	bne	cr1,1f
+	lfd	f0,40(r4)
+	fcmpu	cr1,f0,f19
+	bne	cr1,1f
+	lfd	f0,48(r4)
+	fcmpu	cr1,f0,f20
+	bne	cr1,1f
+	lfd	f0,56(r4)
+	fcmpu	cr1,f0,f21
+	bne	cr1,1f
+	lfd	f0,64(r4)
+	fcmpu	cr1,f0,f22
+	bne	cr1,1f
+	lfd	f0,72(r4)
+	fcmpu	cr1,f0,f23
+	bne	cr1,1f
+	lfd	f0,80(r4)
+	fcmpu	cr1,f0,f24
+	bne	cr1,1f
+	lfd	f0,88(r4)
+	fcmpu	cr1,f0,f25
+	bne	cr1,1f
+	lfd	f0,96(r4)
+	fcmpu	cr1,f0,f26
+	bne	cr1,1f
+	lfd	f0,104(r4)
+	fcmpu	cr1,f0,f27
+	bne	cr1,1f
+	lfd	f0,112(r4)
+	fcmpu	cr1,f0,f28
+	bne	cr1,1f
+	lfd	f0,120(r4)
+	fcmpu	cr1,f0,f29
+	bne	cr1,1f
+	lfd	f0,128(r4)
+	fcmpu	cr1,f0,f30
+	bne	cr1,1f
+	lfd	f0,136(r4)
+	fcmpu	cr1,f0,f31
+	bne	cr1,1f
+	li	r3,0 #Sucess!!!
+1:	blr
+
+FUNC_START(test_fpu)
+	#r3 holds pointer to where to put the result of fork
+	#r4 holds pointer to the pid
+	#f14-f31 are non volatiles
+	PUSH_BASIC_STACK(256)
+	std	r3,STACK_FRAME_PARAM(0)(sp) #Address of darray
+	std r4,STACK_FRAME_PARAM(1)(sp) #Address of pid
+	PUSH_FPU(STACK_FRAME_LOCAL(2,0))
+
+	bl load_fpu
+	nop
+	li	r0,__NR_fork
+	sc
+
+	#pass the result of the fork to the caller
+	ld	r9,STACK_FRAME_PARAM(1)(sp)
+	std	r3,0(r9)
+
+	ld r3,STACK_FRAME_PARAM(0)(sp)
+	bl check_fpu
+	nop
+
+	POP_FPU(STACK_FRAME_LOCAL(2,0))
+	POP_BASIC_STACK(256)
+	blr
+FUNC_END(test_fpu)
diff --git a/tools/testing/selftests/powerpc/math/fpu_syscall.c b/tools/testing/selftests/powerpc/math/fpu_syscall.c
new file mode 100644
index 0000000..949e672
--- /dev/null
+++ b/tools/testing/selftests/powerpc/math/fpu_syscall.c
@@ -0,0 +1,90 @@
+/*
+ * Copyright 2015, Cyril Bur, IBM Corp.
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version
+ * 2 of the License, or (at your option) any later version.
+ *
+ * This test attempts to see if the FPU registers change across a syscall (fork).
+ */
+
+#include <stdio.h>
+#include <unistd.h>
+#include <sys/syscall.h>
+#include <sys/time.h>
+#include <sys/types.h>
+#include <sys/wait.h>
+#include <stdlib.h>
+
+#include "utils.h"
+
+extern int test_fpu(double *darray, pid_t *pid);
+
+double darray[] = {0.1, 0.2, 0.3, 0.4, 0.5, 0.6, 0.7, 0.8, 0.9, 1.0,
+		     1.1, 1.2, 1.3, 1.4, 1.5, 1.6, 1.7, 1.8, 1.9, 2.0,
+		     2.1};
+
+int syscall_fpu(void)
+{
+	pid_t fork_pid;
+	int i;
+	int ret;
+	int child_ret;
+	for (i = 0; i < 1000; i++) {
+		/* test_fpu will fork() */
+		ret = test_fpu(darray, &fork_pid);
+		if (fork_pid == -1)
+			return -1;
+		if (fork_pid == 0)
+			exit(ret);
+		waitpid(fork_pid, &child_ret, 0);
+		if (ret || child_ret)
+			return 1;
+	}
+
+	return 0;
+}
+
+int test_syscall_fpu(void)
+{
+	/*
+	 * Setup an environment with much context switching
+	 */
+	pid_t pid2;
+	pid_t pid = fork();
+	int ret;
+	int child_ret;
+	FAIL_IF(pid == -1);
+
+	pid2 = fork();
+	/* Can't FAIL_IF(pid2 == -1); because already forked once */
+	if (pid2 == -1) {
+		/*
+		 * Couldn't fork, ensure test is a fail
+		 */
+		child_ret = ret = 1;
+	} else {
+		ret = syscall_fpu();
+		if (pid2)
+			waitpid(pid2, &child_ret, 0);
+		else
+			exit(ret);
+	}
+
+	ret |= child_ret;
+
+	if (pid)
+		waitpid(pid, &child_ret, 0);
+	else
+		exit(ret);
+
+	FAIL_IF(ret || child_ret);
+	return 0;
+}
+
+int main(int argc, char *argv[])
+{
+	return test_harness(test_syscall_fpu, "syscall_fpu");
+
+}
diff --git a/tools/testing/selftests/powerpc/math/vmx_asm.S b/tools/testing/selftests/powerpc/math/vmx_asm.S
new file mode 100644
index 0000000..82ddb38
--- /dev/null
+++ b/tools/testing/selftests/powerpc/math/vmx_asm.S
@@ -0,0 +1,195 @@
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
+
+#define PUSH_VMX(pos,reg) \
+	li	reg,pos; \
+	stvx	v20,reg,sp; \
+	addi	reg,reg,16; \
+	stvx	v21,reg,sp; \
+	addi	reg,reg,16; \
+	stvx	v22,reg,sp; \
+	addi	reg,reg,16; \
+	stvx	v23,reg,sp; \
+	addi	reg,reg,16; \
+	stvx	v24,reg,sp; \
+	addi	reg,reg,16; \
+	stvx	v25,reg,sp; \
+	addi	reg,reg,16; \
+	stvx	v26,reg,sp; \
+	addi	reg,reg,16; \
+	stvx	v27,reg,sp; \
+	addi	reg,reg,16; \
+	stvx	v28,reg,sp; \
+	addi	reg,reg,16; \
+	stvx	v29,reg,sp; \
+	addi	reg,reg,16; \
+	stvx	v30,reg,sp; \
+	addi	reg,reg,16; \
+	stvx	v31,reg,sp;
+
+#define POP_VMX(pos,reg) \
+	li	reg,pos; \
+	lvx	v20,reg,sp; \
+	addi	reg,reg,16; \
+	lvx	v21,reg,sp; \
+	addi	reg,reg,16; \
+	lvx	v22,reg,sp; \
+	addi	reg,reg,16; \
+	lvx	v23,reg,sp; \
+	addi	reg,reg,16; \
+	lvx	v24,reg,sp; \
+	addi	reg,reg,16; \
+	lvx	v25,reg,sp; \
+	addi	reg,reg,16; \
+	lvx	v26,reg,sp; \
+	addi	reg,reg,16; \
+	lvx	v27,reg,sp; \
+	addi	reg,reg,16; \
+	lvx	v28,reg,sp; \
+	addi	reg,reg,16; \
+	lvx	v29,reg,sp; \
+	addi	reg,reg,16; \
+	lvx	v30,reg,sp; \
+	addi	reg,reg,16; \
+	lvx	v31,reg,sp;
+
+#Carefull this will 'clobber' vmx (by design)
+#Don't call this from C
+FUNC_START(load_vmx)
+	li	r5,0
+	lvx	v20,r5,r3
+	addi	r5,r5,16
+	lvx	v21,r5,r3
+	addi	r5,r5,16
+	lvx	v22,r5,r3
+	addi	r5,r5,16
+	lvx	v23,r5,r3
+	addi	r5,r5,16
+	lvx	v24,r5,r3
+	addi	r5,r5,16
+	lvx	v25,r5,r3
+	addi	r5,r5,16
+	lvx	v26,r5,r3
+	addi	r5,r5,16
+	lvx	v27,r5,r3
+	addi	r5,r5,16
+	lvx	v28,r5,r3
+	addi	r5,r5,16
+	lvx	v29,r5,r3
+	addi	r5,r5,16
+	lvx	v30,r5,r3
+	addi	r5,r5,16
+	lvx	v31,r5,r3
+	blr
+FUNC_END(load_vmx)
+
+#Should be safe from C, only touches r4, r5 and v0,v1,v2
+FUNC_START(check_vmx)
+	PUSH_BASIC_STACK(16)
+	mr r4,r3
+	li	r3,1 #assume a bad result
+	li	r5,0
+	lvx	v0,r5,r4
+	vcmpequd.	v1,v0,v20
+	vmr	v2,v1
+
+	addi	r5,r5,16
+	lvx	v0,r5,r4
+	vcmpequd.	v1,v0,v21
+	vand	v2,v2,v1
+
+	addi	r5,r5,16
+	lvx	v0,r5,r4
+	vcmpequd.	v1,v0,v22
+	vand	v2,v2,v1
+
+	addi	r5,r5,16
+	lvx	v0,r5,r4
+	vcmpequd.	v1,v0,v23
+	vand	v2,v2,v1
+
+	addi	r5,r5,16
+	lvx	v0,r5,r4
+	vcmpequd.	v1,v0,v24
+	vand	v2,v2,v1
+
+	addi	r5,r5,16
+	lvx	v0,r5,r4
+	vcmpequd.	v1,v0,v25
+	vand	v2,v2,v1
+
+	addi	r5,r5,16
+	lvx	v0,r5,r4
+	vcmpequd.	v1,v0,v26
+	vand	v2,v2,v1
+
+	addi	r5,r5,16
+	lvx	v0,r5,r4
+	vcmpequd.	v1,v0,v27
+	vand	v2,v2,v1
+
+	addi	r5,r5,16
+	lvx	v0,r5,r4
+	vcmpequd.	v1,v0,v28
+	vand	v2,v2,v1
+
+	addi	r5,r5,16
+	lvx	v0,r5,r4
+	vcmpequd.	v1,v0,v29
+	vand	v2,v2,v1
+
+	addi	r5,r5,16
+	lvx	v0,r5,r4
+	vcmpequd.	v1,v0,v30
+	vand	v2,v2,v1
+
+	addi	r5,r5,16
+	lvx	v0,r5,r4
+	vcmpequd.	v1,v0,v31
+	vand	v2,v2,v1
+
+	li	r5,STACK_FRAME_LOCAL(0,0)
+	stvx	v2,r5,sp
+	ldx	r0,r5,sp
+	cmpdi	r0,0xffffffffffffffff
+	bne	1f
+	li	r3,0
+1:	POP_BASIC_STACK(16)
+	blr
+FUNC_END(check_vmx)
+
+#Safe from C
+FUNC_START(test_vmx)
+	#r3 holds pointer to where to put the result of fork
+	#r4 holds pointer to the pid
+	#v20-v31 are non-volatile
+	PUSH_BASIC_STACK(512)
+	std	r3,STACK_FRAME_PARAM(0)(sp) #Address of varray
+	std r4,STACK_FRAME_PARAM(1)(sp) #address of pid
+	PUSH_VMX(STACK_FRAME_LOCAL(2,0),r4)
+
+	bl load_vmx
+	nop
+
+	li	r0,__NR_fork
+	sc
+	#Pass the result of fork back to the caller
+	ld	r9,STACK_FRAME_PARAM(1)(sp)
+	std	r3,0(r9)
+
+	ld r3,STACK_FRAME_PARAM(0)(sp)
+	bl check_vmx
+	nop
+
+	POP_VMX(STACK_FRAME_LOCAL(2,0),r4)
+	POP_BASIC_STACK(512)
+	blr
+FUNC_END(test_vmx)
diff --git a/tools/testing/selftests/powerpc/math/vmx_syscall.c b/tools/testing/selftests/powerpc/math/vmx_syscall.c
new file mode 100644
index 0000000..a017918
--- /dev/null
+++ b/tools/testing/selftests/powerpc/math/vmx_syscall.c
@@ -0,0 +1,91 @@
+/*
+ * Copyright 2015, Cyril Bur, IBM Corp.
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version
+ * 2 of the License, or (at your option) any later version.
+ *
+ * This test attempts to see if the VMX registers change across a syscall (fork).
+ */
+
+#include <altivec.h>
+#include <stdio.h>
+#include <unistd.h>
+#include <sys/syscall.h>
+#include <sys/time.h>
+#include <stdlib.h>
+#include <sys/types.h>
+#include <sys/wait.h>
+#include "utils.h"
+
+vector int varray[] = {{1, 2, 3, 4}, {5, 6, 7, 8}, {9, 10,11,12},
+	{13,14,15,16},{17,18,19,20},{21,22,23,24},
+	{25,26,27,28},{29,30,31,32},{33,34,35,36},
+	{37,38,39,40},{41,42,43,44},{45,46,47,48}};
+
+extern int test_vmx(vector int *varray, pid_t *pid);
+
+int vmx_syscall(void)
+{
+	pid_t fork_pid;
+	int i;
+	int ret;
+	int child_ret;
+	for (i = 0; i < 1000; i++) {
+		/* test_vmx will fork() */
+		ret = test_vmx(varray, &fork_pid);
+		if (fork_pid == -1)
+			return -1;
+		if (fork_pid == 0)
+			exit(ret);
+		waitpid(fork_pid, &child_ret, 0);
+		if (ret || child_ret)
+			return 1;
+	}
+
+	return 0;
+}
+
+int test_vmx_syscall(void)
+{
+	/*
+	 * Setup an environment with much context switching
+	 */
+	pid_t pid2;
+	pid_t pid = fork();
+	int ret;
+	int child_ret;
+	FAIL_IF(pid == -1);
+
+	pid2 = fork();
+	ret = vmx_syscall();
+	/* Can't FAIL_IF(pid2 == -1); because we've already forked */
+	if (pid2 == -1) {
+		/*
+		 * Couldn't fork, ensure child_ret is set and is a fail
+		 */
+		ret = child_ret = 1;
+	} else {
+		if (pid2)
+			waitpid(pid2, &child_ret, 0);
+		else
+			exit(ret);
+	}
+
+	ret |= child_ret;
+
+	if (pid)
+		waitpid(pid, &child_ret, 0);
+	else
+		exit(ret);
+
+	FAIL_IF(ret || child_ret);
+	return 0;
+}
+
+int main(int argc, char *argv[])
+{
+	return test_harness(test_vmx_syscall, "vmx_syscall");
+
+}
-- 
2.7.1

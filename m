Return-Path: <cyrilbur@gmail.com>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rPZWs4Q9SzDq5c
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  8 Jun 2016 14:02:17 +1000 (AEST)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3rPZWs0Frzz9sxS
 for <linuxppc-dev@ozlabs.org>; Wed,  8 Jun 2016 14:02:16 +1000 (AEST)
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u583wigt092740
 for <linuxppc-dev@ozlabs.org>; Wed, 8 Jun 2016 00:02:15 -0400
Received: from e23smtp03.au.ibm.com (e23smtp03.au.ibm.com [202.81.31.145])
 by mx0a-001b2d01.pphosted.com with ESMTP id 23e9m3hc2v-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@ozlabs.org>; Wed, 08 Jun 2016 00:02:14 -0400
Received: from localhost
 by e23smtp03.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <cyrilbur@gmail.com>;
 Wed, 8 Jun 2016 14:02:12 +1000
Received: from d23relay10.au.ibm.com (d23relay10.au.ibm.com [9.190.26.77])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id 602A93578069
 for <linuxppc-dev@ozlabs.org>; Wed,  8 Jun 2016 14:01:57 +1000 (EST)
Received: from d23av06.au.ibm.com (d23av06.au.ibm.com [9.190.235.151])
 by d23relay10.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u5841pvn51904696
 for <linuxppc-dev@ozlabs.org>; Wed, 8 Jun 2016 14:01:51 +1000
Received: from d23av06.au.ibm.com (localhost [127.0.0.1])
 by d23av06.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u5841ebg030763
 for <linuxppc-dev@ozlabs.org>; Wed, 8 Jun 2016 14:01:41 +1000
From: Cyril Bur <cyrilbur@gmail.com>
To: mpe@ellerman.id.au
Cc: linuxppc-dev@ozlabs.org, mikey@neuling.org,
 Anshuman Khandual <khandual@linux.vnet.ibm.com>
Subject: [PATCH 2/5] selftests/powerpc: Add test to check TM ucontext creation
Date: Wed,  8 Jun 2016 14:00:33 +1000
In-Reply-To: <20160608040036.13064-1-cyrilbur@gmail.com>
References: <20160608040036.13064-1-cyrilbur@gmail.com>
Message-Id: <20160608040036.13064-3-cyrilbur@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Signed-off-by: Cyril Bur <cyrilbur@gmail.com>
---
 tools/testing/selftests/powerpc/basic_asm.h        |   4 +
 tools/testing/selftests/powerpc/fpu_asm.h          |  72 ++++++++++++
 tools/testing/selftests/powerpc/gpr_asm.h          |  96 ++++++++++++++++
 tools/testing/selftests/powerpc/math/fpu_asm.S     |  73 +-----------
 tools/testing/selftests/powerpc/math/vmx_asm.S     |  85 +-------------
 tools/testing/selftests/powerpc/tm/Makefile        |   9 +-
 .../powerpc/tm/tm-signal-context-chk-fpu.c         |  94 +++++++++++++++
 .../powerpc/tm/tm-signal-context-chk-gpr.c         |  96 ++++++++++++++++
 .../powerpc/tm/tm-signal-context-chk-vmx.c         | 112 ++++++++++++++++++
 .../powerpc/tm/tm-signal-context-chk-vsx.c         | 127 +++++++++++++++++++++
 .../selftests/powerpc/tm/tm-signal-context-chk.c   | 102 +++++++++++++++++
 tools/testing/selftests/powerpc/tm/tm-signal.S     | 105 +++++++++++++++++
 tools/testing/selftests/powerpc/vmx_asm.h          |  98 ++++++++++++++++
 13 files changed, 920 insertions(+), 153 deletions(-)
 create mode 100644 tools/testing/selftests/powerpc/fpu_asm.h
 create mode 100644 tools/testing/selftests/powerpc/gpr_asm.h
 create mode 100644 tools/testing/selftests/powerpc/tm/tm-signal-context-chk-fpu.c
 create mode 100644 tools/testing/selftests/powerpc/tm/tm-signal-context-chk-gpr.c
 create mode 100644 tools/testing/selftests/powerpc/tm/tm-signal-context-chk-vmx.c
 create mode 100644 tools/testing/selftests/powerpc/tm/tm-signal-context-chk-vsx.c
 create mode 100644 tools/testing/selftests/powerpc/tm/tm-signal-context-chk.c
 create mode 100644 tools/testing/selftests/powerpc/tm/tm-signal.S
 create mode 100644 tools/testing/selftests/powerpc/vmx_asm.h

diff --git a/tools/testing/selftests/powerpc/basic_asm.h b/tools/testing/selftests/powerpc/basic_asm.h
index 3349a07..5131059 100644
--- a/tools/testing/selftests/powerpc/basic_asm.h
+++ b/tools/testing/selftests/powerpc/basic_asm.h
@@ -4,6 +4,10 @@
 #include <ppc-asm.h>
 #include <asm/unistd.h>
 
+#define TBEGIN .long 0x7C00051D
+#define TSUSPEND .long 0x7C0005DD
+#define TRESUME .long 0x7C2005DD
+
 #define LOAD_REG_IMMEDIATE(reg,expr) \
 	lis	reg,(expr)@highest;	\
 	ori	reg,reg,(expr)@higher;	\
diff --git a/tools/testing/selftests/powerpc/fpu_asm.h b/tools/testing/selftests/powerpc/fpu_asm.h
new file mode 100644
index 0000000..a73a7a9
--- /dev/null
+++ b/tools/testing/selftests/powerpc/fpu_asm.h
@@ -0,0 +1,72 @@
+#ifndef _SELFTESTS_POWERPC_FPU_ASM_H
+#define _SELFTESTS_POWERPC_FPU_ASM_H
+#include "basic_asm.h"
+
+#define PUSH_FPU(stack_size) \
+	stfd	f31,(stack_size + STACK_FRAME_MIN_SIZE)(%r1); \
+	stfd	f30,(stack_size + STACK_FRAME_MIN_SIZE - 8)(%r1); \
+	stfd	f29,(stack_size + STACK_FRAME_MIN_SIZE - 16)(%r1); \
+	stfd	f28,(stack_size + STACK_FRAME_MIN_SIZE - 24)(%r1); \
+	stfd	f27,(stack_size + STACK_FRAME_MIN_SIZE - 32)(%r1); \
+	stfd	f26,(stack_size + STACK_FRAME_MIN_SIZE - 40)(%r1); \
+	stfd	f25,(stack_size + STACK_FRAME_MIN_SIZE - 48)(%r1); \
+	stfd	f24,(stack_size + STACK_FRAME_MIN_SIZE - 56)(%r1); \
+	stfd	f23,(stack_size + STACK_FRAME_MIN_SIZE - 64)(%r1); \
+	stfd	f22,(stack_size + STACK_FRAME_MIN_SIZE - 72)(%r1); \
+	stfd	f21,(stack_size + STACK_FRAME_MIN_SIZE - 80)(%r1); \
+	stfd	f20,(stack_size + STACK_FRAME_MIN_SIZE - 88)(%r1); \
+	stfd	f19,(stack_size + STACK_FRAME_MIN_SIZE - 96)(%r1); \
+	stfd	f18,(stack_size + STACK_FRAME_MIN_SIZE - 104)(%r1); \
+	stfd	f17,(stack_size + STACK_FRAME_MIN_SIZE - 112)(%r1); \
+	stfd	f16,(stack_size + STACK_FRAME_MIN_SIZE - 120)(%r1); \
+	stfd	f15,(stack_size + STACK_FRAME_MIN_SIZE - 128)(%r1); \
+	stfd	f14,(stack_size + STACK_FRAME_MIN_SIZE - 136)(%r1);
+
+#define POP_FPU(stack_size) \
+	lfd	f31,(stack_size + STACK_FRAME_MIN_SIZE)(%r1); \
+	lfd	f30,(stack_size + STACK_FRAME_MIN_SIZE - 8)(%r1); \
+	lfd	f29,(stack_size + STACK_FRAME_MIN_SIZE - 16)(%r1); \
+	lfd	f28,(stack_size + STACK_FRAME_MIN_SIZE - 24)(%r1); \
+	lfd	f27,(stack_size + STACK_FRAME_MIN_SIZE - 32)(%r1); \
+	lfd	f26,(stack_size + STACK_FRAME_MIN_SIZE - 40)(%r1); \
+	lfd	f25,(stack_size + STACK_FRAME_MIN_SIZE - 48)(%r1); \
+	lfd	f24,(stack_size + STACK_FRAME_MIN_SIZE - 56)(%r1); \
+	lfd	f23,(stack_size + STACK_FRAME_MIN_SIZE - 64)(%r1); \
+	lfd	f22,(stack_size + STACK_FRAME_MIN_SIZE - 72)(%r1); \
+	lfd	f21,(stack_size + STACK_FRAME_MIN_SIZE - 80)(%r1); \
+	lfd	f20,(stack_size + STACK_FRAME_MIN_SIZE - 88)(%r1); \
+	lfd	f19,(stack_size + STACK_FRAME_MIN_SIZE - 96)(%r1); \
+	lfd	f18,(stack_size + STACK_FRAME_MIN_SIZE - 104)(%r1); \
+	lfd	f17,(stack_size + STACK_FRAME_MIN_SIZE - 112)(%r1); \
+	lfd	f16,(stack_size + STACK_FRAME_MIN_SIZE - 120)(%r1); \
+	lfd	f15,(stack_size + STACK_FRAME_MIN_SIZE - 128)(%r1); \
+	lfd	f14,(stack_size + STACK_FRAME_MIN_SIZE - 136)(%r1);
+
+/*
+ * Careful calling this, it will 'clobber' fpu (by design)
+ * Don't call this from C
+ */
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
+#endif /* _SELFTESTS_POWERPC_FPU_ASM_H */
+
diff --git a/tools/testing/selftests/powerpc/gpr_asm.h b/tools/testing/selftests/powerpc/gpr_asm.h
new file mode 100644
index 0000000..475fde9
--- /dev/null
+++ b/tools/testing/selftests/powerpc/gpr_asm.h
@@ -0,0 +1,96 @@
+/*
+ * Copyright 2015, Cyril Bur, IBM Corp.
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version
+ * 2 of the License, or (at your option) any later version.
+ */
+
+#ifndef _SELFTESTS_POWERPC_GPR_ASM_H
+#define _SELFTESTS_POWERPC_GPR_ASM_H
+
+#include "basic_asm.h"
+
+#define __PUSH_NVREGS(top_pos); \
+	std r31,(top_pos)(%r1); \
+	std r30,(top_pos - 8)(%r1); \
+	std r29,(top_pos - 16)(%r1); \
+	std r28,(top_pos - 24)(%r1); \
+	std r27,(top_pos - 32)(%r1); \
+	std r26,(top_pos - 40)(%r1); \
+	std r25,(top_pos - 48)(%r1); \
+	std r24,(top_pos - 56)(%r1); \
+	std r23,(top_pos - 64)(%r1); \
+	std r22,(top_pos - 72)(%r1); \
+	std r21,(top_pos - 80)(%r1); \
+	std r20,(top_pos - 88)(%r1); \
+	std r19,(top_pos - 96)(%r1); \
+	std r18,(top_pos - 104)(%r1); \
+	std r17,(top_pos - 112)(%r1); \
+	std r16,(top_pos - 120)(%r1); \
+	std r15,(top_pos - 128)(%r1); \
+	std r14,(top_pos - 136)(%r1)
+
+#define __POP_NVREGS(top_pos); \
+	ld r31,(top_pos)(%r1); \
+	ld r30,(top_pos - 8)(%r1); \
+	ld r29,(top_pos - 16)(%r1); \
+	ld r28,(top_pos - 24)(%r1); \
+	ld r27,(top_pos - 32)(%r1); \
+	ld r26,(top_pos - 40)(%r1); \
+	ld r25,(top_pos - 48)(%r1); \
+	ld r24,(top_pos - 56)(%r1); \
+	ld r23,(top_pos - 64)(%r1); \
+	ld r22,(top_pos - 72)(%r1); \
+	ld r21,(top_pos - 80)(%r1); \
+	ld r20,(top_pos - 88)(%r1); \
+	ld r19,(top_pos - 96)(%r1); \
+	ld r18,(top_pos - 104)(%r1); \
+	ld r17,(top_pos - 112)(%r1); \
+	ld r16,(top_pos - 120)(%r1); \
+	ld r15,(top_pos - 128)(%r1); \
+	ld r14,(top_pos - 136)(%r1)
+
+#define PUSH_NVREGS(stack_size) \
+	__PUSH_NVREGS(stack_size + STACK_FRAME_MIN_SIZE)
+
+/* 18 NV FPU REGS */
+#define PUSH_NVREGS_BELOW_FPU(stack_size) \
+	__PUSH_NVREGS(stack_size + STACK_FRAME_MIN_SIZE - (18 * 8))
+
+#define POP_NVREGS(stack_size) \
+	__POP_NVREGS(stack_size + STACK_FRAME_MIN_SIZE)
+
+/* 18 NV FPU REGS */
+#define POP_NVREGS_BELOW_FPU(stack_size) \
+	__POP_NVREGS(stack_size + STACK_FRAME_MIN_SIZE - (18 * 8))
+
+/*
+ * Careful calling this, it will 'clobber' NVGPRs (by design)
+ * Don't call this from C
+ */
+FUNC_START(load_gpr)
+	ld	r14,0(r3)
+	ld	r15,8(r3)
+	ld	r16,16(r3)
+	ld	r17,24(r3)
+	ld	r18,32(r3)
+	ld	r19,40(r3)
+	ld	r20,48(r3)
+	ld	r21,56(r3)
+	ld	r22,64(r3)
+	ld	r23,72(r3)
+	ld	r24,80(r3)
+	ld	r25,88(r3)
+	ld	r26,96(r3)
+	ld	r27,104(r3)
+	ld	r28,112(r3)
+	ld	r29,120(r3)
+	ld	r30,128(r3)
+	ld	r31,136(r3)
+	blr
+FUNC_END(load_gpr)
+
+
+#endif /* _SELFTESTS_POWERPC_GPR_ASM_H */
diff --git a/tools/testing/selftests/powerpc/math/fpu_asm.S b/tools/testing/selftests/powerpc/math/fpu_asm.S
index f3711d8..241f067 100644
--- a/tools/testing/selftests/powerpc/math/fpu_asm.S
+++ b/tools/testing/selftests/powerpc/math/fpu_asm.S
@@ -8,70 +8,7 @@
  */
 
 #include "../basic_asm.h"
-
-#define PUSH_FPU(pos) \
-	stfd	f14,pos(sp); \
-	stfd	f15,pos+8(sp); \
-	stfd	f16,pos+16(sp); \
-	stfd	f17,pos+24(sp); \
-	stfd	f18,pos+32(sp); \
-	stfd	f19,pos+40(sp); \
-	stfd	f20,pos+48(sp); \
-	stfd	f21,pos+56(sp); \
-	stfd	f22,pos+64(sp); \
-	stfd	f23,pos+72(sp); \
-	stfd	f24,pos+80(sp); \
-	stfd	f25,pos+88(sp); \
-	stfd	f26,pos+96(sp); \
-	stfd	f27,pos+104(sp); \
-	stfd	f28,pos+112(sp); \
-	stfd	f29,pos+120(sp); \
-	stfd	f30,pos+128(sp); \
-	stfd	f31,pos+136(sp);
-
-#define POP_FPU(pos) \
-	lfd	f14,pos(sp); \
-	lfd	f15,pos+8(sp); \
-	lfd	f16,pos+16(sp); \
-	lfd	f17,pos+24(sp); \
-	lfd	f18,pos+32(sp); \
-	lfd	f19,pos+40(sp); \
-	lfd	f20,pos+48(sp); \
-	lfd	f21,pos+56(sp); \
-	lfd	f22,pos+64(sp); \
-	lfd	f23,pos+72(sp); \
-	lfd	f24,pos+80(sp); \
-	lfd	f25,pos+88(sp); \
-	lfd	f26,pos+96(sp); \
-	lfd	f27,pos+104(sp); \
-	lfd	f28,pos+112(sp); \
-	lfd	f29,pos+120(sp); \
-	lfd	f30,pos+128(sp); \
-	lfd	f31,pos+136(sp);
-
-# Careful calling this, it will 'clobber' fpu (by design)
-# Don't call this from C
-FUNC_START(load_fpu)
-	lfd	f14,0(r3)
-	lfd	f15,8(r3)
-	lfd	f16,16(r3)
-	lfd	f17,24(r3)
-	lfd	f18,32(r3)
-	lfd	f19,40(r3)
-	lfd	f20,48(r3)
-	lfd	f21,56(r3)
-	lfd	f22,64(r3)
-	lfd	f23,72(r3)
-	lfd	f24,80(r3)
-	lfd	f25,88(r3)
-	lfd	f26,96(r3)
-	lfd	f27,104(r3)
-	lfd	f28,112(r3)
-	lfd	f29,120(r3)
-	lfd	f30,128(r3)
-	lfd	f31,136(r3)
-	blr
-FUNC_END(load_fpu)
+#include "../fpu_asm.h"
 
 FUNC_START(check_fpu)
 	mr r4,r3
@@ -138,9 +75,9 @@ FUNC_START(test_fpu)
 	# r4 holds pointer to the pid
 	# f14-f31 are non volatiles
 	PUSH_BASIC_STACK(256)
+	PUSH_FPU(256)
 	std	r3,STACK_FRAME_PARAM(0)(sp) # Address of darray
 	std r4,STACK_FRAME_PARAM(1)(sp) # Address of pid
-	PUSH_FPU(STACK_FRAME_LOCAL(2,0))
 
 	bl load_fpu
 	nop
@@ -155,7 +92,7 @@ FUNC_START(test_fpu)
 	bl check_fpu
 	nop
 
-	POP_FPU(STACK_FRAME_LOCAL(2,0))
+	POP_FPU(256)
 	POP_BASIC_STACK(256)
 	blr
 FUNC_END(test_fpu)
@@ -166,10 +103,10 @@ FUNC_END(test_fpu)
 # registers while running is not zero.
 FUNC_START(preempt_fpu)
 	PUSH_BASIC_STACK(256)
+	PUSH_FPU(256)
 	std r3,STACK_FRAME_PARAM(0)(sp) # double *darray
 	std r4,STACK_FRAME_PARAM(1)(sp) # int *threads_starting
 	std r5,STACK_FRAME_PARAM(2)(sp) # int *running
-	PUSH_FPU(STACK_FRAME_LOCAL(3,0))
 
 	bl load_fpu
 	nop
@@ -192,7 +129,7 @@ FUNC_START(preempt_fpu)
 	cmpwi r5,0
 	bne 2b
 
-3:	POP_FPU(STACK_FRAME_LOCAL(3,0))
+3:	POP_FPU(256)
 	POP_BASIC_STACK(256)
 	blr
 FUNC_END(preempt_fpu)
diff --git a/tools/testing/selftests/powerpc/math/vmx_asm.S b/tools/testing/selftests/powerpc/math/vmx_asm.S
index 1b8c248..fd74da4 100644
--- a/tools/testing/selftests/powerpc/math/vmx_asm.S
+++ b/tools/testing/selftests/powerpc/math/vmx_asm.S
@@ -8,90 +8,7 @@
  */
 
 #include "../basic_asm.h"
-
-# POS MUST BE 16 ALIGNED!
-#define PUSH_VMX(pos,reg) \
-	li	reg,pos; \
-	stvx	v20,reg,sp; \
-	addi	reg,reg,16; \
-	stvx	v21,reg,sp; \
-	addi	reg,reg,16; \
-	stvx	v22,reg,sp; \
-	addi	reg,reg,16; \
-	stvx	v23,reg,sp; \
-	addi	reg,reg,16; \
-	stvx	v24,reg,sp; \
-	addi	reg,reg,16; \
-	stvx	v25,reg,sp; \
-	addi	reg,reg,16; \
-	stvx	v26,reg,sp; \
-	addi	reg,reg,16; \
-	stvx	v27,reg,sp; \
-	addi	reg,reg,16; \
-	stvx	v28,reg,sp; \
-	addi	reg,reg,16; \
-	stvx	v29,reg,sp; \
-	addi	reg,reg,16; \
-	stvx	v30,reg,sp; \
-	addi	reg,reg,16; \
-	stvx	v31,reg,sp;
-
-# POS MUST BE 16 ALIGNED!
-#define POP_VMX(pos,reg) \
-	li	reg,pos; \
-	lvx	v20,reg,sp; \
-	addi	reg,reg,16; \
-	lvx	v21,reg,sp; \
-	addi	reg,reg,16; \
-	lvx	v22,reg,sp; \
-	addi	reg,reg,16; \
-	lvx	v23,reg,sp; \
-	addi	reg,reg,16; \
-	lvx	v24,reg,sp; \
-	addi	reg,reg,16; \
-	lvx	v25,reg,sp; \
-	addi	reg,reg,16; \
-	lvx	v26,reg,sp; \
-	addi	reg,reg,16; \
-	lvx	v27,reg,sp; \
-	addi	reg,reg,16; \
-	lvx	v28,reg,sp; \
-	addi	reg,reg,16; \
-	lvx	v29,reg,sp; \
-	addi	reg,reg,16; \
-	lvx	v30,reg,sp; \
-	addi	reg,reg,16; \
-	lvx	v31,reg,sp;
-
-# Carefull this will 'clobber' vmx (by design)
-# Don't call this from C
-FUNC_START(load_vmx)
-	li	r5,0
-	lvx	v20,r5,r3
-	addi	r5,r5,16
-	lvx	v21,r5,r3
-	addi	r5,r5,16
-	lvx	v22,r5,r3
-	addi	r5,r5,16
-	lvx	v23,r5,r3
-	addi	r5,r5,16
-	lvx	v24,r5,r3
-	addi	r5,r5,16
-	lvx	v25,r5,r3
-	addi	r5,r5,16
-	lvx	v26,r5,r3
-	addi	r5,r5,16
-	lvx	v27,r5,r3
-	addi	r5,r5,16
-	lvx	v28,r5,r3
-	addi	r5,r5,16
-	lvx	v29,r5,r3
-	addi	r5,r5,16
-	lvx	v30,r5,r3
-	addi	r5,r5,16
-	lvx	v31,r5,r3
-	blr
-FUNC_END(load_vmx)
+#include "../vmx_asm.h"
 
 # Should be safe from C, only touches r4, r5 and v0,v1,v2
 FUNC_START(check_vmx)
diff --git a/tools/testing/selftests/powerpc/tm/Makefile b/tools/testing/selftests/powerpc/tm/Makefile
index d0505db..4362666 100644
--- a/tools/testing/selftests/powerpc/tm/Makefile
+++ b/tools/testing/selftests/powerpc/tm/Makefile
@@ -1,4 +1,8 @@
-TEST_PROGS := tm-resched-dscr tm-syscall tm-signal-msr-resv tm-signal-stack tm-vmxcopy tm-fork tm-tar tm-tmspr
+SIGNAL_CONTEXT_CHK_TESTS := tm-signal-context-chk-gpr tm-signal-context-chk-fpu \
+	tm-signal-context-chk-vmx tm-signal-context-chk-vsx
+
+TEST_PROGS := tm-resched-dscr tm-syscall tm-signal-msr-resv tm-signal-stack \
+	tm-vmxcopy tm-fork tm-tar tm-tmspr $(SIGNAL_CONTEXT_CHK_TESTS)
 
 all: $(TEST_PROGS)
 
@@ -8,6 +12,9 @@ tm-syscall: tm-syscall-asm.S
 tm-syscall: CFLAGS += -mhtm -I../../../../../usr/include
 tm-tmspr: CFLAGS += -pthread
 
+$(SIGNAL_CONTEXT_CHK_TESTS): tm-signal.S
+$(SIGNAL_CONTEXT_CHK_TESTS): CFLAGS += -mhtm
+
 include ../../lib.mk
 
 clean:
diff --git a/tools/testing/selftests/powerpc/tm/tm-signal-context-chk-fpu.c b/tools/testing/selftests/powerpc/tm/tm-signal-context-chk-fpu.c
new file mode 100644
index 0000000..776457d
--- /dev/null
+++ b/tools/testing/selftests/powerpc/tm/tm-signal-context-chk-fpu.c
@@ -0,0 +1,94 @@
+/*
+ * Copyright 2016, Cyril Bur, IBM Corp.
+ * Licensed under GPLv2.
+ *
+ * Test the kernel's signal frame code.
+ *
+ * The kernel sets up two sets of ucontexts if the signal was to be delivered
+ * while the thread was in a transaction. Expected behaviour is that the
+ * currently executing code is in the first and the checkpointed state (the
+ * state that will be rolled back to) is in the uc_link ucontext.
+ *
+ * The reason for this is that code which is not TM aware and installs a signal
+ * handler will expect to see/modify its currently running state in the uc,
+ * this code may have dynamicially linked against code which is TM aware and is
+ * doing HTM under the hood.
+ */
+
+#include <stdlib.h>
+#include <stdio.h>
+#include <signal.h>
+#include <unistd.h>
+
+#include "utils.h"
+#include "tm.h"
+
+#define TBEGIN          ".long 0x7C00051D ;"
+#define TSUSPEND        ".long 0x7C0005DD ;"
+#define TRESUME         ".long 0x7C2005DD ;"
+#define MAX_ATTEMPT 100
+
+#define NV_FPU_REGS 18
+
+/* Be sure there are 2x as many as there are NV FPU regs (2x18) */
+static double fps[] = { 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18,
+					   -1,-2,-3,-4,-5,-6,-7,-8,-9,-10,-11,-12,-13,-14,-15,-16,-17,-18 };
+
+extern long tm_signal_self_context_load(pid_t pid, long *gps, double *fps, vector int *vms, vector int *vss);
+
+static int signaled;
+static int fail;
+
+static void signal_usr1(int signum, siginfo_t *info, void *uc)
+{
+	int i;
+	ucontext_t *ucp = uc;
+	ucontext_t *tm_ucp = ucp->uc_link;
+
+	signaled = 1;
+
+	for (i = 0; i < NV_FPU_REGS && !fail; i++) {
+		fail = (ucp->uc_mcontext.fp_regs[i + 14] != fps[i]);
+		fail |= (tm_ucp->uc_mcontext.fp_regs[i + 14] != fps[i + NV_FPU_REGS]);
+	}
+	if (fail)
+		printf("Failed on %d FP %g or %g\n", i - 1, ucp->uc_mcontext.fp_regs[i + 13], tm_ucp->uc_mcontext.fp_regs[i + 13]);
+}
+
+static int tm_signal_context_chk_fpu()
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
+	while (!signaled && i < MAX_ATTEMPT) {
+		rc = tm_signal_self_context_load(pid, NULL, fps, NULL, NULL);
+		if (!rc)
+			fprintf(stderr, "Transaction was not doomed...\n");
+		FAIL_IF(!rc);
+
+		i++;
+	}
+
+	if (i == MAX_ATTEMPT)
+		fprintf(stderr, "Tried to signal %d times and didn't work, failing!\n", MAX_ATTEMPT);
+	FAIL_IF(i == MAX_ATTEMPT);
+	return fail;
+}
+
+int main(void)
+{
+	return test_harness(tm_signal_context_chk_fpu, "tm_signal_context_chk_fpu");
+}
diff --git a/tools/testing/selftests/powerpc/tm/tm-signal-context-chk-gpr.c b/tools/testing/selftests/powerpc/tm/tm-signal-context-chk-gpr.c
new file mode 100644
index 0000000..22abe48
--- /dev/null
+++ b/tools/testing/selftests/powerpc/tm/tm-signal-context-chk-gpr.c
@@ -0,0 +1,96 @@
+/*
+ * Copyright 2016, Cyril Bur, IBM Corp.
+ * Licensed under GPLv2.
+ *
+ * Test the kernel's signal frame code.
+ *
+ * The kernel sets up two sets of ucontexts if the signal was to be delivered
+ * while the thread was in a transaction. Expected behaviour is that the
+ * currently executing code is in the first and the checkpointed state (the
+ * state that will be rolled back to) is in the uc_link ucontext.
+ *
+ * The reason for this is that code which is not TM aware and installs a signal
+ * handler will expect to see/modify its currently running state in the uc,
+ * this code may have dynamicially linked against code which is TM aware and is
+ * doing HTM under the hood.
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
+#define TBEGIN          ".long 0x7C00051D ;"
+#define TSUSPEND        ".long 0x7C0005DD ;"
+#define TRESUME         ".long 0x7C2005DD ;"
+#define MAX_ATTEMPT 100
+
+#define NV_GPR_REGS 18
+
+extern long tm_signal_self_context_load(pid_t pid, long *gps, double *fps, vector int *vms, vector int *vss);
+
+static int signaled;
+static int fail;
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
+	signaled = 1;
+
+	/* Always be 64bit, don't really care about 32bit */
+	for (i = 0; i < NV_GPR_REGS && !fail; i++) {
+		fail = (ucp->uc_mcontext.gp_regs[i + 14] != gps[i]);
+		fail |= (tm_ucp->uc_mcontext.gp_regs[i + 14] != gps[i + NV_GPR_REGS]);
+	}
+	if (fail)
+		printf("Failed on %d GPR %lu or %lu\n", i - 1,
+				ucp->uc_mcontext.gp_regs[i + 13], tm_ucp->uc_mcontext.gp_regs[i + 13]);
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
+	while (!signaled && i < MAX_ATTEMPT) {
+		rc = tm_signal_self_context_load(pid, gps, NULL, NULL, NULL);
+		if (!rc)
+			fprintf(stderr, "Transaction was not doomed...\n");
+		FAIL_IF(!rc);
+		i++;
+	}
+
+	if (i == MAX_ATTEMPT)
+		fprintf(stderr, "Tried to signal %d times and didn't work, failing!\n", MAX_ATTEMPT);
+	FAIL_IF(i == MAX_ATTEMPT);
+	return fail;
+}
+
+int main(void)
+{
+	return test_harness(tm_signal_context_chk_gpr, "tm_signal_context_chk_gpr");
+}
diff --git a/tools/testing/selftests/powerpc/tm/tm-signal-context-chk-vmx.c b/tools/testing/selftests/powerpc/tm/tm-signal-context-chk-vmx.c
new file mode 100644
index 0000000..fd58369
--- /dev/null
+++ b/tools/testing/selftests/powerpc/tm/tm-signal-context-chk-vmx.c
@@ -0,0 +1,112 @@
+/*
+ * Copyright 2016, Cyril Bur, IBM Corp.
+ * Licensed under GPLv2.
+ *
+ * Test the kernel's signal frame code.
+ *
+ * The kernel sets up two sets of ucontexts if the signal was to be delivered
+ * while the thread was in a transaction. Expected behaviour is that the
+ * currently executing code is in the first and the checkpointed state (the
+ * state that will be rolled back to) is in the uc_link ucontext.
+ *
+ * The reason for this is that code which is not TM aware and installs a signal
+ * handler will expect to see/modify its currently running state in the uc,
+ * this code may have dynamicially linked against code which is TM aware and is
+ * doing HTM under the hood.
+ */
+
+#include <stdlib.h>
+#include <stdio.h>
+#include <string.h>
+#include <signal.h>
+#include <unistd.h>
+
+#include <altivec.h>
+
+#include "utils.h"
+#include "tm.h"
+
+#define TBEGIN          ".long 0x7C00051D ;"
+#define TSUSPEND        ".long 0x7C0005DD ;"
+#define TRESUME         ".long 0x7C2005DD ;"
+#define MAX_ATTEMPT 100
+
+extern long tm_signal_self_context_load(pid_t pid, long *gps, double *fps, vector int *vms, vector int *vss);
+
+static int signaled;
+static int fail;
+
+vector int vms[] = {{1, 2, 3, 4}, {5, 6, 7, 8}, {9, 10,11,12},
+	{13,14,15,16},{17,18,19,20},{21,22,23,24},
+	{25,26,27,28},{29,30,31,32},{33,34,35,36},
+	{37,38,39,40},{41,42,43,44},{45,46,47,48},
+	{-1, -2, -3, -4}, {-5, -6, -7, -8}, {-9, -10,-11,-12},
+	{-13,-14,-15,-16},{-17,-18,-19,-20},{-21,-22,-23,-24},
+	{-25,-26,-27,-28},{-29,-30,-31,-32},{-33,-34,-35,-36},
+	{-37,-38,-39,-40},{-41,-42,-43,-44},{-45,-46,-47,-48}};
+
+static void signal_usr1(int signum, siginfo_t *info, void *uc)
+{
+	int i;
+	ucontext_t *ucp = uc;
+	ucontext_t *tm_ucp = ucp->uc_link;
+
+	signaled = 1;
+
+	/* Always be 64bit, don't really care about 32bit */
+	for (i = 0; i < 12 && !fail; i++) {
+		fail = memcmp(ucp->uc_mcontext.v_regs->vrregs[i + 20], &vms[i], 16);
+		fail |= memcmp(tm_ucp->uc_mcontext.v_regs->vrregs[i + 20], &vms[i + 12], 16);
+	}
+	if (fail) {
+		int j;
+
+		fprintf(stderr, "Failed on %d vmx 0x", i - 1);
+		for (j = 0; j < 4; j++)
+			fprintf(stderr, "%08x", ucp->uc_mcontext.v_regs->vrregs[i + 19][j]);
+		fprintf(stderr, " vs 0x");
+		for (j = 0 ; j < 4; j++)
+			fprintf(stderr, "%08x", tm_ucp->uc_mcontext.v_regs->vrregs[i + 19][j]);
+		fprintf(stderr, "\n");
+		return;
+	}
+}
+
+static int tm_signal_context_chk()
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
+	while (!signaled && i < MAX_ATTEMPT) {
+		rc = tm_signal_self_context_load(pid, NULL, NULL, vms, NULL);
+		if (!rc) {
+			fprintf(stderr, "Transaction was not doomed...\n");
+			FAIL_IF(!rc);
+		}
+		i++;
+	}
+
+	if (i == MAX_ATTEMPT) {
+		fprintf(stderr, "Tried to signal %d times and didn't work, failing!\n", MAX_ATTEMPT);
+		fail = 1;
+	}
+	return fail;
+}
+
+int main(void)
+{
+	return test_harness(tm_signal_context_chk, "tm_signal_context_chk_vmx");
+}
diff --git a/tools/testing/selftests/powerpc/tm/tm-signal-context-chk-vsx.c b/tools/testing/selftests/powerpc/tm/tm-signal-context-chk-vsx.c
new file mode 100644
index 0000000..9685881
--- /dev/null
+++ b/tools/testing/selftests/powerpc/tm/tm-signal-context-chk-vsx.c
@@ -0,0 +1,127 @@
+/*
+ * Copyright 2016, Cyril Bur, IBM Corp.
+ * Licensed under GPLv2.
+ *
+ * Test the kernel's signal frame code.
+ *
+ * The kernel sets up two sets of ucontexts if the signal was to be delivered
+ * while the thread was in a transaction. Expected behaviour is that the
+ * currently executing code is in the first and the checkpointed state (the
+ * state that will be rolled back to) is in the uc_link ucontext.
+ *
+ * The reason for this is that code which is not TM aware and installs a signal
+ * handler will expect to see/modify its currently running state in the uc,
+ * this code may have dynamicially linked against code which is TM aware and is
+ * doing HTM under the hood.
+ */
+
+#include <stdlib.h>
+#include <stdio.h>
+#include <string.h>
+#include <signal.h>
+#include <unistd.h>
+
+#include <altivec.h>
+
+#include "utils.h"
+#include "tm.h"
+
+#define TBEGIN          ".long 0x7C00051D ;"
+#define TSUSPEND        ".long 0x7C0005DD ;"
+#define TRESUME         ".long 0x7C2005DD ;"
+#define MAX_ATTEMPT 100
+
+extern long tm_signal_self_context_load(pid_t pid, long *gps, double *fps, vector int *vms, vector int *vss);
+
+static int signaled;
+static int fail;
+
+vector int vss[] = {{1, 2, 3, 4}, {5, 6, 7, 8}, {9, 10,11,12},
+	{13,14,15,16},{17,18,19,20},{21,22,23,24},
+	{25,26,27,28},{29,30,31,32},{33,34,35,36},
+	{37,38,39,40},{41,42,43,44},{45,46,47,48},
+	{-1, -2, -3, -4}, {-5, -6, -7, -8}, {-9, -10,-11,-12},
+	{-13,-14,-15,-16},{-17,-18,-19,-20},{-21,-22,-23,-24},
+	{-25,-26,-27,-28},{-29,-30,-31,-32},{-33,-34,-35,-36},
+	{-37,-38,-39,-40},{-41,-42,-43,-44},{-45,-46,-47,-48}};
+
+static void signal_usr1(int signum, siginfo_t *info, void *uc)
+{
+	int i;
+	uint8_t vsc[16];
+	uint8_t vst[16];
+	ucontext_t *ucp = uc;
+	ucontext_t *tm_ucp = ucp->uc_link;
+
+	signaled = 1;
+
+	/*
+	 * The other half of the VSX regs will be after v_regs.
+	 *
+	 * In short, vmx_reserve array holds everything. v_regs is a 16
+	 * byte aligned pointer at the start of vmx_reserve (vmx_reserve
+	 * may or may not be 16 aligned) where the v_regs structure exists.
+	 * (half of) The VSX regsters are directly after v_regs so the
+	 * easiest way to find them below.
+	 */
+	long *vsx_ptr = (long *)(ucp->uc_mcontext.v_regs + 1);
+	long *tm_vsx_ptr = (long *)(tm_ucp->uc_mcontext.v_regs + 1);
+	/* Always be 64bit, don't really care about 32bit */
+	for (i = 0; i < 12 && !fail; i++) {
+		memcpy(vsc, &ucp->uc_mcontext.fp_regs[i + 20], 8);
+		memcpy(vsc + 8, &vsx_ptr[20 + i], 8);
+		fail = memcmp(vsc, &vss[i], 16);
+		memcpy(vst, &tm_ucp->uc_mcontext.fp_regs[i + 20], 8);
+		memcpy(vst + 8, &tm_vsx_ptr[20 + i], 8);
+		fail |= memcmp(vst, &vss[i + 12], 16);
+	}
+	if (fail) {
+		fprintf(stderr, "Failed on %d vsx 0x", i - 1);
+		for (i = 0; i < 16; i++)
+			fprintf(stderr, "%02x", vsc[i]);
+		fprintf(stderr, " vs 0x");
+		for (i = 0; i < 16; i++)
+			fprintf(stderr, "%02x", vst[i]);
+		fprintf(stderr, "\n");
+		return;
+	}
+}
+
+static int tm_signal_context_chk()
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
+	while (!signaled && i < MAX_ATTEMPT) {
+		rc = tm_signal_self_context_load(pid, NULL, NULL, NULL, vss);
+		if (!rc) {
+			fprintf(stderr, "Transaction was not doomed...\n");
+			FAIL_IF(!rc);
+		}
+		i++;
+	}
+
+	if (i == MAX_ATTEMPT) {
+		fprintf(stderr, "Tried to signal %d times and didn't work, failing!\n", MAX_ATTEMPT);
+		fail = 1;
+	}
+	return fail;
+}
+
+int main(void)
+{
+	return test_harness(tm_signal_context_chk, "tm_signal_context_chk_vsx");
+}
diff --git a/tools/testing/selftests/powerpc/tm/tm-signal-context-chk.c b/tools/testing/selftests/powerpc/tm/tm-signal-context-chk.c
new file mode 100644
index 0000000..4c906cf
--- /dev/null
+++ b/tools/testing/selftests/powerpc/tm/tm-signal-context-chk.c
@@ -0,0 +1,102 @@
+/*
+ * Copyright 2016, Cyril Bur, IBM Corp.
+ * Licensed under GPLv2.
+ *
+ * Test the kernel's signal frame code.
+ *
+ * The kernel sets up two sets of ucontexts if the signal was to be delivered
+ * while the thread was in a transaction. Expected behaviour is that the
+ * currently executing code is in the first and the checkpointed state (the
+ * state that will be rolled back to) is in the uc_link ucontext.
+ *
+ * The reason for this is that code which is not TM aware and installs a signal
+ * handler will expect to see/modify its currently running state in the uc,
+ * this code may have dynamicially linked against code which is TM aware and is
+ * doing HTM under the hood.
+ */
+
+#include <stdlib.h>
+#include <stdio.h>
+#include <signal.h>
+#include <unistd.h>
+
+#include "utils.h"
+#include "tm.h"
+
+#define TBEGIN          ".long 0x7C00051D ;"
+#define TSUSPEND        ".long 0x7C0005DD ;"
+#define TRESUME         ".long 0x7C2005DD ;"
+#define MAX_ATTEMPT 100
+
+static double fps[] = { 1, 2, 3, 4, 5, 6, 7, 8,
+						-1, -2, -3, -4, -5, -6, -7, -8 };
+
+extern long tm_signal_self(pid_t pid, double *fps);
+
+static int signaled;
+static int fail;
+
+static void signal_usr1(int signum, siginfo_t *info, void *uc)
+{
+	int i;
+	ucontext_t *ucp = uc;
+	ucontext_t *tm_ucp = ucp->uc_link;
+
+	signaled = 1;
+
+	/* Always be 64bit, don't really care about 32bit */
+	for (i = 0; i < 8 && !fail; i++) {
+		fail = (ucp->uc_mcontext.gp_regs[i + 14] != i);
+		fail |= (tm_ucp->uc_mcontext.gp_regs[i + 14] != 0xFF - i);
+	}
+	if (fail) {
+		printf("Failed on %d gpr %lu or %lu\n", i - 1, ucp->uc_mcontext.gp_regs[i + 13], tm_ucp->uc_mcontext.gp_regs[i + 13]);
+		return;
+	}
+	for (i = 0; i < 8 && !fail; i++) {
+		fail = (ucp->uc_mcontext.fp_regs[i + 14] != fps[i]);
+		fail |= (tm_ucp->uc_mcontext.fp_regs[i + 14] != fps[i + 8]);
+	}
+	if (fail) {
+		printf("Failed on %d FP %g or %g\n", i - 1, ucp->uc_mcontext.fp_regs[i + 13], tm_ucp->uc_mcontext.fp_regs[i + 13]);
+	}
+}
+
+static int tm_signal_context_chk()
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
+	while (!signaled && i < MAX_ATTEMPT) {
+		rc = tm_signal_self(pid, fps);
+		if (!rc) {
+			fprintf(stderr, "Transaction was not doomed...\n");
+			FAIL_IF(!rc);
+		}
+		i++;
+	}
+
+	if (i == MAX_ATTEMPT) {
+		fprintf(stderr, "Tried to signal %d times and didn't work, failing!\n", MAX_ATTEMPT);
+		fail = 1;
+	}
+	return fail;
+}
+
+int main(void)
+{
+	return test_harness(tm_signal_context_chk, "tm_signal_context_chk");
+}
diff --git a/tools/testing/selftests/powerpc/tm/tm-signal.S b/tools/testing/selftests/powerpc/tm/tm-signal.S
new file mode 100644
index 0000000..c9e7d1e
--- /dev/null
+++ b/tools/testing/selftests/powerpc/tm/tm-signal.S
@@ -0,0 +1,105 @@
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
+	/* Set r3 (return value) before TBEGIN. Use the pid as a known
+	 * 'all good' return value, zero is used to indicate a non-doomed
+	 * transaction.
+	 */
+	ld	r3, STACK_FRAME_PARAM(0)(sp)
+	TBEGIN
+	beq	1f
+	ld	r3, STACK_FRAME_PARAM(1)(sp)
+	cmpdi	r3, 0
+	/* Get the second half of the array */
+	addi	r3, r3, 8 * 18
+	beq skip_gpr_lt
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
+	TSUSPEND /* Can't enter a syscall transactionally, hardware won't let us */
+	li	r0, 37 /* sys_kill */
+	ld r3, STACK_FRAME_PARAM(0)(sp)
+	li r4, 10 /* SIGUSR1 */
+	sc /* Taking the signal will doom the transaction */
+	TRESUME
+	/*
+	 * This will cause us to resume doomed transaction and cause
+	 * hardware to cleanup, we'll end up at 1: anything between
+	 * TRESUME and 1: shouldn't ever run.
+	 */
+	li r3, 0
+	1:
+	POP_VMX(STACK_FRAME_LOCAL(5,0),r4)
+	POP_FPU(512)
+	POP_NVREGS_BELOW_FPU(512)
+	POP_BASIC_STACK(512)
+	blr
+FUNC_END(tm_signal_self_context_load)
diff --git a/tools/testing/selftests/powerpc/vmx_asm.h b/tools/testing/selftests/powerpc/vmx_asm.h
new file mode 100644
index 0000000..461845dd
--- /dev/null
+++ b/tools/testing/selftests/powerpc/vmx_asm.h
@@ -0,0 +1,98 @@
+/*
+ * Copyright 2015, Cyril Bur, IBM Corp.
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version
+ * 2 of the License, or (at your option) any later version.
+ */
+
+#include "basic_asm.h"
+
+/* POS MUST BE 16 ALIGNED! */
+#define PUSH_VMX(pos,reg) \
+	li	reg,pos; \
+	stvx	v20,reg,%r1; \
+	addi	reg,reg,16; \
+	stvx	v21,reg,%r1; \
+	addi	reg,reg,16; \
+	stvx	v22,reg,%r1; \
+	addi	reg,reg,16; \
+	stvx	v23,reg,%r1; \
+	addi	reg,reg,16; \
+	stvx	v24,reg,%r1; \
+	addi	reg,reg,16; \
+	stvx	v25,reg,%r1; \
+	addi	reg,reg,16; \
+	stvx	v26,reg,%r1; \
+	addi	reg,reg,16; \
+	stvx	v27,reg,%r1; \
+	addi	reg,reg,16; \
+	stvx	v28,reg,%r1; \
+	addi	reg,reg,16; \
+	stvx	v29,reg,%r1; \
+	addi	reg,reg,16; \
+	stvx	v30,reg,%r1; \
+	addi	reg,reg,16; \
+	stvx	v31,reg,%r1;
+
+/* POS MUST BE 16 ALIGNED! */
+#define POP_VMX(pos,reg) \
+	li	reg,pos; \
+	lvx	v20,reg,%r1; \
+	addi	reg,reg,16; \
+	lvx	v21,reg,%r1; \
+	addi	reg,reg,16; \
+	lvx	v22,reg,%r1; \
+	addi	reg,reg,16; \
+	lvx	v23,reg,%r1; \
+	addi	reg,reg,16; \
+	lvx	v24,reg,%r1; \
+	addi	reg,reg,16; \
+	lvx	v25,reg,%r1; \
+	addi	reg,reg,16; \
+	lvx	v26,reg,%r1; \
+	addi	reg,reg,16; \
+	lvx	v27,reg,%r1; \
+	addi	reg,reg,16; \
+	lvx	v28,reg,%r1; \
+	addi	reg,reg,16; \
+	lvx	v29,reg,%r1; \
+	addi	reg,reg,16; \
+	lvx	v30,reg,%r1; \
+	addi	reg,reg,16; \
+	lvx	v31,reg,%r1;
+
+/*
+ * Careful this will 'clobber' vmx (by design)
+ * Don't call this from C
+ */
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
+
-- 
2.8.3

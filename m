Return-Path: <cyrilbur@gmail.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sSmZR2lw4zDrpd
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  6 Sep 2016 09:45:51 +1000 (AEST)
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
 u85NhDwH036854
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 5 Sep 2016 19:45:48 -0400
Received: from e23smtp09.au.ibm.com (e23smtp09.au.ibm.com [202.81.31.142])
 by mx0b-001b2d01.pphosted.com with ESMTP id 259d48ska6-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 05 Sep 2016 19:45:48 -0400
Received: from localhost
 by e23smtp09.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <cyrilbur@gmail.com>;
 Tue, 6 Sep 2016 09:45:45 +1000
Received: from d23relay06.au.ibm.com (d23relay06.au.ibm.com [9.185.63.219])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id BD3422CE8056
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  6 Sep 2016 09:45:42 +1000 (EST)
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay06.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u85NjgDN63176954
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 6 Sep 2016 09:45:42 +1000
Received: from d23av03.au.ibm.com (localhost [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u85NjgHb025000
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 6 Sep 2016 09:45:42 +1000
From: Cyril Bur <cyrilbur@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: wei.guo.simon@gmail.com, mikey@neuling.org
Subject: [PATCH v4 08/20] selftests/powerpc: Rework FPU stack placement macros
 and move to header file
Date: Tue,  6 Sep 2016 09:44:36 +1000
In-Reply-To: <20160905234448.5866-1-cyrilbur@gmail.com>
References: <20160905234448.5866-1-cyrilbur@gmail.com>
Message-Id: <20160905234448.5866-9-cyrilbur@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The FPU regs are placed at the top of the stack frame. Currently the
position expected to be passed to the macro. The macros now should be
passed the stack frame size and from there they can calculate where to
put the regs, this makes the use simpler.

Also move them to a header file to be used in an different area of the
powerpc selftests

Signed-off-by: Cyril Bur <cyrilbur@gmail.com>
---
 tools/testing/selftests/powerpc/fpu_asm.h      | 81 ++++++++++++++++++++++++++
 tools/testing/selftests/powerpc/math/fpu_asm.S | 73 ++---------------------
 2 files changed, 86 insertions(+), 68 deletions(-)
 create mode 100644 tools/testing/selftests/powerpc/fpu_asm.h

diff --git a/tools/testing/selftests/powerpc/fpu_asm.h b/tools/testing/selftests/powerpc/fpu_asm.h
new file mode 100644
index 0000000..24061b8
--- /dev/null
+++ b/tools/testing/selftests/powerpc/fpu_asm.h
@@ -0,0 +1,81 @@
+/*
+ * Copyright 2016, Cyril Bur, IBM Corp.
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version
+ * 2 of the License, or (at your option) any later version.
+ */
+
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
-- 
2.9.3

Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 101DB1A01E6
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 Jul 2014 17:31:43 +1000 (EST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: <linuxppc-dev@ozlabs.org>
Subject: [PATCH 03/10] selftests/powerpc: Move core_busy_loop() into asm
Date: Wed, 23 Jul 2014 17:31:33 +1000
Message-Id: <1406100700-9702-3-git-send-email-mpe@ellerman.id.au>
In-Reply-To: <1406100700-9702-1-git-send-email-mpe@ellerman.id.au>
References: <1406100700-9702-1-git-send-email-mpe@ellerman.id.au>
Cc: sam.bobroff@au1.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

There is at least one bug in core_busy_loop(), we use r0, but it's
not in the clobber list. We were getting away with this it seems but
that was luck.

It's also fishy to be touching the stack, even if we do it below the
stack pointer. It seems we get away with it, but looking at the
generated code that may just be luck.

So move it into assembler, do all the stack handling by hand. We create
a stack frame to save the non-volatiles in, so we can muck around with
them.

Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 tools/testing/selftests/powerpc/pmu/ebb/Makefile   |   2 +-
 .../testing/selftests/powerpc/pmu/ebb/busy_loop.S  | 271 +++++++++++++++++++++
 tools/testing/selftests/powerpc/pmu/ebb/ebb.c      | 251 -------------------
 tools/testing/selftests/powerpc/pmu/ebb/ebb.h      |   1 -
 4 files changed, 272 insertions(+), 253 deletions(-)
 create mode 100644 tools/testing/selftests/powerpc/pmu/ebb/busy_loop.S

diff --git a/tools/testing/selftests/powerpc/pmu/ebb/Makefile b/tools/testing/selftests/powerpc/pmu/ebb/Makefile
index edbba2affc2c..251447eafe49 100644
--- a/tools/testing/selftests/powerpc/pmu/ebb/Makefile
+++ b/tools/testing/selftests/powerpc/pmu/ebb/Makefile
@@ -17,7 +17,7 @@ PROGS := reg_access_test event_attributes_test cycles_test	\
 
 all: $(PROGS)
 
-$(PROGS): ../../harness.c ../event.c ../lib.c ebb.c ebb_handler.S trace.c
+$(PROGS): ../../harness.c ../event.c ../lib.c ebb.c ebb_handler.S trace.c busy_loop.S
 
 instruction_count_test: ../loop.S
 
diff --git a/tools/testing/selftests/powerpc/pmu/ebb/busy_loop.S b/tools/testing/selftests/powerpc/pmu/ebb/busy_loop.S
new file mode 100644
index 000000000000..c7e4093f1cd3
--- /dev/null
+++ b/tools/testing/selftests/powerpc/pmu/ebb/busy_loop.S
@@ -0,0 +1,271 @@
+/*
+ * Copyright 2014, Michael Ellerman, IBM Corp.
+ * Licensed under GPLv2.
+ */
+
+#include <ppc-asm.h>
+
+	.text
+
+FUNC_START(core_busy_loop)
+	stdu	%r1, -168(%r1)
+	std	r14, 160(%r1)
+	std	r15, 152(%r1)
+	std	r16, 144(%r1)
+	std	r17, 136(%r1)
+	std	r18, 128(%r1)
+	std	r19, 120(%r1)
+	std	r20, 112(%r1)
+	std	r21, 104(%r1)
+	std	r22, 96(%r1)
+	std	r23, 88(%r1)
+	std	r24, 80(%r1)
+	std	r25, 72(%r1)
+	std	r26, 64(%r1)
+	std	r27, 56(%r1)
+	std	r28, 48(%r1)
+	std	r29, 40(%r1)
+	std	r30, 32(%r1)
+	std	r31, 24(%r1)
+
+	li	 r3, 0x3030
+	std	 r3, -96(%r1)
+	li	 r4, 0x4040
+	std	 r4, -104(%r1)
+	li	 r5, 0x5050
+	std	 r5, -112(%r1)
+	li	 r6, 0x6060
+	std	 r6, -120(%r1)
+	li	 r7, 0x7070
+	std	 r7, -128(%r1)
+	li	 r8, 0x0808
+	std	 r8, -136(%r1)
+	li	 r9, 0x0909
+	std	 r9, -144(%r1)
+	li	r10, 0x1010
+	std	r10, -152(%r1)
+	li	r11, 0x1111
+	std	r11, -160(%r1)
+	li	r14, 0x1414
+	std	r14, -168(%r1)
+	li	r15, 0x1515
+	std	r15, -176(%r1)
+	li	r16, 0x1616
+	std	r16, -184(%r1)
+	li	r17, 0x1717
+	std	r17, -192(%r1)
+	li	r18, 0x1818
+	std	r18, -200(%r1)
+	li	r19, 0x1919
+	std	r19, -208(%r1)
+	li	r20, 0x2020
+	std	r20, -216(%r1)
+	li	r21, 0x2121
+	std	r21, -224(%r1)
+	li	r22, 0x2222
+	std	r22, -232(%r1)
+	li	r23, 0x2323
+	std	r23, -240(%r1)
+	li	r24, 0x2424
+	std	r24, -248(%r1)
+	li	r25, 0x2525
+	std	r25, -256(%r1)
+	li	r26, 0x2626
+	std	r26, -264(%r1)
+	li	r27, 0x2727
+	std	r27, -272(%r1)
+	li	r28, 0x2828
+	std	r28, -280(%r1)
+	li	r29, 0x2929
+	std	r29, -288(%r1)
+	li	r30, 0x3030
+	li	r31, 0x3131
+
+	li	r3, 0
+0:	addi	r3, r3, 1
+	cmpwi	r3, 100
+	blt	0b
+
+	/* Return 1 (fail) unless we get through all the checks */
+	li	r3, 1
+
+	/* Check none of our registers have been corrupted */
+	cmpwi	r4,  0x4040
+	bne	1f
+	cmpwi	r5,  0x5050
+	bne	1f
+	cmpwi	r6,  0x6060
+	bne	1f
+	cmpwi	r7,  0x7070
+	bne	1f
+	cmpwi	r8,  0x0808
+	bne	1f
+	cmpwi	r9,  0x0909
+	bne	1f
+	cmpwi	r10, 0x1010
+	bne	1f
+	cmpwi	r11, 0x1111
+	bne	1f
+	cmpwi	r14, 0x1414
+	bne	1f
+	cmpwi	r15, 0x1515
+	bne	1f
+	cmpwi	r16, 0x1616
+	bne	1f
+	cmpwi	r17, 0x1717
+	bne	1f
+	cmpwi	r18, 0x1818
+	bne	1f
+	cmpwi	r19, 0x1919
+	bne	1f
+	cmpwi	r20, 0x2020
+	bne	1f
+	cmpwi	r21, 0x2121
+	bne	1f
+	cmpwi	r22, 0x2222
+	bne	1f
+	cmpwi	r23, 0x2323
+	bne	1f
+	cmpwi	r24, 0x2424
+	bne	1f
+	cmpwi	r25, 0x2525
+	bne	1f
+	cmpwi	r26, 0x2626
+	bne	1f
+	cmpwi	r27, 0x2727
+	bne	1f
+	cmpwi	r28, 0x2828
+	bne	1f
+	cmpwi	r29, 0x2929
+	bne	1f
+	cmpwi	r30, 0x3030
+	bne	1f
+	cmpwi	r31, 0x3131
+	bne	1f
+
+	/* Load junk into all our registers before we reload them from the stack. */
+	li	r3,  0xde
+	li	r4,  0xad
+	li	r5,  0xbe
+	li	r6,  0xef
+	li	r7,  0xde
+	li	r8,  0xad
+	li	r9,  0xbe
+	li	r10, 0xef
+	li	r11, 0xde
+	li	r14, 0xad
+	li	r15, 0xbe
+	li	r16, 0xef
+	li	r17, 0xde
+	li	r18, 0xad
+	li	r19, 0xbe
+	li	r20, 0xef
+	li	r21, 0xde
+	li	r22, 0xad
+	li	r23, 0xbe
+	li	r24, 0xef
+	li	r25, 0xde
+	li	r26, 0xad
+	li	r27, 0xbe
+	li	r28, 0xef
+	li	r29, 0xdd
+
+	ld	r3,	-96(%r1)
+	cmpwi	r3,  0x3030
+	bne	1f
+	ld	r4,	-104(%r1)
+	cmpwi	r4,  0x4040
+	bne	1f
+	ld	r5,	-112(%r1)
+	cmpwi	r5,  0x5050
+	bne	1f
+	ld	r6,	-120(%r1)
+	cmpwi	r6,  0x6060
+	bne	1f
+	ld	r7,	-128(%r1)
+	cmpwi	r7,  0x7070
+	bne	1f
+	ld	r8,	-136(%r1)
+	cmpwi	r8,  0x0808
+	bne	1f
+	ld	r9,	-144(%r1)
+	cmpwi	r9,  0x0909
+	bne	1f
+	ld	r10, -152(%r1)
+	cmpwi	r10, 0x1010
+	bne	1f
+	ld	r11, -160(%r1)
+	cmpwi	r11, 0x1111
+	bne	1f
+	ld	r14, -168(%r1)
+	cmpwi	r14, 0x1414
+	bne	1f
+	ld	r15, -176(%r1)
+	cmpwi	r15, 0x1515
+	bne	1f
+	ld	r16, -184(%r1)
+	cmpwi	r16, 0x1616
+	bne	1f
+	ld	r17, -192(%r1)
+	cmpwi	r17, 0x1717
+	bne	1f
+	ld	r18, -200(%r1)
+	cmpwi	r18, 0x1818
+	bne	1f
+	ld	r19, -208(%r1)
+	cmpwi	r19, 0x1919
+	bne	1f
+	ld	r20, -216(%r1)
+	cmpwi	r20, 0x2020
+	bne	1f
+	ld	r21, -224(%r1)
+	cmpwi	r21, 0x2121
+	bne	1f
+	ld	r22, -232(%r1)
+	cmpwi	r22, 0x2222
+	bne	1f
+	ld	r23, -240(%r1)
+	cmpwi	r23, 0x2323
+	bne	1f
+	ld	r24, -248(%r1)
+	cmpwi	r24, 0x2424
+	bne	1f
+	ld	r25, -256(%r1)
+	cmpwi	r25, 0x2525
+	bne	1f
+	ld	r26, -264(%r1)
+	cmpwi	r26, 0x2626
+	bne	1f
+	ld	r27, -272(%r1)
+	cmpwi	r27, 0x2727
+	bne	1f
+	ld	r28, -280(%r1)
+	cmpwi	r28, 0x2828
+	bne	1f
+	ld	r29, -288(%r1)
+	cmpwi	r29, 0x2929
+	bne	1f
+
+	/* Load 0 (success) to return */
+	li	r3, 0
+
+1:	ld	r14, 160(%r1)
+	ld	r15, 152(%r1)
+	ld	r16, 144(%r1)
+	ld	r17, 136(%r1)
+	ld	r18, 128(%r1)
+	ld	r19, 120(%r1)
+	ld	r20, 112(%r1)
+	ld	r21, 104(%r1)
+	ld	r22, 96(%r1)
+	ld	r23, 88(%r1)
+	ld	r24, 80(%r1)
+	ld	r25, 72(%r1)
+	ld	r26, 64(%r1)
+	ld	r27, 56(%r1)
+	ld	r28, 48(%r1)
+	ld	r29, 40(%r1)
+	ld	r30, 32(%r1)
+	ld	r31, 24(%r1)
+	addi	%r1, %r1, 168
+	blr
diff --git a/tools/testing/selftests/powerpc/pmu/ebb/ebb.c b/tools/testing/selftests/powerpc/pmu/ebb/ebb.c
index 1b46be94b64c..b7ee607c0fca 100644
--- a/tools/testing/selftests/powerpc/pmu/ebb/ebb.c
+++ b/tools/testing/selftests/powerpc/pmu/ebb/ebb.c
@@ -335,257 +335,6 @@ void event_leader_ebb_init(struct event *e)
 	e->attr.pinned = 1;
 }
 
-int core_busy_loop(void)
-{
-	int rc;
-
-	asm volatile (
-		"li  3,  0x3030\n"
-		"std 3,  -96(1)\n"
-		"li  4,  0x4040\n"
-		"std 4,  -104(1)\n"
-		"li  5,  0x5050\n"
-		"std 5,  -112(1)\n"
-		"li  6,  0x6060\n"
-		"std 6,  -120(1)\n"
-		"li  7,  0x7070\n"
-		"std 7,  -128(1)\n"
-		"li  8,  0x0808\n"
-		"std 8,  -136(1)\n"
-		"li  9,  0x0909\n"
-		"std 9,  -144(1)\n"
-		"li  10, 0x1010\n"
-		"std 10, -152(1)\n"
-		"li  11, 0x1111\n"
-		"std 11, -160(1)\n"
-		"li  14, 0x1414\n"
-		"std 14, -168(1)\n"
-		"li  15, 0x1515\n"
-		"std 15, -176(1)\n"
-		"li  16, 0x1616\n"
-		"std 16, -184(1)\n"
-		"li  17, 0x1717\n"
-		"std 17, -192(1)\n"
-		"li  18, 0x1818\n"
-		"std 18, -200(1)\n"
-		"li  19, 0x1919\n"
-		"std 19, -208(1)\n"
-		"li  20, 0x2020\n"
-		"std 20, -216(1)\n"
-		"li  21, 0x2121\n"
-		"std 21, -224(1)\n"
-		"li  22, 0x2222\n"
-		"std 22, -232(1)\n"
-		"li  23, 0x2323\n"
-		"std 23, -240(1)\n"
-		"li  24, 0x2424\n"
-		"std 24, -248(1)\n"
-		"li  25, 0x2525\n"
-		"std 25, -256(1)\n"
-		"li  26, 0x2626\n"
-		"std 26, -264(1)\n"
-		"li  27, 0x2727\n"
-		"std 27, -272(1)\n"
-		"li  28, 0x2828\n"
-		"std 28, -280(1)\n"
-		"li  29, 0x2929\n"
-		"std 29, -288(1)\n"
-		"li  30, 0x3030\n"
-		"li  31, 0x3131\n"
-
-		"li    3,  0\n"
-		"0: "
-		"addi  3, 3, 1\n"
-		"cmpwi 3, 100\n"
-		"blt   0b\n"
-
-		/* Return 1 (fail) unless we get through all the checks */
-		"li	0, 1\n"
-
-		/* Check none of our registers have been corrupted */
-		"cmpwi  4,  0x4040\n"
-		"bne	1f\n"
-		"cmpwi  5,  0x5050\n"
-		"bne	1f\n"
-		"cmpwi  6,  0x6060\n"
-		"bne	1f\n"
-		"cmpwi  7,  0x7070\n"
-		"bne	1f\n"
-		"cmpwi  8,  0x0808\n"
-		"bne	1f\n"
-		"cmpwi  9,  0x0909\n"
-		"bne	1f\n"
-		"cmpwi  10, 0x1010\n"
-		"bne	1f\n"
-		"cmpwi  11, 0x1111\n"
-		"bne	1f\n"
-		"cmpwi  14, 0x1414\n"
-		"bne	1f\n"
-		"cmpwi  15, 0x1515\n"
-		"bne	1f\n"
-		"cmpwi  16, 0x1616\n"
-		"bne	1f\n"
-		"cmpwi  17, 0x1717\n"
-		"bne	1f\n"
-		"cmpwi  18, 0x1818\n"
-		"bne	1f\n"
-		"cmpwi  19, 0x1919\n"
-		"bne	1f\n"
-		"cmpwi  20, 0x2020\n"
-		"bne	1f\n"
-		"cmpwi  21, 0x2121\n"
-		"bne	1f\n"
-		"cmpwi  22, 0x2222\n"
-		"bne	1f\n"
-		"cmpwi  23, 0x2323\n"
-		"bne	1f\n"
-		"cmpwi  24, 0x2424\n"
-		"bne	1f\n"
-		"cmpwi  25, 0x2525\n"
-		"bne	1f\n"
-		"cmpwi  26, 0x2626\n"
-		"bne	1f\n"
-		"cmpwi  27, 0x2727\n"
-		"bne	1f\n"
-		"cmpwi  28, 0x2828\n"
-		"bne	1f\n"
-		"cmpwi  29, 0x2929\n"
-		"bne	1f\n"
-		"cmpwi  30, 0x3030\n"
-		"bne	1f\n"
-		"cmpwi  31, 0x3131\n"
-		"bne	1f\n"
-
-		/* Load junk into all our registers before we reload them from the stack. */
-		"li  3,  0xde\n"
-		"li  4,  0xad\n"
-		"li  5,  0xbe\n"
-		"li  6,  0xef\n"
-		"li  7,  0xde\n"
-		"li  8,  0xad\n"
-		"li  9,  0xbe\n"
-		"li  10, 0xef\n"
-		"li  11, 0xde\n"
-		"li  14, 0xad\n"
-		"li  15, 0xbe\n"
-		"li  16, 0xef\n"
-		"li  17, 0xde\n"
-		"li  18, 0xad\n"
-		"li  19, 0xbe\n"
-		"li  20, 0xef\n"
-		"li  21, 0xde\n"
-		"li  22, 0xad\n"
-		"li  23, 0xbe\n"
-		"li  24, 0xef\n"
-		"li  25, 0xde\n"
-		"li  26, 0xad\n"
-		"li  27, 0xbe\n"
-		"li  28, 0xef\n"
-		"li  29, 0xdd\n"
-
-		"ld     3,  -96(1)\n"
-		"cmpwi  3,  0x3030\n"
-		"bne	1f\n"
-		"ld     4,  -104(1)\n"
-		"cmpwi  4,  0x4040\n"
-		"bne	1f\n"
-		"ld     5,  -112(1)\n"
-		"cmpwi  5,  0x5050\n"
-		"bne	1f\n"
-		"ld     6,  -120(1)\n"
-		"cmpwi  6,  0x6060\n"
-		"bne	1f\n"
-		"ld     7,  -128(1)\n"
-		"cmpwi  7,  0x7070\n"
-		"bne	1f\n"
-		"ld     8,  -136(1)\n"
-		"cmpwi  8,  0x0808\n"
-		"bne	1f\n"
-		"ld     9,  -144(1)\n"
-		"cmpwi  9,  0x0909\n"
-		"bne	1f\n"
-		"ld     10, -152(1)\n"
-		"cmpwi  10, 0x1010\n"
-		"bne	1f\n"
-		"ld     11, -160(1)\n"
-		"cmpwi  11, 0x1111\n"
-		"bne	1f\n"
-		"ld     14, -168(1)\n"
-		"cmpwi  14, 0x1414\n"
-		"bne	1f\n"
-		"ld     15, -176(1)\n"
-		"cmpwi  15, 0x1515\n"
-		"bne	1f\n"
-		"ld     16, -184(1)\n"
-		"cmpwi  16, 0x1616\n"
-		"bne	1f\n"
-		"ld     17, -192(1)\n"
-		"cmpwi  17, 0x1717\n"
-		"bne	1f\n"
-		"ld     18, -200(1)\n"
-		"cmpwi  18, 0x1818\n"
-		"bne	1f\n"
-		"ld     19, -208(1)\n"
-		"cmpwi  19, 0x1919\n"
-		"bne	1f\n"
-		"ld     20, -216(1)\n"
-		"cmpwi  20, 0x2020\n"
-		"bne	1f\n"
-		"ld     21, -224(1)\n"
-		"cmpwi  21, 0x2121\n"
-		"bne	1f\n"
-		"ld     22, -232(1)\n"
-		"cmpwi  22, 0x2222\n"
-		"bne	1f\n"
-		"ld     23, -240(1)\n"
-		"cmpwi  23, 0x2323\n"
-		"bne	1f\n"
-		"ld     24, -248(1)\n"
-		"cmpwi  24, 0x2424\n"
-		"bne	1f\n"
-		"ld     25, -256(1)\n"
-		"cmpwi  25, 0x2525\n"
-		"bne	1f\n"
-		"ld     26, -264(1)\n"
-		"cmpwi  26, 0x2626\n"
-		"bne	1f\n"
-		"ld     27, -272(1)\n"
-		"cmpwi  27, 0x2727\n"
-		"bne	1f\n"
-		"ld     28, -280(1)\n"
-		"cmpwi  28, 0x2828\n"
-		"bne	1f\n"
-		"ld     29, -288(1)\n"
-		"cmpwi  29, 0x2929\n"
-		"bne	1f\n"
-
-		/* Load 0 (success) to return */
-		"li	0, 0\n"
-
-		"1: 	mr %0, 0\n"
-
-		: "=r" (rc)
-		: /* no inputs */
-		: "3", "4", "5", "6", "7", "8", "9", "10", "11", "14",
-		  "15", "16", "17", "18", "19", "20", "21", "22", "23",
-		   "24", "25", "26", "27", "28", "29", "30", "31",
-		   "memory"
-	);
-
-	return rc;
-}
-
-int core_busy_loop_with_freeze(void)
-{
-	int rc;
-
-	mtspr(SPRN_MMCR0, mfspr(SPRN_MMCR0) & ~MMCR0_FC);
-	rc = core_busy_loop();
-	mtspr(SPRN_MMCR0, mfspr(SPRN_MMCR0) |  MMCR0_FC);
-
-	return rc;
-}
-
 int ebb_child(union pipe read_pipe, union pipe write_pipe)
 {
 	struct event event;
diff --git a/tools/testing/selftests/powerpc/pmu/ebb/ebb.h b/tools/testing/selftests/powerpc/pmu/ebb/ebb.h
index e62bde05bf78..e44eee5d97ca 100644
--- a/tools/testing/selftests/powerpc/pmu/ebb/ebb.h
+++ b/tools/testing/selftests/powerpc/pmu/ebb/ebb.h
@@ -70,7 +70,6 @@ int ebb_check_mmcr0(void);
 extern u64 sample_period;
 
 int core_busy_loop(void);
-int core_busy_loop_with_freeze(void);
 int ebb_child(union pipe read_pipe, union pipe write_pipe);
 int catch_sigill(void (*func)(void));
 void write_pmc1(void);
-- 
1.9.1

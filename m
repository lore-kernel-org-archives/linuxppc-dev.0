Return-Path: <kamalesh@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xxwjv5p14zDqR8
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 Sep 2017 20:20:35 +1000 (AEST)
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 v8KAJlI2058869
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 Sep 2017 06:20:32 -0400
Received: from e23smtp08.au.ibm.com (e23smtp08.au.ibm.com [202.81.31.141])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2d3nqqk4h3-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 Sep 2017 06:20:31 -0400
Received: from localhost
 by e23smtp08.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <kamalesh@linux.vnet.ibm.com>;
 Wed, 20 Sep 2017 20:20:12 +1000
Received: from d23av06.au.ibm.com (d23av06.au.ibm.com [9.190.235.151])
 by d23relay08.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v8KAKA3Q42074224
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 Sep 2017 20:20:10 +1000
Received: from d23av06.au.ibm.com (localhost [127.0.0.1])
 by d23av06.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v8KAK9Nc013397
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 Sep 2017 20:20:09 +1000
From: Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>,
 Balbir Singh <bsingharora@gmail.com>,
 "Naveen N . Rao" <naveen.n.rao@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org
Subject: [PATCH] powerpc/livepatch: Fix livepatch stack access
Date: Wed, 20 Sep 2017 15:49:51 +0530
Message-Id: <1505902791-26383-1-git-send-email-kamalesh@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

While running stress test with livepatch module loaded, kernel
bug was triggered.

cpu 0x5: Vector: 400 (Instruction Access) at [c0000000eb9d3b60]
    pc: c0000000eb9d3e30
    lr: c0000000eb9d3e30
    sp: c0000000eb9d3de0
   msr: 800000001280b033
  current = 0xc0000000dbd38700
  paca    = 0xc00000000fe01400   softe: 0        irq_happened: 0x01
    pid   = 8618, comm = make
Linux version 4.13.0+ (root@ubuntu) (gcc version 6.3.0 20170406 (Ubuntu 6.3.0-12ubuntu2)) #1 SMP Wed Sep 13 03:49:27 EDT 2017

5:mon> t
[c0000000eb9d3de0] c0000000eb9d3e30 (unreliable)
[c0000000eb9d3e30] c000000000008ab4 hardware_interrupt_common+0x114/0x120
 --- Exception: 501 (Hardware Interrupt) at c000000000053040 livepatch_handler+0x4c/0x74
[c0000000eb9d4120] 0000000057ac6e9d (unreliable)
[d0000000089d9f78] 2e0965747962382e
SP (965747962342e09) is in userspace

When an interrupt is served in between the livepatch_handler execution,
there are chances of the livepatch_stack/task task getting corrupted.

                    CPU 1
                 =============
Task A                          Interrupt Handler
=========                       =================
livepatch_handler:
 mr r0, r1
 ld r1, TI_livepatch_sp(r12)
                                hardware_interrupt_common
                                |_do_IRQ
                                  |_ call_do_irq:
                                        mflr r0
                                        std  r0,16(r1)
                                        stdu r1,THREAD_SIZE-STACK_FRAME_OVERHEAD(r4)
                                            ...
lis r2, STACK_END_MAGIC@h
ori r2, r2, STACK_END_MAGIC@l
ld  r12, -8(r1)      <- livepatch stack is corrupted.

Fix the corruption by using r11 register for livepatch stack manipulation,
instead of shuffling task stack and livepatch stack into r1 register.
Using r11 register also avoids disabling/enabling irq's while setting
up the livepatch stack.

Signed-off-by: Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>
Cc: Balbir Singh <bsingharora@gmail.com>
Cc: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org
---
 arch/powerpc/kernel/trace/ftrace_64_mprofile.S | 45 +++++++++-----------------
 1 file changed, 15 insertions(+), 30 deletions(-)

diff --git a/arch/powerpc/kernel/trace/ftrace_64_mprofile.S b/arch/powerpc/kernel/trace/ftrace_64_mprofile.S
index c98e90b..b4e2b71 100644
--- a/arch/powerpc/kernel/trace/ftrace_64_mprofile.S
+++ b/arch/powerpc/kernel/trace/ftrace_64_mprofile.S
@@ -181,34 +181,25 @@ _GLOBAL(ftrace_stub)
 	 *  - we have no stack frame and can not allocate one
 	 *  - LR points back to the original caller (in A)
 	 *  - CTR holds the new NIP in C
-	 *  - r0 & r12 are free
-	 *
-	 * r0 can't be used as the base register for a DS-form load or store, so
-	 * we temporarily shuffle r1 (stack pointer) into r0 and then put it back.
+	 *  - r0, r11 & r12 are free
 	 */
 livepatch_handler:
 	CURRENT_THREAD_INFO(r12, r1)

-	/* Save stack pointer into r0 */
-	mr	r0, r1
-
 	/* Allocate 3 x 8 bytes */
-	ld	r1, TI_livepatch_sp(r12)
-	addi	r1, r1, 24
-	std	r1, TI_livepatch_sp(r12)
+	ld	r11, TI_livepatch_sp(r12)
+	addi	r11, r11, 24
+	std	r11, TI_livepatch_sp(r12)

 	/* Save toc & real LR on livepatch stack */
-	std	r2,  -24(r1)
+	std	r2,  -24(r11)
 	mflr	r12
-	std	r12, -16(r1)
+	std	r12, -16(r11)

 	/* Store stack end marker */
 	lis     r12, STACK_END_MAGIC@h
 	ori     r12, r12, STACK_END_MAGIC@l
-	std	r12, -8(r1)
-
-	/* Restore real stack pointer */
-	mr	r1, r0
+	std	r12, -8(r11)

 	/* Put ctr in r12 for global entry and branch there */
 	mfctr	r12
@@ -216,36 +207,30 @@ livepatch_handler:

 	/*
 	 * Now we are returning from the patched function to the original
-	 * caller A. We are free to use r0 and r12, and we can use r2 until we
+	 * caller A. We are free to use r11, r12 and we can use r2 until we
 	 * restore it.
 	 */

 	CURRENT_THREAD_INFO(r12, r1)

-	/* Save stack pointer into r0 */
-	mr	r0, r1
-
-	ld	r1, TI_livepatch_sp(r12)
+	ld	r11, TI_livepatch_sp(r12)

 	/* Check stack marker hasn't been trashed */
 	lis     r2,  STACK_END_MAGIC@h
 	ori     r2,  r2, STACK_END_MAGIC@l
-	ld	r12, -8(r1)
+	ld	r12, -8(r11)
 1:	tdne	r12, r2
 	EMIT_BUG_ENTRY 1b, __FILE__, __LINE__ - 1, 0

 	/* Restore LR & toc from livepatch stack */
-	ld	r12, -16(r1)
+	ld	r12, -16(r11)
 	mtlr	r12
-	ld	r2,  -24(r1)
+	ld	r2,  -24(r11)

 	/* Pop livepatch stack frame */
-	CURRENT_THREAD_INFO(r12, r0)
-	subi	r1, r1, 24
-	std	r1, TI_livepatch_sp(r12)
-
-	/* Restore real stack pointer */
-	mr	r1, r0
+	CURRENT_THREAD_INFO(r12, r1)
+	subi	r11, r11, 24
+	std	r11, TI_livepatch_sp(r12)

 	/* Return to original caller of live patched function */
 	blr
--
2.7.4

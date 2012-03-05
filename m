Return-Path: <benh@kernel.crashing.org>
Received: from e23smtp01.au.ibm.com (e23smtp01.au.ibm.com [202.81.31.143])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e23smtp01.au.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id EA27EB6FE9
 for <linuxppc-dev@ozlabs.org>; Mon,  5 Mar 2012 13:53:14 +1100 (EST)
Received: from /spool/local
 by e23smtp01.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <benh@kernel.crashing.org>;
 Mon, 5 Mar 2012 02:46:40 +1000
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay03.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 q252qSL11118322
 for <linuxppc-dev@ozlabs.org>; Mon, 5 Mar 2012 13:52:33 +1100
Received: from d23av04.au.ibm.com (loopback [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 q252qRrq013356
 for <linuxppc-dev@ozlabs.org>; Mon, 5 Mar 2012 13:52:28 +1100
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 11/13] powerpc: Fix 64-bit BookE FP unavailable exceptions
Date: Mon,  5 Mar 2012 13:51:29 +1100
Message-Id: <1330915891-19523-12-git-send-email-benh@kernel.crashing.org>
In-Reply-To: <1330915891-19523-1-git-send-email-benh@kernel.crashing.org>
References: <1330915891-19523-1-git-send-email-benh@kernel.crashing.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

We were using CR0.EQ after EXCEPTION_COMMON, hoping it still
contained whether we came from userspace or kernel space.

However, under some circumstances, EXCEPTION_COMMON will
call C code and clobber non-volatile registers, so we really
need to re-load the previous MSR from the stackframe and
re-test.

While there, invert the condition to make the fast path more
obvious and remove the BUG_OPCODE which was a debugging
leftover and call .ret_from_except as we should.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---
 arch/powerpc/kernel/exceptions-64e.S |   13 +++++++------
 1 files changed, 7 insertions(+), 6 deletions(-)

diff --git a/arch/powerpc/kernel/exceptions-64e.S b/arch/powerpc/kernel/exceptions-64e.S
index 3de9993..c4c3466 100644
--- a/arch/powerpc/kernel/exceptions-64e.S
+++ b/arch/powerpc/kernel/exceptions-64e.S
@@ -353,15 +353,16 @@ interrupt_end_book3e:
 	NORMAL_EXCEPTION_PROLOG(0x800, PROLOG_ADDITION_NONE)
 	/* we can probably do a shorter exception entry for that one... */
 	EXCEPTION_COMMON(0x800, PACA_EXGEN, INTS_KEEP)
-	bne	1f			/* if from user, just load it up */
-	INTS_DISABLE_ALL
+	ld	r12,_MSR(r1)
+	andi.	r0,r12,MSR_PR;
+	beq-	1f
+	bl	.load_up_fpu
+	b	fast_exception_return
+1:	INTS_DISABLE_ALL
 	bl	.save_nvgprs
 	addi	r3,r1,STACK_FRAME_OVERHEAD
 	bl	.kernel_fp_unavailable_exception
-	BUG_OPCODE
-1:	ld	r12,_MSR(r1)
-	bl	.load_up_fpu
-	b	fast_exception_return
+	b	.ret_from_except
 
 /* Decrementer Interrupt */
 	MASKABLE_EXCEPTION(0x900, decrementer, .timer_interrupt, ACK_DEC)
-- 
1.7.9

Return-Path: <benh@kernel.crashing.org>
Received: from e23smtp01.au.ibm.com (e23smtp01.au.ibm.com [202.81.31.143])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e23smtp01.au.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id CD1BFB6EF1
 for <linuxppc-dev@ozlabs.org>; Mon,  5 Mar 2012 13:52:40 +1100 (EST)
Received: from /spool/local
 by e23smtp01.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <benh@kernel.crashing.org>;
 Mon, 5 Mar 2012 02:45:58 +1000
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay04.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 q252kqpa2928778
 for <linuxppc-dev@ozlabs.org>; Mon, 5 Mar 2012 13:46:54 +1100
Received: from d23av01.au.ibm.com (loopback [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 q252qQn7015874
 for <linuxppc-dev@ozlabs.org>; Mon, 5 Mar 2012 13:52:26 +1100
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 06/13] powerpc: Disable interrupts in 64-bit kernel FP and
 vector faults
Date: Mon,  5 Mar 2012 13:51:24 +1100
Message-Id: <1330915891-19523-7-git-send-email-benh@kernel.crashing.org>
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

If we get a floating point, altivec or vsx unavaible interrupt in
kernel, we trigger a kernel error. There is no point preserving
the interrupt state, in fact, that can even make debugging harder
as the processor state might change (we may even preempt) between
taking the exception and landing in a debugger.

So just make those 3 disable interrupts unconditionally.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---

v2: On BookE only disable when hitting the kernel unavailable
    path, otherwise it will fail to restore softe as
    fast_exception_return doesn't do it.
---
 arch/powerpc/kernel/exceptions-64e.S |    7 +++----
 arch/powerpc/kernel/exceptions-64s.S |    6 +++---
 arch/powerpc/kernel/traps.c          |    3 +++
 3 files changed, 9 insertions(+), 7 deletions(-)

diff --git a/arch/powerpc/kernel/exceptions-64e.S b/arch/powerpc/kernel/exceptions-64e.S
index 429983c..7098302 100644
--- a/arch/powerpc/kernel/exceptions-64e.S
+++ b/arch/powerpc/kernel/exceptions-64e.S
@@ -354,9 +354,9 @@ interrupt_end_book3e:
 	/* we can probably do a shorter exception entry for that one... */
 	EXCEPTION_COMMON(0x800, PACA_EXGEN, INTS_KEEP)
 	bne	1f			/* if from user, just load it up */
+	INTS_DISABLE_ALL
 	bl	.save_nvgprs
 	addi	r3,r1,STACK_FRAME_OVERHEAD
-	INTS_RESTORE_HARD
 	bl	.kernel_fp_unavailable_exception
 	BUG_OPCODE
 1:	ld	r12,_MSR(r1)
@@ -391,10 +391,9 @@ interrupt_end_book3e:
 /* Auxiliary Processor Unavailable Interrupt */
 	START_EXCEPTION(ap_unavailable);
 	NORMAL_EXCEPTION_PROLOG(0xf20, PROLOG_ADDITION_NONE)
-	EXCEPTION_COMMON(0xf20, PACA_EXGEN, INTS_KEEP)
-	addi	r3,r1,STACK_FRAME_OVERHEAD
+	EXCEPTION_COMMON(0xf20, PACA_EXGEN, INTS_DISABLE_ALL)
 	bl	.save_nvgprs
-	INTS_RESTORE_HARD
+	addi	r3,r1,STACK_FRAME_OVERHEAD
 	bl	.unknown_exception
 	b	.ret_from_except
 
diff --git a/arch/powerpc/kernel/exceptions-64s.S b/arch/powerpc/kernel/exceptions-64s.S
index 3af80e8..bd30fc2 100644
--- a/arch/powerpc/kernel/exceptions-64s.S
+++ b/arch/powerpc/kernel/exceptions-64s.S
@@ -757,8 +757,8 @@ fp_unavailable_common:
 	EXCEPTION_PROLOG_COMMON(0x800, PACA_EXGEN)
 	bne	1f			/* if from user, just load it up */
 	bl	.save_nvgprs
+	DISABLE_INTS
 	addi	r3,r1,STACK_FRAME_OVERHEAD
-	ENABLE_INTS
 	bl	.kernel_fp_unavailable_exception
 	BUG_OPCODE
 1:	bl	.load_up_fpu
@@ -777,8 +777,8 @@ BEGIN_FTR_SECTION
 END_FTR_SECTION_IFSET(CPU_FTR_ALTIVEC)
 #endif
 	bl	.save_nvgprs
+	DISABLE_INTS
 	addi	r3,r1,STACK_FRAME_OVERHEAD
-	ENABLE_INTS
 	bl	.altivec_unavailable_exception
 	b	.ret_from_except
 
@@ -793,8 +793,8 @@ BEGIN_FTR_SECTION
 END_FTR_SECTION_IFSET(CPU_FTR_VSX)
 #endif
 	bl	.save_nvgprs
+	DISABLE_INTS
 	addi	r3,r1,STACK_FRAME_OVERHEAD
-	ENABLE_INTS
 	bl	.vsx_unavailable_exception
 	b	.ret_from_except
 
diff --git a/arch/powerpc/kernel/traps.c b/arch/powerpc/kernel/traps.c
index 5d40e59..a750409 100644
--- a/arch/powerpc/kernel/traps.c
+++ b/arch/powerpc/kernel/traps.c
@@ -247,6 +247,9 @@ void _exception(int signr, struct pt_regs *regs, int code, unsigned long addr)
 				   addr, regs->nip, regs->link, code);
 	}
 
+	if (!arch_irq_disabled_regs(regs))
+		local_irq_enable();
+
 	memset(&info, 0, sizeof(info));
 	info.si_signo = signr;
 	info.si_code = code;
-- 
1.7.9

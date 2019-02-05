Return-Path: <SRS0=EZew=QM=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2AC7C282CB
	for <linuxppc-dev@archiver.kernel.org>; Tue,  5 Feb 2019 12:15:37 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4C53120821
	for <linuxppc-dev@archiver.kernel.org>; Tue,  5 Feb 2019 12:15:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4C53120821
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43v3SR2SdFzDqM4
	for <linuxppc-dev@archiver.kernel.org>; Tue,  5 Feb 2019 23:15:35 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43v2WD3NM0zDq5v
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  5 Feb 2019 22:32:56 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Received: by ozlabs.org (Postfix)
 id 43v2WD2D0Jz9sMx; Tue,  5 Feb 2019 22:32:56 +1100 (AEDT)
Received: by ozlabs.org (Postfix, from userid 1034)
 id 43v2WD11qNz9sNG; Tue,  5 Feb 2019 22:32:56 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH v16 20/21] powerpc/64: Replace CURRENT_THREAD_INFO with
 PACA_CURRENT_TI
Date: Tue,  5 Feb 2019 22:32:18 +1100
Message-Id: <20190205113219.17903-21-mpe@ellerman.id.au>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190205113219.17903-1-mpe@ellerman.id.au>
References: <20190205113219.17903-1-mpe@ellerman.id.au>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Cc: npiggin@gmail.com
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

From: Christophe Leroy <christophe.leroy@c-s.fr>

Now that current_thread_info is located at the beginning of 'current'
task struct, CURRENT_THREAD_INFO macro is not really needed any more.

This patch replaces it by loads of the value at PACA_CURRENT_TI(r13).

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
[mpe: Add PACA_CURRENT_TI rather than using PACACURRENT]
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/include/asm/exception-64s.h       |  4 ++--
 arch/powerpc/include/asm/thread_info.h         |  4 ----
 arch/powerpc/kernel/asm-offsets.c              |  2 ++
 arch/powerpc/kernel/entry_64.S                 | 10 +++++-----
 arch/powerpc/kernel/exceptions-64e.S           |  2 +-
 arch/powerpc/kernel/exceptions-64s.S           |  2 +-
 arch/powerpc/kernel/idle_book3e.S              |  2 +-
 arch/powerpc/kernel/idle_power4.S              |  2 +-
 arch/powerpc/kernel/trace/ftrace_64_mprofile.S |  6 +++---
 9 files changed, 16 insertions(+), 18 deletions(-)

diff --git a/arch/powerpc/include/asm/exception-64s.h b/arch/powerpc/include/asm/exception-64s.h
index 3b4767ed3ec5..f0f0ff192e87 100644
--- a/arch/powerpc/include/asm/exception-64s.h
+++ b/arch/powerpc/include/asm/exception-64s.h
@@ -671,7 +671,7 @@ END_FTR_SECTION_NESTED(ftr,ftr,943)
 
 #define RUNLATCH_ON				\
 BEGIN_FTR_SECTION				\
-	CURRENT_THREAD_INFO(r3, r1);		\
+	ld	r3, PACA_CURRENT_TI(r13);	\
 	ld	r4,TI_LOCAL_FLAGS(r3);		\
 	andi.	r0,r4,_TLF_RUNLATCH;		\
 	beql	ppc64_runlatch_on_trampoline;	\
@@ -721,7 +721,7 @@ END_FTR_SECTION_IFSET(CPU_FTR_CTRL)
 #ifdef CONFIG_PPC_970_NAP
 #define FINISH_NAP				\
 BEGIN_FTR_SECTION				\
-	CURRENT_THREAD_INFO(r11, r1);		\
+	ld	r11, PACA_CURRENT_TI(r13);	\
 	ld	r9,TI_LOCAL_FLAGS(r11);		\
 	andi.	r10,r9,_TLF_NAPPING;		\
 	bnel	power4_fixup_nap;		\
diff --git a/arch/powerpc/include/asm/thread_info.h b/arch/powerpc/include/asm/thread_info.h
index c959b8d66cac..8e1d0195ac36 100644
--- a/arch/powerpc/include/asm/thread_info.h
+++ b/arch/powerpc/include/asm/thread_info.h
@@ -17,10 +17,6 @@
 
 #define THREAD_SIZE		(1 << THREAD_SHIFT)
 
-#ifdef CONFIG_PPC64
-#define CURRENT_THREAD_INFO(dest, sp)	stringify_in_c(ld dest, PACACURRENT(r13))
-#endif
-
 #ifndef __ASSEMBLY__
 #include <linux/cache.h>
 #include <asm/processor.h>
diff --git a/arch/powerpc/kernel/asm-offsets.c b/arch/powerpc/kernel/asm-offsets.c
index 03439785c2ea..7a1b93c5af63 100644
--- a/arch/powerpc/kernel/asm-offsets.c
+++ b/arch/powerpc/kernel/asm-offsets.c
@@ -179,6 +179,8 @@ int main(void)
 	OFFSET(PACAPROCSTART, paca_struct, cpu_start);
 	OFFSET(PACAKSAVE, paca_struct, kstack);
 	OFFSET(PACACURRENT, paca_struct, __current);
+	DEFINE(PACA_CURRENT_TI, offsetof(struct paca_struct, __current) +
+				offsetof(struct task_struct, thread_info));
 	OFFSET(PACASAVEDMSR, paca_struct, saved_msr);
 	OFFSET(PACAR1, paca_struct, saved_r1);
 	OFFSET(PACATOC, paca_struct, kernel_toc);
diff --git a/arch/powerpc/kernel/entry_64.S b/arch/powerpc/kernel/entry_64.S
index 21f1cb4d464e..259fcc82ec75 100644
--- a/arch/powerpc/kernel/entry_64.S
+++ b/arch/powerpc/kernel/entry_64.S
@@ -166,7 +166,7 @@ system_call:			/* label this so stack traces look sane */
 	li	r10,IRQS_ENABLED
 	std	r10,SOFTE(r1)
 
-	CURRENT_THREAD_INFO(r11, r1)
+	ld	r11, PACA_CURRENT_TI(r13)
 	ld	r10,TI_FLAGS(r11)
 	andi.	r11,r10,_TIF_SYSCALL_DOTRACE
 	bne	.Lsyscall_dotrace		/* does not return */
@@ -213,7 +213,7 @@ system_call:			/* label this so stack traces look sane */
 	ld	r3,RESULT(r1)
 #endif
 
-	CURRENT_THREAD_INFO(r12, r1)
+	ld	r12, PACA_CURRENT_TI(r13)
 
 	ld	r8,_MSR(r1)
 #ifdef CONFIG_PPC_BOOK3S
@@ -346,7 +346,7 @@ END_FTR_SECTION_IFSET(CPU_FTR_HAS_PPR)
 
 	/* Repopulate r9 and r10 for the syscall path */
 	addi	r9,r1,STACK_FRAME_OVERHEAD
-	CURRENT_THREAD_INFO(r10, r1)
+	ld	r10, PACA_CURRENT_TI(r13)
 	ld	r10,TI_FLAGS(r10)
 
 	cmpldi	r0,NR_syscalls
@@ -740,7 +740,7 @@ _GLOBAL(ret_from_except_lite)
 	mtmsrd	r10,1		  /* Update machine state */
 #endif /* CONFIG_PPC_BOOK3E */
 
-	CURRENT_THREAD_INFO(r9, r1)
+	ld	r9, PACA_CURRENT_TI(r13)
 	ld	r3,_MSR(r1)
 #ifdef CONFIG_PPC_BOOK3E
 	ld	r10,PACACURRENT(r13)
@@ -854,7 +854,7 @@ _GLOBAL(ret_from_except_lite)
 1:	bl	preempt_schedule_irq
 
 	/* Re-test flags and eventually loop */
-	CURRENT_THREAD_INFO(r9, r1)
+	ld	r9, PACA_CURRENT_TI(r13)
 	ld	r4,TI_FLAGS(r9)
 	andi.	r0,r4,_TIF_NEED_RESCHED
 	bne	1b
diff --git a/arch/powerpc/kernel/exceptions-64e.S b/arch/powerpc/kernel/exceptions-64e.S
index 20f14996281d..92d5ded2b290 100644
--- a/arch/powerpc/kernel/exceptions-64e.S
+++ b/arch/powerpc/kernel/exceptions-64e.S
@@ -493,7 +493,7 @@ exc_##n##_bad_stack:							    \
  * interrupts happen before the wait instruction.
  */
 #define CHECK_NAPPING()							\
-	CURRENT_THREAD_INFO(r11, r1);					\
+	ld	r11, PACA_CURRENT_TI(r13);				\
 	ld	r10,TI_LOCAL_FLAGS(r11);				\
 	andi.	r9,r10,_TLF_NAPPING;					\
 	beq+	1f;							\
diff --git a/arch/powerpc/kernel/exceptions-64s.S b/arch/powerpc/kernel/exceptions-64s.S
index 9e253ce27e08..83be18d478b8 100644
--- a/arch/powerpc/kernel/exceptions-64s.S
+++ b/arch/powerpc/kernel/exceptions-64s.S
@@ -1629,7 +1629,7 @@ USE_TEXT_SECTION()
 	ori	r0,r0,DSISR_BAD_FAULT_64S@l
 	and.	r0,r4,r0		/* weird error? */
 	bne-	handle_page_fault	/* if not, try to insert a HPTE */
-	CURRENT_THREAD_INFO(r11, r1)
+	ld	r11, PACA_CURRENT_TI(r13)
 	lwz	r0,TI_PREEMPT(r11)	/* If we're in an "NMI" */
 	andis.	r0,r0,NMI_MASK@h	/* (i.e. an irq when soft-disabled) */
 	bne	77f			/* then don't call hash_page now */
diff --git a/arch/powerpc/kernel/idle_book3e.S b/arch/powerpc/kernel/idle_book3e.S
index 4e0d94d02030..31e732c378ad 100644
--- a/arch/powerpc/kernel/idle_book3e.S
+++ b/arch/powerpc/kernel/idle_book3e.S
@@ -63,7 +63,7 @@ _GLOBAL(\name)
 1:	/* Let's set the _TLF_NAPPING flag so interrupts make us return
 	 * to the right spot
 	*/
-	CURRENT_THREAD_INFO(r11, r1)
+	ld	r11, PACACURRENT(r13)
 	ld	r10,TI_LOCAL_FLAGS(r11)
 	ori	r10,r10,_TLF_NAPPING
 	std	r10,TI_LOCAL_FLAGS(r11)
diff --git a/arch/powerpc/kernel/idle_power4.S b/arch/powerpc/kernel/idle_power4.S
index a09b3c7ca176..b4c849f9f0e2 100644
--- a/arch/powerpc/kernel/idle_power4.S
+++ b/arch/powerpc/kernel/idle_power4.S
@@ -68,7 +68,7 @@ BEGIN_FTR_SECTION
 	DSSALL
 	sync
 END_FTR_SECTION_IFSET(CPU_FTR_ALTIVEC)
-	CURRENT_THREAD_INFO(r9, r1)
+	ld	r9, PACA_CURRENT_TI(r13)
 	ld	r8,TI_LOCAL_FLAGS(r9)	/* set napping bit */
 	ori	r8,r8,_TLF_NAPPING	/* so when we take an exception */
 	std	r8,TI_LOCAL_FLAGS(r9)	/* it will return to our caller */
diff --git a/arch/powerpc/kernel/trace/ftrace_64_mprofile.S b/arch/powerpc/kernel/trace/ftrace_64_mprofile.S
index 32476a6e4e9c..17ec02cb2f58 100644
--- a/arch/powerpc/kernel/trace/ftrace_64_mprofile.S
+++ b/arch/powerpc/kernel/trace/ftrace_64_mprofile.S
@@ -229,7 +229,7 @@ _GLOBAL(ftrace_caller)
 	 *  - r0, r11 & r12 are free
 	 */
 livepatch_handler:
-	CURRENT_THREAD_INFO(r12, r1)
+	ld	r12, PACA_CURRENT_TI(r13)
 
 	/* Allocate 3 x 8 bytes */
 	ld	r11, TI_livepatch_sp(r12)
@@ -256,7 +256,7 @@ _GLOBAL(ftrace_caller)
 	 * restore it.
 	 */
 
-	CURRENT_THREAD_INFO(r12, r1)
+	ld	r12, PACA_CURRENT_TI(r13)
 
 	ld	r11, TI_livepatch_sp(r12)
 
@@ -273,7 +273,7 @@ _GLOBAL(ftrace_caller)
 	ld	r2,  -24(r11)
 
 	/* Pop livepatch stack frame */
-	CURRENT_THREAD_INFO(r12, r1)
+	ld	r12, PACA_CURRENT_TI(r13)
 	subi	r11, r11, 24
 	std	r11, TI_livepatch_sp(r12)
 
-- 
2.20.1


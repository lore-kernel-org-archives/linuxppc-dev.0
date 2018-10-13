Return-Path: <SRS0=nAH3=MZ=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44969C28CF8
	for <linuxppc-dev@archiver.kernel.org>; Sat, 13 Oct 2018 11:02:36 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9D8B9206B2
	for <linuxppc-dev@archiver.kernel.org>; Sat, 13 Oct 2018 11:02:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9D8B9206B2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42XMHF3ZhWzF1QD
	for <linuxppc-dev@archiver.kernel.org>; Sat, 13 Oct 2018 22:02:33 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42XM8z4GLpzF368
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 13 Oct 2018 21:57:07 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Received: by ozlabs.org (Postfix)
 id 42XM8z3RYtz9s89; Sat, 13 Oct 2018 21:57:07 +1100 (AEDT)
Received: by ozlabs.org (Postfix, from userid 1034)
 id 42XM8z312Cz9s9h; Sat, 13 Oct 2018 21:57:07 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 3/3] powerpc/64: Interrupts save PPR on stack rather than
 thread_struct
Date: Sat, 13 Oct 2018 21:56:46 +1100
Message-Id: <20181013105646.5147-3-mpe@ellerman.id.au>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181013105646.5147-1-mpe@ellerman.id.au>
References: <20181013105646.5147-1-mpe@ellerman.id.au>
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

From: Nicholas Piggin <npiggin@gmail.com>

PPR is the odd register out when it comes to interrupt handling, it is
saved in current->thread.ppr while all others are saved on the stack.

The difficulty with this is that accessing thread.ppr can cause a SLB
fault, but the SLB fault handler implementation in C change had
assumed the normal exception entry handlers would not cause an SLB
fault.

Fix this by allocating room in the interrupt stack to save PPR.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/include/asm/exception-64s.h |  9 ++++-----
 arch/powerpc/include/asm/processor.h     |  6 ++----
 arch/powerpc/include/asm/ptrace.h        |  4 ++++
 arch/powerpc/kernel/asm-offsets.c        |  2 +-
 arch/powerpc/kernel/entry_64.S           | 15 +++++----------
 arch/powerpc/kernel/process.c            |  2 +-
 arch/powerpc/kernel/ptrace.c             |  4 ++--
 7 files changed, 19 insertions(+), 23 deletions(-)

diff --git a/arch/powerpc/include/asm/exception-64s.h b/arch/powerpc/include/asm/exception-64s.h
index a86feddddad0..403d73898a9a 100644
--- a/arch/powerpc/include/asm/exception-64s.h
+++ b/arch/powerpc/include/asm/exception-64s.h
@@ -236,11 +236,10 @@
  * PPR save/restore macros used in exceptions_64s.S  
  * Used for P7 or later processors
  */
-#define SAVE_PPR(area, ra, rb)						\
+#define SAVE_PPR(area, ra)						\
 BEGIN_FTR_SECTION_NESTED(940)						\
-	ld	ra,PACACURRENT(r13);					\
-	ld	rb,area+EX_PPR(r13);	/* Read PPR from paca */	\
-	std	rb,TASKTHREADPPR(ra);					\
+	ld	ra,area+EX_PPR(r13);	/* Read PPR from paca */	\
+	std	ra,_PPR(r1);						\
 END_FTR_SECTION_NESTED(CPU_FTR_HAS_PPR,CPU_FTR_HAS_PPR,940)
 
 #define RESTORE_PPR_PACA(area, ra)					\
@@ -508,7 +507,7 @@ END_FTR_SECTION_NESTED(ftr,ftr,943)
 3:	EXCEPTION_PROLOG_COMMON_1();					   \
 	beq	4f;			/* if from kernel mode		*/ \
 	ACCOUNT_CPU_USER_ENTRY(r13, r9, r10);				   \
-	SAVE_PPR(area, r9, r10);					   \
+	SAVE_PPR(area, r9);						   \
 4:	EXCEPTION_PROLOG_COMMON_2(area)					   \
 	EXCEPTION_PROLOG_COMMON_3(n)					   \
 	ACCOUNT_STOLEN_TIME
diff --git a/arch/powerpc/include/asm/processor.h b/arch/powerpc/include/asm/processor.h
index 52fadded5c1e..3fefb8a65b17 100644
--- a/arch/powerpc/include/asm/processor.h
+++ b/arch/powerpc/include/asm/processor.h
@@ -32,9 +32,9 @@
 /* Default SMT priority is set to 3. Use 11- 13bits to save priority. */
 #define PPR_PRIORITY 3
 #ifdef __ASSEMBLY__
-#define INIT_PPR (PPR_PRIORITY << 50)
+#define DEFAULT_PPR (PPR_PRIORITY << 50)
 #else
-#define INIT_PPR ((u64)PPR_PRIORITY << 50)
+#define DEFAULT_PPR ((u64)PPR_PRIORITY << 50)
 #endif /* __ASSEMBLY__ */
 #endif /* CONFIG_PPC64 */
 
@@ -341,7 +341,6 @@ struct thread_struct {
 	 * onwards.
 	 */
 	int		dscr_inherit;
-	unsigned long	ppr;	/* used to save/restore SMT priority */
 	unsigned long	tidr;
 #endif
 #ifdef CONFIG_PPC_BOOK3S_64
@@ -389,7 +388,6 @@ struct thread_struct {
 	.regs = (struct pt_regs *)INIT_SP - 1, /* XXX bogus, I think */ \
 	.addr_limit = KERNEL_DS, \
 	.fpexc_mode = 0, \
-	.ppr = INIT_PPR, \
 	.fscr = FSCR_TAR | FSCR_EBB \
 }
 #endif
diff --git a/arch/powerpc/include/asm/ptrace.h b/arch/powerpc/include/asm/ptrace.h
index 3dd15024db93..2ba2a1e52291 100644
--- a/arch/powerpc/include/asm/ptrace.h
+++ b/arch/powerpc/include/asm/ptrace.h
@@ -51,6 +51,10 @@ struct pt_regs
 			unsigned long result;
 		};
 	};
+
+#ifdef CONFIG_PPC64
+	unsigned long ppr;
+#endif
 };
 #endif
 
diff --git a/arch/powerpc/kernel/asm-offsets.c b/arch/powerpc/kernel/asm-offsets.c
index 2eb4923f8468..92156c61d21c 100644
--- a/arch/powerpc/kernel/asm-offsets.c
+++ b/arch/powerpc/kernel/asm-offsets.c
@@ -89,7 +89,6 @@ int main(void)
 #ifdef CONFIG_PPC64
 	DEFINE(SIGSEGV, SIGSEGV);
 	DEFINE(NMI_MASK, NMI_MASK);
-	OFFSET(TASKTHREADPPR, task_struct, thread.ppr);
 #else
 	OFFSET(THREAD_INFO, task_struct, stack);
 	DEFINE(THREAD_INFO_GAP, _ALIGN_UP(sizeof(struct thread_info), 16));
@@ -323,6 +322,7 @@ int main(void)
 	STACK_PT_REGS_OFFSET(_ESR, dsisr);
 #else /* CONFIG_PPC64 */
 	STACK_PT_REGS_OFFSET(SOFTE, softe);
+	STACK_PT_REGS_OFFSET(_PPR, ppr);
 #endif /* CONFIG_PPC64 */
 
 #if defined(CONFIG_PPC32)
diff --git a/arch/powerpc/kernel/entry_64.S b/arch/powerpc/kernel/entry_64.S
index 7db00ee6be48..7b1693adff2a 100644
--- a/arch/powerpc/kernel/entry_64.S
+++ b/arch/powerpc/kernel/entry_64.S
@@ -386,10 +386,9 @@ END_FTR_SECTION_IFSET(CPU_FTR_HAS_PPR)
 
 4:	/* Anything else left to do? */
 BEGIN_FTR_SECTION
-	lis	r3,INIT_PPR@highest	/* Set thread.ppr = 3 */
-	ld	r10,PACACURRENT(r13)
+	lis	r3,DEFAULT_PPR@highest	/* Set default PPR */
 	sldi	r3,r3,32	/* bits 11-13 are used for ppr */
-	std	r3,TASKTHREADPPR(r10)
+	std	r3,_PPR(r1)
 END_FTR_SECTION_IFSET(CPU_FTR_HAS_PPR)
 
 	andi.	r0,r9,(_TIF_SYSCALL_DOTRACE|_TIF_SINGLESTEP)
@@ -942,12 +941,6 @@ fast_exception_return:
 	andi.	r0,r3,MSR_RI
 	beq-	.Lunrecov_restore
 
-	/* Load PPR from thread struct before we clear MSR:RI */
-BEGIN_FTR_SECTION
-	ld	r2,PACACURRENT(r13)
-	ld	r2,TASKTHREADPPR(r2)
-END_FTR_SECTION_IFSET(CPU_FTR_HAS_PPR)
-
 	/*
 	 * Clear RI before restoring r13.  If we are returning to
 	 * userspace and we take an exception after restoring r13,
@@ -968,7 +961,9 @@ END_FTR_SECTION_IFSET(CPU_FTR_HAS_PPR)
 	andi.	r0,r3,MSR_PR
 	beq	1f
 BEGIN_FTR_SECTION
-	mtspr	SPRN_PPR,r2	/* Restore PPR */
+	/* Restore PPR */
+	ld	r2,_PPR(r1)
+	mtspr	SPRN_PPR,r2
 END_FTR_SECTION_IFSET(CPU_FTR_HAS_PPR)
 	ACCOUNT_CPU_USER_EXIT(r13, r2, r4)
 	REST_GPR(13, r1)
diff --git a/arch/powerpc/kernel/process.c b/arch/powerpc/kernel/process.c
index 0ed8d0968515..f9d1cca28cce 100644
--- a/arch/powerpc/kernel/process.c
+++ b/arch/powerpc/kernel/process.c
@@ -1710,7 +1710,7 @@ int copy_thread(unsigned long clone_flags, unsigned long usp,
 		p->thread.dscr = mfspr(SPRN_DSCR);
 	}
 	if (cpu_has_feature(CPU_FTR_HAS_PPR))
-		p->thread.ppr = INIT_PPR;
+		childregs->ppr = DEFAULT_PPR;
 
 	p->thread.tidr = 0;
 #endif
diff --git a/arch/powerpc/kernel/ptrace.c b/arch/powerpc/kernel/ptrace.c
index c7d0d0c1e34d..afb819f4ca68 100644
--- a/arch/powerpc/kernel/ptrace.c
+++ b/arch/powerpc/kernel/ptrace.c
@@ -1609,7 +1609,7 @@ static int ppr_get(struct task_struct *target,
 		      void *kbuf, void __user *ubuf)
 {
 	return user_regset_copyout(&pos, &count, &kbuf, &ubuf,
-				   &target->thread.ppr, 0, sizeof(u64));
+				   &target->thread.regs->ppr, 0, sizeof(u64));
 }
 
 static int ppr_set(struct task_struct *target,
@@ -1618,7 +1618,7 @@ static int ppr_set(struct task_struct *target,
 		      const void *kbuf, const void __user *ubuf)
 {
 	return user_regset_copyin(&pos, &count, &kbuf, &ubuf,
-				  &target->thread.ppr, 0, sizeof(u64));
+				  &target->thread.regs->ppr, 0, sizeof(u64));
 }
 
 static int dscr_get(struct task_struct *target,
-- 
2.17.1


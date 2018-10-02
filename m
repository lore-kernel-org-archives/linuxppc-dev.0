Return-Path: <SRS0=LYrz=MO=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A945C43143
	for <linuxppc-dev@archiver.kernel.org>; Tue,  2 Oct 2018 14:50:08 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AA7392082A
	for <linuxppc-dev@archiver.kernel.org>; Tue,  2 Oct 2018 14:50:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HfXoTJh7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AA7392082A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42Phrs4DszzDr8q
	for <linuxppc-dev@archiver.kernel.org>; Wed,  3 Oct 2018 00:50:05 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="HfXoTJh7";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::644; helo=mail-pl1-x644.google.com;
 envelope-from=npiggin@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="HfXoTJh7"; 
 dkim-atps=neutral
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com
 [IPv6:2607:f8b0:4864:20::644])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42PhMc5D9lzDrDT
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  3 Oct 2018 00:28:12 +1000 (AEST)
Received: by mail-pl1-x644.google.com with SMTP id v5-v6so1706278plz.13
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 02 Oct 2018 07:28:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=8RvbUmqAJNoqxaw+QZlonciUMsIbxSzAM0iHQDYgKBg=;
 b=HfXoTJh7j0XQUIbyIbXqSVyGECfwYltQKAfOA4DgjpBOpFUPt6TvvHRtbDUQnraxWj
 yI3erbmnAhSAr9WESnib5pHVPRDfe3+SbzsIIfq/Bu6p0mE16k6LsUQLIMdeS048lMO9
 DMW9qDzJl/97JkykMG7RyBcLYqC1SBb/TVlFhaIl8DNmDVxkqrMBWFq65P7+/c8elCFb
 grxrUW9DXndkK9EKMzgMfxkBHDRBOlsQ+9BKOT0+/SF6Vz1hxrIA7KGyGrff00NJb4TX
 HNKFiS0PbRZPaccK+1qVwgmoLLfozm1t2kAFFOA63DHQ2iPq5mtTmL3bMxJWzoeBJllQ
 0uzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=8RvbUmqAJNoqxaw+QZlonciUMsIbxSzAM0iHQDYgKBg=;
 b=PslsEi/lgGMpTW4caQRYMgU+nA2Bh9svXpGlZ+B52LSnJ+/vNRm218g1wJ7CMpTe3u
 H5rVkw+L0Emnl7rv40ewXJnN/wNi8HNL//RoLKZVMnXpznJWUZyponocljrFxIIGTEsx
 EpwKPE76051bGJ0EMbFr0yXAALAxSmk2bnbgPoNydqjSDqog178f6yskGM4LWQSq20Wx
 gMiDbZBu2j1Ww+rjFznqtE9h9JLHUEAiZ8Zr6q6iLOf8s/M2ZheDJ7uIBg+zgc1wIfLn
 uNcLIpmf6cLoU6zWLIqg/tu8AuIefzgN1NsCQ+yOU2S9rASAPHY0xGzXQ3uTcFWVcuim
 RY/A==
X-Gm-Message-State: ABuFfogoaeJzT2Oz6C4YtGTQZYgK1MzmuFrnYqvfjgFGpZeP2ccDb47j
 oqvHt/IuFhilf/UtbXNq7M/vMAap
X-Google-Smtp-Source: ACcGV613mcowE7DoftAKJyLSWDeuXROAaF/H3SksC6TYxNAq5IEhC4fNtN+Axm91TCQq+qdMvSpFnA==
X-Received: by 2002:a63:fd09:: with SMTP id
 d9-v6mr12967162pgh.164.1538490490602; 
 Tue, 02 Oct 2018 07:28:10 -0700 (PDT)
Received: from roar.local0.net (59-102-83-213.tpgi.com.au. [59.102.83.213])
 by smtp.gmail.com with ESMTPSA id p3-v6sm21862621pfo.130.2018.10.02.07.28.08
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 02 Oct 2018 07:28:10 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v2 3/9] powerpc/64: interrupts save PPR on stack rather than
 thread_struct
Date: Wed,  3 Oct 2018 00:27:53 +1000
Message-Id: <20181002142759.6244-4-npiggin@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20181002142759.6244-1-npiggin@gmail.com>
References: <20181002142759.6244-1-npiggin@gmail.com>
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
Cc: "Aneesh Kumar K . V" <aneesh.kumar@linux.vnet.ibm.com>,
 Nicholas Piggin <npiggin@gmail.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

PPR is the odd register out when it comes to interrupt handling,
it is saved in current->thread.ppr while all others are saved on
the stack.

The difficulty with this is that accessing thread.ppr can cause a
SLB fault, but the SLB fault handler implementation in C change had
assumed the normal exception entry handlers would not cause an SLB
fault.

Fix this by allocating room in the interrupt stack to save PPR.

Fixes: 5e46e29e6a97 ("powerpc/64s/hash: convert SLB miss handlers to C")
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 arch/powerpc/include/asm/exception-64s.h |  9 ++++-----
 arch/powerpc/include/asm/processor.h     | 12 +++++++-----
 arch/powerpc/include/asm/ptrace.h        |  1 +
 arch/powerpc/kernel/asm-offsets.c        |  2 +-
 arch/powerpc/kernel/entry_64.S           | 15 +++++----------
 arch/powerpc/kernel/process.c            |  2 +-
 arch/powerpc/kernel/ptrace.c             |  4 ++--
 7 files changed, 21 insertions(+), 24 deletions(-)

diff --git a/arch/powerpc/include/asm/exception-64s.h b/arch/powerpc/include/asm/exception-64s.h
index 47578b79f0fb..3b4767ed3ec5 100644
--- a/arch/powerpc/include/asm/exception-64s.h
+++ b/arch/powerpc/include/asm/exception-64s.h
@@ -228,11 +228,10 @@
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
@@ -500,7 +499,7 @@ END_FTR_SECTION_NESTED(ftr,ftr,943)
 3:	EXCEPTION_PROLOG_COMMON_1();					   \
 	beq	4f;			/* if from kernel mode		*/ \
 	ACCOUNT_CPU_USER_ENTRY(r13, r9, r10);				   \
-	SAVE_PPR(area, r9, r10);					   \
+	SAVE_PPR(area, r9);						   \
 4:	EXCEPTION_PROLOG_COMMON_2(area)					   \
 	EXCEPTION_PROLOG_COMMON_3(n)					   \
 	ACCOUNT_STOLEN_TIME
diff --git a/arch/powerpc/include/asm/processor.h b/arch/powerpc/include/asm/processor.h
index 350c584ca179..07251598056c 100644
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
 
@@ -247,7 +247,11 @@ struct thread_struct {
 #ifdef CONFIG_PPC64
 	unsigned long	ksp_vsid;
 #endif
-	struct pt_regs	*regs;		/* Pointer to saved register state */
+	union {
+		struct int_regs	*iregs;	/* Pointer to saved register state */
+		struct pt_regs	*regs;	/* Pointer to saved register state */
+	};
+
 	mm_segment_t	addr_limit;	/* for get_fs() validation */
 #ifdef CONFIG_BOOKE
 	/* BookE base exception scratch space; align on cacheline */
@@ -342,7 +346,6 @@ struct thread_struct {
 	 * onwards.
 	 */
 	int		dscr_inherit;
-	unsigned long	ppr;	/* used to save/restore SMT priority */
 	unsigned long	tidr;
 #endif
 #ifdef CONFIG_PPC_BOOK3S_64
@@ -390,7 +393,6 @@ struct thread_struct {
 	.regs = (struct pt_regs *)INIT_SP - 1, /* XXX bogus, I think */ \
 	.addr_limit = KERNEL_DS, \
 	.fpexc_mode = 0, \
-	.ppr = INIT_PPR, \
 	.fscr = FSCR_TAR | FSCR_EBB \
 }
 #endif
diff --git a/arch/powerpc/include/asm/ptrace.h b/arch/powerpc/include/asm/ptrace.h
index 1a98cd8c49f6..9a5a1cc85bd0 100644
--- a/arch/powerpc/include/asm/ptrace.h
+++ b/arch/powerpc/include/asm/ptrace.h
@@ -78,6 +78,7 @@
 struct int_regs {
 	/* pt_regs must be offset 0 so r1 + STACK_FRAME_OVERHEAD points to it */
 	struct pt_regs pt_regs;
+	unsigned long ppr;
 };
 
 #define GET_IP(regs)		((regs)->nip)
diff --git a/arch/powerpc/kernel/asm-offsets.c b/arch/powerpc/kernel/asm-offsets.c
index 509a113f97dc..56241174ea94 100644
--- a/arch/powerpc/kernel/asm-offsets.c
+++ b/arch/powerpc/kernel/asm-offsets.c
@@ -88,7 +88,6 @@ int main(void)
 #ifdef CONFIG_PPC64
 	DEFINE(SIGSEGV, SIGSEGV);
 	DEFINE(NMI_MASK, NMI_MASK);
-	OFFSET(TASKTHREADPPR, task_struct, thread.ppr);
 #else
 	OFFSET(THREAD_INFO, task_struct, stack);
 	DEFINE(THREAD_INFO_GAP, _ALIGN_UP(sizeof(struct thread_info), 16));
@@ -283,6 +282,7 @@ int main(void)
 	/* Create extra stack space for SRR0 and SRR1 when calling prom/rtas. */
 	DEFINE(PROM_FRAME_SIZE, STACK_FRAME_OVERHEAD + sizeof(struct int_regs) + 16);
 	DEFINE(RTAS_FRAME_SIZE, STACK_FRAME_OVERHEAD + sizeof(struct int_regs) + 16);
+	STACK_INT_REGS_OFFSET(_PPR, ppr);
 #endif /* CONFIG_PPC64 */
 	STACK_PT_REGS_OFFSET(GPR0, gpr[0]);
 	STACK_PT_REGS_OFFSET(GPR1, gpr[1]);
diff --git a/arch/powerpc/kernel/entry_64.S b/arch/powerpc/kernel/entry_64.S
index 77a888bfcb53..ce448f753d2e 100644
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
@@ -938,12 +937,6 @@ fast_exception_return:
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
@@ -964,7 +957,9 @@ END_FTR_SECTION_IFSET(CPU_FTR_HAS_PPR)
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
index 532e9a83e526..18a14fb8f759 100644
--- a/arch/powerpc/kernel/process.c
+++ b/arch/powerpc/kernel/process.c
@@ -1711,7 +1711,7 @@ int copy_thread(unsigned long clone_flags, unsigned long usp,
 		p->thread.dscr = mfspr(SPRN_DSCR);
 	}
 	if (cpu_has_feature(CPU_FTR_HAS_PPR))
-		p->thread.ppr = INIT_PPR;
+		childregs->ppr = DEFAULT_PPR;
 
 	p->thread.tidr = 0;
 #endif
diff --git a/arch/powerpc/kernel/ptrace.c b/arch/powerpc/kernel/ptrace.c
index 9667666eb18e..57c04176f686 100644
--- a/arch/powerpc/kernel/ptrace.c
+++ b/arch/powerpc/kernel/ptrace.c
@@ -1609,7 +1609,7 @@ static int ppr_get(struct task_struct *target,
 		      void *kbuf, void __user *ubuf)
 {
 	return user_regset_copyout(&pos, &count, &kbuf, &ubuf,
-				   &target->thread.ppr, 0, sizeof(u64));
+				   &target->thread.iregs->ppr, 0, sizeof(u64));
 }
 
 static int ppr_set(struct task_struct *target,
@@ -1618,7 +1618,7 @@ static int ppr_set(struct task_struct *target,
 		      const void *kbuf, const void __user *ubuf)
 {
 	return user_regset_copyin(&pos, &count, &kbuf, &ubuf,
-				  &target->thread.ppr, 0, sizeof(u64));
+				  &target->thread.iregs->ppr, 0, sizeof(u64));
 }
 
 static int dscr_get(struct task_struct *target,
-- 
2.18.0


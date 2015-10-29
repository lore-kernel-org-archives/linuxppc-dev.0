Return-Path: <anton@samba.org>
Received: from hr2.samba.org (hr2.samba.org [IPv6:2a01:4f8:192:486::147:1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id D59C41A0483
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 29 Oct 2015 11:45:35 +1100 (AEDT)
From: Anton Blanchard <anton@samba.org>
To: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
 mikey@neuling.org, cyrilbur@gmail.com, scottwood@freescale.com
Cc: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 08/19] powerpc: Remove NULL task struct pointer checks in FP
 and vector code
Date: Thu, 29 Oct 2015 11:44:00 +1100
Message-Id: <1446079451-8774-9-git-send-email-anton@samba.org>
In-Reply-To: <1446079451-8774-1-git-send-email-anton@samba.org>
References: <1446079451-8774-1-git-send-email-anton@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

We used to allow giveup_*() to be called with a NULL task struct
pointer. Now those cases are handled in the caller we can remove
the checks. We can also remove giveup_altivec_notask() which is also
unused.

Signed-off-by: Anton Blanchard <anton@samba.org>
---
 arch/powerpc/include/asm/switch_to.h |  1 -
 arch/powerpc/kernel/fpu.S            |  2 --
 arch/powerpc/kernel/head_fsl_booke.S |  2 --
 arch/powerpc/kernel/vector.S         | 14 --------------
 4 files changed, 19 deletions(-)

diff --git a/arch/powerpc/include/asm/switch_to.h b/arch/powerpc/include/asm/switch_to.h
index bd1d933..042aaf0 100644
--- a/arch/powerpc/include/asm/switch_to.h
+++ b/arch/powerpc/include/asm/switch_to.h
@@ -38,7 +38,6 @@ static inline void giveup_fpu(struct task_struct *t) { }
 #ifdef CONFIG_ALTIVEC
 extern void flush_altivec_to_thread(struct task_struct *);
 extern void giveup_altivec(struct task_struct *);
-extern void giveup_altivec_notask(void);
 #else
 static inline void flush_altivec_to_thread(struct task_struct *t)
 {
diff --git a/arch/powerpc/kernel/fpu.S b/arch/powerpc/kernel/fpu.S
index 50d2352..71bdce2 100644
--- a/arch/powerpc/kernel/fpu.S
+++ b/arch/powerpc/kernel/fpu.S
@@ -173,8 +173,6 @@ END_FTR_SECTION_IFSET(CPU_FTR_VSX)
 	MTMSRD(r5)			/* enable use of fpu now */
 	SYNC_601
 	isync
-	PPC_LCMPI	0,r3,0
-	beqlr-				/* if no previous owner, done */
 	addi	r3,r3,THREAD	        /* want THREAD of task */
 	PPC_LL	r6,THREAD_FPSAVEAREA(r3)
 	PPC_LL	r5,PT_REGS(r3)
diff --git a/arch/powerpc/kernel/head_fsl_booke.S b/arch/powerpc/kernel/head_fsl_booke.S
index ec936ab..d6980bb 100644
--- a/arch/powerpc/kernel/head_fsl_booke.S
+++ b/arch/powerpc/kernel/head_fsl_booke.S
@@ -992,8 +992,6 @@ _GLOBAL(giveup_spe)
 	oris	r5,r5,MSR_SPE@h
 	mtmsr	r5			/* enable use of SPE now */
 	isync
-	cmpi	0,r3,0
-	beqlr-				/* if no previous owner, done */
 	addi	r3,r3,THREAD		/* want THREAD of task */
 	lwz	r5,PT_REGS(r3)
 	cmpi	0,r5,0
diff --git a/arch/powerpc/kernel/vector.S b/arch/powerpc/kernel/vector.S
index 1757c0c..b31528c 100644
--- a/arch/powerpc/kernel/vector.S
+++ b/arch/powerpc/kernel/vector.S
@@ -111,16 +111,6 @@ _GLOBAL(load_up_altivec)
 	/* restore registers and return */
 	blr
 
-_GLOBAL(giveup_altivec_notask)
-	mfmsr	r3
-	andis.	r4,r3,MSR_VEC@h
-	bnelr				/* Already enabled? */
-	oris	r3,r3,MSR_VEC@h
-	SYNC
-	MTMSRD(r3)			/* enable use of VMX now */
-	isync
-	blr
-
 /*
  * giveup_altivec(tsk)
  * Disable VMX for the task given as the argument,
@@ -133,8 +123,6 @@ _GLOBAL(giveup_altivec)
 	SYNC
 	MTMSRD(r5)			/* enable use of VMX now */
 	isync
-	PPC_LCMPI	0,r3,0
-	beqlr				/* if no previous owner, done */
 	addi	r3,r3,THREAD		/* want THREAD of task */
 	PPC_LL	r7,THREAD_VRSAVEAREA(r3)
 	PPC_LL	r5,PT_REGS(r3)
@@ -203,8 +191,6 @@ _GLOBAL(__giveup_vsx)
 	mtmsrd	r5			/* enable use of VSX now */
 	isync
 
-	cmpdi	0,r3,0
-	beqlr-				/* if no previous owner, done */
 	addi	r3,r3,THREAD		/* want THREAD of task */
 	ld	r5,PT_REGS(r3)
 	cmpdi	0,r5,0
-- 
2.5.0

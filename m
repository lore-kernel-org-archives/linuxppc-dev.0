Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id D66BEDDE04
	for <linuxppc-dev@ozlabs.org>; Thu,  1 May 2008 16:33:48 +1000 (EST)
From: Kumar Gala <galak@kernel.crashing.org>
To: paulus@samba.org, benh@kernel.crashing.org
Subject: [PATCH v3 3/3] [POWERPC] 40x/Book-E: Save/restore volatile exception
	registers
Date: Thu,  1 May 2008 01:29:29 -0500
Message-Id: <1209623369-4592-3-git-send-email-galak@kernel.crashing.org>
In-Reply-To: <1209623369-4592-2-git-send-email-galak@kernel.crashing.org>
References: <1209623369-4592-1-git-send-email-galak@kernel.crashing.org>
	<1209623369-4592-2-git-send-email-galak@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On machines with more than one exception level any system register that
might be modified by the "normal" exception level needs to be saved and
restored on taking a higher level exception.  We already are saving
and restoring ESR and DEAR.

For critical level add SRR0/1.
For debug level add CSRR0/1 and SRR0/1.
For machine check level add DSRR0/1, CSRR0/1, and SRR0/1.

On FSL Book-E parts we always save/restore the MAS registers for critical,
debug, and machine check level exceptions.  On 44x we always save/restore
the MMUCR.

Signed-off-by: Kumar Gala <galak@kernel.crashing.org>
---

* Added saving/restoring of 44x MMUCR.

 arch/powerpc/kernel/asm-offsets.c |   27 +++++++++++
 arch/powerpc/kernel/entry_32.S    |   93 ++++++++++++++++++++++++++++++++++++-
 arch/powerpc/kernel/head_40x.S    |    4 ++
 arch/powerpc/kernel/head_booke.h  |   24 +++++++++-
 4 files changed, 144 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/kernel/asm-offsets.c b/arch/powerpc/kernel/asm-offsets.c
index ec9228d..c106f1f 100644
--- a/arch/powerpc/kernel/asm-offsets.c
+++ b/arch/powerpc/kernel/asm-offsets.c
@@ -52,6 +52,15 @@
 #include <asm/iseries/alpaca.h>
 #endif
 
+#if defined(CONFIG_BOOKE) || defined(CONFIG_40x)
+#include "head_booke.h"
+#endif
+
+#define DEFINE(sym, val) \
+	asm volatile("\n->" #sym " %0 " #val : : "i" (val))
+
+#define BLANK() asm volatile("\n->" : : )
+
 int main(void)
 {
 	DEFINE(THREAD, offsetof(struct task_struct, thread));
@@ -242,6 +251,24 @@ int main(void)
 	DEFINE(_SRR1, STACK_FRAME_OVERHEAD+sizeof(struct pt_regs)+8);
 #endif /* CONFIG_PPC64 */
 
+#if defined(CONFIG_BOOKE) || defined(CONFIG_40x)
+	DEFINE(EXC_LVL_SIZE, STACK_EXC_LVL_FRAME_SIZE);
+	DEFINE(MAS0, STACK_INT_FRAME_SIZE+offsetof(struct exception_regs, mas0));
+	/* we overload MMUCR for 44x on MAS0 since they are mutually exclusive */
+	DEFINE(MMUCR, STACK_INT_FRAME_SIZE+offsetof(struct exception_regs, mas0));
+	DEFINE(MAS1, STACK_INT_FRAME_SIZE+offsetof(struct exception_regs, mas1));
+	DEFINE(MAS2, STACK_INT_FRAME_SIZE+offsetof(struct exception_regs, mas2));
+	DEFINE(MAS3, STACK_INT_FRAME_SIZE+offsetof(struct exception_regs, mas3));
+	DEFINE(MAS6, STACK_INT_FRAME_SIZE+offsetof(struct exception_regs, mas6));
+	DEFINE(MAS7, STACK_INT_FRAME_SIZE+offsetof(struct exception_regs, mas7));
+	DEFINE(_SRR0, STACK_INT_FRAME_SIZE+offsetof(struct exception_regs, srr0));
+	DEFINE(_SRR1, STACK_INT_FRAME_SIZE+offsetof(struct exception_regs, srr1));
+	DEFINE(_CSRR0, STACK_INT_FRAME_SIZE+offsetof(struct exception_regs, csrr0));
+	DEFINE(_CSRR1, STACK_INT_FRAME_SIZE+offsetof(struct exception_regs, csrr1));
+	DEFINE(_DSRR0, STACK_INT_FRAME_SIZE+offsetof(struct exception_regs, dsrr0));
+	DEFINE(_DSRR1, STACK_INT_FRAME_SIZE+offsetof(struct exception_regs, dsrr1));
+#endif
+
 	DEFINE(CLONE_VM, CLONE_VM);
 	DEFINE(CLONE_UNTRACED, CLONE_UNTRACED);
 
diff --git a/arch/powerpc/kernel/entry_32.S b/arch/powerpc/kernel/entry_32.S
index 816dd54..2cd7ecc 100644
--- a/arch/powerpc/kernel/entry_32.S
+++ b/arch/powerpc/kernel/entry_32.S
@@ -46,14 +46,46 @@
 #ifdef CONFIG_BOOKE
 	.globl	mcheck_transfer_to_handler
 mcheck_transfer_to_handler:
-	b	transfer_to_handler_full
+	mfspr	r0,SPRN_DSRR0
+	stw	r0,_DSRR0(r11)
+	mfspr	r0,SPRN_DSRR1
+	stw	r0,_DSRR1(r11)
+	/* fall through */
 
 	.globl	debug_transfer_to_handler
 debug_transfer_to_handler:
-	b	transfer_to_handler_full
+	mfspr	r0,SPRN_CSRR0
+	stw	r0,_CSRR0(r11)
+	mfspr	r0,SPRN_CSRR1
+	stw	r0,_CSRR1(r11)
+	/* fall through */
 
 	.globl	crit_transfer_to_handler
 crit_transfer_to_handler:
+#ifdef CONFIG_FSL_BOOKE
+	mfspr	r0,SPRN_MAS0
+	stw	r0,MAS0(r11)
+	mfspr	r0,SPRN_MAS1
+	stw	r0,MAS1(r11)
+	mfspr	r0,SPRN_MAS2
+	stw	r0,MAS2(r11)
+	mfspr	r0,SPRN_MAS3
+	stw	r0,MAS3(r11)
+	mfspr	r0,SPRN_MAS6
+	stw	r0,MAS6(r11)
+#ifdef CONFIG_PHYS_64BIT
+	mfspr	r0,SPRN_MAS7
+	stw	r0,MAS7(r11)
+#endif /* CONFIG_PHYS_64BIT */
+#endif /* CONFIG_FSL_BOOKE */
+#ifdef CONFIG_44x
+	mfspr	r0,SPRN_MMUCR
+	stw	r0,MMUCR(r11)
+#endif
+	mfspr	r0,SPRN_SRR0
+	stw	r0,_SRR0(r11)
+	mfspr	r0,SPRN_SRR1
+	stw	r0,_SRR1(r11)
 	/* fall through */
 #endif
 
@@ -64,6 +96,10 @@ crit_transfer_to_handler:
 	stw	r0,GPR10(r11)
 	lwz	r0,crit_r11@l(0)
 	stw	r0,GPR11(r11)
+	mfspr	r0,SPRN_SRR0
+	stw	r0,crit_srr0@l(0)
+	mfspr	r0,SPRN_SRR1
+	stw	r0,crit_srr1@l(0)
 	/* fall through */
 #endif
 
@@ -846,17 +882,70 @@ exc_exit_restart_end:
 	exc_lvl_rfi;							\
 	b	.;		/* prevent prefetch past exc_lvl_rfi */
 
+#define	RESTORE_xSRR(exc_lvl_srr0, exc_lvl_srr1)			\
+	lwz	r9,_##exc_lvl_srr0(r1);					\
+	lwz	r10,_##exc_lvl_srr1(r1);				\
+	mtspr	SPRN_##exc_lvl_srr0,r9;					\
+	mtspr	SPRN_##exc_lvl_srr1,r10;
+
+#if defined(CONFIG_FSL_BOOKE)
+#ifdef CONFIG_PHYS_64BIT
+#define	RESTORE_MAS7							\
+	lwz	r11,MAS7(r1);						\
+	mtspr	SPRN_MAS7,r11;
+#else
+#define	RESTORE_MAS7
+#endif /* CONFIG_PHYS_64BIT */
+#define RESTORE_MMU_REGS						\
+	lwz	r9,MAS0(r1);						\
+	lwz	r10,MAS1(r1);						\
+	lwz	r11,MAS2(r1);						\
+	mtspr	SPRN_MAS0,r9;						\
+	lwz	r9,MAS3(r1);						\
+	mtspr	SPRN_MAS1,r10;						\
+	lwz	r10,MAS6(r1);						\
+	mtspr	SPRN_MAS2,r11;						\
+	mtspr	SPRN_MAS3,r9;						\
+	mtspr	SPRN_MAS6,r10;						\
+	RESTORE_MAS7;
+#elif defined(CONFIG_44x)
+#define RESTORE_MMU_REGS						\
+	lwz	r9,MMUCR(r1);						\
+	mtspr	SPRN_MMUCR,r9;						\
+#else
+#define RESTORE_MMU_REGS
+#endif
+
+#ifdef CONFIG_40x
 	.globl	ret_from_crit_exc
 ret_from_crit_exc:
+	lwz	r9,crit_srr0@l(0);
+	lwz	r10,crit_srr1@l(0);
+	mtspr	SPRN_SRR0,r9;
+	mtspr	SPRN_SRR1,r10;
 	RET_FROM_EXC_LEVEL(SPRN_CSRR0, SPRN_CSRR1, RFCI)
+#endif /* CONFIG_40x */
 
 #ifdef CONFIG_BOOKE
+	.globl	ret_from_crit_exc
+ret_from_crit_exc:
+	RESTORE_xSRR(SRR0,SRR1);
+	RESTORE_MMU_REGS;
+	RET_FROM_EXC_LEVEL(SPRN_CSRR0, SPRN_CSRR1, RFCI)
+
 	.globl	ret_from_debug_exc
 ret_from_debug_exc:
+	RESTORE_xSRR(SRR0,SRR1);
+	RESTORE_xSRR(CSRR0,CSRR1);
+	RESTORE_MMU_REGS;
 	RET_FROM_EXC_LEVEL(SPRN_DSRR0, SPRN_DSRR1, RFDI)
 
 	.globl	ret_from_mcheck_exc
 ret_from_mcheck_exc:
+	RESTORE_xSRR(SRR0,SRR1);
+	RESTORE_xSRR(CSRR0,CSRR1);
+	RESTORE_xSRR(DSRR0,DSRR1);
+	RESTORE_MMU_REGS;
 	RET_FROM_EXC_LEVEL(SPRN_MCSRR0, SPRN_MCSRR1, RFMCI)
 #endif /* CONFIG_BOOKE */
 
diff --git a/arch/powerpc/kernel/head_40x.S b/arch/powerpc/kernel/head_40x.S
index ca75eaf..3c819a1 100644
--- a/arch/powerpc/kernel/head_40x.S
+++ b/arch/powerpc/kernel/head_40x.S
@@ -93,6 +93,10 @@ _ENTRY(crit_r10)
 	.space	4
 _ENTRY(crit_r11)
 	.space	4
+_ENTRY(crit_srr0)
+	.space	4
+_ENTRY(crit_srr1)
+	.space	4
 
 /*
  * Exception vector entry code. This code runs with address translation
diff --git a/arch/powerpc/kernel/head_booke.h b/arch/powerpc/kernel/head_booke.h
index 667c78e..9c81efc 100644
--- a/arch/powerpc/kernel/head_booke.h
+++ b/arch/powerpc/kernel/head_booke.h
@@ -78,12 +78,12 @@
 	slwi	r8,r8,2;				\
 	addis	r8,r8,level##_STACK_BASE@ha;		\
 	lwz	r8,level##_STACK_BASE@l(r8);		\
-	addi	r8,r8,THREAD_SIZE-INT_FRAME_SIZE;
+	addi	r8,r8,THREAD_SIZE-INT_FRAME_SIZE-EXC_LVL_SIZE;
 #else
 #define BOOKE_LOAD_EXC_LEVEL_STACK(level)		\
 	lis	r8,level##_STACK_BASE@ha;		\
 	lwz	r8,level##_STACK_BASE@l(r8);		\
-	addi	r8,r8,THREAD_SIZE-INT_FRAME_SIZE;
+	addi	r8,r8,THREAD_SIZE-INT_FRAME_SIZE-EXC_LVL_SIZE;
 #endif
 
 /*
@@ -374,4 +374,24 @@ label:
 	addi	r3,r1,STACK_FRAME_OVERHEAD;				      \
 	EXC_XFER_EE_LITE(0x800, kernel_fp_unavailable_exception)
 
+#ifndef __ASSEMBLY__
+/* ensure this structure is always sized to a multiple of the stack alignment */
+struct exception_regs {
+	unsigned long mas0;
+	unsigned long mas1;
+	unsigned long mas2;
+	unsigned long mas3;
+	unsigned long mas6;
+	unsigned long mas7;
+	unsigned long srr0;
+	unsigned long srr1;
+	unsigned long csrr0;
+	unsigned long csrr1;
+	unsigned long dsrr0;
+	unsigned long dsrr1;
+};
+
+#define STACK_EXC_LVL_FRAME_SIZE	(sizeof (struct exception_regs))
+
+#endif /* __ASSEMBLY__ */
 #endif /* __HEAD_BOOKE_H__ */
-- 
1.5.4.1

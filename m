Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id B56C0DE238
	for <linuxppc-dev@ozlabs.org>; Wed, 30 Apr 2008 00:01:08 +1000 (EST)
Date: Tue, 29 Apr 2008 08:56:56 -0500 (CDT)
From: Kumar Gala <galak@kernel.crashing.org>
To: Paul Mackerras <paulus@samba.org>
Subject: [PATCH] [POWERPC] convert transfer_to_handler into a macro
Message-ID: <Pine.LNX.4.64.0804290856210.9230@blarg.am.freescale.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

We need to have unique transfer_to_handler paths for each exception level
that is supported.  We need to use the proper xSRR0/1 depending on which
exception level the interrupt was from.  The macro conversion lets up
templatize this code path.

Signed-off-by: Kumar Gala <galak@kernel.crashing.org>
---

Paul,

I request you apply this for v2.6.26.  I know its a bit late in the game
but I'd prefer to get this in so reduce churn later.  Also, I've built this
version on pmac_defconfig, ppc40x_defconfig, and ppc44x_config and compared
the objdump output to ensure that the code is identical before and after
this patch.

- k

 arch/powerpc/kernel/entry_32.S |  191 ++++++++++++++++++++++------------------
 1 files changed, 106 insertions(+), 85 deletions(-)

diff --git a/arch/powerpc/kernel/entry_32.S b/arch/powerpc/kernel/entry_32.S
index 0c8614d..7710a02 100644
--- a/arch/powerpc/kernel/entry_32.S
+++ b/arch/powerpc/kernel/entry_32.S
@@ -43,6 +43,111 @@
 #define LOAD_MSR_KERNEL(r, x)	li r,(x)
 #endif

+#if defined(CONFIG_40x) || defined(CONFIG_BOOKE)
+#ifdef CONFIG_SMP
+#define SMP_ADJUST_GLOBAL_DBCR0						       \
+	rlwinm	r9,r1,0,0,(31-THREAD_SHIFT);				       \
+	lwz	r9,TI_CPU(r9);						       \
+	slwi	r9,r9,3;						       \
+	add	r11,r11,r9;
+#else
+#define SMP_ADJUST_GLOBAL_DBCR0
+#endif
+#define HANDLE_DBCR							       \
+	/* Check to see if the dbcr0 register is set up to debug.  Use the     \
+	   internal debug mode bit to do this. */			       \
+	lwz	r12,THREAD_DBCR0(r12);					       \
+	andis.	r12,r12,DBCR0_IDM@h;					       \
+	beq+	3f;							       \
+	/* From user and task is ptraced - load up global dbcr0 */	       \
+	li	r12,-1;			/* clear all pending debug events */   \
+	mtspr	SPRN_DBSR,r12;						       \
+	lis	r11,global_dbcr0@ha;					       \
+	tophys(r11,r11);						       \
+	addi	r11,r11,global_dbcr0@l;					       \
+	SMP_ADJUST_GLOBAL_DBCR0;					       \
+	lwz	r12,0(r11);						       \
+	mtspr	SPRN_DBCR0,r12;						       \
+	lwz	r12,4(r11);						       \
+	addi	r12,r12,-1;						       \
+	stw	r12,4(r11);
+#else
+#define HANDLE_DBCR
+#endif
+
+#ifdef CONFIG_6xx
+#define CHECK_DOZE_NAP							       \
+	rlwinm	r9,r1,0,0,31-THREAD_SHIFT;				       \
+	tophys(r9,r9);			/* check local flags */		       \
+	lwz	r12,TI_LOCAL_FLAGS(r9);					       \
+	mtcrf	0x01,r12;						       \
+	bt-	31-TLF_NAPPING,4f;
+#define RESTORE_DOZE_NAP						       \
+4:	rlwinm	r12,r12,0,~_TLF_NAPPING;				       \
+	stw	r12,TI_LOCAL_FLAGS(r9);					       \
+	b	power_save_6xx_restore;
+#else
+#define RESTORE_DOZE_NAP
+#define CHECK_DOZE_NAP
+#endif /* CONFIG_6xx */
+
+/*
+ * This code finishes saving the registers to the exception frame
+ * and jumps to the appropriate handler for the exception, turning
+ * on address translation.
+ * Note that we rely on the caller having set cr0.eq iff the exception
+ * occurred in kernel mode (i.e. MSR:PR = 0).
+ */
+
+#define	TRANSFER_TO_HANDLER(prefix, exc_lvl_srr0, exc_lvl_srr1, exc_lvl_rfi)   \
+	.globl	prefix##transfer_to_handler_full;			       \
+prefix##transfer_to_handler_full:					       \
+	SAVE_NVGPRS(r11);						       \
+	/* fall through */						       \
+									       \
+	.globl	prefix##transfer_to_handler;				       \
+prefix##transfer_to_handler:						       \
+	stw	r2,GPR2(r11);						       \
+	stw	r12,_NIP(r11);						       \
+	stw	r9,_MSR(r11);						       \
+	andi.	r2,r9,MSR_PR;						       \
+	mfctr	r12;							       \
+	mfspr	r2,SPRN_XER;						       \
+	stw	r12,_CTR(r11);						       \
+	stw	r2,_XER(r11);						       \
+	mfspr	r12,SPRN_SPRG3;						       \
+	addi	r2,r12,-THREAD;						       \
+	tovirt(r2,r2);			/* set r2 to current */		       \
+	beq	2f;			/* if from user, fix up THREAD.regs */ \
+									       \
+	addi	r11,r1,STACK_FRAME_OVERHEAD;				       \
+	stw	r11,PT_REGS(r12);					       \
+	HANDLE_DBCR;							       \
+	b	3f;							       \
+									       \
+2:	/* if from kernel, check interrupted DOZE/NAP mode and		       \
+         * check for stack overflow					       \
+         */								       \
+	lwz	r9,KSP_LIMIT(r12);					       \
+	cmplw	r1,r9;			/* if r1 <= ksp_limit */	       \
+	ble-	stack_ovf;		/* then the kernel stack overflowed */ \
+5:									       \
+	CHECK_DOZE_NAP;							       \
+									       \
+	.globl prefix##transfer_to_handler_cont;			       \
+prefix##transfer_to_handler_cont:					       \
+3:									       \
+	mflr	r9;							       \
+	lwz	r11,0(r9);		/* virtual address of handler */       \
+	lwz	r9,4(r9);		/* where to go when done */	       \
+	mtspr	exc_lvl_srr0,r11;					       \
+	mtspr	exc_lvl_srr1,r10;					       \
+	mtlr	r9;							       \
+	SYNC;								       \
+	exc_lvl_rfi;			/* jump to handler, enable MMU */      \
+									       \
+	RESTORE_DOZE_NAP;
+
 #ifdef CONFIG_BOOKE
 #include "head_booke.h"
 #define TRANSFER_TO_HANDLER_EXC_LEVEL(exc_level)	\
@@ -80,91 +185,7 @@ crit_transfer_to_handler:
 	/* fall through */
 #endif

-/*
- * This code finishes saving the registers to the exception frame
- * and jumps to the appropriate handler for the exception, turning
- * on address translation.
- * Note that we rely on the caller having set cr0.eq iff the exception
- * occurred in kernel mode (i.e. MSR:PR = 0).
- */
-	.globl	transfer_to_handler_full
-transfer_to_handler_full:
-	SAVE_NVGPRS(r11)
-	/* fall through */
-
-	.globl	transfer_to_handler
-transfer_to_handler:
-	stw	r2,GPR2(r11)
-	stw	r12,_NIP(r11)
-	stw	r9,_MSR(r11)
-	andi.	r2,r9,MSR_PR
-	mfctr	r12
-	mfspr	r2,SPRN_XER
-	stw	r12,_CTR(r11)
-	stw	r2,_XER(r11)
-	mfspr	r12,SPRN_SPRG3
-	addi	r2,r12,-THREAD
-	tovirt(r2,r2)			/* set r2 to current */
-	beq	2f			/* if from user, fix up THREAD.regs */
-	addi	r11,r1,STACK_FRAME_OVERHEAD
-	stw	r11,PT_REGS(r12)
-#if defined(CONFIG_40x) || defined(CONFIG_BOOKE)
-	/* Check to see if the dbcr0 register is set up to debug.  Use the
-	   internal debug mode bit to do this. */
-	lwz	r12,THREAD_DBCR0(r12)
-	andis.	r12,r12,DBCR0_IDM@h
-	beq+	3f
-	/* From user and task is ptraced - load up global dbcr0 */
-	li	r12,-1			/* clear all pending debug events */
-	mtspr	SPRN_DBSR,r12
-	lis	r11,global_dbcr0@ha
-	tophys(r11,r11)
-	addi	r11,r11,global_dbcr0@l
-#ifdef CONFIG_SMP
-	rlwinm	r9,r1,0,0,(31-THREAD_SHIFT)
-	lwz	r9,TI_CPU(r9)
-	slwi	r9,r9,3
-	add	r11,r11,r9
-#endif
-	lwz	r12,0(r11)
-	mtspr	SPRN_DBCR0,r12
-	lwz	r12,4(r11)
-	addi	r12,r12,-1
-	stw	r12,4(r11)
-#endif
-	b	3f
-
-2:	/* if from kernel, check interrupted DOZE/NAP mode and
-         * check for stack overflow
-         */
-	lwz	r9,KSP_LIMIT(r12)
-	cmplw	r1,r9			/* if r1 <= ksp_limit */
-	ble-	stack_ovf		/* then the kernel stack overflowed */
-5:
-#ifdef CONFIG_6xx
-	rlwinm	r9,r1,0,0,31-THREAD_SHIFT
-	tophys(r9,r9)			/* check local flags */
-	lwz	r12,TI_LOCAL_FLAGS(r9)
-	mtcrf	0x01,r12
-	bt-	31-TLF_NAPPING,4f
-#endif /* CONFIG_6xx */
-	.globl transfer_to_handler_cont
-transfer_to_handler_cont:
-3:
-	mflr	r9
-	lwz	r11,0(r9)		/* virtual address of handler */
-	lwz	r9,4(r9)		/* where to go when done */
-	mtspr	SPRN_SRR0,r11
-	mtspr	SPRN_SRR1,r10
-	mtlr	r9
-	SYNC
-	RFI				/* jump to handler, enable MMU */
-
-#ifdef CONFIG_6xx
-4:	rlwinm	r12,r12,0,~_TLF_NAPPING
-	stw	r12,TI_LOCAL_FLAGS(r9)
-	b	power_save_6xx_restore
-#endif
+	TRANSFER_TO_HANDLER(, SPRN_SRR0, SPRN_SRR1, RFI);

 /*
  * On kernel stack overflow, load up an initial stack pointer
-- 
1.5.4.1

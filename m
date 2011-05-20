Return-Path: <B07421@freescale.com>
Received: from TX2EHSOBE009.bigfish.com (tx2ehsobe004.messaging.microsoft.com
	[65.55.88.14]) (using TLSv1 with cipher AES128-SHA (128/128 bits))
	(Client CN "mail.global.frontbridge.com",
	Issuer "Cybertrust SureServer Standard Validation CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 965CCB71A3
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat, 21 May 2011 05:00:45 +1000 (EST)
Date: Fri, 20 May 2011 14:00:30 -0500
From: Scott Wood <scottwood@freescale.com>
To: <galak@kernel.crashing.org>
Subject: [PATCH 1/2] powerpc/book3e-64: hv exceptions aren't MASKABLE
Message-ID: <20110520190030.GA7058@schlenkerla.am.freescale.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

In general we will not have EE soft-disabled or be napping when
these exceptions happen, but still it is not correct.

The guest doorbell exceptions can only be triggered with MSR[GS]=1,
and thus for host kernel nesting purposes are base-level exceptions.

Note that ehpriv and hypercall are triggerable from normal userspace.
I tested that the process gets properly signalled in this case.

Signed-off-by: Scott Wood <scottwood@freescale.com>
---
 arch/powerpc/include/asm/reg_booke.h |    2 +
 arch/powerpc/kernel/exceptions-64e.S |   67 ++++++++++++++++++++++++++--------
 2 files changed, 53 insertions(+), 16 deletions(-)

diff --git a/arch/powerpc/include/asm/reg_booke.h b/arch/powerpc/include/asm/reg_booke.h
index 0f0ad9f..e438286 100644
--- a/arch/powerpc/include/asm/reg_booke.h
+++ b/arch/powerpc/include/asm/reg_booke.h
@@ -67,6 +67,8 @@
 #define SPRN_EPTCFG	0x15e	/* Embedded Page Table Config */
 #define SPRN_MAS7_MAS3	0x174	/* MMU Assist Register 7 || 3 */
 #define SPRN_MAS0_MAS1	0x175	/* MMU Assist Register 0 || 1 */
+#define SPRN_GSRR0	0x17a	/* Guest Save and Restore Register 0 */
+#define SPRN_GSRR1	0x17b	/* Guest Save and Restore Register 1 */
 #define SPRN_IVOR0	0x190	/* Interrupt Vector Offset Register 0 */
 #define SPRN_IVOR1	0x191	/* Interrupt Vector Offset Register 1 */
 #define SPRN_IVOR2	0x192	/* Interrupt Vector Offset Register 2 */
diff --git a/arch/powerpc/kernel/exceptions-64e.S b/arch/powerpc/kernel/exceptions-64e.S
index 69de473..b60f49e 100644
--- a/arch/powerpc/kernel/exceptions-64e.S
+++ b/arch/powerpc/kernel/exceptions-64e.S
@@ -34,17 +34,17 @@
 #define	SPECIAL_EXC_FRAME_SIZE	INT_FRAME_SIZE
 
 /* Exception prolog code for all exceptions */
-#define EXCEPTION_PROLOG(n, type, addition)				    \
-	mtspr	SPRN_SPRG_##type##_SCRATCH,r13;	/* get spare registers */   \
+#define EXCEPTION_PROLOG(n, level, type, addition)			    \
+	mtspr	SPRN_SPRG_##level##_SCRATCH,r13; /* get spare registers */  \
 	mfspr	r13,SPRN_SPRG_PACA;	/* get PACA */			    \
-	std	r10,PACA_EX##type+EX_R10(r13);				    \
-	std	r11,PACA_EX##type+EX_R11(r13);				    \
+	std	r10,PACA_EX##level+EX_R10(r13);				    \
+	std	r11,PACA_EX##level+EX_R11(r13);				    \
 	mfcr	r10;			/* save CR */			    \
 	addition;			/* additional code for that exc. */ \
-	std	r1,PACA_EX##type+EX_R1(r13); /* save old r1 in the PACA */  \
-	stw	r10,PACA_EX##type+EX_CR(r13); /* save old CR in the PACA */ \
+	std	r1,PACA_EX##level+EX_R1(r13); /* save old r1 in the PACA */ \
+	stw	r10,PACA_EX##level+EX_CR(r13); /* save old CR in the PACA */\
 	mfspr	r11,SPRN_##type##_SRR1;/* what are we coming from */	    \
-	type##_SET_KSTACK;		/* get special stack if necessary */\
+	level##_SET_KSTACK;		/* get special stack if necessary */\
 	andi.	r10,r11,MSR_PR;		/* save stack pointer */	    \
 	beq	1f;			/* branch around if supervisor */   \
 	ld	r1,PACAKSAVE(r13);	/* get kernel stack coming from usr */\
@@ -76,17 +76,20 @@
 #define SPRN_MC_SRR0	SPRN_MCSRR0
 #define SPRN_MC_SRR1	SPRN_MCSRR1
 
+#define SPRN_GUEST_SRR0	SPRN_GSRR0
+#define SPRN_GUEST_SRR1	SPRN_GSRR1
+
 #define NORMAL_EXCEPTION_PROLOG(n, addition)				    \
-	EXCEPTION_PROLOG(n, GEN, addition##_GEN)
+	EXCEPTION_PROLOG(n, GEN, GEN, addition##_GEN)
 
 #define CRIT_EXCEPTION_PROLOG(n, addition)				    \
-	EXCEPTION_PROLOG(n, CRIT, addition##_CRIT)
+	EXCEPTION_PROLOG(n, CRIT, CRIT, addition##_CRIT)
 
 #define DBG_EXCEPTION_PROLOG(n, addition)				    \
-	EXCEPTION_PROLOG(n, DBG, addition##_DBG)
+	EXCEPTION_PROLOG(n, DBG, DBG, addition##_DBG)
 
 #define MC_EXCEPTION_PROLOG(n, addition)				    \
-	EXCEPTION_PROLOG(n, MC, addition##_MC)
+	EXCEPTION_PROLOG(n, MC, MC, addition##_MC)
 
 
 /* Variants of the "addition" argument for the prolog
@@ -228,7 +231,7 @@ exc_##n##_bad_stack:							    \
 	std	r7,TI_LOCAL_FLAGS(r11);					\
 1:
 
-
+/* Use for interrupts that should be masked by soft-EE */
 #define MASKABLE_EXCEPTION(trapnum, label, hdlr, ack)			\
 	START_EXCEPTION(label);						\
 	NORMAL_EXCEPTION_PROLOG(trapnum, PROLOG_ADDITION_MASKABLE)	\
@@ -476,11 +479,43 @@ kernel_dbg_exc:
 //	b	ret_from_crit_except
 	b	.
 
-	MASKABLE_EXCEPTION(0x2c0, guest_doorbell, .unknown_exception, ACK_NONE)
-	MASKABLE_EXCEPTION(0x2e0, guest_doorbell_crit, .unknown_exception, ACK_NONE)
-	MASKABLE_EXCEPTION(0x310, hypercall, .unknown_exception, ACK_NONE)
-	MASKABLE_EXCEPTION(0x320, ehpriv, .unknown_exception, ACK_NONE)
+	START_EXCEPTION(guest_doorbell);
+	EXCEPTION_PROLOG(0x2c0, GEN, GUEST, PROLOG_ADDITION_NONE_GEN)
+	EXCEPTION_COMMON(0x2c0, PACA_EXGEN, INTS_DISABLE_ALL)
+	addi	r3,r1,STACK_FRAME_OVERHEAD
+	bl	.save_nvgprs
+	bl	.unknown_exception
+	b	.ret_from_except
+
+	/*
+	 * Not really critical as far as host kernel exception nesting is
+	 * concerned, but uses crit registers.
+	 */
+	START_EXCEPTION(guest_doorbell_crit);
+	EXCEPTION_PROLOG(0x2e0, GEN, CRIT, PROLOG_ADDITION_NONE_GEN)
+	EXCEPTION_COMMON(0x2e0, PACA_EXGEN, INTS_DISABLE_ALL)
+	addi	r3,r1,STACK_FRAME_OVERHEAD
+	bl	.save_nvgprs
+	bl	.unknown_exception
+	b	.ret_from_except
+
+	START_EXCEPTION(hypercall);
+	NORMAL_EXCEPTION_PROLOG(0x310, PROLOG_ADDITION_NONE)
+	EXCEPTION_COMMON(0x310, PACA_EXGEN, INTS_KEEP)
+	addi	r3,r1,STACK_FRAME_OVERHEAD
+	bl	.save_nvgprs
+	INTS_RESTORE_HARD
+	bl	.unknown_exception
+	b	.ret_from_except
 
+	START_EXCEPTION(ehpriv);
+	NORMAL_EXCEPTION_PROLOG(0x320, PROLOG_ADDITION_NONE)
+	EXCEPTION_COMMON(0x320, PACA_EXGEN, INTS_KEEP)
+	addi	r3,r1,STACK_FRAME_OVERHEAD
+	bl	.save_nvgprs
+	INTS_RESTORE_HARD
+	bl	.unknown_exception
+	b	.ret_from_except
 
 /*
  * An interrupt came in while soft-disabled; clear EE in SRR1,
-- 
1.7.4.1

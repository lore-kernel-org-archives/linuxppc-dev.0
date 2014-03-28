Return-Path: <mikey@neuling.org>
From: Michael Neuling <mikey@neuling.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [PATCH 3/3] powerpc/tm: Add checking to treclaim/trechkpt
Date: Fri, 28 Mar 2014 16:40:34 +1100
Message-Id: <1395985234-27281-3-git-send-email-mikey@neuling.org>
In-Reply-To: <1395985234-27281-1-git-send-email-mikey@neuling.org>
References: <1395985234-27281-1-git-send-email-mikey@neuling.org>
Cc: linuxppc-dev@lists.ozlabs.org, Michael Neuling <mikey@neuling.org>,
 Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

If we do a treclaim and we are not in TM suspend mode, it results in a TM bad
thing (ie. a 0x700 program check).  Similarly if we do a trechkpt and we have
an active transaction or TEXASR Failure Summary (FS) is not set, we also take a
TM bad thing.

This should never happen, but if it does (ie. a kernel bug), the cause is
almost impossible to debug as the GPR state is mostly userspace and hence we
don't get a call chain.

This adds some checks in these cases case a BUG_ON() (in asm) in case we ever
hit these cases.  It moves the register saving around to preserve r1 till later
also.

Signed-off-by: Michael Neuling <mikey@neuling.org>
---
 arch/powerpc/include/asm/reg.h |  1 +
 arch/powerpc/kernel/tm.S       | 38 +++++++++++++++++++++++++++++++++++---
 2 files changed, 36 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/include/asm/reg.h b/arch/powerpc/include/asm/reg.h
index 1a36b8e..c09627d 100644
--- a/arch/powerpc/include/asm/reg.h
+++ b/arch/powerpc/include/asm/reg.h
@@ -214,6 +214,7 @@
 #define SPRN_TFIAR	0x81	/* Transaction Failure Inst Addr   */
 #define SPRN_TEXASR	0x82	/* Transaction EXception & Summary */
 #define SPRN_TEXASRU	0x83	/* ''	   ''	   ''	 Upper 32  */
+#define   TEXASR_FS     __MASK(63-36) /* TEXASR Failure Summary */
 #define SPRN_TFHAR	0x80	/* Transaction Failure Handler Addr */
 #define SPRN_CTRLF	0x088
 #define SPRN_CTRLT	0x098
diff --git a/arch/powerpc/kernel/tm.S b/arch/powerpc/kernel/tm.S
index 0535c7f..508c54b 100644
--- a/arch/powerpc/kernel/tm.S
+++ b/arch/powerpc/kernel/tm.S
@@ -10,6 +10,7 @@
 #include <asm/ppc-opcode.h>
 #include <asm/ptrace.h>
 #include <asm/reg.h>
+#include <asm/bug.h>
 
 #ifdef CONFIG_VSX
 /* See fpu.S, this is borrowed from there */
@@ -175,6 +176,13 @@ dont_backup_vec:
 	stfd    fr0,FPSTATE_FPSCR(r7)
 
 dont_backup_fp:
+	/* Do sanity check on MSR to make sure we are suspended */
+	li	r7, (MSR_TS_S)@higher
+	srdi	r6, r14, 32
+	and	r6, r6, r7
+1:	tdeqi   r6, 0
+	EMIT_BUG_ENTRY 1b,__FILE__,__LINE__,0
+
 	/* The moment we treclaim, ALL of our GPRs will switch
 	 * to user register state.  (FPRs, CCR etc. also!)
 	 * Use an sprg and a tm_scratch in the PACA to shuffle.
@@ -383,12 +391,10 @@ restore_gprs:
 	/* ******************** CR,LR,CCR,MSR ********** */
 	ld	r4, _CTR(r7)
 	ld	r5, _LINK(r7)
-	ld	r6, _CCR(r7)
 	ld	r8, _XER(r7)
 
 	mtctr	r4
 	mtlr	r5
-	mtcr	r6
 	mtxer	r8
 
 	/* ******************** TAR ******************** */
@@ -404,7 +410,8 @@ restore_gprs:
 	li	r4, 0
 	mtmsrd	r4, 1
 
-	REST_4GPRS(0, r7)			/* GPR0-3 */
+	REST_GPR(0, r7)				/* GPR0 */
+	REST_2GPRS(2, r7)			/* GPR2-3 */
 	REST_GPR(4, r7)				/* GPR4 */
 	REST_4GPRS(8, r7)			/* GPR8-11 */
 	REST_2GPRS(12, r7)			/* GPR12-13 */
@@ -416,6 +423,31 @@ restore_gprs:
 	mtspr	SPRN_DSCR, r5
 	mtspr	SPRN_PPR, r6
 
+	/* Do final sanity check on TEXASR to make sure FS is set.  Do this
+	 * here before we load up the userspace r1 so any bugs we hit will get
+	 * a call chain */
+	mfspr	r5, SPRN_TEXASR
+	srdi	r5, r5, 16
+	li	r6, (TEXASR_FS)@h
+	and	r6, r6, r5
+1:	tdeqi	r6, 0
+	EMIT_BUG_ENTRY 1b,__FILE__,__LINE__,0
+
+	/* Do final sanity check on MSR to make sure we are not transactional
+	 * or suspended
+	 */
+	mfmsr   r6
+	li	r5, (MSR_TS_MASK)@higher
+	srdi	r6, r6, 32
+	and	r6, r6, r5
+1:	tdnei   r6, 0
+	EMIT_BUG_ENTRY 1b,__FILE__,__LINE__,0
+
+	/* Restore CR */
+	ld	r6, _CCR(r7)
+	mtcr    r6
+
+	REST_GPR(1, r7)				/* GPR1 */
 	REST_GPR(5, r7)				/* GPR5-7 */
 	REST_GPR(6, r7)
 	ld	r7, GPR7(r7)
-- 
1.8.3.2

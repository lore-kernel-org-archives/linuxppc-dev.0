Return-Path: <mikey@neuling.org>
From: Michael Neuling <mikey@neuling.org>
To: benh@kernel.crashing.org
MIME-Version: 1.0
Subject: [PATCH] powerpc/tm: Clear MSR RI in non-recoverable TM code
Date: Fri, 28 Jun 2013 18:17:09 +1000
Message-ID: <28318.1372407429@ale.ozlabs.ibm.com>
Cc: Linux PPC dev <linuxppc-dev@ozlabs.org>, Paul Mackerras <paulus@samba.org>,
 anton@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

When we treclaim and trecheckpoint there's an unavoidable period when r1
will not be a valid kernel stack pointer.

This patch clears the MSR recoverable interrupt (RI) bit over these
regions to indicate we have an invalid kernel stack pointer.

For treclaim, the region over which we clear MSR RI is larger than
required to avoid the need for an extra costly mtmsrd.

Thanks to Paulus for suggesting this change.

Signed-off-by: Michael Neuling <mikey@neuling.org>

diff --git a/arch/powerpc/kernel/tm.S b/arch/powerpc/kernel/tm.S
index 2da67e7..51be8fb 100644
--- a/arch/powerpc/kernel/tm.S
+++ b/arch/powerpc/kernel/tm.S
@@ -112,9 +112,18 @@ _GLOBAL(tm_reclaim)
 	std	r3, STACK_PARAM(0)(r1)
 	SAVE_NVGPRS(r1)
 
+	/* We need to setup MSR for VSX register save instructions.  Here we
+	 * also clear the MSR RI since when we do the treclaim, we won't have a
+	 * valid kernel pointer for a while.  We clear RI here as it avoids
+	 * adding another mtmsr closer to the treclaim.  This makes the region
+	 * maked as non-recoverable wider than it needs to be but it saves on
+	 * inserting another mtmsrd later.
+	 */
 	mfmsr	r14
 	mr	r15, r14
 	ori	r15, r15, MSR_FP
+	li	r16, MSR_RI
+	andc	r15, r15, r16
 	oris	r15, r15, MSR_VEC@h
 #ifdef CONFIG_VSX
 	BEGIN_FTR_SECTION
@@ -349,9 +358,10 @@ restore_gprs:
 	mtcr	r5
 	mtxer	r6
 
-	/* MSR and flags:  We don't change CRs, and we don't need to alter
-	 * MSR.
+	/* Clear the MSR RI since we are about to change R1.  EE is already off
 	 */
+	li	r4, 0
+	mtmsrd	r4, 1
 
 	REST_4GPRS(0, r7)			/* GPR0-3 */
 	REST_GPR(4, r7)				/* GPR4-6 */
@@ -377,6 +387,10 @@ restore_gprs:
 	GET_PACA(r13)
 	GET_SCRATCH0(r1)
 
+	/* R1 is restored, so we are recoverable again.  EE is still off */
+	li	r4, MSR_RI
+	mtmsrd	r4, 1
+
 	REST_NVGPRS(r1)
 
 	addi    r1, r1, TM_FRAME_SIZE

Return-Path: <joakim.tjernlund@transmode.se>
Received: from gw1.transmode.se (gw1.transmode.se [195.58.98.146])
 (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id AFEA1B6F95
 for <linuxppc-dev@ozlabs.org>; Mon, 10 Oct 2011 22:30:33 +1100 (EST)
From: Joakim Tjernlund <Joakim.Tjernlund@transmode.se>
To: linuxppc-dev <linuxppc-dev@ozlabs.org>,
 Scott Wood <scottwood@freescale.com>, Willy Tarreau <w@1wt.eu>,
 Dan Malek <ppc6dev@digitaldans.com>
Subject: [PATCH 02/14] 8xx: Tag DAR with 0x00f0 to catch buggy instructions.
Date: Mon, 10 Oct 2011 13:30:08 +0200
Message-Id: <1318246220-4839-3-git-send-email-Joakim.Tjernlund@transmode.se>
In-Reply-To: <1318246220-4839-1-git-send-email-Joakim.Tjernlund@transmode.se>
References: <1318246220-4839-1-git-send-email-Joakim.Tjernlund@transmode.se>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

dcbz, dcbf, dcbi, dcbst and icbi do not set DAR when they
cause a DTLB Error. Dectect this by tagging DAR with 0x00f0
at every exception exit that modifies DAR.
This also fixes MachineCheck to pass DAR and DSISR as well.

Signed-off-by: Joakim Tjernlund <Joakim.Tjernlund@transmode.se>
---
 arch/ppc/kernel/head_8xx.S |   18 +++++++++++++++++-
 1 files changed, 17 insertions(+), 1 deletions(-)

diff --git a/arch/ppc/kernel/head_8xx.S b/arch/ppc/kernel/head_8xx.S
index ba05a57..57858ce 100644
--- a/arch/ppc/kernel/head_8xx.S
+++ b/arch/ppc/kernel/head_8xx.S
@@ -197,7 +197,17 @@ label:						\
 	STD_EXCEPTION(0x100, Reset, UnknownException)
 
 /* Machine check */
-	STD_EXCEPTION(0x200, MachineCheck, MachineCheckException)
+	. = 0x200
+MachineCheck:
+	EXCEPTION_PROLOG
+	mfspr	r20,DSISR
+	stw	r20,_DSISR(r21)
+	mfspr	r20,DAR
+	stw	r20,_DAR(r21)
+	li	r20,0x00f0
+	mtspr	DAR,r20	/* Tag DAR */
+	addi	r3,r1,STACK_FRAME_OVERHEAD
+	FINISH_EXCEPTION(MachineCheckException)
 
 /* Data access exception.
  * This is "never generated" by the MPC8xx.  We jump to it for other
@@ -211,6 +221,8 @@ DataAccess:
 	mr	r5,r20
 	mfspr	r4,DAR
 	stw	r4,_DAR(r21)
+	li	r20,0x00f0
+	mtspr	DAR,r20	/* Tag DAR */
 	addi	r3,r1,STACK_FRAME_OVERHEAD
 	li	r20,MSR_KERNEL
 	rlwimi	r20,r23,0,16,16		/* copy EE bit from saved MSR */
@@ -249,6 +261,8 @@ Alignment:
 	EXCEPTION_PROLOG
 	mfspr	r4,DAR
 	stw	r4,_DAR(r21)
+	li	r20,0x00f0
+	mtspr	DAR,r20	/* Tag DAR */
 	mfspr	r5,DSISR
 	stw	r5,_DSISR(r21)
 	addi	r3,r1,STACK_FRAME_OVERHEAD
@@ -433,6 +447,7 @@ DataStoreTLBMiss:
 	 * of the MMU.
 	 */
 2:	li	r21, 0x00f0
+	mtspr	DAR, r21	/* Tag DAR */
 	rlwimi	r20, r21, 0, 24, 28	/* Set 24-27, clear 28 */
 	DO_8xx_CPU6(0x3d80, r3)
 	mtspr	MD_RPN, r20	/* Update TLB entry */
@@ -543,6 +558,7 @@ DataTLBError:
 	 * of the MMU.
 	 */
 	li	r21, 0x00f0
+	mtspr	DAR, r21	/* Tag DAR */
 	rlwimi	r20, r21, 0, 24, 28	/* Set 24-27, clear 28 */
 	DO_8xx_CPU6(0x3d80, r3)
 	mtspr	MD_RPN, r20	/* Update TLB entry */
-- 
1.7.3.4

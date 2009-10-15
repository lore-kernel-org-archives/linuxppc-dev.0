Return-Path: <joakim.tjernlund@transmode.com>
Received: from gw1.transmode.se (gw1.transmode.se [213.115.205.20])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id D7874B7B8C
	for <linuxppc-dev@ozlabs.org>; Thu, 15 Oct 2009 20:04:34 +1100 (EST)
From: Joakim Tjernlund <Joakim.Tjernlund@transmode.se>
To: Scott Wood <scottwood@freescale.com>, Rex Feany <RFeany@mrv.com>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	"linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
Subject: [PATCH 3/8] 8xx: Tag DAR with 0x00f0 to catch buggy instructions.
Date: Thu, 15 Oct 2009 11:04:21 +0200
Message-Id: <1255597466-30976-4-git-send-email-Joakim.Tjernlund@transmode.se>
In-Reply-To: <1255597466-30976-3-git-send-email-Joakim.Tjernlund@transmode.se>
References: <1255597466-30976-1-git-send-email-Joakim.Tjernlund@transmode.se>
	<1255597466-30976-2-git-send-email-Joakim.Tjernlund@transmode.se>
	<1255597466-30976-3-git-send-email-Joakim.Tjernlund@transmode.se>
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
Test for DAR=0x00f0 in DataTLBError and bail
to handle_page_fault().
---
 arch/powerpc/kernel/head_8xx.S |   15 ++++++++++++++-
 1 files changed, 14 insertions(+), 1 deletions(-)

diff --git a/arch/powerpc/kernel/head_8xx.S b/arch/powerpc/kernel/head_8xx.S
index 2011230..bca22fa 100644
--- a/arch/powerpc/kernel/head_8xx.S
+++ b/arch/powerpc/kernel/head_8xx.S
@@ -206,6 +206,8 @@ MachineCheck:
 	EXCEPTION_PROLOG
 	mfspr r4,SPRN_DAR
 	stw r4,_DAR(r11)
+	li r5,0x00f0
+	mtspr SPRN_DAR,r5	/* Tag DAR, to be used in DTLB Error */
 	mfspr r5,SPRN_DSISR
 	stw r5,_DSISR(r11)
 	addi r3,r1,STACK_FRAME_OVERHEAD
@@ -222,6 +224,8 @@ DataAccess:
 	stw	r10,_DSISR(r11)
 	mr	r5,r10
 	mfspr	r4,SPRN_DAR
+	li	r10,0x00f0
+	mtspr	SPRN_DAR,r10	/* Tag DAR, to be used in DTLB Error */
 	EXC_XFER_EE_LITE(0x300, handle_page_fault)
 
 /* Instruction access exception.
@@ -244,6 +248,8 @@ Alignment:
 	EXCEPTION_PROLOG
 	mfspr	r4,SPRN_DAR
 	stw	r4,_DAR(r11)
+	li	r5,0x00f0
+	mtspr	SPRN_DAR,r5	/* Tag DAR, to be used in DTLB Error */
 	mfspr	r5,SPRN_DSISR
 	stw	r5,_DSISR(r11)
 	addi	r3,r1,STACK_FRAME_OVERHEAD
@@ -445,6 +451,7 @@ DataStoreTLBMiss:
 	 * of the MMU.
 	 */
 2:	li	r11, 0x00f0
+	mtspr	SPRN_DAR,r11	/* Tag DAR */
 	rlwimi	r10, r11, 0, 24, 28	/* Set 24-27, clear 28 */
 	DO_8xx_CPU6(0x3d80, r3)
 	mtspr	SPRN_MD_RPN, r10	/* Update TLB entry */
@@ -485,6 +492,10 @@ DataTLBError:
 	stw	r10, 0(r0)
 	stw	r11, 4(r0)
 
+	mfspr	r10, SPRN_DAR
+	cmpwi	cr0, r10, 0x00f0
+	beq-	2f	/* must be a buggy dcbX, icbi insn. */
+
 	mfspr	r11, SPRN_DSISR
 	andis.	r11, r11, 0x4800	/* !translation or protection */
 	bne	2f	/* branch if either is set */
@@ -508,7 +519,8 @@ DataTLBError:
 	 * are initialized in mapin_ram().  This will avoid the problem,
 	 * assuming we only use the dcbi instruction on kernel addresses.
 	 */
-	mfspr	r10, SPRN_DAR
+
+	/* DAR is in r10 already */
 	rlwinm	r11, r10, 0, 0, 19
 	ori	r11, r11, MD_EVALID
 	mfspr	r10, SPRN_M_CASID
@@ -550,6 +562,7 @@ DataTLBError:
 	 * of the MMU.
 	 */
 	li	r11, 0x00f0
+	mtspr	SPRN_DAR,r11	/* Tag DAR */
 	rlwimi	r10, r11, 0, 24, 28	/* Set 24-27, clear 28 */
 	DO_8xx_CPU6(0x3d80, r3)
 	mtspr	SPRN_MD_RPN, r10	/* Update TLB entry */
-- 
1.6.4.4

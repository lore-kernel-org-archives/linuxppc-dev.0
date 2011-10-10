Return-Path: <joakim.tjernlund@transmode.se>
Received: from gw1.transmode.se (gw1.transmode.se [195.58.98.146])
 (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id B4712B70BD
 for <linuxppc-dev@ozlabs.org>; Mon, 10 Oct 2011 22:30:34 +1100 (EST)
From: Joakim Tjernlund <Joakim.Tjernlund@transmode.se>
To: linuxppc-dev <linuxppc-dev@ozlabs.org>,
 Scott Wood <scottwood@freescale.com>, Willy Tarreau <w@1wt.eu>,
 Dan Malek <ppc6dev@digitaldans.com>
Subject: [PATCH 03/14] 8xx: invalidate non present TLBs
Date: Mon, 10 Oct 2011 13:30:09 +0200
Message-Id: <1318246220-4839-4-git-send-email-Joakim.Tjernlund@transmode.se>
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

8xx sometimes need to load a invalid/non-present TLBs in
it DTLB asm handler.
These must be invalidated separately as 8xx MMU don't.

Signed-off-by: Joakim Tjernlund <Joakim.Tjernlund@transmode.se>
---
 arch/ppc/kernel/head_8xx.S |   12 ++++++++++--
 1 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/arch/ppc/kernel/head_8xx.S b/arch/ppc/kernel/head_8xx.S
index 57858ce..b3aff21 100644
--- a/arch/ppc/kernel/head_8xx.S
+++ b/arch/ppc/kernel/head_8xx.S
@@ -221,7 +221,11 @@ DataAccess:
 	mr	r5,r20
 	mfspr	r4,DAR
 	stw	r4,_DAR(r21)
-	li	r20,0x00f0
+	/* invalidate ~PRESENT TLBs, 8xx MMU don't do this */
+	andis.	r20,r5,0x4000
+	beq+	1f
+	tlbie	r4
+1:	li	r20,0x00f0
 	mtspr	DAR,r20	/* Tag DAR */
 	addi	r3,r1,STACK_FRAME_OVERHEAD
 	li	r20,MSR_KERNEL
@@ -238,7 +242,11 @@ InstructionAccess:
 	addi	r3,r1,STACK_FRAME_OVERHEAD
 	mr	r4,r22
 	mr	r5,r23
-	li	r20,MSR_KERNEL
+	/* invalidate ~PRESENT TLBs, 8xx MMU don't do this */
+	andis.	r20,r5,0x4000
+	beq+	1f
+	tlbie	r4
+1:	li	r20,MSR_KERNEL
 	rlwimi	r20,r23,0,16,16		/* copy EE bit from saved MSR */
 	FINISH_EXCEPTION(do_page_fault)
 
-- 
1.7.3.4

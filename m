Return-Path: <joakim.tjernlund@transmode.se>
Received: from gw1.transmode.se (gw1.transmode.se [195.58.98.146])
	(using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 9EB50B70A1
	for <linuxppc-dev@ozlabs.org>; Wed, 15 Jun 2011 00:05:41 +1000 (EST)
From: Joakim Tjernlund <Joakim.Tjernlund@transmode.se>
To: Willy Tarreau <w@1wt.eu>, Scott Wood <scottwood@freescale.com>,
	linuxppc-dev <linuxppc-dev@ozlabs.org>
Subject: [PATCH 15/15] 8xx: Optimize TLB Miss handlers
Date: Tue, 14 Jun 2011 15:55:00 +0200
Message-Id: <1308059700-10839-16-git-send-email-Joakim.Tjernlund@transmode.se>
In-Reply-To: <1308059700-10839-1-git-send-email-Joakim.Tjernlund@transmode.se>
References: <1308059700-10839-1-git-send-email-Joakim.Tjernlund@transmode.se>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Only update pte w.r.t ACCESSED if it isn't already set
Wrap ACCESSED with #ifndef NO_SWAP for too ease optimization.

Signed-off-by: Joakim Tjernlund <Joakim.Tjernlund@transmode.se>
---
 arch/ppc/kernel/head_8xx.S |   11 +++++++++--
 1 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/arch/ppc/kernel/head_8xx.S b/arch/ppc/kernel/head_8xx.S
index 7f9e647..8f50ffb 100644
--- a/arch/ppc/kernel/head_8xx.S
+++ b/arch/ppc/kernel/head_8xx.S
@@ -382,10 +382,14 @@ InstructionTLBMiss:
 	mfspr	r21, MD_TWC	/* ....and get the pte address */
 	lwz	r20, 0(r21)	/* Get the pte */
 
-#if 1
+#ifndef NO_SWAP
 	/* if !swap, you can delete this */
+	andi.	r21, r20, _PAGE_ACCESSED	/* test ACCESSED bit */
+	bne+	4f		/* Branch if set */
+	mfspr	r21, MD_TWC	/* get the pte address */
 	rlwimi	r20, r20, 5, _PAGE_PRESENT<<5	/* Copy PRESENT to ACCESSED */
 	stw	r20, 0(r21)	/* Update pte */
+4:
 #endif
 	/* The Linux PTE won't go exactly into the MMU TLB.
 	 * Software indicator bits 21 and 28 must be clear.
@@ -455,11 +459,14 @@ DataStoreTLBMiss:
 	DO_8xx_CPU6(0x3b80, r3)
 	mtspr	MD_TWC, r21
 
-#if 1
+#ifndef NO_SWAP
 	/* if !swap, you can delete this */
+	andi.	r21, r20, _PAGE_ACCESSED	/* test ACCESSED bit */
+	bne+	4f		/* Branch if set */
 	mfspr	r21, MD_TWC	/* get the pte address */
 	rlwimi	r20, r20, 5, _PAGE_PRESENT<<5	/* Copy PRESENT to ACCESSED */
 	stw	r20, 0(r21)	/* Update pte */
+4:
 #endif
 
 	/* Honour kernel RO, User NA */
-- 
1.7.3.4

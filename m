Return-Path: <joakim.tjernlund@transmode.se>
Received: from gw1.transmode.se (gw1.transmode.se [195.58.98.146])
 (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 74AC2B7225
 for <linuxppc-dev@ozlabs.org>; Mon, 10 Oct 2011 22:38:40 +1100 (EST)
From: Joakim Tjernlund <Joakim.Tjernlund@transmode.se>
To: Dan Malek <ppc6dev@digitaldans.com>,
 linuxppc-dev <linuxppc-dev@ozlabs.org>,
 Scott Wood <scottwood@freescale.com>, Willy Tarreau <w@1wt.eu>
Subject: [PATCH 2/3] 8xx: Support LARGE pages in TLB code.
Date: Mon, 10 Oct 2011 13:38:33 +0200
Message-Id: <1318246714-5015-3-git-send-email-Joakim.Tjernlund@transmode.se>
In-Reply-To: <1318246714-5015-1-git-send-email-Joakim.Tjernlund@transmode.se>
References: <1318246714-5015-1-git-send-email-Joakim.Tjernlund@transmode.se>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


Signed-off-by: Joakim Tjernlund <Joakim.Tjernlund@transmode.se>
---
 arch/ppc/kernel/head_8xx.S |   22 +++++++++++++++-------
 1 files changed, 15 insertions(+), 7 deletions(-)

diff --git a/arch/ppc/kernel/head_8xx.S b/arch/ppc/kernel/head_8xx.S
index 8e3fe40..439e7f2 100644
--- a/arch/ppc/kernel/head_8xx.S
+++ b/arch/ppc/kernel/head_8xx.S
@@ -368,15 +368,19 @@ InstructionTLBMiss:
 	 * for this "segment."
 	 */
 	tophys(r21,r21)
-	ori	r21,r21,1		/* Set valid bit */
-	DO_8xx_CPU6(0x2b80, r3)
-	mtspr	MI_TWC, r21	/* Set segment attributes */
 	beq-	2f		/* If zero, don't try to find a pte */
 	DO_8xx_CPU6(0x3b80, r3)
 	mtspr	MD_TWC, r21	/* Load pte table base address */
-	mfspr	r21, MD_TWC	/* ....and get the pte address */
-	lwz	r20, 0(r21)	/* Get the pte */
+	mfspr	r20, MD_TWC	/* ....and get the pte address */
+	lwz	r20, 0(r20)	/* Get the pte */
+
+	ori	r21, r21, MI_SVALID	/* Set valid bit */
+	/* Copy PSE to PS bits(8MB) */
+	rlwimi	r21, r20, 0, _PAGE_PSE
+	rlwimi	r21, r20, 32-1, _PAGE_PSE>>1
 
+	DO_8xx_CPU6(0x2b80, r3)
+	mtspr	MI_TWC, r21	/* Set segment attributes */
 #ifndef NO_SWAP
 	/* if !swap, you can delete this */
 	andi.	r21, r20, _PAGE_ACCESSED	/* test ACCESSED bit */
@@ -446,7 +450,9 @@ DataStoreTLBMiss:
 	 * this into the Linux pgd/pmd and load it in the operation
 	 * above.
 	 */
-	rlwimi	r21, r20, 0, _PAGE_GUARDED
+	rlwimi	r21, r20, 0, _PAGE_GUARDED | _PAGE_PSE
+	/* Copy PSE to PS bits(8MB), combine with GUARDED above */
+	rlwimi	r21, r20, 32-1, _PAGE_PSE>>1
 	/* Insert the WriteThru flag into the TWC from the Linux PTE.
 	 * It is bit 25 in the Linux PTE and bit 30 in the TWC
 	 */
@@ -589,7 +595,9 @@ DARFixed:
 	/* Insert the Guarded flag into the TWC from the Linux PTE.
 	 * It is bit 27 of both the Linux PTE and the TWC
 	 */
-	rlwimi	r21, r20, 0, _PAGE_GUARDED
+	rlwimi	r21, r20, 0, _PAGE_GUARDED | _PAGE_PSE
+	/* Copy PSE to PS bits(8MB), combine with GUARDED above */
+	rlwimi	r21, r20, 32-1, _PAGE_PSE>>1
 	/* Insert the WriteThru flag into the TWC from the Linux PTE.
 	 * It is bit 25 in the Linux PTE and bit 30 in the TWC
 	 */
-- 
1.7.3.4

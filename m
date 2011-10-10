Return-Path: <joakim.tjernlund@transmode.se>
Received: from gw1.transmode.se (gw1.transmode.se [195.58.98.146])
 (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 1268AB7325
 for <linuxppc-dev@ozlabs.org>; Mon, 10 Oct 2011 22:30:39 +1100 (EST)
From: Joakim Tjernlund <Joakim.Tjernlund@transmode.se>
To: linuxppc-dev <linuxppc-dev@ozlabs.org>,
 Scott Wood <scottwood@freescale.com>, Willy Tarreau <w@1wt.eu>,
 Dan Malek <ppc6dev@digitaldans.com>
Subject: [PATCH 07/14] 8xx: CPU6 errata make DTLB error too big to fit.
Date: Mon, 10 Oct 2011 13:30:13 +0200
Message-Id: <1318246220-4839-8-git-send-email-Joakim.Tjernlund@transmode.se>
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

branch to common code in DTLB Miss instead.

Signed-off-by: Joakim Tjernlund <Joakim.Tjernlund@transmode.se>
---
 arch/ppc/kernel/head_8xx.S |   23 ++---------------------
 1 files changed, 2 insertions(+), 21 deletions(-)

diff --git a/arch/ppc/kernel/head_8xx.S b/arch/ppc/kernel/head_8xx.S
index 0891b96..367fec0 100644
--- a/arch/ppc/kernel/head_8xx.S
+++ b/arch/ppc/kernel/head_8xx.S
@@ -469,6 +469,7 @@ DataStoreTLBMiss:
 	 * set.  All other Linux PTE bits control the behavior
 	 * of the MMU.
 	 */
+finish_DTLB:
 2:	li	r21, 0x00f0
 	mtspr	DAR, r21	/* Tag DAR */
 	rlwimi	r20, r21, 0, 24, 28	/* Set 24-27, clear 28 */
@@ -578,27 +579,7 @@ DARFixed:
 	ori	r20, r20, _PAGE_DIRTY|_PAGE_ACCESSED|_PAGE_HWWRITE
 	stw	r20, 0(r21)		/* and update pte in table */
 	xori	r20, r20, _PAGE_RW	/* RW bit is inverted */
-
-	/* The Linux PTE won't go exactly into the MMU TLB.
-	 * Software indicator bits 22 and 28 must be clear.
-	 * Software indicator bits 24, 25, 26, and 27 must be
-	 * set.  All other Linux PTE bits control the behavior
-	 * of the MMU.
-	 */
-	li	r21, 0x00f0
-	mtspr	DAR, r21	/* Tag DAR */
-	rlwimi	r20, r21, 0, 24, 28	/* Set 24-27, clear 28 */
-	DO_8xx_CPU6(0x3d80, r3)
-	mtspr	MD_RPN, r20	/* Update TLB entry */
-
-	mfspr	r20, M_TW	/* Restore registers */
-	lwz	r21, 0(r0)
-	mtcr	r21
-	lwz	r21, 4(r0)
-#ifdef CONFIG_8xx_CPU6
-	lwz	r3, 8(r0)
-#endif
-	rfi
+	b	finish_DTLB
 2:
 	mfspr	r20, M_TW	/* Restore registers */
 	lwz	r21, 0(r0)
-- 
1.7.3.4

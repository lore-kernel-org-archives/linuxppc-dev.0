Return-Path: <joakim.tjernlund@transmode.se>
Received: from gw1.transmode.se (gw1.transmode.se [213.115.205.20])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 26537B71D1
	for <linuxppc-dev@ozlabs.org>; Tue, 11 Jan 2011 08:38:22 +1100 (EST)
From: Joakim Tjernlund <Joakim.Tjernlund@transmode.se>
To: Willy Tarreau <w@1wt.eu>, Scott Wood <scottwood@freescale.com>,
	linuxppc-dev <linuxppc-dev@ozlabs.org>
Subject: [PATCH 09/13] 8xx: Add missing Guarded setting in DTLB Error.
Date: Mon, 10 Jan 2011 22:37:55 +0100
Message-Id: <1294695479-344-10-git-send-email-Joakim.Tjernlund@transmode.se>
In-Reply-To: <1294695479-344-1-git-send-email-Joakim.Tjernlund@transmode.se>
References: <1294695479-344-1-git-send-email-Joakim.Tjernlund@transmode.se>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

only DTLB Miss did set this bit, DTLB Error needs too otherwise
the setting is lost when the page becomes dirty.

Signed-off-by: Joakim Tjernlund <Joakim.Tjernlund@transmode.se>
---
 arch/ppc/kernel/head_8xx.S |   12 +++++++++---
 1 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/arch/ppc/kernel/head_8xx.S b/arch/ppc/kernel/head_8xx.S
index 0aab8ca..2659a1e 100644
--- a/arch/ppc/kernel/head_8xx.S
+++ b/arch/ppc/kernel/head_8xx.S
@@ -565,9 +565,15 @@ DARFixed:
 	ori	r21, r21, 1		/* Set valid bit in physical L2 page */
 	DO_8xx_CPU6(0x3b80, r3)
 	mtspr	MD_TWC, r21		/* Load pte table base address */
-	mfspr	r21, MD_TWC		/* ....and get the pte address */
-	lwz	r20, 0(r21)		/* Get the pte */
-
+	mfspr	r20, MD_TWC		/* ....and get the pte address */
+	lwz	r20, 0(r20)		/* Get the pte */
+	/* Insert the Guarded flag into the TWC from the Linux PTE.
+	 * It is bit 27 of both the Linux PTE and the TWC
+	 */
+	rlwimi	r21, r20, 0, 27, 27
+	DO_8xx_CPU6(0x3b80, r3)
+	mtspr	MD_TWC, r21
+	mfspr	r21, MD_TWC		/* get the pte address again */
 	ori	r20, r20, _PAGE_DIRTY|_PAGE_ACCESSED|_PAGE_HWWRITE
 	stw	r20, 0(r21)		/* and update pte in table */
 	xori	r20, r20, _PAGE_RW	/* RW bit is inverted */
-- 
1.7.3.4

Return-Path: <joakim.tjernlund@transmode.com>
Received: from gw1.transmode.se (gw1.transmode.se [213.115.205.20])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 90B74B7BCA
	for <linuxppc-dev@ozlabs.org>; Thu,  5 Nov 2009 00:38:49 +1100 (EST)
From: Joakim Tjernlund <Joakim.Tjernlund@transmode.se>
To: Scott Wood <scottwood@freescale.com>, Rex Feany <RFeany@mrv.com>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	"linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
Subject: [PATCH 5/8] 8xx: Add missing Guarded setting in DTLB Error.
Date: Wed, 4 Nov 2009 14:38:37 +0100
Message-Id: <1257341920-29277-6-git-send-email-Joakim.Tjernlund@transmode.se>
In-Reply-To: <1257341920-29277-5-git-send-email-Joakim.Tjernlund@transmode.se>
References: <1257341920-29277-1-git-send-email-Joakim.Tjernlund@transmode.se>
	<1257341920-29277-2-git-send-email-Joakim.Tjernlund@transmode.se>
	<1257341920-29277-3-git-send-email-Joakim.Tjernlund@transmode.se>
	<1257341920-29277-4-git-send-email-Joakim.Tjernlund@transmode.se>
	<1257341920-29277-5-git-send-email-Joakim.Tjernlund@transmode.se>
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
 arch/powerpc/kernel/head_8xx.S |   13 ++++++++++---
 1 files changed, 10 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/kernel/head_8xx.S b/arch/powerpc/kernel/head_8xx.S
index 1d8e4e3..18e9901 100644
--- a/arch/powerpc/kernel/head_8xx.S
+++ b/arch/powerpc/kernel/head_8xx.S
@@ -552,9 +552,16 @@ DARFixed:/* Return from dcbx instruction bug workaround, r10 holds value of DAR
 	 */
 	ori	r11, r11, 1		/* Set valid bit in physical L2 page */
 	DO_8xx_CPU6(0x3b80, r3)
-	mtspr	SPRN_MD_TWC, r11		/* Load pte table base address */
-	mfspr	r11, SPRN_MD_TWC		/* ....and get the pte address */
-	lwz	r10, 0(r11)		/* Get the pte */
+	mtspr	SPRN_MD_TWC, r11	/* Load pte table base address */
+	mfspr	r10, SPRN_MD_TWC	/* ....and get the pte address */
+	lwz	r10, 0(r10)		/* Get the pte */
+	/* Insert the Guarded flag into the TWC from the Linux PTE.
+	 * It is bit 27 of both the Linux PTE and the TWC
+	 */
+	rlwimi	r11, r10, 0, 27, 27
+	DO_8xx_CPU6(0x3b80, r3)
+	mtspr	SPRN_MD_TWC, r11
+	mfspr	r11, SPRN_MD_TWC	/* get the pte address again */
 
 	ori	r10, r10, _PAGE_DIRTY | _PAGE_ACCESSED | _PAGE_HWWRITE
 	stw	r10, 0(r11)		/* and update pte in table */
-- 
1.6.4.4

Return-Path: <joakim.tjernlund@transmode.com>
Received: from gw1.transmode.se (gw1.transmode.se [213.115.205.20])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id AD595B7C3D
	for <linuxppc-dev@ozlabs.org>; Mon, 12 Oct 2009 03:35:27 +1100 (EST)
From: Joakim Tjernlund <Joakim.Tjernlund@transmode.se>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	"linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>,
	Rex Feany <RFeany@mrv.com>, Scott Wood <scottwood@freescale.com>
Subject: [PATCH 6/8] 8xx: Add missing Guarded setting in DTLB Error.
Date: Sun, 11 Oct 2009 18:35:10 +0200
Message-Id: <1255278912-8042-7-git-send-email-Joakim.Tjernlund@transmode.se>
In-Reply-To: <1255278912-8042-6-git-send-email-Joakim.Tjernlund@transmode.se>
References: <1255278912-8042-1-git-send-email-Joakim.Tjernlund@transmode.se>
	<1255278912-8042-2-git-send-email-Joakim.Tjernlund@transmode.se>
	<1255278912-8042-3-git-send-email-Joakim.Tjernlund@transmode.se>
	<1255278912-8042-4-git-send-email-Joakim.Tjernlund@transmode.se>
	<1255278912-8042-5-git-send-email-Joakim.Tjernlund@transmode.se>
	<1255278912-8042-6-git-send-email-Joakim.Tjernlund@transmode.se>
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
---
 arch/powerpc/kernel/head_8xx.S |   13 ++++++++++---
 1 files changed, 10 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/kernel/head_8xx.S b/arch/powerpc/kernel/head_8xx.S
index 027856e..371b606 100644
--- a/arch/powerpc/kernel/head_8xx.S
+++ b/arch/powerpc/kernel/head_8xx.S
@@ -552,9 +552,16 @@ DARFix:	/* Return from dcbx instruction bug workaround, r10 holds value of DAR *
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

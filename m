Return-Path: <joakim.tjernlund@transmode.se>
Received: from gw1.transmode.se (gw1.transmode.se [195.58.98.146])
	(using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 62096B7117
	for <linuxppc-dev@ozlabs.org>; Wed, 15 Jun 2011 00:05:42 +1000 (EST)
From: Joakim Tjernlund <Joakim.Tjernlund@transmode.se>
To: Willy Tarreau <w@1wt.eu>, Scott Wood <scottwood@freescale.com>,
	linuxppc-dev <linuxppc-dev@ozlabs.org>
Subject: [PATCH 13/15] 8xx: Use symbolic constants in TLB asm
Date: Tue, 14 Jun 2011 15:54:58 +0200
Message-Id: <1308059700-10839-14-git-send-email-Joakim.Tjernlund@transmode.se>
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

Use the PTE #defines where possible instead of
hardcoded constants.

Signed-off-by: Joakim Tjernlund <Joakim.Tjernlund@transmode.se>
---
 arch/ppc/kernel/head_8xx.S |   12 ++++++------
 1 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/ppc/kernel/head_8xx.S b/arch/ppc/kernel/head_8xx.S
index d701542..a4290b5 100644
--- a/arch/ppc/kernel/head_8xx.S
+++ b/arch/ppc/kernel/head_8xx.S
@@ -442,11 +442,11 @@ DataStoreTLBMiss:
 	 * this into the Linux pgd/pmd and load it in the operation
 	 * above.
 	 */
-	rlwimi	r21, r20, 0, 27, 27
+	rlwimi	r21, r20, 0, _PAGE_GUARDED
 	/* Insert the WriteThru flag into the TWC from the Linux PTE.
 	 * It is bit 25 in the Linux PTE and bit 30 in the TWC
 	 */
-	rlwimi	r21, r20, 32-5, 30, 30
+	rlwimi	r21, r20, 32-5, _PAGE_WRITETHRU>>5
 	DO_8xx_CPU6(0x3b80, r3)
 	mtspr	MD_TWC, r21
 
@@ -460,9 +460,9 @@ DataStoreTLBMiss:
 	/* Honour kernel RO, User NA */
 	/* 0x200 == Extended encoding, bit 22 */
 	/* r20 |=  (r20 & _PAGE_USER) >> 2 */
-	rlwimi	r20, r20, 32-2, 0x200
+	rlwimi	r20, r20, 32-2, _PAGE_USER>>2 /* Copy USER to Encoding */
 	/* r21 =  (r20 & _PAGE_RW) >> 1 */
-	rlwinm	r21, r20, 32-1, 0x200
+	rlwinm	r21, r20, 32-1, _PAGE_RW>>1
 	or	r20, r21, r20
 	/* invert RW and 0x200 bits */
 	xori	r20, r20, _PAGE_RW | 0x200
@@ -582,11 +582,11 @@ DARFixed:
 	/* Insert the Guarded flag into the TWC from the Linux PTE.
 	 * It is bit 27 of both the Linux PTE and the TWC
 	 */
-	rlwimi	r21, r20, 0, 27, 27
+	rlwimi	r21, r20, 0, _PAGE_GUARDED
 	/* Insert the WriteThru flag into the TWC from the Linux PTE.
 	 * It is bit 25 in the Linux PTE and bit 30 in the TWC
 	 */
-	rlwimi	r21, r20, 32-5, 30, 30
+	rlwimi	r21, r20, 32-5, _PAGE_WRITETHRU>>5
 	DO_8xx_CPU6(0x3b80, r3)
 	mtspr	MD_TWC, r21
 	mfspr	r21, MD_TWC		/* get the pte address again */
-- 
1.7.3.4

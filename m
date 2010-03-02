Return-Path: <joakim.tjernlund@transmode.com>
Received: from gw1.transmode.se (gw1.transmode.se [213.115.205.20])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 59567B7D45
	for <linuxppc-dev@ozlabs.org>; Wed,  3 Mar 2010 02:37:22 +1100 (EST)
From: Joakim Tjernlund <Joakim.Tjernlund@transmode.se>
To: linuxppc-dev@ozlabs.org, Scott Wood <scottwood@freescale.com>
Subject: [PATCH 1/4] 8xx: Optimze TLB Miss handlers
Date: Tue, 2 Mar 2010 16:37:09 +0100
Message-Id: <1267544232-14784-2-git-send-email-Joakim.Tjernlund@transmode.se>
In-Reply-To: <1267544232-14784-1-git-send-email-Joakim.Tjernlund@transmode.se>
References: <1267544232-14784-1-git-send-email-Joakim.Tjernlund@transmode.se>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This removes a couple of insn's from the TLB Miss
handlers whithout changing functionality.

Signed-off-by: Joakim Tjernlund <Joakim.Tjernlund@transmode.se>
---
 arch/powerpc/kernel/head_8xx.S |   11 +++--------
 1 files changed, 3 insertions(+), 8 deletions(-)

diff --git a/arch/powerpc/kernel/head_8xx.S b/arch/powerpc/kernel/head_8xx.S
index 3ef743f..ecc4a02 100644
--- a/arch/powerpc/kernel/head_8xx.S
+++ b/arch/powerpc/kernel/head_8xx.S
@@ -343,17 +343,14 @@ InstructionTLBMiss:
 	cmpwi	cr0, r11, _PAGE_ACCESSED | _PAGE_PRESENT
 	bne-	cr0, 2f
 
-	/* Clear PP lsb, 0x400 */
-	rlwinm 	r10, r10, 0, 22, 20
-
 	/* The Linux PTE won't go exactly into the MMU TLB.
-	 * Software indicator bits 22 and 28 must be clear.
+	 * Software indicator bits 21 and 28 must be clear.
 	 * Software indicator bits 24, 25, 26, and 27 must be
 	 * set.  All other Linux PTE bits control the behavior
 	 * of the MMU.
 	 */
 	li	r11, 0x00f0
-	rlwimi	r10, r11, 0, 24, 28	/* Set 24-27, clear 28 */
+	rlwimi	r10, r11, 0, 0x07f8	/* Set 24-27, clear 21-23,28 */
 	DO_8xx_CPU6(0x2d80, r3)
 	mtspr	SPRN_MI_RPN, r10	/* Update TLB entry */
 
@@ -444,9 +441,7 @@ DataStoreTLBMiss:
 
 	/* Honour kernel RO, User NA */
 	/* 0x200 == Extended encoding, bit 22 */
-	/* r11 =  (r10 & _PAGE_USER) >> 2 */
-	rlwinm	r11, r10, 32-2, 0x200
-	or	r10, r11, r10
+	rlwimi	r10, r10, 32-2, 0x200 /* Copy USER to bit 22, 0x200 */
 	/* r11 =  (r10 & _PAGE_RW) >> 1 */
 	rlwinm	r11, r10, 32-1, 0x200
 	or	r10, r11, r10
-- 
1.6.4.4

Return-Path: <joakim.tjernlund@transmode.com>
Received: from gw1.transmode.se (gw1.transmode.se [213.115.205.20])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 01FB9B7CEF
	for <linuxppc-dev@ozlabs.org>; Fri, 26 Feb 2010 19:39:17 +1100 (EST)
Received: from sesr04.transmode.se (sesr04.transmode.se [192.168.201.15])
	by gw1.transmode.se (Postfix) with ESMTP id 65C37650006
	for <linuxppc-dev@ozlabs.org>; Fri, 26 Feb 2010 09:29:55 +0100 (CET)
From: Joakim Tjernlund <Joakim.Tjernlund@transmode.se>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 3/4] 8xx: Don't touch ACCESSED when no SWAP.
Date: Fri, 26 Feb 2010 09:29:42 +0100
Message-Id: <1267172983-28721-4-git-send-email-Joakim.Tjernlund@transmode.se>
In-Reply-To: <1267172983-28721-3-git-send-email-Joakim.Tjernlund@transmode.se>
References: <1267172983-28721-1-git-send-email-Joakim.Tjernlund@transmode.se>
	<1267172983-28721-2-git-send-email-Joakim.Tjernlund@transmode.se>
	<1267172983-28721-3-git-send-email-Joakim.Tjernlund@transmode.se>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Only the swap function cares about the ACCESSED bit in
the pte. Do not waste cycles updateting ACCESSED when swap
is not compiled into the kernel.
---
 arch/powerpc/kernel/head_8xx.S |    6 ++++--
 1 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/kernel/head_8xx.S b/arch/powerpc/kernel/head_8xx.S
index 84ca1d9..6478a96 100644
--- a/arch/powerpc/kernel/head_8xx.S
+++ b/arch/powerpc/kernel/head_8xx.S
@@ -343,10 +343,11 @@ InstructionTLBMiss:
 	mfspr	r11, SPRN_MD_TWC	/* ....and get the pte address */
 	lwz	r10, 0(r11)	/* Get the pte */
 
+#ifdef CONFIG_SWAP
 	andi.	r11, r10, _PAGE_ACCESSED | _PAGE_PRESENT
 	cmpwi	cr0, r11, _PAGE_ACCESSED | _PAGE_PRESENT
 	bne-	cr0, 2f
-
+#endif
 	/* The Linux PTE won't go exactly into the MMU TLB.
 	 * Software indicator bits 21 and 28 must be clear.
 	 * Software indicator bits 24, 25, 26, and 27 must be
@@ -439,10 +440,11 @@ DataStoreTLBMiss:
 	 * r11 = ((r10 & PRESENT) & ((r10 & ACCESSED) >> 5));
 	 * r10 = (r10 & ~PRESENT) | r11;
 	 */
+#ifdef CONFIG_SWAP
 	rlwinm	r11, r10, 32-5, _PAGE_PRESENT
 	and	r11, r11, r10
 	rlwimi	r10, r11, 0, _PAGE_PRESENT
-
+#endif
 	/* Honour kernel RO, User NA */
 	/* 0x200 == Extended encoding, bit 22 */
 	rlwimi	r10, r10, 32-2, 0x200 /* Copy USER to bit 22, 0x200 */
-- 
1.6.4.4

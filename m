Return-Path: <joakim.tjernlund@transmode.com>
Received: from gw1.transmode.se (gw1.transmode.se [213.115.205.20])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 8B1B91008AA
	for <linuxppc-dev@ozlabs.org>; Fri, 20 Nov 2009 21:21:38 +1100 (EST)
From: Joakim Tjernlund <Joakim.Tjernlund@transmode.se>
To: Scott Wood <scottwood@freescale.com>,
	"linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>,
	Rex Feany <RFeany@mrv.com>
Subject: [PATCH 10/10] 8xx: DTLB Miss cleanup
Date: Fri, 20 Nov 2009 11:21:11 +0100
Message-Id: <1258712471-3104-11-git-send-email-Joakim.Tjernlund@transmode.se>
In-Reply-To: <1258712471-3104-10-git-send-email-Joakim.Tjernlund@transmode.se>
References: <1258712471-3104-1-git-send-email-Joakim.Tjernlund@transmode.se>
	<1258712471-3104-2-git-send-email-Joakim.Tjernlund@transmode.se>
	<1258712471-3104-3-git-send-email-Joakim.Tjernlund@transmode.se>
	<1258712471-3104-4-git-send-email-Joakim.Tjernlund@transmode.se>
	<1258712471-3104-5-git-send-email-Joakim.Tjernlund@transmode.se>
	<1258712471-3104-6-git-send-email-Joakim.Tjernlund@transmode.se>
	<1258712471-3104-7-git-send-email-Joakim.Tjernlund@transmode.se>
	<1258712471-3104-8-git-send-email-Joakim.Tjernlund@transmode.se>
	<1258712471-3104-9-git-send-email-Joakim.Tjernlund@transmode.se>
	<1258712471-3104-10-git-send-email-Joakim.Tjernlund@transmode.se>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Use symbolic constant for PRESENT and avoid branching.

Signed-off-by: Joakim Tjernlund <Joakim.Tjernlund@transmode.se>
---
 arch/powerpc/kernel/head_8xx.S |   17 +++++++++++------
 1 files changed, 11 insertions(+), 6 deletions(-)

diff --git a/arch/powerpc/kernel/head_8xx.S b/arch/powerpc/kernel/head_8xx.S
index 36af721..ce327c5 100644
--- a/arch/powerpc/kernel/head_8xx.S
+++ b/arch/powerpc/kernel/head_8xx.S
@@ -438,15 +438,20 @@ DataStoreTLBMiss:
 	 * r11 = ((r10 & PRESENT) & ((r10 & ACCESSED) >> 5));
 	 * r10 = (r10 & ~PRESENT) | r11;
 	 */
-	rlwinm	r11, r10, 32-5, 31, 31
+	rlwinm	r11, r10, 32-5, _PAGE_PRESENT
 	and	r11, r11, r10
-	rlwimi	r10, r11, 0, 31, 31
+	rlwimi	r10, r11, 0, _PAGE_PRESENT
 
 	/* Honour kernel RO, User NA */
-	andi.	r11, r10, _PAGE_USER | _PAGE_RW
-	bne-	cr0, 5f
-	ori	r10,r10, 0x200 /* Extended encoding, bit 22 */
-5:	xori	r10, r10, _PAGE_RW  /* invert RW bit */
+	/* 0x200 == Extended encoding, bit 22 */
+	/* r11 =  (r10 & _PAGE_USER) >> 2 */
+	rlwinm	r11, r10, 32-2, 0x200
+	or	r10, r11, r10
+	/* r11 =  (r10 & _PAGE_RW) >> 1 */
+	rlwinm	r11, r10, 32-1, 0x200
+	or	r10, r11, r10
+	/* invert RW and 0x200 bits */
+	xori	r10, r10, _PAGE_RW | 0x200
 
 	/* The Linux PTE won't go exactly into the MMU TLB.
 	 * Software indicator bits 22 and 28 must be clear.
-- 
1.6.4.4

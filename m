Return-Path: <joakim.tjernlund@transmode.se>
Received: from gw1.transmode.se (gw1.transmode.se [213.115.205.20])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 60D7BB75D9
	for <linuxppc-dev@ozlabs.org>; Tue, 11 Jan 2011 08:38:27 +1100 (EST)
From: Joakim Tjernlund <Joakim.Tjernlund@transmode.se>
To: Willy Tarreau <w@1wt.eu>, Scott Wood <scottwood@freescale.com>,
	linuxppc-dev <linuxppc-dev@ozlabs.org>
Subject: [PATCH 13/13] 8xx: Optimize TLB Miss handlers
Date: Mon, 10 Jan 2011 22:37:59 +0100
Message-Id: <1294695479-344-14-git-send-email-Joakim.Tjernlund@transmode.se>
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

Only update pte w.r.t ACCESSED if it isn't already set

Signed-off-by: Joakim Tjernlund <Joakim.Tjernlund@transmode.se>
---
 arch/ppc/kernel/head_8xx.S |    7 +++++++
 1 files changed, 7 insertions(+), 0 deletions(-)

diff --git a/arch/ppc/kernel/head_8xx.S b/arch/ppc/kernel/head_8xx.S
index 5dbbdb4..75acaa0 100644
--- a/arch/ppc/kernel/head_8xx.S
+++ b/arch/ppc/kernel/head_8xx.S
@@ -376,8 +376,12 @@ InstructionTLBMiss:
 
 #if 1
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
@@ -449,9 +453,12 @@ DataStoreTLBMiss:
 
 #if 1
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

Return-Path: <joakim.tjernlund@transmode.se>
Received: from gw1.transmode.se (gw1.transmode.se [195.58.98.146])
	(using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id B1DF6B6FE3
	for <linuxppc-dev@ozlabs.org>; Wed, 15 Jun 2011 00:05:44 +1000 (EST)
From: Joakim Tjernlund <Joakim.Tjernlund@transmode.se>
To: Willy Tarreau <w@1wt.eu>, Scott Wood <scottwood@freescale.com>,
	linuxppc-dev <linuxppc-dev@ozlabs.org>
Subject: [PATCH 11/15] 8xx: Set correct HW pte flags in DTLB Error too
Date: Tue, 14 Jun 2011 15:54:56 +0200
Message-Id: <1308059700-10839-12-git-send-email-Joakim.Tjernlund@transmode.se>
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

DTLB Error needs to adjust the HW PTE bits as DTLB Miss
does.

Signed-off-by: Joakim Tjernlund <Joakim.Tjernlund@transmode.se>
---
 arch/ppc/kernel/head_8xx.S |    7 ++++++-
 1 files changed, 6 insertions(+), 1 deletions(-)

diff --git a/arch/ppc/kernel/head_8xx.S b/arch/ppc/kernel/head_8xx.S
index a29a011..d701542 100644
--- a/arch/ppc/kernel/head_8xx.S
+++ b/arch/ppc/kernel/head_8xx.S
@@ -592,7 +592,12 @@ DARFixed:
 	mfspr	r21, MD_TWC		/* get the pte address again */
 	ori	r20, r20, _PAGE_DIRTY|_PAGE_ACCESSED|_PAGE_HWWRITE
 	stw	r20, 0(r21)		/* and update pte in table */
-	xori	r20, r20, _PAGE_RW	/* RW bit is inverted */
+	rlwimi	r20, r20, 32-2, _PAGE_USER>>2 /* Copy USER to Encoding */
+	/* r21 =  (r20 & _PAGE_RW) >> 1 */
+	rlwinm	r21, r20, 32-1, _PAGE_RW>>1
+	or	r20, r21, r20
+	/* invert RW and 0x200 bits */
+	xori	r20, r20, _PAGE_RW | 0x200
 	b	finish_DTLB
 2:
 	mfspr	r20, M_TW	/* Restore registers */
-- 
1.7.3.4

Return-Path: <joakim.tjernlund@transmode.se>
Received: from gw1.transmode.se (gw1.transmode.se [195.58.98.146])
 (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 74D3BB743C
 for <linuxppc-dev@ozlabs.org>; Mon, 10 Oct 2011 22:30:42 +1100 (EST)
From: Joakim Tjernlund <Joakim.Tjernlund@transmode.se>
To: linuxppc-dev <linuxppc-dev@ozlabs.org>,
 Scott Wood <scottwood@freescale.com>, Willy Tarreau <w@1wt.eu>,
 Dan Malek <ppc6dev@digitaldans.com>
Subject: [PATCH 10/14] 8xx: Set correct HW pte flags in DTLB Error too
Date: Mon, 10 Oct 2011 13:30:16 +0200
Message-Id: <1318246220-4839-11-git-send-email-Joakim.Tjernlund@transmode.se>
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

DTLB Error needs to adjust the HW PTE bits as DTLB Miss
does.

Signed-off-by: Joakim Tjernlund <Joakim.Tjernlund@transmode.se>
---
 arch/ppc/kernel/head_8xx.S |    7 ++++++-
 1 files changed, 6 insertions(+), 1 deletions(-)

diff --git a/arch/ppc/kernel/head_8xx.S b/arch/ppc/kernel/head_8xx.S
index 402158d..4bcd9b3 100644
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

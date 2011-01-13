Return-Path: <joakim.tjernlund@transmode.se>
Received: from gw1.transmode.se (gw1.transmode.se [213.115.205.20])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id D88C0B70F6
	for <linuxppc-dev@ozlabs.org>; Fri, 14 Jan 2011 09:22:08 +1100 (EST)
From: Joakim Tjernlund <Joakim.Tjernlund@transmode.se>
To: Scott Wood <scottwood@freescale.com>, Willy Tarreau <w@1wt.eu>,
	linuxppc-dev <linuxppc-dev@ozlabs.org>
Subject: [PATCH 3/3] 8xx: Set correct HW pte flags in DTLB Error too
Date: Thu, 13 Jan 2011 23:21:55 +0100
Message-Id: <1294957315-1696-4-git-send-email-Joakim.Tjernlund@transmode.se>
In-Reply-To: <1294957315-1696-1-git-send-email-Joakim.Tjernlund@transmode.se>
References: <1294957315-1696-1-git-send-email-Joakim.Tjernlund@transmode.se>
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
index 7a449d1..6e64681 100644
--- a/arch/ppc/kernel/head_8xx.S
+++ b/arch/ppc/kernel/head_8xx.S
@@ -604,7 +604,12 @@ DARFixed:
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

Return-Path: <MAILER-DAEMON>
Received: from VA3EHSNDR001.bigfish.com
 (va3outboundsmtppool2.messaging.microsoft.com [157.55.133.164])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id E1F8EB6FB9
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Jun 2012 08:02:50 +1000 (EST)
Date: Tue, 12 Jun 2012 17:02:32 -0500
From: Scott Wood <scott@tyr.buserror.net>
To: <benh@kernel.crashing.org>
Subject: [PATCH] powerpc/booke-64: fix tlbsrx. path in bolted tlb handler
Message-ID: <20120612220232.GA17228@tyr.buserror.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Cc: linuxppc-dev@lists.ozlabs.org
Reply-To: scott@tyr.buserror.net
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

It was branching to the cleanup part of the non-bolted handler,
which would have been bad if there were any chips with tlbsrx.
that use the bolted handler.

Signed-off-by: Scott Wood <scott@tyr.buserror.net>
---
 arch/powerpc/mm/tlb_low_64e.S |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/arch/powerpc/mm/tlb_low_64e.S b/arch/powerpc/mm/tlb_low_64e.S
index ff672bd..efe0f33 100644
--- a/arch/powerpc/mm/tlb_low_64e.S
+++ b/arch/powerpc/mm/tlb_low_64e.S
@@ -128,7 +128,7 @@ BEGIN_MMU_FTR_SECTION
 	 */
 	PPC_TLBSRX_DOT(0,r16)
 	ldx	r14,r14,r15		/* grab pgd entry */
-	beq	normal_tlb_miss_done	/* tlb exists already, bail */
+	beq	tlb_miss_done_bolted	/* tlb exists already, bail */
 MMU_FTR_SECTION_ELSE
 	ldx	r14,r14,r15		/* grab pgd entry */
 ALT_MMU_FTR_SECTION_END_IFSET(MMU_FTR_USE_TLBRSRV)
@@ -184,6 +184,7 @@ ALT_MMU_FTR_SECTION_END_IFSET(MMU_FTR_USE_TLBRSRV)
 	mtspr	SPRN_MAS7_MAS3,r15
 	tlbwe
 
+tlb_miss_done_bolted:
 	TLB_MISS_STATS_X(MMSTAT_TLB_MISS_NORM_OK)
 	tlb_epilog_bolted
 	rfi
-- 
1.7.5.4

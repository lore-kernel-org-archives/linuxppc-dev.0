Return-Path: <scottwood@freescale.com>
Received: from na01-by2-obe.outbound.protection.outlook.com
 (mail-by2lp0236.outbound.protection.outlook.com [207.46.163.236])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 76BAF2C0084
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 11 Jan 2014 10:31:11 +1100 (EST)
From: Scott Wood <scottwood@freescale.com>
To: <linuxppc-dev@lists.ozlabs.org>
Subject: [PATCH v2] powerpc/booke-64: fix tlbsrx. path in bolted tlb handler
Date: Fri, 10 Jan 2014 17:30:56 -0600
Message-ID: <1389396656-27813-1-git-send-email-scottwood@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: Scott Wood <scottwood@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Scott Wood <scott@tyr.buserror.net>

It was branching to the cleanup part of the non-bolted handler,
which would have been bad if there were any chips with tlbsrx.
that use the bolted handler.

Signed-off-by: Scott Wood <scottwood@freescale.com>
---
v2: rebase

 arch/powerpc/mm/tlb_low_64e.S | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/mm/tlb_low_64e.S b/arch/powerpc/mm/tlb_low_64e.S
index 75f5d27..16250b1 100644
--- a/arch/powerpc/mm/tlb_low_64e.S
+++ b/arch/powerpc/mm/tlb_low_64e.S
@@ -136,7 +136,7 @@ BEGIN_MMU_FTR_SECTION
 	 */
 	PPC_TLBSRX_DOT(0,R16)
 	ldx	r14,r14,r15		/* grab pgd entry */
-	beq	normal_tlb_miss_done	/* tlb exists already, bail */
+	beq	tlb_miss_done_bolted	/* tlb exists already, bail */
 MMU_FTR_SECTION_ELSE
 	ldx	r14,r14,r15		/* grab pgd entry */
 ALT_MMU_FTR_SECTION_END_IFSET(MMU_FTR_USE_TLBRSRV)
@@ -192,6 +192,7 @@ ALT_MMU_FTR_SECTION_END_IFSET(MMU_FTR_USE_TLBRSRV)
 	mtspr	SPRN_MAS7_MAS3,r15
 	tlbwe
 
+tlb_miss_done_bolted:
 	TLB_MISS_STATS_X(MMSTAT_TLB_MISS_NORM_OK)
 	tlb_epilog_bolted
 	rfi
-- 
1.8.3.2

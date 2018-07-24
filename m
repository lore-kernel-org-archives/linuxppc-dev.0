Return-Path: <bharat.bhushan@nxp.com>
Received: from EUR02-VE1-obe.outbound.protection.outlook.com
 (mail-eopbgr20072.outbound.protection.outlook.com [40.107.2.72])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41ZSVX1GWQzDqRM
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 Jul 2018 16:04:19 +1000 (AEST)
From: Bharat Bhushan <Bharat.Bhushan@nxp.com>
To: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Cc: Bharat Bhushan <Bharat.Bhushan@nxp.com>
Subject: [PATCH] powerpc/e200: Skip tlb1 entries used for kernel mapping
Date: Tue, 24 Jul 2018 11:29:45 +0530
Message-Id: <1532411985-17725-1-git-send-email-Bharat.Bhushan@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

E200 have TLB1 only and it does not have TLB0.
So TLB1 are used for mapping kernel and user-space both.
TLB miss handler for E200 does not consider skipping TLBs
used for kernel mapping. This patch ensures that we skip
tlb1 entries used for kernel mapping (tlbcam_index).

Signed-off-by: Bharat Bhushan <Bharat.Bhushan@nxp.com>
---
 arch/powerpc/kernel/head_fsl_booke.S | 20 ++++++++++++++++++--
 1 file changed, 18 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/kernel/head_fsl_booke.S b/arch/powerpc/kernel/head_fsl_booke.S
index bf4c602..951fb96 100644
--- a/arch/powerpc/kernel/head_fsl_booke.S
+++ b/arch/powerpc/kernel/head_fsl_booke.S
@@ -801,12 +801,28 @@ END_MMU_FTR_SECTION_IFSET(MMU_FTR_BIG_PHYS)
 	/* Round robin TLB1 entries assignment */
 	mfspr	r12, SPRN_MAS0
 
+	/* Get first free tlbcam entry */
+	lis	r11, tlbcam_index@ha
+	lwz	r11, tlbcam_index@l(r11)
+
+	/* Extract MAS0(NV) */
+	andi.	r13, r12, 0xfff
+	cmpw	0, r13, r11
+	blt	0, 5f
+	b	6f
+5:
+	/* When NV is less than first free tlbcam entry, use first free
+	 * tlbcam entry for ESEL and set NV */
+	rlwimi	r12, r11, 16, 4, 15
+	addi	r11, r11, 1
+	rlwimi	r12, r11, 0, 20, 31
+	b	7f
+6:
 	/* Extract TLB1CFG(NENTRY) */
 	mfspr	r11, SPRN_TLB1CFG
 	andi.	r11, r11, 0xfff
 
-	/* Extract MAS0(NV) */
-	andi.	r13, r12, 0xfff
+	/* Set MAS0(NV) for next TLB miss exception */
 	addi	r13, r13, 1
 	cmpw	0, r13, r11
 	addi	r12, r12, 1
-- 
1.9.3

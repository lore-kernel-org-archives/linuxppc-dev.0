Return-Path: <beckyb@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id B3C6EB7C33
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 13 Apr 2010 02:21:58 +1000 (EST)
From: Becky Bruce <beckyb@kernel.crashing.org>
To: galak@kernel.crashing.org, benh@kernel.crashing.org,
	linuxppc-dev@lists.ozlabs.org
Subject: [PATCH V2] fsl_booke: Correct test for MMU_FTR_BIG_PHYS
Date: Mon, 12 Apr 2010 11:21:50 -0500
Message-Id: <1271089310-17607-1-git-send-email-beckyb@kernel.crashing.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The code was looking for this in cpu_features, not mmu_features.  Fix this.

Signed-off-by: Becky Bruce <beckyb@kernel.crashing.org>
---
Switched to mmu_has_feature.....

 arch/powerpc/mm/fsl_booke_mmu.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/mm/fsl_booke_mmu.c b/arch/powerpc/mm/fsl_booke_mmu.c
index c539472..3260fdf 100644
--- a/arch/powerpc/mm/fsl_booke_mmu.c
+++ b/arch/powerpc/mm/fsl_booke_mmu.c
@@ -116,7 +116,7 @@ void loadcam_entry(int idx)
 	mtspr(SPRN_MAS2, TLBCAM[idx].MAS2);
 	mtspr(SPRN_MAS3, TLBCAM[idx].MAS3);
 
-	if (cur_cpu_spec->cpu_features & MMU_FTR_BIG_PHYS)
+	if (mmu_has_feature(MMU_FTR_BIG_PHYS))
 		mtspr(SPRN_MAS7, TLBCAM[idx].MAS7);
 
 	asm volatile("isync;tlbwe;isync" : : : "memory");
@@ -152,7 +152,7 @@ static void settlbcam(int index, unsigned long virt, phys_addr_t phys,
 
 	TLBCAM[index].MAS3 = (phys & MAS3_RPN) | MAS3_SX | MAS3_SR;
 	TLBCAM[index].MAS3 |= ((flags & _PAGE_RW) ? MAS3_SW : 0);
-	if (cur_cpu_spec->cpu_features & MMU_FTR_BIG_PHYS)
+	if (mmu_has_feature(MMU_FTR_BIG_PHYS))
 		TLBCAM[index].MAS7 = (u64)phys >> 32;
 
 #ifndef CONFIG_KGDB /* want user access for breakpoints */
-- 
1.6.0.6

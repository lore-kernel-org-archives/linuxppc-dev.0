Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 14E66B7D4A
	for <linuxppc-dev@ozlabs.org>; Wed, 17 Mar 2010 15:42:01 +1100 (EST)
Received: from localhost (localhost.localdomain [127.0.0.1])
	by gate.crashing.org (8.14.1/8.13.8) with ESMTP id o2H4fuCJ002070
	for <linuxppc-dev@ozlabs.org>; Tue, 16 Mar 2010 23:41:57 -0500
From: Kumar Gala <galak@kernel.crashing.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] powerpc/fsl-booke: Get coherent bit from PTE
Date: Tue, 16 Mar 2010 23:41:56 -0500
Message-Id: <1268800916-14247-1-git-send-email-galak@kernel.crashing.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

We shouldn't be always setting 'M' in the TLB entry since its reasonable
for somethings to be mapped non-coherent.  The PTE should have 'M' set
properly.

Signed-off-by: Kumar Gala <galak@kernel.crashing.org>
---
 arch/powerpc/kernel/head_fsl_booke.S |    3 ---
 1 files changed, 0 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/kernel/head_fsl_booke.S b/arch/powerpc/kernel/head_fsl_booke.S
index 25793bb..a7cf493 100644
--- a/arch/powerpc/kernel/head_fsl_booke.S
+++ b/arch/powerpc/kernel/head_fsl_booke.S
@@ -747,9 +747,6 @@ finish_tlb_load:
 #else
 	rlwimi	r12, r11, 26, 27, 31	/* extract WIMGE from pte */
 #endif
-#ifdef CONFIG_SMP
-	ori	r12, r12, MAS2_M
-#endif
 	mtspr	SPRN_MAS2, r12
 
 #ifdef CONFIG_PTE_64BIT
-- 
1.6.0.6

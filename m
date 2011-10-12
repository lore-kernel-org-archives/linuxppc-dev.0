Return-Path: <beckyb@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 52D00B6F18
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 13 Oct 2011 05:22:08 +1100 (EST)
Received: from localhost (localhost.localdomain [127.0.0.1])
 by gate.crashing.org (8.14.1/8.13.8) with ESMTP id p9CIM4s9030268
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 12 Oct 2011 13:22:05 -0500
From: Becky Bruce <beckyb@kernel.crashing.org>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH] powerpc/fsl-booke: Fix settlbcam for 64-bit
Date: Wed, 12 Oct 2011 13:22:04 -0500
Message-Id: <13184437244040-git-send-email-beckyb@kernel.crashing.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Becky Bruce <beckyb@kernel.crashing.org>

Currently, it does a cntlzd on the size and then subtracts it from
21.... this doesn't take into account the varying size of a "long".
Just use __ilog instead (and subtract the 10 we have to subtract
to get to the tsize encoding).

Signed-off-by: Becky Bruce <beckyb@kernel.crashing.org>
---
 arch/powerpc/mm/fsl_booke_mmu.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/powerpc/mm/fsl_booke_mmu.c b/arch/powerpc/mm/fsl_booke_mmu.c
index f7802c8..54897c0 100644
--- a/arch/powerpc/mm/fsl_booke_mmu.c
+++ b/arch/powerpc/mm/fsl_booke_mmu.c
@@ -111,7 +111,7 @@ static void settlbcam(int index, unsigned long virt, phys_addr_t phys,
 	unsigned int tsize, lz;
 
 	asm (PPC_CNTLZL "%0,%1" : "=r" (lz) : "r" (size));
-	tsize = 21 - lz;
+	tsize = __ilog2(size) - 10;
 
 #ifdef CONFIG_SMP
 	if ((flags & _PAGE_NO_CACHE) == 0)
-- 
1.5.6.5

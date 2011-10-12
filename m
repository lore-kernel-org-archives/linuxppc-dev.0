Return-Path: <beckyb@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 28B22B6F6B
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 13 Oct 2011 08:17:05 +1100 (EST)
Received: from localhost (localhost.localdomain [127.0.0.1])
 by gate.crashing.org (8.14.1/8.13.8) with ESMTP id p9CLH2QP018925
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 12 Oct 2011 16:17:02 -0500
From: Becky Bruce <beckyb@kernel.crashing.org>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v2] powerpc/fsl-booke: Fix settlbcam for 64-bit
Date: Wed, 12 Oct 2011 16:17:02 -0500
Message-Id: <13184542222469-git-send-email-beckyb@kernel.crashing.org>
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

Also correct the comment about page sizes supported.

Signed-off-by: Becky Bruce <beckyb@kernel.crashing.org>
---
Sent the wrong version last time; also noticed that the comment is
incorrect now that we have 64-bit and added that to the patch.

 arch/powerpc/mm/fsl_booke_mmu.c |   12 ++++++------
 1 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/powerpc/mm/fsl_booke_mmu.c b/arch/powerpc/mm/fsl_booke_mmu.c
index f7802c8..5b8fd3b 100644
--- a/arch/powerpc/mm/fsl_booke_mmu.c
+++ b/arch/powerpc/mm/fsl_booke_mmu.c
@@ -101,17 +101,17 @@ unsigned long p_mapped_by_tlbcam(phys_addr_t pa)
 
 /*
  * Set up a variable-size TLB entry (tlbcam). The parameters are not checked;
- * in particular size must be a power of 4 between 4k and 256M (or 1G, for cpus
- * that support extended page sizes).  Note that while some cpus support a
- * page size of 4G, we don't allow its use here.
+ * in particular size must be a power of 4 between 4k and the max supported by
+ * an implementation; max may further be limited by what can be represented in
+ * an unsigned long (for example, 32-bit implementations cannot support a 4GB
+ * size).
  */
 static void settlbcam(int index, unsigned long virt, phys_addr_t phys,
 		unsigned long size, unsigned long flags, unsigned int pid)
 {
-	unsigned int tsize, lz;
+	unsigned int tsize;
 
-	asm (PPC_CNTLZL "%0,%1" : "=r" (lz) : "r" (size));
-	tsize = 21 - lz;
+	tsize = __ilog2(size) - 10;
 
 #ifdef CONFIG_SMP
 	if ((flags & _PAGE_NO_CACHE) == 0)
-- 
1.5.6.5

Return-Path: <beckyb@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id B7A59B6F04
	for <linuxppc-dev@ozlabs.org>; Thu,  1 Jul 2010 05:42:55 +1000 (EST)
From: Becky Bruce <beckyb@kernel.crashing.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] powerpc/fsl-booke: Fix comments that refer to BAT registers
Date: Wed, 30 Jun 2010 14:42:51 -0500
Message-Id: <1277926971-30712-1-git-send-email-beckyb@kernel.crashing.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

There are no BATS on BookE - we have the TLBCAM instead.  Also correct
the page size information to included extended (1G and 4G) sizes.

Signed-off-by: Becky Bruce <beckyb@kernel.crashing.org>
---
Lame, I know, but this drives me batty every time I see it, and I've had
customers get confused because of it.  I've finally gotten irritated enough
to send a patch.

-Becky

 arch/powerpc/mm/fsl_booke_mmu.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/mm/fsl_booke_mmu.c b/arch/powerpc/mm/fsl_booke_mmu.c
index cdc7526..681429d 100644
--- a/arch/powerpc/mm/fsl_booke_mmu.c
+++ b/arch/powerpc/mm/fsl_booke_mmu.c
@@ -104,9 +104,9 @@ unsigned long p_mapped_by_tlbcam(phys_addr_t pa)
 }
 
 /*
- * Set up one of the I/D BAT (block address translation) register pairs.
- * The parameters are not checked; in particular size must be a power
- * of 4 between 4k and 256M.
+ * Set up a variable-size TLB entry (tlbcam). The parameters are not checked;
+ * in particular size must be a power of 4 between 4k and 256M (or 4G, for cpus
+ * that support extended page sizes).
  */
 static void settlbcam(int index, unsigned long virt, phys_addr_t phys,
 		unsigned long size, unsigned long flags, unsigned int pid)
-- 
1.6.0.6

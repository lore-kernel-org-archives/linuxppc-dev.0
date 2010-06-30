Return-Path: <beckyb@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id CF186B6EDF
	for <linuxppc-dev@ozlabs.org>; Thu,  1 Jul 2010 06:23:35 +1000 (EST)
From: Becky Bruce <beckyb@kernel.crashing.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH V2] powerpc: Fix comments in fsl_booke_mmu code that mention
	BATS
Date: Wed, 30 Jun 2010 15:23:31 -0500
Message-Id: <1277929411-2307-1-git-send-email-beckyb@kernel.crashing.org>
In-Reply-To: <1277926971-30712-1-git-send-email-beckyb@kernel.crashing.org>
References: <1277926971-30712-1-git-send-email-beckyb@kernel.crashing.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

There are no BATS on BookE - we have the TLBCAM instead.  Also correct
the page size information to included extended sizes.  We don't actually allow
a 4G page size to be used, so comment on that as well.

Signed-off-by: Becky Bruce <beckyb@kernel.crashing.org>
---
Even lamer, I forgot that we don't actually allow use of a 4G page.
Update the comment to reflect this.

-Becky

 arch/powerpc/mm/fsl_booke_mmu.c |    7 ++++---
 1 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/mm/fsl_booke_mmu.c b/arch/powerpc/mm/fsl_booke_mmu.c
index cdc7526..4b66a1e 100644
--- a/arch/powerpc/mm/fsl_booke_mmu.c
+++ b/arch/powerpc/mm/fsl_booke_mmu.c
@@ -104,9 +104,10 @@ unsigned long p_mapped_by_tlbcam(phys_addr_t pa)
 }
 
 /*
- * Set up one of the I/D BAT (block address translation) register pairs.
- * The parameters are not checked; in particular size must be a power
- * of 4 between 4k and 256M.
+ * Set up a variable-size TLB entry (tlbcam). The parameters are not checked;
+ * in particular size must be a power of 4 between 4k and 256M (or 1G, for cpus
+ * that support extended page sizes).  Note that while some cpus support a
+ * page size of 4G, we don't allow its use here.
  */
 static void settlbcam(int index, unsigned long virt, phys_addr_t phys,
 		unsigned long size, unsigned long flags, unsigned int pid)
-- 
1.6.0.6

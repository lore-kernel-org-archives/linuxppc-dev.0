Return-Path: <christophe.leroy@c-s.fr>
Received: from mailhub1.si.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 by lists.ozlabs.org (Postfix) with ESMTP id 9D56F1A0987
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 18 Sep 2014 02:37:33 +1000 (EST)
From: Christophe Leroy <christophe.leroy@c-s.fr>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>
Subject: [PATCH v3 18/21] powerpc/8xx: _PMD_PRESENT already set in level 1
 entries
Message-Id: <20140917163700.969841AB043@localhost.localdomain>
Date: Wed, 17 Sep 2014 18:37:00 +0200 (CEST)
Cc: scottwood@freescale.com, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

When a PMD entry is valid, _PMD_PRESENT is set. Therefore, forcing that bit
during TLB loading is useless.

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>

---
Changes in v2:
- None

Changes in v3:
- None

 arch/powerpc/kernel/head_8xx.S |    2 --
 1 files changed, 0 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/kernel/head_8xx.S b/arch/powerpc/kernel/head_8xx.S
index 48d3de8..bb7c816 100644
--- a/arch/powerpc/kernel/head_8xx.S
+++ b/arch/powerpc/kernel/head_8xx.S
@@ -340,7 +340,6 @@ InstructionTLBMiss:
 	/* We have a pte table, so load the MI_TWC with the attributes
 	 * for this "segment."
 	 */
-	ori	r11,r11,1		/* Set valid bit */
 	MTSPR_CPU6(SPRN_MI_TWC, r11, r3)	/* Set segment attributes */
 	mfspr	r11, SPRN_SRR0	/* Get effective address of fault */
 	/* Extract level 2 index */
@@ -417,7 +416,6 @@ DataStoreTLBMiss:
 	rlwimi	r10, r11, 0, 0, 32 - PAGE_SHIFT - 1	/* Add level 2 base */
 	lwz	r10, 0(r10)	/* Get the pte */
 
-	ori	r11, r11, 1	/* Set valid bit in physical L2 page */
 	/* Insert the Guarded flag into the TWC from the Linux PTE.
 	 * It is bit 27 of both the Linux PTE and the TWC (at least
 	 * I got that right :-).  It will be better when we can put
-- 
1.7.1

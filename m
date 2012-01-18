Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 4963EB6EE6
 for <linuxppc-dev@ozlabs.org>; Thu, 19 Jan 2012 06:39:47 +1100 (EST)
Received: from localhost (localhost.localdomain [127.0.0.1])
 by gate.crashing.org (8.14.1/8.13.8) with ESMTP id q0IJdenQ031225
 for <linuxppc-dev@ozlabs.org>; Wed, 18 Jan 2012 13:39:42 -0600
From: Kumar Gala <galak@kernel.crashing.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 1/2] powerpc/fsl-booke: Fixup calc_cam_sz to support MMU v2
Date: Wed, 18 Jan 2012 13:39:39 -0600
Message-Id: <1326915580-19652-1-git-send-email-galak@kernel.crashing.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The registers that describe size supported by TLB are different on MMU
v2 as well as we support power of two page sizes.  For now we continue
to assume that FSL variable size array supports all page sizes up to the
maximum one reported in TLB1PS.

Signed-off-by: Kumar Gala <galak@kernel.crashing.org>
---
 arch/powerpc/include/asm/reg_booke.h |    1 +
 arch/powerpc/mm/fsl_booke_mmu.c      |   19 +++++++++++++------
 2 files changed, 14 insertions(+), 6 deletions(-)

diff --git a/arch/powerpc/include/asm/reg_booke.h b/arch/powerpc/include/asm/reg_booke.h
index 500fe1d..8a97aa7 100644
--- a/arch/powerpc/include/asm/reg_booke.h
+++ b/arch/powerpc/include/asm/reg_booke.h
@@ -62,6 +62,7 @@
 #define SPRN_DVC2	0x13F	/* Data Value Compare Register 2 */
 #define SPRN_MAS8	0x155	/* MMU Assist Register 8 */
 #define SPRN_TLB0PS	0x158	/* TLB 0 Page Size Register */
+#define SPRN_TLB1PS	0x159	/* TLB 1 Page Size Register */
 #define SPRN_MAS5_MAS6	0x15c	/* MMU Assist Register 5 || 6 */
 #define SPRN_MAS8_MAS1	0x15d	/* MMU Assist Register 8 || 1 */
 #define SPRN_EPTCFG	0x15e	/* Embedded Page Table Config */
diff --git a/arch/powerpc/mm/fsl_booke_mmu.c b/arch/powerpc/mm/fsl_booke_mmu.c
index 66a6fd3..07ba45b 100644
--- a/arch/powerpc/mm/fsl_booke_mmu.c
+++ b/arch/powerpc/mm/fsl_booke_mmu.c
@@ -149,12 +149,19 @@ static void settlbcam(int index, unsigned long virt, phys_addr_t phys,
 unsigned long calc_cam_sz(unsigned long ram, unsigned long virt,
 			  phys_addr_t phys)
 {
-	unsigned int camsize = __ilog2(ram) & ~1U;
-	unsigned int align = __ffs(virt | phys) & ~1U;
-	unsigned long max_cam = (mfspr(SPRN_TLB1CFG) >> 16) & 0xf;
-
-	/* Convert (4^max) kB to (2^max) bytes */
-	max_cam = max_cam * 2 + 10;
+	unsigned int camsize = __ilog2(ram);
+	unsigned int align = __ffs(virt | phys);
+	unsigned long max_cam;
+
+	if ((mfspr(SPRN_MMUCFG) & MMUCFG_MAVN) == MMUCFG_MAVN_V1) {
+		/* Convert (4^max) kB to (2^max) bytes */
+		max_cam = ((mfspr(SPRN_TLB1CFG) >> 16) & 0xf) * 2 + 10;
+		camsize &= ~1U;
+		align &= ~1U;
+	} else {
+		/* Convert (2^max) kB to (2^max) bytes */
+		max_cam = __ilog2(mfspr(SPRN_TLB1PS)) + 10;
+	}
 
 	if (camsize > align)
 		camsize = align;
-- 
1.7.3.4

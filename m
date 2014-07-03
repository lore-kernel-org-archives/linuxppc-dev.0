Return-Path: <mihai.caraman@freescale.com>
Received: from na01-by2-obe.outbound.protection.outlook.com
 (mail-by2lp0242.outbound.protection.outlook.com [207.46.163.242])
 (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3E66E1A0004
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  4 Jul 2014 00:45:41 +1000 (EST)
From: Mihai Caraman <mihai.caraman@freescale.com>
To: <kvm-ppc@vger.kernel.org>
Subject: [RFC PATCH 1/4] powerpc/booke64: Add LRAT next and max entries to
 tlb_core_data structure
Date: Thu, 3 Jul 2014 17:45:24 +0300
Message-ID: <1404398727-12844-2-git-send-email-mihai.caraman@freescale.com>
In-Reply-To: <1404398727-12844-1-git-send-email-mihai.caraman@freescale.com>
References: <1404398727-12844-1-git-send-email-mihai.caraman@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: Mihai Caraman <mihai.caraman@freescale.com>, linuxppc-dev@lists.ozlabs.org,
 kvm@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

LRAT (Logical to Real Address Translation) is shared between hw threads.
Add LRAT next and max entries to tlb_core_data structure and initialize them.

Signed-off-by: Mihai Caraman <mihai.caraman@freescale.com>
---
 arch/powerpc/include/asm/mmu-book3e.h | 7 +++++++
 arch/powerpc/include/asm/reg_booke.h  | 1 +
 arch/powerpc/mm/fsl_booke_mmu.c       | 8 ++++++++
 3 files changed, 16 insertions(+)

diff --git a/arch/powerpc/include/asm/mmu-book3e.h b/arch/powerpc/include/asm/mmu-book3e.h
index 8d24f78..088fd9f 100644
--- a/arch/powerpc/include/asm/mmu-book3e.h
+++ b/arch/powerpc/include/asm/mmu-book3e.h
@@ -217,6 +217,12 @@
 #define TLBILX_T_CLASS2			6
 #define TLBILX_T_CLASS3			7
 
+/* LRATCFG bits */
+#define LRATCFG_ASSOC		0xFF000000
+#define LRATCFG_LASIZE		0x00FE0000
+#define LRATCFG_LPID		0x00002000
+#define LRATCFG_NENTRY		0x00000FFF
+
 #ifndef __ASSEMBLY__
 #include <asm/bug.h>
 
@@ -294,6 +300,7 @@ struct tlb_core_data {
 
 	/* For software way selection, as on Freescale TLB1 */
 	u8 esel_next, esel_max, esel_first;
+	u8 lrat_next, lrat_max;
 };
 
 #ifdef CONFIG_PPC64
diff --git a/arch/powerpc/include/asm/reg_booke.h b/arch/powerpc/include/asm/reg_booke.h
index 464f108..75bda23 100644
--- a/arch/powerpc/include/asm/reg_booke.h
+++ b/arch/powerpc/include/asm/reg_booke.h
@@ -64,6 +64,7 @@
 #define SPRN_DVC2	0x13F	/* Data Value Compare Register 2 */
 #define SPRN_LPID	0x152	/* Logical Partition ID */
 #define SPRN_MAS8	0x155	/* MMU Assist Register 8 */
+#define SPRN_LRATCFG	0x156	/* LRAT Configuration Register */
 #define SPRN_TLB0PS	0x158	/* TLB 0 Page Size Register */
 #define SPRN_TLB1PS	0x159	/* TLB 1 Page Size Register */
 #define SPRN_MAS5_MAS6	0x15c	/* MMU Assist Register 5 || 6 */
diff --git a/arch/powerpc/mm/fsl_booke_mmu.c b/arch/powerpc/mm/fsl_booke_mmu.c
index 94cd728..6492708 100644
--- a/arch/powerpc/mm/fsl_booke_mmu.c
+++ b/arch/powerpc/mm/fsl_booke_mmu.c
@@ -196,6 +196,14 @@ static unsigned long map_mem_in_cams_addr(phys_addr_t phys, unsigned long virt,
 	get_paca()->tcd.esel_next = i;
 	get_paca()->tcd.esel_max = mfspr(SPRN_TLB1CFG) & TLBnCFG_N_ENTRY;
 	get_paca()->tcd.esel_first = i;
+
+	get_paca()->tcd.lrat_next = 0;
+	if (((mfspr(SPRN_MMUCFG) & MMUCFG_MAVN) == MMUCFG_MAVN_V2) &&
+	    (mfspr(SPRN_MMUCFG) & MMUCFG_LRAT)) {
+		get_paca()->tcd.lrat_max = mfspr(SPRN_LRATCFG) & LRATCFG_NENTRY;
+	} else {
+		get_paca()->tcd.lrat_max = 0;
+	}
 #endif
 
 	return amount_mapped;
-- 
1.7.11.7

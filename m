Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 85F9BB73D7
	for <linuxppc-dev@ozlabs.org>; Sat,  9 Oct 2010 06:07:13 +1100 (EST)
Received: from localhost (localhost.localdomain [127.0.0.1])
	by gate.crashing.org (8.14.1/8.13.8) with ESMTP id o98J791a005913
	for <linuxppc-dev@ozlabs.org>; Fri, 8 Oct 2010 14:07:09 -0500
From: Kumar Gala <galak@kernel.crashing.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 08/11] powerpc/fsl-booke: Add support for FSL Arch v1.0 MMU in
	setup_page_sizes
Date: Fri,  8 Oct 2010 14:06:50 -0500
Message-Id: <1286564813-21209-8-git-send-email-galak@kernel.crashing.org>
In-Reply-To: <1286564813-21209-7-git-send-email-galak@kernel.crashing.org>
References: <1286564813-21209-1-git-send-email-galak@kernel.crashing.org>
	<1286564813-21209-2-git-send-email-galak@kernel.crashing.org>
	<1286564813-21209-3-git-send-email-galak@kernel.crashing.org>
	<1286564813-21209-4-git-send-email-galak@kernel.crashing.org>
	<1286564813-21209-5-git-send-email-galak@kernel.crashing.org>
	<1286564813-21209-6-git-send-email-galak@kernel.crashing.org>
	<1286564813-21209-7-git-send-email-galak@kernel.crashing.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Update setup_page_sizes() to support for a MMU v1.0 FSL style MMU
implementation.  In such a processor, we don't have TLB0PS or EPTCFG
registers (and access to these registers may cause exceptions).  We need
to parse the older format of TLBnCFG for page size support.  Additionaly,
assume since we are an FSL implementation that we have 2 TLB arrays and
the second array contains the variable size pages.

Signed-off-by: Kumar Gala <galak@kernel.crashing.org>
---
 arch/powerpc/include/asm/mmu-book3e.h |   15 +++++++++++
 arch/powerpc/mm/tlb_nohash.c          |   42 ++++++++++++++++++++++++++++++--
 2 files changed, 54 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/include/asm/mmu-book3e.h b/arch/powerpc/include/asm/mmu-book3e.h
index 87a1d78..8eaed81 100644
--- a/arch/powerpc/include/asm/mmu-book3e.h
+++ b/arch/powerpc/include/asm/mmu-book3e.h
@@ -114,6 +114,17 @@
 
 #define MAS7_RPN		0xFFFFFFFF
 
+/* Bit definitions for MMUCFG */
+#define MMUCFG_MAVN	0x00000003	/* MMU Architecture Version Number */
+#define MMUCFG_MAVN_V1	0x00000000	/* v1.0 */
+#define MMUCFG_MAVN_V2	0x00000001	/* v2.0 */
+#define MMUCFG_NTLBS	0x0000000c	/* Number of TLBs */
+#define MMUCFG_PIDSIZE	0x000007c0	/* PID Reg Size */
+#define MMUCFG_TWC	0x00008000	/* TLB Write Conditional (v2.0) */
+#define MMUCFG_LRAT	0x00010000	/* LRAT Supported (v2.0) */
+#define MMUCFG_RASIZE	0x00fe0000	/* Real Addr Size */
+#define MMUCFG_LPIDSIZE	0x0f000000	/* LPID Reg Size */
+
 /* Bit definitions for MMUCSR0 */
 #define MMUCSR0_TLB1FI	0x00000002	/* TLB1 Flash invalidate */
 #define MMUCSR0_TLB0FI	0x00000004	/* TLB0 Flash invalidate */
@@ -133,6 +144,10 @@
 #define TLBnCFG_GTWE		0x00010000	/* Guest can write */
 #define TLBnCFG_IND		0x00020000	/* IND entries supported */
 #define TLBnCFG_PT		0x00040000	/* Can load from page table */
+#define TLBnCFG_MINSIZE		0x00f00000	/* Minimum Page Size (v1.0) */
+#define TLBnCFG_MINSIZE_SHIFT	20
+#define TLBnCFG_MAXSIZE		0x000f0000	/* Maximum Page Size (v1.0) */
+#define TLBnCFG_MAXSIZE_SHIFT	16
 #define TLBnCFG_ASSOC		0xff000000	/* Associativity */
 
 /* TLBnPS encoding */
diff --git a/arch/powerpc/mm/tlb_nohash.c b/arch/powerpc/mm/tlb_nohash.c
index fe391e9..6651899 100644
--- a/arch/powerpc/mm/tlb_nohash.c
+++ b/arch/powerpc/mm/tlb_nohash.c
@@ -349,11 +349,47 @@ void tlb_flush_pgtable(struct mmu_gather *tlb, unsigned long address)
 
 static void setup_page_sizes(void)
 {
-	unsigned int tlb0cfg = mfspr(SPRN_TLB0CFG);
-	unsigned int tlb0ps = mfspr(SPRN_TLB0PS);
-	unsigned int eptcfg = mfspr(SPRN_EPTCFG);
+	unsigned int tlb0cfg;
+	unsigned int tlb0ps;
+	unsigned int eptcfg;
 	int i, psize;
 
+#ifdef CONFIG_PPC_FSL_BOOK3E
+	unsigned int mmucfg = mfspr(SPRN_MMUCFG);
+
+	if (((mmucfg & MMUCFG_MAVN) == MMUCFG_MAVN_V1) &&
+		(mmu_has_feature(MMU_FTR_TYPE_FSL_E))) {
+		unsigned int tlb1cfg = mfspr(SPRN_TLB1CFG);
+		unsigned int min_pg, max_pg;
+
+		min_pg = (tlb1cfg & TLBnCFG_MINSIZE) >> TLBnCFG_MINSIZE_SHIFT;
+		max_pg = (tlb1cfg & TLBnCFG_MAXSIZE) >> TLBnCFG_MAXSIZE_SHIFT;
+
+		for (psize = 0; psize < MMU_PAGE_COUNT; ++psize) {
+			struct mmu_psize_def *def;
+			unsigned int shift;
+
+			def = &mmu_psize_defs[psize];
+			shift = def->shift;
+
+			if (shift == 0)
+				continue;
+
+			/* adjust to be in terms of 4^shift Kb */
+			shift = (shift - 10) >> 1;
+
+			if ((shift >= min_pg) && (shift <= max_pg))
+				def->flags |= MMU_PAGE_SIZE_DIRECT;
+		}
+
+		goto no_indirect;
+	}
+#endif
+
+	tlb0cfg = mfspr(SPRN_TLB0CFG);
+	tlb0ps = mfspr(SPRN_TLB0PS);
+	eptcfg = mfspr(SPRN_EPTCFG);
+
 	/* Look for supported direct sizes */
 	for (psize = 0; psize < MMU_PAGE_COUNT; ++psize) {
 		struct mmu_psize_def *def = &mmu_psize_defs[psize];
-- 
1.7.2.3

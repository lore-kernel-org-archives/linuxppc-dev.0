Return-Path: <B07421@freescale.com>
Received: from VA3EHSOBE008.bigfish.com (va3ehsobe001.messaging.microsoft.com
	[216.32.180.11]) (using TLSv1 with cipher AES128-SHA (128/128 bits))
	(Client CN "mail.global.frontbridge.com",
	Issuer "Cybertrust SureServer Standard Validation CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 9FD7EB6F5A
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 19 May 2011 07:05:38 +1000 (EST)
Date: Wed, 18 May 2011 16:05:29 -0500
From: Scott Wood <scottwood@freescale.com>
To: <benh@kernel.crashing.org>
Subject: [PATCH 2/7] powerpc/mm: 64-bit 4k: use a PMD-based virtual page table
Message-ID: <20110518210528.GA29524@schlenkerla.am.freescale.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
In-Reply-To: <20110518210453.GA29500@schlenkerla.am.freescale.net>
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Loads with non-linear access patterns were producing a very high
ratio of recursive pt faults to regular tlb misses.  Rather than
choose between a 4-level table walk or a 1-level virtual page table
lookup, use a hybrid scheme with a virtual linear pmd, followed by a
2-level lookup in the normal handler.

This adds about 5 cycles (assuming no cache misses, and e5500 timing)
to a normal TLB miss, but greatly reduces the recursive fault rate
for loads which don't have locality within 2 MiB regions but do have
significant locality within 1 GiB regions.  Improvements of close to 50%
were seen on such benchmarks.

Signed-off-by: Scott Wood <scottwood@freescale.com>
---
 arch/powerpc/mm/tlb_low_64e.S |   23 +++++++++++++++--------
 1 files changed, 15 insertions(+), 8 deletions(-)

diff --git a/arch/powerpc/mm/tlb_low_64e.S b/arch/powerpc/mm/tlb_low_64e.S
index af08922..17726d3 100644
--- a/arch/powerpc/mm/tlb_low_64e.S
+++ b/arch/powerpc/mm/tlb_low_64e.S
@@ -24,7 +24,7 @@
 #ifdef CONFIG_PPC_64K_PAGES
 #define VPTE_PMD_SHIFT	(PTE_INDEX_SIZE+1)
 #else
-#define VPTE_PMD_SHIFT	(PTE_INDEX_SIZE)
+#define VPTE_PMD_SHIFT	0
 #endif
 #define VPTE_PUD_SHIFT	(VPTE_PMD_SHIFT + PMD_INDEX_SIZE)
 #define VPTE_PGD_SHIFT	(VPTE_PUD_SHIFT + PUD_INDEX_SIZE)
@@ -185,7 +185,7 @@ normal_tlb_miss:
 	/* Insert the bottom bits in */
 	rlwimi	r14,r15,0,16,31
 #else
-	rldicl	r14,r16,64-(PAGE_SHIFT-3),PAGE_SHIFT-3+4
+	rldicl	r14,r16,64-(PMD_SHIFT-3),PMD_SHIFT-3+4
 #endif
 	sldi	r15,r10,60
 	clrrdi	r14,r14,3
@@ -202,6 +202,16 @@ MMU_FTR_SECTION_ELSE
 	ld	r14,0(r10)
 ALT_MMU_FTR_SECTION_END_IFSET(MMU_FTR_USE_TLBRSRV)
 
+#ifndef CONFIG_PPC_64K_PAGES
+	rldicl	r15,r16,64-PAGE_SHIFT+3,64-PTE_INDEX_SIZE-3
+	clrrdi	r15,r15,3
+
+	cmpldi	cr0,r14,0
+	beq	normal_tlb_miss_access_fault
+
+	ldx	r14,r14,r15
+#endif
+
 finish_normal_tlb_miss:
 	/* Check if required permissions are met */
 	andc.	r15,r11,r14
@@ -353,14 +363,11 @@ END_MMU_FTR_SECTION_IFSET(MMU_FTR_USE_TLBRSRV)
 #ifndef CONFIG_PPC_64K_PAGES
 	/* Get to PUD entry */
 	rldicl	r11,r16,64-VPTE_PUD_SHIFT,64-PUD_INDEX_SIZE-3
-	clrrdi	r10,r11,3
-	ldx	r15,r10,r15
-	cmpldi	cr0,r15,0
-	beq	virt_page_table_tlb_miss_fault
-#endif /* CONFIG_PPC_64K_PAGES */
-
+#else
 	/* Get to PMD entry */
 	rldicl	r11,r16,64-VPTE_PMD_SHIFT,64-PMD_INDEX_SIZE-3
+#endif
+
 	clrrdi	r10,r11,3
 	ldx	r15,r10,r15
 	cmpldi	cr0,r15,0
-- 
1.7.4.1

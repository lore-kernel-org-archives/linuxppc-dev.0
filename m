Return-Path: <beckyb@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id C62BDB736F
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 11 Oct 2011 07:51:14 +1100 (EST)
From: Becky Bruce <beckyb@kernel.crashing.org>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 03/13] powerpc: Fix booke hugetlb preload code for
 PPC_MM_SLICES and 64-bit
Date: Mon, 10 Oct 2011 15:50:38 -0500
Message-Id: <13182798681100-git-send-email-beckyb@kernel.crashing.org>
In-Reply-To: <13182798643553-git-send-email-beckyb@kernel.crashing.org>
References: <1318279848494-git-send-email-beckyb@kernel.crashing.org>
 <13182798624083-git-send-email-beckyb@kernel.crashing.org>
 <13182798643553-git-send-email-beckyb@kernel.crashing.org>
Cc: david@gibson.dropbear.id.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Becky Bruce <beckyb@kernel.crashing.org>

This patch does 2 things: It corrects the code that determines the
size to write into MAS1 for the PPC_MM_SLICES case (this originally
came from David Gibson and I had incorrectly altered it), and it
changes the methodolody used to calculate the size for !PPC_MM_SLICES
to work for 64-bit as well as 32-bit.

Signed-off-by: Becky Bruce <beckyb@kernel.crashing.org>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 arch/powerpc/mm/hugetlbpage-book3e.c |   15 ++++++---------
 1 files changed, 6 insertions(+), 9 deletions(-)

diff --git a/arch/powerpc/mm/hugetlbpage-book3e.c b/arch/powerpc/mm/hugetlbpage-book3e.c
index 343ad0b..4d6d849 100644
--- a/arch/powerpc/mm/hugetlbpage-book3e.c
+++ b/arch/powerpc/mm/hugetlbpage-book3e.c
@@ -45,23 +45,20 @@ void book3e_hugetlb_preload(struct mm_struct *mm, unsigned long ea, pte_t pte)
 	unsigned long flags;
 
 #ifdef CONFIG_PPC_FSL_BOOK3E
-	int index, lz, ncams;
-	struct vm_area_struct *vma;
+	int index, ncams;
 #endif
 
 	if (unlikely(is_kernel_addr(ea)))
 		return;
 
 #ifdef CONFIG_PPC_MM_SLICES
-	psize = mmu_get_tsize(get_slice_psize(mm, ea));
-	tsize = mmu_get_psize(psize);
+	psize = get_slice_psize(mm, ea);
+	tsize = mmu_get_tsize(psize);
 	shift = mmu_psize_defs[psize].shift;
 #else
-	vma = find_vma(mm, ea);
-	psize = vma_mmu_pagesize(vma);	/* returns actual size in bytes */
-	asm (PPC_CNTLZL "%0,%1" : "=r" (lz) : "r" (psize));
-	shift = 31 - lz;
-	tsize = 21 - lz;
+	psize = vma_mmu_pagesize(find_vma(mm, ea));
+	shift = __ilog2(psize);
+	tsize = shift - 10;
 #endif
 
 	/*
-- 
1.5.6.5

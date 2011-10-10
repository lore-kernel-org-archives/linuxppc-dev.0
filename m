Return-Path: <beckyb@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 28DE9B7231
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 11 Oct 2011 07:51:11 +1100 (EST)
From: Becky Bruce <beckyb@kernel.crashing.org>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 02/13] powerpc: hugetlb: fix huge_ptep_set_access_flags return
 value
Date: Mon, 10 Oct 2011 15:50:37 -0500
Message-Id: <13182798643553-git-send-email-beckyb@kernel.crashing.org>
In-Reply-To: <13182798624083-git-send-email-beckyb@kernel.crashing.org>
References: <1318279848494-git-send-email-beckyb@kernel.crashing.org>
 <13182798624083-git-send-email-beckyb@kernel.crashing.org>
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

There was an unconditional return of "1" in the original code
from David Gibson, and I dropped it because it wasn't needed
for FSL BOOKE 32-bit.  However, not all systems (including 64-bit
FSL BOOKE) do loading of the hpte from the fault handler asm
and depend on this function returning 1, which causes a call
to update_mmu_cache() that writes an entry into the tlb.

Signed-off-by: Becky Bruce <beckyb@kernel.crashing.org>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 arch/powerpc/include/asm/hugetlb.h |   11 +++++++++++
 1 files changed, 11 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/include/asm/hugetlb.h b/arch/powerpc/include/asm/hugetlb.h
index 8600493..70f9885 100644
--- a/arch/powerpc/include/asm/hugetlb.h
+++ b/arch/powerpc/include/asm/hugetlb.h
@@ -124,7 +124,18 @@ static inline int huge_ptep_set_access_flags(struct vm_area_struct *vma,
 					     unsigned long addr, pte_t *ptep,
 					     pte_t pte, int dirty)
 {
+#if defined(CONFIG_PPC_MMU_NOHASH) && \
+	!(defined(CONFIG_PPC_FSL_BOOK3E) && defined(CONFIG_PPC32))
+	/*
+	 * The "return 1" forces a call of update_mmu_cache, which will write a
+	 * TLB entry.  Without this, platforms that don't do a write of the TLB
+	 * entry in the TLB miss handler asm will fault ad infinitum.
+	 */
+	ptep_set_access_flags(vma, addr, ptep, pte, dirty);
+	return 1;
+#else
 	return ptep_set_access_flags(vma, addr, ptep, pte, dirty);
+#endif
 }
 
 static inline pte_t huge_ptep_get(pte_t *ptep)
-- 
1.5.6.5

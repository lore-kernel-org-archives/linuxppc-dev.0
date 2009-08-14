Return-Path: <beckyb@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by bilbo.ozlabs.org (Postfix) with ESMTPS id E1C9CB6F31
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat, 15 Aug 2009 05:47:25 +1000 (EST)
From: Becky Bruce <beckyb@kernel.crashing.org>
To: benh@kernel.crashing.org
Subject: [PATCH] powerpc: Fix __tlb_remove_tlb_entry for PPC_STD_MMU_32
Date: Fri, 14 Aug 2009 14:47:18 -0500
Message-Id: <1250279238-15616-1-git-send-email-beckyb@kernel.crashing.org>
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Ben's recent patches are missing the CONFIG_ prefix to
PPC_STD_MMU_32, which results in not properly flushing hash
entries.  On 8641, this showed up as a platform that would boot,
but deny logins.

Signed-off-by: Becky Bruce <beckyb@kernel.crashing.org>
---
 arch/powerpc/include/asm/tlb.h |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/powerpc/include/asm/tlb.h b/arch/powerpc/include/asm/tlb.h
index 5db9910..e2b428b 100644
--- a/arch/powerpc/include/asm/tlb.h
+++ b/arch/powerpc/include/asm/tlb.h
@@ -39,7 +39,7 @@ extern void flush_hash_entry(struct mm_struct *mm, pte_t *ptep,
 static inline void __tlb_remove_tlb_entry(struct mmu_gather *tlb, pte_t *ptep,
 					  unsigned long address)
 {
-#ifdef PPC_STD_MMU_32
+#ifdef CONFIG_PPC_STD_MMU_32
 	if (pte_val(*ptep) & _PAGE_HASHPTE)
 		flush_hash_entry(tlb->mm, ptep, address);
 #endif
-- 
1.6.0.6

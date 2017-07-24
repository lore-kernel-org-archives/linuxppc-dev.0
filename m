Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xG7fk0CTjzDrJ8
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 24 Jul 2017 14:28:45 +1000 (AEST)
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: linuxppc-dev@lists.ozlabs.org
Cc: aneesh.kumar@linux.vnet.ibm.com, npiggin@gmail.com,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [PATCH 2/6] powerpc/mm: Avoid double irq save/restore in activate_mm
Date: Mon, 24 Jul 2017 14:27:59 +1000
Message-Id: <20170724042803.25848-2-benh@kernel.crashing.org>
In-Reply-To: <20170724042803.25848-1-benh@kernel.crashing.org>
References: <20170724042803.25848-1-benh@kernel.crashing.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

It calls switch_mm() which already does the irq save/restore
these days.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---
 arch/powerpc/include/asm/mmu_context.h | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/arch/powerpc/include/asm/mmu_context.h b/arch/powerpc/include/asm/mmu_context.h
index 603b0e5cdec0..ed9a36ee3107 100644
--- a/arch/powerpc/include/asm/mmu_context.h
+++ b/arch/powerpc/include/asm/mmu_context.h
@@ -158,11 +158,7 @@ static inline void switch_mm(struct mm_struct *prev, struct mm_struct *next,
  */
 static inline void activate_mm(struct mm_struct *prev, struct mm_struct *next)
 {
-	unsigned long flags;
-
-	local_irq_save(flags);
 	switch_mm(prev, next, current);
-	local_irq_restore(flags);
 }
 
 /* We don't currently use enter_lazy_tlb() for anything */
-- 
2.13.3

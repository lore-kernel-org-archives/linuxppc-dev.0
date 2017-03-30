Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vv3G83WhVzDqLj
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 30 Mar 2017 23:04:32 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: linuxppc-dev@ozlabs.org
Cc: aneesh.kumar@linux.vnet.ibm.com
Subject: [PATCH v6 16/19] powerpc/mm/hash: Store addr_limit in PACA
Date: Thu, 30 Mar 2017 23:04:04 +1100
Message-Id: <1490875447-4016-16-git-send-email-mpe@ellerman.id.au>
In-Reply-To: <1490875447-4016-1-git-send-email-mpe@ellerman.id.au>
References: <1490875447-4016-1-git-send-email-mpe@ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>

We optmize the slice page size array copy to paca by copying only the
range based on addr_limit. This will require us to not look at page size
array beyond addr_limit in PACA on slb fault. To enable that copy task
size to paca which will be used during slb fault.

Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
[mpe: Rename from task_size to addr_limit, consolidate #ifdefs]
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/include/asm/paca.h   | 1 +
 arch/powerpc/kernel/asm-offsets.c | 1 +
 arch/powerpc/kernel/paca.c        | 1 +
 arch/powerpc/mm/slb_low.S         | 8 +++++++-
 4 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/include/asm/paca.h b/arch/powerpc/include/asm/paca.h
index f48c250339fd..65d0ffb2aa33 100644
--- a/arch/powerpc/include/asm/paca.h
+++ b/arch/powerpc/include/asm/paca.h
@@ -139,6 +139,7 @@ struct paca_struct {
 #ifdef CONFIG_PPC_MM_SLICES
 	u64 mm_ctx_low_slices_psize;
 	unsigned char mm_ctx_high_slices_psize[SLICE_ARRAY_SIZE];
+	unsigned long addr_limit;
 #else
 	u16 mm_ctx_user_psize;
 	u16 mm_ctx_sllp;
diff --git a/arch/powerpc/kernel/asm-offsets.c b/arch/powerpc/kernel/asm-offsets.c
index 4367e7df51a1..795505e27535 100644
--- a/arch/powerpc/kernel/asm-offsets.c
+++ b/arch/powerpc/kernel/asm-offsets.c
@@ -185,6 +185,7 @@ int main(void)
 #ifdef CONFIG_PPC_MM_SLICES
 	OFFSET(PACALOWSLICESPSIZE, paca_struct, mm_ctx_low_slices_psize);
 	OFFSET(PACAHIGHSLICEPSIZE, paca_struct, mm_ctx_high_slices_psize);
+	DEFINE(PACA_ADDR_LIMIT, offsetof(struct paca_struct, addr_limit));
 	DEFINE(MMUPSIZEDEFSIZE, sizeof(struct mmu_psize_def));
 #endif /* CONFIG_PPC_MM_SLICES */
 #endif
diff --git a/arch/powerpc/kernel/paca.c b/arch/powerpc/kernel/paca.c
index a2c7a6456ee6..8d63627e067f 100644
--- a/arch/powerpc/kernel/paca.c
+++ b/arch/powerpc/kernel/paca.c
@@ -254,6 +254,7 @@ void copy_mm_to_paca(struct mm_struct *mm)
 	get_paca()->mm_ctx_id = context->id;
 #ifdef CONFIG_PPC_MM_SLICES
 	VM_BUG_ON(!mm->context.addr_limit);
+	get_paca()->addr_limit = mm->context.addr_limit;
 	get_paca()->mm_ctx_low_slices_psize = context->low_slices_psize;
 	memcpy(&get_paca()->mm_ctx_high_slices_psize,
 	       &context->high_slices_psize, TASK_SLICE_ARRAY_SZ(mm));
diff --git a/arch/powerpc/mm/slb_low.S b/arch/powerpc/mm/slb_low.S
index 1c503d07e0fb..1519617aab36 100644
--- a/arch/powerpc/mm/slb_low.S
+++ b/arch/powerpc/mm/slb_low.S
@@ -149,7 +149,13 @@ END_MMU_FTR_SECTION_IFCLR(MMU_FTR_1T_SEGMENT)
 	 * For userspace addresses, make sure this is region 0.
 	 */
 	cmpdi	r9, 0
-	bne	8f
+	bne-	8f
+        /*
+         * user space make sure we are within the allowed limit
+	 */
+	ld	r11,PACA_ADDR_LIMIT(r13)
+	cmpld	r3,r11
+	bge-	8f
 
 	/* when using slices, we extract the psize off the slice bitmaps
 	 * and then we need to get the sllp encoding off the mmu_psize_defs
-- 
2.7.4

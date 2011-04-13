Return-Path: <michael@ozlabs.org>
To: <linuxppc-dev@ozlabs.org>
Message-Id: <d143d3f1ea9830a0f2ef7b0cf7148dab2bf0cc14.1302670946.git.michael@ellerman.id.au>
Subject: [PATCH 1/2] powerpc: Standardise on MMU_NO_CONTEXT
Date: Wed, 13 Apr 2011 15:00:04 +1000 (EST)
From: michael@ozlabs.org (Michael Ellerman)
Cc: David Gibson <david@gibson.dropbear.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Use MMU_NO_CONTEXT as the initialiser for mm_context.id on
nohash and hash64.

Signed-off-by: Michael Ellerman <michael@ellerman.id.au>
---
 arch/powerpc/include/asm/tlbflush.h  |    2 ++
 arch/powerpc/mm/mmu_context_hash64.c |    3 +--
 2 files changed, 3 insertions(+), 2 deletions(-)

v2: Updated to not break 40x.

diff --git a/arch/powerpc/include/asm/tlbflush.h b/arch/powerpc/include/asm/tlbflush.h
index d50a380..81143fc 100644
--- a/arch/powerpc/include/asm/tlbflush.h
+++ b/arch/powerpc/include/asm/tlbflush.h
@@ -79,6 +79,8 @@ static inline void local_flush_tlb_mm(struct mm_struct *mm)
 
 #elif defined(CONFIG_PPC_STD_MMU_64)
 
+#define MMU_NO_CONTEXT		0
+
 /*
  * TLB flushing for 64-bit hash-MMU CPUs
  */
diff --git a/arch/powerpc/mm/mmu_context_hash64.c b/arch/powerpc/mm/mmu_context_hash64.c
index 2535828..c585944 100644
--- a/arch/powerpc/mm/mmu_context_hash64.c
+++ b/arch/powerpc/mm/mmu_context_hash64.c
@@ -31,7 +31,6 @@ static DEFINE_IDA(mmu_context_ida);
  * Each segment contains 2^28 bytes.  Each context maps 2^44 bytes,
  * so we can support 2^19-1 contexts (19 == 35 + 28 - 44).
  */
-#define NO_CONTEXT	0
 #define MAX_CONTEXT	((1UL << 19) - 1)
 
 int __init_new_context(void)
@@ -95,5 +94,5 @@ void destroy_context(struct mm_struct *mm)
 {
 	__destroy_context(mm->context.id);
 	subpage_prot_free(mm);
-	mm->context.id = NO_CONTEXT;
+	mm->context.id = MMU_NO_CONTEXT;
 }
-- 
1.7.1

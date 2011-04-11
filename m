Return-Path: <michael@ozlabs.org>
To: <linuxppc-dev@ozlabs.org>
Message-Id: <b7bdf4b6e066671119a897d4d3dda800a096e0b5.1302503867.git.michael@ellerman.id.au>
From: Michael Ellerman <michael@ellerman.id.au>
Subject: [PATCH] powerpc: Standardise on MMU_NO_CONTEXT
Date: Mon, 11 Apr 2011 16:35:05 +1000 (EST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Use MMU_NO_CONTEXT as the initialiser for mm_context.id on book3e
and hash64.

Signed-off-by: Michael Ellerman <michael@ellerman.id.au>
---
 arch/powerpc/include/asm/mmu-book3e.h |    2 ++
 arch/powerpc/include/asm/mmu-hash64.h |    2 ++
 arch/powerpc/include/asm/tlbflush.h   |    2 --
 arch/powerpc/mm/mmu_context_hash64.c  |    3 +--
 4 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/include/asm/mmu-book3e.h b/arch/powerpc/include/asm/mmu-book3e.h
index 17194fc..f6e7d40 100644
--- a/arch/powerpc/include/asm/mmu-book3e.h
+++ b/arch/powerpc/include/asm/mmu-book3e.h
@@ -192,6 +192,8 @@
 
 extern unsigned int tlbcam_index;
 
+#define MMU_NO_CONTEXT      	((unsigned int)-1)
+
 typedef struct {
 	unsigned int	id;
 	unsigned int	active;
diff --git a/arch/powerpc/include/asm/mmu-hash64.h b/arch/powerpc/include/asm/mmu-hash64.h
index ae7b3ef..b589189 100644
--- a/arch/powerpc/include/asm/mmu-hash64.h
+++ b/arch/powerpc/include/asm/mmu-hash64.h
@@ -409,6 +409,8 @@ static inline void subpage_prot_init_new_context(struct mm_struct *mm) { }
 
 typedef unsigned long mm_context_id_t;
 
+#define MMU_NO_CONTEXT	0
+
 typedef struct {
 	mm_context_id_t id;
 	u16 user_psize;		/* page size index */
diff --git a/arch/powerpc/include/asm/tlbflush.h b/arch/powerpc/include/asm/tlbflush.h
index d50a380..852b139 100644
--- a/arch/powerpc/include/asm/tlbflush.h
+++ b/arch/powerpc/include/asm/tlbflush.h
@@ -32,8 +32,6 @@
 struct vm_area_struct;
 struct mm_struct;
 
-#define MMU_NO_CONTEXT      	((unsigned int)-1)
-
 extern void flush_tlb_range(struct vm_area_struct *vma, unsigned long start,
 			    unsigned long end);
 extern void flush_tlb_kernel_range(unsigned long start, unsigned long end);
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

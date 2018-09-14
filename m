Return-Path: <npiggin@gmail.com>
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com
 [IPv6:2607:f8b0:4864:20::543])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42Bfd45kGrzF3XK
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 15 Sep 2018 01:31:36 +1000 (AEST)
Received: by mail-pg1-x543.google.com with SMTP id i190-v6so4573382pgc.6
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 14 Sep 2018 08:31:36 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>
Subject: [PATCH 11/12] powerpc/64s/hash: provide arch_setup_exec hooks for
 hash slice setup
Date: Sat, 15 Sep 2018 01:30:55 +1000
Message-Id: <20180914153056.3644-12-npiggin@gmail.com>
In-Reply-To: <20180914153056.3644-1-npiggin@gmail.com>
References: <20180914153056.3644-1-npiggin@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This will be used by the SLB code in the next patch, but for now this
sets the slb_addr_limit to the correct size for 32-bit tasks.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 arch/powerpc/include/asm/book3s/64/mmu-hash.h |  2 ++
 arch/powerpc/include/asm/slice.h              |  1 +
 arch/powerpc/include/asm/thread_info.h        |  6 ++++++
 arch/powerpc/kernel/process.c                 |  9 +++++++++
 arch/powerpc/mm/mmu_context_book3s64.c        |  5 +++++
 arch/powerpc/mm/slice.c                       | 14 ++++++++++++++
 6 files changed, 37 insertions(+)

diff --git a/arch/powerpc/include/asm/book3s/64/mmu-hash.h b/arch/powerpc/include/asm/book3s/64/mmu-hash.h
index 4c8d413ce99a..fc68058554fa 100644
--- a/arch/powerpc/include/asm/book3s/64/mmu-hash.h
+++ b/arch/powerpc/include/asm/book3s/64/mmu-hash.h
@@ -487,6 +487,8 @@ int htab_remove_mapping(unsigned long vstart, unsigned long vend,
 extern void pseries_add_gpage(u64 addr, u64 page_size, unsigned long number_of_pages);
 extern void demote_segment_4k(struct mm_struct *mm, unsigned long addr);
 
+extern void hash__setup_new_exec(void);
+
 #ifdef CONFIG_PPC_PSERIES
 void hpte_init_pseries(void);
 #else
diff --git a/arch/powerpc/include/asm/slice.h b/arch/powerpc/include/asm/slice.h
index e40406cf5628..a595461c9cb0 100644
--- a/arch/powerpc/include/asm/slice.h
+++ b/arch/powerpc/include/asm/slice.h
@@ -32,6 +32,7 @@ void slice_set_range_psize(struct mm_struct *mm, unsigned long start,
 			   unsigned long len, unsigned int psize);
 
 void slice_init_new_context_exec(struct mm_struct *mm);
+void slice_setup_new_exec(void);
 
 #endif /* __ASSEMBLY__ */
 
diff --git a/arch/powerpc/include/asm/thread_info.h b/arch/powerpc/include/asm/thread_info.h
index 3c0002044bc9..f9a442bb5a72 100644
--- a/arch/powerpc/include/asm/thread_info.h
+++ b/arch/powerpc/include/asm/thread_info.h
@@ -72,6 +72,12 @@ static inline struct thread_info *current_thread_info(void)
 }
 
 extern int arch_dup_task_struct(struct task_struct *dst, struct task_struct *src);
+
+#ifdef CONFIG_PPC_BOOK3S_64
+void arch_setup_new_exec(void);
+#define arch_setup_new_exec arch_setup_new_exec
+#endif
+
 #endif /* __ASSEMBLY__ */
 
 /*
diff --git a/arch/powerpc/kernel/process.c b/arch/powerpc/kernel/process.c
index 913c5725cdb2..e4feb45ae4c6 100644
--- a/arch/powerpc/kernel/process.c
+++ b/arch/powerpc/kernel/process.c
@@ -1482,6 +1482,15 @@ void flush_thread(void)
 #endif /* CONFIG_HAVE_HW_BREAKPOINT */
 }
 
+#ifdef CONFIG_PPC_BOOK3S_64
+void arch_setup_new_exec(void)
+{
+	if (radix_enabled())
+		return;
+	hash__setup_new_exec();
+}
+#endif
+
 int set_thread_uses_vas(void)
 {
 #ifdef CONFIG_PPC_BOOK3S_64
diff --git a/arch/powerpc/mm/mmu_context_book3s64.c b/arch/powerpc/mm/mmu_context_book3s64.c
index dbd8f762140b..f7352c66b6b8 100644
--- a/arch/powerpc/mm/mmu_context_book3s64.c
+++ b/arch/powerpc/mm/mmu_context_book3s64.c
@@ -84,6 +84,11 @@ static int hash__init_new_context(struct mm_struct *mm)
 	return index;
 }
 
+void hash__setup_new_exec(void)
+{
+	slice_setup_new_exec();
+}
+
 static int radix__init_new_context(struct mm_struct *mm)
 {
 	unsigned long rts_field;
diff --git a/arch/powerpc/mm/slice.c b/arch/powerpc/mm/slice.c
index 606f424aac47..fc5b3a1ec666 100644
--- a/arch/powerpc/mm/slice.c
+++ b/arch/powerpc/mm/slice.c
@@ -746,6 +746,20 @@ void slice_init_new_context_exec(struct mm_struct *mm)
 		bitmap_fill(mask->high_slices, SLICE_NUM_HIGH);
 }
 
+#ifdef CONFIG_PPC_BOOK3S_64
+void slice_setup_new_exec(void)
+{
+	struct mm_struct *mm = current->mm;
+
+	slice_dbg("slice_setup_new_exec(mm=%p)\n", mm);
+
+	if (!is_32bit_task())
+		return;
+
+	mm->context.slb_addr_limit = DEFAULT_MAP_WINDOW;
+}
+#endif
+
 void slice_set_range_psize(struct mm_struct *mm, unsigned long start,
 			   unsigned long len, unsigned int psize)
 {
-- 
2.18.0

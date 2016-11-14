Return-Path: <bsingharora@gmail.com>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tHBxg61RQzDvNH
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 14 Nov 2016 11:59:35 +1100 (AEDT)
Received: from mail-pg0-x243.google.com (mail-pg0-x243.google.com
 [IPv6:2607:f8b0:400e:c05::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3tHBxg2FSDz9t1h
 for <linuxppc-dev@ozlabs.org>; Mon, 14 Nov 2016 11:59:35 +1100 (AEDT)
Received: by mail-pg0-x243.google.com with SMTP id p66so7475186pga.2
 for <linuxppc-dev@ozlabs.org>; Sun, 13 Nov 2016 16:59:35 -0800 (PST)
To: Michael Ellerman <mpe@ellerman.id.au>,
 linuxppc-dev <linuxppc-dev@ozlabs.org>
Subject: [PATCH] Rename early_init_mmu to early_init_mmu_primary
From: Balbir Singh <bsingharora@gmail.com>
Message-ID: <77c0eab1-c85c-94fa-4d33-da2bcba7aa86@gmail.com>
Date: Mon, 14 Nov 2016 11:59:29 +1100
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


It helps clarify that the action taken is just for the primary
CPU and more action might be required for in the secondaries
in early_init_mmu_secondary. This patch does not introduce
a functional change

Signed-off-by: Balbir Singh <bsingharora@gmail.com>
---
 arch/powerpc/include/asm/book3s/64/mmu.h | 10 +++++-----
 arch/powerpc/include/asm/mmu.h           |  2 +-
 arch/powerpc/kernel/setup_32.c           |  2 +-
 arch/powerpc/kernel/setup_64.c           |  2 +-
 arch/powerpc/mm/hash_utils_64.c          |  2 +-
 arch/powerpc/mm/pgtable-radix.c          |  2 +-
 arch/powerpc/mm/tlb_hash32.c             |  2 +-
 arch/powerpc/mm/tlb_nohash.c             |  4 ++--
 8 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/arch/powerpc/include/asm/book3s/64/mmu.h b/arch/powerpc/include/asm/book3s/64/mmu.h
index 8afb0e0..c60a629 100644
--- a/arch/powerpc/include/asm/book3s/64/mmu.h
+++ b/arch/powerpc/include/asm/book3s/64/mmu.h
@@ -104,13 +104,13 @@ void mmu_early_init_devtree(void);
 void hash__early_init_devtree(void);
 void radix__early_init_devtree(void);
 extern void radix_init_native(void);
-extern void hash__early_init_mmu(void);
-extern void radix__early_init_mmu(void);
-static inline void early_init_mmu(void)
+extern void hash__early_init_mmu_primary(void);
+extern void radix__early_init_mmu_primary(void);
+static inline void early_init_mmu_primary(void)
 {
 	if (radix_enabled())
-		return radix__early_init_mmu();
-	return hash__early_init_mmu();
+		return radix__early_init_mmu_primary();
+	return hash__early_init_mmu_primary();
 }
 extern void hash__early_init_mmu_secondary(void);
 extern void radix__early_init_mmu_secondary(void);
diff --git a/arch/powerpc/include/asm/mmu.h b/arch/powerpc/include/asm/mmu.h
index e883683..3f8226c 100644
--- a/arch/powerpc/include/asm/mmu.h
+++ b/arch/powerpc/include/asm/mmu.h
@@ -284,7 +284,7 @@ static inline bool early_radix_enabled(void)
 
 #ifndef __ASSEMBLY__
 /* MMU initialization */
-extern void early_init_mmu(void);
+extern void early_init_mmu_primary(void);
 extern void early_init_mmu_secondary(void);
 extern void setup_initial_memory_limit(phys_addr_t first_memblock_base,
 				       phys_addr_t first_memblock_size);
diff --git a/arch/powerpc/kernel/setup_32.c b/arch/powerpc/kernel/setup_32.c
index 5fe7918..e1ee6d6 100644
--- a/arch/powerpc/kernel/setup_32.c
+++ b/arch/powerpc/kernel/setup_32.c
@@ -118,7 +118,7 @@ notrace void __init machine_init(u64 dt_ptr)
 	/* Do some early initialization based on the flat device tree */
 	early_init_devtree(__va(dt_ptr));
 
-	early_init_mmu();
+	early_init_mmu_primary();
 
 	setup_kdump_trampoline();
 }
diff --git a/arch/powerpc/kernel/setup_64.c b/arch/powerpc/kernel/setup_64.c
index c3e1290..5d1ba51a 100644
--- a/arch/powerpc/kernel/setup_64.c
+++ b/arch/powerpc/kernel/setup_64.c
@@ -303,7 +303,7 @@ void __init early_setup(unsigned long dt_ptr)
 	setup_feature_keys();
 
 	/* Initialize the hash table or TLB handling */
-	early_init_mmu();
+	early_init_mmu_primary();
 
 	/*
 	 * At this point, we can let interrupts switch to virtual mode
diff --git a/arch/powerpc/mm/hash_utils_64.c b/arch/powerpc/mm/hash_utils_64.c
index 44d3c3a..e0acd6d 100644
--- a/arch/powerpc/mm/hash_utils_64.c
+++ b/arch/powerpc/mm/hash_utils_64.c
@@ -964,7 +964,7 @@ void __init hash__early_init_devtree(void)
 	htab_scan_page_sizes();
 }
 
-void __init hash__early_init_mmu(void)
+void __init hash__early_init_mmu_primary(void)
 {
 	htab_init_page_sizes();
 
diff --git a/arch/powerpc/mm/pgtable-radix.c b/arch/powerpc/mm/pgtable-radix.c
index ed7bddc..968e29c 100644
--- a/arch/powerpc/mm/pgtable-radix.c
+++ b/arch/powerpc/mm/pgtable-radix.c
@@ -320,7 +320,7 @@ static void update_hid_for_radix(void)
 		cpu_relax();
 }
 
-void __init radix__early_init_mmu(void)
+void __init radix__early_init_mmu_primary(void)
 {
 	unsigned long lpcr;
 
diff --git a/arch/powerpc/mm/tlb_hash32.c b/arch/powerpc/mm/tlb_hash32.c
index 702d768..c006f04 100644
--- a/arch/powerpc/mm/tlb_hash32.c
+++ b/arch/powerpc/mm/tlb_hash32.c
@@ -168,6 +168,6 @@ void flush_tlb_range(struct vm_area_struct *vma, unsigned long start,
 }
 EXPORT_SYMBOL(flush_tlb_range);
 
-void __init early_init_mmu(void)
+void __init early_init_mmu_primary(void)
 {
 }
diff --git a/arch/powerpc/mm/tlb_nohash.c b/arch/powerpc/mm/tlb_nohash.c
index 050badc..e704b33 100644
--- a/arch/powerpc/mm/tlb_nohash.c
+++ b/arch/powerpc/mm/tlb_nohash.c
@@ -718,7 +718,7 @@ static void __init early_mmu_set_memory_limit(void)
 }
 
 /* boot cpu only */
-void __init early_init_mmu(void)
+void __init early_init_mmu_primary(void)
 {
 	early_init_mmu_global();
 	early_init_this_mmu();
@@ -770,7 +770,7 @@ void setup_initial_memory_limit(phys_addr_t first_memblock_base,
 	memblock_set_current_limit(first_memblock_base + ppc64_rma_size);
 }
 #else /* ! CONFIG_PPC64 */
-void __init early_init_mmu(void)
+void __init early_init_mmu_primary(void)
 {
 #ifdef CONFIG_PPC_47x
 	early_init_mmu_47x();
-- 
2.5.5

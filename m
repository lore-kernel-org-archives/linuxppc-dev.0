Return-Path: <anton@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 5488A1A08E4
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 17 Sep 2014 14:39:49 +1000 (EST)
From: Anton Blanchard <anton@samba.org>
To: benh@kernel.crashing.org,
	paulus@samba.org,
	mpe@ellerman.id.au
Subject: [PATCH 6/6] powerpc: Add printk levels to powerpc code
Date: Wed, 17 Sep 2014 14:39:39 +1000
Message-Id: <1410928779-20938-6-git-send-email-anton@samba.org>
In-Reply-To: <1410928779-20938-1-git-send-email-anton@samba.org>
References: <1410928779-20938-1-git-send-email-anton@samba.org>
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Add printk levels to some places in the powerpc port.

Signed-off-by: Anton Blanchard <anton@samba.org>
---
 arch/powerpc/include/asm/pgtable-ppc32.h    |  4 ++--
 arch/powerpc/include/asm/pgtable-ppc64-4k.h |  2 +-
 arch/powerpc/include/asm/pgtable-ppc64.h    |  6 +++---
 arch/powerpc/kernel/irq.c                   |  6 +++---
 arch/powerpc/kernel/setup-common.c          |  2 +-
 arch/powerpc/kernel/setup_64.c              | 20 ++++++++++----------
 6 files changed, 20 insertions(+), 20 deletions(-)

diff --git a/arch/powerpc/include/asm/pgtable-ppc32.h b/arch/powerpc/include/asm/pgtable-ppc32.h
index 622672f..945e47a 100644
--- a/arch/powerpc/include/asm/pgtable-ppc32.h
+++ b/arch/powerpc/include/asm/pgtable-ppc32.h
@@ -48,10 +48,10 @@ extern int icache_44x_need_flush;
 #define FIRST_USER_ADDRESS	0
 
 #define pte_ERROR(e) \
-	printk("%s:%d: bad pte %llx.\n", __FILE__, __LINE__, \
+	pr_err("%s:%d: bad pte %llx.\n", __FILE__, __LINE__, \
 		(unsigned long long)pte_val(e))
 #define pgd_ERROR(e) \
-	printk("%s:%d: bad pgd %08lx.\n", __FILE__, __LINE__, pgd_val(e))
+	pr_err("%s:%d: bad pgd %08lx.\n", __FILE__, __LINE__, pgd_val(e))
 
 /*
  * This is the bottom of the PKMAP area with HIGHMEM or an arbitrary
diff --git a/arch/powerpc/include/asm/pgtable-ppc64-4k.h b/arch/powerpc/include/asm/pgtable-ppc64-4k.h
index 12798c9..7b93568 100644
--- a/arch/powerpc/include/asm/pgtable-ppc64-4k.h
+++ b/arch/powerpc/include/asm/pgtable-ppc64-4k.h
@@ -64,7 +64,7 @@
     (((addr) >> PUD_SHIFT) & (PTRS_PER_PUD - 1)))
 
 #define pud_ERROR(e) \
-	printk("%s:%d: bad pud %08lx.\n", __FILE__, __LINE__, pud_val(e))
+	pr_err("%s:%d: bad pud %08lx.\n", __FILE__, __LINE__, pud_val(e))
 
 /*
  * On all 4K setups, remap_4k_pfn() equates to remap_pfn_range() */
diff --git a/arch/powerpc/include/asm/pgtable-ppc64.h b/arch/powerpc/include/asm/pgtable-ppc64.h
index 7b3d54f..ae153c4 100644
--- a/arch/powerpc/include/asm/pgtable-ppc64.h
+++ b/arch/powerpc/include/asm/pgtable-ppc64.h
@@ -328,11 +328,11 @@ static inline void __ptep_set_access_flags(pte_t *ptep, pte_t entry)
 #define pte_same(A,B)	(((pte_val(A) ^ pte_val(B)) & ~_PAGE_HPTEFLAGS) == 0)
 
 #define pte_ERROR(e) \
-	printk("%s:%d: bad pte %08lx.\n", __FILE__, __LINE__, pte_val(e))
+	pr_err("%s:%d: bad pte %08lx.\n", __FILE__, __LINE__, pte_val(e))
 #define pmd_ERROR(e) \
-	printk("%s:%d: bad pmd %08lx.\n", __FILE__, __LINE__, pmd_val(e))
+	pr_err("%s:%d: bad pmd %08lx.\n", __FILE__, __LINE__, pmd_val(e))
 #define pgd_ERROR(e) \
-	printk("%s:%d: bad pgd %08lx.\n", __FILE__, __LINE__, pgd_val(e))
+	pr_err("%s:%d: bad pgd %08lx.\n", __FILE__, __LINE__, pgd_val(e))
 
 /* Encode and de-code a swap entry */
 #define __swp_type(entry)	(((entry).val >> 1) & 0x3f)
diff --git a/arch/powerpc/kernel/irq.c b/arch/powerpc/kernel/irq.c
index 4c5891d..8eb857f 100644
--- a/arch/powerpc/kernel/irq.c
+++ b/arch/powerpc/kernel/irq.c
@@ -444,13 +444,13 @@ void migrate_irqs(void)
 
 		cpumask_and(mask, data->affinity, map);
 		if (cpumask_any(mask) >= nr_cpu_ids) {
-			printk("Breaking affinity for irq %i\n", irq);
+			pr_warn("Breaking affinity for irq %i\n", irq);
 			cpumask_copy(mask, map);
 		}
 		if (chip->irq_set_affinity)
 			chip->irq_set_affinity(data, mask, true);
 		else if (desc->action && !(warned++))
-			printk("Cannot set affinity for irq %i\n", irq);
+			pr_err("Cannot set affinity for irq %i\n", irq);
 	}
 
 	free_cpumask_var(mask);
@@ -470,7 +470,7 @@ static inline void check_stack_overflow(void)
 
 	/* check for stack overflow: is there less than 2KB free? */
 	if (unlikely(sp < (sizeof(struct thread_info) + 2048))) {
-		printk("do_IRQ: stack overflow: %ld\n",
+		pr_err("do_IRQ: stack overflow: %ld\n",
 			sp - sizeof(struct thread_info));
 		dump_stack();
 	}
diff --git a/arch/powerpc/kernel/setup-common.c b/arch/powerpc/kernel/setup-common.c
index 0df37f5..1362cd6 100644
--- a/arch/powerpc/kernel/setup-common.c
+++ b/arch/powerpc/kernel/setup-common.c
@@ -383,7 +383,7 @@ void __init check_for_initrd(void)
 		initrd_start = initrd_end = 0;
 
 	if (initrd_start)
-		printk("Found initrd at 0x%lx:0x%lx\n", initrd_start, initrd_end);
+		pr_info("Found initrd at 0x%lx:0x%lx\n", initrd_start, initrd_end);
 
 	DBG(" <- check_for_initrd()\n");
 #endif /* CONFIG_BLK_DEV_INITRD */
diff --git a/arch/powerpc/kernel/setup_64.c b/arch/powerpc/kernel/setup_64.c
index a3ba9d0..a8c9620 100644
--- a/arch/powerpc/kernel/setup_64.c
+++ b/arch/powerpc/kernel/setup_64.c
@@ -522,26 +522,26 @@ void __init setup_system(void)
 	smp_release_cpus();
 #endif
 
-	printk("Starting Linux PPC64 %s\n", init_utsname()->version);
+	pr_info("Starting Linux PPC64 %s\n", init_utsname()->version);
 
-	printk("-----------------------------------------------------\n");
-	printk("ppc64_pft_size                = 0x%llx\n", ppc64_pft_size);
-	printk("physicalMemorySize            = 0x%llx\n", memblock_phys_mem_size());
+	pr_info("-----------------------------------------------------\n");
+	pr_info("ppc64_pft_size                = 0x%llx\n", ppc64_pft_size);
+	pr_info("physicalMemorySize            = 0x%llx\n", memblock_phys_mem_size());
 	if (ppc64_caches.dline_size != 0x80)
-		printk("ppc64_caches.dcache_line_size = 0x%x\n",
+		pr_info("ppc64_caches.dcache_line_size = 0x%x\n",
 		       ppc64_caches.dline_size);
 	if (ppc64_caches.iline_size != 0x80)
-		printk("ppc64_caches.icache_line_size = 0x%x\n",
+		pr_info("ppc64_caches.icache_line_size = 0x%x\n",
 		       ppc64_caches.iline_size);
 #ifdef CONFIG_PPC_STD_MMU_64
 	if (htab_address)
-		printk("htab_address                  = 0x%p\n", htab_address);
-	printk("htab_hash_mask                = 0x%lx\n", htab_hash_mask);
+		pr_info("htab_address                  = 0x%p\n", htab_address);
+	pr_info("htab_hash_mask                = 0x%lx\n", htab_hash_mask);
 #endif /* CONFIG_PPC_STD_MMU_64 */
 	if (PHYSICAL_START > 0)
-		printk("physical_start                = 0x%llx\n",
+		pr_info("physical_start                = 0x%llx\n",
 		       (unsigned long long)PHYSICAL_START);
-	printk("-----------------------------------------------------\n");
+	pr_info("-----------------------------------------------------\n");
 
 	DBG(" <- setup_system()\n");
 }
-- 
1.9.1

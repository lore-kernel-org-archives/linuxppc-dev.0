Return-Path: <paulus@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tKqNz35XfzDvt1
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 18 Nov 2016 18:28:51 +1100 (AEDT)
From: Paul Mackerras <paulus@ozlabs.org>
To: kvm@vger.kernel.org,
	kvm-ppc@vger.kernel.org,
	linuxppc-dev@ozlabs.org
Subject: [PATCH 02/13] powerpc/64: Provide functions for accessing POWER9
 partition table
Date: Fri, 18 Nov 2016 18:28:31 +1100
Message-Id: <1479454122-26994-3-git-send-email-paulus@ozlabs.org>
In-Reply-To: <1479454122-26994-1-git-send-email-paulus@ozlabs.org>
References: <1479454122-26994-1-git-send-email-paulus@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

POWER9 requires the host to set up a partition table, which is a
table in memory indexed by logical partition ID (LPID) which
contains the pointers to page tables and process tables for the
host and each guest.

This factors out the initialization of the partition table into
a single function.  This code was previously duplicated between
hash_utils_64.c and pgtable-radix.c.

This provides a function for setting a partition table entry,
which is used in early MMU initialization, and will be used by
KVM whenever a guest is created.  This function includes a tlbie
instruction which will flush all TLB entries for the LPID and
all caches of the partition table entry for the LPID, across the
system.

This also moves a call to memblock_set_current_limit(), which was
in radix_init_partition_table(), but has nothing to do with the
partition table.  By analogy with the similar code for hash, the
call gets moved to near the end of radix__early_init_mmu().  It
now gets called when running as a guest, whereas previously it
would only be called if the kernel is running as the host.

Signed-off-by: Paul Mackerras <paulus@ozlabs.org>
---
 arch/powerpc/include/asm/mmu.h  |  5 +++++
 arch/powerpc/mm/hash_utils_64.c | 28 ++++------------------------
 arch/powerpc/mm/pgtable-radix.c | 18 ++++++------------
 arch/powerpc/mm/pgtable_64.c    | 33 +++++++++++++++++++++++++++++++++
 4 files changed, 48 insertions(+), 36 deletions(-)

diff --git a/arch/powerpc/include/asm/mmu.h b/arch/powerpc/include/asm/mmu.h
index e883683..060b40b 100644
--- a/arch/powerpc/include/asm/mmu.h
+++ b/arch/powerpc/include/asm/mmu.h
@@ -208,6 +208,11 @@ extern u64 ppc64_rma_size;
 /* Cleanup function used by kexec */
 extern void mmu_cleanup_all(void);
 extern void radix__mmu_cleanup_all(void);
+
+/* Functions for creating and updating partition table on POWER9 */
+extern void mmu_partition_table_init(void);
+extern void mmu_partition_table_set_entry(unsigned int lpid, unsigned long dw0,
+					  unsigned long dw1);
 #endif /* CONFIG_PPC64 */
 
 struct mm_struct;
diff --git a/arch/powerpc/mm/hash_utils_64.c b/arch/powerpc/mm/hash_utils_64.c
index 44d3c3a..b9a062f 100644
--- a/arch/powerpc/mm/hash_utils_64.c
+++ b/arch/powerpc/mm/hash_utils_64.c
@@ -792,37 +792,17 @@ static void update_hid_for_hash(void)
 static void __init hash_init_partition_table(phys_addr_t hash_table,
 					     unsigned long htab_size)
 {
-	unsigned long ps_field;
-	unsigned long patb_size = 1UL << PATB_SIZE_SHIFT;
+	mmu_partition_table_init();
 
 	/*
-	 * slb llp encoding for the page size used in VPM real mode.
-	 * We can ignore that for lpid 0
+	 * PS field (VRMA page size) is not used for LPID 0, hence set to 0.
+	 * For now, UPRT is 0 and we have no segment table.
 	 */
-	ps_field = 0;
 	htab_size =  __ilog2(htab_size) - 18;
-
-	BUILD_BUG_ON_MSG((PATB_SIZE_SHIFT > 24), "Partition table size too large.");
-	partition_tb = __va(memblock_alloc_base(patb_size, patb_size,
-						MEMBLOCK_ALLOC_ANYWHERE));
-
-	/* Initialize the Partition Table with no entries */
-	memset((void *)partition_tb, 0, patb_size);
-	partition_tb->patb0 = cpu_to_be64(ps_field | hash_table | htab_size);
-	/*
-	 * FIXME!! This should be done via update_partition table
-	 * For now UPRT is 0 for us.
-	 */
-	partition_tb->patb1 = 0;
+	mmu_partition_table_set_entry(0, hash_table | htab_size, 0);
 	pr_info("Partition table %p\n", partition_tb);
 	if (cpu_has_feature(CPU_FTR_POWER9_DD1))
 		update_hid_for_hash();
-	/*
-	 * update partition table control register,
-	 * 64 K size.
-	 */
-	mtspr(SPRN_PTCR, __pa(partition_tb) | (PATB_SIZE_SHIFT - 12));
-
 }
 
 static void __init htab_initialize(void)
diff --git a/arch/powerpc/mm/pgtable-radix.c b/arch/powerpc/mm/pgtable-radix.c
index ed7bddc..186f1ad 100644
--- a/arch/powerpc/mm/pgtable-radix.c
+++ b/arch/powerpc/mm/pgtable-radix.c
@@ -177,23 +177,15 @@ static void __init radix_init_pgtable(void)
 
 static void __init radix_init_partition_table(void)
 {
-	unsigned long rts_field;
+	unsigned long rts_field, dw0;
 
+	mmu_partition_table_init();
 	rts_field = radix__get_tree_size();
+	dw0 = rts_field | __pa(init_mm.pgd) | RADIX_PGD_INDEX_SIZE | PATB_HR;
+	mmu_partition_table_set_entry(0, dw0, 0);
 
-	BUILD_BUG_ON_MSG((PATB_SIZE_SHIFT > 24), "Partition table size too large.");
-	partition_tb = early_alloc_pgtable(1UL << PATB_SIZE_SHIFT);
-	partition_tb->patb0 = cpu_to_be64(rts_field | __pa(init_mm.pgd) |
-					  RADIX_PGD_INDEX_SIZE | PATB_HR);
 	pr_info("Initializing Radix MMU\n");
 	pr_info("Partition table %p\n", partition_tb);
-
-	memblock_set_current_limit(MEMBLOCK_ALLOC_ANYWHERE);
-	/*
-	 * update partition table control register,
-	 * 64 K size.
-	 */
-	mtspr(SPRN_PTCR, __pa(partition_tb) | (PATB_SIZE_SHIFT - 12));
 }
 
 void __init radix_init_native(void)
@@ -378,6 +370,8 @@ void __init radix__early_init_mmu(void)
 		radix_init_partition_table();
 	}
 
+	memblock_set_current_limit(MEMBLOCK_ALLOC_ANYWHERE);
+
 	radix_init_pgtable();
 }
 
diff --git a/arch/powerpc/mm/pgtable_64.c b/arch/powerpc/mm/pgtable_64.c
index f5e8d4e..fef0890 100644
--- a/arch/powerpc/mm/pgtable_64.c
+++ b/arch/powerpc/mm/pgtable_64.c
@@ -431,3 +431,36 @@ void pgtable_free_tlb(struct mmu_gather *tlb, void *table, int shift)
 	}
 }
 #endif
+
+#ifdef CONFIG_PPC_BOOK3S_64
+void mmu_partition_table_init(void)
+{
+	unsigned long patb_size = 1UL << PATB_SIZE_SHIFT;
+
+	BUILD_BUG_ON_MSG((PATB_SIZE_SHIFT > 24), "Partition table size too large.");
+	partition_tb = __va(memblock_alloc_base(patb_size, patb_size,
+						MEMBLOCK_ALLOC_ANYWHERE));
+
+	/* Initialize the Partition Table with no entries */
+	memset((void *)partition_tb, 0, patb_size);
+
+	/*
+	 * update partition table control register,
+	 * 64 K size.
+	 */
+	mtspr(SPRN_PTCR, __pa(partition_tb) | (PATB_SIZE_SHIFT - 12));
+}
+
+void mmu_partition_table_set_entry(unsigned int lpid, unsigned long dw0,
+				   unsigned long dw1)
+{
+	partition_tb[lpid].patb0 = cpu_to_be64(dw0);
+	partition_tb[lpid].patb1 = cpu_to_be64(dw1);
+
+	/* Global flush of TLBs and partition table caches for this lpid */
+	asm volatile("ptesync");
+	asm volatile(PPC_TLBIE_5(%0,%1,2,0,0) : : "r"(0x800), "r" (lpid));
+	asm volatile("eieio; tlbsync; ptesync" : : : "memory");
+}
+EXPORT_SYMBOL_GPL(mmu_partition_table_set_entry);
+#endif /* CONFIG_PPC_BOOK3S_64 */
-- 
2.7.4

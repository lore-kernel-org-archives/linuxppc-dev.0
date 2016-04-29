Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qxDxw19PKzDqB2
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 29 Apr 2016 23:27:00 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: <linuxppc-dev@ozlabs.org>
Cc: aneesh.kumar@linux.vnet.ibm.com, bsingharora@gmail.com,
 Paul Mackerras <paulus@samba.org>
Subject: [PATCH v3 20/70] powerpc/mm/hash: Add support for Power9 Hash
Date: Fri, 29 Apr 2016 23:25:43 +1000
Message-Id: <1461936393-10131-20-git-send-email-mpe@ellerman.id.au>
In-Reply-To: <1461936393-10131-1-git-send-email-mpe@ellerman.id.au>
References: <1461936393-10131-1-git-send-email-mpe@ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>

PowerISA 3.0 adds a parition table indexed by LPID. Parition table
allows us to specify the MMU model that will be used for guest and host
translation.

This patch adds support with SLB based hash model (UPRT = 0). What is
required with this model is to support the new hash page table entry
format and also setup partition table such that we use hash table for
address translation.

We don't have segment table support yet.

In order to make sure we don't load KVM module on Power9 (since we don't
have kvm support yet) this patch also disables KVM on Power9.

Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/include/asm/book3s/64/mmu-hash.h | 13 +++++++--
 arch/powerpc/kvm/book3s_hv.c                  |  6 ++++
 arch/powerpc/kvm/book3s_pr.c                  |  6 +++-
 arch/powerpc/mm/hash_native_64.c              | 11 ++++++-
 arch/powerpc/mm/hash_utils_64.c               | 42 +++++++++++++++++++++++++--
 arch/powerpc/mm/pgtable_64.c                  |  7 +++++
 arch/powerpc/platforms/ps3/htab.c             |  2 +-
 arch/powerpc/platforms/pseries/lpar.c         |  2 +-
 8 files changed, 81 insertions(+), 8 deletions(-)

diff --git a/arch/powerpc/include/asm/book3s/64/mmu-hash.h b/arch/powerpc/include/asm/book3s/64/mmu-hash.h
index ce73736b42db..843b5d839904 100644
--- a/arch/powerpc/include/asm/book3s/64/mmu-hash.h
+++ b/arch/powerpc/include/asm/book3s/64/mmu-hash.h
@@ -78,6 +78,10 @@
 #define HPTE_V_SECONDARY	ASM_CONST(0x0000000000000002)
 #define HPTE_V_VALID		ASM_CONST(0x0000000000000001)
 
+/*
+ * ISA 3.0 have a different HPTE format.
+ */
+#define HPTE_R_3_0_SSIZE_SHIFT	58
 #define HPTE_R_PP0		ASM_CONST(0x8000000000000000)
 #define HPTE_R_TS		ASM_CONST(0x4000000000000000)
 #define HPTE_R_KEY_HI		ASM_CONST(0x3000000000000000)
@@ -224,7 +228,8 @@ static inline unsigned long hpte_encode_avpn(unsigned long vpn, int psize,
 	 */
 	v = (vpn >> (23 - VPN_SHIFT)) & ~(mmu_psize_defs[psize].avpnm);
 	v <<= HPTE_V_AVPN_SHIFT;
-	v |= ((unsigned long) ssize) << HPTE_V_SSIZE_SHIFT;
+	if (!cpu_has_feature(CPU_FTR_ARCH_300))
+		v |= ((unsigned long) ssize) << HPTE_V_SSIZE_SHIFT;
 	return v;
 }
 
@@ -248,8 +253,12 @@ static inline unsigned long hpte_encode_v(unsigned long vpn, int base_psize,
  * aligned for the requested page size
  */
 static inline unsigned long hpte_encode_r(unsigned long pa, int base_psize,
-					  int actual_psize)
+					  int actual_psize, int ssize)
 {
+
+	if (cpu_has_feature(CPU_FTR_ARCH_300))
+		pa |= ((unsigned long) ssize) << HPTE_R_3_0_SSIZE_SHIFT;
+
 	/* A 4K page needs no special encoding */
 	if (actual_psize == MMU_PAGE_4K)
 		return pa & HPTE_R_RPN;
diff --git a/arch/powerpc/kvm/book3s_hv.c b/arch/powerpc/kvm/book3s_hv.c
index 84fb4fcfaa41..4cd37b498fbd 100644
--- a/arch/powerpc/kvm/book3s_hv.c
+++ b/arch/powerpc/kvm/book3s_hv.c
@@ -3271,6 +3271,12 @@ static int kvmppc_core_check_processor_compat_hv(void)
 	if (!cpu_has_feature(CPU_FTR_HVMODE) ||
 	    !cpu_has_feature(CPU_FTR_ARCH_206))
 		return -EIO;
+	/*
+	 * Disable KVM for Power9, untill the required bits merged.
+	 */
+	if (cpu_has_feature(CPU_FTR_ARCH_300))
+		return -EIO;
+
 	return 0;
 }
 
diff --git a/arch/powerpc/kvm/book3s_pr.c b/arch/powerpc/kvm/book3s_pr.c
index 95bceca8f40e..ffbaf40b7f31 100644
--- a/arch/powerpc/kvm/book3s_pr.c
+++ b/arch/powerpc/kvm/book3s_pr.c
@@ -1683,7 +1683,11 @@ static void kvmppc_core_destroy_vm_pr(struct kvm *kvm)
 
 static int kvmppc_core_check_processor_compat_pr(void)
 {
-	/* we are always compatible */
+	/*
+	 * Disable KVM for Power9 untill the required bits merged.
+	 */
+	if (cpu_has_feature(CPU_FTR_ARCH_300))
+		return -EIO;
 	return 0;
 }
 
diff --git a/arch/powerpc/mm/hash_native_64.c b/arch/powerpc/mm/hash_native_64.c
index 8eaac81347fd..d873f6507f72 100644
--- a/arch/powerpc/mm/hash_native_64.c
+++ b/arch/powerpc/mm/hash_native_64.c
@@ -221,7 +221,7 @@ static long native_hpte_insert(unsigned long hpte_group, unsigned long vpn,
 		return -1;
 
 	hpte_v = hpte_encode_v(vpn, psize, apsize, ssize) | vflags | HPTE_V_VALID;
-	hpte_r = hpte_encode_r(pa, psize, apsize) | rflags;
+	hpte_r = hpte_encode_r(pa, psize, apsize, ssize) | rflags;
 
 	if (!(vflags & HPTE_V_BOLTED)) {
 		DBG_LOW(" i=%x hpte_v=%016lx, hpte_r=%016lx\n",
@@ -719,6 +719,12 @@ static void native_flush_hash_range(unsigned long number, int local)
 	local_irq_restore(flags);
 }
 
+static int native_update_partition_table(u64 patb1)
+{
+	partition_tb->patb1 = cpu_to_be64(patb1);
+	return 0;
+}
+
 void __init hpte_init_native(void)
 {
 	ppc_md.hpte_invalidate	= native_hpte_invalidate;
@@ -729,4 +735,7 @@ void __init hpte_init_native(void)
 	ppc_md.hpte_clear_all	= native_hpte_clear;
 	ppc_md.flush_hash_range = native_flush_hash_range;
 	ppc_md.hugepage_invalidate   = native_hugepage_invalidate;
+
+	if (cpu_has_feature(CPU_FTR_ARCH_300))
+		ppc_md.update_partition_table = native_update_partition_table;
 }
diff --git a/arch/powerpc/mm/hash_utils_64.c b/arch/powerpc/mm/hash_utils_64.c
index eb928d86ce01..f76a033d1e16 100644
--- a/arch/powerpc/mm/hash_utils_64.c
+++ b/arch/powerpc/mm/hash_utils_64.c
@@ -676,6 +676,41 @@ int remove_section_mapping(unsigned long start, unsigned long end)
 }
 #endif /* CONFIG_MEMORY_HOTPLUG */
 
+static void __init hash_init_partition_table(phys_addr_t hash_table,
+					     unsigned long pteg_count)
+{
+	unsigned long ps_field;
+	unsigned long htab_size;
+	unsigned long patb_size = 1UL << PATB_SIZE_SHIFT;
+
+	/*
+	 * slb llp encoding for the page size used in VPM real mode.
+	 * We can ignore that for lpid 0
+	 */
+	ps_field = 0;
+	htab_size =  __ilog2(pteg_count) - 11;
+
+	BUILD_BUG_ON_MSG((PATB_SIZE_SHIFT > 24), "Partition table size too large.");
+	partition_tb = __va(memblock_alloc_base(patb_size, patb_size,
+						MEMBLOCK_ALLOC_ANYWHERE));
+
+	/* Initialize the Partition Table with no entries */
+	memset((void *)partition_tb, 0, patb_size);
+	partition_tb->patb0 = cpu_to_be64(ps_field | hash_table | htab_size);
+	/*
+	 * FIXME!! This should be done via update_partition table
+	 * For now UPRT is 0 for us.
+	 */
+	partition_tb->patb1 = 0;
+	DBG("Partition table %p\n", partition_tb);
+	/*
+	 * update partition table control register,
+	 * 64 K size.
+	 */
+	mtspr(SPRN_PTCR, __pa(partition_tb) | (PATB_SIZE_SHIFT - 12));
+
+}
+
 static void __init htab_initialize(void)
 {
 	unsigned long table;
@@ -744,8 +779,11 @@ static void __init htab_initialize(void)
 		/* Initialize the HPT with no entries */
 		memset((void *)table, 0, htab_size_bytes);
 
-		/* Set SDR1 */
-		mtspr(SPRN_SDR1, _SDR1);
+		if (!cpu_has_feature(CPU_FTR_ARCH_300))
+			/* Set SDR1 */
+			mtspr(SPRN_SDR1, _SDR1);
+		else
+			hash_init_partition_table(table, pteg_count);
 	}
 
 	prot = pgprot_val(PAGE_KERNEL);
diff --git a/arch/powerpc/mm/pgtable_64.c b/arch/powerpc/mm/pgtable_64.c
index 177e4893438c..8f3b2942fba8 100644
--- a/arch/powerpc/mm/pgtable_64.c
+++ b/arch/powerpc/mm/pgtable_64.c
@@ -69,6 +69,13 @@
 #endif
 #endif
 
+#ifdef CONFIG_PPC_BOOK3S_64
+/*
+ * partition table and process table for ISA 3.0
+ */
+struct prtb_entry *process_tb;
+struct patb_entry *partition_tb;
+#endif
 unsigned long ioremap_bot = IOREMAP_BASE;
 
 #ifdef CONFIG_PPC_MMU_NOHASH
diff --git a/arch/powerpc/platforms/ps3/htab.c b/arch/powerpc/platforms/ps3/htab.c
index 2f95d33cf34a..c9a3e677192a 100644
--- a/arch/powerpc/platforms/ps3/htab.c
+++ b/arch/powerpc/platforms/ps3/htab.c
@@ -63,7 +63,7 @@ static long ps3_hpte_insert(unsigned long hpte_group, unsigned long vpn,
 	vflags &= ~HPTE_V_SECONDARY;
 
 	hpte_v = hpte_encode_v(vpn, psize, apsize, ssize) | vflags | HPTE_V_VALID;
-	hpte_r = hpte_encode_r(ps3_mm_phys_to_lpar(pa), psize, apsize) | rflags;
+	hpte_r = hpte_encode_r(ps3_mm_phys_to_lpar(pa), psize, apsize, ssize) | rflags;
 
 	spin_lock_irqsave(&ps3_htab_lock, flags);
 
diff --git a/arch/powerpc/platforms/pseries/lpar.c b/arch/powerpc/platforms/pseries/lpar.c
index 0d4608990702..e4ceba2b1551 100644
--- a/arch/powerpc/platforms/pseries/lpar.c
+++ b/arch/powerpc/platforms/pseries/lpar.c
@@ -139,7 +139,7 @@ static long pSeries_lpar_hpte_insert(unsigned long hpte_group,
 			 hpte_group, vpn,  pa, rflags, vflags, psize);
 
 	hpte_v = hpte_encode_v(vpn, psize, apsize, ssize) | vflags | HPTE_V_VALID;
-	hpte_r = hpte_encode_r(pa, psize, apsize) | rflags;
+	hpte_r = hpte_encode_r(pa, psize, apsize, ssize) | rflags;
 
 	if (!(vflags & HPTE_V_BOLTED))
 		pr_devel(" hpte_v=%016lx, hpte_r=%016lx\n", hpte_v, hpte_r);
-- 
2.5.0

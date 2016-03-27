Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e19.ny.us.ibm.com (e19.ny.us.ibm.com [129.33.205.209])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qXqpk1rByzDqFV
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 27 Mar 2016 19:25:02 +1100 (AEDT)
Received: from localhost
 by e19.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Sun, 27 Mar 2016 04:25:00 -0400
Received: from b01cxnp22034.gho.pok.ibm.com (b01cxnp22034.gho.pok.ibm.com
 [9.57.198.24])
 by d01dlp02.pok.ibm.com (Postfix) with ESMTP id 59C1C6E803F
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 27 Mar 2016 04:11:47 -0400 (EDT)
Received: from d01av03.pok.ibm.com (d01av03.pok.ibm.com [9.56.224.217])
 by b01cxnp22034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u2R8OvlS21823648
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 27 Mar 2016 08:24:57 GMT
Received: from d01av03.pok.ibm.com (localhost [127.0.0.1])
 by d01av03.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u2R8OvDY017888
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 27 Mar 2016 04:24:57 -0400
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au
Cc: linuxppc-dev@lists.ozlabs.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: [PATCH 15/65] powerpc/mm/hash: Add support for POWER9 hash
Date: Sun, 27 Mar 2016 13:53:23 +0530
Message-Id: <1459067053-10835-15-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
In-Reply-To: <1459067053-10835-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
References: <1459067053-10835-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

PowerISA 3.0 adds a parition table indexed by LPID. Parition table allow
us to specify the MMU model that will be used for guest and host
translation.

This patch add support with SLB based hash model (UPRT = 0). What is
required with this model is to support the new hash page table entry
format and also setup Partition table such we use hash table for
address translation.

We don't have segment table support yet.

Inorder to make sure we don't load KVM module on Power9 (since we
don't have kvm support yet) this patch also disable kvm on Power9

Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
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
index baeddb06811d..c07600efcef6 100644
--- a/arch/powerpc/kvm/book3s_hv.c
+++ b/arch/powerpc/kvm/book3s_hv.c
@@ -3083,6 +3083,12 @@ static int kvmppc_core_check_processor_compat_hv(void)
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
index e924690a5a0e..43e0d86b7ca1 100644
--- a/arch/powerpc/mm/hash_utils_64.c
+++ b/arch/powerpc/mm/hash_utils_64.c
@@ -674,6 +674,41 @@ int remove_section_mapping(unsigned long start, unsigned long end)
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
@@ -742,8 +777,11 @@ static void __init htab_initialize(void)
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
index 98c91ad18ba7..5fff787da17a 100644
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

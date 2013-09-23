Return-Path: <anton@ozlabs.org>
From: Anton Blanchard <anton@samba.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>
Subject: [PATCH 02/39] powerpc: Book 3S MMU little endian support
Date: Mon, 23 Sep 2013 12:04:36 +1000
Message-Id: <1379901913-5945-3-git-send-email-anton@samba.org>
In-Reply-To: <1379901913-5945-1-git-send-email-anton@samba.org>
References: <1379901913-5945-1-git-send-email-anton@samba.org>
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

v2: HPTE_LOCK_BIT was wrong in LE, spotted by Paul Mackerras.

Signed-off-by: Anton Blanchard <anton@samba.org>
---
 arch/powerpc/include/asm/mmu-hash64.h |  4 +--
 arch/powerpc/mm/hash_native_64.c      | 46 ++++++++++++++++++++---------------
 arch/powerpc/mm/hash_utils_64.c       | 38 ++++++++++++++---------------
 3 files changed, 46 insertions(+), 42 deletions(-)

diff --git a/arch/powerpc/include/asm/mmu-hash64.h b/arch/powerpc/include/asm/mmu-hash64.h
index c4cf011..807014d 100644
--- a/arch/powerpc/include/asm/mmu-hash64.h
+++ b/arch/powerpc/include/asm/mmu-hash64.h
@@ -135,8 +135,8 @@ extern char initial_stab[];
 #ifndef __ASSEMBLY__
 
 struct hash_pte {
-	unsigned long v;
-	unsigned long r;
+	__be64 v;
+	__be64 r;
 };
 
 extern struct hash_pte *htab_address;
diff --git a/arch/powerpc/mm/hash_native_64.c b/arch/powerpc/mm/hash_native_64.c
index c33d939..3ea26c2 100644
--- a/arch/powerpc/mm/hash_native_64.c
+++ b/arch/powerpc/mm/hash_native_64.c
@@ -35,7 +35,11 @@
 #define DBG_LOW(fmt...)
 #endif
 
+#ifdef __BIG_ENDIAN__
 #define HPTE_LOCK_BIT 3
+#else
+#define HPTE_LOCK_BIT (56+3)
+#endif
 
 DEFINE_RAW_SPINLOCK(native_tlbie_lock);
 
@@ -172,7 +176,7 @@ static inline void tlbie(unsigned long vpn, int psize, int apsize,
 
 static inline void native_lock_hpte(struct hash_pte *hptep)
 {
-	unsigned long *word = &hptep->v;
+	unsigned long *word = (unsigned long *)&hptep->v;
 
 	while (1) {
 		if (!test_and_set_bit_lock(HPTE_LOCK_BIT, word))
@@ -184,7 +188,7 @@ static inline void native_lock_hpte(struct hash_pte *hptep)
 
 static inline void native_unlock_hpte(struct hash_pte *hptep)
 {
-	unsigned long *word = &hptep->v;
+	unsigned long *word = (unsigned long *)&hptep->v;
 
 	clear_bit_unlock(HPTE_LOCK_BIT, word);
 }
@@ -204,10 +208,10 @@ static long native_hpte_insert(unsigned long hpte_group, unsigned long vpn,
 	}
 
 	for (i = 0; i < HPTES_PER_GROUP; i++) {
-		if (! (hptep->v & HPTE_V_VALID)) {
+		if (! (be64_to_cpu(hptep->v) & HPTE_V_VALID)) {
 			/* retry with lock held */
 			native_lock_hpte(hptep);
-			if (! (hptep->v & HPTE_V_VALID))
+			if (! (be64_to_cpu(hptep->v) & HPTE_V_VALID))
 				break;
 			native_unlock_hpte(hptep);
 		}
@@ -226,14 +230,14 @@ static long native_hpte_insert(unsigned long hpte_group, unsigned long vpn,
 			i, hpte_v, hpte_r);
 	}
 
-	hptep->r = hpte_r;
+	hptep->r = cpu_to_be64(hpte_r);
 	/* Guarantee the second dword is visible before the valid bit */
 	eieio();
 	/*
 	 * Now set the first dword including the valid bit
 	 * NOTE: this also unlocks the hpte
 	 */
-	hptep->v = hpte_v;
+	hptep->v = cpu_to_be64(hpte_v);
 
 	__asm__ __volatile__ ("ptesync" : : : "memory");
 
@@ -254,12 +258,12 @@ static long native_hpte_remove(unsigned long hpte_group)
 
 	for (i = 0; i < HPTES_PER_GROUP; i++) {
 		hptep = htab_address + hpte_group + slot_offset;
-		hpte_v = hptep->v;
+		hpte_v = be64_to_cpu(hptep->v);
 
 		if ((hpte_v & HPTE_V_VALID) && !(hpte_v & HPTE_V_BOLTED)) {
 			/* retry with lock held */
 			native_lock_hpte(hptep);
-			hpte_v = hptep->v;
+			hpte_v = be64_to_cpu(hptep->v);
 			if ((hpte_v & HPTE_V_VALID)
 			    && !(hpte_v & HPTE_V_BOLTED))
 				break;
@@ -294,7 +298,7 @@ static long native_hpte_updatepp(unsigned long slot, unsigned long newpp,
 
 	native_lock_hpte(hptep);
 
-	hpte_v = hptep->v;
+	hpte_v = be64_to_cpu(hptep->v);
 	/*
 	 * We need to invalidate the TLB always because hpte_remove doesn't do
 	 * a tlb invalidate. If a hash bucket gets full, we "evict" a more/less
@@ -308,8 +312,8 @@ static long native_hpte_updatepp(unsigned long slot, unsigned long newpp,
 	} else {
 		DBG_LOW(" -> hit\n");
 		/* Update the HPTE */
-		hptep->r = (hptep->r & ~(HPTE_R_PP | HPTE_R_N)) |
-			(newpp & (HPTE_R_PP | HPTE_R_N | HPTE_R_C));
+		hptep->r = cpu_to_be64((be64_to_cpu(hptep->r) & ~(HPTE_R_PP | HPTE_R_N)) |
+			(newpp & (HPTE_R_PP | HPTE_R_N | HPTE_R_C)));
 	}
 	native_unlock_hpte(hptep);
 
@@ -334,7 +338,7 @@ static long native_hpte_find(unsigned long vpn, int psize, int ssize)
 	slot = (hash & htab_hash_mask) * HPTES_PER_GROUP;
 	for (i = 0; i < HPTES_PER_GROUP; i++) {
 		hptep = htab_address + slot;
-		hpte_v = hptep->v;
+		hpte_v = be64_to_cpu(hptep->v);
 
 		if (HPTE_V_COMPARE(hpte_v, want_v) && (hpte_v & HPTE_V_VALID))
 			/* HPTE matches */
@@ -369,8 +373,9 @@ static void native_hpte_updateboltedpp(unsigned long newpp, unsigned long ea,
 	hptep = htab_address + slot;
 
 	/* Update the HPTE */
-	hptep->r = (hptep->r & ~(HPTE_R_PP | HPTE_R_N)) |
-		(newpp & (HPTE_R_PP | HPTE_R_N));
+	hptep->r = cpu_to_be64((be64_to_cpu(hptep->r) &
+			~(HPTE_R_PP | HPTE_R_N)) |
+		(newpp & (HPTE_R_PP | HPTE_R_N)));
 	/*
 	 * Ensure it is out of the tlb too. Bolted entries base and
 	 * actual page size will be same.
@@ -392,7 +397,7 @@ static void native_hpte_invalidate(unsigned long slot, unsigned long vpn,
 
 	want_v = hpte_encode_avpn(vpn, bpsize, ssize);
 	native_lock_hpte(hptep);
-	hpte_v = hptep->v;
+	hpte_v = be64_to_cpu(hptep->v);
 
 	/*
 	 * We need to invalidate the TLB always because hpte_remove doesn't do
@@ -458,7 +463,7 @@ static void native_hugepage_invalidate(struct mm_struct *mm,
 		hptep = htab_address + slot;
 		want_v = hpte_encode_avpn(vpn, psize, ssize);
 		native_lock_hpte(hptep);
-		hpte_v = hptep->v;
+		hpte_v = be64_to_cpu(hptep->v);
 
 		/* Even if we miss, we need to invalidate the TLB */
 		if (!HPTE_V_COMPARE(hpte_v, want_v) || !(hpte_v & HPTE_V_VALID))
@@ -519,11 +524,12 @@ static void hpte_decode(struct hash_pte *hpte, unsigned long slot,
 			int *psize, int *apsize, int *ssize, unsigned long *vpn)
 {
 	unsigned long avpn, pteg, vpi;
-	unsigned long hpte_v = hpte->v;
+	unsigned long hpte_v = be64_to_cpu(hpte->v);
+	unsigned long hpte_r = be64_to_cpu(hpte->r);
 	unsigned long vsid, seg_off;
 	int size, a_size, shift;
 	/* Look at the 8 bit LP value */
-	unsigned int lp = (hpte->r >> LP_SHIFT) & ((1 << LP_BITS) - 1);
+	unsigned int lp = (hpte_r >> LP_SHIFT) & ((1 << LP_BITS) - 1);
 
 	if (!(hpte_v & HPTE_V_LARGE)) {
 		size   = MMU_PAGE_4K;
@@ -612,7 +618,7 @@ static void native_hpte_clear(void)
 		 * running,  right?  and for crash dump, we probably
 		 * don't want to wait for a maybe bad cpu.
 		 */
-		hpte_v = hptep->v;
+		hpte_v = be64_to_cpu(hptep->v);
 
 		/*
 		 * Call __tlbie() here rather than tlbie() since we
@@ -664,7 +670,7 @@ static void native_flush_hash_range(unsigned long number, int local)
 			hptep = htab_address + slot;
 			want_v = hpte_encode_avpn(vpn, psize, ssize);
 			native_lock_hpte(hptep);
-			hpte_v = hptep->v;
+			hpte_v = be64_to_cpu(hptep->v);
 			if (!HPTE_V_COMPARE(hpte_v, want_v) ||
 			    !(hpte_v & HPTE_V_VALID))
 				native_unlock_hpte(hptep);
diff --git a/arch/powerpc/mm/hash_utils_64.c b/arch/powerpc/mm/hash_utils_64.c
index bde8b55..6176b3c 100644
--- a/arch/powerpc/mm/hash_utils_64.c
+++ b/arch/powerpc/mm/hash_utils_64.c
@@ -251,19 +251,18 @@ static int __init htab_dt_scan_seg_sizes(unsigned long node,
 					 void *data)
 {
 	char *type = of_get_flat_dt_prop(node, "device_type", NULL);
-	u32 *prop;
+	__be32 *prop;
 	unsigned long size = 0;
 
 	/* We are scanning "cpu" nodes only */
 	if (type == NULL || strcmp(type, "cpu") != 0)
 		return 0;
 
-	prop = (u32 *)of_get_flat_dt_prop(node, "ibm,processor-segment-sizes",
-					  &size);
+	prop = of_get_flat_dt_prop(node, "ibm,processor-segment-sizes", &size);
 	if (prop == NULL)
 		return 0;
 	for (; size >= 4; size -= 4, ++prop) {
-		if (prop[0] == 40) {
+		if (be32_to_cpu(prop[0]) == 40) {
 			DBG("1T segment support detected\n");
 			cur_cpu_spec->mmu_features |= MMU_FTR_1T_SEGMENT;
 			return 1;
@@ -307,23 +306,22 @@ static int __init htab_dt_scan_page_sizes(unsigned long node,
 					  void *data)
 {
 	char *type = of_get_flat_dt_prop(node, "device_type", NULL);
-	u32 *prop;
+	__be32 *prop;
 	unsigned long size = 0;
 
 	/* We are scanning "cpu" nodes only */
 	if (type == NULL || strcmp(type, "cpu") != 0)
 		return 0;
 
-	prop = (u32 *)of_get_flat_dt_prop(node,
-					  "ibm,segment-page-sizes", &size);
+	prop = of_get_flat_dt_prop(node, "ibm,segment-page-sizes", &size);
 	if (prop != NULL) {
 		pr_info("Page sizes from device-tree:\n");
 		size /= 4;
 		cur_cpu_spec->mmu_features &= ~(MMU_FTR_16M_PAGE);
 		while(size > 0) {
-			unsigned int base_shift = prop[0];
-			unsigned int slbenc = prop[1];
-			unsigned int lpnum = prop[2];
+			unsigned int base_shift = be32_to_cpu(prop[0]);
+			unsigned int slbenc = be32_to_cpu(prop[1]);
+			unsigned int lpnum = be32_to_cpu(prop[2]);
 			struct mmu_psize_def *def;
 			int idx, base_idx;
 
@@ -356,8 +354,8 @@ static int __init htab_dt_scan_page_sizes(unsigned long node,
 				def->tlbiel = 0;
 
 			while (size > 0 && lpnum) {
-				unsigned int shift = prop[0];
-				int penc  = prop[1];
+				unsigned int shift = be32_to_cpu(prop[0]);
+				int penc  = be32_to_cpu(prop[1]);
 
 				prop += 2; size -= 2;
 				lpnum--;
@@ -390,8 +388,8 @@ static int __init htab_dt_scan_hugepage_blocks(unsigned long node,
 					const char *uname, int depth,
 					void *data) {
 	char *type = of_get_flat_dt_prop(node, "device_type", NULL);
-	unsigned long *addr_prop;
-	u32 *page_count_prop;
+	__be64 *addr_prop;
+	__be32 *page_count_prop;
 	unsigned int expected_pages;
 	long unsigned int phys_addr;
 	long unsigned int block_size;
@@ -405,12 +403,12 @@ static int __init htab_dt_scan_hugepage_blocks(unsigned long node,
 	page_count_prop = of_get_flat_dt_prop(node, "ibm,expected#pages", NULL);
 	if (page_count_prop == NULL)
 		return 0;
-	expected_pages = (1 << page_count_prop[0]);
+	expected_pages = (1 << be32_to_cpu(page_count_prop[0]));
 	addr_prop = of_get_flat_dt_prop(node, "reg", NULL);
 	if (addr_prop == NULL)
 		return 0;
-	phys_addr = addr_prop[0];
-	block_size = addr_prop[1];
+	phys_addr = be64_to_cpu(addr_prop[0]);
+	block_size = be64_to_cpu(addr_prop[1]);
 	if (block_size != (16 * GB))
 		return 0;
 	printk(KERN_INFO "Huge page(16GB) memory: "
@@ -534,16 +532,16 @@ static int __init htab_dt_scan_pftsize(unsigned long node,
 				       void *data)
 {
 	char *type = of_get_flat_dt_prop(node, "device_type", NULL);
-	u32 *prop;
+	__be32 *prop;
 
 	/* We are scanning "cpu" nodes only */
 	if (type == NULL || strcmp(type, "cpu") != 0)
 		return 0;
 
-	prop = (u32 *)of_get_flat_dt_prop(node, "ibm,pft-size", NULL);
+	prop = of_get_flat_dt_prop(node, "ibm,pft-size", NULL);
 	if (prop != NULL) {
 		/* pft_size[0] is the NUMA CEC cookie */
-		ppc64_pft_size = prop[1];
+		ppc64_pft_size = be32_to_cpu(prop[1]);
 		return 1;
 	}
 	return 0;
-- 
1.8.1.2

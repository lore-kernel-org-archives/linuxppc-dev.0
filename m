Return-Path: <benh@kernel.crashing.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rkCFh0G4QzDr32
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  5 Jul 2016 15:32:40 +1000 (AEST)
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3rkCFf1WpLz9sBc
 for <linuxppc-dev@ozlabs.org>; Tue,  5 Jul 2016 15:32:37 +1000 (AEST)
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 22/41] powerpc/mm: Move hash table ops to a separate structure
Date: Tue,  5 Jul 2016 15:03:58 +1000
Message-Id: <1467695057-12431-23-git-send-email-benh@kernel.crashing.org>
In-Reply-To: <1467695057-12431-1-git-send-email-benh@kernel.crashing.org>
References: <1467695057-12431-1-git-send-email-benh@kernel.crashing.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Moving probe_machine() to after mmu init will cause the ppc_md
fields relative to the hash table management to be overwritten.

Since we have essentially disconnected the machine type from
the hash backend ops, finish the job by moving them to a different
structure.

The only callback that didn't quite fix is update_partition_table
since this is not specific to hash, so I moved it to a standalone
variable for now. We can revisit later if needed.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---
 arch/powerpc/include/asm/book3s/64/mmu-hash.h | 39 ++++++++++++++++++++
 arch/powerpc/include/asm/book3s/64/mmu.h      |  2 ++
 arch/powerpc/include/asm/machdep.h            | 37 -------------------
 arch/powerpc/kernel/machine_kexec_64.c        |  4 +--
 arch/powerpc/kernel/misc_64.S                 |  2 +-
 arch/powerpc/kvm/book3s_64_mmu_host.c         | 18 +++++-----
 arch/powerpc/mm/hash64_4k.c                   | 18 +++++-----
 arch/powerpc/mm/hash64_64k.c                  | 39 +++++++++++---------
 arch/powerpc/mm/hash_native_64.c              | 18 +++++-----
 arch/powerpc/mm/hash_utils_64.c               | 51 +++++++++++++++------------
 arch/powerpc/mm/hugepage-hash64.c             | 17 ++++-----
 arch/powerpc/mm/hugetlbpage-hash64.c          |  4 +--
 arch/powerpc/mm/pgtable-book3s64.c            |  2 ++
 arch/powerpc/mm/pgtable-radix.c               |  7 ++--
 arch/powerpc/platforms/ps3/htab.c             | 12 +++----
 arch/powerpc/platforms/pseries/lpar.c         | 18 +++++-----
 16 files changed, 156 insertions(+), 132 deletions(-)

diff --git a/arch/powerpc/include/asm/book3s/64/mmu-hash.h b/arch/powerpc/include/asm/book3s/64/mmu-hash.h
index 290157e..c2baabe 100644
--- a/arch/powerpc/include/asm/book3s/64/mmu-hash.h
+++ b/arch/powerpc/include/asm/book3s/64/mmu-hash.h
@@ -123,6 +123,45 @@
 
 #ifndef __ASSEMBLY__
 
+struct mmu_hash_ops {
+	void            (*hpte_invalidate)(unsigned long slot,
+					   unsigned long vpn,
+					   int bpsize, int apsize,
+					   int ssize, int local);
+	long		(*hpte_updatepp)(unsigned long slot,
+					 unsigned long newpp,
+					 unsigned long vpn,
+					 int bpsize, int apsize,
+					 int ssize, unsigned long flags);
+	void            (*hpte_updateboltedpp)(unsigned long newpp,
+					       unsigned long ea,
+					       int psize, int ssize);
+	long		(*hpte_insert)(unsigned long hpte_group,
+				       unsigned long vpn,
+				       unsigned long prpn,
+				       unsigned long rflags,
+				       unsigned long vflags,
+				       int psize, int apsize,
+				       int ssize);
+	long		(*hpte_remove)(unsigned long hpte_group);
+	int             (*hpte_removebolted)(unsigned long ea,
+					     int psize, int ssize);
+	void		(*flush_hash_range)(unsigned long number, int local);
+	void		(*hugepage_invalidate)(unsigned long vsid,
+					       unsigned long addr,
+					       unsigned char *hpte_slot_array,
+					       int psize, int ssize, int local);
+	/*
+	 * Special for kexec.
+	 * To be called in real mode with interrupts disabled. No locks are
+	 * taken as such, concurrent access on pre POWER5 hardware could result
+	 * in a deadlock.
+	 * The linear mapping is destroyed as well.
+	 */
+	void		(*hpte_clear_all)(void);
+};
+extern struct mmu_hash_ops mmu_hash_ops;
+
 struct hash_pte {
 	__be64 v;
 	__be64 r;
diff --git a/arch/powerpc/include/asm/book3s/64/mmu.h b/arch/powerpc/include/asm/book3s/64/mmu.h
index 5854263..6a90efe 100644
--- a/arch/powerpc/include/asm/book3s/64/mmu.h
+++ b/arch/powerpc/include/asm/book3s/64/mmu.h
@@ -25,6 +25,8 @@ extern struct mmu_psize_def mmu_psize_defs[MMU_PAGE_COUNT];
 
 #define radix_enabled() mmu_has_feature(MMU_FTR_RADIX)
 
+extern int (*ppc64_update_partition_table)(u64);
+
 #endif /* __ASSEMBLY__ */
 
 /* 64-bit classic hash table MMU */
diff --git a/arch/powerpc/include/asm/machdep.h b/arch/powerpc/include/asm/machdep.h
index 6bdcd0d..62b1461 100644
--- a/arch/powerpc/include/asm/machdep.h
+++ b/arch/powerpc/include/asm/machdep.h
@@ -34,42 +34,6 @@ struct pci_host_bridge;
 struct machdep_calls {
 	char		*name;
 #ifdef CONFIG_PPC64
-	void            (*hpte_invalidate)(unsigned long slot,
-					   unsigned long vpn,
-					   int bpsize, int apsize,
-					   int ssize, int local);
-	long		(*hpte_updatepp)(unsigned long slot, 
-					 unsigned long newpp, 
-					 unsigned long vpn,
-					 int bpsize, int apsize,
-					 int ssize, unsigned long flags);
-	void            (*hpte_updateboltedpp)(unsigned long newpp, 
-					       unsigned long ea,
-					       int psize, int ssize);
-	long		(*hpte_insert)(unsigned long hpte_group,
-				       unsigned long vpn,
-				       unsigned long prpn,
-				       unsigned long rflags,
-				       unsigned long vflags,
-				       int psize, int apsize,
-				       int ssize);
-	long		(*hpte_remove)(unsigned long hpte_group);
-	int             (*hpte_removebolted)(unsigned long ea,
-					     int psize, int ssize);
-	void		(*flush_hash_range)(unsigned long number, int local);
-	void		(*hugepage_invalidate)(unsigned long vsid,
-					       unsigned long addr,
-					       unsigned char *hpte_slot_array,
-					       int psize, int ssize, int local);
-	/*
-	 * Special for kexec.
-	 * To be called in real mode with interrupts disabled. No locks are
-	 * taken as such, concurrent access on pre POWER5 hardware could result
-	 * in a deadlock.
-	 * The linear mapping is destroyed as well.
-	 */
-	void		(*hpte_clear_all)(void);
-
 	void __iomem *	(*ioremap)(phys_addr_t addr, unsigned long size,
 				   unsigned long flags, void *caller);
 	void		(*iounmap)(volatile void __iomem *token);
@@ -256,7 +220,6 @@ struct machdep_calls {
 #ifdef CONFIG_ARCH_RANDOM
 	int (*get_random_seed)(unsigned long *v);
 #endif
-	int (*update_partition_table)(u64);
 };
 
 extern void e500_idle(void);
diff --git a/arch/powerpc/kernel/machine_kexec_64.c b/arch/powerpc/kernel/machine_kexec_64.c
index b8c202d..021cc7c 100644
--- a/arch/powerpc/kernel/machine_kexec_64.c
+++ b/arch/powerpc/kernel/machine_kexec_64.c
@@ -54,7 +54,7 @@ int default_machine_kexec_prepare(struct kimage *image)
 	const unsigned long *basep;
 	const unsigned int *sizep;
 
-	if (!ppc_md.hpte_clear_all)
+	if (!mmu_hash_ops.hpte_clear_all)
 		return -ENOENT;
 
 	/*
@@ -379,7 +379,7 @@ void default_machine_kexec(struct kimage *image)
 	 */
 	kexec_sequence(&kexec_stack, image->start, image,
 			page_address(image->control_code_page),
-			ppc_md.hpte_clear_all);
+			mmu_hash_ops.hpte_clear_all);
 	/* NOTREACHED */
 }
 
diff --git a/arch/powerpc/kernel/misc_64.S b/arch/powerpc/kernel/misc_64.S
index f28754c..5974837 100644
--- a/arch/powerpc/kernel/misc_64.S
+++ b/arch/powerpc/kernel/misc_64.S
@@ -667,7 +667,7 @@ _GLOBAL(kexec_sequence)
 	mr	r12,r27
 #endif
 	mtctr	r12
-	bctrl				/* ppc_md.hpte_clear_all(void); */
+	bctrl				/* mmu_hash_ops.hpte_clear_all(void); */
 #endif /* !CONFIG_PPC_BOOK3E */
 
 /*
diff --git a/arch/powerpc/kvm/book3s_64_mmu_host.c b/arch/powerpc/kvm/book3s_64_mmu_host.c
index 114edac..8164792 100644
--- a/arch/powerpc/kvm/book3s_64_mmu_host.c
+++ b/arch/powerpc/kvm/book3s_64_mmu_host.c
@@ -34,9 +34,9 @@
 
 void kvmppc_mmu_invalidate_pte(struct kvm_vcpu *vcpu, struct hpte_cache *pte)
 {
-	ppc_md.hpte_invalidate(pte->slot, pte->host_vpn,
-			       pte->pagesize, pte->pagesize, MMU_SEGSIZE_256M,
-			       false);
+	mmu_hash_ops.hpte_invalidate(pte->slot, pte->host_vpn,
+				     pte->pagesize, pte->pagesize,
+				     MMU_SEGSIZE_256M, false);
 }
 
 /* We keep 512 gvsid->hvsid entries, mapping the guest ones to the array using
@@ -169,13 +169,13 @@ map_again:
 
 	/* In case we tried normal mapping already, let's nuke old entries */
 	if (attempt > 1)
-		if (ppc_md.hpte_remove(hpteg) < 0) {
+		if (mmu_hash_ops.hpte_remove(hpteg) < 0) {
 			r = -1;
 			goto out_unlock;
 		}
 
-	ret = ppc_md.hpte_insert(hpteg, vpn, hpaddr, rflags, vflags,
-				 hpsize, hpsize, MMU_SEGSIZE_256M);
+	ret = mmu_hash_ops.hpte_insert(hpteg, vpn, hpaddr, rflags, vflags,
+				       hpsize, hpsize, MMU_SEGSIZE_256M);
 
 	if (ret < 0) {
 		/* If we couldn't map a primary PTE, try a secondary */
@@ -187,8 +187,10 @@ map_again:
 		trace_kvm_book3s_64_mmu_map(rflags, hpteg,
 					    vpn, hpaddr, orig_pte);
 
-		/* The ppc_md code may give us a secondary entry even though we
-		   asked for a primary. Fix up. */
+		/* The mmu_hash_ops code may give us a secondary entry even
+		 * though we
+		 * asked for a primary. Fix up.
+		 */
 		if ((ret & _PTEIDX_SECONDARY) && !(vflags & HPTE_V_SECONDARY)) {
 			hash = ~hash;
 			hpteg = ((hash & htab_hash_mask) * HPTES_PER_GROUP);
diff --git a/arch/powerpc/mm/hash64_4k.c b/arch/powerpc/mm/hash64_4k.c
index 6333b27..42c702b 100644
--- a/arch/powerpc/mm/hash64_4k.c
+++ b/arch/powerpc/mm/hash64_4k.c
@@ -70,8 +70,8 @@ int __hash_page_4K(unsigned long ea, unsigned long access, unsigned long vsid,
 		slot = (hash & htab_hash_mask) * HPTES_PER_GROUP;
 		slot += (old_pte & H_PAGE_F_GIX) >> H_PAGE_F_GIX_SHIFT;
 
-		if (ppc_md.hpte_updatepp(slot, rflags, vpn, MMU_PAGE_4K,
-					 MMU_PAGE_4K, ssize, flags) == -1)
+		if (mmu_hash_ops.hpte_updatepp(slot, rflags, vpn, MMU_PAGE_4K,
+					       MMU_PAGE_4K, ssize, flags) == -1)
 			old_pte &= ~_PAGE_HPTEFLAGS;
 	}
 
@@ -84,21 +84,23 @@ repeat:
 		hpte_group = ((hash & htab_hash_mask) * HPTES_PER_GROUP) & ~0x7UL;
 
 		/* Insert into the hash table, primary slot */
-		slot = ppc_md.hpte_insert(hpte_group, vpn, pa, rflags, 0,
-				  MMU_PAGE_4K, MMU_PAGE_4K, ssize);
+		slot = mmu_hash_ops.hpte_insert(hpte_group, vpn, pa, rflags, 0,
+						MMU_PAGE_4K, MMU_PAGE_4K, ssize);
 		/*
 		 * Primary is full, try the secondary
 		 */
 		if (unlikely(slot == -1)) {
 			hpte_group = ((~hash & htab_hash_mask) * HPTES_PER_GROUP) & ~0x7UL;
-			slot = ppc_md.hpte_insert(hpte_group, vpn, pa,
-						  rflags, HPTE_V_SECONDARY,
-						  MMU_PAGE_4K, MMU_PAGE_4K, ssize);
+			slot = mmu_hash_ops.hpte_insert(hpte_group, vpn, pa,
+							rflags,
+							HPTE_V_SECONDARY,
+							MMU_PAGE_4K,
+							MMU_PAGE_4K, ssize);
 			if (slot == -1) {
 				if (mftb() & 0x1)
 					hpte_group = ((hash & htab_hash_mask) *
 						      HPTES_PER_GROUP) & ~0x7UL;
-				ppc_md.hpte_remove(hpte_group);
+				mmu_hash_ops.hpte_remove(hpte_group);
 				/*
 				 * FIXME!! Should be try the group from which we removed ?
 				 */
diff --git a/arch/powerpc/mm/hash64_64k.c b/arch/powerpc/mm/hash64_64k.c
index 16644e1..3bbbea0 100644
--- a/arch/powerpc/mm/hash64_64k.c
+++ b/arch/powerpc/mm/hash64_64k.c
@@ -133,9 +133,9 @@ int __hash_page_4K(unsigned long ea, unsigned long access, unsigned long vsid,
 		slot = (hash & htab_hash_mask) * HPTES_PER_GROUP;
 		slot += hidx & _PTEIDX_GROUP_IX;
 
-		ret = ppc_md.hpte_updatepp(slot, rflags, vpn,
-					   MMU_PAGE_4K, MMU_PAGE_4K,
-					   ssize, flags);
+		ret = mmu_hash_ops.hpte_updatepp(slot, rflags, vpn,
+						 MMU_PAGE_4K, MMU_PAGE_4K,
+						 ssize, flags);
 		/*
 		 *if we failed because typically the HPTE wasn't really here
 		 * we try an insertion.
@@ -166,21 +166,22 @@ repeat:
 	hpte_group = ((hash & htab_hash_mask) * HPTES_PER_GROUP) & ~0x7UL;
 
 	/* Insert into the hash table, primary slot */
-	slot = ppc_md.hpte_insert(hpte_group, vpn, pa, rflags, 0,
-				  MMU_PAGE_4K, MMU_PAGE_4K, ssize);
+	slot = mmu_hash_ops.hpte_insert(hpte_group, vpn, pa, rflags, 0,
+					MMU_PAGE_4K, MMU_PAGE_4K, ssize);
 	/*
 	 * Primary is full, try the secondary
 	 */
 	if (unlikely(slot == -1)) {
 		hpte_group = ((~hash & htab_hash_mask) * HPTES_PER_GROUP) & ~0x7UL;
-		slot = ppc_md.hpte_insert(hpte_group, vpn, pa,
-					  rflags, HPTE_V_SECONDARY,
-					  MMU_PAGE_4K, MMU_PAGE_4K, ssize);
+		slot = mmu_hash_ops.hpte_insert(hpte_group, vpn, pa,
+						rflags, HPTE_V_SECONDARY,
+						MMU_PAGE_4K, MMU_PAGE_4K,
+						ssize);
 		if (slot == -1) {
 			if (mftb() & 0x1)
 				hpte_group = ((hash & htab_hash_mask) *
 					      HPTES_PER_GROUP) & ~0x7UL;
-			ppc_md.hpte_remove(hpte_group);
+			mmu_hash_ops.hpte_remove(hpte_group);
 			/*
 			 * FIXME!! Should be try the group from which we removed ?
 			 */
@@ -272,8 +273,9 @@ int __hash_page_64K(unsigned long ea, unsigned long access,
 		slot = (hash & htab_hash_mask) * HPTES_PER_GROUP;
 		slot += (old_pte & H_PAGE_F_GIX) >> H_PAGE_F_GIX_SHIFT;
 
-		if (ppc_md.hpte_updatepp(slot, rflags, vpn, MMU_PAGE_64K,
-					 MMU_PAGE_64K, ssize, flags) == -1)
+		if (mmu_hash_ops.hpte_updatepp(slot, rflags, vpn, MMU_PAGE_64K,
+					       MMU_PAGE_64K, ssize,
+					       flags) == -1)
 			old_pte &= ~_PAGE_HPTEFLAGS;
 	}
 
@@ -286,21 +288,24 @@ repeat:
 		hpte_group = ((hash & htab_hash_mask) * HPTES_PER_GROUP) & ~0x7UL;
 
 		/* Insert into the hash table, primary slot */
-		slot = ppc_md.hpte_insert(hpte_group, vpn, pa, rflags, 0,
-				  MMU_PAGE_64K, MMU_PAGE_64K, ssize);
+		slot = mmu_hash_ops.hpte_insert(hpte_group, vpn, pa, rflags, 0,
+						MMU_PAGE_64K, MMU_PAGE_64K,
+						ssize);
 		/*
 		 * Primary is full, try the secondary
 		 */
 		if (unlikely(slot == -1)) {
 			hpte_group = ((~hash & htab_hash_mask) * HPTES_PER_GROUP) & ~0x7UL;
-			slot = ppc_md.hpte_insert(hpte_group, vpn, pa,
-						  rflags, HPTE_V_SECONDARY,
-						  MMU_PAGE_64K, MMU_PAGE_64K, ssize);
+			slot = mmu_hash_ops.hpte_insert(hpte_group, vpn, pa,
+							rflags,
+							HPTE_V_SECONDARY,
+							MMU_PAGE_64K,
+							MMU_PAGE_64K, ssize);
 			if (slot == -1) {
 				if (mftb() & 0x1)
 					hpte_group = ((hash & htab_hash_mask) *
 						      HPTES_PER_GROUP) & ~0x7UL;
-				ppc_md.hpte_remove(hpte_group);
+				mmu_hash_ops.hpte_remove(hpte_group);
 				/*
 				 * FIXME!! Should be try the group from which we removed ?
 				 */
diff --git a/arch/powerpc/mm/hash_native_64.c b/arch/powerpc/mm/hash_native_64.c
index 40e05e7..09ec60f 100644
--- a/arch/powerpc/mm/hash_native_64.c
+++ b/arch/powerpc/mm/hash_native_64.c
@@ -731,15 +731,15 @@ static int native_update_partition_table(u64 patb1)
 
 void __init hpte_init_native(void)
 {
-	ppc_md.hpte_invalidate	= native_hpte_invalidate;
-	ppc_md.hpte_updatepp	= native_hpte_updatepp;
-	ppc_md.hpte_updateboltedpp = native_hpte_updateboltedpp;
-	ppc_md.hpte_insert	= native_hpte_insert;
-	ppc_md.hpte_remove	= native_hpte_remove;
-	ppc_md.hpte_clear_all	= native_hpte_clear;
-	ppc_md.flush_hash_range = native_flush_hash_range;
-	ppc_md.hugepage_invalidate   = native_hugepage_invalidate;
+	mmu_hash_ops.hpte_invalidate	= native_hpte_invalidate;
+	mmu_hash_ops.hpte_updatepp	= native_hpte_updatepp;
+	mmu_hash_ops.hpte_updateboltedpp = native_hpte_updateboltedpp;
+	mmu_hash_ops.hpte_insert	= native_hpte_insert;
+	mmu_hash_ops.hpte_remove	= native_hpte_remove;
+	mmu_hash_ops.hpte_clear_all	= native_hpte_clear;
+	mmu_hash_ops.flush_hash_range = native_flush_hash_range;
+	mmu_hash_ops.hugepage_invalidate   = native_hugepage_invalidate;
 
 	if (cpu_has_feature(CPU_FTR_ARCH_300))
-		ppc_md.update_partition_table = native_update_partition_table;
+		ppc64_update_partition_table = native_update_partition_table;
 }
diff --git a/arch/powerpc/mm/hash_utils_64.c b/arch/powerpc/mm/hash_utils_64.c
index 8ccb0b1..9e30e0a 100644
--- a/arch/powerpc/mm/hash_utils_64.c
+++ b/arch/powerpc/mm/hash_utils_64.c
@@ -118,6 +118,8 @@ static u8 *linear_map_hash_slots;
 static unsigned long linear_map_hash_count;
 static DEFINE_SPINLOCK(linear_map_hash_lock);
 #endif /* CONFIG_DEBUG_PAGEALLOC */
+struct mmu_hash_ops mmu_hash_ops;
+EXPORT_SYMBOL(mmu_hash_ops);
 
 /* There are definitions of page sizes arrays to be used when none
  * is provided by the firmware.
@@ -272,9 +274,10 @@ int htab_bolt_mapping(unsigned long vstart, unsigned long vend,
 		hash = hpt_hash(vpn, shift, ssize);
 		hpteg = ((hash & htab_hash_mask) * HPTES_PER_GROUP);
 
-		BUG_ON(!ppc_md.hpte_insert);
-		ret = ppc_md.hpte_insert(hpteg, vpn, paddr, tprot,
-					 HPTE_V_BOLTED, psize, psize, ssize);
+		BUG_ON(!mmu_hash_ops.hpte_insert);
+		ret = mmu_hash_ops.hpte_insert(hpteg, vpn, paddr, tprot,
+					       HPTE_V_BOLTED, psize, psize,
+					       ssize);
 
 		if (ret < 0)
 			break;
@@ -299,11 +302,11 @@ int htab_remove_mapping(unsigned long vstart, unsigned long vend,
 	shift = mmu_psize_defs[psize].shift;
 	step = 1 << shift;
 
-	if (!ppc_md.hpte_removebolted)
+	if (!mmu_hash_ops.hpte_removebolted)
 		return -ENODEV;
 
 	for (vaddr = vstart; vaddr < vend; vaddr += step) {
-		rc = ppc_md.hpte_removebolted(vaddr, psize, ssize);
+		rc = mmu_hash_ops.hpte_removebolted(vaddr, psize, ssize);
 		if (rc == -ENOENT) {
 			ret = -ENOENT;
 			continue;
@@ -771,8 +774,8 @@ static void __init htab_initialize(void)
 		 * Clear the htab if firmware assisted dump is active so
 		 * that we dont end up using old mappings.
 		 */
-		if (is_fadump_active() && ppc_md.hpte_clear_all)
-			ppc_md.hpte_clear_all();
+		if (is_fadump_active() && mmu_hash_ops.hpte_clear_all)
+			mmu_hash_ops.hpte_clear_all();
 #endif
 	} else {
 		unsigned long limit = MEMBLOCK_ALLOC_ANYWHERE;
@@ -1456,7 +1459,8 @@ void flush_hash_page(unsigned long vpn, real_pte_t pte, int psize, int ssize,
 		 * We use same base page size and actual psize, because we don't
 		 * use these functions for hugepage
 		 */
-		ppc_md.hpte_invalidate(slot, vpn, psize, psize, ssize, local);
+		mmu_hash_ops.hpte_invalidate(slot, vpn, psize, psize,
+					     ssize, local);
 	} pte_iterate_hashed_end();
 
 #ifdef CONFIG_PPC_TRANSACTIONAL_MEM
@@ -1497,9 +1501,9 @@ void flush_hash_hugepage(unsigned long vsid, unsigned long addr,
 	if (!hpte_slot_array)
 		return;
 
-	if (ppc_md.hugepage_invalidate) {
-		ppc_md.hugepage_invalidate(vsid, s_addr, hpte_slot_array,
-					   psize, ssize, local);
+	if (mmu_hash_ops.hugepage_invalidate) {
+		mmu_hash_ops.hugepage_invalidate(vsid, s_addr, hpte_slot_array,
+						 psize, ssize, local);
 		goto tm_abort;
 	}
 	/*
@@ -1526,8 +1530,8 @@ void flush_hash_hugepage(unsigned long vsid, unsigned long addr,
 
 		slot = (hash & htab_hash_mask) * HPTES_PER_GROUP;
 		slot += hidx & _PTEIDX_GROUP_IX;
-		ppc_md.hpte_invalidate(slot, vpn, psize,
-				       MMU_PAGE_16M, ssize, local);
+		mmu_hash_ops.hpte_invalidate(slot, vpn, psize,
+					     MMU_PAGE_16M, ssize, local);
 	}
 tm_abort:
 #ifdef CONFIG_PPC_TRANSACTIONAL_MEM
@@ -1551,8 +1555,8 @@ tm_abort:
 
 void flush_hash_range(unsigned long number, int local)
 {
-	if (ppc_md.flush_hash_range)
-		ppc_md.flush_hash_range(number, local);
+	if (mmu_hash_ops.flush_hash_range)
+		mmu_hash_ops.flush_hash_range(number, local);
 	else {
 		int i;
 		struct ppc64_tlb_batch *batch =
@@ -1597,22 +1601,22 @@ repeat:
 		       HPTES_PER_GROUP) & ~0x7UL;
 
 	/* Insert into the hash table, primary slot */
-	slot = ppc_md.hpte_insert(hpte_group, vpn, pa, rflags, vflags,
-				  psize, psize, ssize);
+	slot = mmu_hash_ops.hpte_insert(hpte_group, vpn, pa, rflags, vflags,
+					psize, psize, ssize);
 
 	/* Primary is full, try the secondary */
 	if (unlikely(slot == -1)) {
 		hpte_group = ((~hash & htab_hash_mask) *
 			      HPTES_PER_GROUP) & ~0x7UL;
-		slot = ppc_md.hpte_insert(hpte_group, vpn, pa, rflags,
-					  vflags | HPTE_V_SECONDARY,
-					  psize, psize, ssize);
+		slot = mmu_hash_ops.hpte_insert(hpte_group, vpn, pa, rflags,
+						vflags | HPTE_V_SECONDARY,
+						psize, psize, ssize);
 		if (slot == -1) {
 			if (mftb() & 0x1)
 				hpte_group = ((hash & htab_hash_mask) *
 					      HPTES_PER_GROUP)&~0x7UL;
 
-			ppc_md.hpte_remove(hpte_group);
+			mmu_hash_ops.hpte_remove(hpte_group);
 			goto repeat;
 		}
 	}
@@ -1662,8 +1666,9 @@ static void kernel_unmap_linear_page(unsigned long vaddr, unsigned long lmi)
 		hash = ~hash;
 	slot = (hash & htab_hash_mask) * HPTES_PER_GROUP;
 	slot += hidx & _PTEIDX_GROUP_IX;
-	ppc_md.hpte_invalidate(slot, vpn, mmu_linear_psize, mmu_linear_psize,
-			       mmu_kernel_ssize, 0);
+	mmu_hash_ops.hpte_invalidate(slot, vpn, mmu_linear_psize,
+				     mmu_linear_psize,
+				     mmu_kernel_ssize, 0);
 }
 
 void __kernel_map_pages(struct page *page, int numpages, int enable)
diff --git a/arch/powerpc/mm/hugepage-hash64.c b/arch/powerpc/mm/hugepage-hash64.c
index ba3fc22..f20d16f 100644
--- a/arch/powerpc/mm/hugepage-hash64.c
+++ b/arch/powerpc/mm/hugepage-hash64.c
@@ -103,8 +103,8 @@ int __hash_page_thp(unsigned long ea, unsigned long access, unsigned long vsid,
 		slot = (hash & htab_hash_mask) * HPTES_PER_GROUP;
 		slot += hidx & _PTEIDX_GROUP_IX;
 
-		ret = ppc_md.hpte_updatepp(slot, rflags, vpn,
-					   psize, lpsize, ssize, flags);
+		ret = mmu_hash_ops.hpte_updatepp(slot, rflags, vpn,
+						 psize, lpsize, ssize, flags);
 		/*
 		 * We failed to update, try to insert a new entry.
 		 */
@@ -131,23 +131,24 @@ repeat:
 		hpte_group = ((hash & htab_hash_mask) * HPTES_PER_GROUP) & ~0x7UL;
 
 		/* Insert into the hash table, primary slot */
-		slot = ppc_md.hpte_insert(hpte_group, vpn, pa, rflags, 0,
-					  psize, lpsize, ssize);
+		slot = mmu_hash_ops.hpte_insert(hpte_group, vpn, pa, rflags, 0,
+						psize, lpsize, ssize);
 		/*
 		 * Primary is full, try the secondary
 		 */
 		if (unlikely(slot == -1)) {
 			hpte_group = ((~hash & htab_hash_mask) *
 				      HPTES_PER_GROUP) & ~0x7UL;
-			slot = ppc_md.hpte_insert(hpte_group, vpn, pa,
-						  rflags, HPTE_V_SECONDARY,
-						  psize, lpsize, ssize);
+			slot = mmu_hash_ops.hpte_insert(hpte_group, vpn, pa,
+							rflags,
+							HPTE_V_SECONDARY,
+							psize, lpsize, ssize);
 			if (slot == -1) {
 				if (mftb() & 0x1)
 					hpte_group = ((hash & htab_hash_mask) *
 						      HPTES_PER_GROUP) & ~0x7UL;
 
-				ppc_md.hpte_remove(hpte_group);
+				mmu_hash_ops.hpte_remove(hpte_group);
 				goto repeat;
 			}
 		}
diff --git a/arch/powerpc/mm/hugetlbpage-hash64.c b/arch/powerpc/mm/hugetlbpage-hash64.c
index 3058560..d5026f3 100644
--- a/arch/powerpc/mm/hugetlbpage-hash64.c
+++ b/arch/powerpc/mm/hugetlbpage-hash64.c
@@ -79,8 +79,8 @@ int __hash_page_huge(unsigned long ea, unsigned long access, unsigned long vsid,
 		slot = (hash & htab_hash_mask) * HPTES_PER_GROUP;
 		slot += (old_pte & H_PAGE_F_GIX) >> H_PAGE_F_GIX_SHIFT;
 
-		if (ppc_md.hpte_updatepp(slot, rflags, vpn, mmu_psize,
-					 mmu_psize, ssize, flags) == -1)
+		if (mmu_hash_ops.hpte_updatepp(slot, rflags, vpn, mmu_psize,
+					       mmu_psize, ssize, flags) == -1)
 			old_pte &= ~_PAGE_HPTEFLAGS;
 	}
 
diff --git a/arch/powerpc/mm/pgtable-book3s64.c b/arch/powerpc/mm/pgtable-book3s64.c
index 6703187..85c6070 100644
--- a/arch/powerpc/mm/pgtable-book3s64.c
+++ b/arch/powerpc/mm/pgtable-book3s64.c
@@ -14,6 +14,8 @@
 #include "mmu_decl.h"
 #include <trace/events/thp.h>
 
+int (*ppc64_update_partition_table)(u64);
+
 #ifdef CONFIG_TRANSPARENT_HUGEPAGE
 /*
  * This is called when relaxing access to a hugepage. It's also called in the page
diff --git a/arch/powerpc/mm/pgtable-radix.c b/arch/powerpc/mm/pgtable-radix.c
index 6624b7b..3ababda 100644
--- a/arch/powerpc/mm/pgtable-radix.c
+++ b/arch/powerpc/mm/pgtable-radix.c
@@ -114,6 +114,9 @@ static void __init radix_init_pgtable(void)
 
 	/* We don't support slb for radix */
 	mmu_slb_size = 0;
+
+	BUG_ON(!ppc64_update_partition_table);
+
 	/*
 	 * Create the linear mapping, using standard page size for now
 	 */
@@ -169,7 +172,7 @@ redo:
 	 * of process table here. But our linear mapping also enable us to use
 	 * physical address here.
 	 */
-	ppc_md.update_partition_table(__pa(process_tb) | (PRTB_SIZE_SHIFT - 12) | PATB_GR);
+	ppc64_update_partition_table(__pa(process_tb) | (PRTB_SIZE_SHIFT - 12) | PATB_GR);
 	pr_info("Process table %p and radix root for kernel: %p\n", process_tb, init_mm.pgd);
 }
 
@@ -197,7 +200,7 @@ static void __init radix_init_partition_table(void)
 
 void __init radix_init_native(void)
 {
-	ppc_md.update_partition_table = native_update_partition_table;
+	ppc64_update_partition_table = native_update_partition_table;
 }
 
 static int __init get_idx_from_shift(unsigned int shift)
diff --git a/arch/powerpc/platforms/ps3/htab.c b/arch/powerpc/platforms/ps3/htab.c
index c9a3e67..cb3c503 100644
--- a/arch/powerpc/platforms/ps3/htab.c
+++ b/arch/powerpc/platforms/ps3/htab.c
@@ -195,12 +195,12 @@ static void ps3_hpte_clear(void)
 
 void __init ps3_hpte_init(unsigned long htab_size)
 {
-	ppc_md.hpte_invalidate = ps3_hpte_invalidate;
-	ppc_md.hpte_updatepp = ps3_hpte_updatepp;
-	ppc_md.hpte_updateboltedpp = ps3_hpte_updateboltedpp;
-	ppc_md.hpte_insert = ps3_hpte_insert;
-	ppc_md.hpte_remove = ps3_hpte_remove;
-	ppc_md.hpte_clear_all = ps3_hpte_clear;
+	mmu_hash_ops.hpte_invalidate = ps3_hpte_invalidate;
+	mmu_hash_ops.hpte_updatepp = ps3_hpte_updatepp;
+	mmu_hash_ops.hpte_updateboltedpp = ps3_hpte_updateboltedpp;
+	mmu_hash_ops.hpte_insert = ps3_hpte_insert;
+	mmu_hash_ops.hpte_remove = ps3_hpte_remove;
+	mmu_hash_ops.hpte_clear_all = ps3_hpte_clear;
 
 	ppc64_pft_size = __ilog2(htab_size);
 }
diff --git a/arch/powerpc/platforms/pseries/lpar.c b/arch/powerpc/platforms/pseries/lpar.c
index eb2374e..b79ab20 100644
--- a/arch/powerpc/platforms/pseries/lpar.c
+++ b/arch/powerpc/platforms/pseries/lpar.c
@@ -590,15 +590,15 @@ __setup("bulk_remove=", disable_bulk_remove);
 
 void __init hpte_init_lpar(void)
 {
-	ppc_md.hpte_invalidate	= pSeries_lpar_hpte_invalidate;
-	ppc_md.hpte_updatepp	= pSeries_lpar_hpte_updatepp;
-	ppc_md.hpte_updateboltedpp = pSeries_lpar_hpte_updateboltedpp;
-	ppc_md.hpte_insert	= pSeries_lpar_hpte_insert;
-	ppc_md.hpte_remove	= pSeries_lpar_hpte_remove;
-	ppc_md.hpte_removebolted = pSeries_lpar_hpte_removebolted;
-	ppc_md.flush_hash_range	= pSeries_lpar_flush_hash_range;
-	ppc_md.hpte_clear_all   = pSeries_lpar_hptab_clear;
-	ppc_md.hugepage_invalidate = pSeries_lpar_hugepage_invalidate;
+	mmu_hash_ops.hpte_invalidate	 = pSeries_lpar_hpte_invalidate;
+	mmu_hash_ops.hpte_updatepp	 = pSeries_lpar_hpte_updatepp;
+	mmu_hash_ops.hpte_updateboltedpp = pSeries_lpar_hpte_updateboltedpp;
+	mmu_hash_ops.hpte_insert	 = pSeries_lpar_hpte_insert;
+	mmu_hash_ops.hpte_remove	 = pSeries_lpar_hpte_remove;
+	mmu_hash_ops.hpte_removebolted   = pSeries_lpar_hpte_removebolted;
+	mmu_hash_ops.flush_hash_range	 = pSeries_lpar_flush_hash_range;
+	mmu_hash_ops.hpte_clear_all      = pSeries_lpar_hptab_clear;
+	mmu_hash_ops.hugepage_invalidate = pSeries_lpar_hugepage_invalidate;
 }
 
 #ifdef CONFIG_PPC_SMLPAR
-- 
2.7.4

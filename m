Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e23smtp05.au.ibm.com (e23smtp05.au.ibm.com [202.81.31.147])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e23smtp05.au.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id A45E92C02B7
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 Jun 2013 19:01:41 +1000 (EST)
Received: from /spool/local
 by e23smtp05.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Thu, 20 Jun 2013 18:55:38 +1000
Received: from d23relay05.au.ibm.com (d23relay05.au.ibm.com [9.190.235.152])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id DF8EC2CE804D
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 Jun 2013 19:01:37 +1000 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay05.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r5K8kiw63408182
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 Jun 2013 18:46:45 +1000
Received: from d23av02.au.ibm.com (loopback [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r5K91a4G002241
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 Jun 2013 19:01:36 +1000
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: benh@kernel.crashing.org, paulus@samba.org
Subject: [PATCH -V11 15/15] powerpc: Optimize hugepage invalidate
Date: Thu, 20 Jun 2013 14:30:27 +0530
Message-Id: <1371718827-15065-16-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
In-Reply-To: <1371718827-15065-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
References: <1371718827-15065-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>

Hugepage invalidate involves invalidating multiple hpte entries.
Optimize the operation using H_BULK_REMOVE on lpar platforms.
On native, reduce the number of tlb flush.

Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/machdep.h    |   3 +
 arch/powerpc/mm/hash_native_64.c      |  73 ++++++++++++++++++++
 arch/powerpc/mm/pgtable_64.c          |  12 +++-
 arch/powerpc/platforms/pseries/lpar.c | 122 ++++++++++++++++++++++++++++++++--
 4 files changed, 201 insertions(+), 9 deletions(-)

diff --git a/arch/powerpc/include/asm/machdep.h b/arch/powerpc/include/asm/machdep.h
index 801e3c6..8b48090 100644
--- a/arch/powerpc/include/asm/machdep.h
+++ b/arch/powerpc/include/asm/machdep.h
@@ -57,6 +57,9 @@ struct machdep_calls {
 	void            (*hpte_removebolted)(unsigned long ea,
 					     int psize, int ssize);
 	void		(*flush_hash_range)(unsigned long number, int local);
+	void		(*hugepage_invalidate)(struct mm_struct *mm,
+					       unsigned char *hpte_slot_array,
+					       unsigned long addr, int psize);
 
 	/* special for kexec, to be called in real mode, linear mapping is
 	 * destroyed as well */
diff --git a/arch/powerpc/mm/hash_native_64.c b/arch/powerpc/mm/hash_native_64.c
index 6d152bc..3f0c30a 100644
--- a/arch/powerpc/mm/hash_native_64.c
+++ b/arch/powerpc/mm/hash_native_64.c
@@ -407,6 +407,78 @@ static void native_hpte_invalidate(unsigned long slot, unsigned long vpn,
 	local_irq_restore(flags);
 }
 
+static void native_hugepage_invalidate(struct mm_struct *mm,
+				       unsigned char *hpte_slot_array,
+				       unsigned long addr, int psize)
+{
+	int ssize = 0, i;
+	int lock_tlbie;
+	struct hash_pte *hptep;
+	int actual_psize = MMU_PAGE_16M;
+	unsigned int max_hpte_count, valid;
+	unsigned long flags, s_addr = addr;
+	unsigned long hpte_v, want_v, shift;
+	unsigned long hidx, vpn = 0, vsid, hash, slot;
+
+	shift = mmu_psize_defs[psize].shift;
+	max_hpte_count = 1U << (PMD_SHIFT - shift);
+
+	local_irq_save(flags);
+	for (i = 0; i < max_hpte_count; i++) {
+		valid = hpte_valid(hpte_slot_array, i);
+		if (!valid)
+			continue;
+		hidx =  hpte_hash_index(hpte_slot_array, i);
+
+		/* get the vpn */
+		addr = s_addr + (i * (1ul << shift));
+		if (!is_kernel_addr(addr)) {
+			ssize = user_segment_size(addr);
+			vsid = get_vsid(mm->context.id, addr, ssize);
+			WARN_ON(vsid == 0);
+		} else {
+			vsid = get_kernel_vsid(addr, mmu_kernel_ssize);
+			ssize = mmu_kernel_ssize;
+		}
+
+		vpn = hpt_vpn(addr, vsid, ssize);
+		hash = hpt_hash(vpn, shift, ssize);
+		if (hidx & _PTEIDX_SECONDARY)
+			hash = ~hash;
+
+		slot = (hash & htab_hash_mask) * HPTES_PER_GROUP;
+		slot += hidx & _PTEIDX_GROUP_IX;
+
+		hptep = htab_address + slot;
+		want_v = hpte_encode_avpn(vpn, psize, ssize);
+		native_lock_hpte(hptep);
+		hpte_v = hptep->v;
+
+		/* Even if we miss, we need to invalidate the TLB */
+		if (!HPTE_V_COMPARE(hpte_v, want_v) || !(hpte_v & HPTE_V_VALID))
+			native_unlock_hpte(hptep);
+		else
+			/* Invalidate the hpte. NOTE: this also unlocks it */
+			hptep->v = 0;
+	}
+	/*
+	 * Since this is a hugepage, we just need a single tlbie.
+	 * use the last vpn.
+	 */
+	lock_tlbie = !mmu_has_feature(MMU_FTR_LOCKLESS_TLBIE);
+	if (lock_tlbie)
+		raw_spin_lock(&native_tlbie_lock);
+
+	asm volatile("ptesync":::"memory");
+	__tlbie(vpn, psize, actual_psize, ssize);
+	asm volatile("eieio; tlbsync; ptesync":::"memory");
+
+	if (lock_tlbie)
+		raw_spin_unlock(&native_tlbie_lock);
+
+	local_irq_restore(flags);
+}
+
 static inline int __hpte_actual_psize(unsigned int lp, int psize)
 {
 	int i, shift;
@@ -640,4 +712,5 @@ void __init hpte_init_native(void)
 	ppc_md.hpte_remove	= native_hpte_remove;
 	ppc_md.hpte_clear_all	= native_hpte_clear;
 	ppc_md.flush_hash_range = native_flush_hash_range;
+	ppc_md.hugepage_invalidate   = native_hugepage_invalidate;
 }
diff --git a/arch/powerpc/mm/pgtable_64.c b/arch/powerpc/mm/pgtable_64.c
index 074a4a2..536eec72 100644
--- a/arch/powerpc/mm/pgtable_64.c
+++ b/arch/powerpc/mm/pgtable_64.c
@@ -708,6 +708,7 @@ void hpte_do_hugepage_flush(struct mm_struct *mm, unsigned long addr,
 {
 	int ssize, i;
 	unsigned long s_addr;
+	int max_hpte_count;
 	unsigned int psize, valid;
 	unsigned char *hpte_slot_array;
 	unsigned long hidx, vpn, vsid, hash, shift, slot;
@@ -727,9 +728,16 @@ void hpte_do_hugepage_flush(struct mm_struct *mm, unsigned long addr,
 
 	/* get the base page size */
 	psize = get_slice_psize(mm, s_addr);
-	shift = mmu_psize_defs[psize].shift;
 
-	for (i = 0; i < (HPAGE_PMD_SIZE >> shift); i++) {
+	if (ppc_md.hugepage_invalidate)
+		return ppc_md.hugepage_invalidate(mm, hpte_slot_array,
+						  s_addr, psize);
+	/*
+	 * No bluk hpte removal support, invalidate each entry
+	 */
+	shift = mmu_psize_defs[psize].shift;
+	max_hpte_count = HPAGE_PMD_SIZE >> shift;
+	for (i = 0; i < max_hpte_count; i++) {
 		/*
 		 * 8 bits per each hpte entries
 		 * 000| [ secondary group (one bit) | hidx (3 bits) | valid bit]
diff --git a/arch/powerpc/platforms/pseries/lpar.c b/arch/powerpc/platforms/pseries/lpar.c
index ca45c8f..fd0f2f2 100644
--- a/arch/powerpc/platforms/pseries/lpar.c
+++ b/arch/powerpc/platforms/pseries/lpar.c
@@ -45,6 +45,13 @@
 #include "plpar_wrappers.h"
 #include "pseries.h"
 
+/* Flag bits for H_BULK_REMOVE */
+#define HBR_REQUEST	0x4000000000000000UL
+#define HBR_RESPONSE	0x8000000000000000UL
+#define HBR_END		0xc000000000000000UL
+#define HBR_AVPN	0x0200000000000000UL
+#define HBR_ANDCOND	0x0100000000000000UL
+
 
 /* in hvCall.S */
 EXPORT_SYMBOL(plpar_hcall);
@@ -347,6 +354,113 @@ static void pSeries_lpar_hpte_invalidate(unsigned long slot, unsigned long vpn,
 	BUG_ON(lpar_rc != H_SUCCESS);
 }
 
+/*
+ * Limit iterations holding pSeries_lpar_tlbie_lock to 3. We also need
+ * to make sure that we avoid bouncing the hypervisor tlbie lock.
+ */
+#define PPC64_HUGE_HPTE_BATCH 12
+
+static void __pSeries_lpar_hugepage_invalidate(unsigned long *slot,
+					     unsigned long *vpn, int count,
+					     int psize, int ssize)
+{
+	unsigned long param[8];
+	int i = 0, pix = 0, rc;
+	unsigned long flags = 0;
+	int lock_tlbie = !mmu_has_feature(MMU_FTR_LOCKLESS_TLBIE);
+
+	if (lock_tlbie)
+		spin_lock_irqsave(&pSeries_lpar_tlbie_lock, flags);
+
+	for (i = 0; i < count; i++) {
+
+		if (!firmware_has_feature(FW_FEATURE_BULK_REMOVE)) {
+			pSeries_lpar_hpte_invalidate(slot[i], vpn[i], psize, 0,
+						     ssize, 0);
+		} else {
+			param[pix] = HBR_REQUEST | HBR_AVPN | slot[i];
+			param[pix+1] = hpte_encode_avpn(vpn[i], psize, ssize);
+			pix += 2;
+			if (pix == 8) {
+				rc = plpar_hcall9(H_BULK_REMOVE, param,
+						  param[0], param[1], param[2],
+						  param[3], param[4], param[5],
+						  param[6], param[7]);
+				BUG_ON(rc != H_SUCCESS);
+				pix = 0;
+			}
+		}
+	}
+	if (pix) {
+		param[pix] = HBR_END;
+		rc = plpar_hcall9(H_BULK_REMOVE, param, param[0], param[1],
+				  param[2], param[3], param[4], param[5],
+				  param[6], param[7]);
+		BUG_ON(rc != H_SUCCESS);
+	}
+
+	if (lock_tlbie)
+		spin_unlock_irqrestore(&pSeries_lpar_tlbie_lock, flags);
+}
+
+static void pSeries_lpar_hugepage_invalidate(struct mm_struct *mm,
+				       unsigned char *hpte_slot_array,
+				       unsigned long addr, int psize)
+{
+	int ssize = 0, i, index = 0;
+	unsigned long s_addr = addr;
+	unsigned int max_hpte_count, valid;
+	unsigned long vpn_array[PPC64_HUGE_HPTE_BATCH];
+	unsigned long slot_array[PPC64_HUGE_HPTE_BATCH];
+	unsigned long shift, hidx, vpn = 0, vsid, hash, slot;
+
+	shift = mmu_psize_defs[psize].shift;
+	max_hpte_count = 1U << (PMD_SHIFT - shift);
+
+	for (i = 0; i < max_hpte_count; i++) {
+		valid = hpte_valid(hpte_slot_array, i);
+		if (!valid)
+			continue;
+		hidx =  hpte_hash_index(hpte_slot_array, i);
+
+		/* get the vpn */
+		addr = s_addr + (i * (1ul << shift));
+		if (!is_kernel_addr(addr)) {
+			ssize = user_segment_size(addr);
+			vsid = get_vsid(mm->context.id, addr, ssize);
+			WARN_ON(vsid == 0);
+		} else {
+			vsid = get_kernel_vsid(addr, mmu_kernel_ssize);
+			ssize = mmu_kernel_ssize;
+		}
+
+		vpn = hpt_vpn(addr, vsid, ssize);
+		hash = hpt_hash(vpn, shift, ssize);
+		if (hidx & _PTEIDX_SECONDARY)
+			hash = ~hash;
+
+		slot = (hash & htab_hash_mask) * HPTES_PER_GROUP;
+		slot += hidx & _PTEIDX_GROUP_IX;
+
+		slot_array[index] = slot;
+		vpn_array[index] = vpn;
+		if (index == PPC64_HUGE_HPTE_BATCH - 1) {
+			/*
+			 * Now do a bluk invalidate
+			 */
+			__pSeries_lpar_hugepage_invalidate(slot_array,
+							   vpn_array,
+							   PPC64_HUGE_HPTE_BATCH,
+							   psize, ssize);
+			index = 0;
+		} else
+			index++;
+	}
+	if (index)
+		__pSeries_lpar_hugepage_invalidate(slot_array, vpn_array,
+						   index, psize, ssize);
+}
+
 static void pSeries_lpar_hpte_removebolted(unsigned long ea,
 					   int psize, int ssize)
 {
@@ -364,13 +478,6 @@ static void pSeries_lpar_hpte_removebolted(unsigned long ea,
 	pSeries_lpar_hpte_invalidate(slot, vpn, psize, 0, ssize, 0);
 }
 
-/* Flag bits for H_BULK_REMOVE */
-#define HBR_REQUEST	0x4000000000000000UL
-#define HBR_RESPONSE	0x8000000000000000UL
-#define HBR_END		0xc000000000000000UL
-#define HBR_AVPN	0x0200000000000000UL
-#define HBR_ANDCOND	0x0100000000000000UL
-
 /*
  * Take a spinlock around flushes to avoid bouncing the hypervisor tlbie
  * lock.
@@ -459,6 +566,7 @@ void __init hpte_init_lpar(void)
 	ppc_md.hpte_removebolted = pSeries_lpar_hpte_removebolted;
 	ppc_md.flush_hash_range	= pSeries_lpar_flush_hash_range;
 	ppc_md.hpte_clear_all   = pSeries_lpar_hptab_clear;
+	ppc_md.hugepage_invalidate = pSeries_lpar_hugepage_invalidate;
 }
 
 #ifdef CONFIG_PPC_SMLPAR
-- 
1.8.1.2

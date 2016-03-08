Return-Path: <dgibson@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 20B5F1A011E
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  8 Mar 2016 14:09:11 +1100 (AEDT)
From: David Gibson <david@gibson.dropbear.id.au>
To: paulus@samba.org,
	aik@ozlabs.ru,
	benh@kernel.crashing.org
Cc: bharata@linux.vnet.ibm.com, linuxppc-dev@lists.ozlabs.org,
 David Gibson <david@gibson.dropbear.id.au>
Subject: [RFCv2 13/25] powerpc/kvm: Don't store values derivable from HPT order
Date: Tue,  8 Mar 2016 14:08:50 +1100
Message-Id: <1457406542-6210-14-git-send-email-david@gibson.dropbear.id.au>
In-Reply-To: <1457406542-6210-1-git-send-email-david@gibson.dropbear.id.au>
References: <1457406542-6210-1-git-send-email-david@gibson.dropbear.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Currently the kvm_hpt_info structure stores the hashed page table's order,
and also the number of HPTEs it contains and a mask for its size.  The
last two can be easily derived from the order, so remove them and just
calculate them as necessary with a couple of helper inlines.

Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 arch/powerpc/include/asm/kvm_book3s_64.h | 12 ++++++++++++
 arch/powerpc/include/asm/kvm_host.h      |  2 --
 arch/powerpc/kvm/book3s_64_mmu_hv.c      | 28 +++++++++++++---------------
 arch/powerpc/kvm/book3s_hv_rm_mmu.c      | 18 +++++++++---------
 4 files changed, 34 insertions(+), 26 deletions(-)

diff --git a/arch/powerpc/include/asm/kvm_book3s_64.h b/arch/powerpc/include/asm/kvm_book3s_64.h
index 2aa79c8..75b2dee 100644
--- a/arch/powerpc/include/asm/kvm_book3s_64.h
+++ b/arch/powerpc/include/asm/kvm_book3s_64.h
@@ -437,6 +437,18 @@ extern void kvmppc_mmu_debugfs_init(struct kvm *kvm);
 
 extern void kvmhv_rm_send_ipi(int cpu);
 
+static inline unsigned long kvmppc_hpt_npte(struct kvm_hpt_info *hpt)
+{
+	/* HPTEs are 2**4 bytes long */
+	return 1UL << (hpt->order - 4);
+}
+
+static inline unsigned long kvmppc_hpt_mask(struct kvm_hpt_info *hpt)
+{
+	/* 128 (2**7) bytes in each HPTEG */
+	return (1UL << (hpt->order - 7)) - 1;
+}
+
 #endif /* CONFIG_KVM_BOOK3S_HV_POSSIBLE */
 
 #endif /* __ASM_KVM_BOOK3S_64_H__ */
diff --git a/arch/powerpc/include/asm/kvm_host.h b/arch/powerpc/include/asm/kvm_host.h
index c32413a..718dc56 100644
--- a/arch/powerpc/include/asm/kvm_host.h
+++ b/arch/powerpc/include/asm/kvm_host.h
@@ -226,8 +226,6 @@ struct kvm_arch_memory_slot {
 struct kvm_hpt_info {
 	unsigned long virt;
 	struct revmap_entry *rev;
-	unsigned long npte;
-	unsigned long mask;
 	u32 order;
 	int cma;
 };
diff --git a/arch/powerpc/kvm/book3s_64_mmu_hv.c b/arch/powerpc/kvm/book3s_64_mmu_hv.c
index 2ba9d99..679c292 100644
--- a/arch/powerpc/kvm/book3s_64_mmu_hv.c
+++ b/arch/powerpc/kvm/book3s_64_mmu_hv.c
@@ -83,13 +83,9 @@ long kvmppc_alloc_hpt(struct kvm *kvm, u32 *htab_orderp)
 
 	kvm->arch.hpt.virt = hpt;
 	kvm->arch.hpt.order = order;
-	/* HPTEs are 2**4 bytes long */
-	kvm->arch.hpt.npte = 1ul << (order - 4);
-	/* 128 (2**7) bytes in each HPTEG */
-	kvm->arch.hpt.mask = (1ul << (order - 7)) - 1;
 
 	/* Allocate reverse map array */
-	rev = vmalloc(sizeof(struct revmap_entry) * kvm->arch.hpt.npte);
+	rev = vmalloc(sizeof(struct revmap_entry) * kvmppc_hpt_npte(&kvm->arch.hpt));
 	if (!rev) {
 		pr_err("kvmppc_alloc_hpt: Couldn't alloc reverse map array\n");
 		goto out_freehpt;
@@ -192,8 +188,8 @@ void kvmppc_map_vrma(struct kvm_vcpu *vcpu, struct kvm_memory_slot *memslot,
 	if (npages > 1ul << (40 - porder))
 		npages = 1ul << (40 - porder);
 	/* Can't use more than 1 HPTE per HPTEG */
-	if (npages > kvm->arch.hpt.mask + 1)
-		npages = kvm->arch.hpt.mask + 1;
+	if (npages > kvmppc_hpt_mask(&kvm->arch.hpt) + 1)
+		npages = kvmppc_hpt_mask(&kvm->arch.hpt) + 1;
 
 	hp0 = HPTE_V_1TB_SEG | (VRMA_VSID << (40 - 16)) |
 		HPTE_V_BOLTED | hpte0_pgsize_encoding(psize);
@@ -203,7 +199,8 @@ void kvmppc_map_vrma(struct kvm_vcpu *vcpu, struct kvm_memory_slot *memslot,
 	for (i = 0; i < npages; ++i) {
 		addr = i << porder;
 		/* can't use hpt_hash since va > 64 bits */
-		hash = (i ^ (VRMA_VSID ^ (VRMA_VSID << 25))) & kvm->arch.hpt.mask;
+		hash = (i ^ (VRMA_VSID ^ (VRMA_VSID << 25)))
+			& kvmppc_hpt_mask(&kvm->arch.hpt);
 		/*
 		 * We assume that the hash table is empty and no
 		 * vcpus are using it at this stage.  Since we create
@@ -1268,7 +1265,7 @@ static ssize_t kvm_htab_read(struct file *file, char __user *buf,
 
 		/* Skip uninteresting entries, i.e. clean on not-first pass */
 		if (!first_pass) {
-			while (i < kvm->arch.hpt.npte &&
+			while (i < kvmppc_hpt_npte(&kvm->arch.hpt) &&
 			       !hpte_dirty(revp, hptp)) {
 				++i;
 				hptp += 2;
@@ -1278,7 +1275,7 @@ static ssize_t kvm_htab_read(struct file *file, char __user *buf,
 		hdr.index = i;
 
 		/* Grab a series of valid entries */
-		while (i < kvm->arch.hpt.npte &&
+		while (i < kvmppc_hpt_npte(&kvm->arch.hpt) &&
 		       hdr.n_valid < 0xffff &&
 		       nb + HPTE_SIZE < count &&
 		       record_hpte(flags, hptp, hpte, revp, 1, first_pass)) {
@@ -1294,7 +1291,7 @@ static ssize_t kvm_htab_read(struct file *file, char __user *buf,
 			++revp;
 		}
 		/* Now skip invalid entries while we can */
-		while (i < kvm->arch.hpt.npte &&
+		while (i < kvmppc_hpt_npte(&kvm->arch.hpt) &&
 		       hdr.n_invalid < 0xffff &&
 		       record_hpte(flags, hptp, hpte, revp, 0, first_pass)) {
 			/* found an invalid entry */
@@ -1315,7 +1312,7 @@ static ssize_t kvm_htab_read(struct file *file, char __user *buf,
 		}
 
 		/* Check if we've wrapped around the hash table */
-		if (i >= kvm->arch.hpt.npte) {
+		if (i >= kvmppc_hpt_npte(&kvm->arch.hpt)) {
 			i = 0;
 			ctx->first_pass = 0;
 			break;
@@ -1374,8 +1371,8 @@ static ssize_t kvm_htab_write(struct file *file, const char __user *buf,
 
 		err = -EINVAL;
 		i = hdr.index;
-		if (i >= kvm->arch.hpt.npte ||
-		    i + hdr.n_valid + hdr.n_invalid > kvm->arch.hpt.npte)
+		if (i >= kvmppc_hpt_npte(&kvm->arch.hpt) ||
+		    i + hdr.n_valid + hdr.n_invalid > kvmppc_hpt_npte(&kvm->arch.hpt))
 			break;
 
 		hptp = (__be64 *)(kvm->arch.hpt.virt + (i * HPTE_SIZE));
@@ -1566,7 +1563,8 @@ static ssize_t debugfs_htab_read(struct file *file, char __user *buf,
 	kvm = p->kvm;
 	i = p->hpt_index;
 	hptp = (__be64 *)(kvm->arch.hpt.virt + (i * HPTE_SIZE));
-	for (; len != 0 && i < kvm->arch.hpt.npte; ++i, hptp += 2) {
+	for (; len != 0 && i < kvmppc_hpt_npte(&kvm->arch.hpt);
+	     ++i, hptp += 2) {
 		if (!(be64_to_cpu(hptp[0]) & (HPTE_V_VALID | HPTE_V_ABSENT)))
 			continue;
 
diff --git a/arch/powerpc/kvm/book3s_hv_rm_mmu.c b/arch/powerpc/kvm/book3s_hv_rm_mmu.c
index a4641e4..347ed0e 100644
--- a/arch/powerpc/kvm/book3s_hv_rm_mmu.c
+++ b/arch/powerpc/kvm/book3s_hv_rm_mmu.c
@@ -281,7 +281,7 @@ long kvmppc_do_h_enter(struct kvm *kvm, unsigned long flags,
 
 	/* Find and lock the HPTEG slot to use */
  do_insert:
-	if (pte_index >= kvm->arch.hpt.npte)
+	if (pte_index >= kvmppc_hpt_npte(&kvm->arch.hpt))
 		return H_PARAMETER;
 	if (likely((flags & H_EXACT) == 0)) {
 		pte_index &= ~7UL;
@@ -437,7 +437,7 @@ long kvmppc_do_h_remove(struct kvm *kvm, unsigned long flags,
 	struct revmap_entry *rev;
 	u64 pte;
 
-	if (pte_index >= kvm->arch.hpt.npte)
+	if (pte_index >= kvmppc_hpt_npte(&kvm->arch.hpt))
 		return H_PARAMETER;
 	hpte = (__be64 *)(kvm->arch.hpt.virt + (pte_index << 4));
 	while (!try_lock_hpte(hpte, HPTE_V_HVLOCK))
@@ -515,7 +515,7 @@ long kvmppc_h_bulk_remove(struct kvm_vcpu *vcpu)
 				break;
 			}
 			if (req != 1 || flags == 3 ||
-			    pte_index >= kvm->arch.hpt.npte) {
+			    pte_index >= kvmppc_hpt_npte(&kvm->arch.hpt)) {
 				/* parameter error */
 				args[j] = ((0xa0 | flags) << 56) + pte_index;
 				ret = H_PARAMETER;
@@ -607,7 +607,7 @@ long kvmppc_h_protect(struct kvm_vcpu *vcpu, unsigned long flags,
 	unsigned long v, r, rb, mask, bits;
 	u64 pte;
 
-	if (pte_index >= kvm->arch.hpt.npte)
+	if (pte_index >= kvmppc_hpt_npte(&kvm->arch.hpt))
 		return H_PARAMETER;
 
 	hpte = (__be64 *)(kvm->arch.hpt.virt + (pte_index << 4));
@@ -670,7 +670,7 @@ long kvmppc_h_read(struct kvm_vcpu *vcpu, unsigned long flags,
 	int i, n = 1;
 	struct revmap_entry *rev = NULL;
 
-	if (pte_index >= kvm->arch.hpt.npte)
+	if (pte_index >= kvmppc_hpt_npte(&kvm->arch.hpt))
 		return H_PARAMETER;
 	if (flags & H_READ_4) {
 		pte_index &= ~3;
@@ -705,7 +705,7 @@ long kvmppc_h_clear_ref(struct kvm_vcpu *vcpu, unsigned long flags,
 	unsigned long *rmap;
 	long ret = H_NOT_FOUND;
 
-	if (pte_index >= kvm->arch.hpt.npte)
+	if (pte_index >= kvmppc_hpt_npte(&kvm->arch.hpt))
 		return H_PARAMETER;
 
 	rev = real_vmalloc_addr(&kvm->arch.hpt.rev[pte_index]);
@@ -751,7 +751,7 @@ long kvmppc_h_clear_mod(struct kvm_vcpu *vcpu, unsigned long flags,
 	unsigned long *rmap;
 	long ret = H_NOT_FOUND;
 
-	if (pte_index >= kvm->arch.hpt.npte)
+	if (pte_index >= kvmppc_hpt_npte(&kvm->arch.hpt))
 		return H_PARAMETER;
 
 	rev = real_vmalloc_addr(&kvm->arch.hpt.rev[pte_index]);
@@ -861,7 +861,7 @@ long kvmppc_hv_find_lock_hpte(struct kvm *kvm, gva_t eaddr, unsigned long slb_v,
 		somask = (1UL << 28) - 1;
 		vsid = (slb_v & ~SLB_VSID_B) >> SLB_VSID_SHIFT;
 	}
-	hash = (vsid ^ ((eaddr & somask) >> pshift)) & kvm->arch.hpt.mask;
+	hash = (vsid ^ ((eaddr & somask) >> pshift)) & kvmppc_hpt_mask(&kvm->arch.hpt);
 	avpn = slb_v & ~(somask >> 16);	/* also includes B */
 	avpn |= (eaddr & somask) >> 16;
 
@@ -902,7 +902,7 @@ long kvmppc_hv_find_lock_hpte(struct kvm *kvm, gva_t eaddr, unsigned long slb_v,
 		if (val & HPTE_V_SECONDARY)
 			break;
 		val |= HPTE_V_SECONDARY;
-		hash = hash ^ kvm->arch.hpt.mask;
+		hash = hash ^ kvmppc_hpt_mask(&kvm->arch.hpt);
 	}
 	return -1;
 }
-- 
2.5.0

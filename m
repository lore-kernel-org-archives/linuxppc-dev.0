Return-Path: <paulus@ozlabs.org>
Date: Tue, 13 Dec 2011 09:27:39 +1100
From: Paul Mackerras <paulus@samba.org>
To: Alexander Graf <agraf@suse.de>
Subject: [PATCH v3 03/14] KVM: PPC: Keep a record of HV guest view of hashed
 page table entries
Message-ID: <20111212222739.GD18868@bloggs.ozlabs.ibm.com>
References: <20111212222347.GA18868@bloggs.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20111212222347.GA18868@bloggs.ozlabs.ibm.com>
Cc: linuxppc-dev@ozlabs.org, kvm@vger.kernel.org, kvm-ppc@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This adds an array that parallels the guest hashed page table (HPT),
that is, it has one entry per HPTE, used to store the guest's view
of the second doubleword of the corresponding HPTE.  The first
doubleword in the HPTE is the same as the guest's idea of it, so we
don't need to store a copy, but the second doubleword in the HPTE has
the real page number rather than the guest's logical page number.
This allows us to remove the back_translate() and reverse_xlate()
functions.

This "reverse mapping" array is vmalloc'd, meaning that to access it
in real mode we have to walk the kernel's page tables explicitly.
That is done by the new real_vmalloc_addr() function.  (In fact this
returns an address in the linear mapping, so the result is usable
both in real mode and in virtual mode.)

There are also some minor cleanups here: moving the definitions of
HPT_ORDER etc. to a header file and defining HPT_NPTE for HPT_NPTEG << 3.

Signed-off-by: Paul Mackerras <paulus@samba.org>
---
 arch/powerpc/include/asm/kvm_book3s_64.h |    8 +++
 arch/powerpc/include/asm/kvm_host.h      |   10 ++++
 arch/powerpc/kvm/book3s_64_mmu_hv.c      |   44 +++++++++++----
 arch/powerpc/kvm/book3s_hv_rm_mmu.c      |   87 ++++++++++++++++++------------
 4 files changed, 103 insertions(+), 46 deletions(-)

diff --git a/arch/powerpc/include/asm/kvm_book3s_64.h b/arch/powerpc/include/asm/kvm_book3s_64.h
index 2054e47..fa3dc79 100644
--- a/arch/powerpc/include/asm/kvm_book3s_64.h
+++ b/arch/powerpc/include/asm/kvm_book3s_64.h
@@ -35,6 +35,14 @@ static inline void svcpu_put(struct kvmppc_book3s_shadow_vcpu *svcpu)
 
 #define SPAPR_TCE_SHIFT		12
 
+#ifdef CONFIG_KVM_BOOK3S_64_HV
+/* For now use fixed-size 16MB page table */
+#define HPT_ORDER	24
+#define HPT_NPTEG	(1ul << (HPT_ORDER - 7))	/* 128B per pteg */
+#define HPT_NPTE	(HPT_NPTEG << 3)		/* 8 PTEs per PTEG */
+#define HPT_HASH_MASK	(HPT_NPTEG - 1)
+#endif
+
 static inline unsigned long compute_tlbie_rb(unsigned long v, unsigned long r,
 					     unsigned long pte_index)
 {
diff --git a/arch/powerpc/include/asm/kvm_host.h b/arch/powerpc/include/asm/kvm_host.h
index 66c75cd..629df2e 100644
--- a/arch/powerpc/include/asm/kvm_host.h
+++ b/arch/powerpc/include/asm/kvm_host.h
@@ -166,9 +166,19 @@ struct kvmppc_rma_info {
 	atomic_t 	 use_count;
 };
 
+/*
+ * The reverse mapping array has one entry for each HPTE,
+ * which stores the guest's view of the second word of the HPTE
+ * (including the guest physical address of the mapping).
+ */
+struct revmap_entry {
+	unsigned long guest_rpte;
+};
+
 struct kvm_arch {
 #ifdef CONFIG_KVM_BOOK3S_64_HV
 	unsigned long hpt_virt;
+	struct revmap_entry *revmap;
 	unsigned long ram_npages;
 	unsigned long ram_psize;
 	unsigned long ram_porder;
diff --git a/arch/powerpc/kvm/book3s_64_mmu_hv.c b/arch/powerpc/kvm/book3s_64_mmu_hv.c
index bc3a2ea..80ece8d 100644
--- a/arch/powerpc/kvm/book3s_64_mmu_hv.c
+++ b/arch/powerpc/kvm/book3s_64_mmu_hv.c
@@ -23,6 +23,7 @@
 #include <linux/gfp.h>
 #include <linux/slab.h>
 #include <linux/hugetlb.h>
+#include <linux/vmalloc.h>
 
 #include <asm/tlbflush.h>
 #include <asm/kvm_ppc.h>
@@ -33,11 +34,6 @@
 #include <asm/ppc-opcode.h>
 #include <asm/cputable.h>
 
-/* For now use fixed-size 16MB page table */
-#define HPT_ORDER	24
-#define HPT_NPTEG	(1ul << (HPT_ORDER - 7))	/* 128B per pteg */
-#define HPT_HASH_MASK	(HPT_NPTEG - 1)
-
 /* Pages in the VRMA are 16MB pages */
 #define VRMA_PAGE_ORDER	24
 #define VRMA_VSID	0x1ffffffUL	/* 1TB VSID reserved for VRMA */
@@ -51,7 +47,9 @@ long kvmppc_alloc_hpt(struct kvm *kvm)
 {
 	unsigned long hpt;
 	unsigned long lpid;
+	struct revmap_entry *rev;
 
+	/* Allocate guest's hashed page table */
 	hpt = __get_free_pages(GFP_KERNEL|__GFP_ZERO|__GFP_REPEAT|__GFP_NOWARN,
 			       HPT_ORDER - PAGE_SHIFT);
 	if (!hpt) {
@@ -60,12 +58,20 @@ long kvmppc_alloc_hpt(struct kvm *kvm)
 	}
 	kvm->arch.hpt_virt = hpt;
 
+	/* Allocate reverse map array */
+	rev = vmalloc(sizeof(struct revmap_entry) * HPT_NPTE);
+	if (!rev) {
+		pr_err("kvmppc_alloc_hpt: Couldn't alloc reverse map array\n");
+		goto out_freehpt;
+	}
+	kvm->arch.revmap = rev;
+
+	/* Allocate the guest's logical partition ID */
 	do {
 		lpid = find_first_zero_bit(lpid_inuse, NR_LPIDS);
 		if (lpid >= NR_LPIDS) {
 			pr_err("kvm_alloc_hpt: No LPIDs free\n");
-			free_pages(hpt, HPT_ORDER - PAGE_SHIFT);
-			return -ENOMEM;
+			goto out_freeboth;
 		}
 	} while (test_and_set_bit(lpid, lpid_inuse));
 
@@ -74,11 +80,18 @@ long kvmppc_alloc_hpt(struct kvm *kvm)
 
 	pr_info("KVM guest htab at %lx, LPID %lx\n", hpt, lpid);
 	return 0;
+
+ out_freeboth:
+	vfree(rev);
+ out_freehpt:
+	free_pages(hpt, HPT_ORDER - PAGE_SHIFT);
+	return -ENOMEM;
 }
 
 void kvmppc_free_hpt(struct kvm *kvm)
 {
 	clear_bit(kvm->arch.lpid, lpid_inuse);
+	vfree(kvm->arch.revmap);
 	free_pages(kvm->arch.hpt_virt, HPT_ORDER - PAGE_SHIFT);
 }
 
@@ -89,14 +102,16 @@ void kvmppc_map_vrma(struct kvm *kvm, struct kvm_userspace_memory_region *mem)
 	unsigned long pfn;
 	unsigned long *hpte;
 	unsigned long hash;
+	unsigned long porder = kvm->arch.ram_porder;
+	struct revmap_entry *rev;
 	struct kvmppc_pginfo *pginfo = kvm->arch.ram_pginfo;
 
 	if (!pginfo)
 		return;
 
 	/* VRMA can't be > 1TB */
-	if (npages > 1ul << (40 - kvm->arch.ram_porder))
-		npages = 1ul << (40 - kvm->arch.ram_porder);
+	if (npages > 1ul << (40 - porder))
+		npages = 1ul << (40 - porder);
 	/* Can't use more than 1 HPTE per HPTEG */
 	if (npages > HPT_NPTEG)
 		npages = HPT_NPTEG;
@@ -113,15 +128,20 @@ void kvmppc_map_vrma(struct kvm *kvm, struct kvm_userspace_memory_region *mem)
 		 * at most one HPTE per HPTEG, we just assume entry 7
 		 * is available and use it.
 		 */
-		hpte = (unsigned long *) (kvm->arch.hpt_virt + (hash << 7));
-		hpte += 7 * 2;
+		hash = (hash << 3) + 7;
+		hpte = (unsigned long *) (kvm->arch.hpt_virt + (hash << 4));
 		/* HPTE low word - RPN, protection, etc. */
 		hpte[1] = (pfn << PAGE_SHIFT) | HPTE_R_R | HPTE_R_C |
 			HPTE_R_M | PP_RWXX;
-		wmb();
+		smp_wmb();
 		hpte[0] = HPTE_V_1TB_SEG | (VRMA_VSID << (40 - 16)) |
 			(i << (VRMA_PAGE_ORDER - 16)) | HPTE_V_BOLTED |
 			HPTE_V_LARGE | HPTE_V_VALID;
+
+		/* Reverse map info */
+		rev = &kvm->arch.revmap[hash];
+		rev->guest_rpte = (i << porder) | HPTE_R_R | HPTE_R_C |
+			HPTE_R_M | PP_RWXX;
 	}
 }
 
diff --git a/arch/powerpc/kvm/book3s_hv_rm_mmu.c b/arch/powerpc/kvm/book3s_hv_rm_mmu.c
index bacb0cf..6148493 100644
--- a/arch/powerpc/kvm/book3s_hv_rm_mmu.c
+++ b/arch/powerpc/kvm/book3s_hv_rm_mmu.c
@@ -20,10 +20,19 @@
 #include <asm/synch.h>
 #include <asm/ppc-opcode.h>
 
-/* For now use fixed-size 16MB page table */
-#define HPT_ORDER	24
-#define HPT_NPTEG	(1ul << (HPT_ORDER - 7))	/* 128B per pteg */
-#define HPT_HASH_MASK	(HPT_NPTEG - 1)
+/* Translate address of a vmalloc'd thing to a linear map address */
+static void *real_vmalloc_addr(void *x)
+{
+	unsigned long addr = (unsigned long) x;
+	pte_t *p;
+
+	p = find_linux_pte(swapper_pg_dir, addr);
+	if (!p || !pte_present(*p))
+		return NULL;
+	/* assume we don't have huge pages in vmalloc space... */
+	addr = (pte_pfn(*p) << PAGE_SHIFT) | (addr & ~PAGE_MASK);
+	return __va(addr);
+}
 
 #define HPTE_V_HVLOCK	0x40UL
 
@@ -52,6 +61,8 @@ long kvmppc_h_enter(struct kvm_vcpu *vcpu, unsigned long flags,
 	struct kvm *kvm = vcpu->kvm;
 	unsigned long i, lpn, pa;
 	unsigned long *hpte;
+	struct revmap_entry *rev;
+	unsigned long g_ptel = ptel;
 
 	/* only handle 4k, 64k and 16M pages for now */
 	porder = 12;
@@ -82,7 +93,7 @@ long kvmppc_h_enter(struct kvm_vcpu *vcpu, unsigned long flags,
 	pteh &= ~0x60UL;
 	ptel &= ~(HPTE_R_PP0 - kvm->arch.ram_psize);
 	ptel |= pa;
-	if (pte_index >= (HPT_NPTEG << 3))
+	if (pte_index >= HPT_NPTE)
 		return H_PARAMETER;
 	if (likely((flags & H_EXACT) == 0)) {
 		pte_index &= ~7UL;
@@ -95,18 +106,22 @@ long kvmppc_h_enter(struct kvm_vcpu *vcpu, unsigned long flags,
 				break;
 			hpte += 2;
 		}
+		pte_index += i;
 	} else {
-		i = 0;
 		hpte = (unsigned long *)(kvm->arch.hpt_virt + (pte_index << 4));
 		if (!lock_hpte(hpte, HPTE_V_HVLOCK | HPTE_V_VALID))
 			return H_PTEG_FULL;
 	}
+
+	/* Save away the guest's idea of the second HPTE dword */
+	rev = real_vmalloc_addr(&kvm->arch.revmap[pte_index]);
+	if (rev)
+		rev->guest_rpte = g_ptel;
 	hpte[1] = ptel;
 	eieio();
 	hpte[0] = pteh;
 	asm volatile("ptesync" : : : "memory");
-	atomic_inc(&kvm->arch.ram_pginfo[lpn].refcnt);
-	vcpu->arch.gpr[4] = pte_index + i;
+	vcpu->arch.gpr[4] = pte_index;
 	return H_SUCCESS;
 }
 
@@ -138,7 +153,7 @@ long kvmppc_h_remove(struct kvm_vcpu *vcpu, unsigned long flags,
 	unsigned long *hpte;
 	unsigned long v, r, rb;
 
-	if (pte_index >= (HPT_NPTEG << 3))
+	if (pte_index >= HPT_NPTE)
 		return H_PARAMETER;
 	hpte = (unsigned long *)(kvm->arch.hpt_virt + (pte_index << 4));
 	while (!lock_hpte(hpte, HPTE_V_HVLOCK))
@@ -193,7 +208,7 @@ long kvmppc_h_bulk_remove(struct kvm_vcpu *vcpu)
 		if (req == 3)
 			break;
 		if (req != 1 || flags == 3 ||
-		    pte_index >= (HPT_NPTEG << 3)) {
+		    pte_index >= HPT_NPTE) {
 			/* parameter error */
 			args[i * 2] = ((0xa0 | flags) << 56) + pte_index;
 			ret = H_PARAMETER;
@@ -256,9 +271,10 @@ long kvmppc_h_protect(struct kvm_vcpu *vcpu, unsigned long flags,
 {
 	struct kvm *kvm = vcpu->kvm;
 	unsigned long *hpte;
-	unsigned long v, r, rb;
+	struct revmap_entry *rev;
+	unsigned long v, r, rb, mask, bits;
 
-	if (pte_index >= (HPT_NPTEG << 3))
+	if (pte_index >= HPT_NPTE)
 		return H_PARAMETER;
 	hpte = (unsigned long *)(kvm->arch.hpt_virt + (pte_index << 4));
 	while (!lock_hpte(hpte, HPTE_V_HVLOCK))
@@ -271,11 +287,21 @@ long kvmppc_h_protect(struct kvm_vcpu *vcpu, unsigned long flags,
 	if (atomic_read(&kvm->online_vcpus) == 1)
 		flags |= H_LOCAL;
 	v = hpte[0];
-	r = hpte[1] & ~(HPTE_R_PP0 | HPTE_R_PP | HPTE_R_N |
-			HPTE_R_KEY_HI | HPTE_R_KEY_LO);
-	r |= (flags << 55) & HPTE_R_PP0;
-	r |= (flags << 48) & HPTE_R_KEY_HI;
-	r |= flags & (HPTE_R_PP | HPTE_R_N | HPTE_R_KEY_LO);
+	bits = (flags << 55) & HPTE_R_PP0;
+	bits |= (flags << 48) & HPTE_R_KEY_HI;
+	bits |= flags & (HPTE_R_PP | HPTE_R_N | HPTE_R_KEY_LO);
+
+	/* Update guest view of 2nd HPTE dword */
+	mask = HPTE_R_PP0 | HPTE_R_PP | HPTE_R_N |
+		HPTE_R_KEY_HI | HPTE_R_KEY_LO;
+	rev = real_vmalloc_addr(&kvm->arch.revmap[pte_index]);
+	if (rev) {
+		r = (rev->guest_rpte & ~mask) | bits;
+		rev->guest_rpte = r;
+	}
+	r = (hpte[1] & ~mask) | bits;
+
+	/* Update HPTE */
 	rb = compute_tlbie_rb(v, r, pte_index);
 	hpte[0] = v & ~HPTE_V_VALID;
 	if (!(flags & H_LOCAL)) {
@@ -298,38 +324,31 @@ long kvmppc_h_protect(struct kvm_vcpu *vcpu, unsigned long flags,
 	return H_SUCCESS;
 }
 
-static unsigned long reverse_xlate(struct kvm *kvm, unsigned long realaddr)
-{
-	long int i;
-	unsigned long offset, rpn;
-
-	offset = realaddr & (kvm->arch.ram_psize - 1);
-	rpn = (realaddr - offset) >> PAGE_SHIFT;
-	for (i = 0; i < kvm->arch.ram_npages; ++i)
-		if (rpn == kvm->arch.ram_pginfo[i].pfn)
-			return (i << PAGE_SHIFT) + offset;
-	return HPTE_R_RPN;	/* all 1s in the RPN field */
-}
-
 long kvmppc_h_read(struct kvm_vcpu *vcpu, unsigned long flags,
 		   unsigned long pte_index)
 {
 	struct kvm *kvm = vcpu->kvm;
 	unsigned long *hpte, r;
 	int i, n = 1;
+	struct revmap_entry *rev = NULL;
 
-	if (pte_index >= (HPT_NPTEG << 3))
+	if (pte_index >= HPT_NPTE)
 		return H_PARAMETER;
 	if (flags & H_READ_4) {
 		pte_index &= ~3;
 		n = 4;
 	}
+	if (flags & H_R_XLATE)
+		rev = real_vmalloc_addr(&kvm->arch.revmap[pte_index]);
 	for (i = 0; i < n; ++i, ++pte_index) {
 		hpte = (unsigned long *)(kvm->arch.hpt_virt + (pte_index << 4));
 		r = hpte[1];
-		if ((flags & H_R_XLATE) && (hpte[0] & HPTE_V_VALID))
-			r = reverse_xlate(kvm, r & HPTE_R_RPN) |
-				(r & ~HPTE_R_RPN);
+		if (hpte[0] & HPTE_V_VALID) {
+			if (rev)
+				r = rev[i].guest_rpte;
+			else
+				r = hpte[1] | HPTE_R_RPN;
+		}
 		vcpu->arch.gpr[4 + i * 2] = hpte[0];
 		vcpu->arch.gpr[5 + i * 2] = r;
 	}
-- 
1.7.7.3

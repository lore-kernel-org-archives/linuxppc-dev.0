Return-Path: <paulus@ozlabs.org>
Date: Thu, 17 Nov 2011 09:56:50 +1100
From: Paul Mackerras <paulus@samba.org>
To: kvm-ppc@vger.kernel.org
Subject: [PATCH 02/11] KVM: PPC: Keep a record of HV guest view of hashed
 page table entries
Message-ID: <20111116225650.GC26985@bloggs.ozlabs.ibm.com>
References: <20111116225055.GA26985@bloggs.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20111116225055.GA26985@bloggs.ozlabs.ibm.com>
Cc: linuxppc-dev@ozlabs.org, Alexander Graf <agraf@suse.de>
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

This also corrects a couple of bugs in kvmppc_mmu_get_pp_value().

Signed-off-by: Paul Mackerras <paulus@samba.org>
---
 arch/powerpc/include/asm/kvm_book3s_64.h |   20 +++++
 arch/powerpc/include/asm/kvm_host.h      |   10 ++
 arch/powerpc/kvm/book3s_64_mmu_hv.c      |  136 +++++++++++++-----------------
 arch/powerpc/kvm/book3s_hv_rm_mmu.c      |   95 +++++++++++++--------
 4 files changed, 147 insertions(+), 114 deletions(-)

diff --git a/arch/powerpc/include/asm/kvm_book3s_64.h b/arch/powerpc/include/asm/kvm_book3s_64.h
index 53692c2..63542dd 100644
--- a/arch/powerpc/include/asm/kvm_book3s_64.h
+++ b/arch/powerpc/include/asm/kvm_book3s_64.h
@@ -29,6 +29,14 @@ static inline struct kvmppc_book3s_shadow_vcpu *to_svcpu(struct kvm_vcpu *vcpu)
 
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
@@ -86,4 +94,16 @@ static inline long try_lock_hpte(unsigned long *hpte, unsigned long bits)
 	return old == 0;
 }
 
+static inline unsigned long hpte_page_size(unsigned long h, unsigned long l)
+{
+	/* only handle 4k, 64k and 16M pages for now */
+	if (!(h & HPTE_V_LARGE))
+		return 1ul << 12;		/* 4k page */
+	if ((l & 0xf000) == 0x1000 && cpu_has_feature(CPU_FTR_ARCH_206))
+		return 1ul << 16;		/* 64k page */
+	if ((l & 0xff000) == 0)
+		return 1ul << 24;		/* 16M page */
+	return 0;				/* error */
+}
+
 #endif /* __ASM_KVM_BOOK3S_64_H__ */
diff --git a/arch/powerpc/include/asm/kvm_host.h b/arch/powerpc/include/asm/kvm_host.h
index f142a2d..56f7046 100644
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
index da8c2f4..2b9b8be 100644
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
 
@@ -192,22 +212,6 @@ static unsigned int kvmppc_mmu_book3s_hv_slb_pshift(struct kvmppc_slb *slbe)
 	return 12;     	/* Unsupported */
 }
 
-static unsigned long back_translate(struct kvm *kvm, unsigned long ra)
-{
-	unsigned long offset, rpn, i;
-
-	/* XXX handle MMIO  */
-	offset = ra & (kvm->arch.ram_psize - 1);
-	rpn = (ra - offset) >> PAGE_SHIFT;
-	for (i = 0; i < kvm->arch.ram_npages; ++i)
-		if (rpn == kvm->arch.ram_pginfo[i].pfn)
-			return (i << kvm->arch.ram_porder) + offset;
-
-	/* Error value */
-	return -1ull;
-}
-
-
 static char pp_read_perm[16] = {
 	/* key = 0 */	1, 1, 1, 1, 0, 0, 1, 0,
 	/* key = 1 */	0, 1, 1, 1, 0, 0, 0, 0
@@ -224,7 +228,7 @@ static int kvmppc_hv_find_hpte(struct kvm *kvm, gva_t eaddr,
 	unsigned int i;
 	unsigned int pshift;
 	unsigned long somask;
-	unsigned long vsid, hash;
+	unsigned long vsid, hash, index;
 	unsigned long avpn;
 	unsigned long *hpte;
 
@@ -252,7 +256,7 @@ static int kvmppc_hv_find_hpte(struct kvm *kvm, gva_t eaddr,
 		hpte = (unsigned long *)(kvm->arch.hpt_virt + (hash << 7));	
 
 		for (i = 0; i < 16; i += 2) {
-			unsigned long oldv, v, r;
+			unsigned long oldv, v, r, gr;
 
 			/* Read the PTE racily */
 			oldv = hpte[i] & ~HPTE_V_HVLOCK;
@@ -267,6 +271,8 @@ static int kvmppc_hv_find_hpte(struct kvm *kvm, gva_t eaddr,
 				cpu_relax();
 			v = hpte[i];
 			r = hpte[i+1];
+			index = (hash << 3) + (i >> 1);
+			gr = kvm->arch.revmap[index].guest_rpte;
 
 			/* Unlock the HPTE */
 			asm volatile("lwsync" : : : "memory");
@@ -280,7 +286,8 @@ static int kvmppc_hv_find_hpte(struct kvm *kvm, gva_t eaddr,
 			}
 			ret[0] = v;
 			ret[1] = r;
-			return 1;
+			ret[2] = gr;
+			return index;
 		}
 
 		if (avpn & HPTE_V_SECONDARY)
@@ -288,32 +295,20 @@ static int kvmppc_hv_find_hpte(struct kvm *kvm, gva_t eaddr,
 		avpn |= HPTE_V_SECONDARY;
 		hash = hash ^ HPT_HASH_MASK;
 	}
-	return 0;
+	return -1;
 }
 
-static unsigned long kvmppc_mmu_get_real_addr(unsigned long hpte[2],
+static unsigned long kvmppc_mmu_get_real_addr(unsigned long v, unsigned long r,
 			unsigned long ea)
 {
-	unsigned int hpshift;
-	unsigned long r = hpte[1];
 	unsigned long ra_mask;
 
-	/* Get page size */
-	hpshift = 12;
-	if (hpte[0] & HPTE_V_LARGE) {
-		if ((r & 0xf000) == 0x1000)
-			hpshift = 16;
-		else if ((r & 0xff000) == 0)
-			hpshift = 24;
-		/* XXX TODO: Add 16G */
-	}
-	ra_mask = (1 << hpshift) - 1;
-
+	ra_mask = hpte_page_size(v, r) - 1;
 	return (r & HPTE_R_RPN & ~ra_mask) | (ea & ra_mask);
 }
 
 static unsigned int kvmppc_mmu_get_pp_value(struct kvm_vcpu *vcpu,
-			struct kvmppc_slb *slbe, unsigned long hpte[2])
+			struct kvmppc_slb *slbe, unsigned long hpte_r)
 {
 	unsigned int key, pp;
 
@@ -322,8 +317,8 @@ static unsigned int kvmppc_mmu_get_pp_value(struct kvm_vcpu *vcpu,
 	else 
 		key = slbe->origv & SLB_VSID_KS;
 
-	pp = hpte[0] & HPTE_R_PP;
-	if (pp & HPTE_R_PP0)
+	pp = hpte_r & HPTE_R_PP;
+	if (hpte_r & HPTE_R_PP0)
 		pp |= 4;
 	if (key)
 		pp |= 8;
@@ -340,9 +335,9 @@ static int kvmppc_mmu_book3s_64_hv_xlate(struct kvm_vcpu *vcpu, gva_t eaddr,
 {
 	struct kvm *kvm = vcpu->kvm;
 	struct kvmppc_slb *slbe;
-	unsigned int pp, skey;
-	unsigned long hpte[2];
-	unsigned long ra;
+	unsigned int pp;
+	unsigned long hpte[3];
+	int index;
 
 	/* Get SLB entry */
 	slbe = kvmppc_mmu_book3s_hv_find_slbe(vcpu, eaddr);
@@ -350,37 +345,23 @@ static int kvmppc_mmu_book3s_64_hv_xlate(struct kvm_vcpu *vcpu, gva_t eaddr,
 		return -EINVAL;
 
 	/* Find the HPTE in the hash table */
-	if (!kvmppc_hv_find_hpte(kvm, eaddr, slbe, hpte))
+	index = kvmppc_hv_find_hpte(kvm, eaddr, slbe, hpte);
+	if (index < 0)
 		return -ENOENT;
 
 	gpte->eaddr = eaddr;
 	gpte->vpage = ((hpte[0] & HPTE_V_AVPN) << 4) | ((eaddr >> 12) & 0xfff);
 
-	/* Get the real address from the HPTE */
-	ra = kvmppc_mmu_get_real_addr(hpte, eaddr);
-
 	/* Get PP bits and key for permission check */
-	pp = kvmppc_mmu_get_pp_value(vcpu, slbe, hpte);
+	pp = kvmppc_mmu_get_pp_value(vcpu, slbe, hpte[1]);
 
 	/* Calculate permissions */
 	gpte->may_execute = !(hpte[1] & (HPTE_R_N | HPTE_R_G));
 	gpte->may_read = pp_read_perm[pp];
 	gpte->may_write = pp_write_perm[pp];
 
-	/*
-	 * Get the storage key value.  31 means a special no-access
-	 * HPTE that we have inserted, with the guest physical address
-	 * in the RPN field.  Other keys mean that the the RPN field
-	 * contains the real address.
-	 */
-	skey = ((hpte[1] & HPTE_R_KEY_HI) >> 57) |
-		((hpte[1] & HPTE_R_KEY_LO) >> 9);
-	if (skey == 31) {
-		gpte->raddr = ra;
-		return 0;
-	}
-
-	gpte->raddr = back_translate(kvm, ra);
+	/* Get the guest physical address */
+	gpte->raddr = kvmppc_mmu_get_real_addr(hpte[0], hpte[2], eaddr);
 	return 0;
 }
 
@@ -388,23 +369,24 @@ int kvmppc_book3s_hv_emulate_mmio(struct kvm_run *run, struct kvm_vcpu *vcpu)
 {
 	struct kvm *kvm = vcpu->kvm;
 	struct kvmppc_slb *slbe;
-	unsigned long hpte[2];
+	unsigned long hpte[3];
 	unsigned long srr0 = kvmppc_get_pc(vcpu);
 	unsigned long ea = vcpu->arch.fault_dar;	
 	unsigned long gpa;
 	unsigned int pp, ok;
 	u32 last_inst, dsisr = vcpu->arch.fault_dsisr;
-	int ret = 0;
+	int index, ret = 0;
 
 	/*
 	 * Translate the access address.
 	 * If we can't find the HPTE, just return and re-execute the
-	 * instruction.f
+	 * instruction.
  	 */
 	slbe = kvmppc_mmu_book3s_hv_find_slbe(vcpu, ea);
 	if (!slbe)
 		return RESUME_GUEST;
-	if (!kvmppc_hv_find_hpte(kvm, ea, slbe, hpte))
+	index = kvmppc_hv_find_hpte(kvm, ea, slbe, hpte);
+	if (index < 0)
 		return RESUME_GUEST;
 
 	/*
@@ -420,7 +402,7 @@ int kvmppc_book3s_hv_emulate_mmio(struct kvm_run *run, struct kvm_vcpu *vcpu)
 	}
 
 	/* Check whether the attempted access was permitted */
-	pp = kvmppc_mmu_get_pp_value(vcpu, slbe, hpte);
+	pp = kvmppc_mmu_get_pp_value(vcpu, slbe, hpte[1]);
 	ok = (dsisr & DSISR_ISSTORE) ? pp_write_perm[pp] : pp_read_perm[pp];
 	if (!ok) {
 		vcpu->arch.shregs.dar = ea;
@@ -431,7 +413,7 @@ int kvmppc_book3s_hv_emulate_mmio(struct kvm_run *run, struct kvm_vcpu *vcpu)
 	}
 
 	/* Translate the logical address */
-	gpa = kvmppc_mmu_get_real_addr(hpte, ea);
+	gpa = kvmppc_mmu_get_real_addr(hpte[0], hpte[2], ea);
 
 	/*
 	 * We try to load the last instruction.  We don't let
diff --git a/arch/powerpc/kvm/book3s_hv_rm_mmu.c b/arch/powerpc/kvm/book3s_hv_rm_mmu.c
index 6cb2f23..2da8fac 100644
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
 
 /*
  * Since this file is built in even if KVM is a module, we need
@@ -54,6 +63,8 @@ long kvmppc_h_enter(struct kvm_vcpu *vcpu, unsigned long flags,
 	struct kvm *kvm = vcpu->kvm;
 	unsigned long i, lpn, pa, gpa, psize;
 	unsigned long *hpte;
+	struct revmap_entry *rev;
+	unsigned long g_ptel = ptel;
 
 	/* only handle 4k, 64k and 16M pages for now */
 	porder = 12;
@@ -153,7 +164,7 @@ long kvmppc_h_enter(struct kvm_vcpu *vcpu, unsigned long flags,
 	}
 	pteh &= ~0x60UL;
 	
-	if (pte_index >= (HPT_NPTEG << 3))
+	if (pte_index >= HPT_NPTE)
 		return H_PARAMETER;
 	if (likely((flags & H_EXACT) == 0)) {
 		pte_index &= ~7UL;
@@ -166,18 +177,22 @@ long kvmppc_h_enter(struct kvm_vcpu *vcpu, unsigned long flags,
 				break;
 			hpte += 2;
 		}
+		pte_index += i;
 	} else {
-		i = 0;
 		hpte = (unsigned long *)(kvm->arch.hpt_virt + (pte_index << 4));
 		if (!try_lock_hpte(hpte, HPTE_V_HVLOCK | HPTE_V_VALID))
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
-	// XXX atomic_inc(&kvm->arch.ram_pginfo[lpn].refcnt);
-	vcpu->arch.gpr[4] = pte_index + i;
+	vcpu->arch.gpr[4] = pte_index;
 	return H_SUCCESS;
 }
 
@@ -209,7 +224,7 @@ long kvmppc_h_remove(struct kvm_vcpu *vcpu, unsigned long flags,
 	unsigned long *hpte;
 	unsigned long v, r, rb;
 
-	if (pte_index >= (HPT_NPTEG << 3))
+	if (pte_index >= HPT_NPTE)
 		return H_PARAMETER;
 	hpte = (unsigned long *)(kvm->arch.hpt_virt + (pte_index << 4));
 	while (!try_lock_hpte(hpte, HPTE_V_HVLOCK))
@@ -264,7 +279,7 @@ long kvmppc_h_bulk_remove(struct kvm_vcpu *vcpu)
 		if (req == 3)
 			break;
 		if (req != 1 || flags == 3 ||
-		    pte_index >= (HPT_NPTEG << 3)) {
+		    pte_index >= HPT_NPTE) {
 			/* parameter error */
 			args[i * 2] = ((0xa0 | flags) << 56) + pte_index;
 			ret = H_PARAMETER;
@@ -327,9 +342,10 @@ long kvmppc_h_protect(struct kvm_vcpu *vcpu, unsigned long flags,
 {
 	struct kvm *kvm = vcpu->kvm;
 	unsigned long *hpte;
-	unsigned long v, r, rb;
+	struct revmap_entry *rev;
+	unsigned long v, r, rb, mask, bits;
 
-	if (pte_index >= (HPT_NPTEG << 3))
+	if (pte_index >= HPT_NPTE)
 		return H_PARAMETER;
 	/* Don't let it set a normal memory page to key 31 */
 	if (((flags >> 9) & 0x1f) == 0x1f)
@@ -347,17 +363,30 @@ long kvmppc_h_protect(struct kvm_vcpu *vcpu, unsigned long flags,
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
+	rev = real_vmalloc_addr(&kvm->arch.revmap[pte_index]);
+	if (rev) {
+		mask = HPTE_R_PP0 | HPTE_R_PP | HPTE_R_N |
+			HPTE_R_KEY_HI | HPTE_R_KEY_LO;
+		r = rev->guest_rpte & ~mask;
+		r |= bits;
+		rev->guest_rpte = r;
+	}
 
  	/* Don't let guest remove N or key from emulated MMIO pages */
 	if ((hpte[1] & (HPTE_R_KEY_HI | HPTE_R_KEY_LO)) == 
 	    (HPTE_R_KEY_HI | HPTE_R_KEY_LO))
-		r |= HPTE_R_N | HPTE_R_KEY_HI | HPTE_R_KEY_LO;
-		
+		mask = HPTE_R_PP0 | HPTE_R_PP;
+	else
+		mask = HPTE_R_PP0 | HPTE_R_PP | HPTE_R_N |
+			HPTE_R_KEY_HI | HPTE_R_KEY_LO;
+	r = (hpte[1] & ~mask) | (bits & mask);
+
+	/* Update HPTE */
 	rb = compute_tlbie_rb(v, r, pte_index);
 	hpte[0] = v & ~HPTE_V_VALID;
 	if (!(flags & H_LOCAL)) {
@@ -380,39 +409,31 @@ long kvmppc_h_protect(struct kvm_vcpu *vcpu, unsigned long flags,
 	return H_SUCCESS;
 }
 
-static unsigned long reverse_xlate(struct kvm *kvm, unsigned long realaddr)
-{
-	long int i;
-	unsigned long offset, rpn;
-
-	/* XXX handle MMIO and EMU */
-	offset = realaddr & (kvm->arch.ram_psize - 1);
-	rpn = (realaddr - offset) >> PAGE_SHIFT;
-	for (i = 0; i < kvm->arch.ram_npages; ++i)
-		if (rpn == kvm->arch.ram_pginfo[i].pfn)
-			return (i << kvm->arch.ram_porder) + offset;
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
1.7.7.2

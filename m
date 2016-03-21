Return-Path: <dgibson@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qT22q4kzmzDqCn
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 21 Mar 2016 14:52:19 +1100 (AEDT)
From: David Gibson <david@gibson.dropbear.id.au>
To: paulus@samba.org,
	aik@ozlabs.ru,
	benh@kernel.crashing.org
Cc: bharata@linux.vnet.ibm.com, linuxppc-dev@lists.ozlabs.org,
 michael@ellerman.id.au, David Gibson <david@gibson.dropbear.id.au>
Subject: [RFCv3 10/17] powerpc/kvm: Split HPT allocation from activation
Date: Mon, 21 Mar 2016 14:53:17 +1100
Message-Id: <1458532404-21258-11-git-send-email-david@gibson.dropbear.id.au>
In-Reply-To: <1458532404-21258-1-git-send-email-david@gibson.dropbear.id.au>
References: <1458532404-21258-1-git-send-email-david@gibson.dropbear.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Currently, kvmppc_alloc_hpt() both allocates a new hashed page table (HPT)
and sets it up as the active page table for a VM.  For the upcoming HPT
resize implementation we're going to want to allocate HPTs separately from
activating them.

So, split the allocation itself out into kvmppc_allocate_hpt() and perform
the activation with a new kvmppc_set_hpt() function.  Likewise we split
kvmppc_free_hpt(), which just frees the HPT, from kvmppc_release_hpt()
which unsets it as an active HPT, then frees it.

We also move the logic to fall back to smaller HPT sizes if the first try
fails into the single caller which used that behaviour,
kvmppc_hv_setup_htab_rma().  This introduces a slight semantic change, in
that previously if the initial attempt at CMA allocation faile, we would
fall back to attempting smaller sizes with the page allocator.  Now, we
try first CMA, then the page allocator at each size.  As far as I can tell
this change should be harmless.

To match, we make kvmppc_free_hpt() just free the actual HPT itself.  The
call to kvmppc_free_lpid() that was there, we move to the single caller.

Signed-off-by: David Gibson <david@gibson.dropbear.id.au>

# Conflicts:
#	arch/powerpc/kvm/book3s_64_mmu_hv.c
---
 arch/powerpc/include/asm/kvm_book3s_64.h |  3 ++
 arch/powerpc/include/asm/kvm_ppc.h       |  5 +-
 arch/powerpc/kvm/book3s_64_mmu_hv.c      | 89 ++++++++++++++++----------------
 arch/powerpc/kvm/book3s_hv.c             | 18 +++++--
 4 files changed, 65 insertions(+), 50 deletions(-)

diff --git a/arch/powerpc/include/asm/kvm_book3s_64.h b/arch/powerpc/include/asm/kvm_book3s_64.h
index 9f762aa..17ea22f 100644
--- a/arch/powerpc/include/asm/kvm_book3s_64.h
+++ b/arch/powerpc/include/asm/kvm_book3s_64.h
@@ -20,6 +20,9 @@
 #ifndef __ASM_KVM_BOOK3S_64_H__
 #define __ASM_KVM_BOOK3S_64_H__
 
+/* Power architecture requires HPT is at least 256kB */
+#define PPC_MIN_HPT_ORDER	18
+
 #ifdef CONFIG_KVM_BOOK3S_PR_POSSIBLE
 static inline struct kvmppc_book3s_shadow_vcpu *svcpu_get(struct kvm_vcpu *vcpu)
 {
diff --git a/arch/powerpc/include/asm/kvm_ppc.h b/arch/powerpc/include/asm/kvm_ppc.h
index 49cb8b4..154dd63 100644
--- a/arch/powerpc/include/asm/kvm_ppc.h
+++ b/arch/powerpc/include/asm/kvm_ppc.h
@@ -155,9 +155,10 @@ extern void kvmppc_core_destroy_mmu(struct kvm_vcpu *vcpu);
 extern int kvmppc_kvm_pv(struct kvm_vcpu *vcpu);
 extern void kvmppc_map_magic(struct kvm_vcpu *vcpu);
 
-extern long kvmppc_alloc_hpt(struct kvm *kvm, u32 *htab_orderp);
+extern int kvmppc_allocate_hpt(struct kvm_hpt_info *info, u32 order);
+extern void kvmppc_set_hpt(struct kvm *kvm, struct kvm_hpt_info *info);
 extern long kvmppc_alloc_reset_hpt(struct kvm *kvm, u32 *htab_orderp);
-extern void kvmppc_free_hpt(struct kvm *kvm);
+extern void kvmppc_free_hpt(struct kvm_hpt_info *info);
 extern long kvmppc_prepare_vrma(struct kvm *kvm,
 				struct kvm_userspace_memory_region *mem);
 extern void kvmppc_map_vrma(struct kvm_vcpu *vcpu,
diff --git a/arch/powerpc/kvm/book3s_64_mmu_hv.c b/arch/powerpc/kvm/book3s_64_mmu_hv.c
index c057c81..518b573 100644
--- a/arch/powerpc/kvm/book3s_64_mmu_hv.c
+++ b/arch/powerpc/kvm/book3s_64_mmu_hv.c
@@ -40,74 +40,69 @@
 
 #include "trace_hv.h"
 
-/* Power architecture requires HPT is at least 256kB */
-#define PPC_MIN_HPT_ORDER	18
-
 static long kvmppc_virtmode_do_h_enter(struct kvm *kvm, unsigned long flags,
 				long pte_index, unsigned long pteh,
 				unsigned long ptel, unsigned long *pte_idx_ret);
 static void kvmppc_rmap_reset(struct kvm *kvm);
 
-long kvmppc_alloc_hpt(struct kvm *kvm, u32 *htab_orderp)
+int kvmppc_allocate_hpt(struct kvm_hpt_info *info, u32 order)
 {
-	unsigned long hpt = 0;
-	struct revmap_entry *rev;
+	unsigned long hpt;
+	int cma;
 	struct page *page = NULL;
-	long order = KVM_DEFAULT_HPT_ORDER;
-
-	if (htab_orderp) {
-		order = *htab_orderp;
-		if (order < PPC_MIN_HPT_ORDER)
-			order = PPC_MIN_HPT_ORDER;
-	}
+	struct revmap_entry *rev;
+	unsigned long npte;
 
-	kvm->arch.hpt.cma = 0;
+	hpt = 0;
+	cma = 0;
 	page = kvm_alloc_hpt_cma(1ul << (order - PAGE_SHIFT));
 	if (page) {
 		hpt = (unsigned long)pfn_to_kaddr(page_to_pfn(page));
 		memset((void *)hpt, 0, (1ul << order));
-		kvm->arch.hpt.cma = 1;
+		cma = 1;
 	}
 
-	/* Lastly try successively smaller sizes from the page allocator */
-	/* Only do this if userspace didn't specify a size via ioctl */
-	while (!hpt && order > PPC_MIN_HPT_ORDER && !htab_orderp) {
-		hpt = __get_free_pages(GFP_KERNEL|__GFP_ZERO|__GFP_REPEAT|
-				       __GFP_NOWARN, order - PAGE_SHIFT);
-		if (!hpt)
-			--order;
-	}
+	if (!hpt)
+		hpt = __get_free_pages(GFP_KERNEL|__GFP_ZERO|__GFP_REPEAT
+				       |__GFP_NOWARN, order - PAGE_SHIFT);
 
 	if (!hpt)
 		return -ENOMEM;
 
-	kvm->arch.hpt.virt = hpt;
-	kvm->arch.hpt.order = order;
+	/* HPTEs are 2**4 bytes long */
+	npte = 1ul << (order - 4);
 
 	/* Allocate reverse map array */
-	rev = vmalloc(sizeof(struct revmap_entry) * kvmppc_hpt_npte(&kvm->arch.hpt));
+	rev = vmalloc(sizeof(struct revmap_entry) * npte);
 	if (!rev) {
-		pr_err("kvmppc_alloc_hpt: Couldn't alloc reverse map array\n");
+		pr_err("kvmppc_allocate_hpt: Couldn't alloc reverse map array\n");
 		goto out_freehpt;
 	}
-	kvm->arch.hpt.rev = rev;
-	kvm->arch.sdr1 = __pa(hpt) | (order - 18);
 
-	pr_info("KVM guest htab at %lx (order %ld), LPID %x\n",
-		hpt, order, kvm->arch.lpid);
+	info->order = order;
+	info->virt = hpt;
+	info->cma = cma;
+	info->rev = rev;
 
-	if (htab_orderp)
-		*htab_orderp = order;
 	return 0;
 
  out_freehpt:
-	if (kvm->arch.hpt.cma)
+	if (info->cma)
 		kvm_free_hpt_cma(page, 1 << (order - PAGE_SHIFT));
 	else
-		free_pages(hpt, order - PAGE_SHIFT);
+		free_pages(info->virt, order - PAGE_SHIFT);
 	return -ENOMEM;
 }
 
+void kvmppc_set_hpt(struct kvm *kvm, struct kvm_hpt_info *info)
+{
+	kvm->arch.hpt = *info;
+	kvm->arch.sdr1 = __pa(info->virt) | (info->order - 18);
+
+	pr_info("KVM guest htab at %lx (order %ld), LPID %x\n",
+		info->virt, (long)info->order, kvm->arch.lpid);
+}
+
 long kvmppc_alloc_reset_hpt(struct kvm *kvm, u32 *htab_orderp)
 {
 	long err = -EBUSY;
@@ -136,24 +131,28 @@ long kvmppc_alloc_reset_hpt(struct kvm *kvm, u32 *htab_orderp)
 		*htab_orderp = order;
 		err = 0;
 	} else {
-		err = kvmppc_alloc_hpt(kvm, htab_orderp);
-		order = *htab_orderp;
+		struct kvm_hpt_info info;
+
+		err = kvmppc_allocate_hpt(&info, *htab_orderp);
+		if (err < 0)
+			goto out;
+		kvmppc_set_hpt(kvm, &info);
 	}
  out:
 	mutex_unlock(&kvm->lock);
 	return err;
 }
 
-void kvmppc_free_hpt(struct kvm *kvm)
+void kvmppc_free_hpt(struct kvm_hpt_info *info)
 {
-	kvmppc_free_lpid(kvm->arch.lpid);
-	vfree(kvm->arch.hpt.rev);
-	if (kvm->arch.hpt.cma)
-		kvm_free_hpt_cma(virt_to_page(kvm->arch.hpt.virt),
-				 1 << (kvm->arch.hpt.order - PAGE_SHIFT));
+	vfree(info->rev);
+	if (info->cma)
+		kvm_free_hpt_cma(virt_to_page(info->virt),
+				 1 << (info->order - PAGE_SHIFT));
 	else
-		free_pages(kvm->arch.hpt.virt,
-			   kvm->arch.hpt.order - PAGE_SHIFT);
+		free_pages(info->virt, info->order - PAGE_SHIFT);
+	info->virt = 0;
+	info->order = 0;
 }
 
 /* Bits in first HPTE dword for pagesize 4k, 64k or 16M */
diff --git a/arch/powerpc/kvm/book3s_hv.c b/arch/powerpc/kvm/book3s_hv.c
index 889f8ce..18eb106 100644
--- a/arch/powerpc/kvm/book3s_hv.c
+++ b/arch/powerpc/kvm/book3s_hv.c
@@ -3001,11 +3001,22 @@ static int kvmppc_hv_setup_htab_rma(struct kvm_vcpu *vcpu)
 
 	/* Allocate hashed page table (if not done already) and reset it */
 	if (!kvm->arch.hpt.virt) {
-		err = kvmppc_alloc_hpt(kvm, NULL);
-		if (err) {
+		int order = KVM_DEFAULT_HPT_ORDER;
+		struct kvm_hpt_info info;
+
+		err = kvmppc_allocate_hpt(&info, order);
+		/* If we get here, it means userspace didn't specify a
+		 * size explicitly.  So, try successively smaller
+		 * sizes if the default failed. */
+		while (err < 0 && --order > PPC_MIN_HPT_ORDER)
+			err  = kvmppc_allocate_hpt(&info, order);
+
+		if (err < 0) {
 			pr_err("KVM: Couldn't alloc HPT\n");
 			goto out;
 		}
+
+		kvmppc_set_hpt(kvm, &info);
 	}
 
 	/* Look up the memslot for guest physical address 0 */
@@ -3244,7 +3255,8 @@ static void kvmppc_core_destroy_vm_hv(struct kvm *kvm)
 
 	kvmppc_free_vcores(kvm);
 
-	kvmppc_free_hpt(kvm);
+	kvmppc_free_lpid(kvm->arch.lpid);
+	kvmppc_free_hpt(&kvm->arch.hpt);
 }
 
 /* We don't need to emulate any privileged instructions or dcbz */
-- 
2.5.0

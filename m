Return-Path: <dgibson@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 1E0FF1A06C2
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  3 Mar 2016 12:59:54 +1100 (AEDT)
From: David Gibson <david@gibson.dropbear.id.au>
To: paulus@samba.org,
	aik@ozlabs.ru,
	benh@kernel.crashing.org
Cc: bharata@linux.vnet.ibm.com, linuxppc-dev@lists.ozlabs.org,
 David Gibson <david@gibson.dropbear.id.au>
Subject: [RFC 11/18] powerpc/kvm: Rename kvm_alloc_hpt() for clarity
Date: Thu,  3 Mar 2016 12:59:42 +1100
Message-Id: <1456970389-28802-12-git-send-email-david@gibson.dropbear.id.au>
In-Reply-To: <1456970389-28802-1-git-send-email-david@gibson.dropbear.id.au>
References: <1456970389-28802-1-git-send-email-david@gibson.dropbear.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The difference between kvm_alloc_hpt() and kvmppc_alloc_hpt() is not at
all obvious from the name.  In practice kvmppc_alloc_hpt() allocates an HPT
by whatever means, and clals kvm_alloc_hpt() which will attempt to allocate
it with CMA only.

To make this less confusing, rename kvm_alloc_hpt() to kvm_alloc_hpt_cma().
Similarly, kvm_release_hpt() is renamed kvm_free_hpt_cma().

Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 arch/powerpc/include/asm/kvm_ppc.h   | 4 ++--
 arch/powerpc/kvm/book3s_64_mmu_hv.c  | 8 ++++----
 arch/powerpc/kvm/book3s_hv_builtin.c | 8 ++++----
 3 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/arch/powerpc/include/asm/kvm_ppc.h b/arch/powerpc/include/asm/kvm_ppc.h
index 2241d53..f25947a 100644
--- a/arch/powerpc/include/asm/kvm_ppc.h
+++ b/arch/powerpc/include/asm/kvm_ppc.h
@@ -170,8 +170,8 @@ extern long kvmppc_h_put_tce(struct kvm_vcpu *vcpu, unsigned long liobn,
 			     unsigned long ioba, unsigned long tce);
 extern long kvmppc_h_get_tce(struct kvm_vcpu *vcpu, unsigned long liobn,
 			     unsigned long ioba);
-extern struct page *kvm_alloc_hpt(unsigned long nr_pages);
-extern void kvm_release_hpt(struct page *page, unsigned long nr_pages);
+extern struct page *kvm_alloc_hpt_cma(unsigned long nr_pages);
+extern void kvm_free_hpt_cma(struct page *page, unsigned long nr_pages);
 extern int kvmppc_core_init_vm(struct kvm *kvm);
 extern void kvmppc_core_destroy_vm(struct kvm *kvm);
 extern void kvmppc_core_free_memslot(struct kvm *kvm,
diff --git a/arch/powerpc/kvm/book3s_64_mmu_hv.c b/arch/powerpc/kvm/book3s_64_mmu_hv.c
index fb37290..157285b0 100644
--- a/arch/powerpc/kvm/book3s_64_mmu_hv.c
+++ b/arch/powerpc/kvm/book3s_64_mmu_hv.c
@@ -62,7 +62,7 @@ long kvmppc_alloc_hpt(struct kvm *kvm, u32 *htab_orderp)
 	}
 
 	kvm->arch.hpt_cma_alloc = 0;
-	page = kvm_alloc_hpt(1ul << (order - PAGE_SHIFT));
+	page = kvm_alloc_hpt_cma(1ul << (order - PAGE_SHIFT));
 	if (page) {
 		hpt = (unsigned long)pfn_to_kaddr(page_to_pfn(page));
 		memset((void *)hpt, 0, (1ul << order));
@@ -106,7 +106,7 @@ long kvmppc_alloc_hpt(struct kvm *kvm, u32 *htab_orderp)
 
  out_freehpt:
 	if (kvm->arch.hpt_cma_alloc)
-		kvm_release_hpt(page, 1 << (order - PAGE_SHIFT));
+		kvm_free_hpt_cma(page, 1 << (order - PAGE_SHIFT));
 	else
 		free_pages(hpt, order - PAGE_SHIFT);
 	return -ENOMEM;
@@ -153,8 +153,8 @@ void kvmppc_free_hpt(struct kvm *kvm)
 	kvmppc_free_lpid(kvm->arch.lpid);
 	vfree(kvm->arch.revmap);
 	if (kvm->arch.hpt_cma_alloc)
-		kvm_release_hpt(virt_to_page(kvm->arch.hpt_virt),
-				1 << (kvm->arch.hpt_order - PAGE_SHIFT));
+		kvm_free_hpt_cma(virt_to_page(kvm->arch.hpt_virt),
+				 1 << (kvm->arch.hpt_order - PAGE_SHIFT));
 	else
 		free_pages(kvm->arch.hpt_virt,
 			   kvm->arch.hpt_order - PAGE_SHIFT);
diff --git a/arch/powerpc/kvm/book3s_hv_builtin.c b/arch/powerpc/kvm/book3s_hv_builtin.c
index fd7006b..bcc00b7 100644
--- a/arch/powerpc/kvm/book3s_hv_builtin.c
+++ b/arch/powerpc/kvm/book3s_hv_builtin.c
@@ -49,19 +49,19 @@ static int __init early_parse_kvm_cma_resv(char *p)
 }
 early_param("kvm_cma_resv_ratio", early_parse_kvm_cma_resv);
 
-struct page *kvm_alloc_hpt(unsigned long nr_pages)
+struct page *kvm_alloc_hpt_cma(unsigned long nr_pages)
 {
 	VM_BUG_ON(order_base_2(nr_pages) < KVM_CMA_CHUNK_ORDER - PAGE_SHIFT);
 
 	return cma_alloc(kvm_cma, nr_pages, order_base_2(HPT_ALIGN_PAGES));
 }
-EXPORT_SYMBOL_GPL(kvm_alloc_hpt);
+EXPORT_SYMBOL_GPL(kvm_alloc_hpt_cma);
 
-void kvm_release_hpt(struct page *page, unsigned long nr_pages)
+void kvm_free_hpt_cma(struct page *page, unsigned long nr_pages)
 {
 	cma_release(kvm_cma, page, nr_pages);
 }
-EXPORT_SYMBOL_GPL(kvm_release_hpt);
+EXPORT_SYMBOL_GPL(kvm_free_hpt_cma);
 
 /**
  * kvm_cma_reserve() - reserve area for kvm hash pagetable
-- 
2.5.0

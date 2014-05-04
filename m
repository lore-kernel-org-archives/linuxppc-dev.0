Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e23smtp05.au.ibm.com (e23smtp05.au.ibm.com [202.81.31.147])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id F11B014018B
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  5 May 2014 03:25:32 +1000 (EST)
Received: from /spool/local
 by e23smtp05.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Mon, 5 May 2014 03:25:32 +1000
Received: from d23relay05.au.ibm.com (d23relay05.au.ibm.com [9.190.235.152])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id 5AF482BB0047
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  5 May 2014 03:25:30 +1000 (EST)
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay05.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s44H4EEb8913340
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 5 May 2014 03:04:14 +1000
Received: from d23av03.au.ibm.com (localhost [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s44HPTtZ007462
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 5 May 2014 03:25:30 +1000
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: agraf@suse.de, benh@kernel.crashing.org, paulus@samba.org
Subject: [PATCH] KVM: PPC: BOOK3S: HV: Don't try to allocate from kernel page
 allocator for hash page table.
Date: Sun,  4 May 2014 22:55:22 +0530
Message-Id: <1399224322-22028-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org, kvm-ppc@vger.kernel.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

We reserve 5% of total ram for CMA allocation and not using that can
result in us running out of numa node memory with specific
configuration. One caveat is we may not have node local hpt with pinned
vcpu configuration. But currently libvirt also pins the vcpu to cpuset
after creating hash page table.

Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
---
 arch/powerpc/kvm/book3s_64_mmu_hv.c | 23 ++++++-----------------
 1 file changed, 6 insertions(+), 17 deletions(-)

diff --git a/arch/powerpc/kvm/book3s_64_mmu_hv.c b/arch/powerpc/kvm/book3s_64_mmu_hv.c
index fb25ebc0af0c..f32896ffd784 100644
--- a/arch/powerpc/kvm/book3s_64_mmu_hv.c
+++ b/arch/powerpc/kvm/book3s_64_mmu_hv.c
@@ -52,7 +52,7 @@ static void kvmppc_rmap_reset(struct kvm *kvm);
 
 long kvmppc_alloc_hpt(struct kvm *kvm, u32 *htab_orderp)
 {
-	unsigned long hpt;
+	unsigned long hpt = 0;
 	struct revmap_entry *rev;
 	struct page *page = NULL;
 	long order = KVM_DEFAULT_HPT_ORDER;
@@ -64,22 +64,11 @@ long kvmppc_alloc_hpt(struct kvm *kvm, u32 *htab_orderp)
 	}
 
 	kvm->arch.hpt_cma_alloc = 0;
-	/*
-	 * try first to allocate it from the kernel page allocator.
-	 * We keep the CMA reserved for failed allocation.
-	 */
-	hpt = __get_free_pages(GFP_KERNEL | __GFP_ZERO | __GFP_REPEAT |
-			       __GFP_NOWARN, order - PAGE_SHIFT);
-
-	/* Next try to allocate from the preallocated pool */
-	if (!hpt) {
-		VM_BUG_ON(order < KVM_CMA_CHUNK_ORDER);
-		page = kvm_alloc_hpt(1 << (order - PAGE_SHIFT));
-		if (page) {
-			hpt = (unsigned long)pfn_to_kaddr(page_to_pfn(page));
-			kvm->arch.hpt_cma_alloc = 1;
-		} else
-			--order;
+	VM_BUG_ON(order < KVM_CMA_CHUNK_ORDER);
+	page = kvm_alloc_hpt(1 << (order - PAGE_SHIFT));
+	if (page) {
+		hpt = (unsigned long)pfn_to_kaddr(page_to_pfn(page));
+		kvm->arch.hpt_cma_alloc = 1;
 	}
 
 	/* Lastly try successively smaller sizes from the page allocator */
-- 
1.9.1

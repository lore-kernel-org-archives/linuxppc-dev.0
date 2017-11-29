Return-Path: <spopovyc@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yn5ng4X5LzDqkJ
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 30 Nov 2017 03:38:31 +1100 (AEDT)
From: Serhii Popovych <spopovyc@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: michael@ellerman.id.au, paulus@samba.org, linuxppc-dev@lists.ozlabs.org,
 kvm-ppc@vger.kernel.org, david@gibson.dropbear.id.au
Subject: [PATCH 2/4] KVM: PPC: Book3S HV: Improve
 kvmppc_allocate_hpt()/kvmppc_free_hpt()
Date: Wed, 29 Nov 2017 11:38:24 -0500
Message-Id: <1511973506-65683-3-git-send-email-spopovyc@redhat.com>
In-Reply-To: <1511973506-65683-1-git-send-email-spopovyc@redhat.com>
References: <1511973506-65683-1-git-send-email-spopovyc@redhat.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

There are several points of improvements:

  1) Make kvmppc_free_hpt() check if allocation is made before attempt
     to release. This follows kfree(p) semantics where p == NULL.

  2) Return initialized @info parameter from kvmppc_allocate_hpt()
     even if allocation fails.

     This allows to use kvmppc_free_hpt() in the caller without
     checking that preceded kvmppc_allocate_hpt() was successful

         p = kmalloc(size, gfp);
         kfree(p);

     which is correct for both p != NULL and p == NULL. Followup
     change will rely on this behaviour.

  3) Better code reuse: kvmppc_free_hpt() can be reused on error
     path in kvmppc_allocate_hpt() to avoid code duplication.

  4) No need to check for !hpt if allocated from CMA: neither
     pfn_to_kaddr() nor page_to_pfn() is 0 in case of page != NULL.

Signed-off-by: Serhii Popovych <spopovyc@redhat.com>
---
 arch/powerpc/kvm/book3s_64_mmu_hv.c | 54 ++++++++++++++++++-------------------
 1 file changed, 26 insertions(+), 28 deletions(-)

diff --git a/arch/powerpc/kvm/book3s_64_mmu_hv.c b/arch/powerpc/kvm/book3s_64_mmu_hv.c
index 0534aab..3e9abd9 100644
--- a/arch/powerpc/kvm/book3s_64_mmu_hv.c
+++ b/arch/powerpc/kvm/book3s_64_mmu_hv.c
@@ -82,47 +82,44 @@ struct kvm_resize_hpt {
 int kvmppc_allocate_hpt(struct kvm_hpt_info *info, u32 order)
 {
 	unsigned long hpt = 0;
-	int cma = 0;
-	struct page *page = NULL;
-	struct revmap_entry *rev;
+	int err, cma = 0;
+	struct page *page;
+	struct revmap_entry *rev = NULL;
 	unsigned long npte;
 
+	err = -EINVAL;
 	if ((order < PPC_MIN_HPT_ORDER) || (order > PPC_MAX_HPT_ORDER))
-		return -EINVAL;
+		goto out;
 
+	err = -ENOMEM;
 	page = kvm_alloc_hpt_cma(1ul << (order - PAGE_SHIFT));
 	if (page) {
 		hpt = (unsigned long)pfn_to_kaddr(page_to_pfn(page));
 		memset((void *)hpt, 0, (1ul << order));
 		cma = 1;
-	}
-
-	if (!hpt)
+	} else {
 		hpt = __get_free_pages(GFP_KERNEL|__GFP_ZERO|__GFP_RETRY_MAYFAIL
 				       |__GFP_NOWARN, order - PAGE_SHIFT);
-
-	if (!hpt)
-		return -ENOMEM;
+		if (!hpt)
+			goto out;
+	}
 
 	/* HPTEs are 2**4 bytes long */
 	npte = 1ul << (order - 4);
 
 	/* Allocate reverse map array */
-	rev = vmalloc(sizeof(struct revmap_entry) * npte);
-	if (!rev) {
-		if (cma)
-			kvm_free_hpt_cma(page, 1 << (order - PAGE_SHIFT));
-		else
-			free_pages(hpt, order - PAGE_SHIFT);
-		return -ENOMEM;
-	}
-
+	rev = vmalloc(sizeof(*rev) * npte);
+	if (rev)
+		err = 0;
+out:
 	info->order = order;
 	info->virt = hpt;
 	info->cma = cma;
 	info->rev = rev;
 
-	return 0;
+	if (err)
+		kvmppc_free_hpt(info);
+	return err;
 }
 
 void kvmppc_set_hpt(struct kvm *kvm, struct kvm_hpt_info *info)
@@ -190,12 +187,14 @@ void kvmppc_free_hpt(struct kvm_hpt_info *info)
 {
 	vfree(info->rev);
 	info->rev = NULL;
-	if (info->cma)
-		kvm_free_hpt_cma(virt_to_page(info->virt),
-				 1 << (info->order - PAGE_SHIFT));
-	else if (info->virt)
-		free_pages(info->virt, info->order - PAGE_SHIFT);
-	info->virt = 0;
+	if (info->virt) {
+		if (info->cma)
+			kvm_free_hpt_cma(virt_to_page(info->virt),
+					 1 << (info->order - PAGE_SHIFT));
+		else
+			free_pages(info->virt, info->order - PAGE_SHIFT);
+		info->virt = 0;
+	}
 	info->order = 0;
 }
 
@@ -1423,8 +1422,7 @@ static void resize_hpt_release(struct kvm *kvm, struct kvm_resize_hpt *resize)
 	if (!resize)
 		return;
 
-	if (resize->hpt.virt)
-		kvmppc_free_hpt(&resize->hpt);
+	kvmppc_free_hpt(&resize->hpt);
 
 	kvm->arch.resize_hpt = NULL;
 	kfree(resize);
-- 
1.8.3.1

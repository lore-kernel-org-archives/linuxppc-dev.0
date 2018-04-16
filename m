Return-Path: <aneesh.kumar@linux.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40PmMZ1VMxzF1sg
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 16 Apr 2018 21:27:54 +1000 (AEST)
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w3GBNH5A113347
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 16 Apr 2018 07:27:51 -0400
Received: from e18.ny.us.ibm.com (e18.ny.us.ibm.com [129.33.205.208])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2hcqs5h080-1
 (version=TLSv1.2 cipher=AES256-SHA256 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 16 Apr 2018 07:27:51 -0400
Received: from localhost
 by e18.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.ibm.com>;
 Mon, 16 Apr 2018 07:27:49 -0400
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
To: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au
Cc: linuxppc-dev@lists.ozlabs.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: [PATCH V1 02/11] powerpc/kvm: Switch kvm pmd allocator to custom
 allocator
Date: Mon, 16 Apr 2018 16:57:15 +0530
In-Reply-To: <20180416112724.9677-1-aneesh.kumar@linux.ibm.com>
References: <20180416112724.9677-1-aneesh.kumar@linux.ibm.com>
Message-Id: <20180416112724.9677-4-aneesh.kumar@linux.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>

In the next set of patches, we will switch pmd allocator to use page fragments
and the locking will be updated to split pmd ptlock. We want to avoid using
fragments for partition-scoped table. Use slab cache similar to level 4 table

Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
---
 arch/powerpc/kvm/book3s_64_mmu_radix.c | 36 +++++++++++++++++++++++++++++-----
 1 file changed, 31 insertions(+), 5 deletions(-)

diff --git a/arch/powerpc/kvm/book3s_64_mmu_radix.c b/arch/powerpc/kvm/book3s_64_mmu_radix.c
index a57eafec4dc2..ccdf3761eec0 100644
--- a/arch/powerpc/kvm/book3s_64_mmu_radix.c
+++ b/arch/powerpc/kvm/book3s_64_mmu_radix.c
@@ -200,6 +200,7 @@ void kvmppc_radix_set_pte_at(struct kvm *kvm, unsigned long addr,
 }
 
 static struct kmem_cache *kvm_pte_cache;
+static struct kmem_cache *kvm_pmd_cache;
 
 static pte_t *kvmppc_pte_alloc(void)
 {
@@ -217,6 +218,16 @@ static inline int pmd_is_leaf(pmd_t pmd)
 	return !!(pmd_val(pmd) & _PAGE_PTE);
 }
 
+static pmd_t *kvmppc_pmd_alloc(void)
+{
+	return kmem_cache_alloc(kvm_pmd_cache, GFP_KERNEL);
+}
+
+static void kvmppc_pmd_free(pmd_t *pmdp)
+{
+	kmem_cache_free(kvm_pmd_cache, pmdp);
+}
+
 static int kvmppc_create_pte(struct kvm *kvm, pte_t pte, unsigned long gpa,
 			     unsigned int level, unsigned long mmu_seq)
 {
@@ -239,7 +250,7 @@ static int kvmppc_create_pte(struct kvm *kvm, pte_t pte, unsigned long gpa,
 	if (pud && pud_present(*pud) && !pud_huge(*pud))
 		pmd = pmd_offset(pud, gpa);
 	else if (level <= 1)
-		new_pmd = pmd_alloc_one(kvm->mm, gpa);
+		new_pmd = kvmppc_pmd_alloc();
 
 	if (level == 0 && !(pmd && pmd_present(*pmd) && !pmd_is_leaf(*pmd)))
 		new_ptep = kvmppc_pte_alloc();
@@ -382,7 +393,7 @@ static int kvmppc_create_pte(struct kvm *kvm, pte_t pte, unsigned long gpa,
 	if (new_pud)
 		pud_free(kvm->mm, new_pud);
 	if (new_pmd)
-		pmd_free(kvm->mm, new_pmd);
+		kvmppc_pmd_free(new_pmd);
 	if (new_ptep)
 		kvmppc_pte_free(new_ptep);
 	return ret;
@@ -758,7 +769,7 @@ void kvmppc_free_radix(struct kvm *kvm)
 				kvmppc_pte_free(pte);
 				pmd_clear(pmd);
 			}
-			pmd_free(kvm->mm, pmd_offset(pud, 0));
+			kvmppc_pmd_free(pmd_offset(pud, 0));
 			pud_clear(pud);
 		}
 		pud_free(kvm->mm, pud_offset(pgd, 0));
@@ -770,20 +781,35 @@ void kvmppc_free_radix(struct kvm *kvm)
 
 static void pte_ctor(void *addr)
 {
-	memset(addr, 0, PTE_TABLE_SIZE);
+	memset(addr, 0, RADIX_PTE_TABLE_SIZE);
+}
+
+static void pmd_ctor(void *addr)
+{
+	memset(addr, 0, RADIX_PMD_TABLE_SIZE);
 }
 
 int kvmppc_radix_init(void)
 {
-	unsigned long size = sizeof(void *) << PTE_INDEX_SIZE;
+	unsigned long size = sizeof(void *) << RADIX_PTE_INDEX_SIZE;
 
 	kvm_pte_cache = kmem_cache_create("kvm-pte", size, size, 0, pte_ctor);
 	if (!kvm_pte_cache)
 		return -ENOMEM;
+
+	size = sizeof(void *) << RADIX_PMD_INDEX_SIZE;
+
+	kvm_pmd_cache = kmem_cache_create("kvm-pmd", size, size, 0, pmd_ctor);
+	if (!kvm_pmd_cache) {
+		kmem_cache_destroy(kvm_pte_cache);
+		return -ENOMEM;
+	}
+
 	return 0;
 }
 
 void kvmppc_radix_exit(void)
 {
 	kmem_cache_destroy(kvm_pte_cache);
+	kmem_cache_destroy(kvm_pmd_cache);
 }
-- 
2.14.3

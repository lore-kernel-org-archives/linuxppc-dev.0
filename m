Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yNVkS0kSpzDrcq
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 27 Oct 2017 15:09:19 +1100 (AEDT)
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 v9R492QI141858
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 27 Oct 2017 00:09:17 -0400
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2dustahpfb-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 27 Oct 2017 00:09:17 -0400
Received: from localhost
 by e35.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Thu, 26 Oct 2017 22:09:16 -0600
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au
Cc: linuxppc-dev@lists.ozlabs.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: [PATCH 05/16] powerpc/mm: use hash_invalidate for __kernel_map_pages()
Date: Fri, 27 Oct 2017 09:38:22 +0530
In-Reply-To: <20171027040833.3644-1-aneesh.kumar@linux.vnet.ibm.com>
References: <20171027040833.3644-1-aneesh.kumar@linux.vnet.ibm.com>
Message-Id: <20171027040833.3644-6-aneesh.kumar@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
---
 arch/powerpc/mm/hash_utils_64.c | 32 +++++---------------------------
 1 file changed, 5 insertions(+), 27 deletions(-)

diff --git a/arch/powerpc/mm/hash_utils_64.c b/arch/powerpc/mm/hash_utils_64.c
index b197fe57547e..8635b241e2d5 100644
--- a/arch/powerpc/mm/hash_utils_64.c
+++ b/arch/powerpc/mm/hash_utils_64.c
@@ -119,11 +119,6 @@ EXPORT_SYMBOL_GPL(mmu_slb_size);
 #ifdef CONFIG_PPC_64K_PAGES
 int mmu_ci_restrictions;
 #endif
-#ifdef CONFIG_DEBUG_PAGEALLOC
-static u8 *linear_map_hash_slots;
-static unsigned long linear_map_hash_count;
-static DEFINE_SPINLOCK(linear_map_hash_lock);
-#endif /* CONFIG_DEBUG_PAGEALLOC */
 struct mmu_hash_ops mmu_hash_ops;
 EXPORT_SYMBOL(mmu_hash_ops);
 
@@ -1744,7 +1739,7 @@ long hpte_insert_repeating(unsigned long hash, unsigned long vpn,
 }
 
 #ifdef CONFIG_DEBUG_PAGEALLOC
-static void kernel_map_linear_page(unsigned long vaddr, unsigned long lmi)
+static void kernel_map_linear_page(unsigned long vaddr)
 {
 	unsigned long hash;
 	unsigned long vsid = get_kernel_vsid(vaddr, mmu_kernel_ssize);
@@ -1761,12 +1756,7 @@ static void kernel_map_linear_page(unsigned long vaddr, unsigned long lmi)
 	ret = hpte_insert_repeating(hash, vpn, __pa(vaddr), mode,
 				    HPTE_V_BOLTED,
 				    mmu_linear_psize, mmu_kernel_ssize);
-
 	BUG_ON (ret < 0);
-	spin_lock(&linear_map_hash_lock);
-	BUG_ON(linear_map_hash_slots[lmi] & 0x80);
-	linear_map_hash_slots[lmi] = ret | 0x80;
-	spin_unlock(&linear_map_hash_lock);
 }
 
 static void kernel_unmap_linear_page(unsigned long vaddr, unsigned long lmi)
@@ -1776,35 +1766,23 @@ static void kernel_unmap_linear_page(unsigned long vaddr, unsigned long lmi)
 	unsigned long vpn = hpt_vpn(vaddr, vsid, mmu_kernel_ssize);
 
 	hash = hpt_hash(vpn, PAGE_SHIFT, mmu_kernel_ssize);
-	spin_lock(&linear_map_hash_lock);
-	BUG_ON(!(linear_map_hash_slots[lmi] & 0x80));
-	hidx = linear_map_hash_slots[lmi] & 0x7f;
-	linear_map_hash_slots[lmi] = 0;
-	spin_unlock(&linear_map_hash_lock);
-	if (hidx & _PTEIDX_SECONDARY)
-		hash = ~hash;
-	slot = (hash & htab_hash_mask) * HPTES_PER_GROUP;
-	slot += hidx & _PTEIDX_GROUP_IX;
-	mmu_hash_ops.hpte_invalidate(slot, vpn, mmu_linear_psize,
+	mmu_hash_ops.hash_invalidate(hash, vpn, mmu_linear_psize,
 				     mmu_linear_psize,
 				     mmu_kernel_ssize, 0);
 }
 
 void __kernel_map_pages(struct page *page, int numpages, int enable)
 {
-	unsigned long flags, vaddr, lmi;
+	unsigned long flags, vaddr;
 	int i;
 
 	local_irq_save(flags);
 	for (i = 0; i < numpages; i++, page++) {
 		vaddr = (unsigned long)page_address(page);
-		lmi = __pa(vaddr) >> PAGE_SHIFT;
-		if (lmi >= linear_map_hash_count)
-			continue;
 		if (enable)
-			kernel_map_linear_page(vaddr, lmi);
+			kernel_map_linear_page(vaddr);
 		else
-			kernel_unmap_linear_page(vaddr, lmi);
+			kernel_unmap_linear_page(vaddr);
 	}
 	local_irq_restore(flags);
 }
-- 
2.13.6

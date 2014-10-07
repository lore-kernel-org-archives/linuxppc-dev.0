Return-Path: <mikey@neuling.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id F1B681A1773
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  7 Oct 2014 21:49:36 +1100 (EST)
From: Michael Neuling <mikey@neuling.org>
To: greg@kroah.com, arnd@arndb.de, mpe@ellerman.id.au, benh@kernel.crashing.org
Subject: [PATCH v3 09/16] powerpc/mm: Add new hash_page_mm()
Date: Tue,  7 Oct 2014 21:48:15 +1100
Message-Id: <1412678902-18672-10-git-send-email-mikey@neuling.org>
In-Reply-To: <1412678902-18672-1-git-send-email-mikey@neuling.org>
References: <1412678902-18672-1-git-send-email-mikey@neuling.org>
Cc: cbe-oss-dev@lists.ozlabs.org, mikey@neuling.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>, imunsie@au.ibm.com,
 linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org, jk@ozlabs.org,
 anton@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Ian Munsie <imunsie@au1.ibm.com>

This adds a new function hash_page_mm() based on the existing hash_page().
This version allows any struct mm to be passed in, rather than assuming
current. This is useful for servicing co-processor faults which are not in the
context of the current running process.

We need to be careful here as the current hash_page() assumes current in a few
places.

Signed-off-by: Ian Munsie <imunsie@au1.ibm.com>
Signed-off-by: Michael Neuling <mikey@neuling.org>
---
 arch/powerpc/include/asm/mmu-hash64.h |  1 +
 arch/powerpc/mm/hash_utils_64.c       | 24 +++++++++++++++++-------
 2 files changed, 18 insertions(+), 7 deletions(-)

diff --git a/arch/powerpc/include/asm/mmu-hash64.h b/arch/powerpc/include/asm/mmu-hash64.h
index 6d0b7a2..f84e5a5 100644
--- a/arch/powerpc/include/asm/mmu-hash64.h
+++ b/arch/powerpc/include/asm/mmu-hash64.h
@@ -322,6 +322,7 @@ extern int __hash_page_64K(unsigned long ea, unsigned long access,
 			   unsigned int local, int ssize);
 struct mm_struct;
 unsigned int hash_page_do_lazy_icache(unsigned int pp, pte_t pte, int trap);
+extern int hash_page_mm(struct mm_struct *mm, unsigned long ea, unsigned long access, unsigned long trap);
 extern int hash_page(unsigned long ea, unsigned long access, unsigned long trap);
 int __hash_page_huge(unsigned long ea, unsigned long access, unsigned long vsid,
 		     pte_t *ptep, unsigned long trap, int local, int ssize,
diff --git a/arch/powerpc/mm/hash_utils_64.c b/arch/powerpc/mm/hash_utils_64.c
index bbdb054..698834d 100644
--- a/arch/powerpc/mm/hash_utils_64.c
+++ b/arch/powerpc/mm/hash_utils_64.c
@@ -904,7 +904,7 @@ void demote_segment_4k(struct mm_struct *mm, unsigned long addr)
 		return;
 	slice_set_range_psize(mm, addr, 1, MMU_PAGE_4K);
 	copro_flush_all_slbs(mm);
-	if (get_paca_psize(addr) != MMU_PAGE_4K) {
+	if ((get_paca_psize(addr) != MMU_PAGE_4K) && (current->mm == mm)) {
 		get_paca()->context = mm->context;
 		slb_flush_and_rebolt();
 	}
@@ -989,12 +989,11 @@ static void check_paca_psize(unsigned long ea, struct mm_struct *mm,
  * -1 - critical hash insertion error
  * -2 - access not permitted by subpage protection mechanism
  */
-int hash_page(unsigned long ea, unsigned long access, unsigned long trap)
+int hash_page_mm(struct mm_struct *mm, unsigned long ea, unsigned long access, unsigned long trap)
 {
 	enum ctx_state prev_state = exception_enter();
 	pgd_t *pgdir;
 	unsigned long vsid;
-	struct mm_struct *mm;
 	pte_t *ptep;
 	unsigned hugeshift;
 	const struct cpumask *tmp;
@@ -1008,7 +1007,6 @@ int hash_page(unsigned long ea, unsigned long access, unsigned long trap)
  	switch (REGION_ID(ea)) {
 	case USER_REGION_ID:
 		user_region = 1;
-		mm = current->mm;
 		if (! mm) {
 			DBG_LOW(" user region with no mm !\n");
 			rc = 1;
@@ -1019,7 +1017,6 @@ int hash_page(unsigned long ea, unsigned long access, unsigned long trap)
 		vsid = get_vsid(mm->context.id, ea, ssize);
 		break;
 	case VMALLOC_REGION_ID:
-		mm = &init_mm;
 		vsid = get_kernel_vsid(ea, mmu_kernel_ssize);
 		if (ea < VMALLOC_END)
 			psize = mmu_vmalloc_psize;
@@ -1104,7 +1101,8 @@ int hash_page(unsigned long ea, unsigned long access, unsigned long trap)
 			WARN_ON(1);
 		}
 #endif
-		check_paca_psize(ea, mm, psize, user_region);
+		if (current->mm == mm)
+			check_paca_psize(ea, mm, psize, user_region);
 
 		goto bail;
 	}
@@ -1145,7 +1143,8 @@ int hash_page(unsigned long ea, unsigned long access, unsigned long trap)
 		}
 	}
 
-	check_paca_psize(ea, mm, psize, user_region);
+	if (current->mm == mm)
+		check_paca_psize(ea, mm, psize, user_region);
 #endif /* CONFIG_PPC_64K_PAGES */
 
 #ifdef CONFIG_PPC_HAS_HASH_64K
@@ -1180,6 +1179,17 @@ bail:
 	exception_exit(prev_state);
 	return rc;
 }
+EXPORT_SYMBOL_GPL(hash_page_mm);
+
+int hash_page(unsigned long ea, unsigned long access, unsigned long trap)
+{
+	struct mm_struct *mm = current->mm;
+
+	if (REGION_ID(ea) == VMALLOC_REGION_ID)
+		mm = &init_mm;
+
+	return hash_page_mm(mm, ea, access, trap);
+}
 EXPORT_SYMBOL_GPL(hash_page);
 
 void hash_preload(struct mm_struct *mm, unsigned long ea,
-- 
1.9.1

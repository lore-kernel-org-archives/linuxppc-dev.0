Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rPrmk4rMmzDwpc
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  9 Jun 2016 00:44:22 +1000 (AEST)
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u58Eddu6134399
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 8 Jun 2016 10:44:20 -0400
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
 by mx0a-001b2d01.pphosted.com with ESMTP id 23e9m42whn-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 08 Jun 2016 10:44:20 -0400
Received: from localhost
 by e34.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Wed, 8 Jun 2016 08:44:18 -0600
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au
Cc: linuxppc-dev@lists.ozlabs.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: [PATCH V2 13/16] powerpc/mm: remove flush_tlb_page_nohash
Date: Wed,  8 Jun 2016 20:13:20 +0530
In-Reply-To: <1465397003-26812-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
References: <1465397003-26812-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
Message-Id: <1465397003-26812-14-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This should be same as flush_tlb_page except for hash32. For hash32
I guess the existing code is wrong, because we don't seem to be
flushing tlb for Hash != 0 case at all. Fix this by switching to
calling flush_tlb_page() which does the right thing by flushing
tlb for both hash and nohash case with hash32

Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/book3s/64/tlbflush-hash.h |  5 -----
 arch/powerpc/include/asm/book3s/64/tlbflush.h      |  8 --------
 arch/powerpc/include/asm/tlbflush.h                |  1 -
 arch/powerpc/mm/pgtable.c                          |  2 +-
 arch/powerpc/mm/tlb_hash32.c                       | 11 -----------
 5 files changed, 1 insertion(+), 26 deletions(-)

diff --git a/arch/powerpc/include/asm/book3s/64/tlbflush-hash.h b/arch/powerpc/include/asm/book3s/64/tlbflush-hash.h
index f12ddf5e8de5..2f6373144e2c 100644
--- a/arch/powerpc/include/asm/book3s/64/tlbflush-hash.h
+++ b/arch/powerpc/include/asm/book3s/64/tlbflush-hash.h
@@ -75,11 +75,6 @@ static inline void hash__flush_tlb_page(struct vm_area_struct *vma,
 {
 }
 
-static inline void hash__flush_tlb_page_nohash(struct vm_area_struct *vma,
-					   unsigned long vmaddr)
-{
-}
-
 static inline void hash__flush_tlb_range(struct vm_area_struct *vma,
 				     unsigned long start, unsigned long end)
 {
diff --git a/arch/powerpc/include/asm/book3s/64/tlbflush.h b/arch/powerpc/include/asm/book3s/64/tlbflush.h
index 02cd7def893d..7f942c361ea9 100644
--- a/arch/powerpc/include/asm/book3s/64/tlbflush.h
+++ b/arch/powerpc/include/asm/book3s/64/tlbflush.h
@@ -57,14 +57,6 @@ static inline void local_flush_tlb_page(struct vm_area_struct *vma,
 	return hash__local_flush_tlb_page(vma, vmaddr);
 }
 
-static inline void flush_tlb_page_nohash(struct vm_area_struct *vma,
-					 unsigned long vmaddr)
-{
-	if (radix_enabled())
-		return radix__flush_tlb_page(vma, vmaddr);
-	return hash__flush_tlb_page_nohash(vma, vmaddr);
-}
-
 static inline void tlb_flush(struct mmu_gather *tlb)
 {
 	if (radix_enabled())
diff --git a/arch/powerpc/include/asm/tlbflush.h b/arch/powerpc/include/asm/tlbflush.h
index 1b38eea28e5a..13dbcd41885e 100644
--- a/arch/powerpc/include/asm/tlbflush.h
+++ b/arch/powerpc/include/asm/tlbflush.h
@@ -54,7 +54,6 @@ extern void __flush_tlb_page(struct mm_struct *mm, unsigned long vmaddr,
 #define flush_tlb_page(vma,addr)	local_flush_tlb_page(vma,addr)
 #define __flush_tlb_page(mm,addr,p,i)	__local_flush_tlb_page(mm,addr,p,i)
 #endif
-#define flush_tlb_page_nohash(vma,addr)	flush_tlb_page(vma,addr)
 
 #elif defined(CONFIG_PPC_STD_MMU_32)
 
diff --git a/arch/powerpc/mm/pgtable.c b/arch/powerpc/mm/pgtable.c
index 88a307504b5a..0b6fb244d0a1 100644
--- a/arch/powerpc/mm/pgtable.c
+++ b/arch/powerpc/mm/pgtable.c
@@ -225,7 +225,7 @@ int ptep_set_access_flags(struct vm_area_struct *vma, unsigned long address,
 		if (!is_vm_hugetlb_page(vma))
 			assert_pte_locked(vma->vm_mm, address);
 		__ptep_set_access_flags(ptep, entry);
-		flush_tlb_page_nohash(vma, address);
+		flush_tlb_page(vma, address);
 	}
 	return changed;
 }
diff --git a/arch/powerpc/mm/tlb_hash32.c b/arch/powerpc/mm/tlb_hash32.c
index 558e30cce33e..702d7689d714 100644
--- a/arch/powerpc/mm/tlb_hash32.c
+++ b/arch/powerpc/mm/tlb_hash32.c
@@ -49,17 +49,6 @@ void flush_hash_entry(struct mm_struct *mm, pte_t *ptep, unsigned long addr)
 EXPORT_SYMBOL(flush_hash_entry);
 
 /*
- * Called by ptep_set_access_flags, must flush on CPUs for which the
- * DSI handler can't just "fixup" the TLB on a write fault
- */
-void flush_tlb_page_nohash(struct vm_area_struct *vma, unsigned long addr)
-{
-	if (Hash != 0)
-		return;
-	_tlbie(addr);
-}
-
-/*
  * Called at the end of a mmu_gather operation to make sure the
  * TLB flush is completely done.
  */
-- 
2.7.4

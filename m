Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e28smtp01.in.ibm.com (e28smtp01.in.ibm.com [125.16.236.1])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3r9NkH0kSdzDqVp
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 May 2016 17:59:02 +1000 (AEST)
Received: from localhost
 by e28smtp01.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Thu, 19 May 2016 13:29:01 +0530
Received: from d28relay06.in.ibm.com (d28relay06.in.ibm.com [9.184.220.150])
 by d28dlp02.in.ibm.com (Postfix) with ESMTP id 6EF053940068
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 May 2016 13:28:57 +0530 (IST)
Received: from d28av04.in.ibm.com (d28av04.in.ibm.com [9.184.220.66])
 by d28relay06.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u4J7wvso45940802
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 May 2016 13:28:57 +0530
Received: from d28av04.in.ibm.com (localhost [127.0.0.1])
 by d28av04.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u4J7wsHr006650
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 May 2016 13:28:56 +0530
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au
Cc: linuxppc-dev@lists.ozlabs.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: [PATCH 7/7] powerpc/mm: remove flush_tlb_page_nohash
Date: Thu, 19 May 2016 13:28:50 +0530
Message-Id: <1463644730-10946-8-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
In-Reply-To: <1463644730-10946-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
References: <1463644730-10946-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
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
index 3b3e5e944af7..ea29cc3318d2 100644
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

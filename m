Return-Path: <apw@shadowen.org>
Received: from hellhawk.shadowen.org (hellhawk.shadowen.org [80.68.90.175])
	by ozlabs.org (Postfix) with ESMTP id 3EE01DE1C6
	for <linuxppc-dev@ozlabs.org>; Thu, 26 Jun 2008 20:23:44 +1000 (EST)
From: Andy Whitcroft <apw@shadowen.org>
To: paulus@samba.org
Subject: [PATCH 1/1] powerpc: add 64 bit version of huge_ptep_set_wrprotect
Date: Thu, 26 Jun 2008 10:55:58 +0100
Message-Id: <1214474158-17870-1-git-send-email-apw@shadowen.org>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

The implementation of huge_ptep_set_wrprotect() directly calls
ptep_set_wrprotect() to mark a hugepte write protected.  However this
call is not appropriate on ppc64 kernels as this is a small page only
implementation.  This can lead to the hash not being flushed correctly
when a mapping is being converted to COW, allowing processes to continue
using the original copy.

Currently huge_ptep_set_wrprotect() unconditionally calls
ptep_set_wrprotect().  This is fine on ppc32 kernels as this call is
generic.  On 64 bit this is implemented as:

	pte_update(mm, addr, ptep, _PAGE_RW, 0);

On ppc64 this last parameter is the page size and is passed directly on
to hpte_need_flush():

	hpte_need_flush(mm, addr, ptep, old, huge);

And this directly affects the page size we pass to flush_hash_page():

	flush_hash_page(vaddr, rpte, psize, ssize, 0);

As this changes the way the hash is calculated we will flush the wrong
pages, potentially leaving live hashes to the original page.

Move the definition of huge_ptep_set_wrprotect() to the 32/64 bit specific
headers.

Signed-off-by: Andy Whitcroft <apw@shadowen.org>
---
 include/asm-powerpc/hugetlb.h       |    6 ------
 include/asm-powerpc/pgtable-ppc32.h |    6 ++++++
 include/asm-powerpc/pgtable-ppc64.h |    9 +++++++++
 3 files changed, 15 insertions(+), 6 deletions(-)

diff --git a/include/asm-powerpc/hugetlb.h b/include/asm-powerpc/hugetlb.h
index 649c6c3..be32ff0 100644
--- a/include/asm-powerpc/hugetlb.h
+++ b/include/asm-powerpc/hugetlb.h
@@ -49,12 +49,6 @@ static inline pte_t huge_pte_wrprotect(pte_t pte)
 	return pte_wrprotect(pte);
 }
 
-static inline void huge_ptep_set_wrprotect(struct mm_struct *mm,
-					   unsigned long addr, pte_t *ptep)
-{
-	ptep_set_wrprotect(mm, addr, ptep);
-}
-
 static inline int huge_ptep_set_access_flags(struct vm_area_struct *vma,
 					     unsigned long addr, pte_t *ptep,
 					     pte_t pte, int dirty)
diff --git a/include/asm-powerpc/pgtable-ppc32.h b/include/asm-powerpc/pgtable-ppc32.h
index c08e714..eddad35 100644
--- a/include/asm-powerpc/pgtable-ppc32.h
+++ b/include/asm-powerpc/pgtable-ppc32.h
@@ -652,6 +652,12 @@ static inline void ptep_set_wrprotect(struct mm_struct *mm, unsigned long addr,
 {
 	pte_update(ptep, (_PAGE_RW | _PAGE_HWWRITE), 0);
 }
+static inline void huge_ptep_set_wrprotect(struct mm_struct *mm,
+					   unsigned long addr, pte_t *ptep)
+{
+	ptep_set_wrprotect(mm, addr, ptep);
+}
+
 
 #define __HAVE_ARCH_PTEP_SET_ACCESS_FLAGS
 static inline void __ptep_set_access_flags(pte_t *ptep, pte_t entry, int dirty)
diff --git a/include/asm-powerpc/pgtable-ppc64.h b/include/asm-powerpc/pgtable-ppc64.h
index cc6a43b..9f7dbc2 100644
--- a/include/asm-powerpc/pgtable-ppc64.h
+++ b/include/asm-powerpc/pgtable-ppc64.h
@@ -313,6 +313,15 @@ static inline void ptep_set_wrprotect(struct mm_struct *mm, unsigned long addr,
        		return;
 	old = pte_update(mm, addr, ptep, _PAGE_RW, 0);
 }
+static inline void huge_ptep_set_wrprotect(struct mm_struct *mm,
+					   unsigned long addr, pte_t *ptep)
+{
+	unsigned long old;
+
+       	if ((pte_val(*ptep) & _PAGE_RW) == 0)
+       		return;
+	old = pte_update(mm, addr, ptep, _PAGE_RW, 1);
+}
 
 /*
  * We currently remove entries from the hashtable regardless of whether
-- 
1.5.6.205.g7ca3a

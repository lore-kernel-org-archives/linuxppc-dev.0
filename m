Return-Path: <dgibson@ozlabs.org>
Date: Tue, 8 Jul 2008 15:24:42 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Paul Mackerras <paulus@samba.org>
Subject: Correct hash flushing from huge_ptep_set_wrprotect()
Message-ID: <20080708052442.GA10326@yookeroo.seuss>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

As Andy Whitcroft recently pointed out, the current powerpc version of
huge_ptep_set_wrprotect() has a bug.  It just calls
ptep_set_wrprotect() which in turn calls pte_update() then
hpte_need_flush() with the 'huge' argument set to 0.  This will cause
hpte_need_flush() to flush the wrong hash entries (of any).  Andy's
fix for this is already in the powerpc tree as commit
016b33c4958681c24056abed8ec95844a0da80a3.

I have confirmed this is a real bug, not masked by some other
synchronization, with a new testcase for libhugetlbfs.  A process
write a (MAP_PRIVATE) hugepage mapping, fork(), then alter the mapping
and have the child incorrectly see the second write.

Therefore, this should be fixed for 2.6.26, and for the stable tree.
Here is a suitable patch for 2.6.26, which I think will also be
suitable for the stable tree (neither of the headers in question has
been changed much recently).  It is cut down slighlty from Andy's
original version, in that it does not include a 32-bit version of
huge_ptep_set_wrprotect().  Currently, hugepages are not supported on
any 32-bit powerpc platform.  When they are, a suitable 32-bit version
can be added - the only 32-bit hardware which supports hugepages does
not use the conventional hashtable MMU and so will have different
needs anyway.

Signed-off-by: Andy Whitcroft <apw@shadowen.org>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>

Index: working-2.6/include/asm-powerpc/hugetlb.h
===================================================================
--- working-2.6.orig/include/asm-powerpc/hugetlb.h	2008-07-08 14:06:56.000000000 +1000
+++ working-2.6/include/asm-powerpc/hugetlb.h	2008-07-08 14:07:04.000000000 +1000
@@ -49,12 +49,6 @@ static inline pte_t huge_pte_wrprotect(p
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
Index: working-2.6/include/asm-powerpc/pgtable-ppc64.h
===================================================================
--- working-2.6.orig/include/asm-powerpc/pgtable-ppc64.h	2008-07-08 14:09:16.000000000 +1000
+++ working-2.6/include/asm-powerpc/pgtable-ppc64.h	2008-07-08 14:09:30.000000000 +1000
@@ -314,6 +314,16 @@ static inline void ptep_set_wrprotect(st
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
+
 /*
  * We currently remove entries from the hashtable regardless of whether
  * the entry was young or dirty. The generic routines only flush if the

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

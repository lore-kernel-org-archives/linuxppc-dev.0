Return-Path: <dgibson@ozlabs.org>
Date: Fri, 22 Dec 2006 09:23:03 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Andrew Morton <akpm@osdl.org>
Subject: [powerpc] Fix bogus BUG_ON() in in hugetlb_get_unmapped_area()
Message-ID: <20061221222303.GA6418@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Paul Mackerras <paulus@samba.org>, libhugetlbfs-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org,
	William Lee Irwin <wli@holomorphy.com>, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Andrew, Paulus, please apply

The powerpc specific version of hugetlb_get_unmapped_area() makes some
unwarranted assumptions about what checks have been made to its
parameters by its callers.  This will lead to a BUG_ON() if a 32-bit
process attempts to make a hugepage mapping which extends above
TASK_SIZE (4GB).

I'm not sure if these assumptions came about because they were valid
with earlier versions of the get_unmapped_area() path, or if it was
always broken.  Nonetheless this patch fixes the logic, and removes
the crash.

Signed-off-by: David Gibson <david@gibson.dropbear.id.au>

Index: working-2.6/arch/powerpc/mm/hugetlbpage.c
===================================================================
--- working-2.6.orig/arch/powerpc/mm/hugetlbpage.c	2006-12-21 14:54:15.000000000 +1100
+++ working-2.6/arch/powerpc/mm/hugetlbpage.c	2006-12-21 14:57:35.000000000 +1100
@@ -744,7 +744,8 @@ static int htlb_check_hinted_area(unsign
 	struct vm_area_struct *vma;
 
 	vma = find_vma(current->mm, addr);
-	if (!vma || ((addr + len) <= vma->vm_start))
+	if (TASK_SIZE - len >= addr &&
+	    (!vma || ((addr + len) <= vma->vm_start)))
 		return 0;
 
 	return -ENOMEM;
@@ -815,6 +816,8 @@ unsigned long hugetlb_get_unmapped_area(
 		return -EINVAL;
 	if (len & ~HPAGE_MASK)
 		return -EINVAL;
+	if (len > TASK_SIZE)
+		return -ENOMEM;
 
 	if (!cpu_has_feature(CPU_FTR_16M_PAGE))
 		return -EINVAL;
@@ -823,9 +826,6 @@ unsigned long hugetlb_get_unmapped_area(
 	BUG_ON((addr + len)  < addr);
 
 	if (test_thread_flag(TIF_32BIT)) {
-		/* Paranoia, caller should have dealt with this */
-		BUG_ON((addr + len) > 0x100000000UL);
-
 		curareas = current->mm->context.low_htlb_areas;
 
 		/* First see if we can use the hint address */

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

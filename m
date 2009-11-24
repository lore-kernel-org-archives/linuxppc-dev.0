Return-Path: <dgibson@ozlabs.org>
Date: Tue, 24 Nov 2009 17:03:40 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Fix bug in gup_hugepd()
Message-ID: <20091124060340.GE2737@yookeroo>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Commit a4fe3ce7699bfe1bd88f816b55d42d8fe1dac655 introduced a new
get_user_pages() path for hugepages on powerpc.  Unfortunately, there
is a bug in it's loop logic, which can cause it to overrun the end of
the intended region.  This came about by copying the logic from the
normal page path, which assumes the address and end parameters have
been pagesize aligned at the top-level.  Since they're not *hugepage*
size aligned, the simplistic logic could step over the end of the gup
region without triggering the loop end condition.

This patch fixes the bug by using the technique that the normal page
path uses in levels above the lowest to truncate the ending address to
something we know we'll match with.

Signed-off-by: David Gibson <david@gibson.dropbear.id.au>

Index: working-2.6/arch/powerpc/mm/hugetlbpage.c
===================================================================
--- working-2.6.orig/arch/powerpc/mm/hugetlbpage.c	2009-11-24 14:25:36.488330625 +1100
+++ working-2.6/arch/powerpc/mm/hugetlbpage.c	2009-11-24 15:55:27.296455938 +1100
@@ -436,18 +436,27 @@ static noinline int gup_hugepte(pte_t *p
 	return 1;
 }
 
+static unsigned long hugepte_addr_end(unsigned long addr, unsigned long end,
+				      unsigned long sz)
+{
+	unsigned long __boundary = (addr + sz) & ~(sz-1);
+	return (__boundary - 1 < end - 1) ? __boundary : end;
+}
+
 int gup_hugepd(hugepd_t *hugepd, unsigned pdshift,
 	       unsigned long addr, unsigned long end,
 	       int write, struct page **pages, int *nr)
 {
 	pte_t *ptep;
 	unsigned long sz = 1UL << hugepd_shift(*hugepd);
+	unsigned long next;
 
 	ptep = hugepte_offset(hugepd, addr, pdshift);
 	do {
+		next = hugepte_addr_end(addr, end, sz);
 		if (!gup_hugepte(ptep, sz, addr, end, write, pages, nr))
 			return 0;
-	} while (ptep++, addr += sz, addr != end);
+	} while (ptep++, addr = next, addr != end);
 
 	return 1;
 }


-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

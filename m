Return-Path: <benh@ozlabs.org>
To: Paul Mackerras <paulus@samba.org>
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Wed, 03 Sep 2008 13:12:05 +1000
Subject: [PATCH] powerpc: Fix build error with 64K pages and !hugetlbfs
Message-Id: <20080903031303.7BA65DDE1D@ozlabs.org>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

HAVE_ARCH_UNMAPPED_AREA and HAVE_ARCH_UNMAPPED_AREA_TOPDOWN must
be defined whenever CONFIG_PPC_MM_SLICES is enabled, not only when
CONFIG_HUGETLB_PAGE is. They used to be always defined together but
this is no longer the case.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---

 arch/powerpc/include/asm/pgtable-ppc64.h |    6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

--- linux-work.orig/arch/powerpc/include/asm/pgtable-ppc64.h	2008-09-03 13:06:58.000000000 +1000
+++ linux-work/arch/powerpc/include/asm/pgtable-ppc64.h	2008-09-03 13:07:14.000000000 +1000
@@ -153,12 +153,10 @@
 #define __S110	PAGE_SHARED_X
 #define __S111	PAGE_SHARED_X
 
-#ifdef CONFIG_HUGETLB_PAGE
-
+#ifdef CONFIG_PPC_MM_SLICES
 #define HAVE_ARCH_UNMAPPED_AREA
 #define HAVE_ARCH_UNMAPPED_AREA_TOPDOWN
-
-#endif
+#endif /* CONFIG_PPC_MM_SLICES */
 
 #ifndef __ASSEMBLY__
 

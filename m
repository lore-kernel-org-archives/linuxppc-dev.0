Return-Path: <mel@skynet.ie>
Received: from gir.skynet.ie (gir.skynet.ie [193.1.99.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id EBA56DDE03
	for <linuxppc-dev@ozlabs.org>; Thu, 15 Nov 2007 05:10:52 +1100 (EST)
Date: Wed, 14 Nov 2007 18:10:45 +0000
To: Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: Do not depend on MAX_ORDER when grouping pages by mobility
Message-ID: <20071114181044.GB773@skynet.ie>
References: <20071112132108.7c98f011.sfr@canb.auug.org.au>
	<20071112155452.GB6653@skynet.ie>
	<20071113114401.73d81ce2.sfr@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
In-Reply-To: <20071113114401.73d81ce2.sfr@canb.auug.org.au>
From: mel@skynet.ie (Mel Gorman)
Cc: ppc-dev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On (13/11/07 11:44), Stephen Rothwell didst pronounce:
> On Mon, 12 Nov 2007 15:54:53 +0000 mel@skynet.ie (Mel Gorman) wrote:
> >
> > Ordinarily, the size of a pageblock is determined from the hugepage size.
> > On PPC64, the hugepage size is determined at runtime based on the ability
> > of the machine. If the machine does not support hugepages, HPAGE_SHIFT is
> > 0. This results in pageblock_order being set to -PAGE_SHIFT and a crash
> > results shortly afterwards.
> > 
> > This patch checks that HPAGE_SHIFT is a sensible value before using the
> > hugepage size. If it is 0, MAX_ORDER-1 is used instead as this is a sensible
> > value of pageblock_order.
> > 
> > Signed-off-by: Mel Gorman <mel@csn.ul.ie>
> 
> Looks good. Legacy iSeries boots fine with this and David Gibson has run
> his libhugetlbfs test suite on a Power5+ machine also running the same
> kernel (ppc64_defconfig).
> 
> I would be good if we could get this in for 2.6.24 (since, as far as
> legacy iSeries is concerned, this is a regression from 2.6.23).  I am not
> sure what other testing needs to be done.
> 

libhugetlbfs test suite and boot test on iSeries is sufficient in this
case. However, the version I sent would break on IA-64 due to the lack of
a definition for HPAGE_SHIFT when CONFIG_HUGETLB_PAGE is not set. Can you
confirm this patch still fixes the problem please? If it does, I'll send
it to Andrew as a fix for 2.6.24. Whether iSeries is legacy or not, this is
breakage and should be fixed.

Thanks

====

Ordinarily the size of a pageblock is determined at compile-time based on the
hugepage size. On PPC64, the hugepage size is determined at runtime based on
what is supported by the machine. With legacy machines such as iSeries that
do not support hugepages, HPAGE_SHIFT is 0. This results in pageblock_order
being set to -PAGE_SHIFT and a crash results shortly afterwards.

This patch adds a function to select a sensible value for pageblock order by
default when HUGETLB_PAGE_SIZE_VARIABLE is set. It checks that HPAGE_SHIFT
is a sensible value before using the hugepage size; if it is not MAX_ORDER-1
is used.

This is a fix for 2.6.24.

Credit goes to Stephen Rothwell for identifying the bug and testing on
iSeries. Additional credit goes to Andy Whitcroft for spotting a problem
with respects to IA-64 before releasing. Additional credit goes to David
Gibson for testing with the libhugetlbfs test suite.

Signed-off-by: Mel Gorman <mel@csn.ul.ie>

--- 
 arch/powerpc/Kconfig |    5 +++++
 mm/page_alloc.c      |   14 ++++++++++++--
 2 files changed, 17 insertions(+), 2 deletions(-)

diff -rup -X /usr/src/patchset-0.6/bin//dontdiff linux-2.6.24-rc2-mm1-clean/arch/powerpc/Kconfig linux-2.6.24-rc2-005_iSeries_fix/arch/powerpc/Kconfig
--- linux-2.6.24-rc2-mm1-clean/arch/powerpc/Kconfig	2007-11-14 11:38:05.000000000 +0000
+++ linux-2.6.24-rc2-005_iSeries_fix/arch/powerpc/Kconfig	2007-11-14 11:39:12.000000000 +0000
@@ -187,6 +187,11 @@ config FORCE_MAX_ZONEORDER
 	default "9" if PPC_64K_PAGES
 	default "13"
 
+config HUGETLB_PAGE_SIZE_VARIABLE
+	bool
+	depends on HUGETLB_PAGE
+	default y
+
 config MATH_EMULATION
 	bool "Math emulation"
 	depends on 4xx || 8xx || E200 || PPC_MPC832x || E500
diff -rup -X /usr/src/patchset-0.6/bin//dontdiff linux-2.6.24-rc2-mm1-clean/mm/page_alloc.c linux-2.6.24-rc2-005_iSeries_fix/mm/page_alloc.c
--- linux-2.6.24-rc2-mm1-clean/mm/page_alloc.c	2007-11-14 11:38:08.000000000 +0000
+++ linux-2.6.24-rc2-005_iSeries_fix/mm/page_alloc.c	2007-11-14 13:45:19.000000000 +0000
@@ -3342,6 +3342,16 @@ static void inline setup_usemap(struct p
 #endif /* CONFIG_SPARSEMEM */
 
 #ifdef CONFIG_HUGETLB_PAGE_SIZE_VARIABLE
+
+/* Return a sensible default order for the pageblock size. */
+static inline int __init pageblock_default_order(void)
+{
+	if (HPAGE_SHIFT > PAGE_SHIFT)
+		return HUGETLB_PAGE_ORDER;
+
+	return MAX_ORDER-1;
+}
+
 /* Initialise the number of pages represented by NR_PAGEBLOCK_BITS */
 static inline void __init set_pageblock_order(unsigned int order)
 {
@@ -3357,7 +3367,7 @@ static inline void __init set_pageblock_
 }
 #else /* CONFIG_HUGETLB_PAGE_SIZE_VARIABLE */
 
-/* Defined this way to avoid accidently referencing HUGETLB_PAGE_ORDER */
+#define pageblock_default_order(x) (0)
 #define set_pageblock_order(x)	do {} while (0)
 
 #endif /* CONFIG_HUGETLB_PAGE_SIZE_VARIABLE */
@@ -3442,7 +3452,7 @@ static void __meminit free_area_init_cor
 		if (!size)
 			continue;
 
-		set_pageblock_order(HUGETLB_PAGE_ORDER);
+		set_pageblock_order(pageblock_default_order());
 		setup_usemap(pgdat, zone, size);
 		ret = init_currently_empty_zone(zone, zone_start_pfn,
 						size, MEMMAP_EARLY);

-- 
Mel Gorman
Part-time Phd Student                          Linux Technology Center
University of Limerick                         IBM Dublin Software Lab

Return-Path: <mel@skynet.ie>
Received: from gir.skynet.ie (gir.skynet.ie [193.1.99.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 2B201DDE02
	for <linuxppc-dev@ozlabs.org>; Tue, 13 Nov 2007 03:13:45 +1100 (EST)
Date: Mon, 12 Nov 2007 15:54:53 +0000
To: Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: Do not depend on MAX_ORDER when grouping pages by mobility
Message-ID: <20071112155452.GB6653@skynet.ie>
References: <20071112132108.7c98f011.sfr@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
In-Reply-To: <20071112132108.7c98f011.sfr@canb.auug.org.au>
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

On (12/11/07 13:21), Stephen Rothwell didst pronounce:

> I discovered recently that a kernel built with ppc64_defconfig no longer
> boots on legacy iSeries.  It did in 2.6.23.  I bisected down the commit
> d9c2340052278d8eb2ffb16b0484f8f794def4de ("Do not depend on MAX_ORDER
> when grouping pages by mobility") which fails while its parent is ok.
> Also, an iseries_defconfig kernel will boot.  The reason it seem is
> because on PowerPC 64 with CONFIG_HUGETLB_PAGE, HPAGE_SHIFT is not
> constant and its value is determined at runtime early.
> 

Ok, that in itself is ok. IA-64 does something similar.

> For legacy iSeries HPAGE_SHIFT remains 0 which means that
> HUGETLB_PAGE_ORDER becomes -PAGE_SHIFT and things degenerate badly.
> 

D'oh. That would have problems for sure.

> I can enable CONFIG_HUGETLB_PAGE_SIZE_VARIABLE for PowerPC 64, but I
> still need to know a good value for HPAGE_SHIFT.  Do you have a
> suggestion? Is there a better way to fix this problem?  There are places
> in the PowerPC code that assume that HPAGE_SHIFT == 0 means that we have
> no huge pages.
> 

How about the following both in terms of taste and whether it works or
not?

===

Ordinarily, the size of a pageblock is determined from the hugepage size.
On PPC64, the hugepage size is determined at runtime based on the ability
of the machine. If the machine does not support hugepages, HPAGE_SHIFT is
0. This results in pageblock_order being set to -PAGE_SHIFT and a crash
results shortly afterwards.

This patch checks that HPAGE_SHIFT is a sensible value before using the
hugepage size. If it is 0, MAX_ORDER-1 is used instead as this is a sensible
value of pageblock_order.

Signed-off-by: Mel Gorman <mel@csn.ul.ie>
---

diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index 18f397c..232c298 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
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
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index da69d83..14e0ac3 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -3386,7 +3386,16 @@ static void __meminit free_area_init_core(struct pglist_data *pgdat,
 		if (!size)
 			continue;
 
-		set_pageblock_order(HUGETLB_PAGE_ORDER);
+		/*
+		 * If HPAGE_SHIFT is a sensible value, base the size of a
+		 * pageblock on the hugepage size. Otherwise MAX_ORDER-1
+		 * is a sensible choice
+		 */
+		if (HPAGE_SHIFT > PAGE_SHIFT)
+			set_pageblock_order(HUGETLB_PAGE_ORDER);
+		else
+			set_pageblock_order(MAX_ORDER-1);
+
 		setup_usemap(pgdat, zone, size);
 		ret = init_currently_empty_zone(zone, zone_start_pfn,
 						size, MEMMAP_EARLY);
-- 
Mel Gorman
Part-time Phd Student                          Linux Technology Center
University of Limerick                         IBM Dublin Software Lab

Return-Path: <mel@csn.ul.ie>
Received: from holly.csn.ul.ie (holly.csn.ul.ie [193.1.99.76])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 69472679E0
	for <linuxppc-dev@ozlabs.org>; Mon, 15 May 2006 22:27:38 +1000 (EST)
Date: Mon, 15 May 2006 13:27:29 +0100
To: Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH 5/6] Have ia64 use add_active_range() and
	free_area_init_nodes
Message-ID: <20060515122728.GA29253@skynet.ie>
References: <20060508141030.26912.93090.sendpatchset@skynet>
	<20060508141211.26912.48278.sendpatchset@skynet>
	<20060514203158.216a966e.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
In-Reply-To: <20060514203158.216a966e.akpm@osdl.org>
From: mel@csn.ul.ie (Mel Gorman)
Cc: davej@codemonkey.org.uk, tony.luck@intel.com, linuxppc-dev@ozlabs.org,
	ak@suse.de, bob.picco@hp.com, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On (14/05/06 20:31), Andrew Morton didst pronounce:
> Mel Gorman <mel@csn.ul.ie> wrote:
> >
> > Size zones and holes in an architecture independent manner for ia64.
> > 
> 
> This one makes my ia64 die very early in boot.   The trace is pretty useless.
> 
> config at http://www.zip.com.au/~akpm/linux/patches/stuff/config-ia64
> 
> <log snipped>

Curses. When I tried to reproduce this, the machine booted with my default
config but died before initialising the console with your config. The machine
is far away so I can't see the screen or restart the machine remotely so
I can only assume it is dying for the same reasons yours did.

> Note the misaligned pfns.
> 
> Andy's (misspelled) CONFIG_UNALIGNED_ZONE_BOUNDRIES patch didn't actually
> include an update to any Kconfig files.  But hacking that in by hand didn't
> help.

It would not have helped in this case because the zone boundaries would still
be in the wrong place for ia64. Below is a patch that aligns the zones on
all architectures that use CONFIG_ARCH_POPULATES_NODE_MAP . That is currently
i386, x86_64, powerpc, ppc and ia64. It does *not* align pgdat->node_start_pfn
but I don't believe that it is necessary.

I can't test it on ia64 until I get someone to restart the machine. The patch
compiles and is currently boot-testing on a range of other machines. I hope
to know within 5-6 hours if everything is ok.

diff -rup -X /usr/src/patchset-0.5/bin//dontdiff linux-2.6.17-rc4-mm4-clean/mm/page_alloc.c linux-2.6.17-rc4-mm4-ia64_force_alignment/mm/page_alloc.c
--- linux-2.6.17-rc4-mm4-clean/mm/page_alloc.c	2006-05-15 10:37:55.000000000 +0100
+++ linux-2.6.17-rc4-mm4-ia64_force_alignment/mm/page_alloc.c	2006-05-15 13:10:42.000000000 +0100
@@ -2640,14 +2640,20 @@ void __init free_area_init_nodes(unsigne
 {
 	unsigned long nid;
 	int zone_index;
+	unsigned long lowest_pfn = find_min_pfn_with_active_regions();
+
+	lowest_pfn = zone_boundary_align_pfn(lowest_pfn);
+	arch_max_dma_pfn = zone_boundary_align_pfn(arch_max_dma_pfn);
+	arch_max_dma32_pfn = zone_boundary_align_pfn(arch_max_dma32_pfn);
+	arch_max_low_pfn = zone_boundary_align_pfn(arch_max_low_pfn);
+	arch_max_high_pfn = zone_boundary_align_pfn(arch_max_high_pfn);
 
 	/* Record where the zone boundaries are */
 	memset(arch_zone_lowest_possible_pfn, 0,
 				sizeof(arch_zone_lowest_possible_pfn));
 	memset(arch_zone_highest_possible_pfn, 0,
 				sizeof(arch_zone_highest_possible_pfn));
-	arch_zone_lowest_possible_pfn[ZONE_DMA] =
-					find_min_pfn_with_active_regions();
+	arch_zone_lowest_possible_pfn[ZONE_DMA] = lowest_pfn;
 	arch_zone_highest_possible_pfn[ZONE_DMA] = arch_max_dma_pfn;
 	arch_zone_highest_possible_pfn[ZONE_DMA32] = arch_max_dma32_pfn;
 	arch_zone_highest_possible_pfn[ZONE_NORMAL] = arch_max_low_pfn;

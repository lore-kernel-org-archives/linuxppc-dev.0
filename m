Return-Path: <mel@csn.ul.ie>
Received: from holly.csn.ul.ie (holly.csn.ul.ie [193.1.99.76])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 7A01E67A04
	for <linuxppc-dev@ozlabs.org>; Fri, 14 Apr 2006 03:30:14 +1000 (EST)
Date: Thu, 13 Apr 2006 18:30:08 +0100
To: "Luck, Tony" <tony.luck@intel.com>
Subject: Re: [PATCH 0/7] [RFC] Sizing zones and holes in an architecture
	independent manner V2
Message-ID: <20060413173008.GA19402@skynet.ie>
References: <20060412232036.18862.84118.sendpatchset@skynet>
	<20060413095207.GA4047@skynet.ie>
	<20060413171942.GA15047@agluck-lia64.sc.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
In-Reply-To: <20060413171942.GA15047@agluck-lia64.sc.intel.com>
From: mel@csn.ul.ie (Mel Gorman)
Cc: davej@codemonkey.org.uk, linuxppc-dev@ozlabs.org, ak@suse.de,
	bob.picco@hp.com, linux-kernel@vger.kernel.org, linux-mm@kvack.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On (13/04/06 10:19), Luck, Tony didst pronounce:
> On Thu, Apr 13, 2006 at 10:52:08AM +0100, Mel Gorman wrote:
> > I didn't look at the test program output carefully enough! There was a
> > double counting of some holes because of a missing "if" - obvious in the
> > morning. Fix is this (applies on top of the debugging patch)
> 
> Back to not booting with tiger_defconfig on Intel Tiger box :-(
> 
> There are no lines like:
> 
> 	On node 0 totalpages: 260725
> 	  DMA zone: 129700 pages, LIFO batch:7
> 	  Normal zone: 131025 pages, LIFO batch:7
> 
> in the log ... which might explain the OOM later.
> 
> Whole console log appended (The "Kill process 2" messages repeat
> forever).
> 
> -Tony
> 
> 
> <SNIP>
> Dumping sorted node map
> entry 0: 0  1024 -> 130688
> entry 1: 0  130984 -> 131020
> entry 2: 0  393216 -> 524164
> entry 3: 0  524192 -> 524269
> Hole found index 1: 130688 -> 130984
> Hole found index 2: 131020 -> 262144
> Hole found index 2: 131020 -> 393216

Double counted a hole here, then went downhill. Does the following fix
it?


diff -rup -X /usr/src/patchset-0.5/bin//dontdiff linux-2.6.17-rc1-zonesizing-v6/mm/mem_init.c linux-2.6.17-rc1-107-debug/mm/mem_init.c
--- linux-2.6.17-rc1-zonesizing-v6/mm/mem_init.c	2006-04-13 10:30:50.000000000 +0100
+++ linux-2.6.17-rc1-107-debug/mm/mem_init.c	2006-04-13 18:00:39.000000000 +0100
@@ -753,17 +753,21 @@ unsigned long __init zone_absent_pages_i
 		start_pfn = early_node_map[i].start_pfn;
 		if (start_pfn > arch_zone_highest_possible_pfn[zone_type])
 			start_pfn = arch_zone_highest_possible_pfn[zone_type];
-		if (prev_end_pfn > start_pfn) {
-			printk("prev_end > start_pfn : %lu > %lu\n",
-					prev_end_pfn,
-					start_pfn);
-			BUG();
-		}
+		if (prev_end_pfn < arch_zone_lowest_possible_pfn[zone_type])
+			prev_end_pfn = arch_zone_lowest_possible_pfn[zone_type];
 
 		/* Update the hole size cound and move on */
-		hole_pages += start_pfn - prev_end_pfn;
-		printk("Hole found index %d: %lu -> %lu\n",
-				i, prev_end_pfn, start_pfn);
+		if (start_pfn > arch_zone_lowest_possible_pfn[zone_type]) {
+			if (prev_end_pfn > start_pfn) {
+				printk("prev_end > start_pfn : %lu > %lu\n",
+						prev_end_pfn,
+						start_pfn);
+				BUG();
+			}
+			hole_pages += start_pfn - prev_end_pfn;
+			printk("Hole found index %d: %lu -> %lu\n",
+					i, prev_end_pfn, start_pfn);
+		}
 		prev_end_pfn = early_node_map[i].end_pfn;
 	}
 

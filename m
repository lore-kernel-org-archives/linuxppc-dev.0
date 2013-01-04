Return-Path: <cody@linux.vnet.ibm.com>
Received: from e36.co.us.ibm.com (e36.co.us.ibm.com [32.97.110.154])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e36.co.us.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id C305E2C0082
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  5 Jan 2013 05:17:20 +1100 (EST)
Received: from /spool/local
 by e36.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <cody@linux.vnet.ibm.com>;
 Fri, 4 Jan 2013 11:17:17 -0700
Received: from d03relay03.boulder.ibm.com (d03relay03.boulder.ibm.com
 [9.17.195.228])
 by d03dlp01.boulder.ibm.com (Postfix) with ESMTP id 49D351FF003E
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  4 Jan 2013 11:17:03 -0700 (MST)
Received: from d03av05.boulder.ibm.com (d03av05.boulder.ibm.com [9.17.195.85])
 by d03relay03.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP
 id r04IHBAk273458
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 4 Jan 2013 11:17:12 -0700
Received: from d03av05.boulder.ibm.com (loopback [127.0.0.1])
 by d03av05.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r04IGgYg011557
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 4 Jan 2013 11:17:10 -0700
From: Cody P Schafer <cody@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH] powerpc/mm: eliminate unneeded for_each_memblock
Date: Fri,  4 Jan 2013 13:06:00 -0500
Message-Id: <1357322760-12197-1-git-send-email-cody@linux.vnet.ibm.com>
Cc: Cody P Schafer <cody@linux.vnet.ibm.com>,
 LKML <linux-kernel@vger.kernel.org>, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The only persistent change made by this loop is calling
memblock_set_node() once for each memblock, which is not useful (and has
no effect) as memblock_set_node() is not called with any
memblock-specific parameters.

Subsistute a single memblock_set_node().
---
 arch/powerpc/mm/mem.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/arch/powerpc/mm/mem.c b/arch/powerpc/mm/mem.c
index 0dba506..50370bb 100644
--- a/arch/powerpc/mm/mem.c
+++ b/arch/powerpc/mm/mem.c
@@ -195,13 +195,8 @@ void __init do_init_bootmem(void)
 	min_low_pfn = MEMORY_START >> PAGE_SHIFT;
 	boot_mapsize = init_bootmem_node(NODE_DATA(0), start >> PAGE_SHIFT, min_low_pfn, max_low_pfn);
 
-	/* Add active regions with valid PFNs */
-	for_each_memblock(memory, reg) {
-		unsigned long start_pfn, end_pfn;
-		start_pfn = memblock_region_memory_base_pfn(reg);
-		end_pfn = memblock_region_memory_end_pfn(reg);
-		memblock_set_node(0, (phys_addr_t)ULLONG_MAX, 0);
-	}
+	/* Place all memblock_regions in the same node and merge contiguous memblock_regions */
+	memblock_set_node(0, (phys_addr_t)ULLONG_MAX, 0);
 
 	/* Add all physical memory to the bootmem map, mark each area
 	 * present.
-- 
1.8.0.3

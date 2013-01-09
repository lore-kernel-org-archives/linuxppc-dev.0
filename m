Return-Path: <cody@linux.vnet.ibm.com>
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e35.co.us.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 78B6D2C0193
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 10 Jan 2013 09:41:11 +1100 (EST)
Received: from /spool/local
 by e35.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <cody@linux.vnet.ibm.com>;
 Wed, 9 Jan 2013 15:41:07 -0700
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com
 [9.17.195.227])
 by d03dlp01.boulder.ibm.com (Postfix) with ESMTP id BCA801FF003E
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  9 Jan 2013 15:40:45 -0700 (MST)
Received: from d03av06.boulder.ibm.com (d03av06.boulder.ibm.com [9.17.195.245])
 by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r09MeiOC104158
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 9 Jan 2013 15:40:45 -0700
Received: from d03av06.boulder.ibm.com (loopback [127.0.0.1])
 by d03av06.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r09MggVu029173
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 9 Jan 2013 15:42:43 -0700
From: Cody P Schafer <cody@linux.vnet.ibm.com>
To: Linux PPC <linuxppc-dev@lists.ozlabs.org>, galak@kernel.crashing.org
Subject: [PATCH v2] powerpc/mm: eliminate unneeded for_each_memblock
Date: Wed,  9 Jan 2013 14:40:18 -0800
Message-Id: <1357771218-6499-1-git-send-email-cody@linux.vnet.ibm.com>
In-Reply-To: <82A31E2D-FA24-44CF-9812-9E8062AFA6F4@kernel.crashing.org>
References: <82A31E2D-FA24-44CF-9812-9E8062AFA6F4@kernel.crashing.org>
Cc: Cody P Schafer <cody@linux.vnet.ibm.com>, Paul Mackerras <paulus@samba.org>,
 LKML <linux-kernel@vger.kernel.org>
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

Signed-off-by: Cody P Schafer <cody@linux.vnet.ibm.com>
---

Now with a signoff & wrapped comment line.

 arch/powerpc/mm/mem.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/arch/powerpc/mm/mem.c b/arch/powerpc/mm/mem.c
index 0dba506..40df7c8 100644
--- a/arch/powerpc/mm/mem.c
+++ b/arch/powerpc/mm/mem.c
@@ -195,13 +195,10 @@ void __init do_init_bootmem(void)
 	min_low_pfn = MEMORY_START >> PAGE_SHIFT;
 	boot_mapsize = init_bootmem_node(NODE_DATA(0), start >> PAGE_SHIFT, min_low_pfn, max_low_pfn);
 
-	/* Add active regions with valid PFNs */
-	for_each_memblock(memory, reg) {
-		unsigned long start_pfn, end_pfn;
-		start_pfn = memblock_region_memory_base_pfn(reg);
-		end_pfn = memblock_region_memory_end_pfn(reg);
-		memblock_set_node(0, (phys_addr_t)ULLONG_MAX, 0);
-	}
+	/* Place all memblock_regions in the same node and merge contiguous
+	 * memblock_regions
+	 */
+	memblock_set_node(0, (phys_addr_t)ULLONG_MAX, 0);
 
 	/* Add all physical memory to the bootmem map, mark each area
 	 * present.
-- 
1.8.0.3

Return-Path: <bharata@linux.vnet.ibm.com>
Received: from e28smtp05.in.ibm.com (e28smtp05.in.ibm.com [125.16.236.5])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qg16c4zsDzDq6B
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  6 Apr 2016 19:45:11 +1000 (AEST)
Received: from localhost
 by e28smtp05.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <bharata@linux.vnet.ibm.com>;
 Wed, 6 Apr 2016 15:15:08 +0530
Received: from d28av03.in.ibm.com (d28av03.in.ibm.com [9.184.220.65])
 by d28relay03.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u369j4HK50987258
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 6 Apr 2016 15:15:04 +0530
Received: from d28av03.in.ibm.com (localhost [127.0.0.1])
 by d28av03.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u369iuea001978
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 6 Apr 2016 15:15:00 +0530
From: Bharata B Rao <bharata@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: david@gibson.dropbear.id.au, nfonteno@us.ibm.com,
 mdroth@linux.vnet.ibm.com, aik@au1.ibm.com,
 Bharata B Rao <bharata@linux.vnet.ibm.com>
Subject: [RFC FIX PATCH v0] powerpc,numa: Fix memory_hotplug_max()
Date: Wed,  6 Apr 2016 15:14:43 +0530
Message-Id: <1459935883-29445-1-git-send-email-bharata@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

memory_hotplug_max() uses hot_add_drconf_memory_max() to get maxmimum
addressable memory by referring to ibm,dyanamic-memory property. There
are three problems with the current approach:

1 hot_add_drconf_memory_max() assumes that ibm,dynamic-memory includes
  all the LMBs of the guest, but that is not true for PowerKVM which
  populates only DR LMBs (LMBs that can be hotplugged/removed) in that
  property.
2 hot_add_drconf_memory_max() multiplies lmb-size with lmb-count to arrive
  at the max possible address. Since ibm,dynamic-memory doesn't include
  RMA LMBs, the address thus obtained will be less than the actual max
  address. For example, if max possible memory size is 32G, with lmb-size
  of 256MB there can be 127 LMBs in ibm,dynamic-memory (1 LMB for RMA
  which won't be present here).  hot_add_drconf_memory_max() would then
  return the max addressable memory as 127 * 256MB = 31.75GB, the max
  address should have been 32G which is what ibm,lrdr-capacity shows.
3 In PowerKVM, there can be a gap between the end of boot time RAM and
  beginning of hotplug RAM area. So just multiplying lmb-count with
  lmb-size will not provide the correct max possible address for PowerKVM.

This patch fixes 1 by using ibm,lrdr-capacity property to return the max
addressable memory whenever the property is present. Then it fixes 2 & 3
by fetching the address of the last LMB in ibm,dynamic-memory property.

NOTE: There are some unnecessary changes in the patch because of converting
spaces to tabs w/o which checkpatch.pl complains.

Signed-off-by: Bharata B Rao <bharata@linux.vnet.ibm.com>
---
 arch/powerpc/mm/numa.c | 29 ++++++++++++++++++++++-------
 1 file changed, 22 insertions(+), 7 deletions(-)

diff --git a/arch/powerpc/mm/numa.c b/arch/powerpc/mm/numa.c
index 669a15e..57d5877 100644
--- a/arch/powerpc/mm/numa.c
+++ b/arch/powerpc/mm/numa.c
@@ -1164,17 +1164,32 @@ int hot_add_scn_to_nid(unsigned long scn_addr)
 static u64 hot_add_drconf_memory_max(void)
 {
         struct device_node *memory = NULL;
-        unsigned int drconf_cell_cnt = 0;
-        u64 lmb_size = 0;
+	struct device_node *dn = NULL;
+	unsigned int drconf_cell_cnt = 0;
+	u64 lmb_size = 0;
 	const __be32 *dm = NULL;
+	const __be64 *lrdr = NULL;
+	struct of_drconf_cell drmem;
+
+	dn = of_find_node_by_path("/rtas");
+	if (dn) {
+		lrdr = of_get_property(dn, "ibm,lrdr-capacity", NULL);
+		of_node_put(dn);
+		if (lrdr)
+			return be64_to_cpup(lrdr);
+	}
 
         memory = of_find_node_by_path("/ibm,dynamic-reconfiguration-memory");
         if (memory) {
-                drconf_cell_cnt = of_get_drconf_memory(memory, &dm);
-                lmb_size = of_get_lmb_size(memory);
-                of_node_put(memory);
-        }
-        return lmb_size * drconf_cell_cnt;
+		drconf_cell_cnt = of_get_drconf_memory(memory, &dm);
+		lmb_size = of_get_lmb_size(memory);
+
+		/* Advance to the last cell, each cell has 6 32 bit integers */
+		dm += (drconf_cell_cnt - 1) * 6;
+		read_drconf_cell(&drmem, &dm);
+		of_node_put(memory);
+	}
+	return drmem.base_addr + lmb_size;
 }
 
 /*
-- 
2.1.0

Return-Path: <raghavendra.kt@linux.vnet.ibm.com>
Received: from e19.ny.us.ibm.com (e19.ny.us.ibm.com [129.33.205.209])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id A41781A08A6
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 16 Jan 2016 06:06:09 +1100 (AEDT)
Received: from localhost
 by e19.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <raghavendra.kt@linux.vnet.ibm.com>;
 Fri, 15 Jan 2016 14:06:06 -0500
Received: from b01cxnp22033.gho.pok.ibm.com (b01cxnp22033.gho.pok.ibm.com
 [9.57.198.23])
 by d01dlp03.pok.ibm.com (Postfix) with ESMTP id 06905C90042
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 15 Jan 2016 14:06:01 -0500 (EST)
Received: from d01av03.pok.ibm.com (d01av03.pok.ibm.com [9.56.224.217])
 by b01cxnp22033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u0FJ61f627721800
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 15 Jan 2016 19:06:01 GMT
Received: from d01av03.pok.ibm.com (localhost [127.0.0.1])
 by d01av03.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u0FJ5ql9027944
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 15 Jan 2016 14:06:01 -0500
From: Raghavendra K T <raghavendra.kt@linux.vnet.ibm.com>
To: <mingo@redhat.com>, <peterz@infradead.org>, <benh@kernel.crashing.org>,
 <paulus@samba.org>, <mpe@ellerman.id.au>, <anton@samba.org>,
 <akpm@linux-foundation.org>
Cc: <jstancek@redhat.com>, <gkurz@linux.vnet.ibm.com>,
 <grant.likely@linaro.org>, <nikunj@linux.vnet.ibm.com>,
 <vdavydov@parallels.com>, <raghavendra.kt@linux.vnet.ibm.com>,
 <linuxppc-dev@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>,
 <linux-mm@kvack.org>
Subject: [PATCH] Fix: PowerNV crash with 4.4.0-rc8 at sched_init_numa
Date: Sat, 16 Jan 2016 00:31:23 +0530
Message-Id: <1452884483-11676-1-git-send-email-raghavendra.kt@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Commit c118baf80256 ("arch/powerpc/mm/numa.c: do not allocate bootmem
memory for non existing nodes") avoided bootmem memory allocation for
non existent nodes.

When DEBUG_PER_CPU_MAPS enabled, powerNV system failed to boot because
in sched_init_numa, cpumask_or operation was done on unallocated nodes.
Fix that by making cpumask_or operation only on existing nodes.

[ Tested with and w/o DEBUG_PER_CPU_MAPS on x86 and powerpc ]

Reported-by: Jan Stancek <jstancek@redhat.com>
Signed-off-by: Raghavendra K T <raghavendra.kt@linux.vnet.ibm.com>
---
 kernel/sched/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 44253ad..474658b 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -6840,7 +6840,7 @@ static void sched_init_numa(void)
 
 			sched_domains_numa_masks[i][j] = mask;
 
-			for (k = 0; k < nr_node_ids; k++) {
+			for_each_node(k) {
 				if (node_distance(j, k) > sched_domains_numa_distance[i])
 					continue;
 
-- 
1.7.11.7

Return-Path: <sasha.levin@oracle.com>
Received: from aserp1040.oracle.com (aserp1040.oracle.com [141.146.126.69])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qnmpw6PsYzDq5k
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 17 Apr 2016 19:55:04 +1000 (AEST)
From: Sasha Levin <sasha.levin@oracle.com>
To: stable@vger.kernel.org, stable-commits@vger.kernel.org
Cc: Raghavendra K T <raghavendra.kt@linux.vnet.ibm.com>,
 <gkurz@linux.vnet.ibm.com>, <grant.likely@linaro.org>,
 <nikunj@linux.vnet.ibm.com>, <vdavydov@parallels.com>,
 <linuxppc-dev@lists.ozlabs.org>, <linux-mm@kvack.org>,
 <peterz@infradead.org>, <benh@kernel.crashing.org>, <paulus@samba.org>,
 <mpe@ellerman.id.au>, <anton@samba.org>,
 Ingo Molnar <mingo@kernel.org>, Sasha Levin <sasha.levin@oracle.com>
Subject: [added to the 4.1 stable tree] sched: Fix crash in sched_init_numa()
Date: Sun, 17 Apr 2016 05:50:09 -0400
Message-Id: <1460886804-19372-10-git-send-email-sasha.levin@oracle.com>
In-Reply-To: <1460886804-19372-1-git-send-email-sasha.levin@oracle.com>
References: <1460886804-19372-1-git-send-email-sasha.levin@oracle.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Raghavendra K T <raghavendra.kt@linux.vnet.ibm.com>

This patch has been added to the 4.1 stable tree. If you have any
objections, please let us know.

===============

[ Upstream commit 9c03ee147193645be4c186d3688232fa438c57c7 ]

The following PowerPC commit:

  c118baf80256 ("arch/powerpc/mm/numa.c: do not allocate bootmem memory for non existing nodes")

avoids allocating bootmem memory for non existent nodes.

But when DEBUG_PER_CPU_MAPS=y is enabled, my powerNV system failed to boot
because in sched_init_numa(), cpumask_or() operation was done on
unallocated nodes.

Fix that by making cpumask_or() operation only on existing nodes.

[ Tested with and w/o DEBUG_PER_CPU_MAPS=y on x86 and PowerPC. ]

Reported-by: Jan Stancek <jstancek@redhat.com>
Tested-by: Jan Stancek <jstancek@redhat.com>
Signed-off-by: Raghavendra K T <raghavendra.kt@linux.vnet.ibm.com>
Cc: <gkurz@linux.vnet.ibm.com>
Cc: <grant.likely@linaro.org>
Cc: <nikunj@linux.vnet.ibm.com>
Cc: <vdavydov@parallels.com>
Cc: <linuxppc-dev@lists.ozlabs.org>
Cc: <linux-mm@kvack.org>
Cc: <peterz@infradead.org>
Cc: <benh@kernel.crashing.org>
Cc: <paulus@samba.org>
Cc: <mpe@ellerman.id.au>
Cc: <anton@samba.org>
Link: http://lkml.kernel.org/r/1452884483-11676-1-git-send-email-raghavendra.kt@linux.vnet.ibm.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Sasha Levin <sasha.levin@oracle.com>
---
 kernel/sched/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 4d870eb..3b0f4c0 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -6480,7 +6480,7 @@ static void sched_init_numa(void)
 
 			sched_domains_numa_masks[i][j] = mask;
 
-			for (k = 0; k < nr_node_ids; k++) {
+			for_each_node(k) {
 				if (node_distance(j, k) > sched_domains_numa_distance[i])
 					continue;
 
-- 
2.5.0

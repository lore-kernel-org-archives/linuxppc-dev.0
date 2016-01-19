Return-Path: <tipbot@zytor.com>
Received: from terminus.zytor.com (terminus.zytor.com [IPv6:2001:1868:205::10])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 6398F1A0CD7
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 Jan 2016 00:39:08 +1100 (AEDT)
Date: Tue, 19 Jan 2016 05:38:13 -0800
Sender: tip tree robot <tipbot@zytor.com>
From: tip-bot for Raghavendra K T <tipbot@zytor.com>
Message-ID: <tip-9c03ee147193645be4c186d3688232fa438c57c7@git.kernel.org>
Cc: linux-kernel@vger.kernel.org, gkurz@linux.vnet.ibm.com,
 raghavendra.kt@linux.vnet.ibm.com, vdavydov@parallels.com,
 mpe@ellerman.id.au, linux-mm@kvack.org, linuxppc-dev@lists.ozlabs.org,
 peterz@infradead.org, hpa@zytor.com, nikunj@linux.vnet.ibm.com,
 tglx@linutronix.de, mingo@kernel.org, paulus@samba.org,
 grant.likely@linaro.org, jstancek@redhat.com, benh@kernel.crashing.org,
 anton@samba.org
Reply-To: tglx@linutronix.de, mingo@kernel.org, linux-mm@kvack.org,
 mpe@ellerman.id.au, hpa@zytor.com, nikunj@linux.vnet.ibm.com,
 linuxppc-dev@lists.ozlabs.org, peterz@infradead.org,
 vdavydov@parallels.com, gkurz@linux.vnet.ibm.com,
 linux-kernel@vger.kernel.org, raghavendra.kt@linux.vnet.ibm.com,
 jstancek@redhat.com, benh@kernel.crashing.org, anton@samba.org,
 grant.likely@linaro.org, paulus@samba.org
In-Reply-To: <1452884483-11676-1-git-send-email-raghavendra.kt@linux.vnet.ibm.com>
References: <1452884483-11676-1-git-send-email-raghavendra.kt@linux.vnet.ibm.com>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:sched/urgent] sched: Fix crash in sched_init_numa()
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Commit-ID:  9c03ee147193645be4c186d3688232fa438c57c7
Gitweb:     http://git.kernel.org/tip/9c03ee147193645be4c186d3688232fa438c57c7
Author:     Raghavendra K T <raghavendra.kt@linux.vnet.ibm.com>
AuthorDate: Sat, 16 Jan 2016 00:31:23 +0530
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Tue, 19 Jan 2016 08:42:20 +0100

sched: Fix crash in sched_init_numa()

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
 

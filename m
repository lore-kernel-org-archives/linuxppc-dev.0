Return-Path: <gregkh@linuxfoundation.org>
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org
 [140.211.169.12])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 208E11A0320
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 15 Feb 2016 08:04:31 +1100 (AEDT)
Subject: Patch "sched: Fix crash in sched_init_numa()" has been added to the
 4.3-stable tree
To: raghavendra.kt@linux.vnet.ibm.com, anton@samba.org,
 benh@kernel.crashing.org, gkurz@linux.vnet.ibm.com, grant.likely@linaro.org,
 gregkh@linuxfoundation.org, jstancek@redhat.com, linux-mm@kvack.org,
 linuxppc-dev@lists.ozlabs.org, mingo@kernel.org, mpe@ellerman.id.au,
 nikunj@linux.vnet.ibm.com, paulus@samba.org, peterz@infradead.org,
 vdavydov@parallels.com
Cc: <stable@vger.kernel.org>, <stable-commits@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Sun, 14 Feb 2016 13:04:29 -0800
Message-ID: <1455483869147137@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


This is a note to let you know that I've just added the patch titled

    sched: Fix crash in sched_init_numa()

to the 4.3-stable tree which can be found at:
    http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary

The filename of the patch is:
     sched-fix-crash-in-sched_init_numa.patch
and it can be found in the queue-4.3 subdirectory.

If you, or anyone else, feels it should not be added to the stable tree,
please let <stable@vger.kernel.org> know about it.


>From 9c03ee147193645be4c186d3688232fa438c57c7 Mon Sep 17 00:00:00 2001
From: Raghavendra K T <raghavendra.kt@linux.vnet.ibm.com>
Date: Sat, 16 Jan 2016 00:31:23 +0530
Subject: sched: Fix crash in sched_init_numa()

From: Raghavendra K T <raghavendra.kt@linux.vnet.ibm.com>

commit 9c03ee147193645be4c186d3688232fa438c57c7 upstream.

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 kernel/sched/core.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -6678,7 +6678,7 @@ static void sched_init_numa(void)
 
 			sched_domains_numa_masks[i][j] = mask;
 
-			for (k = 0; k < nr_node_ids; k++) {
+			for_each_node(k) {
 				if (node_distance(j, k) > sched_domains_numa_distance[i])
 					continue;
 


Patches currently in stable-queue which might be from raghavendra.kt@linux.vnet.ibm.com are

queue-4.3/sched-fix-crash-in-sched_init_numa.patch

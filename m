Return-Path: <millerjo@us.ibm.com>
Received: from e39.co.us.ibm.com (e39.co.us.ibm.com [32.97.110.160])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4937B1A060E
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 21 May 2015 03:13:20 +1000 (AEST)
Received: from /spool/local
 by e39.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <millerjo@us.ibm.com>;
 Wed, 20 May 2015 11:13:17 -0600
Received: from b03cxnp07029.gho.boulder.ibm.com
 (b03cxnp07029.gho.boulder.ibm.com [9.17.130.16])
 by d03dlp02.boulder.ibm.com (Postfix) with ESMTP id C333F3E4004C
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 May 2015 11:13:14 -0600 (MDT)
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
 by b03cxnp07029.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t4KHDEaE52887704
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 May 2015 10:13:14 -0700
Received: from d03av03.boulder.ibm.com (localhost [127.0.0.1])
 by d03av03.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t4KHD930004719
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 May 2015 11:13:12 -0600
From: Jack Miller <millerjo@us.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH] powerpc/powernv: Fix idle state allocation corruption
Date: Wed, 20 May 2015 12:13:04 -0500
Message-Id: <1432141984-5804-1-git-send-email-millerjo@us.ibm.com>
Cc: preeti@linux.vnet.ibm.com, shreyas@linux.vnet.ibm.com, jk@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

pnv_alloc_idle_core_states is iterating over PACAs based on the
configured maximum number of CPUs (NR_CPUS), but PACAs are only
initialized up to nr_cpu_ids, so rein in loops to keep from overwriting
adjacent memory.

Signed-off-by: Jack Miller <millerjo@us.ibm.com>
---
 arch/powerpc/platforms/powernv/setup.c | 26 +++++++++++---------------
 1 file changed, 11 insertions(+), 15 deletions(-)

diff --git a/arch/powerpc/platforms/powernv/setup.c b/arch/powerpc/platforms/powernv/setup.c
index ad0e32e..8e794b6 100644
--- a/arch/powerpc/platforms/powernv/setup.c
+++ b/arch/powerpc/platforms/powernv/setup.c
@@ -356,9 +356,8 @@ int pnv_save_sprs_for_winkle(void)
 
 static void pnv_alloc_idle_core_states(void)
 {
-	int i, j;
-	int nr_cores = cpu_nr_cores();
-	u32 *core_idle_state;
+	u32 *core_idle_state = NULL;
+	int i, thread;
 
 	/*
 	 * core_idle_state - First 8 bits track the idle state of each thread
@@ -371,20 +370,17 @@ static void pnv_alloc_idle_core_states(void)
 	 * b. While the last thread in the core is saving the core state, it
 	 * prevents a different thread from waking up.
 	 */
-	for (i = 0; i < nr_cores; i++) {
-		int first_cpu = i * threads_per_core;
-		int node = cpu_to_node(first_cpu);
+	for (i = 0; i < nr_cpu_ids; i++) {
+		thread = i % threads_per_core;
 
-		core_idle_state = kmalloc_node(sizeof(u32), GFP_KERNEL, node);
-		*core_idle_state = PNV_CORE_IDLE_THREAD_BITS;
-
-		for (j = 0; j < threads_per_core; j++) {
-			int cpu = first_cpu + j;
-
-			paca[cpu].core_idle_state_ptr = core_idle_state;
-			paca[cpu].thread_idle_state = PNV_THREAD_RUNNING;
-			paca[cpu].thread_mask = 1 << j;
+		if (thread == 0) {
+			core_idle_state = kmalloc_node(sizeof(u32), GFP_KERNEL, cpu_to_node(i));
+			*core_idle_state = PNV_CORE_IDLE_THREAD_BITS;
 		}
+
+		paca[i].core_idle_state_ptr = core_idle_state;
+		paca[i].thread_idle_state = PNV_THREAD_RUNNING;
+		paca[i].thread_mask = 1 << thread;
 	}
 
 	update_subcore_sibling_mask();
-- 
2.4.1

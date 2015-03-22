Return-Path: <shreyas@linux.vnet.ibm.com>
Received: from e37.co.us.ibm.com (e37.co.us.ibm.com [32.97.110.158])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 2485C1A025A
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 22 Mar 2015 15:43:23 +1100 (AEDT)
Received: from /spool/local
 by e37.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <shreyas@linux.vnet.ibm.com>;
 Sat, 21 Mar 2015 22:43:20 -0600
Received: from b03cxnp08027.gho.boulder.ibm.com
 (b03cxnp08027.gho.boulder.ibm.com [9.17.130.19])
 by d03dlp02.boulder.ibm.com (Postfix) with ESMTP id E7F453E4003E
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 21 Mar 2015 22:43:18 -0600 (MDT)
Received: from d03av04.boulder.ibm.com (d03av04.boulder.ibm.com [9.17.195.170])
 by b03cxnp08027.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t2M4hIFP35389684
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 21 Mar 2015 21:43:18 -0700
Received: from d03av04.boulder.ibm.com (loopback [127.0.0.1])
 by d03av04.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t2M4hHno018856
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 21 Mar 2015 22:43:18 -0600
From: "Shreyas B. Prabhu" <shreyas@linux.vnet.ibm.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH v3 1/3] powerpc: Fix cpu_online_cores_map to return only
 online threads mask
Date: Sun, 22 Mar 2015 10:12:57 +0530
Message-Id: <1426999379-20542-1-git-send-email-shreyas@linux.vnet.ibm.com>
Cc: "Shreyas B. Prabhu" <shreyas@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Currently, cpu_online_cores_map returns a mask, which for every core
that has atleast one online thread, has the first-cpu-of-that-core's bit
set. But the first cpu itself may not be online always. In such cases, if
the returned mask is used for IPI, then it'll cause IPIs to be skipped
on cores where the first thread is offline.

Fix this by setting first-online-cpu-of-the-core's bit in the mask.
This is done by fixing this in the underlying function
cpu_thread_mask_to_cores.

Signed-off-by: Shreyas B. Prabhu <shreyas@linux.vnet.ibm.com>
---
This patch is new in v3

In an example scenario where all the threads of 1st core are offline
and argument to cpu_thread_mask_to_cores is cpu_possible_mask,
with this implementation, return value will not have any bit
corresponding to 1st core set. I think that should be okay. Any thoughts?

 arch/powerpc/include/asm/cputhreads.h | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/arch/powerpc/include/asm/cputhreads.h b/arch/powerpc/include/asm/cputhreads.h
index 2bf8e93..9e8485c 100644
--- a/arch/powerpc/include/asm/cputhreads.h
+++ b/arch/powerpc/include/asm/cputhreads.h
@@ -31,9 +31,9 @@ extern cpumask_t threads_core_mask;
 /* cpu_thread_mask_to_cores - Return a cpumask of one per cores
  *                            hit by the argument
  *
- * @threads:	a cpumask of threads
+ * @threads:	a cpumask of online threads
  *
- * This function returns a cpumask which will have one "cpu" (or thread)
+ * This function returns a cpumask which will have one online cpu's
  * bit set for each core that has at least one thread set in the argument.
  *
  * This can typically be used for things like IPI for tlb invalidations
@@ -42,13 +42,16 @@ extern cpumask_t threads_core_mask;
 static inline cpumask_t cpu_thread_mask_to_cores(const struct cpumask *threads)
 {
 	cpumask_t	tmp, res;
-	int		i;
+	int		i, cpu;
 
 	cpumask_clear(&res);
 	for (i = 0; i < NR_CPUS; i += threads_per_core) {
 		cpumask_shift_left(&tmp, &threads_core_mask, i);
-		if (cpumask_intersects(threads, &tmp))
-			cpumask_set_cpu(i, &res);
+		if (cpumask_intersects(threads, &tmp)) {
+			cpu = cpumask_next_and(-1, &tmp, cpu_online_mask);
+			if (cpu < nr_cpu_ids)
+				cpumask_set_cpu(cpu, &res);
+		}
 	}
 	return res;
 }
-- 
1.9.3

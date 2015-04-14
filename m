Return-Path: <shreyas@linux.vnet.ibm.com>
Received: from e37.co.us.ibm.com (e37.co.us.ibm.com [32.97.110.158])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id E2BE61A0ABD
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Apr 2015 11:58:02 +1000 (AEST)
Received: from /spool/local
 by e37.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <shreyas@linux.vnet.ibm.com>;
 Mon, 13 Apr 2015 19:58:00 -0600
Received: from b03cxnp08028.gho.boulder.ibm.com
 (b03cxnp08028.gho.boulder.ibm.com [9.17.130.20])
 by d03dlp03.boulder.ibm.com (Postfix) with ESMTP id 4702619D803E
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 13 Apr 2015 19:49:03 -0600 (MDT)
Received: from d03av05.boulder.ibm.com (d03av05.boulder.ibm.com [9.17.195.85])
 by b03cxnp08028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with
 ESMTP id t3E1vgg427066498
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 13 Apr 2015 18:57:42 -0700
Received: from d03av05.boulder.ibm.com (localhost [127.0.0.1])
 by d03av05.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t3E1vv9V030267
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 13 Apr 2015 19:57:57 -0600
From: "Shreyas B. Prabhu" <shreyas@linux.vnet.ibm.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH v4 1/3] powerpc: Fix cpu_online_cores_map to return only
 online threads mask
Date: Tue, 14 Apr 2015 07:26:51 +0530
Message-Id: <1428976613-13007-2-git-send-email-shreyas@linux.vnet.ibm.com>
In-Reply-To: <1428976613-13007-1-git-send-email-shreyas@linux.vnet.ibm.com>
References: <1428976613-13007-1-git-send-email-shreyas@linux.vnet.ibm.com>
Cc: preeti@linux.vnet.ibm.com, "Shreyas B. Prabhu" <shreyas@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Currently, cpu_online_cores_map returns a mask, which for every core with
at least one online thread, has the bit for thread 0 of the core set to 1,
and the bits for all other threads of the core set to 0. But thread 0 of
the core itself may not be online always. In such cases, if the returned
mask is used for IPI, then it'll cause IPIs to be skipped on cores where
the first thread is offline, because the IPI code refuses to send IPIs to
offline threads.

Fix this by setting the bit of the first online thread in the core.
This is done by fixing this in the underlying function
cpu_thread_mask_to_cores.

The result has the property that for all cores with online threads, there
is one bit set in the returned map. And further, all bits that are set in
the returned map correspond to online threads.

Signed-off-by: Shreyas B. Prabhu <shreyas@linux.vnet.ibm.com>
Reviewed-by: Preeti U Murthy <preeti@linux.vnet.ibm.com>
[ Changelog from Michael Ellerman <mpe@ellerman.id.au> ]
---
 arch/powerpc/include/asm/cputhreads.h | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/arch/powerpc/include/asm/cputhreads.h b/arch/powerpc/include/asm/cputhreads.h
index 4c8ad59..1076d3f 100644
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

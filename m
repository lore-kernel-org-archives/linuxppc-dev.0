Return-Path: <benh@ozlabs.org>
To: Paul Mackerras <paulus@samba.org>
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Fri, 22 Feb 2008 14:26:43 +1100
Subject: [PATCH] [POWERPC] Fix thinko in cpu_thread_mask_to_cores()
Message-Id: <20080222032708.689FFDDE08@ozlabs.org>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

The function cpu_thread_mask_to_cores() which returns a cpumask
of one and only one thread enabled for a given core has a bug
as it's shifting things in the wrong direction.

Note: The implementation is still sub-optimal in the sense that
for a given core, the thread set in the result may not be any of
the threads set in the input, which can lead to more IPIs then
strictly necessary, but it isn't incorrect per-se. I'll improve
that later.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---

 include/asm-powerpc/cputhreads.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- linux-work.orig/include/asm-powerpc/cputhreads.h	2008-02-22 14:22:34.000000000 +1100
+++ linux-work/include/asm-powerpc/cputhreads.h	2008-02-22 14:22:39.000000000 +1100
@@ -35,7 +35,7 @@ static inline cpumask_t cpu_thread_mask_
 
 	res = CPU_MASK_NONE;
 	for (i = 0; i < NR_CPUS; i += threads_per_core) {
-		cpus_shift_right(tmp, threads_core_mask, i);
+		cpus_shift_left(tmp, threads_core_mask, i);
 		if (cpus_intersects(threads, tmp))
 			cpu_set(i, res);
 	}

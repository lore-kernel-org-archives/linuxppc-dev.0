Return-Path: <hugh_dickins@symantec.com>
Received: from extu-mxob-2.symantec.com (extu-mxob-2.symantec.com
	[216.10.194.135])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "extu-mxob-2.symantec.com",
	Issuer "VeriSign Trust Network" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 10AC4DE02B
	for <linuxppc-dev@ozlabs.org>; Sat, 19 May 2007 02:47:27 +1000 (EST)
Date: Fri, 18 May 2007 17:47:01 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
To: Paul Mackerras <paulus@samba.org>
Subject: [PATCH] powerpc: smp_call_function might switch cpu
Message-ID: <Pine.LNX.4.64.0705181741380.30417@blonde.wat.veritas.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

smp_call_function_map() was not safe against preemption to another
cpu: its test for removing self from map was outside the spinlock.
Rearrange it a little to fix that.

smp_call_function_single() was also wrong: now get_cpu() before
excluding self, as other architectures do.

Signed-off-by: Hugh Dickins <hugh@veritas.com>
---
I guess most callers actually have preemption disabled already: I only
noticed this for the first time in 2.6.22-rc1-mm1, where mm/page_alloc.c
has a drain_all_local_pages(), which triggered a warning with my PowerPC
DEBUG_PREEMPT patch.

 arch/powerpc/kernel/smp.c |   34 ++++++++++++++++++----------------
 1 file changed, 18 insertions(+), 16 deletions(-)

--- 2.6.22-rc1-git7/arch/powerpc/kernel/smp.c	2007-05-13 05:40:52.000000000 +0100
+++ linux/arch/powerpc/kernel/smp.c	2007-05-18 17:07:51.000000000 +0100
@@ -201,13 +201,6 @@ int smp_call_function_map(void (*func) (
 	/* Can deadlock when called with interrupts disabled */
 	WARN_ON(irqs_disabled());
 
-	/* remove 'self' from the map */
-	if (cpu_isset(smp_processor_id(), map))
-		cpu_clear(smp_processor_id(), map);
-
-	/* sanity check the map, remove any non-online processors. */
-	cpus_and(map, map, cpu_online_map);
-
 	if (unlikely(smp_ops == NULL))
 		return ret;
 
@@ -222,10 +215,17 @@ int smp_call_function_map(void (*func) (
 	/* Must grab online cpu count with preempt disabled, otherwise
 	 * it can change. */
 	num_cpus = num_online_cpus() - 1;
-	if (!num_cpus || cpus_empty(map)) {
-		ret = 0;
-		goto out;
-	}
+	if (!num_cpus)
+		goto done;
+
+	/* remove 'self' from the map */
+	if (cpu_isset(smp_processor_id(), map))
+		cpu_clear(smp_processor_id(), map);
+
+	/* sanity check the map, remove any non-online processors. */
+	cpus_and(map, map, cpu_online_map);
+	if (cpus_empty(map))
+		goto done;
 
 	call_data = &data;
 	smp_wmb();
@@ -263,6 +263,7 @@ int smp_call_function_map(void (*func) (
 		}
 	}
 
+ done:
 	ret = 0;
 
  out:
@@ -282,16 +283,17 @@ EXPORT_SYMBOL(smp_call_function);
 int smp_call_function_single(int cpu, void (*func) (void *info), void *info, int nonatomic,
 			int wait)
 {
-	cpumask_t map=CPU_MASK_NONE;
+	cpumask_t map = CPU_MASK_NONE;
+	int ret = -EBUSY;
 
 	if (!cpu_online(cpu))
 		return -EINVAL;
 
-	if (cpu == smp_processor_id())
-		return -EBUSY;
-
 	cpu_set(cpu, map);
-	return smp_call_function_map(func,info,nonatomic,wait,map);
+	if (cpu != get_cpu())
+		ret = smp_call_function_map(func,info,nonatomic,wait,map);
+	put_cpu();
+	return ret;
 }
 EXPORT_SYMBOL(smp_call_function_single);
 

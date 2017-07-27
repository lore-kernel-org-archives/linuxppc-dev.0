Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xJCNh0r8WzDrG0
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 27 Jul 2017 23:23:48 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: linuxppc-dev@ozlabs.org
Cc: tglx@linutronix.de
Subject: [PATCH] powerpc/smp: Call smp_ops->setup_cpu() directly on the boot
 CPU
Date: Thu, 27 Jul 2017 23:23:37 +1000
Message-Id: <1501161817-4654-1-git-send-email-mpe@ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

In smp_cpus_done() we need to call smp_ops->setup_cpu() for the boot
CPU, which means it has to run *on* the boot CPU.

In the past we ensured it ran on the boot CPU by changing the CPU
affinity mask of current directly. That was removed in commit
6d11b87d55eb ("powerpc/smp: Replace open coded task affinity logic"),
and replaced with a work queue call.

Unfortunately using a work queue leads to a lockdep warning, now that
the CPU hotplug lock is a regular semaphore:

  ======================================================
  WARNING: possible circular locking dependency detected
  ...
  kworker/0:1/971 is trying to acquire lock:
   (cpu_hotplug_lock.rw_sem){++++++}, at: [<c000000000100974>] apply_workqueue_attrs+0x34/0xa0

  but task is already holding lock:
   ((&wfc.work)){+.+.+.}, at: [<c0000000000fdb2c>] process_one_work+0x25c/0x800
  ...
       CPU0                    CPU1
       ----                    ----
  lock((&wfc.work));
                               lock(cpu_hotplug_lock.rw_sem);
                               lock((&wfc.work));
  lock(cpu_hotplug_lock.rw_sem);

Although the deadlock can't happen in practice, because
smp_cpus_done() only runs in early boot before CPU hotplug is allowed,
lockdep can't tell that.

Luckily in commit 8fb12156b8db ("init: Pin init task to the boot CPU,
initially") tglx changed the generic code to pin init to the boot CPU
to begin with. The unpinning of init from the boot CPU happens in
sched_init_smp(), which is called after smp_cpus_done().

So smp_cpus_done() is always called on the boot CPU, which means we
don't need the work queue call at all - and the lockdep warning goes
away.

Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/kernel/smp.c | 12 ++----------
 1 file changed, 2 insertions(+), 10 deletions(-)

diff --git a/arch/powerpc/kernel/smp.c b/arch/powerpc/kernel/smp.c
index 997c88d54acf..cf0e1245b8cc 100644
--- a/arch/powerpc/kernel/smp.c
+++ b/arch/powerpc/kernel/smp.c
@@ -1003,21 +1003,13 @@ static struct sched_domain_topology_level powerpc_topology[] = {
 	{ NULL, },
 };
 
-static __init long smp_setup_cpu_workfn(void *data __always_unused)
-{
-	smp_ops->setup_cpu(boot_cpuid);
-	return 0;
-}
-
 void __init smp_cpus_done(unsigned int max_cpus)
 {
 	/*
-	 * We want the setup_cpu() here to be called on the boot CPU, but
-	 * init might run on any CPU, so make sure it's invoked on the boot
-	 * CPU.
+	 * We are running pinned to the boot CPU, see rest_init().
 	 */
 	if (smp_ops && smp_ops->setup_cpu)
-		work_on_cpu_safe(boot_cpuid, smp_setup_cpu_workfn, NULL);
+		smp_ops->setup_cpu(boot_cpuid);
 
 	if (smp_ops && smp_ops->bringup_done)
 		smp_ops->bringup_done();
-- 
2.7.4

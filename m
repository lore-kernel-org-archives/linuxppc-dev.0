Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id EC4BA1A0D1F
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 Feb 2015 17:58:27 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: <linuxppc-dev@ozlabs.org>
Subject: [PATCH] powerpc/smp: Wait until secondaries are active & online
Date: Tue, 24 Feb 2015 17:58:02 +1100
Message-Id: <1424761082-29938-1-git-send-email-mpe@ellerman.id.au>
Cc: mingo@kernel.org, tglx@linutronix.de, Anton Blanchard <anton@samba.org>,
 linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Anton has a busy ppc64le KVM box where guests sometimes hit the infamous
"kernel BUG at kernel/smpboot.c:134!" issue during boot:

  BUG_ON(td->cpu != smp_processor_id());

Basically a per CPU hotplug thread scheduled on the wrong CPU. The oops
output confirms it:

  CPU: 0
  Comm: watchdog/130

The problem is that we aren't ensuring the CPU active bit is set for the
secondary before allowing the master to continue on. The master unparks
the secondary CPU's kthreads and the scheduler looks for a CPU to run
on. It calls select_task_rq() and realises the suggested CPU is not in
the cpus_allowed mask. It then ends up in select_fallback_rq(), and
since the active bit isnt't set we choose some other CPU to run on.

This seems to have been introduced by 6acbfb96976f "sched: Fix hotplug
vs. set_cpus_allowed_ptr()", which changed from setting active before
online to setting active after online. However that was in turn fixing a
bug where other code assumed an active CPU was also online, so we can't
just revert that fix.

The simplest fix is just to spin waiting for both active & online to be
set. We already have a barrier prior to set_cpu_online() (which also
sets active), to ensure all other setup is completed before online &
active are set.

Fixes: 6acbfb96976f ("sched: Fix hotplug vs. set_cpus_allowed_ptr()")
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Signed-off-by: Anton Blanchard <anton@samba.org>
---
 arch/powerpc/kernel/smp.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/kernel/smp.c b/arch/powerpc/kernel/smp.c
index 6e19afa35a15..ec9ec2058d2d 100644
--- a/arch/powerpc/kernel/smp.c
+++ b/arch/powerpc/kernel/smp.c
@@ -541,8 +541,8 @@ int __cpu_up(unsigned int cpu, struct task_struct *tidle)
 	if (smp_ops->give_timebase)
 		smp_ops->give_timebase();
 
-	/* Wait until cpu puts itself in the online map */
-	while (!cpu_online(cpu))
+	/* Wait until cpu puts itself in the online & active maps */
+	while (!cpu_online(cpu) || !cpu_active(cpu))
 		cpu_relax();
 
 	return 0;
-- 
2.1.0

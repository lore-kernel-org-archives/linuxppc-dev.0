Return-Path: <tglx@linutronix.de>
Received: from Galois.linutronix.de (Galois.linutronix.de
 [IPv6:2a01:7a0:2:106d:700::1])
 (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3w3Ffb2F4wzDq7Z
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 13 Apr 2017 06:20:39 +1000 (AEST)
Message-Id: <20170412201042.518053336@linutronix.de>
Date: Wed, 12 Apr 2017 22:07:31 +0200
From: Thomas Gleixner <tglx@linutronix.de>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>,
 Sebastian Siewior <bigeasy@linutronix.de>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 "David S. Miller" <davem@davemloft.net>, Fenghua Yu <fenghua.yu@intel.com>,
 Herbert Xu <herbert@gondor.apana.org.au>,
 Lai Jiangshan <jiangshanlai@gmail.com>, Len Brown <lenb@kernel.org>,
 Michael Ellerman <mpe@ellerman.id.au>,
 "Rafael J. Wysocki" <rjw@rjwysocki.net>, Tejun Heo <tj@kernel.org>,
 Tony Luck <tony.luck@intel.com>, Viresh Kumar <viresh.kumar@linaro.org>,
 Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org
Subject: [patch 05/13] powerpc/smp: Replace open coded task affinity logic
References: <20170412200726.941336635@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Init task invokes smp_ops->setup_cpu() from smp_cpus_done(). Init task can
run on any online CPU at this point, but the setup_cpu() callback requires
to be invoked on the boot CPU. This is achieved by temporarily setting the
affinity of the calling user space thread to the requested CPU and reset it
to the original affinity afterwards.

That's racy vs. CPU hotplug and concurrent affinity settings for that
thread resulting in code executing on the wrong CPU and overwriting the
new affinity setting.

That's actually not a problem in this context as neither CPU hotplug nor
affinity settings can happen, but the access to task_struct::cpus_allowed
is about to restricted.

Replace it with a call to work_on_cpu_safe() which achieves the same result.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Paul Mackerras <paulus@samba.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: linuxppc-dev@lists.ozlabs.org
---
 arch/powerpc/kernel/smp.c |   26 +++++++++++---------------
 1 file changed, 11 insertions(+), 15 deletions(-)

--- a/arch/powerpc/kernel/smp.c
+++ b/arch/powerpc/kernel/smp.c
@@ -787,24 +787,21 @@ static struct sched_domain_topology_leve
 	{ NULL, },
 };
 
-void __init smp_cpus_done(unsigned int max_cpus)
+static __init long smp_setup_cpu_workfn(void *data __always_unused)
 {
-	cpumask_var_t old_mask;
+	smp_ops->setup_cpu(boot_cpuid);
+	return 0;
+}
 
-	/* We want the setup_cpu() here to be called from CPU 0, but our
-	 * init thread may have been "borrowed" by another CPU in the meantime
-	 * se we pin us down to CPU 0 for a short while
+void __init smp_cpus_done(unsigned int max_cpus)
+{
+	/*
+	 * We want the setup_cpu() here to be called on the boot CPU, but
+	 * init might run on any CPU, so make sure it's invoked on the boot
+	 * CPU.
 	 */
-	alloc_cpumask_var(&old_mask, GFP_NOWAIT);
-	cpumask_copy(old_mask, &current->cpus_allowed);
-	set_cpus_allowed_ptr(current, cpumask_of(boot_cpuid));
-	
 	if (smp_ops && smp_ops->setup_cpu)
-		smp_ops->setup_cpu(boot_cpuid);
-
-	set_cpus_allowed_ptr(current, old_mask);
-
-	free_cpumask_var(old_mask);
+		work_on_cpu_safe(boot_cpuid, smp_setup_cpu_workfn, NULL);
 
 	if (smp_ops && smp_ops->bringup_done)
 		smp_ops->bringup_done();
@@ -812,7 +809,6 @@ void __init smp_cpus_done(unsigned int m
 	dump_numa_cpu_topology();
 
 	set_sched_topology(powerpc_topology);
-
 }
 
 #ifdef CONFIG_HOTPLUG_CPU

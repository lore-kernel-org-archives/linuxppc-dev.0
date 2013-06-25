Return-Path: <srivatsa.bhat@linux.vnet.ibm.com>
Received: from e28smtp01.in.ibm.com (e28smtp01.in.ibm.com [122.248.162.1])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e28smtp01.in.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id BE9762C02ED
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 26 Jun 2013 06:30:26 +1000 (EST)
Received: from /spool/local
 by e28smtp01.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <srivatsa.bhat@linux.vnet.ibm.com>;
 Wed, 26 Jun 2013 01:53:26 +0530
Received: from d28relay02.in.ibm.com (d28relay02.in.ibm.com [9.184.220.59])
 by d28dlp02.in.ibm.com (Postfix) with ESMTP id 137103940053
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 26 Jun 2013 02:00:21 +0530 (IST)
Received: from d28av05.in.ibm.com (d28av05.in.ibm.com [9.184.220.67])
 by d28relay02.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r5PKUd7p27066568
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 26 Jun 2013 02:00:39 +0530
Received: from d28av05.in.ibm.com (loopback [127.0.0.1])
 by d28av05.in.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r5PKUInB021337
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 26 Jun 2013 06:30:20 +1000
From: "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>
Subject: [PATCH v2 09/45] smp: Use get/put_online_cpus_atomic() to prevent CPU
 offline
To: tglx@linutronix.de, peterz@infradead.org, tj@kernel.org, oleg@redhat.com,
 paulmck@linux.vnet.ibm.com, rusty@rustcorp.com.au, mingo@kernel.org,
 akpm@linux-foundation.org, namhyung@kernel.org, walken@google.com,
 vincent.guittot@linaro.org, laijs@cn.fujitsu.com
Date: Wed, 26 Jun 2013 01:57:02 +0530
Message-ID: <20130625202702.16593.51562.stgit@srivatsabhat.in.ibm.com>
In-Reply-To: <20130625202452.16593.22810.stgit@srivatsabhat.in.ibm.com>
References: <20130625202452.16593.22810.stgit@srivatsabhat.in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Cc: linux-arch@vger.kernel.org, nikunj@linux.vnet.ibm.com,
 zhong@linux.vnet.ibm.com, linux-pm@vger.kernel.org, fweisbec@gmail.com,
 Shaohua Li <shli@fusionio.com>, linux-kernel@vger.kernel.org,
 rostedt@goodmis.org, xiaoguangrong@linux.vnet.ibm.com, sbw@mit.edu,
 Jan Beulich <jbeulich@suse.com>, wangyun@linux.vnet.ibm.com,
 "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>, netdev@vger.kernel.org,
 Andrew Morton <akpm@linux-foundation.org>, linuxppc-dev@lists.ozlabs.org,
 liguang <lig.fnst@cn.fujitsu.com>, Wang YanQing <udknight@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Once stop_machine() is gone from the CPU offline path, we won't be able
to depend on disabling preemption to prevent CPUs from going offline
from under us.

Use the get/put_online_cpus_atomic() APIs to prevent CPUs from going
offline, while invoking from atomic context.

Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Wang YanQing <udknight@gmail.com>
Cc: Shaohua Li <shli@fusionio.com>
Cc: Jan Beulich <jbeulich@suse.com>
Cc: liguang <lig.fnst@cn.fujitsu.com>
Signed-off-by: Srivatsa S. Bhat <srivatsa.bhat@linux.vnet.ibm.com>
---

 kernel/smp.c |   52 ++++++++++++++++++++++++++++++----------------------
 1 file changed, 30 insertions(+), 22 deletions(-)

diff --git a/kernel/smp.c b/kernel/smp.c
index 4dba0f7..1f36d6d 100644
--- a/kernel/smp.c
+++ b/kernel/smp.c
@@ -232,7 +232,7 @@ int smp_call_function_single(int cpu, smp_call_func_t func, void *info,
 	 * prevent preemption and reschedule on another processor,
 	 * as well as CPU removal
 	 */
-	this_cpu = get_cpu();
+	this_cpu = get_online_cpus_atomic();
 
 	/*
 	 * Can deadlock when called with interrupts disabled.
@@ -264,7 +264,7 @@ int smp_call_function_single(int cpu, smp_call_func_t func, void *info,
 		}
 	}
 
-	put_cpu();
+	put_online_cpus_atomic();
 
 	return err;
 }
@@ -294,7 +294,7 @@ int smp_call_function_any(const struct cpumask *mask,
 	int ret;
 
 	/* Try for same CPU (cheapest) */
-	cpu = get_cpu();
+	cpu = get_online_cpus_atomic();
 	if (cpumask_test_cpu(cpu, mask))
 		goto call;
 
@@ -310,7 +310,7 @@ int smp_call_function_any(const struct cpumask *mask,
 	cpu = cpumask_any_and(mask, cpu_online_mask);
 call:
 	ret = smp_call_function_single(cpu, func, info, wait);
-	put_cpu();
+	put_online_cpus_atomic();
 	return ret;
 }
 EXPORT_SYMBOL_GPL(smp_call_function_any);
@@ -331,7 +331,8 @@ void __smp_call_function_single(int cpu, struct call_single_data *csd,
 	unsigned int this_cpu;
 	unsigned long flags;
 
-	this_cpu = get_cpu();
+	this_cpu = get_online_cpus_atomic();
+
 	/*
 	 * Can deadlock when called with interrupts disabled.
 	 * We allow cpu's that are not yet online though, as no one else can
@@ -349,7 +350,8 @@ void __smp_call_function_single(int cpu, struct call_single_data *csd,
 		csd_lock(csd);
 		generic_exec_single(cpu, csd, wait);
 	}
-	put_cpu();
+
+	put_online_cpus_atomic();
 }
 
 /**
@@ -370,7 +372,9 @@ void smp_call_function_many(const struct cpumask *mask,
 			    smp_call_func_t func, void *info, bool wait)
 {
 	struct call_function_data *cfd;
-	int cpu, next_cpu, this_cpu = smp_processor_id();
+	int cpu, next_cpu, this_cpu;
+
+	this_cpu = get_online_cpus_atomic();
 
 	/*
 	 * Can deadlock when called with interrupts disabled.
@@ -388,7 +392,7 @@ void smp_call_function_many(const struct cpumask *mask,
 
 	/* No online cpus?  We're done. */
 	if (cpu >= nr_cpu_ids)
-		return;
+		goto out;
 
 	/* Do we have another CPU which isn't us? */
 	next_cpu = cpumask_next_and(cpu, mask, cpu_online_mask);
@@ -398,7 +402,7 @@ void smp_call_function_many(const struct cpumask *mask,
 	/* Fastpath: do that cpu by itself. */
 	if (next_cpu >= nr_cpu_ids) {
 		smp_call_function_single(cpu, func, info, wait);
-		return;
+		goto out;
 	}
 
 	cfd = &__get_cpu_var(cfd_data);
@@ -408,7 +412,7 @@ void smp_call_function_many(const struct cpumask *mask,
 
 	/* Some callers race with other cpus changing the passed mask */
 	if (unlikely(!cpumask_weight(cfd->cpumask)))
-		return;
+		goto out;
 
 	/*
 	 * After we put an entry into the list, cfd->cpumask may be cleared
@@ -443,6 +447,9 @@ void smp_call_function_many(const struct cpumask *mask,
 			csd_lock_wait(csd);
 		}
 	}
+
+out:
+	put_online_cpus_atomic();
 }
 EXPORT_SYMBOL(smp_call_function_many);
 
@@ -463,9 +470,9 @@ EXPORT_SYMBOL(smp_call_function_many);
  */
 int smp_call_function(smp_call_func_t func, void *info, int wait)
 {
-	preempt_disable();
+	get_online_cpus_atomic();
 	smp_call_function_many(cpu_online_mask, func, info, wait);
-	preempt_enable();
+	put_online_cpus_atomic();
 
 	return 0;
 }
@@ -565,12 +572,12 @@ int on_each_cpu(void (*func) (void *info), void *info, int wait)
 	unsigned long flags;
 	int ret = 0;
 
-	preempt_disable();
+	get_online_cpus_atomic();
 	ret = smp_call_function(func, info, wait);
 	local_irq_save(flags);
 	func(info);
 	local_irq_restore(flags);
-	preempt_enable();
+	put_online_cpus_atomic();
 	return ret;
 }
 EXPORT_SYMBOL(on_each_cpu);
@@ -592,7 +599,7 @@ EXPORT_SYMBOL(on_each_cpu);
 void on_each_cpu_mask(const struct cpumask *mask, smp_call_func_t func,
 			void *info, bool wait)
 {
-	int cpu = get_cpu();
+	unsigned int cpu = get_online_cpus_atomic();
 
 	smp_call_function_many(mask, func, info, wait);
 	if (cpumask_test_cpu(cpu, mask)) {
@@ -600,7 +607,7 @@ void on_each_cpu_mask(const struct cpumask *mask, smp_call_func_t func,
 		func(info);
 		local_irq_enable();
 	}
-	put_cpu();
+	put_online_cpus_atomic();
 }
 EXPORT_SYMBOL(on_each_cpu_mask);
 
@@ -625,8 +632,9 @@ EXPORT_SYMBOL(on_each_cpu_mask);
  * The function might sleep if the GFP flags indicates a non
  * atomic allocation is allowed.
  *
- * Preemption is disabled to protect against CPUs going offline but not online.
- * CPUs going online during the call will not be seen or sent an IPI.
+ * We use get/put_online_cpus_atomic() to protect against CPUs going
+ * offline but not online. CPUs going online during the call will
+ * not be seen or sent an IPI.
  *
  * You must not call this function with disabled interrupts or
  * from a hardware interrupt handler or from a bottom half handler.
@@ -641,26 +649,26 @@ void on_each_cpu_cond(bool (*cond_func)(int cpu, void *info),
 	might_sleep_if(gfp_flags & __GFP_WAIT);
 
 	if (likely(zalloc_cpumask_var(&cpus, (gfp_flags|__GFP_NOWARN)))) {
-		preempt_disable();
+		get_online_cpus_atomic();
 		for_each_online_cpu(cpu)
 			if (cond_func(cpu, info))
 				cpumask_set_cpu(cpu, cpus);
 		on_each_cpu_mask(cpus, func, info, wait);
-		preempt_enable();
+		put_online_cpus_atomic();
 		free_cpumask_var(cpus);
 	} else {
 		/*
 		 * No free cpumask, bother. No matter, we'll
 		 * just have to IPI them one by one.
 		 */
-		preempt_disable();
+		get_online_cpus_atomic();
 		for_each_online_cpu(cpu)
 			if (cond_func(cpu, info)) {
 				ret = smp_call_function_single(cpu, func,
 								info, wait);
 				WARN_ON_ONCE(!ret);
 			}
-		preempt_enable();
+		put_online_cpus_atomic();
 	}
 }
 EXPORT_SYMBOL(on_each_cpu_cond);

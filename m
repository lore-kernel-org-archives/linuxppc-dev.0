Return-Path: <srivatsa.bhat@linux.vnet.ibm.com>
Received: from e23smtp08.au.ibm.com (e23smtp08.au.ibm.com [202.81.31.141])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e23smtp08.au.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 4BBBB2C0336
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 18 Feb 2013 23:45:02 +1100 (EST)
Received: from /spool/local
 by e23smtp08.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <srivatsa.bhat@linux.vnet.ibm.com>;
 Mon, 18 Feb 2013 22:43:16 +1000
Received: from d23relay05.au.ibm.com (d23relay05.au.ibm.com [9.190.235.152])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id 226E42BB0050
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 18 Feb 2013 23:44:59 +1100 (EST)
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay05.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r1ICWWOS64290996
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 18 Feb 2013 23:32:32 +1100
Received: from d23av04.au.ibm.com (loopback [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r1ICiu0G018923
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 18 Feb 2013 23:44:58 +1100
From: "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>
Subject: [PATCH v6 33/46] cris/smp: Use get/put_online_cpus_atomic() to
 prevent CPU offline
To: tglx@linutronix.de, peterz@infradead.org, tj@kernel.org, oleg@redhat.com,
 paulmck@linux.vnet.ibm.com, rusty@rustcorp.com.au, mingo@kernel.org,
 akpm@linux-foundation.org, namhyung@kernel.org
Date: Mon, 18 Feb 2013 18:12:54 +0530
Message-ID: <20130218124254.26245.4577.stgit@srivatsabhat.in.ibm.com>
In-Reply-To: <20130218123714.26245.61816.stgit@srivatsabhat.in.ibm.com>
References: <20130218123714.26245.61816.stgit@srivatsabhat.in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Cc: linux-arch@vger.kernel.org, linux@arm.linux.org.uk,
 nikunj@linux.vnet.ibm.com, linux-pm@vger.kernel.org, fweisbec@gmail.com,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, rostedt@goodmis.org,
 xiaoguangrong@linux.vnet.ibm.com, rjw@sisk.pl, sbw@mit.edu,
 wangyun@linux.vnet.ibm.com, srivatsa.bhat@linux.vnet.ibm.com,
 netdev@vger.kernel.org, vincent.guittot@linaro.org, walken@google.com,
 linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Once stop_machine() is gone from the CPU offline path, we won't be able to
depend on preempt_disable() or local_irq_disable() to prevent CPUs from
going offline from under us.

Use the get/put_online_cpus_atomic() APIs to prevent CPUs from going offline,
while invoking from atomic context.

Cc: Mikael Starvik <starvik@axis.com>
Cc: Jesper Nilsson <jesper.nilsson@axis.com>
Cc: linux-cris-kernel@axis.com
Signed-off-by: Srivatsa S. Bhat <srivatsa.bhat@linux.vnet.ibm.com>
---

 arch/cris/arch-v32/kernel/smp.c |    8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/cris/arch-v32/kernel/smp.c b/arch/cris/arch-v32/kernel/smp.c
index 04a16ed..644b358 100644
--- a/arch/cris/arch-v32/kernel/smp.c
+++ b/arch/cris/arch-v32/kernel/smp.c
@@ -15,6 +15,7 @@
 #include <linux/sched.h>
 #include <linux/kernel.h>
 #include <linux/cpumask.h>
+#include <linux/cpu.h>
 #include <linux/interrupt.h>
 #include <linux/module.h>
 
@@ -208,9 +209,12 @@ int __cpuinit __cpu_up(unsigned int cpu, struct task_struct *tidle)
 void smp_send_reschedule(int cpu)
 {
 	cpumask_t cpu_mask;
+
+	get_online_cpus_atomic();
 	cpumask_clear(&cpu_mask);
 	cpumask_set_cpu(cpu, &cpu_mask);
 	send_ipi(IPI_SCHEDULE, 0, cpu_mask);
+	put_online_cpus_atomic();
 }
 
 /* TLB flushing
@@ -224,6 +228,7 @@ void flush_tlb_common(struct mm_struct* mm, struct vm_area_struct* vma, unsigned
 	unsigned long flags;
 	cpumask_t cpu_mask;
 
+	get_online_cpus_atomic();
 	spin_lock_irqsave(&tlbstate_lock, flags);
 	cpu_mask = (mm == FLUSH_ALL ? cpu_all_mask : *mm_cpumask(mm));
 	cpumask_clear_cpu(smp_processor_id(), &cpu_mask);
@@ -232,6 +237,7 @@ void flush_tlb_common(struct mm_struct* mm, struct vm_area_struct* vma, unsigned
 	flush_addr = addr;
 	send_ipi(IPI_FLUSH_TLB, 1, cpu_mask);
 	spin_unlock_irqrestore(&tlbstate_lock, flags);
+	put_online_cpus_atomic();
 }
 
 void flush_tlb_all(void)
@@ -312,6 +318,7 @@ int smp_call_function(void (*func)(void *info), void *info, int wait)
 	struct call_data_struct data;
 	int ret;
 
+	get_online_cpus_atomic();
 	cpumask_setall(&cpu_mask);
 	cpumask_clear_cpu(smp_processor_id(), &cpu_mask);
 
@@ -325,6 +332,7 @@ int smp_call_function(void (*func)(void *info), void *info, int wait)
 	call_data = &data;
 	ret = send_ipi(IPI_CALL, wait, cpu_mask);
 	spin_unlock(&call_lock);
+	put_online_cpus_atomic();
 
 	return ret;
 }

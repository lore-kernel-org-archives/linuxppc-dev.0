Return-Path: <srivatsa.bhat@linux.vnet.ibm.com>
Received: from e28smtp08.in.ibm.com (e28smtp08.in.ibm.com [122.248.162.8])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e28smtp08.in.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id E80742C0D9B
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 23 Jun 2013 23:47:06 +1000 (EST)
Received: from /spool/local
 by e28smtp08.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <srivatsa.bhat@linux.vnet.ibm.com>;
 Sun, 23 Jun 2013 19:08:30 +0530
Received: from d28relay05.in.ibm.com (d28relay05.in.ibm.com [9.184.220.62])
 by d28dlp01.in.ibm.com (Postfix) with ESMTP id EF62AE0057
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 23 Jun 2013 19:16:28 +0530 (IST)
Received: from d28av02.in.ibm.com (d28av02.in.ibm.com [9.184.220.64])
 by d28relay05.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r5NDktdb27263160
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 23 Jun 2013 19:16:55 +0530
Received: from d28av02.in.ibm.com (loopback [127.0.0.1])
 by d28av02.in.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r5NDkvTc008380
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 23 Jun 2013 23:46:59 +1000
From: "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>
Subject: [PATCH 26/45] x86: Use get/put_online_cpus_atomic() to prevent CPU
 offline
To: tglx@linutronix.de, peterz@infradead.org, tj@kernel.org, oleg@redhat.com,
 paulmck@linux.vnet.ibm.com, rusty@rustcorp.com.au, mingo@kernel.org,
 akpm@linux-foundation.org, namhyung@kernel.org, walken@google.com,
 vincent.guittot@linaro.org, laijs@cn.fujitsu.com
Date: Sun, 23 Jun 2013 19:13:43 +0530
Message-ID: <20130623134340.19094.55514.stgit@srivatsabhat.in.ibm.com>
In-Reply-To: <20130623133642.19094.16038.stgit@srivatsabhat.in.ibm.com>
References: <20130623133642.19094.16038.stgit@srivatsabhat.in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Cc: fweisbec@gmail.com, Sebastian Andrzej Siewior <sebastian@breakpoint.cc>,
 Jan Beulich <jbeulich@suse.com>, "H. Peter Anvin" <hpa@zytor.com>,
 linux-arch@vger.kernel.org, Joonsoo Kim <js1304@gmail.com>,
 Joerg Roedel <joro@8bytes.org>, x86@kernel.org,
 xiaoguangrong@linux.vnet.ibm.com, Ingo Molnar <mingo@redhat.com>,
 wangyun@linux.vnet.ibm.com, nikunj@linux.vnet.ibm.com,
 linux-pm@vger.kernel.org, rostedt@goodmis.org,
 Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Borislav Petkov <bp@alien8.de>,
 Thomas Gleixner <tglx@linutronix.de>, linux-edac@vger.kernel.org,
 Tony Luck <tony.luck@intel.com>, zhong@linux.vnet.ibm.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, sbw@mit.edu,
 srivatsa.bhat@linux.vnet.ibm.com, linuxppc-dev@lists.ozlabs.org
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

Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: x86@kernel.org
Cc: Tony Luck <tony.luck@intel.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Cc: Sebastian Andrzej Siewior <sebastian@breakpoint.cc>
Cc: Joerg Roedel <joro@8bytes.org>
Cc: Jan Beulich <jbeulich@suse.com>
Cc: Joonsoo Kim <js1304@gmail.com>
Cc: linux-edac@vger.kernel.org
Signed-off-by: Srivatsa S. Bhat <srivatsa.bhat@linux.vnet.ibm.com>
---

 arch/x86/kernel/apic/io_apic.c           |   21 ++++++++++++++++++---
 arch/x86/kernel/cpu/mcheck/therm_throt.c |    4 ++--
 arch/x86/mm/tlb.c                        |   14 +++++++-------
 3 files changed, 27 insertions(+), 12 deletions(-)

diff --git a/arch/x86/kernel/apic/io_apic.c b/arch/x86/kernel/apic/io_apic.c
index 9ed796c..4c71c1e 100644
--- a/arch/x86/kernel/apic/io_apic.c
+++ b/arch/x86/kernel/apic/io_apic.c
@@ -25,6 +25,7 @@
 #include <linux/init.h>
 #include <linux/delay.h>
 #include <linux/sched.h>
+#include <linux/cpu.h>
 #include <linux/pci.h>
 #include <linux/mc146818rtc.h>
 #include <linux/compiler.h>
@@ -1169,9 +1170,11 @@ int assign_irq_vector(int irq, struct irq_cfg *cfg, const struct cpumask *mask)
 	int err;
 	unsigned long flags;
 
+	get_online_cpus_atomic();
 	raw_spin_lock_irqsave(&vector_lock, flags);
 	err = __assign_irq_vector(irq, cfg, mask);
 	raw_spin_unlock_irqrestore(&vector_lock, flags);
+	put_online_cpus_atomic();
 	return err;
 }
 
@@ -1757,13 +1760,13 @@ __apicdebuginit(void) print_local_APICs(int maxcpu)
 	if (!maxcpu)
 		return;
 
-	preempt_disable();
+	get_online_cpus_atomic();
 	for_each_online_cpu(cpu) {
 		if (cpu >= maxcpu)
 			break;
 		smp_call_function_single(cpu, print_local_APIC, NULL, 1);
 	}
-	preempt_enable();
+	put_online_cpus_atomic();
 }
 
 __apicdebuginit(void) print_PIC(void)
@@ -2153,10 +2156,12 @@ static int ioapic_retrigger_irq(struct irq_data *data)
 	unsigned long flags;
 	int cpu;
 
+	get_online_cpus_atomic();
 	raw_spin_lock_irqsave(&vector_lock, flags);
 	cpu = cpumask_first_and(cfg->domain, cpu_online_mask);
 	apic->send_IPI_mask(cpumask_of(cpu), cfg->vector);
 	raw_spin_unlock_irqrestore(&vector_lock, flags);
+	put_online_cpus_atomic();
 
 	return 1;
 }
@@ -2175,6 +2180,7 @@ void send_cleanup_vector(struct irq_cfg *cfg)
 {
 	cpumask_var_t cleanup_mask;
 
+	get_online_cpus_atomic();
 	if (unlikely(!alloc_cpumask_var(&cleanup_mask, GFP_ATOMIC))) {
 		unsigned int i;
 		for_each_cpu_and(i, cfg->old_domain, cpu_online_mask)
@@ -2185,6 +2191,7 @@ void send_cleanup_vector(struct irq_cfg *cfg)
 		free_cpumask_var(cleanup_mask);
 	}
 	cfg->move_in_progress = 0;
+	put_online_cpus_atomic();
 }
 
 asmlinkage void smp_irq_move_cleanup_interrupt(void)
@@ -2939,11 +2946,13 @@ unsigned int __create_irqs(unsigned int from, unsigned int count, int node)
 			goto out_irqs;
 	}
 
+	get_online_cpus_atomic();
 	raw_spin_lock_irqsave(&vector_lock, flags);
 	for (i = 0; i < count; i++)
 		if (__assign_irq_vector(irq + i, cfg[i], apic->target_cpus()))
 			goto out_vecs;
 	raw_spin_unlock_irqrestore(&vector_lock, flags);
+	put_online_cpus_atomic();
 
 	for (i = 0; i < count; i++) {
 		irq_set_chip_data(irq + i, cfg[i]);
@@ -2957,6 +2966,7 @@ out_vecs:
 	for (i--; i >= 0; i--)
 		__clear_irq_vector(irq + i, cfg[i]);
 	raw_spin_unlock_irqrestore(&vector_lock, flags);
+	put_online_cpus_atomic();
 out_irqs:
 	for (i = 0; i < count; i++)
 		free_irq_at(irq + i, cfg[i]);
@@ -2994,9 +3004,11 @@ void destroy_irq(unsigned int irq)
 
 	free_remapped_irq(irq);
 
+	get_online_cpus_atomic();
 	raw_spin_lock_irqsave(&vector_lock, flags);
 	__clear_irq_vector(irq, cfg);
 	raw_spin_unlock_irqrestore(&vector_lock, flags);
+	put_online_cpus_atomic();
 	free_irq_at(irq, cfg);
 }
 
@@ -3365,8 +3377,11 @@ io_apic_setup_irq_pin(unsigned int irq, int node, struct io_apic_irq_attr *attr)
 	if (!cfg)
 		return -EINVAL;
 	ret = __add_pin_to_irq_node(cfg, node, attr->ioapic, attr->ioapic_pin);
-	if (!ret)
+	if (!ret) {
+		get_online_cpus_atomic();
 		setup_ioapic_irq(irq, cfg, attr);
+		put_online_cpus_atomic();
+	}
 	return ret;
 }
 
diff --git a/arch/x86/kernel/cpu/mcheck/therm_throt.c b/arch/x86/kernel/cpu/mcheck/therm_throt.c
index 47a1870..d128ba4 100644
--- a/arch/x86/kernel/cpu/mcheck/therm_throt.c
+++ b/arch/x86/kernel/cpu/mcheck/therm_throt.c
@@ -82,13 +82,13 @@ static ssize_t therm_throt_device_show_##event##_##name(		\
 	unsigned int cpu = dev->id;					\
 	ssize_t ret;							\
 									\
-	preempt_disable();	/* CPU hotplug */			\
+	get_online_cpus_atomic();	/* CPU hotplug */		\
 	if (cpu_online(cpu)) {						\
 		ret = sprintf(buf, "%lu\n",				\
 			      per_cpu(thermal_state, cpu).event.name);	\
 	} else								\
 		ret = 0;						\
-	preempt_enable();						\
+	put_online_cpus_atomic();					\
 									\
 	return ret;							\
 }
diff --git a/arch/x86/mm/tlb.c b/arch/x86/mm/tlb.c
index 282375f..8126374 100644
--- a/arch/x86/mm/tlb.c
+++ b/arch/x86/mm/tlb.c
@@ -147,12 +147,12 @@ void flush_tlb_current_task(void)
 {
 	struct mm_struct *mm = current->mm;
 
-	preempt_disable();
+	get_online_cpus_atomic();
 
 	local_flush_tlb();
 	if (cpumask_any_but(mm_cpumask(mm), smp_processor_id()) < nr_cpu_ids)
 		flush_tlb_others(mm_cpumask(mm), mm, 0UL, TLB_FLUSH_ALL);
-	preempt_enable();
+	put_online_cpus_atomic();
 }
 
 /*
@@ -187,7 +187,7 @@ void flush_tlb_mm_range(struct mm_struct *mm, unsigned long start,
 	unsigned long addr;
 	unsigned act_entries, tlb_entries = 0;
 
-	preempt_disable();
+	get_online_cpus_atomic();
 	if (current->active_mm != mm)
 		goto flush_all;
 
@@ -225,21 +225,21 @@ void flush_tlb_mm_range(struct mm_struct *mm, unsigned long start,
 		if (cpumask_any_but(mm_cpumask(mm),
 				smp_processor_id()) < nr_cpu_ids)
 			flush_tlb_others(mm_cpumask(mm), mm, start, end);
-		preempt_enable();
+		put_online_cpus_atomic();
 		return;
 	}
 
 flush_all:
 	if (cpumask_any_but(mm_cpumask(mm), smp_processor_id()) < nr_cpu_ids)
 		flush_tlb_others(mm_cpumask(mm), mm, 0UL, TLB_FLUSH_ALL);
-	preempt_enable();
+	put_online_cpus_atomic();
 }
 
 void flush_tlb_page(struct vm_area_struct *vma, unsigned long start)
 {
 	struct mm_struct *mm = vma->vm_mm;
 
-	preempt_disable();
+	get_online_cpus_atomic();
 
 	if (current->active_mm == mm) {
 		if (current->mm)
@@ -251,7 +251,7 @@ void flush_tlb_page(struct vm_area_struct *vma, unsigned long start)
 	if (cpumask_any_but(mm_cpumask(mm), smp_processor_id()) < nr_cpu_ids)
 		flush_tlb_others(mm_cpumask(mm), mm, start, 0UL);
 
-	preempt_enable();
+	put_online_cpus_atomic();
 }
 
 static void do_flush_tlb_all(void *info)

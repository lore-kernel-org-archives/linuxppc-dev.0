Return-Path: <srivatsa.bhat@linux.vnet.ibm.com>
Received: from e28smtp08.in.ibm.com (e28smtp08.in.ibm.com [122.248.162.8])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e28smtp08.in.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 49E0A2C0722
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 18 Feb 2013 23:44:38 +1100 (EST)
Received: from /spool/local
 by e28smtp08.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <srivatsa.bhat@linux.vnet.ibm.com>;
 Mon, 18 Feb 2013 18:11:16 +0530
Received: from d28relay05.in.ibm.com (d28relay05.in.ibm.com [9.184.220.62])
 by d28dlp03.in.ibm.com (Postfix) with ESMTP id 90D3F125804F
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 18 Feb 2013 18:15:17 +0530 (IST)
Received: from d28av01.in.ibm.com (d28av01.in.ibm.com [9.184.220.63])
 by d28relay05.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r1ICiU2W32309440
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 18 Feb 2013 18:14:30 +0530
Received: from d28av01.in.ibm.com (loopback [127.0.0.1])
 by d28av01.in.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r1ICiSEt029422
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 18 Feb 2013 12:44:30 GMT
From: "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>
Subject: [PATCH v6 30/46] x86/xen: Use get/put_online_cpus_atomic() to prevent
 CPU offline
To: tglx@linutronix.de, peterz@infradead.org, tj@kernel.org, oleg@redhat.com,
 paulmck@linux.vnet.ibm.com, rusty@rustcorp.com.au, mingo@kernel.org,
 akpm@linux-foundation.org, namhyung@kernel.org
Date: Mon, 18 Feb 2013 18:12:31 +0530
Message-ID: <20130218124231.26245.27495.stgit@srivatsabhat.in.ibm.com>
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

Cc: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Cc: Jeremy Fitzhardinge <jeremy@goop.org>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: x86@kernel.org
Cc: xen-devel@lists.xensource.com
Cc: virtualization@lists.linux-foundation.org
Signed-off-by: Srivatsa S. Bhat <srivatsa.bhat@linux.vnet.ibm.com>
---

 arch/x86/xen/mmu.c |   11 +++++++++--
 arch/x86/xen/smp.c |    9 +++++++++
 2 files changed, 18 insertions(+), 2 deletions(-)

diff --git a/arch/x86/xen/mmu.c b/arch/x86/xen/mmu.c
index 01de35c..6a95a15 100644
--- a/arch/x86/xen/mmu.c
+++ b/arch/x86/xen/mmu.c
@@ -39,6 +39,7 @@
  * Jeremy Fitzhardinge <jeremy@xensource.com>, XenSource Inc, 2007
  */
 #include <linux/sched.h>
+#include <linux/cpu.h>
 #include <linux/highmem.h>
 #include <linux/debugfs.h>
 #include <linux/bug.h>
@@ -1163,9 +1164,13 @@ static void xen_drop_mm_ref(struct mm_struct *mm)
  */
 static void xen_exit_mmap(struct mm_struct *mm)
 {
-	get_cpu();		/* make sure we don't move around */
+	/*
+	 * Make sure we don't move around, and prevent CPUs from going
+	 * offline.
+	 */
+	get_online_cpus_atomic();
 	xen_drop_mm_ref(mm);
-	put_cpu();
+	put_online_cpus_atomic();
 
 	spin_lock(&mm->page_table_lock);
 
@@ -1371,6 +1376,7 @@ static void xen_flush_tlb_others(const struct cpumask *cpus,
 	args->op.arg2.vcpumask = to_cpumask(args->mask);
 
 	/* Remove us, and any offline CPUS. */
+	get_online_cpus_atomic();
 	cpumask_and(to_cpumask(args->mask), cpus, cpu_online_mask);
 	cpumask_clear_cpu(smp_processor_id(), to_cpumask(args->mask));
 
@@ -1383,6 +1389,7 @@ static void xen_flush_tlb_others(const struct cpumask *cpus,
 	MULTI_mmuext_op(mcs.mc, &args->op, 1, NULL, DOMID_SELF);
 
 	xen_mc_issue(PARAVIRT_LAZY_MMU);
+	put_online_cpus_atomic();
 }
 
 static unsigned long xen_read_cr3(void)
diff --git a/arch/x86/xen/smp.c b/arch/x86/xen/smp.c
index 34bc4ce..cb82e71 100644
--- a/arch/x86/xen/smp.c
+++ b/arch/x86/xen/smp.c
@@ -16,6 +16,7 @@
 #include <linux/err.h>
 #include <linux/slab.h>
 #include <linux/smp.h>
+#include <linux/cpu.h>
 #include <linux/irq_work.h>
 
 #include <asm/paravirt.h>
@@ -480,8 +481,10 @@ static void __xen_send_IPI_mask(const struct cpumask *mask,
 {
 	unsigned cpu;
 
+	get_online_cpus_atomic();
 	for_each_cpu_and(cpu, mask, cpu_online_mask)
 		xen_send_IPI_one(cpu, vector);
+	put_online_cpus_atomic();
 }
 
 static void xen_smp_send_call_function_ipi(const struct cpumask *mask)
@@ -544,8 +547,10 @@ void xen_send_IPI_all(int vector)
 {
 	int xen_vector = xen_map_vector(vector);
 
+	get_online_cpus_atomic();
 	if (xen_vector >= 0)
 		__xen_send_IPI_mask(cpu_online_mask, xen_vector);
+	put_online_cpus_atomic();
 }
 
 void xen_send_IPI_self(int vector)
@@ -565,20 +570,24 @@ void xen_send_IPI_mask_allbutself(const struct cpumask *mask,
 	if (!(num_online_cpus() > 1))
 		return;
 
+	get_online_cpus_atomic();
 	for_each_cpu_and(cpu, mask, cpu_online_mask) {
 		if (this_cpu == cpu)
 			continue;
 
 		xen_smp_send_call_function_single_ipi(cpu);
 	}
+	put_online_cpus_atomic();
 }
 
 void xen_send_IPI_allbutself(int vector)
 {
 	int xen_vector = xen_map_vector(vector);
 
+	get_online_cpus_atomic();
 	if (xen_vector >= 0)
 		xen_send_IPI_mask_allbutself(cpu_online_mask, xen_vector);
+	put_online_cpus_atomic();
 }
 
 static irqreturn_t xen_call_function_interrupt(int irq, void *dev_id)

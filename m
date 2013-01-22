Return-Path: <srivatsa.bhat@linux.vnet.ibm.com>
Received: from e28smtp03.in.ibm.com (e28smtp03.in.ibm.com [122.248.162.3])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e28smtp03.in.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 3748F2C0767
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 22 Jan 2013 18:41:07 +1100 (EST)
Received: from /spool/local
 by e28smtp03.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <srivatsa.bhat@linux.vnet.ibm.com>;
 Tue, 22 Jan 2013 13:09:32 +0530
Received: from d28relay01.in.ibm.com (d28relay01.in.ibm.com [9.184.220.58])
 by d28dlp03.in.ibm.com (Postfix) with ESMTP id 0F2DA125804D
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 22 Jan 2013 13:11:27 +0530 (IST)
Received: from d28av04.in.ibm.com (d28av04.in.ibm.com [9.184.220.66])
 by d28relay01.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r0M7f14q44761174
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 22 Jan 2013 13:11:01 +0530
Received: from d28av04.in.ibm.com (loopback [127.0.0.1])
 by d28av04.in.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r0M7exjL017488
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 22 Jan 2013 18:41:03 +1100
From: "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>
Subject: [PATCH v5 22/45] infiniband: ehca: Use get/put_online_cpus_atomic()
 to prevent CPU offline
To: tglx@linutronix.de, peterz@infradead.org, tj@kernel.org, oleg@redhat.com,
 paulmck@linux.vnet.ibm.com, rusty@rustcorp.com.au, mingo@kernel.org,
 akpm@linux-foundation.org, namhyung@kernel.org
Date: Tue, 22 Jan 2013 13:09:13 +0530
Message-ID: <20130122073909.13822.6220.stgit@srivatsabhat.in.ibm.com>
In-Reply-To: <20130122073210.13822.50434.stgit@srivatsabhat.in.ibm.com>
References: <20130122073210.13822.50434.stgit@srivatsabhat.in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Cc: linux-arch@vger.kernel.org, linux@arm.linux.org.uk,
 nikunj@linux.vnet.ibm.com, linux-pm@vger.kernel.org, fweisbec@gmail.com,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, rostedt@goodmis.org,
 xiaoguangrong@linux.vnet.ibm.com, rjw@sisk.pl, sbw@mit.edu,
 wangyun@linux.vnet.ibm.com, srivatsa.bhat@linux.vnet.ibm.com,
 netdev@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-arm-kernel@lists.infradead.org
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

Cc: Roland Dreier <roland@kernel.org>
Signed-off-by: Srivatsa S. Bhat <srivatsa.bhat@linux.vnet.ibm.com>
---

 drivers/infiniband/hw/ehca/ehca_irq.c |    8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/infiniband/hw/ehca/ehca_irq.c b/drivers/infiniband/hw/ehca/ehca_irq.c
index 8615d7c..d61936c 100644
--- a/drivers/infiniband/hw/ehca/ehca_irq.c
+++ b/drivers/infiniband/hw/ehca/ehca_irq.c
@@ -43,6 +43,7 @@
 
 #include <linux/slab.h>
 #include <linux/smpboot.h>
+#include <linux/cpu.h>
 
 #include "ehca_classes.h"
 #include "ehca_irq.h"
@@ -653,6 +654,9 @@ void ehca_tasklet_eq(unsigned long data)
 	ehca_process_eq((struct ehca_shca*)data, 1);
 }
 
+/*
+ * Must be called under get_online_cpus_atomic() and put_online_cpus_atomic().
+ */
 static int find_next_online_cpu(struct ehca_comp_pool *pool)
 {
 	int cpu;
@@ -703,6 +707,7 @@ static void queue_comp_task(struct ehca_cq *__cq)
 	int cq_jobs;
 	unsigned long flags;
 
+	get_online_cpus_atomic();
 	cpu_id = find_next_online_cpu(pool);
 	BUG_ON(!cpu_online(cpu_id));
 
@@ -720,6 +725,7 @@ static void queue_comp_task(struct ehca_cq *__cq)
 		BUG_ON(!cct || !thread);
 	}
 	__queue_comp_task(__cq, cct, thread);
+	put_online_cpus_atomic();
 }
 
 static void run_comp_task(struct ehca_cpu_comp_task *cct)
@@ -759,6 +765,7 @@ static void comp_task_park(unsigned int cpu)
 	list_splice_init(&cct->cq_list, &list);
 	spin_unlock_irq(&cct->task_lock);
 
+	get_online_cpus_atomic();
 	cpu = find_next_online_cpu(pool);
 	target = per_cpu_ptr(pool->cpu_comp_tasks, cpu);
 	thread = *per_cpu_ptr(pool->cpu_comp_threads, cpu);
@@ -768,6 +775,7 @@ static void comp_task_park(unsigned int cpu)
 		__queue_comp_task(cq, target, thread);
 	}
 	spin_unlock_irq(&target->task_lock);
+	put_online_cpus_atomic();
 }
 
 static void comp_task_stop(unsigned int cpu, bool online)

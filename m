Return-Path: <srivatsa.bhat@linux.vnet.ibm.com>
Received: from e23smtp04.au.ibm.com (e23smtp04.au.ibm.com [202.81.31.146])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e23smtp04.au.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id BB4B42C069C
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 28 Jun 2013 05:59:41 +1000 (EST)
Received: from /spool/local
 by e23smtp04.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <srivatsa.bhat@linux.vnet.ibm.com>;
 Fri, 28 Jun 2013 05:45:05 +1000
Received: from d23relay04.au.ibm.com (d23relay04.au.ibm.com [9.190.234.120])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id 09C973578050
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 28 Jun 2013 05:59:38 +1000 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay04.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r5RJijhr57933872
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 28 Jun 2013 05:44:45 +1000
Received: from d23av01.au.ibm.com (loopback [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r5RJxZDB015505
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 28 Jun 2013 05:59:37 +1000
From: "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>
Subject: [PATCH v3 20/45] irq: Use get/put_online_cpus_atomic() to prevent CPU
 offline
To: tglx@linutronix.de, peterz@infradead.org, tj@kernel.org, oleg@redhat.com,
 paulmck@linux.vnet.ibm.com, rusty@rustcorp.com.au, mingo@kernel.org,
 akpm@linux-foundation.org, namhyung@kernel.org, walken@google.com,
 vincent.guittot@linaro.org, laijs@cn.fujitsu.com, David.Laight@aculab.com
Date: Fri, 28 Jun 2013 01:26:15 +0530
Message-ID: <20130627195614.29830.86515.stgit@srivatsabhat.in.ibm.com>
In-Reply-To: <20130627195136.29830.10445.stgit@srivatsabhat.in.ibm.com>
References: <20130627195136.29830.10445.stgit@srivatsabhat.in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Cc: linux-arch@vger.kernel.org, nikunj@linux.vnet.ibm.com,
 zhong@linux.vnet.ibm.com, linux-pm@vger.kernel.org, fweisbec@gmail.com,
 linux-kernel@vger.kernel.org, rostedt@goodmis.org,
 xiaoguangrong@linux.vnet.ibm.com, sbw@mit.edu, wangyun@linux.vnet.ibm.com,
 "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>, netdev@vger.kernel.org,
 Thomas Gleixner <tglx@linutronix.de>, linuxppc-dev@lists.ozlabs.org
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
Signed-off-by: Srivatsa S. Bhat <srivatsa.bhat@linux.vnet.ibm.com>
---

 kernel/irq/manage.c |    7 +++++++
 kernel/irq/proc.c   |    3 +++
 2 files changed, 10 insertions(+)

diff --git a/kernel/irq/manage.c b/kernel/irq/manage.c
index e16caa8..4d89f19 100644
--- a/kernel/irq/manage.c
+++ b/kernel/irq/manage.c
@@ -18,6 +18,7 @@
 #include <linux/sched.h>
 #include <linux/sched/rt.h>
 #include <linux/task_work.h>
+#include <linux/cpu.h>
 
 #include "internals.h"
 
@@ -202,9 +203,11 @@ int irq_set_affinity(unsigned int irq, const struct cpumask *mask)
 	if (!desc)
 		return -EINVAL;
 
+	get_online_cpus_atomic();
 	raw_spin_lock_irqsave(&desc->lock, flags);
 	ret =  __irq_set_affinity_locked(irq_desc_get_irq_data(desc), mask);
 	raw_spin_unlock_irqrestore(&desc->lock, flags);
+	put_online_cpus_atomic();
 	return ret;
 }
 
@@ -343,9 +346,11 @@ int irq_select_affinity_usr(unsigned int irq, struct cpumask *mask)
 	unsigned long flags;
 	int ret;
 
+	get_online_cpus_atomic();
 	raw_spin_lock_irqsave(&desc->lock, flags);
 	ret = setup_affinity(irq, desc, mask);
 	raw_spin_unlock_irqrestore(&desc->lock, flags);
+	put_online_cpus_atomic();
 	return ret;
 }
 
@@ -1128,7 +1133,9 @@ __setup_irq(unsigned int irq, struct irq_desc *desc, struct irqaction *new)
 		}
 
 		/* Set default affinity mask once everything is setup */
+		get_online_cpus_atomic();
 		setup_affinity(irq, desc, mask);
+		put_online_cpus_atomic();
 
 	} else if (new->flags & IRQF_TRIGGER_MASK) {
 		unsigned int nmsk = new->flags & IRQF_TRIGGER_MASK;
diff --git a/kernel/irq/proc.c b/kernel/irq/proc.c
index 19ed5c4..47f9a74 100644
--- a/kernel/irq/proc.c
+++ b/kernel/irq/proc.c
@@ -7,6 +7,7 @@
  */
 
 #include <linux/irq.h>
+#include <linux/cpu.h>
 #include <linux/gfp.h>
 #include <linux/proc_fs.h>
 #include <linux/seq_file.h>
@@ -441,6 +442,7 @@ int show_interrupts(struct seq_file *p, void *v)
 	if (!desc)
 		return 0;
 
+	get_online_cpus_atomic();
 	raw_spin_lock_irqsave(&desc->lock, flags);
 	for_each_online_cpu(j)
 		any_count |= kstat_irqs_cpu(i, j);
@@ -477,6 +479,7 @@ int show_interrupts(struct seq_file *p, void *v)
 	seq_putc(p, '\n');
 out:
 	raw_spin_unlock_irqrestore(&desc->lock, flags);
+	put_online_cpus_atomic();
 	return 0;
 }
 #endif

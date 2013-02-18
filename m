Return-Path: <srivatsa.bhat@linux.vnet.ibm.com>
Received: from e23smtp09.au.ibm.com (e23smtp09.au.ibm.com [202.81.31.142])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e23smtp09.au.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id EF4F62C0549
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 18 Feb 2013 23:43:02 +1100 (EST)
Received: from /spool/local
 by e23smtp09.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <srivatsa.bhat@linux.vnet.ibm.com>;
 Mon, 18 Feb 2013 22:35:55 +1000
Received: from d23relay04.au.ibm.com (d23relay04.au.ibm.com [9.190.234.120])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id 0E8462CE804A
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 18 Feb 2013 23:42:58 +1100 (EST)
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay04.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r1ICUef29634194
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 18 Feb 2013 23:30:40 +1100
Received: from d23av03.au.ibm.com (loopback [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r1ICgtrd020263
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 18 Feb 2013 23:42:57 +1100
From: "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>
Subject: [PATCH v6 19/46] irq: Use get/put_online_cpus_atomic() to prevent CPU
 offline
To: tglx@linutronix.de, peterz@infradead.org, tj@kernel.org, oleg@redhat.com,
 paulmck@linux.vnet.ibm.com, rusty@rustcorp.com.au, mingo@kernel.org,
 akpm@linux-foundation.org, namhyung@kernel.org
Date: Mon, 18 Feb 2013 18:10:52 +0530
Message-ID: <20130218124052.26245.30164.stgit@srivatsabhat.in.ibm.com>
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

Signed-off-by: Srivatsa S. Bhat <srivatsa.bhat@linux.vnet.ibm.com>
---

 kernel/irq/manage.c |    7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/kernel/irq/manage.c b/kernel/irq/manage.c
index e49a288..b4240b9 100644
--- a/kernel/irq/manage.c
+++ b/kernel/irq/manage.c
@@ -16,6 +16,7 @@
 #include <linux/interrupt.h>
 #include <linux/slab.h>
 #include <linux/sched.h>
+#include <linux/cpu.h>
 #include <linux/task_work.h>
 
 #include "internals.h"
@@ -202,7 +203,9 @@ int irq_set_affinity(unsigned int irq, const struct cpumask *mask)
 		return -EINVAL;
 
 	raw_spin_lock_irqsave(&desc->lock, flags);
+	get_online_cpus_atomic();
 	ret =  __irq_set_affinity_locked(irq_desc_get_irq_data(desc), mask);
+	put_online_cpus_atomic();
 	raw_spin_unlock_irqrestore(&desc->lock, flags);
 	return ret;
 }
@@ -343,7 +346,9 @@ int irq_select_affinity_usr(unsigned int irq, struct cpumask *mask)
 	int ret;
 
 	raw_spin_lock_irqsave(&desc->lock, flags);
+	get_online_cpus_atomic();
 	ret = setup_affinity(irq, desc, mask);
+	put_online_cpus_atomic();
 	raw_spin_unlock_irqrestore(&desc->lock, flags);
 	return ret;
 }
@@ -1126,7 +1131,9 @@ __setup_irq(unsigned int irq, struct irq_desc *desc, struct irqaction *new)
 		}
 
 		/* Set default affinity mask once everything is setup */
+		get_online_cpus_atomic();
 		setup_affinity(irq, desc, mask);
+		put_online_cpus_atomic();
 
 	} else if (new->flags & IRQF_TRIGGER_MASK) {
 		unsigned int nmsk = new->flags & IRQF_TRIGGER_MASK;

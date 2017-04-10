Return-Path: <srs0=5cae=3s=kernel.crashing.org=benh@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3w1gKr5CM6zDqFJ
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 10 Apr 2017 16:30:40 +1000 (AEST)
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 3w1gKr40H8z8vHF
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 10 Apr 2017 16:30:40 +1000 (AEST)
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3w1gKq6Fsbz9s7p
 for <linuxppc-dev@ozlabs.org>; Mon, 10 Apr 2017 16:30:39 +1000 (AEST)
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH v2 3/3] powerpc/xive: Extra sanity checks on cpu numbers
Date: Mon, 10 Apr 2017 16:30:01 +1000
Message-Id: <20170410063001.7235-3-benh@kernel.crashing.org>
In-Reply-To: <20170410063001.7235-1-benh@kernel.crashing.org>
References: <20170410063001.7235-1-benh@kernel.crashing.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

When targetting interrupts we do various manipulations of cpu numbers
and CPU masks. This adds some sanity checking to ensure we don't
break assumptions and manpulate cpu numbers that are out of bounds
of the various cpumasks.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---
 arch/powerpc/sysdev/xive/common.c | 22 ++++++++++++++++++++--
 1 file changed, 20 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/sysdev/xive/common.c b/arch/powerpc/sysdev/xive/common.c
index f37d257..f78a779 100644
--- a/arch/powerpc/sysdev/xive/common.c
+++ b/arch/powerpc/sysdev/xive/common.c
@@ -421,8 +421,10 @@ static void xive_dec_target_count(int cpu)
 	struct xive_cpu *xc = per_cpu(xive_cpu, cpu);
 	struct xive_q *q = &xc->queue[xive_irq_priority];
 
-	if (WARN_ON(cpu < 0))
+	if (unlikely(WARN_ON(cpu < 0 || !xc))) {
+		pr_err("%s: cpu=%d xc=%p\n", __func__, cpu, xc);
 		return;
+	}
 
 	/*
 	 * We increment the "pending count" which will be used
@@ -446,8 +448,14 @@ static int xive_find_target_in_mask(const struct cpumask *mask,
 
 	/* Locate it */
 	cpu = cpumask_first(mask);
-	for (i = 0; i < first; i++)
+	for (i = 0; i < first && cpu < nr_cpu_ids; i++)
 		cpu = cpumask_next(cpu, mask);
+
+	/* Sanity check */
+	if (WARN_ON(cpu >= nr_cpu_ids))
+		cpu = cpumask_first(cpu_online_mask);
+
+	/* Remember first one to handle wrap-around */
 	first = cpu;
 
 	/*
@@ -540,6 +548,12 @@ static unsigned int xive_irq_startup(struct irq_data *d)
 		pr_warn("XIVE: irq %d started with broken affinity\n",
 			d->irq);
 	}
+
+	/* Sanity check */
+	if (WARN_ON(target == XIVE_INVALID_TARGET ||
+		    target >= nr_cpu_ids))
+		target = smp_processor_id();
+
 	xd->target = target;
 
 	/*
@@ -670,6 +684,10 @@ static int xive_irq_set_affinity(struct irq_data *d,
 	if (target == XIVE_INVALID_TARGET)
 		return -ENXIO;
 
+	/* Sanity check */
+	if (WARN_ON(target >= nr_cpu_ids))
+		target = smp_processor_id();
+
 	old_target = xd->target;
 
 	/*
-- 
2.9.3

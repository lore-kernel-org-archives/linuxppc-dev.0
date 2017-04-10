Return-Path: <srs0=5cae=3s=kernel.crashing.org=benh@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3w1gB638T4zDq7Z
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 10 Apr 2017 16:23:58 +1000 (AEST)
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 3w1gB62kkkz8t6y
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 10 Apr 2017 16:23:58 +1000 (AEST)
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3w1gB541Ktz9s7j
 for <linuxppc-dev@ozlabs.org>; Mon, 10 Apr 2017 16:23:57 +1000 (AEST)
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 3/3] powerpc/xive: Extra sanity checks on cpu numbers
Date: Mon, 10 Apr 2017 16:23:21 +1000
Message-Id: <20170410062321.32521-3-benh@kernel.crashing.org>
In-Reply-To: <20170410062321.32521-1-benh@kernel.crashing.org>
References: <20170410062321.32521-1-benh@kernel.crashing.org>
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
 arch/powerpc/sysdev/xive/common.c | 18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/sysdev/xive/common.c b/arch/powerpc/sysdev/xive/common.c
index abda9b2..496036c 100644
--- a/arch/powerpc/sysdev/xive/common.c
+++ b/arch/powerpc/sysdev/xive/common.c
@@ -452,8 +452,14 @@ static int xive_find_target_in_mask(const struct cpumask *mask,
 
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
@@ -545,6 +551,12 @@ static unsigned int xive_irq_startup(struct irq_data *d)
 			return -ENXIO;
 		pr_warn("irq %d started with broken affinity\n", d->irq);
 	}
+
+	/* Sanity check */
+	if (WARN_ON(target == XIVE_INVALID_TARGET ||
+		    target >= nr_cpu_ids))
+		target = smp_processor_id();
+
 	xd->target = target;
 
 	/*
@@ -676,6 +688,10 @@ static int xive_irq_set_affinity(struct irq_data *d,
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

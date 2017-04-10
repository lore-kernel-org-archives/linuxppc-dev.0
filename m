Return-Path: <srs0=5cae=3s=kernel.crashing.org=benh@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3w1gBM3VVvzDqG1
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 10 Apr 2017 16:24:11 +1000 (AEST)
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 3w1gBM2njGz8t6y
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 10 Apr 2017 16:24:11 +1000 (AEST)
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3w1gBL1RTvz9s2x
 for <linuxppc-dev@ozlabs.org>; Mon, 10 Apr 2017 16:24:09 +1000 (AEST)
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 2/3] powerpx/xive: Fix irq target selection returning out of
 bounds cpu#
Date: Mon, 10 Apr 2017 16:23:20 +1000
Message-Id: <20170410062321.32521-2-benh@kernel.crashing.org>
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

xive_pick_irq_target() first tries to construct a mask that is
the intersection of the requested affinity, online CPUs, and
the group of CPUs that are on the same chip as the interrupt
source.

If that resulting mask is empty, we were incorrectly returning
nr_cpu_ids as a target.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---
 arch/powerpc/sysdev/xive/common.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/sysdev/xive/common.c b/arch/powerpc/sysdev/xive/common.c
index dbbe446..abda9b2 100644
--- a/arch/powerpc/sysdev/xive/common.c
+++ b/arch/powerpc/sysdev/xive/common.c
@@ -492,7 +492,7 @@ static int xive_pick_irq_target(struct irq_data *d,
 
 	/*
 	 * If we have chip IDs, first we try to build a mask of
-	 * CPUs matching ther CPU and find a target in there
+	 * CPUs matching the CPU and find a target in there
 	 */
 	if (xd->src_chip != XIVE_INVALID_CHIP_ID &&
 		zalloc_cpumask_var(&mask, GFP_ATOMIC)) {
@@ -503,7 +503,9 @@ static int xive_pick_irq_target(struct irq_data *d,
 				cpumask_set_cpu(cpu, mask);
 		}
 		/* Try to find a target */
-		if (!cpumask_empty(mask))
+		if (cpumask_empty(mask))
+			cpu = -1;
+		else
 			cpu = xive_find_target_in_mask(mask, fuzz++);
 		free_cpumask_var(mask);
 		if (cpu >= 0)
-- 
2.9.3

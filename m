Return-Path: <miltonm@bga.com>
Received: from mail4.comsite.net (mail4.comsite.net [205.238.176.238])
	by ozlabs.org (Postfix) with ESMTP id 9C5601007F9
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 11 May 2011 17:42:44 +1000 (EST)
To: <linuxppc-dev@lists.ozlabs.org>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>
Message-Id: <2994415a7083c591b33948b09d2baea9d29cee01.1305092637.git.miltonm@bga.com>
In-Reply-To: <cover.1305092637.git.miltonm@bga.com>
References: <cover.1305092637.git.miltonm@bga.com>
From: Milton Miller <miltonm@bga.com>
Date: Wed, 11 May 2011 00:29:02 -0500
Subject: [PATCH 09/37] powerpc: mpic: break cpumask abstraction earlier
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

mpic_set_affinity is allocating and freeing a cpumask var even though
it was breaking the cpumask abstraction when passing the mask to
mpic_physmask.  It also didn't have any check for allocatin failure.

Break the cpumask abstraction earlier and use simple bitwise and of the
bits from the mask with the bits of cpu_online_mask.

Signed-off-by: Milton Miller <miltonm@bga.com>
---
 arch/powerpc/sysdev/mpic.c |   10 +++-------
 1 files changed, 3 insertions(+), 7 deletions(-)

diff --git a/arch/powerpc/sysdev/mpic.c b/arch/powerpc/sysdev/mpic.c
index a93da80..116695b 100644
--- a/arch/powerpc/sysdev/mpic.c
+++ b/arch/powerpc/sysdev/mpic.c
@@ -821,16 +821,12 @@ int mpic_set_affinity(struct irq_data *d, const struct cpumask *cpumask,
 
 		mpic_irq_write(src, MPIC_INFO(IRQ_DESTINATION), 1 << cpuid);
 	} else {
-		cpumask_var_t tmp;
+		u32 mask = cpumask_bits(cpumask)[0];
 
-		alloc_cpumask_var(&tmp, GFP_KERNEL);
-
-		cpumask_and(tmp, cpumask, cpu_online_mask);
+		mask &= cpumask_bits(cpu_online_mask)[0];
 
 		mpic_irq_write(src, MPIC_INFO(IRQ_DESTINATION),
-			       mpic_physmask(cpumask_bits(tmp)[0]));
-
-		free_cpumask_var(tmp);
+			       mpic_physmask(mask));
 	}
 
 	return 0;
-- 
1.7.0.4

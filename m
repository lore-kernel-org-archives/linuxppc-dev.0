Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xG7hJ0B7gzDrL5
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 24 Jul 2017 14:30:07 +1000 (AEST)
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: linuxppc-dev@lists.ozlabs.org
Cc: aneesh.kumar@linux.vnet.ibm.com, npiggin@gmail.com,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [PATCH 3/6] powerpc/mm: Ensure cpumask update is ordered
Date: Mon, 24 Jul 2017 14:28:00 +1000
Message-Id: <20170724042803.25848-3-benh@kernel.crashing.org>
In-Reply-To: <20170724042803.25848-1-benh@kernel.crashing.org>
References: <20170724042803.25848-1-benh@kernel.crashing.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

There is no guarantee that the various isync's involved with
the context switch will order the update of the CPU mask with
the first TLB entry for the new context being loaded by the HW.

Be safe here and add a memory barrier to order any subsequent
load/store which may bring entries into the TLB.

The corresponding barrier on the other side already exists as
pte updates use pte_xchg() which uses __cmpxchg_u64 which has
a sync after the atomic operation.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---
 arch/powerpc/include/asm/mmu_context.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/powerpc/include/asm/mmu_context.h b/arch/powerpc/include/asm/mmu_context.h
index ed9a36ee3107..ff1aeb2cd19f 100644
--- a/arch/powerpc/include/asm/mmu_context.h
+++ b/arch/powerpc/include/asm/mmu_context.h
@@ -110,6 +110,7 @@ static inline void switch_mm_irqs_off(struct mm_struct *prev,
 	/* Mark this context has been used on the new CPU */
 	if (!cpumask_test_cpu(smp_processor_id(), mm_cpumask(next))) {
 		cpumask_set_cpu(smp_processor_id(), mm_cpumask(next));
+		smp_mb();
 		new_on_cpu = true;
 	}
 
-- 
2.13.3

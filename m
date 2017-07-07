Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3x46l12GTNzDr8l
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  8 Jul 2017 07:12:45 +1000 (AEST)
Message-ID: <1499461936.3397.13.camel@kernel.crashing.org>
Subject: [PATCH 2/2] powerpc/mm/radix: Synchronize updates to the process table
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: linuxppc dev list <linuxppc-dev@lists.ozlabs.org>
Cc: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>, Michael Neuling
 <michael.neuling@au1.ibm.com>, Nick Piggin <npiggin@au1.ibm.com>
Date: Fri, 07 Jul 2017 16:12:16 -0500
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

When writing to the process table, we need to ensure the store is
visible to a subsequent access by the MMU. We assume we never have
the PID active while doing the update, so a ptesync/isync pair
should hopefully be a big enough hammer for our purpose.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---

Note: Architecturally, we also need to use a tlbie(l) with RIC=2
to flush the process table cache. However this is (very) expensive
and we know that POWER9 will invalidate its cache when hitting the
mtpid instruction.

To be safe, we should add the tlbie for any ARCH300 processor we
don't know about though. (Aneesh, Nick do we need a ftr bit ?)

 arch/powerpc/mm/mmu_context_book3s64.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/powerpc/mm/mmu_context_book3s64.c b/arch/powerpc/mm/mmu_context_book3s64.c
index 9404b5e..e3e2803 100644
--- a/arch/powerpc/mm/mmu_context_book3s64.c
+++ b/arch/powerpc/mm/mmu_context_book3s64.c
@@ -138,6 +138,14 @@ static int radix__init_new_context(struct mm_struct *mm)
 	rts_field = radix__get_tree_size();
 	process_tb[index].prtb0 = cpu_to_be64(rts_field | __pa(mm->pgd) | RADIX_PGD_INDEX_SIZE);
 
+	/*
+	 * Order the above store with subsequent update of the PID
+	 * register (at which point HW can start loading/caching
+	 * the entry) and the corresponding load by the MMU from
+	 * the L2 cache.
+	 */
+	asm volatile("ptesync;isync" : : : "memory");
+
 	mm->context.npu_context = NULL;
 
 	return index;

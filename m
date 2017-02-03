Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vF61K6ygdzDqBY
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  3 Feb 2017 17:10:45 +1100 (AEDT)
Message-ID: <1486102228.4850.52.camel@kernel.crashing.org>
Subject: [PATCH] powerpc/mm: Fix spurrious segfaults on radix with Autonuma
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: linuxppc-dev@lists.ozlabs.org
Cc: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>, Michael Neuling
 <michael.neuling@au1.ibm.com>, Balbir Singh <bsingharora@gmail.com>
Date: Fri, 03 Feb 2017 17:10:28 +1100
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

When autonuma marks a PTE inaccessible it clears all the protection
bits but leave the PTE valid.

With the Radix MMU, an attempt at executing from such a PTE will
take a fault with bit 35 of SRR1 set "SRR1_ISI_N_OR_G".

It is thus incorrect to treat all such faults as errors. We should
pass them to handle_mm_fault() for autonuma to deal with. The case
of pages that are really not executable is handled by the existing
test for VM_EXEC further down.

That leaves us with catching the kernel attempts at executing user
pages. We can catch that earlier, even before we do find_vma.

It is never valid on powerpc for the kernel to take an exec fault
to begin with. So fold that test with the existing test for the
kernel faulting on kernel addresses to bail out early.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Fixes: 1d18ad0 ("powerpc/mm: Detect instruction fetch denied and report")
Fixes: 0ab5171 ("powerpc/mm: Fix no execute fault handling on pre-POWER5")
---

diff --git a/arch/powerpc/mm/fault.c b/arch/powerpc/mm/fault.c
index 6fd30ac..62a50d6 100644
--- a/arch/powerpc/mm/fault.c
+++ b/arch/powerpc/mm/fault.c
@@ -253,8 +253,11 @@ int do_page_fault(struct pt_regs *regs, unsigned long address,
 	if (unlikely(debugger_fault_handler(regs)))
 		goto bail;
 
-	/* On a kernel SLB miss we can only check for a valid exception entry */
-	if (!user_mode(regs) && (address >= TASK_SIZE)) {
+	/*
+	 * The kernel should never take an execute fault nor should it
+	 * take a page fault to a kernel address.
+	 */
+	if (!user_mode(regs) && (is_exec || (address >= TASK_SIZE))) {
 		rc = SIGSEGV;
 		goto bail;
 	}
@@ -391,20 +394,6 @@ int do_page_fault(struct pt_regs *regs, unsigned long address,
 
 	if (is_exec) {
 		/*
-		 * An execution fault + no execute ?
-		 *
-		 * On CPUs that don't have CPU_FTR_COHERENT_ICACHE we
-		 * deliberately create NX mappings, and use the fault to do the
-		 * cache flush. This is usually handled in hash_page_do_lazy_icache()
-		 * but we could end up here if that races with a concurrent PTE
-		 * update. In that case we need to fall through here to the VMA
-		 * check below.
-		 */
-		if (cpu_has_feature(CPU_FTR_COHERENT_ICACHE) &&
-			(regs->msr & SRR1_ISI_N_OR_G))
-			goto bad_area;
-
-		/*
 		 * Allow execution from readable areas if the MMU does not
 		 * provide separate controls over reading and executing.
 		 *

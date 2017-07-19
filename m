Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xC4Wn2j0NzDrTB
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 19 Jul 2017 14:57:09 +1000 (AEST)
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: linuxppc-dev@lists.ozlabs.org
Cc: aneesh.kumar@linux.vnet.ibm.com,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [PATCH 18/24] powerpc/mm: Move/simplify faulthandler_disabled() and
 !mm check
Date: Wed, 19 Jul 2017 14:49:40 +1000
Message-Id: <20170719044946.22030-18-benh@kernel.crashing.org>
In-Reply-To: <20170719044946.22030-1-benh@kernel.crashing.org>
References: <20170719044946.22030-1-benh@kernel.crashing.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Do the check before we re-enable interrupts and clean the code
up a bit.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---
 arch/powerpc/mm/fault.c | 27 +++++++++++++--------------
 1 file changed, 13 insertions(+), 14 deletions(-)

diff --git a/arch/powerpc/mm/fault.c b/arch/powerpc/mm/fault.c
index 6f3a2437008a..c5859ffd3a96 100644
--- a/arch/powerpc/mm/fault.c
+++ b/arch/powerpc/mm/fault.c
@@ -355,24 +355,23 @@ static int __do_page_fault(struct pt_regs *regs, unsigned long address,
 	if (unlikely(!is_user && bad_kernel_fault(is_exec, error_code, address)))
 		return SIGSEGV;
 
+	/*
+	 * If we're in an interrupt, have no user context or are running
+	 * in a region with pagefaults disabled then we must not take the fault
+	 */
+	if (unlikely(faulthandler_disabled() || !mm)) {
+		if (is_user)
+			printk_ratelimited(KERN_ERR "Page fault in user mode"
+					   " with faulthandler_disabled()=%d"
+					   " mm=%=p\n",
+					   faulthandler_disabled(), mm);
+		return bad_area_nosemaphore(regs, address);
+	}
+
 	/* We restore the interrupt state now */
 	if (!arch_irq_disabled_regs(regs))
 		local_irq_enable();
 
-	if (faulthandler_disabled() || mm == NULL) {
-		if (!is_user)
-			return SIGSEGV;
-
-		/* faulthandler_disabled() in user mode is really bad,
-		   as is current->mm == NULL. */
-		printk(KERN_EMERG "Page fault in user mode with "
-		       "faulthandler_disabled() = %d mm = %p\n",
-		       faulthandler_disabled(), mm);
-		printk(KERN_EMERG "NIP = %lx  MSR = %lx\n",
-		       regs->nip, regs->msr);
-		die("Weird page fault", regs, SIGSEGV);
-	}
-
 	perf_sw_event(PERF_COUNT_SW_PAGE_FAULTS, 1, regs, address);
 
 	/*
-- 
2.13.3

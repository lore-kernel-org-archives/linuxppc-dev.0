Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xC4NV1G3QzDr1v
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 19 Jul 2017 14:50:49 +1000 (AEST)
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: linuxppc-dev@lists.ozlabs.org
Cc: aneesh.kumar@linux.vnet.ibm.com,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [PATCH 11/24] powerpc/mm: Simplify returns from __do_page_fault
Date: Wed, 19 Jul 2017 14:49:33 +1000
Message-Id: <20170719044946.22030-11-benh@kernel.crashing.org>
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

Now that we moved the exception state handling to a wrapper, we can
just directly return rather than "goto bail"

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---
 arch/powerpc/mm/fault.c | 39 ++++++++++++++++-----------------------
 1 file changed, 16 insertions(+), 23 deletions(-)

diff --git a/arch/powerpc/mm/fault.c b/arch/powerpc/mm/fault.c
index 2f825ae68f20..e8d6acc888c5 100644
--- a/arch/powerpc/mm/fault.c
+++ b/arch/powerpc/mm/fault.c
@@ -233,39 +233,36 @@ static int __do_page_fault(struct pt_regs *regs, unsigned long address,
 	if (error_code & ICSWX_DSI_UCT) {
 		rc = acop_handle_fault(regs, address, error_code);
 		if (rc)
-			goto bail;
+			return rc;
 	}
 #endif /* CONFIG_PPC_ICSWX */
 
 	if (notify_page_fault(regs))
-		goto bail;
+		return 0;
 
 	if (unlikely(page_fault_is_bad(error_code))) {
-		if (is_user)
+		if (is_user) {
 			_exception(SIGBUS, regs, BUS_OBJERR, address);
-		else
-			rc = SIGBUS;
-		goto bail;
+			return 0;
+		}
+		return SIGBUS;
 	}
 
 	/*
 	 * The kernel should never take an execute fault nor should it
 	 * take a page fault to a kernel address.
 	 */
-	if (!is_user && (is_exec || (address >= TASK_SIZE))) {
-		rc = SIGSEGV;
-		goto bail;
-	}
+	if (!is_user && (is_exec || (address >= TASK_SIZE)))
+		return SIGSEGV;
 
 	/* We restore the interrupt state now */
 	if (!arch_irq_disabled_regs(regs))
 		local_irq_enable();
 
 	if (faulthandler_disabled() || mm == NULL) {
-		if (!is_user) {
-			rc = SIGSEGV;
-			goto bail;
-		}
+		if (!is_user)
+			return SIGSEGV;
+
 		/* faulthandler_disabled() in user mode is really bad,
 		   as is current->mm == NULL. */
 		printk(KERN_EMERG "Page fault in user mode with "
@@ -454,9 +451,8 @@ static int __do_page_fault(struct pt_regs *regs, unsigned long address,
 			goto bad_area_nosemaphore;
 		rc = mm_fault_error(regs, address, fault);
 		if (rc >= MM_FAULT_RETURN)
-			goto bail;
-		else
-			rc = 0;
+			return rc;
+		rc = 0;
 	}
 
 	/*
@@ -483,7 +479,7 @@ static int __do_page_fault(struct pt_regs *regs, unsigned long address,
 			      regs, address);
 	}
 
-	goto bail;
+	return rc;
 
 bad_area:
 	up_read(&mm->mmap_sem);
@@ -492,7 +488,7 @@ static int __do_page_fault(struct pt_regs *regs, unsigned long address,
 	/* User mode accesses cause a SIGSEGV */
 	if (is_user) {
 		_exception(SIGSEGV, regs, code, address);
-		goto bail;
+		return 0;
 	}
 
 	if (is_exec && (error_code & DSISR_PROTFAULT))
@@ -500,10 +496,7 @@ static int __do_page_fault(struct pt_regs *regs, unsigned long address,
 				   " page (%lx) - exploit attempt? (uid: %d)\n",
 				   address, from_kuid(&init_user_ns, current_uid()));
 
-	rc = SIGSEGV;
-
-bail:
-	return rc;
+	return SIGSEGV;
 }
 NOKPROBE_SYMBOL(__do_page_fault);
 
-- 
2.13.3

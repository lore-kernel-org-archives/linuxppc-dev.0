Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xC4Wt0nKdzDrSn
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 19 Jul 2017 14:57:13 +1000 (AEST)
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: linuxppc-dev@lists.ozlabs.org
Cc: aneesh.kumar@linux.vnet.ibm.com,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [PATCH 14/24] powerpc/mm: Rework mm_fault_error()
Date: Wed, 19 Jul 2017 14:49:36 +1000
Message-Id: <20170719044946.22030-14-benh@kernel.crashing.org>
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

First, handle the normal retry failure in do_page_fault itself,
since it's a simple return statement. That allows us to remove
the "continue" special return code from mm_fault_error().

Once that's done, we can have an implementation much closer to
x86 where we only call mm_fault_error() if VM_FAULT_ERROR is set
and directly return.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---
 arch/powerpc/mm/fault.c | 66 +++++++++++++++++++++----------------------------
 1 file changed, 28 insertions(+), 38 deletions(-)

diff --git a/arch/powerpc/mm/fault.c b/arch/powerpc/mm/fault.c
index 3903b55fccf8..0b217947d34f 100644
--- a/arch/powerpc/mm/fault.c
+++ b/arch/powerpc/mm/fault.c
@@ -147,10 +147,6 @@ static noinline int bad_area(struct pt_regs *regs, unsigned long address)
 	return __bad_area(regs, address, SEGV_MAPERR);
 }
 
-#define MM_FAULT_RETURN		0
-#define MM_FAULT_CONTINUE	-1
-#define MM_FAULT_ERR(sig)	(sig)
-
 static int do_sigbus(struct pt_regs *regs, unsigned long address,
 		     unsigned int fault)
 {
@@ -158,7 +154,7 @@ static int do_sigbus(struct pt_regs *regs, unsigned long address,
 	unsigned int lsb = 0;
 
 	if (!user_mode(regs))
-		return MM_FAULT_ERR(SIGBUS);
+		return SIGBUS;
 
 	current->thread.trap_nr = BUS_ADRERR;
 	info.si_signo = SIGBUS;
@@ -179,25 +175,17 @@ static int do_sigbus(struct pt_regs *regs, unsigned long address,
 #endif
 	info.si_addr_lsb = lsb;
 	force_sig_info(SIGBUS, &info, current);
-	return MM_FAULT_RETURN;
+	return 0;
 }
 
 static int mm_fault_error(struct pt_regs *regs, unsigned long addr, int fault)
 {
 	/*
-	 * Pagefault was interrupted by SIGKILL. We have no reason to
-	 * continue the pagefault.
+	 * Kernel page fault interrupted by SIGKILL. We have no reason to
+	 * continue processing.
 	 */
-	if (fatal_signal_pending(current)) {
-		/* Coming from kernel, we need to deal with uaccess fixups */
-		if (user_mode(regs))
-			return MM_FAULT_RETURN;
-		return MM_FAULT_ERR(SIGKILL);
-	}
-
-	/* No fault: be happy */
-	if (!(fault & VM_FAULT_ERROR))
-		return MM_FAULT_CONTINUE;
+	if (fatal_signal_pending(current) && !user_mode(regs))
+		return SIGKILL;
 
 	/* Out of memory */
 	if (fault & VM_FAULT_OOM) {
@@ -206,17 +194,18 @@ static int mm_fault_error(struct pt_regs *regs, unsigned long addr, int fault)
 		 * made us unable to handle the page fault gracefully.
 		 */
 		if (!user_mode(regs))
-			return MM_FAULT_ERR(SIGKILL);
+			return SIGSEGV;
 		pagefault_out_of_memory();
-		return MM_FAULT_RETURN;
+	} else {
+		if (fault & (VM_FAULT_SIGBUS|VM_FAULT_HWPOISON|
+			     VM_FAULT_HWPOISON_LARGE))
+			return do_sigbus(regs, addr, fault);
+		else if (fault & VM_FAULT_SIGSEGV)
+			return bad_area_nosemaphore(regs, addr);
+		else
+			BUG();
 	}
-
-	if (fault & (VM_FAULT_SIGBUS|VM_FAULT_HWPOISON|VM_FAULT_HWPOISON_LARGE))
-		return do_sigbus(regs, addr, fault);
-
-	/* We don't understand the fault code, this is fatal */
-	BUG();
-	return MM_FAULT_CONTINUE;
+	return 0;
 }
 
 /* Is this a bad kernel fault ? */
@@ -274,7 +263,7 @@ static int __do_page_fault(struct pt_regs *regs, unsigned long address,
 	int is_user = user_mode(regs);
 	int is_write = page_fault_is_write(error_code);
 	int fault;
-	int rc = 0, store_update_sp = 0;
+	int store_update_sp = 0;
 
 #ifdef CONFIG_PPC_ICSWX
 	/*
@@ -283,7 +272,7 @@ static int __do_page_fault(struct pt_regs *regs, unsigned long address,
 	 * look at it
 	 */
 	if (error_code & ICSWX_DSI_UCT) {
-		rc = acop_handle_fault(regs, address, error_code);
+		int rc = acop_handle_fault(regs, address, error_code);
 		if (rc)
 			return rc;
 	}
@@ -492,18 +481,19 @@ static int __do_page_fault(struct pt_regs *regs, unsigned long address,
 			if (!fatal_signal_pending(current))
 				goto retry;
 		}
-		/* We will enter mm_fault_error() below */
-	} else
-		up_read(&current->mm->mmap_sem);
 
-	if (unlikely(fault & (VM_FAULT_RETRY|VM_FAULT_ERROR))) {
-		if (fault & VM_FAULT_SIGSEGV)
-			return bad_area_nosemaphore(regs, address);
-		rc = mm_fault_error(regs, address, fault);
-		if (rc >= MM_FAULT_RETURN)
-			return rc;
+		/*
+		 * User mode? Just return to handle the fatal exception otherwise
+		 * return to bad_page_fault
+		 */
+		return is_user ? 0 : SIGBUS;
 	}
 
+	up_read(&current->mm->mmap_sem);
+
+	if (unlikely(fault & VM_FAULT_ERROR))
+		return mm_fault_error(regs, address, fault);
+
 	/*
 	 * Major/minor page fault accounting.
 	 */
-- 
2.13.3

Return-Path: <benh@kernel.crashing.org>
Received: from e23smtp06.au.ibm.com (e23smtp06.au.ibm.com [202.81.31.148])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e23smtp06.au.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 32EF2B6FB6
 for <linuxppc-dev@ozlabs.org>; Mon,  5 Mar 2012 13:52:47 +1100 (EST)
Received: from /spool/local
 by e23smtp06.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <benh@kernel.crashing.org>;
 Mon, 5 Mar 2012 02:48:31 +1000
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay05.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 q252kqHw2670672
 for <linuxppc-dev@ozlabs.org>; Mon, 5 Mar 2012 13:46:54 +1100
Received: from d23av04.au.ibm.com (loopback [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 q252qR2d013321
 for <linuxppc-dev@ozlabs.org>; Mon, 5 Mar 2012 13:52:27 +1100
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 08/13] powerpc: Add support for page fault retry and fatal
 signals
Date: Mon,  5 Mar 2012 13:51:26 +1100
Message-Id: <1330915891-19523-9-git-send-email-benh@kernel.crashing.org>
In-Reply-To: <1330915891-19523-1-git-send-email-benh@kernel.crashing.org>
References: <1330915891-19523-1-git-send-email-benh@kernel.crashing.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Other architectures such as x86 and ARM have been growing
new support for features like retrying page faults after
dropping the mm semaphore to break contention, or being
able to return from a stuck page fault when a SIGKILL is
pending.

This refactors our implementation of do_page_fault() to
move the error handling out of line in a way similar to
x86 and adds support for those two features.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---
 arch/powerpc/mm/fault.c |  170 +++++++++++++++++++++++++++++++++--------------
 1 files changed, 120 insertions(+), 50 deletions(-)

diff --git a/arch/powerpc/mm/fault.c b/arch/powerpc/mm/fault.c
index 7e89006..19f2f94 100644
--- a/arch/powerpc/mm/fault.c
+++ b/arch/powerpc/mm/fault.c
@@ -105,6 +105,82 @@ static int store_updates_sp(struct pt_regs *regs)
 	}
 	return 0;
 }
+/*
+ * do_page_fault error handling helpers
+ */
+
+#define MM_FAULT_RETURN		0
+#define MM_FAULT_CONTINUE	-1
+#define MM_FAULT_ERR(sig)	(sig)
+
+static int out_of_memory(struct pt_regs *regs)
+{
+	/*
+	 * We ran out of memory, or some other thing happened to us that made
+	 * us unable to handle the page fault gracefully.
+	 */
+	up_read(&current->mm->mmap_sem);
+	if (!user_mode(regs))
+		return MM_FAULT_ERR(SIGKILL);
+	pagefault_out_of_memory();
+	return MM_FAULT_RETURN;
+}
+
+static int do_sigbus(struct pt_regs *regs, unsigned long address)
+{
+	siginfo_t info;
+
+	up_read(&current->mm->mmap_sem);
+
+	if (user_mode(regs)) {
+		info.si_signo = SIGBUS;
+		info.si_errno = 0;
+		info.si_code = BUS_ADRERR;
+		info.si_addr = (void __user *)address;
+		force_sig_info(SIGBUS, &info, current);
+		return MM_FAULT_RETURN;
+	}
+	return MM_FAULT_ERR(SIGBUS);
+}
+
+static int mm_fault_error(struct pt_regs *regs, unsigned long addr, int fault)
+{
+	/*
+	 * Pagefault was interrupted by SIGKILL. We have no reason to
+	 * continue the pagefault.
+	 */
+	if (fatal_signal_pending(current)) {
+		/*
+		 * If we have retry set, the mmap semaphore will have
+		 * alrady been released in __lock_page_or_retry(). Else
+		 * we release it now.
+		 */
+		if (!(fault & VM_FAULT_RETRY))
+			up_read(&current->mm->mmap_sem);
+		/* Coming from kernel, we need to deal with uaccess fixups */
+		if (user_mode(regs))
+			return MM_FAULT_RETURN;
+		return MM_FAULT_ERR(SIGKILL);
+	}
+
+	/* No fault: be happy */
+	if (!(fault & VM_FAULT_ERROR))
+		return MM_FAULT_CONTINUE;
+
+	/* Out of memory */
+	if (fault & VM_FAULT_OOM)
+		return out_of_memory(regs);
+
+	/* Bus error. x86 handles HWPOISON here, we'll add this if/when
+	 * we support the feature in HW
+	 */
+	if (fault & VM_FAULT_SIGBUS)
+		return do_sigbus(regs, addr);
+
+	/* We don't understand the fault code, this is fatal */
+	BUG();
+	return MM_FAULT_CONTINUE;
+}
 
 /*
  * For 600- and 800-family processors, the error_code parameter is DSISR
@@ -124,11 +200,12 @@ int __kprobes do_page_fault(struct pt_regs *regs, unsigned long address,
 {
 	struct vm_area_struct * vma;
 	struct mm_struct *mm = current->mm;
-	siginfo_t info;
+	unsigned int flags = FAULT_FLAG_ALLOW_RETRY | FAULT_FLAG_KILLABLE;
 	int code = SEGV_MAPERR;
-	int is_write = 0, ret;
+	int is_write = 0;
 	int trap = TRAP(regs);
  	int is_exec = trap == 0x400;
+	int fault;
 
 #if !(defined(CONFIG_4xx) || defined(CONFIG_BOOKE))
 	/*
@@ -145,6 +222,9 @@ int __kprobes do_page_fault(struct pt_regs *regs, unsigned long address,
 	is_write = error_code & ESR_DST;
 #endif /* CONFIG_4xx || CONFIG_BOOKE */
 
+	if (is_write)
+		flags |= FAULT_FLAG_WRITE;
+
 #ifdef CONFIG_PPC_ICSWX
 	/*
 	 * we need to do this early because this "data storage
@@ -152,13 +232,11 @@ int __kprobes do_page_fault(struct pt_regs *regs, unsigned long address,
 	 * look at it
 	 */
 	if (error_code & ICSWX_DSI_UCT) {
-		int ret;
-
-		ret = acop_handle_fault(regs, address, error_code);
-		if (ret)
-			return ret;
+		int rc = acop_handle_fault(regs, address, error_code);
+		if (rc)
+			return rc;
 	}
-#endif
+#endif /* CONFIG_PPC_ICSWX */
 
 	if (notify_page_fault(regs))
 		return 0;
@@ -216,6 +294,7 @@ int __kprobes do_page_fault(struct pt_regs *regs, unsigned long address,
 		if (!user_mode(regs) && !search_exception_tables(regs->nip))
 			goto bad_area_nosemaphore;
 
+retry:
 		down_read(&mm->mmap_sem);
 	} else {
 		/*
@@ -338,30 +417,43 @@ good_area:
 	 * make sure we exit gracefully rather than endlessly redo
 	 * the fault.
 	 */
-	ret = handle_mm_fault(mm, vma, address, is_write ? FAULT_FLAG_WRITE : 0);
-	if (unlikely(ret & VM_FAULT_ERROR)) {
-		if (ret & VM_FAULT_OOM)
-			goto out_of_memory;
-		else if (ret & VM_FAULT_SIGBUS)
-			goto do_sigbus;
-		BUG();
+	fault = handle_mm_fault(mm, vma, address, flags);
+	if (unlikely(fault & (VM_FAULT_RETRY|VM_FAULT_ERROR))) {
+		int rc = mm_fault_error(regs, address, fault);
+		if (rc >= MM_FAULT_RETURN)
+			return rc;
 	}
-	if (ret & VM_FAULT_MAJOR) {
-		current->maj_flt++;
-		perf_sw_event(PERF_COUNT_SW_PAGE_FAULTS_MAJ, 1,
-				     regs, address);
+
+	/*
+	 * Major/minor page fault accounting is only done on the
+	 * initial attempt. If we go through a retry, it is extremely
+	 * likely that the page will be found in page cache at that point.
+	 */
+	if (flags & FAULT_FLAG_ALLOW_RETRY) {
+		if (fault & VM_FAULT_MAJOR) {
+			current->maj_flt++;
+			perf_sw_event(PERF_COUNT_SW_PAGE_FAULTS_MAJ, 1,
+				      regs, address);
 #ifdef CONFIG_PPC_SMLPAR
-		if (firmware_has_feature(FW_FEATURE_CMO)) {
-			preempt_disable();
-			get_lppaca()->page_ins += (1 << PAGE_FACTOR);
-			preempt_enable();
+			if (firmware_has_feature(FW_FEATURE_CMO)) {
+				preempt_disable();
+				get_lppaca()->page_ins += (1 << PAGE_FACTOR);
+				preempt_enable();
+			}
+#endif /* CONFIG_PPC_SMLPAR */
+		} else {
+			current->min_flt++;
+			perf_sw_event(PERF_COUNT_SW_PAGE_FAULTS_MIN, 1,
+				      regs, address);
+		}
+		if (fault & VM_FAULT_RETRY) {
+			/* Clear FAULT_FLAG_ALLOW_RETRY to avoid any risk
+			 * of starvation. */
+			flags &= ~FAULT_FLAG_ALLOW_RETRY;
+			goto retry;
 		}
-#endif
-	} else {
-		current->min_flt++;
-		perf_sw_event(PERF_COUNT_SW_PAGE_FAULTS_MIN, 1,
-				     regs, address);
 	}
+
 	up_read(&mm->mmap_sem);
 	return 0;
 
@@ -382,28 +474,6 @@ bad_area_nosemaphore:
 
 	return SIGSEGV;
 
-/*
- * We ran out of memory, or some other thing happened to us that made
- * us unable to handle the page fault gracefully.
- */
-out_of_memory:
-	up_read(&mm->mmap_sem);
-	if (!user_mode(regs))
-		return SIGKILL;
-	pagefault_out_of_memory();
-	return 0;
-
-do_sigbus:
-	up_read(&mm->mmap_sem);
-	if (user_mode(regs)) {
-		info.si_signo = SIGBUS;
-		info.si_errno = 0;
-		info.si_code = BUS_ADRERR;
-		info.si_addr = (void __user *)address;
-		force_sig_info(SIGBUS, &info, current);
-		return 0;
-	}
-	return SIGBUS;
 }
 
 /*
-- 
1.7.9

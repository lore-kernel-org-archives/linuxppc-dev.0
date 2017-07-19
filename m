Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xC4Wt0l57zDrJf
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 19 Jul 2017 14:57:13 +1000 (AEST)
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: linuxppc-dev@lists.ozlabs.org
Cc: aneesh.kumar@linux.vnet.ibm.com,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [PATCH 13/24] powerpc/mm: Make bad_area* helper functions
Date: Wed, 19 Jul 2017 14:49:35 +1000
Message-Id: <20170719044946.22030-13-benh@kernel.crashing.org>
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

Instead of goto labels, instead call those functions and return.

This gets us closer to x86 and allows us to shring do_page_fault()
even more.

The main difference with x86 is that those function return a value
which we then return from do_page_fault(). That value is our
return value from do_page_fault() which we use to generate
kernel faults.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---
 arch/powerpc/mm/fault.c | 78 +++++++++++++++++++++++++++++++------------------
 1 file changed, 50 insertions(+), 28 deletions(-)

diff --git a/arch/powerpc/mm/fault.c b/arch/powerpc/mm/fault.c
index aead07cf8a5b..3903b55fccf8 100644
--- a/arch/powerpc/mm/fault.c
+++ b/arch/powerpc/mm/fault.c
@@ -108,6 +108,45 @@ static int store_updates_sp(struct pt_regs *regs)
  * do_page_fault error handling helpers
  */
 
+static int
+__bad_area_nosemaphore(struct pt_regs *regs, unsigned long address, int si_code)
+{
+	/*
+	 * If we are in kernel mode, bail out with a SEGV, this will
+	 * be caught by the assembly which will restore the non-volatile
+	 * registers before calling bad_page_fault()
+	 */
+	if (!user_mode(regs))
+		return SIGSEGV;
+
+	_exception(SIGSEGV, regs, si_code, address);
+
+	return 0;
+}
+
+static noinline int bad_area_nosemaphore(struct pt_regs *regs, unsigned long address)
+{
+	return __bad_area_nosemaphore(regs, address, SEGV_MAPERR);
+}
+
+static int __bad_area(struct pt_regs *regs, unsigned long address, int si_code)
+{
+	struct mm_struct *mm = current->mm;
+
+	/*
+	 * Something tried to access memory that isn't in our memory map..
+	 * Fix it, but check if it's kernel or user first..
+	 */
+	up_read(&mm->mmap_sem);
+
+	return __bad_area_nosemaphore(regs, address, si_code);
+}
+
+static noinline int bad_area(struct pt_regs *regs, unsigned long address)
+{
+	return __bad_area(regs, address, SEGV_MAPERR);
+}
+
 #define MM_FAULT_RETURN		0
 #define MM_FAULT_CONTINUE	-1
 #define MM_FAULT_ERR(sig)	(sig)
@@ -231,7 +270,6 @@ static int __do_page_fault(struct pt_regs *regs, unsigned long address,
 	struct vm_area_struct * vma;
 	struct mm_struct *mm = current->mm;
 	unsigned int flags = FAULT_FLAG_ALLOW_RETRY | FAULT_FLAG_KILLABLE;
-	int code = SEGV_MAPERR;
  	int is_exec = TRAP(regs) == 0x400;
 	int is_user = user_mode(regs);
 	int is_write = page_fault_is_write(error_code);
@@ -317,7 +355,7 @@ static int __do_page_fault(struct pt_regs *regs, unsigned long address,
 	 */
 	if (!down_read_trylock(&mm->mmap_sem)) {
 		if (!is_user && !search_exception_tables(regs->nip))
-			goto bad_area_nosemaphore;
+			return bad_area_nosemaphore(regs, address);
 
 retry:
 		down_read(&mm->mmap_sem);
@@ -332,11 +370,11 @@ static int __do_page_fault(struct pt_regs *regs, unsigned long address,
 
 	vma = find_vma(mm, address);
 	if (!vma)
-		goto bad_area;
+		return bad_area(regs, address);
 	if (vma->vm_start <= address)
 		goto good_area;
 	if (!(vma->vm_flags & VM_GROWSDOWN))
-		goto bad_area;
+		return bad_area(regs, address);
 
 	/*
 	 * N.B. The POWER/Open ABI allows programs to access up to
@@ -351,7 +389,7 @@ static int __do_page_fault(struct pt_regs *regs, unsigned long address,
 		/* get user regs even if this fault is in kernel mode */
 		struct pt_regs *uregs = current->thread.regs;
 		if (uregs == NULL)
-			goto bad_area;
+			return bad_area(regs, address);
 
 		/*
 		 * A user-mode access to an address a long way below
@@ -366,14 +404,12 @@ static int __do_page_fault(struct pt_regs *regs, unsigned long address,
 		 * expand the stack rather than segfaulting.
 		 */
 		if (address + 2048 < uregs->gpr[1] && !store_update_sp)
-			goto bad_area;
+			return bad_area(regs, address);
 	}
 	if (expand_stack(vma, address))
-		goto bad_area;
+		return bad_area(regs, address);
 
 good_area:
-	code = SEGV_ACCERR;
-
 	if (is_exec) {
 		/*
 		 * Allow execution from readable areas if the MMU does not
@@ -388,16 +424,16 @@ static int __do_page_fault(struct pt_regs *regs, unsigned long address,
 		if (!(vma->vm_flags & VM_EXEC) &&
 		    (cpu_has_feature(CPU_FTR_NOEXECUTE) ||
 		     !(vma->vm_flags & (VM_READ | VM_WRITE))))
-			goto bad_area;
+			return bad_area(regs, address);
 	/* a write */
 	} else if (is_write) {
 		if (!(vma->vm_flags & VM_WRITE))
-			goto bad_area;
+			return bad_area(regs, address);
 		flags |= FAULT_FLAG_WRITE;
 	/* a read */
 	} else {
 		if (!(vma->vm_flags & (VM_READ | VM_EXEC | VM_WRITE)))
-			goto bad_area;
+			return bad_area(regs, address);
 	}
 #ifdef CONFIG_PPC_STD_MMU
 	/*
@@ -462,11 +498,10 @@ static int __do_page_fault(struct pt_regs *regs, unsigned long address,
 
 	if (unlikely(fault & (VM_FAULT_RETRY|VM_FAULT_ERROR))) {
 		if (fault & VM_FAULT_SIGSEGV)
-			goto bad_area_nosemaphore;
+			return bad_area_nosemaphore(regs, address);
 		rc = mm_fault_error(regs, address, fault);
 		if (rc >= MM_FAULT_RETURN)
 			return rc;
-		rc = 0;
 	}
 
 	/*
@@ -492,20 +527,7 @@ static int __do_page_fault(struct pt_regs *regs, unsigned long address,
 		perf_sw_event(PERF_COUNT_SW_PAGE_FAULTS_MIN, 1,
 			      regs, address);
 	}
-
-	return rc;
-
-bad_area:
-	up_read(&mm->mmap_sem);
-
-bad_area_nosemaphore:
-	/* User mode accesses cause a SIGSEGV */
-	if (is_user) {
-		_exception(SIGSEGV, regs, code, address);
-		return 0;
-	}
-
-	return SIGSEGV;
+	return 0;
 }
 NOKPROBE_SYMBOL(__do_page_fault);
 
-- 
2.13.3

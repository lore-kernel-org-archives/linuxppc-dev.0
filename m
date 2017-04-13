Return-Path: <christophe.leroy@c-s.fr>
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3w3kLy3qXPzDq5b
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 14 Apr 2017 00:53:46 +1000 (AEST)
From: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH] powerpc/mm: some cleanup of do_page_fault()
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Scott Wood <oss@buserror.net>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Message-Id: <20170413145342.40ED56E667@localhost.localdomain>
Date: Thu, 13 Apr 2017 16:53:42 +0200 (CEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This patch is a bunch of small cleanups of the do_page_fault()
function:
1/ Function store_updates_sp() checks whether the faulting
instruction is a store updating r1. Therefore we can limit its calls
to stores exceptions
2/ Only the get_user() in store_updates_sp() has to be done outside
the mm semaphore. All the comparison can be done within the semaphore,
so only when really needed.
3/ As we got a DSI exception, the address pointed by regs->nip is
obviously valid, otherwise we would have had a instruction exception.
So __get_user() can be used instead of get_user()
4/ Replaced one duplicate 'trap == 0x400' by 'is_exec'
5/ Created a 'is_user = user_mode(regs)' and replaced all
'user_mode(regs)'.
Analysis of the assembly code shows that when using user_mode(regs),
at least the 'andi. r7,r8,16384' is redone several times, and also
the 'lwz r8,132(r31)' at times. With the new form, the 'is_user'
is mapped to cr4, then all further use of is_user results in just
things like 'beq cr4,218 <do_page_fault+0x218>'
6/ The 8xx has a dedicated exception for breakpoints, that directly
calls do_break()
7/ stdu and stdux only exist on PPC64, so no need to check for them
on PPC32

With this patch, on PPC8xx the size of do_page_fault() is reduced by
12% (from 1420 bytes to 1248 bytes)

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 arch/powerpc/mm/fault.c | 34 ++++++++++++++++++----------------
 1 file changed, 18 insertions(+), 16 deletions(-)

diff --git a/arch/powerpc/mm/fault.c b/arch/powerpc/mm/fault.c
index 3a7d580fdc59..5aa43268baca 100644
--- a/arch/powerpc/mm/fault.c
+++ b/arch/powerpc/mm/fault.c
@@ -73,12 +73,8 @@ static inline int notify_page_fault(struct pt_regs *regs)
  * Check whether the instruction at regs->nip is a store using
  * an update addressing form which will update r1.
  */
-static int store_updates_sp(struct pt_regs *regs)
+static int store_updates_sp(unsigned int inst)
 {
-	unsigned int inst;
-
-	if (get_user(inst, (unsigned int __user *)regs->nip))
-		return 0;
 	/* check for 1 in the rA field */
 	if (((inst >> 16) & 0x1f) != 1)
 		return 0;
@@ -90,12 +86,16 @@ static int store_updates_sp(struct pt_regs *regs)
 	case 53:	/* stfsu */
 	case 55:	/* stfdu */
 		return 1;
+#ifdef CONFIG_PPC64
 	case 62:	/* std or stdu */
 		return (inst & 3) == 1;
+#endif
 	case 31:
 		/* check minor opcode */
 		switch ((inst >> 1) & 0x3ff) {
+#ifdef CONFIG_PPC64
 		case 181:	/* stdux */
+#endif
 		case 183:	/* stwux */
 		case 247:	/* stbux */
 		case 439:	/* sthux */
@@ -207,7 +207,9 @@ int do_page_fault(struct pt_regs *regs, unsigned long address,
 	int trap = TRAP(regs);
  	int is_exec = trap == 0x400;
 	int fault;
-	int rc = 0, store_update_sp = 0;
+	int rc = 0;
+	int is_user = user_mode(regs);
+	unsigned int inst = 0;
 
 #if !(defined(CONFIG_4xx) || defined(CONFIG_BOOKE))
 	/*
@@ -216,7 +218,7 @@ int do_page_fault(struct pt_regs *regs, unsigned long address,
 	 * bits we are interested in.  But there are some bits which
 	 * indicate errors in DSISR but can validly be set in SRR1.
 	 */
-	if (trap == 0x400)
+	if (is_exec)
 		error_code &= 0x48200000;
 	else
 		is_write = error_code & DSISR_ISSTORE;
@@ -247,13 +249,13 @@ int do_page_fault(struct pt_regs *regs, unsigned long address,
 	 * The kernel should never take an execute fault nor should it
 	 * take a page fault to a kernel address.
 	 */
-	if (!user_mode(regs) && (is_exec || (address >= TASK_SIZE))) {
+	if (!is_user && (is_exec || (address >= TASK_SIZE))) {
 		rc = SIGSEGV;
 		goto bail;
 	}
 
 #if !(defined(CONFIG_4xx) || defined(CONFIG_BOOKE) || \
-			     defined(CONFIG_PPC_BOOK3S_64))
+      defined(CONFIG_PPC_BOOK3S_64) || defined(CONFIG_PPC_8xx))
   	if (error_code & DSISR_DABRMATCH) {
 		/* breakpoint match */
 		do_break(regs, address, error_code);
@@ -266,7 +268,7 @@ int do_page_fault(struct pt_regs *regs, unsigned long address,
 		local_irq_enable();
 
 	if (faulthandler_disabled() || mm == NULL) {
-		if (!user_mode(regs)) {
+		if (!is_user) {
 			rc = SIGSEGV;
 			goto bail;
 		}
@@ -287,10 +289,10 @@ int do_page_fault(struct pt_regs *regs, unsigned long address,
 	 * can result in fault, which will cause a deadlock when called with
 	 * mmap_sem held
 	 */
-	if (!is_exec && user_mode(regs))
-		store_update_sp = store_updates_sp(regs);
+	if (is_write && is_user)
+		__get_user(inst, (unsigned int __user *)regs->nip);
 
-	if (user_mode(regs))
+	if (is_user)
 		flags |= FAULT_FLAG_USER;
 
 	/* When running in the kernel we expect faults to occur only to
@@ -309,7 +311,7 @@ int do_page_fault(struct pt_regs *regs, unsigned long address,
 	 * thus avoiding the deadlock.
 	 */
 	if (!down_read_trylock(&mm->mmap_sem)) {
-		if (!user_mode(regs) && !search_exception_tables(regs->nip))
+		if (!is_user && !search_exception_tables(regs->nip))
 			goto bad_area_nosemaphore;
 
 retry:
@@ -358,7 +360,7 @@ int do_page_fault(struct pt_regs *regs, unsigned long address,
 		 * between the last mapped region and the stack will
 		 * expand the stack rather than segfaulting.
 		 */
-		if (address + 2048 < uregs->gpr[1] && !store_update_sp)
+		if (address + 2048 < uregs->gpr[1] && !store_updates_sp(inst))
 			goto bad_area;
 	}
 	if (expand_stack(vma, address))
@@ -509,7 +511,7 @@ int do_page_fault(struct pt_regs *regs, unsigned long address,
 
 bad_area_nosemaphore:
 	/* User mode accesses cause a SIGSEGV */
-	if (user_mode(regs)) {
+	if (is_user) {
 		_exception(SIGSEGV, regs, code, address);
 		goto bail;
 	}
-- 
2.12.0

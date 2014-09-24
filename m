Return-Path: <anton@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4C4F21A0053
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 24 Sep 2014 10:27:09 +1000 (EST)
From: Anton Blanchard <anton@samba.org>
To: benh@kernel.crashing.org,
	paulus@samba.org,
	mpe@ellerman.id.au
Subject: [PATCH 1/2] powerpc: Add VM_FAULT_HWPOISON handling to powerpc page
 fault handler
Date: Wed, 24 Sep 2014 10:27:06 +1000
Message-Id: <1411518427-14408-1-git-send-email-anton@samba.org>
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

do_page_fault was missing knowledge of HWPOISON, and we would oops
if userspace tried to access a poisoned page:

kernel BUG at arch/powerpc/mm/fault.c:180!

Signed-off-by: Anton Blanchard <anton@samba.org>
---
 arch/powerpc/mm/fault.c | 36 +++++++++++++++++++++---------------
 1 file changed, 21 insertions(+), 15 deletions(-)

diff --git a/arch/powerpc/mm/fault.c b/arch/powerpc/mm/fault.c
index 51ab9e7..c3728c1 100644
--- a/arch/powerpc/mm/fault.c
+++ b/arch/powerpc/mm/fault.c
@@ -114,22 +114,31 @@ static int store_updates_sp(struct pt_regs *regs)
 #define MM_FAULT_CONTINUE	-1
 #define MM_FAULT_ERR(sig)	(sig)
 
-static int do_sigbus(struct pt_regs *regs, unsigned long address)
+static int do_sigbus(struct pt_regs *regs, unsigned long address,
+		     unsigned int fault)
 {
 	siginfo_t info;
 
 	up_read(&current->mm->mmap_sem);
 
-	if (user_mode(regs)) {
-		current->thread.trap_nr = BUS_ADRERR;
-		info.si_signo = SIGBUS;
-		info.si_errno = 0;
-		info.si_code = BUS_ADRERR;
-		info.si_addr = (void __user *)address;
-		force_sig_info(SIGBUS, &info, current);
-		return MM_FAULT_RETURN;
+	if (!user_mode(regs))
+		return MM_FAULT_ERR(SIGBUS);
+
+	current->thread.trap_nr = BUS_ADRERR;
+	info.si_signo = SIGBUS;
+	info.si_errno = 0;
+	info.si_code = BUS_ADRERR;
+	info.si_addr = (void __user *)address;
+
+#ifdef CONFIG_MEMORY_FAILURE
+	if (fault & (VM_FAULT_HWPOISON|VM_FAULT_HWPOISON_LARGE)) {
+		pr_err("MCE: Killing %s:%d due to hardware memory corruption fault at %lx\n",
+			current->comm, current->pid, address);
+		info.si_code = BUS_MCEERR_AR;
 	}
-	return MM_FAULT_ERR(SIGBUS);
+#endif
+	force_sig_info(SIGBUS, &info, current);
+	return MM_FAULT_RETURN;
 }
 
 static int mm_fault_error(struct pt_regs *regs, unsigned long addr, int fault)
@@ -170,11 +179,8 @@ static int mm_fault_error(struct pt_regs *regs, unsigned long addr, int fault)
 		return MM_FAULT_RETURN;
 	}
 
-	/* Bus error. x86 handles HWPOISON here, we'll add this if/when
-	 * we support the feature in HW
-	 */
-	if (fault & VM_FAULT_SIGBUS)
-		return do_sigbus(regs, addr);
+	if (fault & (VM_FAULT_SIGBUS|VM_FAULT_HWPOISON|VM_FAULT_HWPOISON_LARGE))
+		return do_sigbus(regs, addr, fault);
 
 	/* We don't understand the fault code, this is fatal */
 	BUG();
-- 
1.9.1

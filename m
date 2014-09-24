Return-Path: <anton@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 21B8B1A06FA
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 24 Sep 2014 17:00:02 +1000 (EST)
From: Anton Blanchard <anton@samba.org>
To: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
 amodra@gmail.com, torvalds@linux-foundation.org, sfr@canb.auug.org.au
Subject: [PATCH 2/3] powerpc: Add VM_FAULT_HWPOISON handling to powerpc page
 fault handler
Date: Wed, 24 Sep 2014 16:59:57 +1000
Message-Id: <1411541999-21457-2-git-send-email-anton@samba.org>
In-Reply-To: <1411541999-21457-1-git-send-email-anton@samba.org>
References: <1411541999-21457-1-git-send-email-anton@samba.org>
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
 arch/powerpc/mm/fault.c | 17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

diff --git a/arch/powerpc/mm/fault.c b/arch/powerpc/mm/fault.c
index abc8c81..588b6cc 100644
--- a/arch/powerpc/mm/fault.c
+++ b/arch/powerpc/mm/fault.c
@@ -114,7 +114,8 @@ static int store_updates_sp(struct pt_regs *regs)
 #define MM_FAULT_CONTINUE	-1
 #define MM_FAULT_ERR(sig)	(sig)
 
-static int do_sigbus(struct pt_regs *regs, unsigned long address)
+static int do_sigbus(struct pt_regs *regs, unsigned long address,
+		     unsigned int fault)
 {
 	siginfo_t info;
 
@@ -128,6 +129,13 @@ static int do_sigbus(struct pt_regs *regs, unsigned long address)
 	info.si_errno = 0;
 	info.si_code = BUS_ADRERR;
 	info.si_addr = (void __user *)address;
+#ifdef CONFIG_MEMORY_FAILURE
+	if (fault & (VM_FAULT_HWPOISON|VM_FAULT_HWPOISON_LARGE)) {
+		pr_err("MCE: Killing %s:%d due to hardware memory corruption fault at %lx\n",
+			current->comm, current->pid, address);
+		info.si_code = BUS_MCEERR_AR;
+	}
+#endif
 	force_sig_info(SIGBUS, &info, current);
 	return MM_FAULT_RETURN;
 }
@@ -170,11 +178,8 @@ static int mm_fault_error(struct pt_regs *regs, unsigned long addr, int fault)
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

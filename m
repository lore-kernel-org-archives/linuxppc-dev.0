Return-Path: <fweisbec@gmail.com>
Received: from mail-wy0-f179.google.com (mail-wy0-f179.google.com
	[74.125.82.179]) (using TLSv1 with cipher RC4-SHA (128/128 bits))
	(Client CN "smtp.gmail.com",
	Issuer "Google Internet Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 20AC0B6F67
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri,  6 May 2011 09:53:30 +1000 (EST)
Received: by wyg36 with SMTP id 36so2288608wyg.38
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 05 May 2011 16:53:25 -0700 (PDT)
From: Frederic Weisbecker <fweisbec@gmail.com>
To: Ingo Molnar <mingo@elte.hu>
Subject: [PATCH] powerpc,
	hw_breakpoints: Fix CONFIG_HAVE_HW_BREAKPOINT off-case in
	ptrace_set_debugreg
Date: Fri,  6 May 2011 01:53:18 +0200
Message-Id: <1304639598-4707-1-git-send-email-fweisbec@gmail.com>
Cc: Frederic Weisbecker <fweisbec@gmail.com>,
	LPPC <linuxppc-dev@lists.ozlabs.org>, LKML <linux-kernel@vger.kernel.org>,
	Prasad <prasad@linux.vnet.ibm.com>, "v2.6.33.." <stable@kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

We make use of ptrace_get_breakpoints() / ptrace_put_breakpoints()
to protect ptrace_set_debugreg() even if CONFIG_HAVE_HW_BREAKPOINT
if off. However in this case, these APIs are not implemented.

To fix this, push the protection down inside the relevant ifdef.
Best would be to export the code inside CONFIG_HAVE_HW_BREAKPOINT
into a standalone function to cleanup the ifdefury there and call
the breakpoint ref API inside. But as it is more invasive, this
should be rather made in an -rc1.

Fixes:

arch/powerpc/kernel/ptrace.c:1594: error: implicit declaration of function 'ptrace_get_breakpoints'
make[2]: *** [arch/powerpc/kernel/ptrace.o] Error 1
make[1]: *** [arch/powerpc/kernel] Error 2
make: *** [sub-make] Error 2

Reported-by: Ingo Molnar <mingo@elte.hu>
Signed-off-by: Frederic Weisbecker <fweisbec@gmail.com>
Cc: Prasad <prasad@linux.vnet.ibm.com>
Cc: v2.6.33.. <stable@kernel.org>
---
 arch/powerpc/kernel/ptrace.c |   15 +++++++++++----
 1 files changed, 11 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/kernel/ptrace.c b/arch/powerpc/kernel/ptrace.c
index 4edeeb3..a6ae1cf 100644
--- a/arch/powerpc/kernel/ptrace.c
+++ b/arch/powerpc/kernel/ptrace.c
@@ -933,12 +933,16 @@ int ptrace_set_debugreg(struct task_struct *task, unsigned long addr,
 	if (data && !(data & DABR_TRANSLATION))
 		return -EIO;
 #ifdef CONFIG_HAVE_HW_BREAKPOINT
+	if (ptrace_get_breakpoints(task) < 0)
+		return -ESRCH;
+
 	bp = thread->ptrace_bps[0];
 	if ((!data) || !(data & (DABR_DATA_WRITE | DABR_DATA_READ))) {
 		if (bp) {
 			unregister_hw_breakpoint(bp);
 			thread->ptrace_bps[0] = NULL;
 		}
+		ptrace_put_breakpoints(task);
 		return 0;
 	}
 	if (bp) {
@@ -948,9 +952,12 @@ int ptrace_set_debugreg(struct task_struct *task, unsigned long addr,
 					(DABR_DATA_WRITE | DABR_DATA_READ),
 							&attr.bp_type);
 		ret =  modify_user_hw_breakpoint(bp, &attr);
-		if (ret)
+		if (ret) {
+			ptrace_put_breakpoints(task);
 			return ret;
+		}
 		thread->ptrace_bps[0] = bp;
+		ptrace_put_breakpoints(task);
 		thread->dabr = data;
 		return 0;
 	}
@@ -965,9 +972,12 @@ int ptrace_set_debugreg(struct task_struct *task, unsigned long addr,
 							ptrace_triggered, task);
 	if (IS_ERR(bp)) {
 		thread->ptrace_bps[0] = NULL;
+		ptrace_put_breakpoints(task);
 		return PTR_ERR(bp);
 	}
 
+	ptrace_put_breakpoints(task);
+
 #endif /* CONFIG_HAVE_HW_BREAKPOINT */
 
 	/* Move contents to the DABR register */
@@ -1591,10 +1601,7 @@ long arch_ptrace(struct task_struct *child, long request,
 	}
 
 	case PTRACE_SET_DEBUGREG:
-		if (ptrace_get_breakpoints(child) < 0)
-			return -ESRCH;
 		ret = ptrace_set_debugreg(child, addr, data);
-		ptrace_put_breakpoints(child);
 		break;
 
 #ifdef CONFIG_PPC64
-- 
1.7.3.2

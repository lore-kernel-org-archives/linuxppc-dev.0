Return-Path: <bounces.tip@hpa.at.zytor.com>
Received: from hera.kernel.org (hera.kernel.org [140.211.167.34])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id F1C0FB6F53
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri,  6 May 2011 19:43:26 +1000 (EST)
Date: Fri, 6 May 2011 09:43:03 GMT
Sender: tip tree robot <bounces.tip@hpa.at.zytor.com>
From: tip-bot for Frederic Weisbecker <fweisbec@gmail.com>
Message-ID: <tip-925f83c085e1bb08435556c5b4844a60de002e31@git.kernel.org>
In-Reply-To: <1304639598-4707-1-git-send-email-fweisbec@gmail.com>
References: <1304639598-4707-1-git-send-email-fweisbec@gmail.com>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:perf/urgent] hw_breakpoints,
	powerpc: Fix CONFIG_HAVE_HW_BREAKPOINT off-case in
	ptrace_set_debugreg()
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: fweisbec@gmail.com, mingo@elte.hu, linux-kernel@vger.kernel.org,
	mingo@redhat.com, prasad@linux.vnet.ibm.com, hpa@zytor.com,
	tglx@linutronix.de, linuxppc-dev@lists.ozlabs.org, stable@kernel.org
Reply-To: mingo@redhat.com, hpa@zytor.com, linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org, fweisbec@gmail.com,
	stable@kernel.org, tglx@linutronix.de, mingo@elte.hu,
	prasad@linux.vnet.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Commit-ID:  925f83c085e1bb08435556c5b4844a60de002e31
Gitweb:     http://git.kernel.org/tip/925f83c085e1bb08435556c5b4844a60de002e31
Author:     Frederic Weisbecker <fweisbec@gmail.com>
AuthorDate: Fri, 6 May 2011 01:53:18 +0200
Committer:  Ingo Molnar <mingo@elte.hu>
CommitDate: Fri, 6 May 2011 11:24:46 +0200

hw_breakpoints, powerpc: Fix CONFIG_HAVE_HW_BREAKPOINT off-case in ptrace_set_debugreg()

We make use of ptrace_get_breakpoints() / ptrace_put_breakpoints() to
protect ptrace_set_debugreg() even if CONFIG_HAVE_HW_BREAKPOINT if off.
However in this case, these APIs are not implemented.

To fix this, push the protection down inside the relevant ifdef.
Best would be to export the code inside
CONFIG_HAVE_HW_BREAKPOINT into a standalone function to cleanup
the ifdefury there and call the breakpoint ref API inside. But
as it is more invasive, this should be rather made in an -rc1.

Fixes this build error:

  arch/powerpc/kernel/ptrace.c:1594: error: implicit declaration of function 'ptrace_get_breakpoints' make[2]: ***

Reported-by: Ingo Molnar <mingo@elte.hu>
Signed-off-by: Frederic Weisbecker <fweisbec@gmail.com>
Cc: LPPC <linuxppc-dev@lists.ozlabs.org>
Cc: Prasad <prasad@linux.vnet.ibm.com>
Cc: v2.6.33.. <stable@kernel.org>
Link: http://lkml.kernel.org/r/1304639598-4707-1-git-send-email-fweisbec@gmail.com
Signed-off-by: Ingo Molnar <mingo@elte.hu>
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

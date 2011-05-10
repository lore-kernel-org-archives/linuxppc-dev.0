Return-Path: <greg@kroah.com>
Received: from coco.kroah.org (kroah.org [198.145.64.141])
	(using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "coco.kroah.org", Issuer "Greg KH" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id CBA7C10099F
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 10 May 2011 10:17:54 +1000 (EST)
Subject: Patch "hw_breakpoints,
	powerpc: Fix CONFIG_HAVE_HW_BREAKPOINT off-case in
	ptrace_set_debugreg()" has been added to the 2.6.38-stable tree
To: fweisbec@gmail.com, gregkh@suse.de, linuxppc-dev@lists.ozlabs.org,
	mingo@elte.hu, prasad@linux.vnet.ibm.com
From: <gregkh@suse.de>
Date: Mon, 09 May 2011 17:10:40 -0700
Message-ID: <13049862401464@kroah.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Cc: stable@kernel.org, stable-commits@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


This is a note to let you know that I've just added the patch titled

    hw_breakpoints, powerpc: Fix CONFIG_HAVE_HW_BREAKPOINT off-case in ptrace_set_debugreg()

to the 2.6.38-stable tree which can be found at:
    http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary

The filename of the patch is:
     hw_breakpoints-powerpc-fix-config_have_hw_breakpoint-off-case-in-ptrace_set_debugreg.patch
and it can be found in the queue-2.6.38 subdirectory.

If you, or anyone else, feels it should not be added to the stable tree,
please let <stable@kernel.org> know about it.


>From 925f83c085e1bb08435556c5b4844a60de002e31 Mon Sep 17 00:00:00 2001
From: Frederic Weisbecker <fweisbec@gmail.com>
Date: Fri, 6 May 2011 01:53:18 +0200
Subject: hw_breakpoints, powerpc: Fix CONFIG_HAVE_HW_BREAKPOINT off-case in ptrace_set_debugreg()

From: Frederic Weisbecker <fweisbec@gmail.com>

commit 925f83c085e1bb08435556c5b4844a60de002e31 upstream.

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
Link: http://lkml.kernel.org/r/1304639598-4707-1-git-send-email-fweisbec@gmail.com
Signed-off-by: Ingo Molnar <mingo@elte.hu>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
 arch/powerpc/kernel/ptrace.c |   12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

--- a/arch/powerpc/kernel/ptrace.c
+++ b/arch/powerpc/kernel/ptrace.c
@@ -924,12 +924,16 @@ int ptrace_set_debugreg(struct task_stru
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
@@ -939,9 +943,12 @@ int ptrace_set_debugreg(struct task_stru
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
@@ -956,9 +963,12 @@ int ptrace_set_debugreg(struct task_stru
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


Patches currently in stable-queue which might be from fweisbec@gmail.com are

queue-2.6.38/ptrace-prepare-to-fix-racy-accesses-on-task-breakpoints.patch
queue-2.6.38/hw_breakpoints-powerpc-fix-config_have_hw_breakpoint-off-case-in-ptrace_set_debugreg.patch
queue-2.6.38/x86-hw_breakpoints-fix-racy-access-to-ptrace-breakpoints.patch

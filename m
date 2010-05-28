Return-Path: <prasad@linux.vnet.ibm.com>
Received: from e23smtp04.au.ibm.com (e23smtp04.au.ibm.com [202.81.31.146])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e23smtp04.au.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 13759B7D4C
	for <linuxppc-dev@ozlabs.org>; Fri, 28 May 2010 16:41:42 +1000 (EST)
Received: from d23relay04.au.ibm.com (d23relay04.au.ibm.com [202.81.31.246])
	by e23smtp04.au.ibm.com (8.14.3/8.13.1) with ESMTP id o4S6bZDw001297
	for <linuxppc-dev@ozlabs.org>; Fri, 28 May 2010 16:37:35 +1000
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
	by d23relay04.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	o4S6fftx1749098
	for <linuxppc-dev@ozlabs.org>; Fri, 28 May 2010 16:41:41 +1000
Received: from d23av02.au.ibm.com (loopback [127.0.0.1])
	by d23av02.au.ibm.com (8.14.3/8.13.1/NCO v10.0 AVout) with ESMTP id
	o4S6fe78032656
	for <linuxppc-dev@ozlabs.org>; Fri, 28 May 2010 16:41:41 +1000
Date: Fri, 28 May 2010 12:11:35 +0530
From: "K.Prasad" <prasad@linux.vnet.ibm.com>
To: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>,
	Paul Mackerras <paulus@samba.org>
Subject: [Patch 5/5] PPC64-HWBKPT: Discard extraneous interrupt due to
	accesses outside symbol length
Message-ID: <20100528064135.GF8679@in.ibm.com>
References: <20100528061928.677651410@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Michael Neuling <mikey@neuling.org>,
	Benjamin Herrenschmidt <benh@au1.ibm.com>, shaggy@linux.vnet.ibm.com,
	Frederic Weisbecker <fweisbec@gmail.com>, David Gibson <dwg@au1.ibm.com>,
	Alan Stern <stern@rowland.harvard.edu>,
	"K.Prasad" <prasad@linux.vnet.ibm.com>, Roland McGrath <roland@redhat.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Many a times, the requested breakpoint length can be less than the fixed
breakpoint length i.e. 8 bytes supported by PowerPC BookIII S. This could lead
to extraneous interrupts resulting in false breakpoint notifications. The patch
below detects and discards such interrupts for non-ptrace requests (we don't
want to change ptrace behaviour for fear of breaking compatability).

Signed-off-by: K.Prasad <prasad@linux.vnet.ibm.com>
---
 arch/powerpc/kernel/hw_breakpoint.c |   39 ++++++++++++++++++++++++++++++++----
 1 file changed, 35 insertions(+), 4 deletions(-)

Index: linux-2.6.ppc64_test/arch/powerpc/kernel/hw_breakpoint.c
===================================================================
--- linux-2.6.ppc64_test.orig/arch/powerpc/kernel/hw_breakpoint.c
+++ linux-2.6.ppc64_test/arch/powerpc/kernel/hw_breakpoint.c
@@ -198,12 +198,13 @@ void thread_change_pc(struct task_struct
  */
 int __kprobes hw_breakpoint_handler(struct die_args *args)
 {
-	bool is_ptrace_bp = false;
+	bool is_extraneous_interrupt = false, is_ptrace_bp = false;
 	int rc = NOTIFY_STOP;
 	struct perf_event *bp;
 	struct pt_regs *regs = args->regs;
 	int stepped = 1;
 	struct arch_hw_breakpoint *info;
+	unsigned long dar = regs->dar;
 
 	/* Disable breakpoints during exception handling */
 	set_dabr(0);
@@ -234,9 +235,33 @@ int __kprobes hw_breakpoint_handler(stru
 		goto out;
 	}
 
+	/*
+	 * Verify if dar lies within the address range occupied by the symbol
+	 * being watched to filter extraneous exceptions.
+	 */
+	if (!((bp->attr.bp_addr <= dar) &&
+	     (dar <= (bp->attr.bp_addr + bp->attr.bp_len)))) {
+		/*
+		 * This exception is triggered not because of a memory access
+		 * on the monitored variable but in the double-word address
+		 * range in which it is contained. We will consume this
+		 * exception, considering it as 'noise'.
+		 */
+		is_extraneous_interrupt = true;
+	}
+
 	/* Do not emulate user-space instructions, instead single-step them */
 	if (user_mode(regs)) {
-		bp->ctx->task->thread.last_hit_ubp = bp;
+		/*
+		 * To prevent invocation of perf_event_bp(), we shall overload
+		 * thread.ptrace_bps[] pointer (unused for non-ptrace
+		 * exceptions) to flag an extraneous interrupt which must be
+		 * skipped.
+		 */
+		if (is_extraneous_interrupt)
+			bp->ctx->task->thread.ptrace_bps[0] = bp;
+		else
+			bp->ctx->task->thread.last_hit_ubp = bp;
 		regs->msr |= MSR_SE;
 		goto out;
 	}
@@ -274,7 +299,12 @@ int __kprobes single_step_dabr_instructi
 	struct perf_event *bp = NULL;
 	struct arch_hw_breakpoint *bp_info;
 
-	bp = current->thread.last_hit_ubp;
+	if (current->thread.last_hit_ubp)
+		bp = current->thread.last_hit_ubp;
+	else {
+		bp = current->thread.ptrace_bps[0];
+		current->thread.ptrace_bps[0] = NULL;
+	}
 	/*
 	 * Check if we are single-stepping as a result of a
 	 * previous HW Breakpoint exception
@@ -288,7 +318,8 @@ int __kprobes single_step_dabr_instructi
 	 * We shall invoke the user-defined callback function in the single
 	 * stepping handler to confirm to 'trigger-after-execute' semantics
 	 */
-	perf_bp_event(bp, regs);
+	if (bp == current->thread.last_hit_ubp)
+		perf_bp_event(bp, regs);
 
 	/*
 	 * Do not disable MSR_SE if the process was already in

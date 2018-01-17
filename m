Return-Path: <naveen.n.rao@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zM5nl5nbqzF0Xw
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 17 Jan 2018 23:22:35 +1100 (AEDT)
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w0HCLYbY081565
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 17 Jan 2018 07:22:33 -0500
Received: from e06smtp13.uk.ibm.com (e06smtp13.uk.ibm.com [195.75.94.109])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2fj5rkss4j-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 17 Jan 2018 07:22:33 -0500
Received: from localhost
 by e06smtp13.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <naveen.n.rao@linux.vnet.ibm.com>;
 Wed, 17 Jan 2018 12:22:31 -0000
From: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Ananth N Mavinakayanahalli <ananth@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org
Subject: [PATCH] powerpc/kprobes: Fix call trace due to incorrect preempt count
Date: Wed, 17 Jan 2018 17:52:24 +0530
Message-Id: <20180117122224.19860-1-naveen.n.rao@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Michael Ellerman reported the following call trace when running
ftracetest:

BUG: using __this_cpu_write() in preemptible [00000000] code: ftracetest/6178
caller is opt_pre_handler+0xc4/0x110
CPU: 1 PID: 6178 Comm: ftracetest Not tainted 4.15.0-rc7-gcc6x-gb2cd1df #1
Call Trace:
[c0000000f9ec39c0] [c000000000ac4304] dump_stack+0xb4/0x100 (unreliable)
[c0000000f9ec3a00] [c00000000061159c] check_preemption_disabled+0x15c/0x170
[c0000000f9ec3a90] [c000000000217e84] opt_pre_handler+0xc4/0x110
[c0000000f9ec3af0] [c00000000004cf68] optimized_callback+0x148/0x170
[c0000000f9ec3b40] [c00000000004d954] optinsn_slot+0xec/0x10000
[c0000000f9ec3e30] [c00000000004bae0] kretprobe_trampoline+0x0/0x10

This is showing up since OPTPROBES is now enabled with CONFIG_PREEMPT.

trampoline_probe_handler() considers itself to be a special kprobe
handler for kretprobes. In doing so, it expects to be called from
kprobe_handler() on a trap, and re-enables preemption before returning a
non-zero return value so as to suppress any subsequent processing of the
trap by the kprobe_handler().

However, with optprobes, we don't deal with special handlers (we ignore
the return code) and just try to re-enable preemption causing the above
trace.

To address this, modify trampoline_probe_handler() to not be special.
The only additional processing done in kprobe_handler() is to emulate
the instruction (in this case, a 'nop'). We adjust the value of
regs->nip for the purpose and delegate the job of re-enabling
preemption and resetting current kprobe to the probe handlers
(kprobe_handler() or optimized_callback()).

Reported-by: Michael Ellerman <mpe@ellerman.id.au>
Signed-off-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
---
 arch/powerpc/kernel/kprobes.c | 30 +++++++++++++++++-------------
 1 file changed, 17 insertions(+), 13 deletions(-)

diff --git a/arch/powerpc/kernel/kprobes.c b/arch/powerpc/kernel/kprobes.c
index ca5d5a081e75..e4c5bf33970b 100644
--- a/arch/powerpc/kernel/kprobes.c
+++ b/arch/powerpc/kernel/kprobes.c
@@ -455,29 +455,33 @@ static int trampoline_probe_handler(struct kprobe *p, struct pt_regs *regs)
 	}
 
 	kretprobe_assert(ri, orig_ret_address, trampoline_address);
-	regs->nip = orig_ret_address;
+
 	/*
-	 * Make LR point to the orig_ret_address.
-	 * When the 'nop' inside the kretprobe_trampoline
-	 * is optimized, we can do a 'blr' after executing the
-	 * detour buffer code.
+	 * We get here through one of two paths:
+	 * 1. by taking a trap -> kprobe_handler() -> here
+	 * 2. by optprobe branch -> optimized_callback() -> opt_pre_handler() -> here
+	 *
+	 * When going back through (1), we need regs->nip to be setup properly
+	 * as it is used to determine the return address from the trap.
+	 * For (2), since nip is not honoured with optprobes, we instead setup
+	 * the link register properly so that the subsequent 'blr' in
+	 * kretprobe_trampoline jumps back to the right instruction.
+	 *
+	 * For nip, we should set the address to the previous instruction since
+	 * we end up emulating it in kprobe_handler(), which increments the nip
+	 * again.
 	 */
+	regs->nip = orig_ret_address - 4;
 	regs->link = orig_ret_address;
 
-	reset_current_kprobe();
 	kretprobe_hash_unlock(current, &flags);
-	preempt_enable_no_resched();
 
 	hlist_for_each_entry_safe(ri, tmp, &empty_rp, hlist) {
 		hlist_del(&ri->hlist);
 		kfree(ri);
 	}
-	/*
-	 * By returning a non-zero value, we are telling
-	 * kprobe_handler() that we don't want the post_handler
-	 * to run (and have re-enabled preemption)
-	 */
-	return 1;
+
+	return 0;
 }
 NOKPROBE_SYMBOL(trampoline_probe_handler);
 
-- 
2.15.1

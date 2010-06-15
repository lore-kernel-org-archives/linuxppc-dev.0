Return-Path: <prasad@linux.vnet.ibm.com>
Received: from e28smtp04.in.ibm.com (e28smtp04.in.ibm.com [122.248.162.4])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e28smtp04.in.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 563461007FE
	for <linuxppc-dev@ozlabs.org>; Tue, 15 Jun 2010 16:06:18 +1000 (EST)
Received: from d28relay05.in.ibm.com (d28relay05.in.ibm.com [9.184.220.62])
	by e28smtp04.in.ibm.com (8.14.4/8.13.1) with ESMTP id o5F66EdP010230
	for <linuxppc-dev@ozlabs.org>; Tue, 15 Jun 2010 11:36:14 +0530
Received: from d28av02.in.ibm.com (d28av02.in.ibm.com [9.184.220.64])
	by d28relay05.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	o5F66E3B3223672
	for <linuxppc-dev@ozlabs.org>; Tue, 15 Jun 2010 11:36:14 +0530
Received: from d28av02.in.ibm.com (loopback [127.0.0.1])
	by d28av02.in.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
	o5F66DhR016445
	for <linuxppc-dev@ozlabs.org>; Tue, 15 Jun 2010 16:06:14 +1000
Date: Tue, 15 Jun 2010 11:36:12 +0530
From: "K.Prasad" <prasad@linux.vnet.ibm.com>
To: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>,
	Paul Mackerras <paulus@samba.org>
Subject: [Patch 5/5] PPC64-HWBKPT: Discard extraneous interrupt due to
	accesses outside symbol length
Message-ID: <20100615060612.GF4790@in.ibm.com>
References: <20100615055010.108795721@linux.vnet.ibm.com>
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

[Suggestions from Paul Mackerras <paulus@samba.org> to add a new flag in
'struct arch_hw_breakpoint' to identify extraneous interrupts]

Signed-off-by: K.Prasad <prasad@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/hw_breakpoint.h |    1 +
 arch/powerpc/kernel/hw_breakpoint.c      |   23 +++++++++++++++++++++--
 2 files changed, 22 insertions(+), 2 deletions(-)

Index: linux-2.6.ppc64_test/arch/powerpc/kernel/hw_breakpoint.c
===================================================================
--- linux-2.6.ppc64_test.orig/arch/powerpc/kernel/hw_breakpoint.c
+++ linux-2.6.ppc64_test/arch/powerpc/kernel/hw_breakpoint.c
@@ -202,6 +202,7 @@ int __kprobes hw_breakpoint_handler(stru
 	struct pt_regs *regs = args->regs;
 	int stepped = 1;
 	struct arch_hw_breakpoint *info;
+	unsigned long dar = regs->dar;
 
 	/* Disable breakpoints during exception handling */
 	set_dabr(0);
@@ -232,6 +233,22 @@ int __kprobes hw_breakpoint_handler(stru
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
+		info->extraneous_interrupt = true;
+	} else
+		info->extraneous_interrupt = false;
+
 	/* Do not emulate user-space instructions, instead single-step them */
 	if (user_mode(regs)) {
 		bp->ctx->task->thread.last_hit_ubp = bp;
@@ -255,7 +272,8 @@ int __kprobes hw_breakpoint_handler(stru
 	 * As a policy, the callback is invoked in a 'trigger-after-execute'
 	 * fashion
 	 */
-	perf_bp_event(bp, regs);
+	if (!info->extraneous_interrupt)
+		perf_bp_event(bp, regs);
 
 	set_dabr(info->address | info->type | DABR_TRANSLATION);
 out:
@@ -286,7 +304,8 @@ int __kprobes single_step_dabr_instructi
 	 * We shall invoke the user-defined callback function in the single
 	 * stepping handler to confirm to 'trigger-after-execute' semantics
 	 */
-	perf_bp_event(bp, regs);
+	if (!bp_info->extraneous_interrupt)
+		perf_bp_event(bp, regs);
 
 	/*
 	 * Do not disable MSR_SE if the process was already in
Index: linux-2.6.ppc64_test/arch/powerpc/include/asm/hw_breakpoint.h
===================================================================
--- linux-2.6.ppc64_test.orig/arch/powerpc/include/asm/hw_breakpoint.h
+++ linux-2.6.ppc64_test/arch/powerpc/include/asm/hw_breakpoint.h
@@ -27,6 +27,7 @@
 #ifdef CONFIG_HAVE_HW_BREAKPOINT
 
 struct arch_hw_breakpoint {
+	bool		extraneous_interrupt;
 	u8		len; /* length of the target data symbol */
 	int		type;
 	unsigned long	address;

Return-Path: <ananth@in.ibm.com>
Received: from e7.ny.us.ibm.com (e7.ny.us.ibm.com [32.97.182.137])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e7.ny.us.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 599B82C0094
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 26 Jul 2012 15:19:58 +1000 (EST)
Received: from /spool/local
 by e7.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <ananth@in.ibm.com>;
 Thu, 26 Jul 2012 01:19:54 -0400
Received: from d01relay05.pok.ibm.com (d01relay05.pok.ibm.com [9.56.227.237])
 by d01dlp03.pok.ibm.com (Postfix) with ESMTP id F2C7AC9001C
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 26 Jul 2012 01:19:03 -0400 (EDT)
Received: from d01av01.pok.ibm.com (d01av01.pok.ibm.com [9.56.224.215])
 by d01relay05.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 q6Q5J3mG353378
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 26 Jul 2012 01:19:03 -0400
Received: from d01av01.pok.ibm.com (loopback [127.0.0.1])
 by d01av01.pok.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 q6QAntou004213
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 26 Jul 2012 06:49:56 -0400
Date: Thu, 26 Jul 2012 10:49:02 +0530
From: Ananth N Mavinakayanahalli <ananth@in.ibm.com>
To: linuxppc-dev@lists.ozlabs.org, lkml <linux-kernel@vger.kernel.org>
Subject: [PATCH 1/2] powerpc: Add trap_nr to thread_struct
Message-ID: <20120726051902.GA29466@in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Srikar Dronamraju <srikar@linux.vnet.ibm.com>, peterz@infradead.org,
 oleg@redhat.com, Paul Mackerras <paulus@samba.org>,
 Anton Blanchard <anton@samba.org>, Ingo Molnar <mingo@elte.hu>
Reply-To: ananth@in.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Ananth N Mavinakayanahalli <ananth@in.ibm.com>

Add thread_struct.trap_nr and use it to store the last exception
the thread experienced. In this patch, we populate the field at
various places where we force_sig_info() to the process.

This is also used in uprobes to determine if the probed instruction
caused an exception.

Patch applies on the current master branch of Linus' tree (bdc0077af)

Signed-off-by: Ananth N Mavinakayanahalli <ananth@in.ibm.com>
---
 arch/powerpc/include/asm/processor.h |    1 +
 arch/powerpc/kernel/process.c        |    2 ++
 arch/powerpc/kernel/traps.c          |    1 +
 arch/powerpc/mm/fault.c              |    1 +
 4 files changed, 5 insertions(+)

Index: linux-26jul/arch/powerpc/include/asm/processor.h
===================================================================
--- linux-26jul.orig/arch/powerpc/include/asm/processor.h
+++ linux-26jul/arch/powerpc/include/asm/processor.h
@@ -219,6 +219,7 @@ struct thread_struct {
 #endif /* CONFIG_HAVE_HW_BREAKPOINT */
 #endif
 	unsigned long	dabr;		/* Data address breakpoint register */
+	unsigned long	trap_nr;	/* last trap # on this thread */
 #ifdef CONFIG_ALTIVEC
 	/* Complete AltiVec register set */
 	vector128	vr[32] __attribute__((aligned(16)));
Index: linux-26jul/arch/powerpc/kernel/process.c
===================================================================
--- linux-26jul.orig/arch/powerpc/kernel/process.c
+++ linux-26jul/arch/powerpc/kernel/process.c
@@ -258,6 +258,7 @@ void do_send_trap(struct pt_regs *regs, 
 {
 	siginfo_t info;
 
+	current->thread.trap_nr = signal_code;
 	if (notify_die(DIE_DABR_MATCH, "dabr_match", regs, error_code,
 			11, SIGSEGV) == NOTIFY_STOP)
 		return;
@@ -275,6 +276,7 @@ void do_dabr(struct pt_regs *regs, unsig
 {
 	siginfo_t info;
 
+	current->thread.trap_nr = TRAP_HWBKPT;
 	if (notify_die(DIE_DABR_MATCH, "dabr_match", regs, error_code,
 			11, SIGSEGV) == NOTIFY_STOP)
 		return;
Index: linux-26jul/arch/powerpc/kernel/traps.c
===================================================================
--- linux-26jul.orig/arch/powerpc/kernel/traps.c
+++ linux-26jul/arch/powerpc/kernel/traps.c
@@ -251,6 +251,7 @@ void _exception(int signr, struct pt_reg
 	if (arch_irqs_disabled() && !arch_irq_disabled_regs(regs))
 		local_irq_enable();
 
+	current->thread.trap_nr = code;
 	memset(&info, 0, sizeof(info));
 	info.si_signo = signr;
 	info.si_code = code;
Index: linux-26jul/arch/powerpc/mm/fault.c
===================================================================
--- linux-26jul.orig/arch/powerpc/mm/fault.c
+++ linux-26jul/arch/powerpc/mm/fault.c
@@ -133,6 +133,7 @@ static int do_sigbus(struct pt_regs *reg
 	up_read(&current->mm->mmap_sem);
 
 	if (user_mode(regs)) {
+		current->thread.trap_nr = BUS_ADRERR;
 		info.si_signo = SIGBUS;
 		info.si_errno = 0;
 		info.si_code = BUS_ADRERR;

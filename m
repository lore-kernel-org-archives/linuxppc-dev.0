Return-Path: <prasad@linux.vnet.ibm.com>
Received: from e28smtp06.in.ibm.com (e28smtp06.in.ibm.com [122.248.162.6])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e28smtp06.in.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id C9C01100A7E
	for <linuxppc-dev@ozlabs.org>; Wed,  9 Jun 2010 20:25:37 +1000 (EST)
Received: from d28relay05.in.ibm.com (d28relay05.in.ibm.com [9.184.220.62])
	by e28smtp06.in.ibm.com (8.14.4/8.13.1) with ESMTP id o59APYXc022064
	for <linuxppc-dev@ozlabs.org>; Wed, 9 Jun 2010 15:55:34 +0530
Received: from d28av05.in.ibm.com (d28av05.in.ibm.com [9.184.220.67])
	by d28relay05.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	o59APXNM2887712
	for <linuxppc-dev@ozlabs.org>; Wed, 9 Jun 2010 15:55:33 +0530
Received: from d28av05.in.ibm.com (loopback [127.0.0.1])
	by d28av05.in.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
	o59APXJM013861
	for <linuxppc-dev@ozlabs.org>; Wed, 9 Jun 2010 20:25:33 +1000
Date: Wed, 9 Jun 2010 15:55:31 +0530
From: "K.Prasad" <prasad@linux.vnet.ibm.com>
To: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>,
	Paul Mackerras <paulus@samba.org>
Subject: [Patch 3/5] PPC64-HWBKPT: Handle concurrent alignment interrupts
Message-ID: <20100609102531.GD20332@in.ibm.com>
References: <20100609101417.644628763@linux.vnet.ibm.com>
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

An alignment interrupt may intervene between a DSI/hw-breakpoint exception
and the single-step exception. Enable the alignment interrupt (through
modifications to emulate_single_step()) to notify the single-step exception
handler for proper restoration of hw-breakpoints.

Signed-off-by: K.Prasad <prasad@linux.vnet.ibm.com>
---
 arch/powerpc/kernel/traps.c |    8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

Index: linux-2.6.ppc64_test/arch/powerpc/kernel/traps.c
===================================================================
--- linux-2.6.ppc64_test.orig/arch/powerpc/kernel/traps.c
+++ linux-2.6.ppc64_test/arch/powerpc/kernel/traps.c
@@ -602,7 +602,7 @@ void RunModeException(struct pt_regs *re
 
 void __kprobes single_step_exception(struct pt_regs *regs)
 {
-	regs->msr &= ~(MSR_SE | MSR_BE);  /* Turn off 'trace' bits */
+	clear_single_step(regs);
 
 	if (notify_die(DIE_SSTEP, "single_step", regs, 5,
 					5, SIGTRAP) == NOTIFY_STOP)
@@ -621,10 +621,8 @@ void __kprobes single_step_exception(str
  */
 static void emulate_single_step(struct pt_regs *regs)
 {
-	if (single_stepping(regs)) {
-		clear_single_step(regs);
-		_exception(SIGTRAP, regs, TRAP_TRACE, 0);
-	}
+	if (single_stepping(regs))
+		single_step_exception(regs);
 }
 
 static inline int __parse_fpscr(unsigned long fpscr)

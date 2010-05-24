Return-Path: <prasad@linux.vnet.ibm.com>
Received: from e23smtp06.au.ibm.com (e23smtp06.au.ibm.com [202.81.31.148])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e23smtp06.au.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 98957B7DB9
	for <linuxppc-dev@ozlabs.org>; Mon, 24 May 2010 14:02:58 +1000 (EST)
Received: from d23relay03.au.ibm.com (d23relay03.au.ibm.com [202.81.31.245])
	by e23smtp06.au.ibm.com (8.14.3/8.13.1) with ESMTP id o4O42jUU025793
	for <linuxppc-dev@ozlabs.org>; Mon, 24 May 2010 14:02:45 +1000
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
	by d23relay03.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	o4O42wJa1511616
	for <linuxppc-dev@ozlabs.org>; Mon, 24 May 2010 14:02:58 +1000
Received: from d23av01.au.ibm.com (loopback [127.0.0.1])
	by d23av01.au.ibm.com (8.14.3/8.13.1/NCO v10.0 AVout) with ESMTP id
	o4O42vqd023744
	for <linuxppc-dev@ozlabs.org>; Mon, 24 May 2010 14:02:57 +1000
Date: Mon, 24 May 2010 09:32:50 +0530
From: "K.Prasad" <prasad@linux.vnet.ibm.com>
To: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>,
	Paul Mackerras <paulus@samba.org>
Subject: [RFC Patch 3/5] PPC64-HWBKPT: Handle concurrent alignment interrupts
Message-ID: <20100524040250.GD20873@in.ibm.com>
References: <20100524034520.964014525@linux.vnet.ibm.com>
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
 arch/powerpc/kernel/traps.c |    7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

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
@@ -621,10 +621,7 @@ void __kprobes single_step_exception(str
  */
 static void emulate_single_step(struct pt_regs *regs)
 {
-	if (single_stepping(regs)) {
-		clear_single_step(regs);
-		_exception(SIGTRAP, regs, TRAP_TRACE, 0);
-	}
+	single_step_exception(regs);
 }
 
 static inline int __parse_fpscr(unsigned long fpscr)

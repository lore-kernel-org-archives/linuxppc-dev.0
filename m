Return-Path: <prasad@linux.vnet.ibm.com>
Received: from e23smtp08.au.ibm.com (e23smtp08.au.ibm.com [202.81.31.141])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e23smtp08.au.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 43F35B86D6
	for <linuxppc-dev@ozlabs.org>; Tue, 25 May 2010 19:14:42 +1000 (EST)
Received: from d23relay04.au.ibm.com (d23relay04.au.ibm.com [202.81.31.246])
	by e23smtp08.au.ibm.com (8.14.3/8.13.1) with ESMTP id o4P9Ed9R010636
	for <linuxppc-dev@ozlabs.org>; Tue, 25 May 2010 19:14:39 +1000
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
	by d23relay04.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	o4P9EfgO1609968
	for <linuxppc-dev@ozlabs.org>; Tue, 25 May 2010 19:14:41 +1000
Received: from d23av02.au.ibm.com (loopback [127.0.0.1])
	by d23av02.au.ibm.com (8.14.3/8.13.1/NCO v10.0 AVout) with ESMTP id
	o4P9Ee5o005787
	for <linuxppc-dev@ozlabs.org>; Tue, 25 May 2010 19:14:40 +1000
Date: Tue, 25 May 2010 14:44:35 +0530
From: "K.Prasad" <prasad@linux.vnet.ibm.com>
To: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>,
	Paul Mackerras <paulus@samba.org>
Subject: [Patch 3/4] PPC64-HWBKPT: Handle concurrent alignment interrupts
Message-ID: <20100525091435.GD29003@in.ibm.com>
References: <20100525083055.342788418@linux.vnet.ibm.com>
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

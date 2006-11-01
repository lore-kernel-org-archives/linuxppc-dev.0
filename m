Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id D6B9D67B8B
	for <linuxppc-dev@ozlabs.org>; Wed,  1 Nov 2006 15:13:13 +1100 (EST)
Subject: [PATCH] powerpc: Make alignment exception always check exception
	table (#3)
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Paul Mackerras <paulus@samba.org>
In-Reply-To: <1162350571.25682.389.camel@localhost.localdomain>
References: <1162350571.25682.389.camel@localhost.localdomain>
Content-Type: text/plain
Date: Wed, 01 Nov 2006 15:11:39 +1100
Message-Id: <1162354299.25682.394.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>, Greg KH <greg@kroah.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

The alignment exception used to only check the exception table for
-EFAULT, not for other errors. That opens an oops window if we can
coerce the kernel into getting an alignment exception for other reasons
in what would normally be a user-protected accessor, which can be done
via some of the futex ops. This fixes it by always checking the
exception tables.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---

Paul: this version sets the correct si_code

This is 2.6.19 material and should probably go into stable as well.
(Greg: take it if paulus acks it and it applies :)

Index: linux-work/arch/powerpc/kernel/traps.c
===================================================================
--- linux-work.orig/arch/powerpc/kernel/traps.c	2006-11-01 14:59:07.000000000 +1100
+++ linux-work/arch/powerpc/kernel/traps.c	2006-11-01 15:01:06.000000000 +1100
@@ -843,7 +843,7 @@ void __kprobes program_check_exception(s
 
 void alignment_exception(struct pt_regs *regs)
 {
-	int fixed = 0;
+	int sig, code, fixed = 0;
 
 	/* we don't implement logging of alignment exceptions */
 	if (!(current->thread.align_ctl & PR_UNALIGN_SIGBUS))
@@ -857,14 +857,16 @@ void alignment_exception(struct pt_regs 
 
 	/* Operand address was bad */
 	if (fixed == -EFAULT) {
-		if (user_mode(regs))
-			_exception(SIGSEGV, regs, SEGV_ACCERR, regs->dar);
-		else
-			/* Search exception table */
-			bad_page_fault(regs, regs->dar, SIGSEGV);
-		return;
+		sig = SIGSEGV;
+		code = SEGV_ACCERR;
+	} else {
+		sig = SIGBUS;
+		code = BUS_ADRALN;
 	}
-	_exception(SIGBUS, regs, BUS_ADRALN, regs->dar);
+	if (user_mode(regs))
+		_exception(sig, regs, code, regs->dar);
+	else
+		bad_page_fault(regs, regs->dar, sig);
 }
 
 void StackOverflow(struct pt_regs *regs)
Index: linux-work/arch/ppc/kernel/traps.c
===================================================================
--- linux-work.orig/arch/ppc/kernel/traps.c	2006-11-01 14:59:07.000000000 +1100
+++ linux-work/arch/ppc/kernel/traps.c	2006-11-01 15:01:32.000000000 +1100
@@ -708,7 +708,7 @@ void single_step_exception(struct pt_reg
 
 void alignment_exception(struct pt_regs *regs)
 {
-	int fixed;
+	int sig, code, fixed = 0;
 
 	fixed = fix_alignment(regs);
 	if (fixed == 1) {
@@ -717,14 +717,16 @@ void alignment_exception(struct pt_regs 
 		return;
 	}
 	if (fixed == -EFAULT) {
-		/* fixed == -EFAULT means the operand address was bad */
-		if (user_mode(regs))
-			_exception(SIGSEGV, regs, SEGV_ACCERR, regs->dar);
-		else
-			bad_page_fault(regs, regs->dar, SIGSEGV);
-		return;
+		sig = SIGSEGV;
+		code = SEGV_ACCERR;
+	} else {
+		sig = SIGBUS;
+		code = BUS_ADRALN;
 	}
-	_exception(SIGBUS, regs, BUS_ADRALN, regs->dar);
+	if (user_mode(regs))
+		_exception(sig, regs, code, regs->dar);
+	else
+		bad_page_fault(regs, regs->dar, sig);
 }
 
 void StackOverflow(struct pt_regs *regs)

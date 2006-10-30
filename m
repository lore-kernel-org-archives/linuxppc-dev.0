Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id BD53567C62
	for <linuxppc-dev@ozlabs.org>; Mon, 30 Oct 2006 14:02:21 +1100 (EST)
Subject: Re: glibc-2.5 test suite hangs/crashes the machine
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Fabio Massimo Di Nitto <fabbione@ubuntu.com>
In-Reply-To: <45419F79.2020300@ubuntu.com>
References: <45419F79.2020300@ubuntu.com>
Content-Type: text/plain
Date: Mon, 30 Oct 2006 14:02:13 +1100
Message-Id: <1162177334.25682.144.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Jeff Bailey <jbailey@ubuntu.com>,
	Paul Mackerras <paulus@samba.org>, Ben Collins <ben.collins@ubuntu.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Does that patch fixes it ?

Index: linux-work/arch/powerpc/kernel/traps.c
===================================================================
--- linux-work.orig/arch/powerpc/kernel/traps.c	2006-10-23 14:41:37.000000000 +1000
+++ linux-work/arch/powerpc/kernel/traps.c	2006-10-30 13:59:41.000000000 +1100
@@ -843,7 +843,7 @@ void __kprobes program_check_exception(s
 
 void alignment_exception(struct pt_regs *regs)
 {
-	int fixed = 0;
+	int sig, fixed = 0;
 
 	/* we don't implement logging of alignment exceptions */
 	if (!(current->thread.align_ctl & PR_UNALIGN_SIGBUS))
@@ -856,15 +856,11 @@ void alignment_exception(struct pt_regs 
 	}
 
 	/* Operand address was bad */
-	if (fixed == -EFAULT) {
-		if (user_mode(regs))
-			_exception(SIGSEGV, regs, SEGV_ACCERR, regs->dar);
-		else
-			/* Search exception table */
-			bad_page_fault(regs, regs->dar, SIGSEGV);
-		return;
-	}
-	_exception(SIGBUS, regs, BUS_ADRALN, regs->dar);
+	sig = fixed == -EFAULT ? SIGSEGV : SIGBUS;
+	if (user_mode(regs))
+		_exception(sig, regs, SEGV_ACCERR, regs->dar);
+	else
+		bad_page_fault(regs, regs->dar, sig);
 }
 
 void StackOverflow(struct pt_regs *regs)

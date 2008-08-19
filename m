Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 37F0EDDFD0
	for <linuxppc-dev@ozlabs.org>; Tue, 19 Aug 2008 12:58:04 +1000 (EST)
Subject: Re: ftrace introduces instability into kernel 2.6.27(-rc2,-rc3)
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Steven Rostedt <rostedt@goodmis.org>
In-Reply-To: <1219113549.8062.13.camel@pasglop>
References: <48591941.4070408@extricom.com> <48A92E15.2080709@extricom.com>
	<48A9901B.1080900@redhat.com> <20080818154746.GA26835@Krystal>
	<48A9AFA7.8080508@freescale.com>
	<alpine.DEB.1.10.0808181425090.796@gandalf.stny.rr.com>
	<1219110814.8062.2.camel@pasglop>
	<alpine.DEB.1.10.0808182208110.13401@gandalf.stny.rr.com>
	<1219113549.8062.13.camel@pasglop>
Content-Type: text/plain
Date: Tue, 19 Aug 2008 12:56:40 +1000
Message-Id: <1219114600.8062.15.camel@pasglop>
Mime-Version: 1.0
Cc: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
	Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>,
	linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org,
	Steven Rostedt <srostedt@redhat.com>, Scott Wood <scottwood@freescale.com>,
	Eran Liberty <liberty@extricom.com>
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Ok, so i did a patch, but it doesn't fix the problem. So
there's something else whacking on the stack frames.

Still, here it is:

powerpc/ftrace: Fix broken assembly for code replacement

Instead, uses __get_user() and __put_user().

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---

Index: linux-work/arch/powerpc/kernel/ftrace.c
===================================================================
--- linux-work.orig/arch/powerpc/kernel/ftrace.c	2008-08-19 12:45:49.000000000 +1000
+++ linux-work/arch/powerpc/kernel/ftrace.c	2008-08-19 12:52:51.000000000 +1000
@@ -16,7 +16,7 @@
 
 #include <asm/cacheflush.h>
 #include <asm/ftrace.h>
-
+#include <asm/uaccess.h>
 
 static unsigned int ftrace_nop = 0x60000000;
 
@@ -72,10 +72,9 @@ notrace int
 ftrace_modify_code(unsigned long ip, unsigned char *old_code,
 		   unsigned char *new_code)
 {
-	unsigned replaced;
-	unsigned old = *(unsigned *)old_code;
-	unsigned new = *(unsigned *)new_code;
-	int faulted = 0;
+	unsigned int old = *(unsigned int *)old_code;
+	unsigned int new = *(unsigned int *)new_code;
+	unsigned int instr;
 
 	/*
 	 * Note: Due to modules and __init, code can
@@ -85,32 +84,13 @@ ftrace_modify_code(unsigned long ip, uns
 	 * No real locking needed, this code is run through
 	 * kstop_machine.
 	 */
-	asm volatile (
-		"1: lwz		%1, 0(%2)\n"
-		"   cmpw	%1, %5\n"
-		"   bne		2f\n"
-		"   stwu	%3, 0(%2)\n"
-		"2:\n"
-		".section .fixup, \"ax\"\n"
-		"3:	li %0, 1\n"
-		"	b 2b\n"
-		".previous\n"
-		".section __ex_table,\"a\"\n"
-		_ASM_ALIGN "\n"
-		_ASM_PTR "1b, 3b\n"
-		".previous"
-		: "=r"(faulted), "=r"(replaced)
-		: "r"(ip), "r"(new),
-		  "0"(faulted), "r"(old)
-		: "memory");
-
-	if (replaced != old && replaced != new)
-		faulted = 2;
-
-	if (!faulted)
-		flush_icache_range(ip, ip + 8);
-
-	return faulted;
+	if (__get_user(instr, (unsigned int __user *)ip))
+		return 1;
+	if (instr != old && instr != new)
+		return 2;
+	WARN_ON_ONCE(__put_user(new, (unsigned int __user *)ip));
+	flush_icache_range(ip, ip + 8);
+	return 0;
 }
 
 notrace int ftrace_update_ftrace_func(ftrace_func_t func)

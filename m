Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 6E421686DA
	for <linuxppc-dev@ozlabs.org>; Mon,  7 Nov 2005 16:45:57 +1100 (EST)
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Paul Mackerras <paulus@samba.org>
Content-Type: text/plain
Date: Mon, 07 Nov 2005 16:43:44 +1100
Message-Id: <1131342224.11406.22.camel@gaston>
Mime-Version: 1.0
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>
Subject: [PATCH] ppc: Fix ARCH=ppc build with xmon
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

xmon() prototype is inconsistent between ARCH=ppc and ARCH=powerpc, thus causing
ARCH=ppc build breakage.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---
I'm not sure you already fixed that, so just in case...

Index: linux-work/arch/ppc/kernel/traps.c
===================================================================
--- linux-work.orig/arch/ppc/kernel/traps.c	2005-11-07 15:10:26.000000000 +1100
+++ linux-work/arch/ppc/kernel/traps.c	2005-11-07 16:28:39.000000000 +1100
@@ -49,7 +49,7 @@
 extern int xmon_iabr_match(struct pt_regs *regs);
 extern int xmon_dabr_match(struct pt_regs *regs);
 
-void (*debugger)(struct pt_regs *regs) = xmon;
+int (*debugger)(struct pt_regs *regs) = xmon;
 int (*debugger_bpt)(struct pt_regs *regs) = xmon_bpt;
 int (*debugger_sstep)(struct pt_regs *regs) = xmon_sstep;
 int (*debugger_iabr_match)(struct pt_regs *regs) = xmon_iabr_match;
@@ -57,7 +57,7 @@
 void (*debugger_fault_handler)(struct pt_regs *regs);
 #else
 #ifdef CONFIG_KGDB
-void (*debugger)(struct pt_regs *regs);
+int (*debugger)(struct pt_regs *regs);
 int (*debugger_bpt)(struct pt_regs *regs);
 int (*debugger_sstep)(struct pt_regs *regs);
 int (*debugger_iabr_match)(struct pt_regs *regs);
Index: linux-work/arch/ppc/xmon/xmon.c
===================================================================
--- linux-work.orig/arch/ppc/xmon/xmon.c	2005-11-03 09:40:36.000000000 +1100
+++ linux-work/arch/ppc/xmon/xmon.c	2005-11-07 16:30:03.000000000 +1100
@@ -220,8 +220,7 @@
 	p[1] = lo;
 }
 
-void
-xmon(struct pt_regs *excp)
+int xmon(struct pt_regs *excp)
 {
 	struct pt_regs regs;
 	int msr, cmd;
@@ -290,6 +289,8 @@
 #endif /* CONFIG_SMP */
 	set_msr(msr);		/* restore interrupt enable */
 	get_tb(start_tb[smp_processor_id()]);
+
+	return cmd != 'X';
 }
 
 irqreturn_t
Index: linux-work/include/asm-ppc/kgdb.h
===================================================================
--- linux-work.orig/include/asm-ppc/kgdb.h	2005-09-22 14:07:27.000000000 +1000
+++ linux-work/include/asm-ppc/kgdb.h	2005-11-07 16:29:07.000000000 +1100
@@ -31,7 +31,7 @@
 /* For taking exceptions
  * these are defined in traps.c
  */
-extern void (*debugger)(struct pt_regs *regs);
+extern int (*debugger)(struct pt_regs *regs);
 extern int (*debugger_bpt)(struct pt_regs *regs);
 extern int (*debugger_sstep)(struct pt_regs *regs);
 extern int (*debugger_iabr_match)(struct pt_regs *regs);

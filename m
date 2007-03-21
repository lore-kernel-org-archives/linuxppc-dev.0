Return-Path: <anton@ozlabs.org>
Message-Id: <20070321013825.623943000@samba.org>
References: <20070321013810.404636000@samba.org>
Date: Tue, 20 Mar 2007 20:38:19 -0500
From: anton@samba.org
To: linuxppc-dev@ozlabs.org
Subject: [patch 09/10] Use lowercase for hex printouts in oops messages.
Cc: paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Use lowercase for hex printouts in oops messages. The number of times I have
tried to copy and paste from an oops into an objdump search...

Signed-off-by: Anton Blanchard <anton@samba.org>
---

Index: linux-2.6/arch/powerpc/kernel/process.c
===================================================================
--- linux-2.6.orig/arch/powerpc/kernel/process.c	2007-03-11 14:40:22.000000000 -0500
+++ linux-2.6/arch/powerpc/kernel/process.c	2007-03-11 14:40:58.000000000 -0500
@@ -400,11 +400,11 @@
 }
 
 #ifdef CONFIG_PPC64
-#define REG		"%016lX"
+#define REG		"%016lx"
 #define REGS_PER_LINE	4
 #define LAST_VOLATILE	13
 #else
-#define REG		"%08lX"
+#define REG		"%08lx"
 #define REGS_PER_LINE	8
 #define LAST_VOLATILE	12
 #endif
@@ -422,7 +422,7 @@
 	       regs, regs->trap, print_tainted(), init_utsname()->release);
 	printk("%sMSR: "REG" ", log_lvl, regs->msr);
 	printbits(regs->msr, msr_bits);
-	printk("  CR: %08lX  XER: %08lX\n", regs->ccr, regs->xer);
+	printk("  CR: %08lx  XER: %08lx\n", regs->ccr, regs->xer);
 	trap = TRAP(regs);
 	if (trap == 0x300 || trap == 0x600)
 		printk("%sDAR: "REG", DSISR: "REG"\n", log_lvl, regs->dar,

--

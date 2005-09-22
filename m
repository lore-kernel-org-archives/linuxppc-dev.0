Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 3CB2568300
	for <linuxppc-dev@ozlabs.org>; Thu, 22 Sep 2005 16:03:28 +1000 (EST)
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Andrew Morton <akpm@osdl.org>
Content-Type: text/plain
Date: Thu, 22 Sep 2005 16:01:21 +1000
Message-Id: <1127368881.32344.36.camel@gaston>
Mime-Version: 1.0
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>
Subject: [PATCH] ppc32: fix build with oprofile
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Current -git tree doesn't build when enabling oprofile on a non-bookE
CPU (like on a PowerMac for example). While there is no performance
counter support for these CPUs implemented yet, it's still nice to be
able to use the timer based sampling, and that got broken.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

Index: linux-work/arch/ppc/kernel/Makefile
===================================================================
--- linux-work.orig/arch/ppc/kernel/Makefile	2005-09-22 15:44:03.000000000 +1000
+++ linux-work/arch/ppc/kernel/Makefile	2005-09-22 15:51:17.000000000 +1000
@@ -15,9 +15,8 @@
 obj-y				:= entry.o traps.o irq.o idle.o time.o misc.o \
 					process.o signal.o ptrace.o align.o \
 					semaphore.o syscalls.o setup.o \
-					cputable.o ppc_htab.o
+					cputable.o ppc_htab.o perfmon.o
 obj-$(CONFIG_6xx)		+= l2cr.o cpu_setup_6xx.o
-obj-$(CONFIG_E500)		+= perfmon.o
 obj-$(CONFIG_SOFTWARE_SUSPEND)	+= swsusp.o
 obj-$(CONFIG_POWER4)		+= cpu_setup_power4.o
 obj-$(CONFIG_MODULES)		+= module.o ppc_ksyms.o
Index: linux-work/arch/ppc/kernel/perfmon.c
===================================================================
--- linux-work.orig/arch/ppc/kernel/perfmon.c	2005-09-22 14:06:18.000000000 +1000
+++ linux-work/arch/ppc/kernel/perfmon.c	2005-09-22 15:51:49.000000000 +1000
@@ -45,7 +45,7 @@
 	mtpmr(PMRN_PMGC0, pmgc0);
 }
 
-#else
+#elif CONFIG_6xx
 /* Ensure exceptions are disabled */
 
 static void dummy_perf(struct pt_regs *regs)
@@ -55,6 +55,10 @@
 	mmcr0 &= ~MMCR0_PMXE;
 	mtspr(SPRN_MMCR0, mmcr0);
 }
+#else
+static void dummy_perf(struct pt_regs *regs)
+{
+}
 #endif
 
 void (*perf_irq)(struct pt_regs *) = dummy_perf;

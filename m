Return-Path: <marcelo.tosatti@cyclades.com>
Received: from parcelfarce.linux.theplanet.co.uk
	(parcelfarce.linux.theplanet.co.uk [195.92.249.252])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id A315D68093
	for <linuxppc-dev@ozlabs.org>; Wed, 24 Aug 2005 06:32:42 +1000 (EST)
Date: Tue, 23 Aug 2005 17:27:08 -0300
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: linuxppc-dev@ozlabs.org
Message-ID: <20050823202708.GE13157@dmt.cnet>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Kumar Gala <galak@freescale.com>
Subject: [PATCH] ppc32: make perfmon.o CONFIG_E500 specific
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


Subject says it all, there is no need to link perfmon.o on 
sub-architectures other than CONFIG_E500.

diff --git a/arch/ppc/kernel/Makefile b/arch/ppc/kernel/Makefile
--- a/arch/ppc/kernel/Makefile
+++ b/arch/ppc/kernel/Makefile
@@ -15,8 +15,9 @@ extra-y				+= vmlinux.lds
 obj-y				:= entry.o traps.o irq.o idle.o time.o misc.o \
 					process.o signal.o ptrace.o align.o \
 					semaphore.o syscalls.o setup.o \
-					cputable.o ppc_htab.o perfmon.o
+					cputable.o ppc_htab.o
 obj-$(CONFIG_6xx)		+= l2cr.o cpu_setup_6xx.o
+obj-$(CONFIG_E500)		+= perfmon.o
 obj-$(CONFIG_SOFTWARE_SUSPEND)	+= swsusp.o
 obj-$(CONFIG_POWER4)		+= cpu_setup_power4.o
 obj-$(CONFIG_MODULES)		+= module.o ppc_ksyms.o
diff --git a/arch/ppc/kernel/traps.c b/arch/ppc/kernel/traps.c
--- a/arch/ppc/kernel/traps.c
+++ b/arch/ppc/kernel/traps.c
@@ -849,10 +849,12 @@ void AltivecAssistException(struct pt_re
 }
 #endif /* CONFIG_ALTIVEC */
 
+#ifdef CONFIG_E500
 void PerformanceMonitorException(struct pt_regs *regs)
 {
 	perf_irq(regs);
 }
+#endif
 
 #ifdef CONFIG_FSL_BOOKE
 void CacheLockingException(struct pt_regs *regs, unsigned long address,

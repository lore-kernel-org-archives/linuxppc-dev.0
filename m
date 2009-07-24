Return-Path: <benh@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 1B1A1B7CC7
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 24 Jul 2009 19:15:41 +1000 (EST)
To: <linuxppc-dev@ozlabs.org>
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Fri, 24 Jul 2009 19:15:28 +1000
Subject: [PATCH 11/20] powerpc: Move definitions of secondary CPU spinloop to
	header file (v2)
In-Reply-To: <1248426902.401617.944220131651.qpush@grosgo>
Message-Id: <20090724091541.0C13DDDD1B@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Those definitions are currently declared extern in the .c file where
they are used, move them to a header file instead.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
--

v2. Move more definitions to the header and update more call sites

 arch/powerpc/include/asm/smp.h            |    9 +++++++++
 arch/powerpc/kernel/prom_init.c           |    4 ----
 arch/powerpc/kernel/setup_64.c            |    3 ---
 arch/powerpc/platforms/85xx/smp.c         |    1 -
 arch/powerpc/platforms/86xx/mpc86xx_smp.c |    1 -
 arch/powerpc/platforms/cell/smp.c         |    2 --
 arch/powerpc/platforms/pseries/smp.c      |    2 --
 7 files changed, 9 insertions(+), 13 deletions(-)

--- linux-work.orig/arch/powerpc/include/asm/smp.h	2009-07-24 15:31:07.000000000 +1000
+++ linux-work/arch/powerpc/include/asm/smp.h	2009-07-24 16:03:50.000000000 +1000
@@ -148,6 +148,15 @@ extern struct smp_ops_t *smp_ops;
 extern void arch_send_call_function_single_ipi(int cpu);
 extern void arch_send_call_function_ipi(cpumask_t mask);
 
+/* Definitions relative to the secondary CPU spin loop
+ * and entry point. Not all of them exist on both 32 and
+ * 64-bit but defining them all here doesn't harm
+ */
+extern void generic_secondary_smp_init(void);
+extern unsigned long __secondary_hold_spinloop;
+extern unsigned long __secondary_hold_acknowledge;
+extern char __secondary_hold;
+
 #endif /* __ASSEMBLY__ */
 
 #endif /* __KERNEL__ */
Index: linux-work/arch/powerpc/kernel/setup_64.c
===================================================================
--- linux-work.orig/arch/powerpc/kernel/setup_64.c	2009-07-24 15:32:37.000000000 +1000
+++ linux-work/arch/powerpc/kernel/setup_64.c	2009-07-24 15:57:00.000000000 +1000
@@ -230,9 +230,6 @@ void early_setup_secondary(void)
 #endif /* CONFIG_SMP */
 
 #if defined(CONFIG_SMP) || defined(CONFIG_KEXEC)
-extern unsigned long __secondary_hold_spinloop;
-extern void generic_secondary_smp_init(void);
-
 void smp_release_cpus(void)
 {
 	unsigned long *ptr;
Index: linux-work/arch/powerpc/kernel/prom_init.c
===================================================================
--- linux-work.orig/arch/powerpc/kernel/prom_init.c	2009-07-24 16:01:44.000000000 +1000
+++ linux-work/arch/powerpc/kernel/prom_init.c	2009-07-24 16:02:27.000000000 +1000
@@ -1259,10 +1259,6 @@ static void __init prom_initialize_tce_t
  *
  * -- Cort
  */
-extern char __secondary_hold;
-extern unsigned long __secondary_hold_spinloop;
-extern unsigned long __secondary_hold_acknowledge;
-
 /*
  * We want to reference the copy of __secondary_hold_* in the
  * 0 - 0x100 address range
Index: linux-work/arch/powerpc/platforms/85xx/smp.c
===================================================================
--- linux-work.orig/arch/powerpc/platforms/85xx/smp.c	2009-07-24 16:02:47.000000000 +1000
+++ linux-work/arch/powerpc/platforms/85xx/smp.c	2009-07-24 16:02:54.000000000 +1000
@@ -25,7 +25,6 @@
 
 #include <sysdev/fsl_soc.h>
 
-extern volatile unsigned long __secondary_hold_acknowledge;
 extern void __early_start(void);
 
 #define BOOT_ENTRY_ADDR_UPPER	0
Index: linux-work/arch/powerpc/platforms/86xx/mpc86xx_smp.c
===================================================================
--- linux-work.orig/arch/powerpc/platforms/86xx/mpc86xx_smp.c	2009-07-24 16:03:06.000000000 +1000
+++ linux-work/arch/powerpc/platforms/86xx/mpc86xx_smp.c	2009-07-24 16:03:11.000000000 +1000
@@ -27,7 +27,6 @@
 #include "mpc86xx.h"
 
 extern void __secondary_start_mpc86xx(void);
-extern unsigned long __secondary_hold_acknowledge;
 
 #define MCM_PORT_CONFIG_OFFSET	0x10
 
Index: linux-work/arch/powerpc/platforms/cell/smp.c
===================================================================
--- linux-work.orig/arch/powerpc/platforms/cell/smp.c	2009-07-24 16:00:37.000000000 +1000
+++ linux-work/arch/powerpc/platforms/cell/smp.c	2009-07-24 16:00:56.000000000 +1000
@@ -58,8 +58,6 @@
  */
 static cpumask_t of_spin_map;
 
-extern void generic_secondary_smp_init(unsigned long);
-
 /**
  * smp_startup_cpu() - start the given cpu
  *
Index: linux-work/arch/powerpc/platforms/pseries/smp.c
===================================================================
--- linux-work.orig/arch/powerpc/platforms/pseries/smp.c	2009-07-24 16:01:23.000000000 +1000
+++ linux-work/arch/powerpc/platforms/pseries/smp.c	2009-07-24 16:01:25.000000000 +1000
@@ -56,8 +56,6 @@
  */
 static cpumask_t of_spin_map;
 
-extern void generic_secondary_smp_init(unsigned long);
-
 /**
  * smp_startup_cpu() - start the given cpu
  *

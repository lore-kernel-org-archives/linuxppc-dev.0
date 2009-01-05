Return-Path: <miltonm@bga.com>
Received: from mercury.realtime.net (mercury.realtime.net [205.238.132.86])
	by ozlabs.org (Postfix) with ESMTP id 02E2EDE00B
	for <linuxppc-dev@ozlabs.org>; Tue,  6 Jan 2009 00:05:28 +1100 (EST)
To: Matt Sealey <matt@genesi-usa.com>
Subject: [PATCH] powerpc: use common cpu_die 
In-Reply-To: <49614F36.2040406@genesi-usa.com>
From: Milton Miller <miltonm@bga.com>
Date: Mon, 05 Jan 2009 07:05:24 -0600
Message-ID: <1231160724_126472@mercury.realtime.net>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Configuring a powerpc 32 bit kernel for both SMP and SUSPEND turns on
CPU_HOTPLUG to enable disable_nonboot_cpus to be called by the common
suspend code.  Previously the definition of cpu_die for ppc32 was in
the powermac platform code, causing it to be undefined if that platform
as not selected.

Move the code from setup_64 to smp.c and rename the power mac
versions to their specific names.

Note that this does not setup the cpu_die pointers in either
smp_ops (request a given cpu die) or ppc_md (make this cpu die),
for other platforms but there are generic versions in smp.c.

Reported-By: Matt Sealey
Signed-off-by: Milton Miller <miltonm@bga.com>
---
compile tested on Matt's 2.6.27.7 config, both as given and with POWERMAC
rediffed to linus git, applies with offset to 2.6.27.7

Matt please test ... especially sleep on a smp machine


Index: work.git/arch/powerpc/kernel/setup_64.c
===================================================================
--- work.git.orig/arch/powerpc/kernel/setup_64.c	2009-01-05 02:09:08.000000000 -0600
+++ work.git/arch/powerpc/kernel/setup_64.c	2009-01-05 02:27:23.000000000 -0600
@@ -585,12 +585,6 @@ void ppc64_terminate_msg(unsigned int sr
 	printk("[terminate]%04x %s\n", src, msg);
 }
 
-void cpu_die(void)
-{
-	if (ppc_md.cpu_die)
-		ppc_md.cpu_die();
-}
-
 #ifdef CONFIG_SMP
 void __init setup_per_cpu_areas(void)
 {
Index: work.git/arch/powerpc/kernel/smp.c
===================================================================
--- work.git.orig/arch/powerpc/kernel/smp.c	2009-01-05 02:09:08.000000000 -0600
+++ work.git/arch/powerpc/kernel/smp.c	2009-01-05 02:27:23.000000000 -0600
@@ -612,4 +612,10 @@ void __cpu_die(unsigned int cpu)
 	if (smp_ops->cpu_die)
 		smp_ops->cpu_die(cpu);
 }
+
+void cpu_die(void)
+{
+	if (ppc_md.cpu_die)
+		ppc_md.cpu_die();
+}
 #endif
Index: work.git/arch/powerpc/platforms/powermac/pmac.h
===================================================================
--- work.git.orig/arch/powerpc/platforms/powermac/pmac.h	2009-01-05 02:09:08.000000000 -0600
+++ work.git/arch/powerpc/platforms/powermac/pmac.h	2009-01-05 02:27:23.000000000 -0600
@@ -33,6 +33,9 @@ extern void pmac_setup_pci_dma(void);
 extern void pmac_check_ht_link(void);
 
 extern void pmac_setup_smp(void);
+extern void pmac32_cpu_die(void);
+extern void low_cpu_die(void) __attribute__((noreturn));
+
 
 extern int pmac_nvram_init(void);
 extern void pmac_pic_init(void);
Index: work.git/arch/powerpc/platforms/powermac/setup.c
===================================================================
--- work.git.orig/arch/powerpc/platforms/powermac/setup.c	2009-01-05 02:09:08.000000000 -0600
+++ work.git/arch/powerpc/platforms/powermac/setup.c	2009-01-05 02:27:23.000000000 -0600
@@ -672,7 +672,7 @@ static int pmac_pci_probe_mode(struct pc
 /* access per cpu vars from generic smp.c */
 DECLARE_PER_CPU(int, cpu_state);
 
-static void pmac_cpu_die(void)
+static void pmac64_cpu_die(void)
 {
 	/*
 	 * turn off as much as possible, we'll be
@@ -743,7 +743,12 @@ define_machine(powermac) {
 	.pcibios_after_init	= pmac_pcibios_after_init,
 	.phys_mem_access_prot	= pci_phys_mem_access_prot,
 #endif
-#if defined(CONFIG_HOTPLUG_CPU) && defined(CONFIG_PPC64)
-	.cpu_die		= pmac_cpu_die,
+#ifdef CONFIG_HOTPLUG_CPU
+#ifdef CONFIG_PPC64
+	.cpu_die		= pmac64_cpu_die,
+#endif
+#ifdef CONFIG_PPC32
+	.cpu_die		= pmac32_cpu_die,
+#endif
 #endif
 };
Index: work.git/arch/powerpc/platforms/powermac/smp.c
===================================================================
--- work.git.orig/arch/powerpc/platforms/powermac/smp.c	2009-01-05 02:09:08.000000000 -0600
+++ work.git/arch/powerpc/platforms/powermac/smp.c	2009-01-05 02:27:23.000000000 -0600
@@ -53,6 +53,8 @@
 #include <asm/pmac_low_i2c.h>
 #include <asm/pmac_pfunc.h>
 
+#include "pmac.h"
+
 #define DEBUG
 
 #ifdef DEBUG
@@ -872,10 +874,9 @@ int smp_core99_cpu_disable(void)
 	return 0;
 }
 
-extern void low_cpu_die(void) __attribute__((noreturn)); /* in sleep.S */
 static int cpu_dead[NR_CPUS];
 
-void cpu_die(void)
+void pmac32_cpu_die(void)
 {
 	local_irq_disable();
 	cpu_dead[smp_processor_id()] = 1;

Return-Path: <avorontsov@mvista.com>
Received: from buildserver.ru.mvista.com (unknown [213.79.90.228])
	by ozlabs.org (Postfix) with ESMTP id 91A2FB7D65
	for <linuxppc-dev@ozlabs.org>; Wed, 19 May 2010 22:56:33 +1000 (EST)
Date: Wed, 19 May 2010 16:56:29 +0400
From: Anton Vorontsov <avorontsov@mvista.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [PATCH] powerpc: Use common cpu_die (fixes SMP+SUSPEND build)
Message-ID: <20100519125629.GA25449@oksana.dev.rtsoft.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Milton Miller <miltonm@bga.com>, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Milton Miller <miltonm@bga.com>

Configuring a powerpc 32 bit kernel for both SMP and SUSPEND turns on
CPU_HOTPLUG to enable disable_nonboot_cpus to be called by the common
suspend code.  Previously the definition of cpu_die for ppc32 was in
the powermac platform code, causing it to be undefined if that platform
as not selected.

arch/powerpc/kernel/built-in.o: In function 'cpu_idle':
arch/powerpc/kernel/idle.c:98: undefined reference to 'cpu_die'

Move the code from setup_64 to smp.c and rename the power mac
versions to their specific names.

Note that this does not setup the cpu_die pointers in either
smp_ops (request a given cpu die) or ppc_md (make this cpu die),
for other platforms but there are generic versions in smp.c.

Reported-by: Matt Sealey <matt@genesi-usa.com>
Reported-by: Kumar Gala <galak@kernel.crashing.org>
Signed-off-by: Milton Miller <miltonm@bga.com>
Signed-off-by: Anton Vorontsov <avorontsov@mvista.com>
---
 arch/powerpc/kernel/setup_64.c          |    6 ------
 arch/powerpc/kernel/smp.c               |    6 ++++++
 arch/powerpc/platforms/powermac/pmac.h  |    2 ++
 arch/powerpc/platforms/powermac/setup.c |   11 ++++++++---
 arch/powerpc/platforms/powermac/smp.c   |    5 +++--
 5 files changed, 19 insertions(+), 11 deletions(-)

diff --git a/arch/powerpc/kernel/setup_64.c b/arch/powerpc/kernel/setup_64.c
index 9143891..cea6698 100644
--- a/arch/powerpc/kernel/setup_64.c
+++ b/arch/powerpc/kernel/setup_64.c
@@ -573,12 +573,6 @@ void ppc64_boot_msg(unsigned int src, const char *msg)
 	printk("[boot]%04x %s\n", src, msg);
 }
 
-void cpu_die(void)
-{
-	if (ppc_md.cpu_die)
-		ppc_md.cpu_die();
-}
-
 #ifdef CONFIG_SMP
 #define PCPU_DYN_SIZE		()
 
diff --git a/arch/powerpc/kernel/smp.c b/arch/powerpc/kernel/smp.c
index c2ee144..a3b8d61 100644
--- a/arch/powerpc/kernel/smp.c
+++ b/arch/powerpc/kernel/smp.c
@@ -631,4 +631,10 @@ void cpu_hotplug_driver_unlock()
 {
 	mutex_unlock(&powerpc_cpu_hotplug_driver_mutex);
 }
+
+void cpu_die(void)
+{
+	if (ppc_md.cpu_die)
+		ppc_md.cpu_die();
+}
 #endif
diff --git a/arch/powerpc/platforms/powermac/pmac.h b/arch/powerpc/platforms/powermac/pmac.h
index 3362e78..f0bc08f 100644
--- a/arch/powerpc/platforms/powermac/pmac.h
+++ b/arch/powerpc/platforms/powermac/pmac.h
@@ -33,6 +33,8 @@ extern void pmac_setup_pci_dma(void);
 extern void pmac_check_ht_link(void);
 
 extern void pmac_setup_smp(void);
+extern void pmac32_cpu_die(void);
+extern void low_cpu_die(void) __attribute__((noreturn));
 
 extern int pmac_nvram_init(void);
 extern void pmac_pic_init(void);
diff --git a/arch/powerpc/platforms/powermac/setup.c b/arch/powerpc/platforms/powermac/setup.c
index 15c2241..8b42476 100644
--- a/arch/powerpc/platforms/powermac/setup.c
+++ b/arch/powerpc/platforms/powermac/setup.c
@@ -646,7 +646,7 @@ static int pmac_pci_probe_mode(struct pci_bus *bus)
 /* access per cpu vars from generic smp.c */
 DECLARE_PER_CPU(int, cpu_state);
 
-static void pmac_cpu_die(void)
+static void pmac64_cpu_die(void)
 {
 	/*
 	 * turn off as much as possible, we'll be
@@ -717,8 +717,13 @@ define_machine(powermac) {
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
 #if defined(CONFIG_HOTPLUG_CPU) && defined(CONFIG_PPC32)
 	.cpu_die		= generic_mach_cpu_die,
diff --git a/arch/powerpc/platforms/powermac/smp.c b/arch/powerpc/platforms/powermac/smp.c
index 6898e82..64f3a46 100644
--- a/arch/powerpc/platforms/powermac/smp.c
+++ b/arch/powerpc/platforms/powermac/smp.c
@@ -53,6 +53,8 @@
 #include <asm/pmac_low_i2c.h>
 #include <asm/pmac_pfunc.h>
 
+#include "pmac.h"
+
 #undef DEBUG
 
 #ifdef DEBUG
@@ -878,10 +880,9 @@ int smp_core99_cpu_disable(void)
 	return 0;
 }
 
-extern void low_cpu_die(void) __attribute__((noreturn)); /* in sleep.S */
 static int cpu_dead[NR_CPUS];
 
-void cpu_die(void)
+void pmac32_cpu_die(void)
 {
 	local_irq_disable();
 	cpu_dead[smp_processor_id()] = 1;
-- 
1.7.0.5

Return-Path: <msm@freescale.com>
Received: from VA3EHSOBE001.bigfish.com (va3ehsobe001.messaging.microsoft.com
	[216.32.180.11]) by ozlabs.org (Postfix) with ESMTP id 5EEA4B6F07
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 22 Jul 2010 07:13:46 +1000 (EST)
Received: from mail174-va3 (localhost.localdomain [127.0.0.1])	by
	mail174-va3-R.bigfish.com (Postfix) with ESMTP id 6A8A21980281	for
	<linuxppc-dev@lists.ozlabs.org>; Wed, 21 Jul 2010 21:13:38 +0000 (UTC)
Received: from VA3EHSMHS025.bigfish.com (unknown [10.7.14.238])	by
	mail174-va3.bigfish.com (Postfix) with ESMTP id DACA970046	for
	<linuxppc-dev@lists.ozlabs.org>; Wed, 21 Jul 2010 21:13:37 +0000 (UTC)
Received: from az33smr01.freescale.net (az33smr01.freescale.net
	[10.64.34.199])	by az33egw02.freescale.net (8.14.3/8.14.3) with ESMTP
	id o6LLDaqb009041	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 21 Jul 2010 14:13:36 -0700 (MST)
From: Matthew McClintock <msm@freescale.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v2 1/2] powerpc/85xx: kexec for SMP 85xx BookE systems
Date: Wed, 21 Jul 2010 16:14:53 -0500
Message-ID: <1279746894-29529-2-git-send-email-msm@freescale.com>
In-Reply-To: <1279746894-29529-1-git-send-email-msm@freescale.com>
References: <1279746894-29529-1-git-send-email-msm@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: Matthew McClintock <msm@freescale.com>, kumar.gala@freescale.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Adds support for kexec on 85xx machines for the BookE platform.
Including support for SMP machines

Based off work from Maxim Uvarov <muvarov@mvista.com>
Signed-off-by: Matthew McClintock <msm@freescale.com>
---
 arch/powerpc/Kconfig              |   10 +++---
 arch/powerpc/platforms/85xx/smp.c |   63 +++++++++++++++++++++++++++++++++++++
 2 files changed, 68 insertions(+), 5 deletions(-)

diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index 328774b..351ce4a 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -351,7 +351,7 @@ config ARCH_ENABLE_MEMORY_HOTREMOVE
 
 config KEXEC
 	bool "kexec system call (EXPERIMENTAL)"
-	depends on (PPC_BOOK3S || (FSL_BOOKE && !SMP)) && EXPERIMENTAL
+	depends on (PPC_BOOK3S || FSL_BOOKE) && EXPERIMENTAL
 	help
 	  kexec is a system call that implements the ability to shutdown your
 	  current kernel, and to start another kernel.  It is like a reboot
@@ -368,8 +368,8 @@ config KEXEC
 
 config CRASH_DUMP
 	bool "Build a kdump crash kernel"
-	depends on PPC64 || 6xx
-	select RELOCATABLE if PPC64
+	depends on PPC64 || 6xx || FSL_BOOKE
+	select RELOCATABLE if PPC64 || FSL_BOOKE
 	help
 	  Build a kernel suitable for use as a kdump capture kernel.
 	  The same kernel binary can be used as production kernel and dump
@@ -897,7 +897,7 @@ config KERNEL_START_BOOL
 config KERNEL_START
 	hex "Virtual address of kernel base" if KERNEL_START_BOOL
 	default PAGE_OFFSET if PAGE_OFFSET_BOOL
-	default "0xc2000000" if CRASH_DUMP
+	default "0xc2000000" if CRASH_DUMP && !RELOCATABLE
 	default "0xc0000000"
 
 config PHYSICAL_START_BOOL
@@ -910,7 +910,7 @@ config PHYSICAL_START_BOOL
 
 config PHYSICAL_START
 	hex "Physical address where the kernel is loaded" if PHYSICAL_START_BOOL
-	default "0x02000000" if PPC_STD_MMU && CRASH_DUMP
+	default "0x02000000" if PPC_STD_MMU && CRASH_DUMP && !RELOCATABLE
 	default "0x00000000"
 
 config PHYSICAL_ALIGN
diff --git a/arch/powerpc/platforms/85xx/smp.c b/arch/powerpc/platforms/85xx/smp.c
index a15f582..036c33c 100644
--- a/arch/powerpc/platforms/85xx/smp.c
+++ b/arch/powerpc/platforms/85xx/smp.c
@@ -15,6 +15,7 @@
 #include <linux/init.h>
 #include <linux/delay.h>
 #include <linux/of.h>
+#include <linux/kexec.h>
 
 #include <asm/machdep.h>
 #include <asm/pgtable.h>
@@ -24,6 +25,7 @@
 #include <asm/dbell.h>
 
 #include <sysdev/fsl_soc.h>
+#include <sysdev/mpic.h>
 
 extern void __early_start(void);
 
@@ -103,8 +105,64 @@ smp_85xx_setup_cpu(int cpu_nr)
 
 struct smp_ops_t smp_85xx_ops = {
 	.kick_cpu = smp_85xx_kick_cpu,
+#ifdef CONFIG_KEXEC
+	.give_timebase	= smp_generic_give_timebase,
+	.take_timebase	= smp_generic_take_timebase,
+#endif
 };
 
+#ifdef CONFIG_KEXEC
+static int kexec_down_cpus = 0;
+
+void mpc85xx_smp_kexec_cpu_down(int crash_shutdown, int secondary)
+{
+	mpic_teardown_this_cpu(1);
+
+	/* When crashing, this gets called on all CPU's we only
+	 * take down the non-boot cpus */
+	if (smp_processor_id() != boot_cpuid)
+	{
+		local_irq_disable();
+		kexec_down_cpus++;
+
+		while (1);
+	}
+}
+
+static void mpc85xx_smp_kexec_down(void *arg)
+{
+	if (ppc_md.kexec_cpu_down)
+		ppc_md.kexec_cpu_down(0,1);
+}
+
+static void mpc85xx_smp_machine_kexec(struct kimage *image)
+{
+	int timeout = 2000;
+	int i;
+
+	set_cpus_allowed(current, cpumask_of_cpu(boot_cpuid));
+
+	smp_call_function(mpc85xx_smp_kexec_down, NULL, 0);
+
+	while ( (kexec_down_cpus != (num_online_cpus() - 1)) &&
+		( timeout > 0 ) )
+	{
+		timeout--;
+	}
+
+	if ( !timeout )
+		printk(KERN_ERR "Unable to bring down secondary cpu(s)");
+
+	for (i = 0; i < num_present_cpus(); i++)
+	{
+		if ( i == smp_processor_id() ) continue;
+		mpic_reset_core(i);
+	}
+
+	default_machine_kexec(image);
+}
+#endif /* CONFIG_KEXEC */
+
 void __init mpc85xx_smp_init(void)
 {
 	struct device_node *np;
@@ -122,4 +180,9 @@ void __init mpc85xx_smp_init(void)
 	BUG_ON(!smp_85xx_ops.message_pass);
 
 	smp_ops = &smp_85xx_ops;
+
+#ifdef CONFIG_KEXEC
+	ppc_md.kexec_cpu_down = mpc85xx_smp_kexec_cpu_down;
+	ppc_md.machine_kexec = mpc85xx_smp_machine_kexec;
+#endif
 }
-- 
1.6.6.1

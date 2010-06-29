Return-Path: <msm@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id A73B1B7244
	for <linuxppc-dev@ozlabs.org>; Wed, 30 Jun 2010 05:40:17 +1000 (EST)
Received: from az33smr01.freescale.net (az33smr01.freescale.net [10.64.34.199])
	by az33egw02.freescale.net (8.14.3/az33egw02) with ESMTP id
	o5TJeFUo023432
	for <linuxppc-dev@ozlabs.org>; Tue, 29 Jun 2010 12:40:15 -0700 (MST)
From: Matthew McClintock <msm@freescale.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 2/2] powerpc/85xx platorms: kexec for SMP 85xx BookE systems
Date: Tue, 29 Jun 2010 14:42:27 -0500
Message-Id: <1277840547-19007-2-git-send-email-msm@freescale.com>
In-Reply-To: <1277840547-19007-1-git-send-email-msm@freescale.com>
References: <1277840547-19007-1-git-send-email-msm@freescale.com>
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
To test/use you will need to fetch kexec from GIT and apply the following 
patch for kexec to work properply with uImages
 
http://lists.infradead.org/pipermail/kexec/2010-June/004163.html

 arch/powerpc/Kconfig              |    2 +-
 arch/powerpc/platforms/85xx/smp.c |   57 +++++++++++++++++++++++++++++++++++++
 2 files changed, 58 insertions(+), 1 deletions(-)

diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index 328774b..042f2f0 100644
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
diff --git a/arch/powerpc/platforms/85xx/smp.c b/arch/powerpc/platforms/85xx/smp.c
index a15f582..35c3d95 100644
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
 
@@ -103,8 +105,58 @@ smp_85xx_setup_cpu(int cpu_nr)
 
 struct smp_ops_t smp_85xx_ops = {
 	.kick_cpu = smp_85xx_kick_cpu,
+#ifdef CONFIG_KEXEC
+	.give_timebase	= smp_generic_give_timebase,
+	.take_timebase	= smp_generic_take_timebase,
+#endif
 };
 
+#ifdef CONFIG_KEXEC
+void mpc85xx_smp_kexec_cpu_down(int crash_shutdown, int secondary)
+{
+	mpic_teardown_this_cpu(1);
+}
+
+static int kexec_down_cpus = 0;
+
+static void mpc85xx_smp_kexec_down(void *arg)
+{
+	if (ppc_md.kexec_cpu_down)
+		ppc_md.kexec_cpu_down(0,1);
+
+	local_irq_disable();
+	kexec_down_cpus++;
+	while (1) ;
+}
+
+static void mpc85xx_smp_machine_kexec(struct kimage *image)
+{
+	int timeout = 1000;
+	int i;
+
+	set_cpus_allowed(current, cpumask_of_cpu(boot_cpuid));
+
+	smp_call_function(mpc85xx_smp_kexec_down, NULL, 0);
+
+	while ( (kexec_down_cpus != (num_present_cpus() - 1)) &&
+		( timeout-- > 0 ) )
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
@@ -122,4 +174,9 @@ void __init mpc85xx_smp_init(void)
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

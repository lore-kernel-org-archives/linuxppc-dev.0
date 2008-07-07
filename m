Return-Path: <krafft@de.ibm.com>
Date: Mon, 7 Jul 2008 18:54:28 +0200
From: Christian Krafft <krafft@de.ibm.com>
To: Christian Krafft <krafft@linux.ibm.com>
Subject: Re: [Cbe-oss-dev] [patch 01/02] powerpc/cell: cleanup sysreset_hack
	for IBM cell blades
Message-ID: <20080707185428.042a6131@de.ibm.com>
In-Reply-To: <20080707184756.16e52677@linux.ibm.com>
References: <20080704190535.316377278@arndb.de>
	<20080704190805.638836822@arndb.de>
	<1215407543.8970.61.camel@pasglop>
	<20080707112322.26a21902@de.ibm.com>
	<20080707184756.16e52677@linux.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: cbe-oss-dev@ozlabs.org, arnd@arndb.de, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Christian Krafft <krafft@de.ibm.com>

This patch adds a config option for the sysreset_hack used for
IBM Cell blades. The code is moves from pervasive.c into ras.c and
gets it's own init method.

Signed-off-by: Christian Krafft <krafft@de.ibm.com>

Index: linux.git/arch/powerpc/platforms/cell/pervasive.c
===================================================================
--- linux.git.orig/arch/powerpc/platforms/cell/pervasive.c
+++ linux.git/arch/powerpc/platforms/cell/pervasive.c
@@ -38,8 +38,6 @@
 
 #include "pervasive.h"
 
-static int sysreset_hack;
-
 static void cbe_power_save(void)
 {
 	unsigned long ctrl, thread_switch_control;
@@ -87,9 +85,6 @@ static void cbe_power_save(void)
 
 static int cbe_system_reset_exception(struct pt_regs *regs)
 {
-	int cpu;
-	struct cbe_pmd_regs __iomem *pmd;
-
 	switch (regs->msr & SRR1_WAKEMASK) {
 	case SRR1_WAKEEE:
 		do_IRQ(regs);
@@ -98,19 +93,7 @@ static int cbe_system_reset_exception(st
 		timer_interrupt(regs);
 		break;
 	case SRR1_WAKEMT:
-		/*
-		 * The BMC can inject user triggered system reset exceptions,
-		 * but cannot set the system reset reason in srr1,
-		 * so check an extra register here.
-		 */
-		if (sysreset_hack && (cpu = smp_processor_id()) == 0) {
-			pmd = cbe_get_cpu_pmd_regs(cpu);
-			if (in_be64(&pmd->ras_esc_0) & 0xffff) {
-				out_be64(&pmd->ras_esc_0, 0);
-				return 0;
-			}
-		}
-		break;
+		return cbe_sysreset_hack();
 #ifdef CONFIG_CBE_RAS
 	case SRR1_WAKESYSERR:
 		cbe_system_error_exception(regs);
@@ -134,8 +117,6 @@ void __init cbe_pervasive_init(void)
 	if (!cpu_has_feature(CPU_FTR_PAUSE_ZERO))
 		return;
 
-	sysreset_hack = machine_is_compatible("IBM,CBPLUS-1.0");
-
 	for_each_possible_cpu(cpu) {
 		struct cbe_pmd_regs __iomem *regs = cbe_get_cpu_pmd_regs(cpu);
 		if (!regs)
@@ -144,12 +125,6 @@ void __init cbe_pervasive_init(void)
 		 /* Enable Pause(0) control bit */
 		out_be64(&regs->pmcr, in_be64(&regs->pmcr) |
 					    CBE_PMD_PAUSE_ZERO_CONTROL);
-
-		/* Enable JTAG system-reset hack */
-		if (sysreset_hack)
-			out_be32(&regs->fir_mode_reg,
-				in_be32(&regs->fir_mode_reg) |
-				CBE_PMD_FIR_MODE_M8);
 	}
 
 	ppc_md.power_save = cbe_power_save;
Index: linux.git/arch/powerpc/platforms/cell/Kconfig
===================================================================
--- linux.git.orig/arch/powerpc/platforms/cell/Kconfig
+++ linux.git/arch/powerpc/platforms/cell/Kconfig
@@ -83,6 +83,14 @@ config CBE_RAS
 	depends on PPC_CELL_NATIVE
 	default y
 
+config PPC_IBM_CELL_BLADE_BUTTONS
+	bool "IBM Cell Blade Buttons"
+	depends on CBE_RAS && PPC_IBM_CELL_BLADE
+	default y
+	help
+	  Support Buttons on IBM Cell blades. This adds a method to
+	  trigger system reset via front panel pinhole button.
+
 config CBE_THERM
 	tristate "CBE thermal support"
 	default m
Index: linux.git/arch/powerpc/platforms/cell/pervasive.h
===================================================================
--- linux.git.orig/arch/powerpc/platforms/cell/pervasive.h
+++ linux.git/arch/powerpc/platforms/cell/pervasive.h
@@ -30,4 +30,13 @@ extern void cbe_system_error_exception(s
 extern void cbe_maintenance_exception(struct pt_regs *regs);
 extern void cbe_thermal_exception(struct pt_regs *regs);
 
+#ifdef CONFIG_PPC_IBM_CELL_BLADE_BUTTONS
+extern int cbe_sysreset_hack(void);
+#else
+static inline int cbe_sysreset_hack(void)
+{
+	return 1;
+}
+#endif /* CONFIG_PPC_IBM_CELL_BLADE_BUTTONS */
+
 #endif
Index: linux.git/arch/powerpc/platforms/cell/ras.c
===================================================================
--- linux.git.orig/arch/powerpc/platforms/cell/ras.c
+++ linux.git/arch/powerpc/platforms/cell/ras.c
@@ -230,6 +230,50 @@ static struct notifier_block cbe_ptcal_r
 	.notifier_call = cbe_ptcal_notify_reboot
 };
 
+#ifdef CONFIG_PPC_IBM_CELL_BLADE_BUTTONS
+static int sysreset_hack;
+
+static int __init cbe_sysreset_init(void)
+{
+	struct cbe_pmd_regs __iomem *regs;
+
+	sysreset_hack = machine_is_compatible("IBM,CBPLUS-1.0");
+	if (!sysreset_hack)
+		return 0;
+
+	/* Enable JTAG system-reset hack */
+	regs = cbe_get_cpu_pmd_regs(0);
+	if (regs)
+		out_be32(&regs->fir_mode_reg,
+			in_be32(&regs->fir_mode_reg) |
+			CBE_PMD_FIR_MODE_M8);
+
+	return 0;
+}
+device_initcall(cbe_sysreset_init);
+
+int cbe_sysreset_hack(void)
+{
+	struct cbe_pmd_regs __iomem *regs;
+
+	/*
+	 * The BMC can inject user triggered system reset exceptions,
+	 * but cannot set the system reset reason in srr1,
+	 * so check an extra register here.
+	 */
+	if (sysreset_hack && (smp_processor_id() == 0)) {
+		regs = cbe_get_cpu_pmd_regs(0);
+		if (!regs)
+			return 0;
+		if (in_be64(&regs->ras_esc_0) & 0x0000ffff) {
+			out_be64(&regs->ras_esc_0, 0);
+			return 0;
+		}
+	}
+	return 1;
+}
+#endif /* CONFIG_PPC_IBM_CELL_BLADE_BUTTONS */
+
 int __init cbe_ptcal_init(void)
 {
 	int ret;

-- 
Mit freundlichen Gruessen,
kind regards,

Christian Krafft
Linux Kernel Development
IBM Systems & Technology Group
Phone: +49-07031-16-2032

IBM Deutschland Research & Development GmbH
Vorsitzender des Aufsichtsrats:	Martin Jetter
Geschaetsfuehung:		Herbert Kircher
Sitz der Gesellschaft:		Boelingen
Registergericht:		Amtsgericht Stuttgart, HRB 243294

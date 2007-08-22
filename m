Return-Path: <arnd@arndb.de>
Message-Id: <20070822170732.141665324@arndb.de>
References: <20070822170124.764128591@arndb.de>
Date: Wed, 22 Aug 2007 19:01:26 +0200
From: Arnd Bergmann <arnd@arndb.de>
To: paulus@samba.org
Subject: [patch 2/5] cell: support pinhole-reset on IBM cell blades
Cc: Arnd Bergmann <arnd.bergmann@de.ibm.com>, linuxppc-dev@ozlabs.org,
	linux-kernel@vger.kernel.org, cbe-oss-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Arnd Bergmann <arnd.bergmann@de.ibm.com>
The Cell Broadband Engine has a method of injecting a
system-reset-exception from an external source into the
operating system, which should trigger the regular behaviour
of entering xmon or kdump.

Unfortunately, the exception handler cannot distinguish it from
other interrupt causes by the SRR1 register, which gets used
for this on Power 6 and others.

IBM Blade servers that want to support triggering the
system reset exception using a pinhole button in the front
panel therefore use an extra register to determine the
reset cause.

Signed-off-by: Arnd Bergmann <arnd.bergmann@de.ibm.com>

Index: linux-2.6/arch/powerpc/platforms/cell/cbe_regs.h
===================================================================
--- linux-2.6.orig/arch/powerpc/platforms/cell/cbe_regs.h
+++ linux-2.6/arch/powerpc/platforms/cell/cbe_regs.h
@@ -113,10 +113,14 @@ struct cbe_pmd_regs {
 	u64	checkstop_fir;					/* 0x0c00 */
 	u64	recoverable_fir;				/* 0x0c08 */
 	u64	spec_att_mchk_fir;				/* 0x0c10 */
-	u64	fir_mode_reg;					/* 0x0c18 */
+	u32	fir_mode_reg;					/* 0x0c18 */
+	u8	pad_0x0c1c_0x0c20 [4];				/* 0x0c1c */
+#define CBE_PMD_FIR_MODE_M8		0x00800
 	u64	fir_enable_mask;				/* 0x0c20 */
 
-	u8	pad_0x0c28_0x1000 [0x1000 - 0x0c28];		/* 0x0c28 */
+	u8	pad_0x0c28_0x0ca8 [0x0ca8 - 0x0c28];		/* 0x0c28 */
+	u64	ras_esc_0;					/* 0x0ca8 */
+	u8	pad_0x0cb0_0x1000 [0x1000 - 0x0cb0];		/* 0x0cb0 */
 };
 
 extern struct cbe_pmd_regs __iomem *cbe_get_pmd_regs(struct device_node *np);
Index: linux-2.6/arch/powerpc/platforms/cell/pervasive.c
===================================================================
--- linux-2.6.orig/arch/powerpc/platforms/cell/pervasive.c
+++ linux-2.6/arch/powerpc/platforms/cell/pervasive.c
@@ -38,6 +38,8 @@
 #include "pervasive.h"
 #include "cbe_regs.h"
 
+static int sysreset_hack;
+
 static void cbe_power_save(void)
 {
 	unsigned long ctrl, thread_switch_control;
@@ -85,6 +87,9 @@ static void cbe_power_save(void)
 
 static int cbe_system_reset_exception(struct pt_regs *regs)
 {
+	int cpu;
+	struct cbe_pmd_regs __iomem *pmd;
+
 	switch (regs->msr & SRR1_WAKEMASK) {
 	case SRR1_WAKEEE:
 		do_IRQ(regs);
@@ -93,6 +98,18 @@ static int cbe_system_reset_exception(st
 		timer_interrupt(regs);
 		break;
 	case SRR1_WAKEMT:
+		/*
+		 * The BMC can inject user triggered system reset exceptions,
+		 * but cannot set the system reset reason in srr1,
+		 * so check an extra register here.
+		 */
+		if (sysreset_hack && (cpu = smp_processor_id()) == 0) {
+			pmd = cbe_get_cpu_pmd_regs(cpu);
+			if (in_be64(&pmd->ras_esc_0) & 0xffff) {
+				out_be64(&pmd->ras_esc_0, 0);
+				return 0;
+			}
+		}
 		break;
 #ifdef CONFIG_CBE_RAS
 	case SRR1_WAKESYSERR:
@@ -113,9 +130,12 @@ static int cbe_system_reset_exception(st
 void __init cbe_pervasive_init(void)
 {
 	int cpu;
+
 	if (!cpu_has_feature(CPU_FTR_PAUSE_ZERO))
 		return;
 
+	sysreset_hack = machine_is_compatible("IBM,CBPLUS-1.0");
+
 	for_each_possible_cpu(cpu) {
 		struct cbe_pmd_regs __iomem *regs = cbe_get_cpu_pmd_regs(cpu);
 		if (!regs)
@@ -124,6 +144,12 @@ void __init cbe_pervasive_init(void)
 		 /* Enable Pause(0) control bit */
 		out_be64(&regs->pmcr, in_be64(&regs->pmcr) |
 					    CBE_PMD_PAUSE_ZERO_CONTROL);
+
+		/* Enable JTAG system-reset hack */
+		if (sysreset_hack)
+			out_be32(&regs->fir_mode_reg,
+				in_be32(&regs->fir_mode_reg) |
+				CBE_PMD_FIR_MODE_M8);
 	}
 
 	ppc_md.power_save = cbe_power_save;

--

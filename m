Return-Path: <olof@lixom.net>
Received: from mail.lixom.net (lixom.net [66.141.50.11])
	by ozlabs.org (Postfix) with ESMTP id 65A77DDF39
	for <linuxppc-dev@ozlabs.org>; Mon, 16 Apr 2007 16:12:13 +1000 (EST)
Date: Mon, 16 Apr 2007 01:30:15 -0500
To: paulus@samba.org
Subject: [PATCH] [4/5] pasemi: PA6T oprofile support
Message-ID: <20070416063015.GB20319@lixom.net>
References: <20070416062634.GB20196@lixom.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070416062634.GB20196@lixom.net>
From: olof@lixom.net (Olof Johansson)
Cc: linuxppc-dev@ozlabs.org, anton@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Oprofile support for PA6T, kernel side.

Also rename the PA6T_SPRN.* defines to SPRN_PA6T.*.


Signed-off-by: Olof Johansson <olof@lixom.net>

Index: linux-2.6/arch/powerpc/kernel/cputable.c
===================================================================
--- linux-2.6.orig/arch/powerpc/kernel/cputable.c
+++ linux-2.6/arch/powerpc/kernel/cputable.c
@@ -373,6 +373,8 @@ static struct cpu_spec cpu_specs[] = {
 		.pmc_type		= PPC_PMC_PA6T,
 		.cpu_setup		= __setup_cpu_pa6t,
 		.cpu_restore		= __restore_cpu_pa6t,
+		.oprofile_cpu_type	= "ppc64/pa6t",
+		.oprofile_type		= PPC_OPROFILE_PA6T,
 		.platform		= "pa6t",
 	},
 	{	/* default match */
Index: linux-2.6/arch/powerpc/kernel/sysfs.c
===================================================================
--- linux-2.6.orig/arch/powerpc/kernel/sysfs.c
+++ linux-2.6/arch/powerpc/kernel/sysfs.c
@@ -189,12 +189,12 @@ SYSFS_PMCSETUP(purr, SPRN_PURR);
 SYSFS_PMCSETUP(spurr, SPRN_SPURR);
 SYSFS_PMCSETUP(dscr, SPRN_DSCR);
 
-SYSFS_PMCSETUP(pa6t_pmc0, PA6T_SPRN_PMC0);
-SYSFS_PMCSETUP(pa6t_pmc1, PA6T_SPRN_PMC1);
-SYSFS_PMCSETUP(pa6t_pmc2, PA6T_SPRN_PMC2);
-SYSFS_PMCSETUP(pa6t_pmc3, PA6T_SPRN_PMC3);
-SYSFS_PMCSETUP(pa6t_pmc4, PA6T_SPRN_PMC4);
-SYSFS_PMCSETUP(pa6t_pmc5, PA6T_SPRN_PMC5);
+SYSFS_PMCSETUP(pa6t_pmc0, SPRN_PA6T_PMC0);
+SYSFS_PMCSETUP(pa6t_pmc1, SPRN_PA6T_PMC1);
+SYSFS_PMCSETUP(pa6t_pmc2, SPRN_PA6T_PMC2);
+SYSFS_PMCSETUP(pa6t_pmc3, SPRN_PA6T_PMC3);
+SYSFS_PMCSETUP(pa6t_pmc4, SPRN_PA6T_PMC4);
+SYSFS_PMCSETUP(pa6t_pmc5, SPRN_PA6T_PMC5);
 
 
 static SYSDEV_ATTR(mmcra, 0600, show_mmcra, store_mmcra);
Index: linux-2.6/arch/powerpc/oprofile/op_model_pa6t.c
===================================================================
--- /dev/null
+++ linux-2.6/arch/powerpc/oprofile/op_model_pa6t.c
@@ -0,0 +1,234 @@
+/*
+ * Copyright (C) 2006-2007 PA Semi, Inc
+ *
+ * Author: Shashi Rao, PA Semi
+ *
+ * Maintained by: Olof Johansson <olof@lixom.net>
+ *
+ * Based on arch/powerpc/oprofile/op_model_power4.c
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307 USA
+ */
+
+#include <linux/oprofile.h>
+#include <linux/init.h>
+#include <linux/smp.h>
+#include <linux/percpu.h>
+#include <asm/processor.h>
+#include <asm/cputable.h>
+#include <asm/oprofile_impl.h>
+#include <asm/reg.h>
+
+static unsigned char oprofile_running;
+
+/* mmcr values are set in pa6t_reg_setup, used in pa6t_cpu_setup */
+static u64 mmcr0_val;
+static u64 mmcr1_val;
+
+/* inited in pa6t_reg_setup */
+static u64 reset_value[OP_MAX_COUNTER];
+
+static inline u64 ctr_read(unsigned int i)
+{
+	switch (i) {
+	case 0:
+		return mfspr(SPRN_PA6T_PMC0);
+	case 1:
+		return mfspr(SPRN_PA6T_PMC1);
+	case 2:
+		return mfspr(SPRN_PA6T_PMC2);
+	case 3:
+		return mfspr(SPRN_PA6T_PMC3);
+	case 4:
+		return mfspr(SPRN_PA6T_PMC4);
+	case 5:
+		return mfspr(SPRN_PA6T_PMC5);
+	default:
+		printk(KERN_ERR "ctr_read called with bad arg %u\n", i);
+		return 0;
+	}
+}
+
+static inline void ctr_write(unsigned int i, u64 val)
+{
+	switch (i) {
+	case 0:
+		mtspr(SPRN_PA6T_PMC0, val);
+		break;
+	case 1:
+		mtspr(SPRN_PA6T_PMC1, val);
+		break;
+	case 2:
+		mtspr(SPRN_PA6T_PMC2, val);
+		break;
+	case 3:
+		mtspr(SPRN_PA6T_PMC3, val);
+		break;
+	case 4:
+		mtspr(SPRN_PA6T_PMC4, val);
+		break;
+	case 5:
+		mtspr(SPRN_PA6T_PMC5, val);
+		break;
+	default:
+		printk(KERN_ERR "ctr_write called with bad arg %u\n", i);
+		break;
+	}
+}
+
+
+/* precompute the values to stuff in the hardware registers */
+static void pa6t_reg_setup(struct op_counter_config *ctr,
+			   struct op_system_config *sys,
+			   int num_ctrs)
+{
+	int pmc;
+
+	/*
+	 * adjust the mmcr0.en[0-5] and mmcr0.inten[0-5] values obtained from the
+	 * event_mappings file by turning off the counters that the user doesn't
+	 * care about
+	 *
+	 * setup user and kernel profiling
+	 */
+	for (pmc = 0; pmc < cur_cpu_spec->num_pmcs; pmc++)
+		if (!ctr[pmc].enabled) {
+			sys->mmcr0 &= ~(0x1UL << pmc);
+			sys->mmcr0 &= ~(0x1UL << (pmc+12));
+			pr_debug("turned off counter %u\n", pmc);
+		}
+
+	if (sys->enable_kernel)
+		sys->mmcr0 |= PA6T_MMCR0_SUPEN | PA6T_MMCR0_HYPEN;
+	else
+		sys->mmcr0 &= ~(PA6T_MMCR0_SUPEN | PA6T_MMCR0_HYPEN);
+
+	if (sys->enable_user)
+		sys->mmcr0 |= PA6T_MMCR0_PREN;
+	else
+		sys->mmcr0 &= ~PA6T_MMCR0_PREN;
+
+	/*
+	 * The performance counter event settings are given in the mmcr0 and
+	 * mmcr1 values passed from the user in the op_system_config
+	 * structure (sys variable).
+	 */
+	mmcr0_val = sys->mmcr0;
+	mmcr1_val = sys->mmcr1;
+	pr_debug("mmcr0_val inited to %016lx\n", sys->mmcr0);
+	pr_debug("mmcr1_val inited to %016lx\n", sys->mmcr1);
+
+	for (pmc = 0; pmc < cur_cpu_spec->num_pmcs; pmc++) {
+		/* counters are 40 bit. Move to cputable at some point? */
+		reset_value[pmc] = (0x1UL << 39) - ctr[pmc].count;
+		pr_debug("reset_value for pmc%u inited to 0x%lx\n",
+				 pmc, reset_value[pmc]);
+	}
+}
+
+/* configure registers on this cpu */
+static void pa6t_cpu_setup(struct op_counter_config *ctr)
+{
+	u64 mmcr0 = mmcr0_val;
+	u64 mmcr1 = mmcr1_val;
+
+	/* Default is all PMCs off */
+	mmcr0 &= ~(0x3FUL);
+	mtspr(SPRN_PA6T_MMCR0, mmcr0);
+
+	/* program selected programmable events in */
+	mtspr(SPRN_PA6T_MMCR1, mmcr1);
+
+	pr_debug("setup on cpu %d, mmcr0 %016lx\n", smp_processor_id(),
+		mfspr(SPRN_PA6T_MMCR0));
+	pr_debug("setup on cpu %d, mmcr1 %016lx\n", smp_processor_id(),
+		mfspr(SPRN_PA6T_MMCR1));
+}
+
+static void pa6t_start(struct op_counter_config *ctr)
+{
+	int i;
+
+	/* Hold off event counting until rfid */
+	u64 mmcr0 = mmcr0_val | PA6T_MMCR0_HANDDIS;
+
+	for (i = 0; i < cur_cpu_spec->num_pmcs; i++)
+		if (ctr[i].enabled)
+			ctr_write(i, reset_value[i]);
+		else
+			ctr_write(i, 0UL);
+
+	mtspr(SPRN_PA6T_MMCR0, mmcr0);
+
+	oprofile_running = 1;
+
+	pr_debug("start on cpu %d, mmcr0 %lx\n", smp_processor_id(), mmcr0);
+}
+
+static void pa6t_stop(void)
+{
+	u64 mmcr0;
+
+	/* freeze counters */
+	mmcr0 = mfspr(SPRN_PA6T_MMCR0);
+	mmcr0 |= PA6T_MMCR0_FCM0;
+	mtspr(SPRN_PA6T_MMCR0, mmcr0);
+
+	oprofile_running = 0;
+
+	pr_debug("stop on cpu %d, mmcr0 %lx\n", smp_processor_id(), mmcr0);
+}
+
+/* handle the perfmon overflow vector */
+static void pa6t_handle_interrupt(struct pt_regs *regs,
+				  struct op_counter_config *ctr)
+{
+	unsigned long pc = mfspr(SPRN_PA6T_SIAR);
+	int is_kernel = is_kernel_addr(pc);
+	u64 val;
+	int i;
+	u64 mmcr0;
+
+	/* disable perfmon counting until rfid */
+	mmcr0 = mfspr(SPRN_PA6T_MMCR0);
+	mtspr(SPRN_PA6T_MMCR0, mmcr0 | PA6T_MMCR0_HANDDIS);
+
+	/* Record samples. We've got one global bit for whether a sample
+	 * was taken, so add it for any counter that triggered overflow.
+	 */
+	for (i = 0; i < cur_cpu_spec->num_pmcs; i++) {
+		val = ctr_read(i);
+		if (val & (0x1UL << 39)) { /* Overflow bit set */
+			if (oprofile_running && ctr[i].enabled) {
+				if (mmcr0 & PA6T_MMCR0_SIARLOG)
+					oprofile_add_ext_sample(pc, regs, i, is_kernel);
+				ctr_write(i, reset_value[i]);
+			} else {
+				ctr_write(i, 0UL);
+			}
+		}
+	}
+
+	/* Restore mmcr0 to a good known value since the PMI changes it */
+	mmcr0 = mmcr0_val | PA6T_MMCR0_HANDDIS;
+	mtspr(SPRN_PA6T_MMCR0, mmcr0);
+}
+
+struct op_powerpc_model op_model_pa6t = {
+	.reg_setup		= pa6t_reg_setup,
+	.cpu_setup		= pa6t_cpu_setup,
+	.start			= pa6t_start,
+	.stop			= pa6t_stop,
+	.handle_interrupt	= pa6t_handle_interrupt,
+};
Index: linux-2.6/arch/powerpc/platforms/pasemi/setup.c
===================================================================
--- linux-2.6.orig/arch/powerpc/platforms/pasemi/setup.c
+++ linux-2.6/arch/powerpc/platforms/pasemi/setup.c
@@ -28,6 +28,7 @@
 #include <linux/console.h>
 #include <linux/pci.h>
 
+#include <asm/pmc.h>
 #include <asm/prom.h>
 #include <asm/system.h>
 #include <asm/iommu.h>
Index: linux-2.6/include/asm-powerpc/cputable.h
===================================================================
--- linux-2.6.orig/include/asm-powerpc/cputable.h
+++ linux-2.6/include/asm-powerpc/cputable.h
@@ -48,6 +48,7 @@ enum powerpc_oprofile_type {
 	PPC_OPROFILE_G4 = 3,
 	PPC_OPROFILE_BOOKE = 4,
 	PPC_OPROFILE_CELL = 5,
+	PPC_OPROFILE_PA6T = 6,
 };
 
 enum powerpc_pmc_type {
Index: linux-2.6/include/asm-powerpc/reg.h
===================================================================
--- linux-2.6.orig/include/asm-powerpc/reg.h
+++ linux-2.6/include/asm-powerpc/reg.h
@@ -469,12 +469,77 @@
 #define SPRN_SIAR	780
 #define SPRN_SDAR	781
 
-#define PA6T_SPRN_PMC0	787
-#define PA6T_SPRN_PMC1	788
-#define PA6T_SPRN_PMC2	789
-#define PA6T_SPRN_PMC3	790
-#define PA6T_SPRN_PMC4	791
-#define PA6T_SPRN_PMC5	792
+#define SPRN_PA6T_PMC0	787
+#define SPRN_PA6T_PMC1	788
+#define SPRN_PA6T_PMC2	789
+#define SPRN_PA6T_PMC3	790
+#define SPRN_PA6T_PMC4	791
+#define SPRN_PA6T_PMC5	792
+
+#define PA6T_BITPOS(x) (0x1UL << (63 - x))
+
+#define SPRN_PA6T_MMCR0 795
+#define   PA6T_MMCR0_EN0	0x0000000000000001UL
+#define   PA6T_MMCR0_EN1	0x0000000000000002UL
+#define   PA6T_MMCR0_EN2	0x0000000000000004UL
+#define   PA6T_MMCR0_EN3	0x0000000000000008UL
+#define   PA6T_MMCR0_EN4	0x0000000000000010UL
+#define   PA6T_MMCR0_EN5	0x0000000000000020UL
+#define   PA6T_MMCR0_SUPEN	0x0000000000000040UL
+#define   PA6T_MMCR0_PREN	0x0000000000000080UL
+#define   PA6T_MMCR0_HYPEN	0x0000000000000100UL
+#define   PA6T_MMCR0_FCM0	0x0000000000000200UL
+#define   PA6T_MMCR0_FCM1	0x0000000000000400UL
+#define   PA6T_MMCR0_INTGEN	0x0000000000000800UL
+#define   PA6T_MMCR0_INTEN0	0x0000000000001000UL
+#define   PA6T_MMCR0_INTEN1	0x0000000000002000UL
+#define   PA6T_MMCR0_INTEN2	0x0000000000004000UL
+#define   PA6T_MMCR0_INTEN3	0x0000000000008000UL
+#define   PA6T_MMCR0_INTEN4	0x0000000000010000UL
+#define   PA6T_MMCR0_INTEN5	0x0000000000020000UL
+#define   PA6T_MMCR0_DISCNT	0x0000000000040000UL
+#define   PA6T_MMCR0_UOP	0x0000000000080000UL
+#define   PA6T_MMCR0_TRG	0x0000000000100000UL
+#define   PA6T_MMCR0_TRGEN	0x0000000000200000UL
+#define   PA6T_MMCR0_TRGREG	0x0000000001600000UL
+#define   PA6T_MMCR0_SIARLOG	0x0000000002000000UL
+#define   PA6T_MMCR0_SDARLOG	0x0000000004000000UL
+#define   PA6T_MMCR0_PROEN	0x0000000008000000UL
+#define   PA6T_MMCR0_PROLOG	0x0000000010000000UL
+#define   PA6T_MMCR0_DAMEN2	0x0000000020000000UL
+#define   PA6T_MMCR0_DAMEN3	0x0000000040000000UL
+#define   PA6T_MMCR0_DAMEN4	0x0000000080000000UL
+#define   PA6T_MMCR0_DAMEN5	0x0000000100000000UL
+#define   PA6T_MMCR0_DAMSEL2	0x0000000200000000UL
+#define   PA6T_MMCR0_DAMSEL3	0x0000000400000000UL
+#define   PA6T_MMCR0_DAMSEL4	0x0000000800000000UL
+#define   PA6T_MMCR0_DAMSEL5	0x0000001000000000UL
+#define   PA6T_MMCR0_HANDDIS	0x0000002000000000UL
+#define   PA6T_MMCR0_PCTEN	0x0000004000000000UL
+#define   PA6T_MMCR0_SOCEN	0x0000008000000000UL
+#define   PA6T_MMCR0_SOCMOD	0x0000010000000000UL
+
+#define SPRN_PA6T_MMCR1 798
+#define   PA6T_MMCR1_ES2	0x00000000000000ffUL
+#define   PA6T_MMCR1_ES3	0x000000000000ff00UL
+#define   PA6T_MMCR1_ES4	0x0000000000ff0000UL
+#define   PA6T_MMCR1_ES5	0x00000000ff000000UL
+
+#define SPRN_PA6T_SIAR  780
+#define SPRN_PA6T_UPMC0 771
+#define SPRN_PA6T_UPMC1 772
+#define SPRN_PA6T_UPMC2 773
+#define SPRN_PA6T_UPMC3 774
+#define SPRN_PA6T_UPMC4 775
+#define SPRN_PA6T_UPMC5 776
+#define SPRN_PA6T_UMMCR0 779
+#define SPRN_PA6T_UMMCR1 782
+#define SPRN_PA6T_PMC0  787
+#define SPRN_PA6T_PMC1  788
+#define SPRN_PA6T_PMC2  789
+#define SPRN_PA6T_PMC3  790
+#define SPRN_PA6T_PMC4  791
+#define SPRN_PA6T_PMC5  792
 
 #else /* 32-bit */
 #define SPRN_MMCR0	952	/* Monitor Mode Control Register 0 */
Index: linux-2.6/include/asm-powerpc/pmc.h
===================================================================
--- linux-2.6.orig/include/asm-powerpc/pmc.h
+++ linux-2.6/include/asm-powerpc/pmc.h
@@ -30,6 +30,7 @@ void release_pmc_hardware(void);
 
 #ifdef CONFIG_PPC64
 void power4_enable_pmcs(void);
+void pasemi_enable_pmcs(void);
 #endif
 
 #endif /* __KERNEL__ */
Index: linux-2.6/arch/powerpc/oprofile/common.c
===================================================================
--- linux-2.6.orig/arch/powerpc/oprofile/common.c
+++ linux-2.6/arch/powerpc/oprofile/common.c
@@ -160,6 +160,9 @@ int __init oprofile_arch_init(struct opr
 		case PPC_OPROFILE_POWER4:
 			model = &op_model_power4;
 			break;
+		case PPC_OPROFILE_PA6T:
+			model = &op_model_pa6t;
+			break;
 #endif
 #ifdef CONFIG_6xx
 		case PPC_OPROFILE_G4:
Index: linux-2.6/arch/powerpc/oprofile/Makefile
===================================================================
--- linux-2.6.orig/arch/powerpc/oprofile/Makefile
+++ linux-2.6/arch/powerpc/oprofile/Makefile
@@ -12,6 +12,6 @@ DRIVER_OBJS := $(addprefix ../../../driv
 
 oprofile-y := $(DRIVER_OBJS) common.o backtrace.o
 oprofile-$(CONFIG_PPC_CELL_NATIVE) += op_model_cell.o
-oprofile-$(CONFIG_PPC64) += op_model_rs64.o op_model_power4.o
+oprofile-$(CONFIG_PPC64) += op_model_rs64.o op_model_power4.o op_model_pa6t.o
 oprofile-$(CONFIG_FSL_BOOKE) += op_model_fsl_booke.o
 oprofile-$(CONFIG_6xx) += op_model_7450.o
Index: linux-2.6/include/asm-powerpc/oprofile_impl.h
===================================================================
--- linux-2.6.orig/include/asm-powerpc/oprofile_impl.h
+++ linux-2.6/include/asm-powerpc/oprofile_impl.h
@@ -57,6 +57,8 @@ extern struct op_powerpc_model op_model_
 extern struct op_powerpc_model op_model_power4;
 extern struct op_powerpc_model op_model_7450;
 extern struct op_powerpc_model op_model_cell;
+extern struct op_powerpc_model op_model_pa6t;
+
 
 /* All the classic PPC parts use these */
 static inline unsigned int classic_ctr_read(unsigned int i)

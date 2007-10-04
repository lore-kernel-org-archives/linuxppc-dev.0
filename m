Return-Path: <benh@ozlabs.org>
To: <bluesmoke-devel@lists.sourceforge.net>,
	<linuxppc-dev@ozlabs.org>
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Thu, 04 Oct 2007 15:40:42 +1000
Subject: [PATCH 1/4] powerpc: Move cbe_regs.h to
	include/asm-powerpc/cell-regs.h
In-Reply-To: <1191476442.154524.519055590678.qpush@grosgo>
Message-Id: <20071004054104.1AD8EDDE03@ozlabs.org>
Cc: Paul Mackerras <paulus@samba.org>, cbe-oss-dev@ozlabs.org,
	Arnd Bergmann <arnd.bergmann@de.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

The new Cell EDAC driver needs that file, oprofile also does ugly
path tricks to get to it, it's time to move it to asm-powerpc. While
at it, rename it to be consistent with cell-pmu.h (and dashes look
nicer than underscores anyway).

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---

 arch/powerpc/oprofile/cell/pr_util.h                |    3 
 arch/powerpc/oprofile/op_model_cell.c               |    2 
 arch/powerpc/platforms/cell/cbe_cpufreq.c           |    2 
 arch/powerpc/platforms/cell/cbe_cpufreq_pervasive.c |    2 
 arch/powerpc/platforms/cell/cbe_cpufreq_pmi.c       |    2 
 arch/powerpc/platforms/cell/cbe_regs.c              |    3 
 arch/powerpc/platforms/cell/cbe_regs.h              |  271 --------------------
 arch/powerpc/platforms/cell/cbe_thermal.c           |    2 
 arch/powerpc/platforms/cell/interrupt.c             |    2 
 arch/powerpc/platforms/cell/iommu.c                 |    2 
 arch/powerpc/platforms/cell/pervasive.c             |    2 
 arch/powerpc/platforms/cell/pmu.c                   |    2 
 arch/powerpc/platforms/cell/ras.c                   |    2 
 arch/powerpc/platforms/cell/setup.c                 |    2 
 include/asm-powerpc/cell-regs.h                     |  271 ++++++++++++++++++++
 15 files changed, 284 insertions(+), 286 deletions(-)

Index: linux-work/arch/powerpc/platforms/cell/cbe_regs.h
===================================================================
--- linux-work.orig/arch/powerpc/platforms/cell/cbe_regs.h	2007-10-04 15:15:21.000000000 +1000
+++ /dev/null	1970-01-01 00:00:00.000000000 +0000
@@ -1,271 +0,0 @@
-/*
- * cbe_regs.h
- *
- * This file is intended to hold the various register definitions for CBE
- * on-chip system devices (memory controller, IO controller, etc...)
- *
- * (C) Copyright IBM Corporation 2001,2006
- *
- * Authors: Maximino Aguilar (maguilar@us.ibm.com)
- *          David J. Erb (djerb@us.ibm.com)
- *
- * (c) 2006 Benjamin Herrenschmidt <benh@kernel.crashing.org>, IBM Corp.
- */
-
-#ifndef CBE_REGS_H
-#define CBE_REGS_H
-
-#include <asm/cell-pmu.h>
-
-/*
- *
- * Some HID register definitions
- *
- */
-
-/* CBE specific HID0 bits */
-#define HID0_CBE_THERM_WAKEUP	0x0000020000000000ul
-#define HID0_CBE_SYSERR_WAKEUP	0x0000008000000000ul
-#define HID0_CBE_THERM_INT_EN	0x0000000400000000ul
-#define HID0_CBE_SYSERR_INT_EN	0x0000000200000000ul
-
-#define MAX_CBE		2
-
-/*
- *
- * Pervasive unit register definitions
- *
- */
-
-union spe_reg {
-	u64 val;
-	u8 spe[8];
-};
-
-union ppe_spe_reg {
-	u64 val;
-	struct {
-		u32 ppe;
-		u32 spe;
-	};
-};
-
-
-struct cbe_pmd_regs {
-	/* Debug Bus Control */
-	u64	pad_0x0000;					/* 0x0000 */
-
-	u64	group_control;					/* 0x0008 */
-
-	u8	pad_0x0010_0x00a8 [0x00a8 - 0x0010];		/* 0x0010 */
-
-	u64	debug_bus_control;				/* 0x00a8 */
-
-	u8	pad_0x00b0_0x0100 [0x0100 - 0x00b0];		/* 0x00b0 */
-
-	u64	trace_aux_data;					/* 0x0100 */
-	u64	trace_buffer_0_63;				/* 0x0108 */
-	u64	trace_buffer_64_127;				/* 0x0110 */
-	u64	trace_address;					/* 0x0118 */
-	u64	ext_tr_timer;					/* 0x0120 */
-
-	u8	pad_0x0128_0x0400 [0x0400 - 0x0128];		/* 0x0128 */
-
-	/* Performance Monitor */
-	u64	pm_status;					/* 0x0400 */
-	u64	pm_control;					/* 0x0408 */
-	u64	pm_interval;					/* 0x0410 */
-	u64	pm_ctr[4];					/* 0x0418 */
-	u64	pm_start_stop;					/* 0x0438 */
-	u64	pm07_control[8];				/* 0x0440 */
-
-	u8	pad_0x0480_0x0800 [0x0800 - 0x0480];		/* 0x0480 */
-
-	/* Thermal Sensor Registers */
-	union	spe_reg	ts_ctsr1;				/* 0x0800 */
-	u64	ts_ctsr2;					/* 0x0808 */
-	union	spe_reg	ts_mtsr1;				/* 0x0810 */
-	u64	ts_mtsr2;					/* 0x0818 */
-	union	spe_reg	ts_itr1;				/* 0x0820 */
-	u64	ts_itr2;					/* 0x0828 */
-	u64	ts_gitr;					/* 0x0830 */
-	u64	ts_isr;						/* 0x0838 */
-	u64	ts_imr;						/* 0x0840 */
-	union	spe_reg	tm_cr1;					/* 0x0848 */
-	u64	tm_cr2;						/* 0x0850 */
-	u64	tm_simr;					/* 0x0858 */
-	union	ppe_spe_reg tm_tpr;				/* 0x0860 */
-	union	spe_reg	tm_str1;				/* 0x0868 */
-	u64	tm_str2;					/* 0x0870 */
-	union	ppe_spe_reg tm_tsr;				/* 0x0878 */
-
-	/* Power Management */
-	u64	pmcr;						/* 0x0880 */
-#define CBE_PMD_PAUSE_ZERO_CONTROL	0x10000
-	u64	pmsr;						/* 0x0888 */
-
-	/* Time Base Register */
-	u64	tbr;						/* 0x0890 */
-
-	u8	pad_0x0898_0x0c00 [0x0c00 - 0x0898];		/* 0x0898 */
-
-	/* Fault Isolation Registers */
-	u64	checkstop_fir;					/* 0x0c00 */
-	u64	recoverable_fir;				/* 0x0c08 */
-	u64	spec_att_mchk_fir;				/* 0x0c10 */
-	u32	fir_mode_reg;					/* 0x0c18 */
-	u8	pad_0x0c1c_0x0c20 [4];				/* 0x0c1c */
-#define CBE_PMD_FIR_MODE_M8		0x00800
-	u64	fir_enable_mask;				/* 0x0c20 */
-
-	u8	pad_0x0c28_0x0ca8 [0x0ca8 - 0x0c28];		/* 0x0c28 */
-	u64	ras_esc_0;					/* 0x0ca8 */
-	u8	pad_0x0cb0_0x1000 [0x1000 - 0x0cb0];		/* 0x0cb0 */
-};
-
-extern struct cbe_pmd_regs __iomem *cbe_get_pmd_regs(struct device_node *np);
-extern struct cbe_pmd_regs __iomem *cbe_get_cpu_pmd_regs(int cpu);
-
-/*
- * PMU shadow registers
- *
- * Many of the registers in the performance monitoring unit are write-only,
- * so we need to save a copy of what we write to those registers.
- *
- * The actual data counters are read/write. However, writing to the counters
- * only takes effect if the PMU is enabled. Otherwise the value is stored in
- * a hardware latch until the next time the PMU is enabled. So we save a copy
- * of the counter values if we need to read them back while the PMU is
- * disabled. The counter_value_in_latch field is a bitmap indicating which
- * counters currently have a value waiting to be written.
- */
-
-struct cbe_pmd_shadow_regs {
-	u32 group_control;
-	u32 debug_bus_control;
-	u32 trace_address;
-	u32 ext_tr_timer;
-	u32 pm_status;
-	u32 pm_control;
-	u32 pm_interval;
-	u32 pm_start_stop;
-	u32 pm07_control[NR_CTRS];
-
-	u32 pm_ctr[NR_PHYS_CTRS];
-	u32 counter_value_in_latch;
-};
-
-extern struct cbe_pmd_shadow_regs *cbe_get_pmd_shadow_regs(struct device_node *np);
-extern struct cbe_pmd_shadow_regs *cbe_get_cpu_pmd_shadow_regs(int cpu);
-
-/*
- *
- * IIC unit register definitions
- *
- */
-
-struct cbe_iic_pending_bits {
-	u32 data;
-	u8 flags;
-	u8 class;
-	u8 source;
-	u8 prio;
-};
-
-#define CBE_IIC_IRQ_VALID	0x80
-#define CBE_IIC_IRQ_IPI		0x40
-
-struct cbe_iic_thread_regs {
-	struct cbe_iic_pending_bits pending;
-	struct cbe_iic_pending_bits pending_destr;
-	u64 generate;
-	u64 prio;
-};
-
-struct cbe_iic_regs {
-	u8	pad_0x0000_0x0400[0x0400 - 0x0000];		/* 0x0000 */
-
-	/* IIC interrupt registers */
-	struct	cbe_iic_thread_regs thread[2];			/* 0x0400 */
-
-	u64	iic_ir;						/* 0x0440 */
-#define CBE_IIC_IR_PRIO(x)      (((x) & 0xf) << 12)
-#define CBE_IIC_IR_DEST_NODE(x) (((x) & 0xf) << 4)
-#define CBE_IIC_IR_DEST_UNIT(x) ((x) & 0xf)
-#define CBE_IIC_IR_IOC_0        0x0
-#define CBE_IIC_IR_IOC_1S       0xb
-#define CBE_IIC_IR_PT_0         0xe
-#define CBE_IIC_IR_PT_1         0xf
-
-	u64	iic_is;						/* 0x0448 */
-#define CBE_IIC_IS_PMI		0x2
-
-	u8	pad_0x0450_0x0500[0x0500 - 0x0450];		/* 0x0450 */
-
-	/* IOC FIR */
-	u64	ioc_fir_reset;					/* 0x0500 */
-	u64	ioc_fir_set;					/* 0x0508 */
-	u64	ioc_checkstop_enable;				/* 0x0510 */
-	u64	ioc_fir_error_mask;				/* 0x0518 */
-	u64	ioc_syserr_enable;				/* 0x0520 */
-	u64	ioc_fir;					/* 0x0528 */
-
-	u8	pad_0x0530_0x1000[0x1000 - 0x0530];		/* 0x0530 */
-};
-
-extern struct cbe_iic_regs __iomem *cbe_get_iic_regs(struct device_node *np);
-extern struct cbe_iic_regs __iomem *cbe_get_cpu_iic_regs(int cpu);
-
-
-struct cbe_mic_tm_regs {
-	u8	pad_0x0000_0x0040[0x0040 - 0x0000];		/* 0x0000 */
-
-	u64	mic_ctl_cnfg2;					/* 0x0040 */
-#define CBE_MIC_ENABLE_AUX_TRC		0x8000000000000000LL
-#define CBE_MIC_DISABLE_PWR_SAV_2	0x0200000000000000LL
-#define CBE_MIC_DISABLE_AUX_TRC_WRAP	0x0100000000000000LL
-#define CBE_MIC_ENABLE_AUX_TRC_INT	0x0080000000000000LL
-
-	u64	pad_0x0048;					/* 0x0048 */
-
-	u64	mic_aux_trc_base;				/* 0x0050 */
-	u64	mic_aux_trc_max_addr;				/* 0x0058 */
-	u64	mic_aux_trc_cur_addr;				/* 0x0060 */
-	u64	mic_aux_trc_grf_addr;				/* 0x0068 */
-	u64	mic_aux_trc_grf_data;				/* 0x0070 */
-
-	u64	pad_0x0078;					/* 0x0078 */
-
-	u64	mic_ctl_cnfg_0;					/* 0x0080 */
-#define CBE_MIC_DISABLE_PWR_SAV_0	0x8000000000000000LL
-
-	u64	pad_0x0088;					/* 0x0088 */
-
-	u64	slow_fast_timer_0;				/* 0x0090 */
-	u64	slow_next_timer_0;				/* 0x0098 */
-
-	u8	pad_0x00a0_0x01c0[0x01c0 - 0x0a0];		/* 0x00a0 */
-
-	u64	mic_ctl_cnfg_1;					/* 0x01c0 */
-#define CBE_MIC_DISABLE_PWR_SAV_1	0x8000000000000000LL
-	u64	pad_0x01c8;					/* 0x01c8 */
-
-	u64	slow_fast_timer_1;				/* 0x01d0 */
-	u64	slow_next_timer_1;				/* 0x01d8 */
-
-	u8	pad_0x01e0_0x1000[0x1000 - 0x01e0];		/* 0x01e0 */
-};
-
-extern struct cbe_mic_tm_regs __iomem *cbe_get_mic_tm_regs(struct device_node *np);
-extern struct cbe_mic_tm_regs __iomem *cbe_get_cpu_mic_tm_regs(int cpu);
-
-/* some utility functions to deal with SMT */
-extern u32 cbe_get_hw_thread_id(int cpu);
-extern u32 cbe_cpu_to_node(int cpu);
-extern u32 cbe_node_to_cpu(int node);
-
-/* Init this module early */
-extern void cbe_regs_init(void);
-
-
-#endif /* CBE_REGS_H */
Index: linux-work/arch/powerpc/oprofile/cell/pr_util.h
===================================================================
--- linux-work.orig/arch/powerpc/oprofile/cell/pr_util.h	2007-10-04 15:15:22.000000000 +1000
+++ linux-work/arch/powerpc/oprofile/cell/pr_util.h	2007-10-04 15:15:23.000000000 +1000
@@ -17,10 +17,9 @@
 #include <linux/cpumask.h>
 #include <linux/oprofile.h>
 #include <asm/cell-pmu.h>
+#include <asm/cell-regs.h>
 #include <asm/spu.h>
 
-#include "../../platforms/cell/cbe_regs.h"
-
 /* Defines used for sync_start */
 #define SKIP_GENERIC_SYNC 0
 #define SYNC_START_ERROR -1
Index: linux-work/arch/powerpc/oprofile/op_model_cell.c
===================================================================
--- linux-work.orig/arch/powerpc/oprofile/op_model_cell.c	2007-10-04 15:15:22.000000000 +1000
+++ linux-work/arch/powerpc/oprofile/op_model_cell.c	2007-10-04 15:15:23.000000000 +1000
@@ -35,9 +35,9 @@
 #include <asm/reg.h>
 #include <asm/rtas.h>
 #include <asm/system.h>
+#include <asm/cell-regs.h>
 
 #include "../platforms/cell/interrupt.h"
-#include "../platforms/cell/cbe_regs.h"
 #include "cell/pr_util.h"
 
 static void cell_global_stop_spu(void);
Index: linux-work/arch/powerpc/platforms/cell/cbe_cpufreq.c
===================================================================
--- linux-work.orig/arch/powerpc/platforms/cell/cbe_cpufreq.c	2007-10-04 15:15:21.000000000 +1000
+++ linux-work/arch/powerpc/platforms/cell/cbe_cpufreq.c	2007-10-04 15:15:23.000000000 +1000
@@ -24,7 +24,7 @@
 #include <asm/machdep.h>
 #include <asm/of_platform.h>
 #include <asm/prom.h>
-#include "cbe_regs.h"
+#include <asm/cell-regs.h>
 #include "cbe_cpufreq.h"
 
 static DEFINE_MUTEX(cbe_switch_mutex);
Index: linux-work/arch/powerpc/platforms/cell/cbe_cpufreq_pervasive.c
===================================================================
--- linux-work.orig/arch/powerpc/platforms/cell/cbe_cpufreq_pervasive.c	2007-10-04 15:15:21.000000000 +1000
+++ linux-work/arch/powerpc/platforms/cell/cbe_cpufreq_pervasive.c	2007-10-04 15:15:23.000000000 +1000
@@ -28,8 +28,8 @@
 #include <linux/time.h>
 #include <asm/machdep.h>
 #include <asm/hw_irq.h>
+#include <asm/cell-regs.h>
 
-#include "cbe_regs.h"
 #include "cbe_cpufreq.h"
 
 /* to write to MIC register */
Index: linux-work/arch/powerpc/platforms/cell/cbe_cpufreq_pmi.c
===================================================================
--- linux-work.orig/arch/powerpc/platforms/cell/cbe_cpufreq_pmi.c	2007-10-04 15:15:22.000000000 +1000
+++ linux-work/arch/powerpc/platforms/cell/cbe_cpufreq_pmi.c	2007-10-04 15:15:23.000000000 +1000
@@ -27,12 +27,12 @@
 #include <asm/processor.h>
 #include <asm/prom.h>
 #include <asm/pmi.h>
+#include <asm/cell-regs.h>
 
 #ifdef DEBUG
 #include <asm/time.h>
 #endif
 
-#include "cbe_regs.h"
 #include "cbe_cpufreq.h"
 
 static u8 pmi_slow_mode_limit[MAX_CBE];
Index: linux-work/arch/powerpc/platforms/cell/cbe_regs.c
===================================================================
--- linux-work.orig/arch/powerpc/platforms/cell/cbe_regs.c	2007-10-04 15:15:21.000000000 +1000
+++ linux-work/arch/powerpc/platforms/cell/cbe_regs.c	2007-10-04 15:15:23.000000000 +1000
@@ -16,8 +16,7 @@
 #include <asm/ptrace.h>
 #include <asm/of_device.h>
 #include <asm/of_platform.h>
-
-#include "cbe_regs.h"
+#include <asm/cell-regs.h>
 
 /*
  * Current implementation uses "cpu" nodes. We build our own mapping
Index: linux-work/arch/powerpc/platforms/cell/cbe_thermal.c
===================================================================
--- linux-work.orig/arch/powerpc/platforms/cell/cbe_thermal.c	2007-10-04 15:15:21.000000000 +1000
+++ linux-work/arch/powerpc/platforms/cell/cbe_thermal.c	2007-10-04 15:15:23.000000000 +1000
@@ -52,8 +52,8 @@
 #include <asm/spu.h>
 #include <asm/io.h>
 #include <asm/prom.h>
+#include <asm/cell-regs.h>
 
-#include "cbe_regs.h"
 #include "spu_priv1_mmio.h"
 
 #define TEMP_MIN 65
Index: linux-work/arch/powerpc/platforms/cell/interrupt.c
===================================================================
--- linux-work.orig/arch/powerpc/platforms/cell/interrupt.c	2007-10-04 15:15:21.000000000 +1000
+++ linux-work/arch/powerpc/platforms/cell/interrupt.c	2007-10-04 15:15:23.000000000 +1000
@@ -41,9 +41,9 @@
 #include <asm/prom.h>
 #include <asm/ptrace.h>
 #include <asm/machdep.h>
+#include <asm/cell-regs.h>
 
 #include "interrupt.h"
-#include "cbe_regs.h"
 
 struct iic {
 	struct cbe_iic_thread_regs __iomem *regs;
Index: linux-work/arch/powerpc/platforms/cell/iommu.c
===================================================================
--- linux-work.orig/arch/powerpc/platforms/cell/iommu.c	2007-10-04 15:15:21.000000000 +1000
+++ linux-work/arch/powerpc/platforms/cell/iommu.c	2007-10-04 15:15:23.000000000 +1000
@@ -34,8 +34,8 @@
 #include <asm/udbg.h>
 #include <asm/of_platform.h>
 #include <asm/lmb.h>
+#include <asm/cell-regs.h>
 
-#include "cbe_regs.h"
 #include "interrupt.h"
 
 /* Define CELL_IOMMU_REAL_UNMAP to actually unmap non-used pages
Index: linux-work/arch/powerpc/platforms/cell/pervasive.c
===================================================================
--- linux-work.orig/arch/powerpc/platforms/cell/pervasive.c	2007-10-04 15:15:21.000000000 +1000
+++ linux-work/arch/powerpc/platforms/cell/pervasive.c	2007-10-04 15:15:23.000000000 +1000
@@ -34,9 +34,9 @@
 #include <asm/prom.h>
 #include <asm/pgtable.h>
 #include <asm/reg.h>
+#include <asm/cell-regs.h>
 
 #include "pervasive.h"
-#include "cbe_regs.h"
 
 static int sysreset_hack;
 
Index: linux-work/arch/powerpc/platforms/cell/pmu.c
===================================================================
--- linux-work.orig/arch/powerpc/platforms/cell/pmu.c	2007-10-04 15:15:21.000000000 +1000
+++ linux-work/arch/powerpc/platforms/cell/pmu.c	2007-10-04 15:15:23.000000000 +1000
@@ -30,8 +30,8 @@
 #include <asm/pmc.h>
 #include <asm/reg.h>
 #include <asm/spu.h>
+#include <asm/cell-regs.h>
 
-#include "cbe_regs.h"
 #include "interrupt.h"
 
 /*
Index: linux-work/arch/powerpc/platforms/cell/ras.c
===================================================================
--- linux-work.orig/arch/powerpc/platforms/cell/ras.c	2007-10-04 15:15:21.000000000 +1000
+++ linux-work/arch/powerpc/platforms/cell/ras.c	2007-10-04 15:15:23.000000000 +1000
@@ -10,9 +10,9 @@
 #include <asm/prom.h>
 #include <asm/machdep.h>
 #include <asm/rtas.h>
+#include <asm/cell-regs.h>
 
 #include "ras.h"
-#include "cbe_regs.h"
 
 
 static void dump_fir(int cpu)
Index: linux-work/arch/powerpc/platforms/cell/setup.c
===================================================================
--- linux-work.orig/arch/powerpc/platforms/cell/setup.c	2007-10-04 15:15:21.000000000 +1000
+++ linux-work/arch/powerpc/platforms/cell/setup.c	2007-10-04 15:15:23.000000000 +1000
@@ -52,9 +52,9 @@
 #include <asm/udbg.h>
 #include <asm/mpic.h>
 #include <asm/of_platform.h>
+#include <asm/cell-regs.h>
 
 #include "interrupt.h"
-#include "cbe_regs.h"
 #include "pervasive.h"
 #include "ras.h"
 
Index: linux-work/include/asm-powerpc/cell-regs.h
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-work/include/asm-powerpc/cell-regs.h	2007-10-04 15:15:23.000000000 +1000
@@ -0,0 +1,271 @@
+/*
+ * cbe_regs.h
+ *
+ * This file is intended to hold the various register definitions for CBE
+ * on-chip system devices (memory controller, IO controller, etc...)
+ *
+ * (C) Copyright IBM Corporation 2001,2006
+ *
+ * Authors: Maximino Aguilar (maguilar@us.ibm.com)
+ *          David J. Erb (djerb@us.ibm.com)
+ *
+ * (c) 2006 Benjamin Herrenschmidt <benh@kernel.crashing.org>, IBM Corp.
+ */
+
+#ifndef CBE_REGS_H
+#define CBE_REGS_H
+
+#include <asm/cell-pmu.h>
+
+/*
+ *
+ * Some HID register definitions
+ *
+ */
+
+/* CBE specific HID0 bits */
+#define HID0_CBE_THERM_WAKEUP	0x0000020000000000ul
+#define HID0_CBE_SYSERR_WAKEUP	0x0000008000000000ul
+#define HID0_CBE_THERM_INT_EN	0x0000000400000000ul
+#define HID0_CBE_SYSERR_INT_EN	0x0000000200000000ul
+
+#define MAX_CBE		2
+
+/*
+ *
+ * Pervasive unit register definitions
+ *
+ */
+
+union spe_reg {
+	u64 val;
+	u8 spe[8];
+};
+
+union ppe_spe_reg {
+	u64 val;
+	struct {
+		u32 ppe;
+		u32 spe;
+	};
+};
+
+
+struct cbe_pmd_regs {
+	/* Debug Bus Control */
+	u64	pad_0x0000;					/* 0x0000 */
+
+	u64	group_control;					/* 0x0008 */
+
+	u8	pad_0x0010_0x00a8 [0x00a8 - 0x0010];		/* 0x0010 */
+
+	u64	debug_bus_control;				/* 0x00a8 */
+
+	u8	pad_0x00b0_0x0100 [0x0100 - 0x00b0];		/* 0x00b0 */
+
+	u64	trace_aux_data;					/* 0x0100 */
+	u64	trace_buffer_0_63;				/* 0x0108 */
+	u64	trace_buffer_64_127;				/* 0x0110 */
+	u64	trace_address;					/* 0x0118 */
+	u64	ext_tr_timer;					/* 0x0120 */
+
+	u8	pad_0x0128_0x0400 [0x0400 - 0x0128];		/* 0x0128 */
+
+	/* Performance Monitor */
+	u64	pm_status;					/* 0x0400 */
+	u64	pm_control;					/* 0x0408 */
+	u64	pm_interval;					/* 0x0410 */
+	u64	pm_ctr[4];					/* 0x0418 */
+	u64	pm_start_stop;					/* 0x0438 */
+	u64	pm07_control[8];				/* 0x0440 */
+
+	u8	pad_0x0480_0x0800 [0x0800 - 0x0480];		/* 0x0480 */
+
+	/* Thermal Sensor Registers */
+	union	spe_reg	ts_ctsr1;				/* 0x0800 */
+	u64	ts_ctsr2;					/* 0x0808 */
+	union	spe_reg	ts_mtsr1;				/* 0x0810 */
+	u64	ts_mtsr2;					/* 0x0818 */
+	union	spe_reg	ts_itr1;				/* 0x0820 */
+	u64	ts_itr2;					/* 0x0828 */
+	u64	ts_gitr;					/* 0x0830 */
+	u64	ts_isr;						/* 0x0838 */
+	u64	ts_imr;						/* 0x0840 */
+	union	spe_reg	tm_cr1;					/* 0x0848 */
+	u64	tm_cr2;						/* 0x0850 */
+	u64	tm_simr;					/* 0x0858 */
+	union	ppe_spe_reg tm_tpr;				/* 0x0860 */
+	union	spe_reg	tm_str1;				/* 0x0868 */
+	u64	tm_str2;					/* 0x0870 */
+	union	ppe_spe_reg tm_tsr;				/* 0x0878 */
+
+	/* Power Management */
+	u64	pmcr;						/* 0x0880 */
+#define CBE_PMD_PAUSE_ZERO_CONTROL	0x10000
+	u64	pmsr;						/* 0x0888 */
+
+	/* Time Base Register */
+	u64	tbr;						/* 0x0890 */
+
+	u8	pad_0x0898_0x0c00 [0x0c00 - 0x0898];		/* 0x0898 */
+
+	/* Fault Isolation Registers */
+	u64	checkstop_fir;					/* 0x0c00 */
+	u64	recoverable_fir;				/* 0x0c08 */
+	u64	spec_att_mchk_fir;				/* 0x0c10 */
+	u32	fir_mode_reg;					/* 0x0c18 */
+	u8	pad_0x0c1c_0x0c20 [4];				/* 0x0c1c */
+#define CBE_PMD_FIR_MODE_M8		0x00800
+	u64	fir_enable_mask;				/* 0x0c20 */
+
+	u8	pad_0x0c28_0x0ca8 [0x0ca8 - 0x0c28];		/* 0x0c28 */
+	u64	ras_esc_0;					/* 0x0ca8 */
+	u8	pad_0x0cb0_0x1000 [0x1000 - 0x0cb0];		/* 0x0cb0 */
+};
+
+extern struct cbe_pmd_regs __iomem *cbe_get_pmd_regs(struct device_node *np);
+extern struct cbe_pmd_regs __iomem *cbe_get_cpu_pmd_regs(int cpu);
+
+/*
+ * PMU shadow registers
+ *
+ * Many of the registers in the performance monitoring unit are write-only,
+ * so we need to save a copy of what we write to those registers.
+ *
+ * The actual data counters are read/write. However, writing to the counters
+ * only takes effect if the PMU is enabled. Otherwise the value is stored in
+ * a hardware latch until the next time the PMU is enabled. So we save a copy
+ * of the counter values if we need to read them back while the PMU is
+ * disabled. The counter_value_in_latch field is a bitmap indicating which
+ * counters currently have a value waiting to be written.
+ */
+
+struct cbe_pmd_shadow_regs {
+	u32 group_control;
+	u32 debug_bus_control;
+	u32 trace_address;
+	u32 ext_tr_timer;
+	u32 pm_status;
+	u32 pm_control;
+	u32 pm_interval;
+	u32 pm_start_stop;
+	u32 pm07_control[NR_CTRS];
+
+	u32 pm_ctr[NR_PHYS_CTRS];
+	u32 counter_value_in_latch;
+};
+
+extern struct cbe_pmd_shadow_regs *cbe_get_pmd_shadow_regs(struct device_node *np);
+extern struct cbe_pmd_shadow_regs *cbe_get_cpu_pmd_shadow_regs(int cpu);
+
+/*
+ *
+ * IIC unit register definitions
+ *
+ */
+
+struct cbe_iic_pending_bits {
+	u32 data;
+	u8 flags;
+	u8 class;
+	u8 source;
+	u8 prio;
+};
+
+#define CBE_IIC_IRQ_VALID	0x80
+#define CBE_IIC_IRQ_IPI		0x40
+
+struct cbe_iic_thread_regs {
+	struct cbe_iic_pending_bits pending;
+	struct cbe_iic_pending_bits pending_destr;
+	u64 generate;
+	u64 prio;
+};
+
+struct cbe_iic_regs {
+	u8	pad_0x0000_0x0400[0x0400 - 0x0000];		/* 0x0000 */
+
+	/* IIC interrupt registers */
+	struct	cbe_iic_thread_regs thread[2];			/* 0x0400 */
+
+	u64	iic_ir;						/* 0x0440 */
+#define CBE_IIC_IR_PRIO(x)      (((x) & 0xf) << 12)
+#define CBE_IIC_IR_DEST_NODE(x) (((x) & 0xf) << 4)
+#define CBE_IIC_IR_DEST_UNIT(x) ((x) & 0xf)
+#define CBE_IIC_IR_IOC_0        0x0
+#define CBE_IIC_IR_IOC_1S       0xb
+#define CBE_IIC_IR_PT_0         0xe
+#define CBE_IIC_IR_PT_1         0xf
+
+	u64	iic_is;						/* 0x0448 */
+#define CBE_IIC_IS_PMI		0x2
+
+	u8	pad_0x0450_0x0500[0x0500 - 0x0450];		/* 0x0450 */
+
+	/* IOC FIR */
+	u64	ioc_fir_reset;					/* 0x0500 */
+	u64	ioc_fir_set;					/* 0x0508 */
+	u64	ioc_checkstop_enable;				/* 0x0510 */
+	u64	ioc_fir_error_mask;				/* 0x0518 */
+	u64	ioc_syserr_enable;				/* 0x0520 */
+	u64	ioc_fir;					/* 0x0528 */
+
+	u8	pad_0x0530_0x1000[0x1000 - 0x0530];		/* 0x0530 */
+};
+
+extern struct cbe_iic_regs __iomem *cbe_get_iic_regs(struct device_node *np);
+extern struct cbe_iic_regs __iomem *cbe_get_cpu_iic_regs(int cpu);
+
+
+struct cbe_mic_tm_regs {
+	u8	pad_0x0000_0x0040[0x0040 - 0x0000];		/* 0x0000 */
+
+	u64	mic_ctl_cnfg2;					/* 0x0040 */
+#define CBE_MIC_ENABLE_AUX_TRC		0x8000000000000000LL
+#define CBE_MIC_DISABLE_PWR_SAV_2	0x0200000000000000LL
+#define CBE_MIC_DISABLE_AUX_TRC_WRAP	0x0100000000000000LL
+#define CBE_MIC_ENABLE_AUX_TRC_INT	0x0080000000000000LL
+
+	u64	pad_0x0048;					/* 0x0048 */
+
+	u64	mic_aux_trc_base;				/* 0x0050 */
+	u64	mic_aux_trc_max_addr;				/* 0x0058 */
+	u64	mic_aux_trc_cur_addr;				/* 0x0060 */
+	u64	mic_aux_trc_grf_addr;				/* 0x0068 */
+	u64	mic_aux_trc_grf_data;				/* 0x0070 */
+
+	u64	pad_0x0078;					/* 0x0078 */
+
+	u64	mic_ctl_cnfg_0;					/* 0x0080 */
+#define CBE_MIC_DISABLE_PWR_SAV_0	0x8000000000000000LL
+
+	u64	pad_0x0088;					/* 0x0088 */
+
+	u64	slow_fast_timer_0;				/* 0x0090 */
+	u64	slow_next_timer_0;				/* 0x0098 */
+
+	u8	pad_0x00a0_0x01c0[0x01c0 - 0x0a0];		/* 0x00a0 */
+
+	u64	mic_ctl_cnfg_1;					/* 0x01c0 */
+#define CBE_MIC_DISABLE_PWR_SAV_1	0x8000000000000000LL
+	u64	pad_0x01c8;					/* 0x01c8 */
+
+	u64	slow_fast_timer_1;				/* 0x01d0 */
+	u64	slow_next_timer_1;				/* 0x01d8 */
+
+	u8	pad_0x01e0_0x1000[0x1000 - 0x01e0];		/* 0x01e0 */
+};
+
+extern struct cbe_mic_tm_regs __iomem *cbe_get_mic_tm_regs(struct device_node *np);
+extern struct cbe_mic_tm_regs __iomem *cbe_get_cpu_mic_tm_regs(int cpu);
+
+/* some utility functions to deal with SMT */
+extern u32 cbe_get_hw_thread_id(int cpu);
+extern u32 cbe_cpu_to_node(int cpu);
+extern u32 cbe_node_to_cpu(int node);
+
+/* Init this module early */
+extern void cbe_regs_init(void);
+
+
+#endif /* CBE_REGS_H */

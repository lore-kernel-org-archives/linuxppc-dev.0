Return-Path: <afleming@freescale.com>
Date: Fri, 27 Oct 2006 15:06:32 -0500 (CDT)
From: Andy Fleming <afleming@freescale.com>
To: linuxppc-dev@ozlabs.org, linuxppc-embedded <linuxppc-embedded@ozlabs.org>,
	Paul Mackerras <paulus@samba.org>, Kumar Gala <galak@kernel.crashing.org>
Subject: [PATCH] Fix oprofile support for e500 in arch/powerpc
Message-ID: <Pine.LNX.4.61.0610271501270.23433@ld0175-tx32.am.freescale.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Oprofile List <oprofile-list@lists.sourceforge.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Fixed a compile error in building the 85xx support with oprofile, and in
the process cleaned up some issues with the fsl_booke performance monitor
code.

* Reorganized FSL Book-E performance monitoring code so that the 7450
  wouldn't be built if the e500 was, and cleaned it up so it was more
  self-contained.

* Added a cpu_setup function for FSL Book-E.  The original
  cpu_setup function prototype had no arguments, assuming that
  the reg_setup function would copy the required information into
  variables which represented the registers.  This was silly for
  e500, since it has 1 register per counter (rather than 3 for
  all counters), so the code has been restructured to have
  cpu_setup take the current counter config array as an argument,
  with op_powerpc_setup() invoking op_powerpc_cpu_setup() through
  on_each_cpu(), and op_powerpc_cpu_setup() invoking the
  model-specific cpu_setup function with an argument.  The
  argument is ignored on all other platforms at present.

* Fixed a confusing line where a trinary operator only had two
  arguments
Signed-off-by: Andrew Fleming <afleming@freescale.com>
---
This is a very slight respin of this patch: 
http://patchwork.ozlabs.org/linuxppc/patch?id=5531
Thanks to Vitaly Wool for noticing that this bug still existed!

 arch/powerpc/kernel/Makefile               |    1 
 arch/powerpc/kernel/perfmon_fsl_booke.c    |  221 ----------------------------
 arch/powerpc/kernel/pmc.c                  |    2 
 arch/powerpc/oprofile/Makefile             |    2 
 arch/powerpc/oprofile/common.c             |   10 +
 arch/powerpc/oprofile/op_model_7450.c      |    2 
 arch/powerpc/oprofile/op_model_fsl_booke.c |  170 +++++++++++++++++-----
 arch/powerpc/oprofile/op_model_power4.c    |    2 
 arch/powerpc/oprofile/op_model_rs64.c      |    2 
 include/asm-powerpc/oprofile_impl.h        |   87 +++++++++++
 include/asm-powerpc/pmc.h                  |   13 --
 11 files changed, 234 insertions(+), 278 deletions(-)

diff --git a/arch/powerpc/kernel/Makefile b/arch/powerpc/kernel/Makefile
index 8b133af..7af23c4 100644
--- a/arch/powerpc/kernel/Makefile
+++ b/arch/powerpc/kernel/Makefile
@@ -38,7 +38,6 @@ obj-$(CONFIG_6xx)		+= idle_6xx.o l2cr_6x
 obj-$(CONFIG_TAU)		+= tau_6xx.o
 obj32-$(CONFIG_SOFTWARE_SUSPEND) += swsusp_32.o
 obj32-$(CONFIG_MODULES)		+= module_32.o
-obj-$(CONFIG_E500)		+= perfmon_fsl_booke.o
 
 ifeq ($(CONFIG_PPC_MERGE),y)
 
diff --git a/arch/powerpc/kernel/perfmon_fsl_booke.c b/arch/powerpc/kernel/perfmon_fsl_booke.c
deleted file mode 100644
index e0dcf2b..0000000
--- a/arch/powerpc/kernel/perfmon_fsl_booke.c
+++ /dev/null
@@ -1,221 +0,0 @@
-/* arch/powerpc/kernel/perfmon_fsl_booke.c
- * Freescale Book-E Performance Monitor code
- *
- * Author: Andy Fleming
- * Copyright (c) 2004 Freescale Semiconductor, Inc
- *
- *  This program is free software; you can redistribute it and/or
- *  modify it under the terms of the GNU General Public License
- *  as published by the Free Software Foundation; either version
- *  2 of the License, or (at your option) any later version.
- */
-
-#include <linux/errno.h>
-#include <linux/sched.h>
-#include <linux/kernel.h>
-#include <linux/mm.h>
-#include <linux/stddef.h>
-#include <linux/unistd.h>
-#include <linux/ptrace.h>
-#include <linux/slab.h>
-#include <linux/user.h>
-#include <linux/a.out.h>
-#include <linux/interrupt.h>
-#include <linux/init.h>
-#include <linux/module.h>
-#include <linux/prctl.h>
-
-#include <asm/pgtable.h>
-#include <asm/uaccess.h>
-#include <asm/system.h>
-#include <asm/io.h>
-#include <asm/reg.h>
-#include <asm/xmon.h>
-#include <asm/pmc.h>
-
-static inline u32 get_pmlca(int ctr);
-static inline void set_pmlca(int ctr, u32 pmlca);
-
-static inline u32 get_pmlca(int ctr)
-{
-	u32 pmlca;
-
-	switch (ctr) {
-		case 0:
-			pmlca = mfpmr(PMRN_PMLCA0);
-			break;
-		case 1:
-			pmlca = mfpmr(PMRN_PMLCA1);
-			break;
-		case 2:
-			pmlca = mfpmr(PMRN_PMLCA2);
-			break;
-		case 3:
-			pmlca = mfpmr(PMRN_PMLCA3);
-			break;
-		default:
-			panic("Bad ctr number\n");
-	}
-
-	return pmlca;
-}
-
-static inline void set_pmlca(int ctr, u32 pmlca)
-{
-	switch (ctr) {
-		case 0:
-			mtpmr(PMRN_PMLCA0, pmlca);
-			break;
-		case 1:
-			mtpmr(PMRN_PMLCA1, pmlca);
-			break;
-		case 2:
-			mtpmr(PMRN_PMLCA2, pmlca);
-			break;
-		case 3:
-			mtpmr(PMRN_PMLCA3, pmlca);
-			break;
-		default:
-			panic("Bad ctr number\n");
-	}
-}
-
-void init_pmc_stop(int ctr)
-{
-	u32 pmlca = (PMLCA_FC | PMLCA_FCS | PMLCA_FCU |
-			PMLCA_FCM1 | PMLCA_FCM0);
-	u32 pmlcb = 0;
-
-	switch (ctr) {
-		case 0:
-			mtpmr(PMRN_PMLCA0, pmlca);
-			mtpmr(PMRN_PMLCB0, pmlcb);
-			break;
-		case 1:
-			mtpmr(PMRN_PMLCA1, pmlca);
-			mtpmr(PMRN_PMLCB1, pmlcb);
-			break;
-		case 2:
-			mtpmr(PMRN_PMLCA2, pmlca);
-			mtpmr(PMRN_PMLCB2, pmlcb);
-			break;
-		case 3:
-			mtpmr(PMRN_PMLCA3, pmlca);
-			mtpmr(PMRN_PMLCB3, pmlcb);
-			break;
-		default:
-			panic("Bad ctr number!\n");
-	}
-}
-
-void set_pmc_event(int ctr, int event)
-{
-	u32 pmlca;
-
-	pmlca = get_pmlca(ctr);
-
-	pmlca = (pmlca & ~PMLCA_EVENT_MASK) |
-		((event << PMLCA_EVENT_SHIFT) &
-		 PMLCA_EVENT_MASK);
-
-	set_pmlca(ctr, pmlca);
-}
-
-void set_pmc_user_kernel(int ctr, int user, int kernel)
-{
-	u32 pmlca;
-
-	pmlca = get_pmlca(ctr);
-
-	if(user)
-		pmlca &= ~PMLCA_FCU;
-	else
-		pmlca |= PMLCA_FCU;
-
-	if(kernel)
-		pmlca &= ~PMLCA_FCS;
-	else
-		pmlca |= PMLCA_FCS;
-
-	set_pmlca(ctr, pmlca);
-}
-
-void set_pmc_marked(int ctr, int mark0, int mark1)
-{
-	u32 pmlca = get_pmlca(ctr);
-
-	if(mark0)
-		pmlca &= ~PMLCA_FCM0;
-	else
-		pmlca |= PMLCA_FCM0;
-
-	if(mark1)
-		pmlca &= ~PMLCA_FCM1;
-	else
-		pmlca |= PMLCA_FCM1;
-
-	set_pmlca(ctr, pmlca);
-}
-
-void pmc_start_ctr(int ctr, int enable)
-{
-	u32 pmlca = get_pmlca(ctr);
-
-	pmlca &= ~PMLCA_FC;
-
-	if (enable)
-		pmlca |= PMLCA_CE;
-	else
-		pmlca &= ~PMLCA_CE;
-
-	set_pmlca(ctr, pmlca);
-}
-
-void pmc_start_ctrs(int enable)
-{
-	u32 pmgc0 = mfpmr(PMRN_PMGC0);
-
-	pmgc0 &= ~PMGC0_FAC;
-	pmgc0 |= PMGC0_FCECE;
-
-	if (enable)
-		pmgc0 |= PMGC0_PMIE;
-	else
-		pmgc0 &= ~PMGC0_PMIE;
-
-	mtpmr(PMRN_PMGC0, pmgc0);
-}
-
-void pmc_stop_ctrs(void)
-{
-	u32 pmgc0 = mfpmr(PMRN_PMGC0);
-
-	pmgc0 |= PMGC0_FAC;
-
-	pmgc0 &= ~(PMGC0_PMIE | PMGC0_FCECE);
-
-	mtpmr(PMRN_PMGC0, pmgc0);
-}
-
-void dump_pmcs(void)
-{
-	printk("pmgc0: %x\n", mfpmr(PMRN_PMGC0));
-	printk("pmc\t\tpmlca\t\tpmlcb\n");
-	printk("%8x\t%8x\t%8x\n", mfpmr(PMRN_PMC0),
-			mfpmr(PMRN_PMLCA0), mfpmr(PMRN_PMLCB0));
-	printk("%8x\t%8x\t%8x\n", mfpmr(PMRN_PMC1),
-			mfpmr(PMRN_PMLCA1), mfpmr(PMRN_PMLCB1));
-	printk("%8x\t%8x\t%8x\n", mfpmr(PMRN_PMC2),
-			mfpmr(PMRN_PMLCA2), mfpmr(PMRN_PMLCB2));
-	printk("%8x\t%8x\t%8x\n", mfpmr(PMRN_PMC3),
-			mfpmr(PMRN_PMLCA3), mfpmr(PMRN_PMLCB3));
-}
-
-EXPORT_SYMBOL(init_pmc_stop);
-EXPORT_SYMBOL(set_pmc_event);
-EXPORT_SYMBOL(set_pmc_user_kernel);
-EXPORT_SYMBOL(set_pmc_marked);
-EXPORT_SYMBOL(pmc_start_ctr);
-EXPORT_SYMBOL(pmc_start_ctrs);
-EXPORT_SYMBOL(pmc_stop_ctrs);
-EXPORT_SYMBOL(dump_pmcs);
diff --git a/arch/powerpc/kernel/pmc.c b/arch/powerpc/kernel/pmc.c
index a0a2efa..3d8f6f4 100644
--- a/arch/powerpc/kernel/pmc.c
+++ b/arch/powerpc/kernel/pmc.c
@@ -71,7 +71,7 @@ int reserve_pmc_hardware(perf_irq_t new_
 	}
 
 	pmc_owner_caller = __builtin_return_address(0);
-	perf_irq = new_perf_irq ? : dummy_perf;
+	perf_irq = new_perf_irq ? new_perf_irq : dummy_perf;
 
  out:
 	spin_unlock(&pmc_owner_lock);
diff --git a/arch/powerpc/oprofile/Makefile b/arch/powerpc/oprofile/Makefile
index 3145d61..0b5df9c 100644
--- a/arch/powerpc/oprofile/Makefile
+++ b/arch/powerpc/oprofile/Makefile
@@ -13,4 +13,4 @@ DRIVER_OBJS := $(addprefix ../../../driv
 oprofile-y := $(DRIVER_OBJS) common.o backtrace.o
 oprofile-$(CONFIG_PPC64) += op_model_rs64.o op_model_power4.o
 oprofile-$(CONFIG_FSL_BOOKE) += op_model_fsl_booke.o
-oprofile-$(CONFIG_PPC32) += op_model_7450.o
+oprofile-$(CONFIG_6xx) += op_model_7450.o
diff --git a/arch/powerpc/oprofile/common.c b/arch/powerpc/oprofile/common.c
index fd0bbbe..63bbef3 100644
--- a/arch/powerpc/oprofile/common.c
+++ b/arch/powerpc/oprofile/common.c
@@ -34,6 +34,11 @@ static void op_handle_interrupt(struct p
 	model->handle_interrupt(regs, ctr);
 }
 
+static void op_powerpc_cpu_setup(void *dummy)
+{
+	model->cpu_setup(ctr);
+}
+
 static int op_powerpc_setup(void)
 {
 	int err;
@@ -47,7 +52,7 @@ static int op_powerpc_setup(void)
 	model->reg_setup(ctr, &sys, model->num_counters);
 
 	/* Configure the registers on all cpus.  */
-	on_each_cpu(model->cpu_setup, NULL, 0, 1);
+	on_each_cpu(op_powerpc_cpu_setup, NULL, 0, 1);
 
 	return 0;
 }
@@ -142,7 +147,8 @@ #ifdef CONFIG_PPC64
 		case PPC_OPROFILE_POWER4:
 			model = &op_model_power4;
 			break;
-#else
+#endif
+#ifdef CONFIG_6xx
 		case PPC_OPROFILE_G4:
 			model = &op_model_7450;
 			break;
diff --git a/arch/powerpc/oprofile/op_model_7450.c b/arch/powerpc/oprofile/op_model_7450.c
index d8ee3ae..f481c0e 100644
--- a/arch/powerpc/oprofile/op_model_7450.c
+++ b/arch/powerpc/oprofile/op_model_7450.c
@@ -81,7 +81,7 @@ static void pmc_stop_ctrs(void)
 
 /* Configures the counters on this CPU based on the global
  * settings */
-static void fsl7450_cpu_setup(void *unused)
+static void fsl7450_cpu_setup(struct op_counter_config *ctr)
 {
 	/* freeze all counters */
 	pmc_stop_ctrs();
diff --git a/arch/powerpc/oprofile/op_model_fsl_booke.c b/arch/powerpc/oprofile/op_model_fsl_booke.c
index e29dede..0b3c31f 100644
--- a/arch/powerpc/oprofile/op_model_fsl_booke.c
+++ b/arch/powerpc/oprofile/op_model_fsl_booke.c
@@ -32,42 +32,152 @@ static unsigned long reset_value[OP_MAX_
 static int num_counters;
 static int oprofile_running;
 
-static inline unsigned int ctr_read(unsigned int i)
+static void init_pmc_stop(int ctr)
 {
-	switch(i) {
-		case 0:
-			return mfpmr(PMRN_PMC0);
-		case 1:
-			return mfpmr(PMRN_PMC1);
-		case 2:
-			return mfpmr(PMRN_PMC2);
-		case 3:
-			return mfpmr(PMRN_PMC3);
-		default:
-			return 0;
-	}
-}
+	u32 pmlca = (PMLCA_FC | PMLCA_FCS | PMLCA_FCU |
+			PMLCA_FCM1 | PMLCA_FCM0);
+	u32 pmlcb = 0;
 
-static inline void ctr_write(unsigned int i, unsigned int val)
-{
-	switch(i) {
+	switch (ctr) {
 		case 0:
-			mtpmr(PMRN_PMC0, val);
+			mtpmr(PMRN_PMLCA0, pmlca);
+			mtpmr(PMRN_PMLCB0, pmlcb);
 			break;
 		case 1:
-			mtpmr(PMRN_PMC1, val);
+			mtpmr(PMRN_PMLCA1, pmlca);
+			mtpmr(PMRN_PMLCB1, pmlcb);
 			break;
 		case 2:
-			mtpmr(PMRN_PMC2, val);
+			mtpmr(PMRN_PMLCA2, pmlca);
+			mtpmr(PMRN_PMLCB2, pmlcb);
 			break;
 		case 3:
-			mtpmr(PMRN_PMC3, val);
+			mtpmr(PMRN_PMLCA3, pmlca);
+			mtpmr(PMRN_PMLCB3, pmlcb);
 			break;
 		default:
-			break;
+			panic("Bad ctr number!\n");
 	}
 }
 
+static void set_pmc_event(int ctr, int event)
+{
+	u32 pmlca;
+
+	pmlca = get_pmlca(ctr);
+
+	pmlca = (pmlca & ~PMLCA_EVENT_MASK) |
+		((event << PMLCA_EVENT_SHIFT) &
+		 PMLCA_EVENT_MASK);
+
+	set_pmlca(ctr, pmlca);
+}
+
+static void set_pmc_user_kernel(int ctr, int user, int kernel)
+{
+	u32 pmlca;
+
+	pmlca = get_pmlca(ctr);
+
+	if(user)
+		pmlca &= ~PMLCA_FCU;
+	else
+		pmlca |= PMLCA_FCU;
+
+	if(kernel)
+		pmlca &= ~PMLCA_FCS;
+	else
+		pmlca |= PMLCA_FCS;
+
+	set_pmlca(ctr, pmlca);
+}
+
+static void set_pmc_marked(int ctr, int mark0, int mark1)
+{
+	u32 pmlca = get_pmlca(ctr);
+
+	if(mark0)
+		pmlca &= ~PMLCA_FCM0;
+	else
+		pmlca |= PMLCA_FCM0;
+
+	if(mark1)
+		pmlca &= ~PMLCA_FCM1;
+	else
+		pmlca |= PMLCA_FCM1;
+
+	set_pmlca(ctr, pmlca);
+}
+
+static void pmc_start_ctr(int ctr, int enable)
+{
+	u32 pmlca = get_pmlca(ctr);
+
+	pmlca &= ~PMLCA_FC;
+
+	if (enable)
+		pmlca |= PMLCA_CE;
+	else
+		pmlca &= ~PMLCA_CE;
+
+	set_pmlca(ctr, pmlca);
+}
+
+static void pmc_start_ctrs(int enable)
+{
+	u32 pmgc0 = mfpmr(PMRN_PMGC0);
+
+	pmgc0 &= ~PMGC0_FAC;
+	pmgc0 |= PMGC0_FCECE;
+
+	if (enable)
+		pmgc0 |= PMGC0_PMIE;
+	else
+		pmgc0 &= ~PMGC0_PMIE;
+
+	mtpmr(PMRN_PMGC0, pmgc0);
+}
+
+static void pmc_stop_ctrs(void)
+{
+	u32 pmgc0 = mfpmr(PMRN_PMGC0);
+
+	pmgc0 |= PMGC0_FAC;
+
+	pmgc0 &= ~(PMGC0_PMIE | PMGC0_FCECE);
+
+	mtpmr(PMRN_PMGC0, pmgc0);
+}
+
+static void dump_pmcs(void)
+{
+	printk("pmgc0: %x\n", mfpmr(PMRN_PMGC0));
+	printk("pmc\t\tpmlca\t\tpmlcb\n");
+	printk("%8x\t%8x\t%8x\n", mfpmr(PMRN_PMC0),
+			mfpmr(PMRN_PMLCA0), mfpmr(PMRN_PMLCB0));
+	printk("%8x\t%8x\t%8x\n", mfpmr(PMRN_PMC1),
+			mfpmr(PMRN_PMLCA1), mfpmr(PMRN_PMLCB1));
+	printk("%8x\t%8x\t%8x\n", mfpmr(PMRN_PMC2),
+			mfpmr(PMRN_PMLCA2), mfpmr(PMRN_PMLCB2));
+	printk("%8x\t%8x\t%8x\n", mfpmr(PMRN_PMC3),
+			mfpmr(PMRN_PMLCA3), mfpmr(PMRN_PMLCB3));
+}
+
+static void fsl_booke_cpu_setup(struct op_counter_config *ctr)
+{
+	int i;
+
+	/* freeze all counters */
+	pmc_stop_ctrs();
+
+	for (i = 0;i < num_counters;i++) {
+		init_pmc_stop(i);
+
+		set_pmc_event(i, ctr[i].event);
+
+		set_pmc_user_kernel(i, ctr[i].user, ctr[i].kernel);
+	}
+}
 
 static void fsl_booke_reg_setup(struct op_counter_config *ctr,
 			     struct op_system_config *sys,
@@ -77,23 +187,14 @@ static void fsl_booke_reg_setup(struct o
 
 	num_counters = num_ctrs;
 
-	/* freeze all counters */
-	pmc_stop_ctrs();
-
 	/* Our counters count up, and "count" refers to
 	 * how much before the next interrupt, and we interrupt
 	 * on overflow.  So we calculate the starting value
 	 * which will give us "count" until overflow.
 	 * Then we set the events on the enabled counters */
-	for (i = 0; i < num_counters; ++i) {
+	for (i = 0; i < num_counters; ++i)
 		reset_value[i] = 0x80000000UL - ctr[i].count;
 
-		init_pmc_stop(i);
-
-		set_pmc_event(i, ctr[i].event);
-
-		set_pmc_user_kernel(i, ctr[i].user, ctr[i].kernel);
-	}
 }
 
 static void fsl_booke_start(struct op_counter_config *ctr)
@@ -105,8 +206,8 @@ static void fsl_booke_start(struct op_co
 	for (i = 0; i < num_counters; ++i) {
 		if (ctr[i].enabled) {
 			ctr_write(i, reset_value[i]);
-			/* Set Each enabled counterd to only
-			 * count when the Mark bit is not set */
+			/* Set each enabled counter to only
+			 * count when the Mark bit is *not* set */
 			set_pmc_marked(i, 1, 0);
 			pmc_start_ctr(i, 1);
 		} else {
@@ -177,6 +278,7 @@ static void fsl_booke_handle_interrupt(s
 
 struct op_powerpc_model op_model_fsl_booke = {
 	.reg_setup		= fsl_booke_reg_setup,
+	.cpu_setup		= fsl_booke_cpu_setup,
 	.start			= fsl_booke_start,
 	.stop			= fsl_booke_stop,
 	.handle_interrupt	= fsl_booke_handle_interrupt,
diff --git a/arch/powerpc/oprofile/op_model_power4.c b/arch/powerpc/oprofile/op_model_power4.c
index 6a927ef..356709d 100644
--- a/arch/powerpc/oprofile/op_model_power4.c
+++ b/arch/powerpc/oprofile/op_model_power4.c
@@ -82,7 +82,7 @@ static inline int mmcra_must_set_sample(
 	return 0;
 }
 
-static void power4_cpu_setup(void *unused)
+static void power4_cpu_setup(struct op_counter_config *ctr)
 {
 	unsigned int mmcr0 = mmcr0_val;
 	unsigned long mmcra = mmcra_val;
diff --git a/arch/powerpc/oprofile/op_model_rs64.c b/arch/powerpc/oprofile/op_model_rs64.c
index 042f8f4..19c5ee0 100644
--- a/arch/powerpc/oprofile/op_model_rs64.c
+++ b/arch/powerpc/oprofile/op_model_rs64.c
@@ -102,7 +102,7 @@ static void rs64_reg_setup(struct op_cou
 	/* XXX setup user and kernel profiling */
 }
 
-static void rs64_cpu_setup(void *unused)
+static void rs64_cpu_setup(struct op_counter_config *ctr)
 {
 	unsigned int mmcr0;
 
diff --git a/include/asm-powerpc/oprofile_impl.h b/include/asm-powerpc/oprofile_impl.h
index 5b33994..07a10e5 100644
--- a/include/asm-powerpc/oprofile_impl.h
+++ b/include/asm-powerpc/oprofile_impl.h
@@ -42,7 +42,7 @@ struct op_powerpc_model {
 	void (*reg_setup) (struct op_counter_config *,
 			   struct op_system_config *,
 			   int num_counters);
-	void (*cpu_setup) (void *);
+	void (*cpu_setup) (struct op_counter_config *);
 	void (*start) (struct op_counter_config *);
 	void (*stop) (void);
 	void (*handle_interrupt) (struct pt_regs *,
@@ -121,7 +121,90 @@ #endif
 		break;
 	}
 }
-#endif /* !CONFIG_FSL_BOOKE */
+#else /* CONFIG_FSL_BOOKE */
+static inline u32 get_pmlca(int ctr)
+{
+	u32 pmlca;
+
+	switch (ctr) {
+		case 0:
+			pmlca = mfpmr(PMRN_PMLCA0);
+			break;
+		case 1:
+			pmlca = mfpmr(PMRN_PMLCA1);
+			break;
+		case 2:
+			pmlca = mfpmr(PMRN_PMLCA2);
+			break;
+		case 3:
+			pmlca = mfpmr(PMRN_PMLCA3);
+			break;
+		default:
+			panic("Bad ctr number\n");
+	}
+
+	return pmlca;
+}
+
+static inline void set_pmlca(int ctr, u32 pmlca)
+{
+	switch (ctr) {
+		case 0:
+			mtpmr(PMRN_PMLCA0, pmlca);
+			break;
+		case 1:
+			mtpmr(PMRN_PMLCA1, pmlca);
+			break;
+		case 2:
+			mtpmr(PMRN_PMLCA2, pmlca);
+			break;
+		case 3:
+			mtpmr(PMRN_PMLCA3, pmlca);
+			break;
+		default:
+			panic("Bad ctr number\n");
+	}
+}
+
+static inline unsigned int ctr_read(unsigned int i)
+{
+	switch(i) {
+		case 0:
+			return mfpmr(PMRN_PMC0);
+		case 1:
+			return mfpmr(PMRN_PMC1);
+		case 2:
+			return mfpmr(PMRN_PMC2);
+		case 3:
+			return mfpmr(PMRN_PMC3);
+		default:
+			return 0;
+	}
+}
+
+static inline void ctr_write(unsigned int i, unsigned int val)
+{
+	switch(i) {
+		case 0:
+			mtpmr(PMRN_PMC0, val);
+			break;
+		case 1:
+			mtpmr(PMRN_PMC1, val);
+			break;
+		case 2:
+			mtpmr(PMRN_PMC2, val);
+			break;
+		case 3:
+			mtpmr(PMRN_PMC3, val);
+			break;
+		default:
+			break;
+	}
+}
+
+
+#endif /* CONFIG_FSL_BOOKE */
+
 
 extern void op_powerpc_backtrace(struct pt_regs * const regs, unsigned int depth);
 
diff --git a/include/asm-powerpc/pmc.h b/include/asm-powerpc/pmc.h
index 07d6a42..8588be6 100644
--- a/include/asm-powerpc/pmc.h
+++ b/include/asm-powerpc/pmc.h
@@ -32,18 +32,5 @@ #ifdef CONFIG_PPC64
 void power4_enable_pmcs(void);
 #endif
 
-#ifdef CONFIG_FSL_BOOKE
-void init_pmc_stop(int ctr);
-void set_pmc_event(int ctr, int event);
-void set_pmc_user_kernel(int ctr, int user, int kernel);
-void set_pmc_marked(int ctr, int mark0, int mark1);
-void pmc_start_ctr(int ctr, int enable);
-void pmc_start_ctrs(int enable);
-void pmc_stop_ctrs(void);
-void dump_pmcs(void);
-
-extern struct op_powerpc_model op_model_fsl_booke;
-#endif
-
 #endif /* __KERNEL__ */
 #endif /* _POWERPC_PMC_H */
-- 
1.4.2.3

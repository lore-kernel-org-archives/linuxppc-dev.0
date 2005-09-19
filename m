Return-Path: <sfr@canb.auug.org.au>
Date: Mon, 19 Sep 2005 23:24:08 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: paulus@samba.org
Message-Id: <20050919232408.776ff437.sfr@canb.auug.org.au>
In-Reply-To: <20050919231051.28fcdf30.sfr@canb.auug.org.au>
References: <20050919231051.28fcdf30.sfr@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: ppc64-dev <linuxppc64-dev@ozlabs.org>, ppc-dev <linuxppc-dev@ozlabs.org>
Subject: [PATCH 5/6] powerpc: merge the rest of arch/ppc*/oprofile
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

- merge common.c
- move model specific files
- remove stub Makefiles
- clean up arch/ppc*/Makefile

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---

 arch/powerpc/oprofile/common.c             |  214 +++++++++++++++++++
 arch/powerpc/oprofile/op_model_fsl_booke.c |  183 +++++++++++++++++
 arch/powerpc/oprofile/op_model_power4.c    |  309 ++++++++++++++++++++++++++++
 arch/powerpc/oprofile/op_model_rs64.c      |  218 ++++++++++++++++++++
 arch/ppc/Makefile                          |    2 
 arch/ppc/oprofile/Makefile                 |    1 
 arch/ppc/oprofile/common.c                 |  160 --------------
 arch/ppc/oprofile/op_model_fsl_booke.c     |  183 -----------------
 arch/ppc64/Makefile                        |    2 
 arch/ppc64/oprofile/Makefile               |    1 
 arch/ppc64/oprofile/common.c               |  145 -------------
 arch/ppc64/oprofile/op_model_power4.c      |  309 ----------------------------
 arch/ppc64/oprofile/op_model_rs64.c        |  218 --------------------
 13 files changed, 926 insertions(+), 1019 deletions(-)
 create mode 100644 arch/powerpc/oprofile/common.c
 create mode 100644 arch/powerpc/oprofile/op_model_fsl_booke.c
 create mode 100644 arch/powerpc/oprofile/op_model_power4.c
 create mode 100644 arch/powerpc/oprofile/op_model_rs64.c
 delete mode 100644 arch/ppc/oprofile/Makefile
 delete mode 100644 arch/ppc/oprofile/common.c
 delete mode 100644 arch/ppc/oprofile/op_model_fsl_booke.c
 delete mode 100644 arch/ppc64/oprofile/Makefile
 delete mode 100644 arch/ppc64/oprofile/common.c
 delete mode 100644 arch/ppc64/oprofile/op_model_power4.c
 delete mode 100644 arch/ppc64/oprofile/op_model_rs64.c

-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

6dc3424cfdea7aedd29e9aad5eb93c84f922bdd1
diff --git a/arch/powerpc/oprofile/common.c b/arch/powerpc/oprofile/common.c
new file mode 100644
--- /dev/null
+++ b/arch/powerpc/oprofile/common.c
@@ -0,0 +1,214 @@
+/*
+ * PPC 64 oprofile support:
+ * Copyright (C) 2004 Anton Blanchard <anton@au.ibm.com>, IBM
+ * PPC 32 oprofile support: (based on PPC 64 support)
+ * Copyright (C) Freescale Semiconductor, Inc 2004
+ *	Author: Andy Fleming
+ *
+ * Based on alpha version.
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version
+ * 2 of the License, or (at your option) any later version.
+ */
+
+#include <linux/oprofile.h>
+#ifndef __powerpc64__
+#include <linux/slab.h>
+#endif /* ! __powerpc64__ */
+#include <linux/init.h>
+#include <linux/smp.h>
+#include <linux/errno.h>
+#include <asm/ptrace.h>
+#include <asm/system.h>
+#ifdef __powerpc64__
+#include <asm/pmc.h>
+#else /* __powerpc64__ */
+#include <asm/perfmon.h>
+#endif /* __powerpc64__ */
+#include <asm/cputable.h>
+#include <asm/oprofile_impl.h>
+
+static struct op_powerpc_model *model;
+
+static struct op_counter_config ctr[OP_MAX_COUNTER];
+static struct op_system_config sys;
+
+#ifndef __powerpc64__
+static char *cpu_type;
+#endif /* ! __powerpc64__ */
+
+static void op_handle_interrupt(struct pt_regs *regs)
+{
+	model->handle_interrupt(regs, ctr);
+}
+
+static int op_powerpc_setup(void)
+{
+#ifdef __powerpc64__
+	int err;
+
+	/* Grab the hardware */
+	err = reserve_pmc_hardware(op_handle_interrupt);
+	if (err)
+		return err;
+#else /* __powerpc64__ */
+	/* Install our interrupt handler into the existing hook.  */
+	if (request_perfmon_irq(&op_handle_interrupt))
+		return -EBUSY;
+	mb();
+#endif /* __powerpc64__ */
+
+	/* Pre-compute the values to stuff in the hardware registers.  */
+	model->reg_setup(ctr, &sys, model->num_counters);
+
+	/* Configure the registers on all cpus.  */
+#ifdef __powerpc64__
+	on_each_cpu(model->cpu_setup, NULL, 0, 1);
+#else /* __powerpc64__ */
+#if 0
+	/* FIXME: Make multi-cpu work */
+	on_each_cpu(model->reg_setup, NULL, 0, 1);
+#endif
+#endif /* __powerpc64__ */
+
+	return 0;
+}
+
+static void op_powerpc_shutdown(void)
+{
+#ifdef __powerpc64__
+	release_pmc_hardware();
+#else /* __powerpc64__ */
+	mb();
+	/* Remove our interrupt handler. We may be removing this module. */
+	free_perfmon_irq();
+#endif /* __powerpc64__ */
+}
+
+static void op_powerpc_cpu_start(void *dummy)
+{
+	model->start(ctr);
+}
+
+static int op_powerpc_start(void)
+{
+	on_each_cpu(op_powerpc_cpu_start, NULL, 0, 1);
+	return 0;
+}
+
+static inline void op_powerpc_cpu_stop(void *dummy)
+{
+	model->stop();
+}
+
+static void op_powerpc_stop(void)
+{
+	on_each_cpu(op_powerpc_cpu_stop, NULL, 0, 1);
+}
+
+static int op_powerpc_create_files(struct super_block *sb, struct dentry *root)
+{
+	int i;
+
+#ifdef __powerpc64__
+	/*
+	 * There is one mmcr0, mmcr1 and mmcra for setting the events for
+	 * all of the counters.
+	 */
+	oprofilefs_create_ulong(sb, root, "mmcr0", &sys.mmcr0);
+	oprofilefs_create_ulong(sb, root, "mmcr1", &sys.mmcr1);
+	oprofilefs_create_ulong(sb, root, "mmcra", &sys.mmcra);
+#endif /* __powerpc64__ */
+
+	for (i = 0; i < model->num_counters; ++i) {
+		struct dentry *dir;
+		char buf[3];
+
+		snprintf(buf, sizeof buf, "%d", i);
+		dir = oprofilefs_mkdir(sb, root, buf);
+
+		oprofilefs_create_ulong(sb, dir, "enabled", &ctr[i].enabled);
+		oprofilefs_create_ulong(sb, dir, "event", &ctr[i].event);
+		oprofilefs_create_ulong(sb, dir, "count", &ctr[i].count);
+#ifdef __powerpc64__
+		/*
+		 * We dont support per counter user/kernel selection, but
+		 * we leave the entries because userspace expects them
+		 */
+#endif /* __powerpc64__ */
+		oprofilefs_create_ulong(sb, dir, "kernel", &ctr[i].kernel);
+		oprofilefs_create_ulong(sb, dir, "user", &ctr[i].user);
+
+#ifndef __powerpc64__
+		/* FIXME: Not sure if this is used */
+#endif /* ! __powerpc64__ */
+		oprofilefs_create_ulong(sb, dir, "unit_mask", &ctr[i].unit_mask);
+	}
+
+	oprofilefs_create_ulong(sb, root, "enable_kernel", &sys.enable_kernel);
+	oprofilefs_create_ulong(sb, root, "enable_user", &sys.enable_user);
+#ifdef __powerpc64__
+	oprofilefs_create_ulong(sb, root, "backtrace_spinlocks",
+				&sys.backtrace_spinlocks);
+#endif /* __powerpc64__ */
+
+	/* Default to tracing both kernel and user */
+	sys.enable_kernel = 1;
+	sys.enable_user = 1;
+#ifdef __powerpc64__
+	/* Turn on backtracing through spinlocks by default */
+	sys.backtrace_spinlocks = 1;
+#endif /* __powerpc64__ */
+
+	return 0;
+}
+
+int __init oprofile_arch_init(struct oprofile_operations *ops)
+{
+#ifndef __powerpc64__
+	int cpu_id = smp_processor_id();
+
+#ifdef CONFIG_FSL_BOOKE
+	model = &op_model_fsl_booke;
+#else
+	return -ENODEV;
+#endif
+
+	cpu_type = kmalloc(32, GFP_KERNEL);
+	if (NULL == cpu_type)
+		return -ENOMEM;
+
+	sprintf(cpu_type, "ppc/%s", cur_cpu_spec[cpu_id]->cpu_name);
+
+	model->num_counters = cur_cpu_spec[cpu_id]->num_pmcs;
+
+	ops->cpu_type = cpu_type;
+#else /* __powerpc64__ */
+	if (!cur_cpu_spec->oprofile_model || !cur_cpu_spec->oprofile_cpu_type)
+		return -ENODEV;
+	model = cur_cpu_spec->oprofile_model;
+	model->num_counters = cur_cpu_spec->num_pmcs;
+
+	ops->cpu_type = cur_cpu_spec->oprofile_cpu_type;
+#endif /* __powerpc64__ */
+	ops->create_files = op_powerpc_create_files;
+	ops->setup = op_powerpc_setup;
+	ops->shutdown = op_powerpc_shutdown;
+	ops->start = op_powerpc_start;
+	ops->stop = op_powerpc_stop;
+
+	printk(KERN_INFO "oprofile: using %s performance monitoring.\n",
+	       ops->cpu_type);
+
+	return 0;
+}
+
+void oprofile_arch_exit(void)
+{
+#ifndef __powerpc64__
+	kfree(cpu_type);
+	cpu_type = NULL;
+#endif /* ! __powerpc64__ */
+}
diff --git a/arch/powerpc/oprofile/op_model_fsl_booke.c b/arch/powerpc/oprofile/op_model_fsl_booke.c
new file mode 100644
--- /dev/null
+++ b/arch/powerpc/oprofile/op_model_fsl_booke.c
@@ -0,0 +1,183 @@
+/*
+ * oprofile/op_model_e500.c
+ *
+ * Freescale Book-E oprofile support, based on ppc64 oprofile support
+ * Copyright (C) 2004 Anton Blanchard <anton@au.ibm.com>, IBM
+ *
+ * Copyright (c) 2004 Freescale Semiconductor, Inc
+ *
+ * Author: Andy Fleming
+ * Maintainer: Kumar Gala <Kumar.Gala@freescale.com>
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version
+ * 2 of the License, or (at your option) any later version.
+ */
+
+#include <linux/oprofile.h>
+#include <linux/init.h>
+#include <linux/smp.h>
+#include <asm/ptrace.h>
+#include <asm/system.h>
+#include <asm/processor.h>
+#include <asm/cputable.h>
+#include <asm/reg_booke.h>
+#include <asm/page.h>
+#include <asm/perfmon.h>
+#include <asm/oprofile_impl.h>
+
+static unsigned long reset_value[OP_MAX_COUNTER];
+
+static int num_counters;
+static int oprofile_running;
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
+static void fsl_booke_reg_setup(struct op_counter_config *ctr,
+			     struct op_system_config *sys,
+			     int num_ctrs)
+{
+	int i;
+
+	num_counters = num_ctrs;
+
+	/* freeze all counters */
+	pmc_stop_ctrs();
+
+	/* Our counters count up, and "count" refers to
+	 * how much before the next interrupt, and we interrupt
+	 * on overflow.  So we calculate the starting value
+	 * which will give us "count" until overflow.
+	 * Then we set the events on the enabled counters */
+	for (i = 0; i < num_counters; ++i) {
+		reset_value[i] = 0x80000000UL - ctr[i].count;
+
+		init_pmc_stop(i);
+
+		set_pmc_event(i, ctr[i].event);
+
+		set_pmc_user_kernel(i, ctr[i].user, ctr[i].kernel);
+	}
+}
+
+static void fsl_booke_start(struct op_counter_config *ctr)
+{
+	int i;
+
+	mtmsr(mfmsr() | MSR_PMM);
+
+	for (i = 0; i < num_counters; ++i) {
+		if (ctr[i].enabled) {
+			ctr_write(i, reset_value[i]);
+			/* Set Each enabled counterd to only
+			 * count when the Mark bit is not set */
+			set_pmc_marked(i, 1, 0);
+			pmc_start_ctr(i, 1);
+		} else {
+			ctr_write(i, 0);
+
+			/* Set the ctr to be stopped */
+			pmc_start_ctr(i, 0);
+		}
+	}
+
+	/* Clear the freeze bit, and enable the interrupt.
+	 * The counters won't actually start until the rfi clears
+	 * the PMM bit */
+	pmc_start_ctrs(1);
+
+	oprofile_running = 1;
+
+	pr_debug("start on cpu %d, pmgc0 %x\n", smp_processor_id(),
+			mfpmr(PMRN_PMGC0));
+}
+
+static void fsl_booke_stop(void)
+{
+	/* freeze counters */
+	pmc_stop_ctrs();
+
+	oprofile_running = 0;
+
+	pr_debug("stop on cpu %d, pmgc0 %x\n", smp_processor_id(),
+			mfpmr(PMRN_PMGC0));
+
+	mb();
+}
+
+
+static void fsl_booke_handle_interrupt(struct pt_regs *regs,
+				    struct op_counter_config *ctr)
+{
+	unsigned long pc;
+	int is_kernel;
+	int val;
+	int i;
+
+	/* set the PMM bit (see comment below) */
+	mtmsr(mfmsr() | MSR_PMM);
+
+	pc = regs->nip;
+	is_kernel = (pc >= KERNELBASE);
+
+	for (i = 0; i < num_counters; ++i) {
+		val = ctr_read(i);
+		if (val < 0) {
+			if (oprofile_running && ctr[i].enabled) {
+				oprofile_add_pc(pc, is_kernel, i);
+				ctr_write(i, reset_value[i]);
+			} else {
+				ctr_write(i, 0);
+			}
+		}
+	}
+
+	/* The freeze bit was set by the interrupt. */
+	/* Clear the freeze bit, and reenable the interrupt.
+	 * The counters won't actually start until the rfi clears
+	 * the PMM bit */
+	pmc_start_ctrs(1);
+}
+
+struct op_powerpc_model op_model_fsl_booke = {
+	.reg_setup		= fsl_booke_reg_setup,
+	.start			= fsl_booke_start,
+	.stop			= fsl_booke_stop,
+	.handle_interrupt	= fsl_booke_handle_interrupt,
+};
diff --git a/arch/powerpc/oprofile/op_model_power4.c b/arch/powerpc/oprofile/op_model_power4.c
new file mode 100644
--- /dev/null
+++ b/arch/powerpc/oprofile/op_model_power4.c
@@ -0,0 +1,309 @@
+/*
+ * Copyright (C) 2004 Anton Blanchard <anton@au.ibm.com>, IBM
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version
+ * 2 of the License, or (at your option) any later version.
+ */
+
+#include <linux/oprofile.h>
+#include <linux/init.h>
+#include <linux/smp.h>
+#include <asm/ptrace.h>
+#include <asm/system.h>
+#include <asm/processor.h>
+#include <asm/cputable.h>
+#include <asm/systemcfg.h>
+#include <asm/rtas.h>
+#include <asm/oprofile_impl.h>
+
+#define dbg(args...)
+
+static unsigned long reset_value[OP_MAX_COUNTER];
+
+static int oprofile_running;
+static int mmcra_has_sihv;
+
+/* mmcr values are set in power4_reg_setup, used in power4_cpu_setup */
+static u32 mmcr0_val;
+static u64 mmcr1_val;
+static u32 mmcra_val;
+
+/*
+ * Since we do not have an NMI, backtracing through spinlocks is
+ * only a best guess. In light of this, allow it to be disabled at
+ * runtime.
+ */
+static int backtrace_spinlocks;
+
+static void power4_reg_setup(struct op_counter_config *ctr,
+			     struct op_system_config *sys,
+			     int num_ctrs)
+{
+	int i;
+
+	/*
+	 * SIHV / SIPR bits are only implemented on POWER4+ (GQ) and above.
+	 * However we disable it on all POWER4 until we verify it works
+	 * (I was seeing some strange behaviour last time I tried).
+	 *
+	 * It has been verified to work on POWER5 so we enable it there.
+	 */
+	if (cpu_has_feature(CPU_FTR_MMCRA_SIHV))
+		mmcra_has_sihv = 1;
+
+	/*
+	 * The performance counter event settings are given in the mmcr0,
+	 * mmcr1 and mmcra values passed from the user in the
+	 * op_system_config structure (sys variable).
+	 */
+	mmcr0_val = sys->mmcr0;
+	mmcr1_val = sys->mmcr1;
+	mmcra_val = sys->mmcra;
+
+	backtrace_spinlocks = sys->backtrace_spinlocks;
+
+	for (i = 0; i < cur_cpu_spec->num_pmcs; ++i)
+		reset_value[i] = 0x80000000UL - ctr[i].count;
+
+	/* setup user and kernel profiling */
+	if (sys->enable_kernel)
+		mmcr0_val &= ~MMCR0_KERNEL_DISABLE;
+	else
+		mmcr0_val |= MMCR0_KERNEL_DISABLE;
+
+	if (sys->enable_user)
+		mmcr0_val &= ~MMCR0_PROBLEM_DISABLE;
+	else
+		mmcr0_val |= MMCR0_PROBLEM_DISABLE;
+}
+
+extern void ppc64_enable_pmcs(void);
+
+static void power4_cpu_setup(void *unused)
+{
+	unsigned int mmcr0 = mmcr0_val;
+	unsigned long mmcra = mmcra_val;
+
+	ppc64_enable_pmcs();
+
+	/* set the freeze bit */
+	mmcr0 |= MMCR0_FC;
+	mtspr(SPRN_MMCR0, mmcr0);
+
+	mmcr0 |= MMCR0_FCM1|MMCR0_PMXE|MMCR0_FCECE;
+	mmcr0 |= MMCR0_PMC1CE|MMCR0_PMCjCE;
+	mtspr(SPRN_MMCR0, mmcr0);
+
+	mtspr(SPRN_MMCR1, mmcr1_val);
+
+	mmcra |= MMCRA_SAMPLE_ENABLE;
+	mtspr(SPRN_MMCRA, mmcra);
+
+	dbg("setup on cpu %d, mmcr0 %lx\n", smp_processor_id(),
+	    mfspr(SPRN_MMCR0));
+	dbg("setup on cpu %d, mmcr1 %lx\n", smp_processor_id(),
+	    mfspr(SPRN_MMCR1));
+	dbg("setup on cpu %d, mmcra %lx\n", smp_processor_id(),
+	    mfspr(SPRN_MMCRA));
+}
+
+static void power4_start(struct op_counter_config *ctr)
+{
+	int i;
+	unsigned int mmcr0;
+
+	/* set the PMM bit (see comment below) */
+	mtmsrd(mfmsr() | MSR_PMM);
+
+	for (i = 0; i < cur_cpu_spec->num_pmcs; ++i) {
+		if (ctr[i].enabled) {
+			ctr_write(i, reset_value[i]);
+		} else {
+			ctr_write(i, 0);
+		}
+	}
+
+	mmcr0 = mfspr(SPRN_MMCR0);
+
+	/*
+	 * We must clear the PMAO bit on some (GQ) chips. Just do it
+	 * all the time
+	 */
+	mmcr0 &= ~MMCR0_PMAO;
+
+	/*
+	 * now clear the freeze bit, counting will not start until we
+	 * rfid from this excetion, because only at that point will
+	 * the PMM bit be cleared
+	 */
+	mmcr0 &= ~MMCR0_FC;
+	mtspr(SPRN_MMCR0, mmcr0);
+
+	oprofile_running = 1;
+
+	dbg("start on cpu %d, mmcr0 %x\n", smp_processor_id(), mmcr0);
+}
+
+static void power4_stop(void)
+{
+	unsigned int mmcr0;
+
+	/* freeze counters */
+	mmcr0 = mfspr(SPRN_MMCR0);
+	mmcr0 |= MMCR0_FC;
+	mtspr(SPRN_MMCR0, mmcr0);
+
+	oprofile_running = 0;
+
+	dbg("stop on cpu %d, mmcr0 %x\n", smp_processor_id(), mmcr0);
+
+	mb();
+}
+
+/* Fake functions used by canonicalize_pc */
+static void __attribute_used__ hypervisor_bucket(void)
+{
+}
+
+static void __attribute_used__ rtas_bucket(void)
+{
+}
+
+static void __attribute_used__ kernel_unknown_bucket(void)
+{
+}
+
+static unsigned long check_spinlock_pc(struct pt_regs *regs,
+				       unsigned long profile_pc)
+{
+	unsigned long pc = instruction_pointer(regs);
+
+	/*
+	 * If both the SIAR (sampled instruction) and the perfmon exception
+	 * occurred in a spinlock region then we account the sample to the
+	 * calling function. This isnt 100% correct, we really need soft
+	 * IRQ disable so we always get the perfmon exception at the
+	 * point at which the SIAR is set.
+	 */
+	if (backtrace_spinlocks && in_lock_functions(pc) &&
+			in_lock_functions(profile_pc))
+		return regs->link;
+	else
+		return profile_pc;
+}
+
+/*
+ * On GQ and newer the MMCRA stores the HV and PR bits at the time
+ * the SIAR was sampled. We use that to work out if the SIAR was sampled in
+ * the hypervisor, our exception vectors or RTAS.
+ */
+static unsigned long get_pc(struct pt_regs *regs)
+{
+	unsigned long pc = mfspr(SPRN_SIAR);
+	unsigned long mmcra;
+
+	/* Cant do much about it */
+	if (!mmcra_has_sihv)
+		return check_spinlock_pc(regs, pc);
+
+	mmcra = mfspr(SPRN_MMCRA);
+
+	/* Were we in the hypervisor? */
+	if ((systemcfg->platform == PLATFORM_PSERIES_LPAR) &&
+	    (mmcra & MMCRA_SIHV))
+		/* function descriptor madness */
+		return *((unsigned long *)hypervisor_bucket);
+
+	/* We were in userspace, nothing to do */
+	if (mmcra & MMCRA_SIPR)
+		return pc;
+
+#ifdef CONFIG_PPC_RTAS
+	/* Were we in RTAS? */
+	if (pc >= rtas.base && pc < (rtas.base + rtas.size))
+		/* function descriptor madness */
+		return *((unsigned long *)rtas_bucket);
+#endif
+
+	/* Were we in our exception vectors or SLB real mode miss handler? */
+	if (pc < 0x1000000UL)
+		return (unsigned long)__va(pc);
+
+	/* Not sure where we were */
+	if (pc < KERNELBASE)
+		/* function descriptor madness */
+		return *((unsigned long *)kernel_unknown_bucket);
+
+	return check_spinlock_pc(regs, pc);
+}
+
+static int get_kernel(unsigned long pc)
+{
+	int is_kernel;
+
+	if (!mmcra_has_sihv) {
+		is_kernel = (pc >= KERNELBASE);
+	} else {
+		unsigned long mmcra = mfspr(SPRN_MMCRA);
+		is_kernel = ((mmcra & MMCRA_SIPR) == 0);
+	}
+
+	return is_kernel;
+}
+
+static void power4_handle_interrupt(struct pt_regs *regs,
+				    struct op_counter_config *ctr)
+{
+	unsigned long pc;
+	int is_kernel;
+	int val;
+	int i;
+	unsigned int mmcr0;
+
+	pc = get_pc(regs);
+	is_kernel = get_kernel(pc);
+
+	/* set the PMM bit (see comment below) */
+	mtmsrd(mfmsr() | MSR_PMM);
+
+	for (i = 0; i < cur_cpu_spec->num_pmcs; ++i) {
+		val = ctr_read(i);
+		if (val < 0) {
+			if (oprofile_running && ctr[i].enabled) {
+				oprofile_add_pc(pc, is_kernel, i);
+				ctr_write(i, reset_value[i]);
+			} else {
+				ctr_write(i, 0);
+			}
+		}
+	}
+
+	mmcr0 = mfspr(SPRN_MMCR0);
+
+	/* reset the perfmon trigger */
+	mmcr0 |= MMCR0_PMXE;
+
+	/*
+	 * We must clear the PMAO bit on some (GQ) chips. Just do it
+	 * all the time
+	 */
+	mmcr0 &= ~MMCR0_PMAO;
+
+	/*
+	 * now clear the freeze bit, counting will not start until we
+	 * rfid from this exception, because only at that point will
+	 * the PMM bit be cleared
+	 */
+	mmcr0 &= ~MMCR0_FC;
+	mtspr(SPRN_MMCR0, mmcr0);
+}
+
+struct op_powerpc_model op_model_power4 = {
+	.reg_setup		= power4_reg_setup,
+	.cpu_setup		= power4_cpu_setup,
+	.start			= power4_start,
+	.stop			= power4_stop,
+	.handle_interrupt	= power4_handle_interrupt,
+};
diff --git a/arch/powerpc/oprofile/op_model_rs64.c b/arch/powerpc/oprofile/op_model_rs64.c
new file mode 100644
--- /dev/null
+++ b/arch/powerpc/oprofile/op_model_rs64.c
@@ -0,0 +1,218 @@
+/*
+ * Copyright (C) 2004 Anton Blanchard <anton@au.ibm.com>, IBM
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version
+ * 2 of the License, or (at your option) any later version.
+ */
+
+#include <linux/oprofile.h>
+#include <linux/init.h>
+#include <linux/smp.h>
+#include <asm/ptrace.h>
+#include <asm/system.h>
+#include <asm/processor.h>
+#include <asm/cputable.h>
+#include <asm/oprofile_impl.h>
+
+#define dbg(args...)
+
+static void ctrl_write(unsigned int i, unsigned int val)
+{
+	unsigned int tmp = 0;
+	unsigned long shift = 0, mask = 0;
+
+	dbg("ctrl_write %d %x\n", i, val);
+
+	switch(i) {
+	case 0:
+		tmp = mfspr(SPRN_MMCR0);
+		shift = 6;
+		mask = 0x7F;
+		break;
+	case 1:
+		tmp = mfspr(SPRN_MMCR0);
+		shift = 0;
+		mask = 0x3F;
+		break;
+	case 2:
+		tmp = mfspr(SPRN_MMCR1);
+		shift = 31 - 4;
+		mask = 0x1F;
+		break;
+	case 3:
+		tmp = mfspr(SPRN_MMCR1);
+		shift = 31 - 9;
+		mask = 0x1F;
+		break;
+	case 4:
+		tmp = mfspr(SPRN_MMCR1);
+		shift = 31 - 14;
+		mask = 0x1F;
+		break;
+	case 5:
+		tmp = mfspr(SPRN_MMCR1);
+		shift = 31 - 19;
+		mask = 0x1F;
+		break;
+	case 6:
+		tmp = mfspr(SPRN_MMCR1);
+		shift = 31 - 24;
+		mask = 0x1F;
+		break;
+	case 7:
+		tmp = mfspr(SPRN_MMCR1);
+		shift = 31 - 28;
+		mask = 0xF;
+		break;
+	}
+
+	tmp = tmp & ~(mask << shift);
+	tmp |= val << shift;
+
+	switch(i) {
+		case 0:
+		case 1:
+			mtspr(SPRN_MMCR0, tmp);
+			break;
+		default:
+			mtspr(SPRN_MMCR1, tmp);
+	}
+
+	dbg("ctrl_write mmcr0 %lx mmcr1 %lx\n", mfspr(SPRN_MMCR0),
+	       mfspr(SPRN_MMCR1));
+}
+
+static unsigned long reset_value[OP_MAX_COUNTER];
+
+static int num_counters;
+
+static void rs64_reg_setup(struct op_counter_config *ctr,
+			   struct op_system_config *sys,
+			   int num_ctrs)
+{
+	int i;
+
+	num_counters = num_ctrs;
+
+	for (i = 0; i < num_counters; ++i)
+		reset_value[i] = 0x80000000UL - ctr[i].count;
+
+	/* XXX setup user and kernel profiling */
+}
+
+static void rs64_cpu_setup(void *unused)
+{
+	unsigned int mmcr0;
+
+	/* reset MMCR0 and set the freeze bit */
+	mmcr0 = MMCR0_FC;
+	mtspr(SPRN_MMCR0, mmcr0);
+
+	/* reset MMCR1, MMCRA */
+	mtspr(SPRN_MMCR1, 0);
+
+	if (cpu_has_feature(CPU_FTR_MMCRA))
+		mtspr(SPRN_MMCRA, 0);
+
+	mmcr0 |= MMCR0_FCM1|MMCR0_PMXE|MMCR0_FCECE;
+	/* Only applies to POWER3, but should be safe on RS64 */
+	mmcr0 |= MMCR0_PMC1CE|MMCR0_PMCjCE;
+	mtspr(SPRN_MMCR0, mmcr0);
+
+	dbg("setup on cpu %d, mmcr0 %lx\n", smp_processor_id(),
+	    mfspr(SPRN_MMCR0));
+	dbg("setup on cpu %d, mmcr1 %lx\n", smp_processor_id(),
+	    mfspr(SPRN_MMCR1));
+}
+
+static void rs64_start(struct op_counter_config *ctr)
+{
+	int i;
+	unsigned int mmcr0;
+
+	/* set the PMM bit (see comment below) */
+	mtmsrd(mfmsr() | MSR_PMM);
+
+	for (i = 0; i < num_counters; ++i) {
+		if (ctr[i].enabled) {
+			ctr_write(i, reset_value[i]);
+			ctrl_write(i, ctr[i].event);
+		} else {
+			ctr_write(i, 0);
+		}
+	}
+
+	mmcr0 = mfspr(SPRN_MMCR0);
+
+	/*
+	 * now clear the freeze bit, counting will not start until we
+	 * rfid from this excetion, because only at that point will
+	 * the PMM bit be cleared
+	 */
+	mmcr0 &= ~MMCR0_FC;
+	mtspr(SPRN_MMCR0, mmcr0);
+
+	dbg("start on cpu %d, mmcr0 %x\n", smp_processor_id(), mmcr0);
+}
+
+static void rs64_stop(void)
+{
+	unsigned int mmcr0;
+
+	/* freeze counters */
+	mmcr0 = mfspr(SPRN_MMCR0);
+	mmcr0 |= MMCR0_FC;
+	mtspr(SPRN_MMCR0, mmcr0);
+
+	dbg("stop on cpu %d, mmcr0 %x\n", smp_processor_id(), mmcr0);
+
+	mb();
+}
+
+static void rs64_handle_interrupt(struct pt_regs *regs,
+				  struct op_counter_config *ctr)
+{
+	unsigned int mmcr0;
+	int val;
+	int i;
+	unsigned long pc = mfspr(SPRN_SIAR);
+	int is_kernel = (pc >= KERNELBASE);
+
+	/* set the PMM bit (see comment below) */
+	mtmsrd(mfmsr() | MSR_PMM);
+
+	for (i = 0; i < num_counters; ++i) {
+		val = ctr_read(i);
+		if (val < 0) {
+			if (ctr[i].enabled) {
+				oprofile_add_pc(pc, is_kernel, i);
+				ctr_write(i, reset_value[i]);
+			} else {
+				ctr_write(i, 0);
+			}
+		}
+	}
+
+	mmcr0 = mfspr(SPRN_MMCR0);
+
+	/* reset the perfmon trigger */
+	mmcr0 |= MMCR0_PMXE;
+
+	/*
+	 * now clear the freeze bit, counting will not start until we
+	 * rfid from this exception, because only at that point will
+	 * the PMM bit be cleared
+	 */
+	mmcr0 &= ~MMCR0_FC;
+	mtspr(SPRN_MMCR0, mmcr0);
+}
+
+struct op_powerpc_model op_model_rs64 = {
+	.reg_setup		= rs64_reg_setup,
+	.cpu_setup		= rs64_cpu_setup,
+	.start			= rs64_start,
+	.stop			= rs64_stop,
+	.handle_interrupt	= rs64_handle_interrupt,
+};
diff --git a/arch/ppc/Makefile b/arch/ppc/Makefile
--- a/arch/ppc/Makefile
+++ b/arch/ppc/Makefile
@@ -71,7 +71,7 @@ drivers-$(CONFIG_8xx)		+= arch/ppc/8xx_i
 drivers-$(CONFIG_4xx)		+= arch/ppc/4xx_io/
 drivers-$(CONFIG_CPM2)		+= arch/ppc/8260_io/
 
-drivers-$(CONFIG_OPROFILE)	+= arch/ppc/oprofile/
+drivers-$(CONFIG_OPROFILE)	+= arch/powerpc/oprofile/
 
 BOOT_TARGETS = zImage zImage.initrd znetboot znetboot.initrd vmlinux.sm
 
diff --git a/arch/ppc/oprofile/Makefile b/arch/ppc/oprofile/Makefile
deleted file mode 100644
--- a/arch/ppc/oprofile/Makefile
+++ /dev/null
@@ -1 +0,0 @@
-include arch/powerpc/oprofile/Makefile
diff --git a/arch/ppc/oprofile/common.c b/arch/ppc/oprofile/common.c
deleted file mode 100644
--- a/arch/ppc/oprofile/common.c
+++ /dev/null
@@ -1,160 +0,0 @@
-/*
- * PPC 32 oprofile support
- * Based on PPC64 oprofile support
- * Copyright (C) 2004 Anton Blanchard <anton@au.ibm.com>, IBM
- *
- * Copyright (C) Freescale Semiconductor, Inc 2004
- *
- * Author: Andy Fleming
- *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of the GNU General Public License
- * as published by the Free Software Foundation; either version
- * 2 of the License, or (at your option) any later version.
- */
-
-#include <linux/oprofile.h>
-#include <linux/slab.h>
-#include <linux/init.h>
-#include <linux/smp.h>
-#include <linux/errno.h>
-#include <asm/ptrace.h>
-#include <asm/system.h>
-#include <asm/perfmon.h>
-#include <asm/cputable.h>
-#include <asm/oprofile_impl.h>
-
-static struct op_powerpc_model *model;
-
-static struct op_counter_config ctr[OP_MAX_COUNTER];
-static struct op_system_config sys;
-
-static void op_handle_interrupt(struct pt_regs *regs)
-{
-	model->handle_interrupt(regs, ctr);
-}
-
-static int op_ppc32_setup(void)
-{
-	/* Install our interrupt handler into the existing hook.  */
-	if(request_perfmon_irq(&op_handle_interrupt))
-		return -EBUSY;
-
-	mb();
-
-	/* Pre-compute the values to stuff in the hardware registers.  */
-	model->reg_setup(ctr, &sys, model->num_counters);
-
-#if 0
-	/* FIXME: Make multi-cpu work */
-	/* Configure the registers on all cpus.  */
-	on_each_cpu(model->reg_setup, NULL, 0, 1);
-#endif
-
-	return 0;
-}
-
-static void op_ppc32_shutdown(void)
-{
-	mb();
-
-	/* Remove our interrupt handler. We may be removing this module. */
-	free_perfmon_irq();
-}
-
-static void op_ppc32_cpu_start(void *dummy)
-{
-	model->start(ctr);
-}
-
-static int op_ppc32_start(void)
-{
-	on_each_cpu(op_ppc32_cpu_start, NULL, 0, 1);
-	return 0;
-}
-
-static inline void op_ppc32_cpu_stop(void *dummy)
-{
-	model->stop();
-}
-
-static void op_ppc32_stop(void)
-{
-	on_each_cpu(op_ppc32_cpu_stop, NULL, 0, 1);
-}
-
-static int op_ppc32_create_files(struct super_block *sb, struct dentry *root)
-{
-	int i;
-
-	for (i = 0; i < model->num_counters; ++i) {
-		struct dentry *dir;
-		char buf[3];
-
-		snprintf(buf, sizeof buf, "%d", i);
-		dir = oprofilefs_mkdir(sb, root, buf);
-
-		oprofilefs_create_ulong(sb, dir, "enabled", &ctr[i].enabled);
-		oprofilefs_create_ulong(sb, dir, "event", &ctr[i].event);
-		oprofilefs_create_ulong(sb, dir, "count", &ctr[i].count);
-		oprofilefs_create_ulong(sb, dir, "kernel", &ctr[i].kernel);
-		oprofilefs_create_ulong(sb, dir, "user", &ctr[i].user);
-
-		/* FIXME: Not sure if this is used */
-		oprofilefs_create_ulong(sb, dir, "unit_mask", &ctr[i].unit_mask);
-	}
-
-	oprofilefs_create_ulong(sb, root, "enable_kernel", &sys.enable_kernel);
-	oprofilefs_create_ulong(sb, root, "enable_user", &sys.enable_user);
-
-	/* Default to tracing both kernel and user */
-	sys.enable_kernel = 1;
-	sys.enable_user = 1;
-
-	return 0;
-}
-
-static struct oprofile_operations oprof_ppc32_ops = {
-	.create_files	= op_ppc32_create_files,
-	.setup		= op_ppc32_setup,
-	.shutdown	= op_ppc32_shutdown,
-	.start		= op_ppc32_start,
-	.stop		= op_ppc32_stop,
-	.cpu_type	= NULL		/* To be filled in below. */
-};
-
-int __init oprofile_arch_init(struct oprofile_operations *ops)
-{
-	char *name;
-	int cpu_id = smp_processor_id();
-
-#ifdef CONFIG_FSL_BOOKE
-	model = &op_model_fsl_booke;
-#else
-	return -ENODEV;
-#endif
-
-	name = kmalloc(32, GFP_KERNEL);
-
-	if (NULL == name)
-		return -ENOMEM;
-
-	sprintf(name, "ppc/%s", cur_cpu_spec[cpu_id]->cpu_name);
-
-	oprof_ppc32_ops.cpu_type = name;
-
-	model->num_counters = cur_cpu_spec[cpu_id]->num_pmcs;
-
-	*ops = oprof_ppc32_ops;
-
-	printk(KERN_INFO "oprofile: using %s performance monitoring.\n",
-	       oprof_ppc32_ops.cpu_type);
-
-	return 0;
-}
-
-void oprofile_arch_exit(void)
-{
-	kfree(oprof_ppc32_ops.cpu_type);
-	oprof_ppc32_ops.cpu_type = NULL;
-}
diff --git a/arch/ppc/oprofile/op_model_fsl_booke.c b/arch/ppc/oprofile/op_model_fsl_booke.c
deleted file mode 100644
--- a/arch/ppc/oprofile/op_model_fsl_booke.c
+++ /dev/null
@@ -1,183 +0,0 @@
-/*
- * oprofile/op_model_e500.c
- *
- * Freescale Book-E oprofile support, based on ppc64 oprofile support
- * Copyright (C) 2004 Anton Blanchard <anton@au.ibm.com>, IBM
- *
- * Copyright (c) 2004 Freescale Semiconductor, Inc
- *
- * Author: Andy Fleming
- * Maintainer: Kumar Gala <Kumar.Gala@freescale.com>
- *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of the GNU General Public License
- * as published by the Free Software Foundation; either version
- * 2 of the License, or (at your option) any later version.
- */
-
-#include <linux/oprofile.h>
-#include <linux/init.h>
-#include <linux/smp.h>
-#include <asm/ptrace.h>
-#include <asm/system.h>
-#include <asm/processor.h>
-#include <asm/cputable.h>
-#include <asm/reg_booke.h>
-#include <asm/page.h>
-#include <asm/perfmon.h>
-#include <asm/oprofile_impl.h>
-
-static unsigned long reset_value[OP_MAX_COUNTER];
-
-static int num_counters;
-static int oprofile_running;
-
-static inline unsigned int ctr_read(unsigned int i)
-{
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
-
-static inline void ctr_write(unsigned int i, unsigned int val)
-{
-	switch(i) {
-		case 0:
-			mtpmr(PMRN_PMC0, val);
-			break;
-		case 1:
-			mtpmr(PMRN_PMC1, val);
-			break;
-		case 2:
-			mtpmr(PMRN_PMC2, val);
-			break;
-		case 3:
-			mtpmr(PMRN_PMC3, val);
-			break;
-		default:
-			break;
-	}
-}
-
-
-static void fsl_booke_reg_setup(struct op_counter_config *ctr,
-			     struct op_system_config *sys,
-			     int num_ctrs)
-{
-	int i;
-
-	num_counters = num_ctrs;
-
-	/* freeze all counters */
-	pmc_stop_ctrs();
-
-	/* Our counters count up, and "count" refers to
-	 * how much before the next interrupt, and we interrupt
-	 * on overflow.  So we calculate the starting value
-	 * which will give us "count" until overflow.
-	 * Then we set the events on the enabled counters */
-	for (i = 0; i < num_counters; ++i) {
-		reset_value[i] = 0x80000000UL - ctr[i].count;
-
-		init_pmc_stop(i);
-
-		set_pmc_event(i, ctr[i].event);
-
-		set_pmc_user_kernel(i, ctr[i].user, ctr[i].kernel);
-	}
-}
-
-static void fsl_booke_start(struct op_counter_config *ctr)
-{
-	int i;
-
-	mtmsr(mfmsr() | MSR_PMM);
-
-	for (i = 0; i < num_counters; ++i) {
-		if (ctr[i].enabled) {
-			ctr_write(i, reset_value[i]);
-			/* Set Each enabled counterd to only
-			 * count when the Mark bit is not set */
-			set_pmc_marked(i, 1, 0);
-			pmc_start_ctr(i, 1);
-		} else {
-			ctr_write(i, 0);
-
-			/* Set the ctr to be stopped */
-			pmc_start_ctr(i, 0);
-		}
-	}
-
-	/* Clear the freeze bit, and enable the interrupt.
-	 * The counters won't actually start until the rfi clears
-	 * the PMM bit */
-	pmc_start_ctrs(1);
-
-	oprofile_running = 1;
-
-	pr_debug("start on cpu %d, pmgc0 %x\n", smp_processor_id(),
-			mfpmr(PMRN_PMGC0));
-}
-
-static void fsl_booke_stop(void)
-{
-	/* freeze counters */
-	pmc_stop_ctrs();
-
-	oprofile_running = 0;
-
-	pr_debug("stop on cpu %d, pmgc0 %x\n", smp_processor_id(),
-			mfpmr(PMRN_PMGC0));
-
-	mb();
-}
-
-
-static void fsl_booke_handle_interrupt(struct pt_regs *regs,
-				    struct op_counter_config *ctr)
-{
-	unsigned long pc;
-	int is_kernel;
-	int val;
-	int i;
-
-	/* set the PMM bit (see comment below) */
-	mtmsr(mfmsr() | MSR_PMM);
-
-	pc = regs->nip;
-	is_kernel = (pc >= KERNELBASE);
-
-	for (i = 0; i < num_counters; ++i) {
-		val = ctr_read(i);
-		if (val < 0) {
-			if (oprofile_running && ctr[i].enabled) {
-				oprofile_add_pc(pc, is_kernel, i);
-				ctr_write(i, reset_value[i]);
-			} else {
-				ctr_write(i, 0);
-			}
-		}
-	}
-
-	/* The freeze bit was set by the interrupt. */
-	/* Clear the freeze bit, and reenable the interrupt.
-	 * The counters won't actually start until the rfi clears
-	 * the PMM bit */
-	pmc_start_ctrs(1);
-}
-
-struct op_powerpc_model op_model_fsl_booke = {
-	.reg_setup		= fsl_booke_reg_setup,
-	.start			= fsl_booke_start,
-	.stop			= fsl_booke_stop,
-	.handle_interrupt	= fsl_booke_handle_interrupt,
-};
diff --git a/arch/ppc64/Makefile b/arch/ppc64/Makefile
--- a/arch/ppc64/Makefile
+++ b/arch/ppc64/Makefile
@@ -85,7 +85,7 @@ libs-y				+= arch/ppc64/lib/
 core-y				+= arch/ppc64/kernel/
 core-y				+= arch/ppc64/mm/
 core-$(CONFIG_XMON)		+= arch/ppc64/xmon/
-drivers-$(CONFIG_OPROFILE)	+= arch/ppc64/oprofile/
+drivers-$(CONFIG_OPROFILE)	+= arch/powerpc/oprofile/
 
 boot := arch/ppc64/boot
 
diff --git a/arch/ppc64/oprofile/Makefile b/arch/ppc64/oprofile/Makefile
deleted file mode 100644
--- a/arch/ppc64/oprofile/Makefile
+++ /dev/null
@@ -1 +0,0 @@
-include arch/powerpc/oprofile/Makefile
diff --git a/arch/ppc64/oprofile/common.c b/arch/ppc64/oprofile/common.c
deleted file mode 100644
--- a/arch/ppc64/oprofile/common.c
+++ /dev/null
@@ -1,145 +0,0 @@
-/*
- * Copyright (C) 2004 Anton Blanchard <anton@au.ibm.com>, IBM
- *
- * Based on alpha version.
- *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of the GNU General Public License
- * as published by the Free Software Foundation; either version
- * 2 of the License, or (at your option) any later version.
- */
-
-#include <linux/oprofile.h>
-#include <linux/init.h>
-#include <linux/smp.h>
-#include <linux/errno.h>
-#include <asm/ptrace.h>
-#include <asm/system.h>
-#include <asm/pmc.h>
-#include <asm/cputable.h>
-#include <asm/oprofile_impl.h>
-
-static struct op_powerpc_model *model;
-
-static struct op_counter_config ctr[OP_MAX_COUNTER];
-static struct op_system_config sys;
-
-static void op_handle_interrupt(struct pt_regs *regs)
-{
-	model->handle_interrupt(regs, ctr);
-}
-
-static int op_ppc64_setup(void)
-{
-	int err;
-
-	/* Grab the hardware */
-	err = reserve_pmc_hardware(op_handle_interrupt);
-	if (err)
-		return err;
-
-	/* Pre-compute the values to stuff in the hardware registers.  */
-	model->reg_setup(ctr, &sys, model->num_counters);
-
-	/* Configure the registers on all cpus.  */
-	on_each_cpu(model->cpu_setup, NULL, 0, 1);
-
-	return 0;
-}
-
-static void op_ppc64_shutdown(void)
-{
-	release_pmc_hardware();
-}
-
-static void op_ppc64_cpu_start(void *dummy)
-{
-	model->start(ctr);
-}
-
-static int op_ppc64_start(void)
-{
-	on_each_cpu(op_ppc64_cpu_start, NULL, 0, 1);
-	return 0;
-}
-
-static inline void op_ppc64_cpu_stop(void *dummy)
-{
-	model->stop();
-}
-
-static void op_ppc64_stop(void)
-{
-	on_each_cpu(op_ppc64_cpu_stop, NULL, 0, 1);
-}
-
-static int op_ppc64_create_files(struct super_block *sb, struct dentry *root)
-{
-	int i;
-
-	/*
-	 * There is one mmcr0, mmcr1 and mmcra for setting the events for
-	 * all of the counters.
-	 */
-	oprofilefs_create_ulong(sb, root, "mmcr0", &sys.mmcr0);
-	oprofilefs_create_ulong(sb, root, "mmcr1", &sys.mmcr1);
-	oprofilefs_create_ulong(sb, root, "mmcra", &sys.mmcra);
-
-	for (i = 0; i < model->num_counters; ++i) {
-		struct dentry *dir;
-		char buf[3];
-
-		snprintf(buf, sizeof buf, "%d", i);
-		dir = oprofilefs_mkdir(sb, root, buf);
-
-		oprofilefs_create_ulong(sb, dir, "enabled", &ctr[i].enabled);
-		oprofilefs_create_ulong(sb, dir, "event", &ctr[i].event);
-		oprofilefs_create_ulong(sb, dir, "count", &ctr[i].count);
-		/*
-		 * We dont support per counter user/kernel selection, but
-		 * we leave the entries because userspace expects them
-		 */
-		oprofilefs_create_ulong(sb, dir, "kernel", &ctr[i].kernel);
-		oprofilefs_create_ulong(sb, dir, "user", &ctr[i].user);
-		oprofilefs_create_ulong(sb, dir, "unit_mask", &ctr[i].unit_mask);
-	}
-
-	oprofilefs_create_ulong(sb, root, "enable_kernel", &sys.enable_kernel);
-	oprofilefs_create_ulong(sb, root, "enable_user", &sys.enable_user);
-	oprofilefs_create_ulong(sb, root, "backtrace_spinlocks",
-				&sys.backtrace_spinlocks);
-
-	/* Default to tracing both kernel and user */
-	sys.enable_kernel = 1;
-	sys.enable_user = 1;
-
-	/* Turn on backtracing through spinlocks by default */
-	sys.backtrace_spinlocks = 1;
-
-	return 0;
-}
-
-int __init oprofile_arch_init(struct oprofile_operations *ops)
-{
-	if (!cur_cpu_spec->oprofile_model || !cur_cpu_spec->oprofile_cpu_type)
-		return -ENODEV;
-
-	model = cur_cpu_spec->oprofile_model;
-	model->num_counters = cur_cpu_spec->num_pmcs;
-
-	ops->cpu_type = cur_cpu_spec->oprofile_cpu_type;
-	ops->create_files = op_ppc64_create_files;
-	ops->setup = op_ppc64_setup;
-	ops->shutdown = op_ppc64_shutdown;
-	ops->start = op_ppc64_start;
-	ops->stop = op_ppc64_stop;
-
-	printk(KERN_INFO "oprofile: using %s performance monitoring.\n",
-	       ops->cpu_type);
-
-	return 0;
-}
-
-void oprofile_arch_exit(void)
-{
-}
diff --git a/arch/ppc64/oprofile/op_model_power4.c b/arch/ppc64/oprofile/op_model_power4.c
deleted file mode 100644
--- a/arch/ppc64/oprofile/op_model_power4.c
+++ /dev/null
@@ -1,309 +0,0 @@
-/*
- * Copyright (C) 2004 Anton Blanchard <anton@au.ibm.com>, IBM
- *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of the GNU General Public License
- * as published by the Free Software Foundation; either version
- * 2 of the License, or (at your option) any later version.
- */
-
-#include <linux/oprofile.h>
-#include <linux/init.h>
-#include <linux/smp.h>
-#include <asm/ptrace.h>
-#include <asm/system.h>
-#include <asm/processor.h>
-#include <asm/cputable.h>
-#include <asm/systemcfg.h>
-#include <asm/rtas.h>
-#include <asm/oprofile_impl.h>
-
-#define dbg(args...)
-
-static unsigned long reset_value[OP_MAX_COUNTER];
-
-static int oprofile_running;
-static int mmcra_has_sihv;
-
-/* mmcr values are set in power4_reg_setup, used in power4_cpu_setup */
-static u32 mmcr0_val;
-static u64 mmcr1_val;
-static u32 mmcra_val;
-
-/*
- * Since we do not have an NMI, backtracing through spinlocks is
- * only a best guess. In light of this, allow it to be disabled at
- * runtime.
- */
-static int backtrace_spinlocks;
-
-static void power4_reg_setup(struct op_counter_config *ctr,
-			     struct op_system_config *sys,
-			     int num_ctrs)
-{
-	int i;
-
-	/*
-	 * SIHV / SIPR bits are only implemented on POWER4+ (GQ) and above.
-	 * However we disable it on all POWER4 until we verify it works
-	 * (I was seeing some strange behaviour last time I tried).
-	 *
-	 * It has been verified to work on POWER5 so we enable it there.
-	 */
-	if (cpu_has_feature(CPU_FTR_MMCRA_SIHV))
-		mmcra_has_sihv = 1;
-
-	/*
-	 * The performance counter event settings are given in the mmcr0,
-	 * mmcr1 and mmcra values passed from the user in the
-	 * op_system_config structure (sys variable).
-	 */
-	mmcr0_val = sys->mmcr0;
-	mmcr1_val = sys->mmcr1;
-	mmcra_val = sys->mmcra;
-
-	backtrace_spinlocks = sys->backtrace_spinlocks;
-
-	for (i = 0; i < cur_cpu_spec->num_pmcs; ++i)
-		reset_value[i] = 0x80000000UL - ctr[i].count;
-
-	/* setup user and kernel profiling */
-	if (sys->enable_kernel)
-		mmcr0_val &= ~MMCR0_KERNEL_DISABLE;
-	else
-		mmcr0_val |= MMCR0_KERNEL_DISABLE;
-
-	if (sys->enable_user)
-		mmcr0_val &= ~MMCR0_PROBLEM_DISABLE;
-	else
-		mmcr0_val |= MMCR0_PROBLEM_DISABLE;
-}
-
-extern void ppc64_enable_pmcs(void);
-
-static void power4_cpu_setup(void *unused)
-{
-	unsigned int mmcr0 = mmcr0_val;
-	unsigned long mmcra = mmcra_val;
-
-	ppc64_enable_pmcs();
-
-	/* set the freeze bit */
-	mmcr0 |= MMCR0_FC;
-	mtspr(SPRN_MMCR0, mmcr0);
-
-	mmcr0 |= MMCR0_FCM1|MMCR0_PMXE|MMCR0_FCECE;
-	mmcr0 |= MMCR0_PMC1CE|MMCR0_PMCjCE;
-	mtspr(SPRN_MMCR0, mmcr0);
-
-	mtspr(SPRN_MMCR1, mmcr1_val);
-
-	mmcra |= MMCRA_SAMPLE_ENABLE;
-	mtspr(SPRN_MMCRA, mmcra);
-
-	dbg("setup on cpu %d, mmcr0 %lx\n", smp_processor_id(),
-	    mfspr(SPRN_MMCR0));
-	dbg("setup on cpu %d, mmcr1 %lx\n", smp_processor_id(),
-	    mfspr(SPRN_MMCR1));
-	dbg("setup on cpu %d, mmcra %lx\n", smp_processor_id(),
-	    mfspr(SPRN_MMCRA));
-}
-
-static void power4_start(struct op_counter_config *ctr)
-{
-	int i;
-	unsigned int mmcr0;
-
-	/* set the PMM bit (see comment below) */
-	mtmsrd(mfmsr() | MSR_PMM);
-
-	for (i = 0; i < cur_cpu_spec->num_pmcs; ++i) {
-		if (ctr[i].enabled) {
-			ctr_write(i, reset_value[i]);
-		} else {
-			ctr_write(i, 0);
-		}
-	}
-
-	mmcr0 = mfspr(SPRN_MMCR0);
-
-	/*
-	 * We must clear the PMAO bit on some (GQ) chips. Just do it
-	 * all the time
-	 */
-	mmcr0 &= ~MMCR0_PMAO;
-
-	/*
-	 * now clear the freeze bit, counting will not start until we
-	 * rfid from this excetion, because only at that point will
-	 * the PMM bit be cleared
-	 */
-	mmcr0 &= ~MMCR0_FC;
-	mtspr(SPRN_MMCR0, mmcr0);
-
-	oprofile_running = 1;
-
-	dbg("start on cpu %d, mmcr0 %x\n", smp_processor_id(), mmcr0);
-}
-
-static void power4_stop(void)
-{
-	unsigned int mmcr0;
-
-	/* freeze counters */
-	mmcr0 = mfspr(SPRN_MMCR0);
-	mmcr0 |= MMCR0_FC;
-	mtspr(SPRN_MMCR0, mmcr0);
-
-	oprofile_running = 0;
-
-	dbg("stop on cpu %d, mmcr0 %x\n", smp_processor_id(), mmcr0);
-
-	mb();
-}
-
-/* Fake functions used by canonicalize_pc */
-static void __attribute_used__ hypervisor_bucket(void)
-{
-}
-
-static void __attribute_used__ rtas_bucket(void)
-{
-}
-
-static void __attribute_used__ kernel_unknown_bucket(void)
-{
-}
-
-static unsigned long check_spinlock_pc(struct pt_regs *regs,
-				       unsigned long profile_pc)
-{
-	unsigned long pc = instruction_pointer(regs);
-
-	/*
-	 * If both the SIAR (sampled instruction) and the perfmon exception
-	 * occurred in a spinlock region then we account the sample to the
-	 * calling function. This isnt 100% correct, we really need soft
-	 * IRQ disable so we always get the perfmon exception at the
-	 * point at which the SIAR is set.
-	 */
-	if (backtrace_spinlocks && in_lock_functions(pc) &&
-			in_lock_functions(profile_pc))
-		return regs->link;
-	else
-		return profile_pc;
-}
-
-/*
- * On GQ and newer the MMCRA stores the HV and PR bits at the time
- * the SIAR was sampled. We use that to work out if the SIAR was sampled in
- * the hypervisor, our exception vectors or RTAS.
- */
-static unsigned long get_pc(struct pt_regs *regs)
-{
-	unsigned long pc = mfspr(SPRN_SIAR);
-	unsigned long mmcra;
-
-	/* Cant do much about it */
-	if (!mmcra_has_sihv)
-		return check_spinlock_pc(regs, pc);
-
-	mmcra = mfspr(SPRN_MMCRA);
-
-	/* Were we in the hypervisor? */
-	if ((systemcfg->platform == PLATFORM_PSERIES_LPAR) &&
-	    (mmcra & MMCRA_SIHV))
-		/* function descriptor madness */
-		return *((unsigned long *)hypervisor_bucket);
-
-	/* We were in userspace, nothing to do */
-	if (mmcra & MMCRA_SIPR)
-		return pc;
-
-#ifdef CONFIG_PPC_RTAS
-	/* Were we in RTAS? */
-	if (pc >= rtas.base && pc < (rtas.base + rtas.size))
-		/* function descriptor madness */
-		return *((unsigned long *)rtas_bucket);
-#endif
-
-	/* Were we in our exception vectors or SLB real mode miss handler? */
-	if (pc < 0x1000000UL)
-		return (unsigned long)__va(pc);
-
-	/* Not sure where we were */
-	if (pc < KERNELBASE)
-		/* function descriptor madness */
-		return *((unsigned long *)kernel_unknown_bucket);
-
-	return check_spinlock_pc(regs, pc);
-}
-
-static int get_kernel(unsigned long pc)
-{
-	int is_kernel;
-
-	if (!mmcra_has_sihv) {
-		is_kernel = (pc >= KERNELBASE);
-	} else {
-		unsigned long mmcra = mfspr(SPRN_MMCRA);
-		is_kernel = ((mmcra & MMCRA_SIPR) == 0);
-	}
-
-	return is_kernel;
-}
-
-static void power4_handle_interrupt(struct pt_regs *regs,
-				    struct op_counter_config *ctr)
-{
-	unsigned long pc;
-	int is_kernel;
-	int val;
-	int i;
-	unsigned int mmcr0;
-
-	pc = get_pc(regs);
-	is_kernel = get_kernel(pc);
-
-	/* set the PMM bit (see comment below) */
-	mtmsrd(mfmsr() | MSR_PMM);
-
-	for (i = 0; i < cur_cpu_spec->num_pmcs; ++i) {
-		val = ctr_read(i);
-		if (val < 0) {
-			if (oprofile_running && ctr[i].enabled) {
-				oprofile_add_pc(pc, is_kernel, i);
-				ctr_write(i, reset_value[i]);
-			} else {
-				ctr_write(i, 0);
-			}
-		}
-	}
-
-	mmcr0 = mfspr(SPRN_MMCR0);
-
-	/* reset the perfmon trigger */
-	mmcr0 |= MMCR0_PMXE;
-
-	/*
-	 * We must clear the PMAO bit on some (GQ) chips. Just do it
-	 * all the time
-	 */
-	mmcr0 &= ~MMCR0_PMAO;
-
-	/*
-	 * now clear the freeze bit, counting will not start until we
-	 * rfid from this exception, because only at that point will
-	 * the PMM bit be cleared
-	 */
-	mmcr0 &= ~MMCR0_FC;
-	mtspr(SPRN_MMCR0, mmcr0);
-}
-
-struct op_powerpc_model op_model_power4 = {
-	.reg_setup		= power4_reg_setup,
-	.cpu_setup		= power4_cpu_setup,
-	.start			= power4_start,
-	.stop			= power4_stop,
-	.handle_interrupt	= power4_handle_interrupt,
-};
diff --git a/arch/ppc64/oprofile/op_model_rs64.c b/arch/ppc64/oprofile/op_model_rs64.c
deleted file mode 100644
--- a/arch/ppc64/oprofile/op_model_rs64.c
+++ /dev/null
@@ -1,218 +0,0 @@
-/*
- * Copyright (C) 2004 Anton Blanchard <anton@au.ibm.com>, IBM
- *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of the GNU General Public License
- * as published by the Free Software Foundation; either version
- * 2 of the License, or (at your option) any later version.
- */
-
-#include <linux/oprofile.h>
-#include <linux/init.h>
-#include <linux/smp.h>
-#include <asm/ptrace.h>
-#include <asm/system.h>
-#include <asm/processor.h>
-#include <asm/cputable.h>
-#include <asm/oprofile_impl.h>
-
-#define dbg(args...)
-
-static void ctrl_write(unsigned int i, unsigned int val)
-{
-	unsigned int tmp = 0;
-	unsigned long shift = 0, mask = 0;
-
-	dbg("ctrl_write %d %x\n", i, val);
-
-	switch(i) {
-	case 0:
-		tmp = mfspr(SPRN_MMCR0);
-		shift = 6;
-		mask = 0x7F;
-		break;
-	case 1:
-		tmp = mfspr(SPRN_MMCR0);
-		shift = 0;
-		mask = 0x3F;
-		break;
-	case 2:
-		tmp = mfspr(SPRN_MMCR1);
-		shift = 31 - 4;
-		mask = 0x1F;
-		break;
-	case 3:
-		tmp = mfspr(SPRN_MMCR1);
-		shift = 31 - 9;
-		mask = 0x1F;
-		break;
-	case 4:
-		tmp = mfspr(SPRN_MMCR1);
-		shift = 31 - 14;
-		mask = 0x1F;
-		break;
-	case 5:
-		tmp = mfspr(SPRN_MMCR1);
-		shift = 31 - 19;
-		mask = 0x1F;
-		break;
-	case 6:
-		tmp = mfspr(SPRN_MMCR1);
-		shift = 31 - 24;
-		mask = 0x1F;
-		break;
-	case 7:
-		tmp = mfspr(SPRN_MMCR1);
-		shift = 31 - 28;
-		mask = 0xF;
-		break;
-	}
-
-	tmp = tmp & ~(mask << shift);
-	tmp |= val << shift;
-
-	switch(i) {
-		case 0:
-		case 1:
-			mtspr(SPRN_MMCR0, tmp);
-			break;
-		default:
-			mtspr(SPRN_MMCR1, tmp);
-	}
-
-	dbg("ctrl_write mmcr0 %lx mmcr1 %lx\n", mfspr(SPRN_MMCR0),
-	       mfspr(SPRN_MMCR1));
-}
-
-static unsigned long reset_value[OP_MAX_COUNTER];
-
-static int num_counters;
-
-static void rs64_reg_setup(struct op_counter_config *ctr,
-			   struct op_system_config *sys,
-			   int num_ctrs)
-{
-	int i;
-
-	num_counters = num_ctrs;
-
-	for (i = 0; i < num_counters; ++i)
-		reset_value[i] = 0x80000000UL - ctr[i].count;
-
-	/* XXX setup user and kernel profiling */
-}
-
-static void rs64_cpu_setup(void *unused)
-{
-	unsigned int mmcr0;
-
-	/* reset MMCR0 and set the freeze bit */
-	mmcr0 = MMCR0_FC;
-	mtspr(SPRN_MMCR0, mmcr0);
-
-	/* reset MMCR1, MMCRA */
-	mtspr(SPRN_MMCR1, 0);
-
-	if (cpu_has_feature(CPU_FTR_MMCRA))
-		mtspr(SPRN_MMCRA, 0);
-
-	mmcr0 |= MMCR0_FCM1|MMCR0_PMXE|MMCR0_FCECE;
-	/* Only applies to POWER3, but should be safe on RS64 */
-	mmcr0 |= MMCR0_PMC1CE|MMCR0_PMCjCE;
-	mtspr(SPRN_MMCR0, mmcr0);
-
-	dbg("setup on cpu %d, mmcr0 %lx\n", smp_processor_id(),
-	    mfspr(SPRN_MMCR0));
-	dbg("setup on cpu %d, mmcr1 %lx\n", smp_processor_id(),
-	    mfspr(SPRN_MMCR1));
-}
-
-static void rs64_start(struct op_counter_config *ctr)
-{
-	int i;
-	unsigned int mmcr0;
-
-	/* set the PMM bit (see comment below) */
-	mtmsrd(mfmsr() | MSR_PMM);
-
-	for (i = 0; i < num_counters; ++i) {
-		if (ctr[i].enabled) {
-			ctr_write(i, reset_value[i]);
-			ctrl_write(i, ctr[i].event);
-		} else {
-			ctr_write(i, 0);
-		}
-	}
-
-	mmcr0 = mfspr(SPRN_MMCR0);
-
-	/*
-	 * now clear the freeze bit, counting will not start until we
-	 * rfid from this excetion, because only at that point will
-	 * the PMM bit be cleared
-	 */
-	mmcr0 &= ~MMCR0_FC;
-	mtspr(SPRN_MMCR0, mmcr0);
-
-	dbg("start on cpu %d, mmcr0 %x\n", smp_processor_id(), mmcr0);
-}
-
-static void rs64_stop(void)
-{
-	unsigned int mmcr0;
-
-	/* freeze counters */
-	mmcr0 = mfspr(SPRN_MMCR0);
-	mmcr0 |= MMCR0_FC;
-	mtspr(SPRN_MMCR0, mmcr0);
-
-	dbg("stop on cpu %d, mmcr0 %x\n", smp_processor_id(), mmcr0);
-
-	mb();
-}
-
-static void rs64_handle_interrupt(struct pt_regs *regs,
-				  struct op_counter_config *ctr)
-{
-	unsigned int mmcr0;
-	int val;
-	int i;
-	unsigned long pc = mfspr(SPRN_SIAR);
-	int is_kernel = (pc >= KERNELBASE);
-
-	/* set the PMM bit (see comment below) */
-	mtmsrd(mfmsr() | MSR_PMM);
-
-	for (i = 0; i < num_counters; ++i) {
-		val = ctr_read(i);
-		if (val < 0) {
-			if (ctr[i].enabled) {
-				oprofile_add_pc(pc, is_kernel, i);
-				ctr_write(i, reset_value[i]);
-			} else {
-				ctr_write(i, 0);
-			}
-		}
-	}
-
-	mmcr0 = mfspr(SPRN_MMCR0);
-
-	/* reset the perfmon trigger */
-	mmcr0 |= MMCR0_PMXE;
-
-	/*
-	 * now clear the freeze bit, counting will not start until we
-	 * rfid from this exception, because only at that point will
-	 * the PMM bit be cleared
-	 */
-	mmcr0 &= ~MMCR0_FC;
-	mtspr(SPRN_MMCR0, mmcr0);
-}
-
-struct op_powerpc_model op_model_rs64 = {
-	.reg_setup		= rs64_reg_setup,
-	.cpu_setup		= rs64_cpu_setup,
-	.start			= rs64_start,
-	.stop			= rs64_stop,
-	.handle_interrupt	= rs64_handle_interrupt,
-};

Return-Path: <Geert.Uytterhoeven@sonycom.com>
Received: from pophost.sonytel.be (vervifontaine.sonytel.be [80.88.33.193])
	by ozlabs.org (Postfix) with ESMTP id 84668DDD1C
	for <linuxppc-dev@ozlabs.org>; Fri,  3 Apr 2009 23:08:25 +1100 (EST)
Date: Fri, 3 Apr 2009 14:08:21 +0200 (CEST)
From: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
Sender: geert@sonytel.be
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Kumar Gala <galak@kernel.crashing.org>
Subject: [PATCH] powerpc: Keep track of emulated instructions
Message-ID: <alpine.LRH.2.00.0904031404450.32353@vixen.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-15
Cc: Linux/PPC Development <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

	Hi Ben, Kumar,

Finally (after ca. 1.5 years), he're an updated version of my patch to keep
track of emulated instructions.  In the light of Kumar's `Emulate enough of SPE
instructions to make gcc happy' patch, he probably also wants to keep track of
the actual runtime overhead.

Changes since last version:
  - arch/powerpc/kernel/sysfs.c is now compiled on ppc32, so we can provide
    counters in sysfs on ppc32, too,
  - WARN_EMULATED() is a no-op if CONFIG_SYSCTL is disabled,
  - Add warnings for altivec,
  - Add warnings for recently introduced emulation of vsx and isel
    instructions.

Tested with `mfpvr' on PS3 and AMCC `Sequoia' EV-440EPX.
---
>From 8df6f7d77f28c9a5b82c9512b9dd7688d94d4e33 Mon Sep 17 00:00:00 2001
From: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
Date: Thu, 26 Mar 2009 17:00:12 +0100
Subject: [PATCH] powerpc: Keep track of emulated instructions

Counters for the various classes of emulated instructions are available under
/sys/devices/system/cpu/cpu*/emulated/.
Optionally (controlled by /proc/sys/kernel/cpu_emulation_warnings, if
CONFIG_SYSCTL=y), rate-limited warnings can be printed to the console when
instructions are emulated.

Signed-off-by: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
---
 arch/powerpc/include/asm/emulated_ops.h |   63 +++++++++++++++++++++++++
 arch/powerpc/kernel/align.c             |   18 ++++++--
 arch/powerpc/kernel/sysfs.c             |   78 ++++++++++++++++++++++++++++++-
 arch/powerpc/kernel/traps.c             |   60 +++++++++++++++++++++++-
 4 files changed, 212 insertions(+), 7 deletions(-)
 create mode 100644 arch/powerpc/include/asm/emulated_ops.h

diff --git a/arch/powerpc/include/asm/emulated_ops.h b/arch/powerpc/include/asm/emulated_ops.h
new file mode 100644
index 0000000..e655034
--- /dev/null
+++ b/arch/powerpc/include/asm/emulated_ops.h
@@ -0,0 +1,63 @@
+/*
+ *  Copyright 2007 Sony Corp.
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License as published by
+ *  the Free Software Foundation; version 2 of the License.
+ *
+ *  This program is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *  GNU General Public License for more details.
+ *
+ *  You should have received a copy of the GNU General Public License
+ *  along with this program; if not, write to the Free Software
+ *  Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+ */
+
+#ifndef _ASM_POWERPC_EMULATED_OPS_H
+#define _ASM_POWERPC_EMULATED_OPS_H
+
+#include <linux/percpu.h>
+
+#include <asm/atomic.h>
+
+#ifdef CONFIG_ALTIVEC
+DECLARE_PER_CPU(atomic_long_t, emulated_altivec);
+#endif
+DECLARE_PER_CPU(atomic_long_t, emulated_dcba);
+DECLARE_PER_CPU(atomic_long_t, emulated_dcbz);
+DECLARE_PER_CPU(atomic_long_t, emulated_fp_pair);
+DECLARE_PER_CPU(atomic_long_t, emulated_isel);
+DECLARE_PER_CPU(atomic_long_t, emulated_mcrxr);
+DECLARE_PER_CPU(atomic_long_t, emulated_mfpvr);
+DECLARE_PER_CPU(atomic_long_t, emulated_multiple);
+DECLARE_PER_CPU(atomic_long_t, emulated_popcntb);
+DECLARE_PER_CPU(atomic_long_t, emulated_spe);
+DECLARE_PER_CPU(atomic_long_t, emulated_string);
+#ifdef CONFIG_MATH_EMULATION
+DECLARE_PER_CPU(atomic_long_t, emulated_math);
+#elif defined(CONFIG_8XX_MINIMAL_FPEMU)
+DECLARE_PER_CPU(atomic_long_t, emulated_8xx);
+#endif
+#ifdef CONFIG_VSX
+DECLARE_PER_CPU(atomic_long_t, emulated_vsx);
+#endif
+
+extern void warn_emulated_print(const char *type);
+
+#ifdef CONFIG_SYSCTL
+extern int sysctl_warn_emulated;
+#else
+#define sysctl_warn_emulated		0
+#endif
+
+#define WARN_EMULATED(type)						\
+	do {								\
+		atomic_long_inc(&per_cpu(emulated_ ## type,		\
+					 raw_smp_processor_id()));	\
+		if (sysctl_warn_emulated)				\
+			warn_emulated_print(#type);			\
+	} while (0)
+
+#endif /* _ASM_POWERPC_EMULATED_OPS_H */
diff --git a/arch/powerpc/kernel/align.c b/arch/powerpc/kernel/align.c
index 5ffcfaa..0f3c31b 100644
--- a/arch/powerpc/kernel/align.c
+++ b/arch/powerpc/kernel/align.c
@@ -24,6 +24,7 @@
 #include <asm/system.h>
 #include <asm/cache.h>
 #include <asm/cputable.h>
+#include <asm/emulated_ops.h>
 
 struct aligninfo {
 	unsigned char len;
@@ -730,8 +731,10 @@ int fix_alignment(struct pt_regs *regs)
 	areg = dsisr & 0x1f;		/* register to update */
 
 #ifdef CONFIG_SPE
-	if ((instr >> 26) == 0x4)
+	if ((instr >> 26) == 0x4) {
+		WARN_EMULATED(spe);
 		return emulate_spe(regs, reg, instr);
+	}
 #endif
 
 	instr = (dsisr >> 10) & 0x7f;
@@ -783,23 +786,28 @@ int fix_alignment(struct pt_regs *regs)
 			flags |= SPLT;
 			nb = 8;
 		}
+		WARN_EMULATED(vsx);
 		return emulate_vsx(addr, reg, areg, regs, flags, nb);
 	}
 #endif
 	/* A size of 0 indicates an instruction we don't support, with
 	 * the exception of DCBZ which is handled as a special case here
 	 */
-	if (instr == DCBZ)
+	if (instr == DCBZ) {
+		WARN_EMULATED(dcbz);
 		return emulate_dcbz(regs, addr);
+	}
 	if (unlikely(nb == 0))
 		return 0;
 
 	/* Load/Store Multiple instructions are handled in their own
 	 * function
 	 */
-	if (flags & M)
+	if (flags & M) {
+		WARN_EMULATED(multiple);
 		return emulate_multiple(regs, addr, reg, nb,
 					flags, instr, swiz);
+	}
 
 	/* Verify the address of the operand */
 	if (unlikely(user_mode(regs) &&
@@ -816,8 +824,10 @@ int fix_alignment(struct pt_regs *regs)
 	}
 
 	/* Special case for 16-byte FP loads and stores */
-	if (nb == 16)
+	if (nb == 16) {
+		WARN_EMULATED(fp_pair);
 		return emulate_fp_pair(addr, reg, flags);
+	}
 
 	/* If we are loading, get the data from user space, else
 	 * get it from register values
diff --git a/arch/powerpc/kernel/sysfs.c b/arch/powerpc/kernel/sysfs.c
index f41aec8..344d03f 100644
--- a/arch/powerpc/kernel/sysfs.c
+++ b/arch/powerpc/kernel/sysfs.c
@@ -17,6 +17,7 @@
 #include <asm/prom.h>
 #include <asm/machdep.h>
 #include <asm/smp.h>
+#include <asm/emulated_ops.h>
 
 #include "cacheinfo.h"
 
@@ -322,12 +323,82 @@ static struct sysdev_attribute pa6t_attrs[] = {
 #endif /* HAS_PPC_PMC_PA6T */
 #endif /* HAS_PPC_PMC_CLASSIC */
 
+#define SYSFS_EMULATED_SETUP(type)					\
+DEFINE_PER_CPU(atomic_long_t, emulated_ ## type);			\
+static ssize_t show_emulated_ ## type (struct sys_device *dev,		\
+				       struct sysdev_attribute *attr,	\
+				       char *buf)			\
+{									\
+	struct cpu *cpu = container_of(dev, struct cpu, sysdev);	\
+									\
+	return sprintf(buf, "%lu\n",					\
+		       atomic_long_read(&per_cpu(emulated_ ## type,	\
+					cpu->sysdev.id)));		\
+}									\
+									\
+static struct sysdev_attribute emulated_ ## type ## _attr = {		\
+	.attr = { .name = #type, .mode = 0400 },			\
+	.show = show_emulated_ ## type,					\
+};
+
+#ifdef CONFIG_ALTIVEC
+SYSFS_EMULATED_SETUP(altivec);
+#endif
+SYSFS_EMULATED_SETUP(dcba);
+SYSFS_EMULATED_SETUP(dcbz);
+SYSFS_EMULATED_SETUP(fp_pair);
+SYSFS_EMULATED_SETUP(isel);
+SYSFS_EMULATED_SETUP(mcrxr);
+SYSFS_EMULATED_SETUP(mfpvr);
+SYSFS_EMULATED_SETUP(multiple);
+SYSFS_EMULATED_SETUP(popcntb);
+SYSFS_EMULATED_SETUP(spe);
+SYSFS_EMULATED_SETUP(string);
+#ifdef CONFIG_MATH_EMULATION
+SYSFS_EMULATED_SETUP(math);
+#elif defined(CONFIG_8XX_MINIMAL_FPEMU)
+SYSFS_EMULATED_SETUP(8xx);
+#endif
+#ifdef CONFIG_VSX
+SYSFS_EMULATED_SETUP(vsx);
+#endif
+
+static struct attribute *emulated_attrs[] = {
+#ifdef CONFIG_ALTIVEC
+	&emulated_altivec_attr.attr,
+#endif
+	&emulated_dcba_attr.attr,
+	&emulated_dcbz_attr.attr,
+	&emulated_fp_pair_attr.attr,
+	&emulated_isel_attr.attr,
+	&emulated_mcrxr_attr.attr,
+	&emulated_mfpvr_attr.attr,
+	&emulated_multiple_attr.attr,
+	&emulated_popcntb_attr.attr,
+	&emulated_spe_attr.attr,
+	&emulated_string_attr.attr,
+#ifdef CONFIG_MATH_EMULATION
+	&emulated_math_attr.attr,
+#elif defined(CONFIG_8XX_MINIMAL_FPEMU)
+	&emulated_8xx_attr.attr,
+#endif
+#ifdef CONFIG_VSX
+	&emulated_vsx_attr.attr,
+#endif
+	NULL
+};
+
+static struct attribute_group emulated_attr_group = {
+	.attrs = emulated_attrs,
+	.name = "emulated"
+};
+
 static void __cpuinit register_cpu_online(unsigned int cpu)
 {
 	struct cpu *c = &per_cpu(cpu_devices, cpu);
 	struct sys_device *s = &c->sysdev;
 	struct sysdev_attribute *attrs, *pmc_attrs;
-	int i, nattrs;
+	int i, nattrs, res;
 
 #ifdef CONFIG_PPC64
 	if (!firmware_has_feature(FW_FEATURE_ISERIES) &&
@@ -387,6 +458,11 @@ static void __cpuinit register_cpu_online(unsigned int cpu)
 #endif /* CONFIG_PPC64 */
 
 	cacheinfo_cpu_online(cpu);
+
+	res = sysfs_create_group(&s->kobj, &emulated_attr_group);
+	if (res)
+		pr_warning("Cannot create emulated sysfs group for cpu %u\n",
+			   cpu);
 }
 
 #ifdef CONFIG_HOTPLUG_CPU
diff --git a/arch/powerpc/kernel/traps.c b/arch/powerpc/kernel/traps.c
index 678fbff..6cf1e13 100644
--- a/arch/powerpc/kernel/traps.c
+++ b/arch/powerpc/kernel/traps.c
@@ -33,7 +33,9 @@
 #include <linux/backlight.h>
 #include <linux/bug.h>
 #include <linux/kdebug.h>
+#include <linux/sysctl.h>
 
+#include <asm/emulated_ops.h>
 #include <asm/pgtable.h>
 #include <asm/uaccess.h>
 #include <asm/system.h>
@@ -757,36 +759,44 @@ static int emulate_instruction(struct pt_regs *regs)
 
 	/* Emulate the mfspr rD, PVR. */
 	if ((instword & PPC_INST_MFSPR_PVR_MASK) == PPC_INST_MFSPR_PVR) {
+		WARN_EMULATED(mfpvr);
 		rd = (instword >> 21) & 0x1f;
 		regs->gpr[rd] = mfspr(SPRN_PVR);
 		return 0;
 	}
 
 	/* Emulating the dcba insn is just a no-op.  */
-	if ((instword & PPC_INST_DCBA_MASK) == PPC_INST_DCBA)
+	if ((instword & PPC_INST_DCBA_MASK) == PPC_INST_DCBA) {
+		WARN_EMULATED(dcba);
 		return 0;
+	}
 
 	/* Emulate the mcrxr insn.  */
 	if ((instword & PPC_INST_MCRXR_MASK) == PPC_INST_MCRXR) {
 		int shift = (instword >> 21) & 0x1c;
 		unsigned long msk = 0xf0000000UL >> shift;
 
+		WARN_EMULATED(mcrxr);
 		regs->ccr = (regs->ccr & ~msk) | ((regs->xer >> shift) & msk);
 		regs->xer &= ~0xf0000000UL;
 		return 0;
 	}
 
 	/* Emulate load/store string insn. */
-	if ((instword & PPC_INST_STRING_GEN_MASK) == PPC_INST_STRING)
+	if ((instword & PPC_INST_STRING_GEN_MASK) == PPC_INST_STRING) {
+		WARN_EMULATED(string);
 		return emulate_string_inst(regs, instword);
+	}
 
 	/* Emulate the popcntb (Population Count Bytes) instruction. */
 	if ((instword & PPC_INST_POPCNTB_MASK) == PPC_INST_POPCNTB) {
+		WARN_EMULATED(popcntb);
 		return emulate_popcntb_inst(regs, instword);
 	}
 
 	/* Emulate isel (Integer Select) instruction */
 	if ((instword & PPC_INST_ISEL_MASK) == PPC_INST_ISEL) {
+		WARN_EMULATED(isel);
 		return emulate_isel(regs, instword);
 	}
 
@@ -984,6 +994,8 @@ void SoftwareEmulation(struct pt_regs *regs)
 
 #ifdef CONFIG_MATH_EMULATION
 	errcode = do_mathemu(regs);
+	if (errcode >= 0)
+		WARN_EMULATED(math);
 
 	switch (errcode) {
 	case 0:
@@ -1005,6 +1017,9 @@ void SoftwareEmulation(struct pt_regs *regs)
 
 #elif defined(CONFIG_8XX_MINIMAL_FPEMU)
 	errcode = Soft_emulate_8xx(regs);
+	if (errcode >= 0)
+		WARN_EMULATED(8xx);
+
 	switch (errcode) {
 	case 0:
 		emulate_single_step(regs);
@@ -1088,6 +1103,7 @@ void altivec_assist_exception(struct pt_regs *regs)
 
 	flush_altivec_to_thread(current);
 
+	WARN_EMULATED(altivec);
 	err = emulate_altivec(regs);
 	if (err == 0) {
 		regs->nip += 4;		/* skip emulated instruction */
@@ -1286,3 +1302,43 @@ void kernel_bad_stack(struct pt_regs *regs)
 void __init trap_init(void)
 {
 }
+
+#ifdef CONFIG_SYSCTL
+int sysctl_warn_emulated;
+
+static ctl_table warn_emulated_ctl_table[] = {
+	{
+		.procname	= "cpu_emulation_warnings",
+		.data		= &sysctl_warn_emulated,
+		.maxlen		= sizeof(int),
+		.mode		= 0644,
+		.proc_handler	= &proc_dointvec,
+	},
+	{}
+};
+
+static ctl_table warn_emulated_sysctl_root[] = {
+	{
+		.ctl_name	= CTL_KERN,
+		.procname	= "kernel",
+		.mode		= 0555,
+		.child		= warn_emulated_ctl_table,
+	},
+	{}
+};
+
+void warn_emulated_print(const char *type)
+{
+	if (printk_ratelimit())
+		pr_warning("%s used emulated %s instruction\n", current->comm,
+			   type);
+}
+
+static inline int __init warn_emulated_sysctl_register(void)
+{
+	register_sysctl_table(warn_emulated_sysctl_root);
+	return 0;
+}
+
+device_initcall(warn_emulated_sysctl_register);
+#endif /* !CONFIG_SYSCTL */
-- 
1.6.0.4


With kind regards,

Geert Uytterhoeven
Software Architect

Sony Techsoft Centre Europe
The Corporate Village � Da Vincilaan 7-D1 � B-1935 Zaventem � Belgium

Phone:    +32 (0)2 700 8453
Fax:      +32 (0)2 700 8622
E-mail:   Geert.Uytterhoeven@sonycom.com
Internet: http://www.sony-europe.com/

A division of Sony Europe (Belgium) N.V.
VAT BE 0413.825.160 � RPR Brussels
Fortis � BIC GEBABEBB � IBAN BE41293037680010

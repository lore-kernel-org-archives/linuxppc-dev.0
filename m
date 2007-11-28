Return-Path: <Geert.Uytterhoeven@sonycom.com>
Received: from vervifontaine.sonycom.com (vervifontaine.sonytel.be
	[80.88.33.193]) by ozlabs.org (Postfix) with ESMTP id BD6EBDDDD6
	for <linuxppc-dev@ozlabs.org>; Wed, 28 Nov 2007 21:49:14 +1100 (EST)
Date: Wed, 28 Nov 2007 11:49:03 +0100 (CET)
From: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
Sender: geert@sonytel.be
To: Olof Johansson <olof@lixom.net>
Subject: Re: [PATCH] [POWERPC] Emulate isel (Integer Select) instruction
In-Reply-To: <20071127152317.GA5230@lixom.net>
Message-ID: <Pine.LNX.4.62.0711281148020.27512@pademelon.sonytel.be>
References: <Pine.LNX.4.64.0711192135460.24923@blarg.am.freescale.net>
	<20071120175416.GA4389@loki.buserror.net>
	<B82E6C31-8BB7-4348-9426-B18A971172A9@kernel.crashing.org>
	<Pine.LNX.4.62.0711211407260.12720@pademelon.sonytel.be>
	<Pine.LNX.4.62.0711271555520.5847@pademelon.sonytel.be>
	<20071127152317.GA5230@lixom.net>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED;
	BOUNDARY="-584337861-1933793973-1196246943=:27512"
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---584337861-1933793973-1196246943=:27512
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: 8BIT

On Tue, 27 Nov 2007, Olof Johansson wrote:
> On Tue, Nov 27, 2007 at 03:56:53PM +0100, Geert Uytterhoeven wrote:
> >  include/asm-powerpc/emulator.h |   60 ++++++++++++++++++++++++++++++++++++++
> 
> This name stood out as being a bit too generic, emulator could mean
> system support for running under some sort of emulator as well. How
> about emulated_ops.h?

Changed.

> > +config DEBUG_WARN_EMULATED
> > +	bool "Warn if emulated instructions are used"
> > +	depends on DEBUG_KERNEL && SYSFS
> > +	help
> > +	  This option will cause messages to be printed if an instruction is
> > +	  emulated.
> > +	  Counters for emulated instruction usages are always available under
> > +	  /sys/devices/system/cpu/cpu*/emulated/, irrespective of the state
> > +	  of this option.
> 
> How about making it a sysctl instead, so it can be flipped at runtime
> (but default off)?

Converted to a sysctl.

Subject: powerpc: Keep track of emulated instructions

From: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>

powerpc: Keep track of emulated instructions

Counters for the various classes of emulated instructions are available under
/sys/devices/system/cpu/cpu*/emulated/.
Optionally (controlled by /proc/sys/kernel/cpu_emulation_warnings),
rate-limited warnings can be printed to the console when instructions are
emulated.

Signed-off-by: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
---
 arch/powerpc/kernel/align.c        |   17 ++++--
 arch/powerpc/kernel/sysfs.c        |  100 ++++++++++++++++++++++++++++++++++++-
 arch/powerpc/kernel/traps.c        |   24 ++++++++
 include/asm-powerpc/emulated_ops.h |   52 +++++++++++++++++++
 4 files changed, 186 insertions(+), 7 deletions(-)

--- a/arch/powerpc/kernel/align.c
+++ b/arch/powerpc/kernel/align.c
@@ -24,6 +24,7 @@
 #include <asm/system.h>
 #include <asm/cache.h>
 #include <asm/cputable.h>
+#include <asm/emulated_ops.h>
 
 struct aligninfo {
 	unsigned char len;
@@ -696,8 +697,10 @@ int fix_alignment(struct pt_regs *regs)
 	areg = dsisr & 0x1f;		/* register to update */
 
 #ifdef CONFIG_SPE
-	if ((instr >> 26) == 0x4)
+	if ((instr >> 26) == 0x4) {
+		WARN_EMULATE(spe);
 		return emulate_spe(regs, reg, instr);
+	}
 #endif
 
 	instr = (dsisr >> 10) & 0x7f;
@@ -731,17 +734,21 @@ int fix_alignment(struct pt_regs *regs)
 	/* A size of 0 indicates an instruction we don't support, with
 	 * the exception of DCBZ which is handled as a special case here
 	 */
-	if (instr == DCBZ)
+	if (instr == DCBZ) {
+		WARN_EMULATE(dcbz);
 		return emulate_dcbz(regs, addr);
+	}
 	if (unlikely(nb == 0))
 		return 0;
 
 	/* Load/Store Multiple instructions are handled in their own
 	 * function
 	 */
-	if (flags & M)
+	if (flags & M) {
+		WARN_EMULATE(multiple);
 		return emulate_multiple(regs, addr, reg, nb,
 					flags, instr, swiz);
+	}
 
 	/* Verify the address of the operand */
 	if (unlikely(user_mode(regs) &&
@@ -758,8 +765,10 @@ int fix_alignment(struct pt_regs *regs)
 	}
 
 	/* Special case for 16-byte FP loads and stores */
-	if (nb == 16)
+	if (nb == 16) {
+		WARN_EMULATE(fp_pair);
 		return emulate_fp_pair(regs, addr, reg, flags);
+	}
 
 	/* If we are loading, get the data from user space, else
 	 * get it from register values
--- a/arch/powerpc/kernel/sysfs.c
+++ b/arch/powerpc/kernel/sysfs.c
@@ -8,6 +8,7 @@
 #include <linux/nodemask.h>
 #include <linux/cpumask.h>
 #include <linux/notifier.h>
+#include <linux/sysctl.h>
 
 #include <asm/current.h>
 #include <asm/processor.h>
@@ -19,6 +20,7 @@
 #include <asm/lppaca.h>
 #include <asm/machdep.h>
 #include <asm/smp.h>
+#include <asm/emulated_ops.h>
 
 static DEFINE_PER_CPU(struct cpu, cpu_devices);
 
@@ -291,12 +293,101 @@ static struct sysdev_attribute pa6t_attr
 };
 
 
+#define SYSFS_EMULATED_SETUP(type)					\
+DEFINE_PER_CPU(atomic_long_t, emulated_ ## type);			\
+static ssize_t show_emulated_ ## type (struct sys_device *dev,		\
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
+SYSFS_EMULATED_SETUP(dcba);
+SYSFS_EMULATED_SETUP(dcbz);
+SYSFS_EMULATED_SETUP(fp_pair);
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
+
+static struct attribute *emulated_attrs[] = {
+	&emulated_dcba_attr.attr,
+	&emulated_dcbz_attr.attr,
+	&emulated_fp_pair_attr.attr,
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
+	NULL
+};
+
+static struct attribute_group emulated_attr_group = {
+	.attrs = emulated_attrs,
+	.name = "emulated"
+};
+
+int sysctl_warn_emulated;
+
+#ifdef CONFIG_SYSCTL
+static ctl_table warn_emulated_ctl_table[]={
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
+static inline void warn_emulated_sysctl_register(void)
+{
+	int res = register_sysctl_table(warn_emulated_sysctl_root);
+	printk("@@@ register_sysctl_table() returned %d\n", res);
+}
+#else /* !CONFIG_SYSCTL */
+static inline void warn_emulated_sysctl_register(void) {}
+#endif /* !CONFIG_SYSCTL */
+
+
 static void register_cpu_online(unsigned int cpu)
 {
 	struct cpu *c = &per_cpu(cpu_devices, cpu);
 	struct sys_device *s = &c->sysdev;
 	struct sysdev_attribute *attrs, *pmc_attrs;
-	int i, nattrs;
+	int i, nattrs, res;
 
 	if (!firmware_has_feature(FW_FEATURE_ISERIES) &&
 			cpu_has_feature(CPU_FTR_SMT))
@@ -339,6 +430,11 @@ static void register_cpu_online(unsigned
 
 	if (cpu_has_feature(CPU_FTR_DSCR))
 		sysdev_create_file(s, &attr_dscr);
+
+	res = sysfs_create_group(&s->kobj, &emulated_attr_group);
+	if (res)
+		pr_warning("Cannot create emulated sysfs group for cpu %u\n",
+			   cpu);
 }
 
 #ifdef CONFIG_HOTPLUG_CPU
@@ -560,6 +656,8 @@ static int __init topology_init(void)
 			register_cpu_online(cpu);
 	}
 
+	warn_emulated_sysctl_register();
+
 	return 0;
 }
 subsys_initcall(topology_init);
--- a/arch/powerpc/kernel/traps.c
+++ b/arch/powerpc/kernel/traps.c
@@ -53,6 +53,7 @@
 #include <asm/processor.h>
 #endif
 #include <asm/kexec.h>
+#include <asm/emulated_ops.h>
 
 #ifdef CONFIG_DEBUGGER
 int (*__debugger)(struct pt_regs *regs);
@@ -707,6 +708,13 @@ static int emulate_popcntb_inst(struct p
 	return 0;
 }
 
+void do_warn_emulate(const char *type)
+{
+	if (printk_ratelimit())
+		pr_warning("%s used emulated %s instruction\n", current->comm,
+			   type);
+}
+
 static int emulate_instruction(struct pt_regs *regs)
 {
 	u32 instword;
@@ -721,31 +729,38 @@ static int emulate_instruction(struct pt
 
 	/* Emulate the mfspr rD, PVR. */
 	if ((instword & INST_MFSPR_PVR_MASK) == INST_MFSPR_PVR) {
+		WARN_EMULATE(mfpvr);
 		rd = (instword >> 21) & 0x1f;
 		regs->gpr[rd] = mfspr(SPRN_PVR);
 		return 0;
 	}
 
 	/* Emulating the dcba insn is just a no-op.  */
-	if ((instword & INST_DCBA_MASK) == INST_DCBA)
+	if ((instword & INST_DCBA_MASK) == INST_DCBA) {
+		WARN_EMULATE(dcba);
 		return 0;
+	}
 
 	/* Emulate the mcrxr insn.  */
 	if ((instword & INST_MCRXR_MASK) == INST_MCRXR) {
 		int shift = (instword >> 21) & 0x1c;
 		unsigned long msk = 0xf0000000UL >> shift;
 
+		WARN_EMULATE(mcrxr);
 		regs->ccr = (regs->ccr & ~msk) | ((regs->xer >> shift) & msk);
 		regs->xer &= ~0xf0000000UL;
 		return 0;
 	}
 
 	/* Emulate load/store string insn. */
-	if ((instword & INST_STRING_GEN_MASK) == INST_STRING)
+	if ((instword & INST_STRING_GEN_MASK) == INST_STRING) {
+		WARN_EMULATE(string);
 		return emulate_string_inst(regs, instword);
+	}
 
 	/* Emulate the popcntb (Population Count Bytes) instruction. */
 	if ((instword & INST_POPCNTB_MASK) == INST_POPCNTB) {
+		WARN_EMULATE(popcntb);
 		return emulate_popcntb_inst(regs, instword);
 	}
 
@@ -929,6 +944,8 @@ void SoftwareEmulation(struct pt_regs *r
 
 #ifdef CONFIG_MATH_EMULATION
 	errcode = do_mathemu(regs);
+	if (errcode >= 0)
+		WARN_EMULATE(math);
 
 	switch (errcode) {
 	case 0:
@@ -950,6 +967,9 @@ void SoftwareEmulation(struct pt_regs *r
 
 #elif defined(CONFIG_8XX_MINIMAL_FPEMU)
 	errcode = Soft_emulate_8xx(regs);
+	if (errcode >= 0)
+		WARN_EMULATE(8xx);
+
 	switch (errcode) {
 	case 0:
 		emulate_single_step(regs);
--- /dev/null
+++ b/include/asm-powerpc/emulated_ops.h
@@ -0,0 +1,52 @@
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
+DECLARE_PER_CPU(atomic_long_t, emulated_dcba);
+DECLARE_PER_CPU(atomic_long_t, emulated_dcbz);
+DECLARE_PER_CPU(atomic_long_t, emulated_fp_pair);
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
+
+extern int sysctl_warn_emulated;
+extern void do_warn_emulate(const char *type);
+
+#define WARN_EMULATE(type)						\
+	do {								\
+		atomic_long_inc(&per_cpu(emulated_ ## type,		\
+					 raw_smp_processor_id()));	\
+		if (sysctl_warn_emulated)				\
+			do_warn_emulate(#type);				\
+	} while (0)
+
+
+#endif /* _ASM_POWERPC_EMULATED_OPS_H */

With kind regards,
 
Geert Uytterhoeven
Software Architect

Sony Network and Software Technology Center Europe
The Corporate Village · Da Vincilaan 7-D1 · B-1935 Zaventem · Belgium
 
Phone:    +32 (0)2 700 8453	
Fax:      +32 (0)2 700 8622	
E-mail:   Geert.Uytterhoeven@sonycom.com	
Internet: http://www.sony-europe.com/
 	
Sony Network and Software Technology Center Europe	
A division of Sony Service Centre (Europe) N.V.	
Registered office: Technologielaan 7 · B-1840 Londerzeel · Belgium	
VAT BE 0413.825.160 · RPR Brussels	
Fortis Bank Zaventem · Swift GEBABEBB08A · IBAN BE39001382358619
---584337861-1933793973-1196246943=:27512--

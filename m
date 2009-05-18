Return-Path: <Geert.Uytterhoeven@sonycom.com>
Received: from pophost.sonytel.be (vervifontaine.sonytel.be [80.88.33.193])
	by ozlabs.org (Postfix) with ESMTP id F2083DE058
	for <linuxppc-dev@ozlabs.org>; Mon, 18 May 2009 22:10:06 +1000 (EST)
Received: from vixen.sonytel.be (piraat.sonytel.be [43.221.60.197])
	by pophost.sonytel.be (Postfix) with ESMTP id 6467D44426
	for <linuxppc-dev@ozlabs.org>; Mon, 18 May 2009 14:10:05 +0200 (CEST)
Date: Mon, 18 May 2009 14:10:05 +0200 (CEST)
From: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
Sender: geert@sonytel.be
To: Linux/PPC Development <linuxppc-dev@ozlabs.org>
Subject: [PATCH v4] powerpc: Keep track of emulated instructions
Message-ID: <alpine.LRH.2.00.0905181407150.2526@vixen.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-15
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

If CONFIG_PPC_EMULATED_STATS is enabled, make available counters for the
various classes of emulated instructions under
/sys/kernel/debug/powerpc/emulated_instructions/ (assumed debugfs is mounted on
/sys/kernel/debug).  Optionally (controlled by
/sys/kernel/debug/powerpc/emulated_instructions/do_warn), rate-limited warnings
can be printed to the console when instructions are emulated.

Signed-off-by: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
---
Tested on ppc64 (ps3) and ppc32 (sequoia) using mfpvr.

v4:
  - Introduce CONFIG_PPC_EMULATED_STATS

v3:
  - Add generic unaligned
  - Switch from sysfs + sysctl to debugfs. All virtual files now show up under
    /sys/kernel/debug/powerpc/emulated_instructions (assumed debugfs mounted on
    /sys/kernel/debug)
  - Enable the printing of rate-limited warnings by writing a non-zero value to
    /sys/kernel/debug/powerpc/emulated_instructions/do_warn
  - Switch from per-CPU to system-wide counters
  - Always use 32-bit counters (was 64-bit on ppc64)
  - Counters are writable, i.e. can be reset (by root)

v2:
  - arch/powerpc/kernel/sysfs.c is now compiled on ppc32, so we can provide
    counters in sysfs on ppc32, too,
  - WARN_EMULATED() is a no-op if CONFIG_SYSCTL is disabled,
  - Add warnings for altivec,
  - Add warnings for recently introduced emulation of vsx and isel
    instructions.

 arch/powerpc/Kconfig.debug              |   13 ++++
 arch/powerpc/include/asm/emulated_ops.h |   73 +++++++++++++++++++++++
 arch/powerpc/kernel/align.c             |   20 +++++-
 arch/powerpc/kernel/traps.c             |   96 ++++++++++++++++++++++++++++++-
 4 files changed, 196 insertions(+), 6 deletions(-)
 create mode 100644 arch/powerpc/include/asm/emulated_ops.h

diff --git a/arch/powerpc/Kconfig.debug b/arch/powerpc/Kconfig.debug
index a1098e2..d79a902 100644
--- a/arch/powerpc/Kconfig.debug
+++ b/arch/powerpc/Kconfig.debug
@@ -41,6 +41,19 @@ config HCALL_STATS
 	  This option will add a small amount of overhead to all hypervisor
 	  calls.
 
+config PPC_EMULATED_STATS
+	bool "Emulated instructions tracking"
+	depends on DEBUG_FS
+	help
+	  Adds code to keep track of the number of instructions that are
+	  emulated by the in-kernel emulator. Counters for the various classes
+	  of emulated instructions are available under
+	  powerpc/emulated_instructions/ in the root of the debugfs file
+	  system. Optionally (controlled by
+	  powerpc/emulated_instructions/do_warn in debugfs), rate-limited
+	  warnings can be printed to the console when instructions are
+	  emulated.
+
 config CODE_PATCHING_SELFTEST
 	bool "Run self-tests of the code-patching code."
 	depends on DEBUG_KERNEL
diff --git a/arch/powerpc/include/asm/emulated_ops.h b/arch/powerpc/include/asm/emulated_ops.h
new file mode 100644
index 0000000..9154e85
--- /dev/null
+++ b/arch/powerpc/include/asm/emulated_ops.h
@@ -0,0 +1,73 @@
+/*
+ *  Copyright 2007 Sony Corporation
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
+ *  along with this program.
+ *  If not, see <http://www.gnu.org/licenses/>.
+ */
+
+#ifndef _ASM_POWERPC_EMULATED_OPS_H
+#define _ASM_POWERPC_EMULATED_OPS_H
+
+#include <asm/atomic.h>
+
+
+#ifdef CONFIG_PPC_EMULATED_STATS
+
+struct ppc_emulated_entry {
+	const char *name;
+	atomic_t val;
+};
+
+extern struct ppc_emulated {
+#ifdef CONFIG_ALTIVEC
+	struct ppc_emulated_entry altivec;
+#endif
+	struct ppc_emulated_entry dcba;
+	struct ppc_emulated_entry dcbz;
+	struct ppc_emulated_entry fp_pair;
+	struct ppc_emulated_entry isel;
+	struct ppc_emulated_entry mcrxr;
+	struct ppc_emulated_entry mfpvr;
+	struct ppc_emulated_entry multiple;
+	struct ppc_emulated_entry popcntb;
+	struct ppc_emulated_entry spe;
+	struct ppc_emulated_entry string;
+	struct ppc_emulated_entry unaligned;
+#ifdef CONFIG_MATH_EMULATION
+	struct ppc_emulated_entry math;
+#elif defined(CONFIG_8XX_MINIMAL_FPEMU)
+	struct ppc_emulated_entry 8xx;
+#endif
+#ifdef CONFIG_VSX
+	struct ppc_emulated_entry vsx;
+#endif
+} ppc_emulated;
+
+extern u32 ppc_warn_emulated;
+
+extern void ppc_warn_emulated_print(const char *type);
+
+#define PPC_WARN_EMULATED(type)						 \
+	do {								 \
+		atomic_inc(&ppc_emulated.type.val);			 \
+		if (ppc_warn_emulated)					 \
+			ppc_warn_emulated_print(ppc_emulated.type.name); \
+	} while (0)
+
+#else /* !CONFIG_PPC_EMULATED_STATS */
+
+#define PPC_WARN_EMULATED(type)	do { } while (0)
+
+#endif /* !CONFIG_PPC_EMULATED_STATS */
+
+#endif /* _ASM_POWERPC_EMULATED_OPS_H */
diff --git a/arch/powerpc/kernel/align.c b/arch/powerpc/kernel/align.c
index 5ffcfaa..a5b632e 100644
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
+		PPC_WARN_EMULATED(spe);
 		return emulate_spe(regs, reg, instr);
+	}
 #endif
 
 	instr = (dsisr >> 10) & 0x7f;
@@ -783,23 +786,28 @@ int fix_alignment(struct pt_regs *regs)
 			flags |= SPLT;
 			nb = 8;
 		}
+		PPC_WARN_EMULATED(vsx);
 		return emulate_vsx(addr, reg, areg, regs, flags, nb);
 	}
 #endif
 	/* A size of 0 indicates an instruction we don't support, with
 	 * the exception of DCBZ which is handled as a special case here
 	 */
-	if (instr == DCBZ)
+	if (instr == DCBZ) {
+		PPC_WARN_EMULATED(dcbz);
 		return emulate_dcbz(regs, addr);
+	}
 	if (unlikely(nb == 0))
 		return 0;
 
 	/* Load/Store Multiple instructions are handled in their own
 	 * function
 	 */
-	if (flags & M)
+	if (flags & M) {
+		PPC_WARN_EMULATED(multiple);
 		return emulate_multiple(regs, addr, reg, nb,
 					flags, instr, swiz);
+	}
 
 	/* Verify the address of the operand */
 	if (unlikely(user_mode(regs) &&
@@ -816,8 +824,12 @@ int fix_alignment(struct pt_regs *regs)
 	}
 
 	/* Special case for 16-byte FP loads and stores */
-	if (nb == 16)
+	if (nb == 16) {
+		PPC_WARN_EMULATED(fp_pair);
 		return emulate_fp_pair(addr, reg, flags);
+	}
+
+	PPC_WARN_EMULATED(unaligned);
 
 	/* If we are loading, get the data from user space, else
 	 * get it from register values
diff --git a/arch/powerpc/kernel/traps.c b/arch/powerpc/kernel/traps.c
index 678fbff..6a5b2b7 100644
--- a/arch/powerpc/kernel/traps.c
+++ b/arch/powerpc/kernel/traps.c
@@ -33,7 +33,9 @@
 #include <linux/backlight.h>
 #include <linux/bug.h>
 #include <linux/kdebug.h>
+#include <linux/debugfs.h>
 
+#include <asm/emulated_ops.h>
 #include <asm/pgtable.h>
 #include <asm/uaccess.h>
 #include <asm/system.h>
@@ -757,36 +759,44 @@ static int emulate_instruction(struct pt_regs *regs)
 
 	/* Emulate the mfspr rD, PVR. */
 	if ((instword & PPC_INST_MFSPR_PVR_MASK) == PPC_INST_MFSPR_PVR) {
+		PPC_WARN_EMULATED(mfpvr);
 		rd = (instword >> 21) & 0x1f;
 		regs->gpr[rd] = mfspr(SPRN_PVR);
 		return 0;
 	}
 
 	/* Emulating the dcba insn is just a no-op.  */
-	if ((instword & PPC_INST_DCBA_MASK) == PPC_INST_DCBA)
+	if ((instword & PPC_INST_DCBA_MASK) == PPC_INST_DCBA) {
+		PPC_WARN_EMULATED(dcba);
 		return 0;
+	}
 
 	/* Emulate the mcrxr insn.  */
 	if ((instword & PPC_INST_MCRXR_MASK) == PPC_INST_MCRXR) {
 		int shift = (instword >> 21) & 0x1c;
 		unsigned long msk = 0xf0000000UL >> shift;
 
+		PPC_WARN_EMULATED(mcrxr);
 		regs->ccr = (regs->ccr & ~msk) | ((regs->xer >> shift) & msk);
 		regs->xer &= ~0xf0000000UL;
 		return 0;
 	}
 
 	/* Emulate load/store string insn. */
-	if ((instword & PPC_INST_STRING_GEN_MASK) == PPC_INST_STRING)
+	if ((instword & PPC_INST_STRING_GEN_MASK) == PPC_INST_STRING) {
+		PPC_WARN_EMULATED(string);
 		return emulate_string_inst(regs, instword);
+	}
 
 	/* Emulate the popcntb (Population Count Bytes) instruction. */
 	if ((instword & PPC_INST_POPCNTB_MASK) == PPC_INST_POPCNTB) {
+		PPC_WARN_EMULATED(popcntb);
 		return emulate_popcntb_inst(regs, instword);
 	}
 
 	/* Emulate isel (Integer Select) instruction */
 	if ((instword & PPC_INST_ISEL_MASK) == PPC_INST_ISEL) {
+		PPC_WARN_EMULATED(isel);
 		return emulate_isel(regs, instword);
 	}
 
@@ -984,6 +994,8 @@ void SoftwareEmulation(struct pt_regs *regs)
 
 #ifdef CONFIG_MATH_EMULATION
 	errcode = do_mathemu(regs);
+	if (errcode >= 0)
+		PPC_WARN_EMULATED(math);
 
 	switch (errcode) {
 	case 0:
@@ -1005,6 +1017,9 @@ void SoftwareEmulation(struct pt_regs *regs)
 
 #elif defined(CONFIG_8XX_MINIMAL_FPEMU)
 	errcode = Soft_emulate_8xx(regs);
+	if (errcode >= 0)
+		PPC_WARN_EMULATED(8xx);
+
 	switch (errcode) {
 	case 0:
 		emulate_single_step(regs);
@@ -1088,6 +1103,7 @@ void altivec_assist_exception(struct pt_regs *regs)
 
 	flush_altivec_to_thread(current);
 
+	PPC_WARN_EMULATED(altivec);
 	err = emulate_altivec(regs);
 	if (err == 0) {
 		regs->nip += 4;		/* skip emulated instruction */
@@ -1286,3 +1302,79 @@ void kernel_bad_stack(struct pt_regs *regs)
 void __init trap_init(void)
 {
 }
+
+
+#ifdef CONFIG_PPC_EMULATED_STATS
+
+#define WARN_EMULATED_SETUP(type)	.type = { .name = #type }
+
+struct ppc_emulated ppc_emulated = {
+#ifdef CONFIG_ALTIVEC
+	WARN_EMULATED_SETUP(altivec),
+#endif
+	WARN_EMULATED_SETUP(dcba),
+	WARN_EMULATED_SETUP(dcbz),
+	WARN_EMULATED_SETUP(fp_pair),
+	WARN_EMULATED_SETUP(isel),
+	WARN_EMULATED_SETUP(mcrxr),
+	WARN_EMULATED_SETUP(mfpvr),
+	WARN_EMULATED_SETUP(multiple),
+	WARN_EMULATED_SETUP(popcntb),
+	WARN_EMULATED_SETUP(spe),
+	WARN_EMULATED_SETUP(string),
+	WARN_EMULATED_SETUP(unaligned),
+#ifdef CONFIG_MATH_EMULATION
+	WARN_EMULATED_SETUP(math),
+#elif defined(CONFIG_8XX_MINIMAL_FPEMU)
+	WARN_EMULATED_SETUP(8xx),
+#endif
+#ifdef CONFIG_VSX
+	WARN_EMULATED_SETUP(vsx),
+#endif
+};
+
+u32 ppc_warn_emulated;
+
+void ppc_warn_emulated_print(const char *type)
+{
+	if (printk_ratelimit())
+		pr_warning("%s used emulated %s instruction\n", current->comm,
+			   type);
+}
+
+static int __init ppc_warn_emulated_init(void)
+{
+	struct dentry *dir, *d;
+	unsigned int i;
+	struct ppc_emulated_entry *entries = (void *)&ppc_emulated;
+
+	if (!powerpc_debugfs_root)
+		return -ENODEV;
+
+	dir = debugfs_create_dir("emulated_instructions",
+				 powerpc_debugfs_root);
+	if (!dir)
+		return -ENOMEM;
+
+	d = debugfs_create_u32("do_warn", S_IRUGO | S_IWUSR, dir,
+			       &ppc_warn_emulated);
+	if (!d)
+		goto fail;
+
+	for (i = 0; i < sizeof(ppc_emulated)/sizeof(*entries); i++) {
+		d = debugfs_create_u32(entries[i].name, S_IRUGO | S_IWUSR, dir,
+				       (u32 *)&entries[i].val.counter);
+		if (!d)
+			goto fail;
+	}
+
+	return 0;
+
+fail:
+	debugfs_remove_recursive(dir);
+	return -ENOMEM;
+}
+
+device_initcall(ppc_warn_emulated_init);
+
+#endif /* CONFIG_PPC_EMULATED_STATS */
-- 
1.6.2.4

With kind regards,

Geert Uytterhoeven
Software Architect
Techsoft Centre

Technology and Software Centre Europe
The Corporate Village � Da Vincilaan 7-D1 � B-1935 Zaventem � Belgium

Phone:    +32 (0)2 700 8453
Fax:      +32 (0)2 700 8622
E-mail:   Geert.Uytterhoeven@sonycom.com
Internet: http://www.sony-europe.com/

A division of Sony Europe (Belgium) N.V.
VAT BE 0413.825.160 � RPR Brussels
Fortis � BIC GEBABEBB � IBAN BE41293037680010

Subject: [PATCH,RFC] PPC32 Machine Check Handling
From: Adrian Cox <adrian@humboldt.co.uk>
To: linuxppc-dev@lists.linuxppc.org
Cc: paulus@samba.org, trini@kernel.crashing.org
Content-Type: multipart/mixed; boundary="=-ofgE4sE3pft41YjMGBSh"
Message-Id: <1093602389.1862.54.camel@localhost>
Mime-Version: 1.0
Date: Fri, 27 Aug 2004 11:26:29 +0100
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


--=-ofgE4sE3pft41YjMGBSh
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

The attached patch rearranges PPC32 machine check handling in order to
test for internal CPU failures before signalling user processes. This
makes the behaviour match that of i386.

The patch currently only changes behaviour for 6xx processors. It does
not enable any extra causes of machine check, but it will turn internal
CPU faults into kernel panics rather than signals.

The PowerMac and Qspan specific code is moved into platform files. There
don't seem to be any boards in the tree that actually use Qspan PCI. I'd
like to hear test reports for PowerMac machines that take machine checks
on I/O faults.

Paul, Tom: This isn't the finished version, but is there any chance of
something like this going mainstream?  The current behaviour makes it
very hard to separate chip failures and cooling problems from
application bugs.

- Adrian Cox
Humboldt Solutions Ltd.


--=-ofgE4sE3pft41YjMGBSh
Content-Description: 
Content-Disposition: inline; filename=mcheck-2.patch
Content-Type: text/x-patch; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 7bit

# This is a BitKeeper generated diff -Nru style patch.
#
# ChangeSet
#   2004/08/27 10:55:15+01:00 adrian@humboldt.co.uk
#   First stage of restructuring machine check.
#
# arch/ppc/kernel/mcheck_6xx.c
#   2004/08/27 10:55:06+01:00 adrian@humboldt.co.uk +113 -0
#
# arch/ppc/kernel/mcheck_6xx.c
#   2004/08/27 10:55:06+01:00 adrian@humboldt.co.uk +0 -0
#   BitKeeper file /home/adrian/kernels/sa107-2.6/sa107-merge/arch/ppc/kernel/mcheck_6xx.c
#
# arch/ppc/kernel/mcheck.h
#   2004/08/27 10:55:05+01:00 adrian@humboldt.co.uk +17 -0
#
# include/asm-ppc/system.h
#   2004/08/27 10:55:05+01:00 adrian@humboldt.co.uk +1 -0
#   Add generic handler for a fatal machine check.
#
# include/asm-ppc/machdep.h
#   2004/08/27 10:55:05+01:00 adrian@humboldt.co.uk +1 -0
#   Add machine check handler.
#
# include/asm-ppc/cputable.h
#   2004/08/27 10:55:05+01:00 adrian@humboldt.co.uk +6 -0
#   Add machine check handler.
#
# arch/ppc/syslib/qspan_pci.c
#   2004/08/27 10:55:05+01:00 adrian@humboldt.co.uk +10 -0
#   Handle machine checks from PCI accesss.
#
# arch/ppc/platforms/pmac_setup.c
#   2004/08/27 10:55:05+01:00 adrian@humboldt.co.uk +49 -0
#   Pmac specific machine check handler to cope with failed I/O accesses.
#
# arch/ppc/kernel/traps.c
#   2004/08/27 10:55:05+01:00 adrian@humboldt.co.uk +21 -87
#   Move to new machine check handling. Qspan and PowerMac code moved
#   to platform files.
#
# arch/ppc/kernel/mcheck.h
#   2004/08/27 10:55:05+01:00 adrian@humboldt.co.uk +0 -0
#   BitKeeper file /home/adrian/kernels/sa107-2.6/sa107-merge/arch/ppc/kernel/mcheck.h
#
# arch/ppc/kernel/cputable.c
#   2004/08/27 10:55:05+01:00 adrian@humboldt.co.uk +31 -30
#   Add 6xx specific machine check handlers
#
# arch/ppc/kernel/Makefile
#   2004/08/27 10:55:05+01:00 adrian@humboldt.co.uk +1 -1
#   Add 6xx CPU specific machine check handlers
#
diff -Nru a/arch/ppc/kernel/Makefile b/arch/ppc/kernel/Makefile
--- a/arch/ppc/kernel/Makefile	Fri Aug 27 10:57:57 2004
+++ b/arch/ppc/kernel/Makefile	Fri Aug 27 10:57:57 2004
@@ -15,7 +15,7 @@
 					process.o signal.o ptrace.o align.o \
 					semaphore.o syscalls.o setup.o \
 					cputable.o ppc_htab.o
-obj-$(CONFIG_6xx)		+= l2cr.o cpu_setup_6xx.o
+obj-$(CONFIG_6xx)		+= l2cr.o cpu_setup_6xx.o mcheck_6xx.o
 obj-$(CONFIG_POWER4)		+= cpu_setup_power4.o
 obj-$(CONFIG_MODULES)		+= module.o ppc_ksyms.o
 obj-$(CONFIG_NOT_COHERENT_CACHE)	+= dma-mapping.o
diff -Nru a/arch/ppc/kernel/cputable.c b/arch/ppc/kernel/cputable.c
--- a/arch/ppc/kernel/cputable.c	Fri Aug 27 10:57:57 2004
+++ b/arch/ppc/kernel/cputable.c	Fri Aug 27 10:57:57 2004
@@ -15,6 +15,7 @@
 #include <linux/threads.h>
 #include <linux/init.h>
 #include <asm/cputable.h>
+#include "mcheck.h"

 struct cpu_spec* cur_cpu_spec[NR_CPUS];

@@ -80,7 +81,7 @@
     	CPU_FTR_CAN_NAP,
 	COMMON_PPC,
     	32, 32,
-	__setup_cpu_603
+	__setup_cpu_603, mcheck_603
     },
     {	/* 603e */
     	0xffff0000, 0x00060000, "603e",
@@ -89,7 +90,7 @@
     	CPU_FTR_CAN_NAP,
 	COMMON_PPC,
 	32, 32,
-	__setup_cpu_603
+	__setup_cpu_603, mcheck_603
     },
     {	/* 603ev */
     	0xffff0000, 0x00070000, "603ev",
@@ -98,7 +99,7 @@
     	CPU_FTR_CAN_NAP,
 	COMMON_PPC,
 	32, 32,
-	__setup_cpu_603
+	__setup_cpu_603, mcheck_603
     },
     {	/* 604 */
     	0xffff0000, 0x00040000, "604",
@@ -107,7 +108,7 @@
 	CPU_FTR_HPTE_TABLE,
 	COMMON_PPC,
 	32, 32,
-	__setup_cpu_604
+	__setup_cpu_604, mcheck_604
     },
     {	/* 604e */
     	0xfffff000, 0x00090000, "604e",
@@ -116,7 +117,7 @@
 	CPU_FTR_HPTE_TABLE,
 	COMMON_PPC,
 	32, 32,
-	__setup_cpu_604
+	__setup_cpu_604, mcheck_604
     },
     {	/* 604r */
     	0xffff0000, 0x00090000, "604r",
@@ -125,7 +126,7 @@
 	CPU_FTR_HPTE_TABLE,
 	COMMON_PPC,
 	32, 32,
-	__setup_cpu_604
+	__setup_cpu_604, mcheck_604
     },
     {	/* 604ev */
     	0xffff0000, 0x000a0000, "604ev",
@@ -134,7 +135,7 @@
 	CPU_FTR_HPTE_TABLE,
 	COMMON_PPC,
 	32, 32,
-	__setup_cpu_604
+	__setup_cpu_604, mcheck_604
     },
     {	/* 740/750 (0x4202, don't support TAU ?) */
     	0xffffffff, 0x00084202, "740/750",
@@ -143,7 +144,7 @@
 	CPU_FTR_L2CR | CPU_FTR_HPTE_TABLE | CPU_FTR_CAN_NAP,
 	COMMON_PPC,
 	32, 32,
-	__setup_cpu_750
+	__setup_cpu_750, mcheck_750
     },
     {	/* 745/755 */
     	0xfffff000, 0x00083000, "745/755",
@@ -152,7 +153,7 @@
 	CPU_FTR_L2CR | CPU_FTR_TAU | CPU_FTR_HPTE_TABLE | CPU_FTR_CAN_NAP,
 	COMMON_PPC,
 	32, 32,
-	__setup_cpu_750
+	__setup_cpu_750, mcheck_750
     },
     {	/* 750CX (80100 and 8010x?) */
     	0xfffffff0, 0x00080100, "750CX",
@@ -161,7 +162,7 @@
 	CPU_FTR_L2CR | CPU_FTR_TAU | CPU_FTR_HPTE_TABLE | CPU_FTR_CAN_NAP,
 	COMMON_PPC,
 	32, 32,
-	__setup_cpu_750cx
+	__setup_cpu_750cx, mcheck_750
     },
     {	/* 750CX (82201 and 82202) */
     	0xfffffff0, 0x00082200, "750CX",
@@ -170,7 +171,7 @@
 	CPU_FTR_L2CR | CPU_FTR_TAU | CPU_FTR_HPTE_TABLE | CPU_FTR_CAN_NAP,
 	COMMON_PPC,
 	32, 32,
-	__setup_cpu_750cx
+	__setup_cpu_750cx, mcheck_750
     },
     {	/* 750CXe (82214) */
     	0xfffffff0, 0x00082210, "750CXe",
@@ -179,7 +180,7 @@
 	CPU_FTR_L2CR | CPU_FTR_TAU | CPU_FTR_HPTE_TABLE | CPU_FTR_CAN_NAP,
 	COMMON_PPC,
 	32, 32,
-	__setup_cpu_750cx
+	__setup_cpu_750cx, mcheck_750
     },
     {	/* 750FX rev 1.x */
     	0xffffff00, 0x70000100, "750FX",
@@ -189,7 +190,7 @@
 	CPU_FTR_DUAL_PLL_750FX | CPU_FTR_NO_DPM,
 	COMMON_PPC,
 	32, 32,
-	__setup_cpu_750
+	__setup_cpu_750, mcheck_750
     },
     {	/* 750FX rev 2.0 must disable HID0[DPM] */
     	0xffffffff, 0x70000200, "750FX",
@@ -199,7 +200,7 @@
 	CPU_FTR_NO_DPM,
 	COMMON_PPC,
 	32, 32,
-	__setup_cpu_750
+	__setup_cpu_750, mcheck_750
     },
     {	/* 750FX (All revs except 2.0) */
     	0xffff0000, 0x70000000, "750FX",
@@ -209,7 +210,7 @@
 	CPU_FTR_DUAL_PLL_750FX | CPU_FTR_HAS_HIGH_BATS,
 	COMMON_PPC,
 	32, 32,
-	__setup_cpu_750fx
+	__setup_cpu_750fx, mcheck_750
     },
     {	/* 750GX */
     	0xffff0000, 0x70020000, "750GX",
@@ -218,7 +219,7 @@
 	CPU_FTR_DUAL_PLL_750FX | CPU_FTR_HAS_HIGH_BATS,
 	COMMON_PPC,
 	32, 32,
-	__setup_cpu_750fx
+	__setup_cpu_750fx, mcheck_750
     },
     {	/* 740/750 (L2CR bit need fixup for 740) */
     	0xffff0000, 0x00080000, "740/750",
@@ -227,7 +228,7 @@
 	CPU_FTR_L2CR | CPU_FTR_TAU | CPU_FTR_HPTE_TABLE | CPU_FTR_CAN_NAP,
 	COMMON_PPC,
 	32, 32,
-	__setup_cpu_750
+	__setup_cpu_750, mcheck_750
     },
     {	/* 7400 rev 1.1 ? (no TAU) */
     	0xffffffff, 0x000c1101, "7400 (1.1)",
@@ -237,7 +238,7 @@
 	CPU_FTR_CAN_NAP,
 	COMMON_PPC | PPC_FEATURE_ALTIVEC_COMP,
 	32, 32,
-	__setup_cpu_7400
+	__setup_cpu_7400, mcheck_7400
     },
     {	/* 7400 */
     	0xffff0000, 0x000c0000, "7400",
@@ -247,7 +248,7 @@
 	CPU_FTR_CAN_NAP,
 	COMMON_PPC | PPC_FEATURE_ALTIVEC_COMP,
 	32, 32,
-	__setup_cpu_7400
+	__setup_cpu_7400, mcheck_7400
     },
     {	/* 7410 */
     	0xffff0000, 0x800c0000, "7410",
@@ -257,7 +258,7 @@
 	CPU_FTR_CAN_NAP,
 	COMMON_PPC | PPC_FEATURE_ALTIVEC_COMP,
 	32, 32,
-	__setup_cpu_7410
+	__setup_cpu_7410, mcheck_7400
     },
     {	/* 7450 2.0 - no doze/nap */
     	0xffffffff, 0x80000200, "7450",
@@ -267,7 +268,7 @@
 	CPU_FTR_HPTE_TABLE | CPU_FTR_SPEC7450 | CPU_FTR_NEED_COHERENT,
 	COMMON_PPC | PPC_FEATURE_ALTIVEC_COMP,
 	32, 32,
-	__setup_cpu_745x
+	__setup_cpu_745x, mcheck_7450
     },
     {	/* 7450 2.1 */
     	0xffffffff, 0x80000201, "7450",
@@ -278,7 +279,7 @@
 	CPU_FTR_L3_DISABLE_NAP | CPU_FTR_NEED_COHERENT,
 	COMMON_PPC | PPC_FEATURE_ALTIVEC_COMP,
 	32, 32,
-	__setup_cpu_745x
+	__setup_cpu_745x, mcheck_7450
     },
     {	/* 7450 2.3 and newer */
     	0xffff0000, 0x80000000, "7450",
@@ -289,7 +290,7 @@
 	CPU_FTR_NEED_COHERENT,
 	COMMON_PPC | PPC_FEATURE_ALTIVEC_COMP,
 	32, 32,
-	__setup_cpu_745x
+	__setup_cpu_745x, mcheck_7450
     },
     {	/* 7455 rev 1.x */
     	0xffffff00, 0x80010100, "7455",
@@ -300,7 +301,7 @@
 	CPU_FTR_NEED_COHERENT,
 	COMMON_PPC | PPC_FEATURE_ALTIVEC_COMP,
 	32, 32,
-	__setup_cpu_745x
+	__setup_cpu_745x, mcheck_7450
     },
     {	/* 7455 rev 2.0 */
     	0xffffffff, 0x80010200, "7455",
@@ -311,7 +312,7 @@
 	CPU_FTR_L3_DISABLE_NAP | CPU_FTR_NEED_COHERENT | CPU_FTR_HAS_HIGH_BATS,
 	COMMON_PPC | PPC_FEATURE_ALTIVEC_COMP,
 	32, 32,
-	__setup_cpu_745x
+	__setup_cpu_745x, mcheck_7450
     },
     {	/* 7455 others */
     	0xffff0000, 0x80010000, "7455",
@@ -322,7 +323,7 @@
 	CPU_FTR_HAS_HIGH_BATS | CPU_FTR_NEED_COHERENT,
 	COMMON_PPC | PPC_FEATURE_ALTIVEC_COMP,
 	32, 32,
-	__setup_cpu_745x
+	__setup_cpu_745x, mcheck_7450
     },
     {	/* 7447/7457 Rev 1.0 */
     	0xffffffff, 0x80020100, "7447/7457",
@@ -355,7 +356,7 @@
 	CPU_FTR_HAS_HIGH_BATS | CPU_FTR_NEED_COHERENT,
 	COMMON_PPC | PPC_FEATURE_ALTIVEC_COMP,
 	32, 32,
-	__setup_cpu_745x
+	__setup_cpu_745x, mcheck_7450
     },
     {	/* 7447A */
     	0xffff0000, 0x80030000, "7447A",
@@ -366,7 +367,7 @@
 	CPU_FTR_HAS_HIGH_BATS | CPU_FTR_NEED_COHERENT,
 	COMMON_PPC | PPC_FEATURE_ALTIVEC_COMP,
 	32, 32,
-	__setup_cpu_745x
+	__setup_cpu_745x, mcheck_7450
     },
     {	/* 82xx (8240, 8245, 8260 are all 603e cores) */
 	0x7fff0000, 0x00810000, "82xx",
@@ -374,7 +375,7 @@
 	CPU_FTR_SPLIT_ID_CACHE | CPU_FTR_CAN_DOZE | CPU_FTR_USE_TB,
 	COMMON_PPC,
 	32, 32,
-	__setup_cpu_603
+	__setup_cpu_603, mcheck_603
     },
     {	/* All G2_LE (603e core, plus some) have the same pvr */
 	0x7fff0000, 0x00820000, "G2_LE",
@@ -382,7 +383,7 @@
 	CPU_FTR_CAN_NAP | CPU_FTR_HAS_HIGH_BATS,
 	COMMON_PPC,
 	32, 32,
-	__setup_cpu_603
+	__setup_cpu_603, mcheck_603
     },
     {	/* default match, we assume split I/D cache & TB (non-601)... */
     	0x00000000, 0x00000000, "(generic PPC)",
diff -Nru a/arch/ppc/kernel/mcheck.h b/arch/ppc/kernel/mcheck.h
--- /dev/null	Wed Dec 31 16:00:00 1969
+++ b/arch/ppc/kernel/mcheck.h	Fri Aug 27 10:57:57 2004
@@ -0,0 +1,17 @@
+/*
+ *  arch/ppc/kernel/mcheck.h
+ *
+ *  Copyright (C) 2004 Humboldt Solutions Ltd.
+ *  Author Adrian Cox <adrian@humboldt.co.uk>
+ *  This program is free software; you can redistribute it and/or
+ *  modify it under the terms of the GNU General Public License
+ *  as published by the Free Software Foundation; either version
+ *  2 of the License, or (at your option) any later version.
+ */
+
+int mcheck_603(struct pt_regs *regs);
+int mcheck_604(struct pt_regs *regs);
+int mcheck_750(struct pt_regs *regs);
+int mcheck_7400(struct pt_regs *regs);
+int mcheck_7450(struct pt_regs *regs);
+
diff -Nru a/arch/ppc/kernel/mcheck_6xx.c b/arch/ppc/kernel/mcheck_6xx.c
--- /dev/null	Wed Dec 31 16:00:00 1969
+++ b/arch/ppc/kernel/mcheck_6xx.c	Fri Aug 27 10:57:57 2004
@@ -0,0 +1,113 @@
+/*
+ *  arch/ppc/kernel/mcheck_6xx.c
+ *
+ *  Copyright (C) 2004 Humboldt Solutions Ltd.
+ *  Author Adrian Cox <adrian@humboldt.co.uk>
+ *  This program is free software; you can redistribute it and/or
+ *  modify it under the terms of the GNU General Public License
+ *  as published by the Free Software Foundation; either version
+ *  2 of the License, or (at your option) any later version.
+ */
+
+#include <linux/interrupt.h>
+#include <linux/config.h>
+#include <linux/init.h>
+#include <linux/kernel.h>
+#include <asm/reg.h>
+
+#include "mcheck.h"
+
+int mcheck_603(struct pt_regs *regs)
+{
+	unsigned long reason = regs->msr;
+	int cause = 0;
+
+	if (reason & 0x00020000)
+		fatal_machine_check("Data bus parity error", regs);
+	if (reason & 0x00010000)
+		fatal_machine_check("Address bus parity error", regs);
+	if (reason & 0x00040000) {
+		printk(KERN_INFO "Received TEA signal\n");
+		cause = 2;
+	}
+	if (reason & 0x00080000) {
+		printk(KERN_EMERG "Received MCP signal\n");
+		cause = 1;
+	}
+	return cause;
+}
+
+int mcheck_604(struct pt_regs *regs)
+{
+	if (regs->msr & 0x00200000)
+		fatal_machine_check("L1 instruction cache error", regs);
+	if (regs->msr & 0x00100000)
+		fatal_machine_check("L1 data cache error", regs);
+	return mcheck_603(regs);
+}
+
+int mcheck_750(struct pt_regs *regs)
+{
+	if (regs->msr & 0x00100000)
+		fatal_machine_check("L2 cache parity error", regs);
+	return mcheck_603(regs);
+}
+
+int mcheck_7400(struct pt_regs *regs)
+{
+	unsigned long reason = regs->msr;
+
+	if (reason & 0x40000000)
+		fatal_machine_check("L1 instruction cache error", regs);
+	if (reason & 0x20000000)
+		fatal_machine_check("L1 data cache error", regs);
+	if (reason & 0x10000000)
+		fatal_machine_check("L2 cache tag error", regs);
+	if (reason & 0x08000000)
+		fatal_machine_check("TLB array error", regs);
+	if (reason & 0x04000000)
+		fatal_machine_check("BHT/BTIC error", regs);
+	if (reason & 0x00200000)
+		fatal_machine_check("Internal error", regs);
+	if (reason & 0x00100000)
+		fatal_machine_check("L2 cache parity error", regs);
+	return mcheck_603(regs);
+}
+
+int mcheck_7450(struct pt_regs *regs)
+{
+	unsigned long reason = regs->msr;
+	int cause = 0;
+
+	if (reason & 0x40000000)
+		fatal_machine_check("L1 instruction cache error", regs);
+	if (reason & 0x20000000)
+		fatal_machine_check("L1 data cache error", regs);
+	if (reason & 0x00100000) {
+		unsigned long msssr0 = mfspr(SPRN_MSSSR0);
+		if (msssr0 & 0x00040000)
+			fatal_machine_check("L2 cache tag parity error", regs);
+		if (msssr0 & 0x00020000)
+			fatal_machine_check("L2 cache data parity error", regs);
+		if (msssr0 & 0x00010000)
+			fatal_machine_check("L3 cache tag parity error", regs);
+		if (msssr0 & 0x00008000)
+			fatal_machine_check("L3 cache data parity error", regs);
+		if (msssr0 & 0x00004000)
+			fatal_machine_check("Address bus parity error", regs);
+		if (msssr0 & 0x00002000)
+			fatal_machine_check("Data bus parity error", regs);
+		if (msssr0 & 0x00001000) {
+			printk(KERN_EMERG "Received MCP signal");
+			cause = 1;
+		}
+	}
+	if (! cause)
+		cause = mcheck_603(regs);
+	/* On 7450, the cause is MCP if no other bit is set */
+	if (! cause) {
+		printk(KERN_EMERG "Received MCP signal\n");
+		cause = 1;
+	}
+	return cause;
+}
diff -Nru a/arch/ppc/kernel/traps.c b/arch/ppc/kernel/traps.c
--- a/arch/ppc/kernel/traps.c	Fri Aug 27 10:57:57 2004
+++ b/arch/ppc/kernel/traps.c	Fri Aug 27 10:57:57 2004
@@ -41,6 +41,7 @@
 #ifdef CONFIG_PMAC_BACKLIGHT
 #include <asm/backlight.h>
 #endif
+#include <asm/cputable.h>

 #ifdef CONFIG_XMON
 void (*debugger)(struct pt_regs *regs) = xmon;
@@ -103,6 +104,19 @@
 	do_exit(err);
 }

+NORET_TYPE void fatal_machine_check(const char * str, struct pt_regs * fp)
+{
+	console_verbose();
+	spin_lock_irq(&die_lock);
+#ifdef CONFIG_PMAC_BACKLIGHT
+	set_backlight_enable(1);
+	set_backlight_level(BACKLIGHT_MAX);
+#endif
+	printk("Fatal machine check\n");
+	show_regs(fp);
+	panic(str);
+}
+
 void _exception(int signr, struct pt_regs *regs, int code, unsigned long addr)
 {
 	siginfo_t info;
@@ -118,55 +132,6 @@
 	force_sig_info(signr, &info, current);
 }

-/*
- * I/O accesses can cause machine checks on powermacs.
- * Check if the NIP corresponds to the address of a sync
- * instruction for which there is an entry in the exception
- * table.
- * Note that the 601 only takes a machine check on TEA
- * (transfer error ack) signal assertion, and does not
- * set any of the top 16 bits of SRR1.
- *  -- paulus.
- */
-static inline int check_io_access(struct pt_regs *regs)
-{
-#ifdef CONFIG_PPC_PMAC
-	unsigned long msr = regs->msr;
-	const struct exception_table_entry *entry;
-	unsigned int *nip = (unsigned int *)regs->nip;
-
-	if (((msr & 0xffff0000) == 0 || (msr & (0x80000 | 0x40000)))
-	    && (entry = search_exception_tables(regs->nip)) != NULL) {
-		/*
-		 * Check that it's a sync instruction, or somewhere
-		 * in the twi; isync; nop sequence that inb/inw/inl uses.
-		 * As the address is in the exception table
-		 * we should be able to read the instr there.
-		 * For the debug message, we look at the preceding
-		 * load or store.
-		 */
-		if (*nip == 0x60000000)		/* nop */
-			nip -= 2;
-		else if (*nip == 0x4c00012c)	/* isync */
-			--nip;
-		if (*nip == 0x7c0004ac || (*nip >> 26) == 3) {
-			/* sync or twi */
-			unsigned int rb;
-
-			--nip;
-			rb = (*nip >> 11) & 0x1f;
-			printk(KERN_DEBUG "%s bad port %lx at %p\n",
-			       (*nip & 0x100)? "OUT to": "IN from",
-			       regs->gpr[rb] - _IO_BASE, nip);
-			regs->msr |= MSR_RI;
-			regs->nip = entry->fixup;
-			return 1;
-		}
-	}
-#endif /* CONFIG_PPC_PMAC */
-	return 0;
-}
-
 #if defined(CONFIG_4xx) || defined(CONFIG_BOOKE)
 /* On 4xx, the reason for the machine check or program exception
    is in the ESR. */
@@ -202,6 +167,13 @@
 void MachineCheckException(struct pt_regs *regs)
 {
 	unsigned long reason = get_mc_reason(regs);
+	int cause = 1; /* Assume external cause until proved otherwise */
+	struct cpu_spec *current_cpu = cur_cpu_spec[smp_processor_id()];
+
+	if (current_cpu->cpu_mcheck && ! (cause = current_cpu->cpu_mcheck(regs)))
+		return;
+	if (cause && ppc_md.mcheck && ! ppc_md.mcheck(regs))
+		return;

 	if (user_mode(regs)) {
 		regs->msr |= MSR_RI;
@@ -209,21 +181,12 @@
 		return;
 	}

-#if defined(CONFIG_8xx) && defined(CONFIG_PCI)
-	/* the qspan pci read routines can cause machine checks -- Cort */
-	bad_page_fault(regs, regs->dar, SIGBUS);
-	return;
-#endif
-
 	if (debugger_fault_handler) {
 		debugger_fault_handler(regs);
 		regs->msr |= MSR_RI;
 		return;
 	}

-	if (check_io_access(regs))
-		return;
-
 #if defined(CONFIG_4xx) && !defined(CONFIG_440A)
 	if (reason & ESR_IMCP) {
 		printk("Instruction");
@@ -292,35 +255,6 @@
 	if (reason & MCSR_BUS_RPERR)
 		printk("Bus - Read Parity Error\n");
 #else /* !CONFIG_4xx && !CONFIG_E500 */
-	printk("Machine check in kernel mode.\n");
-	printk("Caused by (from SRR1=%lx): ", reason);
-	switch (reason & 0x601F0000) {
-	case 0x80000:
-		printk("Machine check signal\n");
-		break;
-	case 0:		/* for 601 */
-	case 0x40000:
-	case 0x140000:	/* 7450 MSS error and TEA */
-		printk("Transfer error ack signal\n");
-		break;
-	case 0x20000:
-		printk("Data parity error signal\n");
-		break;
-	case 0x10000:
-		printk("Address parity error signal\n");
-		break;
-	case 0x20000000:
-		printk("L1 Data Cache error\n");
-		break;
-	case 0x40000000:
-		printk("L1 Instruction Cache error\n");
-		break;
-	case 0x00100000:
-		printk("L2 data cache parity error\n");
-		break;
-	default:
-		printk("Unknown values in msr\n");
-	}
 #endif /* CONFIG_4xx */

 	debugger(regs);
diff -Nru a/arch/ppc/platforms/pmac_setup.c b/arch/ppc/platforms/pmac_setup.c
--- a/arch/ppc/platforms/pmac_setup.c	Fri Aug 27 10:57:57 2004
+++ b/arch/ppc/platforms/pmac_setup.c	Fri Aug 27 10:57:57 2004
@@ -593,6 +593,53 @@
 	return total;
 }

+
+/*
+ * I/O accesses can cause machine checks on powermacs.
+ * Check if the NIP corresponds to the address of a sync
+ * instruction for which there is an entry in the exception
+ * table.
+ * Note that the 601 only takes a machine check on TEA
+ * (transfer error ack) signal assertion, and does not
+ * set any of the top 16 bits of SRR1.
+ *  -- paulus.
+ */
+static int pmac_mcheck(struct pt_regs *regs)
+{
+	const struct exception_table_entry *entry;
+	unsigned int *nip = (unsigned int *)regs->nip;
+
+	if ((! user_mode(regs))
+	    && (entry = search_exception_tables(regs->nip)) != NULL) {
+		/*
+		 * Check that it's a sync instruction, or somewhere
+		 * in the twi; isync; nop sequence that inb/inw/inl uses.
+		 * As the address is in the exception table
+		 * we should be able to read the instr there.
+		 * For the debug message, we look at the preceding
+		 * load or store.
+		 */
+		if (*nip == 0x60000000)		/* nop */
+			nip -= 2;
+		else if (*nip == 0x4c00012c)	/* isync */
+			--nip;
+		if (*nip == 0x7c0004ac || (*nip >> 26) == 3) {
+			/* sync or twi */
+			unsigned int rb;
+
+			--nip;
+			rb = (*nip >> 11) & 0x1f;
+			printk(KERN_DEBUG "%s bad port %lx at %p\n",
+			       (*nip & 0x100)? "OUT to": "IN from",
+			       regs->gpr[rb] - _IO_BASE, nip);
+			regs->msr |= MSR_RI;
+			regs->nip = entry->fixup;
+			return 0;
+		}
+	}
+	return 1;
+}
+
 void __init
 pmac_init(unsigned long r3, unsigned long r4, unsigned long r5,
 	  unsigned long r6, unsigned long r7)
@@ -614,6 +661,8 @@
 	ppc_md.pcibios_fixup  = pmac_pcibios_fixup;
 	ppc_md.pcibios_enable_device_hook = pmac_pci_enable_device_hook;
 	ppc_md.pcibios_after_init = pmac_pcibios_after_init;
+
+	ppc_md.mcheck         = pmac_mcheck;

 	ppc_md.restart        = pmac_restart;
 	ppc_md.power_off      = pmac_power_off;
diff -Nru a/arch/ppc/syslib/qspan_pci.c b/arch/ppc/syslib/qspan_pci.c
--- a/arch/ppc/syslib/qspan_pci.c	Fri Aug 27 10:57:57 2004
+++ b/arch/ppc/syslib/qspan_pci.c	Fri Aug 27 10:57:57 2004
@@ -369,11 +369,21 @@
    /* Lots to do here, all board and configuration specific. */
 }

+static int qspan_mcheck(struct pt_regs *regs)
+{
+	if (! user_mode(regs)) {
+		bad_page_fault(regs, regs->dar, SIGBUS);
+		return 0;
+	}
+	return 1;
+}
+
 void __init
 m8xx_setup_pci_ptrs(void))
 {
 	set_config_access_method(qspan);

 	ppc_md.pcibios_fixup = m8xx_pcibios_fixup;
+	ppc_md.mcheck = qspan_mcheck;
 }

diff -Nru a/include/asm-ppc/cputable.h b/include/asm-ppc/cputable.h
--- a/include/asm-ppc/cputable.h	Fri Aug 27 10:57:57 2004
+++ b/include/asm-ppc/cputable.h	Fri Aug 27 10:57:57 2004
@@ -30,8 +30,10 @@
  * via the mkdefs mecanism.
  */
 struct cpu_spec;
+struct pt_regs;

 typedef	void (*cpu_setup_t)(unsigned long offset, int cpu_nr, struct cpu_spec* spec);
+typedef int (*cpu_mcheck_t)(struct pt_regs *regs);

 struct cpu_spec {
 	/* CPU is matched via (PVR & pvr_mask) == pvr_value */
@@ -50,6 +52,10 @@
 	 * BHT, SPD, etc... from head.S before branching to identify_machine
 	 */
 	cpu_setup_t	cpu_setup;
+	/* this is called when a machine check occurs. It returns 0 if it has handled the machine
+	* check, and a non-zero cause value if not. This may be interpreted by platform specific
+	 * handlers. */
+	cpu_mcheck_t	cpu_mcheck;
 };

 extern struct cpu_spec		cpu_specs[];
diff -Nru a/include/asm-ppc/machdep.h b/include/asm-ppc/machdep.h
--- a/include/asm-ppc/machdep.h	Fri Aug 27 10:57:57 2004
+++ b/include/asm-ppc/machdep.h	Fri Aug 27 10:57:57 2004
@@ -63,6 +63,7 @@
 	void		(*nvram_write_val)(int addr, unsigned char val);
 	void		(*nvram_sync)(void);

+	int		(*mcheck)(struct pt_regs *);
 	/*
 	 * optional PCI "hooks"
 	 */
diff -Nru a/include/asm-ppc/system.h b/include/asm-ppc/system.h
--- a/include/asm-ppc/system.h	Fri Aug 27 10:57:57 2004
+++ b/include/asm-ppc/system.h	Fri Aug 27 10:57:57 2004
@@ -86,6 +86,7 @@
 extern int do_page_fault(struct pt_regs *, unsigned long, unsigned long);
 extern void bad_page_fault(struct pt_regs *, unsigned long, int);
 extern void die(const char *, struct pt_regs *, long);
+NORET_TYPE void fatal_machine_check(const char *, struct pt_regs *);

 struct device_node;
 extern void note_scsi_host(struct device_node *, void *);

--=-ofgE4sE3pft41YjMGBSh--


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/

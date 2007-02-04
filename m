Return-Path: <olof@lixom.net>
Received: from mail.lixom.net (lixom.net [66.141.50.11])
	by ozlabs.org (Postfix) with ESMTP id AFC04DDEC4
	for <linuxppc-dev@ozlabs.org>; Mon,  5 Feb 2007 09:41:51 +1100 (EST)
Message-Id: <20070204223752.500830000@lixom.net>>
References: <20070204223648.767950000@lixom.net>>
Date: Sun, 04 Feb 2007 16:36:51 -0600
From: Olof Johansson <olof@lixom.net>
To: Paul Mackerras <paulus@samba.org>
Subject: [PATCH] [v2] [3/8] pasemi: Idle loops
Cc: linuxppc-dev@ozlabs.org, Arnd Bergmann <arnd@arndb.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Powersave support on PA6T. Right now it only uses 'doze' mode, and
will default to no savings (spin).


Signed-off-by: Olof Johansson <olof@lixom.net>

Index: merge/arch/powerpc/platforms/pasemi/idle.c
===================================================================
--- /dev/null
+++ merge/arch/powerpc/platforms/pasemi/idle.c
@@ -0,0 +1,88 @@
+/*
+ * Copyright (C) 2006-2007 PA Semi, Inc
+ *
+ * Maintained by: Olof Johansson <olof@lixom.net>
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
+ *
+ */
+
+#undef DEBUG
+
+#include <linux/kernel.h>
+#include <linux/string.h>
+
+#include <asm/machdep.h>
+#include <asm/reg.h>
+
+#include "pasemi.h"
+
+struct sleep_mode {
+	char *name;
+	void (*entry)(void);
+};
+
+static struct sleep_mode modes[] = {
+	{ .name = "spin", .entry = &idle_spin },
+	{ .name = "doze", .entry = &idle_doze },
+};
+
+static int current_mode = 0;
+
+static int pasemi_system_reset_exception(struct pt_regs *regs)
+{
+	/* If we were woken up from power savings, we need to return
+	 * to the calling function, since nip is not saved across
+	 * all modes.
+	 */
+
+	if (regs->msr & SRR1_WAKEMASK)
+		regs->nip = regs->link;
+
+	switch (regs->msr & SRR1_WAKEMASK) {
+	case SRR1_WAKEEE:
+		do_IRQ(regs);
+		break;
+	case SRR1_WAKEDEC:
+		timer_interrupt(regs);
+		break;
+	default:
+		/* do system reset */
+		return 0;
+	}
+	/* everything handled */
+	regs->msr |= MSR_RI;
+	return 1;
+}
+
+void __init pasemi_idle_init(void)
+{
+	ppc_md.system_reset_exception = pasemi_system_reset_exception;
+	ppc_md.power_save = modes[current_mode].entry;
+	printk(KERN_INFO "Using PA6T idle loop (%s)\n", modes[current_mode].name);
+}
+
+static int __init idle_param(char *p)
+{
+	int i;
+	for (i = 0; i < sizeof(modes)/sizeof(struct sleep_mode); i++) {
+		if (!strcmp(modes[i].name, p)) {
+			current_mode = i;
+			break;
+		}
+	}
+	return 0;
+}
+
+early_param("idle", idle_param);
Index: merge/arch/powerpc/platforms/pasemi/Makefile
===================================================================
--- merge.orig/arch/powerpc/platforms/pasemi/Makefile
+++ merge/arch/powerpc/platforms/pasemi/Makefile
@@ -1 +1,2 @@
-obj-y	+= setup.o pci.o time.o
+obj-y	+= setup.o pci.o time.o idle.o powersave.o
+
Index: merge/arch/powerpc/platforms/pasemi/setup.c
===================================================================
--- merge.orig/arch/powerpc/platforms/pasemi/setup.c
+++ merge/arch/powerpc/platforms/pasemi/setup.c
@@ -82,7 +82,7 @@ void __init pas_setup_arch(void)
 	conswitchp = &dummy_con;
 #endif
 
-	printk(KERN_DEBUG "Using default idle loop\n");
+	pasemi_idle_init();
 }
 
 /* No legacy IO on our parts */
Index: merge/arch/powerpc/platforms/pasemi/pasemi.h
===================================================================
--- merge.orig/arch/powerpc/platforms/pasemi/pasemi.h
+++ merge/arch/powerpc/platforms/pasemi/pasemi.h
@@ -4,4 +4,11 @@
 extern unsigned long pas_get_boot_time(void);
 extern void pas_pci_init(void);
 
+extern void __init pasemi_idle_init(void);
+
+/* Power savings modes, implemented in asm */
+extern void idle_spin(void);
+extern void idle_doze(void);
+
+
 #endif /* _PASEMI_PASEMI_H */
Index: merge/arch/powerpc/kernel/Makefile
===================================================================
--- merge.orig/arch/powerpc/kernel/Makefile
+++ merge/arch/powerpc/kernel/Makefile
@@ -17,6 +17,7 @@ obj-y				+= vdso32/
 obj-$(CONFIG_PPC64)		+= setup_64.o binfmt_elf32.o sys_ppc32.o \
 				   signal_64.o ptrace32.o \
 				   paca.o cpu_setup_ppc970.o \
+				   cpu_setup_pa6t.o \
 				   firmware.o sysfs.o nvram_64.o
 obj-$(CONFIG_PPC64)		+= vdso64/
 obj-$(CONFIG_ALTIVEC)		+= vecemu.o vector.o
Index: merge/arch/powerpc/kernel/cpu_setup_pa6t.S
===================================================================
--- /dev/null
+++ merge/arch/powerpc/kernel/cpu_setup_pa6t.S
@@ -0,0 +1,44 @@
+/*
+ * Copyright (C) 2006-2007 PA Semi, Inc
+ *
+ * Maintained by: Olof Johansson <olof@lixom.net>
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
+ *
+ */
+
+#include <asm/processor.h>
+#include <asm/page.h>
+#include <asm/cputable.h>
+#include <asm/ppc_asm.h>
+#include <asm/asm-offsets.h>
+#include <asm/cache.h>
+
+/* Right now, restore and setup are the same thing */
+_GLOBAL(__restore_cpu_pa6t)
+_GLOBAL(__setup_cpu_pa6t)
+	/* Do nothing if not running in HV mode */
+	mfmsr	r0
+	rldicl.	r0,r0,4,63
+	beqlr
+
+	mfspr	r0,SPRN_HID5
+	ori	r0,r0,0x30
+	mtspr	SPRN_HID5,r0
+
+	mfspr	r0,SPRN_LPCR
+	ori	r0,r0,0x7000
+	mtspr	SPRN_LPCR,r0
+
+	blr
Index: merge/arch/powerpc/kernel/cputable.c
===================================================================
--- merge.orig/arch/powerpc/kernel/cputable.c
+++ merge/arch/powerpc/kernel/cputable.c
@@ -43,6 +43,8 @@ extern void __setup_cpu_745x(unsigned lo
 #ifdef CONFIG_PPC64
 extern void __setup_cpu_ppc970(unsigned long offset, struct cpu_spec* spec);
 extern void __setup_cpu_ppc970MP(unsigned long offset, struct cpu_spec* spec);
+extern void __setup_cpu_pa6t(unsigned long offset, struct cpu_spec* spec);
+extern void __restore_cpu_pa6t(unsigned long offset, struct cpu_spec* spec);
 extern void __restore_cpu_ppc970(void);
 #endif /* CONFIG_PPC64 */
 
@@ -369,6 +371,8 @@ static struct cpu_spec cpu_specs[] = {
 		.dcache_bsize		= 64,
 		.num_pmcs		= 6,
 		.pmc_type		= PPC_PMC_PA6T,
+		.cpu_setup		= __setup_cpu_pa6t,
+		.cpu_restore		= __restore_cpu_pa6t,
 		.platform		= "pa6t",
 	},
 	{	/* default match */
Index: merge/arch/powerpc/platforms/pasemi/powersave.S
===================================================================
--- /dev/null
+++ merge/arch/powerpc/platforms/pasemi/powersave.S
@@ -0,0 +1,80 @@
+/*
+ * Copyright (C) 2006-2007 PA Semi, Inc
+ *
+ * Maintained by: Olof Johansson <olof@lixom.net>
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
+ *
+ */
+
+#include <asm/processor.h>
+#include <asm/page.h>
+#include <asm/ppc_asm.h>
+#include <asm/cputable.h>
+#include <asm/cache.h>
+#include <asm/thread_info.h>
+#include <asm/asm-offsets.h>
+
+/* Power savings opcodes since not all binutils have them at this time */
+#define DOZE	.long	0x4c000324
+#define NAP	.long	0x4c000364
+#define SLEEP	.long	0x4c0003a4
+#define RVW	.long	0x4c0003e4
+
+/* Common sequence to do before going to any of the
+ * powersavings modes.
+ */
+
+#define PRE_SLEEP_SEQUENCE	\
+	std	r3,8(r1);	\
+	ptesync	;		\
+	ld	r3,8(r1);	\
+1:	cmpd 	r3,r3;		\
+	bne	1b
+
+_doze:
+	PRE_SLEEP_SEQUENCE
+	DOZE
+	b	.
+
+
+_GLOBAL(idle_spin)
+	blr
+
+_GLOBAL(idle_doze)
+	LOAD_REG_ADDR(r3, _doze)
+	b	sleep_common
+
+/* Add more modes here later */
+
+sleep_common:
+	mflr	r0
+	std	r0, 16(r1)
+	stdu	r1,-64(r1)
+
+	LOAD_REG_IMMEDIATE(r6,MSR_DR|MSR_IR|MSR_ME|MSR_EE)
+	mfmsr	r4
+	andc	r5,r4,r6
+	mtmsrd	r5,0
+
+	mtctr	r3
+	bctrl
+
+	mtmsrd	r4,0
+
+	addi	r1,r1,64
+	ld	r0,16(r1)
+	mtlr	r0
+	blr
+
Index: merge/include/asm-powerpc/reg.h
===================================================================
--- merge.orig/include/asm-powerpc/reg.h
+++ merge/include/asm-powerpc/reg.h
@@ -166,6 +166,7 @@
 #define SPRN_TBWU	0x11D	/* Time Base Upper Register (super, R/W) */
 #define SPRN_SPURR	0x134	/* Scaled PURR */
 #define SPRN_HIOR	0x137	/* 970 Hypervisor interrupt offset */
+#define SPRN_LPCR	0x13E	/* LPAR Control Register */
 #define SPRN_DBAT0L	0x219	/* Data BAT 0 Lower Register */
 #define SPRN_DBAT0U	0x218	/* Data BAT 0 Upper Register */
 #define SPRN_DBAT1L	0x21B	/* Data BAT 1 Lower Register */

--

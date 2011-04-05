Return-Path: <benh@kernel.crashing.org>
Received: from e23smtp07.au.ibm.com (e23smtp07.au.ibm.com [202.81.31.140])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e23smtp07.au.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 05898B701D
	for <linuxppc-dev@ozlabs.org>; Tue,  5 Apr 2011 16:14:23 +1000 (EST)
Received: from d23relay03.au.ibm.com (d23relay03.au.ibm.com [202.81.31.245])
	by e23smtp07.au.ibm.com (8.14.4/8.13.1) with ESMTP id p356ELXe018925
	for <linuxppc-dev@ozlabs.org>; Tue, 5 Apr 2011 16:14:21 +1000
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
	by d23relay03.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	p356ELDK1798244
	for <linuxppc-dev@ozlabs.org>; Tue, 5 Apr 2011 16:14:21 +1000
Received: from d23av01.au.ibm.com (loopback [127.0.0.1])
	by d23av01.au.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
	p356EKgp027120
	for <linuxppc-dev@ozlabs.org>; Tue, 5 Apr 2011 16:14:20 +1000
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 04/15] powerpc: Define CPU feature for Architected 2.06 HV mode
Date: Tue,  5 Apr 2011 16:14:00 +1000
Message-Id: <1301984051-18413-5-git-send-email-benh@kernel.crashing.org>
In-Reply-To: <1301984051-18413-1-git-send-email-benh@kernel.crashing.org>
References: <1301984051-18413-1-git-send-email-benh@kernel.crashing.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This bit indicates that we are operating in hypervisor mode on a CPU
compliant to architecture 2.06 or later (currently server only).

We set it on POWER7 and have a boot-time CPU setup function that
clears it if MSR:HV isn't set (booting under a hypervisor).

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---
 arch/powerpc/include/asm/cputable.h    |    3 +-
 arch/powerpc/kernel/Makefile           |    1 +
 arch/powerpc/kernel/cpu_setup_power7.S |   65 ++++++++++++++++++++++++++++++++
 arch/powerpc/kernel/cputable.c         |    6 +++
 4 files changed, 74 insertions(+), 1 deletions(-)
 create mode 100644 arch/powerpc/kernel/cpu_setup_power7.S

diff --git a/arch/powerpc/include/asm/cputable.h b/arch/powerpc/include/asm/cputable.h
index be3cdf9..7d2eb44 100644
--- a/arch/powerpc/include/asm/cputable.h
+++ b/arch/powerpc/include/asm/cputable.h
@@ -181,6 +181,7 @@ extern const char *powerpc_base_platform;
 #define CPU_FTR_SLB			LONG_ASM_CONST(0x0000000100000000)
 #define CPU_FTR_16M_PAGE		LONG_ASM_CONST(0x0000000200000000)
 #define CPU_FTR_TLBIEL			LONG_ASM_CONST(0x0000000400000000)
+#define CPU_FTR_HVMODE_206		LONG_ASM_CONST(0x0000000800000000)
 #define CPU_FTR_IABR			LONG_ASM_CONST(0x0000002000000000)
 #define CPU_FTR_MMCRA			LONG_ASM_CONST(0x0000004000000000)
 #define CPU_FTR_CTRL			LONG_ASM_CONST(0x0000008000000000)
@@ -416,7 +417,7 @@ extern const char *powerpc_base_platform;
 	    CPU_FTR_DSCR | CPU_FTR_UNALIGNED_LD_STD | \
 	    CPU_FTR_STCX_CHECKS_ADDRESS | CPU_FTR_POPCNTB)
 #define CPU_FTRS_POWER7 (CPU_FTR_USE_TB | CPU_FTR_LWSYNC | \
-	    CPU_FTR_PPCAS_ARCH_V2 | CPU_FTR_CTRL | \
+	    CPU_FTR_PPCAS_ARCH_V2 | CPU_FTR_CTRL | CPU_FTR_HVMODE_206 |\
 	    CPU_FTR_MMCRA | CPU_FTR_SMT | \
 	    CPU_FTR_COHERENT_ICACHE | CPU_FTR_LOCKLESS_TLBIE | \
 	    CPU_FTR_PURR | CPU_FTR_SPURR | CPU_FTR_REAL_LE | \
diff --git a/arch/powerpc/kernel/Makefile b/arch/powerpc/kernel/Makefile
index 3bb2a3e..7c6eb49 100644
--- a/arch/powerpc/kernel/Makefile
+++ b/arch/powerpc/kernel/Makefile
@@ -38,6 +38,7 @@ obj-$(CONFIG_PPC64)		+= setup_64.o sys_ppc32.o \
 				   paca.o nvram_64.o firmware.o
 obj-$(CONFIG_HAVE_HW_BREAKPOINT)	+= hw_breakpoint.o
 obj-$(CONFIG_PPC_BOOK3S_64)	+= cpu_setup_ppc970.o cpu_setup_pa6t.o
+obj-$(CONFIG_PPC_BOOK3S_64)	+= cpu_setup_power7.o
 obj64-$(CONFIG_RELOCATABLE)	+= reloc_64.o
 obj-$(CONFIG_PPC_BOOK3E_64)	+= exceptions-64e.o idle_book3e.o
 obj-$(CONFIG_PPC64)		+= vdso64/
diff --git a/arch/powerpc/kernel/cpu_setup_power7.S b/arch/powerpc/kernel/cpu_setup_power7.S
new file mode 100644
index 0000000..f2b3178
--- /dev/null
+++ b/arch/powerpc/kernel/cpu_setup_power7.S
@@ -0,0 +1,65 @@
+/*
+ * This file contains low level CPU setup functions.
+ *    Copyright (C) 2003 Benjamin Herrenschmidt (benh@kernel.crashing.org)
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version
+ * 2 of the License, or (at your option) any later version.
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
+/* Entry: r3 = crap, r4 = ptr to cputable entry
+ *
+ * Note that we can be called twice for pseudo-PVRs
+ */
+_GLOBAL(__setup_cpu_power7)
+	mflr	r11
+	bl	__init_hvmode_206
+	mtlr	r11
+	beqlr
+	bl	__init_LPCR
+	mtlr	r11
+	blr
+
+_GLOBAL(__restore_cpu_power7)
+	mflr	r11
+	mfmsr	r3
+	rldicl.	r0,r3,4,63
+	beqlr
+	bl	__init_LPCR
+	mtlr	r11
+	blr
+
+__init_hvmode_206:
+	/* Disable CPU_FTR_HVMODE_206 and exit if MSR:HV is not set */
+	mfmsr	r3
+	rldicl.	r0,r3,4,63
+	bnelr
+	ld	r5,CPU_SPEC_FEATURES(r4)
+	LOAD_REG_IMMEDIATE(r6,CPU_FTR_HVMODE_206)
+	xor	r5,r5,r6
+	std	r5,CPU_SPEC_FEATURES(r4)
+	blr
+
+__init_LPCR:
+	/* Setup a sane LPCR:
+	 *
+	 *   LPES = 0b11 (SRR0/1 used for 0x500)
+	 *   PECE = 0b111
+	 *
+	 * Other bits untouched for now
+	 */
+	mfspr	r3,SPRN_LPCR
+	ori	r3,r3,(LPCR_LPES0|LPCR_LPES1)
+	ori	r3,r3,(LPCR_PECE0|LPCR_PECE1|LPCR_PECE2)
+	mtspr	SPRN_LPCR,r3
+	isync
+	blr
diff --git a/arch/powerpc/kernel/cputable.c b/arch/powerpc/kernel/cputable.c
index c9b68d0..867ae30 100644
--- a/arch/powerpc/kernel/cputable.c
+++ b/arch/powerpc/kernel/cputable.c
@@ -423,6 +423,8 @@ static struct cpu_spec __initdata cpu_specs[] = {
 		.dcache_bsize		= 128,
 		.oprofile_type		= PPC_OPROFILE_POWER4,
 		.oprofile_cpu_type	= "ppc64/ibm-compat-v1",
+		.cpu_setup		= __setup_cpu_power7,
+		.cpu_restore		= __restore_cpu_power7,
 		.platform		= "power7",
 	},
 	{	/* Power7 */
@@ -439,6 +441,8 @@ static struct cpu_spec __initdata cpu_specs[] = {
 		.pmc_type		= PPC_PMC_IBM,
 		.oprofile_cpu_type	= "ppc64/power7",
 		.oprofile_type		= PPC_OPROFILE_POWER4,
+		.cpu_setup		= __setup_cpu_power7,
+		.cpu_restore		= __restore_cpu_power7,
 		.platform		= "power7",
 	},
 	{	/* Power7+ */
@@ -455,6 +459,8 @@ static struct cpu_spec __initdata cpu_specs[] = {
 		.pmc_type		= PPC_PMC_IBM,
 		.oprofile_cpu_type	= "ppc64/power7",
 		.oprofile_type		= PPC_OPROFILE_POWER4,
+		.cpu_setup		= __setup_cpu_power7,
+		.cpu_restore		= __restore_cpu_power7,
 		.platform		= "power7+",
 	},
 	{	/* Cell Broadband Engine */
-- 
1.7.1

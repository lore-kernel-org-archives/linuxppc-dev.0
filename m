Return-Path: <benh@kernel.crashing.org>
Received: from e23smtp02.au.ibm.com (e23smtp02.au.ibm.com [202.81.31.144])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e23smtp02.au.ibm.com",
	Issuer "GeoTrust SSL CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 5C8A0B7006
	for <linuxppc-dev@ozlabs.org>; Tue,  5 Apr 2011 16:14:22 +1000 (EST)
Received: from d23relay04.au.ibm.com (d23relay04.au.ibm.com [202.81.31.246])
	by e23smtp02.au.ibm.com (8.14.4/8.13.1) with ESMTP id p3568qV3024679
	for <linuxppc-dev@ozlabs.org>; Tue, 5 Apr 2011 16:08:52 +1000
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
	by d23relay04.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	p356ELHm1450204
	for <linuxppc-dev@ozlabs.org>; Tue, 5 Apr 2011 16:14:21 +1000
Received: from d23av04.au.ibm.com (loopback [127.0.0.1])
	by d23av04.au.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
	p356ELYl004184
	for <linuxppc-dev@ozlabs.org>; Tue, 5 Apr 2011 16:14:21 +1000
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 13/15] powerpc: Add NAP mode support on Power7 in HV mode
Date: Tue,  5 Apr 2011 16:14:09 +1000
Message-Id: <1301984051-18413-14-git-send-email-benh@kernel.crashing.org>
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

Wakeup comes from the system reset handler with a potential loss of
the non-hypervisor CPU state. We save the non-volatile state on the
stack and a pointer to it in the PACA, which the system reset handler
uses to restore things

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---
 arch/powerpc/include/asm/machdep.h    |    1 +
 arch/powerpc/include/asm/paca.h       |    2 +-
 arch/powerpc/include/asm/ppc-opcode.h |    6 ++
 arch/powerpc/kernel/Makefile          |    1 +
 arch/powerpc/kernel/exceptions-64s.S  |   30 ++++++++++-
 arch/powerpc/kernel/idle_power7.S     |   97 +++++++++++++++++++++++++++++++++
 arch/powerpc/platforms/Kconfig        |    4 ++
 7 files changed, 139 insertions(+), 2 deletions(-)
 create mode 100644 arch/powerpc/kernel/idle_power7.S

diff --git a/arch/powerpc/include/asm/machdep.h b/arch/powerpc/include/asm/machdep.h
index e4f0191..493dbb3 100644
--- a/arch/powerpc/include/asm/machdep.h
+++ b/arch/powerpc/include/asm/machdep.h
@@ -267,6 +267,7 @@ struct machdep_calls {
 
 extern void e500_idle(void);
 extern void power4_idle(void);
+extern void power7_idle(void);
 extern void ppc6xx_idle(void);
 extern void book3e_idle(void);
 
diff --git a/arch/powerpc/include/asm/paca.h b/arch/powerpc/include/asm/paca.h
index ec57540..f6da4f5 100644
--- a/arch/powerpc/include/asm/paca.h
+++ b/arch/powerpc/include/asm/paca.h
@@ -125,7 +125,7 @@ struct paca_struct {
 	struct task_struct *__current;	/* Pointer to current */
 	u64 kstack;			/* Saved Kernel stack addr */
 	u64 stab_rr;			/* stab/slb round-robin counter */
-	u64 saved_r1;			/* r1 save for RTAS calls */
+	u64 saved_r1;			/* r1 save for RTAS calls or PM */
 	u64 saved_msr;			/* MSR saved here by enter_rtas */
 	u16 trap_save;			/* Used when bad stack is encountered */
 	u8 soft_enabled;		/* irq soft-enable flag */
diff --git a/arch/powerpc/include/asm/ppc-opcode.h b/arch/powerpc/include/asm/ppc-opcode.h
index 1255569..384a96d 100644
--- a/arch/powerpc/include/asm/ppc-opcode.h
+++ b/arch/powerpc/include/asm/ppc-opcode.h
@@ -56,6 +56,9 @@
 #define PPC_INST_TLBSRX_DOT		0x7c0006a5
 #define PPC_INST_XXLOR			0xf0000510
 
+#define PPC_INST_NAP			0x4c000364
+#define PPC_INST_SLEEP			0x4c0003a4
+
 /* macros to insert fields into opcodes */
 #define __PPC_RA(a)	(((a) & 0x1f) << 16)
 #define __PPC_RB(b)	(((b) & 0x1f) << 11)
@@ -126,4 +129,7 @@
 #define XXLOR(t, a, b)		stringify_in_c(.long PPC_INST_XXLOR | \
 					       VSX_XX3((t), (a), (b)))
 
+#define PPC_NAP			stringify_in_c(.long PPC_INST_NAP)
+#define PPC_SLEEP		stringify_in_c(.long PPC_INST_SLEEP)
+
 #endif /* _ASM_POWERPC_PPC_OPCODE_H */
diff --git a/arch/powerpc/kernel/Makefile b/arch/powerpc/kernel/Makefile
index 7c6eb49..0fd6273 100644
--- a/arch/powerpc/kernel/Makefile
+++ b/arch/powerpc/kernel/Makefile
@@ -44,6 +44,7 @@ obj-$(CONFIG_PPC_BOOK3E_64)	+= exceptions-64e.o idle_book3e.o
 obj-$(CONFIG_PPC64)		+= vdso64/
 obj-$(CONFIG_ALTIVEC)		+= vecemu.o
 obj-$(CONFIG_PPC_970_NAP)	+= idle_power4.o
+obj-$(CONFIG_PPC_P7_NAP)	+= idle_power7.o
 obj-$(CONFIG_PPC_OF)		+= of_platform.o prom_parse.o
 obj-$(CONFIG_PPC_CLOCK)		+= clock.o
 procfs-y			:= proc_powerpc.o
diff --git a/arch/powerpc/kernel/exceptions-64s.S b/arch/powerpc/kernel/exceptions-64s.S
index 0c50a52..a6ead27 100644
--- a/arch/powerpc/kernel/exceptions-64s.S
+++ b/arch/powerpc/kernel/exceptions-64s.S
@@ -37,7 +37,35 @@
 	.globl __start_interrupts
 __start_interrupts:
 
-	STD_EXCEPTION_PSERIES(0x100, 0x100, system_reset)
+	.globl system_reset_pSeries;
+system_reset_pSeries:
+	HMT_MEDIUM;
+	DO_KVM	0x100;
+	SET_SCRATCH0(r13)
+#ifdef CONFIG_PPC_P7_NAP
+BEGIN_FTR_SECTION
+	/* Running native on arch 2.06 or later, check if we are
+	 * waking up from nap. We only handle no state loss and
+	 * supervisor state loss. We do -not- handle hypervisor
+	 * state loss at this time.
+	 */
+	mfspr	r13,SPRN_SRR1
+	rlwinm	r13,r13,47-31,30,31
+	cmpwi	cr0,r13,1
+	bne	1f
+	b	.power7_wakeup_noloss
+1:	cmpwi	cr0,r13,2
+	bne	1f
+	b	.power7_wakeup_loss
+	/* Total loss of HV state is fatal, we could try to use the
+	 * PIR to locate a PACA, then use an emergency stack etc...
+	 * but for now, let's just stay stuck here
+	 */
+1:	cmpwi	cr0,r13,3
+	beq	.
+END_FTR_SECTION_IFSET(CPU_FTR_HVMODE_206)
+#endif /* CONFIG_PPC_P7_NAP */
+	EXCEPTION_PROLOG_PSERIES(PACA_EXGEN, system_reset_common, EXC_STD)
 
 	. = 0x200
 _machine_check_pSeries:
diff --git a/arch/powerpc/kernel/idle_power7.S b/arch/powerpc/kernel/idle_power7.S
new file mode 100644
index 0000000..f8f0bc7
--- /dev/null
+++ b/arch/powerpc/kernel/idle_power7.S
@@ -0,0 +1,97 @@
+/*
+ *  This file contains the power_save function for 970-family CPUs.
+ *
+ *  This program is free software; you can redistribute it and/or
+ *  modify it under the terms of the GNU General Public License
+ *  as published by the Free Software Foundation; either version
+ *  2 of the License, or (at your option) any later version.
+ */
+
+#include <linux/threads.h>
+#include <asm/processor.h>
+#include <asm/page.h>
+#include <asm/cputable.h>
+#include <asm/thread_info.h>
+#include <asm/ppc_asm.h>
+#include <asm/asm-offsets.h>
+#include <asm/ppc-opcode.h>
+
+#undef DEBUG
+
+	.text
+
+_GLOBAL(power7_idle)
+	/* Now check if user or arch enabled NAP mode */
+	LOAD_REG_ADDRBASE(r3,powersave_nap)
+	lwz	r4,ADDROFF(powersave_nap)(r3)
+	cmpwi	0,r4,0
+	beqlr
+
+	/* NAP is a state loss, we create a regs frame on the
+	 * stack, fill it up with the state we care about and
+	 * stick a pointer to it in PACAR1. We really only
+	 * need to save PC, some CR bits and the NV GPRs,
+	 * but for now an interrupt frame will do.
+	 */
+	mflr	r0
+	std	r0,16(r1)
+	stdu	r1,-INT_FRAME_SIZE(r1)
+	std	r0,_LINK(r1)
+	std	r0,_NIP(r1)
+
+#ifndef CONFIG_SMP
+	/* Make sure FPU, VSX etc... are flushed as we may lose
+	 * state when going to nap mode
+	 */
+	bl	.discard_lazy_cpu_state
+#endif /* CONFIG_SMP */
+
+	/* Hard disable interrupts */
+	mfmsr	r9
+	rldicl	r9,r9,48,1
+	rotldi	r9,r9,16
+	mtmsrd	r9,1			/* hard-disable interrupts */
+	li	r0,0
+	stb	r0,PACASOFTIRQEN(r13)	/* we'll hard-enable shortly */
+	stb	r0,PACAHARDIRQEN(r13)
+
+	/* Continue saving state */
+	SAVE_GPR(2, r1)
+	SAVE_NVGPRS(r1)
+	mfcr	r3
+	std	r3,_CCR(r1)
+	std	r9,_MSR(r1)
+	std	r1,PACAR1(r13)
+
+	/* Magic NAP mode enter sequence */
+	std	r0,0(r1)
+	ptesync
+	ld	r0,0(r1)
+1:	cmp	cr0,r0,r0
+	bne	1b
+	PPC_NAP
+	b	.
+
+_GLOBAL(power7_wakeup_loss)
+	GET_PACA(r13)
+	ld	r1,PACAR1(r13)
+	REST_NVGPRS(r1)
+	REST_GPR(2, r1)
+	ld	r3,_CCR(r1)
+	ld	r4,_MSR(r1)
+	ld	r5,_NIP(r1)
+	addi	r1,r1,INT_FRAME_SIZE
+	mtcr	r3
+	mtspr	SPRN_SRR1,r4
+	mtspr	SPRN_SRR0,r5
+	rfid
+
+_GLOBAL(power7_wakeup_noloss)
+	GET_PACA(r13)
+	ld	r1,PACAR1(r13)
+	ld	r4,_MSR(r1)
+	ld	r5,_NIP(r1)
+	addi	r1,r1,INT_FRAME_SIZE
+	mtspr	SPRN_SRR1,r4
+	mtspr	SPRN_SRR0,r5
+	rfid
diff --git a/arch/powerpc/platforms/Kconfig b/arch/powerpc/platforms/Kconfig
index 2057682..59eeb77 100644
--- a/arch/powerpc/platforms/Kconfig
+++ b/arch/powerpc/platforms/Kconfig
@@ -147,6 +147,10 @@ config PPC_970_NAP
 	bool
 	default n
 
+config PPC_P7_NAP
+	bool
+	default n
+
 config PPC_INDIRECT_IO
 	bool
 	select GENERIC_IOMAP
-- 
1.7.1

Return-Path: <mikey@neuling.org>
From: Michael Neuling <mikey@neuling.org>
To: benh@kernel.crashing.org
MIME-Version: 1.0
Subject: [PATCH] powerpc: add denormalisation exception handling for POWER6/7
Date: Mon, 11 Jul 2011 15:52:18 +1000
Message-ID: <11738.1310363538@neuling.org>
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>, miltonm@bga.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On POWER6 and POWER7 if the input operand to an instruction is a
denormalised single precision binary floating we can take a
denormalisation exception where it's expected that the hypervisor (HV=1)
will fix up the inputs before the instruction is run.

This adds code to handle this denormalisation exception for POWER6 and
POWER7.

It also add a CONFIG_PPC_DENORMALISATION option and sets it in
pseries/ppc64_defconfig. 

This is useful on bare metal systems only.  Based on patch from Milton
Miller.

Signed-off-by: Michael Neuling <mikey@neuling.org>

---
 arch/powerpc/Kconfig                   |    7 +
 arch/powerpc/configs/ppc64_defconfig   |    1 
 arch/powerpc/configs/pseries_defconfig |    1 
 arch/powerpc/include/asm/ppc-opcode.h  |    2 
 arch/powerpc/include/asm/reg.h         |    1 
 arch/powerpc/kernel/exceptions-64s.S   |  125 +++++++++++++++++++++++++++++++++
 6 files changed, 137 insertions(+)

Index: linux-ozlabs/arch/powerpc/Kconfig
===================================================================
--- linux-ozlabs.orig/arch/powerpc/Kconfig
+++ linux-ozlabs/arch/powerpc/Kconfig
@@ -556,6 +556,13 @@ config SCHED_SMT
 	  when dealing with POWER5 cpus at a cost of slightly increased
 	  overhead in some places. If unsure say N here.
 
+config PPC_DENORMALISATION
+	bool "PowerPC denormalisation exception handling"
+	default "n"
+	---help---
+	  Add support for handling denormalisation of single precision
+	  values.  Useful for bare metal only.  If unsure say Y here.
+
 config CMDLINE_BOOL
 	bool "Default bootloader kernel arguments"
 
Index: linux-ozlabs/arch/powerpc/configs/ppc64_defconfig
===================================================================
--- linux-ozlabs.orig/arch/powerpc/configs/ppc64_defconfig
+++ linux-ozlabs/arch/powerpc/configs/ppc64_defconfig
@@ -54,6 +54,7 @@ CONFIG_KEXEC=y
 CONFIG_IRQ_ALL_CPUS=y
 CONFIG_MEMORY_HOTREMOVE=y
 CONFIG_SCHED_SMT=y
+CONFIG_PPC_DENORMALISATION=y
 CONFIG_PCCARD=y
 CONFIG_ELECTRA_CF=y
 CONFIG_HOTPLUG_PCI=m
Index: linux-ozlabs/arch/powerpc/configs/pseries_defconfig
===================================================================
--- linux-ozlabs.orig/arch/powerpc/configs/pseries_defconfig
+++ linux-ozlabs/arch/powerpc/configs/pseries_defconfig
@@ -47,6 +47,7 @@ CONFIG_MEMORY_HOTREMOVE=y
 CONFIG_PPC_64K_PAGES=y
 CONFIG_PPC_SUBPAGE_PROT=y
 CONFIG_SCHED_SMT=y
+CONFIG_PPC_DENORMALISATION=y
 CONFIG_HOTPLUG_PCI=m
 CONFIG_HOTPLUG_PCI_RPA=m
 CONFIG_HOTPLUG_PCI_RPA_DLPAR=m
Index: linux-ozlabs/arch/powerpc/include/asm/ppc-opcode.h
===================================================================
--- linux-ozlabs.orig/arch/powerpc/include/asm/ppc-opcode.h
+++ linux-ozlabs/arch/powerpc/include/asm/ppc-opcode.h
@@ -157,6 +157,8 @@
 					       VSX_XX1((s), (a), (b)))
 #define XXLOR(t, a, b)		stringify_in_c(.long PPC_INST_XXLOR | \
 					       VSX_XX3((t), (a), (b)))
+#define XVCPSGNDP(t, a, b)	stringify_in_c(.long (0xf0000780 | \
+					       VSX_XX3((t), (a), (b))))
 
 #define PPC_NAP			stringify_in_c(.long PPC_INST_NAP)
 #define PPC_SLEEP		stringify_in_c(.long PPC_INST_SLEEP)
Index: linux-ozlabs/arch/powerpc/include/asm/reg.h
===================================================================
--- linux-ozlabs.orig/arch/powerpc/include/asm/reg.h
+++ linux-ozlabs/arch/powerpc/include/asm/reg.h
@@ -496,6 +496,7 @@
 
 #define SPRN_HSRR0	0x13A	/* Save/Restore Register 0 */
 #define SPRN_HSRR1	0x13B	/* Save/Restore Register 1 */
+#define   HSRR1_DENORM		0x00100000 /* Denorm exception */
 
 #define SPRN_TBCTL	0x35f	/* PA6T Timebase control register */
 #define   TBCTL_FREEZE		0x0000000000000000ull /* Freeze all tbs */
Index: linux-ozlabs/arch/powerpc/kernel/exceptions-64s.S
===================================================================
--- linux-ozlabs.orig/arch/powerpc/kernel/exceptions-64s.S
+++ linux-ozlabs/arch/powerpc/kernel/exceptions-64s.S
@@ -264,6 +264,31 @@ vsx_unavailable_pSeries_1:
 	STD_EXCEPTION_HV(0x1200, 0x1202, cbe_system_error)
 #endif /* CONFIG_CBE_RAS */
 	STD_EXCEPTION_PSERIES(0x1300, 0x1300, instruction_breakpoint)
+
+#ifdef CONFIG_PPC_DENORMALISATION
+	. = 0x1500
+	.global denorm_Hypervisor
+denorm_Hypervisor:
+	HMT_MEDIUM
+	mtspr	SPRN_SPRG_HSCRATCH0,r13
+	mfspr	r13,SPRN_SPRG_HPACA
+	std	r9,PACA_EXGEN+EX_R9(r13)
+	std	r10,PACA_EXGEN+EX_R10(r13)
+	std	r11,PACA_EXGEN+EX_R11(r13)
+	std	r12,PACA_EXGEN+EX_R12(r13)
+	mfspr	r9,SPRN_SPRG_HSCRATCH0
+	std	r9,PACA_EXGEN+EX_R13(r13)
+	mfcr	r9
+
+	mfspr	r10,SPRN_HSRR1
+	mfspr	r11,SPRN_HSRR0		/* save HSRR0 */
+	andis.	r10,r10,(HSRR1_DENORM)@h /* denorm? */
+	addi	r11,r11,-4		/* HSRR0 is next instruction */
+	bne+	denorm_assist
+
+	EXCEPTION_PROLOG_PSERIES_1(denorm_common, EXC_HV)
+#endif
+
 #ifdef CONFIG_CBE_RAS
 	STD_EXCEPTION_HV(0x1600, 0x1602, cbe_maintenance)
 #endif /* CONFIG_CBE_RAS */
@@ -317,6 +342,103 @@ masked_Hinterrupt:
 	hrfid
 	b	.
 
+#ifdef CONFIG_PPC_DENORMALISATION
+denorm_assist:
+BEGIN_FTR_SECTION
+/*
+ * To denormalise we need to move a copy of the register to itself.
+ * For POWER6 do that here for all FP regs.
+ */
+	mfmsr	r10
+	ori	r10,r10,(MSR_FP|MSR_FE0|MSR_FE1)
+	xori	r10,r10,(MSR_FE0|MSR_FE1)
+	mtmsrd	r10
+	sync
+	fmr	0,0
+	fmr	1,1
+	fmr	2,2
+	fmr	3,3
+	fmr	4,4
+	fmr	5,5
+	fmr	6,6
+	fmr	7,7
+	fmr	8,8
+	fmr	9,9
+	fmr	10,10
+	fmr	11,11
+	fmr	12,12
+	fmr	13,13
+	fmr	14,14
+	fmr	15,15
+	fmr	16,16
+	fmr	17,17
+	fmr	18,18
+	fmr	19,19
+	fmr	20,20
+	fmr	21,21
+	fmr	22,22
+	fmr	23,23
+	fmr	24,24
+	fmr	25,25
+	fmr	26,26
+	fmr	27,27
+	fmr	28,28
+	fmr	29,29
+	fmr	30,30
+	fmr	31,31
+FTR_SECTION_ELSE
+/*
+ * To denormalise we need to move a copy of the register to itself.
+ * For POWER7 do that here for the first 32 VSX registers only.
+ */
+	mfmsr	r10
+	oris	r10,r10,MSR_VSX@h
+	mtmsrd	r10
+	sync
+	XVCPSGNDP(0,0,0)
+	XVCPSGNDP(1,1,1)
+	XVCPSGNDP(2,2,2)
+	XVCPSGNDP(3,3,3)
+	XVCPSGNDP(4,4,4)
+	XVCPSGNDP(5,5,5)
+	XVCPSGNDP(6,6,6)
+	XVCPSGNDP(7,7,7)
+	XVCPSGNDP(8,8,8)
+	XVCPSGNDP(9,9,9)
+	XVCPSGNDP(10,10,10)
+	XVCPSGNDP(11,11,11)
+	XVCPSGNDP(12,12,12)
+	XVCPSGNDP(13,13,13)
+	XVCPSGNDP(14,14,14)
+	XVCPSGNDP(15,15,15)
+	XVCPSGNDP(16,16,16)
+	XVCPSGNDP(17,17,17)
+	XVCPSGNDP(18,18,18)
+	XVCPSGNDP(19,19,19)
+	XVCPSGNDP(20,20,20)
+	XVCPSGNDP(21,21,21)
+	XVCPSGNDP(22,22,22)
+	XVCPSGNDP(23,23,23)
+	XVCPSGNDP(24,24,24)
+	XVCPSGNDP(25,25,25)
+	XVCPSGNDP(26,26,26)
+	XVCPSGNDP(27,27,27)
+	XVCPSGNDP(28,28,28)
+	XVCPSGNDP(29,29,29)
+	XVCPSGNDP(30,30,30)
+	XVCPSGNDP(31,31,31)
+ALT_FTR_SECTION_END_IFCLR(CPU_FTR_HVMODE_206)
+	mtspr	SPRN_HSRR0,r11
+	mtcrf	0x80,r9
+	ld	r9,PACA_EXGEN+EX_R9(r13)
+	ld	r10,PACA_EXGEN+EX_R10(r13)
+	ld	r11,PACA_EXGEN+EX_R11(r13)
+	ld	r12,PACA_EXGEN+EX_R12(r13)
+	ld	r13,PACA_EXGEN+EX_R13(r13)
+	HRFID
+	b	.
+#endif
+
 	.align	7
 do_stab_bolted_pSeries:
 	std	r11,PACA_EXSLB+EX_R11(r13)
@@ -419,6 +541,9 @@ machine_check_common:
         STD_EXCEPTION_COMMON(0xe60, hmi_exception, .unknown_exception)
 	STD_EXCEPTION_COMMON_IDLE(0xf00, performance_monitor, .performance_monitor_exception)
 	STD_EXCEPTION_COMMON(0x1300, instruction_breakpoint, .instruction_breakpoint_exception)
+#ifdef CONFIG_PPC_DENORMALISATION
+	STD_EXCEPTION_COMMON(0x1502, denorm, .unknown_exception)
+#endif
 #ifdef CONFIG_ALTIVEC
 	STD_EXCEPTION_COMMON(0x1700, altivec_assist, .altivec_assist_exception)
 #else

Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id F0909DDE01
	for <linuxppc-dev@ozlabs.org>; Tue, 29 Jan 2008 01:46:54 +1100 (EST)
Received: from localhost (localhost.localdomain [127.0.0.1])
	by gate.crashing.org (8.13.8/8.13.8) with ESMTP id m0SEkoKN013509
	for <linuxppc-dev@ozlabs.org>; Mon, 28 Jan 2008 08:46:50 -0600
Date: Mon, 28 Jan 2008 08:44:23 -0600 (CST)
From: Kumar Gala <galak@kernel.crashing.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] [PPC] Remove 85xx from arch/ppc
Message-ID: <Pine.LNX.4.64.0801280844050.19758@blarg.am.freescale.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

85xx exists in arch/powerpc as well as cuImage support to boot from
a u-boot that doesn't support device trees.

---
 arch/ppc/Kconfig                             |   51 +-
 arch/ppc/Makefile                            |    8 -
 arch/ppc/configs/TQM8540_defconfig           |  973 -----------------------
 arch/ppc/configs/TQM8541_defconfig           |  986 ------------------------
 arch/ppc/configs/TQM8555_defconfig           |  983 ------------------------
 arch/ppc/configs/TQM8560_defconfig           |  992 ------------------------
 arch/ppc/configs/mpc8540_ads_defconfig       |  706 -----------------
 arch/ppc/configs/mpc8548_cds_defconfig       |  658 ----------------
 arch/ppc/configs/mpc8555_cds_defconfig       |  784 -------------------
 arch/ppc/configs/mpc8560_ads_defconfig       |  769 -------------------
 arch/ppc/configs/stx_gp3_defconfig           |  989 ------------------------
 arch/ppc/kernel/Makefile                     |    1 -
 arch/ppc/kernel/asm-offsets.c                |    6 -
 arch/ppc/kernel/entry.S                      |   12 +-
 arch/ppc/kernel/head_booke.h                 |   55 --
 arch/ppc/kernel/head_fsl_booke.S             | 1065 --------------------------
 arch/ppc/kernel/misc.S                       |   46 +--
 arch/ppc/kernel/ppc_ksyms.c                  |    8 +-
 arch/ppc/kernel/setup.c                      |    3 +-
 arch/ppc/kernel/traps.c                      |  121 ---
 arch/ppc/mm/Makefile                         |    1 -
 arch/ppc/mm/fsl_booke_mmu.c                  |  236 ------
 arch/ppc/mm/init.c                           |    6 -
 arch/ppc/mm/mmu_decl.h                       |    6 -
 arch/ppc/mm/pgtable.c                        |   28 -
 arch/ppc/platforms/85xx/Kconfig              |  106 ---
 arch/ppc/platforms/85xx/Makefile             |   13 -
 arch/ppc/platforms/85xx/mpc8540_ads.c        |  226 ------
 arch/ppc/platforms/85xx/mpc8540_ads.h        |   22 -
 arch/ppc/platforms/85xx/mpc8555_cds.h        |   23 -
 arch/ppc/platforms/85xx/mpc8560_ads.c        |  303 --------
 arch/ppc/platforms/85xx/mpc8560_ads.h        |   24 -
 arch/ppc/platforms/85xx/mpc85xx_ads_common.c |  197 -----
 arch/ppc/platforms/85xx/mpc85xx_ads_common.h |   67 --
 arch/ppc/platforms/85xx/mpc85xx_cds_common.c |  601 ---------------
 arch/ppc/platforms/85xx/mpc85xx_cds_common.h |   80 --
 arch/ppc/platforms/85xx/sbc8560.c            |  234 ------
 arch/ppc/platforms/85xx/sbc8560.h            |   47 --
 arch/ppc/platforms/85xx/sbc85xx.c            |  166 ----
 arch/ppc/platforms/85xx/sbc85xx.h            |   70 --
 arch/ppc/platforms/85xx/stx_gp3.c            |  339 --------
 arch/ppc/platforms/85xx/stx_gp3.h            |   69 --
 arch/ppc/platforms/85xx/tqm85xx.c            |  412 ----------
 arch/ppc/platforms/85xx/tqm85xx.h            |   53 --
 arch/ppc/syslib/Makefile                     |    8 -
 arch/ppc/syslib/mpc85xx_devices.c            |  826 --------------------
 arch/ppc/syslib/mpc85xx_sys.c                |  233 ------
 arch/ppc/syslib/ocp.c                        |    2 +-
 arch/ppc/syslib/open_pic.c                   |    2 +-
 arch/ppc/syslib/ppc85xx_common.c             |   38 -
 arch/ppc/syslib/ppc85xx_common.h             |   22 -
 arch/ppc/syslib/ppc85xx_setup.c              |  367 ---------
 arch/ppc/syslib/ppc85xx_setup.h              |   56 --
 include/asm-powerpc/irq.h                    |  121 ---
 include/asm-ppc/cpm2.h                       |    2 +-
 include/asm-ppc/immap_85xx.h                 |  126 ---
 include/asm-ppc/mmu_context.h                |    5 -
 include/asm-ppc/mpc85xx.h                    |  192 -----
 include/asm-ppc/pgtable.h                    |   46 --
 include/asm-ppc/ppc_sys.h                    |    2 -
 include/asm-ppc/ppcboot.h                    |    7 +-
 include/asm-ppc/reg_booke.h                  |   26 -
 include/asm-ppc/serial.h                     |    2 -
 63 files changed, 20 insertions(+), 14608 deletions(-)
 delete mode 100644 arch/ppc/configs/TQM8540_defconfig
 delete mode 100644 arch/ppc/configs/TQM8541_defconfig
 delete mode 100644 arch/ppc/configs/TQM8555_defconfig
 delete mode 100644 arch/ppc/configs/TQM8560_defconfig
 delete mode 100644 arch/ppc/configs/mpc8540_ads_defconfig
 delete mode 100644 arch/ppc/configs/mpc8548_cds_defconfig
 delete mode 100644 arch/ppc/configs/mpc8555_cds_defconfig
 delete mode 100644 arch/ppc/configs/mpc8560_ads_defconfig
 delete mode 100644 arch/ppc/configs/stx_gp3_defconfig
 delete mode 100644 arch/ppc/kernel/head_fsl_booke.S
 delete mode 100644 arch/ppc/mm/fsl_booke_mmu.c
 delete mode 100644 arch/ppc/platforms/85xx/Kconfig
 delete mode 100644 arch/ppc/platforms/85xx/Makefile
 delete mode 100644 arch/ppc/platforms/85xx/mpc8540_ads.c
 delete mode 100644 arch/ppc/platforms/85xx/mpc8540_ads.h
 delete mode 100644 arch/ppc/platforms/85xx/mpc8555_cds.h
 delete mode 100644 arch/ppc/platforms/85xx/mpc8560_ads.c
 delete mode 100644 arch/ppc/platforms/85xx/mpc8560_ads.h
 delete mode 100644 arch/ppc/platforms/85xx/mpc85xx_ads_common.c
 delete mode 100644 arch/ppc/platforms/85xx/mpc85xx_ads_common.h
 delete mode 100644 arch/ppc/platforms/85xx/mpc85xx_cds_common.c
 delete mode 100644 arch/ppc/platforms/85xx/mpc85xx_cds_common.h
 delete mode 100644 arch/ppc/platforms/85xx/sbc8560.c
 delete mode 100644 arch/ppc/platforms/85xx/sbc8560.h
 delete mode 100644 arch/ppc/platforms/85xx/sbc85xx.c
 delete mode 100644 arch/ppc/platforms/85xx/sbc85xx.h
 delete mode 100644 arch/ppc/platforms/85xx/stx_gp3.c
 delete mode 100644 arch/ppc/platforms/85xx/stx_gp3.h
 delete mode 100644 arch/ppc/platforms/85xx/tqm85xx.c
 delete mode 100644 arch/ppc/platforms/85xx/tqm85xx.h
 delete mode 100644 arch/ppc/syslib/mpc85xx_devices.c
 delete mode 100644 arch/ppc/syslib/mpc85xx_sys.c
 delete mode 100644 arch/ppc/syslib/ppc85xx_common.c
 delete mode 100644 arch/ppc/syslib/ppc85xx_common.h
 delete mode 100644 arch/ppc/syslib/ppc85xx_setup.c
 delete mode 100644 arch/ppc/syslib/ppc85xx_setup.h
 delete mode 100644 include/asm-ppc/immap_85xx.h
 delete mode 100644 include/asm-ppc/mpc85xx.h

diff --git a/arch/ppc/Kconfig b/arch/ppc/Kconfig
index 08e083d..db5934c 100644
--- a/arch/ppc/Kconfig
+++ b/arch/ppc/Kconfig
@@ -104,12 +104,6 @@ config 8xx
 	bool "8xx"
 	select PPC_LIB_RHEAP

-config E200
-	bool "e200"
-
-config E500
-	bool "e500"
-
 endchoice

 config PPC_FPU
@@ -124,25 +118,14 @@ config PPC_DCR
 	depends on PPC_DCR_NATIVE
 	default y

-config BOOKE
-	bool
-	depends on E200 || E500
-	default y
-
-config FSL_BOOKE
-	bool
-	depends on E200 || E500
-	default y
-
 config PTE_64BIT
 	bool
-	depends on 44x || E500
+	depends on 44x
 	default y if 44x
-	default y if E500 && PHYS_64BIT

 config PHYS_64BIT
-	bool 'Large physical address support' if E500
-	depends on 44x || E500
+	bool
+	depends on 44x
 	default y if 44x
 	---help---
 	  This option enables kernel support for larger than 32-bit physical
@@ -167,21 +150,6 @@ config ALTIVEC

 	  If in doubt, say Y here.

-config SPE
-	bool "SPE Support"
-	depends on E200 || E500
-	---help---
-	  This option enables kernel support for the Signal Processing
-	  Extensions (SPE) to the PowerPC processor. The kernel currently
-	  supports saving and restoring SPE registers, and turning on the
-	  'spe enable' bit so user processes can execute SPE instructions.
-
-	  This option is only useful if you have a processor that supports
-	  SPE (e500, otherwise known as 85xx series), but does not have any
-	  effect on a non-spe cpu (it does, however add code to the kernel).
-
-	  If in doubt, say Y here.
-
 config TAU
 	bool "Thermal Management Support"
 	depends on 6xx && !8260
@@ -228,7 +196,7 @@ config TAU_AVERAGE

 config MATH_EMULATION
 	bool "Math emulation"
-	depends on 4xx || 8xx || E200 || E500
+	depends on 4xx || 8xx
 	---help---
 	  Some PowerPC chips designed for embedded applications do not have
 	  a floating-point unit and therefore do not implement the
@@ -279,7 +247,6 @@ config PPC601_SYNC_FIX
 	  If in doubt, say Y here.

 source arch/ppc/platforms/4xx/Kconfig
-source arch/ppc/platforms/85xx/Kconfig

 config PPC_STD_MMU
 	bool
@@ -288,7 +255,7 @@ config PPC_STD_MMU

 config NOT_COHERENT_CACHE
 	bool
-	depends on 4xx || 8xx || E200
+	depends on 4xx || 8xx
 	default y

 endmenu
@@ -1045,13 +1012,13 @@ config GENERIC_ISA_DMA

 config PPC_I8259
 	bool
-	default y if 85xx || PPC_PREP
+	default y if PPC_PREP
 	default n

 config PPC_INDIRECT_PCI
 	bool
 	depends on PCI
-	default y if 40x || 44x || 85xx || PPC_PREP
+	default y if 40x || 44x || PPC_PREP
 	default n

 config EISA
@@ -1068,8 +1035,8 @@ config MCA
 	bool

 config PCI
-	bool "PCI support" if 40x || CPM2 || 85xx || PPC_MPC52xx
-	default y if !40x && !CPM2 && !8xx && !85xx
+	bool "PCI support" if 40x || CPM2 || PPC_MPC52xx
+	default y if !40x && !CPM2 && !8xx
 	default PCI_QSPAN if !4xx && !CPM2 && 8xx
 	help
 	  Find out whether your system includes a PCI bus. PCI is the name of
diff --git a/arch/ppc/Makefile b/arch/ppc/Makefile
index a4fef18..8df7f0e 100644
--- a/arch/ppc/Makefile
+++ b/arch/ppc/Makefile
@@ -36,14 +36,8 @@ LINUXINCLUDE    += -Iarch/$(ARCH)/include

 CHECKFLAGS	+= -D__powerpc__

-ifndef CONFIG_FSL_BOOKE
-KBUILD_CFLAGS	+= -mstring
-endif
-
 cpu-as-$(CONFIG_4xx)		+= -Wa,-m405
 cpu-as-$(CONFIG_6xx)		+= -Wa,-maltivec
-cpu-as-$(CONFIG_E500)		+= -Wa,-me500
-cpu-as-$(CONFIG_E200)		+= -Wa,-me200

 KBUILD_AFLAGS += $(cpu-as-y)
 KBUILD_CFLAGS += $(cpu-as-y)
@@ -55,7 +49,6 @@ head-y				:= arch/ppc/kernel/head.o
 head-$(CONFIG_8xx)		:= arch/ppc/kernel/head_8xx.o
 head-$(CONFIG_4xx)		:= arch/ppc/kernel/head_4xx.o
 head-$(CONFIG_44x)		:= arch/ppc/kernel/head_44x.o
-head-$(CONFIG_FSL_BOOKE)	:= arch/ppc/kernel/head_fsl_booke.o

 head-$(CONFIG_PPC_FPU)		+= arch/powerpc/kernel/fpu.o

@@ -65,7 +58,6 @@ core-y				+= arch/ppc/kernel/ arch/powerpc/kernel/ \
 				   arch/ppc/syslib/ arch/powerpc/sysdev/ \
 				   arch/powerpc/lib/
 core-$(CONFIG_4xx)		+= arch/ppc/platforms/4xx/
-core-$(CONFIG_85xx)		+= arch/ppc/platforms/85xx/
 core-$(CONFIG_MATH_EMULATION)	+= arch/powerpc/math-emu/
 core-$(CONFIG_XMON)		+= arch/ppc/xmon/
 drivers-$(CONFIG_8xx)		+= arch/ppc/8xx_io/
diff --git a/arch/ppc/kernel/Makefile b/arch/ppc/kernel/Makefile
index 5da0ca7..7b73905 100644
--- a/arch/ppc/kernel/Makefile
+++ b/arch/ppc/kernel/Makefile
@@ -4,7 +4,6 @@
 extra-$(CONFIG_PPC_STD_MMU)	:= head.o
 extra-$(CONFIG_40x)		:= head_4xx.o
 extra-$(CONFIG_44x)		:= head_44x.o
-extra-$(CONFIG_FSL_BOOKE)	:= head_fsl_booke.o
 extra-$(CONFIG_8xx)		:= head_8xx.o
 extra-y				+= vmlinux.lds

diff --git a/arch/ppc/kernel/asm-offsets.c b/arch/ppc/kernel/asm-offsets.c
index e8e9432..a51a177 100644
--- a/arch/ppc/kernel/asm-offsets.c
+++ b/arch/ppc/kernel/asm-offsets.c
@@ -54,12 +54,6 @@ main(void)
 	DEFINE(THREAD_VSCR, offsetof(struct thread_struct, vscr));
 	DEFINE(THREAD_USED_VR, offsetof(struct thread_struct, used_vr));
 #endif /* CONFIG_ALTIVEC */
-#ifdef CONFIG_SPE
-	DEFINE(THREAD_EVR0, offsetof(struct thread_struct, evr[0]));
-	DEFINE(THREAD_ACC, offsetof(struct thread_struct, acc));
-	DEFINE(THREAD_SPEFSCR, offsetof(struct thread_struct, spefscr));
-	DEFINE(THREAD_USED_SPE, offsetof(struct thread_struct, used_spe));
-#endif /* CONFIG_SPE */
 	/* Interrupt register frame */
 	DEFINE(STACK_FRAME_OVERHEAD, STACK_FRAME_OVERHEAD);
 	DEFINE(INT_FRAME_SIZE, STACK_FRAME_OVERHEAD + sizeof(struct pt_regs));
diff --git a/arch/ppc/kernel/entry.S b/arch/ppc/kernel/entry.S
index 59e77eb..5f3a5d0 100644
--- a/arch/ppc/kernel/entry.S
+++ b/arch/ppc/kernel/entry.S
@@ -519,12 +519,7 @@ BEGIN_FTR_SECTION
 	stw	r12,THREAD+THREAD_VRSAVE(r2)
 END_FTR_SECTION_IFSET(CPU_FTR_ALTIVEC)
 #endif /* CONFIG_ALTIVEC */
-#ifdef CONFIG_SPE
-	oris	r0,r0,MSR_SPE@h	 /* Disable SPE */
-	mfspr	r12,SPRN_SPEFSCR /* save spefscr register value */
-	stw	r12,THREAD+THREAD_SPEFSCR(r2)
-#endif /* CONFIG_SPE */
-	and.	r0,r0,r11	/* FP or altivec or SPE enabled? */
+	and.	r0,r0,r11	/* FP or altivec enabled? */
 	beq+	1f
 	andc	r11,r11,r0
 	MTMSRD(r11)
@@ -557,11 +552,6 @@ BEGIN_FTR_SECTION
 	mtspr	SPRN_VRSAVE,r0		/* if G4, restore VRSAVE reg */
 END_FTR_SECTION_IFSET(CPU_FTR_ALTIVEC)
 #endif /* CONFIG_ALTIVEC */
-#ifdef CONFIG_SPE
-	lwz	r0,THREAD+THREAD_SPEFSCR(r2)
-	mtspr	SPRN_SPEFSCR,r0		/* restore SPEFSCR reg */
-#endif /* CONFIG_SPE */
-
 	lwz	r0,_CCR(r1)
 	mtcrf	0xFF,r0
 	/* r3-r12 are destroyed -- Cort */
diff --git a/arch/ppc/kernel/head_booke.h b/arch/ppc/kernel/head_booke.h
index f3d274c..166d597 100644
--- a/arch/ppc/kernel/head_booke.h
+++ b/arch/ppc/kernel/head_booke.h
@@ -212,60 +212,6 @@ label:
  * save (and later restore) the MSR via SPRN_CSRR1, which will still have
  * the MSR_DE bit set.
  */
-#ifdef CONFIG_E200
-#define DEBUG_EXCEPTION							      \
-	START_EXCEPTION(Debug);						      \
-	DEBUG_EXCEPTION_PROLOG;						      \
-									      \
-	/*								      \
-	 * If there is a single step or branch-taken exception in an	      \
-	 * exception entry sequence, it was probably meant to apply to	      \
-	 * the code where the exception occurred (since exception entry	      \
-	 * doesn't turn off DE automatically).  We simulate the effect	      \
-	 * of turning off DE on entry to an exception handler by turning      \
-	 * off DE in the CSRR1 value and clearing the debug status.	      \
-	 */								      \
-	mfspr	r10,SPRN_DBSR;		/* check single-step/branch taken */  \
-	andis.	r10,r10,DBSR_IC@h;					      \
-	beq+	2f;							      \
-									      \
-	lis	r10,KERNELBASE@h;	/* check if exception in vectors */   \
-	ori	r10,r10,KERNELBASE@l;					      \
-	cmplw	r12,r10;						      \
-	blt+	2f;			/* addr below exception vectors */    \
-									      \
-	lis	r10,Debug@h;						      \
-	ori	r10,r10,Debug@l;					      \
-	cmplw	r12,r10;						      \
-	bgt+	2f;			/* addr above exception vectors */    \
-									      \
-	/* here it looks like we got an inappropriate debug exception. */     \
-1:	rlwinm	r9,r9,0,~MSR_DE;	/* clear DE in the CDRR1 value */     \
-	lis	r10,DBSR_IC@h;		/* clear the IC event */	      \
-	mtspr	SPRN_DBSR,r10;						      \
-	/* restore state and get out */					      \
-	lwz	r10,_CCR(r11);						      \
-	lwz	r0,GPR0(r11);						      \
-	lwz	r1,GPR1(r11);						      \
-	mtcrf	0x80,r10;						      \
-	mtspr	SPRN_DSRR0,r12;						      \
-	mtspr	SPRN_DSRR1,r9;						      \
-	lwz	r9,GPR9(r11);						      \
-	lwz	r12,GPR12(r11);						      \
-	mtspr	DEBUG_SPRG,r8;						      \
-	BOOKE_LOAD_EXC_LEVEL_STACK(DEBUG); /* r8 points to the debug stack */ \
-	lwz	r10,GPR10-INT_FRAME_SIZE(r8);				      \
-	lwz	r11,GPR11-INT_FRAME_SIZE(r8);				      \
-	mfspr	r8,DEBUG_SPRG;						      \
-									      \
-	RFDI;								      \
-	b	.;							      \
-									      \
-	/* continue normal handling for a critical exception... */	      \
-2:	mfspr	r4,SPRN_DBSR;						      \
-	addi	r3,r1,STACK_FRAME_OVERHEAD;				      \
-	EXC_XFER_TEMPLATE(DebugException, 0x2002, (MSR_KERNEL & ~(MSR_ME|MSR_DE|MSR_CE)), NOCOPY, debug_transfer_to_handler, ret_from_debug_exc)
-#else
 #define DEBUG_EXCEPTION							      \
 	START_EXCEPTION(Debug);						      \
 	CRITICAL_EXCEPTION_PROLOG;					      \
@@ -318,7 +264,6 @@ label:
 2:	mfspr	r4,SPRN_DBSR;						      \
 	addi	r3,r1,STACK_FRAME_OVERHEAD;				      \
 	EXC_XFER_TEMPLATE(DebugException, 0x2002, (MSR_KERNEL & ~(MSR_ME|MSR_DE|MSR_CE)), NOCOPY, crit_transfer_to_handler, ret_from_crit_exc)
-#endif

 #define INSTRUCTION_STORAGE_EXCEPTION					      \
 	START_EXCEPTION(InstructionStorage)				      \
diff --git a/arch/ppc/kernel/misc.S b/arch/ppc/kernel/misc.S
index e0c850d..d5e0dfc 100644
--- a/arch/ppc/kernel/misc.S
+++ b/arch/ppc/kernel/misc.S
@@ -165,24 +165,7 @@ _GLOBAL(_tlbia)
 	ble	1b

 	isync
-#elif defined(CONFIG_FSL_BOOKE)
-	/* Invalidate all entries in TLB0 */
-	li	r3, 0x04
-	tlbivax	0,3
-	/* Invalidate all entries in TLB1 */
-	li	r3, 0x0c
-	tlbivax	0,3
-	/* Invalidate all entries in TLB2 */
-	li	r3, 0x14
-	tlbivax	0,3
-	/* Invalidate all entries in TLB3 */
-	li	r3, 0x1c
-	tlbivax	0,3
-	msync
-#ifdef CONFIG_SMP
-	tlbsync
-#endif /* CONFIG_SMP */
-#else /* !(CONFIG_40x || CONFIG_44x || CONFIG_FSL_BOOKE) */
+#else /* !(CONFIG_40x || CONFIG_44x) */
 #if defined(CONFIG_SMP)
 	rlwinm	r8,r1,0,0,18
 	lwz	r8,TI_CPU(r8)
@@ -268,20 +251,7 @@ _GLOBAL(_tlbie)
 	tlbwe	r3, r3, PPC44x_TLB_PAGEID
 	isync
 10:
-#elif defined(CONFIG_FSL_BOOKE)
-	rlwinm	r4, r3, 0, 0, 19
-	ori	r5, r4, 0x08	/* TLBSEL = 1 */
-	ori	r6, r4, 0x10	/* TLBSEL = 2 */
-	ori	r7, r4, 0x18	/* TLBSEL = 3 */
-	tlbivax	0, r4
-	tlbivax	0, r5
-	tlbivax	0, r6
-	tlbivax	0, r7
-	msync
-#if defined(CONFIG_SMP)
-	tlbsync
-#endif /* CONFIG_SMP */
-#else /* !(CONFIG_40x || CONFIG_44x || CONFIG_FSL_BOOKE) */
+#else /* !(CONFIG_40x || CONFIG_44x) */
 #if defined(CONFIG_SMP)
 	rlwinm	r8,r1,0,0,18
 	lwz	r8,TI_CPU(r8)
@@ -338,18 +308,6 @@ _GLOBAL(flush_instruction_cache)
 	lis	r3, KERNELBASE@h
 	iccci	0,r3
 #endif
-#elif CONFIG_FSL_BOOKE
-BEGIN_FTR_SECTION
-	mfspr   r3,SPRN_L1CSR0
-	ori     r3,r3,L1CSR0_CFI|L1CSR0_CLFC
-	/* msync; isync recommended here */
-	mtspr   SPRN_L1CSR0,r3
-	isync
-	blr
-END_FTR_SECTION_IFSET(CPU_FTR_UNIFIED_ID_CACHE)
-	mfspr	r3,SPRN_L1CSR1
-	ori	r3,r3,L1CSR1_ICFI|L1CSR1_ICLFR
-	mtspr	SPRN_L1CSR1,r3
 #else
 	mfspr	r3,SPRN_PVR
 	rlwinm	r3,r3,16,16,31
diff --git a/arch/ppc/kernel/ppc_ksyms.c b/arch/ppc/kernel/ppc_ksyms.c
index ba729ce..c353502 100644
--- a/arch/ppc/kernel/ppc_ksyms.c
+++ b/arch/ppc/kernel/ppc_ksyms.c
@@ -166,12 +166,6 @@ EXPORT_SYMBOL(last_task_used_altivec);
 #endif
 EXPORT_SYMBOL(giveup_altivec);
 #endif /* CONFIG_ALTIVEC */
-#ifdef CONFIG_SPE
-#ifndef CONFIG_SMP
-EXPORT_SYMBOL(last_task_used_spe);
-#endif
-EXPORT_SYMBOL(giveup_spe);
-#endif /* CONFIG_SPE */
 #ifdef CONFIG_SMP
 EXPORT_SYMBOL(smp_call_function);
 EXPORT_SYMBOL(smp_hw_index);
@@ -244,7 +238,7 @@ EXPORT_SYMBOL(debugger_fault_handler);
 EXPORT_SYMBOL(cpm_install_handler);
 EXPORT_SYMBOL(cpm_free_handler);
 #endif /* CONFIG_8xx */
-#if defined(CONFIG_8xx) || defined(CONFIG_40x) || defined(CONFIG_85xx)
+#if defined(CONFIG_8xx) || defined(CONFIG_40x)
 EXPORT_SYMBOL(__res);
 #endif

diff --git a/arch/ppc/kernel/setup.c b/arch/ppc/kernel/setup.c
index 5888ae6..d51368d 100644
--- a/arch/ppc/kernel/setup.c
+++ b/arch/ppc/kernel/setup.c
@@ -38,8 +38,7 @@
 #include <asm/xmon.h>
 #include <asm/ocp.h>

-#define USES_PPC_SYS (defined(CONFIG_85xx) || \
-		      defined(CONFIG_MPC10X_BRIDGE) || defined(CONFIG_8260) || \
+#define USES_PPC_SYS (defined(CONFIG_MPC10X_BRIDGE) || defined(CONFIG_8260) || \
 		      defined(CONFIG_PPC_MPC52xx))

 #if USES_PPC_SYS
diff --git a/arch/ppc/kernel/traps.c b/arch/ppc/kernel/traps.c
index 25a1085..a467a42 100644
--- a/arch/ppc/kernel/traps.c
+++ b/arch/ppc/kernel/traps.c
@@ -194,11 +194,7 @@ static inline int check_io_access(struct pt_regs *regs)
 /* On 4xx, the reason for the machine check or program exception
    is in the ESR. */
 #define get_reason(regs)	((regs)->dsisr)
-#ifndef CONFIG_FSL_BOOKE
 #define get_mc_reason(regs)	((regs)->dsisr)
-#else
-#define get_mc_reason(regs)	(mfspr(SPRN_MCSR))
-#endif
 #define REASON_FP		ESR_FP
 #define REASON_ILLEGAL		(ESR_PIL | ESR_PUO)
 #define REASON_PRIVILEGED	ESR_PPR
@@ -281,66 +277,6 @@ int machine_check_440A(struct pt_regs *regs)
 	}
 	return 0;
 }
-#elif defined(CONFIG_E500)
-int machine_check_e500(struct pt_regs *regs)
-{
-	unsigned long reason = get_mc_reason(regs);
-
-	printk("Machine check in kernel mode.\n");
-	printk("Caused by (from MCSR=%lx): ", reason);
-
-	if (reason & MCSR_MCP)
-		printk("Machine Check Signal\n");
-	if (reason & MCSR_ICPERR)
-		printk("Instruction Cache Parity Error\n");
-	if (reason & MCSR_DCP_PERR)
-		printk("Data Cache Push Parity Error\n");
-	if (reason & MCSR_DCPERR)
-		printk("Data Cache Parity Error\n");
-	if (reason & MCSR_BUS_IAERR)
-		printk("Bus - Instruction Address Error\n");
-	if (reason & MCSR_BUS_RAERR)
-		printk("Bus - Read Address Error\n");
-	if (reason & MCSR_BUS_WAERR)
-		printk("Bus - Write Address Error\n");
-	if (reason & MCSR_BUS_IBERR)
-		printk("Bus - Instruction Data Error\n");
-	if (reason & MCSR_BUS_RBERR)
-		printk("Bus - Read Data Bus Error\n");
-	if (reason & MCSR_BUS_WBERR)
-		printk("Bus - Read Data Bus Error\n");
-	if (reason & MCSR_BUS_IPERR)
-		printk("Bus - Instruction Parity Error\n");
-	if (reason & MCSR_BUS_RPERR)
-		printk("Bus - Read Parity Error\n");
-
-	return 0;
-}
-#elif defined(CONFIG_E200)
-int machine_check_e200(struct pt_regs *regs)
-{
-	unsigned long reason = get_mc_reason(regs);
-
-	printk("Machine check in kernel mode.\n");
-	printk("Caused by (from MCSR=%lx): ", reason);
-
-	if (reason & MCSR_MCP)
-		printk("Machine Check Signal\n");
-	if (reason & MCSR_CP_PERR)
-		printk("Cache Push Parity Error\n");
-	if (reason & MCSR_CPERR)
-		printk("Cache Parity Error\n");
-	if (reason & MCSR_EXCP_ERR)
-		printk("ISI, ITLB, or Bus Error on first instruction fetch for an exception handler\n");
-	if (reason & MCSR_BUS_IRERR)
-		printk("Bus - Read Bus Error on instruction fetch\n");
-	if (reason & MCSR_BUS_DRERR)
-		printk("Bus - Read Bus Error on data load\n");
-	if (reason & MCSR_BUS_WRERR)
-		printk("Bus - Write Bus Error on buffered store or cache line push\n");
-
-	return 0;
-}
 #else
 int machine_check_generic(struct pt_regs *regs)
 {
@@ -866,63 +802,6 @@ void altivec_assist_exception(struct pt_regs *regs)
 }
 #endif /* CONFIG_ALTIVEC */

-#ifdef CONFIG_E500
-void performance_monitor_exception(struct pt_regs *regs)
-{
-	perf_irq(regs);
-}
-#endif
-
-#ifdef CONFIG_FSL_BOOKE
-void CacheLockingException(struct pt_regs *regs, unsigned long address,
-			   unsigned long error_code)
-{
-	/* We treat cache locking instructions from the user
-	 * as priv ops, in the future we could try to do
-	 * something smarter
-	 */
-	if (error_code & (ESR_DLK|ESR_ILK))
-		_exception(SIGILL, regs, ILL_PRVOPC, regs->nip);
-	return;
-}
-#endif /* CONFIG_FSL_BOOKE */
-
-#ifdef CONFIG_SPE
-void SPEFloatingPointException(struct pt_regs *regs)
-{
-	unsigned long spefscr;
-	int fpexc_mode;
-	int code = 0;
-
-	spefscr = current->thread.spefscr;
-	fpexc_mode = current->thread.fpexc_mode;
-
-	/* Hardware does not necessarily set sticky
-	 * underflow/overflow/invalid flags */
-	if ((spefscr & SPEFSCR_FOVF) && (fpexc_mode & PR_FP_EXC_OVF)) {
-		code = FPE_FLTOVF;
-		spefscr |= SPEFSCR_FOVFS;
-	}
-	else if ((spefscr & SPEFSCR_FUNF) && (fpexc_mode & PR_FP_EXC_UND)) {
-		code = FPE_FLTUND;
-		spefscr |= SPEFSCR_FUNFS;
-	}
-	else if ((spefscr & SPEFSCR_FDBZ) && (fpexc_mode & PR_FP_EXC_DIV))
-		code = FPE_FLTDIV;
-	else if ((spefscr & SPEFSCR_FINV) && (fpexc_mode & PR_FP_EXC_INV)) {
-		code = FPE_FLTINV;
-		spefscr |= SPEFSCR_FINVS;
-	}
-	else if ((spefscr & (SPEFSCR_FG | SPEFSCR_FX)) && (fpexc_mode & PR_FP_EXC_RES))
-		code = FPE_FLTRES;
-
-	current->thread.spefscr = spefscr;
-
-	_exception(SIGFPE, regs, code, regs->nip);
-	return;
-}
-#endif
-
 #ifdef CONFIG_BOOKE_WDT
 /*
  * Default handler for a Watchdog exception,
diff --git a/arch/ppc/mm/Makefile b/arch/ppc/mm/Makefile
index cd3eae1..691ba2b 100644
--- a/arch/ppc/mm/Makefile
+++ b/arch/ppc/mm/Makefile
@@ -8,4 +8,3 @@ obj-y				:= fault.o init.o mem_pieces.o \
 obj-$(CONFIG_PPC_STD_MMU)	+= hashtable.o ppc_mmu.o tlb.o
 obj-$(CONFIG_40x)		+= 4xx_mmu.o
 obj-$(CONFIG_44x)		+= 44x_mmu.o
-obj-$(CONFIG_FSL_BOOKE)		+= fsl_booke_mmu.o
diff --git a/arch/ppc/mm/init.c b/arch/ppc/mm/init.c
index dd898d3..7444df3 100644
--- a/arch/ppc/mm/init.c
+++ b/arch/ppc/mm/init.c
@@ -241,12 +241,6 @@ void __init MMU_init(void)
 	if (__max_memory && total_memory > __max_memory)
 		total_memory = __max_memory;
 	total_lowmem = total_memory;
-#ifdef CONFIG_FSL_BOOKE
-	/* Freescale Book-E parts expect lowmem to be mapped by fixed TLB
-	 * entries, so we need to adjust lowmem to match the amount we can map
-	 * in the fixed entries */
-	adjust_total_lowmem();
-#endif /* CONFIG_FSL_BOOKE */
 	if (total_lowmem > __max_low_memory) {
 		total_lowmem = __max_low_memory;
 #ifndef CONFIG_HIGHMEM
diff --git a/arch/ppc/mm/mmu_decl.h b/arch/ppc/mm/mmu_decl.h
index b298b60..5f813e3 100644
--- a/arch/ppc/mm/mmu_decl.h
+++ b/arch/ppc/mm/mmu_decl.h
@@ -58,12 +58,6 @@ extern unsigned int num_tlbcam_entries;
 extern void MMU_init_hw(void);
 extern unsigned long mmu_mapin_ram(void);

-#elif defined(CONFIG_FSL_BOOKE)
-#define flush_HPTE(pid, va, pg)	_tlbie(va, pid)
-extern void MMU_init_hw(void);
-extern unsigned long mmu_mapin_ram(void);
-extern void adjust_total_lowmem(void);
-
 #else
 /* anything except 4xx or 8xx */
 extern void MMU_init_hw(void);
diff --git a/arch/ppc/mm/pgtable.c b/arch/ppc/mm/pgtable.c
index 1f51e6c..fadacfd 100644
--- a/arch/ppc/mm/pgtable.c
+++ b/arch/ppc/mm/pgtable.c
@@ -42,10 +42,6 @@ int io_bat_index;
 #define HAVE_BATS	1
 #endif

-#if defined(CONFIG_FSL_BOOKE)
-#define HAVE_TLBCAM	1
-#endif
-
 extern char etext[], _stext[];

 #ifdef CONFIG_SMP
@@ -63,15 +59,6 @@ void setbat(int index, unsigned long virt, unsigned long phys,
 #define p_mapped_by_bats(x)	(0UL)
 #endif /* HAVE_BATS */

-#ifdef HAVE_TLBCAM
-extern unsigned int tlbcam_index;
-extern unsigned long v_mapped_by_tlbcam(unsigned long va);
-extern unsigned long p_mapped_by_tlbcam(unsigned long pa);
-#else /* !HAVE_TLBCAM */
-#define v_mapped_by_tlbcam(x)	(0UL)
-#define p_mapped_by_tlbcam(x)	(0UL)
-#endif /* HAVE_TLBCAM */
-
 #ifdef CONFIG_PTE_64BIT
 /* 44x uses an 8kB pgdir because it has 8-byte Linux PTEs. */
 #define PGDIR_ORDER	1
@@ -213,9 +200,6 @@ __ioremap(phys_addr_t addr, unsigned long size, unsigned long flags)
 	if ((v = p_mapped_by_bats(p)) /*&& p_mapped_by_bats(p+size-1)*/ )
 		goto out;

-	if ((v = p_mapped_by_tlbcam(p)))
-		goto out;
-
 	if (mem_init_done) {
 		struct vm_struct *area;
 		area = get_vm_area(size, VM_IOREMAP);
@@ -341,18 +325,6 @@ void __init io_block_mapping(unsigned long virt, phys_addr_t phys,
 	}
 #endif /* HAVE_BATS */

-#ifdef HAVE_TLBCAM
-	/*
-	 * Use a CAM for this if possible...
-	 */
-	if (tlbcam_index < num_tlbcam_entries && is_power_of_4(size)
-	    && (virt & (size - 1)) == 0 && (phys & (size - 1)) == 0) {
-		settlbcam(tlbcam_index, virt, phys, size, flags, 0);
-		++tlbcam_index;
-		return;
-	}
-#endif /* HAVE_TLBCAM */
-
 	/* No BATs available, put it in the page tables. */
 	for (i = 0; i < size; i += PAGE_SIZE)
 		map_page(virt + i, phys + i, flags);
diff --git a/arch/ppc/syslib/Makefile b/arch/ppc/syslib/Makefile
index 4d158f3..52ddebe 100644
--- a/arch/ppc/syslib/Makefile
+++ b/arch/ppc/syslib/Makefile
@@ -87,14 +87,6 @@ endif
 obj-$(CONFIG_BOOTX_TEXT)	+= btext.o
 obj-$(CONFIG_MPC10X_BRIDGE)	+= mpc10x_common.o ppc_sys.o
 obj-$(CONFIG_MPC10X_OPENPIC)	+= open_pic.o
-obj-$(CONFIG_85xx)		+= open_pic.o ppc85xx_common.o ppc85xx_setup.o \
-					ppc_sys.o mpc85xx_sys.o \
-					mpc85xx_devices.o
-ifeq ($(CONFIG_85xx),y)
-obj-$(CONFIG_PCI)		+= pci_auto.o
-endif
-obj-$(CONFIG_MPC8548_CDS)	+= todc_time.o
-obj-$(CONFIG_MPC8555_CDS)	+= todc_time.o
 obj-$(CONFIG_PPC_MPC52xx)	+= mpc52xx_setup.o mpc52xx_pic.o \
 					mpc52xx_sys.o mpc52xx_devices.o ppc_sys.o
 ifeq ($(CONFIG_PPC_MPC52xx),y)
diff --git a/arch/ppc/syslib/ocp.c b/arch/ppc/syslib/ocp.c
index d42d408..ac80370 100644
--- a/arch/ppc/syslib/ocp.c
+++ b/arch/ppc/syslib/ocp.c
@@ -20,7 +20,7 @@
  *  of peripherals are found on embedded SoC (System On a Chip)
  *  processors or highly integrated system controllers that have
  *  a host bridge and many peripherals.  Common examples where
- *  this is already used include the PPC4xx, PPC85xx, MPC52xx,
+ *  this is already used include the PPC4xx, MPC52xx,
  *  and MV64xxx parts.
  *
  *  This subsystem creates a standard OCP bus type within the
diff --git a/arch/ppc/syslib/open_pic.c b/arch/ppc/syslib/open_pic.c
index 18ec947..780a3b9 100644
--- a/arch/ppc/syslib/open_pic.c
+++ b/arch/ppc/syslib/open_pic.c
@@ -24,7 +24,7 @@

 #include "open_pic_defs.h"

-#if defined(CONFIG_PRPMC800) || defined(CONFIG_85xx)
+#if defined(CONFIG_PRPMC800)
 #define OPENPIC_BIG_ENDIAN
 #endif

diff --git a/include/asm-powerpc/irq.h b/include/asm-powerpc/irq.h
index 4a015da..0efe7b2 100644
--- a/include/asm-powerpc/irq.h
+++ b/include/asm-powerpc/irq.h
@@ -483,127 +483,6 @@ static __inline__ int irq_canonicalize(int irq)
  */
 #define	mk_int_int_mask(IL) (1 << (7 - (IL/2)))

-#elif defined(CONFIG_85xx)
-/* Now include the board configuration specific associations.
-*/
-#include <asm/mpc85xx.h>
-
-/* The MPC8548 openpic has 48 internal interrupts and 12 external
- * interrupts.
- *
- * We are "flattening" the interrupt vectors of the cascaded CPM
- * so that we can uniquely identify any interrupt source with a
- * single integer.
- */
-#define NR_CPM_INTS	64
-#define NR_EPIC_INTS	60
-#ifndef NR_8259_INTS
-#define NR_8259_INTS	0
-#endif
-#define NUM_8259_INTERRUPTS NR_8259_INTS
-
-#ifndef CPM_IRQ_OFFSET
-#define CPM_IRQ_OFFSET	0
-#endif
-
-#define NR_IRQS	(NR_EPIC_INTS + NR_CPM_INTS + NR_8259_INTS)
-
-/* Internal IRQs on MPC85xx OpenPIC */
-
-#ifndef MPC85xx_OPENPIC_IRQ_OFFSET
-#ifdef CONFIG_CPM2
-#define MPC85xx_OPENPIC_IRQ_OFFSET	(CPM_IRQ_OFFSET + NR_CPM_INTS)
-#else
-#define MPC85xx_OPENPIC_IRQ_OFFSET	0
-#endif
-#endif
-
-/* Not all of these exist on all MPC85xx implementations */
-#define MPC85xx_IRQ_L2CACHE	( 0 + MPC85xx_OPENPIC_IRQ_OFFSET)
-#define MPC85xx_IRQ_ECM		( 1 + MPC85xx_OPENPIC_IRQ_OFFSET)
-#define MPC85xx_IRQ_DDR		( 2 + MPC85xx_OPENPIC_IRQ_OFFSET)
-#define MPC85xx_IRQ_LBIU	( 3 + MPC85xx_OPENPIC_IRQ_OFFSET)
-#define MPC85xx_IRQ_DMA0	( 4 + MPC85xx_OPENPIC_IRQ_OFFSET)
-#define MPC85xx_IRQ_DMA1	( 5 + MPC85xx_OPENPIC_IRQ_OFFSET)
-#define MPC85xx_IRQ_DMA2	( 6 + MPC85xx_OPENPIC_IRQ_OFFSET)
-#define MPC85xx_IRQ_DMA3	( 7 + MPC85xx_OPENPIC_IRQ_OFFSET)
-#define MPC85xx_IRQ_PCI1	( 8 + MPC85xx_OPENPIC_IRQ_OFFSET)
-#define MPC85xx_IRQ_PCI2	( 9 + MPC85xx_OPENPIC_IRQ_OFFSET)
-#define MPC85xx_IRQ_RIO_ERROR	( 9 + MPC85xx_OPENPIC_IRQ_OFFSET)
-#define MPC85xx_IRQ_RIO_BELL	(10 + MPC85xx_OPENPIC_IRQ_OFFSET)
-#define MPC85xx_IRQ_RIO_TX	(11 + MPC85xx_OPENPIC_IRQ_OFFSET)
-#define MPC85xx_IRQ_RIO_RX	(12 + MPC85xx_OPENPIC_IRQ_OFFSET)
-#define MPC85xx_IRQ_TSEC1_TX	(13 + MPC85xx_OPENPIC_IRQ_OFFSET)
-#define MPC85xx_IRQ_TSEC1_RX	(14 + MPC85xx_OPENPIC_IRQ_OFFSET)
-#define MPC85xx_IRQ_TSEC3_TX	(15 + MPC85xx_OPENPIC_IRQ_OFFSET)
-#define MPC85xx_IRQ_TSEC3_RX	(16 + MPC85xx_OPENPIC_IRQ_OFFSET)
-#define MPC85xx_IRQ_TSEC3_ERROR	(17 + MPC85xx_OPENPIC_IRQ_OFFSET)
-#define MPC85xx_IRQ_TSEC1_ERROR	(18 + MPC85xx_OPENPIC_IRQ_OFFSET)
-#define MPC85xx_IRQ_TSEC2_TX	(19 + MPC85xx_OPENPIC_IRQ_OFFSET)
-#define MPC85xx_IRQ_TSEC2_RX	(20 + MPC85xx_OPENPIC_IRQ_OFFSET)
-#define MPC85xx_IRQ_TSEC4_TX	(21 + MPC85xx_OPENPIC_IRQ_OFFSET)
-#define MPC85xx_IRQ_TSEC4_RX	(22 + MPC85xx_OPENPIC_IRQ_OFFSET)
-#define MPC85xx_IRQ_TSEC4_ERROR	(23 + MPC85xx_OPENPIC_IRQ_OFFSET)
-#define MPC85xx_IRQ_TSEC2_ERROR	(24 + MPC85xx_OPENPIC_IRQ_OFFSET)
-#define MPC85xx_IRQ_FEC		(25 + MPC85xx_OPENPIC_IRQ_OFFSET)
-#define MPC85xx_IRQ_DUART	(26 + MPC85xx_OPENPIC_IRQ_OFFSET)
-#define MPC85xx_IRQ_IIC1	(27 + MPC85xx_OPENPIC_IRQ_OFFSET)
-#define MPC85xx_IRQ_PERFMON	(28 + MPC85xx_OPENPIC_IRQ_OFFSET)
-#define MPC85xx_IRQ_SEC2	(29 + MPC85xx_OPENPIC_IRQ_OFFSET)
-#define MPC85xx_IRQ_CPM		(30 + MPC85xx_OPENPIC_IRQ_OFFSET)
-
-/* The 12 external interrupt lines */
-#define MPC85xx_IRQ_EXT0        (48 + MPC85xx_OPENPIC_IRQ_OFFSET)
-#define MPC85xx_IRQ_EXT1        (49 + MPC85xx_OPENPIC_IRQ_OFFSET)
-#define MPC85xx_IRQ_EXT2        (50 + MPC85xx_OPENPIC_IRQ_OFFSET)
-#define MPC85xx_IRQ_EXT3        (51 + MPC85xx_OPENPIC_IRQ_OFFSET)
-#define MPC85xx_IRQ_EXT4        (52 + MPC85xx_OPENPIC_IRQ_OFFSET)
-#define MPC85xx_IRQ_EXT5        (53 + MPC85xx_OPENPIC_IRQ_OFFSET)
-#define MPC85xx_IRQ_EXT6        (54 + MPC85xx_OPENPIC_IRQ_OFFSET)
-#define MPC85xx_IRQ_EXT7        (55 + MPC85xx_OPENPIC_IRQ_OFFSET)
-#define MPC85xx_IRQ_EXT8        (56 + MPC85xx_OPENPIC_IRQ_OFFSET)
-#define MPC85xx_IRQ_EXT9        (57 + MPC85xx_OPENPIC_IRQ_OFFSET)
-#define MPC85xx_IRQ_EXT10       (58 + MPC85xx_OPENPIC_IRQ_OFFSET)
-#define MPC85xx_IRQ_EXT11       (59 + MPC85xx_OPENPIC_IRQ_OFFSET)
-
-/* CPM related interrupts */
-#define	SIU_INT_ERROR		((uint)0x00+CPM_IRQ_OFFSET)
-#define	SIU_INT_I2C		((uint)0x01+CPM_IRQ_OFFSET)
-#define	SIU_INT_SPI		((uint)0x02+CPM_IRQ_OFFSET)
-#define	SIU_INT_RISC		((uint)0x03+CPM_IRQ_OFFSET)
-#define	SIU_INT_SMC1		((uint)0x04+CPM_IRQ_OFFSET)
-#define	SIU_INT_SMC2		((uint)0x05+CPM_IRQ_OFFSET)
-#define	SIU_INT_USB		((uint)0x0b+CPM_IRQ_OFFSET)
-#define	SIU_INT_TIMER1		((uint)0x0c+CPM_IRQ_OFFSET)
-#define	SIU_INT_TIMER2		((uint)0x0d+CPM_IRQ_OFFSET)
-#define	SIU_INT_TIMER3		((uint)0x0e+CPM_IRQ_OFFSET)
-#define	SIU_INT_TIMER4		((uint)0x0f+CPM_IRQ_OFFSET)
-#define	SIU_INT_FCC1		((uint)0x20+CPM_IRQ_OFFSET)
-#define	SIU_INT_FCC2		((uint)0x21+CPM_IRQ_OFFSET)
-#define	SIU_INT_FCC3		((uint)0x22+CPM_IRQ_OFFSET)
-#define	SIU_INT_MCC1		((uint)0x24+CPM_IRQ_OFFSET)
-#define	SIU_INT_MCC2		((uint)0x25+CPM_IRQ_OFFSET)
-#define	SIU_INT_SCC1		((uint)0x28+CPM_IRQ_OFFSET)
-#define	SIU_INT_SCC2		((uint)0x29+CPM_IRQ_OFFSET)
-#define	SIU_INT_SCC3		((uint)0x2a+CPM_IRQ_OFFSET)
-#define	SIU_INT_SCC4		((uint)0x2b+CPM_IRQ_OFFSET)
-#define	SIU_INT_PC15		((uint)0x30+CPM_IRQ_OFFSET)
-#define	SIU_INT_PC14		((uint)0x31+CPM_IRQ_OFFSET)
-#define	SIU_INT_PC13		((uint)0x32+CPM_IRQ_OFFSET)
-#define	SIU_INT_PC12		((uint)0x33+CPM_IRQ_OFFSET)
-#define	SIU_INT_PC11		((uint)0x34+CPM_IRQ_OFFSET)
-#define	SIU_INT_PC10		((uint)0x35+CPM_IRQ_OFFSET)
-#define	SIU_INT_PC9		((uint)0x36+CPM_IRQ_OFFSET)
-#define	SIU_INT_PC8		((uint)0x37+CPM_IRQ_OFFSET)
-#define	SIU_INT_PC7		((uint)0x38+CPM_IRQ_OFFSET)
-#define	SIU_INT_PC6		((uint)0x39+CPM_IRQ_OFFSET)
-#define	SIU_INT_PC5		((uint)0x3a+CPM_IRQ_OFFSET)
-#define	SIU_INT_PC4		((uint)0x3b+CPM_IRQ_OFFSET)
-#define	SIU_INT_PC3		((uint)0x3c+CPM_IRQ_OFFSET)
-#define	SIU_INT_PC2		((uint)0x3d+CPM_IRQ_OFFSET)
-#define	SIU_INT_PC1		((uint)0x3e+CPM_IRQ_OFFSET)
-#define	SIU_INT_PC0		((uint)0x3f+CPM_IRQ_OFFSET)
-
 #elif defined(CONFIG_PPC_86xx)
 #include <asm/mpc86xx.h>

diff --git a/include/asm-ppc/cpm2.h b/include/asm-ppc/cpm2.h
index 12a2860..4c53822 100644
--- a/include/asm-ppc/cpm2.h
+++ b/include/asm-ppc/cpm2.h
@@ -90,7 +90,7 @@
  */
 #define CPM_DATAONLY_BASE	((uint)128)
 #define CPM_DP_NOSPACE		((uint)0x7fffffff)
-#if defined(CONFIG_8272) || defined(CONFIG_MPC8555)
+#if defined(CONFIG_8272)
 #define CPM_DATAONLY_SIZE	((uint)(8 * 1024) - CPM_DATAONLY_BASE)
 #define CPM_FCC_SPECIAL_BASE	((uint)0x00009000)
 #else
diff --git a/include/asm-ppc/mmu_context.h b/include/asm-ppc/mmu_context.h
index b2e25d8..9f097e2 100644
--- a/include/asm-ppc/mmu_context.h
+++ b/include/asm-ppc/mmu_context.h
@@ -64,11 +64,6 @@ static inline void enter_lazy_tlb(struct mm_struct *mm, struct task_struct *tsk)
 #define LAST_CONTEXT    	255
 #define FIRST_CONTEXT    	1

-#elif defined(CONFIG_E200) || defined(CONFIG_E500)
-#define NO_CONTEXT      	256
-#define LAST_CONTEXT    	255
-#define FIRST_CONTEXT    	1
-
 #else

 /* PPC 6xx, 7xx CPUs */
diff --git a/include/asm-ppc/pgtable.h b/include/asm-ppc/pgtable.h
index 063ad91..69347bd 100644
--- a/include/asm-ppc/pgtable.h
+++ b/include/asm-ppc/pgtable.h
@@ -271,48 +271,6 @@ extern unsigned long ioremap_bot, ioremap_base;
 /* ERPN in a PTE never gets cleared, ignore it */
 #define _PTE_NONE_MASK	0xffffffff00000000ULL

-#elif defined(CONFIG_FSL_BOOKE)
-/*
-   MMU Assist Register 3:
-
-   32 33 34 35 36  ... 50 51 52 53 54 55 56 57 58 59 60 61 62 63
-   RPN......................  0  0 U0 U1 U2 U3 UX SX UW SW UR SR
-
-   - PRESENT *must* be in the bottom three bits because swap cache
-     entries use the top 29 bits.
-
-   - FILE *must* be in the bottom three bits because swap cache
-     entries use the top 29 bits.
-*/
-
-/* Definitions for FSL Book-E Cores */
-#define _PAGE_PRESENT	0x00001	/* S: PTE contains a translation */
-#define _PAGE_USER	0x00002	/* S: User page (maps to UR) */
-#define _PAGE_FILE	0x00002	/* S: when !present: nonlinear file mapping */
-#define _PAGE_ACCESSED	0x00004	/* S: Page referenced */
-#define _PAGE_HWWRITE	0x00008	/* H: Dirty & RW, set in exception */
-#define _PAGE_RW	0x00010	/* S: Write permission */
-#define _PAGE_HWEXEC	0x00020	/* H: UX permission */
-
-#define _PAGE_ENDIAN	0x00040	/* H: E bit */
-#define _PAGE_GUARDED	0x00080	/* H: G bit */
-#define _PAGE_COHERENT	0x00100	/* H: M bit */
-#define _PAGE_NO_CACHE	0x00200	/* H: I bit */
-#define _PAGE_WRITETHRU	0x00400	/* H: W bit */
-
-#ifdef CONFIG_PTE_64BIT
-#define _PAGE_DIRTY	0x08000	/* S: Page dirty */
-
-/* ERPN in a PTE never gets cleared, ignore it */
-#define _PTE_NONE_MASK	0xffffffffffff0000ULL
-#else
-#define _PAGE_DIRTY	0x00800	/* S: Page dirty */
-#endif
-
-#define _PMD_PRESENT	0
-#define _PMD_PRESENT_MASK (PAGE_MASK)
-#define _PMD_BAD	(~PAGE_MASK)
-
 #elif defined(CONFIG_8xx)
 /* Definitions for 8xx embedded chips. */
 #define _PAGE_PRESENT	0x0001	/* Page is valid */
@@ -484,11 +442,7 @@ extern unsigned long bad_call_to_PMD_PAGE_SIZE(void);

 /* in some case we want to additionaly adjust where the pfn is in the pte to
  * allow room for more flags */
-#if defined(CONFIG_FSL_BOOKE) && defined(CONFIG_PTE_64BIT)
-#define PFN_SHIFT_OFFSET	(PAGE_SHIFT + 8)
-#else
 #define PFN_SHIFT_OFFSET	(PAGE_SHIFT)
-#endif

 #define pte_pfn(x)		(pte_val(x) >> PFN_SHIFT_OFFSET)
 #define pte_page(x)		pfn_to_page(pte_pfn(x))
diff --git a/include/asm-ppc/ppc_sys.h b/include/asm-ppc/ppc_sys.h
index 80c5851..d2fee41 100644
--- a/include/asm-ppc/ppc_sys.h
+++ b/include/asm-ppc/ppc_sys.h
@@ -23,8 +23,6 @@

 #if defined(CONFIG_8260)
 #include <asm/mpc8260.h>
-#elif defined(CONFIG_85xx)
-#include <asm/mpc85xx.h>
 #elif defined(CONFIG_8xx)
 #include <asm/mpc8xx.h>
 #elif defined(CONFIG_PPC_MPC52xx)
diff --git a/include/asm-ppc/ppcboot.h b/include/asm-ppc/ppcboot.h
index 18d04e8..3819e17 100644
--- a/include/asm-ppc/ppcboot.h
+++ b/include/asm-ppc/ppcboot.h
@@ -38,7 +38,7 @@ typedef struct bd_info {
 	unsigned long	bi_flashoffset; /* reserved area for startup monitor */
 	unsigned long	bi_sramstart;	/* start of SRAM memory */
 	unsigned long	bi_sramsize;	/* size	 of SRAM memory */
-#if defined(CONFIG_8xx) || defined(CONFIG_CPM2) || defined(CONFIG_85xx)
+#if defined(CONFIG_8xx) || defined(CONFIG_CPM2)
 	unsigned long	bi_immr_base;	/* base of IMMR register */
 #endif
 #if defined(CONFIG_PPC_MPC52xx)
@@ -72,12 +72,11 @@ typedef struct bd_info {
 #if defined(CONFIG_HYMOD)
 	hymod_conf_t	bi_hymod_conf;	/* hymod configuration information */
 #endif
-#if defined(CONFIG_EVB64260) || defined(CONFIG_405EP) || defined(CONFIG_44x) || \
-	defined(CONFIG_85xx)
+#if defined(CONFIG_EVB64260) || defined(CONFIG_405EP) || defined(CONFIG_44x)
 	/* second onboard ethernet port */
 	unsigned char	bi_enet1addr[6];
 #endif
-#if defined(CONFIG_EVB64260) || defined(CONFIG_440GX) || defined(CONFIG_85xx)
+#if defined(CONFIG_EVB64260) || defined(CONFIG_440GX)
 	/* third onboard ethernet ports */
 	unsigned char	bi_enet2addr[6];
 #endif
diff --git a/include/asm-ppc/reg_booke.h b/include/asm-ppc/reg_booke.h
index 2f1a2af..91e96af 100644
--- a/include/asm-ppc/reg_booke.h
+++ b/include/asm-ppc/reg_booke.h
@@ -218,32 +218,6 @@
 #define MCSR_DCFP	0x01000000 /* D-Cache Flush Parity Error */
 #define MCSR_IMPE	0x00800000 /* Imprecise Machine Check Exception */
 #endif
-#ifdef CONFIG_E500
-#define MCSR_MCP 	0x80000000UL /* Machine Check Input Pin */
-#define MCSR_ICPERR 	0x40000000UL /* I-Cache Parity Error */
-#define MCSR_DCP_PERR 	0x20000000UL /* D-Cache Push Parity Error */
-#define MCSR_DCPERR 	0x10000000UL /* D-Cache Parity Error */
-#define MCSR_GL_CI 	0x00010000UL /* Guarded Load or Cache-Inhibited stwcx. */
-#define MCSR_BUS_IAERR 	0x00000080UL /* Instruction Address Error */
-#define MCSR_BUS_RAERR 	0x00000040UL /* Read Address Error */
-#define MCSR_BUS_WAERR 	0x00000020UL /* Write Address Error */
-#define MCSR_BUS_IBERR 	0x00000010UL /* Instruction Data Error */
-#define MCSR_BUS_RBERR 	0x00000008UL /* Read Data Bus Error */
-#define MCSR_BUS_WBERR 	0x00000004UL /* Write Data Bus Error */
-#define MCSR_BUS_IPERR 	0x00000002UL /* Instruction parity Error */
-#define MCSR_BUS_RPERR 	0x00000001UL /* Read parity Error */
-#endif
-#ifdef CONFIG_E200
-#define MCSR_MCP 	0x80000000UL /* Machine Check Input Pin */
-#define MCSR_CP_PERR 	0x20000000UL /* Cache Push Parity Error */
-#define MCSR_CPERR 	0x10000000UL /* Cache Parity Error */
-#define MCSR_EXCP_ERR 	0x08000000UL /* ISI, ITLB, or Bus Error on 1st insn
-					fetch for an exception handler */
-#define MCSR_BUS_IRERR 	0x00000010UL /* Read Bus Error on instruction fetch*/
-#define MCSR_BUS_DRERR 	0x00000008UL /* Read Bus Error on data load */
-#define MCSR_BUS_WRERR 	0x00000004UL /* Write Bus Error on buffered
-					store or cache line push */
-#endif

 /* Bit definitions for the DBSR. */
 /*
diff --git a/include/asm-ppc/serial.h b/include/asm-ppc/serial.h
index 6220ef9..d35ed10 100644
--- a/include/asm-ppc/serial.h
+++ b/include/asm-ppc/serial.h
@@ -29,8 +29,6 @@
 #include <platforms/spruce.h>
 #elif defined(CONFIG_4xx)
 #include <asm/ibm4xx.h>
-#elif defined(CONFIG_85xx)
-#include <asm/mpc85xx.h>
 #elif defined(CONFIG_RADSTONE_PPC7D)
 #include <platforms/radstone_ppc7d.h>
 #else
-- 
1.5.3.7

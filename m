Return-Path: <sfr@canb.auug.org.au>
Date: Sat, 1 Oct 2005 21:37:53 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Paul Mackerras <paulus@samba.org>
Message-Id: <20051001213753.52d5d5c3.sfr@canb.auug.org.au>
In-Reply-To: <17214.632.655003.750819@cargo.ozlabs.ibm.com>
References: <20050930233602.138b6e27.sfr@canb.auug.org.au>
	<20051001000001.1f1d8c48.sfr@canb.auug.org.au>
	<52E29A49-AAF2-4E61-AAB2-CD02ABCBE447@freescale.com>
	<20051001121714.1b5886aa.sfr@canb.auug.org.au>
	<17214.632.655003.750819@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc64-dev@ozlabs.org, linuxppc-dev@ozlabs.org
Subject: [PATCH 6/9] powerpc: merge idle_power4.S and traps.c
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sat, 1 Oct 2005 13:28:56 +1000 Paul Mackerras <paulus@samba.org> wrote:
>
> Stephen Rothwell writes:
> 
> > My first attempt at the merge was a real mess and a right pain, so I put
> > the two files in as a compromise.  However, I have made another attempt
> > and ,although it took a while,  it seems to be going ok.  How about we put
> > the two in for now (as that will allow the merge of more platforms to
> > continue) and I will supply a further patch in a few days that combines
> > the two trapsxx.c files?
> 
> In that case, what is the advantage of having two traps*.c files in
> arch/powerpc/kernel instead of having them in arch/ppc*/kernel?

OK, thanks for keeping me honest :-)  Here is new versions of patches 6
and 7 (all the rest are the same as before).

---------------

Use idle_power4.S from ppc64 as we are not going to support
32 bit power4 in the merged tree.

Merge ppc64 traps.c into powerpc traps.c:
	use ppc64 versions of exception routine names
		(as they don't have StudlyCaps)
	make all the versions if die() have the same
		prototype

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---

 arch/powerpc/Kconfig                 |    4 
 arch/powerpc/kernel/head.S           |   84 +++--
 arch/powerpc/kernel/head_44x.S       |   14 -
 arch/powerpc/kernel/head_4xx.S       |   52 ++-
 arch/powerpc/kernel/head_8xx.S       |   42 +--
 arch/powerpc/kernel/head_fsl_booke.S |   24 +
 arch/powerpc/kernel/idle_power4.S    |   78 +++++
 arch/powerpc/kernel/ppc_ksyms.c      |   16 -
 arch/powerpc/kernel/traps.c          |  407 ++++++++++++++++++------
 arch/ppc/kernel/head.S               |   84 +++--
 arch/ppc/kernel/head_44x.S           |   14 -
 arch/ppc/kernel/head_4xx.S           |   52 ++-
 arch/ppc/kernel/head_8xx.S           |   42 +--
 arch/ppc/kernel/head_booke.h         |    4 
 arch/ppc/kernel/head_fsl_booke.S     |   24 +
 arch/ppc/kernel/ppc_ksyms.c          |   16 -
 arch/ppc/kernel/traps.c              |   20 +
 arch/ppc/syslib/ibm44x_common.c      |    2 
 arch/ppc/syslib/ppc4xx_setup.c       |    2 
 arch/ppc64/kernel/Makefile           |    8 
 arch/ppc64/kernel/idle_power4.S      |   79 -----
 arch/ppc64/kernel/traps.c            |  568 ----------------------------------
 include/asm-ppc/system.h             |    2 
 23 files changed, 640 insertions(+), 998 deletions(-)
 create mode 100644 arch/powerpc/kernel/idle_power4.S
 delete mode 100644 arch/ppc64/kernel/idle_power4.S
 delete mode 100644 arch/ppc64/kernel/traps.c

-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

dc1c1ca3dcd94c545c5e01d7c06b46824d43f4d0
diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -142,8 +142,8 @@ config POWER4
 	def_bool y
 
 config PPC_FPU
-	bool
-	default y if PPC64
+	depends on PPC32
+	def_bool y
 
 config BOOKE
 	bool
diff --git a/arch/powerpc/kernel/head.S b/arch/powerpc/kernel/head.S
--- a/arch/powerpc/kernel/head.S
+++ b/arch/powerpc/kernel/head.S
@@ -349,12 +349,12 @@ i##n:								\
 
 /* System reset */
 /* core99 pmac starts the seconary here by changing the vector, and
-   putting it back to what it was (UnknownException) when done.  */
+   putting it back to what it was (unknown_exception) when done.  */
 #if defined(CONFIG_GEMINI) && defined(CONFIG_SMP)
 	. = 0x100
 	b	__secondary_start_gemini
 #else
-	EXCEPTION(0x100, Reset, UnknownException, EXC_XFER_STD)
+	EXCEPTION(0x100, Reset, unknown_exception, EXC_XFER_STD)
 #endif
 
 /* Machine check */
@@ -389,7 +389,7 @@ i##n:								\
 	cmpwi	cr1,r4,0
 	bne	cr1,1f
 #endif
-	EXC_XFER_STD(0x200, MachineCheckException)
+	EXC_XFER_STD(0x200, machine_check_exception)
 #ifdef CONFIG_PPC_CHRP
 1:	b	machine_check_in_rtas
 #endif
@@ -456,10 +456,10 @@ Alignment:
 	mfspr	r5,SPRN_DSISR
 	stw	r5,_DSISR(r11)
 	addi	r3,r1,STACK_FRAME_OVERHEAD
-	EXC_XFER_EE(0x600, AlignmentException)
+	EXC_XFER_EE(0x600, alignment_exception)
 
 /* Program check exception */
-	EXCEPTION(0x700, ProgramCheck, ProgramCheckException, EXC_XFER_STD)
+	EXCEPTION(0x700, ProgramCheck, program_check_exception, EXC_XFER_STD)
 
 /* Floating-point unavailable */
 	. = 0x800
@@ -472,8 +472,8 @@ FPUnavailable:
 /* Decrementer */
 	EXCEPTION(0x900, Decrementer, timer_interrupt, EXC_XFER_LITE)
 
-	EXCEPTION(0xa00, Trap_0a, UnknownException, EXC_XFER_EE)
-	EXCEPTION(0xb00, Trap_0b, UnknownException, EXC_XFER_EE)
+	EXCEPTION(0xa00, Trap_0a, unknown_exception, EXC_XFER_EE)
+	EXCEPTION(0xb00, Trap_0b, unknown_exception, EXC_XFER_EE)
 
 /* System call */
 	. = 0xc00
@@ -482,8 +482,8 @@ SystemCall:
 	EXC_XFER_EE_LITE(0xc00, DoSyscall)
 
 /* Single step - not used on 601 */
-	EXCEPTION(0xd00, SingleStep, SingleStepException, EXC_XFER_STD)
-	EXCEPTION(0xe00, Trap_0e, UnknownException, EXC_XFER_EE)
+	EXCEPTION(0xd00, SingleStep, single_step_exception, EXC_XFER_STD)
+	EXCEPTION(0xe00, Trap_0e, unknown_exception, EXC_XFER_EE)
 
 /*
  * The Altivec unavailable trap is at 0x0f20.  Foo.
@@ -502,7 +502,7 @@ SystemCall:
 Trap_0f:
 	EXCEPTION_PROLOG
 	addi	r3,r1,STACK_FRAME_OVERHEAD
-	EXC_XFER_EE(0xf00, UnknownException)
+	EXC_XFER_EE(0xf00, unknown_exception)
 
 /*
  * Handle TLB miss for instruction on 603/603e.
@@ -702,44 +702,44 @@ DataStoreTLBMiss:
 	rfi
 
 #ifndef CONFIG_ALTIVEC
-#define AltivecAssistException	UnknownException
+#define altivec_assist_exception	unknown_exception
 #endif
 
-	EXCEPTION(0x1300, Trap_13, InstructionBreakpoint, EXC_XFER_EE)
+	EXCEPTION(0x1300, Trap_13, instruction_breakpoint_exception, EXC_XFER_EE)
 	EXCEPTION(0x1400, SMI, SMIException, EXC_XFER_EE)
-	EXCEPTION(0x1500, Trap_15, UnknownException, EXC_XFER_EE)
+	EXCEPTION(0x1500, Trap_15, unknown_exception, EXC_XFER_EE)
 #ifdef CONFIG_POWER4
-	EXCEPTION(0x1600, Trap_16, UnknownException, EXC_XFER_EE)
-	EXCEPTION(0x1700, Trap_17, AltivecAssistException, EXC_XFER_EE)
+	EXCEPTION(0x1600, Trap_16, unknown_exception, EXC_XFER_EE)
+	EXCEPTION(0x1700, Trap_17, altivec_assist_exception, EXC_XFER_EE)
 	EXCEPTION(0x1800, Trap_18, TAUException, EXC_XFER_STD)
 #else /* !CONFIG_POWER4 */
-	EXCEPTION(0x1600, Trap_16, AltivecAssistException, EXC_XFER_EE)
+	EXCEPTION(0x1600, Trap_16, altivec_assist_exception, EXC_XFER_EE)
 	EXCEPTION(0x1700, Trap_17, TAUException, EXC_XFER_STD)
-	EXCEPTION(0x1800, Trap_18, UnknownException, EXC_XFER_EE)
+	EXCEPTION(0x1800, Trap_18, unknown_exception, EXC_XFER_EE)
 #endif /* CONFIG_POWER4 */
-	EXCEPTION(0x1900, Trap_19, UnknownException, EXC_XFER_EE)
-	EXCEPTION(0x1a00, Trap_1a, UnknownException, EXC_XFER_EE)
-	EXCEPTION(0x1b00, Trap_1b, UnknownException, EXC_XFER_EE)
-	EXCEPTION(0x1c00, Trap_1c, UnknownException, EXC_XFER_EE)
-	EXCEPTION(0x1d00, Trap_1d, UnknownException, EXC_XFER_EE)
-	EXCEPTION(0x1e00, Trap_1e, UnknownException, EXC_XFER_EE)
-	EXCEPTION(0x1f00, Trap_1f, UnknownException, EXC_XFER_EE)
+	EXCEPTION(0x1900, Trap_19, unknown_exception, EXC_XFER_EE)
+	EXCEPTION(0x1a00, Trap_1a, unknown_exception, EXC_XFER_EE)
+	EXCEPTION(0x1b00, Trap_1b, unknown_exception, EXC_XFER_EE)
+	EXCEPTION(0x1c00, Trap_1c, unknown_exception, EXC_XFER_EE)
+	EXCEPTION(0x1d00, Trap_1d, unknown_exception, EXC_XFER_EE)
+	EXCEPTION(0x1e00, Trap_1e, unknown_exception, EXC_XFER_EE)
+	EXCEPTION(0x1f00, Trap_1f, unknown_exception, EXC_XFER_EE)
 	EXCEPTION(0x2000, RunMode, RunModeException, EXC_XFER_EE)
-	EXCEPTION(0x2100, Trap_21, UnknownException, EXC_XFER_EE)
-	EXCEPTION(0x2200, Trap_22, UnknownException, EXC_XFER_EE)
-	EXCEPTION(0x2300, Trap_23, UnknownException, EXC_XFER_EE)
-	EXCEPTION(0x2400, Trap_24, UnknownException, EXC_XFER_EE)
-	EXCEPTION(0x2500, Trap_25, UnknownException, EXC_XFER_EE)
-	EXCEPTION(0x2600, Trap_26, UnknownException, EXC_XFER_EE)
-	EXCEPTION(0x2700, Trap_27, UnknownException, EXC_XFER_EE)
-	EXCEPTION(0x2800, Trap_28, UnknownException, EXC_XFER_EE)
-	EXCEPTION(0x2900, Trap_29, UnknownException, EXC_XFER_EE)
-	EXCEPTION(0x2a00, Trap_2a, UnknownException, EXC_XFER_EE)
-	EXCEPTION(0x2b00, Trap_2b, UnknownException, EXC_XFER_EE)
-	EXCEPTION(0x2c00, Trap_2c, UnknownException, EXC_XFER_EE)
-	EXCEPTION(0x2d00, Trap_2d, UnknownException, EXC_XFER_EE)
-	EXCEPTION(0x2e00, Trap_2e, UnknownException, EXC_XFER_EE)
-	EXCEPTION(0x2f00, MOLTrampoline, UnknownException, EXC_XFER_EE_LITE)
+	EXCEPTION(0x2100, Trap_21, unknown_exception, EXC_XFER_EE)
+	EXCEPTION(0x2200, Trap_22, unknown_exception, EXC_XFER_EE)
+	EXCEPTION(0x2300, Trap_23, unknown_exception, EXC_XFER_EE)
+	EXCEPTION(0x2400, Trap_24, unknown_exception, EXC_XFER_EE)
+	EXCEPTION(0x2500, Trap_25, unknown_exception, EXC_XFER_EE)
+	EXCEPTION(0x2600, Trap_26, unknown_exception, EXC_XFER_EE)
+	EXCEPTION(0x2700, Trap_27, unknown_exception, EXC_XFER_EE)
+	EXCEPTION(0x2800, Trap_28, unknown_exception, EXC_XFER_EE)
+	EXCEPTION(0x2900, Trap_29, unknown_exception, EXC_XFER_EE)
+	EXCEPTION(0x2a00, Trap_2a, unknown_exception, EXC_XFER_EE)
+	EXCEPTION(0x2b00, Trap_2b, unknown_exception, EXC_XFER_EE)
+	EXCEPTION(0x2c00, Trap_2c, unknown_exception, EXC_XFER_EE)
+	EXCEPTION(0x2d00, Trap_2d, unknown_exception, EXC_XFER_EE)
+	EXCEPTION(0x2e00, Trap_2e, unknown_exception, EXC_XFER_EE)
+	EXCEPTION(0x2f00, MOLTrampoline, unknown_exception, EXC_XFER_EE_LITE)
 
 	.globl mol_trampoline
 	.set mol_trampoline, i0x2f00
@@ -751,7 +751,7 @@ AltiVecUnavailable:
 #ifdef CONFIG_ALTIVEC
 	bne	load_up_altivec		/* if from user, just load it up */
 #endif /* CONFIG_ALTIVEC */
-	EXC_XFER_EE_LITE(0xf20, AltivecUnavailException)
+	EXC_XFER_EE_LITE(0xf20, altivec_unavailable_exception)
 
 #ifdef CONFIG_PPC64BRIDGE
 DataAccess:
@@ -767,12 +767,12 @@ DataSegment:
 	addi	r3,r1,STACK_FRAME_OVERHEAD
 	mfspr	r4,SPRN_DAR
 	stw	r4,_DAR(r11)
-	EXC_XFER_STD(0x380, UnknownException)
+	EXC_XFER_STD(0x380, unknown_exception)
 
 InstructionSegment:
 	EXCEPTION_PROLOG
 	addi	r3,r1,STACK_FRAME_OVERHEAD
-	EXC_XFER_STD(0x480, UnknownException)
+	EXC_XFER_STD(0x480, unknown_exception)
 #endif /* CONFIG_PPC64BRIDGE */
 
 #ifdef CONFIG_ALTIVEC
diff --git a/arch/powerpc/kernel/head_44x.S b/arch/powerpc/kernel/head_44x.S
--- a/arch/powerpc/kernel/head_44x.S
+++ b/arch/powerpc/kernel/head_44x.S
@@ -309,13 +309,13 @@ skpinv:	addi	r4,r4,1				/* Increment */
 
 interrupt_base:
 	/* Critical Input Interrupt */
-	CRITICAL_EXCEPTION(0x0100, CriticalInput, UnknownException)
+	CRITICAL_EXCEPTION(0x0100, CriticalInput, unknown_exception)
 
 	/* Machine Check Interrupt */
 #ifdef CONFIG_440A
-	MCHECK_EXCEPTION(0x0200, MachineCheck, MachineCheckException)
+	MCHECK_EXCEPTION(0x0200, MachineCheck, machine_check_exception)
 #else
-	CRITICAL_EXCEPTION(0x0200, MachineCheck, MachineCheckException)
+	CRITICAL_EXCEPTION(0x0200, MachineCheck, machine_check_exception)
 #endif
 
 	/* Data Storage Interrupt */
@@ -442,7 +442,7 @@ interrupt_base:
 #ifdef CONFIG_PPC_FPU
 	FP_UNAVAILABLE_EXCEPTION
 #else
-	EXCEPTION(0x2010, FloatingPointUnavailable, UnknownException, EXC_XFER_EE)
+	EXCEPTION(0x2010, FloatingPointUnavailable, unknown_exception, EXC_XFER_EE)
 #endif
 
 	/* System Call Interrupt */
@@ -451,21 +451,21 @@ interrupt_base:
 	EXC_XFER_EE_LITE(0x0c00, DoSyscall)
 
 	/* Auxillary Processor Unavailable Interrupt */
-	EXCEPTION(0x2020, AuxillaryProcessorUnavailable, UnknownException, EXC_XFER_EE)
+	EXCEPTION(0x2020, AuxillaryProcessorUnavailable, unknown_exception, EXC_XFER_EE)
 
 	/* Decrementer Interrupt */
 	DECREMENTER_EXCEPTION
 
 	/* Fixed Internal Timer Interrupt */
 	/* TODO: Add FIT support */
-	EXCEPTION(0x1010, FixedIntervalTimer, UnknownException, EXC_XFER_EE)
+	EXCEPTION(0x1010, FixedIntervalTimer, unknown_exception, EXC_XFER_EE)
 
 	/* Watchdog Timer Interrupt */
 	/* TODO: Add watchdog support */
 #ifdef CONFIG_BOOKE_WDT
 	CRITICAL_EXCEPTION(0x1020, WatchdogTimer, WatchdogException)
 #else
-	CRITICAL_EXCEPTION(0x1020, WatchdogTimer, UnknownException)
+	CRITICAL_EXCEPTION(0x1020, WatchdogTimer, unknown_exception)
 #endif
 
 	/* Data TLB Error Interrupt */
diff --git a/arch/powerpc/kernel/head_4xx.S b/arch/powerpc/kernel/head_4xx.S
--- a/arch/powerpc/kernel/head_4xx.S
+++ b/arch/powerpc/kernel/head_4xx.S
@@ -245,12 +245,12 @@ label:
 /*
  * 0x0100 - Critical Interrupt Exception
  */
-	CRITICAL_EXCEPTION(0x0100, CriticalInterrupt, UnknownException)
+	CRITICAL_EXCEPTION(0x0100, CriticalInterrupt, unknown_exception)
 
 /*
  * 0x0200 - Machine Check Exception
  */
-	CRITICAL_EXCEPTION(0x0200, MachineCheck, MachineCheckException)
+	CRITICAL_EXCEPTION(0x0200, MachineCheck, machine_check_exception)
 
 /*
  * 0x0300 - Data Storage Exception
@@ -405,7 +405,7 @@ label:
 	mfspr	r4,SPRN_DEAR		/* Grab the DEAR and save it */
 	stw	r4,_DEAR(r11)
 	addi	r3,r1,STACK_FRAME_OVERHEAD
-	EXC_XFER_EE(0x600, AlignmentException)
+	EXC_XFER_EE(0x600, alignment_exception)
 
 /* 0x0700 - Program Exception */
 	START_EXCEPTION(0x0700, ProgramCheck)
@@ -413,21 +413,21 @@ label:
 	mfspr	r4,SPRN_ESR		/* Grab the ESR and save it */
 	stw	r4,_ESR(r11)
 	addi	r3,r1,STACK_FRAME_OVERHEAD
-	EXC_XFER_STD(0x700, ProgramCheckException)
+	EXC_XFER_STD(0x700, program_check_exception)
 
-	EXCEPTION(0x0800, Trap_08, UnknownException, EXC_XFER_EE)
-	EXCEPTION(0x0900, Trap_09, UnknownException, EXC_XFER_EE)
-	EXCEPTION(0x0A00, Trap_0A, UnknownException, EXC_XFER_EE)
-	EXCEPTION(0x0B00, Trap_0B, UnknownException, EXC_XFER_EE)
+	EXCEPTION(0x0800, Trap_08, unknown_exception, EXC_XFER_EE)
+	EXCEPTION(0x0900, Trap_09, unknown_exception, EXC_XFER_EE)
+	EXCEPTION(0x0A00, Trap_0A, unknown_exception, EXC_XFER_EE)
+	EXCEPTION(0x0B00, Trap_0B, unknown_exception, EXC_XFER_EE)
 
 /* 0x0C00 - System Call Exception */
 	START_EXCEPTION(0x0C00,	SystemCall)
 	NORMAL_EXCEPTION_PROLOG
 	EXC_XFER_EE_LITE(0xc00, DoSyscall)
 
-	EXCEPTION(0x0D00, Trap_0D, UnknownException, EXC_XFER_EE)
-	EXCEPTION(0x0E00, Trap_0E, UnknownException, EXC_XFER_EE)
-	EXCEPTION(0x0F00, Trap_0F, UnknownException, EXC_XFER_EE)
+	EXCEPTION(0x0D00, Trap_0D, unknown_exception, EXC_XFER_EE)
+	EXCEPTION(0x0E00, Trap_0E, unknown_exception, EXC_XFER_EE)
+	EXCEPTION(0x0F00, Trap_0F, unknown_exception, EXC_XFER_EE)
 
 /* 0x1000 - Programmable Interval Timer (PIT) Exception */
 	START_EXCEPTION(0x1000, Decrementer)
@@ -444,14 +444,14 @@ label:
 
 /* 0x1010 - Fixed Interval Timer (FIT) Exception
 */
-	STND_EXCEPTION(0x1010,	FITException,		UnknownException)
+	STND_EXCEPTION(0x1010,	FITException,		unknown_exception)
 
 /* 0x1020 - Watchdog Timer (WDT) Exception
 */
 #ifdef CONFIG_BOOKE_WDT
 	CRITICAL_EXCEPTION(0x1020, WDTException, WatchdogException)
 #else
-	CRITICAL_EXCEPTION(0x1020, WDTException, UnknownException)
+	CRITICAL_EXCEPTION(0x1020, WDTException, unknown_exception)
 #endif
 #endif
 
@@ -656,25 +656,25 @@ label:
 	mfspr	r10, SPRN_SPRG0
 	b	InstructionAccess
 
-	EXCEPTION(0x1300, Trap_13, UnknownException, EXC_XFER_EE)
-	EXCEPTION(0x1400, Trap_14, UnknownException, EXC_XFER_EE)
-	EXCEPTION(0x1500, Trap_15, UnknownException, EXC_XFER_EE)
-	EXCEPTION(0x1600, Trap_16, UnknownException, EXC_XFER_EE)
+	EXCEPTION(0x1300, Trap_13, unknown_exception, EXC_XFER_EE)
+	EXCEPTION(0x1400, Trap_14, unknown_exception, EXC_XFER_EE)
+	EXCEPTION(0x1500, Trap_15, unknown_exception, EXC_XFER_EE)
+	EXCEPTION(0x1600, Trap_16, unknown_exception, EXC_XFER_EE)
 #ifdef CONFIG_IBM405_ERR51
 	/* 405GP errata 51 */
 	START_EXCEPTION(0x1700, Trap_17)
 	b DTLBMiss
 #else
-	EXCEPTION(0x1700, Trap_17, UnknownException, EXC_XFER_EE)
+	EXCEPTION(0x1700, Trap_17, unknown_exception, EXC_XFER_EE)
 #endif
-	EXCEPTION(0x1800, Trap_18, UnknownException, EXC_XFER_EE)
-	EXCEPTION(0x1900, Trap_19, UnknownException, EXC_XFER_EE)
-	EXCEPTION(0x1A00, Trap_1A, UnknownException, EXC_XFER_EE)
-	EXCEPTION(0x1B00, Trap_1B, UnknownException, EXC_XFER_EE)
-	EXCEPTION(0x1C00, Trap_1C, UnknownException, EXC_XFER_EE)
-	EXCEPTION(0x1D00, Trap_1D, UnknownException, EXC_XFER_EE)
-	EXCEPTION(0x1E00, Trap_1E, UnknownException, EXC_XFER_EE)
-	EXCEPTION(0x1F00, Trap_1F, UnknownException, EXC_XFER_EE)
+	EXCEPTION(0x1800, Trap_18, unknown_exception, EXC_XFER_EE)
+	EXCEPTION(0x1900, Trap_19, unknown_exception, EXC_XFER_EE)
+	EXCEPTION(0x1A00, Trap_1A, unknown_exception, EXC_XFER_EE)
+	EXCEPTION(0x1B00, Trap_1B, unknown_exception, EXC_XFER_EE)
+	EXCEPTION(0x1C00, Trap_1C, unknown_exception, EXC_XFER_EE)
+	EXCEPTION(0x1D00, Trap_1D, unknown_exception, EXC_XFER_EE)
+	EXCEPTION(0x1E00, Trap_1E, unknown_exception, EXC_XFER_EE)
+	EXCEPTION(0x1F00, Trap_1F, unknown_exception, EXC_XFER_EE)
 
 /* Check for a single step debug exception while in an exception
  * handler before state has been saved.  This is to catch the case
diff --git a/arch/powerpc/kernel/head_8xx.S b/arch/powerpc/kernel/head_8xx.S
--- a/arch/powerpc/kernel/head_8xx.S
+++ b/arch/powerpc/kernel/head_8xx.S
@@ -203,7 +203,7 @@ i##n:								\
 			  ret_from_except)
 
 /* System reset */
-	EXCEPTION(0x100, Reset, UnknownException, EXC_XFER_STD)
+	EXCEPTION(0x100, Reset, unknown_exception, EXC_XFER_STD)
 
 /* Machine check */
 	. = 0x200
@@ -214,7 +214,7 @@ MachineCheck:
 	mfspr r5,SPRN_DSISR
 	stw r5,_DSISR(r11)
 	addi r3,r1,STACK_FRAME_OVERHEAD
-	EXC_XFER_STD(0x200, MachineCheckException)
+	EXC_XFER_STD(0x200, machine_check_exception)
 
 /* Data access exception.
  * This is "never generated" by the MPC8xx.  We jump to it for other
@@ -252,20 +252,20 @@ Alignment:
 	mfspr	r5,SPRN_DSISR
 	stw	r5,_DSISR(r11)
 	addi	r3,r1,STACK_FRAME_OVERHEAD
-	EXC_XFER_EE(0x600, AlignmentException)
+	EXC_XFER_EE(0x600, alignment_exception)
 
 /* Program check exception */
-	EXCEPTION(0x700, ProgramCheck, ProgramCheckException, EXC_XFER_STD)
+	EXCEPTION(0x700, ProgramCheck, program_check_exception, EXC_XFER_STD)
 
 /* No FPU on MPC8xx.  This exception is not supposed to happen.
 */
-	EXCEPTION(0x800, FPUnavailable, UnknownException, EXC_XFER_STD)
+	EXCEPTION(0x800, FPUnavailable, unknown_exception, EXC_XFER_STD)
 
 /* Decrementer */
 	EXCEPTION(0x900, Decrementer, timer_interrupt, EXC_XFER_LITE)
 
-	EXCEPTION(0xa00, Trap_0a, UnknownException, EXC_XFER_EE)
-	EXCEPTION(0xb00, Trap_0b, UnknownException, EXC_XFER_EE)
+	EXCEPTION(0xa00, Trap_0a, unknown_exception, EXC_XFER_EE)
+	EXCEPTION(0xb00, Trap_0b, unknown_exception, EXC_XFER_EE)
 
 /* System call */
 	. = 0xc00
@@ -274,9 +274,9 @@ SystemCall:
 	EXC_XFER_EE_LITE(0xc00, DoSyscall)
 
 /* Single step - not used on 601 */
-	EXCEPTION(0xd00, SingleStep, SingleStepException, EXC_XFER_STD)
-	EXCEPTION(0xe00, Trap_0e, UnknownException, EXC_XFER_EE)
-	EXCEPTION(0xf00, Trap_0f, UnknownException, EXC_XFER_EE)
+	EXCEPTION(0xd00, SingleStep, single_step_exception, EXC_XFER_STD)
+	EXCEPTION(0xe00, Trap_0e, unknown_exception, EXC_XFER_EE)
+	EXCEPTION(0xf00, Trap_0f, unknown_exception, EXC_XFER_EE)
 
 /* On the MPC8xx, this is a software emulation interrupt.  It occurs
  * for all unimplemented and illegal instructions.
@@ -540,22 +540,22 @@ DataTLBError:
 #endif
 	b	DataAccess
 
-	EXCEPTION(0x1500, Trap_15, UnknownException, EXC_XFER_EE)
-	EXCEPTION(0x1600, Trap_16, UnknownException, EXC_XFER_EE)
-	EXCEPTION(0x1700, Trap_17, UnknownException, EXC_XFER_EE)
-	EXCEPTION(0x1800, Trap_18, UnknownException, EXC_XFER_EE)
-	EXCEPTION(0x1900, Trap_19, UnknownException, EXC_XFER_EE)
-	EXCEPTION(0x1a00, Trap_1a, UnknownException, EXC_XFER_EE)
-	EXCEPTION(0x1b00, Trap_1b, UnknownException, EXC_XFER_EE)
+	EXCEPTION(0x1500, Trap_15, unknown_exception, EXC_XFER_EE)
+	EXCEPTION(0x1600, Trap_16, unknown_exception, EXC_XFER_EE)
+	EXCEPTION(0x1700, Trap_17, unknown_exception, EXC_XFER_EE)
+	EXCEPTION(0x1800, Trap_18, unknown_exception, EXC_XFER_EE)
+	EXCEPTION(0x1900, Trap_19, unknown_exception, EXC_XFER_EE)
+	EXCEPTION(0x1a00, Trap_1a, unknown_exception, EXC_XFER_EE)
+	EXCEPTION(0x1b00, Trap_1b, unknown_exception, EXC_XFER_EE)
 
 /* On the MPC8xx, these next four traps are used for development
  * support of breakpoints and such.  Someday I will get around to
  * using them.
  */
-	EXCEPTION(0x1c00, Trap_1c, UnknownException, EXC_XFER_EE)
-	EXCEPTION(0x1d00, Trap_1d, UnknownException, EXC_XFER_EE)
-	EXCEPTION(0x1e00, Trap_1e, UnknownException, EXC_XFER_EE)
-	EXCEPTION(0x1f00, Trap_1f, UnknownException, EXC_XFER_EE)
+	EXCEPTION(0x1c00, Trap_1c, unknown_exception, EXC_XFER_EE)
+	EXCEPTION(0x1d00, Trap_1d, unknown_exception, EXC_XFER_EE)
+	EXCEPTION(0x1e00, Trap_1e, unknown_exception, EXC_XFER_EE)
+	EXCEPTION(0x1f00, Trap_1f, unknown_exception, EXC_XFER_EE)
 
 	. = 0x2000
 
diff --git a/arch/powerpc/kernel/head_fsl_booke.S b/arch/powerpc/kernel/head_fsl_booke.S
--- a/arch/powerpc/kernel/head_fsl_booke.S
+++ b/arch/powerpc/kernel/head_fsl_booke.S
@@ -426,14 +426,14 @@ skpinv:	addi	r6,r6,1				/* Increment */
 
 interrupt_base:
 	/* Critical Input Interrupt */
-	CRITICAL_EXCEPTION(0x0100, CriticalInput, UnknownException)
+	CRITICAL_EXCEPTION(0x0100, CriticalInput, unknown_exception)
 
 	/* Machine Check Interrupt */
 #ifdef CONFIG_E200
 	/* no RFMCI, MCSRRs on E200 */
-	CRITICAL_EXCEPTION(0x0200, MachineCheck, MachineCheckException)
+	CRITICAL_EXCEPTION(0x0200, MachineCheck, machine_check_exception)
 #else
-	MCHECK_EXCEPTION(0x0200, MachineCheck, MachineCheckException)
+	MCHECK_EXCEPTION(0x0200, MachineCheck, machine_check_exception)
 #endif
 
 	/* Data Storage Interrupt */
@@ -542,9 +542,9 @@ interrupt_base:
 #else
 #ifdef CONFIG_E200
 	/* E200 treats 'normal' floating point instructions as FP Unavail exception */
-	EXCEPTION(0x0800, FloatingPointUnavailable, ProgramCheckException, EXC_XFER_EE)
+	EXCEPTION(0x0800, FloatingPointUnavailable, program_check_exception, EXC_XFER_EE)
 #else
-	EXCEPTION(0x0800, FloatingPointUnavailable, UnknownException, EXC_XFER_EE)
+	EXCEPTION(0x0800, FloatingPointUnavailable, unknown_exception, EXC_XFER_EE)
 #endif
 #endif
 
@@ -554,20 +554,20 @@ interrupt_base:
 	EXC_XFER_EE_LITE(0x0c00, DoSyscall)
 
 	/* Auxillary Processor Unavailable Interrupt */
-	EXCEPTION(0x2900, AuxillaryProcessorUnavailable, UnknownException, EXC_XFER_EE)
+	EXCEPTION(0x2900, AuxillaryProcessorUnavailable, unknown_exception, EXC_XFER_EE)
 
 	/* Decrementer Interrupt */
 	DECREMENTER_EXCEPTION
 
 	/* Fixed Internal Timer Interrupt */
 	/* TODO: Add FIT support */
-	EXCEPTION(0x3100, FixedIntervalTimer, UnknownException, EXC_XFER_EE)
+	EXCEPTION(0x3100, FixedIntervalTimer, unknown_exception, EXC_XFER_EE)
 
 	/* Watchdog Timer Interrupt */
 #ifdef CONFIG_BOOKE_WDT
 	CRITICAL_EXCEPTION(0x3200, WatchdogTimer, WatchdogException)
 #else
-	CRITICAL_EXCEPTION(0x3200, WatchdogTimer, UnknownException)
+	CRITICAL_EXCEPTION(0x3200, WatchdogTimer, unknown_exception)
 #endif
 
 	/* Data TLB Error Interrupt */
@@ -696,21 +696,21 @@ interrupt_base:
 	addi    r3,r1,STACK_FRAME_OVERHEAD
 	EXC_XFER_EE_LITE(0x2010, KernelSPE)
 #else
-	EXCEPTION(0x2020, SPEUnavailable, UnknownException, EXC_XFER_EE)
+	EXCEPTION(0x2020, SPEUnavailable, unknown_exception, EXC_XFER_EE)
 #endif /* CONFIG_SPE */
 
 	/* SPE Floating Point Data */
 #ifdef CONFIG_SPE
 	EXCEPTION(0x2030, SPEFloatingPointData, SPEFloatingPointException, EXC_XFER_EE);
 #else
-	EXCEPTION(0x2040, SPEFloatingPointData, UnknownException, EXC_XFER_EE)
+	EXCEPTION(0x2040, SPEFloatingPointData, unknown_exception, EXC_XFER_EE)
 #endif /* CONFIG_SPE */
 
 	/* SPE Floating Point Round */
-	EXCEPTION(0x2050, SPEFloatingPointRound, UnknownException, EXC_XFER_EE)
+	EXCEPTION(0x2050, SPEFloatingPointRound, unknown_exception, EXC_XFER_EE)
 
 	/* Performance Monitor */
-	EXCEPTION(0x2060, PerformanceMonitor, PerformanceMonitorException, EXC_XFER_STD)
+	EXCEPTION(0x2060, PerformanceMonitor, performance_monitor_exception, EXC_XFER_STD)
 
 
 	/* Debug Interrupt */
diff --git a/arch/powerpc/kernel/idle_power4.S b/arch/powerpc/kernel/idle_power4.S
new file mode 100644
--- /dev/null
+++ b/arch/powerpc/kernel/idle_power4.S
@@ -0,0 +1,78 @@
+/*
+ *  This file contains the power_save function for 6xx & 7xxx CPUs
+ *  rewritten in assembler
+ *
+ *  Warning ! This code assumes that if your machine has a 750fx
+ *  it will have PLL 1 set to low speed mode (used during NAP/DOZE).
+ *  if this is not the case some additional changes will have to
+ *  be done to check a runtime var (a bit like powersave-nap)
+ *
+ *  This program is free software; you can redistribute it and/or
+ *  modify it under the terms of the GNU General Public License
+ *  as published by the Free Software Foundation; either version
+ *  2 of the License, or (at your option) any later version.
+ */
+
+#include <linux/config.h>
+#include <linux/threads.h>
+#include <asm/processor.h>
+#include <asm/page.h>
+#include <asm/cputable.h>
+#include <asm/thread_info.h>
+#include <asm/ppc_asm.h>
+#include <asm/asm-offsets.h>
+
+#undef DEBUG
+
+	.text
+
+/*
+ * Here is the power_save_6xx function. This could eventually be
+ * split into several functions & changing the function pointer
+ * depending on the various features.
+ */
+_GLOBAL(power4_idle)
+BEGIN_FTR_SECTION
+	blr
+END_FTR_SECTION_IFCLR(CPU_FTR_CAN_NAP)
+	/* We must dynamically check for the NAP feature as it
+	 * can be cleared by CPU init after the fixups are done
+	 */
+	LOADBASE(r3,cur_cpu_spec)
+	ld	r4,cur_cpu_spec@l(r3)
+	ld	r4,CPU_SPEC_FEATURES(r4)
+	andi.	r0,r4,CPU_FTR_CAN_NAP
+	beqlr
+	/* Now check if user or arch enabled NAP mode */
+	LOADBASE(r3,powersave_nap)
+	lwz	r4,powersave_nap@l(r3)
+	cmpwi	0,r4,0
+	beqlr
+
+	/* Clear MSR:EE */
+	mfmsr	r7
+	li	r4,0
+	ori	r4,r4,MSR_EE
+	andc	r0,r7,r4
+	mtmsrd	r0
+
+	/* Check current_thread_info()->flags */
+	clrrdi	r4,r1,THREAD_SHIFT
+	ld	r4,TI_FLAGS(r4)
+	andi.	r0,r4,_TIF_NEED_RESCHED
+	beq	1f
+	mtmsrd	r7	/* out of line this ? */
+	blr
+1:
+	/* Go to NAP now */
+BEGIN_FTR_SECTION
+	DSSALL
+	sync
+END_FTR_SECTION_IFSET(CPU_FTR_ALTIVEC)
+	oris	r7,r7,MSR_POW@h
+	sync
+	isync
+	mtmsrd	r7
+	isync
+	sync
+	blr
diff --git a/arch/powerpc/kernel/ppc_ksyms.c b/arch/powerpc/kernel/ppc_ksyms.c
--- a/arch/powerpc/kernel/ppc_ksyms.c
+++ b/arch/powerpc/kernel/ppc_ksyms.c
@@ -53,10 +53,10 @@
 
 extern void transfer_to_handler(void);
 extern void do_IRQ(struct pt_regs *regs);
-extern void MachineCheckException(struct pt_regs *regs);
-extern void AlignmentException(struct pt_regs *regs);
-extern void ProgramCheckException(struct pt_regs *regs);
-extern void SingleStepException(struct pt_regs *regs);
+extern void machine_check_exception(struct pt_regs *regs);
+extern void alignment_exception(struct pt_regs *regs);
+extern void program_check_exception(struct pt_regs *regs);
+extern void single_step_exception(struct pt_regs *regs);
 extern int do_signal(sigset_t *, struct pt_regs *);
 extern int pmac_newworld;
 extern int sys_sigreturn(struct pt_regs *regs);
@@ -72,10 +72,10 @@ EXPORT_SYMBOL(clear_user_page);
 EXPORT_SYMBOL(do_signal);
 EXPORT_SYMBOL(transfer_to_handler);
 EXPORT_SYMBOL(do_IRQ);
-EXPORT_SYMBOL(MachineCheckException);
-EXPORT_SYMBOL(AlignmentException);
-EXPORT_SYMBOL(ProgramCheckException);
-EXPORT_SYMBOL(SingleStepException);
+EXPORT_SYMBOL(machine_check_exception);
+EXPORT_SYMBOL(alignment_exception);
+EXPORT_SYMBOL(program_check_exception);
+EXPORT_SYMBOL(single_step_exception);
 EXPORT_SYMBOL(sys_sigreturn);
 EXPORT_SYMBOL(ppc_n_lost_interrupts);
 EXPORT_SYMBOL(ppc_lost_interrupts);
diff --git a/arch/powerpc/kernel/traps.c b/arch/powerpc/kernel/traps.c
--- a/arch/powerpc/kernel/traps.c
+++ b/arch/powerpc/kernel/traps.c
@@ -1,6 +1,4 @@
 /*
- *  arch/powerpc/kernel/traps.c
- *
  *  Copyright (C) 1995-1996  Gary Thomas (gdt@linuxppc.org)
  *
  *  This program is free software; you can redistribute it and/or
@@ -23,29 +21,46 @@
 #include <linux/mm.h>
 #include <linux/stddef.h>
 #include <linux/unistd.h>
-#include <linux/ptrace.h>
 #include <linux/slab.h>
 #include <linux/user.h>
 #include <linux/a.out.h>
 #include <linux/interrupt.h>
-#include <linux/config.h>
 #include <linux/init.h>
 #include <linux/module.h>
-#include <linux/prctl.h>
 #include <linux/delay.h>
 #include <linux/kprobes.h>
 #include <asm/kdebug.h>
+#ifdef CONFIG_PPC32
+#include <linux/ptrace.h>
+#include <linux/prctl.h>
+#endif
 
 #include <asm/pgtable.h>
 #include <asm/uaccess.h>
 #include <asm/system.h>
 #include <asm/io.h>
+#ifdef CONFIG_PPC32
 #include <asm/reg.h>
 #include <asm/xmon.h>
 #ifdef CONFIG_PMAC_BACKLIGHT
 #include <asm/backlight.h>
 #endif
 #include <asm/perfmon.h>
+#endif
+#ifdef CONFIG_PPC64
+#include <asm/processor.h>
+#include <asm/ppcdebug.h>
+#include <asm/rtas.h>
+#include <asm/systemcfg.h>
+#include <asm/machdep.h>
+#include <asm/pmc.h>
+#endif
+
+#ifdef CONFIG_PPC64
+#define __KPROBES	__kprobes
+#else
+#define __KPROBES
+#endif
 
 #ifdef CONFIG_DEBUGGER
 int (*__debugger)(struct pt_regs *regs);
@@ -96,7 +111,7 @@ int die(const char *str, struct pt_regs 
 	console_verbose();
 	spin_lock_irq(&die_lock);
 	bust_spinlocks(1);
-#ifdef CONFIG_PMAC_BACKLIGHT
+#if defined(CONFIG_PPC32) && defined(CONFIG_PMAC_BACKLIGHT)
 	if (_machine == _MACH_Pmac) {
 		set_backlight_enable(1);
 		set_backlight_level(BACKLIGHT_MAX);
@@ -154,9 +169,17 @@ int die(const char *str, struct pt_regs 
 		panic("Fatal exception in interrupt");
 
 	if (panic_on_oops) {
+#ifdef CONFIG_PPC64
+		printk(KERN_EMERG "Fatal exception: panic in 5 seconds\n");
+		ssleep(5);
+#endif
 		panic("Fatal exception");
 	}
+#ifdef CONFIG_PPC32
 	do_exit(err);
+#else
+	do_exit(SIGSEGV);
+#endif
 
 	return 0;
 }
@@ -176,6 +199,7 @@ void _exception(int signr, struct pt_reg
 	info.si_addr = (void __user *) addr;
 	force_sig_info(signr, &info, current);
 
+#ifdef CONFIG_PPC32
 	/*
 	 * Init gets no signals that it doesn't have a handler for.
 	 * That's all very well, but if it has caused a synchronous
@@ -197,6 +221,7 @@ void _exception(int signr, struct pt_reg
 			do_exit(signr);
 		}
 	}
+#endif
 }
 
 #ifdef CONFIG_PPC64
@@ -206,7 +231,7 @@ void system_reset_exception(struct pt_re
 	if (ppc_md.system_reset_exception)
 		ppc_md.system_reset_exception(regs);
 
-	die("System Reset", regs, SIGABRT);
+	die("System Reset", regs, 0);
 
 	/* Must die if the interrupt is not recoverable */
 	if (!(regs->msr & MSR_RI))
@@ -216,6 +241,7 @@ void system_reset_exception(struct pt_re
 }
 #endif
 
+#ifdef CONFIG_PPC32
 /*
  * I/O accesses can cause machine checks on powermacs.
  * Check if the NIP corresponds to the address of a sync
@@ -264,8 +290,10 @@ static inline int check_io_access(struct
 #endif /* CONFIG_PPC_PMAC */
 	return 0;
 }
+#endif /* CONFIG_PPC32 */
 
 #if defined(CONFIG_4xx) || defined(CONFIG_BOOKE)
+
 /* On 4xx, the reason for the machine check or program exception
    is in the ESR. */
 #define get_reason(regs)	((regs)->dsisr)
@@ -284,6 +312,7 @@ static inline int check_io_access(struct
 #define clear_single_step(regs)	(current->thread.dbcr0 &= ~DBCR0_IC)
 
 #else
+
 /* On non-4xx, the reason for the machine check or program
    exception is in the MSR. */
 #define get_reason(regs)	((regs)->msr)
@@ -297,6 +326,7 @@ static inline int check_io_access(struct
 #define clear_single_step(regs)	((regs)->msr &= ~MSR_SE)
 #endif
 
+#ifdef CONFIG_PPC32
 /*
  * This is "fall-back" implementation for configurations
  * which don't provide platform-specific machine check info
@@ -305,8 +335,9 @@ void __attribute__ ((weak))
 platform_machine_check(struct pt_regs *regs)
 {
 }
+#endif
 
-void MachineCheckException(struct pt_regs *regs)
+void machine_check_exception(struct pt_regs *regs)
 {
 #ifdef CONFIG_PPC64
 	int recover = 0;
@@ -462,23 +493,31 @@ void MachineCheckException(struct pt_reg
 	 * additional info, e.g. bus error registers.
 	 */
 	platform_machine_check(regs);
-#endif /* CONFIG_PPC64 */
+#endif /* CONFIG_PPC32 */
 
 	if (debugger_fault_handler(regs))
 		return;
-	die("Machine check", regs, SIGBUS);
+	die("Machine check", regs,
+#ifdef CONFIG_PPC32
+		SIGBUS
+#else
+		0
+#endif
+	);
 
 	/* Must die if the interrupt is not recoverable */
 	if (!(regs->msr & MSR_RI))
 		panic("Unrecoverable Machine check");
 }
 
+#ifdef CONFIG_PPC32
 void SMIException(struct pt_regs *regs)
 {
 	die("System Management Interrupt", regs, SIGABRT);
 }
+#endif
 
-void UnknownException(struct pt_regs *regs)
+void unknown_exception(struct pt_regs *regs)
 {
 	printk("Bad trap at PC: %lx, SR: %lx, vector=%lx\n",
 	       regs->nip, regs->msr, regs->trap);
@@ -486,7 +525,7 @@ void UnknownException(struct pt_regs *re
 	_exception(SIGTRAP, regs, 0, 0);
 }
 
-void InstructionBreakpoint(struct pt_regs *regs)
+void instruction_breakpoint_exception(struct pt_regs *regs)
 {
 	if (notify_die(DIE_IABR_MATCH, "iabr_match", regs, 5,
 					5, SIGTRAP) == NOTIFY_STOP)
@@ -496,14 +535,20 @@ void InstructionBreakpoint(struct pt_reg
 	_exception(SIGTRAP, regs, TRAP_BRKPT, regs->nip);
 }
 
+#ifdef CONFIG_PPC32
 void RunModeException(struct pt_regs *regs)
 {
 	_exception(SIGTRAP, regs, 0, 0);
 }
+#endif
 
-void SingleStepException(struct pt_regs *regs)
+void __KPROBES single_step_exception(struct pt_regs *regs)
 {
+#ifdef CONFIG_PPC32
 	regs->msr &= ~(MSR_SE | MSR_BE);  /* Turn off 'trace' bits */
+#else
+	regs->msr &= ~MSR_SE;  /* Turn off 'trace' bit */
+#endif
 
 	if (notify_die(DIE_SSTEP, "single_step", regs, 5,
 					5, SIGTRAP) == NOTIFY_STOP)
@@ -520,15 +565,62 @@ void SingleStepException(struct pt_regs 
  * pretend we got a single-step exception.  This was pointed out
  * by Kumar Gala.  -- paulus
  */
-static void emulate_single_step(struct pt_regs *regs)
+static inline void emulate_single_step(struct pt_regs *regs)
 {
 	if (single_stepping(regs)) {
+#ifdef CONFIG_PPC32
 		clear_single_step(regs);
 		_exception(SIGTRAP, regs, TRAP_TRACE, 0);
+#else
+		single_step_exception(regs);
+#endif
 	}
 }
 
-/* Illegal instruction emulation support.  Originally written to
+static void parse_fpe(struct pt_regs *regs)
+{
+	int code = 0;
+	unsigned long fpscr;
+
+#ifdef CONFIG_PPC32
+	/* We must make sure the FP state is consistent with
+	 * our MSR_FP in regs
+	 */
+	preempt_disable();
+	if (regs->msr & MSR_FP)
+		giveup_fpu(current);
+	preempt_enable();
+#else
+	flush_fp_to_thread(current);
+#endif
+
+	fpscr = current->thread.fpscr;
+
+	/* Invalid operation */
+	if ((fpscr & FPSCR_VE) && (fpscr & FPSCR_VX))
+		code = FPE_FLTINV;
+
+	/* Overflow */
+	else if ((fpscr & FPSCR_OE) && (fpscr & FPSCR_OX))
+		code = FPE_FLTOVF;
+
+	/* Underflow */
+	else if ((fpscr & FPSCR_UE) && (fpscr & FPSCR_UX))
+		code = FPE_FLTUND;
+
+	/* Divide by zero */
+	else if ((fpscr & FPSCR_ZE) && (fpscr & FPSCR_ZX))
+		code = FPE_FLTDIV;
+
+	/* Inexact result */
+	else if ((fpscr & FPSCR_XE) && (fpscr & FPSCR_XX))
+		code = FPE_FLTRES;
+
+	_exception(SIGFPE, regs, code, regs->nip);
+}
+
+/*
+ * Illegal instruction emulation support.  Originally written to
  * provide the PVR to user applications using the mfspr rd, PVR.
  * Return non-zero if we can't emulate, or -EFAULT if the associated
  * memory access caused an access fault.  Return zero on success.
@@ -536,7 +628,6 @@ static void emulate_single_step(struct p
  * There are a couple of ways to do this, either "decode" the instruction
  * or directly match lots of bits.  In this case, matching lots of
  * bits is faster and easier.
- *
  */
 #define INST_MFSPR_PVR		0x7c1f42a6
 #define INST_MFSPR_PVR_MASK	0xfc1fffff
@@ -547,6 +638,8 @@ static void emulate_single_step(struct p
 #define INST_MCRXR		0x7c000400
 #define INST_MCRXR_MASK		0x7c0007fe
 
+#ifdef CONFIG_PPC32
+
 #define INST_STRING		0x7c00042a
 #define INST_STRING_MASK	0x7c0007fe
 #define INST_STRING_GEN_MASK	0x7c00067e
@@ -622,6 +715,7 @@ static int emulate_string_inst(struct pt
 
 	return 0;
 }
+#endif /* CONFIG_PPC32 */
 
 static int emulate_instruction(struct pt_regs *regs)
 {
@@ -643,22 +737,44 @@ static int emulate_instruction(struct pt
 	}
 
 	/* Emulating the dcba insn is just a no-op.  */
-	if ((instword & INST_DCBA_MASK) == INST_DCBA)
+	if ((instword & INST_DCBA_MASK) == INST_DCBA) {
+#ifdef CONFIG_PPC64
+		static int warned;
+
+		if (!warned) {
+			printk(KERN_WARNING
+			       "process %d (%s) uses obsolete 'dcba' insn\n",
+			       current->pid, current->comm);
+			warned = 1;
+		}
+#endif /* CONFIG_PPC64 */
 		return 0;
+	}
 
 	/* Emulate the mcrxr insn.  */
 	if ((instword & INST_MCRXR_MASK) == INST_MCRXR) {
-		int shift = (instword >> 21) & 0x1c;
+		unsigned int shift = (instword >> 21) & 0x1c;
 		unsigned long msk = 0xf0000000UL >> shift;
+#ifdef CONFIG_PPC64
+		static int warned;
 
+		if (!warned) {
+			printk(KERN_WARNING
+			       "process %d (%s) uses obsolete 'mcrxr' insn\n",
+			       current->pid, current->comm);
+			warned = 1;
+		}
+#endif
 		regs->ccr = (regs->ccr & ~msk) | ((regs->xer >> shift) & msk);
 		regs->xer &= ~0xf0000000UL;
 		return 0;
 	}
 
+#ifdef CONFIG_PPC32
 	/* Emulate load/store string insn. */
 	if ((instword & INST_STRING_GEN_MASK) == INST_STRING)
 		return emulate_string_inst(regs, instword);
+#endif
 
 	return -EINVAL;
 }
@@ -686,7 +802,7 @@ struct bug_entry *find_bug(unsigned long
 	return module_find_bug(bugaddr);
 }
 
-int check_bug_trap(struct pt_regs *regs)
+static int check_bug_trap(struct pt_regs *regs)
 {
 	struct bug_entry *bug;
 	unsigned long addr;
@@ -701,34 +817,38 @@ int check_bug_trap(struct pt_regs *regs)
 		return 0;
 	if (bug->line & BUG_WARNING_TRAP) {
 		/* this is a WARN_ON rather than BUG/BUG_ON */
-#ifdef CONFIG_XMON
+#if defined(CONFIG_PPC32) && defined(CONFIG_XMON)
 		xmon_printf(KERN_ERR "Badness in %s at %s:%d\n",
 		       bug->function, bug->file,
 		       bug->line & ~BUG_WARNING_TRAP);
-#endif /* CONFIG_XMON */		
+#endif
 		printk(KERN_ERR "Badness in %s at %s:%d\n",
 		       bug->function, bug->file,
 		       bug->line & ~BUG_WARNING_TRAP);
+#ifdef CONFIG_PPC32
 		dump_stack();
+#else
+		show_stack(current, (void *)regs->gpr[1]);
+#endif
 		return 1;
 	}
-#ifdef CONFIG_XMON
+#if defined(CONFIG_PPC32) && defined(CONFIG_XMON)
 	xmon_printf(KERN_CRIT "kernel BUG in %s at %s:%d!\n",
 	       bug->function, bug->file, bug->line);
 	xmon(regs);
-#endif /* CONFIG_XMON */
+#endif
 	printk(KERN_CRIT "kernel BUG in %s at %s:%d!\n",
 	       bug->function, bug->file, bug->line);
 
 	return 0;
 }
 
-void ProgramCheckException(struct pt_regs *regs)
+void __KPROBES program_check_exception(struct pt_regs *regs)
 {
 	unsigned int reason = get_reason(regs);
+#if defined(CONFIG_PPC32) && defined(CONFIG_MATH_EMULATION)
 	extern int do_mathemu(struct pt_regs *regs);
 
-#ifdef CONFIG_MATH_EMULATION
 	/* (reason & REASON_ILLEGAL) would be the obvious thing here,
 	 * but there seems to be a hardware bug on the 405GP (RevD)
 	 * that means ESR is sometimes set incorrectly - either to
@@ -740,69 +860,61 @@ void ProgramCheckException(struct pt_reg
 		emulate_single_step(regs);
 		return;
 	}
-#endif /* CONFIG_MATH_EMULATION */
-
-	if (reason & REASON_FP) {
-		/* IEEE FP exception */
-		int code = 0;
-		u32 fpscr;
+#endif
 
-		/* We must make sure the FP state is consistent with
-		 * our MSR_FP in regs
-		 */
-		preempt_disable();
-		if (regs->msr & MSR_FP)
-			giveup_fpu(current);
-		preempt_enable();
-
-		fpscr = current->thread.fpscr;
-		fpscr &= fpscr << 22;	/* mask summary bits with enables */
-		if (fpscr & FPSCR_VX)
-			code = FPE_FLTINV;
-		else if (fpscr & FPSCR_OX)
-			code = FPE_FLTOVF;
-		else if (fpscr & FPSCR_UX)
-			code = FPE_FLTUND;
-		else if (fpscr & FPSCR_ZX)
-			code = FPE_FLTDIV;
-		else if (fpscr & FPSCR_XX)
-			code = FPE_FLTRES;
-		_exception(SIGFPE, regs, code, regs->nip);
+#ifdef CONFIG_PPC64
+	if (debugger_fault_handler(regs))
 		return;
-	}
+#endif
 
-	if (reason & REASON_TRAP) {
+	if (reason & REASON_FP) {
+		/* IEEE FP exception */
+		parse_fpe(regs);
+	} else if (reason & REASON_TRAP) {
 		/* trap exception */
+#ifdef CONFIG_PPC64
+		if (notify_die(DIE_BPT, "breakpoint", regs, 5, 5, SIGTRAP)
+				== NOTIFY_STOP)
+			return;
+#endif
 		if (debugger_bpt(regs))
 			return;
 		if (check_bug_trap(regs)) {
 			regs->nip += 4;
 			return;
 		}
-		_exception(SIGTRAP, regs, TRAP_BRKPT, 0);
-		return;
-	}
-
-	/* Try to emulate it if we should. */
-	if (reason & (REASON_ILLEGAL | REASON_PRIVILEGED)) {
+		_exception(SIGTRAP, regs, TRAP_BRKPT,
+#ifdef CONFIG_PPC32
+			0
+#else
+			regs->nip
+#endif
+		);
+	} else
+#ifdef CONFIG_PPC32
+	if (reason & (REASON_ILLEGAL | REASON_PRIVILEGED))
+#endif
+	{
+		/* Privileged or illegal instruction; try to emulate it. */
 		switch (emulate_instruction(regs)) {
 		case 0:
 			regs->nip += 4;
 			emulate_single_step(regs);
-			return;
+			break;
 		case -EFAULT:
 			_exception(SIGSEGV, regs, SEGV_MAPERR, regs->nip);
-			return;
+			break;
+		default:
+			if (reason & REASON_PRIVILEGED)
+				_exception(SIGILL, regs, ILL_PRVOPC, regs->nip);
+			else
+				_exception(SIGILL, regs, ILL_ILLOPC, regs->nip);
+			break;
 		}
 	}
-
-	if (reason & REASON_PRIVILEGED)
-		_exception(SIGILL, regs, ILL_PRVOPC, regs->nip);
-	else
-		_exception(SIGILL, regs, ILL_ILLOPC, regs->nip);
 }
 
-void AlignmentException(struct pt_regs *regs)
+void alignment_exception(struct pt_regs *regs)
 {
 	int fixed;
 
@@ -814,18 +926,31 @@ void AlignmentException(struct pt_regs *
 		return;
 	}
 
-	/* Operand address was bad */	
+	/* Operand address was bad */
 	if (fixed == -EFAULT) {
 		if (user_mode(regs))
-			_exception(SIGSEGV, regs, SEGV_ACCERR, regs->dar);
+			_exception(SIGSEGV, regs,
+#ifdef CONFIG_PPC32
+				SEGV_ACCERR,
+#else
+				SEGV_MAPERR,
+#endif
+			regs->dar);
 		else
 			/* Search exception table */
 			bad_page_fault(regs, regs->dar, SIGSEGV);
 		return;
 	}
-	_exception(SIGBUS, regs, BUS_ADRALN, regs->dar);
+	_exception(SIGBUS, regs, BUS_ADRALN,
+#ifdef CONFIG_PPC32
+		regs->dar
+#else
+		regs->nip
+#endif
+	);
 }
 
+#ifdef CONFIG_PPC32
 void StackOverflow(struct pt_regs *regs)
 {
 	printk(KERN_CRIT "Kernel stack overflow in process %p, r1=%lx\n",
@@ -849,8 +974,58 @@ void trace_syscall(struct pt_regs *regs)
 	       current, current->pid, regs->nip, regs->link, regs->gpr[0],
 	       regs->ccr&0x10000000?"Error=":"", regs->gpr[3], print_tainted());
 }
+#endif /* CONFIG_PPC32 */
+
+#ifdef CONFIG_PPC64
+void kernel_fp_unavailable_exception(struct pt_regs *regs)
+{
+	printk(KERN_EMERG "Unrecoverable FP Unavailable Exception "
+			  "%lx at %lx\n", regs->trap, regs->nip);
+	die("Unrecoverable FP Unavailable Exception", regs, SIGABRT);
+}
+#endif
+
+void altivec_unavailable_exception(struct pt_regs *regs)
+{
+#if !defined(CONFIG_ALTIVEC) || defined(CONFIG_PPC64)
+	if (user_mode(regs)) {
+		/* A user program has executed an altivec instruction,
+		   but this kernel doesn't support altivec. */
+		_exception(SIGILL, regs, ILL_ILLOPC, regs->nip);
+		return;
+	}
+#endif
+#ifdef CONFIG_PPC32
+	{
+	static int kernel_altivec_count;
+
+	/* The kernel has executed an altivec instruction without
+	   first enabling altivec.  Whinge but let it do it. */
+	if (++kernel_altivec_count < 10)
+		printk(KERN_ERR "AltiVec used in kernel (task=%p, pc=%lx)\n",
+		       current, regs->nip);
+	regs->msr |= MSR_VEC;
+	}
+#else
+	printk(KERN_EMERG "Unrecoverable VMX/Altivec Unavailable Exception "
+			"%lx at %lx\n", regs->trap, regs->nip);
+	die("Unrecoverable VMX/Altivec Unavailable Exception", regs, SIGABRT);
+#endif
+}
+
+#ifdef CONFIG_PPC64
+extern perf_irq_t perf_irq;
+#endif
+
+#if defined(CONFIG_PPC64) || defined(CONFIG_E500)
+void performance_monitor_exception(struct pt_regs *regs)
+{
+	perf_irq(regs);
+}
+#endif
+
 
-#ifdef CONFIG_8xx
+#if defined(CONFIG_PPC32) && defined(CONFIG_8xx)
 void SoftwareEmulation(struct pt_regs *regs)
 {
 	extern int do_mathemu(struct pt_regs *);
@@ -879,8 +1054,9 @@ void SoftwareEmulation(struct pt_regs *r
 	} else
 		emulate_single_step(regs);
 }
-#endif /* CONFIG_8xx */
+#endif /* defined(CONFIG_PPC32) && defined(CONFIG_8xx) */
 
+#ifdef CONFIG_PPC32
 #if defined(CONFIG_40x) || defined(CONFIG_BOOKE)
 
 void DebugException(struct pt_regs *regs, unsigned long debug_status)
@@ -909,42 +1085,36 @@ void TAUException(struct pt_regs *regs)
 	       regs->nip, regs->msr, regs->trap, print_tainted());
 }
 #endif /* CONFIG_INT_TAU */
-
-void AltivecUnavailException(struct pt_regs *regs)
-{
-	static int kernel_altivec_count;
-
-#ifndef CONFIG_ALTIVEC
-	if (user_mode(regs)) {
-		/* A user program has executed an altivec instruction,
-		   but this kernel doesn't support altivec. */
-		_exception(SIGILL, regs, ILL_ILLOPC, regs->nip);
-		return;
-	}
-#endif
-	/* The kernel has executed an altivec instruction without
-	   first enabling altivec.  Whinge but let it do it. */
-	if (++kernel_altivec_count < 10)
-		printk(KERN_ERR "AltiVec used in kernel (task=%p, pc=%lx)\n",
-		       current, regs->nip);
-	regs->msr |= MSR_VEC;
-}
+#endif /* CONFIG_PPC32*/
 
 #ifdef CONFIG_ALTIVEC
-void AltivecAssistException(struct pt_regs *regs)
+void altivec_assist_exception(struct pt_regs *regs)
 {
 	int err;
+#ifdef CONFIG_PPC64
+	siginfo_t info;
+#endif
 
+#ifdef CONFIG_PPC32
 	preempt_disable();
 	if (regs->msr & MSR_VEC)
 		giveup_altivec(current);
 	preempt_enable();
+#endif
 	if (!user_mode(regs)) {
 		printk(KERN_EMERG "VMX/Altivec assist exception in kernel mode"
 		       " at %lx\n", regs->nip);
-		die("Kernel Altivec assist exception", regs, SIGILL);
+		die("Kernel "
+#ifdef CONFIG_PPC64
+			"VMX/"
+#endif
+			"Altivec assist exception", regs, SIGILL);
 	}
 
+#ifdef CONFIG_PPC64
+	flush_altivec_to_thread(current);
+#endif /* CONFIG_PPC64 */
+
 	err = emulate_altivec(regs);
 	if (err == 0) {
 		regs->nip += 4;		/* skip emulated instruction */
@@ -954,7 +1124,15 @@ void AltivecAssistException(struct pt_re
 
 	if (err == -EFAULT) {
 		/* got an error reading the instruction */
+#ifdef CONFIG_PPC32
 		_exception(SIGSEGV, regs, SEGV_ACCERR, regs->nip);
+#else
+		info.si_signo = SIGSEGV;
+		info.si_errno = 0;
+		info.si_code = SEGV_MAPERR;
+		info.si_addr = (void __user *) regs->nip;
+		force_sig_info(SIGSEGV, &info, current);
+#endif
 	} else {
 		/* didn't recognize the instruction */
 		/* XXX quick hack for now: set the non-Java bit in the VSCR */
@@ -966,13 +1144,7 @@ void AltivecAssistException(struct pt_re
 }
 #endif /* CONFIG_ALTIVEC */
 
-#ifdef CONFIG_E500
-void PerformanceMonitorException(struct pt_regs *regs)
-{
-	perf_irq(regs);
-}
-#endif
-
+#ifdef CONFIG_PPC32
 #ifdef CONFIG_FSL_BOOKE
 void CacheLockingException(struct pt_regs *regs, unsigned long address,
 			   unsigned long error_code)
@@ -1022,7 +1194,24 @@ void SPEFloatingPointException(struct pt
 	return;
 }
 #endif
+#endif /* CONFIG_PPC32 */
 
+#ifdef CONFIG_PPC64
+/*
+ * We enter here if we get an unrecoverable exception, that is, one
+ * that happened at a point where the RI (recoverable interrupt) bit
+ * in the MSR is 0.  This indicates that SRR0/1 are live, and that
+ * we therefore lost state by taking this exception.
+ */
+void unrecoverable_exception(struct pt_regs *regs)
+{
+	printk(KERN_EMERG "Unrecoverable exception %lx at %lx\n",
+	       regs->trap, regs->nip);
+	die("Unrecoverable exception", regs, SIGABRT);
+}
+#endif /* CONFIG_PPC64 */
+
+#ifdef CONFIG_PPC32
 #ifdef CONFIG_BOOKE_WDT
 /*
  * Default handler for a Watchdog exception,
@@ -1041,6 +1230,20 @@ void WatchdogException(struct pt_regs *r
 	WatchdogHandler(regs);
 }
 #endif
+#endif /* CONFIG_PPC32 */
+
+#ifdef CONFIG_PPC64
+/*
+ * We enter here if we discover during exception entry that we are
+ * running in supervisor mode with a userspace value in the stack pointer.
+ */
+void kernel_bad_stack(struct pt_regs *regs)
+{
+	printk(KERN_EMERG "Bad kernel stack pointer %lx at %lx\n",
+	       regs->gpr[1], regs->nip);
+	die("Bad kernel stack pointer", regs, SIGABRT);
+}
+#endif
 
 void __init trap_init(void)
 {
diff --git a/arch/ppc/kernel/head.S b/arch/ppc/kernel/head.S
--- a/arch/ppc/kernel/head.S
+++ b/arch/ppc/kernel/head.S
@@ -349,12 +349,12 @@ i##n:								\
 
 /* System reset */
 /* core99 pmac starts the seconary here by changing the vector, and
-   putting it back to what it was (UnknownException) when done.  */
+   putting it back to what it was (unknown_exception) when done.  */
 #if defined(CONFIG_GEMINI) && defined(CONFIG_SMP)
 	. = 0x100
 	b	__secondary_start_gemini
 #else
-	EXCEPTION(0x100, Reset, UnknownException, EXC_XFER_STD)
+	EXCEPTION(0x100, Reset, unknown_exception, EXC_XFER_STD)
 #endif
 
 /* Machine check */
@@ -389,7 +389,7 @@ i##n:								\
 	cmpwi	cr1,r4,0
 	bne	cr1,1f
 #endif
-	EXC_XFER_STD(0x200, MachineCheckException)
+	EXC_XFER_STD(0x200, machine_check_exception)
 #ifdef CONFIG_PPC_CHRP
 1:	b	machine_check_in_rtas
 #endif
@@ -456,10 +456,10 @@ Alignment:
 	mfspr	r5,SPRN_DSISR
 	stw	r5,_DSISR(r11)
 	addi	r3,r1,STACK_FRAME_OVERHEAD
-	EXC_XFER_EE(0x600, AlignmentException)
+	EXC_XFER_EE(0x600, alignment_exception)
 
 /* Program check exception */
-	EXCEPTION(0x700, ProgramCheck, ProgramCheckException, EXC_XFER_STD)
+	EXCEPTION(0x700, ProgramCheck, program_check_exception, EXC_XFER_STD)
 
 /* Floating-point unavailable */
 	. = 0x800
@@ -472,8 +472,8 @@ FPUnavailable:
 /* Decrementer */
 	EXCEPTION(0x900, Decrementer, timer_interrupt, EXC_XFER_LITE)
 
-	EXCEPTION(0xa00, Trap_0a, UnknownException, EXC_XFER_EE)
-	EXCEPTION(0xb00, Trap_0b, UnknownException, EXC_XFER_EE)
+	EXCEPTION(0xa00, Trap_0a, unknown_exception, EXC_XFER_EE)
+	EXCEPTION(0xb00, Trap_0b, unknown_exception, EXC_XFER_EE)
 
 /* System call */
 	. = 0xc00
@@ -482,8 +482,8 @@ SystemCall:
 	EXC_XFER_EE_LITE(0xc00, DoSyscall)
 
 /* Single step - not used on 601 */
-	EXCEPTION(0xd00, SingleStep, SingleStepException, EXC_XFER_STD)
-	EXCEPTION(0xe00, Trap_0e, UnknownException, EXC_XFER_EE)
+	EXCEPTION(0xd00, SingleStep, single_step_exception, EXC_XFER_STD)
+	EXCEPTION(0xe00, Trap_0e, unknown_exception, EXC_XFER_EE)
 
 /*
  * The Altivec unavailable trap is at 0x0f20.  Foo.
@@ -502,7 +502,7 @@ SystemCall:
 Trap_0f:
 	EXCEPTION_PROLOG
 	addi	r3,r1,STACK_FRAME_OVERHEAD
-	EXC_XFER_EE(0xf00, UnknownException)
+	EXC_XFER_EE(0xf00, unknown_exception)
 
 /*
  * Handle TLB miss for instruction on 603/603e.
@@ -702,44 +702,44 @@ DataStoreTLBMiss:
 	rfi
 
 #ifndef CONFIG_ALTIVEC
-#define AltivecAssistException	UnknownException
+#define altivec_assist_exception	unknown_exception
 #endif
 
-	EXCEPTION(0x1300, Trap_13, InstructionBreakpoint, EXC_XFER_EE)
+	EXCEPTION(0x1300, Trap_13, instruction_breakpoint_exception, EXC_XFER_EE)
 	EXCEPTION(0x1400, SMI, SMIException, EXC_XFER_EE)
-	EXCEPTION(0x1500, Trap_15, UnknownException, EXC_XFER_EE)
+	EXCEPTION(0x1500, Trap_15, unknown_exception, EXC_XFER_EE)
 #ifdef CONFIG_POWER4
-	EXCEPTION(0x1600, Trap_16, UnknownException, EXC_XFER_EE)
-	EXCEPTION(0x1700, Trap_17, AltivecAssistException, EXC_XFER_EE)
+	EXCEPTION(0x1600, Trap_16, unknown_exception, EXC_XFER_EE)
+	EXCEPTION(0x1700, Trap_17, altivec_assist_exception, EXC_XFER_EE)
 	EXCEPTION(0x1800, Trap_18, TAUException, EXC_XFER_STD)
 #else /* !CONFIG_POWER4 */
-	EXCEPTION(0x1600, Trap_16, AltivecAssistException, EXC_XFER_EE)
+	EXCEPTION(0x1600, Trap_16, altivec_assist_exception, EXC_XFER_EE)
 	EXCEPTION(0x1700, Trap_17, TAUException, EXC_XFER_STD)
-	EXCEPTION(0x1800, Trap_18, UnknownException, EXC_XFER_EE)
+	EXCEPTION(0x1800, Trap_18, unknown_exception, EXC_XFER_EE)
 #endif /* CONFIG_POWER4 */
-	EXCEPTION(0x1900, Trap_19, UnknownException, EXC_XFER_EE)
-	EXCEPTION(0x1a00, Trap_1a, UnknownException, EXC_XFER_EE)
-	EXCEPTION(0x1b00, Trap_1b, UnknownException, EXC_XFER_EE)
-	EXCEPTION(0x1c00, Trap_1c, UnknownException, EXC_XFER_EE)
-	EXCEPTION(0x1d00, Trap_1d, UnknownException, EXC_XFER_EE)
-	EXCEPTION(0x1e00, Trap_1e, UnknownException, EXC_XFER_EE)
-	EXCEPTION(0x1f00, Trap_1f, UnknownException, EXC_XFER_EE)
+	EXCEPTION(0x1900, Trap_19, unknown_exception, EXC_XFER_EE)
+	EXCEPTION(0x1a00, Trap_1a, unknown_exception, EXC_XFER_EE)
+	EXCEPTION(0x1b00, Trap_1b, unknown_exception, EXC_XFER_EE)
+	EXCEPTION(0x1c00, Trap_1c, unknown_exception, EXC_XFER_EE)
+	EXCEPTION(0x1d00, Trap_1d, unknown_exception, EXC_XFER_EE)
+	EXCEPTION(0x1e00, Trap_1e, unknown_exception, EXC_XFER_EE)
+	EXCEPTION(0x1f00, Trap_1f, unknown_exception, EXC_XFER_EE)
 	EXCEPTION(0x2000, RunMode, RunModeException, EXC_XFER_EE)
-	EXCEPTION(0x2100, Trap_21, UnknownException, EXC_XFER_EE)
-	EXCEPTION(0x2200, Trap_22, UnknownException, EXC_XFER_EE)
-	EXCEPTION(0x2300, Trap_23, UnknownException, EXC_XFER_EE)
-	EXCEPTION(0x2400, Trap_24, UnknownException, EXC_XFER_EE)
-	EXCEPTION(0x2500, Trap_25, UnknownException, EXC_XFER_EE)
-	EXCEPTION(0x2600, Trap_26, UnknownException, EXC_XFER_EE)
-	EXCEPTION(0x2700, Trap_27, UnknownException, EXC_XFER_EE)
-	EXCEPTION(0x2800, Trap_28, UnknownException, EXC_XFER_EE)
-	EXCEPTION(0x2900, Trap_29, UnknownException, EXC_XFER_EE)
-	EXCEPTION(0x2a00, Trap_2a, UnknownException, EXC_XFER_EE)
-	EXCEPTION(0x2b00, Trap_2b, UnknownException, EXC_XFER_EE)
-	EXCEPTION(0x2c00, Trap_2c, UnknownException, EXC_XFER_EE)
-	EXCEPTION(0x2d00, Trap_2d, UnknownException, EXC_XFER_EE)
-	EXCEPTION(0x2e00, Trap_2e, UnknownException, EXC_XFER_EE)
-	EXCEPTION(0x2f00, MOLTrampoline, UnknownException, EXC_XFER_EE_LITE)
+	EXCEPTION(0x2100, Trap_21, unknown_exception, EXC_XFER_EE)
+	EXCEPTION(0x2200, Trap_22, unknown_exception, EXC_XFER_EE)
+	EXCEPTION(0x2300, Trap_23, unknown_exception, EXC_XFER_EE)
+	EXCEPTION(0x2400, Trap_24, unknown_exception, EXC_XFER_EE)
+	EXCEPTION(0x2500, Trap_25, unknown_exception, EXC_XFER_EE)
+	EXCEPTION(0x2600, Trap_26, unknown_exception, EXC_XFER_EE)
+	EXCEPTION(0x2700, Trap_27, unknown_exception, EXC_XFER_EE)
+	EXCEPTION(0x2800, Trap_28, unknown_exception, EXC_XFER_EE)
+	EXCEPTION(0x2900, Trap_29, unknown_exception, EXC_XFER_EE)
+	EXCEPTION(0x2a00, Trap_2a, unknown_exception, EXC_XFER_EE)
+	EXCEPTION(0x2b00, Trap_2b, unknown_exception, EXC_XFER_EE)
+	EXCEPTION(0x2c00, Trap_2c, unknown_exception, EXC_XFER_EE)
+	EXCEPTION(0x2d00, Trap_2d, unknown_exception, EXC_XFER_EE)
+	EXCEPTION(0x2e00, Trap_2e, unknown_exception, EXC_XFER_EE)
+	EXCEPTION(0x2f00, MOLTrampoline, unknown_exception, EXC_XFER_EE_LITE)
 
 	.globl mol_trampoline
 	.set mol_trampoline, i0x2f00
@@ -751,7 +751,7 @@ AltiVecUnavailable:
 #ifdef CONFIG_ALTIVEC
 	bne	load_up_altivec		/* if from user, just load it up */
 #endif /* CONFIG_ALTIVEC */
-	EXC_XFER_EE_LITE(0xf20, AltivecUnavailException)
+	EXC_XFER_EE_LITE(0xf20, altivec_unavailable_exception)
 
 #ifdef CONFIG_PPC64BRIDGE
 DataAccess:
@@ -767,12 +767,12 @@ DataSegment:
 	addi	r3,r1,STACK_FRAME_OVERHEAD
 	mfspr	r4,SPRN_DAR
 	stw	r4,_DAR(r11)
-	EXC_XFER_STD(0x380, UnknownException)
+	EXC_XFER_STD(0x380, unknown_exception)
 
 InstructionSegment:
 	EXCEPTION_PROLOG
 	addi	r3,r1,STACK_FRAME_OVERHEAD
-	EXC_XFER_STD(0x480, UnknownException)
+	EXC_XFER_STD(0x480, unknown_exception)
 #endif /* CONFIG_PPC64BRIDGE */
 
 #ifdef CONFIG_ALTIVEC
diff --git a/arch/ppc/kernel/head_44x.S b/arch/ppc/kernel/head_44x.S
--- a/arch/ppc/kernel/head_44x.S
+++ b/arch/ppc/kernel/head_44x.S
@@ -309,13 +309,13 @@ skpinv:	addi	r4,r4,1				/* Increment */
 
 interrupt_base:
 	/* Critical Input Interrupt */
-	CRITICAL_EXCEPTION(0x0100, CriticalInput, UnknownException)
+	CRITICAL_EXCEPTION(0x0100, CriticalInput, unknown_exception)
 
 	/* Machine Check Interrupt */
 #ifdef CONFIG_440A
-	MCHECK_EXCEPTION(0x0200, MachineCheck, MachineCheckException)
+	MCHECK_EXCEPTION(0x0200, MachineCheck, machine_check_exception)
 #else
-	CRITICAL_EXCEPTION(0x0200, MachineCheck, MachineCheckException)
+	CRITICAL_EXCEPTION(0x0200, MachineCheck, machine_check_exception)
 #endif
 
 	/* Data Storage Interrupt */
@@ -442,7 +442,7 @@ interrupt_base:
 #ifdef CONFIG_PPC_FPU
 	FP_UNAVAILABLE_EXCEPTION
 #else
-	EXCEPTION(0x2010, FloatingPointUnavailable, UnknownException, EXC_XFER_EE)
+	EXCEPTION(0x2010, FloatingPointUnavailable, unknown_exception, EXC_XFER_EE)
 #endif
 
 	/* System Call Interrupt */
@@ -451,21 +451,21 @@ interrupt_base:
 	EXC_XFER_EE_LITE(0x0c00, DoSyscall)
 
 	/* Auxillary Processor Unavailable Interrupt */
-	EXCEPTION(0x2020, AuxillaryProcessorUnavailable, UnknownException, EXC_XFER_EE)
+	EXCEPTION(0x2020, AuxillaryProcessorUnavailable, unknown_exception, EXC_XFER_EE)
 
 	/* Decrementer Interrupt */
 	DECREMENTER_EXCEPTION
 
 	/* Fixed Internal Timer Interrupt */
 	/* TODO: Add FIT support */
-	EXCEPTION(0x1010, FixedIntervalTimer, UnknownException, EXC_XFER_EE)
+	EXCEPTION(0x1010, FixedIntervalTimer, unknown_exception, EXC_XFER_EE)
 
 	/* Watchdog Timer Interrupt */
 	/* TODO: Add watchdog support */
 #ifdef CONFIG_BOOKE_WDT
 	CRITICAL_EXCEPTION(0x1020, WatchdogTimer, WatchdogException)
 #else
-	CRITICAL_EXCEPTION(0x1020, WatchdogTimer, UnknownException)
+	CRITICAL_EXCEPTION(0x1020, WatchdogTimer, unknown_exception)
 #endif
 
 	/* Data TLB Error Interrupt */
diff --git a/arch/ppc/kernel/head_4xx.S b/arch/ppc/kernel/head_4xx.S
--- a/arch/ppc/kernel/head_4xx.S
+++ b/arch/ppc/kernel/head_4xx.S
@@ -245,12 +245,12 @@ label:
 /*
  * 0x0100 - Critical Interrupt Exception
  */
-	CRITICAL_EXCEPTION(0x0100, CriticalInterrupt, UnknownException)
+	CRITICAL_EXCEPTION(0x0100, CriticalInterrupt, unknown_exception)
 
 /*
  * 0x0200 - Machine Check Exception
  */
-	CRITICAL_EXCEPTION(0x0200, MachineCheck, MachineCheckException)
+	CRITICAL_EXCEPTION(0x0200, MachineCheck, machine_check_exception)
 
 /*
  * 0x0300 - Data Storage Exception
@@ -405,7 +405,7 @@ label:
 	mfspr	r4,SPRN_DEAR		/* Grab the DEAR and save it */
 	stw	r4,_DEAR(r11)
 	addi	r3,r1,STACK_FRAME_OVERHEAD
-	EXC_XFER_EE(0x600, AlignmentException)
+	EXC_XFER_EE(0x600, alignment_exception)
 
 /* 0x0700 - Program Exception */
 	START_EXCEPTION(0x0700, ProgramCheck)
@@ -413,21 +413,21 @@ label:
 	mfspr	r4,SPRN_ESR		/* Grab the ESR and save it */
 	stw	r4,_ESR(r11)
 	addi	r3,r1,STACK_FRAME_OVERHEAD
-	EXC_XFER_STD(0x700, ProgramCheckException)
+	EXC_XFER_STD(0x700, program_check_exception)
 
-	EXCEPTION(0x0800, Trap_08, UnknownException, EXC_XFER_EE)
-	EXCEPTION(0x0900, Trap_09, UnknownException, EXC_XFER_EE)
-	EXCEPTION(0x0A00, Trap_0A, UnknownException, EXC_XFER_EE)
-	EXCEPTION(0x0B00, Trap_0B, UnknownException, EXC_XFER_EE)
+	EXCEPTION(0x0800, Trap_08, unknown_exception, EXC_XFER_EE)
+	EXCEPTION(0x0900, Trap_09, unknown_exception, EXC_XFER_EE)
+	EXCEPTION(0x0A00, Trap_0A, unknown_exception, EXC_XFER_EE)
+	EXCEPTION(0x0B00, Trap_0B, unknown_exception, EXC_XFER_EE)
 
 /* 0x0C00 - System Call Exception */
 	START_EXCEPTION(0x0C00,	SystemCall)
 	NORMAL_EXCEPTION_PROLOG
 	EXC_XFER_EE_LITE(0xc00, DoSyscall)
 
-	EXCEPTION(0x0D00, Trap_0D, UnknownException, EXC_XFER_EE)
-	EXCEPTION(0x0E00, Trap_0E, UnknownException, EXC_XFER_EE)
-	EXCEPTION(0x0F00, Trap_0F, UnknownException, EXC_XFER_EE)
+	EXCEPTION(0x0D00, Trap_0D, unknown_exception, EXC_XFER_EE)
+	EXCEPTION(0x0E00, Trap_0E, unknown_exception, EXC_XFER_EE)
+	EXCEPTION(0x0F00, Trap_0F, unknown_exception, EXC_XFER_EE)
 
 /* 0x1000 - Programmable Interval Timer (PIT) Exception */
 	START_EXCEPTION(0x1000, Decrementer)
@@ -444,14 +444,14 @@ label:
 
 /* 0x1010 - Fixed Interval Timer (FIT) Exception
 */
-	STND_EXCEPTION(0x1010,	FITException,		UnknownException)
+	STND_EXCEPTION(0x1010,	FITException,		unknown_exception)
 
 /* 0x1020 - Watchdog Timer (WDT) Exception
 */
 #ifdef CONFIG_BOOKE_WDT
 	CRITICAL_EXCEPTION(0x1020, WDTException, WatchdogException)
 #else
-	CRITICAL_EXCEPTION(0x1020, WDTException, UnknownException)
+	CRITICAL_EXCEPTION(0x1020, WDTException, unknown_exception)
 #endif
 #endif
 
@@ -656,25 +656,25 @@ label:
 	mfspr	r10, SPRN_SPRG0
 	b	InstructionAccess
 
-	EXCEPTION(0x1300, Trap_13, UnknownException, EXC_XFER_EE)
-	EXCEPTION(0x1400, Trap_14, UnknownException, EXC_XFER_EE)
-	EXCEPTION(0x1500, Trap_15, UnknownException, EXC_XFER_EE)
-	EXCEPTION(0x1600, Trap_16, UnknownException, EXC_XFER_EE)
+	EXCEPTION(0x1300, Trap_13, unknown_exception, EXC_XFER_EE)
+	EXCEPTION(0x1400, Trap_14, unknown_exception, EXC_XFER_EE)
+	EXCEPTION(0x1500, Trap_15, unknown_exception, EXC_XFER_EE)
+	EXCEPTION(0x1600, Trap_16, unknown_exception, EXC_XFER_EE)
 #ifdef CONFIG_IBM405_ERR51
 	/* 405GP errata 51 */
 	START_EXCEPTION(0x1700, Trap_17)
 	b DTLBMiss
 #else
-	EXCEPTION(0x1700, Trap_17, UnknownException, EXC_XFER_EE)
+	EXCEPTION(0x1700, Trap_17, unknown_exception, EXC_XFER_EE)
 #endif
-	EXCEPTION(0x1800, Trap_18, UnknownException, EXC_XFER_EE)
-	EXCEPTION(0x1900, Trap_19, UnknownException, EXC_XFER_EE)
-	EXCEPTION(0x1A00, Trap_1A, UnknownException, EXC_XFER_EE)
-	EXCEPTION(0x1B00, Trap_1B, UnknownException, EXC_XFER_EE)
-	EXCEPTION(0x1C00, Trap_1C, UnknownException, EXC_XFER_EE)
-	EXCEPTION(0x1D00, Trap_1D, UnknownException, EXC_XFER_EE)
-	EXCEPTION(0x1E00, Trap_1E, UnknownException, EXC_XFER_EE)
-	EXCEPTION(0x1F00, Trap_1F, UnknownException, EXC_XFER_EE)
+	EXCEPTION(0x1800, Trap_18, unknown_exception, EXC_XFER_EE)
+	EXCEPTION(0x1900, Trap_19, unknown_exception, EXC_XFER_EE)
+	EXCEPTION(0x1A00, Trap_1A, unknown_exception, EXC_XFER_EE)
+	EXCEPTION(0x1B00, Trap_1B, unknown_exception, EXC_XFER_EE)
+	EXCEPTION(0x1C00, Trap_1C, unknown_exception, EXC_XFER_EE)
+	EXCEPTION(0x1D00, Trap_1D, unknown_exception, EXC_XFER_EE)
+	EXCEPTION(0x1E00, Trap_1E, unknown_exception, EXC_XFER_EE)
+	EXCEPTION(0x1F00, Trap_1F, unknown_exception, EXC_XFER_EE)
 
 /* Check for a single step debug exception while in an exception
  * handler before state has been saved.  This is to catch the case
diff --git a/arch/ppc/kernel/head_8xx.S b/arch/ppc/kernel/head_8xx.S
--- a/arch/ppc/kernel/head_8xx.S
+++ b/arch/ppc/kernel/head_8xx.S
@@ -203,7 +203,7 @@ i##n:								\
 			  ret_from_except)
 
 /* System reset */
-	EXCEPTION(0x100, Reset, UnknownException, EXC_XFER_STD)
+	EXCEPTION(0x100, Reset, unknown_exception, EXC_XFER_STD)
 
 /* Machine check */
 	. = 0x200
@@ -214,7 +214,7 @@ MachineCheck:
 	mfspr r5,SPRN_DSISR
 	stw r5,_DSISR(r11)
 	addi r3,r1,STACK_FRAME_OVERHEAD
-	EXC_XFER_STD(0x200, MachineCheckException)
+	EXC_XFER_STD(0x200, machine_check_exception)
 
 /* Data access exception.
  * This is "never generated" by the MPC8xx.  We jump to it for other
@@ -252,20 +252,20 @@ Alignment:
 	mfspr	r5,SPRN_DSISR
 	stw	r5,_DSISR(r11)
 	addi	r3,r1,STACK_FRAME_OVERHEAD
-	EXC_XFER_EE(0x600, AlignmentException)
+	EXC_XFER_EE(0x600, alignment_exception)
 
 /* Program check exception */
-	EXCEPTION(0x700, ProgramCheck, ProgramCheckException, EXC_XFER_STD)
+	EXCEPTION(0x700, ProgramCheck, program_check_exception, EXC_XFER_STD)
 
 /* No FPU on MPC8xx.  This exception is not supposed to happen.
 */
-	EXCEPTION(0x800, FPUnavailable, UnknownException, EXC_XFER_STD)
+	EXCEPTION(0x800, FPUnavailable, unknown_exception, EXC_XFER_STD)
 
 /* Decrementer */
 	EXCEPTION(0x900, Decrementer, timer_interrupt, EXC_XFER_LITE)
 
-	EXCEPTION(0xa00, Trap_0a, UnknownException, EXC_XFER_EE)
-	EXCEPTION(0xb00, Trap_0b, UnknownException, EXC_XFER_EE)
+	EXCEPTION(0xa00, Trap_0a, unknown_exception, EXC_XFER_EE)
+	EXCEPTION(0xb00, Trap_0b, unknown_exception, EXC_XFER_EE)
 
 /* System call */
 	. = 0xc00
@@ -274,9 +274,9 @@ SystemCall:
 	EXC_XFER_EE_LITE(0xc00, DoSyscall)
 
 /* Single step - not used on 601 */
-	EXCEPTION(0xd00, SingleStep, SingleStepException, EXC_XFER_STD)
-	EXCEPTION(0xe00, Trap_0e, UnknownException, EXC_XFER_EE)
-	EXCEPTION(0xf00, Trap_0f, UnknownException, EXC_XFER_EE)
+	EXCEPTION(0xd00, SingleStep, single_step_exception, EXC_XFER_STD)
+	EXCEPTION(0xe00, Trap_0e, unknown_exception, EXC_XFER_EE)
+	EXCEPTION(0xf00, Trap_0f, unknown_exception, EXC_XFER_EE)
 
 /* On the MPC8xx, this is a software emulation interrupt.  It occurs
  * for all unimplemented and illegal instructions.
@@ -540,22 +540,22 @@ DataTLBError:
 #endif
 	b	DataAccess
 
-	EXCEPTION(0x1500, Trap_15, UnknownException, EXC_XFER_EE)
-	EXCEPTION(0x1600, Trap_16, UnknownException, EXC_XFER_EE)
-	EXCEPTION(0x1700, Trap_17, UnknownException, EXC_XFER_EE)
-	EXCEPTION(0x1800, Trap_18, UnknownException, EXC_XFER_EE)
-	EXCEPTION(0x1900, Trap_19, UnknownException, EXC_XFER_EE)
-	EXCEPTION(0x1a00, Trap_1a, UnknownException, EXC_XFER_EE)
-	EXCEPTION(0x1b00, Trap_1b, UnknownException, EXC_XFER_EE)
+	EXCEPTION(0x1500, Trap_15, unknown_exception, EXC_XFER_EE)
+	EXCEPTION(0x1600, Trap_16, unknown_exception, EXC_XFER_EE)
+	EXCEPTION(0x1700, Trap_17, unknown_exception, EXC_XFER_EE)
+	EXCEPTION(0x1800, Trap_18, unknown_exception, EXC_XFER_EE)
+	EXCEPTION(0x1900, Trap_19, unknown_exception, EXC_XFER_EE)
+	EXCEPTION(0x1a00, Trap_1a, unknown_exception, EXC_XFER_EE)
+	EXCEPTION(0x1b00, Trap_1b, unknown_exception, EXC_XFER_EE)
 
 /* On the MPC8xx, these next four traps are used for development
  * support of breakpoints and such.  Someday I will get around to
  * using them.
  */
-	EXCEPTION(0x1c00, Trap_1c, UnknownException, EXC_XFER_EE)
-	EXCEPTION(0x1d00, Trap_1d, UnknownException, EXC_XFER_EE)
-	EXCEPTION(0x1e00, Trap_1e, UnknownException, EXC_XFER_EE)
-	EXCEPTION(0x1f00, Trap_1f, UnknownException, EXC_XFER_EE)
+	EXCEPTION(0x1c00, Trap_1c, unknown_exception, EXC_XFER_EE)
+	EXCEPTION(0x1d00, Trap_1d, unknown_exception, EXC_XFER_EE)
+	EXCEPTION(0x1e00, Trap_1e, unknown_exception, EXC_XFER_EE)
+	EXCEPTION(0x1f00, Trap_1f, unknown_exception, EXC_XFER_EE)
 
 	. = 0x2000
 
diff --git a/arch/ppc/kernel/head_booke.h b/arch/ppc/kernel/head_booke.h
--- a/arch/ppc/kernel/head_booke.h
+++ b/arch/ppc/kernel/head_booke.h
@@ -335,7 +335,7 @@ label:
 	mfspr   r4,SPRN_DEAR;           /* Grab the DEAR and save it */	      \
 	stw     r4,_DEAR(r11);						      \
 	addi    r3,r1,STACK_FRAME_OVERHEAD;				      \
-	EXC_XFER_EE(0x0600, AlignmentException)
+	EXC_XFER_EE(0x0600, alignment_exception)
 
 #define PROGRAM_EXCEPTION						      \
 	START_EXCEPTION(Program)					      \
@@ -343,7 +343,7 @@ label:
 	mfspr	r4,SPRN_ESR;		/* Grab the ESR and save it */	      \
 	stw	r4,_ESR(r11);						      \
 	addi	r3,r1,STACK_FRAME_OVERHEAD;				      \
-	EXC_XFER_STD(0x0700, ProgramCheckException)
+	EXC_XFER_STD(0x0700, program_check_exception)
 
 #define DECREMENTER_EXCEPTION						      \
 	START_EXCEPTION(Decrementer)					      \
diff --git a/arch/ppc/kernel/head_fsl_booke.S b/arch/ppc/kernel/head_fsl_booke.S
--- a/arch/ppc/kernel/head_fsl_booke.S
+++ b/arch/ppc/kernel/head_fsl_booke.S
@@ -426,14 +426,14 @@ skpinv:	addi	r6,r6,1				/* Increment */
 
 interrupt_base:
 	/* Critical Input Interrupt */
-	CRITICAL_EXCEPTION(0x0100, CriticalInput, UnknownException)
+	CRITICAL_EXCEPTION(0x0100, CriticalInput, unknown_exception)
 
 	/* Machine Check Interrupt */
 #ifdef CONFIG_E200
 	/* no RFMCI, MCSRRs on E200 */
-	CRITICAL_EXCEPTION(0x0200, MachineCheck, MachineCheckException)
+	CRITICAL_EXCEPTION(0x0200, MachineCheck, machine_check_exception)
 #else
-	MCHECK_EXCEPTION(0x0200, MachineCheck, MachineCheckException)
+	MCHECK_EXCEPTION(0x0200, MachineCheck, machine_check_exception)
 #endif
 
 	/* Data Storage Interrupt */
@@ -542,9 +542,9 @@ interrupt_base:
 #else
 #ifdef CONFIG_E200
 	/* E200 treats 'normal' floating point instructions as FP Unavail exception */
-	EXCEPTION(0x0800, FloatingPointUnavailable, ProgramCheckException, EXC_XFER_EE)
+	EXCEPTION(0x0800, FloatingPointUnavailable, program_check_exception, EXC_XFER_EE)
 #else
-	EXCEPTION(0x0800, FloatingPointUnavailable, UnknownException, EXC_XFER_EE)
+	EXCEPTION(0x0800, FloatingPointUnavailable, unknown_exception, EXC_XFER_EE)
 #endif
 #endif
 
@@ -554,20 +554,20 @@ interrupt_base:
 	EXC_XFER_EE_LITE(0x0c00, DoSyscall)
 
 	/* Auxillary Processor Unavailable Interrupt */
-	EXCEPTION(0x2900, AuxillaryProcessorUnavailable, UnknownException, EXC_XFER_EE)
+	EXCEPTION(0x2900, AuxillaryProcessorUnavailable, unknown_exception, EXC_XFER_EE)
 
 	/* Decrementer Interrupt */
 	DECREMENTER_EXCEPTION
 
 	/* Fixed Internal Timer Interrupt */
 	/* TODO: Add FIT support */
-	EXCEPTION(0x3100, FixedIntervalTimer, UnknownException, EXC_XFER_EE)
+	EXCEPTION(0x3100, FixedIntervalTimer, unknown_exception, EXC_XFER_EE)
 
 	/* Watchdog Timer Interrupt */
 #ifdef CONFIG_BOOKE_WDT
 	CRITICAL_EXCEPTION(0x3200, WatchdogTimer, WatchdogException)
 #else
-	CRITICAL_EXCEPTION(0x3200, WatchdogTimer, UnknownException)
+	CRITICAL_EXCEPTION(0x3200, WatchdogTimer, unknown_exception)
 #endif
 
 	/* Data TLB Error Interrupt */
@@ -696,21 +696,21 @@ interrupt_base:
 	addi    r3,r1,STACK_FRAME_OVERHEAD
 	EXC_XFER_EE_LITE(0x2010, KernelSPE)
 #else
-	EXCEPTION(0x2020, SPEUnavailable, UnknownException, EXC_XFER_EE)
+	EXCEPTION(0x2020, SPEUnavailable, unknown_exception, EXC_XFER_EE)
 #endif /* CONFIG_SPE */
 
 	/* SPE Floating Point Data */
 #ifdef CONFIG_SPE
 	EXCEPTION(0x2030, SPEFloatingPointData, SPEFloatingPointException, EXC_XFER_EE);
 #else
-	EXCEPTION(0x2040, SPEFloatingPointData, UnknownException, EXC_XFER_EE)
+	EXCEPTION(0x2040, SPEFloatingPointData, unknown_exception, EXC_XFER_EE)
 #endif /* CONFIG_SPE */
 
 	/* SPE Floating Point Round */
-	EXCEPTION(0x2050, SPEFloatingPointRound, UnknownException, EXC_XFER_EE)
+	EXCEPTION(0x2050, SPEFloatingPointRound, unknown_exception, EXC_XFER_EE)
 
 	/* Performance Monitor */
-	EXCEPTION(0x2060, PerformanceMonitor, PerformanceMonitorException, EXC_XFER_STD)
+	EXCEPTION(0x2060, PerformanceMonitor, performance_monitor_exception, EXC_XFER_STD)
 
 
 	/* Debug Interrupt */
diff --git a/arch/ppc/kernel/ppc_ksyms.c b/arch/ppc/kernel/ppc_ksyms.c
--- a/arch/ppc/kernel/ppc_ksyms.c
+++ b/arch/ppc/kernel/ppc_ksyms.c
@@ -53,10 +53,10 @@
 
 extern void transfer_to_handler(void);
 extern void do_IRQ(struct pt_regs *regs);
-extern void MachineCheckException(struct pt_regs *regs);
-extern void AlignmentException(struct pt_regs *regs);
-extern void ProgramCheckException(struct pt_regs *regs);
-extern void SingleStepException(struct pt_regs *regs);
+extern void machine_check_exception(struct pt_regs *regs);
+extern void alignment_exception(struct pt_regs *regs);
+extern void program_check_exception(struct pt_regs *regs);
+extern void single_step_exception(struct pt_regs *regs);
 extern int do_signal(sigset_t *, struct pt_regs *);
 extern int pmac_newworld;
 extern int sys_sigreturn(struct pt_regs *regs);
@@ -72,10 +72,10 @@ EXPORT_SYMBOL(clear_user_page);
 EXPORT_SYMBOL(do_signal);
 EXPORT_SYMBOL(transfer_to_handler);
 EXPORT_SYMBOL(do_IRQ);
-EXPORT_SYMBOL(MachineCheckException);
-EXPORT_SYMBOL(AlignmentException);
-EXPORT_SYMBOL(ProgramCheckException);
-EXPORT_SYMBOL(SingleStepException);
+EXPORT_SYMBOL(machine_check_exception);
+EXPORT_SYMBOL(alignment_exception);
+EXPORT_SYMBOL(program_check_exception);
+EXPORT_SYMBOL(single_step_exception);
 EXPORT_SYMBOL(sys_sigreturn);
 EXPORT_SYMBOL(ppc_n_lost_interrupts);
 EXPORT_SYMBOL(ppc_lost_interrupts);
diff --git a/arch/ppc/kernel/traps.c b/arch/ppc/kernel/traps.c
--- a/arch/ppc/kernel/traps.c
+++ b/arch/ppc/kernel/traps.c
@@ -74,7 +74,7 @@ void (*debugger_fault_handler)(struct pt
 
 DEFINE_SPINLOCK(die_lock);
 
-void die(const char * str, struct pt_regs * fp, long err)
+int die(const char * str, struct pt_regs * fp, long err)
 {
 	static int die_counter;
 	int nl = 0;
@@ -232,7 +232,7 @@ platform_machine_check(struct pt_regs *r
 {
 }
 
-void MachineCheckException(struct pt_regs *regs)
+void machine_check_exception(struct pt_regs *regs)
 {
 	unsigned long reason = get_mc_reason(regs);
 
@@ -393,14 +393,14 @@ void SMIException(struct pt_regs *regs)
 #endif
 }
 
-void UnknownException(struct pt_regs *regs)
+void unknown_exception(struct pt_regs *regs)
 {
 	printk("Bad trap at PC: %lx, MSR: %lx, vector=%lx    %s\n",
 	       regs->nip, regs->msr, regs->trap, print_tainted());
 	_exception(SIGTRAP, regs, 0, 0);
 }
 
-void InstructionBreakpoint(struct pt_regs *regs)
+void instruction_breakpoint_exception(struct pt_regs *regs)
 {
 	if (debugger_iabr_match(regs))
 		return;
@@ -622,7 +622,7 @@ int check_bug_trap(struct pt_regs *regs)
 	return 0;
 }
 
-void ProgramCheckException(struct pt_regs *regs)
+void program_check_exception(struct pt_regs *regs)
 {
 	unsigned int reason = get_reason(regs);
 	extern int do_mathemu(struct pt_regs *regs);
@@ -701,7 +701,7 @@ void ProgramCheckException(struct pt_reg
 		_exception(SIGILL, regs, ILL_ILLOPC, regs->nip);
 }
 
-void SingleStepException(struct pt_regs *regs)
+void single_step_exception(struct pt_regs *regs)
 {
 	regs->msr &= ~(MSR_SE | MSR_BE);  /* Turn off 'trace' bits */
 	if (debugger_sstep(regs))
@@ -709,7 +709,7 @@ void SingleStepException(struct pt_regs 
 	_exception(SIGTRAP, regs, TRAP_TRACE, 0);
 }
 
-void AlignmentException(struct pt_regs *regs)
+void alignment_exception(struct pt_regs *regs)
 {
 	int fixed;
 
@@ -814,7 +814,7 @@ void TAUException(struct pt_regs *regs)
 }
 #endif /* CONFIG_INT_TAU */
 
-void AltivecUnavailException(struct pt_regs *regs)
+void altivec_unavailable_exception(struct pt_regs *regs)
 {
 	static int kernel_altivec_count;
 
@@ -835,7 +835,7 @@ void AltivecUnavailException(struct pt_r
 }
 
 #ifdef CONFIG_ALTIVEC
-void AltivecAssistException(struct pt_regs *regs)
+void altivec_assist_exception(struct pt_regs *regs)
 {
 	int err;
 
@@ -872,7 +872,7 @@ void AltivecAssistException(struct pt_re
 #endif /* CONFIG_ALTIVEC */
 
 #ifdef CONFIG_E500
-void PerformanceMonitorException(struct pt_regs *regs)
+void performance_monitor_exception(struct pt_regs *regs)
 {
 	perf_irq(regs);
 }
diff --git a/arch/ppc/syslib/ibm44x_common.c b/arch/ppc/syslib/ibm44x_common.c
--- a/arch/ppc/syslib/ibm44x_common.c
+++ b/arch/ppc/syslib/ibm44x_common.c
@@ -178,7 +178,7 @@ void __init ibm44x_platform_init(void)
 #endif
 }
 
-/* Called from MachineCheckException */
+/* Called from machine_check_exception */
 void platform_machine_check(struct pt_regs *regs)
 {
     	printk("PLB0: BEAR=0x%08x%08x ACR=  0x%08x BESR= 0x%08x\n",
diff --git a/arch/ppc/syslib/ppc4xx_setup.c b/arch/ppc/syslib/ppc4xx_setup.c
--- a/arch/ppc/syslib/ppc4xx_setup.c
+++ b/arch/ppc/syslib/ppc4xx_setup.c
@@ -279,7 +279,7 @@ ppc4xx_init(unsigned long r3, unsigned l
 #endif /* defined(CONFIG_PCI) && defined(CONFIG_IDE) */
 }
 
-/* Called from MachineCheckException */
+/* Called from machine_check_exception */
 void platform_machine_check(struct pt_regs *regs)
 {
 #if defined(DCRN_PLB0_BEAR)
diff --git a/arch/ppc64/kernel/Makefile b/arch/ppc64/kernel/Makefile
--- a/arch/ppc64/kernel/Makefile
+++ b/arch/ppc64/kernel/Makefile
@@ -2,6 +2,8 @@
 # Makefile for the linux ppc64 kernel.
 #
 
+ifneq ($(CONFIG_PPC_MERGE),y)
+
 EXTRA_CFLAGS	+= -mno-minimal-toc
 extra-y		:= head.o vmlinux.lds
 
@@ -77,3 +79,9 @@ endif
 # These are here while we do the architecture merge
 vecemu-y			+= ../../powerpc/kernel/vecemu.o
 vector-y			+= ../../powerpc/kernel/vector.o
+idle_power4-y			+= ../../powerpc/kernel/idle_power4.o
+traps-y				+= ../../powerpc/kernel/traps.o
+
+else
+
+endif
diff --git a/arch/ppc64/kernel/idle_power4.S b/arch/ppc64/kernel/idle_power4.S
deleted file mode 100644
--- a/arch/ppc64/kernel/idle_power4.S
+++ /dev/null
@@ -1,79 +0,0 @@
-/*
- *  This file contains the power_save function for 6xx & 7xxx CPUs
- *  rewritten in assembler
- *
- *  Warning ! This code assumes that if your machine has a 750fx
- *  it will have PLL 1 set to low speed mode (used during NAP/DOZE).
- *  if this is not the case some additional changes will have to
- *  be done to check a runtime var (a bit like powersave-nap)
- *
- *  This program is free software; you can redistribute it and/or
- *  modify it under the terms of the GNU General Public License
- *  as published by the Free Software Foundation; either version
- *  2 of the License, or (at your option) any later version.
- */
-
-#include <linux/config.h>
-#include <linux/threads.h>
-#include <asm/processor.h>
-#include <asm/page.h>
-#include <asm/cputable.h>
-#include <asm/thread_info.h>
-#include <asm/ppc_asm.h>
-#include <asm/asm-offsets.h>
-
-#undef DEBUG
-
-	.text
-
-/*
- * Here is the power_save_6xx function. This could eventually be
- * split into several functions & changing the function pointer
- * depending on the various features.
- */
-_GLOBAL(power4_idle)
-BEGIN_FTR_SECTION
-	blr
-END_FTR_SECTION_IFCLR(CPU_FTR_CAN_NAP)
-	/* We must dynamically check for the NAP feature as it
-	 * can be cleared by CPU init after the fixups are done
-	 */
-	LOADBASE(r3,cur_cpu_spec)
-	ld	r4,cur_cpu_spec@l(r3)
-	ld	r4,CPU_SPEC_FEATURES(r4)
-	andi.	r0,r4,CPU_FTR_CAN_NAP
-	beqlr
-	/* Now check if user or arch enabled NAP mode */
-	LOADBASE(r3,powersave_nap)
-	lwz	r4,powersave_nap@l(r3)
-	cmpwi	0,r4,0
-	beqlr
-
-	/* Clear MSR:EE */
-	mfmsr	r7
-	li	r4,0
-	ori	r4,r4,MSR_EE
-	andc	r0,r7,r4
-	mtmsrd	r0
-
-	/* Check current_thread_info()->flags */
-	clrrdi	r4,r1,THREAD_SHIFT
-	ld	r4,TI_FLAGS(r4)
-	andi.	r0,r4,_TIF_NEED_RESCHED
-	beq	1f
-	mtmsrd	r7	/* out of line this ? */
-	blr
-1:	
-	/* Go to NAP now */	
-BEGIN_FTR_SECTION
-	DSSALL
-	sync
-END_FTR_SECTION_IFSET(CPU_FTR_ALTIVEC)
-	oris	r7,r7,MSR_POW@h
-	sync
-	isync
-	mtmsrd	r7
-	isync
-	sync
-	blr
-	
diff --git a/arch/ppc64/kernel/traps.c b/arch/ppc64/kernel/traps.c
deleted file mode 100644
--- a/arch/ppc64/kernel/traps.c
+++ /dev/null
@@ -1,568 +0,0 @@
-/*
- *  linux/arch/ppc64/kernel/traps.c
- *
- *  Copyright (C) 1995-1996  Gary Thomas (gdt@linuxppc.org)
- *
- *  This program is free software; you can redistribute it and/or
- *  modify it under the terms of the GNU General Public License
- *  as published by the Free Software Foundation; either version
- *  2 of the License, or (at your option) any later version.
- *
- *  Modified by Cort Dougan (cort@cs.nmt.edu)
- *  and Paul Mackerras (paulus@cs.anu.edu.au)
- */
-
-/*
- * This file handles the architecture-dependent parts of hardware exceptions
- */
-
-#include <linux/config.h>
-#include <linux/errno.h>
-#include <linux/sched.h>
-#include <linux/kernel.h>
-#include <linux/mm.h>
-#include <linux/stddef.h>
-#include <linux/unistd.h>
-#include <linux/slab.h>
-#include <linux/user.h>
-#include <linux/a.out.h>
-#include <linux/interrupt.h>
-#include <linux/init.h>
-#include <linux/module.h>
-#include <linux/delay.h>
-#include <linux/kprobes.h>
-#include <asm/kdebug.h>
-
-#include <asm/pgtable.h>
-#include <asm/uaccess.h>
-#include <asm/system.h>
-#include <asm/io.h>
-#include <asm/processor.h>
-#include <asm/ppcdebug.h>
-#include <asm/rtas.h>
-#include <asm/systemcfg.h>
-#include <asm/machdep.h>
-#include <asm/pmc.h>
-
-#ifdef CONFIG_DEBUGGER
-int (*__debugger)(struct pt_regs *regs);
-int (*__debugger_ipi)(struct pt_regs *regs);
-int (*__debugger_bpt)(struct pt_regs *regs);
-int (*__debugger_sstep)(struct pt_regs *regs);
-int (*__debugger_iabr_match)(struct pt_regs *regs);
-int (*__debugger_dabr_match)(struct pt_regs *regs);
-int (*__debugger_fault_handler)(struct pt_regs *regs);
-
-EXPORT_SYMBOL(__debugger);
-EXPORT_SYMBOL(__debugger_ipi);
-EXPORT_SYMBOL(__debugger_bpt);
-EXPORT_SYMBOL(__debugger_sstep);
-EXPORT_SYMBOL(__debugger_iabr_match);
-EXPORT_SYMBOL(__debugger_dabr_match);
-EXPORT_SYMBOL(__debugger_fault_handler);
-#endif
-
-struct notifier_block *powerpc_die_chain;
-static DEFINE_SPINLOCK(die_notifier_lock);
-
-int register_die_notifier(struct notifier_block *nb)
-{
-	int err = 0;
-	unsigned long flags;
-
-	spin_lock_irqsave(&die_notifier_lock, flags);
-	err = notifier_chain_register(&powerpc_die_chain, nb);
-	spin_unlock_irqrestore(&die_notifier_lock, flags);
-	return err;
-}
-
-/*
- * Trap & Exception support
- */
-
-static DEFINE_SPINLOCK(die_lock);
-
-int die(const char *str, struct pt_regs *regs, long err)
-{
-	static int die_counter;
-	int nl = 0;
-
-	if (debugger(regs))
-		return 1;
-
-	console_verbose();
-	spin_lock_irq(&die_lock);
-	bust_spinlocks(1);
-	printk("Oops: %s, sig: %ld [#%d]\n", str, err, ++die_counter);
-#ifdef CONFIG_PREEMPT
-	printk("PREEMPT ");
-	nl = 1;
-#endif
-#ifdef CONFIG_SMP
-	printk("SMP NR_CPUS=%d ", NR_CPUS);
-	nl = 1;
-#endif
-#ifdef CONFIG_DEBUG_PAGEALLOC
-	printk("DEBUG_PAGEALLOC ");
-	nl = 1;
-#endif
-#ifdef CONFIG_NUMA
-	printk("NUMA ");
-	nl = 1;
-#endif
-	switch(systemcfg->platform) {
-		case PLATFORM_PSERIES:
-			printk("PSERIES ");
-			nl = 1;
-			break;
-		case PLATFORM_PSERIES_LPAR:
-			printk("PSERIES LPAR ");
-			nl = 1;
-			break;
-		case PLATFORM_ISERIES_LPAR:
-			printk("ISERIES LPAR ");
-			nl = 1;
-			break;
-		case PLATFORM_POWERMAC:
-			printk("POWERMAC ");
-			nl = 1;
-			break;
-		case PLATFORM_BPA:
-			printk("BPA ");
-			nl = 1;
-			break;
-	}
-	if (nl)
-		printk("\n");
-	print_modules();
-	show_regs(regs);
-	bust_spinlocks(0);
-	spin_unlock_irq(&die_lock);
-
-	if (in_interrupt())
-		panic("Fatal exception in interrupt");
-
-	if (panic_on_oops) {
-		printk(KERN_EMERG "Fatal exception: panic in 5 seconds\n");
-		ssleep(5);
-		panic("Fatal exception");
-	}
-	do_exit(SIGSEGV);
-
-	return 0;
-}
-
-void _exception(int signr, struct pt_regs *regs, int code, unsigned long addr)
-{
-	siginfo_t info;
-
-	if (!user_mode(regs)) {
-		if (die("Exception in kernel mode", regs, signr))
-			return;
-	}
-
-	memset(&info, 0, sizeof(info));
-	info.si_signo = signr;
-	info.si_code = code;
-	info.si_addr = (void __user *) addr;
-	force_sig_info(signr, &info, current);
-}
-
-void system_reset_exception(struct pt_regs *regs)
-{
-	/* See if any machine dependent calls */
-	if (ppc_md.system_reset_exception)
-		ppc_md.system_reset_exception(regs);
-
-	die("System Reset", regs, 0);
-
-	/* Must die if the interrupt is not recoverable */
-	if (!(regs->msr & MSR_RI))
-		panic("Unrecoverable System Reset");
-
-	/* What should we do here? We could issue a shutdown or hard reset. */
-}
-
-void machine_check_exception(struct pt_regs *regs)
-{
-	int recover = 0;
-
-	/* See if any machine dependent calls */
-	if (ppc_md.machine_check_exception)
-		recover = ppc_md.machine_check_exception(regs);
-
-	if (recover)
-		return;
-
-	if (debugger_fault_handler(regs))
-		return;
-	die("Machine check", regs, 0);
-
-	/* Must die if the interrupt is not recoverable */
-	if (!(regs->msr & MSR_RI))
-		panic("Unrecoverable Machine check");
-}
-
-void unknown_exception(struct pt_regs *regs)
-{
-	printk("Bad trap at PC: %lx, SR: %lx, vector=%lx\n",
-	       regs->nip, regs->msr, regs->trap);
-
-	_exception(SIGTRAP, regs, 0, 0);
-}
-
-void instruction_breakpoint_exception(struct pt_regs *regs)
-{
-	if (notify_die(DIE_IABR_MATCH, "iabr_match", regs, 5,
-					5, SIGTRAP) == NOTIFY_STOP)
-		return;
-	if (debugger_iabr_match(regs))
-		return;
-	_exception(SIGTRAP, regs, TRAP_BRKPT, regs->nip);
-}
-
-void __kprobes single_step_exception(struct pt_regs *regs)
-{
-	regs->msr &= ~MSR_SE;  /* Turn off 'trace' bit */
-
-	if (notify_die(DIE_SSTEP, "single_step", regs, 5,
-					5, SIGTRAP) == NOTIFY_STOP)
-		return;
-	if (debugger_sstep(regs))
-		return;
-
-	_exception(SIGTRAP, regs, TRAP_TRACE, regs->nip);
-}
-
-/*
- * After we have successfully emulated an instruction, we have to
- * check if the instruction was being single-stepped, and if so,
- * pretend we got a single-step exception.  This was pointed out
- * by Kumar Gala.  -- paulus
- */
-static inline void emulate_single_step(struct pt_regs *regs)
-{
-	if (regs->msr & MSR_SE)
-		single_step_exception(regs);
-}
-
-static void parse_fpe(struct pt_regs *regs)
-{
-	int code = 0;
-	unsigned long fpscr;
-
-	flush_fp_to_thread(current);
-
-	fpscr = current->thread.fpscr;
-
-	/* Invalid operation */
-	if ((fpscr & FPSCR_VE) && (fpscr & FPSCR_VX))
-		code = FPE_FLTINV;
-
-	/* Overflow */
-	else if ((fpscr & FPSCR_OE) && (fpscr & FPSCR_OX))
-		code = FPE_FLTOVF;
-
-	/* Underflow */
-	else if ((fpscr & FPSCR_UE) && (fpscr & FPSCR_UX))
-		code = FPE_FLTUND;
-
-	/* Divide by zero */
-	else if ((fpscr & FPSCR_ZE) && (fpscr & FPSCR_ZX))
-		code = FPE_FLTDIV;
-
-	/* Inexact result */
-	else if ((fpscr & FPSCR_XE) && (fpscr & FPSCR_XX))
-		code = FPE_FLTRES;
-
-	_exception(SIGFPE, regs, code, regs->nip);
-}
-
-/*
- * Illegal instruction emulation support.  Return non-zero if we can't
- * emulate, or -EFAULT if the associated memory access caused an access
- * fault.  Return zero on success.
- */
-
-#define INST_MFSPR_PVR		0x7c1f42a6
-#define INST_MFSPR_PVR_MASK	0xfc1fffff
-
-#define INST_DCBA		0x7c0005ec
-#define INST_DCBA_MASK		0x7c0007fe
-
-#define INST_MCRXR		0x7c000400
-#define INST_MCRXR_MASK		0x7c0007fe
-
-static int emulate_instruction(struct pt_regs *regs)
-{
-	unsigned int instword;
-
-	if (!user_mode(regs))
-		return -EINVAL;
-
-	CHECK_FULL_REGS(regs);
-
-	if (get_user(instword, (unsigned int __user *)(regs->nip)))
-		return -EFAULT;
-
-	/* Emulate the mfspr rD, PVR. */
-	if ((instword & INST_MFSPR_PVR_MASK) == INST_MFSPR_PVR) {
-		unsigned int rd;
-
-		rd = (instword >> 21) & 0x1f;
-		regs->gpr[rd] = mfspr(SPRN_PVR);
-		return 0;
-	}
-
-	/* Emulating the dcba insn is just a no-op.  */
-	if ((instword & INST_DCBA_MASK) == INST_DCBA) {
-		static int warned;
-
-		if (!warned) {
-			printk(KERN_WARNING
-			       "process %d (%s) uses obsolete 'dcba' insn\n",
-			       current->pid, current->comm);
-			warned = 1;
-		}
-		return 0;
-	}
-
-	/* Emulate the mcrxr insn.  */
-	if ((instword & INST_MCRXR_MASK) == INST_MCRXR) {
-		static int warned;
-		unsigned int shift;
-
-		if (!warned) {
-			printk(KERN_WARNING
-			       "process %d (%s) uses obsolete 'mcrxr' insn\n",
-			       current->pid, current->comm);
-			warned = 1;
-		}
-
-		shift = (instword >> 21) & 0x1c;
-		regs->ccr &= ~(0xf0000000 >> shift);
-		regs->ccr |= (regs->xer & 0xf0000000) >> shift;
-		regs->xer &= ~0xf0000000;
-		return 0;
-	}
-
-	return -EINVAL;
-}
-
-/*
- * Look through the list of trap instructions that are used for BUG(),
- * BUG_ON() and WARN_ON() and see if we hit one.  At this point we know
- * that the exception was caused by a trap instruction of some kind.
- * Returns 1 if we should continue (i.e. it was a WARN_ON) or 0
- * otherwise.
- */
-extern struct bug_entry __start___bug_table[], __stop___bug_table[];
-
-#ifndef CONFIG_MODULES
-#define module_find_bug(x)	NULL
-#endif
-
-struct bug_entry *find_bug(unsigned long bugaddr)
-{
-	struct bug_entry *bug;
-
-	for (bug = __start___bug_table; bug < __stop___bug_table; ++bug)
-		if (bugaddr == bug->bug_addr)
-			return bug;
-	return module_find_bug(bugaddr);
-}
-
-static int
-check_bug_trap(struct pt_regs *regs)
-{
-	struct bug_entry *bug;
-	unsigned long addr;
-
-	if (regs->msr & MSR_PR)
-		return 0;	/* not in kernel */
-	addr = regs->nip;	/* address of trap instruction */
-	if (addr < PAGE_OFFSET)
-		return 0;
-	bug = find_bug(regs->nip);
-	if (bug == NULL)
-		return 0;
-	if (bug->line & BUG_WARNING_TRAP) {
-		/* this is a WARN_ON rather than BUG/BUG_ON */
-		printk(KERN_ERR "Badness in %s at %s:%d\n",
-		       bug->function, bug->file,
-		       bug->line & ~BUG_WARNING_TRAP);
-		show_stack(current, (void *)regs->gpr[1]);
-		return 1;
-	}
-	printk(KERN_CRIT "kernel BUG in %s at %s:%d!\n",
-	       bug->function, bug->file, bug->line);
-	return 0;
-}
-
-void __kprobes program_check_exception(struct pt_regs *regs)
-{
-	if (debugger_fault_handler(regs))
-		return;
-
-	if (regs->msr & 0x100000) {
-		/* IEEE FP exception */
-		parse_fpe(regs);
-	} else if (regs->msr & 0x20000) {
-		/* trap exception */
-
-		if (notify_die(DIE_BPT, "breakpoint", regs, 5,
-					5, SIGTRAP) == NOTIFY_STOP)
-			return;
-		if (debugger_bpt(regs))
-			return;
-
-		if (check_bug_trap(regs)) {
-			regs->nip += 4;
-			return;
-		}
-		_exception(SIGTRAP, regs, TRAP_BRKPT, regs->nip);
-
-	} else {
-		/* Privileged or illegal instruction; try to emulate it. */
-		switch (emulate_instruction(regs)) {
-		case 0:
-			regs->nip += 4;
-			emulate_single_step(regs);
-			break;
-
-		case -EFAULT:
-			_exception(SIGSEGV, regs, SEGV_MAPERR, regs->nip);
-			break;
-
-		default:
-			if (regs->msr & 0x40000)
-				/* priveleged */
-				_exception(SIGILL, regs, ILL_PRVOPC, regs->nip);
-			else
-				/* illegal */
-				_exception(SIGILL, regs, ILL_ILLOPC, regs->nip);
-			break;
-		}
-	}
-}
-
-void kernel_fp_unavailable_exception(struct pt_regs *regs)
-{
-	printk(KERN_EMERG "Unrecoverable FP Unavailable Exception "
-			  "%lx at %lx\n", regs->trap, regs->nip);
-	die("Unrecoverable FP Unavailable Exception", regs, SIGABRT);
-}
-
-void altivec_unavailable_exception(struct pt_regs *regs)
-{
-	if (user_mode(regs)) {
-		/* A user program has executed an altivec instruction,
-		   but this kernel doesn't support altivec. */
-		_exception(SIGILL, regs, ILL_ILLOPC, regs->nip);
-		return;
-	}
-	printk(KERN_EMERG "Unrecoverable VMX/Altivec Unavailable Exception "
-			  "%lx at %lx\n", regs->trap, regs->nip);
-	die("Unrecoverable VMX/Altivec Unavailable Exception", regs, SIGABRT);
-}
-
-extern perf_irq_t perf_irq;
-
-void performance_monitor_exception(struct pt_regs *regs)
-{
-	perf_irq(regs);
-}
-
-void alignment_exception(struct pt_regs *regs)
-{
-	int fixed;
-
-	fixed = fix_alignment(regs);
-
-	if (fixed == 1) {
-		regs->nip += 4;	/* skip over emulated instruction */
-		emulate_single_step(regs);
-		return;
-	}
-
-	/* Operand address was bad */	
-	if (fixed == -EFAULT) {
-		if (user_mode(regs)) {
-			_exception(SIGSEGV, regs, SEGV_MAPERR, regs->dar);
-		} else {
-			/* Search exception table */
-			bad_page_fault(regs, regs->dar, SIGSEGV);
-		}
-
-		return;
-	}
-
-	_exception(SIGBUS, regs, BUS_ADRALN, regs->nip);
-}
-
-#ifdef CONFIG_ALTIVEC
-void altivec_assist_exception(struct pt_regs *regs)
-{
-	int err;
-	siginfo_t info;
-
-	if (!user_mode(regs)) {
-		printk(KERN_EMERG "VMX/Altivec assist exception in kernel mode"
-		       " at %lx\n", regs->nip);
-		die("Kernel VMX/Altivec assist exception", regs, SIGILL);
-	}
-
-	flush_altivec_to_thread(current);
-
-	err = emulate_altivec(regs);
-	if (err == 0) {
-		regs->nip += 4;		/* skip emulated instruction */
-		emulate_single_step(regs);
-		return;
-	}
-
-	if (err == -EFAULT) {
-		/* got an error reading the instruction */
-		info.si_signo = SIGSEGV;
-		info.si_errno = 0;
-		info.si_code = SEGV_MAPERR;
-		info.si_addr = (void __user *) regs->nip;
-		force_sig_info(SIGSEGV, &info, current);
-	} else {
-		/* didn't recognize the instruction */
-		/* XXX quick hack for now: set the non-Java bit in the VSCR */
-		if (printk_ratelimit())
-			printk(KERN_ERR "Unrecognized altivec instruction "
-			       "in %s at %lx\n", current->comm, regs->nip);
-		current->thread.vscr.u[3] |= 0x10000;
-	}
-}
-#endif /* CONFIG_ALTIVEC */
-
-/*
- * We enter here if we get an unrecoverable exception, that is, one
- * that happened at a point where the RI (recoverable interrupt) bit
- * in the MSR is 0.  This indicates that SRR0/1 are live, and that
- * we therefore lost state by taking this exception.
- */
-void unrecoverable_exception(struct pt_regs *regs)
-{
-	printk(KERN_EMERG "Unrecoverable exception %lx at %lx\n",
-	       regs->trap, regs->nip);
-	die("Unrecoverable exception", regs, SIGABRT);
-}
-
-/*
- * We enter here if we discover during exception entry that we are
- * running in supervisor mode with a userspace value in the stack pointer.
- */
-void kernel_bad_stack(struct pt_regs *regs)
-{
-	printk(KERN_EMERG "Bad kernel stack pointer %lx at %lx\n",
-	       regs->gpr[1], regs->nip);
-	die("Bad kernel stack pointer", regs, SIGABRT);
-}
-
-void __init trap_init(void)
-{
-}
diff --git a/include/asm-ppc/system.h b/include/asm-ppc/system.h
--- a/include/asm-ppc/system.h
+++ b/include/asm-ppc/system.h
@@ -87,7 +87,7 @@ extern void cacheable_memzero(void *p, u
 extern void *cacheable_memcpy(void *, const void *, unsigned int);
 extern int do_page_fault(struct pt_regs *, unsigned long, unsigned long);
 extern void bad_page_fault(struct pt_regs *, unsigned long, int);
-extern void die(const char *, struct pt_regs *, long);
+extern int die(const char *, struct pt_regs *, long);
 extern void _exception(int, struct pt_regs *, int, unsigned long);
 #ifdef CONFIG_BOOKE_WDT
 extern u32 booke_wdt_enabled;

Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 1F641DDD1C
	for <linuxppc-dev@ozlabs.org>; Fri,  3 Apr 2009 09:04:51 +1100 (EST)
Received: from localhost (localhost.localdomain [127.0.0.1])
	by gate.crashing.org (8.14.1/8.13.8) with ESMTP id n32M4l3P013408
	for <linuxppc-dev@ozlabs.org>; Thu, 2 Apr 2009 17:04:48 -0500
From: Kumar Gala <galak@kernel.crashing.org>
To: linuxppc-dev@ozlabs.org
Subject: [RFC][PATCH] powerpc: Emulate enough of SPE instructions to make gcc
	happy
Date: Thu,  2 Apr 2009 17:04:47 -0500
Message-Id: <1238709887-26237-1-git-send-email-galak@kernel.crashing.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Based on patch from Edmar Wienskoski
---

I posting this to see if anyone would possibly use this support if it was in
the stock kernel.  It allows us to build and use e500/SPE toolchains on G5 HW.

- k

 arch/powerpc/include/asm/processor.h   |    6 +-
 arch/powerpc/kernel/traps.c            |   60 +++++++++-
 arch/powerpc/math-emu/Makefile         |    1 +
 arch/powerpc/math-emu/math_efp.c       |  219 +++++++++++++++++++++++++++++++-
 arch/powerpc/platforms/Kconfig.cputype |    6 +
 5 files changed, 286 insertions(+), 6 deletions(-)

diff --git a/arch/powerpc/include/asm/processor.h b/arch/powerpc/include/asm/processor.h
index 9eed29e..331282c 100644
--- a/arch/powerpc/include/asm/processor.h
+++ b/arch/powerpc/include/asm/processor.h
@@ -191,12 +191,12 @@ struct thread_struct {
 	/* VSR status */
 	int		used_vsr;	/* set if process has used altivec */
 #endif /* CONFIG_VSX */
-#ifdef CONFIG_SPE
+#if defined(CONFIG_SPE) || defined(CONFIG_SPE_EMULATION)
 	unsigned long	evr[32];	/* upper 32-bits of SPE regs */
 	u64		acc;		/* Accumulator */
 	unsigned long	spefscr;	/* SPE & eFP status */
 	int		used_spe;	/* set if process has used spe */
-#endif /* CONFIG_SPE */
+#endif /* CONFIG_SPE || CONFIG_SPE_EMULATION */
 };
 
 #define ARCH_MIN_TASKALIGN 16
@@ -205,7 +205,7 @@ struct thread_struct {
 #define INIT_SP_LIMIT \
 	(_ALIGN_UP(sizeof(init_thread_info), 16) + (unsigned long) &init_stack)
 
-#ifdef CONFIG_SPE
+#if defined(CONFIG_SPE) || defined(CONFIG_SPE_EMULATION)
 #define SPEFSCR_INIT .spefscr = SPEFSCR_FINVE | SPEFSCR_FDBZE | SPEFSCR_FUNFE | SPEFSCR_FOVFE,
 #else
 #define SPEFSCR_INIT
diff --git a/arch/powerpc/kernel/traps.c b/arch/powerpc/kernel/traps.c
index 678fbff..ebdd83a 100644
--- a/arch/powerpc/kernel/traps.c
+++ b/arch/powerpc/kernel/traps.c
@@ -798,6 +798,8 @@ int is_valid_bugaddr(unsigned long addr)
 	return is_kernel_addr(addr);
 }
 
+int SPEFloatingPoint(struct pt_regs *);
+
 void __kprobes program_check_exception(struct pt_regs *regs)
 {
 	unsigned int reason = get_reason(regs);
@@ -830,6 +832,14 @@ void __kprobes program_check_exception(struct pt_regs *regs)
 
 	local_irq_enable();
 
+	switch (SPEFloatingPoint (regs)) {
+	case 0:
+		return;
+	case -ENOSYS:
+		_exception(SIGSEGV, regs, SEGV_MAPERR, regs->nip);
+		return;
+	}
+
 #ifdef CONFIG_MATH_EMULATION
 	/* (reason & REASON_ILLEGAL) would be the obvious thing here,
 	 * but there seems to be a hardware bug on the 405GP (RevD)
@@ -938,8 +948,10 @@ void altivec_unavailable_exception(struct pt_regs *regs)
 	if (user_mode(regs)) {
 		/* A user program has executed an altivec instruction,
 		   but this kernel doesn't support altivec. */
-		_exception(SIGILL, regs, ILL_ILLOPC, regs->nip);
-		return;
+		switch (SPEFloatingPoint (regs)) {
+		case 0:
+			return;
+		}
 	}
 
 	printk(KERN_EMERG "Unrecoverable VMX/Altivec Unavailable Exception "
@@ -1156,6 +1168,50 @@ void CacheLockingException(struct pt_regs *regs, unsigned long address,
 }
 #endif /* CONFIG_FSL_BOOKE */
 
+int SPEFloatingPoint(struct pt_regs *regs)
+{
+	extern int do_spe_mathemu(struct pt_regs *regs);
+	unsigned long spefscr;
+	int fpexc_mode;
+	int code = 0;
+	int err;
+
+	spefscr = current->thread.spefscr;
+	fpexc_mode = current->thread.fpexc_mode;
+
+	if ((spefscr & SPEFSCR_FOVF) && (fpexc_mode & PR_FP_EXC_OVF)) {
+		code = FPE_FLTOVF;
+	}
+	else if ((spefscr & SPEFSCR_FUNF) && (fpexc_mode & PR_FP_EXC_UND)) {
+		code = FPE_FLTUND;
+	}
+	else if ((spefscr & SPEFSCR_FDBZ) && (fpexc_mode & PR_FP_EXC_DIV))
+		code = FPE_FLTDIV;
+	else if ((spefscr & SPEFSCR_FINV) && (fpexc_mode & PR_FP_EXC_INV)) {
+		code = FPE_FLTINV;
+	}
+	else if ((spefscr & (SPEFSCR_FG | SPEFSCR_FX)) && (fpexc_mode & PR_FP_EXC_RES))
+		code = FPE_FLTRES;
+
+	err = do_spe_mathemu(regs);
+	if (err == 0) {
+		regs->nip += 4;		/* skip emulated instruction */
+		emulate_single_step(regs);
+		return 0;
+	}
+
+	if (err == -EFAULT) {
+		/* got an error reading the instruction */
+		_exception(SIGSEGV, regs, SEGV_ACCERR, regs->nip);
+	} else if (err == -EINVAL || err == -ENOSYS) {
+		return 1;
+	} else {
+		_exception(SIGFPE, regs, code, regs->nip);
+	}
+
+	return 0;
+}
+
 #ifdef CONFIG_SPE
 void SPEFloatingPointException(struct pt_regs *regs)
 {
diff --git a/arch/powerpc/math-emu/Makefile b/arch/powerpc/math-emu/Makefile
index 0c16ab9..f4eb888 100644
--- a/arch/powerpc/math-emu/Makefile
+++ b/arch/powerpc/math-emu/Makefile
@@ -11,6 +11,7 @@ obj-$(CONFIG_MATH_EMULATION)	+= fabs.o fadd.o fadds.o fcmpo.o fcmpu.o \
 					math.o fmr.o lfd.o stfd.o
 
 obj-$(CONFIG_SPE)		+= math_efp.o
+obj-$(CONFIG_SPE_EMULATION)	+= math_efp.o
 
 CFLAGS_fabs.o = -fno-builtin-fabs
 CFLAGS_math.o = -fno-builtin-fabs
diff --git a/arch/powerpc/math-emu/math_efp.c b/arch/powerpc/math-emu/math_efp.c
index 41f4ef3..e9d9346 100644
--- a/arch/powerpc/math-emu/math_efp.c
+++ b/arch/powerpc/math-emu/math_efp.c
@@ -33,10 +33,26 @@
 
 #define EFAPU		0x4
 
+#define VLD		0x0
+#define VST		0x1
 #define VCT		0x4
 #define SPFP		0x6
 #define DPFP		0x7
 
+#define EVNEG           0x209
+#define EVAND           0x211
+#define EVANDC          0x212
+#define EVXOR           0x216
+#define EVOR            0x217
+#define EVNOR           0x218
+#define EVEQV           0x219
+#define EVORC           0x21b
+
+#define EVMERGEHI       0x22c
+#define EVMERGELO       0x22d
+#define EVMERGEHILO     0x22e
+#define EVMERGELOHI     0x22f
+
 #define EFSADD		0x2c0
 #define EFSSUB		0x2c1
 #define EFSABS		0x2c4
@@ -48,6 +64,7 @@
 #define EFSCMPLT	0x2cd
 #define EFSCMPEQ	0x2ce
 #define EFSCFD		0x2cf
+#define EFSCFUI		0x2d0
 #define EFSCFSI		0x2d1
 #define EFSCTUI		0x2d4
 #define EFSCTSI		0x2d5
@@ -55,6 +72,9 @@
 #define EFSCTSF		0x2d7
 #define EFSCTUIZ	0x2d8
 #define EFSCTSIZ	0x2da
+#define EFSTSTGT	0x2dc
+#define EFSTSTLT	0x2dd
+#define EFSTSTEQ	0x2de
 
 #define EVFSADD		0x280
 #define EVFSSUB		0x281
@@ -75,6 +95,8 @@
 
 #define EFDADD		0x2e0
 #define EFDSUB		0x2e1
+#define EFDCFUID	0x2e2
+#define EFDCFSID	0x2e3
 #define EFDABS		0x2e4
 #define EFDNABS		0x2e5
 #define EFDNEG		0x2e6
@@ -86,12 +108,30 @@
 #define EFDCMPLT	0x2ed
 #define EFDCMPEQ	0x2ee
 #define EFDCFS		0x2ef
+#define EFDCFUI		0x2f0
+#define EFDCFSI		0x2f1
 #define EFDCTUI		0x2f4
 #define EFDCTSI		0x2f5
 #define EFDCTUF		0x2f6
 #define EFDCTSF		0x2f7
 #define EFDCTUIZ	0x2f8
 #define EFDCTSIZ	0x2fa
+#define EFDTSTGT	0x2fc
+#define EFDTSTLT	0x2fd
+#define EFDTSTEQ	0x2fe
+
+#define EVLDDX		0x300
+#define EVLDD		0x301
+#define EVLDWX		0x302
+#define EVLDW		0x303
+#define EVLDHX		0x304
+#define EVLDH		0x305
+#define EVSTDDX		0x320
+#define EVSTDD		0x321
+#define EVSTDWX		0x322
+#define EVSTDW		0x323
+#define EVSTDHX		0x324
+#define EVSTDH		0x325
 
 #define AB	2
 #define XA	3
@@ -114,6 +154,20 @@ static unsigned long insn_type(unsigned long speinsn)
 	unsigned long ret = NOTYPE;
 
 	switch (speinsn & 0x7ff) {
+	case EVNEG:	ret = XCR;	break;
+	case EVAND:	ret = XCR;	break;
+	case EVANDC:	ret = XCR;	break;
+	case EVXOR:	ret = XCR;	break;
+	case EVOR:	ret = XCR;	break;
+	case EVNOR:	ret = XCR;	break;
+	case EVEQV:	ret = XCR;	break;
+	case EVORC:	ret = XCR;	break;
+
+	case EVMERGEHI: ret = XCR;	break;
+	case EVMERGELO: ret = XCR;	break;
+	case EVMERGEHILO: ret = XCR;	break;
+	case EVMERGELOHI: ret = XCR;	break;
+
 	case EFSABS:	ret = XA;	break;
 	case EFSADD:	ret = AB;	break;
 	case EFSCFD:	ret = XB;	break;
@@ -126,11 +180,15 @@ static unsigned long insn_type(unsigned long speinsn)
 	case EFSCTUF:	ret = XB;	break;
 	case EFSCTUI:	ret = XB;	break;
 	case EFSCTUIZ:	ret = XB;	break;
+	case EFSTSTGT:  /* ret = XB;*/  break;
+	case EFSTSTLT:  /* ret = XB;*/  break;
+	case EFSTSTEQ:  /* ret = XB;*/  break;
 	case EFSDIV:	ret = AB;	break;
 	case EFSMUL:	ret = AB;	break;
 	case EFSNABS:	ret = XA;	break;
 	case EFSNEG:	ret = XA;	break;
 	case EFSSUB:	ret = AB;	break;
+	case EFSCFUI:	ret = XB;	break;
 	case EFSCFSI:	ret = XB;	break;
 
 	case EVFSABS:	ret = XA;	break;
@@ -149,7 +207,6 @@ static unsigned long insn_type(unsigned long speinsn)
 	case EVFSNABS:	ret = XA;	break;
 	case EVFSNEG:	ret = XA;	break;
 	case EVFSSUB:	ret = AB;	break;
-
 	case EFDABS:	ret = XA;	break;
 	case EFDADD:	ret = AB;	break;
 	case EFDCFS:	ret = XB;	break;
@@ -160,6 +217,11 @@ static unsigned long insn_type(unsigned long speinsn)
 	case EFDCTSI:	ret = XB;	break;
 	case EFDCTSIDZ:	ret = XB;	break;
 	case EFDCTSIZ:	ret = XB;	break;
+	case EFDTSTGT:	/* ret = XB;*/	break;
+	case EFDTSTLT:	/* ret = XB;*/	break;
+	case EFDTSTEQ:	/* ret = XB;*/	break;
+	case EFDCFUI:	ret = XB;	break;
+	case EFDCFSI:	ret = XB;	break;
 	case EFDCTUF:	ret = XB;	break;
 	case EFDCTUI:	ret = XB;	break;
 	case EFDCTUIDZ:	ret = XB;	break;
@@ -169,6 +231,21 @@ static unsigned long insn_type(unsigned long speinsn)
 	case EFDNABS:	ret = XA;	break;
 	case EFDNEG:	ret = XA;	break;
 	case EFDSUB:	ret = AB;	break;
+	case EFDCFUID:	ret = XB;	break;
+	case EFDCFSID:	ret = XB;	break;
+
+	case EVLDDX:	ret = XCR;	break;
+	case EVLDD:	ret = XCR;	break;
+	case EVLDWX:	ret = XCR;	break;
+	case EVLDW:	ret = XCR;	break;
+	case EVLDHX:	ret = XCR;	break;
+	case EVLDH:	ret = XCR;	break;
+	case EVSTDDX:	ret = XCR;	break;
+	case EVSTDD:	ret = XCR;	break;
+	case EVSTDWX:	ret = XCR;	break;
+	case EVSTDW:	ret = XCR;	break;
+	case EVSTDHX:	ret = XCR;	break;
+	case EVSTDH:	ret = XCR;	break;
 
 	default:
 		printk(KERN_ERR "\nOoops! SPE instruction no type found.");
@@ -208,7 +285,11 @@ int do_spe_mathemu(struct pt_regs *regs)
 	vb.wp[0] = current->thread.evr[fb];
 	vb.wp[1] = regs->gpr[fb];
 
+#ifdef CONFIG_SPE_EMULATION
+	__FPU_FPSCR = current->thread.spefscr;
+#else
 	__FPU_FPSCR = mfspr(SPRN_SPEFSCR);
+#endif
 
 #ifdef DEBUG
 	printk("speinsn:%08lx spefscr:%08lx\n", speinsn, __FPU_FPSCR);
@@ -218,6 +299,108 @@ int do_spe_mathemu(struct pt_regs *regs)
 #endif
 
 	switch (src) {
+	case VLD:
+		switch (func) {
+		u32 *ea;
+
+		case EVNEG:
+			vc.wp[0] = ~va.wp[0] + 1;
+			vc.wp[1] = ~vb.wp[1] + 1;
+			goto write_dest_reg;
+
+		case EVAND:
+			vc.wp[0] = va.wp[0] & vb.wp[0];
+			vc.wp[1] = va.wp[1] & vb.wp[1];
+			goto write_dest_reg;
+
+		case EVANDC:
+			vc.wp[0] = va.wp[0] & ~vb.wp[0];
+			vc.wp[1] = va.wp[1] & ~vb.wp[1];
+			goto write_dest_reg;
+
+		case EVXOR:
+			vc.wp[0] = va.wp[0] ^ vb.wp[0];
+			vc.wp[1] = va.wp[1] ^ vb.wp[1];
+			goto write_dest_reg;
+
+		case EVOR:
+			vc.wp[0] = va.wp[0] | vb.wp[0];
+			vc.wp[1] = va.wp[1] | vb.wp[1];
+			goto write_dest_reg;
+
+		case EVNOR:
+			vc.wp[0] = ~ (va.wp[0] | vb.wp[0]);
+			vc.wp[1] = ~ (va.wp[1] | vb.wp[1]);
+			goto write_dest_reg;
+
+		case EVEQV:
+			vc.wp[0] = ~ (va.wp[0] ^ vb.wp[0]);
+			vc.wp[1] = ~ (va.wp[1] ^ vb.wp[1]);
+			goto write_dest_reg;
+
+		case EVORC:
+			vc.wp[0] = va.wp[0] | ~vb.wp[0];
+			vc.wp[1] = va.wp[1] | ~vb.wp[1];
+			goto write_dest_reg;
+
+		case EVLDDX:
+		case EVLDWX:
+		case EVLDHX:
+			ea = (void *)((fa ? va.wp[1] : 0) + vb.wp[1]);
+			if (copy_from_user(&vc.dp[0], ea, sizeof(u64)))
+				return -EFAULT;
+			goto write_dest_reg;
+		case EVLDD:
+		case EVLDW:
+		case EVLDH:
+			ea = (void *)((fa ? va.wp[1] : 0) + fb * 8);
+			if (copy_from_user(&vc.dp[0], ea, sizeof(u64)))
+				return -EFAULT;
+			goto write_dest_reg;
+		}
+		break;
+
+	case VST:
+		switch (func) {
+		u32 *ea;
+
+		case EVMERGEHI:
+			vc.wp[0] = va.wp[0];
+			vc.wp[1] = vb.wp[0];
+			goto write_dest_reg;
+
+		case EVMERGELO:
+			vc.wp[0] = va.wp[1];
+			vc.wp[1] = vb.wp[1];
+			goto write_dest_reg;
+
+		case EVMERGEHILO:
+			vc.wp[0] = va.wp[0];
+			vc.wp[1] = vb.wp[1];
+			goto write_dest_reg;
+
+		case EVMERGELOHI:
+			vc.wp[0] = va.wp[1];
+			vc.wp[1] = vb.wp[0];
+			goto write_dest_reg;
+
+		case EVSTDDX:
+		case EVSTDWX:
+		case EVSTDHX:
+			ea = (void *)((fa ? va.wp[1] : 0) + vb.wp[1]);
+			if (copy_to_user(ea, &vc.dp[0], sizeof(u64)))
+				return -EFAULT;
+			goto finish_insn;
+		case EVSTDD:
+		case EVSTDW:
+		case EVSTDH:
+			ea = (void *)((fa ? va.wp[1] : 0) + fb * 8);
+			if (copy_to_user(ea, &vc.dp[0], sizeof(u64)))
+				return -EFAULT;
+			goto finish_insn;
+		}
+		break;
+
 	case SPFP: {
 		FP_DECL_S(SA); FP_DECL_S(SB); FP_DECL_S(SR);
 
@@ -311,6 +494,14 @@ int do_spe_mathemu(struct pt_regs *regs)
 			goto pack_s;
 		}
 
+		case EFSCFUI:
+			FP_FROM_INT_S (SR, vb.wp[1], 32, int);
+			goto pack_s;
+
+		case EFSCFSI:
+			FP_FROM_INT_S (SR, (int) vb.wp[1], 32, int);
+			goto pack_s;
+
 		case EFSCTSI:
 		case EFSCTSIZ:
 		case EFSCTUI:
@@ -449,6 +640,22 @@ cmp_s:
 			FP_TO_INT_D(vc.dp[0], DB, 64, ((func & 0x1) == 0));
 			goto update_regs;
 
+		case EFDCFUI:
+			FP_FROM_INT_D(DR, vb.wp[1], 32, int);
+			goto pack_d;
+
+		case EFDCFSI:
+			FP_FROM_INT_D(DR, (int) vb.wp[1], 32, int);
+			goto pack_d;
+
+		case EFDCFUID:
+			FP_FROM_INT_D(DR, vb.dp[0], 64, long);
+			goto pack_d;
+
+		case EFDCFSID:
+			FP_FROM_INT_D(DR, (long)vb.dp[0], 64, long);
+			goto pack_d;
+
 		case EFDCTUI:
 		case EFDCTSI:
 		case EFDCTUIZ:
@@ -635,11 +842,17 @@ update_ccr:
 update_regs:
 	__FPU_FPSCR &= ~FP_EX_MASK;
 	__FPU_FPSCR |= (FP_CUR_EXCEPTIONS & FP_EX_MASK);
+#ifdef CONFIG_SPE_EMULATION
+	current->thread.spefscr = __FPU_FPSCR;
+#else
 	mtspr(SPRN_SPEFSCR, __FPU_FPSCR);
+#endif
 
+write_dest_reg:
 	current->thread.evr[fc] = vc.wp[0];
 	regs->gpr[fc] = vc.wp[1];
 
+finish_insn:
 #ifdef DEBUG
 	printk("ccr = %08lx\n", regs->ccr);
 	printk("cur exceptions = %08x spefscr = %08lx\n",
@@ -676,7 +889,11 @@ int speround_handler(struct pt_regs *regs)
 	fgpr.wp[0] = current->thread.evr[fc];
 	fgpr.wp[1] = regs->gpr[fc];
 
+#ifdef CONFIG_SPE_EMULATION
+	__FPU_FPSCR = current->thread.spefscr;
+#else
 	__FPU_FPSCR = mfspr(SPRN_SPEFSCR);
+#endif
 
 	switch ((speinsn >> 5) & 0x7) {
 	/* Since SPE instructions on E500 core can handle round to nearest
diff --git a/arch/powerpc/platforms/Kconfig.cputype b/arch/powerpc/platforms/Kconfig.cputype
index 9da795e..1d5fd55 100644
--- a/arch/powerpc/platforms/Kconfig.cputype
+++ b/arch/powerpc/platforms/Kconfig.cputype
@@ -169,6 +169,12 @@ config ALTIVEC
 
 	  If in doubt, say Y here.
 
+config SPE_EMULATION
+	bool "SPE Emulation Support"
+	depends on (CLASSIC32 || POWER4) && !ALTIVEC && !SPE
+	---help---
+	  This option enables kernel support for the Altivec extensions to the
+
 config VSX
 	bool "VSX Support"
 	depends on POWER4 && ALTIVEC && PPC_FPU
-- 
1.5.6.6

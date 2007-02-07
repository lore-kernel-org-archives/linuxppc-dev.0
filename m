Return-Path: <galak@kernel.crashing.org>
Received: from nommos.sslcatacombnetworking.com
	(nommos.sslcatacombnetworking.com [67.18.224.114])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 9FBB5DDE3F
	for <linuxppc-dev@ozlabs.org>; Wed,  7 Feb 2007 18:54:43 +1100 (EST)
Date: Wed, 7 Feb 2007 01:51:50 -0600 (CST)
From: Kumar Gala <galak@kernel.crashing.org>
To: Paul Mackerras <paulus@samba.org>
Subject: Please pull from 'for_paulus' branch
Message-ID: <Pine.LNX.4.64.0702070150410.13824@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Please pull from 'for_paulus' branch of
master.kernel.org/pub/scm/linux/kernel/git/galak/powerpc.git

to receive the following updates:

  arch/powerpc/Kconfig          |    2
  arch/powerpc/kernel/kprobes.c |    8 ++-
  arch/powerpc/kernel/traps.c   |  109 ++++++++++++++++++++++++++++--------------
  arch/powerpc/lib/Makefile     |    2
  include/asm-powerpc/kprobes.h |    7 ++
  include/asm-powerpc/sstep.h   |    1
  6 files changed, 89 insertions(+), 40 deletions(-)

Kumar Gala (3):
       [POWERPC] Added kprobes support to ppc32
       [POWERPC] Enable interrupts if we are doing fp math emulation
       [POWERPC] Fixup error handling when emulating a floating point instruction

diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index aeb5309..0b6325a 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -1206,7 +1206,7 @@ source "arch/powerpc/oprofile/Kconfig"

  config KPROBES
  	bool "Kprobes (EXPERIMENTAL)"
-	depends on PPC64 && KALLSYMS && EXPERIMENTAL && MODULES
+	depends on !BOOKE && !4xx && KALLSYMS && EXPERIMENTAL && MODULES
  	help
  	  Kprobes allows you to trap at almost any kernel address and
  	  execute a callback function.  register_kprobe() establishes
diff --git a/arch/powerpc/kernel/kprobes.c b/arch/powerpc/kernel/kprobes.c
index 4657563..dd2886f 100644
--- a/arch/powerpc/kernel/kprobes.c
+++ b/arch/powerpc/kernel/kprobes.c
@@ -46,8 +46,8 @@ int __kprobes arch_prepare_kprobe(struct kprobe *p)
  	if ((unsigned long)p->addr & 0x03) {
  		printk("Attempt to register kprobe at an unaligned address\n");
  		ret = -EINVAL;
-	} else if (IS_MTMSRD(insn) || IS_RFID(insn)) {
-		printk("Cannot register a kprobe on rfid or mtmsrd\n");
+	} else if (IS_MTMSRD(insn) || IS_RFID(insn) || IS_RFI(insn)) {
+		printk("Cannot register a kprobe on rfi/rfid or mtmsr[d]\n");
  		ret = -EINVAL;
  	}

@@ -483,8 +483,12 @@ int __kprobes setjmp_pre_handler(struct kprobe *p, struct pt_regs *regs)
  	memcpy(&kcb->jprobe_saved_regs, regs, sizeof(struct pt_regs));

  	/* setup return addr to the jprobe handler routine */
+#ifdef CONFIG_PPC64
  	regs->nip = (unsigned long)(((func_descr_t *)jp->entry)->entry);
  	regs->gpr[2] = (unsigned long)(((func_descr_t *)jp->entry)->toc);
+#else
+	regs->nip = (unsigned long)jp->entry;
+#endif

  	return 1;
  }
diff --git a/arch/powerpc/kernel/traps.c b/arch/powerpc/kernel/traps.c
index 6915b91..dcc6f15 100644
--- a/arch/powerpc/kernel/traps.c
+++ b/arch/powerpc/kernel/traps.c
@@ -535,34 +535,40 @@ static void emulate_single_step(struct pt_regs *regs)
  	}
  }

-static void parse_fpe(struct pt_regs *regs)
+static inline int __parse_fpscr(unsigned long fpscr)
  {
-	int code = 0;
-	unsigned long fpscr;
-
-	flush_fp_to_thread(current);
-
-	fpscr = current->thread.fpscr.val;
+	int ret = 0;

  	/* Invalid operation */
  	if ((fpscr & FPSCR_VE) && (fpscr & FPSCR_VX))
-		code = FPE_FLTINV;
+		ret = FPE_FLTINV;

  	/* Overflow */
  	else if ((fpscr & FPSCR_OE) && (fpscr & FPSCR_OX))
-		code = FPE_FLTOVF;
+		ret = FPE_FLTOVF;

  	/* Underflow */
  	else if ((fpscr & FPSCR_UE) && (fpscr & FPSCR_UX))
-		code = FPE_FLTUND;
+		ret = FPE_FLTUND;

  	/* Divide by zero */
  	else if ((fpscr & FPSCR_ZE) && (fpscr & FPSCR_ZX))
-		code = FPE_FLTDIV;
+		ret = FPE_FLTDIV;

  	/* Inexact result */
  	else if ((fpscr & FPSCR_XE) && (fpscr & FPSCR_XX))
-		code = FPE_FLTRES;
+		ret = FPE_FLTRES;
+
+	return ret;
+}
+
+static void parse_fpe(struct pt_regs *regs)
+{
+	int code = 0;
+
+	flush_fp_to_thread(current);
+
+	code = __parse_fpscr(current->thread.fpscr.val);

  	_exception(SIGFPE, regs, code, regs->nip);
  }
@@ -739,20 +745,7 @@ void __kprobes program_check_exception(struct pt_regs *regs)
  	extern int do_mathemu(struct pt_regs *regs);

  	/* We can now get here via a FP Unavailable exception if the core
-	 * has no FPU, in that case no reason flags will be set */
-#ifdef CONFIG_MATH_EMULATION
-	/* (reason & REASON_ILLEGAL) would be the obvious thing here,
-	 * but there seems to be a hardware bug on the 405GP (RevD)
-	 * that means ESR is sometimes set incorrectly - either to
-	 * ESR_DST (!?) or 0.  In the process of chasing this with the
-	 * hardware people - not sure if it can happen on any illegal
-	 * instruction or only on FP instructions, whether there is a
-	 * pattern to occurences etc. -dgibson 31/Mar/2003 */
-	if (!(reason & REASON_TRAP) && do_mathemu(regs) == 0) {
-		emulate_single_step(regs);
-		return;
-	}
-#endif /* CONFIG_MATH_EMULATION */
+	 * has no FPU, in that case the reason flags will be 0 */

  	if (reason & REASON_FP) {
  		/* IEEE FP exception */
@@ -778,6 +771,31 @@ void __kprobes program_check_exception(struct pt_regs *regs)

  	local_irq_enable();

+#ifdef CONFIG_MATH_EMULATION
+	/* (reason & REASON_ILLEGAL) would be the obvious thing here,
+	 * but there seems to be a hardware bug on the 405GP (RevD)
+	 * that means ESR is sometimes set incorrectly - either to
+	 * ESR_DST (!?) or 0.  In the process of chasing this with the
+	 * hardware people - not sure if it can happen on any illegal
+	 * instruction or only on FP instructions, whether there is a
+	 * pattern to occurences etc. -dgibson 31/Mar/2003 */
+	switch (do_mathemu(regs)) {
+	case 0:
+		emulate_single_step(regs);
+		return;
+	case 1: {
+			int code = 0;
+			code = __parse_fpscr(current->thread.fpscr.val);
+			_exception(SIGFPE, regs, code, regs->nip);
+			return;
+		}
+	case -EFAULT:
+		_exception(SIGSEGV, regs, SEGV_MAPERR, regs->nip);
+		return;
+	}
+	/* fall through on any other errors */
+#endif /* CONFIG_MATH_EMULATION */
+
  	/* Try to emulate it if we should. */
  	if (reason & (REASON_ILLEGAL | REASON_PRIVILEGED)) {
  		switch (emulate_instruction(regs)) {
@@ -891,18 +909,39 @@ void SoftwareEmulation(struct pt_regs *regs)

  #ifdef CONFIG_MATH_EMULATION
  	errcode = do_mathemu(regs);
+
+	switch (errcode) {
+	case 0:
+		emulate_single_step(regs);
+		return;
+	case 1: {
+			int code = 0;
+			code = __parse_fpscr(current->thread.fpscr.val);
+			_exception(SIGFPE, regs, code, regs->nip);
+			return;
+		}
+	case -EFAULT:
+		_exception(SIGSEGV, regs, SEGV_MAPERR, regs->nip);
+		return;
+	default:
+		_exception(SIGILL, regs, ILL_ILLOPC, regs->nip);
+		return;
+	}
+
  #else
  	errcode = Soft_emulate_8xx(regs);
-#endif
-	if (errcode) {
-		if (errcode > 0)
-			_exception(SIGFPE, regs, 0, 0);
-		else if (errcode == -EFAULT)
-			_exception(SIGSEGV, regs, 0, 0);
-		else
-			_exception(SIGILL, regs, ILL_ILLOPC, regs->nip);
-	} else
+	switch (errcode) {
+	case 0:
  		emulate_single_step(regs);
+		return;
+	case 1:
+		_exception(SIGILL, regs, ILL_ILLOPC, regs->nip);
+		return;
+	case -EFAULT:
+		_exception(SIGSEGV, regs, SEGV_MAPERR, regs->nip);
+		return;
+	}
+#endif
  }
  #endif /* CONFIG_8xx */

diff --git a/arch/powerpc/lib/Makefile b/arch/powerpc/lib/Makefile
index e2d4141..4b1ba49 100644
--- a/arch/powerpc/lib/Makefile
+++ b/arch/powerpc/lib/Makefile
@@ -16,11 +16,11 @@ obj-$(CONFIG_PPC64)	+= checksum_64.o copypage_64.o copyuser_64.o \
  			   strcase.o
  obj-$(CONFIG_QUICC_ENGINE) += rheap.o
  obj-$(CONFIG_XMON)	+= sstep.o
+obj-$(CONFIG_KPROBES)	+= sstep.o
  obj-$(CONFIG_NOT_COHERENT_CACHE)	+= dma-noncoherent.o

  ifeq ($(CONFIG_PPC64),y)
  obj-$(CONFIG_SMP)	+= locks.o
-obj-$(CONFIG_DEBUG_KERNEL) += sstep.o
  endif

  # Temporary hack until we have migrated to asm-powerpc
diff --git a/include/asm-powerpc/kprobes.h b/include/asm-powerpc/kprobes.h
index 2dafa37..3a5dd49 100644
--- a/include/asm-powerpc/kprobes.h
+++ b/include/asm-powerpc/kprobes.h
@@ -44,6 +44,7 @@ typedef unsigned int kprobe_opcode_t;
  #define IS_TDI(instr)		(((instr) & 0xfc000000) == 0x08000000)
  #define IS_TWI(instr)		(((instr) & 0xfc000000) == 0x0c000000)

+#ifdef CONFIG_PPC64
  /*
   * 64bit powerpc uses function descriptors.
   * Handle cases where:
@@ -67,9 +68,13 @@ typedef unsigned int kprobe_opcode_t;
  }

  #define JPROBE_ENTRY(pentry)	(kprobe_opcode_t *)((func_descr_t *)pentry)
-
  #define is_trap(instr)	(IS_TW(instr) || IS_TD(instr) || \
  			IS_TWI(instr) || IS_TDI(instr))
+#else
+/* Use stock kprobe_lookup_name since ppc32 doesn't use function descriptors */
+#define JPROBE_ENTRY(pentry)	(kprobe_opcode_t *)(pentry)
+#define is_trap(instr)	(IS_TW(instr) || IS_TWI(instr))
+#endif

  #define ARCH_SUPPORTS_KRETPROBES
  #define  ARCH_INACTIVE_KPROBE_COUNT 1
diff --git a/include/asm-powerpc/sstep.h b/include/asm-powerpc/sstep.h
index 630a988..f593b0f 100644
--- a/include/asm-powerpc/sstep.h
+++ b/include/asm-powerpc/sstep.h
@@ -21,6 +21,7 @@ struct pt_regs;
   */
  #define IS_MTMSRD(instr)	(((instr) & 0xfc0007be) == 0x7c000124)
  #define IS_RFID(instr)		(((instr) & 0xfc0007fe) == 0x4c000024)
+#define IS_RFI(instr)		(((instr) & 0xfc0007fe) == 0x4c000064)

  /* Emulate instructions that cause a transfer of control. */
  extern int emulate_step(struct pt_regs *regs, unsigned int instr);

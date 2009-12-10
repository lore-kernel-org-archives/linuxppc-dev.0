Return-Path: <jwboyer@linux.vnet.ibm.com>
Date: Thu, 10 Dec 2009 12:27:11 -0500
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: Dave Kleikamp <shaggy@linux.vnet.ibm.com>
Subject: Re: [RFC:PATCH 03/03] powerpc: Add support for BookE Debug Reg.
	traps, exceptions and ptrace
Message-ID: <20091210172711.GV2937@zod.rchland.ibm.com>
References: <20091210155709.6697.4635.sendpatchset@norville.austin.ibm.com>
	<20091210155727.6697.74672.sendpatchset@norville.austin.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20091210155727.6697.74672.sendpatchset@norville.austin.ibm.com>
Cc: linuxppc-dev list <Linuxppc-dev@ozlabs.org>,
	Sergio Durigan Junior <sergiodj@br.ibm.com>,
	Torez Smith <torez@us.ibm.com>,
	Thiago Jung Bauermann <bauerman@br.ibm.com>, David Gibson <dwg@au1.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Dec 10, 2009 at 01:57:27PM -0200, Dave Kleikamp wrote:
>powerpc: Add support for BookE Debug Reg. traps, exceptions and ptrace
>
>From: Torez Smith <lnxtorez@linux.vnet.ibm.com>
>
>This patch defines context switch and trap related functionality
>for BookE specific Debug Registers. It adds support to ptrace()
>for setting and getting BookE related Debug Registers
>
>Signed-off-by: Torez Smith  <lnxtorez@linux.vnet.ibm.com>
>Signed-off-by: Dave Kleikamp <shaggy@linux.vnet.ibm.com>
>Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
>Cc: Thiago Jung Bauermann <bauerman@br.ibm.com>
>Cc: Sergio Durigan Junior <sergiodj@br.ibm.com>
>Cc: David Gibson <dwg@au1.ibm.com>
>Cc: linuxppc-dev list <Linuxppc-dev@ozlabs.org>
>---
>
> arch/powerpc/include/asm/system.h |    2 
> arch/powerpc/kernel/process.c     |  109 ++++++++-
> arch/powerpc/kernel/ptrace.c      |  435 ++++++++++++++++++++++++++++++++++---
> arch/powerpc/kernel/signal.c      |    6 -
> arch/powerpc/kernel/signal_32.c   |    8 +
> arch/powerpc/kernel/traps.c       |   86 ++++++-
> 6 files changed, 564 insertions(+), 82 deletions(-)
>
>
>diff --git a/arch/powerpc/include/asm/system.h b/arch/powerpc/include/asm/system.h
>index bb8e006..474bf23 100644
>--- a/arch/powerpc/include/asm/system.h
>+++ b/arch/powerpc/include/asm/system.h
>@@ -114,6 +114,8 @@ static inline int debugger_fault_handler(struct pt_regs *regs) { return 0; }
> extern int set_dabr(unsigned long dabr);
> extern void do_dabr(struct pt_regs *regs, unsigned long address,
> 		    unsigned long error_code);
>+extern void do_send_trap(struct pt_regs *regs, unsigned long address,
>+			 unsigned long error_code, int signal_code, int errno);
> extern void print_backtrace(unsigned long *);
> extern void show_regs(struct pt_regs * regs);
> extern void flush_instruction_cache(void);
>diff --git a/arch/powerpc/kernel/process.c b/arch/powerpc/kernel/process.c
>index c930ac3..a0dbb09 100644
>--- a/arch/powerpc/kernel/process.c
>+++ b/arch/powerpc/kernel/process.c
>@@ -245,6 +245,24 @@ void discard_lazy_cpu_state(void)
> }
> #endif /* CONFIG_SMP */
>
>+void do_send_trap(struct pt_regs *regs, unsigned long address,
>+		  unsigned long error_code, int signal_code, int errno)
>+{
>+	siginfo_t info;
>+
>+	if (notify_die(DIE_DABR_MATCH, "dabr_match", regs, error_code,
>+			11, SIGSEGV) == NOTIFY_STOP)
>+		return;
>+
>+	/* Deliver the signal to userspace */
>+	info.si_signo = SIGTRAP;
>+	info.si_errno = errno;
>+	info.si_code = signal_code;
>+	info.si_addr = (void __user *)address;
>+	force_sig_info(SIGTRAP, &info, current);
>+}
>+
>+#if !(defined(CONFIG_40x) || defined(CONFIG_BOOKE))
> void do_dabr(struct pt_regs *regs, unsigned long address,
> 		    unsigned long error_code)
> {
>@@ -257,12 +275,6 @@ void do_dabr(struct pt_regs *regs, unsigned long address,
> 	if (debugger_dabr_match(regs))
> 		return;
>
>-	/* Clear the DAC and struct entries.  One shot trigger */
>-#if defined(CONFIG_BOOKE)
>-	mtspr(SPRN_DBCR0, mfspr(SPRN_DBCR0) & ~(DBSR_DAC1R | DBSR_DAC1W
>-							| DBCR0_IDM));
>-#endif
>-
> 	/* Clear the DABR */
> 	set_dabr(0);
>
>@@ -273,9 +285,71 @@ void do_dabr(struct pt_regs *regs, unsigned long address,
> 	info.si_addr = (void __user *)address;
> 	force_sig_info(SIGTRAP, &info, current);
> }
>+#endif
>
> static DEFINE_PER_CPU(unsigned long, current_dabr);
>
>+#if defined(CONFIG_BOOKE) || defined(CONFIG_40x)
>+/*
>+ * Set the debug registers back to their default "safe" values.
>+ */
>+static void set_debug_reg_defaults(struct thread_struct *thread)
>+{
>+	thread->iac1 = thread->iac2 = thread->iac3 = thread->iac4 = 0;
>+	thread->dac1 = thread->dac2 = 0;
>+	thread->dvc1 = thread->dvc2 = 0;
>+	/*
>+	 * reset the DBCR0, DBCR1 and DBCR2 registers. All bits with
>+	 * the exception of the reserved bits should be cleared out
>+	 * and set to 0.
>+	 *
>+	 * For the DBCR0 register, the reserved bits are bits 17:30.
>+	 * Reserved bits for DBCR1 are bits 10:14 and bits 26:30.
>+	 * And, bits 10:11 for DBCR2.
>+	 */
>+	thread->dbcr0 = DBCR0_BASE_REG_VALUE;
>+	/*
>+	 * First clear all "non reserved" bits from DBCR1 then initialize reg
>+	 * to force User/Supervisor bits to b11 (user-only MSR[PR]=1) and
>+	 * Effective/Real * bits to b10 (trap only if IS==0)
>+	 */
>+	thread->dbcr1 = DBCR1_BASE_REG_VALUE;
>+	/*
>+	 * Force Data Address Compare User/Supervisor bits to be User-only
>+	 * (0b11 MSR[PR]=1) and set all other bits in DBCR2 register to be 0.
>+	 * This sets the Data Address Compare Effective/Real bits to be 0b00
>+	 * (Effective, MSR[DS]=don't care).
>+	 */
>+	thread->dbcr2 = DBCR2_BASE_REG_VALUE;
>+}
>+
>+static void prime_debug_regs(struct thread_struct *thread)
>+{
>+	mtspr(SPRN_IAC1, thread->iac1);
>+	mtspr(SPRN_IAC2, thread->iac2);
>+	mtspr(SPRN_IAC3, thread->iac3);
>+	mtspr(SPRN_IAC4, thread->iac4);
>+	mtspr(SPRN_DAC1, thread->dac1);
>+	mtspr(SPRN_DAC2, thread->dac2);
>+	mtspr(SPRN_DVC1, thread->dvc1);
>+	mtspr(SPRN_DVC2, thread->dvc2);
>+	mtspr(SPRN_DBCR0, thread->dbcr0);
>+	mtspr(SPRN_DBCR1, thread->dbcr1);
>+	mtspr(SPRN_DBCR2, thread->dbcr2);

405 has no DBCR2, so I doubt setting it via mtspr would be good.  Does this
compile for 40x and did you test it at all?

Also, looking at the current kernel it seems SPRN_DBCR2 is only defined for
CONFIG_PPC_BOOK3E_64 which is also inaccurate.  I don't see that fixed in any
of the other patches.  Are you missing a patch, or was this generated against
and old kernel or something?

>@@ -514,7 +586,7 @@ void show_regs(struct pt_regs * regs)
> 	printk("  CR: %08lx  XER: %08lx\n", regs->ccr, regs->xer);
> 	trap = TRAP(regs);
> 	if (trap == 0x300 || trap == 0x600)
>-#if defined(CONFIG_4xx) || defined(CONFIG_BOOKE)
>+#if defined(CONFIG_BOOKE) || defined(CONFIG_40x)
> 		printk("DEAR: "REG", ESR: "REG"\n", regs->dar, regs->dsisr);
> #else
> 		printk("DAR: "REG", DSISR: "REG"\n", regs->dar, regs->dsisr);

This hunk seems unnecessary.

I need to find some time to sit down and look over the rest still.  I do have
some questions on how/if this will interact correctly with an older GDB still,
and some of the things I've pointed out make me wonder how much this has all
been tested and on what platforms.

josh

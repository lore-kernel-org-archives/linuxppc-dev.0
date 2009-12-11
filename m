Return-Path: <dwg@au1.ibm.com>
Date: Fri, 11 Dec 2009 14:26:26 +1100
From: David Gibson <dwg@au1.ibm.com>
To: Dave Kleikamp <shaggy@linux.vnet.ibm.com>
Subject: Re: [RFC:PATCH 03/03] powerpc: Add support for BookE Debug Reg.
	traps, exceptions and ptrace
Message-ID: <20091211032626.GC8852@yookeroo>
References: <20091210155709.6697.4635.sendpatchset@norville.austin.ibm.com>
	<20091210155727.6697.74672.sendpatchset@norville.austin.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20091210155727.6697.74672.sendpatchset@norville.austin.ibm.com>
Cc: linuxppc-dev list <Linuxppc-dev@ozlabs.org>,
	Sergio Durigan Junior <sergiodj@br.ibm.com>,
	Torez Smith <torez@us.ibm.com>, Thiago Jung Bauermann <bauerman@br.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Dec 10, 2009 at 01:57:27PM -0200, Dave Kleikamp wrote:
> powerpc: Add support for BookE Debug Reg. traps, exceptions and ptrace
>=20
> From: Torez Smith <lnxtorez@linux.vnet.ibm.com>
>=20
> This patch defines context switch and trap related functionality
> for BookE specific Debug Registers. It adds support to ptrace()
> for setting and getting BookE related Debug Registers
>=20
> Signed-off-by: Torez Smith  <lnxtorez@linux.vnet.ibm.com>
> Signed-off-by: Dave Kleikamp <shaggy@linux.vnet.ibm.com>
> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Cc: Thiago Jung Bauermann <bauerman@br.ibm.com>
> Cc: Sergio Durigan Junior <sergiodj@br.ibm.com>
> Cc: David Gibson <dwg@au1.ibm.com>
> Cc: linuxppc-dev list <Linuxppc-dev@ozlabs.org>
> ---
>=20
>  arch/powerpc/include/asm/system.h |    2=20
>  arch/powerpc/kernel/process.c     |  109 ++++++++-
>  arch/powerpc/kernel/ptrace.c      |  435 +++++++++++++++++++++++++++++++=
+++---
>  arch/powerpc/kernel/signal.c      |    6 -
>  arch/powerpc/kernel/signal_32.c   |    8 +
>  arch/powerpc/kernel/traps.c       |   86 ++++++-
>  6 files changed, 564 insertions(+), 82 deletions(-)

[snip]
> +void do_send_trap(struct pt_regs *regs, unsigned long address,
> +		  unsigned long error_code, int signal_code, int errno)
> +{
> +	siginfo_t info;
> +
> +	if (notify_die(DIE_DABR_MATCH, "dabr_match", regs, error_code,
> +			11, SIGSEGV) =3D=3D NOTIFY_STOP)
> +		return;
> +
> +	/* Deliver the signal to userspace */
> +	info.si_signo =3D SIGTRAP;
> +	info.si_errno =3D errno;

We're using the errno siginfo field, but not for an errno, so possibly
the parameter should be called something else.

[snip]
> +#if !(defined(CONFIG_40x) || defined(CONFIG_BOOKE))
>  void do_dabr(struct pt_regs *regs, unsigned long address,
>  		    unsigned long error_code)
>  {
> @@ -257,12 +275,6 @@ void do_dabr(struct pt_regs *regs, unsigned long add=
ress,
>  	if (debugger_dabr_match(regs))
>  		return;
> =20
> -	/* Clear the DAC and struct entries.  One shot trigger */
> -#if defined(CONFIG_BOOKE)
> -	mtspr(SPRN_DBCR0, mfspr(SPRN_DBCR0) & ~(DBSR_DAC1R | DBSR_DAC1W
> -							| DBCR0_IDM));
> -#endif
> -
>  	/* Clear the DABR */
>  	set_dabr(0);

Uh.. does this imply we're keeping the one-shot behaviour for
new-style breakpoints?  To me the interface really suggests they're
persistent, although dealing with the semantics of that at signal time
can get curly.

> =20
> @@ -273,9 +285,71 @@ void do_dabr(struct pt_regs *regs, unsigned long add=
ress,
>  	info.si_addr =3D (void __user *)address;
>  	force_sig_info(SIGTRAP, &info, current);
>  }
> +#endif
> =20
>  static DEFINE_PER_CPU(unsigned long, current_dabr);
> =20
> +#if defined(CONFIG_BOOKE) || defined(CONFIG_40x)
> +/*
> + * Set the debug registers back to their default "safe" values.
> + */
> +static void set_debug_reg_defaults(struct thread_struct *thread)
> +{
> +	thread->iac1 =3D thread->iac2 =3D thread->iac3 =3D thread->iac4 =3D 0;
> +	thread->dac1 =3D thread->dac2 =3D 0;
> +	thread->dvc1 =3D thread->dvc2 =3D 0;
> +	/*
> +	 * reset the DBCR0, DBCR1 and DBCR2 registers. All bits with
> +	 * the exception of the reserved bits should be cleared out
> +	 * and set to 0.
> +	 *
> +	 * For the DBCR0 register, the reserved bits are bits 17:30.
> +	 * Reserved bits for DBCR1 are bits 10:14 and bits 26:30.
> +	 * And, bits 10:11 for DBCR2.
> +	 */
> +	thread->dbcr0 =3D DBCR0_BASE_REG_VALUE;

Since this is now the only place it's used, I'd pull the
BASE_REG_VALUE constant inline here.  Makes the actual definition sit
next to the describing comment which is a bonus.

> +	/*
> +	 * First clear all "non reserved" bits from DBCR1 then initialize reg
> +	 * to force User/Supervisor bits to b11 (user-only MSR[PR]=3D1) and
> +	 * Effective/Real * bits to b10 (trap only if IS=3D=3D0)
> +	 */
> +	thread->dbcr1 =3D DBCR1_BASE_REG_VALUE;
> +	/*
> +	 * Force Data Address Compare User/Supervisor bits to be User-only
> +	 * (0b11 MSR[PR]=3D1) and set all other bits in DBCR2 register to be 0.
> +	 * This sets the Data Address Compare Effective/Real bits to be 0b00
> +	 * (Effective, MSR[DS]=3Ddon't care).
> +	 */
> +	thread->dbcr2 =3D DBCR2_BASE_REG_VALUE;
> +}
> +
> +static void prime_debug_regs(struct thread_struct *thread)
> +{
> +	mtspr(SPRN_IAC1, thread->iac1);
> +	mtspr(SPRN_IAC2, thread->iac2);
> +	mtspr(SPRN_IAC3, thread->iac3);
> +	mtspr(SPRN_IAC4, thread->iac4);
> +	mtspr(SPRN_DAC1, thread->dac1);
> +	mtspr(SPRN_DAC2, thread->dac2);
> +	mtspr(SPRN_DVC1, thread->dvc1);
> +	mtspr(SPRN_DVC2, thread->dvc2);
> +	mtspr(SPRN_DBCR0, thread->dbcr0);
> +	mtspr(SPRN_DBCR1, thread->dbcr1);
> +	mtspr(SPRN_DBCR2, thread->dbcr2);

As Josh pointed out, you'll need to be a little more careful here to
only mtspr() registers which actually exist on the current platform.
We may be better off only implementing the new interface for BookE in
the first cut.

> +}
> +/*
> + * Unless neither the old or new thread are making use of the
> + * debug registers, set the debug registers from the values
> + * stored in the new thread.
> + */
> +static void switch_booke_debug_regs(struct thread_struct *new_thread)
> +{
> +	if ((current->thread.dbcr0 & DBCR0_IDM)
> +		|| (new_thread->dbcr0 & DBCR0_IDM))
> +			prime_debug_regs(new_thread);
> +}
> +#endif
> +
>  int set_dabr(unsigned long dabr)
>  {
>  	__get_cpu_var(current_dabr) =3D dabr;
> @@ -284,7 +358,7 @@ int set_dabr(unsigned long dabr)
>  		return ppc_md.set_dabr(dabr);
> =20
>  	/* XXX should we have a CPU_FTR_HAS_DABR ? */
> -#if defined(CONFIG_BOOKE)
> +#if defined(CONFIG_BOOKE) || defined(CONFIG_40x)
>  	mtspr(SPRN_DAC1, dabr);

Uh.. this would seem to be wrong.  set_dabr(0) is called from the
debug exception - but nowadays that could be tiggered by a DAC other
than DAC1.

>  #elif defined(CONFIG_PPC_BOOK3S)
>  	mtspr(SPRN_DABR, dabr);
> @@ -371,10 +445,8 @@ struct task_struct *__switch_to(struct task_struct *=
prev,
> =20
>  #endif /* CONFIG_SMP */
> =20
> -#if defined(CONFIG_BOOKE)
> -	/* If new thread DAC (HW breakpoint) is the same then leave it */
> -	if (new->thread.dabr)
> -		set_dabr(new->thread.dabr);
> +#if defined(CONFIG_BOOKE) || defined(CONFIG_40x)
> +	switch_booke_debug_regs(&new->thread);
>  #else
>  	if (unlikely(__get_cpu_var(current_dabr) !=3D new->thread.dabr))
>  		set_dabr(new->thread.dabr);
> @@ -514,7 +586,7 @@ void show_regs(struct pt_regs * regs)
>  	printk("  CR: %08lx  XER: %08lx\n", regs->ccr, regs->xer);
>  	trap =3D TRAP(regs);
>  	if (trap =3D=3D 0x300 || trap =3D=3D 0x600)
> -#if defined(CONFIG_4xx) || defined(CONFIG_BOOKE)
> +#if defined(CONFIG_BOOKE) || defined(CONFIG_40x)
>  		printk("DEAR: "REG", ESR: "REG"\n", regs->dar, regs->dsisr);
>  #else
>  		printk("DAR: "REG", DSISR: "REG"\n", regs->dar, regs->dsisr);
> @@ -568,14 +640,19 @@ void flush_thread(void)
> =20
>  	discard_lazy_cpu_state();
> =20
> +#if defined(CONFIG_BOOKE) || defined(CONFIG_40x)
> +	/*
> +	 * flush_thread() is called on exec() to reset the
> +	 * thread's status. Set all debug regs back to their
> +	 * default values....Torez
> +	 */
> +	set_debug_reg_defaults(&current->thread);

Better to define this function as a nop on non-BookE.

[snip]
> +#else
>  	/* As described above, it was assumed 3 bits were passed with the data
>  	 *  address, but we will assume only the mode bits will be passed
>  	 *  as to not cause alignment restrictions for DAC-based processors.
>  	 */
> =20
>  	/* DAC's hold the whole address without any mode flags */
> -	task->thread.dabr =3D data & ~0x3UL;
> -
> -	if (task->thread.dabr =3D=3D 0) {
> -		task->thread.dbcr0 &=3D ~(DBSR_DAC1R | DBSR_DAC1W | DBCR0_IDM);
> -		task->thread.regs->msr &=3D ~MSR_DE;
> +	task->thread.dac1 =3D data & ~0x3UL;
> +
> +	if (task->thread.dac1 =3D=3D 0) {
> +		dbcr_dac(task) &=3D ~(DBCR_DAC1R | DBCR_DAC1W);
> +		if (!DBCR_ACTIVE_EVENTS(task->thread.dbcr0,
> +					task->thread.dbcr1)) {
> +			task->thread.regs->msr &=3D ~MSR_DE;
> +			task->thread.dbcr0 &=3D ~DBCR0_IDM;
> +		}
>  		return 0;
>  	}

Ok, so effectively the old ptrace method of setting the DABR acts as a
bypass to set DAC1, rather than having the old interface being
implemented via the new interface.  This has some weirdness - you can
clobber a new-style breakpoint in DAC1 using the old interface, for
example.  Still, it might be the simplest approach for a first cut.

What *is* a problem though, is that this means that the SIGTRAP will
always give a slot number, even for a breakpoint established using the
old interface.  Part of the idea of encoding the registered breakpoint
number in the siginfo was to be able to distinguish between old-style
and new-style breakpoints at trap time.

[snip]
> +#if defined(CONFIG_40x) || defined(CONFIG_BOOKE)
> +static long set_intruction_bp(struct task_struct *child,
> +			      struct ppc_hw_breakpoint *bp_info)
> +{
> +	int slots_needed;
> +	int slot;
> +	int free_slot =3D 0;
> +
> +	/*
> +	 * Find an avalailable slot for the breakpoint.
> +	 * If possible, reserve consecutive slots, 1 & 2, for a range
> +	 * breakpoint.  (Can this be done simpler?)
> +	 */
> +	if (bp_info->addr_mode =3D=3D PPC_BREAKPOINT_MODE_EXACT)
> +		slots_needed =3D 1;
> +	else
> +		slots_needed =3D 2;

Ugh.  This logic is pretty hard to follow.  I'm having trouble
convincing myself it gets all the cases right, although I haven't
found something definitely wrong.

> +	if ((child->thread.dbcr0 & DBCR0_IAC1) =3D=3D 0) {
> +		if (slots_needed =3D=3D 1) {
> +			if (child->thread.dbcr0 & DBCR0_IAC2) {
> +				slot =3D 1;
> +				goto found;
> +			}
> +			/* Try to save slots 1 & 2 for range */
> +			free_slot =3D 1;
> +		} else
> +			if ((child->thread.dbcr0 & DBCR0_IAC2) =3D=3D 0) {
> +				slot =3D 1;
> +				goto found;
> +			}
> +	} else if ((slots_needed =3D=3D 1) &&
> +		   ((child->thread.dbcr0 & DBCR0_IAC2) =3D=3D 0)) {
> +		slot =3D 2;
> +		goto found;
> +	}
> +	if ((child->thread.dbcr0 & DBCR0_IAC3) =3D=3D 0) {
> +		if (slots_needed =3D=3D 1) {
> +			slot =3D 3;
> +			goto found;
> +		}
> +		if ((child->thread.dbcr0 & DBCR0_IAC4) =3D=3D 0) {
> +			slot =3D 3;
> +			goto found;
> +		}
> +		return -ENOSPC;
> +	} else if (slots_needed =3D=3D 2)
> +		return -ENOSPC;
> +	if ((child->thread.dbcr0 & DBCR0_IAC4) =3D=3D 0) {
> +		slot =3D 4;
> +	} else if (free_slot)
> +		slot =3D free_slot;
> +	else
> +		return -ENOSPC;
> +found:
> +	if (bp_info->addr_mode =3D=3D PPC_BREAKPOINT_MODE_EXACT) {
> +		switch (slot) {
> +			case 1:
> +				child->thread.iac1 =3D bp_info->addr;
> +				child->thread.dbcr0 |=3D DBCR0_IAC1;
> +				break;
> +			case 2:
> +				child->thread.iac2 =3D bp_info->addr;
> +				child->thread.dbcr0 |=3D DBCR0_IAC2;
> +				break;
> +			case 3:
> +				child->thread.iac3 =3D bp_info->addr;
> +				child->thread.dbcr0 |=3D DBCR0_IAC3;
> +				break;
> +			case 4:
> +				child->thread.iac4 =3D bp_info->addr;
> +				child->thread.dbcr0 |=3D DBCR0_IAC4;
> +				break;

By using an array instead of individual iac1..4 in the thread struct,
plus a suitable macro to generate the right bit, you could get rid of
this nasty switch.

> +		}
> +	} else if (slot =3D=3D 1) {
> +		child->thread.iac1 =3D bp_info->addr;
> +		child->thread.iac2 =3D bp_info->addr2;

You test that addr is a user address in the caller, but I don't think
you ever check addr2.

> +		child->thread.dbcr0 |=3D (DBCR0_IAC1 | DBCR0_IAC2);

Uh.. I thought for range breakpoints you only needed to enable the bit
for the first of the two IACs (plus the range enable bit, of course).

> +		if (bp_info->addr_mode =3D=3D PPC_BREAKPOINT_MODE_RANGE_EXCLUSIVE)
> +			dbcr_iac_range(child) |=3D DBCR_IAC12M_X;
> +		else
> +			dbcr_iac_range(child) |=3D DBCR_IAC12M_I;
> +	} else { /* slot =3D=3D 3 */
> +		child->thread.iac3 =3D bp_info->addr;
> +		child->thread.iac4 =3D bp_info->addr2;
> +		child->thread.dbcr0 |=3D (DBCR0_IAC3 | DBCR0_IAC4);
> +		if (bp_info->addr_mode =3D=3D PPC_BREAKPOINT_MODE_RANGE_EXCLUSIVE)
> +			dbcr_iac_range(child) |=3D DBCR_IAC34M_X;
> +		else
> +			dbcr_iac_range(child) |=3D DBCR_IAC34M_I;
> +	}
> +	child->thread.dbcr0 |=3D DBCR0_IDM;
> +	child->thread.regs->msr |=3D MSR_DE;
> +
> +	return slot;

Yeah, ok.  I think the idea of using the register number as the
breakpoint identifier is limiting and we'll need to do something else
eventually.  Nonetheless, since userspace should be treating it as
opaque, it will do for a first cut and we can rework this later.

> +}
> +
> +static int del_instruction_bp(struct task_struct *child, int slot)
> +{
> +	switch (slot) {
> +	case 1:
> +		if (dbcr_iac_range(child) & DBCR_IAC12M) {
> +			/* address range - clear slots 1 & 2 */
> +			child->thread.iac2 =3D 0;
> +			child->thread.dbcr0 &=3D ~DBCR0_IAC2;
> +			dbcr_iac_range(child) &=3D ~DBCR_IAC12M;
> +		}
> +		child->thread.iac1 =3D 0;
> +		child->thread.dbcr0 &=3D ~DBCR0_IAC1;
> +		break;

Uh.. as far as I can tell, you won't return an error if you try to
clear a breakpoint from a slot that isn't used.  That seems like
incorrect behaviour.

> +	case 2:
> +		if (dbcr_iac_range(child) & DBCR_IAC12M)
> +			/* used in a range */
> +			return -EINVAL;
> +		child->thread.iac2 =3D 0;
> +		child->thread.dbcr0 &=3D ~DBCR0_IAC2;
> +		break;
> +	case 3:
> +		if (dbcr_iac_range(child) & DBCR_IAC34M) {
> +			/* address range - clear slots 3 & 4 */
> +			child->thread.iac4 =3D 0;
> +			child->thread.dbcr0 &=3D ~DBCR0_IAC4;
> +			dbcr_iac_range(child) &=3D ~DBCR_IAC34M;
> +		}
> +		child->thread.iac3 =3D 0;
> +		child->thread.dbcr0 &=3D ~DBCR0_IAC3;
> +		break;
> +	case 4:
> +		if (dbcr_iac_range(child) & DBCR_IAC34M)
> +			/* Used in a range */
> +			return -EINVAL;
> +		child->thread.iac4 =3D 0;
> +		child->thread.dbcr0 &=3D ~DBCR0_IAC4;
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +	return 0;
> +}
> +
> +static int set_dac(struct task_struct *child, struct ppc_hw_breakpoint *=
bp_info)
> +{
> +	int byte_enable =3D
> +		(bp_info->condition_mode >> PPC_BREAKPOINT_CONDITION_BE_SHIFT)
> +		& 0xf;
> +	int condition_mode =3D
> +		bp_info->condition_mode & PPC_BREAKPOINT_CONDITION_AND_OR;

Using the fact that AND_OR is also equal to a suitable mask is a bit
overly subtle.  Better to use a separately defined mask constant.

> +	int slot;
> +
> +	if (byte_enable && (condition_mode =3D=3D 0))
> +		return -EINVAL;
> +
> +	if (bp_info->addr >=3D TASK_SIZE)
> +		return -EIO;
> +
> +	if ((dbcr_dac(child) & (DBCR_DAC1R | DBCR_DAC1W)) =3D=3D 0) {
> +		if (bp_info->trigger_type & PPC_BREAKPOINT_TRIGGER_READ)
> +			dbcr_dac(child) |=3D DBCR_DAC1R;
> +		if (bp_info->trigger_type & PPC_BREAKPOINT_TRIGGER_WRITE)
> +			dbcr_dac(child) |=3D DBCR_DAC1W;
> +		child->thread.dac1 =3D (unsigned long)bp_info->addr;
> +#ifdef CONFIG_BOOKE

Better to have a runtime feature bit test here, than use an #ifdef to
distinguish the 40x and BookE cases.  Plus, you should return an error
if the user attempts to use a feature not supported on this hardware,
which doesn't seem to happen here.

=18[snip]
> +static int del_dac(struct task_struct *child, int slot)
> +{

Again, you never seem to generate an error if you attempt to delete a
watchpoint that was never set.

> +	if (slot =3D=3D 1) {
> +#ifdef CONFIG_BOOKE
> +		if (child->thread.dbcr2 & DBCR2_DAC12MODE) {
> +			child->thread.dac1 =3D 0;
> +			child->thread.dac2 =3D 0;
> +			child->thread.dbcr0 &=3D ~(DBCR0_DAC1R | DBCR0_DAC1W |
> +						 DBCR0_DAC2R | DBCR0_DAC2W);
> +			child->thread.dbcr2 &=3D ~DBCR2_DAC12MODE;
> +			return 0;
> +		}
> +		child->thread.dbcr2 &=3D ~(DBCR2_DVC1M | DBCR2_DVC1BE);
> +		child->thread.dvc1 =3D 0;

Since this will just clear fields which are never used on 40x, you
shouldn't need the ifdef.

> +#endif
> +		child->thread.dac1 =3D 0;
> +		dbcr_dac(child) &=3D ~(DBCR_DAC1R | DBCR_DAC1W);
> +	} else if (slot =3D=3D 2) {
> +#ifdef CONFIG_BOOKE
> +		if (child->thread.dbcr2 & DBCR2_DAC12MODE)
> +			/* Part of a range */
> +			return -EINVAL;
> +		child->thread.dbcr2 &=3D ~(DBCR2_DVC2M | DBCR2_DVC2BE);
> +		child->thread.dvc2 =3D 0;
> +#endif
> +		child->thread.dac2 =3D 0;
> +		dbcr_dac(child) &=3D ~(DBCR_DAC2R | DBCR_DAC2W);
> +	} else
> +		return -EINVAL;
> +
> +	return 0;
> +}
> +#endif /* CONFIG_40x || CONFIG_BOOKE */
> +
> +#ifdef CONFIG_BOOKE
> +static int set_dac_range(struct task_struct *child,
> +			 struct ppc_hw_breakpoint *bp_info)
> +{
> +	int mode =3D bp_info->addr_mode & PPC_BREAKPOINT_MODE_MASK;
> +
> +	/* We don't allow range watchpoints to be used with DVC */
> +	if (bp_info->condition_mode && PPC_BREAKPOINT_CONDITION_BE_ALL)

Uh.. that condition really doesn't look right.  First, surely it
should be a bitwise, not a logical and, second the comment is talking
about range watchpoints, but the condition is about the byte enable
bits.

> +		return -EINVAL;
> +
> +	if (bp_info->addr >=3D TASK_SIZE)
> +		return -EIO;
> +
> +	if (child->thread.dbcr0 &
> +	    (DBCR0_DAC1R | DBCR0_DAC1W | DBCR0_DAC2R | DBCR0_DAC2W))
> +		return -ENOSPC;
> +
> +	if (bp_info->trigger_type & PPC_BREAKPOINT_TRIGGER_READ)
> +		child->thread.dbcr0 |=3D (DBCR0_DAC1R | DBCR0_DAC2R | DBCR0_IDM);
> +	if (bp_info->trigger_type & PPC_BREAKPOINT_TRIGGER_WRITE)
> +		child->thread.dbcr0 |=3D (DBCR0_DAC1W | DBCR0_DAC2W | DBCR0_IDM);

Again, I thought only the DAC1 R/W bits were used for range watchpoints.

> +	child->thread.dac1 =3D bp_info->addr;
> +	child->thread.dac2 =3D bp_info->addr2;
> +	if (mode =3D=3D PPC_BREAKPOINT_MODE_RANGE_INCLUSIVE)
> +		child->thread.dbcr2  |=3D DBCR2_DAC12R;
> +	else if (mode =3D=3D PPC_BREAKPOINT_MODE_RANGE_EXCLUSIVE)
> +		child->thread.dbcr2  |=3D DBCR2_DAC12RX;
> +	else	/* PPC_BREAKPOINT_MODE_MASK */
> +		child->thread.dbcr2  |=3D DBCR2_DAC12MASK;
> +	child->thread.regs->msr |=3D MSR_DE;
> +
> +	return 5;
> +}
> +#endif /* CONFIG_BOOKE */
> +
>  static long ppc_set_hwdebug(struct task_struct *child,
>  		     struct ppc_hw_breakpoint *bp_info)
>  {
> +	if (bp_info->version !=3D 1)
> +		return -ENOTSUPP;
> +
> +#ifdef CONFIG_BOOKE
> +	/*
> +	 * Check for invalid flags and combinations
> +	 */
> +	if ((bp_info->trigger_type =3D=3D 0) ||
> +	    (bp_info->trigger_type & ~(PPC_BREAKPOINT_TRIGGER_EXECUTE |
> +				       PPC_BREAKPOINT_TRIGGER_RW)) ||
> +	    (bp_info->addr_mode & ~PPC_BREAKPOINT_MODE_MASK) ||
> +	    (bp_info->condition_mode &
> +	     ~(PPC_BREAKPOINT_CONDITION_AND_OR |
> +	       PPC_BREAKPOINT_CONDITION_BE_ALL)))
> +		return -EINVAL;
> +
> +	if (bp_info->trigger_type & PPC_BREAKPOINT_TRIGGER_EXECUTE) {
> +		if (bp_info->trigger_type !=3D PPC_BREAKPOINT_TRIGGER_EXECUTE)
> +			/* At least another bit was set */
> +			return -EINVAL;
> +		return set_intruction_bp(child, bp_info);
> +	}
> +
> +	if (bp_info->addr_mode =3D=3D PPC_BREAKPOINT_MODE_EXACT)
> +		return set_dac(child, bp_info);
> +
> +	return set_dac_range(child, bp_info);
> +#elif defined(CONFIG_40x)
> +	/*
> +	 * Check for invalid flags and combinations
> +	 */
> +	if ((bp_info->trigger_type =3D=3D 0) ||
> +	    (bp_info->trigger_type & ~(PPC_BREAKPOINT_TRIGGER_EXECUTE |
> +				       PPC_BREAKPOINT_TRIGGER_RW)) ||
> +	    (bp_info->addr_mode & ~PPC_BREAKPOINT_MODE_MASK) ||
> +	    (bp_info->condition_mode !=3D PPC_BREAKPOINT_CONDITION_NONE))
> +		return -EINVAL;
> +
> +	if (bp_info->trigger_type & PPC_BREAKPOINT_TRIGGER_EXECUTE) {
> +		if (bp_info->trigger_type !=3D PPC_BREAKPOINT_TRIGGER_EXECUTE)
> +			/* At least another bit was set */
> +			return -EINVAL;
> +		return set_intruction_bp(child, bp_info);
> +	}
> +	if (bp_info->addr_mode !=3D PPC_BREAKPOINT_MODE_EXACT)
> +		return -EINVAL;
> +
> +	return set_dac(child, bp_info);
> +#else
>  	/*
> -	 * We currently support one data breakpoint
> +	 * We only support one data breakpoint

Uh.. you've updated this comment to something which is still wrong
with the new code...

[snip]
> @@ -980,16 +1308,36 @@ long arch_ptrace(struct task_struct *child, long r=
equest, long addr, long data)
>  		struct ppc_debug_info dbginfo;
> =20
>  		dbginfo.version =3D 1;
> +#ifdef CONFIG_BOOKE
> +		dbginfo.num_instruction_bps =3D 4;
> +		dbginfo.num_data_bps =3D 2;
> +		dbginfo.num_condition_regs =3D 2;
> +		dbginfo.data_bp_alignment =3D 0;

Surely that can't be right, I thought there was always a data bp
alignment constraint.

> +		dbginfo.sizeof_condition =3D 4;
> +		dbginfo.features =3D PPC_DEBUG_FEATURE_INSN_BP_RANGE |
> +				   PPC_DEBUG_FEATURE_INSN_BP_MASK |
> +				   PPC_DEBUG_FEATURE_DATA_BP_RANGE |
> +				   PPC_DEBUG_FEATURE_DATA_BP_MASK;
> +#elif defined(CONFIG_40x)
> +		/*
> +		 * I don't know how the DVCs work on 40x, I'm not going
> +		 * to support it now. -- Shaggy
> +		 */
> +		dbginfo.num_instruction_bps =3D 4;
> +		dbginfo.num_data_bps =3D 2;
> +		dbginfo.num_condition_regs =3D 0;
> +		dbginfo.data_bp_alignment =3D 0;
> +		dbginfo.sizeof_condition =3D 0;
> +		dbginfo.features =3D PPC_DEBUG_FEATURE_INSN_BP_RANGE |
> +				   PPC_DEBUG_FEATURE_INSN_BP_MASK;
> +#else
>  		dbginfo.num_instruction_bps =3D 0;
>  		dbginfo.num_data_bps =3D 1;
>  		dbginfo.num_condition_regs =3D 0;
> -#ifdef CONFIG_PPC64
>  		dbginfo.data_bp_alignment =3D 8;

Uh, this isn't quite right.  32-bit classic PPC can have DABRs, so
!CONFIG_PPC64 does not imply 40x|BOOKE, which means we still need the
32-bit case here.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

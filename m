Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vD0P40J3wzDqF3
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  1 Feb 2017 21:54:00 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Anju T Sudhakar <anju@linux.vnet.ibm.com>, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org
Cc: ananth@in.ibm.com, naveen.n.rao@linux.vnet.ibm.com, paulus@samba.org,
 srikar@linux.vnet.ibm.com, benh@kernel.crashing.org, mahesh@linux.vnet.ibm.com,
 mhiramat@kernel.org, anju@linux.vnet.ibm.com
Subject: Re: [PATCH V3 3/4] arch/powerpc: Implement Optprobes
In-Reply-To: <1482153507-17350-2-git-send-email-anju@linux.vnet.ibm.com>
References: <1482153507-17350-1-git-send-email-anju@linux.vnet.ibm.com>
 <1482153507-17350-2-git-send-email-anju@linux.vnet.ibm.com>
Date: Wed, 01 Feb 2017 21:53:43 +1100
Message-ID: <87a8a6dvwo.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Anju T Sudhakar <anju@linux.vnet.ibm.com> writes:

> Detour buffer contains instructions to create an in memory pt_regs.
> After the execution of the pre-handler, a call is made for instruction emulation.
> The NIP is determined in advanced through dummy instruction emulation and a branch
> instruction is created to the NIP at the end of the trampoline.

That's good detail, but it's hard to follow for someone who isn't
familiar with with kprobes/optprobes etc. You don't even tell us what an
optprobe is :)

So can you provide a bit more background before diving into the specific
details.

> Instruction slot for detour buffer is allocated from the reserved area.
> For the time being, 64KB is reserved in memory for this purpose.
>
> Instructions which can be emulated using analyse_instr() are suppliants
                                                               ^
                                                               candidates ?
                                                               
> diff --git a/Documentation/features/debug/optprobes/arch-support.txt b/Documentation/features/debug/optprobes/arch-support.txt
> index b8999d8..45bc99d 100644
> --- a/Documentation/features/debug/optprobes/arch-support.txt
> +++ b/Documentation/features/debug/optprobes/arch-support.txt
> @@ -27,7 +27,7 @@
>      |       nios2: | TODO |
>      |    openrisc: | TODO |
>      |      parisc: | TODO |
> -    |     powerpc: | TODO |
> +    |     powerpc: |  ok  |

We don't support them for modules yet, so maybe it's premature to flip
that?

> diff --git a/arch/powerpc/kernel/optprobes.c b/arch/powerpc/kernel/optprobes.c
> new file mode 100644
> index 0000000..fb5e62d
> --- /dev/null
> +++ b/arch/powerpc/kernel/optprobes.c
> @@ -0,0 +1,331 @@
> +/*
> + * Code for Kernel probes Jump optimization.
> + *
> + * Copyright 2016, Anju T, IBM Corp.
> + *
> + * This program is free software; you can redistribute it and/or
> + * modify it under the terms of the GNU General Public License
> + * as published by the Free Software Foundation; either version
> + * 2 of the License, or (at your option) any later version.
> + */
> +
> +#include <linux/kprobes.h>
> +#include <linux/jump_label.h>
> +#include <linux/types.h>
> +#include <linux/slab.h>
> +#include <linux/list.h>
> +#include <asm/kprobes.h>
> +#include <asm/ptrace.h>
> +#include <asm/cacheflush.h>
> +#include <asm/code-patching.h>
> +#include <asm/sstep.h>
> +#include <asm/ppc-opcode.h>
> +
> +#define TMPL_CALL_HDLR_IDX	\
> +	(optprobe_template_call_handler - optprobe_template_entry)
> +#define TMPL_EMULATE_IDX	\
> +	(optprobe_template_call_emulate - optprobe_template_entry)
> +#define TMPL_RET_IDX		\
> +	(optprobe_template_ret - optprobe_template_entry)
> +#define TMPL_OP_IDX		\
> +	(optprobe_template_op_address - optprobe_template_entry)
> +#define TMPL_INSN_IDX		\
> +	(optprobe_template_insn - optprobe_template_entry)
> +#define TMPL_END_IDX		\
> +	(optprobe_template_end - optprobe_template_entry)
> +
> +DEFINE_INSN_CACHE_OPS(ppc_optinsn);
> +
> +static bool insn_page_in_use;
> +
> +static void *__ppc_alloc_insn_page(void)
> +{
> +	if (insn_page_in_use)
> +		return NULL;
> +	insn_page_in_use = true;

This sets off my "no-locking-visible" detector. I assume there's some
locking somewhere else that makes this work?

> +	return &optinsn_slot;
> +}
> +
> +static void __ppc_free_insn_page(void *page __maybe_unused)
> +{
> +	insn_page_in_use = false;
> +}
> +
> +struct kprobe_insn_cache kprobe_ppc_optinsn_slots = {
> +	.mutex = __MUTEX_INITIALIZER(kprobe_ppc_optinsn_slots.mutex),
> +	.pages = LIST_HEAD_INIT(kprobe_ppc_optinsn_slots.pages),
> +	/* insn_size initialized later */
> +	.alloc = __ppc_alloc_insn_page,
> +	.free = __ppc_free_insn_page,
> +	.nr_garbage = 0,
> +};
> +
> +/*
> + * Check if we can optimize this probe. Returns NIP post-emulation if this can
> + * be optimized and 0 otherwise.
> + */
> +static unsigned long can_optimize(struct kprobe *p)
> +{
> +	struct pt_regs regs;
> +	struct instruction_op op;
> +	unsigned long nip = 0;
> +
> +	/*
> +	 * kprobe placed for kretprobe during boot time
> +	 * is not optimizing now.
> +	 *
> +	 * TODO: Optimize kprobe in kretprobe_trampoline
> +	 */
> +	if (p->addr == (kprobe_opcode_t *)&kretprobe_trampoline)
> +		return 0;
> +
> +	/*
> +	 * We only support optimizing kernel addresses, but not
> +	 * module addresses.

That probably warrants a TODO or FIXME.

> +	 */
> +	if (!is_kernel_addr((unsigned long)p->addr))
> +		return 0;
> +
> +	regs.nip = (unsigned long)p->addr;
> +	regs.trap = 0x0;
> +	regs.msr = MSR_KERNEL;

It may not matter in practice, but leaving most of regs uninitialised
seems a bit fishy. I'd prefer if we zeroed it first.

> +	/*
> +	 * Ensure that the instruction is not a conditional branch,

Can you spell out why it can't be a conditional branch.

> +	 * and that can be emulated.
> +	 */
> +	if (!is_conditional_branch(*p->ainsn.insn) &&
> +			analyse_instr(&op, &regs, *p->ainsn.insn))
> +		nip = regs.nip;
> +
> +	return nip;
> +}
> +
> +static void optimized_callback(struct optimized_kprobe *op,
> +			       struct pt_regs *regs)
> +{
> +	struct kprobe_ctlblk *kcb = get_kprobe_ctlblk();
> +	unsigned long flags;
> +
> +	/* This is possible if op is under delayed unoptimizing */
> +	if (kprobe_disabled(&op->kp))
> +		return;
> +
> +	local_irq_save(flags);

What is that protecting against? Because on powerpc it doesn't actually
disable interrupts, it just masks some of them, the perf interrupt for
example can still run.

> +
> +	if (kprobe_running()) {
> +		kprobes_inc_nmissed_count(&op->kp);
> +	} else {
> +		__this_cpu_write(current_kprobe, &op->kp);
> +		regs->nip = (unsigned long)op->kp.addr;
> +		kcb->kprobe_status = KPROBE_HIT_ACTIVE;
> +		opt_pre_handler(&op->kp, regs);
> +		__this_cpu_write(current_kprobe, NULL);
> +	}
> +	local_irq_restore(flags);
> +}
> +NOKPROBE_SYMBOL(optimized_callback);
> +
> +void arch_remove_optimized_kprobe(struct optimized_kprobe *op)
> +{
> +	if (op->optinsn.insn) {
> +		free_ppc_optinsn_slot(op->optinsn.insn, 1);
> +		op->optinsn.insn = NULL;
> +	}
> +}
> +
> +/*
> + * emulate_step() requires insn to be emulated as
> + * second parameter. Load register 'r4' with the
> + * instruction.
> + */
> +void patch_imm32_load_insns(unsigned int val, kprobe_opcode_t *addr)
> +{
> +	/* addis r4,0,(insn)@h */
> +	*addr++ = PPC_INST_ADDIS | ___PPC_RT(4) |
> +		  ((val >> 16) & 0xffff);
> +
> +	/* ori r4,r4,(insn)@l */
> +	*addr = PPC_INST_ORI | ___PPC_RA(4) | ___PPC_RS(4) |
> +		(val & 0xffff);
> +}
> +
> +/*
> + * Generate instructions to load provided immediate 64-bit value
> + * to register 'r3' and patch these instructions at 'addr'.
> + */
> +void patch_imm64_load_insns(unsigned long val, kprobe_opcode_t *addr)
> +{
> +	/* lis r3,(op)@highest */
> +	*addr++ = PPC_INST_ADDIS | ___PPC_RT(3) |
> +		  ((val >> 48) & 0xffff);
> +
> +	/* ori r3,r3,(op)@higher */
> +	*addr++ = PPC_INST_ORI | ___PPC_RA(3) | ___PPC_RS(3) |
> +		  ((val >> 32) & 0xffff);
> +
> +	/* rldicr r3,r3,32,31 */
> +	*addr++ = PPC_INST_RLDICR | ___PPC_RA(3) | ___PPC_RS(3) |
> +		  __PPC_SH64(32) | __PPC_ME64(31);
> +
> +	/* oris r3,r3,(op)@h */
> +	*addr++ = PPC_INST_ORIS | ___PPC_RA(3) | ___PPC_RS(3) |
> +		  ((val >> 16) & 0xffff);
> +
> +	/* ori r3,r3,(op)@l */
> +	*addr = PPC_INST_ORI | ___PPC_RA(3) | ___PPC_RS(3) |
> +		(val & 0xffff);
> +}

I can't say I love those patch functions. A PC-relative load would be
cleaner, but I guess that's ugly/expensive on current CPUs.

> diff --git a/arch/powerpc/kernel/optprobes_head.S b/arch/powerpc/kernel/optprobes_head.S
> new file mode 100644
> index 0000000..c86976b
> --- /dev/null
> +++ b/arch/powerpc/kernel/optprobes_head.S
> @@ -0,0 +1,135 @@
> +/*
> + * Code to prepare detour buffer for optprobes in Kernel.
> + *
> + * Copyright 2016, Anju T, IBM Corp.
> + *
> + * This program is free software; you can redistribute it and/or
> + * modify it under the terms of the GNU General Public License
> + * as published by the Free Software Foundation; either version
> + * 2 of the License, or (at your option) any later version.
> + */
> +
> +#include <asm/ppc_asm.h>
> +#include <asm/ptrace.h>
> +#include <asm/asm-offsets.h>
> +
> +#define	OPT_SLOT_SIZE	65536
> +
> +	.balign	4
> +
> +	/*
> +	 * Reserve an area to allocate slots for detour buffer.
> +	 * This is part of .text section (rather than vmalloc area)
> +	 * as this needs to be within 32MB of the probed address.
> +	 */
> +	.global optinsn_slot
> +optinsn_slot:
> +	.space	OPT_SLOT_SIZE
> +
> +	/*
> +	 * Optprobe template:
> +	 * This template gets copied into one of the slots in optinsn_slot
> +	 * and gets fixed up with real optprobe structures et al.
> +	 */
> +	.global optprobe_template_entry
> +optprobe_template_entry:
> +	/* Create an in-memory pt_regs */
> +	stdu	r1,-INT_FRAME_SIZE(r1)
> +	SAVE_GPR(0,r1)
> +	/* Save the previous SP into stack */
> +	addi	r0,r1,INT_FRAME_SIZE
> +	std	r0,GPR1(r1)
> +	SAVE_10GPRS(2,r1)
> +	SAVE_10GPRS(12,r1)
> +	SAVE_10GPRS(22,r1)
> +	/* Save SPRS */
> +	mfmsr	r5
> +	std	r5,_MSR(r1)
> +	li	r5,0x700
> +	std	r5,_TRAP(r1)
> +	li	r5,0
> +	std	r5,ORIG_GPR3(r1)
> +	std	r5,RESULT(r1)
> +	mfctr	r5
> +	std	r5,_CTR(r1)
> +	mflr	r5
> +	std	r5,_LINK(r1)
> +	mfspr	r5,SPRN_XER
> +	std	r5,_XER(r1)
> +	mfcr	r5
> +	std	r5,_CCR(r1)
> +	lbz     r5,PACASOFTIRQEN(r13)
> +	std     r5,SOFTE(r1)
> +	mfdar	r5
> +	std	r5,_DAR(r1)
> +	mfdsisr	r5
> +	std	r5,_DSISR(r1)

So this is what made me originally reply to this patch. This
save/restore sequence.

I'm not clear on why this is what we need to save/restore.

Aren't we essentially just interposing a function call? If so do we need
to save/restore all of these? eg. MSR/DAR/DSISR. Non-volatile GPRs? And
why are we pretending there was a 0x700 trap?

Is it because we're going to end up emulating the instruction and so we
need everything in pt_regs ?


> diff --git a/arch/powerpc/lib/sstep.c b/arch/powerpc/lib/sstep.c
> index 3362299..895dcdd 100644
> --- a/arch/powerpc/lib/sstep.c
> +++ b/arch/powerpc/lib/sstep.c
> @@ -618,6 +618,27 @@ static int __kprobes trap_compare(long v1, long v2)
>  }
>  
>  /*
> + * Helper to check if a given instruction is a conditional branch
> + * Derived from the conditional checks in analyse_instr()
> + */
> +bool __kprobes is_conditional_branch(unsigned int instr)
> +{
> +	unsigned int opcode = instr >> 26;
> +

We already have some similar routines in code_patching.c/h. Can you move
this in there instead?

cheers

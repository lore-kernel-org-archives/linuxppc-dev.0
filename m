Return-Path: <mhiramat@kernel.org>
Received: from mail.kernel.org (mail.kernel.org [198.145.29.136])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tgBq26n2rzDwBZ
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 17 Dec 2016 01:03:10 +1100 (AEDT)
Date: Fri, 16 Dec 2016 23:02:56 +0900
From: Masami Hiramatsu <mhiramat@kernel.org>
To: Anju T Sudhakar <anju@linux.vnet.ibm.com>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 ananth@in.ibm.com, naveen.n.rao@linux.vnet.ibm.com, paulus@samba.org,
 srikar@linux.vnet.ibm.com, benh@kernel.crashing.org, mpe@ellerman.id.au,
 mahesh@linux.vnet.ibm.com, mhiramat@kernel.org
Subject: Re: [PATCH V2 3/4] arch/powerpc: Implement Optprobes
Message-Id: <20161216230256.89472387164de66c3a6888f5@kernel.org>
In-Reply-To: <1481732310-7779-2-git-send-email-anju@linux.vnet.ibm.com>
References: <1481732310-7779-1-git-send-email-anju@linux.vnet.ibm.com>
 <1481732310-7779-2-git-send-email-anju@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-2022-JP
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 14 Dec 2016 21:48:27 +0530
Anju T Sudhakar <anju@linux.vnet.ibm.com> wrote:

> Detour buffer contains instructions to create an in memory pt_regs.
> After the execution of the pre-handler, a call is made for instruction emulation.
> The NIP is determined in advanced through dummy instruction emulation and a branch
> instruction is created to the NIP at the end of the trampoline.
> 
> Instruction slot for detour buffer is allocated from the reserved area.
> For the time being, 64KB is reserved in memory for this purpose.
> 
> Instructions which can be emulated using analyse_instr() are suppliants
> for optimization. Before optimization ensure that the address range
> between the detour buffer allocated and the instruction being probed
> is within ± 32MB.

Thank you for updating!
I think this has no critical issue, but I have some comments on it.
(just cleanup and hardenings)
Please see below.

> 
> Signed-off-by: Anju T Sudhakar <anju@linux.vnet.ibm.com>
> Signed-off-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
> ---
>  .../features/debug/optprobes/arch-support.txt      |   2 +-
>  arch/powerpc/Kconfig                               |   1 +
>  arch/powerpc/include/asm/kprobes.h                 |  23 +-
>  arch/powerpc/include/asm/sstep.h                   |   1 +
>  arch/powerpc/kernel/Makefile                       |   1 +
>  arch/powerpc/kernel/optprobes.c                    | 333 +++++++++++++++++++++
>  arch/powerpc/kernel/optprobes_head.S               | 135 +++++++++
>  arch/powerpc/lib/sstep.c                           |  22 ++
>  8 files changed, 516 insertions(+), 2 deletions(-)
>  create mode 100644 arch/powerpc/kernel/optprobes.c
>  create mode 100644 arch/powerpc/kernel/optprobes_head.S
> 
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
>      |        s390: | TODO |
>      |       score: | TODO |
>      |          sh: | TODO |
> diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
> index c7f120a..d563f0a 100644
> --- a/arch/powerpc/Kconfig
> +++ b/arch/powerpc/Kconfig
> @@ -98,6 +98,7 @@ config PPC
>  	select HAVE_IOREMAP_PROT
>  	select HAVE_EFFICIENT_UNALIGNED_ACCESS if !(CPU_LITTLE_ENDIAN && POWER7_CPU)
>  	select HAVE_KPROBES
> +	select HAVE_OPTPROBES if PPC64
>  	select HAVE_ARCH_KGDB
>  	select HAVE_KRETPROBES
>  	select HAVE_ARCH_TRACEHOOK
> diff --git a/arch/powerpc/include/asm/kprobes.h b/arch/powerpc/include/asm/kprobes.h
> index 2c9759bd..739ddc5 100644
> --- a/arch/powerpc/include/asm/kprobes.h
> +++ b/arch/powerpc/include/asm/kprobes.h
> @@ -38,7 +38,22 @@ struct pt_regs;
>  struct kprobe;
>  
>  typedef ppc_opcode_t kprobe_opcode_t;
> -#define MAX_INSN_SIZE 1
> +
> +extern kprobe_opcode_t optinsn_slot;
> +
> +/* Optinsn template address */
> +extern kprobe_opcode_t optprobe_template_entry[];
> +extern kprobe_opcode_t optprobe_template_op_address[];
> +extern kprobe_opcode_t optprobe_template_call_handler[];
> +extern kprobe_opcode_t optprobe_template_insn[];
> +extern kprobe_opcode_t optprobe_template_call_emulate[];
> +extern kprobe_opcode_t optprobe_template_ret[];
> +extern kprobe_opcode_t optprobe_template_end[];
> +
> +#define MAX_INSN_SIZE		1
> +#define MAX_OPTIMIZED_LENGTH	4
> +#define MAX_OPTINSN_SIZE	(optprobe_template_end - optprobe_template_entry)
> +#define RELATIVEJUMP_SIZE	4

These size/length macros seems a bit odd. I guess MAX_INSN_SIZE
is based on sizeof(MAX_INSN_SIZE), but others are in byte.
Could you fix that? For example, define it with 
sizeof(kprobe_opcode_t), and add comments on it, etc.

>  
>  #ifdef PPC64_ELF_ABI_v2
>  /* PPC64 ABIv2 needs local entry point */
> @@ -124,6 +139,12 @@ struct kprobe_ctlblk {
>  	struct prev_kprobe prev_kprobe;
>  };
>  
> +struct arch_optimized_insn {
> +	kprobe_opcode_t copied_insn[1];
> +	/* detour buffer */
> +	kprobe_opcode_t *insn;
> +};
> +
>  extern int kprobe_exceptions_notify(struct notifier_block *self,
>  					unsigned long val, void *data);
>  extern int kprobe_fault_handler(struct pt_regs *regs, int trapnr);
> diff --git a/arch/powerpc/include/asm/sstep.h b/arch/powerpc/include/asm/sstep.h
> index d3a42cc..f7ad425 100644
> --- a/arch/powerpc/include/asm/sstep.h
> +++ b/arch/powerpc/include/asm/sstep.h
> @@ -87,3 +87,4 @@ struct instruction_op {
>  
>  extern int analyse_instr(struct instruction_op *op, struct pt_regs *regs,
>  			 unsigned int instr);
> +extern bool is_conditional_branch(unsigned int instr);
> diff --git a/arch/powerpc/kernel/Makefile b/arch/powerpc/kernel/Makefile
> index 1925341..54f0f47 100644
> --- a/arch/powerpc/kernel/Makefile
> +++ b/arch/powerpc/kernel/Makefile
> @@ -98,6 +98,7 @@ obj-$(CONFIG_KGDB)		+= kgdb.o
>  obj-$(CONFIG_BOOTX_TEXT)	+= btext.o
>  obj-$(CONFIG_SMP)		+= smp.o
>  obj-$(CONFIG_KPROBES)		+= kprobes.o
> +obj-$(CONFIG_OPTPROBES)		+= optprobes.o optprobes_head.o
>  obj-$(CONFIG_UPROBES)		+= uprobes.o
>  obj-$(CONFIG_PPC_UDBG_16550)	+= legacy_serial.o udbg_16550.o
>  obj-$(CONFIG_STACKTRACE)	+= stacktrace.o
> diff --git a/arch/powerpc/kernel/optprobes.c b/arch/powerpc/kernel/optprobes.c
> new file mode 100644
> index 0000000..ecba221
> --- /dev/null
> +++ b/arch/powerpc/kernel/optprobes.c
> @@ -0,0 +1,333 @@
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
> +	 */
> +	if (!is_kernel_addr((unsigned long)p->addr))
> +		return 0;
> +
> +	regs.nip = (unsigned long)p->addr;
> +	regs.trap = 0x0;
> +	regs.msr = MSR_KERNEL;
> +
> +	/*
> +	 * Ensure that the instruction is not a conditional branch,
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

I need another PPC maintainer review for these.

> +
> +int arch_prepare_optimized_kprobe(struct optimized_kprobe *op, struct kprobe *p)
> +{
> +	kprobe_opcode_t *buff, branch_op_callback, branch_emulate_step;
> +	kprobe_opcode_t *op_callback_addr, *emulate_step_addr;
> +	long b_offset;
> +	unsigned long nip;
> +
> +	kprobe_ppc_optinsn_slots.insn_size = MAX_OPTINSN_SIZE;
> +
> +	nip = can_optimize(p);
> +	if (!nip)
> +		return -EILSEQ;
> +
> +	/* Allocate instruction slot for detour buffer */
> +	buff = get_ppc_optinsn_slot();
> +	if (!buff)
> +		return -ENOMEM;
> +
> +	/*
> +	 * OPTPROBE uses 'b' instruction to branch to optinsn.insn.
> +	 *
> +	 * The target address has to be relatively nearby, to permit use
> +	 * of branch instruction in powerpc, because the address is specified
> +	 * in an immediate field in the instruction opcode itself, ie 24 bits
> +	 * in the opcode specify the address. Therefore the address should
> +	 * be within 32MB on either side of the current instruction.
> +	 */
> +	b_offset = (unsigned long)buff - (unsigned long)p->addr;
> +	if (!is_offset_in_branch_range(b_offset)) {
> +		free_ppc_optinsn_slot(buff, 0);
> +		return -ERANGE;
> +	}
> +
> +	/* Check if the return address is also within 32MB range */
> +	b_offset = (unsigned long)(buff + TMPL_RET_IDX) -
> +			(unsigned long)nip;
> +	if (!is_offset_in_branch_range(b_offset)) {
> +		free_ppc_optinsn_slot(buff, 0);
> +		return -ERANGE;
> +	}
> +
> +	/* Setup template */
> +	memcpy(buff, optprobe_template_entry,
> +			TMPL_END_IDX * sizeof(kprobe_opcode_t));
> +
> +	/*
> +	 * Fixup the template with instructions to:
> +	 * 1. load the address of the actual probepoint
> +	 */
> +	patch_imm64_load_insns((unsigned long)op, buff + TMPL_OP_IDX);
> +
> +	/*
> +	 * 2. branch to optimized_callback() and emulate_step()
> +	 */
> +	kprobe_lookup_name("optimized_callback", op_callback_addr);
> +	kprobe_lookup_name("emulate_step", emulate_step_addr);
> +	if (!op_callback_addr || !emulate_step_addr) {
> +		free_ppc_optinsn_slot(buff, 0);
> +		WARN(1, "kprobe_lookup_name() failed\n");
> +		return -ENOENT;
> +	}
> +
> +	branch_op_callback = create_branch((unsigned int *)buff + TMPL_CALL_HDLR_IDX,
> +				(unsigned long)op_callback_addr,
> +				BRANCH_SET_LINK);
> +
> +	branch_emulate_step = create_branch((unsigned int *)buff + TMPL_EMULATE_IDX,
> +				(unsigned long)emulate_step_addr,
> +				BRANCH_SET_LINK);
> +
> +	if (!branch_op_callback || !branch_emulate_step) {
> +		free_ppc_optinsn_slot(buff, 0);
> +		return -ERANGE;

Since there are 4 free_ppc_optinsn_slot(buff, 0) and return error pattarns,
I recommend you to consolidate it by using "goto error".

> +	}
> +
> +	buff[TMPL_CALL_HDLR_IDX] = branch_op_callback;
> +	buff[TMPL_EMULATE_IDX] = branch_emulate_step;
> +
> +	/*
> +	 * 3. load instruction to be emulated into relevant register, and
> +	 */
> +	patch_imm32_load_insns(*p->ainsn.insn, buff + TMPL_INSN_IDX);
> +
> +	/*
> +	 * 4. branch back from trampoline
> +	 */
> +	buff[TMPL_RET_IDX] = create_branch((unsigned int *)buff + TMPL_RET_IDX,
> +				(unsigned long)nip, 0);
> +
> +	flush_icache_range((unsigned long)buff,
> +			   (unsigned long)(&buff[TMPL_END_IDX]));
> +
> +	op->optinsn.insn = buff;
> +
> +	return 0;
> +}
> +
> +int arch_prepared_optinsn(struct arch_optimized_insn *optinsn)
> +{
> +	return optinsn->insn != NULL;
> +}
> +
> +/*
> + * On powerpc, Optprobes always replaces one instruction (4 bytes
> + * aligned and 4 bytes long). It is impossible to encounter another
> + * kprobe in this address range. So always return 0.
> + */
> +int arch_check_optimized_kprobe(struct optimized_kprobe *op)
> +{
> +	return 0;
> +}
> +
> +void arch_optimize_kprobes(struct list_head *oplist)
> +{
> +	struct optimized_kprobe *op;
> +	struct optimized_kprobe *tmp;
> +
> +	list_for_each_entry_safe(op, tmp, oplist, list) {
> +		/*
> +		 * Backup instructions which will be replaced
> +		 * by jump address
> +		 */
> +		memcpy(op->optinsn.copied_insn, op->kp.addr,
> +					       RELATIVEJUMP_SIZE);
> +		patch_instruction(op->kp.addr,
> +			create_branch((unsigned int *)op->kp.addr,
> +				      (unsigned long)op->optinsn.insn, 0));

Would you be sure that create_branch doesn't fail?

> +		list_del_init(&op->list);
> +	}
> +}
> +
> +void arch_unoptimize_kprobe(struct optimized_kprobe *op)
> +{
> +	arch_arm_kprobe(&op->kp);
> +}
> +
> +void arch_unoptimize_kprobes(struct list_head *oplist,
> +			     struct list_head *done_list)
> +{
> +	struct optimized_kprobe *op;
> +	struct optimized_kprobe *tmp;
> +
> +	list_for_each_entry_safe(op, tmp, oplist, list) {
> +		arch_unoptimize_kprobe(op);
> +		list_move(&op->list, done_list);
> +	}
> +}
> +
> +int arch_within_optimized_kprobe(struct optimized_kprobe *op,
> +				 unsigned long addr)
> +{
> +	return ((unsigned long)op->kp.addr <= addr &&
> +		(unsigned long)op->kp.addr + RELATIVEJUMP_SIZE > addr);
> +}
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
> +
> +	.global optprobe_template_op_address
> +optprobe_template_op_address:
> +	/*
> +	 * Parameters to optimized_callback():
> +	 * 1. optimized_kprobe structure in r3
> +	 */
> +	nop
> +	nop
> +	nop
> +	nop
> +	nop
> +	/* 2. pt_regs pointer in r4 */
> +	addi	r4,r1,STACK_FRAME_OVERHEAD
> +
> +	.global optprobe_template_call_handler
> +optprobe_template_call_handler:
> +	/* Branch to optimized_callback() */
> +	nop
> +
> +	/*
> +	 * Parameters for instruction emulation:
> +	 * 1. Pass SP in register r3.
> +	 */
> +	addi	r3,r1,STACK_FRAME_OVERHEAD
> +
> +	.global optprobe_template_insn
> +optprobe_template_insn:
> +	/* 2, Pass instruction to be emulated in r4 */
> +	nop
> +	nop
> +
> +	.global optprobe_template_call_emulate
> +optprobe_template_call_emulate:
> +	/* Branch to emulate_step()  */
> +	nop
> +
> +	/*
> +	 * All done.
> +	 * Now, restore the registers...
> +	 */
> +	ld	r5,_MSR(r1)
> +	mtmsr	r5
> +	ld	r5,_CTR(r1)
> +	mtctr	r5
> +	ld	r5,_LINK(r1)
> +	mtlr	r5
> +	ld	r5,_XER(r1)
> +	mtxer	r5
> +	ld	r5,_CCR(r1)
> +	mtcr	r5
> +	ld	r5,_DAR(r1)
> +	mtdar	r5
> +	ld	r5,_DSISR(r1)
> +	mtdsisr	r5
> +	REST_GPR(0,r1)
> +	REST_10GPRS(2,r1)
> +	REST_10GPRS(12,r1)
> +	REST_10GPRS(22,r1)
> +	/* Restore the previous SP */
> +	addi	r1,r1,INT_FRAME_SIZE
> +
> +	.global optprobe_template_ret
> +optprobe_template_ret:
> +	/* ... and jump back from trampoline */
> +	nop
> +
> +	.global optprobe_template_end
> +optprobe_template_end:
> diff --git a/arch/powerpc/lib/sstep.c b/arch/powerpc/lib/sstep.c
> index 3362299..0c6c2b0 100644
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
> +	if (opcode == 16)	/* bc, bca, bcl, bcla */
> +		return true;
> +	if (opcode == 19) {
> +		switch ((instr >> 1) & 0x3ff) {
> +		case 16:	/* bclr, bclrl */
> +		case 528:	/* bcctr, bcctrl */
> +		case 560:	/* bctar, bctarl */
> +			return true;
> +		}
> +	}
> +	return false;
> +}
> +
> +/*
>   * Elements of 32-bit rotate and mask instructions.
>   */
>  #define MASK32(mb, me)	((0xffffffffUL >> (mb)) + \
> @@ -2018,3 +2039,4 @@ int __kprobes emulate_step(struct pt_regs *regs, unsigned int instr)
>  	regs->nip = truncate_if_32bit(regs->msr, regs->nip + 4);
>  	return 1;
>  }
> +

This seems unneeded linefeed :)

Thank you,

-- 
Masami Hiramatsu <mhiramat@kernel.org>

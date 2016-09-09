Return-Path: <anju@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sVv9L2nfZzDrpW
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  9 Sep 2016 20:49:58 +1000 (AEST)
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
 u89Ah69a011097
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 9 Sep 2016 06:49:56 -0400
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
 by mx0a-001b2d01.pphosted.com with ESMTP id 25bc2qmp3r-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 09 Sep 2016 06:49:55 -0400
Received: from localhost
 by e34.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <anju@linux.vnet.ibm.com>;
 Fri, 9 Sep 2016 04:49:55 -0600
Subject: Re: [PATCH 2/3] arch/powerpc : optprobes for powerpc core
To: Masami Hiramatsu <mhiramat@kernel.org>
References: <1473240792-10596-1-git-send-email-anju@linux.vnet.ibm.com>
 <1473240792-10596-3-git-send-email-anju@linux.vnet.ibm.com>
 <20160909014701.8d59bdb341a19a9f98f7ee64@kernel.org>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 ananth@in.ibm.com, naveen.n.rao@linux.vnet.ibm.com, paulus@samba.org,
 srikar@linux.vnet.ibm.com, benh@kernel.crashing.org,
 mpe@ellerman.id.au, hemant@linux.vnet.ibm.com, mahesh@linux.vnet.ibm.com
From: Anju T Sudhakar <anju@linux.vnet.ibm.com>
Date: Fri, 9 Sep 2016 16:19:41 +0530
MIME-Version: 1.0
In-Reply-To: <20160909014701.8d59bdb341a19a9f98f7ee64@kernel.org>
Content-Type: multipart/alternative;
 boundary="------------22A023E59D0B2A24D5044014"
Message-Id: <fd56afb9-c78e-521c-ef60-3e75cb6e24c7@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This is a multi-part message in MIME format.
--------------22A023E59D0B2A24D5044014
Content-Type: text/plain; charset=iso-2022-jp; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit

Hi Masami,


Thank you for reviewing the patch.


On Thursday 08 September 2016 10:17 PM, Masami Hiramatsu wrote:
> On Wed,  7 Sep 2016 15:03:11 +0530
> Anju T Sudhakar <anju@linux.vnet.ibm.com> wrote:
>
>> Instructions which can be emulated are suppliants for optimization.
>> Before optimization ensure that the address range between the detour
>> buffer allocated and the instruction being probed is within ± 32MB.
>>
>> Signed-off-by: Anju T Sudhakar <anju@linux.vnet.ibm.com>
>> ---
>>   arch/powerpc/include/asm/sstep.h |   1 +
>>   arch/powerpc/kernel/optprobes.c  | 329 +++++++++++++++++++++++++++++++++++++++
>>   arch/powerpc/lib/sstep.c         |  21 +++
>>   3 files changed, 351 insertions(+)
>>   create mode 100644 arch/powerpc/kernel/optprobes.c
>>
>> diff --git a/arch/powerpc/include/asm/sstep.h b/arch/powerpc/include/asm/sstep.h
>> index d3a42cc..cd5f6ab 100644
>> --- a/arch/powerpc/include/asm/sstep.h
>> +++ b/arch/powerpc/include/asm/sstep.h
>> @@ -25,6 +25,7 @@ struct pt_regs;
>>   
>>   /* Emulate instructions that cause a transfer of control. */
>>   extern int emulate_step(struct pt_regs *regs, unsigned int instr);
>> +extern int optprobe_conditional_branch_check(unsigned int instr);
>>   
>>   enum instruction_type {
>>   	COMPUTE,		/* arith/logical/CR op, etc. */
>> diff --git a/arch/powerpc/kernel/optprobes.c b/arch/powerpc/kernel/optprobes.c
>> new file mode 100644
>> index 0000000..7983d07
>> --- /dev/null
>> +++ b/arch/powerpc/kernel/optprobes.c
>> @@ -0,0 +1,329 @@
>> +/*
>> + * Code for Kernel probes Jump optimization.
>> + *
>> + * Copyright 2016, Anju T, IBM Corp.
>> + *
>> + * This program is free software; you can redistribute it and/or
>> + * modify it under the terms of the GNU General Public License
>> + * as published by the Free Software Foundation; either version
>> + * 2 of the License, or (at your option) any later version.
>> + */
>> +
>> +#include <linux/kprobes.h>
>> +#include <linux/jump_label.h>
>> +#include <linux/types.h>
>> +#include <linux/slab.h>
>> +#include <linux/list.h>
>> +#include <asm/kprobes.h>
>> +#include <asm/ptrace.h>
>> +#include <asm/cacheflush.h>
>> +#include <asm/code-patching.h>
>> +#include <asm/sstep.h>
>> +
>> +DEFINE_INSN_CACHE_OPS(ppc_optinsn)
>> +
>> +#define TMPL_CALL_HDLR_IDX	\
>> +	(optprobe_template_call_handler - optprobe_template_entry)
>> +#define TMPL_EMULATE_IDX	\
>> +	(optprobe_template_call_emulate - optprobe_template_entry)
>> +#define TMPL_RET_IDX	\
>> +	(optprobe_template_ret - optprobe_template_entry)
>> +#define TMPL_KP_IDX	\
>> +	(optprobe_template_kp_addr - optprobe_template_entry)
>> +#define TMPL_OP1_IDX	\
>> +	(optprobe_template_op_address1 - optprobe_template_entry)
>> +#define TMPL_INSN_IDX	\
>> +	(optprobe_template_insn - optprobe_template_entry)
>> +#define TMPL_END_IDX	\
>> +	(optprobe_template_end - optprobe_template_entry)
>> +
>> +static bool insn_page_in_use;
>> +
>> +static void *__ppc_alloc_insn_page(void)
>> +{
>> +	if (insn_page_in_use)
>> +		return NULL;
>> +	insn_page_in_use = true;
>> +	return &optinsn_slot;
>> +}
>> +
>> +static void __ppc_free_insn_page(void *page __maybe_unused)
>> +{
>> +	insn_page_in_use = false;
>> +}
>> +
>> +struct kprobe_insn_cache kprobe_ppc_optinsn_slots = {
>> +	.mutex = __MUTEX_INITIALIZER(kprobe_ppc_optinsn_slots.mutex),
>> +	.pages = LIST_HEAD_INIT(kprobe_ppc_optinsn_slots.pages),
>> +	/* insn_size initialized later */
>> +	.alloc = __ppc_alloc_insn_page,
>> +	.free = __ppc_free_insn_page,
>> +	.nr_garbage = 0,
>> +};
>> +
>> +kprobe_opcode_t *ppc_get_optinsn_slot(struct optimized_kprobe *op)
>> +{
>> +	/*
>> +	 * The insn slot is allocated from the reserved
>> +	 * area(ie &optinsn_slot).We are not optimizing probes
>> +	 * at module_addr now.
>> +	 */
>> +	if (is_kernel_addr((unsigned long)op->kp.addr))
>> +		return get_ppc_optinsn_slot();
>> +	return NULL;
>> +}
>> +
>> +static void ppc_free_optinsn_slot(struct optimized_kprobe *op)
>> +{
>> +	if (!op->optinsn.insn)
>> +		return;
>> +	if (is_kernel_addr((unsigned long)op->kp.addr))
>> +		free_ppc_optinsn_slot(op->optinsn.insn, 0);
>> +}
>> +
>> +static unsigned long can_optimize(struct kprobe *p)
>> +{
>> +	struct pt_regs *regs;
>> +	unsigned int instr;
>> +
>> +	/*
>> +	 * Not optimizing the kprobe placed by
>> +	 * kretprobe during boot time
>> +	 */
>> +	if (p->addr == (kprobe_opcode_t *)&kretprobe_trampoline)
>> +		return 0;
>> +
>> +	regs = kmalloc(sizeof(*regs), GFP_KERNEL);
>> +	if (!regs)
>> +		return -ENOMEM;
>> +	memset(regs, 0, sizeof(struct pt_regs));
>> +	memcpy(regs, current_pt_regs(), sizeof(struct pt_regs));
>> +	regs->nip = (unsigned long)p->addr;
>> +	instr = *p->ainsn.insn;
>> +
>> +	/* Ensure the instruction can be emulated */
>> +	if (emulate_step(regs, instr) != 1)
>> +		return 0;
>> +	/* Conditional branches are not optimized */
>> +	if (optprobe_conditional_branch_check(instr) != 1)
>> +		return 0;
>> +	return regs->nip;
> Could you free regs here? Or allocate it on stack.

yes. 'regs' can be freed here.
>
>> +}
>> +
>> +static void
>> +optimized_callback(struct optimized_kprobe *op, struct pt_regs *regs)
>> +{
>> +	struct kprobe_ctlblk *kcb = get_kprobe_ctlblk();
>> +	unsigned long flags;
>> +
>> +	local_irq_save(flags);
>> +
>> +	if (kprobe_running()) {
>> +		kprobes_inc_nmissed_count(&op->kp);
>> +	} else {
>> +		__this_cpu_write(current_kprobe, &op->kp);
>> +		kcb->kprobe_status = KPROBE_HIT_ACTIVE;
>> +		opt_pre_handler(&op->kp, regs);
>> +		__this_cpu_write(current_kprobe, NULL);
>> +	}
>> +	local_irq_restore(flags);
>> +}
>> +NOKPROBE_SYMBOL(optimized_callback);
>> +
>> +void arch_remove_optimized_kprobe(struct optimized_kprobe *op)
>> +{
>> +	ppc_free_optinsn_slot(op);
>> +	op->optinsn.insn = NULL;
>> +}
>> +
>> +/*
>> + * emulate_step() requires insn to be emulated as
>> + * second parameter. Load register 'r4' with the
>> + * instruction.
>> + */
>> +void create_load_emulate_insn(unsigned int insn, kprobe_opcode_t *addr)
>> +{
>> +	u32 instr, instr2;
>> +
>> +	/* synthesize addis r4,0,(insn)@h */
>> +	 instr = 0x3c000000 | 0x800000 | ((insn >> 16) & 0xffff);
>> +	*addr++ = instr;
>> +
>> +	/* ori r4,r4,(insn)@l */
>> +	instr2 = 0x60000000 | 0x40000 | 0x800000;
>> +	instr2 = instr2 | (insn & 0xffff);
>> +	*addr = instr2;
>> +}
>> +
>> +/*
>> + * optimized_kprobe structure is required as a parameter
>> + * for invoking optimized_callback() from detour buffer.
>> + * Load this value into register 'r3'.
>> + */
>> +void create_load_address_insn(unsigned long val, kprobe_opcode_t *addr)
>> +{
>> +	u32 instr1, instr2, instr3, instr4, instr5;
>> +	/*
>> +	 * 64bit immediate load into r3.
>> +	 * lis r3,(op)@highest
>> +	 */
>> +	instr1 = 0x3c000000 | 0x600000 | ((val >> 48) & 0xffff);
>> +	*addr++ = instr1;
>> +
>> +	/* ori r3,r3,(op)@higher */
>> +	instr2 = 0x60000000 | 0x30000 | 0x600000 | ((val >> 32) & 0xffff);
>> +	*addr++ = instr2;
>> +
>> +	/* rldicr r3,r3,32,31 */
>> +	instr3 = 0x78000004 | 0x30000 | 0x600000 | ((32 & 0x1f) << 11);
>> +	instr3 = instr3 | ((31 & 0x1f) << 6) | ((32 & 0x20) >> 4);
>> +	*addr++ = instr3;
>> +
>> +	/* oris r3,r3,(op)@h */
>> +	instr4 = 0x64000000 |  0x30000 | 0x600000 | ((val >> 16) & 0xffff);
>> +	*addr++ = instr4;
>> +
>> +	/* ori r3,r3,(op)@l */
>> +	instr5 = 0x60000000 | 0x30000 | 0x600000 | (val & 0xffff);
>> +	*addr = instr5;
>> +}
>> +
>> +int arch_prepare_optimized_kprobe(struct optimized_kprobe *op, struct kprobe *p)
>> +{
>> +	kprobe_opcode_t *buff, branch, branch2, branch3;
>> +	long rel_chk, ret_chk;
>> +	unsigned long nip;
>> +
>> +	kprobe_ppc_optinsn_slots.insn_size = MAX_OPTINSN_SIZE;
>> +	op->optinsn.insn = NULL;
>> +	nip = can_optimize(p);
>> +
>> +	if (!nip)
>> +		return -EILSEQ;
>> +
>> +	/* Allocate instruction slot for detour buffer */
>> +	buff = ppc_get_optinsn_slot(op);
>> +	if (!buff)
>> +		return -ENOMEM;
>> +
>> +	/*
>> +	 * OPTPROBE use a 'b' instruction to branch to optinsn.insn.
>> +	 *
>> +	 * The target address has to be relatively nearby, to permit use
>> +	 * of branch instruction in powerpc because the address is specified
>> +	 * in an immediate field in the instruction opcode itself, ie 24 bits
>> +	 * in the opcode specify the address. Therefore the address gap should
>> +	 * be 32MB on either side of the current instruction.
>> +	 */
>> +	rel_chk = (long)buff - (unsigned long)p->addr;
>> +	if (rel_chk < -0x2000000 || rel_chk > 0x1fffffc || rel_chk & 0x3) {
>> +		ppc_free_optinsn_slot(op);
> This doesn't work because op->optinsn.insn is NULL here. (buff is assigned
> at the end of this function)

yes. You are right. Need to free 'buff' here.
Thank you for pointing out this.
>> +		return -ERANGE;
>> +	}
>> +	/* Check the return address is also within 32MB range */
>> +	ret_chk = (long)(buff + TMPL_RET_IDX) - (unsigned long)nip;
>> +	if (ret_chk < -0x2000000 || ret_chk > 0x1fffffc || ret_chk & 0x3) {
>> +		ppc_free_optinsn_slot(op);
> ditto.
>
>> +		return -ERANGE;
>> +	}
>> +
>> +	/* Do Copy arch specific instance from template */
>> +	memcpy(buff, optprobe_template_entry,
>> +	       TMPL_END_IDX * sizeof(kprobe_opcode_t));
>> +
>> +	/* Load address into register */
>> +	create_load_address_insn((unsigned long)p->addr, buff + TMPL_KP_IDX);
>> +	create_load_address_insn((unsigned long)op, buff + TMPL_OP1_IDX);
>> +
>> +	/*
>> +	 * Create a branch to the optimized_callback function.
>> +	 * optimized_callback, points to the global entry point.
>> +	 * Add +8, to create a branch to the LEP of the function.
>> +	 */
>> +	branch = create_branch((unsigned int *)buff + TMPL_CALL_HDLR_IDX,
>> +			       (unsigned long)optimized_callback + 8,
>> +				BRANCH_SET_LINK);
>> +
>> +	/* Place the branch instr into the trampoline */
>> +	buff[TMPL_CALL_HDLR_IDX] = branch;
>> +
>> +	/* Load instruction to be emulated into relevant register */
>> +	create_load_emulate_insn(*p->ainsn.insn, buff + TMPL_INSN_IDX);
>> +
>> +	/*
>> +	 * Create a branch instruction into the emulate_step.
>> +	 * Add +8, to create the branch to LEP of emulate_step().
>> +	 */
>> +	branch3 = create_branch((unsigned int *)buff + TMPL_EMULATE_IDX,
>> +				(unsigned long)emulate_step + 8,
>> +				BRANCH_SET_LINK);
>> +	buff[TMPL_EMULATE_IDX] = branch3;
>> +
>> +	/* Create a branch for jumping back */
>> +	branch2 = create_branch((unsigned int *)buff + TMPL_RET_IDX,
>> +				(unsigned long)nip, 0);
>> +	buff[TMPL_RET_IDX] = branch2;
>> +
>> +	op->optinsn.insn = buff;
>> +	smp_mb();
>> +	return 0;
>> +}
>> +
>> +int arch_prepared_optinsn(struct arch_optimized_insn *optinsn)
>> +{
>> +	return optinsn->insn != NULL;
>> +}
>> +
>> +/*
>> + * Here,kprobe opt always replace one instruction (4 bytes
>> + * aligned and 4 bytes long). It is impossible to encounter another
>> + * kprobe in the address range. So always return 0.
>> + */
>> +int arch_check_optimized_kprobe(struct optimized_kprobe *op)
>> +{
>> +	return 0;
>> +}
>> +
>> +void arch_optimize_kprobes(struct list_head *oplist)
>> +{
>> +	struct optimized_kprobe *op;
>> +	struct optimized_kprobe *tmp;
>> +
>> +	unsigned int branch;
>> +
>> +	list_for_each_entry_safe(op, tmp, oplist, list) {
>> +		/*
>> +		 * Backup instructions which will be replaced
>> +		 * by jump address
>> +		 */
>> +		memcpy(op->optinsn.copied_insn, op->kp.addr,
>> +		       RELATIVEJUMP_SIZE);
>> +		branch = create_branch((unsigned int *)op->kp.addr,
>> +				       (unsigned long)op->optinsn.insn, 0);
>> +		*op->kp.addr = branch;
> Hmm, wouldn't we have to use patch_instruction() here?
> (It seems ppc kprobe implementation should also be updated to use it...)
>> +		list_del_init(&op->list);
>> +	}
>> +}
>> +
>> +void arch_unoptimize_kprobe(struct optimized_kprobe *op)
>> +{
>> +	arch_arm_kprobe(&op->kp);
>> +}
>> +
>> +void arch_unoptimize_kprobes(struct list_head *oplist,
>> +			     struct list_head *done_list)
>> +{
>> +	struct optimized_kprobe *op;
>> +	struct optimized_kprobe *tmp;
>> +
>> +	list_for_each_entry_safe(op, tmp, oplist, list) {
>> +		arch_unoptimize_kprobe(op);
>> +		list_move(&op->list, done_list);
>> +	}
>> +}
>> +
>> +int arch_within_optimized_kprobe(struct optimized_kprobe *op,
>> +				 unsigned long addr)
>> +{
>> +	return 0;
> Here, please check the address range as same as arm32 optprobe implementation.
>
> e.g.
>          return ((unsigned long)op->kp.addr <= addr &&
>                  (unsigned long)op->kp.addr + RELATIVEJUMP_SIZE > addr);
>
>
> Thank you,

Do we really need this? The only case this check will succeed is if  
kp.addr is not a multiple of 4, which is not a valid address at all  
onPower. So should we again check here for that?



Thanks and regards
-Anju
>> +}
>> diff --git a/arch/powerpc/lib/sstep.c b/arch/powerpc/lib/sstep.c
>> index 3362299..c4b8259 100644
>> --- a/arch/powerpc/lib/sstep.c
>> +++ b/arch/powerpc/lib/sstep.c
>> @@ -2018,3 +2018,24 @@ int __kprobes emulate_step(struct pt_regs *regs, unsigned int instr)
>>   	regs->nip = truncate_if_32bit(regs->msr, regs->nip + 4);
>>   	return 1;
>>   }
>> +
>> +/* Before optimizing, ensure that the probed instruction is not a
>> + * conditional branch instruction
>> + */
>> +int __kprobes optprobe_conditional_branch_check(unsigned int instr)
>> +{
>> +	unsigned int opcode;
>> +
>> +	opcode = instr >> 26;
>> +	if (opcode == 16)
>> +		return 0;
>> +	if (opcode == 19) {
>> +		switch ((instr >> 1) & 0x3ff) {
>> +		case 16:        /* bclr, bclrl */
>> +		case 528:       /* bcctr, bcctrl */
>> +		case 560:       /* bctar, bctarl */
>> +			return 0;
>> +		}
>> +	}
>> +	return 1;
>> +}
>> -- 
>> 1.8.3.1
>>
>


--------------22A023E59D0B2A24D5044014
Content-Type: text/html; charset=iso-2022-jp
Content-Transfer-Encoding: 7bit

<html>
  <head>
    <meta content="text/html; charset=iso-2022-jp"
      http-equiv="Content-Type">
  </head>
  <body bgcolor="#FFFFFF" text="#000000">
    <p>Hi Masami,</p>
    <p><br>
    </p>
    <p>Thank you for reviewing the patch.<br>
    </p>
    <br>
    <div class="moz-cite-prefix">On Thursday 08 September 2016 10:17 PM,
      Masami Hiramatsu wrote:<br>
    </div>
    <blockquote
      cite="mid:20160909014701.8d59bdb341a19a9f98f7ee64@kernel.org"
      type="cite">
      <pre wrap="">On Wed,  7 Sep 2016 15:03:11 +0530
Anju T Sudhakar <a class="moz-txt-link-rfc2396E" href="mailto:anju@linux.vnet.ibm.com">&lt;anju@linux.vnet.ibm.com&gt;</a> wrote:

</pre>
      <blockquote type="cite">
        <pre wrap="">Instructions which can be emulated are suppliants for optimization.
Before optimization ensure that the address range between the detour
buffer allocated and the instruction being probed is within ± 32MB.

Signed-off-by: Anju T Sudhakar <a class="moz-txt-link-rfc2396E" href="mailto:anju@linux.vnet.ibm.com">&lt;anju@linux.vnet.ibm.com&gt;</a>
---
 arch/powerpc/include/asm/sstep.h |   1 +
 arch/powerpc/kernel/optprobes.c  | 329 +++++++++++++++++++++++++++++++++++++++
 arch/powerpc/lib/sstep.c         |  21 +++
 3 files changed, 351 insertions(+)
 create mode 100644 arch/powerpc/kernel/optprobes.c

diff --git a/arch/powerpc/include/asm/sstep.h b/arch/powerpc/include/asm/sstep.h
index d3a42cc..cd5f6ab 100644
--- a/arch/powerpc/include/asm/sstep.h
+++ b/arch/powerpc/include/asm/sstep.h
@@ -25,6 +25,7 @@ struct pt_regs;
 
 /* Emulate instructions that cause a transfer of control. */
 extern int emulate_step(struct pt_regs *regs, unsigned int instr);
+extern int optprobe_conditional_branch_check(unsigned int instr);
 
 enum instruction_type {
 	COMPUTE,		/* arith/logical/CR op, etc. */
diff --git a/arch/powerpc/kernel/optprobes.c b/arch/powerpc/kernel/optprobes.c
new file mode 100644
index 0000000..7983d07
--- /dev/null
+++ b/arch/powerpc/kernel/optprobes.c
@@ -0,0 +1,329 @@
+/*
+ * Code for Kernel probes Jump optimization.
+ *
+ * Copyright 2016, Anju T, IBM Corp.
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version
+ * 2 of the License, or (at your option) any later version.
+ */
+
+#include &lt;linux/kprobes.h&gt;
+#include &lt;linux/jump_label.h&gt;
+#include &lt;linux/types.h&gt;
+#include &lt;linux/slab.h&gt;
+#include &lt;linux/list.h&gt;
+#include &lt;asm/kprobes.h&gt;
+#include &lt;asm/ptrace.h&gt;
+#include &lt;asm/cacheflush.h&gt;
+#include &lt;asm/code-patching.h&gt;
+#include &lt;asm/sstep.h&gt;
+
+DEFINE_INSN_CACHE_OPS(ppc_optinsn)
+
+#define TMPL_CALL_HDLR_IDX	\
+	(optprobe_template_call_handler - optprobe_template_entry)
+#define TMPL_EMULATE_IDX	\
+	(optprobe_template_call_emulate - optprobe_template_entry)
+#define TMPL_RET_IDX	\
+	(optprobe_template_ret - optprobe_template_entry)
+#define TMPL_KP_IDX	\
+	(optprobe_template_kp_addr - optprobe_template_entry)
+#define TMPL_OP1_IDX	\
+	(optprobe_template_op_address1 - optprobe_template_entry)
+#define TMPL_INSN_IDX	\
+	(optprobe_template_insn - optprobe_template_entry)
+#define TMPL_END_IDX	\
+	(optprobe_template_end - optprobe_template_entry)
+
+static bool insn_page_in_use;
+
+static void *__ppc_alloc_insn_page(void)
+{
+	if (insn_page_in_use)
+		return NULL;
+	insn_page_in_use = true;
+	return &amp;optinsn_slot;
+}
+
+static void __ppc_free_insn_page(void *page __maybe_unused)
+{
+	insn_page_in_use = false;
+}
+
+struct kprobe_insn_cache kprobe_ppc_optinsn_slots = {
+	.mutex = __MUTEX_INITIALIZER(kprobe_ppc_optinsn_slots.mutex),
+	.pages = LIST_HEAD_INIT(kprobe_ppc_optinsn_slots.pages),
+	/* insn_size initialized later */
+	.alloc = __ppc_alloc_insn_page,
+	.free = __ppc_free_insn_page,
+	.nr_garbage = 0,
+};
+
+kprobe_opcode_t *ppc_get_optinsn_slot(struct optimized_kprobe *op)
+{
+	/*
+	 * The insn slot is allocated from the reserved
+	 * area(ie &amp;optinsn_slot).We are not optimizing probes
+	 * at module_addr now.
+	 */
+	if (is_kernel_addr((unsigned long)op-&gt;kp.addr))
+		return get_ppc_optinsn_slot();
+	return NULL;
+}
+
+static void ppc_free_optinsn_slot(struct optimized_kprobe *op)
+{
+	if (!op-&gt;optinsn.insn)
+		return;
+	if (is_kernel_addr((unsigned long)op-&gt;kp.addr))
+		free_ppc_optinsn_slot(op-&gt;optinsn.insn, 0);
+}
+
+static unsigned long can_optimize(struct kprobe *p)
+{
+	struct pt_regs *regs;
+	unsigned int instr;
+
+	/*
+	 * Not optimizing the kprobe placed by
+	 * kretprobe during boot time
+	 */
+	if (p-&gt;addr == (kprobe_opcode_t *)&amp;kretprobe_trampoline)
+		return 0;
+
+	regs = kmalloc(sizeof(*regs), GFP_KERNEL);
+	if (!regs)
+		return -ENOMEM;
+	memset(regs, 0, sizeof(struct pt_regs));
+	memcpy(regs, current_pt_regs(), sizeof(struct pt_regs));
+	regs-&gt;nip = (unsigned long)p-&gt;addr;
+	instr = *p-&gt;ainsn.insn;
+
+	/* Ensure the instruction can be emulated */
+	if (emulate_step(regs, instr) != 1)
+		return 0;
+	/* Conditional branches are not optimized */
+	if (optprobe_conditional_branch_check(instr) != 1)
+		return 0;
+	return regs-&gt;nip;
</pre>
      </blockquote>
      <pre wrap="">
Could you free regs here? Or allocate it on stack.</pre>
    </blockquote>
    <br>
    yes. 'regs' can be freed here.<br>
    <blockquote
      cite="mid:20160909014701.8d59bdb341a19a9f98f7ee64@kernel.org"
      type="cite">
      <pre wrap="">

</pre>
      <blockquote type="cite">
        <pre wrap="">+}
+
+static void
+optimized_callback(struct optimized_kprobe *op, struct pt_regs *regs)
+{
+	struct kprobe_ctlblk *kcb = get_kprobe_ctlblk();
+	unsigned long flags;
+
+	local_irq_save(flags);
+
+	if (kprobe_running()) {
+		kprobes_inc_nmissed_count(&amp;op-&gt;kp);
+	} else {
+		__this_cpu_write(current_kprobe, &amp;op-&gt;kp);
+		kcb-&gt;kprobe_status = KPROBE_HIT_ACTIVE;
+		opt_pre_handler(&amp;op-&gt;kp, regs);
+		__this_cpu_write(current_kprobe, NULL);
+	}
+	local_irq_restore(flags);
+}
+NOKPROBE_SYMBOL(optimized_callback);
+
+void arch_remove_optimized_kprobe(struct optimized_kprobe *op)
+{
+	ppc_free_optinsn_slot(op);
+	op-&gt;optinsn.insn = NULL;
+}
+
+/*
+ * emulate_step() requires insn to be emulated as
+ * second parameter. Load register 'r4' with the
+ * instruction.
+ */
+void create_load_emulate_insn(unsigned int insn, kprobe_opcode_t *addr)
+{
+	u32 instr, instr2;
+
+	/* synthesize addis r4,0,(insn)@h */
+	 instr = 0x3c000000 | 0x800000 | ((insn &gt;&gt; 16) &amp; 0xffff);
+	*addr++ = instr;
+
+	/* ori r4,r4,(insn)@l */
+	instr2 = 0x60000000 | 0x40000 | 0x800000;
+	instr2 = instr2 | (insn &amp; 0xffff);
+	*addr = instr2;
+}
+
+/*
+ * optimized_kprobe structure is required as a parameter
+ * for invoking optimized_callback() from detour buffer.
+ * Load this value into register 'r3'.
+ */
+void create_load_address_insn(unsigned long val, kprobe_opcode_t *addr)
+{
+	u32 instr1, instr2, instr3, instr4, instr5;
+	/*
+	 * 64bit immediate load into r3.
+	 * lis r3,(op)@highest
+	 */
+	instr1 = 0x3c000000 | 0x600000 | ((val &gt;&gt; 48) &amp; 0xffff);
+	*addr++ = instr1;
+
+	/* ori r3,r3,(op)@higher */
+	instr2 = 0x60000000 | 0x30000 | 0x600000 | ((val &gt;&gt; 32) &amp; 0xffff);
+	*addr++ = instr2;
+
+	/* rldicr r3,r3,32,31 */
+	instr3 = 0x78000004 | 0x30000 | 0x600000 | ((32 &amp; 0x1f) &lt;&lt; 11);
+	instr3 = instr3 | ((31 &amp; 0x1f) &lt;&lt; 6) | ((32 &amp; 0x20) &gt;&gt; 4);
+	*addr++ = instr3;
+
+	/* oris r3,r3,(op)@h */
+	instr4 = 0x64000000 |  0x30000 | 0x600000 | ((val &gt;&gt; 16) &amp; 0xffff);
+	*addr++ = instr4;
+
+	/* ori r3,r3,(op)@l */
+	instr5 = 0x60000000 | 0x30000 | 0x600000 | (val &amp; 0xffff);
+	*addr = instr5;
+}
+
+int arch_prepare_optimized_kprobe(struct optimized_kprobe *op, struct kprobe *p)
+{
+	kprobe_opcode_t *buff, branch, branch2, branch3;
+	long rel_chk, ret_chk;
+	unsigned long nip;
+
+	kprobe_ppc_optinsn_slots.insn_size = MAX_OPTINSN_SIZE;
+	op-&gt;optinsn.insn = NULL;
+	nip = can_optimize(p);
+
+	if (!nip)
+		return -EILSEQ;
+
+	/* Allocate instruction slot for detour buffer */
+	buff = ppc_get_optinsn_slot(op);
+	if (!buff)
+		return -ENOMEM;
+
+	/*
+	 * OPTPROBE use a 'b' instruction to branch to optinsn.insn.
+	 *
+	 * The target address has to be relatively nearby, to permit use
+	 * of branch instruction in powerpc because the address is specified
+	 * in an immediate field in the instruction opcode itself, ie 24 bits
+	 * in the opcode specify the address. Therefore the address gap should
+	 * be 32MB on either side of the current instruction.
+	 */
+	rel_chk = (long)buff - (unsigned long)p-&gt;addr;
+	if (rel_chk &lt; -0x2000000 || rel_chk &gt; 0x1fffffc || rel_chk &amp; 0x3) {
+		ppc_free_optinsn_slot(op);
</pre>
      </blockquote>
      <pre wrap="">
This doesn't work because op-&gt;optinsn.insn is NULL here. (buff is assigned
at the end of this function)
</pre>
    </blockquote>
    <br>
    yes. You are right. Need to free 'buff' here. <br>
    Thank you for pointing out this.<br>
    <blockquote
      cite="mid:20160909014701.8d59bdb341a19a9f98f7ee64@kernel.org"
      type="cite">
      <pre wrap="">
</pre>
      <blockquote type="cite">
        <pre wrap="">+		return -ERANGE;
+	}
+	/* Check the return address is also within 32MB range */
+	ret_chk = (long)(buff + TMPL_RET_IDX) - (unsigned long)nip;
+	if (ret_chk &lt; -0x2000000 || ret_chk &gt; 0x1fffffc || ret_chk &amp; 0x3) {
+		ppc_free_optinsn_slot(op);
</pre>
      </blockquote>
      <pre wrap="">
ditto.

</pre>
      <blockquote type="cite">
        <pre wrap="">+		return -ERANGE;
+	}
+
+	/* Do Copy arch specific instance from template */
+	memcpy(buff, optprobe_template_entry,
+	       TMPL_END_IDX * sizeof(kprobe_opcode_t));
+
+	/* Load address into register */
+	create_load_address_insn((unsigned long)p-&gt;addr, buff + TMPL_KP_IDX);
+	create_load_address_insn((unsigned long)op, buff + TMPL_OP1_IDX);
+
+	/*
+	 * Create a branch to the optimized_callback function.
+	 * optimized_callback, points to the global entry point.
+	 * Add +8, to create a branch to the LEP of the function.
+	 */
+	branch = create_branch((unsigned int *)buff + TMPL_CALL_HDLR_IDX,
+			       (unsigned long)optimized_callback + 8,
+				BRANCH_SET_LINK);
+
+	/* Place the branch instr into the trampoline */
+	buff[TMPL_CALL_HDLR_IDX] = branch;
+
+	/* Load instruction to be emulated into relevant register */
+	create_load_emulate_insn(*p-&gt;ainsn.insn, buff + TMPL_INSN_IDX);
+
+	/*
+	 * Create a branch instruction into the emulate_step.
+	 * Add +8, to create the branch to LEP of emulate_step().
+	 */
+	branch3 = create_branch((unsigned int *)buff + TMPL_EMULATE_IDX,
+				(unsigned long)emulate_step + 8,
+				BRANCH_SET_LINK);
+	buff[TMPL_EMULATE_IDX] = branch3;
+
+	/* Create a branch for jumping back */
+	branch2 = create_branch((unsigned int *)buff + TMPL_RET_IDX,
+				(unsigned long)nip, 0);
+	buff[TMPL_RET_IDX] = branch2;
+
+	op-&gt;optinsn.insn = buff;
+	smp_mb();
+	return 0;
+}
+
+int arch_prepared_optinsn(struct arch_optimized_insn *optinsn)
+{
+	return optinsn-&gt;insn != NULL;
+}
+
+/*
+ * Here,kprobe opt always replace one instruction (4 bytes
+ * aligned and 4 bytes long). It is impossible to encounter another
+ * kprobe in the address range. So always return 0.
+ */
+int arch_check_optimized_kprobe(struct optimized_kprobe *op)
+{
+	return 0;
+}
+
+void arch_optimize_kprobes(struct list_head *oplist)
+{
+	struct optimized_kprobe *op;
+	struct optimized_kprobe *tmp;
+
+	unsigned int branch;
+
+	list_for_each_entry_safe(op, tmp, oplist, list) {
+		/*
+		 * Backup instructions which will be replaced
+		 * by jump address
+		 */
+		memcpy(op-&gt;optinsn.copied_insn, op-&gt;kp.addr,
+		       RELATIVEJUMP_SIZE);
+		branch = create_branch((unsigned int *)op-&gt;kp.addr,
+				       (unsigned long)op-&gt;optinsn.insn, 0);
+		*op-&gt;kp.addr = branch;
</pre>
      </blockquote>
      <pre wrap="">
Hmm, wouldn't we have to use patch_instruction() here?
(It seems ppc kprobe implementation should also be updated to use it...)</pre>
    </blockquote>
    <blockquote
      cite="mid:20160909014701.8d59bdb341a19a9f98f7ee64@kernel.org"
      type="cite">
      <pre wrap="">
</pre>
      <blockquote type="cite">
        <pre wrap="">+		list_del_init(&amp;op-&gt;list);
+	}
+}
+
+void arch_unoptimize_kprobe(struct optimized_kprobe *op)
+{
+	arch_arm_kprobe(&amp;op-&gt;kp);
+}
+
+void arch_unoptimize_kprobes(struct list_head *oplist,
+			     struct list_head *done_list)
+{
+	struct optimized_kprobe *op;
+	struct optimized_kprobe *tmp;
+
+	list_for_each_entry_safe(op, tmp, oplist, list) {
+		arch_unoptimize_kprobe(op);
+		list_move(&amp;op-&gt;list, done_list);
+	}
+}
+
+int arch_within_optimized_kprobe(struct optimized_kprobe *op,
+				 unsigned long addr)
+{
+	return 0;
</pre>
      </blockquote>
      <pre wrap="">
Here, please check the address range as same as arm32 optprobe implementation.

e.g.
        return ((unsigned long)op-&gt;kp.addr &lt;= addr &amp;&amp;
                (unsigned long)op-&gt;kp.addr + RELATIVEJUMP_SIZE &gt; addr);


Thank you,
</pre>
    </blockquote>
    <br>
    Do we really need this? <font size="+2"><font size="+1">The only
        case this check will succeed is if kp.addr is not a multiple of
        4, which is not a valid address at all on</font></font><font
      size="+2"><font size="+1"> Power. So should we again check here
        for that</font>?<br>
      <br>
      <br>
    </font><br>
    Thanks and regards<br>
    -Anju<font size="+2"><br>
    </font>
    <blockquote
      cite="mid:20160909014701.8d59bdb341a19a9f98f7ee64@kernel.org"
      type="cite">
      <pre wrap="">
</pre>
      <blockquote type="cite">
        <pre wrap="">+}
diff --git a/arch/powerpc/lib/sstep.c b/arch/powerpc/lib/sstep.c
index 3362299..c4b8259 100644
--- a/arch/powerpc/lib/sstep.c
+++ b/arch/powerpc/lib/sstep.c
@@ -2018,3 +2018,24 @@ int __kprobes emulate_step(struct pt_regs *regs, unsigned int instr)
 	regs-&gt;nip = truncate_if_32bit(regs-&gt;msr, regs-&gt;nip + 4);
 	return 1;
 }
+
+/* Before optimizing, ensure that the probed instruction is not a
+ * conditional branch instruction
+ */
+int __kprobes optprobe_conditional_branch_check(unsigned int instr)
+{
+	unsigned int opcode;
+
+	opcode = instr &gt;&gt; 26;
+	if (opcode == 16)
+		return 0;
+	if (opcode == 19) {
+		switch ((instr &gt;&gt; 1) &amp; 0x3ff) {
+		case 16:        /* bclr, bclrl */
+		case 528:       /* bcctr, bcctrl */
+		case 560:       /* bctar, bctarl */
+			return 0;
+		}
+	}
+	return 1;
+}
-- 
1.8.3.1

</pre>
      </blockquote>
      <pre wrap="">

</pre>
    </blockquote>
    <br>
  </body>
</html>

--------------22A023E59D0B2A24D5044014--

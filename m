Return-Path: <naveen.n.rao@linux.vnet.ibm.com>
Received: from e23smtp05.au.ibm.com (e23smtp05.au.ibm.com [202.81.31.147])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rDXrl4hNYzDq9n
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 May 2016 21:15:35 +1000 (AEST)
Received: from localhost
 by e23smtp05.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <naveen.n.rao@linux.vnet.ibm.com>;
 Tue, 24 May 2016 21:15:32 +1000
Received: from d23relay08.au.ibm.com (d23relay08.au.ibm.com [9.185.71.33])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id D83372BB0054
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 May 2016 21:15:28 +1000 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay08.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u4OBFKJL66912400
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 May 2016 21:15:28 +1000
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u4OBEtHI009919
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 May 2016 21:14:55 +1000
Date: Tue, 24 May 2016 16:44:11 +0530
From: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
To: Anju T <anju@linux.vnet.ibm.com>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 ananth@in.ibm.com, paulus@samba.org, srikar@linux.vnet.ibm.com,
 benh@kernel.crashing.org, mpe@ellerman.id.au,
 hemant@linux.vnet.ibm.com, mahesh@linux.vnet.ibm.com, mhiramat@kernel.org
Subject: Re: [RFC PATCH v2 1/3] arch/powerpc : Add detour buffer support for
 optprobes
Message-ID: <20160524111411.GB18654@naverao1-tp.localdomain>
References: <1463670640-25701-1-git-send-email-anju@linux.vnet.ibm.com>
 <1463670640-25701-2-git-send-email-anju@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1463670640-25701-2-git-send-email-anju@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 2016/05/19 08:40PM, Anju T wrote:
> Detour buffer contains instructions to create an in memory pt_regs.
> After the execution of prehandler a call is made for instruction emulation.
> The NIP is decided after the probed instruction is executed. Hence a branch
> instruction is created to the NIP returned by emulate_step().
> 
> Instruction slot for detour buffer is allocated from
> the reserved area. For the time being 64KB is reserved
> in memory for this purpose.
> 
> Signed-off-by: Anju T <anju@linux.vnet.ibm.com>
> ---
>  arch/powerpc/include/asm/kprobes.h   |  25 ++++++++
>  arch/powerpc/kernel/optprobes_head.S | 108 +++++++++++++++++++++++++++++++++++
>  2 files changed, 133 insertions(+)
>  create mode 100644 arch/powerpc/kernel/optprobes_head.S
> 
> diff --git a/arch/powerpc/include/asm/kprobes.h b/arch/powerpc/include/asm/kprobes.h
> index 039b583..3e4c998 100644
> --- a/arch/powerpc/include/asm/kprobes.h
> +++ b/arch/powerpc/include/asm/kprobes.h
> @@ -38,7 +38,25 @@ struct pt_regs;
>  struct kprobe;
> 
>  typedef ppc_opcode_t kprobe_opcode_t;
> +
> +extern kprobe_opcode_t optinsn_slot;
> +/* Optinsn template address */
> +extern kprobe_opcode_t optprobe_template_entry[];
> +extern kprobe_opcode_t optprobe_template_call_handler[];
> +extern kprobe_opcode_t optprobe_template_call_emulate[];
> +extern kprobe_opcode_t optprobe_template_ret_branch[];
> +extern kprobe_opcode_t optprobe_template_ret[];
> +extern kprobe_opcode_t optprobe_template_insn[];
> +extern kprobe_opcode_t optprobe_template_op_address1[];
> +extern kprobe_opcode_t optprobe_template_op_address2[];
> +extern kprobe_opcode_t optprobe_template_end[];
> +
>  #define MAX_INSN_SIZE 1
> +#define MAX_OPTIMIZED_LENGTH    4
> +#define MAX_OPTINSN_SIZE				\
> +	((unsigned long)&optprobe_template_end -	\
> +	(unsigned long)&optprobe_template_entry)
> +#define RELATIVEJUMP_SIZE       4
> 
>  #ifdef CONFIG_PPC64
>  #if defined(_CALL_ELF) && _CALL_ELF == 2
> @@ -129,5 +147,12 @@ struct kprobe_ctlblk {
>  extern int kprobe_exceptions_notify(struct notifier_block *self,
>  					unsigned long val, void *data);
>  extern int kprobe_fault_handler(struct pt_regs *regs, int trapnr);
> +
> +struct arch_optimized_insn {
> +	kprobe_opcode_t copied_insn[1];
> +	/* detour buffer */
> +	kprobe_opcode_t *insn;
> +};
> +
>  #endif /* __KERNEL__ */
>  #endif	/* _ASM_POWERPC_KPROBES_H */
> diff --git a/arch/powerpc/kernel/optprobes_head.S b/arch/powerpc/kernel/optprobes_head.S
> new file mode 100644
> index 0000000..ce32aec
> --- /dev/null
> +++ b/arch/powerpc/kernel/optprobes_head.S
> @@ -0,0 +1,108 @@
> +/*
> + * Code to prepare detour buffer for optprobes in kernel.
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
> +.global optinsn_slot
> +optinsn_slot:
> +	/* Reserve an area to allocate slots for detour buffer */
> +	.space	65536
> +.global optprobe_template_entry
> +optprobe_template_entry:
> +	stdu	r1,-INT_FRAME_SIZE(r1)
> +	SAVE_GPR(0,r1)
> +	/* Save the previous SP into stack */
> +	addi	r0,r1,INT_FRAME_SIZE
> +	std	0,GPR1(r1)
> +	SAVE_2GPRS(2,r1)
> +	SAVE_8GPRS(4,r1)
> +	SAVE_10GPRS(12,r1)
> +	SAVE_10GPRS(22,r1)
> +	/* Save SPRS */
> +	mfcfar	r5
> +	std	r5,_NIP(r1)

I think this will not work. Looking through the code, I don't see us 
saving/restoring CFAR across interrupts.

Also, per the ISA:
"The Come-From Address Register (CFAR) is a 64-bit
register. When an rfebb, rfid, or rfscv instruction is
executed, the register is set to the effective address of
the instruction."

So, it looks like we actually can't save/restore it anyway.

Regardless, NIP is the same as the kprobe'd address, so you should be 
able to either use immediate loads or load the address from kprobe 
structure.


- Naveen

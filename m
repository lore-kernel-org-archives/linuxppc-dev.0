Return-Path: <naveen.n.rao@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rJ9Q76SxtzDqPm
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 30 May 2016 18:53:35 +1000 (AEST)
Received: from pps.filterd (m0049461.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u4U8mYld003323
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 30 May 2016 04:53:33 -0400
Message-Id: <201605300853.u4U8mYld003323@mx0a-001b2d01.pphosted.com>
Received: from e23smtp01.au.ibm.com (e23smtp01.au.ibm.com [202.81.31.143])
 by mx0a-001b2d01.pphosted.com with ESMTP id 23784t65rd-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 30 May 2016 04:53:33 -0400
Received: from localhost
 by e23smtp01.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <naveen.n.rao@linux.vnet.ibm.com>;
 Mon, 30 May 2016 18:53:30 +1000
Received: from d23relay07.au.ibm.com (d23relay07.au.ibm.com [9.190.26.37])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id 101B42CE805A
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 30 May 2016 18:53:27 +1000 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay07.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u4U8rI1959113630
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 30 May 2016 18:53:26 +1000
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u4U8qrPw029733
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 30 May 2016 18:52:54 +1000
Date: Mon, 30 May 2016 14:21:57 +0530
From: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
To: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
Cc: Anju T <anju@linux.vnet.ibm.com>, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, ananth@in.ibm.com,
 mahesh@linux.vnet.ibm.com, paulus@samba.org, mhiramat@kernel.org,
 hemant@linux.vnet.ibm.com, srikar@linux.vnet.ibm.com
Subject: Re: [RFC PATCH v2 1/3] arch/powerpc : Add detour buffer support for
 optprobes
References: <1463670640-25701-1-git-send-email-anju@linux.vnet.ibm.com>
 <1463670640-25701-2-git-send-email-anju@linux.vnet.ibm.com>
 <201605241015.u4OAFAnB038915@mx0a-001b2d01.pphosted.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <201605241015.u4OAFAnB038915@mx0a-001b2d01.pphosted.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 2016/05/24 03:45PM, Madhavan Srinivasan wrote:
> 
> 
> On Thursday 19 May 2016 08:40 PM, Anju T wrote:
> > Detour buffer contains instructions to create an in memory pt_regs.
> > After the execution of prehandler a call is made for instruction emulation.
> > The NIP is decided after the probed instruction is executed. Hence a branch
> > instruction is created to the NIP returned by emulate_step().
> >
> > Instruction slot for detour buffer is allocated from
> > the reserved area. For the time being 64KB is reserved
> > in memory for this purpose.
> >
> > Signed-off-by: Anju T <anju@linux.vnet.ibm.com>
> > ---
> >  arch/powerpc/include/asm/kprobes.h   |  25 ++++++++
> >  arch/powerpc/kernel/optprobes_head.S | 108 +++++++++++++++++++++++++++++++++++
> >  2 files changed, 133 insertions(+)
> >  create mode 100644 arch/powerpc/kernel/optprobes_head.S
> >
> > diff --git a/arch/powerpc/include/asm/kprobes.h b/arch/powerpc/include/asm/kprobes.h
> > index 039b583..3e4c998 100644
> > --- a/arch/powerpc/include/asm/kprobes.h
> > +++ b/arch/powerpc/include/asm/kprobes.h
> > @@ -38,7 +38,25 @@ struct pt_regs;
> >  struct kprobe;
> >  
> >  typedef ppc_opcode_t kprobe_opcode_t;
> > +
> > +extern kprobe_opcode_t optinsn_slot;
> > +/* Optinsn template address */
> > +extern kprobe_opcode_t optprobe_template_entry[];
> > +extern kprobe_opcode_t optprobe_template_call_handler[];
> > +extern kprobe_opcode_t optprobe_template_call_emulate[];
> > +extern kprobe_opcode_t optprobe_template_ret_branch[];
> > +extern kprobe_opcode_t optprobe_template_ret[];
> > +extern kprobe_opcode_t optprobe_template_insn[];
> > +extern kprobe_opcode_t optprobe_template_op_address1[];
> > +extern kprobe_opcode_t optprobe_template_op_address2[];
> > +extern kprobe_opcode_t optprobe_template_end[];
> > +
> >  #define MAX_INSN_SIZE 1
> > +#define MAX_OPTIMIZED_LENGTH    4
> > +#define MAX_OPTINSN_SIZE				\
> > +	((unsigned long)&optprobe_template_end -	\
> > +	(unsigned long)&optprobe_template_entry)
> > +#define RELATIVEJUMP_SIZE       4
> >  
> >  #ifdef CONFIG_PPC64
> >  #if defined(_CALL_ELF) && _CALL_ELF == 2
> > @@ -129,5 +147,12 @@ struct kprobe_ctlblk {
> >  extern int kprobe_exceptions_notify(struct notifier_block *self,
> >  					unsigned long val, void *data);
> >  extern int kprobe_fault_handler(struct pt_regs *regs, int trapnr);
> > +
> > +struct arch_optimized_insn {
> > +	kprobe_opcode_t copied_insn[1];
> > +	/* detour buffer */
> > +	kprobe_opcode_t *insn;
> > +};
> > +
> >  #endif /* __KERNEL__ */
> >  #endif	/* _ASM_POWERPC_KPROBES_H */
> > diff --git a/arch/powerpc/kernel/optprobes_head.S b/arch/powerpc/kernel/optprobes_head.S
> > new file mode 100644
> > index 0000000..ce32aec
> > --- /dev/null
> > +++ b/arch/powerpc/kernel/optprobes_head.S
> > @@ -0,0 +1,108 @@
> > +/*
> > + * Code to prepare detour buffer for optprobes in kernel.
> > + *
> > + * Copyright 2016, Anju T, IBM Corp.
> > + *
> > + * This program is free software; you can redistribute it and/or
> > + * modify it under the terms of the GNU General Public License
> > + * as published by the Free Software Foundation; either version
> > + * 2 of the License, or (at your option) any later version.
> > + */
> > +
> > +#include <asm/ppc_asm.h>
> > +#include <asm/ptrace.h>
> > +#include <asm/asm-offsets.h>
> > +

You should also add an align directive here:

.align 2

> > +.global optinsn_slot
> > +optinsn_slot:
> > +	/* Reserve an area to allocate slots for detour buffer */
> > +	.space	65536
> 
> Can we replace "65536" with SLOT_SIZE?

Yes, a macro will be good to have.

> 
> > +.global optprobe_template_entry
> > +optprobe_template_entry:
> > +	stdu	r1,-INT_FRAME_SIZE(r1)
> > +	SAVE_GPR(0,r1)
> > +	/* Save the previous SP into stack */
> > +	addi	r0,r1,INT_FRAME_SIZE
> > +	std	0,GPR1(r1)
> > +	SAVE_2GPRS(2,r1)
> > +	SAVE_8GPRS(4,r1)
> > +	SAVE_10GPRS(12,r1)
> > +	SAVE_10GPRS(22,r1)
> > +	/* Save SPRS */
> > +	mfcfar	r5
> > +	std	r5,_NIP(r1)
> > +	mfmsr	r5
> > +	std	r5,_MSR(r1)
> > +	mfctr	r5
> > +	std	r5,_CTR(r1)
> > +	mflr	r5
> > +	std	r5,_LINK(r1)
> > +	mfspr	r5,SPRN_XER
> > +	std	r5,_XER(r1)
> > +	li	r5,0
> > +	std	r5,_TRAP(r1)
> > +	mfdar	r5
> > +	std	r5,_DAR(r1)
> > +	mfdsisr	r5
> > +	std	r5,_DSISR(r1)
> 
> We are missing _CCR (CR register)?

Yes, and I think we need to ensure we fill reasonable values for all 
registers in pt_regs including softe (from paca), orig_gpr3 (0?) and 
result (0).

> 
> Why tab space for the comment? and
> a new line before the command will be good

... new line before *each section* will be good :)

> 
> > +	/* Pass parameters for optimized_callback */
> > +.global optprobe_template_op_address1
> > +optprobe_template_op_address1:

So, the general style is to align labels at the start of a line and to 
align everything else as per the code indentation.

In this case though, I think it's best to use a macro for better 
readability. Something like:

#define _GLOB(name)	.global name;		\
			name:


- Naveen

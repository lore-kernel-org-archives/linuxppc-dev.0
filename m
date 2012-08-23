Return-Path: <srikar@linux.vnet.ibm.com>
Received: from e23smtp07.au.ibm.com (e23smtp07.au.ibm.com [202.81.31.140])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e23smtp07.au.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 0412F2C009A
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 23 Aug 2012 15:34:23 +1000 (EST)
Received: from /spool/local
 by e23smtp07.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <srikar@linux.vnet.ibm.com>;
 Thu, 23 Aug 2012 15:33:08 +1000
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay03.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 q7N5YFsf27852906
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 23 Aug 2012 15:34:16 +1000
Received: from d23av04.au.ibm.com (loopback [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 q7N5YEGB015524
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 23 Aug 2012 15:34:15 +1000
Date: Thu, 23 Aug 2012 11:02:34 +0530
From: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
To: Michael Ellerman <michael@ellerman.id.au>
Subject: Re: [PATCH v4 2/2] powerpc: Uprobes port to powerpc
Message-ID: <20120823053234.GE25338@linux.vnet.ibm.com>
References: <20120822082205.GA29216@in.ibm.com>
 <20120822082708.GB29216@in.ibm.com>
 <1345696100.3338.21.camel@concordia>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <1345696100.3338.21.camel@concordia>
Cc: peterz@infradead.org, lkml <linux-kernel@vger.kernel.org>, oleg@redhat.com,
 Paul Mackerras <paulus@samba.org>, Anton Blanchard <anton@samba.org>,
 Ingo Molnar <mingo@elte.hu>, ppcdev <linuxppc-dev@lists.ozlabs.org>
Reply-To: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

> 
> These seem to be duplicated in kprobes.h, can we consolidate them.
> 
> > +struct arch_uprobe {
> > +	u8	insn[MAX_UINSN_BYTES];
> > +};
> 
> Why not uprobe_opcode_t insn ?
> 

insn is updated/accessed in the arch independent code. Size of
uprobe_opcode_t could be different for different archs. uprobe_opcode_t
represents the size of the smallest breakpoint instruction for an arch.

Hence u8 works out the best. I know we could still use uprobe_opcode_t
and achieve the same. In which case, we would have to interpret
MAX_UINSN_BYTES differently. Do you see any advantages of using
uprobe_opcode_t instead of u8 across archs?

> 
> >  void do_notify_resume(struct pt_regs *regs, unsigned long thread_info_flags)
> >  {
> > +	if (thread_info_flags & _TIF_UPROBE) {
> > +		clear_thread_flag(TIF_UPROBE);
> > +		uprobe_notify_resume(regs);
> > +	}
> 
> Presumably this ordering is crucial, ie. uprobes before signals.
> 

Yes, we would want uprobes to have a say before do_signal can take a
look.

> 
> 
> I am probably missing something, but why do we need to execute out of
> line?
> 


The other alternative to execute out of line is the current inline
singlestepping. In inline singlestepping, we would have to guard other
tasks from executing the same instruction. 

Executing out of line solves this problem.

> > +/*
> > + * arch_uprobe_pre_xol - prepare to execute out of line.
> > + * @auprobe: the probepoint information.
> > + * @regs: reflects the saved user state of current task.
> > + */
> > +int arch_uprobe_pre_xol(struct arch_uprobe *auprobe, struct pt_regs *regs)
> > +{
> > +	struct arch_uprobe_task *autask = &current->utask->autask;
> > +
> > +	autask->saved_trap_nr = current->thread.trap_nr;
> > +	current->thread.trap_nr = UPROBE_TRAP_NR;
> > +	regs->nip = current->utask->xol_vaddr;
> > +	return 0;
> > +}
> > +
> > +/**
> > + * uprobe_get_swbp_addr - compute address of swbp given post-swbp regs
> > + * @regs: Reflects the saved state of the task after it has hit a breakpoint
> > + * instruction.
> > + * Return the address of the breakpoint instruction.
> > + */
> > +unsigned long uprobe_get_swbp_addr(struct pt_regs *regs)
> > +{
> > +	return instruction_pointer(regs);
> > +}
> 
> This seems like it would be better in asm/uprobes.h as a static inline,
> but that's not your fault.
> 

We want archs to override uprobe_get_swbp_addr() if the default
uprobe_get_swbp_addr() doesnt suite for a particular arch. Do you have
better ways to achieve this. Initially we were using arch specific
callbacks from which we moved to using weak functions based on reviews.

> > +	/*
> > +	 * emulate_step() returns 1 if the insn was successfully emulated.
> > +	 * For all other cases, we need to single-step in hardware.
> > +	 */
> > +	ret = emulate_step(regs, insn);
> > +	if (ret > 0)
> > +		return true;
> 
> This actually emulates the instruction, ie. the contents of regs are
> changed based on the instruction.
> 
> That seems to differ vs x86, where arch_uprobe_skip_sstep() just checks
> the instruction and returns true/false. Is that because on x86 they are
> only returning true for nops? ie. there is no emulation to be done?
> 

Yes, In x86, we currently support skip for nop instructions, Once we add
code for skipping other instructions in x86, we could enhance them to
skip them too.

> It's a little surprising that can_skip_sstep() actually emulates the
> instruction, but again that's not your fault.
> 

Are you saying its doing more than what the name suggests or to the fact
that can_skip_step should ideally be called just once?

-- 
Thanks and Regards
Srikar

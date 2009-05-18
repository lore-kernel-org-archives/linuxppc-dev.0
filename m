Return-Path: <prasad@linux.vnet.ibm.com>
Received: from e23smtp06.au.ibm.com (e23smtp06.au.ibm.com [202.81.31.148])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e23smtp06.au.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id AD403DE09B
	for <linuxppc-dev@ozlabs.org>; Tue, 19 May 2009 02:11:05 +1000 (EST)
Received: from d23relay01.au.ibm.com (d23relay01.au.ibm.com [202.81.31.243])
	by e23smtp06.au.ibm.com (8.13.1/8.13.1) with ESMTP id n4IGB3lX031852
	for <linuxppc-dev@ozlabs.org>; Tue, 19 May 2009 02:11:03 +1000
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
	by d23relay01.au.ibm.com (8.13.8/8.13.8/NCO v9.2) with ESMTP id
	n4IGB42T401442
	for <linuxppc-dev@ozlabs.org>; Tue, 19 May 2009 02:11:04 +1000
Received: from d23av04.au.ibm.com (loopback [127.0.0.1])
	by d23av04.au.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	n4IGB3K5009006
	for <linuxppc-dev@ozlabs.org>; Tue, 19 May 2009 02:11:04 +1000
Date: Mon, 18 May 2009 21:40:55 +0530
From: "K.Prasad" <prasad@linux.vnet.ibm.com>
To: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [RFC Patch 2/6] Introduce PPC64 specific Hardware
	Breakpointinterfaces
Message-ID: <20090518161055.GA27641@in.ibm.com>
References: <20090514195044.GD30963@in.ibm.com>
	<Pine.LNX.4.44L0.0905141614360.4344-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <Pine.LNX.4.44L0.0905141614360.4344-100000@iolanthe.rowland.org>
Cc: Michael Neuling <mikey@neuling.org>,
	Benjamin Herrenschmidt <benh@au1.ibm.com>,
	linuxppc-dev@ozlabs.org, paulus@samba.org,
	Roland McGrath <roland@redhat.com>
Reply-To: prasad@linux.vnet.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, May 14, 2009 at 04:20:04PM -0400, Alan Stern wrote:
> On Fri, 15 May 2009, K.Prasad wrote:
> 
> > I see that you're referring to this code in __switch_to() :
> >         if (unlikely(__get_cpu_var(current_dabr) != new->thread.dabr))
> >                 set_dabr(new->thread.dabr);
> > 
> > arch_install_thread_hw_breakpoint()<--switch_to_thread_hw_breakpoint()
> > <--__switch_to() implementation is also similar.
> > 
> > In __switch_to(),
> >                 if (unlikely(test_tsk_thread_flag(new, TIF_DEBUG)))
> >                         switch_to_thread_hw_breakpoint(new);
> > 
> > happens only when TIF_DEBUG flag is set. This flag is cleared when the
> > process unregisters any breakpoints it had requested earlier. So, the
> > set_dabr() call is avoided for processes not using the debug register.
> 
> In the x86 code, shouldn't arch_update_user_hw_breakpoint set or clear
> TIF_DEBUG, depending on whether or not there are any user breakpoints
> remaining?
>

Yes. There's a bigger issue in setting TIF_DEBUG flag through ptrace
code. It should instead be done in register_user_hw_breakpoint() and
removed through unregister_user_hw_breakpoint() when the last breakpoint
request is being unregistered.

The unregister_user_hw_breakpoint() code should be like this:

void unregister_user_hw_breakpoint(struct task_struct *tsk,
						struct hw_breakpoint *bp)
{
	struct thread_struct *thread = &(tsk->thread);
	int i, pos = -1, clear_tsk_debug_counter = 0;

	spin_lock_bh(&hw_breakpoint_lock);
	for (i = 0; i < hbp_kernel_pos; i++) {
		if (thread->hbp[i])
			clear_tsk_debug_counter++;
		if (bp == thread->hbp[i]) {
			clear_tsk_debug_counter--;
			pos = i;
		}
	}
	if (pos >= 0)
		__unregister_user_hw_breakpoint(pos, tsk);

	if (!clear_tsk_debug_counter)
		clear_tsk_thread_flag(tsk, TIF_DEBUG);

	spin_unlock_bh(&hw_breakpoint_lock);
}

It needs modification in the generic HW Breakpoint code. I'm planning to
submit this as a patch over the earlier patchset (after it is pulled
into -tip tree).
 
> > > > +int __kprobes hw_breakpoint_handler(struct die_args *args)
> > > > +{
> > > > +	int rc = NOTIFY_STOP;
> > > > +	struct hw_breakpoint *bp;
> > > > +	struct pt_regs *regs = args->regs;
> > > > +	unsigned long dar;
> > > > +	int cpu, stepped, is_kernel;
> > > > +
> > > > +	/* Disable breakpoints during exception handling */
> > > > +	set_dabr(0);
> > > > +
> > > > +	dar = regs->dar & (~HW_BREAKPOINT_ALIGN);
> > > > +	is_kernel = (dar >= TASK_SIZE) ? 1 : 0;
> > > 
> > > is_kernel_addr() ?
> > > 
> > 
> > Ok.
> 
> Shouldn't this test hbp_kernel_pos instead?
> 

Testing hbp_kernel_pos should be sufficient for PPC64 with just one
breakpoint register. However the above code is more extensible to other
PowerPC implementations which have more than one breakpoint register.

> > > > +	if (is_kernel)
> > > > +		bp = hbp_kernel[0];
> > > > +	else {
> > > > +		bp = current->thread.hbp[0];
> > > > +		/* Lazy debug register switching */
> > > > +		if (!bp)
> > > > +			return rc;
> 
> Shouldn't this test be moved outside the "if" statement, as in the x86 
> code?
> 

Yes, I will do it. Another error here is the return code when exception
is raised from user-space address due to lazy debug register switching.
The return code should be NOTIFY_STOP (and not NOTIFY_DONE) since the
exception is a stray one and we don't want it to be propogated as a
signal to user-space. This change is required in both x86 and PPC64. I
will submit the x86 change as a separate patch.

> Alan Stern
> 

Thanks,
K.Prasad

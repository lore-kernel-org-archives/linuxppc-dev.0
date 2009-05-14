Return-Path: <stern+4a1a87d0@rowland.harvard.edu>
Received: from iolanthe.rowland.org (iolanthe.rowland.org [192.131.102.54])
	by ozlabs.org (Postfix) with SMTP id 7772ADE050
	for <linuxppc-dev@ozlabs.org>; Fri, 15 May 2009 06:26:46 +1000 (EST)
Date: Thu, 14 May 2009 16:20:04 -0400 (EDT)
From: Alan Stern <stern@rowland.harvard.edu>
To: "K.Prasad" <prasad@linux.vnet.ibm.com>
Subject: Re: [RFC Patch 2/6] Introduce PPC64 specific Hardware
	Breakpointinterfaces
In-Reply-To: <20090514195044.GD30963@in.ibm.com>
Message-ID: <Pine.LNX.4.44L0.0905141614360.4344-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Michael Neuling <mikey@neuling.org>,
	Benjamin Herrenschmidt <benh@au1.ibm.com>,
	linuxppc-dev@ozlabs.org, paulus@samba.org,
	Roland McGrath <roland@redhat.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, 15 May 2009, K.Prasad wrote:

> I see that you're referring to this code in __switch_to() :
>         if (unlikely(__get_cpu_var(current_dabr) != new->thread.dabr))
>                 set_dabr(new->thread.dabr);
> 
> arch_install_thread_hw_breakpoint()<--switch_to_thread_hw_breakpoint()
> <--__switch_to() implementation is also similar.
> 
> In __switch_to(),
>                 if (unlikely(test_tsk_thread_flag(new, TIF_DEBUG)))
>                         switch_to_thread_hw_breakpoint(new);
> 
> happens only when TIF_DEBUG flag is set. This flag is cleared when the
> process unregisters any breakpoints it had requested earlier. So, the
> set_dabr() call is avoided for processes not using the debug register.

In the x86 code, shouldn't arch_update_user_hw_breakpoint set or clear
TIF_DEBUG, depending on whether or not there are any user breakpoints
remaining?

> > > +int __kprobes hw_breakpoint_handler(struct die_args *args)
> > > +{
> > > +	int rc = NOTIFY_STOP;
> > > +	struct hw_breakpoint *bp;
> > > +	struct pt_regs *regs = args->regs;
> > > +	unsigned long dar;
> > > +	int cpu, stepped, is_kernel;
> > > +
> > > +	/* Disable breakpoints during exception handling */
> > > +	set_dabr(0);
> > > +
> > > +	dar = regs->dar & (~HW_BREAKPOINT_ALIGN);
> > > +	is_kernel = (dar >= TASK_SIZE) ? 1 : 0;
> > 
> > is_kernel_addr() ?
> > 
> 
> Ok.

Shouldn't this test hbp_kernel_pos instead?

> > > +	if (is_kernel)
> > > +		bp = hbp_kernel[0];
> > > +	else {
> > > +		bp = current->thread.hbp[0];
> > > +		/* Lazy debug register switching */
> > > +		if (!bp)
> > > +			return rc;

Shouldn't this test be moved outside the "if" statement, as in the x86 
code?

Alan Stern

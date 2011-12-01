Return-Path: <prasad@linux.vnet.ibm.com>
Received: from e24smtp03.br.ibm.com (e24smtp03.br.ibm.com [32.104.18.24])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e24smtp03.br.ibm.com", Issuer "GeoTrust SSL CA" (verified OK))
 by ozlabs.org (Postfix) with ESMTPS id A7B4B1007D1
 for <linuxppc-dev@ozlabs.org>; Thu,  1 Dec 2011 21:20:35 +1100 (EST)
Received: from /spool/local
 by e24smtp03.br.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <prasad@linux.vnet.ibm.com>;
 Thu, 1 Dec 2011 08:20:21 -0200
Received: from d24av05.br.ibm.com (d24av05.br.ibm.com [9.18.232.44])
 by d24relay01.br.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 pB1AHiOs3469408
 for <linuxppc-dev@ozlabs.org>; Thu, 1 Dec 2011 07:17:44 -0300
Received: from d24av05.br.ibm.com (loopback [127.0.0.1])
 by d24av05.br.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 pB1AKFR7028085
 for <linuxppc-dev@ozlabs.org>; Thu, 1 Dec 2011 08:20:16 -0200
Date: Thu, 1 Dec 2011 15:50:00 +0530
From: "K.Prasad" <prasad@linux.vnet.ibm.com>
To: linuxppc-dev@ozlabs.org, David Gibson <dwg@au1.ibm.com>
Subject: Re: [PATCH 1/2] [hw-breakpoint] Use generic hw-breakpoint interfaces
 for new PPC ptrace flags
Message-ID: <20111201102000.GB2632@in.ibm.com>
References: <20110819074527.GA21817@in.ibm.com>
 <20110819075136.GB21817@in.ibm.com>
 <20110823050850.GS30097@yookeroo.fritz.box>
 <20110823092513.GA2962@in.ibm.com>
 <20110824035939.GB30097@yookeroo.fritz.box>
 <20110826093552.GA2301@in.ibm.com>
 <20110916072710.GA28060@in.ibm.com>
 <20111012033359.GR4849@truffala.fritz.box>
 <20111012173948.GA4340@in.ibm.com>
 <20111128031111.GC3508@truffala.fritz.box>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20111128031111.GC3508@truffala.fritz.box>
Cc: linuxppc-dev@ozlabs.org, Thiago Jung Bauermann <bauerman@br.ibm.com>,
 Edjunior Barbosa Machado <emachado@linux.vnet.ibm.com>
Reply-To: prasad@linux.vnet.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Nov 28, 2011 at 02:11:11PM +1100, David Gibson wrote:
> [snip]
> On Wed, Oct 12, 2011 at 11:09:48PM +0530, K.Prasad wrote:
> > > > +	if (bp) {
> > > > +		attr = bp->attr;
> > > > +		attr.bp_addr = (unsigned long)bp_info->addr & ~HW_BREAKPOINT_ALIGN;
> > > > +		arch_bp_generic_fields(dabr &
> > > > +					(DABR_DATA_WRITE | DABR_DATA_READ),
> > > > +							&attr.bp_type);
> > > > +		attr.bp_len = len;
> > > 
> > > If gdb is using the new breakpoint interface, surely it should just
> > > use it, rather than doing this bit frobbing as in the old SET_DABR
> > > call.
> > > 
> > 
> > I understand that you wanted to avoid this duplication of effort in terms
> > of encoding and decoding the breakpoint type from
> > PPC_BREAKPOINT_TRIGGER_READ to DABR_DATA_READ to HW_BREAKPOINT_R.
> > 
> > However HW_BREAKPOINT_R is a generic definition used across
> > architectures, DABR_DATA_READ is used in the !CONFIG_HAVE_HW_BREAKPOINT
> > case while PPC_BREAKPOINT_TRIGGER_READ is used in
> > CONFIG_PPC_ADV_DEBUG_REGS case.
> > 
> > While we could define PPC_BREAKPOINT_TRIGGER_READ and DABR_DATA_READ to
> > the same value it may not result in any code savings (since the bit
> > translation is done for !CONFIG_HAVE_HW_BREAKPOINT case anyway). So, I
> > think it is best left the way it is.
> 
> That's not what I'm suggesting.  What I'm saying is that ig userspace
> is using the new generic interface, then it should just set the
> bp_type field, and it should not use the DABR_DATA_{READ,WRITE} bits.
> The DABR_DATA bits should *only* be processed in the legacy interface,
> never in the generic interface.
> 

The DABR_DATA_{READ,WRITE} bits are neither set by the user, nor
expected by the hw-breakpoint interface. It is an intermediate code used
to re-use the arch_bp_generic_fields function. We could convert directly
from PPC_BREAKPOINT_TRIGGER_READ to HW_BREAKPOINT_R (using a switch-case)
but that may not result in any code savings.

DABR_DATA_{READ,WRITE} is indeed legacy and cannot be set by user-space
for a PPC_PTRACE_SETHWDEBUG + CONFIG_HAVE_HW_BREAKPOINT combination.

[snipped]

> > diff --git a/Documentation/powerpc/ptrace.txt b/Documentation/powerpc/ptrace.txt
> > index f4a5499..f2a7a39 100644
> > --- a/Documentation/powerpc/ptrace.txt
> > +++ b/Documentation/powerpc/ptrace.txt
> > @@ -127,6 +127,22 @@ Some examples of using the structure to:
> >    p.addr2           = (uint64_t) end_range;
> >    p.condition_value = 0;
> >  
> > +- set a watchpoint in server processors (BookS)
> > +
> > +  p.version         = 1;
> > +  p.trigger_type    = PPC_BREAKPOINT_TRIGGER_RW;
> > +  p.addr_mode       = PPC_BREAKPOINT_MODE_RANGE_INCLUSIVE;
> > +  or
> > +  p.addr_mode       = PPC_BREAKPOINT_MODE_EXACT;
> > +
> > +  p.condition_mode  = PPC_BREAKPOINT_CONDITION_NONE;
> > +  p.addr            = (uint64_t) begin_range;
> 
> You should probably document the alignment constraint on the address
> here, too.
> 

Alignment constraints will be learnt by the user-space during runtime.
We provide that as part of 'struct ppc_debug_info' in
'data_bp_alignment' field.

While the alignment is always 8-bytes for BookS, I think userspace
should be left to learn it through PTRACE_PPC_GETHWDEBUGINFO.

> > +  /* For PPC_BREAKPOINT_MODE_RANGE_INCLUSIVE addr2 needs to be specified, where
> > +   * addr2 - addr <= 8 Bytes.
> > +   */
> > +  p.addr2           = (uint64_t) end_range;
> > +  p.condition_value = 0;
> > +
> >  3. PTRACE_DELHWDEBUG
> >  
> >  Takes an integer which identifies an existing breakpoint or watchpoint
> > diff --git a/arch/powerpc/kernel/ptrace.c b/arch/powerpc/kernel/ptrace.c
> > index 05b7dd2..be5dc57 100644
> > --- a/arch/powerpc/kernel/ptrace.c
> > +++ b/arch/powerpc/kernel/ptrace.c
> > @@ -1339,6 +1339,12 @@ static int set_dac_range(struct task_struct *child,
> >  static long ppc_set_hwdebug(struct task_struct *child,
> >  		     struct ppc_hw_breakpoint *bp_info)
> >  {
> > +#ifdef CONFIG_HAVE_HW_BREAKPOINT
> > +	int ret, len = 0;
> > +	struct thread_struct *thread = &(child->thread);
> > +	struct perf_event *bp;
> > +	struct perf_event_attr attr;
> > +#endif /* CONFIG_HAVE_HW_BREAKPOINT */
> >  #ifndef CONFIG_PPC_ADV_DEBUG_REGS
> >  	unsigned long dabr;
> >  #endif
> > @@ -1382,13 +1388,9 @@ static long ppc_set_hwdebug(struct task_struct *child,
> >  	 */
> >  	if ((bp_info->trigger_type & PPC_BREAKPOINT_TRIGGER_RW) == 0 ||
> >  	    (bp_info->trigger_type & ~PPC_BREAKPOINT_TRIGGER_RW) != 0 ||
> > -	    bp_info->addr_mode != PPC_BREAKPOINT_MODE_EXACT ||
> >  	    bp_info->condition_mode != PPC_BREAKPOINT_CONDITION_NONE)
> >  		return -EINVAL;
> >  
> > -	if (child->thread.dabr)
> > -		return -ENOSPC;
> > -
> >  	if ((unsigned long)bp_info->addr >= TASK_SIZE)
> >  		return -EIO;
> >  
> > @@ -1398,15 +1400,75 @@ static long ppc_set_hwdebug(struct task_struct *child,
> >  		dabr |= DABR_DATA_READ;
> >  	if (bp_info->trigger_type & PPC_BREAKPOINT_TRIGGER_WRITE)
> >  		dabr |= DABR_DATA_WRITE;
> > +#ifdef CONFIG_HAVE_HW_BREAKPOINT
> > +	if (ptrace_get_breakpoints(child) < 0)
> > +		return -ESRCH;
> >  
> > -	child->thread.dabr = dabr;
> > +	/*
> > +	 * Check if the request is for 'range' breakpoints. We can
> > +	 * support it if range < 8 bytes.
> > +	 */
> > +	if (bp_info->addr_mode == PPC_BREAKPOINT_MODE_RANGE_INCLUSIVE) {
> > +		len = bp_info->addr2 - bp_info->addr;
> > +	} else if (bp_info->addr_mode != PPC_BREAKPOINT_MODE_EXACT) {
> > +			ptrace_put_breakpoints(child);
> > +			return -EINVAL;
> 
> You are overindented here.

I must have been confused!...Even scripts/checkpath.pl didn't throw an error
at this line. Will correct it.

> > +	}
> > +	bp = thread->ptrace_bps[0];
> > +	if (bp) {
> > +		attr = bp->attr;
> > +		attr.bp_addr = (unsigned long)bp_info->addr & ~HW_BREAKPOINT_ALIGN;
> > +		arch_bp_generic_fields(dabr &
> > +					(DABR_DATA_WRITE | DABR_DATA_READ),
> > +							&attr.bp_type);
> 
> You still have this code which has no business in the generic
> interface path.


Same explanation as above. If I have to avoid the call to
arch_bp_generic_fields() then, it should be replaced with

switch(bp_info->trigger_type) {

case PPC_BREAKPOINT_TRIGGER_READ:
	attr.bp_type = HW_BREAKPOINT_R;

case PPC_BREAKPOINT_TRIGGER_WRITE:
	attr.bp_type = HW_BREAKPOINT_W;

case PPC_BREAKPOINT_TRIGGER_RW:
	attr.bp_type = (HW_BREAKPOINT_W | HW_BREAKPOINT_R);
}

All these additional lines for no extra benefit (or I haven't
still understood your comments fully).

> > +		attr.bp_len = len;
> > +		ret =  modify_user_hw_breakpoint(bp, &attr);
> > +		if (ret) {
> > +			ptrace_put_breakpoints(child);
> > +			return ret;
> > +		}
> 
> If a bp already exists, you're modifying it.  I thought the semantics
> of the new interface meant that you shoul return ENOSPC in this case,
> and a DEL would be necessary before adding another breakpoint.
> 

I'm not too sure what would be the desired behaviour for this interface,
either way is fine with me. I'd like to hear from the GDB folks (copied
in this email) to know what would please them.
 
> > +		thread->ptrace_bps[0] = bp;
> > +		ptrace_put_breakpoints(child);
> > +		thread->dabr = dabr;
> > +		return 0;
> > +	}
> > +
> > +	/* Create a new breakpoint request if one doesn't exist already */
> > +	hw_breakpoint_init(&attr);
> > +	attr.bp_addr = (unsigned long)bp_info->addr & ~HW_BREAKPOINT_ALIGN;
> > +	attr.bp_len = len;
> > +	arch_bp_generic_fields(dabr & (DABR_DATA_WRITE | DABR_DATA_READ),
> > +								&attr.bp_type);
> > +
> > +	thread->ptrace_bps[0] = bp = register_user_hw_breakpoint(&attr,
> > +					       ptrace_triggered, NULL, child);
> > +	if (IS_ERR(bp)) {
> > +		thread->ptrace_bps[0] = NULL;
> > +		ptrace_put_breakpoints(child);
> > +		return PTR_ERR(bp);
> > +	}
> >  
> > +	ptrace_put_breakpoints(child);
> > +	return 1;
> > +#endif /* CONFIG_HAVE_HW_BREAKPOINT */
> > +
> > +	if (bp_info->addr_mode != PPC_BREAKPOINT_MODE_EXACT)
> > +		return -EINVAL;
> > +
> > +	if (child->thread.dabr)
> > +		return -ENOSPC;
> > +
> > +	child->thread.dabr = dabr;
> >  	return 1;
> >  #endif /* !CONFIG_PPC_ADV_DEBUG_DVCS */
> >  }
> >  
> >  static long ppc_del_hwdebug(struct task_struct *child, long addr, long data)
> >  {
> > +#ifdef CONFIG_HAVE_HW_BREAKPOINT
> > +	struct thread_struct *thread = &(child->thread);
> > +	struct perf_event *bp;
> > +#endif /* CONFIG_HAVE_HW_BREAKPOINT */
> >  #ifdef CONFIG_PPC_ADV_DEBUG_REGS
> >  	int rc;
> >  
> > @@ -1426,10 +1488,24 @@ static long ppc_del_hwdebug(struct task_struct *child, long addr, long data)
> >  #else
> >  	if (data != 1)
> >  		return -EINVAL;
> > +
> > +#ifdef CONFIG_HAVE_HW_BREAKPOINT
> > +	if (ptrace_get_breakpoints(child) < 0)
> > +		return -ESRCH;
> > +
> > +	bp = thread->ptrace_bps[0];
> > +	if (bp) {
> > +		unregister_hw_breakpoint(bp);
> > +		thread->ptrace_bps[0] = NULL;
> > +	}
> > +	ptrace_put_breakpoints(child);
> > +	return 0;
> 
> Shouldn't DEL return an error if there is no existing bp.
>

Same comment as above. We'd like to know what behaviour would help the
GDB use this interface better as there's no right or wrong way here.

Thanks again for your patient review. I will post the modified patch
after hearing comments from all.

Thanks.
K.Prasad

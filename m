Return-Path: <prasad@linux.vnet.ibm.com>
Received: from e28smtp07.in.ibm.com (e28smtp07.in.ibm.com [122.248.162.7])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e28smtp07.in.ibm.com",
	Issuer "GeoTrust SSL CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 88CE8B6F85
	for <linuxppc-dev@ozlabs.org>; Tue, 23 Aug 2011 19:25:23 +1000 (EST)
Received: from d28relay01.in.ibm.com (d28relay01.in.ibm.com [9.184.220.58])
	by e28smtp07.in.ibm.com (8.14.4/8.13.1) with ESMTP id p7N9PHvN002611
	for <linuxppc-dev@ozlabs.org>; Tue, 23 Aug 2011 14:55:17 +0530
Received: from d28av02.in.ibm.com (d28av02.in.ibm.com [9.184.220.64])
	by d28relay01.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	p7N9PHA24374730
	for <linuxppc-dev@ozlabs.org>; Tue, 23 Aug 2011 14:55:17 +0530
Received: from d28av02.in.ibm.com (loopback [127.0.0.1])
	by d28av02.in.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
	p7N9PGr6029420
	for <linuxppc-dev@ozlabs.org>; Tue, 23 Aug 2011 19:25:16 +1000
Date: Tue, 23 Aug 2011 14:55:13 +0530
From: "K.Prasad" <prasad@linux.vnet.ibm.com>
To: linuxppc-dev@ozlabs.org, Thiago Jung Bauermann <bauerman@br.ibm.com>,
	Edjunior Barbosa Machado <emachado@linux.vnet.ibm.com>
Subject: Re: [PATCH 1/2] [hw-breakpoint] Use generic hw-breakpoint interfaces
	for new PPC ptrace flags
Message-ID: <20110823092513.GA2962@in.ibm.com>
References: <20110819074527.GA21817@in.ibm.com>
	<20110819075136.GB21817@in.ibm.com>
	<20110823050850.GS30097@yookeroo.fritz.box>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20110823050850.GS30097@yookeroo.fritz.box>
Reply-To: prasad@linux.vnet.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Aug 23, 2011 at 03:08:50PM +1000, David Gibson wrote:
> On Fri, Aug 19, 2011 at 01:21:36PM +0530, K.Prasad wrote:
> > PPC_PTRACE_GETHWDBGINFO, PPC_PTRACE_SETHWDEBUG and PPC_PTRACE_DELHWDEBUG are
> > PowerPC specific ptrace flags that use the watchpoint register. While they are
> > targeted primarily towards BookE users, user-space applications such as GDB
> > have started using them for BookS too.
> > 
> > This patch enables the use of generic hardware breakpoint interfaces for these
> > new flags. The version number of the associated data structures
> > "ppc_hw_breakpoint" and "ppc_debug_info" is incremented to denote new semantics.
> 
> So, the structure itself doesn't seem to have been extended.  I don't
> understand what the semantic difference is - your patch comment needs
> to explain this clearly.
>

We had a request to extend the structure but thought it was dangerous to
do so. For instance if the user-space used version1 of the structure,
while kernel did a copy_to_user() pertaining to version2, then we'd run
into problems. Unfortunately the ptrace flags weren't designed to accept
a version number as input from the user through the
PPC_PTRACE_GETHWDBGINFO flag (which would have solved this issue).

I'll add a comment w.r.t change in semantics - such as the ability to
accept 'range' breakpoints in BookS.
 
> > Apart from the usual benefits of using generic hw-breakpoint interfaces, these
> > changes allow debuggers (such as GDB) to use a common set of ptrace flags for
> > their watchpoint needs and allow more precise breakpoint specification (length
> > of the variable can be specified).
> 
> What is the mechanism for implementing the range breakpoint on book3s?
> 

The hw-breakpoint interface, accepts length as an argument in BookS (any
value <= 8 Bytes) and would filter out extraneous interrupts arising out
of accesses outside the range comprising <addr, addr + len> inside
hw_breakpoint_handler function.

We put that ability to use here.

> > [Edjunior: Identified an issue in the patch with the sanity check for version
> > numbers]
> > 
> > Tested-by: Edjunior Barbosa Machado <emachado@linux.vnet.ibm.com>
> > Signed-off-by: K.Prasad <prasad@linux.vnet.ibm.com>
> > ---
> >  Documentation/powerpc/ptrace.txt |   16 ++++++
> >  arch/powerpc/kernel/ptrace.c     |  104 +++++++++++++++++++++++++++++++++++---
> >  2 files changed, 112 insertions(+), 8 deletions(-)
> > 
> > diff --git a/Documentation/powerpc/ptrace.txt b/Documentation/powerpc/ptrace.txt
> > index f4a5499..97301ae 100644
> > --- a/Documentation/powerpc/ptrace.txt
> > +++ b/Documentation/powerpc/ptrace.txt
> > @@ -127,6 +127,22 @@ Some examples of using the structure to:
> >    p.addr2           = (uint64_t) end_range;
> >    p.condition_value = 0;
> >  
> > +- set a watchpoint in server processors (BookS) using version 2
> > +
> > +  p.version         = 2;
> > +  p.trigger_type    = PPC_BREAKPOINT_TRIGGER_RW;
> > +  p.addr_mode       = PPC_BREAKPOINT_MODE_RANGE_INCLUSIVE;
> > +  or
> > +  p.addr_mode       = PPC_BREAKPOINT_MODE_RANGE_EXACT;
> > +
> > +  p.condition_mode  = PPC_BREAKPOINT_CONDITION_NONE;
> > +  p.addr            = (uint64_t) begin_range;
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
> > index 05b7dd2..18d28b6 100644
> > --- a/arch/powerpc/kernel/ptrace.c
> > +++ b/arch/powerpc/kernel/ptrace.c
> > @@ -1339,11 +1339,17 @@ static int set_dac_range(struct task_struct *child,
> >  static long ppc_set_hwdebug(struct task_struct *child,
> >  		     struct ppc_hw_breakpoint *bp_info)
> >  {
> > +#ifdef CONFIG_HAVE_HW_BREAKPOINT
> > +	int ret, len = 0;
> > +	struct thread_struct *thread = &(child->thread);
> > +	struct perf_event *bp;
> > +	struct perf_event_attr attr;
> > +#endif /* CONFIG_HAVE_HW_BREAKPOINT */
> 
> I'm confused.  This compiled before on book3s, and I don't see any
> changes to Makefile or Kconfig in the patch that will result in this
> code compiling  when it previously didn't   Why are these new guards
> added?
> 

The code is guarded using the CONFIG_ flags for two reasons.
a) We don't want the code to be included for BookE and other
architectures.
b) In BookS, we're now adding a new ability based on whether
CONFIG_HAVE_HW_BREAKPOINT is defined. Presently this config option is
kept on by default, however there are plans to make this a config-time
option.

> >  #ifndef CONFIG_PPC_ADV_DEBUG_REGS
> >  	unsigned long dabr;
> >  #endif
> >  
> > -	if (bp_info->version != 1)
> > +	if ((bp_info->version != 1) && (bp_info->version != 2))
> >  		return -ENOTSUPP;
> >  #ifdef CONFIG_PPC_ADV_DEBUG_REGS
> >  	/*
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
> 
> You remove this test to see if the single watchpoint slot is already
> in use, but I don't see another test replacing it.
> 

This test is retained for !CONFIG_HAVE_HW_BREAKPOINT case. In case of
using hw-breakpoint interfaces, we have a double check through
thread->ptrace_bps[0] and using register_user_hw_breakpoint function
(which would error out if not enough free slots are available).

> >  	if ((unsigned long)bp_info->addr >= TASK_SIZE)
> >  		return -EIO;
> >  
> > @@ -1398,15 +1400,86 @@ static long ppc_set_hwdebug(struct task_struct *child,
> >  		dabr |= DABR_DATA_READ;
> >  	if (bp_info->trigger_type & PPC_BREAKPOINT_TRIGGER_WRITE)
> >  		dabr |= DABR_DATA_WRITE;
> > +#ifdef CONFIG_HAVE_HW_BREAKPOINT
> > +	if (bp_info->version == 1)
> > +		goto version_one;
> 
> There are several legitimate uses of goto in the kernel, but this is
> definitely not one of them.  You're essentially using it to put the
> old and new versions of the same function in one block.  Nasty.
> 

Maybe it's the label that's causing bother here. It might look elegant
if it was called something like exit_* or error_* :-)

The goto here helps reduce code, is similar to the error exits we use
everywhere.

> > +	if (ptrace_get_breakpoints(child) < 0)
> > +		return -ESRCH;
> >  
> > -	child->thread.dabr = dabr;
> > +	bp = thread->ptrace_bps[0];
> > +	if (!bp_info->addr) {
> > +		if (bp) {
> > +			unregister_hw_breakpoint(bp);
> > +			thread->ptrace_bps[0] = NULL;
> > +		}
> > +		ptrace_put_breakpoints(child);
> > +		return 0;
> 
> Why are you making setting a 0 watchpoint remove the existing one (I
> think that's what this does).  I thought there was an explicit del
> breakpoint operation instead.
> 

We had to define the semantics for what writing a 0 to DABR could mean,
and I think it is intuitive to consider it as deletion
request...couldn't think of a case where DABR with addr=0 and RW=1 would
be required.

> > +	}
> > +	/*
> > +	 * Check if the request is for 'range' breakpoints. We can
> > +	 * support it if range < 8 bytes.
> > +	 */
> > +	if (bp_info->addr_mode == PPC_BREAKPOINT_MODE_RANGE_INCLUSIVE)
> > +		len = bp_info->addr2 - bp_info->addr;
> 
> So you compute the length here, but I don't see you ever test if it is
> < 8 and return an error.
> 

The hw-breakpoint interfaces would fail if the length was > 8.

> > +	else if (bp_info->addr_mode != PPC_BREAKPOINT_MODE_EXACT) {
> > +			ptrace_put_breakpoints(child);
> > +			return -EINVAL;
> > +		}
> > +	if (bp) {
> > +		attr = bp->attr;
> > +		attr.bp_addr = (unsigned long)bp_info->addr & ~HW_BREAKPOINT_ALIGN;
> > +		arch_bp_generic_fields(dabr &
> > +					(DABR_DATA_WRITE | DABR_DATA_READ),
> > +							&attr.bp_type);
> > +		attr.bp_len = len;
> > +		ret =  modify_user_hw_breakpoint(bp, &attr);
> > +		if (ret) {
> > +			ptrace_put_breakpoints(child);
> > +			return ret;
> > +		}
> > +		thread->ptrace_bps[0] = bp;
> > +		ptrace_put_breakpoints(child);
> > +		thread->dabr = dabr;
> > +		return 0;
> > +	}
> >  
> > +	/* Create a new breakpoint request if one doesn't exist already */
> > +	hw_breakpoint_init(&attr);
> > +	attr.bp_addr = (unsigned long)bp_info->addr & ~HW_BREAKPOINT_ALIGN;
> 
> You seem to be silently masking the given address, which seems
> completely wrong.
> 

We have two ways of looking at the input address.
a) Assume that the input address is not multiplexed with the read/write
bits and return -EINVAL (for not confirming to the 8-byte alignment
requirement).
b) Consider the input address to be encoded with the read/write
watchpoint type request and align the address by default. This is how
the code behaves presently for the !CONFIG_HAVE_HW_BREAKPOINT case.

I chose to go with b) and discard the last 3-bits from the address.

Thanks for the detailed review. Looking forward for your comments.

Thanks,
K.Prasad

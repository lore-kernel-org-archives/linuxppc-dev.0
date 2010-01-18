Return-Path: <shaggy@linux.vnet.ibm.com>
Subject: Re: [RFC:PATCH 03/03] powerpc: Add support for BookE Debug Reg.
	traps, exceptions and ptrace
From: Dave Kleikamp <shaggy@linux.vnet.ibm.com>
To: David Gibson <dwg@au1.ibm.com>
In-Reply-To: <20091211032626.GC8852@yookeroo>
References: <20091210155709.6697.4635.sendpatchset@norville.austin.ibm.com>
	<20091210155727.6697.74672.sendpatchset@norville.austin.ibm.com>
	<20091211032626.GC8852@yookeroo>
Content-Type: text/plain
Date: Mon, 18 Jan 2010 16:31:34 -0600
Message-Id: <1263853894.27291.44.camel@norville.austin.ibm.com>
Mime-Version: 1.0
Cc: linuxppc-dev list <Linuxppc-dev@ozlabs.org>,
	Sergio Durigan Junior <sergiodj@br.ibm.com>,
	Torez Smith <torez@us.ibm.com>, Thiago Jung Bauermann <bauerman@br.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2009-12-11 at 14:26 +1100, David Gibson wrote:
> On Thu, Dec 10, 2009 at 01:57:27PM -0200, Dave Kleikamp wrote:
> > powerpc: Add support for BookE Debug Reg. traps, exceptions and ptrace
> > 
> > From: Torez Smith <lnxtorez@linux.vnet.ibm.com>
> > 
> > This patch defines context switch and trap related functionality
> > for BookE specific Debug Registers. It adds support to ptrace()
> > for setting and getting BookE related Debug Registers

> [snip]
> > +#if !(defined(CONFIG_40x) || defined(CONFIG_BOOKE))
> >  void do_dabr(struct pt_regs *regs, unsigned long address,
> >  		    unsigned long error_code)
> >  {
> > @@ -257,12 +275,6 @@ void do_dabr(struct pt_regs *regs, unsigned long address,
> >  	if (debugger_dabr_match(regs))
> >  		return;
> >  
> > -	/* Clear the DAC and struct entries.  One shot trigger */
> > -#if defined(CONFIG_BOOKE)
> > -	mtspr(SPRN_DBCR0, mfspr(SPRN_DBCR0) & ~(DBSR_DAC1R | DBSR_DAC1W
> > -							| DBCR0_IDM));
> > -#endif
> > -
> >  	/* Clear the DABR */
> >  	set_dabr(0);
> 
> Uh.. does this imply we're keeping the one-shot behaviour for
> new-style breakpoints?  To me the interface really suggests they're
> persistent, although dealing with the semantics of that at signal time
> can get curly.

I've left it as one-shot.  The gdb guys seem happy with that.

[snip]

> >  int set_dabr(unsigned long dabr)
> >  {
> >  	__get_cpu_var(current_dabr) = dabr;
> > @@ -284,7 +358,7 @@ int set_dabr(unsigned long dabr)
> >  		return ppc_md.set_dabr(dabr);
> >  
> >  	/* XXX should we have a CPU_FTR_HAS_DABR ? */
> > -#if defined(CONFIG_BOOKE)
> > +#if defined(CONFIG_BOOKE) || defined(CONFIG_40x)
> >  	mtspr(SPRN_DAC1, dabr);
> 
> Uh.. this would seem to be wrong.  set_dabr(0) is called from the
> debug exception - but nowadays that could be tiggered by a DAC other
> than DAC1.

Right now, the only place left that set_dabr() is called for BOOKE or
40x is from xmon.  I think that's already a problem in that it doesn't
play nicely with ptrace and it fails to set DBCR0_DAC1R or DBCR0_DAC1W.
We probably need an independent patch for that.


> [snip]
> > +#else
> >  	/* As described above, it was assumed 3 bits were passed with the data
> >  	 *  address, but we will assume only the mode bits will be passed
> >  	 *  as to not cause alignment restrictions for DAC-based processors.
> >  	 */
> >  
> >  	/* DAC's hold the whole address without any mode flags */
> > -	task->thread.dabr = data & ~0x3UL;
> > -
> > -	if (task->thread.dabr == 0) {
> > -		task->thread.dbcr0 &= ~(DBSR_DAC1R | DBSR_DAC1W | DBCR0_IDM);
> > -		task->thread.regs->msr &= ~MSR_DE;
> > +	task->thread.dac1 = data & ~0x3UL;
> > +
> > +	if (task->thread.dac1 == 0) {
> > +		dbcr_dac(task) &= ~(DBCR_DAC1R | DBCR_DAC1W);
> > +		if (!DBCR_ACTIVE_EVENTS(task->thread.dbcr0,
> > +					task->thread.dbcr1)) {
> > +			task->thread.regs->msr &= ~MSR_DE;
> > +			task->thread.dbcr0 &= ~DBCR0_IDM;
> > +		}
> >  		return 0;
> >  	}
> 
> Ok, so effectively the old ptrace method of setting the DABR acts as a
> bypass to set DAC1, rather than having the old interface being
> implemented via the new interface.  This has some weirdness - you can
> clobber a new-style breakpoint in DAC1 using the old interface, for
> example.  Still, it might be the simplest approach for a first cut.

I really didn't consider a program using both the old and new interface.

> What *is* a problem though, is that this means that the SIGTRAP will
> always give a slot number, even for a breakpoint established using the
> old interface.  Part of the idea of encoding the registered breakpoint
> number in the siginfo was to be able to distinguish between old-style
> and new-style breakpoints at trap time.

Do we realistically expect both the old and new style breakpoints to be
used together?  I'm having trouble visualizing the scenerio.

> [snip]

> > +	int slot;
> > +
> > +	if (byte_enable && (condition_mode == 0))
> > +		return -EINVAL;
> > +
> > +	if (bp_info->addr >= TASK_SIZE)
> > +		return -EIO;
> > +
> > +	if ((dbcr_dac(child) & (DBCR_DAC1R | DBCR_DAC1W)) == 0) {
> > +		if (bp_info->trigger_type & PPC_BREAKPOINT_TRIGGER_READ)
> > +			dbcr_dac(child) |= DBCR_DAC1R;
> > +		if (bp_info->trigger_type & PPC_BREAKPOINT_TRIGGER_WRITE)
> > +			dbcr_dac(child) |= DBCR_DAC1W;
> > +		child->thread.dac1 = (unsigned long)bp_info->addr;
> > +#ifdef CONFIG_BOOKE
> 
> Better to have a runtime feature bit test here, than use an #ifdef to
> distinguish the 40x and BookE cases.  Plus, you should return an error
> if the user attempts to use a feature not supported on this hardware,
> which doesn't seem to happen here.

I'll take a look at making this a runtime feature.

Shaggy
-- 
David Kleikamp
IBM Linux Technology Center

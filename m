Return-Path: <shaggy@linux.vnet.ibm.com>
Subject: Re: [RFC:PATCH 03/03] powerpc: Add support for BookE Debug Reg.
	traps, exceptions and ptrace
From: Dave Kleikamp <shaggy@linux.vnet.ibm.com>
To: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <A04A87EF-F6CC-4AB8-9210-2234007E0AEE@kernel.crashing.org>
References: <20091210155709.6697.4635.sendpatchset@norville.austin.ibm.com>
	<20091210155727.6697.74672.sendpatchset@norville.austin.ibm.com>
	<A04A87EF-F6CC-4AB8-9210-2234007E0AEE@kernel.crashing.org>
Content-Type: text/plain
Date: Mon, 18 Jan 2010 16:18:44 -0600
Message-Id: <1263853124.27291.31.camel@norville.austin.ibm.com>
Mime-Version: 1.0
Cc: linuxppc-dev list <Linuxppc-dev@ozlabs.org>,
	Sergio Durigan Junior <sergiodj@br.ibm.com>,
	Torez Smith <torez@us.ibm.com>,
	Thiago Jung Bauermann <bauerman@br.ibm.com>, David Gibson <dwg@au1.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2009-12-10 at 20:50 -0600, Kumar Gala wrote:
> On Dec 10, 2009, at 9:57 AM, Dave Kleikamp wrote:
> 
> > powerpc: Add support for BookE Debug Reg. traps, exceptions and ptrace
> > 
> > From: Torez Smith <lnxtorez@linux.vnet.ibm.com>
> > 
> > This patch defines context switch and trap related functionality
> > for BookE specific Debug Registers. It adds support to ptrace()
> > for setting and getting BookE related Debug Registers

snip

> > +static void prime_debug_regs(struct thread_struct *thread)
> > +{
> > +	mtspr(SPRN_IAC1, thread->iac1);
> > +	mtspr(SPRN_IAC2, thread->iac2);
> > +	mtspr(SPRN_IAC3, thread->iac3);
> > +	mtspr(SPRN_IAC4, thread->iac4);
> > +	mtspr(SPRN_DAC1, thread->dac1);
> > +	mtspr(SPRN_DAC2, thread->dac2);
> > +	mtspr(SPRN_DVC1, thread->dvc1);
> > +	mtspr(SPRN_DVC2, thread->dvc2);
> > +	mtspr(SPRN_DBCR0, thread->dbcr0);
> > +	mtspr(SPRN_DBCR1, thread->dbcr1);
> > +	mtspr(SPRN_DBCR2, thread->dbcr2);
> 
> We should probably look at dbginfo.num_condition_regs, dbginfo.num_instruction_bps, & dbginfo.num_data_bps and set these accordingly.

All I did here is make dbcr2 depend on CONFIG_BOOKE.  For the time
being, there's no run-time checks on this, only compile-time.

> > +#if defined(CONFIG_40x) || defined(CONFIG_BOOKE)
> > +static long set_intruction_bp(struct task_struct *child,
> > +			      struct ppc_hw_breakpoint *bp_info)
> > +{
> > +	int slots_needed;
> > +	int slot;
> > +	int free_slot = 0;
> > +
> > +	/*
> > +	 * Find an avalailable slot for the breakpoint.
> > +	 * If possible, reserve consecutive slots, 1 & 2, for a range
> > +	 * breakpoint.  (Can this be done simpler?)
> > +	 */
> > +	if (bp_info->addr_mode == PPC_BREAKPOINT_MODE_EXACT)
> > +		slots_needed = 1;
> > +	else
> > +		slots_needed = 2;
> > +
> > +	if ((child->thread.dbcr0 & DBCR0_IAC1) == 0) {
> > +		if (slots_needed == 1) {
> > +			if (child->thread.dbcr0 & DBCR0_IAC2) {
> > +				slot = 1;
> > +				goto found;
> > +			}
> > +			/* Try to save slots 1 & 2 for range */
> > +			free_slot = 1;
> > +		} else
> > +			if ((child->thread.dbcr0 & DBCR0_IAC2) == 0) {
> > +				slot = 1;
> > +				goto found;
> > +			}
> > +	} else if ((slots_needed == 1) &&
> > +		   ((child->thread.dbcr0 & DBCR0_IAC2) == 0)) {
> > +		slot = 2;
> > +		goto found;
> > +	}
> > +	if ((child->thread.dbcr0 & DBCR0_IAC3) == 0) {
> > +		if (slots_needed == 1) {
> > +			slot = 3;
> > +			goto found;
> > +		}
> > +		if ((child->thread.dbcr0 & DBCR0_IAC4) == 0) {
> > +			slot = 3;
> > +			goto found;
> > +		}
> > +		return -ENOSPC;
> > +	} else if (slots_needed == 2)
> > +		return -ENOSPC;
> > +	if ((child->thread.dbcr0 & DBCR0_IAC4) == 0) {
> > +		slot = 4;
> > +	} else if (free_slot)
> > +		slot = free_slot;
> > +	else
> > +		return -ENOSPC;
> 
> Need to factor in if # of IACs is only 2.

What cpu has 2 IACs?

> > static long ppc_set_hwdebug(struct task_struct *child,
> > 		     struct ppc_hw_breakpoint *bp_info)
> > {
> > +	if (bp_info->version != 1)
> > +		return -ENOTSUPP;
> > +
> > +#ifdef CONFIG_BOOKE
> > +	/*
> > +	 * Check for invalid flags and combinations
> > +	 */
> > +	if ((bp_info->trigger_type == 0) ||
> > +	    (bp_info->trigger_type & ~(PPC_BREAKPOINT_TRIGGER_EXECUTE |
> > +				       PPC_BREAKPOINT_TRIGGER_RW)) ||
> > +	    (bp_info->addr_mode & ~PPC_BREAKPOINT_MODE_MASK) ||
> > +	    (bp_info->condition_mode &
> > +	     ~(PPC_BREAKPOINT_CONDITION_AND_OR |
> > +	       PPC_BREAKPOINT_CONDITION_BE_ALL)))
> > +		return -EINVAL;
> 
> We should add a sanity check for bp_info->condition_mode != PPC_BREAKPOINT_CONDITION_NONE if dbginfo.num_condition_regs = 0.

This falls into the run-time checks that I haven't implemented.  BOOKE
will not define dbginfo.num_condition_regs to be 0.

> > /*
> > @@ -980,16 +1308,36 @@ long arch_ptrace(struct task_struct *child, long request, long addr, long data)
> > 		struct ppc_debug_info dbginfo;
> > 
> > 		dbginfo.version = 1;
> > +#ifdef CONFIG_BOOKE
> > +		dbginfo.num_instruction_bps = 4;
> > +		dbginfo.num_data_bps = 2;
> > +		dbginfo.num_condition_regs = 2;
> > +		dbginfo.data_bp_alignment = 0;
> > +		dbginfo.sizeof_condition = 4;
> > +		dbginfo.features = PPC_DEBUG_FEATURE_INSN_BP_RANGE |
> > +				   PPC_DEBUG_FEATURE_INSN_BP_MASK |
> > +				   PPC_DEBUG_FEATURE_DATA_BP_RANGE |
> > +				   PPC_DEBUG_FEATURE_DATA_BP_MASK;
> > +#elif defined(CONFIG_40x)
> > +		/*
> > +		 * I don't know how the DVCs work on 40x, I'm not going
> > +		 * to support it now. -- Shaggy
> > +		 */
> > +		dbginfo.num_instruction_bps = 4;
> > +		dbginfo.num_data_bps = 2;
> > +		dbginfo.num_condition_regs = 0;
> > +		dbginfo.data_bp_alignment = 0;
> > +		dbginfo.sizeof_condition = 0;
> > +		dbginfo.features = PPC_DEBUG_FEATURE_INSN_BP_RANGE |
> > +				   PPC_DEBUG_FEATURE_INSN_BP_MASK;
> > +#else
> > 		dbginfo.num_instruction_bps = 0;
> > 		dbginfo.num_data_bps = 1;
> > 		dbginfo.num_condition_regs = 0;
> > -#ifdef CONFIG_PPC64
> > 		dbginfo.data_bp_alignment = 8;
> > -#else
> > -		dbginfo.data_bp_alignment = 0;
> > -#endif
> > 		dbginfo.sizeof_condition = 0;
> > 		dbginfo.features = 0;
> > +#endif
> 
> This is a bit ugly and BOOKE 64 parts probably don't have the 8 byte alignment.
> 
> Should we push some of this into cputable?

I'm thinking about it.  It may clean up some of the ifdefs.  I'll give
it a try, and if it ends up cleaner, I'll submit a follow-up patch.

Shaggy
-- 
David Kleikamp
IBM Linux Technology Center

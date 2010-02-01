Return-Path: <benh@kernel.crashing.org>
Subject: Re: [RFC:PATCH 01/03] powerpc: Extended ptrace interface
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Michael Neuling <mikey@neuling.org>
In-Reply-To: <14701.1264042076@neuling.org>
References: <20100118215704.15684.60646.sendpatchset@norville.austin.ibm.com>
	<20100118215709.15684.28776.sendpatchset@norville.austin.ibm.com>
	<14701.1264042076@neuling.org>
Content-Type: text/plain; charset="UTF-8"
Date: Mon, 01 Feb 2010 16:08:04 +1100
Message-ID: <1265000884.8287.28.camel@pasglop>
Mime-Version: 1.0
Cc: Thiago Jung Bauermann <bauerman@br.ibm.com>,
	Dave Kleikamp <shaggy@linux.vnet.ibm.com>, David Gibson <dwg@au1.ibm.com>,
	linuxppc-dev list <Linuxppc-dev@ozlabs.org>,
	Torez Smith <torez@us.ibm.com>, Sergio Durigan Junior <sergiodj@br.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2010-01-21 at 15:47 +1300, Michael Neuling wrote:
> > powerpc: Extended ptrace interface

> > +static long ppc_set_hwdebug(struct task_struct *child,
> > +		     struct ppc_hw_breakpoint *bp_info)
> > +{
> > +	/*
> > +	 * We currently support one data breakpoint
> > +	 */
> > +	if (((bp_info->trigger_type & PPC_BREAKPOINT_TRIGGER_RW) == 0) ||
> > +	    ((bp_info->trigger_type & ~PPC_BREAKPOINT_TRIGGER_RW) != 0) ||
> > +	    (bp_info->trigger_type != PPC_BREAKPOINT_TRIGGER_WRITE) ||
> > +	    (bp_info->addr_mode != PPC_BREAKPOINT_MODE_EXACT) ||
> > +	    (bp_info->condition_mode != PPC_BREAKPOINT_CONDITION_NONE))
> > +		return -EINVAL;
> > +
> > +	if (child->thread.dabr)
> > +		return -ENOSPC;
> > +
> > +	if ((unsigned long)bp_info->addr >= TASK_SIZE)
> > +		return -EIO;
> > +
> > +	child->thread.dabr = (unsigned long)bp_info->addr;
> > +#ifdef CONFIG_BOOKE
> 
> Do we want to add these CONFIG_BOOKE into a ppc_md call, so different
> CPU typs can have different setups?  I could see other CPUs might need
> to do different stuff here and we end up in #ifdef chaos

Actually, I don't think we need that level of indirection just now. If
there's ever a need for more ifdef's then ok, but the BookE debug
facility is somewhat architected so I wouldn't expect that much new
stuff.

Cheers,
Ben.

Return-Path: <shaggy@linux.vnet.ibm.com>
Subject: Re: [RFC: PATCH 04/13] powerpc/476: add machine check handler for
	47x core
From: Dave Kleikamp <shaggy@linux.vnet.ibm.com>
To: Olof Johansson <olof@lixom.net>
In-Reply-To: <20100301210811.GA6699@lixom.net>
References: <20100301191255.20987.84668.sendpatchset@norville.austin.ibm.com>
	<20100301191323.20987.13284.sendpatchset@norville.austin.ibm.com>
	<20100301210811.GA6699@lixom.net>
Content-Type: text/plain
Date: Mon, 01 Mar 2010 17:22:47 -0600
Message-Id: <1267485767.26041.41.camel@norville.austin.ibm.com>
Mime-Version: 1.0
Cc: linuxppc-dev list <Linuxppc-dev@ozlabs.org>, Torez Smith <torez@us.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2010-03-01 at 15:08 -0600, Olof Johansson wrote:
> On Mon, Mar 01, 2010 at 05:13:23AM -0700, Dave Kleikamp wrote:
> > powerpc/476: add machine check handler for 47x core
> > 
> > From: Dave Kleikamp <shaggy@linux.vnet.ibm.com>
> > 
> > The 47x core's MCSR varies from 44x, so it needs it's own machine check
> > handler.
> 
> 
> > --- a/arch/powerpc/kernel/traps.c
> > +++ b/arch/powerpc/kernel/traps.c
> > @@ -376,6 +376,44 @@ int machine_check_440A(struct pt_regs *regs)
> >  	}
> >  	return 0;
> >  }
> > +
> > +int machine_check_47x(struct pt_regs *regs)
> > +{
> > +	unsigned long reason = get_mc_reason(regs);
> > +
> > +	printk("Machine check in kernel mode.\n");
> 
> It's quite possible that the other machine check handlers don't have
> printk KERN_-levels on them but it would be a good idea to use them here.

Right.  As it's new code, it should be as correct as possible.

> > +	if (reason & ESR_IMCP){
> > +		printk("Instruction Synchronous Machine Check exception\n");
> > +		mtspr(SPRN_ESR, reason & ~ESR_IMCP);
> > +	}
> > +	else {
> 
> } else {
> 
> Or, rather, add an early return above and you can just remove one level of indentation below.

agreed.

Thanks,
Shaggy
-- 
David Kleikamp
IBM Linux Technology Center

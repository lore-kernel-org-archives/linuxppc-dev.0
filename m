Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e34.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 6F034DDE11
	for <linuxppc-dev@ozlabs.org>; Tue, 25 Dec 2007 03:22:31 +1100 (EST)
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
	[9.17.195.106])
	by e34.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id lBOGMRdw003202
	for <linuxppc-dev@ozlabs.org>; Mon, 24 Dec 2007 11:22:27 -0500
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
	by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v8.7) with ESMTP id
	lBOGMQUQ119624
	for <linuxppc-dev@ozlabs.org>; Mon, 24 Dec 2007 09:22:26 -0700
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
	by d03av02.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	lBOGMQhO007339
	for <linuxppc-dev@ozlabs.org>; Mon, 24 Dec 2007 09:22:26 -0700
Date: Mon, 24 Dec 2007 10:15:57 -0600
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH 1/21] [POWERPC] Reworking machine check handling and Fix
	440/440A
Message-ID: <20071224101557.07718f9c@zod.rchland.ibm.com>
In-Reply-To: <20071223193210.1d06f33f@zod.rchland.ibm.com>
References: <20071221043925.42B40DDE30@ozlabs.org>
	<20071223193210.1d06f33f@zod.rchland.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sun, 23 Dec 2007 19:32:10 -0600
Josh Boyer <jwboyer@linux.vnet.ibm.com> wrote:

> On Fri, 21 Dec 2007 15:39:21 +1100
> Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:
> 
> > Index: linux-merge/arch/powerpc/kernel/traps.c
> > ===================================================================
> > --- linux-merge.orig/arch/powerpc/kernel/traps.c	2007-12-20 11:34:43.000000000 +1100
> > +++ linux-merge/arch/powerpc/kernel/traps.c	2007-12-20 11:35:40.000000000 +1100
> 
> [snip]
> 
> > -#elif defined (CONFIG_E500)
> > +	return 0;
> > +}
> > +#elif defined(CONFIG_E500)
> > +int machine_check_e500(struct pt_regs *regs)
> 
> This...
> 
> > +{
> > +	unsigned long reason = get_mc_reason(regs);
> > +
> >  	printk("Machine check in kernel mode.\n");
> >  	printk("Caused by (from MCSR=%lx): ", reason);
> > 
> > @@ -403,7 +416,14 @@ static int generic_machine_check_excepti
> >  		printk("Bus - Instruction Parity Error\n");
> >  	if (reason & MCSR_BUS_RPERR)
> >  		printk("Bus - Read Parity Error\n");
> > -#elif defined (CONFIG_E200)
> > +
> > +	return 0;
> > +}
> > +#elif defined(CONFIG_E200)
> > +int machine_check_e200(struct pt_regs *regs)
> 
> ... and this cause build failures for most of the mpc8xxx defconfigs.
> The reason is that e200 and e500 are both lumped under CONFIG_FSL_BOOKE
> in cputable.c, but you have them segregated more here.  I've added a
> fix that just does CONFIG_FSL_BOOKE here to match cputable.c.

Actually, reverse that.  There are other places where e200 and e500 are
separated by ifdefs, so I made cputable.c match the rest.

josh

Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 4FA29DDD0C
	for <linuxppc-dev@ozlabs.org>; Fri,  3 Apr 2009 12:43:35 +1100 (EST)
Subject: Re: [PATCH] powerpc ptrace block-step
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Roland McGrath <roland@redhat.com>
In-Reply-To: <20090403004450.F2166FC3AB@magilla.sf.frob.com>
References: <20090401215903.DE872FC3AB@magilla.sf.frob.com>
	<1238650016.17330.193.camel@pasglop>
	<20090403004450.F2166FC3AB@magilla.sf.frob.com>
Content-Type: text/plain
Date: Fri, 03 Apr 2009 12:43:27 +1100
Message-Id: <1238723007.10752.19.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, utrace-devel@redhat.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, 2009-04-02 at 17:44 -0700, Roland McGrath wrote:
> > The patch only implements it for "server/classic" processors, not BookE,
> > thus it should probably only advertise it for these :-)
> >
> > Though it wouldn't be too hard to implement it for BookE using DBCR0:BRT
> > (Branch Taken debug event) though it might need some careful fixups such
> > as the one we have for single step regarding hitting exception entry
> > code.
> 
> In that case, this code seems fairly mysterious:
> 
> > > +#if defined(CONFIG_40x) || defined(CONFIG_BOOKE)
> > > +		task->thread.dbcr0 = DBCR0_IDM | DBCR0_BT;
> > > +		regs->msr |= MSR_DE;
> 
> That doesn't already do whatever it is you described?

It should, I missed that bit. Except for the possible issue with
interrupts.

> Can we assume now that you or someone else who knows what all that means
> will take this up?

I can take this up after I'm back from vacation, which will be in about
4 weeks from now, but maybe Josh can give it a go in the meantime.

Basically, the "issue" with BookE is that the debug interrupts aren't
masked by the fact of taking an exception. So for example, if you have
single step enabled and take a TLB miss on a userland load, you'll take
a single step exception on the first (or rather the second but that's
a detail) instruction of the TLB miss exception vector.

The code for our BookE debug interrupts has a workaround that detects
that case and returns to the TLB miss vector with MSR:DE cleared, but
I think that code will not properly catch a similar things happening
due to block step. Though is should be easy to fix.

Cheers,
Ben.

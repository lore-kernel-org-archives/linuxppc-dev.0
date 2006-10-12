Return-Path: <olof@lixom.net>
Received: from mail.lixom.net (lixom.net [66.141.50.11])
	by ozlabs.org (Postfix) with ESMTP id 5C5E867F21
	for <linuxppc-dev@ozlabs.org>; Fri, 13 Oct 2006 00:57:38 +1000 (EST)
Date: Thu, 12 Oct 2006 09:56:49 -0500
From: Olof Johansson <olof@lixom.net>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH 1/4] powerpc: consolidate feature fixup code
Message-ID: <20061012095649.23bb6b35@localhost.localdomain>
In-Reply-To: <1160664449.4792.147.camel@localhost.localdomain>
References: <1160641793.4792.133.camel@localhost.localdomain>
	<20061012085617.3a5d6a31@localhost.localdomain>
	<1160664449.4792.147.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, 13 Oct 2006 00:47:29 +1000 Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:

> 
> > > +void do_feature_fixups(unsigned long offset, unsigned long value,
> > > +		       void *fixup_start, void *fixup_end)
> > > +{
> > > +	struct fixup_entry {
> > > +		unsigned long	mask;
> > > +		unsigned long	value;
> > > +		unsigned int	*start;
> > > +		unsigned int	*end;
> > > +	} *fcur, *fend;
> > 
> > Shouldn't there be a better place to keep this struct definition than
> > in the function it's used? Some header file?
> 
> It's not used anywhere else.... which header would you put it in ?

Near where the asm-corresponding ones are located (cputable.h).


-Olof

> > Ok, now it's in C, no reason to do a dcbst/icbi for every word. We did
> > it in asm for simplicity's sake. Split it in two loops, one to nop,
> > second to step per line and do the flushes. :-)
> 
> Do we care ? :) But yah, I suppose I can do that.

Close call. :-) It's just easier to do now, might as well do it. But
yeah, no big deal.

It will also be easier to graft in a branch forward instead of a large
amount of nops for large feature sections. I guess it will take some
benchmarking to see what the breakeven point is.


-Olof

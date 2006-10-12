Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 292EC67C41
	for <linuxppc-dev@ozlabs.org>; Fri, 13 Oct 2006 00:47:39 +1000 (EST)
Subject: Re: [PATCH 1/4] powerpc: consolidate feature fixup code
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Olof Johansson <olof@lixom.net>
In-Reply-To: <20061012085617.3a5d6a31@localhost.localdomain>
References: <1160641793.4792.133.camel@localhost.localdomain>
	<20061012085617.3a5d6a31@localhost.localdomain>
Content-Type: text/plain
Date: Fri, 13 Oct 2006 00:47:29 +1000
Message-Id: <1160664449.4792.147.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


> > +void do_feature_fixups(unsigned long offset, unsigned long value,
> > +		       void *fixup_start, void *fixup_end)
> > +{
> > +	struct fixup_entry {
> > +		unsigned long	mask;
> > +		unsigned long	value;
> > +		unsigned int	*start;
> > +		unsigned int	*end;
> > +	} *fcur, *fend;
> 
> Shouldn't there be a better place to keep this struct definition than
> in the function it's used? Some header file?

It's not used anywhere else.... which header would you put it in ?

> > +
> > +	fcur = fixup_start;
> > +	fend = fixup_end;
> > +
> > +	for (; fcur < fend; fcur++) {
> 
> 	for (fcur = fixup_start; fcur < fend; fcur++) {
> 
> > +		unsigned int *pcur, *pend;
> > +
> > +		if ((value & fcur->mask) == fcur->value)
> > +			continue;
> > +
> > +		pcur = fcur->start - offset;
> > +		pend = fcur->end - offset;
> > +		for (; pcur < pend; pcur++) {
> > +			*pcur = 0x60000000u;
> > +			asm ("dcbst 0, %0; sync; icbi 0,%0; sync; isync"
> > +			     : : "r" (pcur));
> > +		}
> 
> Ok, now it's in C, no reason to do a dcbst/icbi for every word. We did
> it in asm for simplicity's sake. Split it in two loops, one to nop,
> second to step per line and do the flushes. :-)

Do we care ? :) But yah, I suppose I can do that.

Thanks,
Ben.

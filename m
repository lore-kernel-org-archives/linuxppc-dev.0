Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 2257867B5C
	for <linuxppc-dev@ozlabs.org>; Wed, 20 Sep 2006 09:12:49 +1000 (EST)
Subject: Re: [POWERPC] convert string i/o operations to C
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Linas Vepstas <linas@austin.ibm.com>
In-Reply-To: <20060919182953.GK29167@austin.ibm.com>
References: <20060919222351.d27a1a06.sfr@canb.auug.org.au>
	<20060919182953.GK29167@austin.ibm.com>
Content-Type: text/plain
Date: Wed, 20 Sep 2006 09:12:12 +1000
Message-Id: <1158707532.6002.171.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, paulus@samba.org,
	ppc-dev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, 2006-09-19 at 13:29 -0500, Linas Vepstas wrote:
> On Tue, Sep 19, 2006 at 10:23:51PM +1000, Stephen Rothwell wrote:
> 
> Perhaps this:
> 
> > +void _insb(volatile u8 __iomem *port, void *buf, int ns)
> > +{
> > +	asm volatile("sync");
> > +	if (ns <= 0)
> > +		return;
> > +	asm volatile(
> 
> should be this: 
> 
> > +void _insb(volatile u8 __iomem *port, void *buf, int ns)
> > +{
> > +	if (ns <= 0)
> > +		return;
> > +	asm volatile("sync");
> > +	asm volatile(

No. The barrier should be there even if somebody is lame enough to give
a count of 0.

> to assuage David Howell's concern.  Not that ns should be negative
> in the first place ... but what the hey.
> 
> Re Davids other comment: "ns" stands for "no  byte-swap", and 
> "s" stands for "string" so "insl_ns" is input string of longs, 
> no byte swap.

David's comment was about the "ns" argument which is the count (dunno
why "ns").

> Here's a question:
> 
> > +	asm volatile(
> > +		"mtctr	%2\n"
> > +		"subi	%1,%1,1\n"
> > +		"0:	lbz	%2,0(%0)\n"
> > +		"eieio\n"
> > +		"stbu	%2,1(%1)\n"
> > +		"bdnz	0b\n"
> > +		"twi	0,%2,0\n"
> 
> What does this twi do? According to my powerpc docs, this would be a
> no-op.  Does this have some magic synchronizing powers on certain
> implementations? If so, there should be at least a comment card added
> about why the twi is there. (This special ability of twi might be
> well-known to some, but still, this is not immediately obvious,
> and not immedately documented in e.g. the PEM.)
> 
> --linas
> 
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-dev

Return-Path: <dgibson@ozlabs.org>
Date: Mon, 12 Nov 2007 14:04:02 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Jon Loeliger <jdl@jdl.com>
Subject: Re: [PATCH] DTC: Polish up the DTS Version 1 implementation.
Message-ID: <20071112030402.GA1404@localhost.localdomain>
References: <E1IpWlT-0007Qd-IX@jdl.com>
	<20071106231120.GG31367@localhost.localdomain>
	<E1Iplfp-0003WY-MB@jdl.com>
	<20071107231942.GA8835@localhost.localdomain>
	<47331979.7030803@freescale.com>
	<20071109001345.GD18592@localhost.localdomain>
	<E1IqUun-00063a-7g@jdl.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <E1IqUun-00063a-7g@jdl.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, Nov 09, 2007 at 08:32:57AM -0600, Jon Loeliger wrote:
> So, like, the other day David Gibson mumbled:
> > 
> > But you do take a hit w.r.t. *minimum* representation size - there's
> > no form amongst all the possibilities here more compact than pure hex.
> > Especially since spaces are optional in the old form.  The fact that
> > [ab cd 00] and [abcd00] are equivalent was a deliberate choice in the
> > original form.
> > 
> > The point of [] is for random binary data which is neither strings
> > (even with the odd strange character) nor sensibly organized into
> > 32-bit (or larger) integers.  Wanting something other than hex here is
> > much rarer than in the < > case.
> > 
> > You're seeing < > and [ ] as basically the same thing - a list of
> > values - with the only difference being the size of those values.
> > That's not wrong, but it's not the only way to look at it - and it's
> > not the way I was thinking of [ ] when I invented it.  Your proposal
> > makes perfect sense while you think of [] as a list of values - but
> > not so much when it's thought of as a direct binary representation.
> > 
> > So I'm thinking perhaps we need two different things here: a "list of
> > values" representation, which can accomodate expressions and can also
> > have multiple sizes (because expressions which are evaluated to a
> > 16-bit or 64-bit value could also be useful under the right
> > circumstances), and the [ ] "bytestring
> > literal" representation.  Perhaps something like:
> > 
> > (32-bit values)
> > 	<0xdeadbeef (1+1)>
> > or	<.32 0xdeadbeef (1+1)>
> > 
> > (64-bit values)
> > 	<.64 (0xdeadbeef << 32) (-1)>
> > (8-bit values)
> > 	<.8 0x00 0x0a 0xe4 0x2c 0x23 (0x10 + n)>
> > 
> > i.e. < > is list of values form, with size of each value as a sort of
> > parameter (defaulting to 32-bit, of course).  I'm not sure I like that
> > particular syntax, it's just the first thing I came up with to
> > demonstrate the idea.
> 
> 
> Ah ha!  I see.  You want this, then:
> 
>     x = <.srec 0000 C001C0DEGE75BABE F1>
> 
> OK.  That was entirely joking.  We all know that
> the cool code does NOT get the babe.

Hrm.. I think I'm not getting all the allusions here.

> Seriously though, I see your point, and I don't really
> have a strong opinion here, so in the interest of making
> some headway, we can just leave it as is for now.
> 
> If it turns out to be a bad decision later, we'll fix it. :-)

Works for me.  And we even have some ideas on how to fix it, if we
have to, without too much horror, so that seems like a reasonable
position to me.

> And with that issue behind us....
> 
> I'm going to post these patches to introduce the new DTS format!
> Any last straggler comments?

Hurrah.  Let's do it!

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

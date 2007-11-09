Return-Path: <dgibson@ozlabs.org>
Date: Fri, 9 Nov 2007 11:13:45 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Jon Loeliger <jdl@freescale.com>
Subject: Re: [PATCH] DTC: Polish up the DTS Version 1 implementation.
Message-ID: <20071109001345.GD18592@localhost.localdomain>
References: <E1IpWlT-0007Qd-IX@jdl.com>
	<20071106231120.GG31367@localhost.localdomain>
	<E1Iplfp-0003WY-MB@jdl.com>
	<20071107231942.GA8835@localhost.localdomain>
	<47331979.7030803@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <47331979.7030803@freescale.com>
Cc: linuxppc-dev@ozlabs.org, Jon Loeliger <jdl@jdl.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Nov 08, 2007 at 08:13:13AM -0600, Jon Loeliger wrote:
> David Gibson wrote:
> > 
> > Yes, I know, but I don't think it's even worth having the unused
> > internal parameterization.
> 
> OK.  We can eliminate it then; no problem.
> 
> >> I ran my "old versus new DTC" comparison script and found it. :-)
> > 
> > Heh, we should fold that into the testsuite, too.
> 
> I'll start by simply adding the script to the test directory then.

Ok.

> >> Because it wasn't working, as explained in the comment I added.
> >> Specifically, (1<<bits), with bits==64 overflowed and yielded
> >> the value 0.
> > 
> > Ah...
> > 
> > Well, I assumed (1ULL << 64) would equal 0, which is why the
> > comparison has the (-1) - I was expecting for bits == 64 it would end
> > up being against -1, i.e. 0xffffffffffffffff.  This appears to work on
> > the systems I've been using.
> 
> But not on an x86 system.
> 
> > But I just remembered that (x << n) has undefined behaviour in C when
> > n >= word size. 
> 
> Exactly.  In fact, I think x86 takes the shift value, bit-wise
> ANDs it with 63 internally, and then shifts left by that value.
> 
>  So I guess (1 << 64) is just returning garbage - I
> 
> In fact, it is yielding 1 on an x86 machine.
> 
> > suspect I didn't catch it because I've been building with -O0 for
> > gdb-ability, which might change the behaviour of corner cases like
> > that.
> 
> Or works on a PPC machine? :-)

Actually I was working from home on an x86 machine when I wrote that,
so I think it must have been the -O0.

> > So I guess we need
> > 	else if ((errno == ERANGE)
> > 		 || ((bits < 64) && (val >= (1ULL << bits))))
> 
> Sounds good.  I'll commit --amend that into the patch!
> 
> 
> >> And in the blue corner, touting consistent hex forms, ...
> > 
> > And in the red, compact bytestring representations.
> 
> > No, seriously, the inconsistency bothers me too.  But so does the fact
> > that using 0x in the bytestring would double the minimum size for
> > representing bytestrings, somewhat changing the flavour of [] as well
> > (because spaces are no longer optional).  I'm looking for a killer
> > argument one way or the other, but I haven't found it yet.
> 
> But why does it even have to be hex numbers at all?
> I guess my point is that they could just be expressions.
> You could use 0x31 or 49 or '1' or 061, whichever made
> more sense in some application.  You don't necessarily take
> a representational size hit.

But you do take a hit w.r.t. *minimum* representation size - there's
no form amongst all the possibilities here more compact than pure hex.
Especially since spaces are optional in the old form.  The fact that
[ab cd 00] and [abcd00] are equivalent was a deliberate choice in the
original form.

The point of [] is for random binary data which is neither strings
(even with the odd strange character) nor sensibly organized into
32-bit (or larger) integers.  Wanting something other than hex here is
much rarer than in the < > case.

You're seeing < > and [ ] as basically the same thing - a list of
values - with the only difference being the size of those values.
That's not wrong, but it's not the only way to look at it - and it's
not the way I was thinking of [ ] when I invented it.  Your proposal
makes perfect sense while you think of [] as a list of values - but
not so much when it's thought of as a direct binary representation.

So I'm thinking perhaps we need two different things here: a "list of
values" representation, which can accomodate expressions and can also
have multiple sizes (because expressions which are evaluated to a
16-bit or 64-bit value could also be useful under the right
circumstances), and the [ ] "bytestring
literal" representation.  Perhaps something like:

(32-bit values)
	<0xdeadbeef (1+1)>
or	<.32 0xdeadbeef (1+1)>

(64-bit values)
	<.64 (0xdeadbeef << 32) (-1)>
(8-bit values)
	<.8 0x00 0x0a 0xe4 0x2c 0x23 (0x10 + n)>

i.e. < > is list of values form, with size of each value as a sort of
parameter (defaulting to 32-bit, of course).  I'm not sure I like that
particular syntax, it's just the first thing I came up with to
demonstrate the idea.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

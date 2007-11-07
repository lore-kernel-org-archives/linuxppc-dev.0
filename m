Return-Path: <dgibson@ozlabs.org>
Date: Thu, 8 Nov 2007 10:19:42 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Jon Loeliger <jdl@jdl.com>
Subject: Re: [PATCH] DTC: Polish up the DTS Version 1 implementation.
Message-ID: <20071107231942.GA8835@localhost.localdomain>
References: <E1IpWlT-0007Qd-IX@jdl.com>
	<20071106231120.GG31367@localhost.localdomain>
	<E1Iplfp-0003WY-MB@jdl.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <E1Iplfp-0003WY-MB@jdl.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Nov 07, 2007 at 08:14:29AM -0600, Jon Loeliger wrote:
> So, like, the other day David Gibson mumbled:
> > On Tue, Nov 06, 2007 at 04:19:19PM -0600, Jon Loeliger wrote:
> > > From: Jon Loeliger <jdl@freescale.com>
> > > 
> > > Fixes BYTESTRING lexing.
> > > Allows -O dts output to be emitted in a given (1) format version.
> > 
> > Ok... I'd actually be more inclined to remove the option and just have
> > -Odts *always* use the newer version.
> 
> You didn't read the code. :-)  That's what it does!
> There is no option, it is just parameterized in the code.
> It _always_ forward re-writes as the latest version.

Yes, I know, but I don't think it's even worth having the unused
internal parameterization.

> > Having dtc be able to convert dts versions forward is easy and
> > useful.
> 
> Oh, I see.  Thank you.
> 
> > > This patch is directly on top of your prior two patches.
> > > Lemme know what you think.
> > 
> > On top of my two dts-v1 patches that is, I assume?
> 
> Right.
> 
> > Ow... that's rather embarrassing, that I didn't even notice I'd
> > totally broken bytestrings.  Really must add some bytestrings to
> > test_tree1.dts so this actually gets checked by the testsuite.
> 
> I ran my "old versus new DTC" comparison script and found it. :-)

Heh, we should fold that into the testsuite, too.

> > Not really related changes, but whatever..
> 
> Uh, yeah.  Leftoverish.  Sorry.
> 
> 
> > > +/*
> > > + * bits is unused, but it should be 32 or 64 as needed.
> > > + *
> > > + * FIXME: However, with bits == 64, ((1ULL << bits) - 1)
> > > + * overflows before you can actually do the range test.
> > > + */
> > >  unsigned long long eval_literal(const char *s, int base, int bits)
> > >  {
> > >  	unsigned long long val;
> > > @@ -317,9 +323,10 @@ unsigned long long eval_literal(const char *s, int base, int bits)
> > >  	val = strtoull(s, &e, base);
> > >  	if (*e)
> > >  		yyerror("bad characters in literal");
> > > -	else if ((errno == ERANGE) || (val > ((1ULL << bits)-1)))
> > > +	else if (errno == ERANGE)
> > >  		yyerror("literal out of range");
> > >  	else if (errno != 0)
> > >  		yyerror("bad literal");
> > > +
> > 
> > Ok.. I don't understand why you've pulled out the range checking
> > against bits here.
> 
> Because it wasn't working, as explained in the comment I added.
> Specifically, (1<<bits), with bits==64 overflowed and yielded
> the value 0.

Ah...

Well, I assumed (1ULL << 64) would equal 0, which is why the
comparison has the (-1) - I was expecting for bits == 64 it would end
up being against -1, i.e. 0xffffffffffffffff.  This appears to work on
the systems I've been using.

But I just remembered that (x << n) has undefined behaviour in C when
n >= word size.  So I guess (1 << 64) is just returning garbage - I
suspect I didn't catch it because I've been building with -O0 for
gdb-ability, which might change the behaviour of corner cases like
that.

So I guess we need
	else if ((errno == ERANGE)
		 || ((bits < 64) && (val >= (1ULL << bits))))

[snip]
> > > -static void write_propval_bytes(FILE *f, struct data val)
> > > +static void write_propval_bytes(FILE *f, struct data val, int dts_version)
> > >  {
> > >  	void *propend = val.val + val.len;
> > >  	char *bp = val.val;
> > >  
> > >  	fprintf(f, " = [");
> > >  	for (;;) {
> > > -		fprintf(f, "%02hhx", *bp++);
> > > +		if (dts_version == 0) {
> > > +			fprintf(f, "%02hhx", *bp++);
> > > +		} else {
> > > +			fprintf(f, "0x%02hhx", *bp++);
> > > +		}
> > 
> > Uh.. not quite right.  My patch (intentionally) leaves bytestrings as
> > pure hex, without 0x.
> 
> Ugh.  That seems inconsistent and wrong to me.

Well... depends on how you think about it.  If you think of [] as a
list of really small integers, then it's inconsistent.  But, if you
think of [] as a way of doing really long hex literals..

> > We can argue about whether that's a good idea,
> > if you like,
> 
> And in the blue corner, touting consistent hex forms, ...

And in the red, compact bytestring representations.

No, seriously, the inconsistency bothers me too.  But so does the fact
that using 0x in the bytestring would double the minimum size for
representing bytestrings, somewhat changing the flavour of [] as well
(because spaces are no longer optional).  I'm looking for a killer
argument one way or the other, but I haven't found it yet.

> > but in any case input and output should match.
> 
> Oops.  That they should.
> 
> > To avoid this sort of problem, I suggest before we apply the dts-v1
> > transition, we apply the patch I'm working on (I'll try to get it out
> > today), which adds a bunch of extra testcases checking that using dtc
> > to go dtb->dts->dtb preserves everything.
> 
> Yeah, I've been doing that too...  Sounds good.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

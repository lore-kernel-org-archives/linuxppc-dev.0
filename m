Return-Path: <jdl@jdl.com>
To: David Gibson <david@gibson.dropbear.id.au>
Subject: Re: [PATCH] DTC: Polish up the DTS Version 1 implementation. 
In-Reply-To: Your message of "Wed, 07 Nov 2007 10:11:20 +1100."
	<20071106231120.GG31367@localhost.localdomain>
References: <E1IpWlT-0007Qd-IX@jdl.com>
	<20071106231120.GG31367@localhost.localdomain>
Date: Wed, 07 Nov 2007 08:14:29 -0600
From: Jon Loeliger <jdl@jdl.com>
Message-Id: <E1Iplfp-0003WY-MB@jdl.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

So, like, the other day David Gibson mumbled:
> On Tue, Nov 06, 2007 at 04:19:19PM -0600, Jon Loeliger wrote:
> > From: Jon Loeliger <jdl@freescale.com>
> > 
> > Fixes BYTESTRING lexing.
> > Allows -O dts output to be emitted in a given (1) format version.
> 
> Ok... I'd actually be more inclined to remove the option and just have
> -Odts *always* use the newer version.

You didn't read the code. :-)  That's what it does!
There is no option, it is just parameterized in the code.
It _always_ forward re-writes as the latest version.

> Having dtc be able to convert dts versions forward is easy and
> useful.

Oh, I see.  Thank you.

> > This patch is directly on top of your prior two patches.
> > Lemme know what you think.
> 
> On top of my two dts-v1 patches that is, I assume?

Right.

> Ow... that's rather embarrassing, that I didn't even notice I'd
> totally broken bytestrings.  Really must add some bytestrings to
> test_tree1.dts so this actually gets checked by the testsuite.

I ran my "old versus new DTC" comparison script and found it. :-)

> Not really related changes, but whatever..

Uh, yeah.  Leftoverish.  Sorry.


> > +/*
> > + * bits is unused, but it should be 32 or 64 as needed.
> > + *
> > + * FIXME: However, with bits == 64, ((1ULL << bits) - 1)
> > + * overflows before you can actually do the range test.
> > + */
> >  unsigned long long eval_literal(const char *s, int base, int bits)
> >  {
> >  	unsigned long long val;
> > @@ -317,9 +323,10 @@ unsigned long long eval_literal(const char *s, int base, int bits)
> >  	val = strtoull(s, &e, base);
> >  	if (*e)
> >  		yyerror("bad characters in literal");
> > -	else if ((errno == ERANGE) || (val > ((1ULL << bits)-1)))
> > +	else if (errno == ERANGE)
> >  		yyerror("literal out of range");
> >  	else if (errno != 0)
> >  		yyerror("bad literal");
> > +
> 
> Ok.. I don't understand why you've pulled out the range checking
> against bits here.

Because it wasn't working, as explained in the comment I added.
Specifically, (1<<bits), with bits==64 overflowed and yielded
the value 0.

Here's the problem:

---------------- snip to get foo.c ----------------
#include "stdio.h"

int bits = 64;
unsigned long long val = 0xabcd1234;

main()
{
    int i;

    for (i = 1; i <= 64; i++) {
        unsigned long long r =  (1ULL << i) - 1;
        printf("range at %d is 0x%016llx\n", i, r);
    }

    printf("val   is 0x%016llx\n", val);

    if (val > ((1ULL << bits) - 1)) {
        printf("val out of dynamic range\n");
    } else {
        printf("val is ok with dynamic range
    }

    if (val > ((1ULL << 64) - 1)) {
        printf("val out of static range\n");
    } else {
        printf("val is ok with static range\n");
    }
}
---------------- snip to get foo.c ----------------

Yielding output:

    [ snip ]

    range at 60 is 0x0fffffffffffffff
    range at 61 is 0x1fffffffffffffff
    range at 62 is 0x3fffffffffffffff
    range at 63 is 0x7fffffffffffffff
    range at 64 is 0x0000000000000000
    val   is 0x00000000abcd1234
    val out of dynamic range
    val is ok with static range

This is:

    jdl.com 1069 % gcc -v
    Using built-in specs.
    Target: i486-linux-gnu
    Configured with: ../src/configure -v
    --enable-languages=c,c++,fortran,objc,obj-c++,treelang --prefix=/usr
    --enable-shared --with-system-zlib --libexecdir=/usr/lib
    --without-included-gettext --enable-threads=posix --enable-nls
    --with-gxx-include-dir=/usr/include/c++/4.1.3 --program-suffix=-4.1
    --enable-__cxa_atexit --enable-clocale=gnu --enable-libstdcxx-debug
    --enable-mpfr --with-tune=i686 --enable-checking=release
    i486-linux-gnu
    Thread model: posix
    gcc version 4.1.3 20070629 (prerelease) (Debian 4.1.2-13)

Which seems at least reasonable, though perhaps wrong. :-)

> > -static void write_propval_bytes(FILE *f, struct data val)
> > +static void write_propval_bytes(FILE *f, struct data val, int dts_version)
> >  {
> >  	void *propend = val.val + val.len;
> >  	char *bp = val.val;
> >  
> >  	fprintf(f, " = [");
> >  	for (;;) {
> > -		fprintf(f, "%02hhx", *bp++);
> > +		if (dts_version == 0) {
> > +			fprintf(f, "%02hhx", *bp++);
> > +		} else {
> > +			fprintf(f, "0x%02hhx", *bp++);
> > +		}
> 
> Uh.. not quite right.  My patch (intentionally) leaves bytestrings as
> pure hex, without 0x.

Ugh.  That seems inconsistent and wrong to me.

> We can argue about whether that's a good idea,
> if you like,

And in the blue corner, touting consistent hex forms, ...

> but in any case input and output should match.

Oops.  That they should.

> To avoid this sort of problem, I suggest before we apply the dts-v1
> transition, we apply the patch I'm working on (I'll try to get it out
> today), which adds a bunch of extra testcases checking that using dtc
> to go dtb->dts->dtb preserves everything.

Yeah, I've been doing that too...  Sounds good.

Thanks,
jdl

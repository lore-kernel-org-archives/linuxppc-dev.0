Return-Path: <bunk@kernel.org>
Date: Tue, 19 Feb 2008 09:43:02 +0200
From: Adrian Bunk <bunk@kernel.org>
To: Michael Ellerman <michael@ellerman.id.au>
Subject: Re: [PATCH 1/3] Fix Unlikely(x) == y
Message-ID: <20080219074302.GA2640@cs181133002.pp.htv.fi>
References: <20080216092552.325e5726@laptopd505.fenrus.org>
	<20080216173315.GU8953@1wt.eu>
	<20080216094226.1e8eede1@laptopd505.fenrus.org>
	<47B72BFE.9060302@am.sony.com>
	<20080216103927.2a02352b@laptopd505.fenrus.org>
	<1203249003.6718.24.camel@concordia>
	<20080218135609.GD21080@cs181133002.pp.htv.fi>
	<Pine.LNX.4.64.0802181500410.13406@vixen.sonytel.be>
	<20080218141340.GB667@cs181133002.pp.htv.fi>
	<1203371163.6844.2.camel@concordia>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <1203371163.6844.2.camel@concordia>
Cc: Roel Kluin <12o3l@tiscali.nl>, lkml <linux-kernel@vger.kernel.org>,
	cbe-oss-dev@ozlabs.org, linuxppc-dev@ozlabs.org,
	Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>,
	Willy Tarreau <w@1wt.eu>, Arjan van de Ven <arjan@infradead.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Feb 19, 2008 at 08:46:03AM +1100, Michael Ellerman wrote:
> On Mon, 2008-02-18 at 16:13 +0200, Adrian Bunk wrote:
> > On Mon, Feb 18, 2008 at 03:01:35PM +0100, Geert Uytterhoeven wrote:
> > > On Mon, 18 Feb 2008, Adrian Bunk wrote:
> > > > 
> > > > This means it generates faster code with a current gcc for your platform.
> > > > 
> > > > But a future gcc might e.g. replace the whole loop with a division
> > > > (gcc SVN head (that will soon become gcc 4.3) already does 
> > > > transformations like replacing loops with divisions [1]).
> > > 
> > > Hence shouldn't we ask the gcc people what's the purpose of __builtin_expect(),
> > > if it doesn't live up to its promise?
> > 
> > That's a different issue.
> > 
> > My point here is that we do not know how the latest gcc available in the 
> > year 2010 might transform this code, and how a likely/unlikely placed 
> > there might influence gcc's optimizations then.
> 
> You're right, we don't know. But if giving the compiler _more_
> information causes it to produce vastly inferior code then we should be
> filing gcc bugs. After all the unlikely/likely is just a hint, if gcc
> knows better it can always ignore it.

It's the other way round, gcc assumes that you know better than gcc when 
you give it a __builtin_expect().

The example you gave had only a 1:3 ratio, which is far outside of the 
ratios where __builtin_expect() should be used.

What if you gave this annotation for the 1:3 case and gcc generates code 
that performs better for ratios > 1:1000 but much worse for a 1:3 ratio
since your hint did override a better estimate of gcc?

And I'm sure that > 90% of all kernel developers (including me) are 
worse in such respects than the gcc heuristics.

I'm a firm believer in the following:
- it's the programmer's job to write clean and efficient C code
- it's the compiler's job to convert C code into efficient assembler
  code

The stable interface between the programmer and the compiler is C, and 
when the programmer starts manually messing with internals of the 
compiler that's a layering violation that requires a _good_ 
justification.

With a "good justification" not consisting of some microbenchmark but of 
measurements of the actual annotations in the kernel code.

> cheers

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

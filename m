Return-Path: <segher@kernel.crashing.org>
Received: from mail-in-05.arcor-online.net (mail-in-05.arcor-online.net
	[151.189.21.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.arcor.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 30A37DDFE2
	for <linuxppc-dev@ozlabs.org>; Tue, 29 May 2007 23:04:11 +1000 (EST)
In-Reply-To: <20070529092658.GA32228@iram.es>
References: <1180423456.19517.124.camel@localhost.localdomain>
	<B1348C8C-09B1-4906-BF89-CC4206F0CA0A@embeddedalley.com>
	<1180425900.19517.136.camel@localhost.localdomain>
	<20070529092658.GA32228@iram.es>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <08b3997ab86a819c63b5cb0afcdc0c9e@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: Saving to 32 bits of GPRs in signal context
Date: Tue, 29 May 2007 15:04:00 +0200
To: Gabriel Paubert <paubert@iram.es>
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	Steve Munroe <sjmunroe@us.ibm.com>,
	Ulrich Weigand <Ulrich.Weigand@de.ibm.com>,
	Paul Mackerras <paulus@samba.org>, Anton Blanchard <anton@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> But it also makes me wonder about a few things:
> - do you use the standard 32 bit ABI, in which case the caller of 
> libraries
>   does not care and the libraries can be put in the standard places,

The compiler should either a) use full 64-bit only for
"volatile" (call-clobbered) registers, or b) save and
restore other 64-bit mode registers around calls.  I don't
remember if powerpc-linux-gcc does a) or b), if either.

> or are
>   there cases where the ability to pass 64 bit values in a single
>   register would improve performance to the point that it is worth
>   having an incompatible library (where to put it and how to name it)?

That would be a third ABI.  Is it worth that?

> - how can an application know that it can use 64 bit registers and call
>   the optimized routines?

Just call them and trap the SEGV ;-)  You can check the
aux vector of course, or ask glibc -- but the SEGV way
is the only really portable way.  Strange world :-)

> Finally, I've not seen a compiler (well, GCC, but I don't have 4.2 or
> 4.3 installed yet) that allows you to tell the compiler to use 32 bit
> addresses but assume that integer registers are 64 bit wide.

This feature was developed in the 3.3 timeframe IIRC.  The
flags to use are -m32 -mpowerpc64 .

> As long
> as such an option does not exist, the usefulness of this feature is
> somewhat limited. In other words, GCC for now has support for ILP32 and
> LP64 modes, but it would be better to also have support for IP32L64.

ILP32LL64.  The C "mode" stays the same, only the generated
machine insns are changed.

> Adding the IP32L64 mode des not seem to be such a huge project
> (comparable to many Google SoC ones, but it's too late for 2007),

GCC (and many 3rd party apps/libs) *really* like pointers and
longs to have the same size.

> the problem is taht if it is started now, I don't think it will hit
> an official GCC release before 2009 at the earliest.

It has been there for a long time now ;-)

> Only the implicit flags calculations, cmp has both 32 and 64 bit
> versions, so it's not _that_ bad. However multiprecision arithmetic 
> will
> have to be done in 32 bit mode

You actually want to do MP calc in 64-bit mode -- multiplies
are four times faster!  (64x64 vs. 32x32).

> because the carry setting[1] is linked with the mode

True enough, but you never really need the CA reg anyway.

> (well I seem to remember a variant of the architecture
> which had 32 and 64 bit variants for generating the flags, but it was a
> long time ago. I've not seen support for this hybrid monster in gcc's 
> md
> file and I don't know whether it ever saw the light).

Book E 64.  You want to forget; well I want to anyway.

> Have you considered the case of a mixed (IP32L64) mode calling a pure
> 32 bit library (or a user provided callback). The high part of R13-R31
> will also be clobbered. Therefore the caller has to save and restore
> all registers that are live around the call, which results in
> significant code bloat and needs compiler support.

I believe the compiler supports this.  The code bloat you
think is there just doesn't exist; it takes a lot more code
to do the actual ops on a pair of 32-bit regs than it takes
to do a bit of 64-bit save/restore work.


Segher

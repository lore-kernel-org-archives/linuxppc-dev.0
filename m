Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.179]) by ozlabs.org (Postfix) with ESMTP id 55B71DE08F
	for <linuxppc-dev@ozlabs.org>; Wed, 30 May 2007 00:28:59 +1000 (EST)
From: Arnd Bergmann <arnd@arndb.de>
To: linuxppc-dev@ozlabs.org
Subject: Re: Saving to 32 bits of GPRs in signal context
Date: Tue, 29 May 2007 16:28:35 +0200
References: <1180423456.19517.124.camel@localhost.localdomain>
	<20070529092658.GA32228@iram.es>
	<08b3997ab86a819c63b5cb0afcdc0c9e@kernel.crashing.org>
In-Reply-To: <08b3997ab86a819c63b5cb0afcdc0c9e@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200705291628.35852.arnd@arndb.de>
Cc: Steve Munroe <sjmunroe@us.ibm.com>,
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

On Tuesday 29 May 2007, Segher Boessenkool wrote:
> > But it also makes me wonder about a few things:
> > - do you use the standard 32 bit ABI, in which case the caller of 
> > libraries
> >   does not care and the libraries can be put in the standard places,
> 
> The compiler should either a) use full 64-bit only for
> "volatile" (call-clobbered) registers, or b) save and
> restore other 64-bit mode registers around calls.  I don't
> remember if powerpc-linux-gcc does a) or b), if either.

As benh explained, the 64 bit register contents are maintained
over normal function calls, iirc the ABI treats the upper halves
of each register as call-clobbered.

The problem is really just signal handlers.

> > or are
> >   there cases where the ability to pass 64 bit values in a single
> >   register would improve performance to the point that it is worth
> >   having an incompatible library (where to put it and how to name it)?
> 
> That would be a third ABI.  Is it worth that?

no ;-)

> > - how can an application know that it can use 64 bit registers and call
> >   the optimized routines?
> 
> Just call them and trap the SEGV ;-)  You can check the
> aux vector of course, or ask glibc -- but the SEGV way
> is the only really portable way.  Strange world :-)

shouldn't that be SIGILL?

> > As long
> > as such an option does not exist, the usefulness of this feature is
> > somewhat limited. In other words, GCC for now has support for ILP32 and
> > LP64 modes, but it would be better to also have support for IP32L64.
> 
> ILP32LL64.  The C "mode" stays the same, only the generated
> machine insns are changed.

right, as mentioned before, IP32L64 would imply introducing a new
ABI, which we don't want.
 
	Arnd <><

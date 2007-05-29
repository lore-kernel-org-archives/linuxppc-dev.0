Return-Path: <paubert@iram.es>
Received: from gra-lx1.iram.es (gra-lx1.iram.es [150.214.224.41])
	by ozlabs.org (Postfix) with ESMTP id B1B8CDDECC
	for <linuxppc-dev@ozlabs.org>; Tue, 29 May 2007 19:27:24 +1000 (EST)
From: Gabriel Paubert <paubert@iram.es>
Date: Tue, 29 May 2007 11:26:58 +0200
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: Saving to 32 bits of GPRs in signal context
Message-ID: <20070529092658.GA32228@iram.es>
References: <1180423456.19517.124.camel@localhost.localdomain>
	<B1348C8C-09B1-4906-BF89-CC4206F0CA0A@embeddedalley.com>
	<1180425900.19517.136.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1180425900.19517.136.camel@localhost.localdomain>
Cc: Ulrich Weigand <Ulrich.Weigand@de.ibm.com>,
	Steve Munroe <sjmunroe@us.ibm.com>,
	linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	Anton Blanchard <anton@samba.org>, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, May 29, 2007 at 06:05:00PM +1000, Benjamin Herrenschmidt wrote:
> On Tue, 2007-05-29 at 03:52 -0400, Dan Malek wrote:
> > > I've been looking at saving & restoring the top 32 bits of 64 bits
> > > registers when delivering signals to 32 bits processes on a 64 bits
> > > kernel. The principle is easy, but I wonder where to stick them.
> > 
> > I'm wondering why you need to do this at all?
> > Why would a 32-bit application care about or
> > know what to do with these?
> 
> There are regular demands for the ability to use the full 64 bits
> registers in 32 bits applications when running on a 64 bits processor.
> That ranges from, iirc, the java folks, to people wanting to optimize
> some libs to use 64 bits registers internally when called from 32 bits
> apps etc...

My thoughts exactly, that's a very useful mode for some applications,
either loading a different library or having alternate routines depending 
on the availability of 64 bit GPRs for "long long" integer computations,
block copying and initializing (and therefore struct copies and memset()), 
etc... 

But it also makes me wonder about a few things:
- do you use the standard 32 bit ABI, in which case the caller of libraries
  does not care and the libraries can be put in the standard places, or are
  there cases where the ability to pass 64 bit values in a single
  register would improve performance to the point that it is worth
  having an incompatible library (where to put it and how to name it)? 
  
  I'd rather lean towards the first solution but I don't have enough
  data to judge. 

- how can an application know that it can use 64 bit registers and call
  the optimized routines?


Finally, I've not seen a compiler (well, GCC, but I don't have 4.2 or 
4.3 installed yet) that allows you to tell the compiler to use 32 bit
addresses but assume that integer registers are 64 bit wide. As long
as such an option does not exist, the usefulness of this feature is
somewhat limited. In other words, GCC for now has support for ILP32 and
LP64 modes, but it would be better to also have support for IP32L64.

[...]

Well, after downloading the gcc trunk, it still seems to be the case.

Adding the IP32L64 mode des not seem to be such a huge project
(comparable to many Google SoC ones, but it's too late for 2007),
the problem is taht if it is started now, I don't think it will hit
an official GCC release before 2009 at the earliest.

> 
> You can use the full 64 bits easily on powerpc, ld/std just work, it's
> only the flags calculations and branches, mostly, that are truncated
> when running in 32 bits mode.

Only the implicit flags calculations, cmp has both 32 and 64 bit
versions, so it's not _that_ bad. However multiprecision arithmetic will 
have to be done in 32 bit mode because the carry setting[1] is linked 
with the mode (well I seem to remember a variant of the architecture 
which had 32 and 64 bit variants for generating the flags, but it was a 
long time ago. I've not seen support for this hybrid monster in gcc's md
file and I don't know whether it ever saw the light).

> Also, the kernel syscall & interrupt
> entry/exit path will save & restore the full 64 bits.
> 
> The problem is when you use signals. The compat signal code for 32 bits
> apps will only save and restore the bottom 32 bits, thus an application
> using signals will potentially corrupt the top 32 bits, which can be a
> problem if, for example, it uses a library that has optimisations based
> on using the full 64 bits.
> 


> We don't intend to update jmpbuf, getcontext/setcontext etc... for
> those... they are purely call clobbered etc..., but it would be nice if
> at least the signal frame save/restore could properly deal with them so
> they don't get randomly clobbered.

Have you considered the case of a mixed (IP32L64) mode calling a pure
32 bit library (or a user provided callback). The high part of R13-R31
will also be clobbered. Therefore the caller has to save and restore 
all registers that are live around the call, which results in
significant code bloat and needs compiler support.

All of this of course unless all people who write mixed mode code
are masochistic enough to limit themselves to 100% pure assembly... 

	Gabriel

[1] and overflow but sadly nobody cares about it, look at Ada code compiled 
when checking for overflows and get deeply depressed :-(


> 
> Ben.
> 
> 
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-dev

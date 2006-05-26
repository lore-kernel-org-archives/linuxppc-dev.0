Return-Path: <olof@lixom.net>
Date: Thu, 25 May 2006 23:43:41 -0700
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: Cell and new CPU feature bits
Message-ID: <20060526064341.GA6183@pb15.lixom.net>
References: <1148011621.13249.7.camel@localhost.localdomain>
	<20060519051939.GJ8220@pb15.lixom.net>
	<1148624357.8089.88.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1148624357.8089.88.camel@localhost.localdomain>
From: Olof Johansson <olof@lixom.net>
Cc: Arnd Bergmann <arnd@arndb.de>, Steve Munroe <sjmunroe@us.ibm.com>,
	linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	Paul Mackerras <paulus@samba.org>,
	Olof Johansson <olof@lixom.net>, cbe-oss-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, May 26, 2006 at 04:19:17PM +1000, Benjamin Herrenschmidt wrote:
> So, replying to Olof and myself and asking for Steve Munroe point of
> view...
> 
> > How are other userspace-exposed erratas normally handled? How are they
> > handled on other architectures? Adding it to the feature aux table
> > sounds like a bad idea.
> 
> Well, I suspect so far we have avoided the problem by just assuming
> there are no such erratas :)
> 
> It's an ABI issue so I'd like Steve to provide some feedback on this. I
> suppose we should probably define an AT_CPU_ERRATA capability
> 
> > >  - Additional Altivec instructions (load/store right/left). A new
> > > feature bit for these ?
> 
> I think a new feature bit is the way to go but we need to start now
> about how to extend our feature bit facility, maybe by defining an
> AT_HWCAP2 ? Steve, what is your position there ?

And what happens when that gets full? Or can we make that one dynamic in
size?

> > >  - Lack of data stream instructions. Until now, it was assumed that
> > > those were tied to the presence
> > >    of an Altivec (and they are documented in the Altivec manual). Maybe
> > > we should split that to a
> > >    new bit. I don't know if existing applications use them though, if
> > > they do, there will be a 
> > >    problem to get them updated as the new bit isn't present on older
> > > kernels...
> >
> > I'm assuming you mean the instructions described under "AltiVec Memory
> > Bandwidth Management" in secion 5.2 of the Altivec PEM -- dst, dstt,
> > dstst, dss and dssall?
> 
> Yes.
> 
> > Since they're explicitly part of the Altivec ISA, not the PPC ISA,
> > I don't see a need for a separate feature bit for them. They are not
> > marked as optional in the version I'm looking at right now (2.0).
> 
> They are not implemented on Cell though. I don't know yet if they are
> NOP's or if they fault but we should still inform userland of the
> situation.
> 
> Thus should we add a feature bit documenting the existence of those
> instructions or should we use an errata bit (provided we define
> something for passing them as suggested above) ?

Only if there's truly uses for it. Do we really want to allocate global
bits for every errata that every vendor introduces?

Do we see this likely to be used in "global userspace", or more likely
in the processor-specific glibc sections? If it's in the
processor-specific ones, maybe we should have a per-processor bitfield
with erratas/features instead of a global one. That'd make allocation
easier too.

I.e. a main feature bitmask like we have now (architecture base
version), and a sub-bitmask with the optional features. That also avoids
the issue of allocating a global bit for something that is a feature in
version X but non-optional in X+1, you can never "get that bit back".

> > >  - Extended implementation of dcbt. (Another bit ? Or sould we just have
> > > a "CELL" bit ? In which
> > >    case should it cover the altivec additions too or are those likely to
> > > exist in future non-Cell 
> > >    processors ?)
> > 
> > If you're referring to the extended dcbt that includes streaming hints
> > (as documented in the 64-bit PEM, but not in PPC book2 2.02), then a
> > separate bit is likely needed -- obviously at least 970 seems to
> > implement them.
> 
> Yes, I think a new CPU feature bit for that too is needed. Not much of
> these left...

Well, are these instructions architected in some later version past
2.02? If so, the bit is only needed on the older processors -- yet again
a case for sub-feature/errata bitmasks.

[rest is good discussion but I don't have much input on it at this time.
Something gestalt-like could be good, it'd help remove some of the
current limits on bitmap sizes, etc]


-Olof

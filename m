Return-Path: <benh@kernel.crashing.org>
Subject: Re: Cell and new CPU feature bits
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Olof Johansson <olof@lixom.net>
In-Reply-To: <20060519051939.GJ8220@pb15.lixom.net>
References: <1148011621.13249.7.camel@localhost.localdomain>
	<20060519051939.GJ8220@pb15.lixom.net>
Content-Type: text/plain
Date: Fri, 26 May 2006 16:19:17 +1000
Message-Id: <1148624357.8089.88.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	Paul Mackerras <paulus@samba.org>, cbe-oss-dev@ozlabs.org,
	Arnd Bergmann <arnd@arndb.de>, Steve Munroe <sjmunroe@us.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

So, replying to Olof and myself and asking for Steve Munroe point of
view...

> How are other userspace-exposed erratas normally handled? How are they
> handled on other architectures? Adding it to the feature aux table
> sounds like a bad idea.

Well, I suspect so far we have avoided the problem by just assuming
there are no such erratas :)

It's an ABI issue so I'd like Steve to provide some feedback on this. I
suppose we should probably define an AT_CPU_ERRATA capability

> >  - Additional Altivec instructions (load/store right/left). A new
> > feature bit for these ?

I think a new feature bit is the way to go but we need to start now
about how to extend our feature bit facility, maybe by defining an
AT_HWCAP2 ? Steve, what is your position there ?

> >  - Lack of data stream instructions. Until now, it was assumed that
> > those were tied to the presence
> >    of an Altivec (and they are documented in the Altivec manual). Maybe
> > we should split that to a
> >    new bit. I don't know if existing applications use them though, if
> > they do, there will be a 
> >    problem to get them updated as the new bit isn't present on older
> > kernels...
>
> I'm assuming you mean the instructions described under "AltiVec Memory
> Bandwidth Management" in secion 5.2 of the Altivec PEM -- dst, dstt,
> dstst, dss and dssall?

Yes.

> Since they're explicitly part of the Altivec ISA, not the PPC ISA,
> I don't see a need for a separate feature bit for them. They are not
> marked as optional in the version I'm looking at right now (2.0).

They are not implemented on Cell though. I don't know yet if they are
NOP's or if they fault but we should still inform userland of the
situation.

Thus should we add a feature bit documenting the existence of those
instructions or should we use an errata bit (provided we define
something for passing them as suggested above) ?

> >  - Extended implementation of dcbt. (Another bit ? Or sould we just have
> > a "CELL" bit ? In which
> >    case should it cover the altivec additions too or are those likely to
> > exist in future non-Cell 
> >    processors ?)
> 
> If you're referring to the extended dcbt that includes streaming hints
> (as documented in the 64-bit PEM, but not in PPC book2 2.02), then a
> separate bit is likely needed -- obviously at least 970 seems to
> implement them.

Yes, I think a new CPU feature bit for that too is needed. Not much of
these left...

> >  - Not strictly Cell specific but we currently don't expose the support
> > for optional instructions
> >    fres and frsqte (which are supported by Cell)
> > 
> > Part of the problem is that we only have 32 userland feature bits and
> > for some reason decided to put the microarchitecture in there, thus we
> > are running out fast...
> 
>  From what I understood by Paul's choice of feature naming (see the
> POWER6 patch discussions), PPC_ARCH_2_05 and similar will mean base
> architecture version implemented and should not be used to assume
> anything about optional features.
> 
> So, with that as a base, there will need to be a way to
> indicate which optional features are available, plus what possible
> extensions/implementation-specific features are there, at least if they
> are common to more than one implementation/processor version. Bit arrays
> seem to be the New Way of doing it between firmware and kernel, maybe
> the same can/should be used for kernel->userspace? Can the aux vectors
> be of arbitrary length?

So the question is should we specify a feature bit for fres and frsqte
or should we let userland assume they are always there on a given
microarchitecture level ?

Steve, another solution is to go to a completely different model (maybe
closer than what apple does) and add an interface similar to Apple old
Gestalt (as mentioned by Alex Rosenberg in a separate email) that could
go through the vDSO. The idea boils down to replacing our current
bitmaps with something like:

	__kernel_cpu_feature(const char *name);

(Apple Gestalt returns a long in addition to a result code that can
contain arbitrary things like version numbers etc... but I'm against
that, I have first hand experience on how that can be abused :) I prefer
a simple boolean result.

The "feature" are named (ascii strings) with a strict naming convention.
For example, erratas always start with "err-", optional architecture
bits with "opt-", totally chip specific functions "chip-", etc...

As far as userland is concerned, glibc could expose a lot of this
through sysconf, or provide a way to get to the vDSO call (though we'll
have to fight with the folks there).

That doesn't completely solve another pending problem we have with
passing down to userland other specific infos like L2/L3 cache
characteristics but I don't see a good solution yet there. Maybe a
separate vDSO call for use by glibc to use to implement sysconf ? Among
the things we've been asked are cache line sizes (we have L1 I and D
already in AT_*), cache associativity (generally available in the device
tree but not provided to userland), cache total size (we put some L1
infos in the deprecated-but-still-present systemcfg, we need a
replacement API), etc... Note that we have been requested to also add
L2/L3 infos but I noticed that our firmware doesn't tell us on modern
CPUs, thus for each of these infos, we also need a way to say "unknown".

Ben.

Return-Path: <olof@lixom.net>
Date: Fri, 19 May 2006 00:19:39 -0500
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: Cell and new CPU feature bits
Message-ID: <20060519051939.GJ8220@pb15.lixom.net>
References: <1148011621.13249.7.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1148011621.13249.7.camel@localhost.localdomain>
From: Olof Johansson <olof@lixom.net>
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	Paul Mackerras <paulus@samba.org>, cbe-oss-dev@ozlabs.org,
	Arnd Bergmann <arnd@arndb.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, May 19, 2006 at 02:07:01PM +1000, Benjamin Herrenschmidt wrote:
> The Cell has a couple of "features" that should be exposed to userland
> in a way or another. That raises some questions however about how those
> should be done. Among others that come to mind:

Good questions, to make things scale when going from here on out
(including new products from various companies in the PPC arena), more
fine-grained features would certainly be useful.

>  - The timebase errata (should we use a separate aux vector for "bugs"
> than for "features" ?

How are other userspace-exposed erratas normally handled? How are they
handled on other architectures? Adding it to the feature aux table
sounds like a bad idea.

>  - Additional Altivec instructions (load/store right/left). A new
> feature bit for these ?
>  - Lack of data stream instructions. Until now, it was assumed that
> those were tied to the presence
>    of an Altivec (and they are documented in the Altivec manual). Maybe
> we should split that to a
>    new bit. I don't know if existing applications use them though, if
> they do, there will be a 
>    problem to get them updated as the new bit isn't present on older
> kernels...

I'm assuming you mean the instructions described under "AltiVec Memory
Bandwidth Management" in secion 5.2 of the Altivec PEM -- dst, dstt,
dstst, dss and dssall?

Since they're explicitly part of the Altivec ISA, not the PPC ISA,
I don't see a need for a separate feature bit for them. They are not
marked as optional in the version I'm looking at right now (2.0).

>  - Extended implementation of dcbt. (Another bit ? Or sould we just have
> a "CELL" bit ? In which
>    case should it cover the altivec additions too or are those likely to
> exist in future non-Cell 
>    processors ?)

If you're referring to the extended dcbt that includes streaming hints
(as documented in the 64-bit PEM, but not in PPC book2 2.02), then a
separate bit is likely needed -- obviously at least 970 seems to
implement them.

>  - Not strictly Cell specific but we currently don't expose the support
> for optional instructions
>    fres and frsqte (which are supported by Cell)
> 
> Part of the problem is that we only have 32 userland feature bits and
> for some reason decided to put the microarchitecture in there, thus we
> are running out fast...

 From what I understood by Paul's choice of feature naming (see the
POWER6 patch discussions), PPC_ARCH_2_05 and similar will mean base
architecture version implemented and should not be used to assume
anything about optional features.

So, with that as a base, there will need to be a way to
indicate which optional features are available, plus what possible
extensions/implementation-specific features are there, at least if they
are common to more than one implementation/processor version. Bit arrays
seem to be the New Way of doing it between firmware and kernel, maybe
the same can/should be used for kernel->userspace? Can the aux vectors
be of arbitrary length?


-Olof

Date: Tue, 2 Apr 2002 09:33:20 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Paul Mackerras <paulus@samba.org>
Cc: Dan Malek <dan@embeddededge.com>,
	linux-galileo@source.mvista.com, linuxppc-dev@lists.linuxppc.org
Subject: Re: EV-64260-BP & GT64260 bi_recs
Message-ID: <20020402163320.GG23756@opus.bloom.county>
References: <0203210213.AA15856@ivan.Harhan.ORG> <3C99801A.8070002@embeddededge.com> <15526.51621.991410.781713@argo.ozlabs.ibm.com> <3CA8A96D.9040309@embeddededge.com> <15529.17031.622986.926261@argo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <15529.17031.622986.926261@argo.ozlabs.ibm.com>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Tue, Apr 02, 2002 at 03:32:55PM +1000, Paul Mackerras wrote:
>
> Dan Malek writes:
>
> > Paul Mackerras wrote:
> >
> > > I don't particularly like the way we define what is on a given
> > > embedded board with what boils down to a shell script.
> >
> > Why single out embedded boards?
>
> Two reasons: (a) it seems to be that (for example) most of the if
> statements in arch/ppc/config.in are concerned with embedded boards,

That's just because pmac hw is so boring and limited.  That and pmacs
are designed around an OS which depends on the hardware to describe
itself.  That's the main reason it's so easy to do lots of things at
runtime on chrp/pmac, OF even describes the non self-describing devices
for you usually.

> > > 1. Derive a set of config option values (or recommendations for those
> > >    values, at least) for including the necessary kernel drivers to
> > >    support the devices on the board.
> >
> > The interdependencies among the resources on an intergrated processor
> > often require cooperation among drivers.  Oh you could probably remove
> > a few #ifdefs and replace it with addtional overhead of some generic
> > function calls.  Now, you have moved a few ifdefs into a "common" place,
>
> No, I don't want to move ifdefs around, I want to get rid of them
> altogether. :)

Which is either generated code at runtime (which we're doing a bit of
when possible) or runtime, which isn't as desired.

Unless we get the proper symlink magic to do
#include <asm/platform.h>
which will get the right platform from CONFIG_foo.  Which would get a
lot more of your 'just adding files' idea.

> Nor should the number of instances of the device.

That's a different problem, mainly drivers which weren't initially
designed around multiple instances.

> > > 2. Make a list of devices and the information that their drivers will
> > >    need about them, such as register base addresses, interrupt
> > >    assignments, etc., for inclusion in the kernel.
> >
> > For PowerPC (well, 8xx anyway, I don't know what 4xx looks like these days)
> > all of this stuff is already defined in a board description configuration
> > file or in the generic processor files.  IMHO, it isn't going to get
> > any better than this (and it seems sufficient for other processors).
>
> My concern is that the current way of doing things is going to become
> increasingly unmanageable as we get more and more chips with different
> combinations and permutations of on-board peripherals.

There's some cleanup which needs to be done (asm/commproc.h needs some
cleanups, which Wolfgang did at one point and I will push to 2.5 soon).

--
Tom Rini (TR1265)
http://gate.crashing.org/~trini/

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/

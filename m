Message-ID: <3CA9EA93.5000404@embeddededge.com>
Date: Tue, 02 Apr 2002 12:29:55 -0500
From: Dan Malek <dan@embeddededge.com>
MIME-Version: 1.0
To: paulus@samba.org
Cc: linux-galileo@source.mvista.com, linuxppc-dev@lists.linuxppc.org
Subject: Re: EV-64260-BP & GT64260 bi_recs
References: <0203210213.AA15856@ivan.Harhan.ORG>	<3C99801A.8070002@embeddededge.com>	<15526.51621.991410.781713@argo.ozlabs.ibm.com>	<3CA8A96D.9040309@embeddededge.com> <15529.17031.622986.926261@argo.ozlabs.ibm.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


I'm glad you found _some_ of the humor in it :-)

Paul Mackerras wrote:


> Two reasons: (a) it seems to be that (for example) most of the if
> statements in arch/ppc/config.in are concerned with embedded boards,

Well, yes, and at one point I tried to create config.in files that were
unique to the boards/peripherals that were just callouts from config.in.
That didn't last long because all of these were incorporated (not by me :-)
into config.in and other places.  I thought having these board specific
configuration files was kind of nice, kept arch/ppc/config.in cleaner,
kept the interdependencies localized to a sensible place, but I guess
someone thought different when it got merged from the development tree.

We are always discussing this separation of information and software
among the different platforms.  I truly want it separate....everything.
The drivers, the configuration files, anything unique to a board that
isn't "common" across a wide range of platforms and architectures.

> So it's no use anyone discussing how to solve the problems?

I guess the "problem" is in the eye of the beholder :-).  I don't
see lots of defconfig files or some complexity to config.in, or
a few #ifdefs as a "problem" :-).  These discussions become a
problem for me because I spend all of my time discussing why something
is the way it is, and why that isn't necessarily bad, considering
all of the details involved in development of the software.  Then,
after I lose the battle, a bunch of code is changed, someone discovers
we don't have anything better than we started, and the "geeze I never
thought of that detail" discussions start so we can crawl out of a
hole.  We then start all over again making changes that in the
end just traded one "problem" for another, making little progress
on the quality or features of the software.......In a year or so
I'll bring up this bi_recs discussion again as an example :-)

> No, I don't want to move ifdefs around, I want to get rid of them
> altogether. :)

I don't understand why that in itself has to be a goal.  As we
have more experience with platforms and the use of the software,
these will be change and perhaps go away.  I don't know how you
just declare this goal without having a better idea of how the
software can be placed into reusable modules.

> The information about the register addresses and interrupt assignments
> isn't (or shouldn't need to be) part of the mental context of driver
> code.  Nor should the number of instances of the device.

As far as I know, the interrupts and registers are fixed at compile
time.  The more challenging resources are I/O pin multiplexing and
bus control.  Again, taking the 8xx and 8260 as an example (of a well
thought out integrated processor design :-) you have flexibility that
can be wired at compile time, making the drivers much more simplified
(removing #ifdefs).  In some cases, there is no way for a bootloader
to know this information (unless it's compiled in there, so why bother)
and there are performance trade offs you can make with these configuration
options (so you are building a kernel anyway).

> My concern is that the current way of doing things is going to become
> increasingly unmanageable as we get more and more chips with different
> combinations and permutations of on-board peripherals.

If you are using the 4xx stuff as an example, I don't really like the
way that is being done, but I'm severely outnumbered in that battle so
I had to retreat and work somewhere else (like MIPS :-).  I still
prefer to wait and see how unmanagable it gets before we start reworking
everything.  Again, I don't see how using a bootloader to provide
information and adding more software complexity to drivers solves this
problem.  If you can't make it work with #define constants and #ifdef
code sections, how will changing a #define with a variable name and
an #ifdef with an if () {} make it eaiser?

> I have this dream that one day we will get to the point where adding
> support for a new board only involves adding files to the kernel
> tree, with no changes to existing files needed.

I pretty much live that dream every day with the 8xx stuff.  Give me
a working piece of hardware and with a few file changes I can have
it booting in no time :-)

> I'll assume that was purely a joke.

Not all of it :-)  I thought we blew off trying to do common binaries
long ago.  We try to do common source code as much as possible,
but we had the common binary discussion long ago.  I guess I should
read some of the old archives to remember correctly.

> Well one would then wonder why they are using PowerPC, not known for
> its code density...
> (Just kidding :-)

The code density is similar to any other risc processor, and it has
some pretty nice instructions.  Quite honestly, Motorola knows how
to get embedded processors done right :-)


	-- Dan


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/

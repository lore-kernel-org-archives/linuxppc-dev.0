From: Paul Mackerras <paulus@samba.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <15529.17031.622986.926261@argo.ozlabs.ibm.com>
Date: Tue, 2 Apr 2002 15:32:55 +1000 (EST)
To: Dan Malek <dan@embeddededge.com>
Cc: linux-galileo@source.mvista.com, linuxppc-dev@lists.linuxppc.org
Subject: Re: EV-64260-BP & GT64260 bi_recs
In-Reply-To: <3CA8A96D.9040309@embeddededge.com>
References: <0203210213.AA15856@ivan.Harhan.ORG>
	<3C99801A.8070002@embeddededge.com>
	<15526.51621.991410.781713@argo.ozlabs.ibm.com>
	<3CA8A96D.9040309@embeddededge.com>
Reply-To: paulus@samba.org
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Dan Malek writes:

> Paul Mackerras wrote:
>
> > I don't particularly like the way we define what is on a given
> > embedded board with what boils down to a shell script.
>
> Why single out embedded boards?

Two reasons: (a) it seems to be that (for example) most of the if
statements in arch/ppc/config.in are concerned with embedded boards,
and (b) embedded boards seem to have high proportion of devices that
aren't self-describing (by self-describing I mean devices such as PCI
devices where there is a straightforward way of enumerating the
devices and finding out what each device is).

> > What I would like to see is a readable, compact, clear description of
> > the hardware (for a given embedded board) in one place,
>
> One of my peeves is all I have ever done with Linux is embedded boards,
> for many years, no one seemed to care what I thought would make it
> easier, and recently people that have little experience with them
> now seem to want to solve all of the problems in one weekend :-).

So it's no use anyone discussing how to solve the problems?

> > 1. Derive a set of config option values (or recommendations for those
> >    values, at least) for including the necessary kernel drivers to
> >    support the devices on the board.
>
> The interdependencies among the resources on an intergrated processor
> often require cooperation among drivers.  Oh you could probably remove
> a few #ifdefs and replace it with addtional overhead of some generic
> function calls.  Now, you have moved a few ifdefs into a "common" place,

No, I don't want to move ifdefs around, I want to get rid of them
altogether. :)

> but along with that you also moved the mental context of the code.
> Rather than describing and implementing in the place where I can
> understand it (the driver itself), I have to look someplace else and
> remember why I am looking there.

The information about the register addresses and interrupt assignments
isn't (or shouldn't need to be) part of the mental context of driver
code.  Nor should the number of instances of the device.

> > 2. Make a list of devices and the information that their drivers will
> >    need about them, such as register base addresses, interrupt
> >    assignments, etc., for inclusion in the kernel.
>
> For PowerPC (well, 8xx anyway, I don't know what 4xx looks like these days)
> all of this stuff is already defined in a board description configuration
> file or in the generic processor files.  IMHO, it isn't going to get
> any better than this (and it seems sufficient for other processors).

My concern is that the current way of doing things is going to become
increasingly unmanageable as we get more and more chips with different
combinations and permutations of on-board peripherals.

I have this dream that one day we will get to the point where adding
support for a new board only involves adding files to the kernel
tree, with no changes to existing files needed.

> > 3. Make such a list for inclusion in a bootloader so that it can
> >    supply it to the kernel, for people who aren't so worried about the
> >    size of their kernels and who want to be able to use the same
> >    kernel binary on several different boards.
>
> Bleh.....You have to compile the kernel anyway, why bother complicating
> everything by passing information through the bootloader?  We have gone
> around and around with this "common binary" before.  How come once we
> decide to go one direction (no common binaries), we now have to expend
> energy going the other direction again?  Not long ago even you argued
> for separate binaries, what happened? (change of business pressure? :-)

I'll assume that was purely a joke.

> > For the situations where every byte is precious,....
>
> Surprisingly, there are still many systems that care about this, and

Well one would then wonder why they are using PowerPC, not known for
its code density...
(Just kidding :-)

Paul.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
